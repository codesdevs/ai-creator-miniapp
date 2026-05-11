package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.AiAppUserAuth;

/**
 * C端用户认证 数据层
 *
 * @author codex
 */
public interface AiAppUserAuthMapper
{
    public AiAppUserAuth selectAiAppUserAuthByAuthTypeAndOpenid(String authType, String openid);

    public AiAppUserAuth selectAiAppUserAuthByUnionid(String unionid);

    public int insertAiAppUserAuth(AiAppUserAuth aiAppUserAuth);

    public int updateAiAppUserAuth(AiAppUserAuth aiAppUserAuth);
}
