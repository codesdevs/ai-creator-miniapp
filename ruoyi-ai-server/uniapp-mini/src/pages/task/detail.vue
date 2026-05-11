<template>
  <view class="page">
    <view class="card" v-if="task">
      <text class="title">{{ task.taskNo }}</text>
      <text class="item">状态：{{ task.status }}</text>
      <text class="item">模型：{{ task.modelName || '-' }}</text>
      <text class="item">版本：{{ task.versionName || '-' }}</text>
      <text class="item">算力：{{ task.powerCost || 0 }}</text>
      <text class="item">提示词：{{ task.promptText || '-' }}</text>
      <text class="item">备注：{{ task.remark || '-' }}</text>
    </view>

    <view class="section">
      <text class="section-title">结果列表</text>
      <view v-if="!results.length" class="empty">当前没有结果文件</view>
      <view v-for="item in results" :key="item.resultId" class="result-card">
        <text>类型：{{ item.resultType }}</text>
        <text>文件：{{ item.fileUrl || '-' }}</text>
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { getTaskDetail } from '@/api/task'
import { requireLogin } from '@/utils/auth'

const task = ref(null)
const results = ref([])

async function loadTask(taskId) {
  if (!requireLogin()) {
    return
  }
  const res = await getTaskDetail(taskId)
  task.value = res.task || null
  results.value = res.resultList || []
}

onLoad((options) => {
  loadTask(options.taskId).catch((error) => {
    uni.showToast({ title: error.message || '加载失败', icon: 'none' })
  })
})
</script>

<style lang="scss">
.page {
  min-height: 100vh;
  padding: 24rpx;
  background: #0f1020;
  color: #fff;
}

.card,
.result-card {
  padding: 24rpx;
  border-radius: 20rpx;
  background: #1a1d35;
}

.title {
  display: block;
  margin-bottom: 16rpx;
  font-size: 32rpx;
  font-weight: 600;
}

.item {
  display: block;
  margin-top: 8rpx;
  color: #d1d6ef;
  font-size: 26rpx;
}

.section {
  margin-top: 28rpx;
}

.section-title {
  display: block;
  margin-bottom: 16rpx;
  font-size: 30rpx;
  font-weight: 600;
}

.result-card {
  margin-top: 16rpx;
}

.empty {
  color: #9aa0c8;
}
</style>
