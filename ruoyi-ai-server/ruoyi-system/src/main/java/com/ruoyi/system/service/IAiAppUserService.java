package com.ruoyi.system.service;

import com.ruoyi.system.domain.AiAppUser;
import com.ruoyi.system.domain.vo.AppDevLoginBo;
import com.ruoyi.system.domain.vo.AppWxLoginBo;

/**
 * C端用户 服务层
 *
 * @author codex
 */
public interface IAiAppUserService
{
    public AiAppUser selectAiAppUserById(Long userId);

    public AiAppUser devLogin(AppDevLoginBo bo);

    public AiAppUser wxLogin(AppWxLoginBo bo);
}
