package com.ruoyi.system.domain;

import com.ruoyi.common.core.domain.BaseEntity;

/**
 * AI 应用首页卡片对象 ai_c_app_home_card
 */
public class AiAppHomeCard extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long cardId;
    private Long sectionId;
    private Long appId;
    private String cardCode;
    private String cardName;
    private String subtitle;
    private String cardImageUrl;
    private String actionType;
    private String actionValue;
    private String extraConfig;
    private Integer sort;
    private String status;

    public Long getCardId() { return cardId; }
    public void setCardId(Long cardId) { this.cardId = cardId; }
    public Long getSectionId() { return sectionId; }
    public void setSectionId(Long sectionId) { this.sectionId = sectionId; }
    public Long getAppId() { return appId; }
    public void setAppId(Long appId) { this.appId = appId; }
    public String getCardCode() { return cardCode; }
    public void setCardCode(String cardCode) { this.cardCode = cardCode; }
    public String getCardName() { return cardName; }
    public void setCardName(String cardName) { this.cardName = cardName; }
    public String getSubtitle() { return subtitle; }
    public void setSubtitle(String subtitle) { this.subtitle = subtitle; }
    public String getCardImageUrl() { return cardImageUrl; }
    public void setCardImageUrl(String cardImageUrl) { this.cardImageUrl = cardImageUrl; }
    public String getActionType() { return actionType; }
    public void setActionType(String actionType) { this.actionType = actionType; }
    public String getActionValue() { return actionValue; }
    public void setActionValue(String actionValue) { this.actionValue = actionValue; }
    public String getExtraConfig() { return extraConfig; }
    public void setExtraConfig(String extraConfig) { this.extraConfig = extraConfig; }
    public Integer getSort() { return sort; }
    public void setSort(Integer sort) { this.sort = sort; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
