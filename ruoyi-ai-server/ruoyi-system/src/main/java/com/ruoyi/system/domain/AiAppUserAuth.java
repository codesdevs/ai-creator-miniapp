package com.ruoyi.system.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import java.io.Serializable;
import java.util.Date;

/**
 * C端用户认证对象 ai_c_user_auth
 *
 * @author codex
 */
public class AiAppUserAuth implements Serializable
{
    private static final long serialVersionUID = 1L;

    private Long authId;

    private Long userId;

    private String authType;

    private String openid;

    private String unionid;

    private String sessionKey;

    private String authNickName;

    private String authAvatar;

    private String authMobile;

    private String remark;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateTime;

    public Long getAuthId()
    {
        return authId;
    }

    public void setAuthId(Long authId)
    {
        this.authId = authId;
    }

    public Long getUserId()
    {
        return userId;
    }

    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public String getAuthType()
    {
        return authType;
    }

    public void setAuthType(String authType)
    {
        this.authType = authType;
    }

    public String getOpenid()
    {
        return openid;
    }

    public void setOpenid(String openid)
    {
        this.openid = openid;
    }

    public String getUnionid()
    {
        return unionid;
    }

    public void setUnionid(String unionid)
    {
        this.unionid = unionid;
    }

    public String getSessionKey()
    {
        return sessionKey;
    }

    public void setSessionKey(String sessionKey)
    {
        this.sessionKey = sessionKey;
    }

    public String getAuthNickName()
    {
        return authNickName;
    }

    public void setAuthNickName(String authNickName)
    {
        this.authNickName = authNickName;
    }

    public String getAuthAvatar()
    {
        return authAvatar;
    }

    public void setAuthAvatar(String authAvatar)
    {
        this.authAvatar = authAvatar;
    }

    public String getAuthMobile()
    {
        return authMobile;
    }

    public void setAuthMobile(String authMobile)
    {
        this.authMobile = authMobile;
    }

    public String getRemark()
    {
        return remark;
    }

    public void setRemark(String remark)
    {
        this.remark = remark;
    }

    public Date getCreateTime()
    {
        return createTime;
    }

    public void setCreateTime(Date createTime)
    {
        this.createTime = createTime;
    }

    public Date getUpdateTime()
    {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime)
    {
        this.updateTime = updateTime;
    }
}
