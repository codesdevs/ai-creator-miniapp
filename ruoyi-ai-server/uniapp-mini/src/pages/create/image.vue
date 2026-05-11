<template>
  <scroll-view class="page" scroll-y>
    <view class="hero" v-if="model.modelId">
      <text class="hero-name">{{ model.modelName }}</text>
      <text class="hero-sub">{{ model.provider || '平台模型' }}</text>
      <text class="hero-desc">{{ model.intro || '围绕当前模型版本推荐合适的创作参数。' }}</text>
    </view>

    <view v-if="loading" class="state">加载中...</view>
    <view v-else-if="loadError" class="state error">{{ loadError }}</view>
    <template v-else>
      <view class="panel">
        <text class="section-title">选择版本</text>
        <scroll-view class="chips-row" scroll-x>
          <view
            v-for="(item, index) in versions"
            :key="item.versionId"
            :class="['chip-card', index === currentVersionIndex ? 'active' : '']"
            @tap="selectVersion(index)"
          >
            <text class="chip-name">{{ item.versionName }}</text>
            <text class="chip-meta">{{ item.powerCost || 0 }} 算力 / 次</text>
          </view>
        </scroll-view>

        <view class="summary" v-if="currentVersion">
          <view class="summary-item">
            <text class="summary-label">当前版本</text>
            <text class="summary-value">{{ currentVersion.versionCode }}</text>
          </view>
          <view class="summary-item">
            <text class="summary-label">支持模式</text>
            <text class="summary-value">{{ modeOptions.length ? modeOptions.join(' / ') : '-' }}</text>
          </view>
        </view>

        <view class="field">
          <text class="field-label">创作模式</text>
          <view class="pill-group">
            <view
              v-for="item in modeOptions"
              :key="item"
              :class="['pill', form.createMode === item ? 'active' : '']"
              @tap="form.createMode = item"
            >
              {{ formatMode(item) }}
            </view>
          </view>
        </view>

        <view class="field">
          <text class="field-label">提示词</text>
          <textarea
            v-model="form.promptText"
            class="textarea"
            maxlength="800"
            placeholder="描述主体、场景、镜头语言、画面风格"
          />
        </view>

        <view class="field">
          <text class="field-label">反向提示词</text>
          <textarea
            v-model="form.negativePrompt"
            class="textarea small"
            maxlength="800"
            placeholder="可选，输入不希望出现的元素"
          />
        </view>

        <view class="field">
          <text class="field-label">画面风格</text>
          <view class="pill-group">
            <view
              v-for="item in styleOptions"
              :key="item"
              :class="['pill', form.styleCode === item ? 'active' : '']"
              @tap="form.styleCode = item"
            >
              {{ item }}
            </view>
            <view v-if="!styleOptions.length" class="pill placeholder">未配置风格</view>
          </view>
        </view>

        <view class="field">
          <text class="field-label">画面比例</text>
          <view class="pill-group">
            <view
              v-for="item in ratioOptions"
              :key="item"
              :class="['pill', form.ratioCode === item ? 'active' : '']"
              @tap="form.ratioCode = item"
            >
              {{ item }}
            </view>
            <view v-if="!ratioOptions.length" class="pill placeholder">未配置比例</view>
          </view>
        </view>
      </view>

      <view class="submit-bar">
        <view class="submit-info">
          <text class="submit-caption">预计消耗</text>
          <text class="submit-power">{{ currentVersion?.powerCost || 0 }} 算力</text>
        </view>
        <button class="submit-btn" :disabled="submitting || !currentVersion" @tap="handleSubmit">
          {{ submitting ? '提交中...' : '立即创作' }}
        </button>
      </view>
    </template>
  </scroll-view>
</template>

