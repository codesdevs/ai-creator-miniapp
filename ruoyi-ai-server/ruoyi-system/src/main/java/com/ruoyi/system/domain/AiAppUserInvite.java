package com.ruoyi.system.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import java.io.Serializable;
import java.util.Date;

/**
 * C端用户邀请关系对象 ai_c_user_invite
 *
 * @author codex
 */
public class AiAppUserInvite implements Serializable
{
    private static final long serialVersionUID = 1L;

    private Long inviteId;

    private Long inviterUserId;

    private Long inviteeUserId;

    private String inviteCode;

    private String inviterUserNo;

    private String inviterNickName;

    private String inviteeUserNo;

    private String inviteeNickName;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    public Long getInviteId()
    {
        return inviteId;
    }

    public void setInviteId(Long inviteId)
    {
        this.inviteId = inviteId;
    }

    public Long getInviterUserId()
    {
        return inviterUserId;
    }

    public void setInviterUserId(Long inviterUserId)
    {
        this.inviterUserId = inviterUserId;
    }

    public Long getInviteeUserId()
    {
        return inviteeUserId;
    }

    public void setInviteeUserId(Long inviteeUserId)
    {
        this.inviteeUserId = inviteeUserId;
    }

    public String getInviteCode()
    {
        return inviteCode;
    }

    public void setInviteCode(String inviteCode)
    {
        this.inviteCode = inviteCode;
    }

    public String getInviterUserNo()
    {
        return inviterUserNo;
    }

    public void setInviterUserNo(String inviterUserNo)
    {
        this.inviterUserNo = inviterUserNo;
    }

    public String getInviterNickName()
    {
        return inviterNickName;
    }

    public void setInviterNickName(String inviterNickName)
    {
        this.inviterNickName = inviterNickName;
    }

    public String getInviteeUserNo()
    {
        return inviteeUserNo;
    }

    public void setInviteeUserNo(String inviteeUserNo)
    {
        this.inviteeUserNo = inviteeUserNo;
    }

    public String getInviteeNickName()
    {
        return inviteeNickName;
    }

    public void setInviteeNickName(String inviteeNickName)
    {
        this.inviteeNickName = inviteeNickName;
    }

    public Date getCreateTime()
    {
        return createTime;
    }

    public void setCreateTime(Date createTime)
    {
        this.createTime = createTime;
    }
}
