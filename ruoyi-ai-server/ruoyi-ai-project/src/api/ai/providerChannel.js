import request from '@/utils/request'

export function listProviderChannel(query) {
  return request({
    url: '/ai/providerChannel/list',
    method: 'get',
    params: query
  })
}

export function getProviderChannel(channelId) {
  return request({
    url: '/ai/providerChannel/' + channelId,
    method: 'get'
  })
}

export function addProviderChannel(data) {
  return request({
    url: '/ai/providerChannel',
    method: 'post',
    data
  })
}

export function updateProviderChannel(data) {
  return request({
    url: '/ai/providerChannel',
    method: 'put',
    data
  })
}

export function delProviderChannel(channelId) {
  return request({
    url: '/ai/providerChannel/' + channelId,
    method: 'delete'
  })
}
