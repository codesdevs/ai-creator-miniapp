package com.ruoyi.system.domain;

import com.ruoyi.common.core.domain.BaseEntity;

/**
 * AI 应用对象 ai_c_app
 */
public class AiApp extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long appId;
    private Long categoryId;
    private String appCode;
    private String appName;
    private String appType;
    private String abilityType;
    private String iconUrl;
    private String cardImageUrl;
    private String description;
    private String intro;
    private String routeUrl;
    private Long modelId;
    private Long modelVersionId;
    private String pricingMode;
    private Integer powerCost;
    private String tags;
    private String formSchema;
    private String isHot;
    private String isRecommend;
    private Integer sort;
    private String status;

    public Long getAppId() { return appId; }
    public void setAppId(Long appId) { this.appId = appId; }
    public Long getCategoryId() { return categoryId; }
    public void setCategoryId(Long categoryId) { this.categoryId = categoryId; }
    public String getAppCode() { return appCode; }
    public void setAppCode(String appCode) { this.appCode = appCode; }
    public String getAppName() { return appName; }
    public void setAppName(String appName) { this.appName = appName; }
    public String getAppType() { return appType; }
    public void setAppType(String appType) { this.appType = appType; }
    public String getAbilityType() { return abilityType; }
    public void setAbilityType(String abilityType) { this.abilityType = abilityType; }
    public String getIconUrl() { return iconUrl; }
    public void setIconUrl(String iconUrl) { this.iconUrl = iconUrl; }
    public String getCardImageUrl() { return cardImageUrl; }
    public void setCardImageUrl(String cardImageUrl) { this.cardImageUrl = cardImageUrl; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getIntro() { return intro; }
    public void setIntro(String intro) { this.intro = intro; }
    public String getRouteUrl() { return routeUrl; }
    public void setRouteUrl(String routeUrl) { this.routeUrl = routeUrl; }
    public Long getModelId() { return modelId; }
    public void setModelId(Long modelId) { this.modelId = modelId; }
    public Long getModelVersionId() { return modelVersionId; }
    public void setModelVersionId(Long modelVersionId) { this.modelVersionId = modelVersionId; }
    public String getPricingMode() { return pricingMode; }
    public void setPricingMode(String pricingMode) { this.pricingMode = pricingMode; }
    public Integer getPowerCost() { return powerCost; }
    public void setPowerCost(Integer powerCost) { this.powerCost = powerCost; }
    public String getTags() { return tags; }
    public void setTags(String tags) { this.tags = tags; }
    public String getFormSchema() { return formSchema; }
    public void setFormSchema(String formSchema) { this.formSchema = formSchema; }
    public String getIsHot() { return isHot; }
    public void setIsHot(String isHot) { this.isHot = isHot; }
    public String getIsRecommend() { return isRecommend; }
    public void setIsRecommend(String isRecommend) { this.isRecommend = isRecommend; }
    public Integer getSort() { return sort; }
    public void setSort(Integer sort) { this.sort = sort; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
