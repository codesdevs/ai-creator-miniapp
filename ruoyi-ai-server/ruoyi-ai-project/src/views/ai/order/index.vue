<template>
  <div class="app-container">
    <el-form ref="queryRef" :model="queryParams" :inline="true" v-show="showSearch">
      <el-form-item label="订单编号" prop="orderNo"><el-input v-model="queryParams.orderNo" placeholder="请输入订单编号" clearable style="width: 220px" @keyup.enter="handleQuery" /></el-form-item>
      <el-form-item label="用户ID" prop="userId"><el-input-number v-model="queryParams.userId" :min="1" controls-position="right" style="width: 180px" /></el-form-item>
      <el-form-item label="订单状态" prop="orderStatus">
        <el-select v-model="queryParams.orderStatus" placeholder="请选择状态" clearable style="width: 160px">
          <el-option label="待支付" value="WAIT_PAY" />
          <el-option label="已支付" value="PAID" />
          <el-option label="已关闭" value="CLOSED" />
          <el-option label="已退款" value="REFUNDED" />
        </el-select>
      </el-form-item>
      <el-form-item label="支付渠道" prop="payChannel"><el-input v-model="queryParams.payChannel" placeholder="请输入支付渠道" clearable style="width: 180px" @keyup.enter="handleQuery" /></el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
    </el-row>

    <el-table v-loading="loading" :data="orderList">
      <el-table-column label="订单ID" align="center" prop="orderId" width="90" />
      <el-table-column label="订单编号" align="center" prop="orderNo" min-width="170" />
      <el-table-column label="用户ID" align="center" prop="userId" width="90" />
      <el-table-column label="用户编号" align="center" prop="userNo" min-width="140" />
      <el-table-column label="昵称" align="center" prop="nickName" min-width="120" />
      <el-table-column label="套餐名称" align="center" prop="packageName" min-width="120" />
      <el-table-column label="到账算力" align="center" width="100">
        <template #default="scope">{{ (scope.row.powerNum || 0) + (scope.row.bonusPowerNum || 0) }}</template>
      </el-table-column>
      <el-table-column label="支付金额" align="center" prop="payAmount" width="100" />
      <el-table-column label="状态" align="center" prop="orderStatus" width="100">
        <template #default="scope"><el-tag :type="statusTagType(scope.row.orderStatus)">{{ formatOrderStatus(scope.row.orderStatus) }}</el-tag></template>
      </el-table-column>
      <el-table-column label="支付渠道" align="center" prop="payChannel" width="120" />
      <el-table-column label="支付时间" align="center" prop="payTime" width="180" />
      <el-table-column label="创建时间" align="center" prop="createTime" width="180" />
      <el-table-column label="操作" align="center" width="180">
        <template #default="scope">
          <el-button link type="primary" icon="View" @click="handleDetail(scope.row)" v-hasPermi="['ai:order:query']">详情</el-button>
          <el-button link type="warning" icon="Edit" @click="handleOpenProcess(scope.row)" v-hasPermi="['ai:order:handle']">处理</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <el-dialog title="订单详情" v-model="open" width="760px" append-to-body>
      <el-descriptions :column="2" border v-if="detail">
        <el-descriptions-item label="订单编号">{{ detail.orderNo }}</el-descriptions-item>
        <el-descriptions-item label="订单状态">{{ formatOrderStatus(detail.orderStatus) }}</el-descriptions-item>
        <el-descriptions-item label="用户ID">{{ detail.userId }}</el-descriptions-item>
        <el-descriptions-item label="用户编号">{{ detail.userNo || '-' }}</el-descriptions-item>
        <el-descriptions-item label="用户昵称">{{ detail.nickName || '-' }}</el-descriptions-item>
        <el-descriptions-item label="套餐名称">{{ detail.packageName || '-' }}</el-descriptions-item>
        <el-descriptions-item label="基础算力">{{ detail.powerNum || 0 }}</el-descriptions-item>
        <el-descriptions-item label="赠送算力">{{ detail.bonusPowerNum || 0 }}</el-descriptions-item>
        <el-descriptions-item label="支付金额">{{ detail.payAmount || 0 }}</el-descriptions-item>
        <el-descriptions-item label="支付渠道">{{ detail.payChannel || '-' }}</el-descriptions-item>
        <el-descriptions-item label="第三方单号">{{ detail.thirdOrderNo || '-' }}</el-descriptions-item>
        <el-descriptions-item label="支付时间">{{ detail.payTime || '-' }}</el-descriptions-item>
        <el-descriptions-item label="备注" :span="2">{{ detail.remark || '-' }}</el-descriptions-item>
      </el-descriptions>
    </el-dialog>

    <el-dialog title="订单处理" v-model="processOpen" width="520px" append-to-body>
      <el-form ref="processRef" :model="processForm" :rules="rules" label-width="100px">
        <el-form-item label="订单ID"><el-input :model-value="processForm.orderId" disabled /></el-form-item>
        <el-form-item label="订单状态" prop="orderStatus">
          <el-select v-model="processForm.orderStatus" style="width: 100%">
            <el-option label="待支付" value="WAIT_PAY" />
            <el-option label="已支付" value="PAID" />
            <el-option label="已关闭" value="CLOSED" />
            <el-option label="已退款" value="REFUNDED" />
          </el-select>
        </el-form-item>
        <el-form-item label="第三方单号" prop="thirdOrderNo"><el-input v-model="processForm.thirdOrderNo" /></el-form-item>
        <el-form-item label="处理备注" prop="remark"><el-input v-model="processForm.remark" type="textarea" :rows="3" /></el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitProcess">确 定</el-button>
          <el-button @click="processOpen = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="AiOrder">
