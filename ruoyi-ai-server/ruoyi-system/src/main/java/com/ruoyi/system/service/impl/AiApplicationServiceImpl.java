package com.ruoyi.system.service.impl;

import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.system.domain.AiApp;
import com.ruoyi.system.domain.AiAppCategory;
import com.ruoyi.system.domain.AiAppHomeSection;
import com.ruoyi.system.domain.AiAppModelRelation;
import com.ruoyi.system.domain.AiModelVersion;
import com.ruoyi.system.mapper.AiApplicationMapper;
import com.ruoyi.system.service.IAiApplicationService;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 小程序 AI 应用配置 服务层实现
 */
@Service
public class AiApplicationServiceImpl implements IAiApplicationService
{
    @Autowired
    private AiApplicationMapper aiApplicationMapper;

    @Override
    public Map<String, Object> selectHome()
    {
        List<AiAppCategory> categoryList = aiApplicationMapper.selectEnabledCategoryList();
        for (AiAppCategory category : categoryList)
        {
            category.getParams().put("appList", aiApplicationMapper.selectEnabledAppListByCategoryId(category.getCategoryId()));
        }

        List<AiAppHomeSection> sectionList = aiApplicationMapper.selectEnabledHomeSectionList();
        for (AiAppHomeSection section : sectionList)
        {
            section.getParams().put("cardList", aiApplicationMapper.selectEnabledHomeCardListBySectionId(section.getSectionId()));
        }

        Map<String, Object> result = new HashMap<>();
        result.put("bannerList", List.of(Map.of("imageUrl", "/static/images/banner_home.png", "actionType", "NONE")));
        result.put("sectionList", sectionList);
        result.put("categoryList", categoryList);
        return result;
    }

    @Override
    public Map<String, Object> selectDetail(Long appId, String appCode)
    {
        AiApp app = aiApplicationMapper.selectEnabledApp(appId, appCode);
        if (app == null)
        {
            throw new ServiceException("应用不存在或已下架");
        }

        List<AiAppModelRelation> modelList = aiApplicationMapper.selectEnabledModelListByAppId(app.getAppId());
        for (AiAppModelRelation model : modelList)
        {
            List<AiModelVersion> versionList = aiApplicationMapper.selectEnabledVersionListByModelId(model.getModelId());
            for (AiModelVersion version : versionList)
            {
                version.getParams().put("styleList", aiApplicationMapper.selectEnabledStyleListByVersionId(version.getVersionId()));
            }
            model.setVersionList(versionList);
        }

        Map<String, Object> result = new HashMap<>();
        result.put("app", app);
        result.put("modeList", aiApplicationMapper.selectEnabledModeListByAppId(app.getAppId()));
        result.put("modelList", modelList);
        return result;
    }
}
