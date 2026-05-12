import { request } from '@/utils/request'

export function getRechargePackageList() {
  return request({
    url: '/app/order/packageList'
  })
}

export function getPayConfigList() {
  return request({
    url: '/app/order/payConfigList'
  })
}

export function submitRechargeOrder(data) {
  return request({
    url: '/app/order/submitRecharge',
    method: 'POST',
    data
  })
}

export function getMyRechargeOrderList() {
  return request({
    url: '/app/order/myRechargeList'
  })
}

export function getRechargeOrderDetail(orderId) {
  return request({
    url: `/app/order/${orderId}`
  })
}

export function cancelRechargeOrder(orderId) {
  return request({
    url: `/app/order/${orderId}`,
    method: 'DELETE'
  })
}

export function mockPayRechargeOrder(orderId) {
  return request({
    url: `/app/order/${orderId}/mockPay`,
    method: 'POST'
  })
}
