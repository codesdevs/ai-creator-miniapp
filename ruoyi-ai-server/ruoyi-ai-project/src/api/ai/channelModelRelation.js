import request from '@/utils/request'

export function listChannelModelRelation(query) {
  return request({
    url: '/ai/channelModelRelation/list',
    method: 'get',
    params: query
  })
}

export function getChannelModelRelation(relationId) {
  return request({
    url: '/ai/channelModelRelation/' + relationId,
    method: 'get'
  })
}

export function addChannelModelRelation(data) {
  return request({
    url: '/ai/channelModelRelation',
    method: 'post',
    data
  })
}

export function updateChannelModelRelation(data) {
  return request({
    url: '/ai/channelModelRelation',
    method: 'put',
    data
  })
}

export function delChannelModelRelation(relationId) {
  return request({
    url: '/ai/channelModelRelation/' + relationId,
    method: 'delete'
  })
}
