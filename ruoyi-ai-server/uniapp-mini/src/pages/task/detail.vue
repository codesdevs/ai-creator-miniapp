<template>
  <scroll-view class="page" scroll-y>
    <view v-if="task" class="hero-card">
      <view class="hero-top">
        <view>
          <text class="hero-title">{{ task.modelName || '任务详情' }}</text>
          <text class="hero-sub">{{ task.versionName || '-' }}</text>
        </view>
        <view :class="['status-pill', statusClass(task.status)]">
          {{ statusText(task.status) }}
        </view>
      </view>
      <text class="hero-no">任务编号：{{ task.taskNo }}</text>
      <text class="hero-remark">{{ task.remark || '任务已创建，等待执行结果。' }}</text>
      <view class="progress-card">
        <view
          v-for="item in progressSteps"
          :key="item.value"
          :class="['progress-item', item.active ? 'active' : '', item.done ? 'done' : '']"
        >
          <view class="progress-dot">{{ item.done ? '✓' : item.index }}</view>
          <text class="progress-text">{{ item.label }}</text>
        </view>
      </view>
      <text v-if="polling" class="hero-tip">状态自动刷新中，生成完成后会展示结果图片。</text>
      <view v-if="task.failReason" class="fail-box">
        <text class="fail-label">失败原因</text>
        <text class="fail-text">{{ task.failReason }}</text>
        <text class="refund-text">{{ refunded ? '本次失败任务对应算力已退回。' : '退款处理中，请稍后刷新查看。' }}</text>
      </view>
    </view>

    <view class="info-card" v-if="task">
      <view class="info-row">
        <text class="info-label">创作模式</text>
        <text class="info-value">{{ formatMode(task.createMode) }}</text>
      </view>
      <view class="info-row">
        <text class="info-label">画面比例</text>
        <text class="info-value">{{ task.ratioCode || '-' }}</text>
      </view>
      <view class="info-row">
        <text class="info-label">风格</text>
        <text class="info-value">{{ task.styleCode || '-' }}</text>
      </view>
      <view class="info-row">
        <text class="info-label">算力消耗</text>
        <text class="info-value">{{ task.powerCost || 0 }}</text>
      </view>
      <view class="info-row">
        <text class="info-label">提交时间</text>
        <text class="info-value">{{ task.submitTime || '-' }}</text>
      </view>
      <view class="info-row" v-if="task.finishTime">
        <text class="info-label">完成时间</text>
        <text class="info-value">{{ task.finishTime }}</text>
      </view>
    </view>

    <view class="prompt-card" v-if="task">
      <text class="card-title">提示词</text>
      <text class="prompt-text">{{ task.promptText || '-' }}</text>
      <text class="card-title muted">反向提示词</text>
      <text class="prompt-text">{{ task.negativePrompt || '-' }}</text>
    </view>

    <view class="section">
      <view class="section-head">
        <text class="section-title">结果列表</text>
        <text v-if="polling" class="polling-tip">自动刷新中</text>
      </view>

      <view v-if="loading" class="state">加载中...</view>
      <view v-else-if="errorMessage" class="state error">{{ errorMessage }}</view>
      <view v-else-if="!results.length" class="empty-card">
        <text class="empty-title">{{ emptyTitle }}</text>
        <text class="empty-desc">{{ emptyDesc }}</text>
      </view>
      <view v-else class="result-list">
        <view v-for="item in results" :key="item.resultId" class="result-card">
          <image
            v-if="item.coverUrl || item.fileUrl"
            class="result-image"
            :src="item.coverUrl || item.fileUrl"
            mode="aspectFill"
            @tap="previewResult(item)"
          />
          <view class="result-meta">
            <text class="result-type">{{ item.resultType || 'IMAGE' }}</text>
            <text class="result-size">
              {{ item.width && item.height ? `${item.width} x ${item.height}` : '尺寸未知' }}
            </text>
          </view>
          <text class="result-url">{{ item.fileUrl || '-' }}</text>
          <view class="result-actions">
            <text class="result-link" @tap="previewResult(item)">预览大图</text>
            <text class="result-link" @tap="saveResult(item)">保存图片</text>
            <text class="result-link primary" @tap="createAgain">再次创作</text>
          </view>
        </view>
      </view>
    </view>

    <view class="action-row" v-if="task?.modelId">
      <button class="secondary-btn" @tap="reload">刷新状态</button>
      <button class="primary-btn" @tap="createAgain">再次创作</button>
    </view>
  </scroll-view>
