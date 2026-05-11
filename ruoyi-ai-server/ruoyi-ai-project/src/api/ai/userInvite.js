import request from '@/utils/request'

// 查询会员邀请关系列表
export function listUserInvite(query) {
  return request({
    url: '/ai/userInvite/list',
    method: 'get',
    params: query
  })
}
