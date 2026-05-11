import request from '@/utils/request'

export function listCardCode(query) {
  return request({
    url: '/ai/cardCode/list',
    method: 'get',
    params: query
  })
}

export function addCardCode(data) {
  return request({
    url: '/ai/cardCode',
    method: 'post',
    data
  })
}

export function batchGenerateCardCode(data) {
  return request({
    url: '/ai/cardCode/batchGenerate',
    method: 'post',
    data
  })
}

export function delCardCode(cardCodeIds) {
  return request({
    url: '/ai/cardCode/' + cardCodeIds,
    method: 'delete'
  })
}
