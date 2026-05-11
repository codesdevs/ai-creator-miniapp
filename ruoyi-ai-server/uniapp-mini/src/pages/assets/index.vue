<template>
  <scroll-view class="page" scroll-y>
    <view class="hero-card">
      <view class="hero-top">
        <view>
          <text class="hero-label">可用算力</text>
          <text class="hero-value">{{ wallet.balancePower ?? 0 }}</text>
        </view>
        <view class="hero-badge">Wallet</view>
      </view>
      <text class="hero-desc">创作任务会消耗算力，失败任务在开发态会自动退回。</text>
    </view>

    <view class="stats-grid">
      <view class="stat-card">
        <text class="stat-label">冻结算力</text>
        <text class="stat-value">{{ wallet.freezePower ?? 0 }}</text>
      </view>
      <view class="stat-card">
        <text class="stat-label">累计消耗</text>
        <text class="stat-value">{{ wallet.totalConsumePower ?? 0 }}</text>
      </view>
      <view class="stat-card">
        <text class="stat-label">累计赠送</text>
        <text class="stat-value">{{ wallet.totalGivePower ?? 0 }}</text>
      </view>
      <view class="stat-card">
        <text class="stat-label">累计充值</text>
        <text class="stat-value">{{ wallet.totalRechargePower ?? 0 }}</text>
      </view>
    </view>

    <view class="action-card">
      <view class="action-head">
        <view>
          <text class="action-title">充值套餐</text>
          <text class="action-desc">当前下单后需在后台手动处理为已支付，用于联调充值到账链路。</text>
        </view>
        <text class="action-badge">DEV</text>
      </view>

      <view v-if="packageLoading" class="state">套餐加载中...</view>
      <view v-else-if="packageErrorMessage" class="state error">{{ packageErrorMessage }}</view>
      <view v-else-if="!packageList.length" class="state">暂无可用套餐</view>
      <view v-else class="package-list">
        <view
          v-for="item in packageList"
          :key="item.packageId"
          :class="['package-item', selectedPackageId === item.packageId ? 'active' : '']"
          @tap="selectedPackageId = item.packageId"
        >
          <view class="package-row">
            <text class="package-name">{{ item.packageName }}</text>
            <text class="package-price">¥{{ item.salePrice }}</text>
          </view>
          <view class="package-row sub">
            <text>{{ item.powerNum || 0 }} 算力</text>
            <text v-if="item.bonusPowerNum">赠送 {{ item.bonusPowerNum }} 算力</text>
            <text v-else>无赠送</text>
          </view>
          <text v-if="item.packageDesc" class="package-desc">{{ item.packageDesc }}</text>
        </view>
      </view>

      <button class="recharge-btn" :disabled="submitting || !selectedPackageId" @tap="handleRecharge">
        {{ submitting ? '提交中...' : '创建充值订单' }}
      </button>
    </view>

    <view class="section">
      <view class="section-head">
        <text class="title">充值订单</text>
        <text class="filter-hint">最近记录</text>
      </view>

      <view v-if="orderLoading" class="state">订单加载中...</view>
      <view v-else-if="orderErrorMessage" class="state error">{{ orderErrorMessage }}</view>
      <view v-else-if="!orderList.length" class="empty-card">
        <text class="empty-title">暂无充值订单</text>
        <text class="empty-desc">选中套餐后创建第一笔充值订单。</text>
      </view>
      <view v-else class="flow-list">
        <view v-for="item in orderList" :key="item.orderId" class="flow-item">
          <view class="flow-main">
            <view>
              <text class="biz">{{ item.packageName || '充值订单' }}</text>
              <text class="remark">{{ item.orderNo }}</text>
            </view>
            <view class="right">
              <text class="plus">+{{ (item.powerNum || 0) + (item.bonusPowerNum || 0) }}</text>
              <text :class="orderStatusClass(item.orderStatus)">{{ formatOrderStatus(item.orderStatus) }}</text>
            </view>
          </view>
          <view class="flow-foot">
            <text>{{ item.createTime }}</text>
            <text>¥{{ item.payAmount || 0 }}</text>
          </view>
        </view>
      </view>
    </view>

    <view class="section">
      <view class="section-head">
        <text class="title">算力流水</text>
        <text class="filter-hint">{{ currentFilter.label }}</text>
      </view>

      <scroll-view class="filter-row" scroll-x>
        <view
          v-for="item in filters"
          :key="item.value"
          :class="['filter-pill', activeFilter === item.value ? 'active' : '']"
          @tap="activeFilter = item.value"
        >
          {{ item.label }}
        </view>
      </scroll-view>

      <view v-if="loading" class="state">加载中...</view>
      <view v-else-if="errorMessage" class="state error">{{ errorMessage }}</view>
      <view v-else-if="!filteredFlows.length" class="empty-card">
        <text class="empty-title">暂无流水</text>
        <text class="empty-desc">当前筛选条件下还没有账本记录。</text>
      </view>
      <view v-else class="flow-list">
        <view v-for="item in filteredFlows" :key="item.flowId" class="flow-item">
          <view class="flow-main">
            <view>
              <text class="biz">{{ flowTitle(item) }}</text>
              <text class="remark">{{ flowRemark(item) }}</text>
            </view>
            <view class="right">
              <text :class="flowAmountClass(item)">{{ flowAmount(item) }}</text>
              <text class="balance">余额 {{ item.afterBalance ?? 0 }}</text>
            </view>
          </view>
          <view class="flow-foot">
            <text>{{ item.createTime }}</text>
            <text v-if="item.bizId">业务ID {{ item.bizId }}</text>
          </view>
        </view>
      </view>
    </view>
  </scroll-view>
