package com.ruoyi.system.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * AI 钱包对象 ai_c_wallet
 *
 * @author codex
 */
public class AiWallet extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long walletId;

    private Long userId;

    private Integer balancePower;

    private Integer freezePower;

    private Integer totalRechargePower;

    private Integer totalConsumePower;

    private Integer totalGivePower;

    public Long getWalletId()
    {
        return walletId;
    }

    public void setWalletId(Long walletId)
    {
        this.walletId = walletId;
    }

    public Long getUserId()
    {
        return userId;
    }

    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public Integer getBalancePower()
    {
        return balancePower;
    }

    public void setBalancePower(Integer balancePower)
    {
        this.balancePower = balancePower;
    }

    public Integer getFreezePower()
    {
        return freezePower;
    }

    public void setFreezePower(Integer freezePower)
    {
        this.freezePower = freezePower;
    }

    public Integer getTotalRechargePower()
    {
        return totalRechargePower;
    }

    public void setTotalRechargePower(Integer totalRechargePower)
    {
        this.totalRechargePower = totalRechargePower;
    }

    public Integer getTotalConsumePower()
    {
        return totalConsumePower;
    }

    public void setTotalConsumePower(Integer totalConsumePower)
    {
        this.totalConsumePower = totalConsumePower;
    }

    public Integer getTotalGivePower()
    {
        return totalGivePower;
    }

    public void setTotalGivePower(Integer totalGivePower)
    {
        this.totalGivePower = totalGivePower;
    }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("walletId", getWalletId())
            .append("userId", getUserId())
            .append("balancePower", getBalancePower())
            .append("freezePower", getFreezePower())
            .append("totalRechargePower", getTotalRechargePower())
            .append("totalConsumePower", getTotalConsumePower())
            .append("totalGivePower", getTotalGivePower())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
