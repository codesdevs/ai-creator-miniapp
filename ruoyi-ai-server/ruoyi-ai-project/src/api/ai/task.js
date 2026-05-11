import request from '@/utils/request'

// 查询任务列表
export function listTask(query) {
  return request({
    url: '/ai/task/list',
    method: 'get',
    params: query
  })
}

// 查询任务详情
export function getTask(taskId) {
  return request({
    url: '/ai/task/' + taskId,
    method: 'get'
  })
}
