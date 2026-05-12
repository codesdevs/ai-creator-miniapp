<template>
  <view class="page">
    <scroll-view class="content" scroll-y>
      <view class="balance-row">
        <text class="spark">✦</text>
        <text class="balance-text">账户算力 {{ balancePower }}</text>
        <button class="charge-btn" @tap="goAssets">立即充值</button>
      </view>

      <view class="intro-card">
        <text class="intro-title">☻ 功能介绍</text>
        <text class="intro-desc">{{ appIntro }}</text>
      </view>

      <view class="mode-grid">
        <view
          v-for="item in displayModes"
          :key="item.code"
          :class="['mode-card', activeMode.code === item.code ? 'active' : '']"
          @tap="activeCode = item.code"
        >
          {{ item.name }}
        </view>
      </view>

      <text class="section-title">创作内容</text>
      <view class="textarea-wrap">
        <textarea
          v-model="contentText"
          class="textarea"
          maxlength="1000"
          :placeholder="activeMode.placeholder"
          placeholder-class="textarea-placeholder"
        />
        <view class="textarea-foot">
          <text v-if="activeMode.code === 'copy_create'" class="example">✣ 示例提示词</text>
          <text>{{ contentText.length }}/1000</text>
        </view>
      </view>

      <text class="section-title">篇幅长度</text>
      <view class="length-grid">
        <view
          v-for="item in lengthOptions"
          :key="item.value"
          :class="['length-card', lengthValue === item.value ? 'active' : '']"
          @tap="lengthValue = item.value"
        >
          {{ item.label }}
        </view>
      </view>

      <view class="agreement">
        本功能涉及AI生成，操作即代表同意《用户服务协议》、《用户隐私协议》和《AI功能使用须知》
      </view>
    </scroll-view>

    <view class="submit-bar">
      <view class="mini-action" @tap="goWorks">
        <text class="mini-icon">◇</text>
        <text>我的作品</text>
      </view>
      <view class="mini-action" @tap="goAssets">
        <text class="mini-icon">◌</text>
        <text>算力清单</text>
      </view>
      <button class="submit-btn" @tap="handleCreate">立即创作（消耗{{ activeMode.powerCost }}算力）</button>
    </view>
  </view>
</template>

