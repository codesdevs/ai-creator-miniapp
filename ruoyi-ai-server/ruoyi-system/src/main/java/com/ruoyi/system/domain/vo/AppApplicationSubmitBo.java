package com.ruoyi.system.domain.vo;

import java.util.Map;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

/**
 * 小程序端应用统一提交参数
 */
public class AppApplicationSubmitBo
{
    private Long userId;

    private String clientRequestId;

    private Long appId;

    private String appCode;

    @NotBlank(message = "应用模式不能为空")
    private String modeCode;

    private Long modelId;

    private Long versionId;

    @NotBlank(message = "提示词不能为空")
    private String promptText;

    private String negativePrompt;

    private String styleCode;

    private Long styleId;

    private String ratioCode;

    private String sizeCode;

    private String sourceUrl;

    private Map<String, Object> inputParams;

    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }
    public String getClientRequestId() { return clientRequestId; }
    public void setClientRequestId(String clientRequestId) { this.clientRequestId = clientRequestId; }
    public Long getAppId() { return appId; }
    public void setAppId(Long appId) { this.appId = appId; }
    public String getAppCode() { return appCode; }
    public void setAppCode(String appCode) { this.appCode = appCode; }
    public String getModeCode() { return modeCode; }
    public void setModeCode(String modeCode) { this.modeCode = modeCode; }
    public Long getModelId() { return modelId; }
    public void setModelId(Long modelId) { this.modelId = modelId; }
    public Long getVersionId() { return versionId; }
    public void setVersionId(Long versionId) { this.versionId = versionId; }
    public String getPromptText() { return promptText; }
    public void setPromptText(String promptText) { this.promptText = promptText; }
    public String getNegativePrompt() { return negativePrompt; }
    public void setNegativePrompt(String negativePrompt) { this.negativePrompt = negativePrompt; }
    public String getStyleCode() { return styleCode; }
    public void setStyleCode(String styleCode) { this.styleCode = styleCode; }
    public Long getStyleId() { return styleId; }
    public void setStyleId(Long styleId) { this.styleId = styleId; }
    public String getRatioCode() { return ratioCode; }
    public void setRatioCode(String ratioCode) { this.ratioCode = ratioCode; }
    public String getSizeCode() { return sizeCode; }
    public void setSizeCode(String sizeCode) { this.sizeCode = sizeCode; }
    public String getSourceUrl() { return sourceUrl; }
    public void setSourceUrl(String sourceUrl) { this.sourceUrl = sourceUrl; }
    public Map<String, Object> getInputParams() { return inputParams; }
    public void setInputParams(Map<String, Object> inputParams) { this.inputParams = inputParams; }
}
