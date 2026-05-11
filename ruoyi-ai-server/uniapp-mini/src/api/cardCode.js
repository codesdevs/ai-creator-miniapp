import { request } from '@/utils/request'

export function redeemCardCode(data) {
  return request({
    url: '/app/cardCode/redeem',
    method: 'POST',
    data
  })
}
