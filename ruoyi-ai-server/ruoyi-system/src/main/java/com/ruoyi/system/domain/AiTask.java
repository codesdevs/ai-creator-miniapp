package com.ruoyi.system.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.Date;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * AI 任务对象 ai_c_task
 *
 * @author codex
 */
public class AiTask extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long taskId;

    private String taskNo;

    private Long userId;

    private Long modelId;

    private Long modelVersionId;

    private String taskType;

    private String createMode;

    private String promptText;

    private String negativePrompt;

    private String styleCode;

    private String ratioCode;

    private String sourceUrl;

    private String status;

    private Integer powerCost;

    private String thirdTaskId;

    private String failReason;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date submitTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date finishTime;

    private String modelName;

    private String versionName;

    public Long getTaskId()
    {
        return taskId;
    }

    public void setTaskId(Long taskId)
    {
        this.taskId = taskId;
    }

    public String getTaskNo()
    {
        return taskNo;
    }

    public void setTaskNo(String taskNo)
    {
        this.taskNo = taskNo;
    }

    public Long getUserId()
    {
        return userId;
    }

    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public Long getModelId()
    {
        return modelId;
    }

    public void setModelId(Long modelId)
    {
        this.modelId = modelId;
    }

    public Long getModelVersionId()
    {
        return modelVersionId;
    }

    public void setModelVersionId(Long modelVersionId)
    {
        this.modelVersionId = modelVersionId;
    }

    public String getTaskType()
    {
        return taskType;
    }

    public void setTaskType(String taskType)
    {
        this.taskType = taskType;
    }

    public String getCreateMode()
    {
        return createMode;
    }

    public void setCreateMode(String createMode)
    {
        this.createMode = createMode;
    }

    public String getPromptText()
    {
        return promptText;
    }

    public void setPromptText(String promptText)
    {
        this.promptText = promptText;
    }

    public String getNegativePrompt()
    {
        return negativePrompt;
    }

    public void setNegativePrompt(String negativePrompt)
    {
        this.negativePrompt = negativePrompt;
    }

    public String getStyleCode()
    {
        return styleCode;
    }

    public void setStyleCode(String styleCode)
    {
        this.styleCode = styleCode;
    }

    public String getRatioCode()
    {
        return ratioCode;
    }

    public void setRatioCode(String ratioCode)
    {
        this.ratioCode = ratioCode;
    }

    public String getSourceUrl()
    {
        return sourceUrl;
    }

    public void setSourceUrl(String sourceUrl)
    {
        this.sourceUrl = sourceUrl;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public Integer getPowerCost()
    {
        return powerCost;
    }

    public void setPowerCost(Integer powerCost)
    {
        this.powerCost = powerCost;
    }

    public String getThirdTaskId()
    {
        return thirdTaskId;
    }

    public void setThirdTaskId(String thirdTaskId)
    {
        this.thirdTaskId = thirdTaskId;
    }

    public String getFailReason()
    {
        return failReason;
    }

    public void setFailReason(String failReason)
    {
        this.failReason = failReason;
    }

    public Date getSubmitTime()
    {
        return submitTime;
    }

    public void setSubmitTime(Date submitTime)
    {
        this.submitTime = submitTime;
    }

    public Date getFinishTime()
    {
        return finishTime;
    }

    public void setFinishTime(Date finishTime)
    {
        this.finishTime = finishTime;
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

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
            .append("taskId", getTaskId())
            .append("taskNo", getTaskNo())
            .append("userId", getUserId())
            .append("modelId", getModelId())
            .append("modelVersionId", getModelVersionId())
            .append("taskType", getTaskType())
            .append("createMode", getCreateMode())
            .append("promptText", getPromptText())
            .append("negativePrompt", getNegativePrompt())
            .append("styleCode", getStyleCode())
            .append("ratioCode", getRatioCode())
            .append("sourceUrl", getSourceUrl())
            .append("status", getStatus())
            .append("powerCost", getPowerCost())
            .append("thirdTaskId", getThirdTaskId())
            .append("failReason", getFailReason())
            .append("submitTime", getSubmitTime())
            .append("finishTime", getFinishTime())
            .append("createTime", getCreateTime())
            .toString();
    }
}
