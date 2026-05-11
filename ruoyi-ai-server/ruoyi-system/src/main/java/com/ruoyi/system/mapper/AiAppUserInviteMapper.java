package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.AiAppUserInvite;

/**
 * C端用户邀请关系 数据层
 *
 * @author codex
 */
public interface AiAppUserInviteMapper
{
    public int insertAiAppUserInvite(AiAppUserInvite aiAppUserInvite);

    public java.util.List<AiAppUserInvite> selectAiAppUserInviteList(AiAppUserInvite aiAppUserInvite);
}
