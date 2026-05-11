import request from '@/utils/request'

// 查询模型版本列表
export function listModelVersion(query) {
  return request({
    url: '/ai/modelVersion/list',
    method: 'get',
    params: query
  })
}

// 查询模型版本详情
export function getModelVersion(versionId) {
  return request({
    url: '/ai/modelVersion/' + versionId,
    method: 'get'
  })
}

// 根据模型查询版本
export function listModelVersionByModelId(modelId) {
  return request({
    url: '/ai/modelVersion/listByModelId',
    method: 'get',
    params: { modelId }
  })
}

// 新增模型版本
export function addModelVersion(data) {
  return request({
    url: '/ai/modelVersion',
    method: 'post',
    data: data
  })
}

// 修改模型版本
export function updateModelVersion(data) {
  return request({
    url: '/ai/modelVersion',
    method: 'put',
    data: data
  })
}

// 删除模型版本
export function delModelVersion(versionId) {
  return request({
    url: '/ai/modelVersion/' + versionId,
    method: 'delete'
  })
}
