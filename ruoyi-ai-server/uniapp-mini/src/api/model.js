import { request } from '@/utils/request'

export function listModel(modelType) {
  return request({
    url: '/app/model/list',
    data: modelType ? { modelType } : {}
  })
}

export function getModelDetail(modelId) {
  return request({
    url: `/app/model/detail/${modelId}`
  })
}
