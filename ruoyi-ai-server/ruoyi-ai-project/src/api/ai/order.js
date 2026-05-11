import request from '@/utils/request'

export function listOrder(query) {
  return request({
    url: '/ai/order/list',
    method: 'get',
    params: query
  })
}

export function getOrder(orderId) {
  return request({
    url: '/ai/order/' + orderId,
    method: 'get'
  })
}

export function handleOrder(data) {
  return request({
    url: '/ai/order/handle',
    method: 'post',
    data
  })
}