</template>

<script setup>
import { computed, ref } from 'vue'
import { onLoad, onShow, onUnload } from '@dcloudio/uni-app'
import { getTaskDetail } from '@/api/task'
import { requireLogin } from '@/utils/auth'

const taskId = ref()
const task = ref(null)
const results = ref([])
const loading = ref(false)
const errorMessage = ref('')
const polling = ref(false)
const refunded = ref(false)
let pollTimer = null

const emptyTitle = computed(() => {
  if (!task.value) {
    return '暂无结果'
  }
  if (['PENDING', 'WAITING', 'RUNNING'].includes(task.value.status)) {
    return '结果生成中'
  }
  if (task.value.status === 'FAIL') {
    return '任务执行失败'
  }
  return '当前没有结果文件'
})

const emptyDesc = computed(() => {
  if (!task.value) {
    return '请稍后再试。'
  }
  if (task.value.status === 'WAITING') {
    return '任务已经入队，后台正在调度渠道执行。'
  }
  if (task.value.status === 'RUNNING') {
    return '模型已经开始处理，请等待结果回传。'
  }
  if (task.value.status === 'PENDING') {
    return '任务已创建，等待进入执行队列。'
  }
  if (task.value.status === 'FAIL') {
    return task.value.failReason || '请调整提示词或模型版本后重新提交。'
  }
  return '结果文件将在任务完成后展示。'
})

const progressSteps = computed(() => {
  const status = task.value?.status
  const current = status === 'SUCCESS' ? 3 : status === 'FAIL' ? 3 : status === 'RUNNING' ? 2 : status === 'WAITING' ? 1 : 0
  return [
    { index: 1, value: 'WAITING', label: '已提交', done: current >= 1, active: current === 1 },
    { index: 2, value: 'RUNNING', label: '生成中', done: current >= 2, active: current === 2 },
    { index: 3, value: status === 'FAIL' ? 'FAIL' : 'SUCCESS', label: status === 'FAIL' ? '执行失败' : '生成完成', done: current >= 3, active: current === 3 }
  ]
})

function statusText(status) {
  const map = {
    PENDING: '待执行',
    WAITING: '排队中',
    RUNNING: '生成中',
    SUCCESS: '已完成',
    FAIL: '失败'
  }
  return map[status] || status || '未知'
}

function statusClass(status) {
  const map = {
    PENDING: 'pending',
    WAITING: 'pending',
    RUNNING: 'running',
    SUCCESS: 'success',
    FAIL: 'fail'
  }
  return map[status] || 'pending'
}

function formatMode(mode) {
  const map = {
    TEXT_TO_IMAGE: '文生图',
    IMAGE_TO_IMAGE: '图生图'
  }
  return map[mode] || mode || '-'
}

function clearPolling() {
  if (pollTimer) {
    clearTimeout(pollTimer)
    pollTimer = null
  }
  polling.value = false
}

function schedulePolling() {
  clearPolling()
  if (!task.value || !['PENDING', 'WAITING', 'RUNNING'].includes(task.value.status)) {
    return
  }
  polling.value = true
  pollTimer = setTimeout(() => {
    loadTask(false)
  }, 4000)
}

async function loadTask(showLoading = true) {
  if (!requireLogin()) {
    return
  }
  if (showLoading) {
    loading.value = true
  }
  errorMessage.value = ''
  try {
    const res = await getTaskDetail(taskId.value)
    task.value = res.task || null
    results.value = res.resultList || []
    refunded.value = !!res.refunded
    schedulePolling()
  } catch (error) {
    clearPolling()
    errorMessage.value = error.message || '加载失败'
  } finally {
    loading.value = false
  }
}

