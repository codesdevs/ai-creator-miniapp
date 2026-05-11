<template>
  <div class="app-container">
    <el-form ref="queryRef" :model="queryParams" :inline="true" v-show="showSearch">
      <el-form-item label="套餐名称" prop="packageName">
        <el-input v-model="queryParams.packageName" placeholder="请输入套餐名称" clearable style="width: 220px" @keyup.enter="handleQuery" />
      </el-form-item>
      <el-form-item label="套餐编码" prop="packageCode">
        <el-input v-model="queryParams.packageCode" placeholder="请输入套餐编码" clearable style="width: 220px" @keyup.enter="handleQuery" />
      </el-form-item>
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
        <el-button type="primary" plain icon="Plus" @click="handleAdd" v-hasPermi="['ai:rechargePackage:add']">新增套餐</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
    </el-row>

    <el-table v-loading="loading" :data="packageList">
      <el-table-column label="套餐ID" align="center" prop="packageId" width="90" />
      <el-table-column label="套餐名称" align="center" prop="packageName" min-width="140" />
      <el-table-column label="套餐编码" align="center" prop="packageCode" min-width="140" />
      <el-table-column label="基础算力" align="center" prop="powerNum" width="100" />
      <el-table-column label="赠送算力" align="center" prop="bonusPowerNum" width="100" />
      <el-table-column label="销售价" align="center" prop="salePrice" width="100" />
      <el-table-column label="原价" align="center" prop="originalPrice" width="100" />
      <el-table-column label="排序" align="center" prop="sort" width="80" />
      <el-table-column label="状态" align="center" prop="status" width="90">
        <template #default="scope">
          <el-tag :type="scope.row.status === '0' ? 'success' : 'danger'">{{ scope.row.status === '0' ? '正常' : '停用' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="说明" align="center" prop="packageDesc" min-width="220" show-overflow-tooltip />
      <el-table-column label="操作" align="center" width="100">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleEdit(scope.row)" v-hasPermi="['ai:rechargePackage:edit']">编辑</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" v-model="open" width="600px" append-to-body>
      <el-form ref="packageRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="套餐名称" prop="packageName"><el-input v-model="form.packageName" /></el-form-item>
        <el-form-item label="套餐编码" prop="packageCode"><el-input v-model="form.packageCode" /></el-form-item>
        <el-form-item label="基础算力" prop="powerNum"><el-input-number v-model="form.powerNum" :min="0" style="width: 100%" /></el-form-item>
        <el-form-item label="赠送算力" prop="bonusPowerNum"><el-input-number v-model="form.bonusPowerNum" :min="0" style="width: 100%" /></el-form-item>
        <el-form-item label="销售价" prop="salePrice"><el-input-number v-model="form.salePrice" :min="0" :precision="2" style="width: 100%" /></el-form-item>
        <el-form-item label="原价" prop="originalPrice"><el-input-number v-model="form.originalPrice" :min="0" :precision="2" style="width: 100%" /></el-form-item>
        <el-form-item label="排序" prop="sort"><el-input-number v-model="form.sort" :min="0" style="width: 100%" /></el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="form.status" style="width: 100%">
            <el-option label="正常" value="0" />
            <el-option label="停用" value="1" />
          </el-select>
        </el-form-item>
        <el-form-item label="套餐说明" prop="packageDesc"><el-input v-model="form.packageDesc" type="textarea" :rows="3" /></el-form-item>
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

<script setup name="AiRechargePackage">
import { addRechargePackage, getRechargePackage, listRechargePackage, updateRechargePackage } from "@/api/ai/rechargePackage"

const { proxy } = getCurrentInstance()
const packageList = ref([])
const total = ref(0)
const loading = ref(true)
const showSearch = ref(true)
const open = ref(false)
const title = ref("")

const data = reactive({
  queryParams: { pageNum: 1, pageSize: 10, packageName: undefined, packageCode: undefined, status: undefined },
  form: { packageId: undefined, packageName: "", packageCode: "", powerNum: 0, bonusPowerNum: 0, salePrice: 0, originalPrice: 0, sort: 0, packageDesc: "", status: "0", remark: "" },
  rules: {
    packageName: [{ required: true, message: "套餐名称不能为空", trigger: "blur" }],
    packageCode: [{ required: true, message: "套餐编码不能为空", trigger: "blur" }]
  }
})

const { queryParams, form, rules } = toRefs(data)

function getList() {
  loading.value = true
  listRechargePackage(queryParams.value).then(response => {
    packageList.value = response.rows
    total.value = response.total
    loading.value = false
  }).catch(() => loading.value = false)
}

function handleQuery() { queryParams.value.pageNum = 1; getList() }
function resetQuery() { proxy.resetForm("queryRef"); handleQuery() }
function resetForm() { form.value = { packageId: undefined, packageName: "", packageCode: "", powerNum: 0, bonusPowerNum: 0, salePrice: 0, originalPrice: 0, sort: 0, packageDesc: "", status: "0", remark: "" }; proxy?.resetForm?.("packageRef") }
function handleAdd() { resetForm(); open.value = true; title.value = "新增充值套餐" }
function handleEdit(row) { resetForm(); getRechargePackage(row.packageId).then(res => { form.value = res.data; open.value = true; title.value = "编辑充值套餐" }) }
function submitForm() {
  proxy.$refs["packageRef"].validate(valid => {
    if (!valid) return
    const request = form.value.packageId ? updateRechargePackage(form.value) : addRechargePackage(form.value)
    request.then(() => {
      proxy.$modal.msgSuccess(form.value.packageId ? "修改成功" : "新增成功")
      open.value = false
      getList()
    })
  })
}

getList()
</script>
