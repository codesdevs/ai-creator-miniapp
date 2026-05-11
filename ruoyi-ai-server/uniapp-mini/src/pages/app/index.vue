<template>
  <scroll-view class="page" scroll-y>
    <view class="topbar">
      <text class="title">模型中心</text>
      <text class="sub">按业务能力挑模型，不按底层表结构找入口。</text>
    </view>

    <view class="guide-card">
      <view class="guide-item">
        <text class="guide-step">1</text>
        <text class="guide-text">先选模型</text>
      </view>
      <view class="guide-item">
        <text class="guide-step">2</text>
        <text class="guide-text">再选版本参数</text>
      </view>
      <view class="guide-item">
        <text class="guide-step">3</text>
        <text class="guide-text">提交任务看结果</text>
      </view>
    </view>

    <view class="filter-row">
      <view
        v-for="item in typeTabs"
        :key="item.value"
        :class="['filter-pill', activeType === item.value ? 'active' : '']"
        @tap="activeType = item.value"
      >
        {{ item.label }}
      </view>
    </view>

    <view v-if="loading" class="state">加载中...</view>
    <view v-else-if="errorMessage" class="state error">{{ errorMessage }}</view>
    <view v-else class="card-list">
      <view
        v-for="item in filteredModels"
        :key="item.modelId"
        class="card"
        @tap="goCreate(item)"
      >
        <view class="card-head">
          <view class="card-main">
            <text class="card-title">{{ item.modelName }}</text>
            <text class="card-sub">{{ item.providerName || item.provider || '未配置服务商' }}</text>
          </view>
          <text :class="['badge', item.modelType === 'VIDEO' ? 'video' : 'image']">
            {{ item.modelType === 'VIDEO' ? '视频' : '图片' }}
          </text>
        </view>
        <text class="card-desc">{{ item.intro || '暂无简介' }}</text>
        <view class="feature-row">
          <text class="feature-pill">{{ item.modelType === 'VIDEO' ? '多阶段接入' : '立即可创作' }}</text>
          <text class="feature-pill">{{ item.providerName || item.provider || '平台模型' }}</text>
        </view>
        <view class="card-foot">
          <text>{{ item.modelType === 'VIDEO' ? '视频能力后续接入' : '支持进入文生图创作页' }}</text>
          <text>›</text>
        </view>
      </view>
    </view>
  </scroll-view>
</template>

<script setup>
import { computed, ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { listModel } from '@/api/model'

const typeTabs = [
  { label: '全部', value: 'ALL' },
  { label: '图片', value: 'IMAGE' },
  { label: '视频', value: 'VIDEO' }
]

const loading = ref(false)
const errorMessage = ref('')
const models = ref([])
const activeType = ref('ALL')

const filteredModels = computed(() => {
  if (activeType.value === 'ALL') {
    return models.value
  }
  return models.value.filter((item) => item.modelType === activeType.value)
})

async function loadModels() {
  loading.value = true
  errorMessage.value = ''
  try {
    const [imageRes, videoRes] = await Promise.all([listModel('IMAGE'), listModel('VIDEO')])
    models.value = [...(imageRes.data || []), ...(videoRes.data || [])]
  } catch (error) {
    errorMessage.value = error.message || '加载失败'
  } finally {
    loading.value = false
  }
}

function goCreate(item) {
  if (item.modelType === 'VIDEO') {
    uni.showToast({ title: '视频模型下一阶段接入', icon: 'none' })
    return
  }
  uni.navigateTo({
    url: `/pages/create/image?modelId=${item.modelId}`
  })
}

onLoad(loadModels)
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

.guide-card {
  display: flex;
  gap: 14rpx;
  margin-top: 24rpx;
  padding: 22rpx;
  border-radius: 24rpx;
  background: linear-gradient(135deg, rgba(45, 59, 123, 0.9), rgba(27, 33, 61, 0.96));
}

.guide-item {
  flex: 1;
  padding: 20rpx;
  border-radius: 20rpx;
  background: rgba(10, 14, 27, 0.3);
}

.guide-step {
  display: inline-flex;
  width: 40rpx;
  height: 40rpx;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.12);
  color: #d9e0ff;
  font-size: 22rpx;
  font-weight: 700;
}

.guide-text {
  display: block;
  margin-top: 14rpx;
  color: #d7ddfa;
  font-size: 24rpx;
  line-height: 1.6;
}

.filter-row {
  display: flex;
  gap: 16rpx;
  margin-top: 26rpx;
  margin-bottom: 24rpx;
}

.filter-pill {
  padding: 12rpx 24rpx;
  border-radius: 999rpx;
  background: #171d33;
  color: #92a0cf;
  font-size: 24rpx;
}

.filter-pill.active {
  background: linear-gradient(135deg, #4e36d8 0%, #3384ff 100%);
  color: #fff;
}

.card-list {
  display: flex;
  flex-direction: column;
  gap: 18rpx;
}

.card {
  padding: 28rpx;
  border-radius: 24rpx;
  background: linear-gradient(180deg, #1b223d 0%, #13192d 100%);
}

.card-head,
.card-foot {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16rpx;
}

.card-main {
  flex: 1;
}

.card-title {
  display: block;
  font-size: 34rpx;
  font-weight: 700;
}

.card-sub {
  display: block;
  margin-top: 8rpx;
  color: #9da9d8;
  font-size: 24rpx;
}

.badge {
  padding: 8rpx 16rpx;
  border-radius: 999rpx;
  font-size: 22rpx;
}

.badge.image {
  background: rgba(110, 129, 224, 0.18);
  color: #9eb0ff;
}

.badge.video {
  background: rgba(91, 223, 193, 0.16);
  color: #8fe6d4;
}

.card-desc {
  display: block;
  margin-top: 20rpx;
  color: #d4daf4;
  font-size: 26rpx;
  line-height: 1.7;
}

.feature-row {
  display: flex;
  flex-wrap: wrap;
  gap: 12rpx;
  margin-top: 18rpx;
}

.feature-pill {
  padding: 10rpx 16rpx;
  border-radius: 999rpx;
  background: rgba(255, 255, 255, 0.06);
  color: #b8c5f0;
  font-size: 22rpx;
}

.card-foot {
  margin-top: 24rpx;
  color: #c9d4ff;
  font-size: 24rpx;
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
