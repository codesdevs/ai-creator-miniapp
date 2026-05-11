import { request } from '@/utils/request'

export function devLogin(data) {
  return request({
    url: '/app/auth/devLogin',
    method: 'POST',
    data
  })
}

export function wxLogin(data) {
  return request({
    url: '/app/auth/wxLogin',
    method: 'POST',
    data
  })
}

export function getProfile() {
  return request({
    url: '/app/auth/profile'
  })
}
