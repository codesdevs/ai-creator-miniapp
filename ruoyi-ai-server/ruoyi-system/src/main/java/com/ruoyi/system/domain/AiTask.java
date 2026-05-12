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

    private Long appId;

    private Long modeId;

    private Long styleId;

    private String sizeCode;

    private String inputParams;

    private Long channelId;

    private Long channelModelRelationId;

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

    private String remoteModelName;

    private String failReason;

    private String requestPayload;

    private String responsePayload;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date submitTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date finishTime;

    private String modelName;

    private String versionName;

    private String providerName;

    private String channelName;

    private String nickName;

    private String requestRecorded;

    private String responseRecorded;

    private String processingOnly;

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

    public Long getAppId()
    {
        return appId;
    }

    public void setAppId(Long appId)
    {
        this.appId = appId;
    }

    public Long getModeId()
    {
        return modeId;
    }

    public void setModeId(Long modeId)
    {
        this.modeId = modeId;
    }

    public Long getStyleId()
    {
        return styleId;
    }

    public void setStyleId(Long styleId)
    {
        this.styleId = styleId;
    }

    public String getSizeCode()
    {
        return sizeCode;
    }

    public void setSizeCode(String sizeCode)
    {
        this.sizeCode = sizeCode;
    }

    public String getInputParams()
    {
        return inputParams;
    }

    public void setInputParams(String inputParams)
    {
        this.inputParams = inputParams;
    }

    public Long getChannelId()
    {
        return channelId;
    }

    public void setChannelId(Long channelId)
    {
        this.channelId = channelId;
    }

    public Long getChannelModelRelationId()
    {
        return channelModelRelationId;
    }

    public void setChannelModelRelationId(Long channelModelRelationId)
    {
        this.channelModelRelationId = channelModelRelationId;
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

    public String getRemoteModelName()
    {
        return remoteModelName;
    }

    public void setRemoteModelName(String remoteModelName)
    {
        this.remoteModelName = remoteModelName;
    }

    public String getFailReason()
    {
        return failReason;
    }

    public void setFailReason(String failReason)
    {
        this.failReason = failReason;
    }

    public String getRequestPayload()
    {
        return requestPayload;
    }

    public void setRequestPayload(String requestPayload)
    {
        this.requestPayload = requestPayload;
    }

    public String getResponsePayload()
    {
        return responsePayload;
    }

    public void setResponsePayload(String responsePayload)
    {
        this.responsePayload = responsePayload;
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

    public String getNickName()
    {
        return nickName;
    }

    public void setNickName(String nickName)
    {
        this.nickName = nickName;
    }

    public String getRequestRecorded()
    {
        return requestRecorded;
    }

    public void setRequestRecorded(String requestRecorded)
    {
        this.requestRecorded = requestRecorded;
    }

    public String getResponseRecorded()
    {
        return responseRecorded;
    }

    public void setResponseRecorded(String responseRecorded)
    {
        this.responseRecorded = responseRecorded;
    }

    public String getProcessingOnly()
    {
        return processingOnly;
    }

    public void setProcessingOnly(String processingOnly)
    {
        this.processingOnly = processingOnly;
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
            .append("appId", getAppId())
            .append("modeId", getModeId())
            .append("styleId", getStyleId())
            .append("sizeCode", getSizeCode())
            .append("inputParams", getInputParams())
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
            .append("requestPayload", getRequestPayload())
            .append("responsePayload", getResponsePayload())
            .append("providerName", getProviderName())
            .append("channelName", getChannelName())
            .append("nickName", getNickName())
            .append("requestRecorded", getRequestRecorded())
            .append("responseRecorded", getResponseRecorded())
            .append("processingOnly", getProcessingOnly())
            .append("submitTime", getSubmitTime())
            .append("finishTime", getFinishTime())
            .append("createTime", getCreateTime())
            .toString();
    }
}
