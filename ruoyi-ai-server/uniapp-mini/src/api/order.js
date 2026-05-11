import { request } from '@/utils/request'

export function getRechargePackageList() {
  return request({
    url: '/app/order/packageList'
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
