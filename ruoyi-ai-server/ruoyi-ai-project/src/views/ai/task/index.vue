<template>
  <div class="app-container">
    <el-form ref="queryRef" :model="queryParams" :inline="true" v-show="showSearch">
      <el-form-item label="任务编号" prop="taskNo">
        <el-input
          v-model="queryParams.taskNo"
          placeholder="请输入任务编号"
          clearable
          style="width: 220px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="任务类型" prop="taskType">
        <el-select v-model="queryParams.taskType" placeholder="请选择任务类型" clearable style="width: 160px">
          <el-option label="图片" value="IMAGE" />
          <el-option label="视频" value="VIDEO" />
          <el-option label="文本" value="TEXT" />
        </el-select>
      </el-form-item>
      <el-form-item label="任务状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择任务状态" clearable style="width: 160px">
          <el-option label="待执行" value="PENDING" />
          <el-option label="排队中" value="WAITING" />
          <el-option label="执行中" value="RUNNING" />
          <el-option label="成功" value="SUCCESS" />
          <el-option label="失败" value="FAIL" />
        </el-select>
      </el-form-item>
      <el-form-item label="提供商" prop="providerName">
        <el-input
          v-model="queryParams.providerName"
          placeholder="请输入提供商"
          clearable
          style="width: 180px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="渠道" prop="channelName">
        <el-input
          v-model="queryParams.channelName"
          placeholder="请输入渠道"
          clearable
          style="width: 180px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="远端模型" prop="remoteModelName">
        <el-input
          v-model="queryParams.remoteModelName"
          placeholder="请输入远端模型"
          clearable
          style="width: 180px"
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="请求落库" prop="requestRecorded">
        <el-select v-model="queryParams.requestRecorded" placeholder="请选择" clearable style="width: 140px">
          <el-option label="已记录" value="1" />
          <el-option label="未记录" value="0" />
        </el-select>
      </el-form-item>
      <el-form-item label="响应落库" prop="responseRecorded">
        <el-select v-model="queryParams.responseRecorded" placeholder="请选择" clearable style="width: 140px">
          <el-option label="已记录" value="1" />
          <el-option label="未记录" value="0" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button type="warning" plain @click="filterProcessing">处理中</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList" />
    </el-row>

    <el-table v-loading="loading" :data="taskList">
      <el-table-column label="任务ID" align="center" prop="taskId" width="90" />
      <el-table-column label="会员昵称" align="center" prop="nickName" min-width="120" show-overflow-tooltip />
      <el-table-column label="任务编号" align="center" prop="taskNo" min-width="180" />
      <el-table-column label="模型名称" align="center" prop="modelName" min-width="120" />
      <el-table-column label="版本名称" align="center" prop="versionName" min-width="120" />
      <el-table-column label="任务状态" align="center" prop="status" width="100">
        <template #default="scope">
          <el-tag :type="statusTagType(scope.row.status)">{{ scope.row.status }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="提交时间" align="center" prop="submitTime" width="180" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="180">
        <template #default="scope">
          <el-button link type="primary" icon="View" @click="handleDetail(scope.row)" v-hasPermi="['ai:task:query']">详情</el-button>
          <el-button link type="warning" icon="Edit" @click="handleOpenProcess(scope.row)" v-hasPermi="['ai:task:handle']">处理</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total > 0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />

    <el-dialog v-model="open" width="900px" append-to-body @closed="stopDetailAutoRefresh">
      <template #header>
        <div class="detail-header">
          <span>任务详情</span>
          <div class="detail-actions">
            <el-tag v-if="detailAutoRefreshActive" type="warning" size="small">自动刷新中</el-tag>
            <el-button link type="primary" icon="Refresh" @click="refreshDetail">立即刷新</el-button>
          </div>
        </div>
      </template>
      <template v-if="detail.task">
        <el-divider content-position="left">基础信息</el-divider>
        <el-descriptions :column="2" border>
          <el-descriptions-item label="任务ID">{{ detail.task.taskId || '-' }}</el-descriptions-item>
          <el-descriptions-item label="任务编号">{{ detail.task.taskNo }}</el-descriptions-item>
          <el-descriptions-item label="任务状态">
            <el-tag :type="statusTagType(detail.task.status)">{{ detail.task.status }}</el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="失败退款">{{ detail.task.status === 'FAIL' ? (detail.refunded ? '已退款' : '未退款') : '-' }}</el-descriptions-item>
          <el-descriptions-item label="会员ID">{{ detail.task.userId || '-' }}</el-descriptions-item>
          <el-descriptions-item label="会员昵称">{{ detail.task.nickName || '-' }}</el-descriptions-item>
          <el-descriptions-item label="模型名称">{{ detail.task.modelName || '-' }}</el-descriptions-item>
          <el-descriptions-item label="版本名称">{{ detail.task.versionName || '-' }}</el-descriptions-item>
          <el-descriptions-item label="提交时间">{{ detail.task.submitTime || '-' }}</el-descriptions-item>
          <el-descriptions-item label="完成时间">{{ detail.task.finishTime || '-' }}</el-descriptions-item>
          <el-descriptions-item label="失败原因" :span="2">{{ detail.task.failReason || '-' }}</el-descriptions-item>
          <el-descriptions-item label="备注" :span="2">{{ detail.task.remark || '-' }}</el-descriptions-item>
        </el-descriptions>

        <el-divider content-position="left">创作参数</el-divider>
        <el-descriptions :column="2" border>
          <el-descriptions-item label="任务类型">{{ detail.task.taskType || '-' }}</el-descriptions-item>
          <el-descriptions-item label="创作模式">{{ detail.task.createMode || '-' }}</el-descriptions-item>
          <el-descriptions-item label="风格编码">{{ detail.task.styleCode || '-' }}</el-descriptions-item>
          <el-descriptions-item label="比例编码">{{ detail.task.ratioCode || '-' }}</el-descriptions-item>
          <el-descriptions-item label="消耗算力">{{ detail.task.powerCost || '-' }}</el-descriptions-item>
          <el-descriptions-item label="原图地址">{{ detail.task.sourceUrl || '-' }}</el-descriptions-item>
          <el-descriptions-item label="提示词" :span="2">{{ detail.task.promptText || '-' }}</el-descriptions-item>
          <el-descriptions-item label="反向提示词" :span="2">{{ detail.task.negativePrompt || '-' }}</el-descriptions-item>
        </el-descriptions>

        <el-divider content-position="left">执行链路</el-divider>
        <el-descriptions :column="2" border>
          <el-descriptions-item label="提供商">{{ detail.task.providerName || '-' }}</el-descriptions-item>
          <el-descriptions-item label="渠道">{{ detail.task.channelName || '-' }}</el-descriptions-item>
          <el-descriptions-item label="远端模型名">{{ detail.task.remoteModelName || '-' }}</el-descriptions-item>
          <el-descriptions-item label="第三方任务ID">{{ detail.task.thirdTaskId || '-' }}</el-descriptions-item>
          <el-descriptions-item label="请求落库">
            <el-tag size="small" :type="hasPayload(detail.task.requestPayload) ? 'success' : 'info'">
              {{ hasPayload(detail.task.requestPayload) ? '已记录' : '未记录' }}
            </el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="响应落库">
            <el-tag size="small" :type="hasPayload(detail.task.responsePayload) ? 'success' : 'info'">
              {{ hasPayload(detail.task.responsePayload) ? '已记录' : '未记录' }}
            </el-tag>
          </el-descriptions-item>
          <el-descriptions-item label="请求参数" :span="2">
            <div class="payload-header">
              <span>请求参数</span>
              <el-button link type="primary" @click="copyText(detail.task.requestPayload)">复制</el-button>
            </div>
            <pre class="payload-pre">{{ formatPayload(detail.task.requestPayload) }}</pre>
          </el-descriptions-item>
          <el-descriptions-item label="响应内容" :span="2">
            <div class="payload-header">
              <span>响应内容</span>
              <el-button link type="primary" @click="copyText(detail.task.responsePayload)">复制</el-button>
            </div>
            <pre class="payload-pre">{{ formatPayload(detail.task.responsePayload) }}</pre>
          </el-descriptions-item>
        </el-descriptions>
      </template>

      <el-divider content-position="left">结果列表</el-divider>
      <el-table :data="detail.resultList || []">
        <el-table-column label="序号" align="center" prop="seqNo" width="80" />
        <el-table-column label="结果类型" align="center" prop="resultType" width="120" />
        <el-table-column label="预览" align="center" width="120">
          <template #default="scope">
            <el-image
              v-if="scope.row.resultType === 'IMAGE' && (scope.row.coverUrl || scope.row.fileUrl)"
              class="result-thumb"
              :src="scope.row.coverUrl || scope.row.fileUrl"
              :preview-src-list="[scope.row.fileUrl || scope.row.coverUrl]"
              fit="cover"
              preview-teleported
            />
            <span v-else>-</span>
          </template>
        </el-table-column>
        <el-table-column label="文件地址" align="center" prop="fileUrl" min-width="280" show-overflow-tooltip />
        <el-table-column label="封面地址" align="center" prop="coverUrl" min-width="220" show-overflow-tooltip />
        <el-table-column label="宽" align="center" prop="width" width="80" />
        <el-table-column label="高" align="center" prop="height" width="80" />
      </el-table>
    </el-dialog>

    <el-dialog title="人工处理任务" v-model="processOpen" width="520px" append-to-body>
      <el-form ref="processRef" :model="processForm" :rules="rules" label-width="100px">
        <el-form-item label="任务ID">
          <el-input :model-value="processForm.taskId" disabled />
        </el-form-item>
        <el-form-item label="处理状态" prop="status">
          <el-select v-model="processForm.status" placeholder="请选择状态" style="width: 100%">
            <el-option label="待执行" value="PENDING" />
            <el-option label="排队中" value="WAITING" />
            <el-option label="执行中" value="RUNNING" />
            <el-option label="成功" value="SUCCESS" />
            <el-option label="失败" value="FAIL" />
          </el-select>
        </el-form-item>
        <el-form-item label="失败原因" prop="failReason" v-if="processForm.status === 'FAIL'">
          <el-input v-model="processForm.failReason" type="textarea" :rows="3" placeholder="请输入失败原因" />
        </el-form-item>
        <el-form-item label="处理备注" prop="remark">
          <el-input v-model="processForm.remark" type="textarea" :rows="3" placeholder="请输入处理备注" />
        </el-form-item>
        <el-form-item label="失败退款" v-if="processForm.status === 'FAIL'">
          <el-switch v-model="processForm.refund" />
        </el-form-item>
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

<script setup name="AiTask">
import { getTask, handleTask, listTask } from "@/api/ai/task"
import { ElMessage } from "element-plus"
import { useRoute } from "vue-router"

const { proxy } = getCurrentInstance()
const route = useRoute()

const taskList = ref([])
const open = ref(false)
const processOpen = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const total = ref(0)
const detailRefreshTimer = ref()

const DETAIL_REFRESH_INTERVAL_MS = 5000

const detail = reactive({
  task: null,
  resultList: [],
  refunded: false
})

const data = reactive({
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    userId: undefined,
    taskNo: undefined,
    providerName: undefined,
    channelName: undefined,
    remoteModelName: undefined,
    taskType: undefined,
    status: undefined,
    processingOnly: undefined,
    requestRecorded: undefined,
    responseRecorded: undefined
  },
  processForm: {
    taskId: undefined,
    status: "RUNNING",
    failReason: "",
    remark: "",
    refund: true
  },
  rules: {
    status: [{ required: true, message: "处理状态不能为空", trigger: "change" }]
  }
})

