<template>
  <view class="page">
    <view class="nav-back" @tap="goBack">‹</view>

    <view class="header">
      <text class="page-title">密码登录</text>
    </view>

    <view class="brand">
      <text class="brand-icon">◡̈</text>
      <text class="brand-text">秒绘AI</text>
    </view>

    <text class="welcome">Hello,欢迎登录</text>
    <text class="section-title">账号密码登录</text>

    <input v-model="form.mobile" class="input" placeholder="请输入手机号" />
    <input v-model="form.password" password class="input" placeholder="请输入登录密码" />
    <input v-model="form.inviteCode" class="input" placeholder="请输入邀请码（选填）" />

    <view class="link-row">
      <text class="forget" @tap="showForgetTip">忘记密码?</text>
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
      <view class="action-item" @tap="goSms">
        <view class="circle">▣</view>
        <text>短信登录</text>
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { devLogin } from '@/api/auth'
import { ENABLE_DEV_LOGIN } from '@/config'
import { isLoggedIn, redirectAfterLogin, setToken, setUser } from '@/utils/auth'

const INVITE_CODE_KEY = 'AI_CREATOR_INVITE_CODE'
const checked = ref(false)
const submitting = ref(false)
const form = ref({
  mobile: '',
  password: '',
  inviteCode: ''
})

function goBack() {
  if (getCurrentPages().length > 1) {
    uni.navigateBack()
    return
  }
  uni.redirectTo({ url: '/pages/login/index' })
}

function goQuick() {
  persistInviteCode()
  uni.redirectTo({ url: `/pages/login/index${buildInviteQuery()}` })
}

function goSms() {
  persistInviteCode()
  uni.redirectTo({ url: `/pages/login/sms${buildInviteQuery()}` })
}

function showForgetTip() {
  uni.showToast({ title: '找回密码后续接入', icon: 'none' })
}

async function handleLogin() {
  if (!ENABLE_DEV_LOGIN) {
    uni.showToast({ title: '账号密码登录暂未开放', icon: 'none' })
    return
  }
  if (!checked.value) {
    uni.showToast({ title: '请先勾选协议', icon: 'none' })
    return
  }
  if (!form.value.mobile.trim() || !form.value.password.trim()) {
    uni.showToast({ title: '请输入手机号和密码', icon: 'none' })
    return
  }
  submitting.value = true
  try {
    const res = await devLogin({
      devKey: `pwd:${form.value.mobile}`,
      nickName: `用户${form.value.mobile.slice(-4)}`,
      avatar: '',
      inviteCode: form.value.inviteCode.trim()
    })
    setToken(res.token)
    setUser(res.user)
    redirectAfterLogin('/pages/mine/index')
  } catch (error) {
    uni.showToast({ title: error.message || '登录失败', icon: 'none' })
  } finally {
    submitting.value = false
  }
}

function buildInviteQuery() {
  const code = form.value.inviteCode.trim()
  return code ? `?inviteCode=${encodeURIComponent(code)}` : ''
}

function persistInviteCode() {
  const code = form.value.inviteCode.trim()
  if (code) {
    uni.setStorageSync(INVITE_CODE_KEY, code)
    return
  }
  uni.removeStorageSync(INVITE_CODE_KEY)
}

onLoad((options) => {
  if (isLoggedIn()) {
    redirectAfterLogin('/pages/mine/index')
    return
  }
  form.value.inviteCode = options?.inviteCode || uni.getStorageSync(INVITE_CODE_KEY) || ''
})
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

.input {
  width: 100%;
  height: 92rpx;
  box-sizing: border-box;
  margin-top: 24rpx;
  padding: 0 28rpx;
  border-radius: 46rpx;
  background: #252233;
  color: #fff;
  font-size: 28rpx;
}

.link-row {
  display: flex;
  justify-content: flex-end;
  margin-top: 18rpx;
}

.forget {
  color: #8f63ff;
  font-size: 26rpx;
}

.primary-btn {
  margin-top: 36rpx;
}
</style>
