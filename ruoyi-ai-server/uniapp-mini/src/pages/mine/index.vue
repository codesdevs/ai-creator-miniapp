<template>
  <view class="page center">
    <template v-if="user">
      <text class="title">{{ user.nickName }}</text>
      <text class="desc">用户编号：{{ user.userNo }}</text>
      <text class="desc">邀请码：{{ user.inviteCode }}</text>
      <button class="action" @tap="goAssets">查看资产</button>
      <button class="action secondary" @tap="logout">退出登录</button>
    </template>
    <template v-else>
      <text class="title">未登录</text>
      <text class="desc">支持微信快捷登录，未配置时自动回退开发登录。</text>
      <button class="action" @tap="goLogin">去登录</button>
    </template>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { onLoad, onShow } from '@dcloudio/uni-app'
import { getProfile } from '@/api/auth'
import { clearAuth, getUser, isLoggedIn, setUser } from '@/utils/auth'

const user = ref(null)

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
  uni.switchTab({ url: '/pages/assets/index' })
}

function logout() {
  clearAuth()
  user.value = null
}

onLoad(loadProfile)
onShow(loadProfile)
</script>

<style lang="scss">
.page {
  min-height: 100vh;
  background: #0f1020;
  color: #fff;
}

.center {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 48rpx;
  text-align: center;
}

.title {
  font-size: 36rpx;
  font-weight: 600;
}

.desc {
  margin-top: 16rpx;
  color: #9aa0c8;
  font-size: 28rpx;
}

.action {
  margin-top: 24rpx;
  width: 320rpx;
  background: linear-gradient(90deg, #7a5cff, #b678ff);
  color: #fff;
  border: none;
}

.secondary {
  background: #232744;
}
</style>
