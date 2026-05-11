<template>
  <view class="page">
    <view class="header-card">
      <text class="label">当前算力</text>
      <text class="value">{{ wallet.balancePower ?? '--' }}</text>
    </view>

    <view class="section">
      <text class="title">算力流水</text>
      <view v-if="loading" class="state">加载中...</view>
      <view v-else-if="errorMessage" class="state error">{{ errorMessage }}</view>
      <view v-else class="flow-list">
        <view v-for="item in flows" :key="item.flowId" class="flow-item">
          <view>
            <text class="biz">{{ item.bizType }}</text>
            <text class="remark">{{ item.remark || '-' }}</text>
          </view>
          <view class="right">
            <text :class="item.changeType === 'GRANT' ? 'plus' : 'minus'">
              {{ item.changeType === 'GRANT' ? '+' : '-' }}{{ item.powerNum }}
            </text>
            <text class="time">{{ item.createTime }}</text>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { getWalletFlows, getWalletInfo } from '@/api/wallet'
import { requireLogin } from '@/utils/auth'

const wallet = ref({})
const flows = ref([])
const loading = ref(false)
const errorMessage = ref('')

async function loadData() {
  loading.value = true
  errorMessage.value = ''
  try {
    if (!requireLogin()) {
      loading.value = false
      return
    }
    const [walletRes, flowRes] = await Promise.all([
      getWalletInfo(),
      getWalletFlows({ pageNum: 1, pageSize: 20 })
    ])
    wallet.value = walletRes.data || {}
    flows.value = flowRes.rows || []
  } catch (error) {
    errorMessage.value = error.message || '加载失败'
  } finally {
    loading.value = false
  }
}

onLoad(loadData)
</script>

<style lang="scss">
.page {
  min-height: 100vh;
  padding: 24rpx;
  background: #0f1020;
  color: #fff;
}

.header-card,
.flow-item {
  background: #1a1d35;
  border-radius: 20rpx;
}

.header-card {
  padding: 32rpx 24rpx;
}

.label {
  display: block;
  font-size: 28rpx;
  color: #9aa0c8;
}

.value {
  display: block;
  margin-top: 12rpx;
  font-size: 56rpx;
  font-weight: 700;
}

.section {
  margin-top: 32rpx;
}

.title {
  display: block;
  margin-bottom: 20rpx;
  font-size: 32rpx;
  font-weight: 600;
}

.flow-list {
  display: flex;
  flex-direction: column;
  gap: 16rpx;
}

.flow-item {
  display: flex;
  justify-content: space-between;
  gap: 20rpx;
  padding: 22rpx;
}

.biz {
  display: block;
  font-size: 28rpx;
  font-weight: 600;
}

.remark {
  display: block;
  margin-top: 8rpx;
  font-size: 24rpx;
  color: #aeb3d1;
}

.right {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
}

.plus {
  color: #78e08f;
}

.minus {
  color: #ff9f68;
}

.time,
.state {
  margin-top: 8rpx;
  font-size: 22rpx;
  color: #9aa0c8;
}

.error {
  color: #ff8a8a;
}
</style>
