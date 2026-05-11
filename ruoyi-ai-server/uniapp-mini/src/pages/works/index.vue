<template>
  <scroll-view class="page" scroll-y>
    <view class="topbar">
      <text class="title">我的作品</text>
      <text class="sub">查看已提交任务、生成状态和结果入口</text>
    </view>

    <view v-if="loading" class="state">加载中...</view>
    <view v-else-if="errorMessage" class="state error">{{ errorMessage }}</view>
    <view v-else-if="!tasks.length" class="empty-card">
      <text class="empty-title">还没有创作记录</text>
      <text class="empty-desc">先去模型中心选一个模型，提交你的第一条任务。</text>
      <button class="empty-btn" @tap="goAppCenter">去创作</button>
    </view>
    <view v-else class="task-list">
      <view
        v-for="item in tasks"
        :key="item.taskId"
        class="task-card"
      >
        <view class="task-main" @tap="goDetail(item.taskId)">
          <view class="task-head">
            <view>
              <text class="task-model">{{ item.modelName || '未命名模型' }}</text>
              <text class="task-version">{{ item.versionName || '-' }}</text>
            </view>
            <view :class="['status-pill', statusClass(item.status)]">
              {{ statusText(item.status) }}
            </view>
          </view>
          <view>
            <text class="task-prompt">{{ item.promptText || '未填写提示词' }}</text>
            <view class="task-meta">
              <text>{{ formatMode(item.createMode) }}</text>
              <text>{{ item.powerCost || 0 }} 算力</text>
              <text>{{ item.submitTime || '-' }}</text>
            </view>
          </view>
        </view>
        <view class="task-actions">
          <text class="task-link" @tap.stop="goDetail(item.taskId)">查看详情</text>
          <text
            v-if="item.status === 'FAIL'"
            class="task-link warn"
            @tap.stop="repeatCreate(item)"
          >
            原参数重试
          </text>
          <text
            v-else-if="item.status === 'SUCCESS'"
            class="task-link primary"
            @tap.stop="repeatCreate(item)"
          >
            同款再来
          </text>
        </view>
      </view>
    </view>
  </scroll-view>
</template>

<script setup>
import { ref } from 'vue'
import { onLoad, onShow } from '@dcloudio/uni-app'
import { getMyTaskList } from '@/api/task'
import { requireLogin } from '@/utils/auth'

const loading = ref(false)
const errorMessage = ref('')
const tasks = ref([])

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

async function loadData() {
  if (!requireLogin()) {
    return
  }
  loading.value = true
  errorMessage.value = ''
  try {
    const res = await getMyTaskList()
    tasks.value = res.data || []
  } catch (error) {
    errorMessage.value = error.message || '加载失败'
  } finally {
    loading.value = false
  }
}

function goDetail(taskId) {
  uni.navigateTo({
    url: `/pages/task/detail?taskId=${taskId}`
  })
}

function goAppCenter() {
  uni.switchTab({ url: '/pages/app/index' })
}

function repeatCreate(item) {
  if (!item?.modelId || !item?.taskId) {
    return
  }
  uni.navigateTo({
    url: `/pages/create/image?modelId=${item.modelId}&sourceTaskId=${item.taskId}`
  })
}

onLoad(loadData)
onShow(loadData)
</script>

<style lang="scss">
.page {
  min-height: 100vh;
  padding: 26rpx 24rpx 40rpx;
  background: #0d1121;
  color: #fff;
}

.topbar {
  padding: 10rpx 4rpx 0;
}

.title {
  display: block;
  font-size: 40rpx;
  font-weight: 700;
}

.sub {
  display: block;
  margin-top: 10rpx;
  color: #99a6d3;
  font-size: 25rpx;
}

.task-list {
  display: flex;
  flex-direction: column;
  gap: 18rpx;
  margin-top: 24rpx;
}

.task-card,
.empty-card {
  padding: 28rpx;
  border-radius: 24rpx;
  background: linear-gradient(180deg, #1b223d 0%, #13192d 100%);
}

.task-main {
  display: block;
}

.task-head,
.task-meta {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16rpx;
}

.task-model {
  display: block;
  font-size: 32rpx;
  font-weight: 700;
}

.task-version {
  display: block;
  margin-top: 8rpx;
  color: #9da9d8;
  font-size: 24rpx;
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

.task-prompt {
  display: block;
  margin-top: 20rpx;
  color: #d4daf4;
  font-size: 26rpx;
  line-height: 1.7;
}

.task-meta {
  margin-top: 22rpx;
  color: #a9b4dd;
  font-size: 22rpx;
  flex-wrap: wrap;
}

.task-actions {
  display: flex;
  justify-content: flex-end;
  gap: 24rpx;
  margin-top: 22rpx;
  padding-top: 18rpx;
  border-top: 1rpx solid rgba(255, 255, 255, 0.06);
}

.task-link {
  color: #9fb0ef;
  font-size: 24rpx;
}

.task-link.primary {
  color: #7ea8ff;
}

.task-link.warn {
  color: #efb44e;
}

.empty-title {
  display: block;
  font-size: 32rpx;
  font-weight: 700;
}

.empty-desc {
  display: block;
  margin-top: 14rpx;
  color: #9eabd8;
  font-size: 25rpx;
  line-height: 1.7;
}

.empty-btn {
  margin-top: 24rpx;
  border: none;
  border-radius: 999rpx;
  background: linear-gradient(135deg, #4d38d6 0%, #3578ff 100%);
  color: #fff;
}

.state {
  padding: 30rpx 0;
  color: #afbadf;
  font-size: 26rpx;
}

.error {
  color: #ff9797;
}
</style>
