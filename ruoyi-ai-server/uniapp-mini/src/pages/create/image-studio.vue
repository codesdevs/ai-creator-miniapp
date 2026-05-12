<template>
  <view class="page">
    <scroll-view class="content" scroll-y>
      <view class="balance-row">
        <text class="spark">✦</text>
        <text class="balance-text">账户算力 {{ balancePower }}</text>
        <button class="charge-btn" @tap="goAssets">立即充值</button>
      </view>

      <scroll-view class="model-tabs" scroll-x>
        <view class="model-tabs-inner">
          <view
            v-for="item in displayModels"
            :key="item.code"
            :class="['model-tab', activeModel.code === item.code ? 'active' : '']"
            @tap="selectModel(item.code)"
          >
            {{ item.name }}
          </view>
        </view>
      </scroll-view>

      <view class="version-grid">
        <view
          v-for="item in activeModel.versions"
          :key="item.code"
          :class="['option-card', activeVersion.code === item.code ? 'active' : '']"
          @tap="selectVersion(item.code)"
        >
          {{ item.name }}
        </view>
      </view>

      <view class="intro-card">
        <text class="intro-icon">☻</text>
        <text class="intro-desc">{{ activeVersion.intro }}</text>
      </view>

      <view class="mode-grid">
        <view
          v-for="item in modeOptions"
          :key="item.value"
          :class="['option-card', createMode === item.value ? 'active' : '']"
          @tap="createMode = item.value"
        >
          {{ item.label }}
        </view>
      </view>

      <text class="section-title">请描述您的图片</text>
      <view class="textarea-wrap">
        <textarea
          v-model="promptText"
          class="textarea"
          maxlength="800"
          placeholder="输入想要绘制的画面场景、风格和细节"
          placeholder-class="textarea-placeholder"
        />
        <view class="textarea-foot">
          <text>▣ AI文案</text>
          <text>✣ AI优化（消耗1算力）</text>
          <text>{{ promptText.length }}/800</text>
        </view>
      </view>

      <view class="warning">生成图片的描述，须避免出现黄、暴、政、以及相关内容。</view>

      <text class="section-title">风格选择</text>
      <view class="style-grid">
        <view
          v-for="item in displayStyles"
          :key="item.code"
          :class="['style-card', styleCode === item.code ? 'active' : '']"
          :style="{ background: item.background }"
          @tap="styleCode = item.code"
        >
          <view class="style-label">{{ item.name }}</view>
        </view>
      </view>

      <text class="section-title">图像比例</text>
      <view class="ratio-grid">
        <view
          v-for="item in displayRatios"
          :key="item.value"
          :class="['ratio-card', ratioValue === item.value ? 'active' : '']"
          @tap="ratioValue = item.value"
        >
          <view :class="['ratio-icon', item.icon]"></view>
          <text>{{ item.label }}</text>
        </view>
      </view>

      <text class="section-title">图片大小</text>
      <view class="size-grid">
        <view
          v-for="item in displaySizes"
          :key="item.value"
          :class="['size-card', sizeValue === item.value ? 'active' : '']"
          @tap="sizeValue = item.value"
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
      <button class="submit-btn" @tap="handleCreate">
        立即创作（消耗{{ currentCost }}算力）
      </button>
    </view>
  </view>
</template>

