import { request } from '@/utils/request'

export function submitImageTask(data) {
  return request({
    url: '/app/task/submitImage',
    method: 'POST',
    data
  })
}

export function getTaskDetail(taskId) {
  return request({
    url: `/app/task/detail/${taskId}`
  })
}

export function getMyTaskList() {
  return request({
    url: '/app/task/myList'
  })
}
