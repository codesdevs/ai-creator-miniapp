package com.ruoyi.system.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import java.io.Serializable;
import java.util.Date;

/**
 * C端用户对象 ai_c_user
 *
 * @author codex
 */
public class AiAppUser implements Serializable
{
    private static final long serialVersionUID = 1L;

    private Long userId;

    private String userNo;

    private String nickName;

    private String avatar;

    private String mobile;

    private String status;

    private String inviteCode;

    private Long inviterUserId;

    private String activateStatus;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date activateTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateTime;

    public Long getUserId()
    {
        return userId;
    }

    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public String getUserNo()
    {
        return userNo;
    }

    public void setUserNo(String userNo)
    {
        this.userNo = userNo;
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

    public String getMobile()
    {
        return mobile;
    }

    public void setMobile(String mobile)
    {
        this.mobile = mobile;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getInviteCode()
    {
        return inviteCode;
    }

    public void setInviteCode(String inviteCode)
    {
        this.inviteCode = inviteCode;
    }

    public Long getInviterUserId()
    {
        return inviterUserId;
    }

    public void setInviterUserId(Long inviterUserId)
    {
        this.inviterUserId = inviterUserId;
    }

    public String getActivateStatus()
    {
        return activateStatus;
    }

    public void setActivateStatus(String activateStatus)
    {
        this.activateStatus = activateStatus;
    }

    public Date getActivateTime()
    {
        return activateTime;
    }

    public void setActivateTime(Date activateTime)
    {
        this.activateTime = activateTime;
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
