const TOKEN_KEY = 'app_token'
const USER_KEY = 'app_user'
const DEV_VISITOR_KEY = 'app_dev_visitor_key'
const LOGIN_REDIRECT_KEY = 'app_login_redirect'
const TAB_PAGE_SET = new Set([
  '/pages/app/index',
  '/pages/assets/index',
  '/pages/home/index',
  '/pages/works/index',
  '/pages/mine/index'
])

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

export function setLoginRedirect(url) {
  if (!url) {
    return
  }
  uni.setStorageSync(LOGIN_REDIRECT_KEY, url)
}

export function consumeLoginRedirect() {
  const url = uni.getStorageSync(LOGIN_REDIRECT_KEY)
  uni.removeStorageSync(LOGIN_REDIRECT_KEY)
  return url
}

export function getCurrentPageUrl() {
  const pages = getCurrentPages()
  const current = pages[pages.length - 1]
  if (!current?.route) {
    return '/pages/home/index'
  }
  const query = current.options || {}
  const queryString = Object.keys(query)
    .filter((key) => query[key] !== undefined && query[key] !== null && query[key] !== '')
    .map((key) => `${encodeURIComponent(key)}=${encodeURIComponent(query[key])}`)
    .join('&')
  return `/${current.route}${queryString ? `?${queryString}` : ''}`
}

export function isTabPage(url) {
  return TAB_PAGE_SET.has((url || '').split('?')[0])
}

export function navigateToLogin(redirectUrl = getCurrentPageUrl()) {
  const currentUrl = getCurrentPageUrl()
  if (currentUrl.startsWith('/pages/login/')) {
    return
  }
  setLoginRedirect(redirectUrl)
  uni.navigateTo({
    url: '/pages/login/index'
  })
}

export function redirectAfterLogin(defaultUrl = '/pages/mine/index') {
  const targetUrl = consumeLoginRedirect() || defaultUrl
  if (isTabPage(targetUrl)) {
    uni.switchTab({ url: targetUrl })
    return
  }
  uni.redirectTo({ url: targetUrl })
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
  navigateToLogin()
  return false
}
