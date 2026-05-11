package com.ruoyi.system.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ruoyi.common.core.domain.BaseEntity;
import com.ruoyi.common.xss.Xss;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * AI 提供商渠道对象 ai_c_provider_channel
 */
public class AiProviderChannel extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long channelId;

    private Long providerId;

    private String providerName;

    private String channelName;

    private String channelCode;

    private String baseUrl;

    private String apiKey;

    private String apiSecret;

    private String proxyEnabled;

    private Integer priority;

    private Integer weight;

    private Integer timeoutMs;

    private Integer maxConcurrency;

    private Integer rpmLimit;

    private Integer tpmLimit;

    private String isFallback;

    private String healthStatus;

    private String status;

    public Long getChannelId()
    {
        return channelId;
    }

    public void setChannelId(Long channelId)
    {
        this.channelId = channelId;
    }

    @NotNull(message = "所属提供商不能为空")
    public Long getProviderId()
    {
        return providerId;
    }

    public void setProviderId(Long providerId)
    {
        this.providerId = providerId;
    }

    public String getProviderName()
    {
        return providerName;
    }

    public void setProviderName(String providerName)
    {
        this.providerName = providerName;
    }

    @Xss(message = "渠道名称不能包含脚本字符")
    @NotBlank(message = "渠道名称不能为空")
    @Size(max = 64, message = "渠道名称长度不能超过64个字符")
    public String getChannelName()
    {
        return channelName;
    }

    public void setChannelName(String channelName)
    {
        this.channelName = channelName;
    }

    @Xss(message = "渠道编码不能包含脚本字符")
    @NotBlank(message = "渠道编码不能为空")
    @Size(max = 64, message = "渠道编码长度不能超过64个字符")
    public String getChannelCode()
    {
        return channelCode;
    }

    public void setChannelCode(String channelCode)
    {
        this.channelCode = channelCode;
    }

    @NotBlank(message = "基础地址不能为空")
    @Size(max = 255, message = "基础地址长度不能超过255个字符")
    public String getBaseUrl()
    {
        return baseUrl;
    }

    public void setBaseUrl(String baseUrl)
    {
        this.baseUrl = baseUrl;
    }

    @Size(max = 512, message = "API Key长度不能超过512个字符")
    public String getApiKey()
    {
        return apiKey;
    }

    public void setApiKey(String apiKey)
    {
        this.apiKey = apiKey;
    }

    @JsonIgnore
    @Size(max = 512, message = "API Secret长度不能超过512个字符")
    public String getApiSecret()
    {
        return apiSecret;
    }

    public void setApiSecret(String apiSecret)
    {
        this.apiSecret = apiSecret;
    }

    @Size(max = 1, message = "代理开关长度不能超过1个字符")
    public String getProxyEnabled()
    {
        return proxyEnabled;
    }

    public void setProxyEnabled(String proxyEnabled)
    {
        this.proxyEnabled = proxyEnabled;
    }

    public Integer getPriority()
    {
        return priority;
    }

    public void setPriority(Integer priority)
    {
        this.priority = priority;
    }

    public Integer getWeight()
    {
        return weight;
    }

    public void setWeight(Integer weight)
    {
        this.weight = weight;
    }

    public Integer getTimeoutMs()
    {
        return timeoutMs;
    }

    public void setTimeoutMs(Integer timeoutMs)
    {
        this.timeoutMs = timeoutMs;
    }

    public Integer getMaxConcurrency()
    {
        return maxConcurrency;
    }

    public void setMaxConcurrency(Integer maxConcurrency)
    {
        this.maxConcurrency = maxConcurrency;
    }

    public Integer getRpmLimit()
    {
        return rpmLimit;
    }

    public void setRpmLimit(Integer rpmLimit)
    {
        this.rpmLimit = rpmLimit;
    }

    public Integer getTpmLimit()
    {
        return tpmLimit;
    }

    public void setTpmLimit(Integer tpmLimit)
    {
        this.tpmLimit = tpmLimit;
    }

    @Size(max = 1, message = "兜底渠道长度不能超过1个字符")
    public String getIsFallback()
    {
        return isFallback;
    }

    public void setIsFallback(String isFallback)
    {
        this.isFallback = isFallback;
    }

    @Size(max = 20, message = "健康状态长度不能超过20个字符")
    public String getHealthStatus()
    {
        return healthStatus;
    }

    public void setHealthStatus(String healthStatus)
    {
        this.healthStatus = healthStatus;
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
            .append("channelId", getChannelId())
            .append("providerId", getProviderId())
            .append("providerName", getProviderName())
            .append("channelName", getChannelName())
            .append("channelCode", getChannelCode())
            .append("baseUrl", getBaseUrl())
            .append("proxyEnabled", getProxyEnabled())
            .append("priority", getPriority())
            .append("weight", getWeight())
            .append("timeoutMs", getTimeoutMs())
            .append("maxConcurrency", getMaxConcurrency())
            .append("rpmLimit", getRpmLimit())
            .append("tpmLimit", getTpmLimit())
            .append("isFallback", getIsFallback())
            .append("healthStatus", getHealthStatus())
            .append("status", getStatus())
            .append("remark", getRemark())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
