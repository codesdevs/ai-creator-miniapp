import { request } from '@/utils/request'

export function getWalletInfo() {
  return request({
    url: '/app/wallet/info'
  })
}

export function getWalletFlows(data) {
  return request({
    url: '/app/wallet/flowPage',
    data
  })
}
