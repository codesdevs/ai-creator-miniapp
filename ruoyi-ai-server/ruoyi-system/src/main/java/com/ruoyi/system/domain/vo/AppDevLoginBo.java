package com.ruoyi.system.domain.vo;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/**
 * C端开发登录请求
 *
 * @author codex
 */
public class AppDevLoginBo
{
    @NotBlank(message = "开发标识不能为空")
    @Size(min = 1, max = 64, message = "开发标识长度不能超过64个字符")
    private String devKey;

    @NotBlank(message = "昵称不能为空")
    @Size(min = 1, max = 64, message = "昵称长度不能超过64个字符")
    private String nickName;

    @Size(max = 255, message = "头像地址长度不能超过255个字符")
    private String avatar;

    @Size(max = 32, message = "邀请码长度不能超过32个字符")
    private String inviteCode;

    public String getDevKey()
    {
        return devKey;
    }

    public void setDevKey(String devKey)
    {
        this.devKey = devKey;
    }

    public String getNickName()
    {
        return nickName;
    }

    public void setNickName(String nickName)
    {
        this.nickName = nickName;
    }

    public String getAvatar()
    {
        return avatar;
    }

    public void setAvatar(String avatar)
    {
        this.avatar = avatar;
    }

    public String getInviteCode()
    {
        return inviteCode;
    }

    public void setInviteCode(String inviteCode)
    {
        this.inviteCode = inviteCode;
    }
}
