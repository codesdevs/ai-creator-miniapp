<template>
  <scroll-view class="page" scroll-y>
    <image class="banner" src="/static/images/banner_home.png" mode="aspectFill" />

    <view class="section">
      <view class="section-head">
        <view class="section-dot"></view>
        <text class="section-title">文本创作</text>
      </view>
      <view class="tool-grid">
        <image
          v-for="item in textTools"
          :key="item.key"
          class="tool-card"
          :src="item.image"
          mode="aspectFill"
          @tap="openTool(item)"
        />
      </view>
    </view>

    <view class="section">
      <view class="section-head">
        <view class="section-dot"></view>
        <text class="section-title">图片创作</text>
      </view>
      <view class="tool-grid">
        <image
          v-for="item in imageTools"
          :key="item.key"
          class="tool-card"
          :src="item.image"
          mode="aspectFill"
          @tap="openTool(item)"
        />
      </view>
    </view>
  </scroll-view>
</template>

<script setup>
import { ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { listModel } from '@/api/model'

const models = ref([])

const textTools = [
  { key: 'copywriting', title: '文案创作', image: '/static/images/application/index/wbcz/wacz.png' },
  { key: 'polish', title: '文案润色', image: '/static/images/application/index/wbcz/wars.png' },
  { key: 'imitate', title: '文案仿写', image: '/static/images/application/index/wbcz/wafx.png' },
  { key: 'revise', title: '文案订正', image: '/static/images/application/index/wbcz/wadz.png' },
  { key: 'expand', title: '文案扩写', image: '/static/images/application/index/wbcz/wakx.png' },
  { key: 'summary', title: '文案精简', image: '/static/images/application/index/wbcz/wajj.png' }
]

const imageTools = [
  {
    key: 'jimeng',
    title: '即梦AI',
    image: '/static/images/application/index/tpcz/jmai.png',
    modelKeywords: ['jimeng', '即梦']
  },
  {
    key: 'keling',
    title: '可灵AI',
    image: '/static/images/application/index/tpcz/klai.png',
    modelKeywords: ['keling', '可灵']
  },
  { key: 'seedream', title: 'Seedream', image: '/static/images/application/index/tpcz/seedream.png' },
  { key: 'banana', title: 'Nano Banana', image: '/static/images/application/index/tpcz/banana.png' },
  { key: 'gpt-image-2', title: 'GPT Image', image: '/static/images/application/index/tpcz/gpt-image-2.png' },
  { key: 'midjourney', title: 'Midjourney', image: '/static/images/application/index/tpcz/midjourney.png' },
  { key: 'luma', title: 'Luma', image: '/static/images/application/index/tpcz/luma.png' },
  { key: 'sora2', title: 'Sora 2', image: '/static/images/application/index/tpcz/sora2.png' },
  { key: 'tywx', title: '通义万相', image: '/static/images/application/index/tpcz/tywx.png' }
]

async function loadModels() {
  try {
    const [imageRes, videoRes] = await Promise.all([listModel('IMAGE'), listModel('VIDEO')])
    models.value = [...(imageRes.data || []), ...(videoRes.data || [])]
  } catch (error) {
    models.value = []
  }
}

function findModel(item) {
  const keywords = item.modelKeywords || [item.key, item.title]
  return models.value.find((model) => {
    const haystack = [
      model.modelCode,
      model.modelName,
      model.provider,
      model.providerName
    ].filter(Boolean).join(' ').toLowerCase()
    return keywords.some((keyword) => haystack.includes(String(keyword).toLowerCase()))
  })
}

function openTool(item) {
  if (!item.image.includes('/tpcz/')) {
    uni.navigateTo({
      url: `/pages/create/text?mode=${item.key}`
    })
    return
  }

  if (['jimeng', 'keling', 'seedream', 'banana'].includes(item.key)) {
    uni.navigateTo({
      url: `/pages/create/image-studio?model=${item.key}`
    })
    return
  }

  const model = findModel(item)
  if (model && model.modelType !== 'VIDEO') {
    uni.navigateTo({
      url: `/pages/create/image?modelId=${model.modelId}`
    })
    return
  }
  uni.showToast({ title: `${item.title}暂未接入`, icon: 'none' })
}

onLoad(loadModels)
</script>

<style lang="scss">
.page {
  min-height: 100vh;
  box-sizing: border-box;
  padding: 24rpx 30rpx 130rpx;
  background: #0c0918;
  color: #ffffff;
}

.banner {
  display: block;
  width: 100%;
  height: 300rpx;
  border-radius: 30rpx;
  overflow: hidden;
}

.section {
  margin-top: 56rpx;
}

.section-head {
  position: relative;
  display: flex;
  align-items: center;
  height: 54rpx;
  margin-bottom: 28rpx;
}

.section-dot {
  width: 20rpx;
  height: 20rpx;
  margin-right: -10rpx;
  border-radius: 50%;
  background: linear-gradient(135deg, #49d8ff 0%, #9a63ff 100%);
}

.section-title {
  position: relative;
  z-index: 1;
  font-size: 38rpx;
  font-weight: 800;
  line-height: 1;
}

.tool-grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 22rpx 20rpx;
}

.tool-card {
  display: block;
  width: 100%;
  height: 150rpx;
  border-radius: 28rpx;
  overflow: hidden;
}
</style>