const { queryParams, processForm, rules } = toRefs(data)

const detailAutoRefreshActive = computed(() => {
  return open.value && isTaskProcessing(detail.task?.status)
})

function getList() {
  loading.value = true
  listTask(queryParams.value).then(response => {
    taskList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function filterProcessing() {
  queryParams.value.pageNum = 1
  queryParams.value.status = undefined
  queryParams.value.processingOnly = "1"
  queryParams.value.requestRecorded = undefined
  queryParams.value.responseRecorded = undefined
  getList()
}

function resetQuery() {
  proxy.resetForm("queryRef")
  handleQuery()
}

function loadDetail(taskId, shouldOpen = false) {
  return getTask(taskId).then(response => {
    detail.task = response.task
    detail.resultList = response.resultList || []
    detail.refunded = !!response.refunded
    if (shouldOpen) {
      open.value = true
    }
    syncDetailAutoRefresh()
  })
}

function handleDetail(row) {
  loadDetail(row.taskId, true)
}

function handleOpenProcess(row) {
  processForm.value = {
    taskId: row.taskId,
    status: row.status || "RUNNING",
    failReason: row.failReason || "",
    remark: row.remark || "",
    refund: true
  }
  processOpen.value = true
  proxy?.resetForm?.("processRef")
}

function submitProcess() {
  proxy.$refs["processRef"].validate(valid => {
    if (valid) {
      handleTask(processForm.value).then(() => {
        proxy.$modal.msgSuccess("处理成功")
        processOpen.value = false
        if (open.value && detail.task?.taskId === processForm.value.taskId) {
          loadDetail(processForm.value.taskId)
        }
        getList()
      })
    }
  })
}

function refreshDetail() {
  if (!detail.task?.taskId) {
    return
  }
  loadDetail(detail.task.taskId)
}

function isTaskProcessing(status) {
  return ["PENDING", "WAITING", "RUNNING"].includes(status)
}

function stopDetailAutoRefresh() {
  if (detailRefreshTimer.value) {
    clearInterval(detailRefreshTimer.value)
    detailRefreshTimer.value = undefined
  }
}

function syncDetailAutoRefresh() {
  stopDetailAutoRefresh()
  if (!open.value || !isTaskProcessing(detail.task?.status) || !detail.task?.taskId) {
    return
  }
  detailRefreshTimer.value = setInterval(() => {
    if (!detail.task?.taskId || !open.value) {
      stopDetailAutoRefresh()
      return
    }
    loadDetail(detail.task.taskId)
  }, DETAIL_REFRESH_INTERVAL_MS)
}

function statusTagType(status) {
  if (status === "SUCCESS") return "success"
  if (status === "FAIL") return "danger"
  if (status === "WAITING") return "info"
  if (status === "RUNNING") return "warning"
  return "info"
}

function hasPayload(payload) {
  return !!(payload && String(payload).trim())
}

function formatPayload(payload) {
  if (!payload) {
    return "-"
  }
  try {
    return JSON.stringify(JSON.parse(payload), null, 2)
  } catch (error) {
    return payload
  }
}

function copyText(payload) {
  const text = formatPayload(payload)
  if (!text || text === "-") {
    ElMessage({ message: "没有可复制的内容", type: "warning", duration: 1500 })
    return
  }
  if (navigator.clipboard) {
    navigator.clipboard.writeText(text).then(() => {
      ElMessage({ message: "已复制", type: "success", duration: 1500 })
    })
    return
  }
  const textarea = document.createElement("textarea")
  textarea.value = text
  document.body.appendChild(textarea)
  textarea.select()
  document.execCommand("copy")
  document.body.removeChild(textarea)
  ElMessage({ message: "已复制", type: "success", duration: 1500 })
}

if (route.query.userId) {
  queryParams.value.userId = Number(route.query.userId)
}

if (route.query.taskNo) {
  queryParams.value.taskNo = route.query.taskNo
}

getList()

onBeforeUnmount(() => {
  stopDetailAutoRefresh()
})
</script>

<style scoped>
.detail-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  width: 100%;
}

.detail-actions {
  display: flex;
  align-items: center;
  gap: 8px;
}

.payload-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  margin-bottom: 8px;
}

.payload-pre {
  margin: 0;
  white-space: pre-wrap;
  word-break: break-all;
  font-family: Menlo, Consolas, monospace;
  font-size: 12px;
  line-height: 1.6;
}

.trace-cell {
  display: flex;
  gap: 8px;
  justify-content: center;
  flex-wrap: wrap;
}

.result-thumb {
  width: 56px;
  height: 56px;
  border-radius: 8px;
  border: 1px solid #e5e7eb;
}
</style>
