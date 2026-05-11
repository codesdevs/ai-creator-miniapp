package com.ruoyi.system.domain.vo;

import jakarta.validation.constraints.NotBlank;

/**
 * 微信小程序登录入参
 *
 * @author codex
 */
public class AppWxLoginBo
{
    @NotBlank(message = "登录code不能为空")
    private String code;

    private String nickName;

    private String avatar;

    private String inviteCode;

    public String getCode()
    {
        return code;
    }

    public void setCode(String code)
    {
        this.code = code;
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
