<template>
  <scroll-view class="page" scroll-y>
    <view class="hero">
      <view>
        <text class="hero-eyebrow">AI Creator</text>
        <text class="hero-title">把灵感直接变成可交付画面</text>
        <text class="hero-desc">先选模型，再带着推荐参数进入创作页，减少试错成本。</text>
      </view>
      <view class="hero-badge">Phase 2</view>
    </view>

    <view class="wallet-card" @tap="goAssets">
      <view>
        <text class="wallet-label">当前算力</text>
        <text class="wallet-value">{{ isLoggedIn() ? wallet.balancePower ?? 0 : '--' }}</text>
      </view>
      <text class="wallet-tip">{{ isLoggedIn() ? '查看流水' : '登录后查看余额' }}</text>
    </view>

    <view class="section">
      <view class="section-head">
        <text class="section-title">推荐模型</text>
        <text class="section-link" @tap="goAppCenter">查看全部</text>
      </view>
      <view v-if="loading" class="state">加载中...</view>
      <view v-else-if="errorMessage" class="state error">{{ errorMessage }}</view>
      <view v-else class="featured-list">
        <view
          v-for="item in featuredModels"
          :key="item.modelId"
          class="featured-card"
          @tap="goModel(item)"
        >
          <text class="featured-type">{{ item.modelType === 'VIDEO' ? '视频模型' : '图片模型' }}</text>
          <text class="featured-name">{{ item.modelName }}</text>
          <text class="featured-provider">{{ item.provider || '平台自定义模型' }}</text>
          <text class="featured-intro">{{ item.intro || '暂无模型介绍' }}</text>
          <view class="featured-action">
            <text>进入创作</text>
            <text>›</text>
          </view>
        </view>
      </view>
    </view>

    <view class="section">
      <view class="section-head">
        <text class="section-title">快捷入口</text>
      </view>
      <view class="shortcut-grid">
        <view class="shortcut-card accent" @tap="goAppCenter">
          <text class="shortcut-title">模型中心</text>
          <text class="shortcut-desc">查看全部模型和能力分类</text>
        </view>
        <view class="shortcut-card" @tap="goAssets">
          <text class="shortcut-title">算力资产</text>
          <text class="shortcut-desc">查看余额和消耗流水</text>
        </view>
      </view>
    </view>
  </scroll-view>
</template>

<script setup>
import { computed, ref } from 'vue'
import { onLoad, onShow } from '@dcloudio/uni-app'
import { listModel } from '@/api/model'
import { getWalletInfo } from '@/api/wallet'
import { isLoggedIn } from '@/utils/auth'

const loading = ref(false)
const errorMessage = ref('')
const models = ref([])
const wallet = ref({})

const featuredModels = computed(() => models.value.slice(0, 3))

async function loadModels() {
  const [imageRes, videoRes] = await Promise.all([listModel('IMAGE'), listModel('VIDEO')])
  const imageModels = imageRes.data || []
  const videoModels = videoRes.data || []
  models.value = [...imageModels, ...videoModels]
}

async function loadWallet() {
  if (!isLoggedIn()) {
    wallet.value = {}
    return
  }
  const res = await getWalletInfo()
  wallet.value = res.data || {}
}

async function loadData() {
  loading.value = true
  errorMessage.value = ''
  try {
    await Promise.all([loadModels(), loadWallet()])
  } catch (error) {
    errorMessage.value = error.message || '加载失败'
  } finally {
    loading.value = false
  }
}

function goAppCenter() {
  uni.switchTab({ url: '/pages/app/index' })
}

function goAssets() {
  uni.switchTab({ url: '/pages/assets/index' })
}

function goModel(item) {
  if (item.modelType === 'VIDEO') {
    uni.showToast({ title: '视频创作下一阶段接入', icon: 'none' })
    return
  }
  uni.navigateTo({
    url: `/pages/create/image?modelId=${item.modelId}`
  })
}

onLoad(loadData)
onShow(loadWallet)
</script>

