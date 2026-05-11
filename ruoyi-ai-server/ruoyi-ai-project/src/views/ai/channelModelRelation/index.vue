<template>
  <div class="app-container">
    <el-form ref="queryRef" :model="queryParams" :inline="true" v-show="showSearch">
      <el-form-item label="渠道" prop="channelId">
        <el-select v-model="queryParams.channelId" placeholder="请选择渠道" clearable filterable style="width: 240px">
          <el-option v-for="item in channelOptions" :key="item.channelId" :label="item.providerName ? `${item.providerName} / ${item.channelName}` : item.channelName" :value="item.channelId" />
        </el-select>
      </el-form-item>
      <el-form-item label="模型版本" prop="modelVersionId">
        <el-select v-model="queryParams.modelVersionId" placeholder="请选择模型版本" clearable filterable style="width: 240px">
          <el-option v-for="item in versionOptions" :key="item.versionId" :label="item.modelName ? `${item.modelName} / ${item.versionName}` : item.versionName" :value="item.versionId" />
        </el-select>
      </el-form-item>
      <el-form-item label="远程模型名" prop="remoteModelName">
        <el-input v-model="queryParams.remoteModelName" placeholder="请输入远程模型名" clearable style="width: 220px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="状态" prop="enabled">
        <el-select v-model="queryParams.enabled" placeholder="请选择状态" clearable style="width: 140px">
          <el-option label="启用" value="0" />
          <el-option label="停用" value="1" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5"><el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['ai:channelModelRelation:add']">新增</el-button></el-col>
      <el-col :span="1.5"><el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate" v-hasPermi="['ai:channelModelRelation:edit']">修改</el-button></el-col>
      <el-col :span="1.5"><el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete" v-hasPermi="['ai:channelModelRelation:remove']">删除</el-button></el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
    </el-row>

    <el-table v-loading="loading" :data="relationList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="ID" align="center" prop="relationId" width="80" />
      <el-table-column label="提供商" align="center" prop="providerName" min-width="120" />
      <el-table-column label="渠道" align="center" prop="channelName" min-width="140" />
      <el-table-column label="模型" align="center" prop="modelName" min-width="140" />
      <el-table-column label="版本" align="center" prop="versionName" min-width="140" />
      <el-table-column label="平台模型名" align="center" prop="apiModelName" min-width="160" show-overflow-tooltip />
      <el-table-column label="远程模型名" align="center" prop="remoteModelName" min-width="180" show-overflow-tooltip />
      <el-table-column label="价格系数" align="center" prop="priceRatio" width="100" />
      <el-table-column label="优先级" align="center" prop="priority" width="90" />
      <el-table-column label="权重" align="center" prop="weight" width="90" />
      <el-table-column label="QPS" align="center" prop="maxQps" width="90" />
      <el-table-column label="状态" align="center" prop="enabled" width="90">
        <template #default="scope"><el-tag :type="scope.row.enabled === '0' ? 'success' : 'info'">{{ scope.row.enabled === '0' ? '启用' : '停用' }}</el-tag></template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="180">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['ai:channelModelRelation:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['ai:channelModelRelation:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" v-model="open" width="760px" append-to-body>
      <el-form ref="relationRef" :model="form" :rules="rules" label-width="110px">
        <el-form-item label="所属渠道" prop="channelId">
          <el-select v-model="form.channelId" filterable style="width: 100%">
            <el-option v-for="item in channelOptions" :key="item.channelId" :label="item.providerName ? `${item.providerName} / ${item.channelName}` : item.channelName" :value="item.channelId" />
          </el-select>
        </el-form-item>
        <el-form-item label="模型版本" prop="modelVersionId">
          <el-select v-model="form.modelVersionId" filterable style="width: 100%">
            <el-option v-for="item in versionOptions" :key="item.versionId" :label="item.modelName ? `${item.modelName} / ${item.versionName}` : item.versionName" :value="item.versionId" />
          </el-select>
        </el-form-item>
        <el-form-item label="远程模型名" prop="remoteModelName">
          <el-input v-model="form.remoteModelName" placeholder="请输入渠道实际调用模型名" />
        </el-form-item>
        <el-row>
          <el-col :span="12"><el-form-item label="价格系数" prop="priceRatio"><el-input-number v-model="form.priceRatio" :min="0" :precision="4" style="width: 100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="优先级" prop="priority"><el-input-number v-model="form.priority" :min="0" style="width: 100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="权重" prop="weight"><el-input-number v-model="form.weight" :min="0" style="width: 100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="最大QPS" prop="maxQps"><el-input-number v-model="form.maxQps" :min="0" style="width: 100%" /></el-form-item></el-col>
        </el-row>
        <el-form-item label="状态" prop="enabled">
          <el-radio-group v-model="form.enabled">
            <el-radio value="0">启用</el-radio>
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

