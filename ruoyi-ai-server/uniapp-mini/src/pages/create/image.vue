<template>
  <scroll-view class="page" scroll-y>
    <view class="hero" v-if="model.modelId">
      <image v-if="model.iconUrl" class="hero-icon" :src="model.iconUrl" mode="aspectFill" />
      <text class="hero-name">{{ model.modelName }}</text>
      <text class="hero-sub">{{ model.providerName || model.provider || '平台模型' }}</text>
      <text class="hero-desc">{{ model.intro || '围绕当前模型版本推荐合适的创作参数。' }}</text>
    </view>

    <view v-if="loading" class="state">加载中...</view>
    <view v-else-if="loadError" class="state error">{{ loadError }}</view>
    <template v-else>
      <view class="tip-card">
        <text class="tip-title">提交后异步生成</text>
        <text class="tip-desc">当前接口会先返回任务 ID，再由后台异步调用模型。提交完成后会自动跳转到任务详情页，通过任务状态轮询查看结果。</text>
      </view>

      <view class="panel">
        <view v-if="sourceTaskId" class="reuse-banner">
          <text class="reuse-title">已载入历史任务参数</text>
          <text class="reuse-desc">当前页面已自动回填上一次创作的版本、提示词、风格和比例，你可以直接修改后再次提交。</text>
        </view>

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
            <text class="summary-value">{{ modeOptions.length ? modeOptions.map(formatMode).join(' / ') : '-' }}</text>
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
          <text v-if="form.createMode === 'IMAGE_TO_IMAGE'" class="field-tip">图生图需要提供原图地址。当前智谱链路主要先验证异步任务流。</text>
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
          <text class="field-label">原图地址</text>
          <input
            v-model="form.sourceUrl"
            class="input"
            placeholder="图生图时填写可访问的图片 URL"
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
          {{ submitting ? '任务创建中...' : '立即创作' }}
        </button>
      </view>
    </template>
  </scroll-view>
</template>

