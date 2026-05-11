<template>
  <view class="page">
    <view class="nav-back" @tap="goBack">‹</view>

    <view class="header">
      <text class="page-title">快捷登录</text>
    </view>

    <view class="brand">
      <text class="brand-icon">◡̈</text>
      <text class="brand-text">秒绘AI</text>
    </view>

    <text class="welcome">Hello,欢迎登录</text>

    <view class="agree-row" @tap="checked = !checked">
      <view :class="['checkbox', checked ? 'checked' : '']">{{ checked ? '✓' : '' }}</view>
      <view class="agree-text">
        我已认真阅读并同意
        <text class="link">《用户服务协议》</text>、
        <text class="link">《用户隐私协议》</text>
        和
        <text class="link">《AI功能使用须知》</text>
      </view>
    </view>

    <button class="primary-btn" :disabled="submitting" @tap="handleQuickLogin">
      {{ submitting ? '登录中...' : '微信快捷登录' }}
    </button>
    <button class="ghost-btn" @tap="showRegisterTip">其他手机号注册</button>

    <view class="divider"><text>其他方式</text></view>

    <view class="other-actions">
      <view class="action-item" @tap="goSms">
        <view class="circle">▣</view>
        <text>短信登录</text>
      </view>
      <view class="action-item" @tap="goPassword">
        <view class="circle">▢</view>
        <text>密码登录</text>
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { devLogin, wxLogin } from '@/api/auth'
import { getDevVisitorKey, setToken, setUser } from '@/utils/auth'

const checked = ref(true)
const submitting = ref(false)

function goBack() {
  if (getCurrentPages().length > 1) {
    uni.navigateBack()
    return
  }
  uni.switchTab({ url: '/pages/home/index' })
}

function ensureAgreement() {
  if (!checked.value) {
    uni.showToast({ title: '请先勾选协议', icon: 'none' })
    return false
  }
  return true
}

function goSms() {
  if (!ensureAgreement()) {
    return
  }
  uni.navigateTo({ url: '/pages/login/sms' })
}

function goPassword() {
  if (!ensureAgreement()) {
    return
  }
  uni.navigateTo({ url: '/pages/login/password' })
}

function showRegisterTip() {
  uni.showToast({ title: '注册流程后续接入', icon: 'none' })
}

function doLoginSuccess(res) {
  setToken(res.token)
  setUser(res.user)
  uni.switchTab({ url: '/pages/mine/index' })
}

function getDefaultNickname() {
  return `用户${getDevVisitorKey().slice(-4)}`
}

function getWxCode() {
  return new Promise((resolve, reject) => {
    uni.login({
      provider: 'weixin',
      success: (res) => {
        if (res.code) {
          resolve(res.code)
          return
        }
        reject(new Error('未获取到微信登录code'))
      },
      fail: (err) => {
        reject(new Error(err?.errMsg || '微信登录能力不可用'))
      }
    })
  })
}

async function tryDevFallback() {
  const devKey = getDevVisitorKey()
  const res = await devLogin({
    devKey: `wx:${devKey}`,
    nickName: getDefaultNickname(),
    avatar: ''
  })
  doLoginSuccess(res)
}

async function handleQuickLogin() {
  if (!ensureAgreement() || submitting.value) {
    return
  }
  submitting.value = true
  try {
    const code = await getWxCode()
    const res = await wxLogin({
      code,
      nickName: getDefaultNickname(),
      avatar: ''
    })
    doLoginSuccess(res)
  } catch (error) {
    const message = error?.message || ''
    if (message.includes('未启用') || message.includes('配置不完整') || message.includes('微信登录能力不可用')) {
      await tryDevFallback()
      return
    }
    uni.showToast({ title: message || '登录失败', icon: 'none' })
  } finally {
    submitting.value = false
  }
}
</script>

<style lang="scss">
.page {
  min-height: 100vh;
  padding: 32rpx 40rpx 0;
  background: #0f0d1c;
  color: #fff;
}

.nav-back {
  width: 56rpx;
  height: 56rpx;
  border-radius: 50%;
  color: #fff;
  font-size: 46rpx;
  line-height: 48rpx;
}

.header {
  margin-top: 8rpx;
  text-align: center;
}

.page-title {
  font-size: 36rpx;
  font-weight: 600;
}

.brand {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 16rpx;
  margin-top: 120rpx;
}

.brand-icon {
  color: #7e4dff;
  font-size: 72rpx;
  font-weight: 700;
}

.brand-text {
  background: linear-gradient(90deg, #7d48ff, #d85ac6);
  -webkit-background-clip: text;
  color: transparent;
  font-size: 72rpx;
  font-weight: 700;
}

.welcome {
  display: block;
  margin-top: 32rpx;
  text-align: center;
  font-size: 36rpx;
}

.agree-row {
  display: flex;
  gap: 20rpx;
  margin-top: 110rpx;
  align-items: flex-start;
}

.checkbox {
  flex: 0 0 40rpx;
  width: 40rpx;
  height: 40rpx;
  border-radius: 50%;
  border: 2rpx solid #6c6a79;
  color: #0f0d1c;
  text-align: center;
  line-height: 36rpx;
  background: #fff;
}

.checked {
  color: #7a5cff;
}

.agree-text {
  color: #c8c4db;
  font-size: 26rpx;
  line-height: 1.7;
}

.link {
  color: #8f63ff;
}

.primary-btn,
.ghost-btn {
  margin-top: 36rpx;
  height: 92rpx;
  border-radius: 46rpx;
  font-size: 32rpx;
  line-height: 92rpx;
}

.primary-btn {
  color: #fff;
  border: none;
  background: linear-gradient(90deg, #724dff, #b57dff);
}

.ghost-btn {
  color: #fff;
  background: #1b1830;
  border: 2rpx solid #393252;
}

.divider {
  position: relative;
  margin-top: 110rpx;
  text-align: center;
  color: #746d8f;
  font-size: 26rpx;
}

.divider::before,
.divider::after {
  content: '';
  position: absolute;
  top: 50%;
  width: 180rpx;
  height: 1rpx;
  background: #2b2740;
}

.divider::before {
  left: 0;
}

.divider::after {
  right: 0;
}

.other-actions {
  display: flex;
  justify-content: center;
  gap: 120rpx;
  margin-top: 70rpx;
}

.action-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  color: #8e89a7;
  font-size: 28rpx;
}

.circle {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 92rpx;
  height: 92rpx;
  margin-bottom: 18rpx;
  border: 2rpx solid #302b46;
  border-radius: 50%;
  font-size: 34rpx;
}
</style>
