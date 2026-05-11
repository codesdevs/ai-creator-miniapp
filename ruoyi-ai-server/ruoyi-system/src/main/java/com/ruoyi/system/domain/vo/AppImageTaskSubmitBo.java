package com.ruoyi.system.domain.vo;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

/**
 * 小程序端图片任务提交参数
 *
 * @author codex
 */
public class AppImageTaskSubmitBo
{
    private Long userId;

    @NotNull(message = "模型ID不能为空")
    private Long modelId;

    @NotNull(message = "模型版本ID不能为空")
    private Long versionId;

    @NotBlank(message = "创作模式不能为空")
    private String createMode;

    @NotBlank(message = "提示词不能为空")
    @Size(min = 0, max = 800, message = "提示词长度不能超过800个字符")
    private String promptText;

    private String negativePrompt;

    private String styleCode;

    private String ratioCode;

    private String sourceUrl;

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

    public Long getVersionId()
    {
        return versionId;
    }

    public void setVersionId(Long versionId)
    {
        this.versionId = versionId;
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
}
