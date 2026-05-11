<template>
  <div class="app-container">
    <el-form ref="queryRef" :model="queryParams" :inline="true" v-show="showSearch">
      <el-form-item label="所属提供商" prop="providerId">
        <el-select v-model="queryParams.providerId" placeholder="请选择提供商" clearable filterable style="width: 200px">
          <el-option v-for="item in providerOptions" :key="item.providerId" :label="item.providerName" :value="item.providerId" />
        </el-select>
      </el-form-item>
      <el-form-item label="渠道名称" prop="channelName">
        <el-input v-model="queryParams.channelName" placeholder="请输入渠道名称" clearable style="width: 200px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable style="width: 160px">
          <el-option label="正常" value="0" />
          <el-option label="停用" value="1" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5"><el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['ai:providerChannel:add']">新增</el-button></el-col>
      <el-col :span="1.5"><el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate" v-hasPermi="['ai:providerChannel:edit']">修改</el-button></el-col>
      <el-col :span="1.5"><el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete" v-hasPermi="['ai:providerChannel:remove']">删除</el-button></el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
    </el-row>

    <el-table v-loading="loading" :data="channelList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="ID" align="center" prop="channelId" width="80" />
      <el-table-column label="提供商" align="center" prop="providerName" min-width="120" />
      <el-table-column label="渠道名称" align="center" prop="channelName" min-width="140" />
      <el-table-column label="渠道编码" align="center" prop="channelCode" min-width="140" />
      <el-table-column label="Base URL" align="center" prop="baseUrl" min-width="200" show-overflow-tooltip />
      <el-table-column label="优先级" align="center" prop="priority" width="90" />
      <el-table-column label="权重" align="center" prop="weight" width="90" />
      <el-table-column label="健康状态" align="center" prop="healthStatus" width="110" />
      <el-table-column label="状态" align="center" prop="status" width="90">
        <template #default="scope"><el-tag :type="scope.row.status === '0' ? 'success' : 'info'">{{ scope.row.status === '0' ? '正常' : '停用' }}</el-tag></template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="180">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['ai:providerChannel:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['ai:providerChannel:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" v-model="open" width="760px" append-to-body>
      <el-form ref="channelRef" :model="form" :rules="rules" label-width="110px">
        <el-form-item label="所属提供商" prop="providerId">
          <el-select v-model="form.providerId" filterable>
            <el-option v-for="item in providerOptions" :key="item.providerId" :label="item.providerName" :value="item.providerId" />
          </el-select>
        </el-form-item>
        <el-form-item label="渠道名称" prop="channelName"><el-input v-model="form.channelName" /></el-form-item>
        <el-form-item label="渠道编码" prop="channelCode"><el-input v-model="form.channelCode" /></el-form-item>
        <el-form-item label="基础地址" prop="baseUrl"><el-input v-model="form.baseUrl" /></el-form-item>
        <el-form-item label="API Key" prop="apiKey"><el-input v-model="form.apiKey" show-password /></el-form-item>
        <el-form-item label="API Secret" prop="apiSecret"><el-input v-model="form.apiSecret" show-password /></el-form-item>
        <el-row>
          <el-col :span="12"><el-form-item label="优先级" prop="priority"><el-input-number v-model="form.priority" :min="0" style="width: 100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="权重" prop="weight"><el-input-number v-model="form.weight" :min="0" style="width: 100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="超时(ms)" prop="timeoutMs"><el-input-number v-model="form.timeoutMs" :min="0" style="width: 100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="最大并发" prop="maxConcurrency"><el-input-number v-model="form.maxConcurrency" :min="0" style="width: 100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="RPM限制" prop="rpmLimit"><el-input-number v-model="form.rpmLimit" :min="0" style="width: 100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="TPM限制" prop="tpmLimit"><el-input-number v-model="form.tpmLimit" :min="0" style="width: 100%" /></el-form-item></el-col>
        </el-row>
        <el-form-item label="健康状态" prop="healthStatus">
          <el-select v-model="form.healthStatus">
            <el-option label="未知" value="UNKNOWN" />
            <el-option label="健康" value="HEALTHY" />
            <el-option label="异常" value="UNHEALTHY" />
          </el-select>
        </el-form-item>
        <el-form-item label="代理开关" prop="proxyEnabled">
          <el-radio-group v-model="form.proxyEnabled">
            <el-radio value="0">关闭</el-radio>
            <el-radio value="1">开启</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="兜底渠道" prop="isFallback">
          <el-radio-group v-model="form.isFallback">
            <el-radio value="0">否</el-radio>
            <el-radio value="1">是</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio value="0">正常</el-radio>
            <el-radio value="1">停用</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="备注" prop="remark"><el-input v-model="form.remark" type="textarea" :rows="3" /></el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="AiProviderChannel">
