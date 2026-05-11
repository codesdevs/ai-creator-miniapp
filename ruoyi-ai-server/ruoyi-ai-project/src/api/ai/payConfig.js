import request from '@/utils/request'

export function listPayConfig(query) {
  return request({
    url: '/ai/payConfig/list',
    method: 'get',
    params: query
  })
}

export function getPayConfig(payConfigId) {
  return request({
    url: '/ai/payConfig/' + payConfigId,
    method: 'get'
  })
}

export function addPayConfig(data) {
  return request({
    url: '/ai/payConfig',
    method: 'post',
    data
  })
}

export function updatePayConfig(data) {
  return request({
    url: '/ai/payConfig',
    method: 'put',
    data
  })
}