function reload() {
  loadTask(true)
}

function createAgain() {
  if (!task.value?.modelId) {
    return
  }
  uni.navigateTo({
    url: `/pages/create/image?modelId=${task.value.modelId}&sourceTaskId=${task.value.taskId}`
  })
}

function previewResult(item) {
  const current = item?.fileUrl || item?.coverUrl
  const urls = results.value
    .map((result) => result.fileUrl || result.coverUrl)
    .filter(Boolean)
  if (!current || !urls.length) {
    return
  }
  uni.previewImage({
    current,
    urls
  })
}

function saveResult(item) {
  const url = item?.fileUrl || item?.coverUrl
  if (!url) {
    uni.showToast({ title: '当前图片不可保存', icon: 'none' })
    return
  }
  uni.showLoading({ title: '保存中...' })
  uni.downloadFile({
    url,
    success: (downloadRes) => {
      if (downloadRes.statusCode !== 200 || !downloadRes.tempFilePath) {
        uni.hideLoading()
        uni.showToast({ title: '下载失败', icon: 'none' })
        return
      }
      uni.saveImageToPhotosAlbum({
        filePath: downloadRes.tempFilePath,
        success: () => {
          uni.hideLoading()
          uni.showToast({ title: '已保存到相册', icon: 'none' })
        },
        fail: () => {
          uni.hideLoading()
          uni.showToast({ title: '保存失败，请检查相册权限', icon: 'none' })
        }
      })
    },
    fail: () => {
      uni.hideLoading()
      uni.showToast({ title: '下载失败', icon: 'none' })
    }
  })
}

onLoad((options) => {
  taskId.value = Number(options.taskId)
  loadTask(true)
})

onShow(() => {
  if (taskId.value) {
    loadTask(false)
  }
})

onUnload(() => {
  clearPolling()
})
</script>

<style lang="scss">
.page {
  min-height: 100vh;
  padding: 24rpx 24rpx 40rpx;
  background: #0d1121;
  color: #fff;
}

.hero-card,
.info-card,
.prompt-card,
.result-card,
.empty-card {
  border-radius: 24rpx;
  background: linear-gradient(180deg, #1b223d 0%, #13192d 100%);
}

.hero-card,
.info-card,
.prompt-card,
.empty-card {
  padding: 28rpx;
}

.hero-top,
.info-row,
.result-meta,
.action-row,
.section-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16rpx;
}

.hero-title {
  display: block;
  font-size: 36rpx;
  font-weight: 700;
}

.hero-sub,
.hero-no,
.hero-remark {
  display: block;
}

.hero-sub {
  margin-top: 8rpx;
  color: #9da9d8;
  font-size: 24rpx;
}

.hero-no {
  margin-top: 18rpx;
  color: #8fa0d7;
  font-size: 24rpx;
}

.hero-remark {
  margin-top: 14rpx;
  color: #d4daf4;
  font-size: 25rpx;
  line-height: 1.7;
}

.hero-tip {
  display: block;
  margin-top: 16rpx;
  color: #93a7e8;
  font-size: 22rpx;
}

.progress-card {
  display: flex;
  justify-content: space-between;
  gap: 12rpx;
  margin-top: 20rpx;
}

.progress-item {
  flex: 1;
  padding: 18rpx 12rpx;
  border-radius: 18rpx;
  background: rgba(255, 255, 255, 0.04);
  text-align: center;
}

.progress-item.active {
  background: rgba(93, 129, 255, 0.18);
}

.progress-item.done {
  background: rgba(76, 217, 126, 0.14);
}

.progress-dot {
  display: inline-flex;
  width: 40rpx;
  height: 40rpx;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.08);
  font-size: 22rpx;
  font-weight: 700;
}