<script setup>
import { computed, ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { getApplicationDetail } from '@/api/application'

const balancePower = ref(0)
const contentText = ref('')
const activeCode = ref('copy_create')
const lengthValue = ref('short')
const remoteApp = ref(null)
const remoteModes = ref([])

const fallbackModes = [
  { code: 'copy_create', name: '文案创作', placeholder: '请输入文案创作的提示词和创作要求', powerCost: 2 },
  { code: 'imitate', name: '文案仿写', placeholder: '请输入对应的文案内容，如整段的文案内容', powerCost: 2 },
  { code: 'polish', name: '文案润色', placeholder: '请输入对应的文案内容，如整段的文案内容', powerCost: 2 },
  { code: 'expand', name: '文案扩写', placeholder: '请输入需要扩写的文案内容', powerCost: 2 },
  { code: 'correct', name: '文案订正', placeholder: '请输入需要订正的文案内容', powerCost: 2 },
  { code: 'summary', name: '文案精简', placeholder: '请输入需要精简的文案内容', powerCost: 2 }
]

const lengthOptions = [
  { label: '短篇', value: 'short' },
  { label: '中篇', value: 'medium' },
  { label: '长篇', value: 'long' }
]

const displayModes = computed(() => remoteModes.value.length ? remoteModes.value : fallbackModes)
const activeMode = computed(() => displayModes.value.find((item) => item.code === activeCode.value) || displayModes.value[0] || fallbackModes[0])
const appIntro = computed(() => remoteApp.value?.intro || '智能生成高质量文案，覆盖营销、广告、社交媒体等场景。AI基于大数据分析，快速产出创意内容，提升创作效率。')

function normalizeMode(item) {
  return {
    code: item.modeCode,
    name: item.modeName,
    placeholder: item.placeholder || '请输入创作内容',
    powerCost: item.powerCost || 2
  }
}

async function loadDetail(preferredCode) {
  try {
    const res = await getApplicationDetail({ appCode: 'copywriting' })
    remoteApp.value = res.data?.app || null
    remoteModes.value = (res.data?.modeList || []).map(normalizeMode).filter((item) => item.code)
    if (preferredCode && remoteModes.value.some((item) => item.code === preferredCode)) {
      activeCode.value = preferredCode
    }
  } catch (error) {
    remoteApp.value = null
    remoteModes.value = []
  }
}

function goAssets() {
  uni.switchTab({ url: '/pages/assets/index' })
}

function goWorks() {
  uni.switchTab({ url: '/pages/works/index' })
}

function handleCreate() {
  uni.showToast({ title: '原型页：后续接入统一应用提交接口', icon: 'none' })
}

onLoad((options) => {
  const modeMap = {
    copywriting: 'copy_create',
    revise: 'correct'
  }
  const optionMode = modeMap[options.mode] || options.mode
  const mode = fallbackModes.find((item) => item.code === optionMode)
  activeCode.value = mode?.code || 'copy_create'
  loadDetail(activeCode.value)
})
</script>

<style lang="scss">
.page {
  min-height: 100vh;
  background: #0c0918;
  color: #ffffff;
}

.content {
  box-sizing: border-box;
  height: calc(100vh - 120rpx);
  padding: 26rpx 30rpx 40rpx;
}

.balance-row {
  display: flex;
  align-items: center;
  min-height: 72rpx;
}

.spark {
  margin-right: 16rpx;
  color: #d7ca9e;
  font-size: 40rpx;
}

.balance-text {
  flex: 1;
  font-size: 34rpx;
  font-weight: 700;
}

.charge-btn {
  height: 56rpx;
  margin: 0;
  padding: 0 28rpx;
  border-radius: 999rpx;
  background: #292433;
  color: #e8bf67;
  font-size: 26rpx;
  font-weight: 700;
  line-height: 56rpx;
}

.intro-card {
  margin-top: 28rpx;
  padding: 26rpx 30rpx;
  border-radius: 24rpx;
  background: #18122c;
}

.intro-title {
  display: block;
  color: #ffffff;
  font-size: 30rpx;
  font-weight: 800;
}

.intro-desc {
  display: block;
  margin-top: 20rpx;
  color: #b8b2c5;
  font-size: 25rpx;
  font-weight: 600;
  line-height: 1.45;
}

.mode-grid,
.length-grid {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 20rpx;
}

.mode-grid {
  margin-top: 34rpx;
}

.mode-card,
.length-card {
  height: 78rpx;
  border: 2rpx solid transparent;
  border-radius: 20rpx;
  background: #2a2733;
  color: #ffffff;
  font-size: 28rpx;
  font-weight: 700;
  line-height: 78rpx;
  text-align: center;
}

.mode-card.active,
.length-card.active {
  border-color: #8250ff;
  background: #2b2635;
}

.section-title {
  display: block;
  margin-top: 34rpx;
  margin-bottom: 20rpx;
  font-size: 30rpx;
  font-weight: 800;
}

.textarea-wrap {
  height: 314rpx;
  padding: 28rpx 30rpx;
  border-radius: 22rpx;
  background: #171129;
}

.textarea {
  width: 100%;
  height: 230rpx;
  color: #ffffff;
  font-size: 28rpx;
  font-weight: 600;
  line-height: 1.5;
}

.textarea-placeholder {
  color: #bcb7c6;
}

.textarea-foot {
  display: flex;
  align-items: center;
  justify-content: space-between;
  color: #8c8794;
  font-size: 24rpx;
  font-weight: 700;
}

.example,
.agreement {
  color: #8552ff;
}

.agreement {
  margin-top: 90rpx;
  padding-bottom: 24rpx;
  font-size: 25rpx;
  font-weight: 700;
  line-height: 1.75;
}

.submit-bar {
  position: fixed;
  right: 0;
  bottom: 0;
  left: 0;
  display: flex;
  align-items: center;
  gap: 18rpx;
  box-sizing: border-box;
  height: 120rpx;
  padding: 14rpx 24rpx 16rpx;
  background: #151026;
}

.mini-action {
  width: 82rpx;
  color: #ffffff;
  font-size: 20rpx;
  font-weight: 700;
  text-align: center;
}

.mini-icon {
  display: block;
  font-size: 34rpx;
}

.submit-btn {
  flex: 1;
  height: 78rpx;
  margin: 0;
  border-radius: 999rpx;
  background: linear-gradient(90deg, #7a45ff 0%, #ad7cff 100%);
  color: #ffffff;
  font-size: 28rpx;
  font-weight: 800;
  line-height: 78rpx;
}
</style>