<script setup name="AiChannelModelRelation">
import { listProviderChannel } from "@/api/ai/providerChannel"
import { listModelVersion } from "@/api/ai/modelVersion"
import { addChannelModelRelation, delChannelModelRelation, getChannelModelRelation, listChannelModelRelation, updateChannelModelRelation } from "@/api/ai/channelModelRelation"

const { proxy } = getCurrentInstance()
const relationList = ref([])
const channelOptions = ref([])
const versionOptions = ref([])
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
  queryParams: { pageNum: 1, pageSize: 10, channelId: undefined, modelVersionId: undefined, remoteModelName: undefined, enabled: undefined },
  rules: {
    channelId: [{ required: true, message: "渠道不能为空", trigger: "change" }],
    modelVersionId: [{ required: true, message: "模型版本不能为空", trigger: "change" }],
    remoteModelName: [{ required: true, message: "远程模型名不能为空", trigger: "blur" }]
  }
})

const { queryParams, form, rules } = toRefs(data)

function getList() {
  loading.value = true
  listChannelModelRelation(queryParams.value).then(response => {
    relationList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

function getChannelOptions() {
  listProviderChannel({ pageNum: 1, pageSize: 1000, status: "0" }).then(response => {
    channelOptions.value = response.rows || []
  })
}

function getVersionOptions() {
  listModelVersion({ pageNum: 1, pageSize: 1000, status: "0" }).then(response => {
    versionOptions.value = response.rows || []
  })
}

function reset() {
  form.value = {
    relationId: undefined,
    channelId: undefined,
    modelVersionId: undefined,
    remoteModelName: undefined,
    enabled: "0",
    priceRatio: 1,
    priority: 0,
    weight: 100,
    maxQps: 0,
    remark: undefined
  }
  proxy.resetForm("relationRef")
}

function cancel() { open.value = false; reset() }
function handleQuery() { queryParams.value.pageNum = 1; getList() }
function resetQuery() { proxy.resetForm("queryRef"); handleQuery() }
function handleSelectionChange(selection) { ids.value = selection.map(item => item.relationId); single.value = selection.length !== 1; multiple.value = !selection.length }
function handleAdd() { reset(); open.value = true; title.value = "新增渠道模型映射" }
function handleUpdate(row) {
  reset()
  getChannelModelRelation(row.relationId || ids.value[0]).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改渠道模型映射"
  })
}
function submitForm() {
  proxy.$refs["relationRef"].validate(valid => {
    if (!valid) return
    const request = form.value.relationId ? updateChannelModelRelation(form.value) : addChannelModelRelation(form.value)
    request.then(() => {
      proxy.$modal.msgSuccess(form.value.relationId ? "修改成功" : "新增成功")
      open.value = false
      getList()
    })
  })
}
function handleDelete(row) {
  const relationIds = row.relationId || ids.value
  proxy.$modal.confirm('是否确认删除渠道模型映射编号为"' + relationIds + '"的数据项？').then(function() {
    return delChannelModelRelation(relationIds)
  }).then(() => {
    proxy.$modal.msgSuccess("删除成功")
    getList()
  }).catch(() => {})
}

getChannelOptions()
getVersionOptions()
getList()
</script>