</template>

<script setup>
import { computed, ref } from 'vue'
import { onLoad, onShow } from '@dcloudio/uni-app'
import { getMyRechargeOrderList, getRechargePackageList, submitRechargeOrder } from '@/api/order'
import { getWalletFlows, getWalletInfo } from '@/api/wallet'
import { requireLogin } from '@/utils/auth'

const wallet = ref({})
const flows = ref([])
const packageList = ref([])
const orderList = ref([])
const loading = ref(false)
const errorMessage = ref('')
const packageLoading = ref(false)
const packageErrorMessage = ref('')
const orderLoading = ref(false)
const orderErrorMessage = ref('')
const selectedPackageId = ref()
const submitting = ref(false)
const activeFilter = ref('ALL')

const filters = [
  { label: '全部', value: 'ALL' },
  { label: '收入', value: 'GRANT' },
  { label: '支出', value: 'CONSUME' }
]

const currentFilter = computed(() => filters.find((item) => item.value === activeFilter.value) || filters[0])

const filteredFlows = computed(() => {
  if (activeFilter.value === 'ALL') {
    return flows.value
  }
  return flows.value.filter((item) => item.changeType === activeFilter.value)
})

function flowTitle(item) {
  const map = {
    TASK_SUBMIT: '提交创作任务',
    TASK_REFUND: '任务失败退款',
    ADMIN_GRANT: '后台赠送算力',
    ORDER_RECHARGE: '充值订单到账'
  }
  return map[item.bizType] || item.bizType || '算力变动'
}

function flowRemark(item) {
  return item.remark || (item.changeType === 'GRANT' ? '算力入账' : '算力扣减')
}

function flowAmount(item) {
  const sign = item.changeType === 'GRANT' ? '+' : '-'
  return `${sign}${item.powerNum ?? 0}`
}

function flowAmountClass(item) {
  return item.changeType === 'GRANT' ? 'plus' : 'minus'
}

function formatOrderStatus(status) {
  if (status === 'WAIT_PAY') return '待支付'
  if (status === 'PAID') return '已支付'
  if (status === 'CLOSED') return '已关闭'
  if (status === 'REFUNDED') return '已退款'
  return status || '-'
}

function orderStatusClass(status) {
  if (status === 'PAID') return 'status status-success'
  if (status === 'WAIT_PAY') return 'status status-warning'
  if (status === 'REFUNDED') return 'status status-danger'
  return 'status'
}

