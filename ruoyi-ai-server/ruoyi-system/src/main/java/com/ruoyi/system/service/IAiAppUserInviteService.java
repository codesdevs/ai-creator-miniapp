package com.ruoyi.system.service;

import com.ruoyi.system.domain.AiAppUserInvite;
import java.util.List;

/**
 * C端用户邀请关系 服务层
 *
 * @author codex
 */
public interface IAiAppUserInviteService
{
    public List<AiAppUserInvite> selectAiAppUserInviteList(AiAppUserInvite aiAppUserInvite);
}
