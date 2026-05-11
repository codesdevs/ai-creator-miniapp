const TOKEN_KEY = 'app_token'
const USER_KEY = 'app_user'
const DEV_VISITOR_KEY = 'app_dev_visitor_key'

export function getToken() {
  return uni.getStorageSync(TOKEN_KEY)
}

export function setToken(token) {
  uni.setStorageSync(TOKEN_KEY, token)
}

export function removeToken() {
  uni.removeStorageSync(TOKEN_KEY)
}

export function getUser() {
  return uni.getStorageSync(USER_KEY)
}

export function setUser(user) {
  uni.setStorageSync(USER_KEY, user)
}

export function removeUser() {
  uni.removeStorageSync(USER_KEY)
}

export function clearAuth() {
  removeToken()
  removeUser()
}

export function getDevVisitorKey() {
  let visitorKey = uni.getStorageSync(DEV_VISITOR_KEY)
  if (visitorKey) {
    return visitorKey
  }
  visitorKey = `dev-${Date.now()}-${Math.random().toString(36).slice(2, 10)}`
  uni.setStorageSync(DEV_VISITOR_KEY, visitorKey)
  return visitorKey
}

export function isLoggedIn() {
  return !!getToken()
}

export function requireLogin() {
  if (isLoggedIn()) {
    return true
  }
  uni.navigateTo({
    url: '/pages/login/index'
  })
  return false
}
