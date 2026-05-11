<template>
  <scroll-view class="page" scroll-y>
    <view class="hero-card">
      <template v-if="user">
        <view class="hero-top">
          <view class="avatar">{{ avatarText }}</view>
          <view class="hero-main">
            <text class="title">{{ user.nickName }}</text>
            <text class="desc">用户编号：{{ user.userNo }}</text>
            <text class="desc">邀请码：{{ user.inviteCode || '-' }}</text>
          </view>
        </view>
        <view class="hero-actions">
          <button class="hero-btn" @tap="goAssets">我的资产</button>
          <button class="hero-btn secondary" @tap="goWorks">我的作品</button>
        </view>
      </template>
      <template v-else>
        <text class="title">未登录</text>
        <text class="desc">支持微信快捷登录，未配置时自动回退开发登录。</text>
        <button class="hero-btn" @tap="goLogin">去登录</button>
      </template>
    </view>

    <view class="section">
      <text class="section-title">常用入口</text>
      <view class="menu-list">
        <view class="menu-item" @tap="goAppCenter">
          <view>
            <text class="menu-title">模型中心</text>
            <text class="menu-desc">继续发起新的创作任务</text>
          </view>
          <text class="menu-arrow">›</text>
        </view>
        <view class="menu-item" @tap="goWorks">
          <view>
            <text class="menu-title">作品记录</text>
            <text class="menu-desc">查看历史任务和结果</text>
          </view>
          <text class="menu-arrow">›</text>
        </view>
        <view class="menu-item" @tap="goAssets">
          <view>
            <text class="menu-title">充值与钱包</text>
            <text class="menu-desc">查看算力余额、流水和订单</text>
          </view>
          <text class="menu-arrow">›</text>
        </view>
      </view>
    </view>

    <view v-if="user" class="section">
      <text class="section-title">账号操作</text>
      <view class="menu-list">
        <view class="menu-item danger" @tap="logout">
          <view>
            <text class="menu-title">退出登录</text>
            <text class="menu-desc">清除当前本地登录状态</text>
          </view>
          <text class="menu-arrow">›</text>
        </view>
      </view>
    </view>
  </scroll-view>
</template>

<script setup>
import { computed, ref } from 'vue'
import { onLoad, onShow } from '@dcloudio/uni-app'
import { getProfile } from '@/api/auth'
import { clearAuth, getUser, isLoggedIn, setUser } from '@/utils/auth'

const user = ref(null)

const avatarText = computed(() => {
  const name = user.value?.nickName || ''
  return name ? name.slice(0, 1).toUpperCase() : 'U'
})

async function loadProfile() {
  if (!isLoggedIn()) {
    user.value = null
    return
  }
  try {
    const cachedUser = getUser()
    if (cachedUser?.userId) {
      user.value = cachedUser
    }
    const res = await getProfile()
    user.value = res.data || null
    if (user.value) {
      setUser(user.value)
    }
  } catch (error) {
    user.value = null
  }
}

function goLogin() {
  uni.navigateTo({ url: '/pages/login/index' })
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

function goAppCenter() {
  uni.switchTab({ url: '/pages/app/index' })
}

function logout() {
  clearAuth()
  user.value = null
  uni.showToast({ title: '已退出登录', icon: 'none' })
}

onLoad(loadProfile)
onShow(loadProfile)
</script>

<style lang="scss">
.page {
  min-height: 100vh;
  padding: 24rpx;
  background:
    radial-gradient(circle at top right, rgba(112, 95, 255, 0.22), transparent 28%),
    linear-gradient(180deg, #0f1020 0%, #161b2f 100%);
  color: #fff;
}

.hero-card,
.menu-item {
  border-radius: 24rpx;
}

.hero-card {
  padding: 30rpx;
  background: linear-gradient(135deg, #1b2346 0%, #20173d 100%);
}

.hero-top {
  display: flex;
  gap: 20rpx;
  align-items: center;
}

.avatar {
  display: flex;
  width: 96rpx;
  height: 96rpx;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background: linear-gradient(135deg, #4d38d6 0%, #2f7cff 100%);
  font-size: 34rpx;
  font-weight: 700;
}

.hero-main {
  flex: 1;
}

.title {
  display: block;
  font-size: 38rpx;
  font-weight: 700;
}

.desc {
  display: block;
  margin-top: 10rpx;
  color: #afb9dd;
  font-size: 24rpx;
}

.hero-actions {
  display: flex;
  gap: 16rpx;
  margin-top: 24rpx;
}

.hero-btn {
  flex: 1;
  border: none;
  border-radius: 999rpx;
  background: linear-gradient(135deg, #4d38d6 0%, #2f7cff 100%);
  color: #fff;
  font-size: 26rpx;
}

.hero-btn.secondary {
  background: rgba(255, 255, 255, 0.08);
}

.section {
  margin-top: 28rpx;
}

.section-title {
  display: block;
  margin-bottom: 18rpx;
  font-size: 30rpx;
  font-weight: 700;
}

.menu-list {
  display: flex;
  flex-direction: column;
  gap: 16rpx;
}

.menu-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16rpx;
  padding: 28rpx;
  background: linear-gradient(180deg, #1b223d 0%, #13192d 100%);
}

.menu-item.danger .menu-title {
  color: #ffb6b6;
}

.menu-title {
  display: block;
  font-size: 28rpx;
  font-weight: 600;
}

.menu-desc {
  display: block;
  margin-top: 10rpx;
  color: #a7b3dc;
  font-size: 23rpx;
}

.menu-arrow {
  font-size: 34rpx;
  color: #8ea2e8;
}
</style>
