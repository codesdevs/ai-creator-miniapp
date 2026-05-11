package com.ruoyi.system.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import com.ruoyi.common.xss.Xss;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

/**
 * AI 渠道模型映射对象 ai_c_channel_model_relation
 */
public class AiChannelModelRelation extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long relationId;
    private Long channelId;
    private String providerName;
    private String channelName;
    private Long modelVersionId;
    private Long modelId;
    private String modelName;
    private String versionName;
    private String apiModelName;
    private String remoteModelName;
    private String enabled;
    private java.math.BigDecimal priceRatio;
    private Integer priority;
    private Integer weight;
    private Integer maxQps;

    public Long getRelationId()
    {
        return relationId;
    }

    public void setRelationId(Long relationId)
    {
        this.relationId = relationId;
    }

    @NotNull(message = "渠道不能为空")
    public Long getChannelId()
    {
        return channelId;
    }

    public void setChannelId(Long channelId)
    {
        this.channelId = channelId;
    }

    public String getProviderName()
    {
        return providerName;
    }

    public void setProviderName(String providerName)
    {
        this.providerName = providerName;
    }

    public String getChannelName()
    {
        return channelName;
    }

    public void setChannelName(String channelName)
    {
        this.channelName = channelName;
    }

    @NotNull(message = "模型版本不能为空")
    public Long getModelVersionId()
    {
        return modelVersionId;
    }

    public void setModelVersionId(Long modelVersionId)
    {
        this.modelVersionId = modelVersionId;
    }

    public Long getModelId()
    {
        return modelId;
    }

    public void setModelId(Long modelId)
    {
        this.modelId = modelId;
    }

    public String getModelName()
    {
        return modelName;
    }

    public void setModelName(String modelName)
    {
        this.modelName = modelName;
    }

    public String getVersionName()
    {
        return versionName;
    }

    public void setVersionName(String versionName)
    {
        this.versionName = versionName;
    }

    public String getApiModelName()
    {
        return apiModelName;
    }

    public void setApiModelName(String apiModelName)
    {
        this.apiModelName = apiModelName;
    }

    @Xss(message = "远程模型名不能包含脚本字符")
    @NotBlank(message = "远程模型名不能为空")
    @Size(max = 128, message = "远程模型名长度不能超过128个字符")
    public String getRemoteModelName()
    {
        return remoteModelName;
    }

    public void setRemoteModelName(String remoteModelName)
    {
        this.remoteModelName = remoteModelName;
    }

    @Size(max = 1, message = "启用状态长度不能超过1个字符")
    public String getEnabled()
    {
        return enabled;
    }

    public void setEnabled(String enabled)
    {
        this.enabled = enabled;
    }

    public java.math.BigDecimal getPriceRatio()
    {
        return priceRatio;
    }

    public void setPriceRatio(java.math.BigDecimal priceRatio)
    {
        this.priceRatio = priceRatio;
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

    public Integer getMaxQps()
    {
        return maxQps;
    }

    public void setMaxQps(Integer maxQps)
    {
        this.maxQps = maxQps;
    }
}
