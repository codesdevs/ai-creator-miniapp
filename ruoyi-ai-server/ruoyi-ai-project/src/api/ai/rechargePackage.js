import request from '@/utils/request'

export function listRechargePackage(query) {
  return request({
    url: '/ai/rechargePackage/list',
    method: 'get',
    params: query
  })
}

export function getRechargePackage(packageId) {
  return request({
    url: '/ai/rechargePackage/' + packageId,
    method: 'get'
  })
}

export function addRechargePackage(data) {
  return request({
    url: '/ai/rechargePackage',
    method: 'post',
    data
  })
}

export function updateRechargePackage(data) {
  return request({
    url: '/ai/rechargePackage',
    method: 'put',
    data
  })
}
