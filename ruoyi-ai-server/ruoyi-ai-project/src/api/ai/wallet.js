import request from '@/utils/request'

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
