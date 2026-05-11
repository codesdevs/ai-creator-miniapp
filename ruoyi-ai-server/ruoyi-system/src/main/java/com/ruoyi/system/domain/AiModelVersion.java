package com.ruoyi.system.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * AI 模型版本对象 ai_c_model_version
 *
 * @author codex
 */
public class AiModelVersion extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 版本ID */
    private Long versionId;

    /** 模型ID */
    private Long modelId;

    /** 版本编码 */
    private String versionCode;

    /** 版本名称 */
    private String versionName;

    /** 单次消耗算力 */
    private Integer powerCost;

    /** 支持比例 */
    private String supportRatio;

    /** 支持风格 */
    private String supportStyle;

    /** 支持模式 */
    private String supportMode;

    /** 扩展配置 */
    private String extConfig;

    /** 状态 */
    private String status;

    /** 模型名称，仅用于列表展示 */
    private String modelName;

    public Long getVersionId()
    {
        return versionId;
    }

    public void setVersionId(Long versionId)
    {
        this.versionId = versionId;
    }

    @NotNull(message = "模型ID不能为空")
    public Long getModelId()
    {
        return modelId;
    }

    public void setModelId(Long modelId)
    {
        this.modelId = modelId;
    }

    @NotBlank(message = "版本编码不能为空")
    @Size(min = 0, max = 64, message = "版本编码长度不能超过64个字符")
    public String getVersionCode()
    {
        return versionCode;
    }

    public void setVersionCode(String versionCode)
    {
        this.versionCode = versionCode;
    }

    @NotBlank(message = "版本名称不能为空")
    @Size(min = 0, max = 64, message = "版本名称长度不能超过64个字符")
    public String getVersionName()
    {
        return versionName;
    }

    public void setVersionName(String versionName)
    {
        this.versionName = versionName;
    }

    public Integer getPowerCost()
    {
        return powerCost;
    }

    public void setPowerCost(Integer powerCost)
    {
        this.powerCost = powerCost;
    }

    public String getSupportRatio()
    {
        return supportRatio;
    }

    public void setSupportRatio(String supportRatio)
    {
        this.supportRatio = supportRatio;
    }

    public String getSupportStyle()
    {
        return supportStyle;
    }

    public void setSupportStyle(String supportStyle)
    {
        this.supportStyle = supportStyle;
    }

    public String getSupportMode()
    {
        return supportMode;
    }

    public void setSupportMode(String supportMode)
    {
        this.supportMode = supportMode;
    }

    public String getExtConfig()
    {
        return extConfig;
    }

    public void setExtConfig(String extConfig)
    {
        this.extConfig = extConfig;
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

    public String getModelName()
    {
        return modelName;
    }

    public void setModelName(String modelName)
    {
        this.modelName = modelName;
    }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("versionId", getVersionId())
            .append("modelId", getModelId())
            .append("versionCode", getVersionCode())
            .append("versionName", getVersionName())
            .append("powerCost", getPowerCost())
            .append("supportRatio", getSupportRatio())
            .append("supportStyle", getSupportStyle())
            .append("supportMode", getSupportMode())
            .append("extConfig", getExtConfig())
            .append("status", getStatus())
            .append("remark", getRemark())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}
