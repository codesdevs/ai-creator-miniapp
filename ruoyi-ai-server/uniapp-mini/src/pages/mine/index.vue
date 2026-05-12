<template>
  <scroll-view class="page" scroll-y>
    <view class="topbar">
      <text class="page-title">我的账户</text>
      <view v-if="user" class="setting-btn" @tap="showComingSoon('账号设置')">⚙</view>
    </view>

    <view class="profile-section">
      <view class="avatar">{{ avatarText }}</view>
      <view class="profile-main" @tap="handleProfileTap">
        <text class="profile-name">{{ user ? user.nickName : '未登录' }}</text>
        <text class="profile-desc">{{ user ? profileDesc : '登录后可查看您的数字作品' }}</text>
      </view>
    </view>

    <view class="stats-row">
      <view v-for="item in stats" :key="item.label" class="stat-item" @tap="item.action">
        <text class="stat-value">{{ item.value }}</text>
        <text class="stat-label">{{ item.label }}</text>
      </view>
    </view>

    <view class="benefit-card" @tap="user ? goAssets() : goLogin()">
      <view class="benefit-left">
        <view class="benefit-icon">✦</view>
        <view>
          <text class="benefit-title">{{ user ? '创作权益' : '登录创作权益' }}</text>
          <text class="benefit-desc">{{ user ? '算力余额与创作记录实时同步' : '登录后同步算力、资产与作品' }}</text>
        </view>
      </view>
      <button class="benefit-btn">{{ user ? '查看资产' : '去登录' }}</button>
    </view>

    <view class="quick-grid">
      <view
        v-for="item in quickActions"
        :key="item.title"
        class="quick-card"
        @tap="item.action"
      >
        <view :class="['quick-icon', item.theme]">{{ item.icon }}</view>
        <view class="quick-copy">
          <text class="quick-title">{{ item.title }}</text>
          <text class="quick-desc">{{ item.desc }}</text>
        </view>
      </view>
    </view>

    <view class="section">
      <text class="section-title">更多服务</text>
      <view class="service-list">
        <view
          v-for="item in serviceItems"
          :key="item.title"
          class="service-item"
          @tap="item.action"
        >
          <view class="service-left">
            <view class="service-icon">{{ item.icon }}</view>
            <text class="service-title">{{ item.title }}</text>
          </view>
          <text class="service-arrow">›</text>
        </view>
      </view>
    </view>

    <view v-if="user" class="logout-wrap">
      <button class="logout-btn" @tap="logout">退出登录</button>
    </view>
  </scroll-view>
</template>

<script setup>
import { computed, ref } from 'vue'
import { onLoad, onShow } from '@dcloudio/uni-app'
import { getProfile, logout as logoutApi } from '@/api/auth'
import { getMyTaskList } from '@/api/task'
import { getWalletInfo } from '@/api/wallet'
import { clearAuth, getUser, isLoggedIn, navigateToLogin, setUser } from '@/utils/auth'

const user = ref(null)
const wallet = ref({})
const works = ref([])

const avatarText = computed(() => {
  const name = user.value?.nickName || ''
  return name ? name.slice(0, 1).toUpperCase() : 'U'
})

const profileDesc = computed(() => {
  if (!user.value) {
    return ''
  }
  return user.value.inviteCode ? `邀请码：${user.value.inviteCode}` : `用户编号：${user.value.userNo || '-'}`
})

const stats = computed(() => [
  {
    label: '剩余算力',
    value: formatNumber(wallet.value.balancePower),
    action: goAssets
  },
  {
    label: '我的资产',
    value: formatNumber((wallet.value.balancePower || 0) + (wallet.value.freezePower || 0)),
    action: goAssets
  },
  {
    label: '我的作品',
    value: formatNumber(works.value.length),
    action: goWorks
  }
])

const quickActions = computed(() => [
  {
    title: '我的资产',
    desc: '资产全局掌控',
    icon: 'AI',
    theme: 'asset',
    action: goAssets
  },
  {
    title: '我的作品',
    desc: '精彩创作集合',
    icon: '▶',
    theme: 'works',
    action: goWorks
  },
  {
    title: '算力充值',
    desc: '充算力创无忧',
    icon: 'BOT',
    theme: 'power',
    action: goAssets
  },
  {
    title: '邀请好友',
    desc: '分享您的邀请码',
    icon: '＋',
    theme: 'invite',
    action: showInvite
  }
])

