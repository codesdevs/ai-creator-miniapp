import request from '@/utils/request'

// 查询C端用户列表
export function listUser(query) {
  return request({
    url: '/ai/user/list',
    method: 'get',
    params: query
  })
}

// 查询C端用户详情
export function getUserDetail(userId) {
  return request({
    url: '/ai/user/list',
    method: 'get',
    params: {
      pageNum: 1,
      pageSize: 1,
      userId
    }
  })
}
