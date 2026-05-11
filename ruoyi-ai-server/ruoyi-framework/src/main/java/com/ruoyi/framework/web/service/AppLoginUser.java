package com.ruoyi.framework.web.service;

import java.io.Serializable;

/**
 * C端登录态对象
 *
 * @author codex
 */
public class AppLoginUser implements Serializable
{
    private static final long serialVersionUID = 1L;

    private Long userId;

    private String token;

    private String nickName;

    private Long loginTime;

    private Long expireTime;

    public Long getUserId()
    {
        return userId;
    }

    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public String getToken()
    {
        return token;
    }

    public void setToken(String token)
    {
        this.token = token;
    }

    public String getNickName()
    {
        return nickName;
    }

    public void setNickName(String nickName)
    {
        this.nickName = nickName;
    }

    public Long getLoginTime()
    {
        return loginTime;
    }

    public void setLoginTime(Long loginTime)
    {
        this.loginTime = loginTime;
    }

    public Long getExpireTime()
    {
        return expireTime;
    }

    public void setExpireTime(Long expireTime)
    {
        this.expireTime = expireTime;
    }
}
