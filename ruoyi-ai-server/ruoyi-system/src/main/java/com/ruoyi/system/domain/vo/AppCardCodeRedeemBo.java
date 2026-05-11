package com.ruoyi.system.domain.vo;

import jakarta.validation.constraints.NotBlank;

/**
 * 小程序端卡密兑换参数
 *
 * @author codex
 */
public class AppCardCodeRedeemBo
{
    @NotBlank(message = "卡密不能为空")
    private String cardCode;

    public String getCardCode()
    {
        return cardCode;
    }

    public void setCardCode(String cardCode)
    {
        this.cardCode = cardCode;
    }
}
