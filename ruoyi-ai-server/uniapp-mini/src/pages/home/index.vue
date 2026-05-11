<template>
  <scroll-view class="page" scroll-y>
    <view class="hero">
      <view class="hero-copy">
        <text class="hero-eyebrow">AI Creator</text>
        <text class="hero-title">从模型选择到结果回看，先把图片创作链路跑通</text>
        <text class="hero-desc">首页聚合模型入口、钱包余额、最近任务和充值能力，适合小程序端联调闭环。</text>
      </view>
      <view class="hero-side">
        <text class="hero-badge">Mini App</text>
        <text class="hero-user">{{ profileText }}</text>
      </view>
    </view>

    <view class="wallet-card" @tap="goAssets">
      <view>
        <text class="wallet-label">当前算力</text>
        <text class="wallet-value">{{ isLoggedIn() ? wallet.balancePower ?? 0 : '--' }}</text>
      </view>
      <view class="wallet-side">
        <text class="wallet-tip">{{ isLoggedIn() ? '查看钱包与流水' : '登录后查看余额' }}</text>
        <text class="wallet-arrow">›</text>
      </view>
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
          <view class="featured-head">
            <text class="featured-type">{{ item.modelType === 'VIDEO' ? '视频模型' : '图片模型' }}</text>
            <text class="featured-action">进入创作 ›</text>
          </view>
          <text class="featured-name">{{ item.modelName }}</text>
          <text class="featured-provider">{{ item.providerName || item.provider || '平台自定义模型' }}</text>
          <text class="featured-intro">{{ item.intro || '暂无模型介绍' }}</text>
        </view>
      </view>
    </view>

    <view class="section">
      <view class="section-head">
        <text class="section-title">最近任务</text>
        <text class="section-link" @tap="goWorks">查看全部</text>
      </view>
      <view v-if="!isLoggedIn()" class="empty-card">
        <text class="empty-title">登录后查看任务记录</text>
        <text class="empty-desc">登录成功后，这里会展示最新创作进度和结果入口。</text>
        <button class="empty-btn" @tap="goLogin">去登录</button>
      </view>
      <view v-else-if="taskLoading" class="state">任务加载中...</view>
      <view v-else-if="taskErrorMessage" class="state error">{{ taskErrorMessage }}</view>
      <view v-else-if="latestTask" class="task-card" @tap="goTaskDetail(latestTask.taskId)">
        <view class="task-head">
          <view>
            <text class="task-model">{{ latestTask.modelName || '未命名模型' }}</text>
            <text class="task-version">{{ latestTask.versionName || '-' }}</text>
          </view>
          <view :class="['status-pill', statusClass(latestTask.status)]">
            {{ statusText(latestTask.status) }}
          </view>
        </view>
        <text class="task-prompt">{{ latestTask.promptText || '未填写提示词' }}</text>
        <view class="task-meta">
          <text>{{ formatMode(latestTask.createMode) }}</text>
          <text>{{ latestTask.powerCost || 0 }} 算力</text>
          <text>{{ latestTask.submitTime || '-' }}</text>
        </view>
      </view>
      <view v-else class="empty-card">
        <text class="empty-title">还没有创作记录</text>
        <text class="empty-desc">先进入模型中心选择一个图片模型，提交你的第一条任务。</text>
        <button class="empty-btn" @tap="goAppCenter">去创作</button>
      </view>
    </view>

    <view class="section">
      <view class="section-head">
        <text class="section-title">快捷入口</text>
      </view>
      <view class="shortcut-grid">
        <view class="shortcut-card accent" @tap="goAppCenter">
          <text class="shortcut-title">模型中心</text>
          <text class="shortcut-desc">查看全部模型、服务商和能力分类</text>
        </view>
        <view class="shortcut-card" @tap="goAssets">
          <text class="shortcut-title">充值与资产</text>
          <text class="shortcut-desc">套餐下单、卡密兑换、钱包流水</text>
        </view>
        <view class="shortcut-card" @tap="goWorks">
          <text class="shortcut-title">作品记录</text>
          <text class="shortcut-desc">查看任务状态、结果和再次创作入口</text>
        </view>
        <view class="shortcut-card" @tap="goMine">
          <text class="shortcut-title">个人中心</text>
          <text class="shortcut-desc">登录状态、邀请码和常用操作</text>
        </view>
      </view>
    </view>
  </scroll-view>
</template>

<script setup>
import { computed, ref } from 'vue'
import { onLoad, onShow } from '@dcloudio/uni-app'
import { listModel } from '@/api/model'
import { getMyTaskList } from '@/api/task'
import { getWalletInfo } from '@/api/wallet'
import { getUser, isLoggedIn } from '@/utils/auth'

