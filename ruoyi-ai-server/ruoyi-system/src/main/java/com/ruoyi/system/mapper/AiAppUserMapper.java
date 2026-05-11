package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.AiAppUser;
import java.util.List;

/**
 * C端用户 数据层
 *
 * @author codex
 */
public interface AiAppUserMapper
{
    public AiAppUser selectAiAppUserById(Long userId);

    public AiAppUser selectAiAppUserByInviteCode(String inviteCode);

    public List<AiAppUser> selectAiAppUserList(AiAppUser aiAppUser);

    public int insertAiAppUser(AiAppUser aiAppUser);

    public int updateAiAppUser(AiAppUser aiAppUser);
}
