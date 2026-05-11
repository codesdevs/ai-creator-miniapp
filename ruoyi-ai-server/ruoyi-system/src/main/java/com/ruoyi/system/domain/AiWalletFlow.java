package com.ruoyi.system.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.domain.BaseEntity;
import java.util.Date;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * AI 钱包流水对象 ai_c_wallet_flow
 *
 * @author codex
 */
public class AiWalletFlow extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long flowId;

    private Long userId;

    private String bizType;

    private Long bizId;

    private String changeType;

    private Integer powerNum;

    private Integer beforeBalance;

    private Integer afterBalance;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    public Long getFlowId()
    {
        return flowId;
    }

    public void setFlowId(Long flowId)
    {
        this.flowId = flowId;
    }

    public Long getUserId()
    {
        return userId;
    }

    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public String getBizType()
    {
        return bizType;
    }

    public void setBizType(String bizType)
    {
        this.bizType = bizType;
    }

    public Long getBizId()
    {
        return bizId;
    }

    public void setBizId(Long bizId)
    {
        this.bizId = bizId;
    }

    public String getChangeType()
    {
        return changeType;
    }

    public void setChangeType(String changeType)
    {
        this.changeType = changeType;
    }

    public Integer getPowerNum()
    {
        return powerNum;
    }

    public void setPowerNum(Integer powerNum)
    {
        this.powerNum = powerNum;
    }

    public Integer getBeforeBalance()
    {
        return beforeBalance;
    }

    public void setBeforeBalance(Integer beforeBalance)
    {
        this.beforeBalance = beforeBalance;
    }

    public Integer getAfterBalance()
    {
        return afterBalance;
    }

    public void setAfterBalance(Integer afterBalance)
    {
        this.afterBalance = afterBalance;
    }

    @Override
    public Date getCreateTime()
    {
        return createTime;
    }

    @Override
    public void setCreateTime(Date createTime)
    {
        this.createTime = createTime;
    }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("flowId", getFlowId())
            .append("userId", getUserId())
            .append("bizType", getBizType())
            .append("bizId", getBizId())
            .append("changeType", getChangeType())
            .append("powerNum", getPowerNum())
            .append("beforeBalance", getBeforeBalance())
            .append("afterBalance", getAfterBalance())
            .append("remark", getRemark())
            .append("createTime", getCreateTime())
            .toString();
    }
}
