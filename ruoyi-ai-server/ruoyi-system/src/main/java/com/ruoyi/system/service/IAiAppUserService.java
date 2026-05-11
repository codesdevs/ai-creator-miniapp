package com.ruoyi.system.service;

import com.ruoyi.system.domain.AiAppUser;
import com.ruoyi.system.domain.vo.AppDevLoginBo;
import com.ruoyi.system.domain.vo.AppWxLoginBo;
import java.util.List;

/**
 * C端用户 服务层
 *
 * @author codex
 */
public interface IAiAppUserService
{
    public AiAppUser selectAiAppUserById(Long userId);

    public List<AiAppUser> selectAiAppUserList(AiAppUser aiAppUser);

    public AiAppUser devLogin(AppDevLoginBo bo);

    public AiAppUser wxLogin(AppWxLoginBo bo);
}
