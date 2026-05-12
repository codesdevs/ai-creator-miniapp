<template>
  <scroll-view class="page" scroll-y>
    <image class="banner" src="/static/images/banner_home.png" mode="aspectFill" />

    <view v-for="section in displaySections" :key="section.sectionCode" class="section">
      <view class="section-head">
        <view class="section-dot"></view>
        <text class="section-title">{{ section.sectionName }}</text>
      </view>
      <view class="tool-grid">
        <image
          v-for="item in section.cardList"
          :key="item.cardCode"
          class="tool-card"
          :src="item.cardImageUrl"
          mode="aspectFill"
          @tap="openCard(item)"
        />
      </view>
    </view>
  </scroll-view>
</template>

<script setup>
import { computed, ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { getApplicationHome } from '@/api/application'
import { listModel } from '@/api/model'

const models = ref([])
const remoteSections = ref([])

const textTools = [
  { cardCode: 'copywriting', cardName: '文案创作', cardImageUrl: '/static/images/application/index/wbcz/wacz.png', actionType: 'ROUTE', actionValue: '/pages/create/text?mode=copywriting' },
  { cardCode: 'polish', cardName: '文案润色', cardImageUrl: '/static/images/application/index/wbcz/wars.png', actionType: 'ROUTE', actionValue: '/pages/create/text?mode=polish' },
  { cardCode: 'imitate', cardName: '文案仿写', cardImageUrl: '/static/images/application/index/wbcz/wafx.png', actionType: 'ROUTE', actionValue: '/pages/create/text?mode=imitate' },
  { cardCode: 'revise', cardName: '文案订正', cardImageUrl: '/static/images/application/index/wbcz/wadz.png', actionType: 'ROUTE', actionValue: '/pages/create/text?mode=revise' },
  { cardCode: 'expand', cardName: '文案扩写', cardImageUrl: '/static/images/application/index/wbcz/wakx.png', actionType: 'ROUTE', actionValue: '/pages/create/text?mode=expand' },
  { cardCode: 'summary', cardName: '文案精简', cardImageUrl: '/static/images/application/index/wbcz/wajj.png', actionType: 'ROUTE', actionValue: '/pages/create/text?mode=summary' }
]

const imageTools = [
  {
    cardCode: 'jimeng',
    cardName: '即梦AI',
    cardImageUrl: '/static/images/application/index/tpcz/jmai.png',
    actionType: 'ROUTE',
    actionValue: '/pages/create/image-studio?model=jimeng',
    modelKeywords: ['jimeng', '即梦']
  },
  {
    cardCode: 'keling',
    cardName: '可灵AI',
    cardImageUrl: '/static/images/application/index/tpcz/klai.png',
    actionType: 'ROUTE',
    actionValue: '/pages/create/image-studio?model=keling',
    modelKeywords: ['keling', '可灵']
  },
  { cardCode: 'seedream', cardName: 'Seedream', cardImageUrl: '/static/images/application/index/tpcz/seedream.png', actionType: 'ROUTE', actionValue: '/pages/create/image-studio?model=seedream' },
  { cardCode: 'banana', cardName: 'Nano Banana', cardImageUrl: '/static/images/application/index/tpcz/banana.png', actionType: 'ROUTE', actionValue: '/pages/create/image-studio?model=banana' },
  { cardCode: 'gpt-image-2', cardName: 'GPT Image', cardImageUrl: '/static/images/application/index/tpcz/gpt-image-2.png', actionType: 'TOAST', actionValue: 'GPT Image暂未接入' },
  { cardCode: 'midjourney', cardName: 'Midjourney', cardImageUrl: '/static/images/application/index/tpcz/midjourney.png', actionType: 'TOAST', actionValue: 'Midjourney暂未接入' },
  { cardCode: 'luma', cardName: 'Luma', cardImageUrl: '/static/images/application/index/tpcz/luma.png', actionType: 'TOAST', actionValue: 'Luma暂未接入' },
  { cardCode: 'sora2', cardName: 'Sora 2', cardImageUrl: '/static/images/application/index/tpcz/sora2.png', actionType: 'ROUTE', actionValue: '/pages/create/image-studio?model=sora2' },
  { cardCode: 'tywx', cardName: '通义万相', cardImageUrl: '/static/images/application/index/tpcz/tywx.png', actionType: 'ROUTE', actionValue: '/pages/create/image-studio?model=wanxiang' }
]

const fallbackSections = [
  { sectionCode: 'TEXT_CREATE', sectionName: '文本创作', cardList: textTools },
  { sectionCode: 'IMAGE_CREATE', sectionName: '图片创作', cardList: imageTools }
]

const displaySections = computed(() => remoteSections.value.length ? remoteSections.value : fallbackSections)

async function loadModels() {
  try {
    const [imageRes, videoRes] = await Promise.all([listModel('IMAGE'), listModel('VIDEO')])
    models.value = [...(imageRes.data || []), ...(videoRes.data || [])]
  } catch (error) {
    models.value = []
  }
}

function findModel(item) {
  const keywords = item.modelKeywords || [item.cardCode, item.cardName]
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

async function loadHome() {
  try {
    const res = await getApplicationHome()
    const sectionList = res.data?.sectionList || []
    remoteSections.value = sectionList
      .map((section) => ({
        ...section,
        cardList: section.params?.cardList || []
      }))
      .filter((section) => section.cardList.length)
  } catch (error) {
    remoteSections.value = []
  }
}

function openRoute(url) {
  if (!url) {
    return
  }
  if (url.startsWith('/pages/app/') || url.startsWith('/pages/assets/') || url.startsWith('/pages/home/') || url.startsWith('/pages/works/') || url.startsWith('/pages/mine/')) {
    uni.switchTab({ url })
    return
  }
  uni.navigateTo({ url })
}

function openCard(item) {
  if (item.actionType === 'ROUTE') {
    openRoute(item.actionValue)
    return
  }
  if (item.actionType === 'TOAST') {
    uni.showToast({ title: item.actionValue || `${item.cardName}暂未接入`, icon: 'none' })
    return
  }

  const model = findModel(item)
  if (model && model.modelType !== 'VIDEO') {
    uni.navigateTo({
      url: `/pages/create/image?modelId=${model.modelId}`
    })
    return
  }
  uni.showToast({ title: `${item.cardName}暂未接入`, icon: 'none' })
}

onLoad(() => {
  loadHome()
  loadModels()
})
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
