package com.ruoyi.system.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import com.ruoyi.common.xss.Xss;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * AI 提供商对象 ai_c_provider
 */
public class AiProvider extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long providerId;

    private String providerName;

    private String providerCode;

    private String providerType;

    private String icon;

    private String website;

    private String status;

    public Long getProviderId()
    {
        return providerId;
    }

    public void setProviderId(Long providerId)
    {
        this.providerId = providerId;
    }

    @Xss(message = "提供商名称不能包含脚本字符")
    @NotBlank(message = "提供商名称不能为空")
    @Size(max = 64, message = "提供商名称长度不能超过64个字符")
    public String getProviderName()
    {
        return providerName;
    }

    public void setProviderName(String providerName)
    {
        this.providerName = providerName;
    }

    @Xss(message = "提供商编码不能包含脚本字符")
    @NotBlank(message = "提供商编码不能为空")
    @Size(max = 64, message = "提供商编码长度不能超过64个字符")
    public String getProviderCode()
    {
        return providerCode;
    }

    public void setProviderCode(String providerCode)
    {
        this.providerCode = providerCode;
    }

    @Size(max = 20, message = "提供商类型长度不能超过20个字符")
    public String getProviderType()
    {
        return providerType;
    }

    public void setProviderType(String providerType)
    {
        this.providerType = providerType;
    }

    @Size(max = 255, message = "图标长度不能超过255个字符")
    public String getIcon()
    {
        return icon;
    }

    public void setIcon(String icon)
    {
        this.icon = icon;
    }

    @Size(max = 255, message = "官网地址长度不能超过255个字符")
    public String getWebsite()
    {
        return website;
    }

    public void setWebsite(String website)
    {
        this.website = website;
    }

    @Size(max = 1, message = "状态长度不能超过1个字符")
    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("providerId", getProviderId())
            .append("providerName", getProviderName())
            .append("providerCode", getProviderCode())
            .append("providerType", getProviderType())
            .append("icon", getIcon())
            .append("website", getWebsite())
            .append("status", getStatus())
            .append("remark", getRemark())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
