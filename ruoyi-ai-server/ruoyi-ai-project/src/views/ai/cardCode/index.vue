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
          <el-tag :type="statusTagType(scope.row.status)">{{ formatStatus(scope.row.status) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="使用用户" align="center" min-width="160">
        <template #default="scope">{{ scope.row.nickName || scope.row.userNo || '-' }}</template>
      </el-table-column>
      <el-table-column label="使用时间" align="center" prop="usedTime" width="180" />
      <el-table-column label="创建时间" align="center" prop="createTime" width="180" />
      <el-table-column label="备注" align="center" prop="remark" min-width="180" show-overflow-tooltip />
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <el-dialog title="新增卡密" v-model="open" width="520px" append-to-body>
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
  </div>
</template>

<script setup name="AiCardCode">
import { addCardCode, batchGenerateCardCode, delCardCode, listCardCode } from "@/api/ai/cardCode"
import { listRechargePackage } from "@/api/ai/rechargePackage"

const { proxy } = getCurrentInstance()
const cardCodeList = ref([])
const packageOptions = ref([])
const ids = ref([])
const total = ref(0)
const loading = ref(true)
const showSearch = ref(true)
const open = ref(false)
const batchOpen = ref(false)
const multiple = ref(true)

const data = reactive({
  queryParams: { pageNum: 1, pageSize: 10, packageName: undefined, cardCode: undefined, status: undefined },
  form: { packageId: undefined, cardCode: "", status: "0", remark: "" },
  batchForm: { packageId: undefined, quantity: 10, remark: "" },
  rules: { packageId: [{ required: true, message: "卡包不能为空", trigger: "change" }] },
  batchRules: {
    packageId: [{ required: true, message: "卡包不能为空", trigger: "change" }],
    quantity: [{ required: true, message: "生成数量不能为空", trigger: "blur" }]
  }
})

const { queryParams, form, batchForm, rules, batchRules } = toRefs(data)

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
function handleAdd() { resetForm(); open.value = true }
function handleBatchGenerate() { resetBatchForm(); batchOpen.value = true }

function submitForm() {
  proxy.$refs["cardCodeRef"].validate(valid => {
    if (!valid) return
    addCardCode(form.value).then(() => {
      proxy.$modal.msgSuccess("新增成功")
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

function handleDelete(row) {
  const cardCodeIds = row?.cardCodeId ? [row.cardCodeId] : ids.value
  proxy.$modal.confirm(`是否确认删除卡密编号为 "${cardCodeIds.join(",")}" 的数据项？`).then(() => {
    return delCardCode(cardCodeIds.join(","))
  }).then(() => {
    proxy.$modal.msgSuccess("删除成功")
    getList()
  }).catch(() => {})
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
