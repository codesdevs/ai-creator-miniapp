package com.ruoyi.system.domain;

import com.ruoyi.common.core.domain.BaseEntity;

/**
 * AI 应用模式对象 ai_c_app_mode
 */
public class AiAppMode extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long modeId;
    private Long appId;
    private String modeCode;
    private String modeName;
    private String modeType;
    private String placeholder;
    private String intro;
    private Integer powerCost;
    private String promptTemplate;
    private String formSchema;
    private Integer sort;
    private String status;

    public Long getModeId() { return modeId; }
    public void setModeId(Long modeId) { this.modeId = modeId; }
    public Long getAppId() { return appId; }
    public void setAppId(Long appId) { this.appId = appId; }
    public String getModeCode() { return modeCode; }
    public void setModeCode(String modeCode) { this.modeCode = modeCode; }
    public String getModeName() { return modeName; }
    public void setModeName(String modeName) { this.modeName = modeName; }
    public String getModeType() { return modeType; }
    public void setModeType(String modeType) { this.modeType = modeType; }
    public String getPlaceholder() { return placeholder; }
    public void setPlaceholder(String placeholder) { this.placeholder = placeholder; }
    public String getIntro() { return intro; }
    public void setIntro(String intro) { this.intro = intro; }
    public Integer getPowerCost() { return powerCost; }
    public void setPowerCost(Integer powerCost) { this.powerCost = powerCost; }
    public String getPromptTemplate() { return promptTemplate; }
    public void setPromptTemplate(String promptTemplate) { this.promptTemplate = promptTemplate; }
    public String getFormSchema() { return formSchema; }
    public void setFormSchema(String formSchema) { this.formSchema = formSchema; }
    public Integer getSort() { return sort; }
    public void setSort(Integer sort) { this.sort = sort; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