const loading = ref(false)
const errorMessage = ref('')
const taskLoading = ref(false)
const taskErrorMessage = ref('')
const models = ref([])
const wallet = ref({})
const latestTask = ref(null)

const featuredModels = computed(() => models.value.slice(0, 3))
const profileText = computed(() => {
  if (!isLoggedIn()) {
    return '未登录'
  }
  return getUser()?.nickName || '已登录'
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
    IMAGE_TO_IMAGE: '图生图',
    TEXT_TO_VIDEO: '文生视频',
    IMAGE_TO_VIDEO: '图生视频'
  }
  return map[mode] || mode || '-'
}

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

async function loadLatestTask() {
  if (!isLoggedIn()) {
    latestTask.value = null
    taskErrorMessage.value = ''
    return
  }
  taskLoading.value = true
  taskErrorMessage.value = ''
  try {
    const res = await getMyTaskList()
    latestTask.value = (res.data || [])[0] || null
  } catch (error) {
    taskErrorMessage.value = error.message || '任务加载失败'
  } finally {
    taskLoading.value = false
  }
}

async function loadData() {
  loading.value = true
  errorMessage.value = ''
  try {
    await Promise.all([loadModels(), loadWallet(), loadLatestTask()])
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
  if (!isLoggedIn()) {
    goLogin()
    return
  }
  uni.switchTab({ url: '/pages/assets/index' })
}

function goWorks() {
  if (!isLoggedIn()) {
    goLogin()
    return
  }
  uni.switchTab({ url: '/pages/works/index' })
}

function goMine() {
  uni.switchTab({ url: '/pages/mine/index' })
}

function goLogin() {
  uni.navigateTo({ url: '/pages/login/index' })
}

function goTaskDetail(taskId) {
  uni.navigateTo({ url: `/pages/task/detail?taskId=${taskId}` })
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
onShow(() => {
  loadWallet()
  loadLatestTask()
})
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
.shortcut-card,
.task-card,
.empty-card {
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

.hero-copy {
  flex: 1;
}

.hero-side {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 14rpx;
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
  font-size: 46rpx;
  font-weight: 700;
  line-height: 1.22;
}

.hero-desc {
  display: block;
  margin-top: 18rpx;
  color: #b7c0e4;
  font-size: 26rpx;
  line-height: 1.7;
}

.hero-badge,
.hero-user {
  padding: 10rpx 18rpx;
  border-radius: 999rpx;
  border: 1rpx solid rgba(255, 255, 255, 0.12);
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

.wallet-side {
  display: flex;
  align-items: center;
  gap: 12rpx;
}

.wallet-tip {
  font-size: 24rpx;
}

.wallet-arrow {
  font-size: 34rpx;
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

.featured-card,
.task-card,
.empty-card {
  padding: 28rpx;
  background: linear-gradient(180deg, rgba(30, 39, 71, 0.96), rgba(18, 24, 45, 0.96));
  border: 1rpx solid rgba(115, 136, 218, 0.14);
}

.featured-head,
.task-head,
.task-meta {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16rpx;
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

.featured-action {
  color: #9fb3ff;
  font-size: 22rpx;
}

.featured-name,
.task-model {
  display: block;
  margin-top: 16rpx;
  font-size: 34rpx;
  font-weight: 700;
}

.featured-provider,
.task-version {
  display: block;
  margin-top: 10rpx;
  color: #9eb0e0;
  font-size: 24rpx;
}

.featured-intro,
.task-prompt {
  display: block;
  margin-top: 16rpx;
  color: #d5dcf6;
  font-size: 25rpx;
  line-height: 1.7;
}

.task-meta {
  margin-top: 18rpx;
  color: #a9b4dd;
  font-size: 22rpx;
  flex-wrap: wrap;
}

.shortcut-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
}

.shortcut-card {
  padding: 28rpx;
  background: linear-gradient(180deg, #1b223d 0%, #13192d 100%);
  border: 1rpx solid rgba(115, 136, 218, 0.14);
}

.shortcut-card.accent {
  background: linear-gradient(135deg, #2d3f86 0%, #1a2347 100%);
}

.shortcut-title {
  display: block;
  font-size: 30rpx;
  font-weight: 700;
}

.shortcut-desc {
  display: block;
  margin-top: 14rpx;
  color: #c0caef;
  font-size: 24rpx;
  line-height: 1.7;
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

.empty-btn {
  margin-top: 24rpx;
  border: none;
  border-radius: 999rpx;
  background: linear-gradient(135deg, #4d38d6 0%, #2f7cff 100%);
  color: #fff;
  font-size: 26rpx;
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