import { getOrder, handleOrder, listOrder } from "@/api/ai/order"

const { proxy } = getCurrentInstance()
const orderList = ref([])
const total = ref(0)
const loading = ref(true)
const showSearch = ref(true)
const open = ref(false)
const processOpen = ref(false)
const detail = ref(null)

const data = reactive({
  queryParams: { pageNum: 1, pageSize: 10, orderNo: undefined, userId: undefined, orderStatus: undefined, payChannel: undefined },
  processForm: { orderId: undefined, orderStatus: "PAID", thirdOrderNo: "", remark: "" },
  rules: { orderStatus: [{ required: true, message: "订单状态不能为空", trigger: "change" }] }
})

const { queryParams, processForm, rules } = toRefs(data)
function getList() { loading.value = true; listOrder(queryParams.value).then(r => { orderList.value = r.rows; total.value = r.total; loading.value = false }).catch(() => loading.value = false) }
function handleQuery() { queryParams.value.pageNum = 1; getList() }
function resetQuery() { proxy.resetForm("queryRef"); handleQuery() }
function handleDetail(row) { getOrder(row.orderId).then(res => { detail.value = res.data; open.value = true }) }
function handleOpenProcess(row) { processForm.value = { orderId: row.orderId, orderStatus: row.orderStatus || "PAID", thirdOrderNo: row.thirdOrderNo || "", remark: row.remark || "" }; processOpen.value = true; proxy?.resetForm?.("processRef") }
function submitProcess() {
  proxy.$refs["processRef"].validate(valid => {
    if (!valid) return
    handleOrder(processForm.value).then(() => {
      proxy.$modal.msgSuccess("处理成功")
      processOpen.value = false
      if (open.value && detail.value?.orderId === processForm.value.orderId) {
        handleDetail({ orderId: processForm.value.orderId })
      }
      getList()
    })
  })
}
function formatOrderStatus(status) {
  if (status === "WAIT_PAY") return "待支付"
  if (status === "PAID") return "已支付"
  if (status === "CLOSED") return "已关闭"
  if (status === "REFUNDED") return "已退款"
  return status || "-"
}
function statusTagType(status) {
  if (status === "PAID") return "success"
  if (status === "WAIT_PAY") return "warning"
  if (status === "REFUNDED") return "danger"
  return "info"
}
getList()
</script>