.progress-text {
  display: block;
  margin-top: 12rpx;
  font-size: 22rpx;
}

.status-pill {
  padding: 10rpx 18rpx;
  border-radius: 999rpx;
  font-size: 22rpx;
}

.status-pill.pending {
  background: rgba(255, 199, 84, 0.16);
  color: #ffca69;
}

.status-pill.running {
  background: rgba(91, 139, 255, 0.16);
  color: #8fb0ff;
}

.status-pill.success {
  background: rgba(76, 217, 126, 0.16);
  color: #77e39f;
}

.status-pill.fail {
  background: rgba(255, 120, 120, 0.16);
  color: #ff9999;
}

.fail-box {
  margin-top: 20rpx;
  padding: 20rpx;
  border-radius: 18rpx;
  background: rgba(255, 120, 120, 0.08);
}

.fail-label {
  display: block;
  color: #ff9e9e;
  font-size: 22rpx;
}

.fail-text {
  display: block;
  margin-top: 8rpx;
  color: #ffd0d0;
  font-size: 24rpx;
  line-height: 1.6;
}

.refund-text {
  display: block;
  margin-top: 12rpx;
  color: #ffdf9d;
  font-size: 23rpx;
  line-height: 1.6;
}

.info-card,
.prompt-card,
.section,
.action-row {
  margin-top: 20rpx;
}

.info-label {
  color: #98a5d5;
  font-size: 24rpx;
}

.info-value {
  max-width: 60%;
  text-align: right;
  color: #eef1ff;
  font-size: 24rpx;
}

.info-row + .info-row {
  margin-top: 18rpx;
}

.card-title {
  display: block;
  font-size: 28rpx;
  font-weight: 700;
}

.card-title.muted {
  margin-top: 24rpx;
  color: #a1add7;
  font-size: 24rpx;
}

.prompt-text {
  display: block;
  margin-top: 14rpx;
  color: #d4daf4;
  font-size: 26rpx;
  line-height: 1.7;
}

.section-title {
  font-size: 30rpx;
  font-weight: 700;
}

.polling-tip {
  color: #8fa1dc;
  font-size: 22rpx;
}

.result-list {
  display: flex;
  flex-direction: column;
  gap: 18rpx;
  margin-top: 18rpx;
}

.result-card {
  overflow: hidden;
}

.result-image {
  width: 100%;
  height: 420rpx;
  background: #0e1325;
}

.result-meta,
.result-url {
  padding: 0 24rpx;
}

.result-meta {
  margin-top: 20rpx;
}

.result-type {
  font-size: 26rpx;
  font-weight: 600;
}

.result-size {
  color: #98a5d5;
  font-size: 22rpx;
}

.result-url {
  display: block;
  margin-top: 10rpx;
  padding-bottom: 24rpx;
  color: #cfd6f0;
  font-size: 22rpx;
  line-height: 1.6;
  word-break: break-all;
}

.result-actions {
  display: flex;
  justify-content: flex-end;
  gap: 24rpx;
  padding: 0 24rpx 24rpx;
}

.result-link {
  color: #9fb0ef;
  font-size: 23rpx;
}

.result-link.primary {
  color: #7ea8ff;
}

.empty-title {
  display: block;
  font-size: 30rpx;
  font-weight: 700;
}

.empty-desc {
  display: block;
  margin-top: 14rpx;
  color: #bcc7ef;
  font-size: 24rpx;
  line-height: 1.7;
}

.state {
  padding: 32rpx 0;
  color: #afbadf;
  font-size: 26rpx;
}

.error {
  color: #ff9797;
}

.action-row {
  display: flex;
  gap: 16rpx;
}

.primary-btn,
.secondary-btn {
  flex: 1;
  border: none;
  border-radius: 999rpx;
  font-size: 26rpx;
}

.primary-btn {
  background: linear-gradient(135deg, #4d38d6 0%, #2f7cff 100%);
  color: #fff;
}

.secondary-btn {
  background: #202741;
  color: #d3dcff;
}
</style>
