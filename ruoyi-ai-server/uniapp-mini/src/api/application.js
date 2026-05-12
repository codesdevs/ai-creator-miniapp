import { request } from '@/utils/request'

export function getApplicationHome() {
  return request({
    url: '/app/application/home'
  })
}

export function getApplicationDetail(data) {
  return request({
    url: '/app/application/detail',
    data
  })
}

export function submitApplication(data) {
  return request({
    url: '/app/application/submit',
    method: 'POST',
    data
  })
}