async function loadPackages() {
  packageLoading.value = true
  packageErrorMessage.value = ''
  try {
    const res = await getRechargePackageList()
    packageList.value = res.data || []
    if (!selectedPackageId.value && packageList.value.length) {
      selectedPackageId.value = packageList.value[0].packageId
    }
  } catch (error) {
    packageErrorMessage.value = error.message || '套餐加载失败'
  } finally {
    packageLoading.value = false
  }
}

async function loadOrders() {
  orderLoading.value = true
  orderErrorMessage.value = ''
  try {
    const res = await getMyRechargeOrderList()
    orderList.value = (res.data || []).slice(0, 10)
  } catch (error) {
    orderErrorMessage.value = error.message || '订单加载失败'
  } finally {
    orderLoading.value = false
  }
}

async function handleRecharge() {
  if (!requireLogin() || !selectedPackageId.value || submitting.value) {
    return
  }
  submitting.value = true
  try {
    const res = await submitRechargeOrder({ packageId: selectedPackageId.value })
    uni.showModal({
      title: '订单已创建',
      content: `${res.payTip}\n订单号：${res.order?.orderNo || '-'}`,
      showCancel: false
    })
    await Promise.all([loadOrders(), loadData()])
  } catch (error) {
    uni.showToast({
      title: error.message || '创建失败',
      icon: 'none'
    })
  } finally {
    submitting.value = false
  }
}

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
      getWalletFlows({ pageNum: 1, pageSize: 50 })
    ])
    wallet.value = walletRes.data || {}
    flows.value = flowRes.rows || []
  } catch (error) {
    errorMessage.value = error.message || '加载失败'
  } finally {
    loading.value = false
  }
}

async function initializePage() {
  await loadPackages()
  if (requireLogin()) {
    await Promise.all([loadData(), loadOrders()])
  } else {
    wallet.value = {}
    flows.value = []
    orderList.value = []
  }
}

onLoad(initializePage)
onShow(initializePage)
</script>

