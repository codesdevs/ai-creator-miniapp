<template>
  <div class="app-container">
    <el-form ref="queryRef" :model="queryParams" :inline="true" v-show="showSearch">
      <el-form-item label="卡包名称" prop="packageName">
        <el-input v-model="queryParams.packageName" placeholder="请输入卡包名称" clearable style="width: 220px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="卡密" prop="cardCode">
        <el-input v-model="queryParams.cardCode" placeholder="请输入卡密" clearable style="width: 220px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable style="width: 140px">
          <el-option label="未使用" value="0" />
          <el-option label="已使用" value="1" />
          <el-option label="停用" value="2" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['ai:cardCode:add']">新增卡密</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="Tickets" @click="handleBatchGenerate" v-hasPermi="['ai:cardCode:add']">批量生成</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete" v-hasPermi="['ai:cardCode:remove']">删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="Download" @click="handleExport" v-hasPermi="['ai:cardCode:export']">导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
    </el-row>

    <el-table v-loading="loading" :data="cardCodeList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="ID" align="center" prop="cardCodeId" width="90" />
      <el-table-column label="卡包名称" align="center" prop="packageName" min-width="140" />
      <el-table-column label="卡密" align="center" prop="cardCode" min-width="180" />
      <el-table-column label="基础算力" align="center" prop="powerNum" width="100" />
      <el-table-column label="赠送算力" align="center" prop="bonusPowerNum" width="100" />
      <el-table-column label="状态" align="center" prop="status" width="100">
        <template #default="scope">
          <el-switch
            v-if="scope.row.status !== '1'"
            :model-value="scope.row.status === '0'"
            inline-prompt
            active-text="启"
            inactive-text="停"
            @change="handleChangeStatus(scope.row, $event)"
          />
          <el-tag v-else :type="statusTagType(scope.row.status)">{{ formatStatus(scope.row.status) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="使用用户" align="center" min-width="160">
        <template #default="scope">{{ scope.row.nickName || scope.row.userNo || '-' }}</template>
      </el-table-column>
      <el-table-column label="使用时间" align="center" prop="usedTime" width="180" />
      <el-table-column label="创建时间" align="center" prop="createTime" width="180" />
      <el-table-column label="备注" align="center" prop="remark" min-width="180" show-overflow-tooltip />
      <el-table-column label="操作" align="center" width="160" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="View" @click="handleDetail(scope.row)" v-hasPermi="['ai:cardCode:query']">详情</el-button>
          <el-button link type="primary" icon="Edit" @click="handleEdit(scope.row)" v-hasPermi="['ai:cardCode:edit']" :disabled="scope.row.status === '1'">编辑</el-button>
          <el-button link type="danger" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['ai:cardCode:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" v-model="open" width="520px" append-to-body>
      <el-form ref="cardCodeRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="卡包" prop="packageId">
          <el-select v-model="form.packageId" style="width: 100%" filterable>
            <el-option v-for="item in packageOptions" :key="item.packageId" :label="item.packageName" :value="item.packageId" />
          </el-select>
        </el-form-item>
        <el-form-item label="卡密" prop="cardCode">
          <el-input v-model="form.cardCode" placeholder="留空则自动生成" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="form.status" style="width: 100%">
            <el-option label="未使用" value="0" />
            <el-option label="停用" value="2" />
          </el-select>
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" :rows="3" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="open = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <el-dialog title="批量生成卡密" v-model="batchOpen" width="520px" append-to-body>
      <el-form ref="batchRef" :model="batchForm" :rules="batchRules" label-width="100px">
        <el-form-item label="卡包" prop="packageId">
          <el-select v-model="batchForm.packageId" style="width: 100%" filterable>
            <el-option v-for="item in packageOptions" :key="item.packageId" :label="item.packageName" :value="item.packageId" />
          </el-select>
        </el-form-item>
        <el-form-item label="生成数量" prop="quantity">
          <el-input-number v-model="batchForm.quantity" :min="1" :max="200" style="width: 100%" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="batchForm.remark" type="textarea" :rows="3" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitBatchForm">确 定</el-button>
          <el-button @click="batchOpen = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <el-dialog title="卡密详情" v-model="detailOpen" width="560px" append-to-body>
      <el-descriptions :column="2" border v-loading="detailLoading">
        <el-descriptions-item label="卡密ID">{{ detailForm.cardCodeId || "-" }}</el-descriptions-item>
        <el-descriptions-item label="卡包名称">{{ detailForm.packageName || "-" }}</el-descriptions-item>
        <el-descriptions-item label="卡密">{{ detailForm.cardCode || "-" }}</el-descriptions-item>
        <el-descriptions-item label="状态">
          <el-tag :type="statusTagType(detailForm.status)">{{ formatStatus(detailForm.status) }}</el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="基础算力">{{ detailForm.powerNum ?? "-" }}</el-descriptions-item>
        <el-descriptions-item label="赠送算力">{{ detailForm.bonusPowerNum ?? "-" }}</el-descriptions-item>
        <el-descriptions-item label="使用用户">{{ detailForm.nickName || detailForm.userNo || "-" }}</el-descriptions-item>
        <el-descriptions-item label="用户编号">{{ detailForm.userNo || "-" }}</el-descriptions-item>
        <el-descriptions-item label="关联订单ID">{{ detailForm.orderId || "-" }}</el-descriptions-item>
        <el-descriptions-item label="使用时间">{{ detailForm.usedTime || "-" }}</el-descriptions-item>
        <el-descriptions-item label="创建时间">{{ detailForm.createTime || "-" }}</el-descriptions-item>
        <el-descriptions-item label="备注" :span="2">{{ detailForm.remark || "-" }}</el-descriptions-item>
      </el-descriptions>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="detailOpen = false">关 闭</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="AiCardCode">
import { addCardCode, batchGenerateCardCode, delCardCode, getCardCode, listCardCode, updateCardCode } from "@/api/ai/cardCode"
import { listRechargePackage } from "@/api/ai/rechargePackage"

const { proxy } = getCurrentInstance()
const cardCodeList = ref([])
const packageOptions = ref([])
const ids = ref([])
const total = ref(0)
const loading = ref(true)
const showSearch = ref(true)
const open = ref(false)
const title = ref("")
const batchOpen = ref(false)
const detailOpen = ref(false)
const detailLoading = ref(false)
const multiple = ref(true)

const data = reactive({
  queryParams: { pageNum: 1, pageSize: 10, packageName: undefined, cardCode: undefined, status: undefined },
  form: { packageId: undefined, cardCode: "", status: "0", remark: "" },
  batchForm: { packageId: undefined, quantity: 10, remark: "" },
  detailForm: {},
  rules: { packageId: [{ required: true, message: "卡包不能为空", trigger: "change" }] },
  batchRules: {
    packageId: [{ required: true, message: "卡包不能为空", trigger: "change" }],
    quantity: [{ required: true, message: "生成数量不能为空", trigger: "blur" }]
  }
})

const { queryParams, form, batchForm, detailForm, rules, batchRules } = toRefs(data)

function getList() {
  loading.value = true
  listCardCode(queryParams.value).then(response => {
    cardCodeList.value = response.rows
    total.value = response.total
    loading.value = false
  }).catch(() => loading.value = false)
}

function loadPackageOptions() {
  listRechargePackage({ pageNum: 1, pageSize: 1000 }).then(response => {
    packageOptions.value = response.rows || []
  })
}

function handleQuery() { queryParams.value.pageNum = 1; getList() }
function resetQuery() { proxy.resetForm("queryRef"); handleQuery() }
function handleSelectionChange(selection) { ids.value = selection.map(item => item.cardCodeId); multiple.value = !selection.length }
function resetForm() { form.value = { packageId: undefined, cardCode: "", status: "0", remark: "" }; proxy?.resetForm?.("cardCodeRef") }
function resetBatchForm() { batchForm.value = { packageId: undefined, quantity: 10, remark: "" }; proxy?.resetForm?.("batchRef") }
function handleAdd() { resetForm(); title.value = "新增卡密"; open.value = true }
function handleBatchGenerate() { resetBatchForm(); batchOpen.value = true }
function resetDetailForm() { detailForm.value = {} }
function handleEdit(row) {
  resetForm()
  getCardCode(row.cardCodeId).then(response => {
    form.value = response.data || {}
    title.value = "编辑卡密"
    open.value = true
  })
}

function submitForm() {
  proxy.$refs["cardCodeRef"].validate(valid => {
    if (!valid) return
    const request = form.value.cardCodeId ? updateCardCode(form.value) : addCardCode(form.value)
    request.then(() => {
      proxy.$modal.msgSuccess(form.value.cardCodeId ? "修改成功" : "新增成功")
      open.value = false
      getList()
    })
  })
}

function submitBatchForm() {
  proxy.$refs["batchRef"].validate(valid => {
    if (!valid) return
    batchGenerateCardCode(batchForm.value).then(() => {
      proxy.$modal.msgSuccess("生成成功")
      batchOpen.value = false
      getList()
    })
  })
}

function handleDetail(row) {
  resetDetailForm()
  detailOpen.value = true
  detailLoading.value = true
  getCardCode(row.cardCodeId).then(response => {
    detailForm.value = response.data || {}
  }).finally(() => {
    detailLoading.value = false
  })
}

function handleDelete(row) {
  const cardCodeIds = row?.cardCodeId ? [row.cardCodeId] : ids.value
  proxy.$modal.confirm(`是否确认删除卡密编号为 "${cardCodeIds.join(",")}" 的数据项？`).then(() => {
    return delCardCode(cardCodeIds.join(","))
  }).then(() => {
    proxy.$modal.msgSuccess("删除成功")
    getList()
  }).catch(() => {})
}

function handleExport() {
  proxy.download("ai/cardCode/export", {
    ...queryParams.value
  }, `card_code_${new Date().getTime()}.xlsx`)
}

function handleChangeStatus(row, value) {
  const status = value ? "0" : "2"
  const actionText = value ? "启用" : "停用"
  proxy.$modal.confirm(`是否确认${actionText}卡密 "${row.cardCode}"？`).then(() => {
    return updateCardCode({
      cardCodeId: row.cardCodeId,
      packageId: row.packageId,
      cardCode: row.cardCode,
      status,
      remark: row.remark
    })
  }).then(() => {
    proxy.$modal.msgSuccess(`${actionText}成功`)
    getList()
  }).catch(() => {
    getList()
  })
}

function formatStatus(status) {
  if (status === "0") return "未使用"
  if (status === "1") return "已使用"
  if (status === "2") return "停用"
  return status || "-"
}

function statusTagType(status) {
  if (status === "0") return "success"
  if (status === "1") return "warning"
  if (status === "2") return "danger"
  return "info"
}

getList()
loadPackageOptions()
</script>