<script setup>
import { computed, ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { getModelDetail } from '@/api/model'
import { submitImageTask } from '@/api/task'
import { requireLogin } from '@/utils/auth'

const modelId = ref()
const model = ref({})
const versions = ref([])
const currentVersionIndex = ref(0)
const submitting = ref(false)
const loading = ref(false)
const loadError = ref('')

const form = ref({
  createMode: '',
  promptText: '',
  negativePrompt: '',
  styleCode: '',
  ratioCode: ''
})

const currentVersion = computed(() => versions.value[currentVersionIndex.value] || null)
const modeOptions = computed(() => splitTextOptions(currentVersion.value?.supportMode))
const styleOptions = computed(() => parseJsonOptions(currentVersion.value?.supportStyle))
const ratioOptions = computed(() => parseJsonOptions(currentVersion.value?.supportRatio))

function splitTextOptions(value) {
  return (value || '')
    .split(',')
    .map((item) => item.trim())
    .filter(Boolean)
}

function parseJsonOptions(value) {
  if (!value) {
    return []
  }
  try {
    const parsed = JSON.parse(value)
    return Array.isArray(parsed) ? parsed : []
  } catch (error) {
    return []
  }
}

function formatMode(value) {
  const map = {
    TEXT_TO_IMAGE: '文生图',
    IMAGE_TO_IMAGE: '图生图',
    TEXT_TO_VIDEO: '文生视频',
    IMAGE_TO_VIDEO: '图生视频'
  }
  return map[value] || value
}

function applyVersionDefaults() {
  form.value.createMode = modeOptions.value[0] || 'TEXT_TO_IMAGE'
  form.value.styleCode = styleOptions.value[0] || ''
  form.value.ratioCode = ratioOptions.value[0] || ''
}

async function loadDetail(id) {
  loading.value = true
  loadError.value = ''
  try {
    const res = await getModelDetail(id)
    model.value = res.model || {}
    versions.value = res.versionList || []
    currentVersionIndex.value = 0
    applyVersionDefaults()
  } catch (error) {
    loadError.value = error.message || '加载失败'
  } finally {
    loading.value = false
  }
}

function selectVersion(index) {
  currentVersionIndex.value = index
  applyVersionDefaults()
}

async function handleSubmit() {
  if (!requireLogin()) {
    return
  }
  if (!form.value.promptText.trim()) {
    uni.showToast({ title: '请输入提示词', icon: 'none' })
    return
  }
  if (!currentVersion.value) {
    uni.showToast({ title: '请选择模型版本', icon: 'none' })
    return
  }
  submitting.value = true
  try {
    const res = await submitImageTask({
      modelId: modelId.value,
      versionId: currentVersion.value.versionId,
      createMode: form.value.createMode,
      promptText: form.value.promptText,
      negativePrompt: form.value.negativePrompt,
      styleCode: form.value.styleCode,
      ratioCode: form.value.ratioCode
    })
    uni.navigateTo({
      url: `/pages/task/detail?taskId=${res.taskId}`
    })
  } catch (error) {
    uni.showToast({ title: error.message || '提交失败', icon: 'none' })
  } finally {
    submitting.value = false
  }
}

onLoad((options) => {
  modelId.value = Number(options.modelId)
  loadDetail(modelId.value)
})
</script>

<style lang="scss">
.page {
  min-height: 100vh;
  padding: 24rpx 24rpx 200rpx;
  background:
    radial-gradient(circle at top right, rgba(70, 116, 255, 0.22), transparent 34%),
    linear-gradient(180deg, #0b1020 0%, #14192d 100%);
  color: #fff;
}

.hero,
.panel,
.submit-bar,
.chip-card,
.pill {
  border-radius: 24rpx;
}

.hero {
  padding: 30rpx;
  background: linear-gradient(135deg, #182143 0%, #1b1237 100%);
}

.hero-name {
  display: block;
  font-size: 40rpx;
  font-weight: 700;
}

.hero-sub {
  display: block;
  margin-top: 10rpx;
  color: #9fb0ef;
  font-size: 24rpx;
}

.hero-desc {
  display: block;
  margin-top: 18rpx;
  color: #d3daf3;
  font-size: 26rpx;
  line-height: 1.7;
}

.panel {
  margin-top: 22rpx;
  padding: 28rpx;
  background: #151b31;
}

.section-title,
.field-label {
  display: block;
  font-size: 28rpx;
  font-weight: 600;
}

.chips-row {
  margin-top: 18rpx;
  white-space: nowrap;
}

.chip-card {
  display: inline-flex;
  flex-direction: column;
  min-width: 230rpx;
  margin-right: 16rpx;
  padding: 22rpx 20rpx;
  background: #0f1427;
  border: 1rpx solid transparent;
}

.chip-card.active {
  border-color: rgba(116, 141, 255, 0.7);
  background: linear-gradient(135deg, rgba(63, 92, 212, 0.28), rgba(86, 48, 180, 0.22));
}

.chip-name {
  font-size: 28rpx;
  font-weight: 600;
}

.chip-meta {
  margin-top: 8rpx;
  color: #9ca8d2;
  font-size: 22rpx;
}

.summary {
  margin-top: 24rpx;
  padding: 22rpx;
  border-radius: 20rpx;
  background: #0f1427;
}

.summary-item + .summary-item {
  margin-top: 14rpx;
}

.summary-label {
  color: #8e9bc8;
  font-size: 24rpx;
}

.summary-value {
  display: block;
  margin-top: 8rpx;
  color: #eef1ff;
  font-size: 25rpx;
  line-height: 1.6;
}

.field {
  margin-top: 28rpx;
}

.pill-group {
  display: flex;
  flex-wrap: wrap;
  gap: 14rpx;
  margin-top: 16rpx;
}

.pill {
  padding: 14rpx 22rpx;
  background: #0f1427;
  color: #bac5ee;
  font-size: 24rpx;
}

.pill.active {
  background: linear-gradient(135deg, #4d38d6 0%, #3578ff 100%);
  color: #fff;
}

.pill.placeholder {
  opacity: 0.7;
}

.textarea {
  width: 100%;
  min-height: 220rpx;
  box-sizing: border-box;
  margin-top: 16rpx;
  padding: 24rpx;
  border-radius: 20rpx;
  background: #0f1427;
  color: #fff;
  font-size: 28rpx;
}

.textarea.small {
  min-height: 140rpx;
}

.submit-bar {
  position: fixed;
  left: 24rpx;
  right: 24rpx;
  bottom: 28rpx;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 20rpx;
  padding: 22rpx 24rpx;
  background: rgba(11, 15, 27, 0.94);
  box-shadow: 0 20rpx 50rpx rgba(0, 0, 0, 0.28);
}

.submit-caption {
  display: block;
  color: #909cc8;
  font-size: 22rpx;
}

.submit-power {
  display: block;
  margin-top: 8rpx;
  font-size: 34rpx;
  font-weight: 700;
}

.submit-btn {
  min-width: 260rpx;
  margin: 0;
  border: none;
  border-radius: 999rpx;
  background: linear-gradient(135deg, #4d38d6 0%, #2f7cff 100%);
  color: #fff;
  font-size: 28rpx;
}

.state {
  padding: 36rpx 0;
  color: #b3bddf;
  font-size: 26rpx;
}

.error {
  color: #ff9797;
}
</style>