<style lang="scss">
.page {
  min-height: 100vh;
  padding: 24rpx 24rpx 40rpx;
  background:
    radial-gradient(circle at top right, rgba(245, 176, 65, 0.16), transparent 30%),
    linear-gradient(180deg, #0d1121 0%, #13192d 100%);
  color: #fff;
}

.hero-card,
.stat-card,
.action-card,
.flow-item,
.empty-card {
  border-radius: 24rpx;
}

.hero-card {
  padding: 30rpx;
  background: linear-gradient(135deg, #efb44e 0%, #f37d4f 100%);
  color: #24170e;
}

.hero-top,
.flow-main,
.flow-foot,
.section-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16rpx;
}

.hero-label {
  display: block;
  font-size: 24rpx;
  opacity: 0.78;
}

.hero-value {
  display: block;
  margin-top: 10rpx;
  font-size: 58rpx;
  font-weight: 700;
}

.hero-badge {
  padding: 10rpx 18rpx;
  border-radius: 999rpx;
  background: rgba(36, 23, 14, 0.08);
  font-size: 22rpx;
}

.hero-desc {
  display: block;
  margin-top: 18rpx;
  font-size: 24rpx;
  line-height: 1.7;
  color: rgba(36, 23, 14, 0.82);
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 16rpx;
  margin-top: 20rpx;
}

.stat-card {
  padding: 24rpx;
  background: #181e36;
}

.stat-label {
  display: block;
  color: #9eabd8;
  font-size: 24rpx;
}

.stat-value {
  display: block;
  margin-top: 10rpx;
  font-size: 36rpx;
  font-weight: 700;
}

.action-card {
  margin-top: 20rpx;
  padding: 26rpx;
  background: linear-gradient(135deg, #1c2340 0%, #151a30 100%);
}

.action-head {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 16rpx;
}

.action-title {
  display: block;
  font-size: 30rpx;
  font-weight: 700;
}

.action-desc {
  display: block;
  margin-top: 12rpx;
  color: #a8b4df;
  font-size: 25rpx;
  line-height: 1.7;
}

.action-badge {
  padding: 8rpx 16rpx;
  border-radius: 999rpx;
  background: rgba(239, 180, 78, 0.18);
  color: #efb44e;
  font-size: 22rpx;
}

.package-list {
  margin-top: 20rpx;
  display: grid;
  gap: 16rpx;
}

.package-item {
  padding: 22rpx;
  border-radius: 20rpx;
  background: rgba(255, 255, 255, 0.04);
  border: 1rpx solid rgba(255, 255, 255, 0.08);
}

.package-item.active {
  border-color: rgba(239, 180, 78, 0.6);
  box-shadow: 0 0 0 2rpx rgba(239, 180, 78, 0.1) inset;
}

.package-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16rpx;
}

.package-row.sub {
  margin-top: 10rpx;
  color: #9eabd8;
  font-size: 22rpx;
}

.package-name {
  font-size: 28rpx;
  font-weight: 700;
}

.package-price {
  color: #efb44e;
  font-size: 30rpx;
  font-weight: 700;
}

.package-desc {
  display: block;
  margin-top: 12rpx;
  color: #c8d0ef;
  font-size: 22rpx;
  line-height: 1.6;
}

.recharge-btn {
  margin-top: 20rpx;
  height: 84rpx;
  line-height: 84rpx;
  border: none;
  border-radius: 999rpx;
  background: linear-gradient(135deg, #efb44e 0%, #f37d4f 100%);
  color: #24170e;
  font-size: 28rpx;
  font-weight: 700;
}

.recharge-btn[disabled] {
  opacity: 0.6;
}

.section {
  margin-top: 30rpx;
}

.title {
  font-size: 32rpx;
  font-weight: 700;
}

.filter-hint {
  color: #8fa1dc;
  font-size: 22rpx;
}

.filter-row {
  margin-top: 18rpx;
  white-space: nowrap;
}

.filter-pill {
  display: inline-flex;
  margin-right: 14rpx;
  padding: 12rpx 22rpx;
  border-radius: 999rpx;
  background: #181e36;
  color: #98a6d6;
  font-size: 24rpx;
}

.filter-pill.active {
  background: linear-gradient(135deg, #4d38d6 0%, #3578ff 100%);
  color: #fff;
}

.flow-list {
  display: flex;
  flex-direction: column;
  gap: 16rpx;
  margin-top: 18rpx;
}

.flow-item {
  padding: 22rpx;
  background: #181e36;
}

.biz {
  display: block;
  font-size: 28rpx;
  font-weight: 600;
}

.remark {
  display: block;
  margin-top: 8rpx;
  color: #aeb7dc;
  font-size: 24rpx;
  line-height: 1.6;
}

.right {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
}

.plus {
  color: #78e08f;
  font-size: 32rpx;
  font-weight: 700;
}

.minus {
  color: #ffb36b;
  font-size: 32rpx;
  font-weight: 700;
}

.balance {
  margin-top: 8rpx;
  color: #96a4d6;
  font-size: 22rpx;
}

.status {
  margin-top: 8rpx;
  color: #96a4d6;
  font-size: 22rpx;
}

.status-success {
  color: #78e08f;
}

.status-warning {
  color: #efb44e;
}

.status-danger {
  color: #ff9797;
}

.flow-foot {
  margin-top: 16rpx;
  color: #8c99c8;
  font-size: 22rpx;
  flex-wrap: wrap;
}

.empty-card {
  margin-top: 18rpx;
  padding: 28rpx;
  background: #181e36;
}

.empty-title {
  display: block;
  font-size: 30rpx;
  font-weight: 700;
}

.empty-desc {
  display: block;
  margin-top: 12rpx;
  color: #a3b0dd;
  font-size: 24rpx;
  line-height: 1.7;
}

.state {
  padding: 28rpx 0;
  color: #afbadf;
  font-size: 26rpx;
}

.error {
  color: #ff9797;
}
</style>