<script setup>
import { computed, ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { getModelDetail } from '@/api/model'
import { getTaskDetail, submitImageTask } from '@/api/task'
import { requireLogin } from '@/utils/auth'

const modelId = ref()
const sourceTaskId = ref()
const model = ref({})
const versions = ref([])
const currentVersionIndex = ref(0)
const submitting = ref(false)
const loading = ref(false)
const loadError = ref('')
const draftLoaded = ref(false)
const submitToken = ref('')
const lastSubmitAt = ref(0)

const SUBMIT_DEBOUNCE_MS = 1200

const form = ref({
  createMode: '',
  promptText: '',
  negativePrompt: '',
  styleCode: '',
  ratioCode: '',
  sourceUrl: ''
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
  if (form.value.createMode !== 'IMAGE_TO_IMAGE') {
    form.value.sourceUrl = ''
  }
}

function applyTaskDraft(task) {
  if (!task) {
    return
  }
  const versionIndex = versions.value.findIndex((item) => item.versionId === task.modelVersionId)
  currentVersionIndex.value = versionIndex >= 0 ? versionIndex : 0
  applyVersionDefaults()
  form.value.createMode = task.createMode || form.value.createMode
  form.value.promptText = task.promptText || ''
  form.value.negativePrompt = task.negativePrompt || ''
  form.value.styleCode = task.styleCode || form.value.styleCode
  form.value.ratioCode = task.ratioCode || form.value.ratioCode
  form.value.sourceUrl = task.sourceUrl || ''
}

async function loadTaskDraft(taskId) {
  if (!taskId || draftLoaded.value) {
    return
  }
  const res = await getTaskDetail(taskId)
  applyTaskDraft(res.task || null)
  draftLoaded.value = true
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
    if (sourceTaskId.value) {
      await loadTaskDraft(sourceTaskId.value)
    }
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

function validateBeforeSubmit() {
  if (!form.value.promptText.trim()) {
    uni.showToast({ title: '请输入提示词', icon: 'none' })
    return false
  }
  if (!currentVersion.value) {
    uni.showToast({ title: '请选择模型版本', icon: 'none' })
    return false
  }
  if (form.value.createMode === 'IMAGE_TO_IMAGE' && !form.value.sourceUrl.trim()) {
    uni.showToast({ title: '图生图请填写原图地址', icon: 'none' })
    return false
  }
  return true
}

function buildClientRequestId() {
  return `img-${Date.now()}-${Math.random().toString(36).slice(2, 10)}`
}

async function handleSubmit() {
  const now = Date.now()
  if (now - lastSubmitAt.value < SUBMIT_DEBOUNCE_MS) {
    uni.showToast({ title: '操作过快，请稍后再试', icon: 'none' })
    return
  }
  if (submitToken.value) {
    uni.showToast({ title: '任务提交中，请勿重复点击', icon: 'none' })
    return
  }
  if (submitting.value) {
    uni.showToast({ title: '任务提交中，请勿重复点击', icon: 'none' })
    return
  }
  if (!requireLogin() || !validateBeforeSubmit()) {
    return
  }
  lastSubmitAt.value = now
  submitToken.value = buildClientRequestId()
  submitting.value = true
  try {
    const res = await submitImageTask({
      clientRequestId: submitToken.value,
      modelId: modelId.value,
      versionId: currentVersion.value.versionId,
      createMode: form.value.createMode,
      promptText: form.value.promptText,
      negativePrompt: form.value.negativePrompt,
      styleCode: form.value.styleCode,
      ratioCode: form.value.ratioCode,
      sourceUrl: form.value.sourceUrl
    })
    uni.showToast({
      title: res.status === 'WAITING' || res.status === 'RUNNING' ? '任务已提交，开始生成' : '任务创建成功',
      icon: 'none'
    })
    setTimeout(() => {
      uni.navigateTo({
        url: `/pages/task/detail?taskId=${res.taskId}`
      })
    }, 350)
  } catch (error) {
    uni.showToast({ title: error.message || '提交失败', icon: 'none' })
  } finally {
    submitting.value = false
    submitToken.value = ''
  }
}

onLoad((options) => {
  modelId.value = Number(options.modelId)
  sourceTaskId.value = options.sourceTaskId ? Number(options.sourceTaskId) : undefined
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
.pill,
.tip-card,
.input {
  border-radius: 24rpx;
}

.hero {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  padding: 30rpx;
  background: linear-gradient(135deg, #182143 0%, #1b1237 100%);
}

.hero-icon {
  width: 88rpx;
  height: 88rpx;
  margin-bottom: 20rpx;
  border-radius: 24rpx;
  background: rgba(255, 255, 255, 0.08);
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

.tip-card {
  margin-top: 20rpx;
  padding: 24rpx;
  background: linear-gradient(135deg, rgba(59, 91, 214, 0.22), rgba(36, 52, 120, 0.18));
  border: 1rpx solid rgba(122, 154, 255, 0.24);
}

.tip-title {
  display: block;
  font-size: 28rpx;
  font-weight: 700;
}

.tip-desc {
  display: block;
  margin-top: 10rpx;
  color: #c9d4ff;
  font-size: 23rpx;
  line-height: 1.7;
}

.panel {
  margin-top: 22rpx;
  padding: 28rpx;
  background: #151b31;
}

.reuse-banner {
  margin-bottom: 24rpx;
  padding: 22rpx;
  border-radius: 20rpx;
  background: rgba(86, 120, 255, 0.14);
  border: 1rpx solid rgba(126, 168, 255, 0.24);
}

.reuse-title {
  display: block;
  font-size: 26rpx;
  font-weight: 700;
}

.reuse-desc {
  display: block;
  margin-top: 10rpx;
  color: #c8d4ff;
  font-size: 23rpx;
  line-height: 1.7;
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

.field-tip {
  display: block;
  margin-top: 12rpx;
  color: #8fa3e8;
  font-size: 22rpx;
  line-height: 1.6;
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

.textarea,
.input {
  width: 100%;
  box-sizing: border-box;
  margin-top: 16rpx;
  padding: 24rpx;
  background: #0f1427;
  color: #fff;
  font-size: 28rpx;
}

.textarea {
  min-height: 220rpx;
}

.textarea.small {
  min-height: 140rpx;
}

.input {
  height: 96rpx;
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