import { listProvider } from "@/api/ai/provider"
import { addProviderChannel, delProviderChannel, getProviderChannel, listProviderChannel, updateProviderChannel } from "@/api/ai/providerChannel"

const { proxy } = getCurrentInstance()
const channelList = ref([])
const providerOptions = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")

const data = reactive({
  form: {},
  queryParams: { pageNum: 1, pageSize: 10, providerId: undefined, channelName: undefined, status: undefined },
  rules: {
    providerId: [{ required: true, message: "提供商不能为空", trigger: "change" }],
    channelName: [{ required: true, message: "渠道名称不能为空", trigger: "blur" }],
    channelCode: [{ required: true, message: "渠道编码不能为空", trigger: "blur" }],
    baseUrl: [{ required: true, message: "基础地址不能为空", trigger: "blur" }]
  }
})

const { queryParams, form, rules } = toRefs(data)

function getList() {
  loading.value = true
  listProviderChannel(queryParams.value).then(response => {
    channelList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

function getProviderOptions() {
  listProvider({ pageNum: 1, pageSize: 1000, status: "0" }).then(response => {
    providerOptions.value = response.rows || []
  })
}

function reset() {
  form.value = {
    channelId: undefined, providerId: undefined, channelName: undefined, channelCode: undefined, baseUrl: undefined,
    apiKey: undefined, apiSecret: undefined, proxyEnabled: "0", priority: 0, weight: 100, timeoutMs: 60000,
    maxConcurrency: 0, rpmLimit: 0, tpmLimit: 0, isFallback: "0", healthStatus: "UNKNOWN", status: "0", remark: undefined
  }
  proxy.resetForm("channelRef")
}

function cancel() { open.value = false; reset() }
function handleQuery() { queryParams.value.pageNum = 1; getList() }
function resetQuery() { proxy.resetForm("queryRef"); handleQuery() }
function handleSelectionChange(selection) { ids.value = selection.map(item => item.channelId); single.value = selection.length !== 1; multiple.value = !selection.length }
function handleAdd() { reset(); open.value = true; title.value = "新增渠道" }
function handleUpdate(row) {
  reset()
  getProviderChannel(row.channelId || ids.value[0]).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改渠道"
  })
}
function submitForm() {
  proxy.$refs["channelRef"].validate(valid => {
    if (!valid) return
    const request = form.value.channelId ? updateProviderChannel(form.value) : addProviderChannel(form.value)
    request.then(() => {
      proxy.$modal.msgSuccess(form.value.channelId ? "修改成功" : "新增成功")
      open.value = false
      getList()
    })
  })
}
function handleDelete(row) {
  const channelIds = row.channelId || ids.value
  proxy.$modal.confirm('是否确认删除渠道编号为"' + channelIds + '"的数据项？').then(function() {
    return delProviderChannel(channelIds)
  }).then(() => {
    proxy.$modal.msgSuccess("删除成功")
    getList()
  }).catch(() => {})
}

getProviderOptions()
getList()
</script>
