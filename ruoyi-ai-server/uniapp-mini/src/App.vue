<script>
import { getProfile } from '@/api/auth'
import { clearAuth, getToken, setUser } from '@/utils/auth'

export default {
  onLaunch() {
    console.log('uni-app launched')
    this.restoreLoginState()
  },
  onShow() {
    this.restoreLoginState()
  },
  methods: {
    async restoreLoginState() {
      if (!getToken()) {
        clearAuth()
        return
      }
      try {
        const res = await getProfile()
        if (res?.data) {
          setUser(res.data)
          return
        }
        clearAuth()
      } catch (error) {
        clearAuth()
      }
    }
  }
}
</script>

<style lang="scss">
page {
  background: #0f1020;
  color: #ffffff;
  font-size: 28rpx;
}

button {
  border-radius: 999rpx;
}
</style>
