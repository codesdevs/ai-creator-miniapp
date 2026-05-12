package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.AiApp;
import com.ruoyi.system.domain.AiAppCategory;
import com.ruoyi.system.domain.AiAppHomeCard;
import com.ruoyi.system.domain.AiAppHomeSection;
import com.ruoyi.system.domain.AiAppMode;
import com.ruoyi.system.domain.AiAppModelRelation;
import com.ruoyi.system.domain.AiModelVersion;
import com.ruoyi.system.domain.AiStylePreset;
import java.util.List;
import org.apache.ibatis.annotations.Param;

/**
 * 小程序 AI 应用配置 数据层
 */
public interface AiApplicationMapper
{
    public List<AiAppCategory> selectEnabledCategoryList();

    public List<AiAppHomeSection> selectEnabledHomeSectionList();

    public List<AiAppHomeCard> selectEnabledHomeCardListBySectionId(Long sectionId);

    public List<AiApp> selectEnabledAppListByCategoryId(Long categoryId);

    public AiApp selectEnabledApp(@Param("appId") Long appId, @Param("appCode") String appCode);

    public List<AiAppMode> selectEnabledModeListByAppId(Long appId);

    public List<AiAppModelRelation> selectEnabledModelListByAppId(Long appId);

    public List<AiModelVersion> selectEnabledVersionListByModelId(Long modelId);

    public List<AiStylePreset> selectEnabledStyleListByVersionId(Long versionId);
}
