<template>
  <div class="app-container">
    <el-form ref="queryRef" :model="queryParams" :inline="true" v-show="showSearch">
      <el-form-item label="配置名称" prop="configName"><el-input v-model="queryParams.configName" placeholder="请输入配置名称" clearable style="width: 220px" @keyup.enter="handleQuery" /></el-form-item>
      <el-form-item label="配置编码" prop="configCode"><el-input v-model="queryParams.configCode" placeholder="请输入配置编码" clearable style="width: 220px" @keyup.enter="handleQuery" /></el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable style="width: 140px">
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
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['ai:payConfig:add']">新增配置</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
    </el-row>

    <el-table v-loading="loading" :data="configList">
      <el-table-column label="配置ID" align="center" prop="payConfigId" width="90" />
      <el-table-column label="配置名称" align="center" prop="configName" min-width="140" />
      <el-table-column label="配置编码" align="center" prop="configCode" min-width="140" />
      <el-table-column label="支付渠道" align="center" prop="payChannel" min-width="120" />
      <el-table-column label="商户号" align="center" prop="mchId" min-width="120" />
      <el-table-column label="应用ID" align="center" prop="appId" min-width="120" />
      <el-table-column label="状态" align="center" prop="status" width="90">
        <template #default="scope"><el-tag :type="scope.row.status === '0' ? 'success' : 'danger'">{{ scope.row.status === '0' ? '正常' : '停用' }}</el-tag></template>
      </el-table-column>
      <el-table-column label="回调地址" align="center" prop="notifyUrl" min-width="180" show-overflow-tooltip />
      <el-table-column label="操作" align="center" width="100">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleEdit(scope.row)" v-hasPermi="['ai:payConfig:edit']">编辑</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" v-model="open" width="600px" append-to-body>
      <el-form ref="configRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="配置名称" prop="configName"><el-input v-model="form.configName" /></el-form-item>
        <el-form-item label="配置编码" prop="configCode"><el-input v-model="form.configCode" /></el-form-item>
        <el-form-item label="支付渠道" prop="payChannel"><el-input v-model="form.payChannel" /></el-form-item>
        <el-form-item label="商户号" prop="mchId"><el-input v-model="form.mchId" /></el-form-item>
        <el-form-item label="应用ID" prop="appId"><el-input v-model="form.appId" /></el-form-item>
        <el-form-item label="回调地址" prop="notifyUrl"><el-input v-model="form.notifyUrl" /></el-form-item>
        <el-form-item label="排序" prop="sort"><el-input-number v-model="form.sort" :min="0" style="width: 100%" /></el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="form.status" style="width: 100%">
            <el-option label="正常" value="0" />
            <el-option label="停用" value="1" />
          </el-select>
        </el-form-item>
        <el-form-item label="备注" prop="remark"><el-input v-model="form.remark" type="textarea" :rows="2" /></el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="open = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="AiPayConfig">
import { addPayConfig, getPayConfig, listPayConfig, updatePayConfig } from "@/api/ai/payConfig"

const { proxy } = getCurrentInstance()
const configList = ref([])
const total = ref(0)
const loading = ref(true)
const showSearch = ref(true)
const open = ref(false)
const title = ref("")

const data = reactive({
  queryParams: { pageNum: 1, pageSize: 10, configName: undefined, configCode: undefined, status: undefined },
  form: { payConfigId: undefined, configName: "", configCode: "", payChannel: "", mchId: "", appId: "", notifyUrl: "", sort: 0, status: "0", remark: "" },
  rules: {
    configName: [{ required: true, message: "配置名称不能为空", trigger: "blur" }],
    configCode: [{ required: true, message: "配置编码不能为空", trigger: "blur" }],
    payChannel: [{ required: true, message: "支付渠道不能为空", trigger: "blur" }]
  }
})

const { queryParams, form, rules } = toRefs(data)
function getList() { loading.value = true; listPayConfig(queryParams.value).then(r => { configList.value = r.rows; total.value = r.total; loading.value = false }).catch(() => loading.value = false) }
function handleQuery() { queryParams.value.pageNum = 1; getList() }
function resetQuery() { proxy.resetForm("queryRef"); handleQuery() }
function resetForm() { form.value = { payConfigId: undefined, configName: "", configCode: "", payChannel: "", mchId: "", appId: "", notifyUrl: "", sort: 0, status: "0", remark: "" }; proxy?.resetForm?.("configRef") }
function handleAdd() { resetForm(); title.value = "新增支付配置"; open.value = true }
function handleEdit(row) { resetForm(); getPayConfig(row.payConfigId).then(res => { form.value = res.data; title.value = "编辑支付配置"; open.value = true }) }
function submitForm() {
  proxy.$refs["configRef"].validate(valid => {
    if (!valid) return
    const request = form.value.payConfigId ? updatePayConfig(form.value) : addPayConfig(form.value)
    request.then(() => { proxy.$modal.msgSuccess(form.value.payConfigId ? "修改成功" : "新增成功"); open.value = false; getList() })
  })
}
getList()
</script>
