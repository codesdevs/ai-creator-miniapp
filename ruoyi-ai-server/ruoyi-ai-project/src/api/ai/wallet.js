import request from '@/utils/request'

// 查询用户钱包
export function getWalletInfo(userId) {
  return request({
    url: '/ai/wallet/info',
    method: 'get',
    params: { userId }
  })
}

// 查询算力流水
export function listWalletFlow(query) {
  return request({
    url: '/ai/wallet/flowList',
    method: 'get',
    params: query
  })
}

// 赠送算力
export function grantPower(params) {
  return request({
    url: '/ai/wallet/grantPower',
    method: 'post',
    params
  })
}
