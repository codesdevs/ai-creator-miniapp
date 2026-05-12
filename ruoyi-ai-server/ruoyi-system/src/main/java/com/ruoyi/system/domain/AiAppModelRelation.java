package com.ruoyi.system.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import java.util.List;

/**
 * AI 应用模型关系对象 ai_c_app_model_relation
 */
public class AiAppModelRelation extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long relationId;
    private Long appId;
    private Long modelId;
    private Long defaultVersionId;
    private String displayName;
    private String intro;
    private Integer sort;
    private String status;
    private String modelCode;
    private String modelName;
    private String modelType;
    private String provider;
    private List<AiModelVersion> versionList;

    public Long getRelationId() { return relationId; }
    public void setRelationId(Long relationId) { this.relationId = relationId; }
    public Long getAppId() { return appId; }
    public void setAppId(Long appId) { this.appId = appId; }
    public Long getModelId() { return modelId; }
    public void setModelId(Long modelId) { this.modelId = modelId; }
    public Long getDefaultVersionId() { return defaultVersionId; }
    public void setDefaultVersionId(Long defaultVersionId) { this.defaultVersionId = defaultVersionId; }
    public String getDisplayName() { return displayName; }
    public void setDisplayName(String displayName) { this.displayName = displayName; }
    public String getIntro() { return intro; }
    public void setIntro(String intro) { this.intro = intro; }
    public Integer getSort() { return sort; }
    public void setSort(Integer sort) { this.sort = sort; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getModelCode() { return modelCode; }
    public void setModelCode(String modelCode) { this.modelCode = modelCode; }
    public String getModelName() { return modelName; }
    public void setModelName(String modelName) { this.modelName = modelName; }
    public String getModelType() { return modelType; }
    public void setModelType(String modelType) { this.modelType = modelType; }
    public String getProvider() { return provider; }
    public void setProvider(String provider) { this.provider = provider; }
    public List<AiModelVersion> getVersionList() { return versionList; }
    public void setVersionList(List<AiModelVersion> versionList) { this.versionList = versionList; }
}