<script setup>
import { computed, ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { getApplicationDetail, submitApplication } from '@/api/application'
import { requireLogin } from '@/utils/auth'

const balancePower = ref(0)
const remoteApp = ref(null)
const activeModelCode = ref('jimeng')
const activeVersionCode = ref('jimeng-3')
const createMode = ref('TEXT_TO_IMAGE')
const promptText = ref('')
const styleCode = ref('custom')
const ratioValue = ref('9:16')
const sizeValue = ref('2K')
const remoteModels = ref([])
const submitting = ref(false)

const fallbackModels = [
  {
    code: 'sora2',
    name: 'Sora',
    versions: [{ code: 'sora2', name: 'Sora2', cost: 30, intro: 'Sora2 支持高质量视觉生成，适合复杂场景与电影感画面。' }]
  },
  {
    code: 'banana',
    name: 'Nano Banana',
    versions: [{ code: 'banana', name: 'Nano Banana', cost: 18, intro: 'Nano Banana 适合轻量快速出图，保持灵活的风格表现。' }]
  },
  {
    code: 'jimeng',
    name: '即梦AI',
    versions: [
      { code: 'jimeng-3', name: '即梦3.0', cost: 20, intro: '即梦AI-3.0支持多模态输入与实时编辑，商用级输出，独创版权保护算法，为专业设计者而生。' },
      { code: 'jimeng-31', name: '即梦3.1', cost: 20, intro: '即梦AI-3.1重点提升画面效果呈现、风格精准度和画面细节丰富度，同时兼具文字响应效果。' },
      { code: 'jimeng-4', name: '即梦4.0', cost: 22, intro: '即梦AI-4.0支持单次输入多张图像及复合编辑，提升中文生图准确率，支持4K超高清输出。' }
    ]
  },
  {
    code: 'wanxiang',
    name: '通义万象',
    versions: [{ code: 'wanxiang-v1', name: '万象V1', cost: 20, intro: '通义万象适合中文语义理解和东方审美风格生成。' }]
  },
  {
    code: 'keling',
    name: '可灵AI',
    versions: [{ code: 'keling-v1', name: '可灵V1', cost: 24, intro: '可灵AI适合视频与动态视觉创意，图片能力后续可扩展接入。' }]
  }
]

const modeOptions = [
  { label: '文生图片', value: 'TEXT_TO_IMAGE' },
  { label: '图生图片', value: 'IMAGE_TO_IMAGE' }
]

const fallbackStyles = [
  { code: 'custom', name: '自定义', background: 'linear-gradient(135deg, #f6f1e7, #d8d1c5)' },
  { code: 'gongbi', name: '新工笔画', background: 'linear-gradient(135deg, #efe6d5, #9b8f76)' },
  { code: 'vangogh', name: '梵高风', background: 'linear-gradient(135deg, #193a73, #f3d35a)' },
  { code: 'chinese', name: '中国画风', background: 'linear-gradient(135deg, #f5dede, #7f8f72)' },
  { code: 'fantasy', name: '奇幻风格', background: 'linear-gradient(135deg, #6d7cff, #f6d771)' },
  { code: 'anime', name: '动漫风格', background: 'linear-gradient(135deg, #92e7ff, #f6f0ff)' },
  { code: 'cartoon', name: '卡通风格', background: 'linear-gradient(135deg, #5f4bd8, #f887d1)' },
  { code: 'realistic', name: '写实风', background: 'linear-gradient(135deg, #f4d1a9, #463424)' },
  { code: 'sketch', name: '素描风', background: 'linear-gradient(135deg, #f4f4f4, #656565)' },
  { code: 'photo', name: '摄影风', background: 'linear-gradient(135deg, #c8dfb4, #d79b88)' },
  { code: 'clay', name: '黏土风', background: 'linear-gradient(135deg, #f1c65d, #f9e0a5)' },
  { code: 'bw', name: '黑白风格', background: 'linear-gradient(135deg, #111111, #e8e8e8)' },
  { code: 'jp', name: '日漫风格', background: 'linear-gradient(135deg, #48a8ff, #ff7b8a)' },
  { code: 'movie', name: '电影风格', background: 'linear-gradient(135deg, #0b2846, #f59d33)' },
  { code: 'watercolor', name: '浅水彩', background: 'linear-gradient(135deg, #d5efff, #fff2ca)' },
  { code: 'pixel', name: '像素风', background: 'linear-gradient(135deg, #207cff, #ffca2f)' }
]

const fallbackRatios = [
  { label: '9:16', value: '9:16', icon: 'portrait' },
  { label: '16:9', value: '16:9', icon: 'landscape' },
  { label: '1:1', value: '1:1', icon: 'square' },
  { label: '4:3', value: '4:3', icon: 'landscape' },
  { label: '3:4', value: '3:4', icon: 'photo' },
  { label: '21:9', value: '21:9', icon: 'wide' }
]

const fallbackSizes = [
  { label: '1K', value: '1K', extraCost: -2 },
  { label: '2K', value: '2K', extraCost: 0 },
  { label: '4K', value: '4K', extraCost: 4 }
]

const styleBackgroundMap = {
  CUSTOM: 'linear-gradient(135deg, #f6f1e7, #d8d1c5)',
  GONGBI: 'linear-gradient(135deg, #efe6d5, #9b8f76)',
  VAN_GOGH: 'linear-gradient(135deg, #193a73, #f3d35a)',
  CHINESE: 'linear-gradient(135deg, #f5dede, #7f8f72)',
  FANTASY: 'linear-gradient(135deg, #6d7cff, #f6d771)',
  ANIME: 'linear-gradient(135deg, #92e7ff, #f6f0ff)',
  CARTOON: 'linear-gradient(135deg, #5f4bd8, #f887d1)',
  REALISTIC: 'linear-gradient(135deg, #f4d1a9, #463424)',
  SKETCH: 'linear-gradient(135deg, #f4f4f4, #656565)',
  PHOTO: 'linear-gradient(135deg, #c8dfb4, #d79b88)',
  CLAY: 'linear-gradient(135deg, #f1c65d, #f9e0a5)',
  BLACK_WHITE: 'linear-gradient(135deg, #111111, #e8e8e8)',
  JAPANESE_ANIME: 'linear-gradient(135deg, #48a8ff, #ff7b8a)',
  MOVIE: 'linear-gradient(135deg, #0b2846, #f59d33)',
  WATERCOLOR: 'linear-gradient(135deg, #d5efff, #fff2ca)',
  PIXEL: 'linear-gradient(135deg, #207cff, #ffca2f)'
}

const displayModels = computed(() => remoteModels.value.length ? remoteModels.value : fallbackModels)
const activeModel = computed(() => displayModels.value.find((item) => item.code === activeModelCode.value) || displayModels.value[0] || fallbackModels[2])
const activeVersion = computed(() => activeModel.value.versions.find((item) => item.code === activeVersionCode.value) || activeModel.value.versions[0])
const displayStyles = computed(() => activeVersion.value?.styles?.length ? activeVersion.value.styles : fallbackStyles)
const displayRatios = computed(() => activeVersion.value?.ratios?.length ? activeVersion.value.ratios : fallbackRatios)
const displaySizes = computed(() => activeVersion.value?.sizes?.length ? activeVersion.value.sizes : fallbackSizes)
const activeSize = computed(() => displaySizes.value.find((item) => item.value === sizeValue.value) || displaySizes.value[1] || fallbackSizes[1])
const currentCost = computed(() => Math.max(1, activeVersion.value.cost + activeSize.value.extraCost))

function selectModel(code) {
  activeModelCode.value = code
  activeVersionCode.value = activeModel.value.versions[0].code
  applyVersionDefaults()
}

function selectVersion(code) {
  activeVersionCode.value = code
  applyVersionDefaults()
}

function parseJsonArray(value, fallback = []) {
  if (Array.isArray(value)) {
    return value
  }
  if (!value) {
    return fallback
  }
  try {
    const parsed = JSON.parse(value)
    return Array.isArray(parsed) ? parsed : fallback
  } catch (error) {
    return fallback
  }
}

function normalizeRatio(value) {
  const iconMap = {
    '9:16': 'portrait',
    '16:9': 'landscape',
    '1:1': 'square',
    '4:3': 'landscape',
    '3:4': 'photo',
    '21:9': 'wide'
  }
  return { label: value, value, icon: iconMap[value] || 'square' }
}

function normalizeSize(value) {
  const costMap = {
    '1K': -2,
    '2K': 0,
    '4K': 4
  }
  return { label: value, value, extraCost: costMap[value] || 0 }
}

function normalizeStyle(item) {
  const code = item.styleCode || item.code || 'CUSTOM'
  return {
    styleId: item.styleId,
    code,
    name: item.styleName || item.name || code,
    background: item.coverUrl ? `url(${item.coverUrl}) center/cover` : (styleBackgroundMap[code] || 'linear-gradient(135deg, #2a2733, #171129)')
  }
}

function normalizeVersion(item) {
  const ratios = parseJsonArray(item.supportRatio, []).map(normalizeRatio)
  const sizes = parseJsonArray(item.supportSize, []).map(normalizeSize)
  const styles = (item.params?.styleList || []).map(normalizeStyle)
  return {
    versionId: item.versionId,
    code: item.versionCode,
    name: item.versionName,
    cost: item.powerCost || 20,
    intro: item.versionIntro || item.intro || '当前版本支持图片生成与编辑。',
    ratios,
    sizes,
    styles,
    defaultRatio: item.defaultRatio,
    defaultSize: item.defaultSize
  }
}

function normalizeModel(item) {
  return {
    modelId: item.modelId,
    code: item.modelCode || item.displayName || String(item.modelId),
    name: item.displayName || item.modelName || item.modelCode,
    versions: (item.versionList || []).map(normalizeVersion).filter((version) => version.code)
  }
}

function applyVersionDefaults() {
  const version = activeVersion.value
  if (!version) {
    return
  }
  const ratios = version.ratios?.length ? version.ratios : fallbackRatios
  const sizes = version.sizes?.length ? version.sizes : fallbackSizes
  const styles = version.styles?.length ? version.styles : fallbackStyles
  ratioValue.value = version.defaultRatio || ratios[0]?.value || '9:16'
  sizeValue.value = version.defaultSize || sizes[1]?.value || sizes[0]?.value || '2K'
  styleCode.value = styles[0]?.code || 'custom'
}

async function loadDetail(preferredModel) {
  try {
    const res = await getApplicationDetail({ appCode: 'image_create' })
    remoteApp.value = res.data?.app || null
    const modelList = (res.data?.modelList || []).map(normalizeModel).filter((item) => item.versions.length)
    if (modelList.length) {
      const target = modelList.find((item) => item.code === preferredModel)
      if (preferredModel && !target) {
        remoteModels.value = []
        return
      }
      remoteModels.value = modelList
      const model = target || modelList[0]
      activeModelCode.value = model.code
      activeVersionCode.value = model.versions[0].code
      applyVersionDefaults()
    }
  } catch (error) {
    remoteApp.value = null
    remoteModels.value = []
  }
}

function goAssets() {
  uni.switchTab({ url: '/pages/assets/index' })
}

function goWorks() {
  uni.switchTab({ url: '/pages/works/index' })
}

function buildClientRequestId() {
  return `app-img-${Date.now()}-${Math.random().toString(36).slice(2, 10)}`
}

function validateBeforeSubmit() {
  if (!promptText.value.trim()) {
    uni.showToast({ title: '请输入图片描述', icon: 'none' })
    return false
  }
  if (!activeModel.value.modelId || !activeVersion.value.versionId) {
    uni.showToast({ title: '当前模型未接入提交接口', icon: 'none' })
    return false
  }
  return true
}

async function handleCreate() {
  if (submitting.value) {
    uni.showToast({ title: '任务提交中，请勿重复点击', icon: 'none' })
    return
  }
  if (!requireLogin() || !validateBeforeSubmit()) {
    return
  }
  submitting.value = true
  const activeStyle = displayStyles.value.find((item) => item.code === styleCode.value)
  try {
    const res = await submitApplication({
      clientRequestId: buildClientRequestId(),
      appId: remoteApp.value?.appId,
      appCode: 'image_create',
      modeCode: createMode.value,
      modelId: activeModel.value.modelId,
      versionId: activeVersion.value.versionId,
      promptText: promptText.value,
      styleCode: styleCode.value,
      styleId: activeStyle?.styleId,
      ratioCode: ratioValue.value,
      sizeCode: sizeValue.value,
      inputParams: {
        modelCode: activeModel.value.code,
        versionCode: activeVersion.value.code,
        createMode: createMode.value,
        styleCode: styleCode.value,
        ratioCode: ratioValue.value,
        sizeCode: sizeValue.value
      }
    })
    uni.showToast({ title: '任务已提交', icon: 'none' })
    setTimeout(() => {
      uni.navigateTo({ url: `/pages/task/detail?taskId=${res.taskId}` })
    }, 350)
  } catch (error) {
    uni.showToast({ title: error.message || '提交失败', icon: 'none' })
  } finally {
    submitting.value = false
  }
}

onLoad((options) => {
  if (fallbackModels.some((item) => item.code === options.model)) {
    selectModel(options.model)
  }
  loadDetail(options.model)
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

.model-tabs {
  margin: 42rpx -30rpx 0;
  white-space: nowrap;
}

.model-tabs-inner {
  display: inline-flex;
  min-width: 100%;
  padding: 0 30rpx;
  box-sizing: border-box;
  background: #17102a;
  border-radius: 28rpx;
}

.model-tab {
  min-width: 160rpx;
  height: 58rpx;
  padding: 0 20rpx;
  border-radius: 999rpx;
  color: #8a57ff;
  font-size: 28rpx;
  font-weight: 800;
  line-height: 58rpx;
  text-align: center;
}

.model-tab.active {
  background: linear-gradient(90deg, #7a45ff, #9c69ff);
  color: #ffffff;
}

.version-grid,
.mode-grid,
.ratio-grid,
.size-grid {
  display: grid;
  gap: 20rpx;
}

.version-grid {
  grid-template-columns: repeat(3, minmax(0, 1fr));
  margin-top: 64rpx;
}

.mode-grid,
.size-grid {
  grid-template-columns: repeat(2, minmax(0, 1fr));
  margin-top: 34rpx;
}

.size-grid {
  grid-template-columns: repeat(3, minmax(0, 1fr));
}

.option-card,
.size-card {
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

.option-card.active,
.size-card.active,
.ratio-card.active,
.style-card.active {
  border-color: #8250ff;
}

.intro-card {
  display: flex;
  gap: 14rpx;
  margin-top: 62rpx;
  padding: 24rpx 30rpx;
  border-radius: 22rpx;
  background: #18122c;
}

.intro-icon {
  color: #8a57ff;
  font-size: 28rpx;
}

.intro-desc {
  flex: 1;
  color: #b8b2c5;
  font-size: 25rpx;
  font-weight: 700;
  line-height: 1.45;
}

.section-title {
  display: block;
  margin-top: 34rpx;
  margin-bottom: 20rpx;
  font-size: 30rpx;
  font-weight: 800;
}

.textarea-wrap {
  height: 286rpx;
  padding: 28rpx 30rpx;
  border-radius: 22rpx;
  background: #171129;
}

.textarea {
  width: 100%;
  height: 202rpx;
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
  color: #8a57ff;
  font-size: 23rpx;
  font-weight: 700;
}

.warning {
  margin-top: 22rpx;
  padding: 18rpx 22rpx;
  border-radius: 18rpx;
  background: #efe3a9;
  color: #b66f08;
  font-size: 25rpx;
  font-weight: 800;
}

.style-grid {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 20rpx;
}

.style-card {
  position: relative;
  height: 156rpx;
  border: 2rpx solid transparent;
  border-radius: 18rpx;
  overflow: hidden;
}

.style-label {
  position: absolute;
  right: 12rpx;
  bottom: 12rpx;
  left: 12rpx;
  height: 42rpx;
  border-radius: 999rpx;
  background: rgba(0, 0, 0, 0.38);
  color: #ffffff;
  font-size: 22rpx;
  font-weight: 800;
  line-height: 42rpx;
  text-align: center;
}

.ratio-grid {
  grid-template-columns: repeat(3, minmax(0, 1fr));
}

.ratio-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 126rpx;
  border: 2rpx solid transparent;
  border-radius: 20rpx;
  background: #2a2733;
  font-size: 28rpx;
  font-weight: 800;
}

.ratio-icon {
  box-sizing: border-box;
  margin-bottom: 12rpx;
  border: 4rpx solid #a8a4af;
  border-radius: 8rpx;
}

.ratio-icon.portrait {
  width: 26rpx;
  height: 50rpx;
}

.ratio-icon.landscape {
  width: 54rpx;
  height: 28rpx;
}

.ratio-icon.square {
  width: 44rpx;
  height: 44rpx;
}

.ratio-icon.photo {
  width: 42rpx;
  height: 34rpx;
}

.ratio-icon.wide {
  width: 58rpx;
  height: 18rpx;
}

.agreement {
  margin-top: 46rpx;
  padding-bottom: 24rpx;
  color: #8552ff;
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