const serviceItems = [
  {
    title: '算力清单',
    icon: '◇',
    action: goAssets
  },
  {
    title: '算力卡密',
    icon: '⌘',
    action: goAssets
  },
  {
    title: '使用技巧',
    icon: '□',
    action: () => showComingSoon('使用技巧')
  },
  {
    title: '推广海报',
    icon: '✈',
    action: showInvite
  }
]

function formatNumber(value) {
  const num = Number(value || 0)
  if (num >= 10000) {
    return `${(num / 10000).toFixed(1)}w`
  }
  return `${num}`
}

async function loadProfile() {
  if (!isLoggedIn()) {
    user.value = null
    wallet.value = {}
    works.value = []
    return
  }
  try {
    const cachedUser = getUser()
    if (cachedUser?.userId) {
      user.value = cachedUser
    }
    const [profileRes, walletRes, taskRes] = await Promise.all([
      getProfile(),
      getWalletInfo(),
      getMyTaskList()
    ])
    user.value = profileRes.data || null
    wallet.value = walletRes.data || {}
    works.value = taskRes.data || []
    if (user.value) {
      setUser(user.value)
    }
  } catch (error) {
    user.value = null
    wallet.value = {}
    works.value = []
  }
}

function handleProfileTap() {
  if (!user.value) {
    goLogin()
  }
}