<style lang="scss">
.page {
  min-height: 100vh;
  padding: 28rpx 24rpx 40rpx;
  background:
    radial-gradient(circle at top right, rgba(134, 92, 255, 0.28), transparent 32%),
    linear-gradient(180deg, #0c1020 0%, #13172a 100%);
  color: #fff;
}

.hero,
.wallet-card,
.featured-card,
.shortcut-card {
  border-radius: 28rpx;
}

.hero {
  display: flex;
  justify-content: space-between;
  gap: 24rpx;
  padding: 32rpx 30rpx;
  background: linear-gradient(135deg, #1a2347 0%, #11182e 55%, #281452 100%);
  box-shadow: 0 24rpx 60rpx rgba(5, 10, 30, 0.35);
}

.hero-eyebrow {
  display: block;
  color: #8aa4ff;
  font-size: 22rpx;
  letter-spacing: 4rpx;
  text-transform: uppercase;
}

.hero-title {
  display: block;
  margin-top: 18rpx;
  font-size: 48rpx;
  font-weight: 700;
  line-height: 1.2;
}

.hero-desc {
  display: block;
  margin-top: 18rpx;
  color: #b7c0e4;
  font-size: 26rpx;
  line-height: 1.7;
}

.hero-badge {
  flex: 0 0 auto;
  height: fit-content;
  padding: 10rpx 18rpx;
  border: 1rpx solid rgba(255, 255, 255, 0.15);
  border-radius: 999rpx;
  background: rgba(255, 255, 255, 0.06);
  color: #dcd6ff;
  font-size: 22rpx;
}

.wallet-card {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: 24rpx;
  padding: 28rpx 30rpx;
  background: linear-gradient(135deg, #f6c46a 0%, #f08a4b 100%);
  color: #23160f;
}

.wallet-label {
  display: block;
  font-size: 24rpx;
  opacity: 0.78;
}

.wallet-value {
  display: block;
  margin-top: 8rpx;
  font-size: 54rpx;
  font-weight: 700;
}

.wallet-tip {
  font-size: 24rpx;
}

.section {
  margin-top: 34rpx;
}

.section-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 20rpx;
}

.section-title {
  font-size: 34rpx;
  font-weight: 700;
}

.section-link {
  color: #90a4ff;
  font-size: 24rpx;
}

.featured-list,
.shortcut-grid {
  display: flex;
  flex-direction: column;
  gap: 18rpx;
}

.featured-card {
  padding: 28rpx;
  background: linear-gradient(180deg, rgba(30, 39, 71, 0.96), rgba(18, 24, 45, 0.96));
  border: 1rpx solid rgba(115, 136, 218, 0.14);
}

.featured-type {
  display: inline-flex;
  width: fit-content;
  padding: 8rpx 14rpx;
  border-radius: 999rpx;
  background: rgba(147, 173, 255, 0.12);
  color: #93adff;
  font-size: 22rpx;
}

.featured-name {
  display: block;
  margin-top: 18rpx;
  font-size: 36rpx;
  font-weight: 700;
}

.featured-provider {
  display: block;
  margin-top: 8rpx;
  color: #98a6d8;
  font-size: 24rpx;
}

.featured-intro {
  display: block;
  margin-top: 18rpx;
  color: #d5dcf5;
  font-size: 26rpx;
  line-height: 1.7;
}

.featured-action {
  display: flex;
  justify-content: space-between;
  margin-top: 24rpx;
  color: #fff;
  font-size: 26rpx;
}

.shortcut-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
}

.shortcut-card {
  padding: 26rpx;
  background: #191f38;
}

.shortcut-card.accent {
  background: linear-gradient(135deg, #5031c7 0%, #2354dd 100%);
}

.shortcut-title {
  display: block;
  font-size: 30rpx;
  font-weight: 700;
}

.shortcut-desc {
  display: block;
  margin-top: 12rpx;
  color: rgba(255, 255, 255, 0.78);
  font-size: 24rpx;
  line-height: 1.6;
}

.state {
  padding: 24rpx 0;
  color: #aeb8de;
  font-size: 26rpx;
}

.error {
  color: #ff9696;
}
</style>
