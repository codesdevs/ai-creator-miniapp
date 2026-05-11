package com.ruoyi.system.domain.vo;

import jakarta.validation.constraints.NotNull;

/**
 * 小程序端充值下单参数
 *
 * @author codex
 */
public class AppRechargeSubmitBo
{
    @NotNull(message = "套餐ID不能为空")
    private Long packageId;

    private Long payConfigId;

    public Long getPackageId()
    {
        return packageId;
    }

    public void setPackageId(Long packageId)
    {
        this.packageId = packageId;
    }

    public Long getPayConfigId()
    {
        return payConfigId;
    }

    public void setPayConfigId(Long payConfigId)
    {
        this.payConfigId = payConfigId;
    }
}
