package com.ruoyi.system.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import com.ruoyi.common.xss.Xss;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * AI 模型配置对象 ai_c_model
 *
 * @author codex
 */
public class AiModel extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 模型ID */
    private Long modelId;

    /** 模型编码 */
    private String modelCode;

    /** 模型名称 */
    private String modelName;

    /** 模型类型 */
    private String modelType;

    /** 兼容旧字段：服务商编码/名称 */
    private String provider;

    /** 官方提供商ID */
    private Long officialProviderId;

    /** 提供商名称 */
    private String providerName;

    /** 能力标签 */
    private String capabilities;

    /** 封面地址 */
    private String coverUrl;

    /** 模型简介 */
    private String intro;

    /** 状态 */
    private String status;

    /** 排序 */
    private Integer sort;

    public Long getModelId()
    {
        return modelId;
    }

    public void setModelId(Long modelId)
    {
        this.modelId = modelId;
    }

    @Xss(message = "模型编码不能包含脚本字符")
    @NotBlank(message = "模型编码不能为空")
    @Size(min = 0, max = 64, message = "模型编码长度不能超过64个字符")
    public String getModelCode()
    {
        return modelCode;
    }

    public void setModelCode(String modelCode)
    {
        this.modelCode = modelCode;
    }

    @Xss(message = "模型名称不能包含脚本字符")
    @NotBlank(message = "模型名称不能为空")
    @Size(min = 0, max = 64, message = "模型名称长度不能超过64个字符")
    public String getModelName()
    {
        return modelName;
    }

    public void setModelName(String modelName)
    {
        this.modelName = modelName;
    }

    @NotBlank(message = "模型类型不能为空")
    @Size(min = 0, max = 20, message = "模型类型长度不能超过20个字符")
    public String getModelType()
    {
        return modelType;
    }

    public void setModelType(String modelType)
    {
        this.modelType = modelType;
    }

    @Size(min = 0, max = 32, message = "服务商长度不能超过32个字符")
    public String getProvider()
    {
        return provider;
    }

    public void setProvider(String provider)
    {
        this.provider = provider;
    }

    public Long getOfficialProviderId()
    {
        return officialProviderId;
    }

    public void setOfficialProviderId(Long officialProviderId)
    {
        this.officialProviderId = officialProviderId;
    }

    public String getProviderName()
    {
        return providerName;
    }

    public void setProviderName(String providerName)
    {
        this.providerName = providerName;
    }

    @Size(min = 0, max = 2000, message = "能力标签长度不能超过2000个字符")
    public String getCapabilities()
    {
        return capabilities;
    }

    public void setCapabilities(String capabilities)
    {
        this.capabilities = capabilities;
    }

    @Size(min = 0, max = 255, message = "封面地址长度不能超过255个字符")
    public String getCoverUrl()
    {
        return coverUrl;
    }

    public void setCoverUrl(String coverUrl)
    {
        this.coverUrl = coverUrl;
    }

    @Size(min = 0, max = 255, message = "模型简介长度不能超过255个字符")
    public String getIntro()
    {
        return intro;
    }

    public void setIntro(String intro)
    {
        this.intro = intro;
    }

    @Size(min = 0, max = 1, message = "状态长度不能超过1个字符")
    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public Integer getSort()
    {
        return sort;
    }

    public void setSort(Integer sort)
    {
        this.sort = sort;
    }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("modelId", getModelId())
            .append("modelCode", getModelCode())
            .append("modelName", getModelName())
            .append("modelType", getModelType())
            .append("provider", getProvider())
            .append("officialProviderId", getOfficialProviderId())
            .append("providerName", getProviderName())
            .append("capabilities", getCapabilities())
            .append("coverUrl", getCoverUrl())
            .append("intro", getIntro())
            .append("status", getStatus())
            .append("sort", getSort())
            .append("remark", getRemark())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
