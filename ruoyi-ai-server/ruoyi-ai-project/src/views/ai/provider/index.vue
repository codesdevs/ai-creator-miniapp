<template>
  <div class="app-container">
    <el-form ref="queryRef" :model="queryParams" :inline="true" v-show="showSearch">
      <el-form-item label="提供商名称" prop="providerName">
        <el-input v-model="queryParams.providerName" placeholder="请输入提供商名称" clearable style="width: 200px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="提供商编码" prop="providerCode">
        <el-input v-model="queryParams.providerCode" placeholder="请输入提供商编码" clearable style="width: 200px" @keyup.enter="handleQuery" />
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
      <el-col :span="1.5"><el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['ai:provider:add']">新增</el-button></el-col>
      <el-col :span="1.5"><el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate" v-hasPermi="['ai:provider:edit']">修改</el-button></el-col>
      <el-col :span="1.5"><el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete" v-hasPermi="['ai:provider:remove']">删除</el-button></el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
    </el-row>

    <el-table v-loading="loading" :data="providerList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="ID" align="center" prop="providerId" width="80" />
      <el-table-column label="提供商名称" align="center" prop="providerName" min-width="140" />
      <el-table-column label="提供商编码" align="center" prop="providerCode" min-width="140" />
      <el-table-column label="类型" align="center" prop="providerType" width="120" />
      <el-table-column label="官网" align="center" prop="website" min-width="180" show-overflow-tooltip />
      <el-table-column label="状态" align="center" prop="status" width="90">
        <template #default="scope"><el-tag :type="scope.row.status === '0' ? 'success' : 'info'">{{ scope.row.status === '0' ? '正常' : '停用' }}</el-tag></template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="180" />
      <el-table-column label="操作" align="center" width="180">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['ai:provider:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['ai:provider:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" v-model="open" width="680px" append-to-body>
      <el-form ref="providerRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="提供商名称" prop="providerName"><el-input v-model="form.providerName" /></el-form-item>
        <el-form-item label="提供商编码" prop="providerCode"><el-input v-model="form.providerCode" /></el-form-item>
        <el-form-item label="类型" prop="providerType">
          <el-select v-model="form.providerType">
            <el-option label="官方" value="OFFICIAL" />
            <el-option label="中转" value="RELAY" />
            <el-option label="自定义" value="CUSTOM" />
          </el-select>
        </el-form-item>
        <el-form-item label="图标" prop="icon"><el-input v-model="form.icon" /></el-form-item>
        <el-form-item label="官网" prop="website"><el-input v-model="form.website" /></el-form-item>
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

<script setup name="AiProvider">
import { addProvider, delProvider, getProvider, listProvider, updateProvider } from "@/api/ai/provider"

const { proxy } = getCurrentInstance()
const providerList = ref([])
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
  queryParams: { pageNum: 1, pageSize: 10, providerName: undefined, providerCode: undefined, status: undefined },
  rules: {
    providerName: [{ required: true, message: "提供商名称不能为空", trigger: "blur" }],
    providerCode: [{ required: true, message: "提供商编码不能为空", trigger: "blur" }]
  }
})

const { queryParams, form, rules } = toRefs(data)

function getList() {
  loading.value = true
  listProvider(queryParams.value).then(response => {
    providerList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

function reset() {
  form.value = { providerId: undefined, providerName: undefined, providerCode: undefined, providerType: "OFFICIAL", icon: undefined, website: undefined, status: "0", remark: undefined }
  proxy.resetForm("providerRef")
}

function cancel() { open.value = false; reset() }
function handleQuery() { queryParams.value.pageNum = 1; getList() }
function resetQuery() { proxy.resetForm("queryRef"); handleQuery() }
function handleSelectionChange(selection) { ids.value = selection.map(item => item.providerId); single.value = selection.length !== 1; multiple.value = !selection.length }
function handleAdd() { reset(); open.value = true; title.value = "新增提供商" }
function handleUpdate(row) {
  reset()
  getProvider(row.providerId || ids.value[0]).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改提供商"
  })
}
function submitForm() {
  proxy.$refs["providerRef"].validate(valid => {
    if (!valid) return
    const request = form.value.providerId ? updateProvider(form.value) : addProvider(form.value)
    request.then(() => {
      proxy.$modal.msgSuccess(form.value.providerId ? "修改成功" : "新增成功")
      open.value = false
      getList()
    })
  })
}
function handleDelete(row) {
  const providerIds = row.providerId || ids.value
  proxy.$modal.confirm('是否确认删除提供商编号为"' + providerIds + '"的数据项？').then(function() {
    return delProvider(providerIds)
  }).then(() => {
    proxy.$modal.msgSuccess("删除成功")
    getList()
  }).catch(() => {})
}

getList()
</script>
