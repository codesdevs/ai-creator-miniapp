<template>
  <scroll-view class="page" scroll-y>
    <view class="topbar">
      <text class="title">模型中心</text>
      <text class="sub">按模型类型挑选最合适的创作能力</text>
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
          <view>
            <text class="card-title">{{ item.modelName }}</text>
            <text class="card-sub">{{ item.provider || '未配置服务商' }}</text>
          </view>
          <text class="badge">{{ item.modelType === 'VIDEO' ? '视频' : '图片' }}</text>
        </view>
        <text class="card-desc">{{ item.intro || '暂无简介' }}</text>
        <view class="card-foot">
          <text>{{ item.modelType === 'VIDEO' ? '视频能力后续接入' : '支持立即创作' }}</text>
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
  background: rgba(110, 129, 224, 0.18);
  color: #9eb0ff;
  font-size: 22rpx;
}

.card-desc {
  display: block;
  margin-top: 20rpx;
  color: #d4daf4;
  font-size: 26rpx;
  line-height: 1.7;
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
