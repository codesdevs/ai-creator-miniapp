import { API_BASE_URL } from '@/config'
import { clearAuth, getToken, navigateToLogin } from '@/utils/auth'

export function request({ url, method = 'GET', data = {}, header = {} }) {
  return new Promise((resolve, reject) => {
    const token = getToken()
    uni.request({
      url: `${API_BASE_URL}${url}`,
      method,
      data,
      header: {
        'Content-Type': 'application/json',
        ...(token ? { Authorization: `Bearer ${token}` } : {}),
        ...header
      },
      success: (res) => {
        const { statusCode, data: response } = res
        if (statusCode >= 200 && statusCode < 300) {
          if (response && response.code === 401) {
            clearAuth()
            navigateToLogin()
            reject(new Error(response.msg || '登录已过期'))
            return
          }
          if (response && typeof response.code !== 'undefined' && response.code !== 200) {
            reject(new Error(response.msg || '请求失败'))
            return
          }
          resolve(response)
          return
        }
        reject(new Error(`HTTP ${statusCode}`))
      },
      fail: (err) => {
        reject(err)
      }
    })
  })
}
