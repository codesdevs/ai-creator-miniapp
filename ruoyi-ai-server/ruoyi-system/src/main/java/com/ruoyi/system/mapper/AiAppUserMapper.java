package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.AiAppUser;

/**
 * C端用户 数据层
 *
 * @author codex
 */
public interface AiAppUserMapper
{
    public AiAppUser selectAiAppUserById(Long userId);

    public int insertAiAppUser(AiAppUser aiAppUser);

    public int updateAiAppUser(AiAppUser aiAppUser);
}
