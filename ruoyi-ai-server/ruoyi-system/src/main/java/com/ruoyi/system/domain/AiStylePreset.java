package com.ruoyi.system.domain;

import com.ruoyi.common.core.domain.BaseEntity;

/**
 * AI 风格预设对象 ai_c_style_preset
 */
public class AiStylePreset extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long styleId;
    private String styleCode;
    private String styleName;
    private String styleType;
    private String coverUrl;
    private String promptSuffix;
    private Integer sort;
    private String status;

    public Long getStyleId() { return styleId; }
    public void setStyleId(Long styleId) { this.styleId = styleId; }
    public String getStyleCode() { return styleCode; }
    public void setStyleCode(String styleCode) { this.styleCode = styleCode; }
    public String getStyleName() { return styleName; }
    public void setStyleName(String styleName) { this.styleName = styleName; }
    public String getStyleType() { return styleType; }
    public void setStyleType(String styleType) { this.styleType = styleType; }
    public String getCoverUrl() { return coverUrl; }
    public void setCoverUrl(String coverUrl) { this.coverUrl = coverUrl; }
    public String getPromptSuffix() { return promptSuffix; }
    public void setPromptSuffix(String promptSuffix) { this.promptSuffix = promptSuffix; }
    public Integer getSort() { return sort; }
    public void setSort(Integer sort) { this.sort = sort; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
