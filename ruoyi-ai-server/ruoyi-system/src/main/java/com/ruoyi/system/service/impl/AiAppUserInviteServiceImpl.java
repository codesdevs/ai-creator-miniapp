package com.ruoyi.system.service.impl;

import com.ruoyi.system.domain.AiAppUserInvite;
import com.ruoyi.system.mapper.AiAppUserInviteMapper;
import com.ruoyi.system.service.IAiAppUserInviteService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * C端用户邀请关系 服务层实现
 *
 * @author codex
 */
@Service
public class AiAppUserInviteServiceImpl implements IAiAppUserInviteService
{
    @Autowired
    private AiAppUserInviteMapper aiAppUserInviteMapper;

    @Override
    public List<AiAppUserInvite> selectAiAppUserInviteList(AiAppUserInvite aiAppUserInvite)
    {
        return aiAppUserInviteMapper.selectAiAppUserInviteList(aiAppUserInvite);
    }
}
