const env = import.meta.env || {}

const DEFAULT_API_BASE_URL = env.PROD ? '' : 'http://127.0.0.1:9901'

export const API_BASE_URL = env.VITE_API_BASE_URL || DEFAULT_API_BASE_URL

export const ENABLE_DEV_LOGIN = env.VITE_ENABLE_DEV_LOGIN === 'true'

export const ENABLE_MOCK_PAY = env.VITE_ENABLE_MOCK_PAY === 'true'