function goLogin() {
  navigateToLogin('/pages/mine/index')
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

function showInvite() {
  if (!isLoggedIn()) {
    goLogin()
    return
  }
  uni.showModal({
    title: '邀请好友',
    content: user.value?.inviteCode ? `您的邀请码：${user.value.inviteCode}` : '邀请码生成中，请稍后再试',
    showCancel: false
  })
}

function showComingSoon(name) {
  uni.showToast({ title: `${name}即将上线`, icon: 'none' })
}

function logout() {
  uni.showModal({
    title: '退出登录',
    content: '确认退出当前账号吗？',
    success: async ({ confirm }) => {
      if (!confirm) {
        return
      }
      try {
        await logoutApi()
      } catch (error) {
        // Ignore backend logout failure and continue clearing local state.
      }
      clearAuth()
      user.value = null
      wallet.value = {}
      works.value = []
      uni.showToast({ title: '已退出登录', icon: 'none' })
    }
  })
}

onLoad(loadProfile)
onShow(loadProfile)
</script>

<style lang="scss">
.page {
  min-height: 100vh;
  box-sizing: border-box;
  padding: 34rpx 30rpx 150rpx;
  background: #0c0918;
  color: #ffffff;
}

.topbar {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 66rpx;
}

.page-title {
  font-size: 34rpx;
  font-weight: 800;
}

.setting-btn {
  position: absolute;
  right: 0;
  top: 0;
  display: flex;
  width: 66rpx;
  height: 66rpx;
  align-items: center;
  justify-content: center;
  color: #ffffff;
  font-size: 46rpx;
  line-height: 1;
}

.profile-section {
  display: flex;
  align-items: center;
  gap: 24rpx;
  margin-top: 52rpx;
}

.avatar {
  display: flex;
  width: 118rpx;
  height: 118rpx;
  flex: 0 0 118rpx;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background: linear-gradient(135deg, #54556f 0%, #34354d 100%);
  color: #d6d6e1;
  font-size: 48rpx;
  font-weight: 800;
}

.profile-main {
  min-width: 0;
  flex: 1;
}

.profile-name {
  display: block;
  font-size: 44rpx;
  font-weight: 900;
  line-height: 1.15;
}

.profile-desc {
  display: block;
  margin-top: 10rpx;
  color: #d4d2df;
  font-size: 26rpx;
  font-weight: 600;
  line-height: 1.35;
}

.stats-row {
  display: flex;
  margin-top: 60rpx;
}

.stat-item {
  flex: 1;
  text-align: center;
}

.stat-value {
  display: block;
  font-size: 42rpx;
  font-weight: 900;
  line-height: 1;
}

.stat-label {
  display: block;
  margin-top: 18rpx;
  color: #d9d7e4;
  font-size: 28rpx;
  font-weight: 800;
}

.benefit-card {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 18rpx;
  min-height: 94rpx;
  margin-top: 44rpx;
  padding: 20rpx 26rpx;
  border-radius: 28rpx;
  background: linear-gradient(135deg, #6e7899 0%, #444864 46%, #2a2c48 100%);
  overflow: hidden;
}

.benefit-left {
  display: flex;
  min-width: 0;
  align-items: center;
  gap: 18rpx;
}

.benefit-icon {
  display: flex;
  width: 58rpx;
  height: 58rpx;
  flex: 0 0 58rpx;
  align-items: center;
  justify-content: center;
  border-radius: 18rpx;
  background: rgba(255, 214, 128, 0.18);
  color: #f7c778;
  font-size: 34rpx;
  font-weight: 900;
}

.benefit-title {
  display: block;
  font-size: 30rpx;
  font-weight: 900;
}

.benefit-desc {
  display: block;
  margin-top: 6rpx;
  color: rgba(255, 255, 255, 0.76);
  font-size: 22rpx;
  line-height: 1.25;
}

.benefit-btn {
  display: flex;
  width: 168rpx;
  height: 58rpx;
  flex: 0 0 168rpx;
  align-items: center;
  justify-content: center;
  margin: 0;
  padding: 0;
  border: 0;
  border-radius: 999rpx;
  background: #cf1724;
  color: #ffffff;
  font-size: 26rpx;
  font-weight: 800;
  line-height: 58rpx;
}

.benefit-btn::after,
.logout-btn::after {
  border: 0;
}

.quick-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 22rpx;
  margin-top: 42rpx;
}

.quick-card {
  display: flex;
  min-height: 126rpx;
  align-items: center;
  gap: 20rpx;
  padding: 28rpx 24rpx;
  border-radius: 24rpx;
  background: #17122c;
}

.quick-icon {
  display: flex;
  width: 84rpx;
  height: 84rpx;
  flex: 0 0 84rpx;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  color: #ffffff;
  font-size: 26rpx;
  font-weight: 900;
}

.quick-icon.asset {
  background: radial-gradient(circle at 65% 38%, #62efff 0%, #26b4e6 34%, #123c33 70%, #10251f 100%);
}

.quick-icon.works {
  background: radial-gradient(circle at 62% 35%, #b389ff 0%, #7b45ff 46%, #2a1767 100%);
}

.quick-icon.power {
  background: radial-gradient(circle at 50% 45%, #ffd279 0%, #ff8865 42%, #462824 100%);
}

.quick-icon.invite {
  background: radial-gradient(circle at 48% 40%, #ff78d4 0%, #c849ba 42%, #4b1734 100%);
}

.quick-copy {
  min-width: 0;
  flex: 1;
}

.quick-title {
  display: block;
  font-size: 30rpx;
  font-weight: 900;
  line-height: 1.2;
}

.quick-desc {
  display: block;
  margin-top: 16rpx;
  color: #ffffff;
  font-size: 24rpx;
  font-weight: 700;
  line-height: 1.25;
}

.section {
  margin-top: 34rpx;
}

.section-title {
  display: block;
  margin-bottom: 22rpx;
  font-size: 34rpx;
  font-weight: 900;
}

.service-list {
  display: flex;
  flex-direction: column;
}

.service-item {
  display: flex;
  min-height: 86rpx;
  align-items: center;
  justify-content: space-between;
  border-bottom: 1rpx solid rgba(255, 255, 255, 0.06);
}

.service-left {
  display: flex;
  align-items: center;
  gap: 18rpx;
}

.service-icon {
  display: flex;
  width: 34rpx;
  height: 34rpx;
  align-items: center;
  justify-content: center;
  color: #f3f1ff;
  font-size: 28rpx;
}

.service-title {
  color: #ffffff;
  font-size: 30rpx;
  font-weight: 800;
}

.service-arrow {
  color: rgba(255, 255, 255, 0.55);
  font-size: 54rpx;
  line-height: 1;
}

.logout-wrap {
  margin-top: 34rpx;
}

.logout-btn {
  margin: 0;
  border: 0;
  border-radius: 22rpx;
  background: rgba(255, 255, 255, 0.07);
  color: #ffb8bd;
  font-size: 28rpx;
  font-weight: 800;
}
</style>
