<template>
  <view class="page">
    <view class="nav-back" @tap="goBack">‹</view>

    <view class="header">
      <text class="page-title">短信登录</text>
    </view>

    <view class="brand">
      <text class="brand-icon">◡̈</text>
      <text class="brand-text">秒绘AI</text>
    </view>

    <text class="welcome">Hello,欢迎登录</text>
    <text class="section-title">手机号登录</text>

    <view class="phone-row">
      <text class="prefix">+86</text>
      <input v-model="form.mobile" class="phone-input" placeholder="请输入手机号" />
    </view>

    <view class="code-row">
      <input v-model="form.code" class="code-input" placeholder="请输入验证码" />
      <button class="code-btn" @tap="mockSendCode">获取验证码</button>
    </view>

    <button class="primary-btn" :disabled="submitting" @tap="handleLogin">
      {{ submitting ? '登录中...' : '登录' }}
    </button>

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

    <view class="divider"><text>其他方式</text></view>

    <view class="other-actions">
      <view class="action-item" @tap="goQuick">
        <view class="circle">⌁</view>
        <text>快捷登录</text>
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
import { devLogin } from '@/api/auth'
import { setToken, setUser } from '@/utils/auth'

const checked = ref(false)
const submitting = ref(false)
const form = ref({
  mobile: '',
  code: ''
})

function goBack() {
  if (getCurrentPages().length > 1) {
    uni.navigateBack()
    return
  }
  uni.redirectTo({ url: '/pages/login/index' })
}

function goQuick() {
  uni.redirectTo({ url: '/pages/login/index' })
}

function goPassword() {
  uni.redirectTo({ url: '/pages/login/password' })
}

function mockSendCode() {
  if (!form.value.mobile.trim()) {
    uni.showToast({ title: '请先输入手机号', icon: 'none' })
    return
  }
  uni.showToast({ title: '演示环境不发送真实验证码', icon: 'none' })
}

async function handleLogin() {
  if (!checked.value) {
    uni.showToast({ title: '请先勾选协议', icon: 'none' })
    return
  }
  if (!form.value.mobile.trim() || !form.value.code.trim()) {
    uni.showToast({ title: '请输入手机号和验证码', icon: 'none' })
    return
  }
  submitting.value = true
  try {
    const res = await devLogin({
      devKey: `sms:${form.value.mobile}`,
      nickName: `用户${form.value.mobile.slice(-4)}`,
      avatar: ''
    })
    setToken(res.token)
    setUser(res.user)
    uni.switchTab({ url: '/pages/mine/index' })
  } catch (error) {
    uni.showToast({ title: error.message || '登录失败', icon: 'none' })
  } finally {
    submitting.value = false
  }
}
</script>

<style lang="scss">
@use './shared.scss' as *;

.section-title {
  display: block;
  margin-top: 64rpx;
  margin-bottom: 28rpx;
  font-size: 34rpx;
  font-weight: 600;
}

.phone-row,
.code-input {
  background: #252233;
  border-radius: 46rpx;
}

.phone-row {
  display: flex;
  align-items: center;
  padding: 0 28rpx;
}

.prefix {
  margin-right: 18rpx;
  font-size: 34rpx;
  font-weight: 700;
}

.phone-input {
  flex: 1;
  height: 92rpx;
  color: #fff;
  font-size: 28rpx;
}

.code-row {
  display: flex;
  gap: 16rpx;
  margin-top: 24rpx;
}

.code-input {
  flex: 1;
  height: 92rpx;
  padding: 0 28rpx;
  color: #fff;
  font-size: 28rpx;
}

.code-btn {
  width: 210rpx;
  height: 92rpx;
  border: none;
  border-radius: 46rpx;
  background: linear-gradient(90deg, #724dff, #b57dff);
  color: #fff;
  font-size: 28rpx;
  line-height: 92rpx;
}

.primary-btn {
  margin-top: 30rpx;
}
</style>
