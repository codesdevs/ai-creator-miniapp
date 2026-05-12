package com.ruoyi.system.service.impl;

import com.alibaba.fastjson2.JSON;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.system.domain.AiApp;
import com.ruoyi.system.domain.AiAppCategory;
import com.ruoyi.system.domain.AiAppHomeSection;
import com.ruoyi.system.domain.AiAppMode;
import com.ruoyi.system.domain.AiAppModelRelation;
import com.ruoyi.system.domain.AiModelVersion;
import com.ruoyi.system.domain.AiTask;
import com.ruoyi.system.domain.vo.AppApplicationSubmitBo;
import com.ruoyi.system.domain.vo.AppImageTaskSubmitBo;
import com.ruoyi.system.mapper.AiApplicationMapper;
import com.ruoyi.system.service.IAiApplicationService;
import com.ruoyi.system.service.IAiTaskService;
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

    @Autowired
    private IAiTaskService aiTaskService;

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

    @Override
    public AiTask submitApplication(AppApplicationSubmitBo bo)
    {
        AiApp app = aiApplicationMapper.selectEnabledApp(bo.getAppId(), bo.getAppCode());
        if (app == null)
        {
            throw new ServiceException("应用不存在或已下架");
        }
        AiAppMode mode = findMode(app.getAppId(), bo.getModeCode());
        if (!"IMAGE".equals(app.getAbilityType()))
        {
            throw new ServiceException("当前应用类型暂未接入提交链路");
        }
        if (bo.getModelId() == null || bo.getVersionId() == null)
        {
            throw new ServiceException("请选择模型和版本");
        }
        assertAppModelVersionAllowed(app.getAppId(), bo.getModelId(), bo.getVersionId());

        AppImageTaskSubmitBo imageBo = new AppImageTaskSubmitBo();
        imageBo.setUserId(bo.getUserId());
        imageBo.setClientRequestId(bo.getClientRequestId());
        imageBo.setAppId(app.getAppId());
        imageBo.setModeId(mode.getModeId());
        imageBo.setModelId(bo.getModelId());
        imageBo.setVersionId(bo.getVersionId());
        imageBo.setCreateMode(mode.getModeType());
        imageBo.setPromptText(bo.getPromptText());
        imageBo.setNegativePrompt(bo.getNegativePrompt());
        imageBo.setStyleCode(bo.getStyleCode());
        imageBo.setStyleId(bo.getStyleId());
        imageBo.setRatioCode(bo.getRatioCode());
        imageBo.setSizeCode(bo.getSizeCode());
        imageBo.setSourceUrl(bo.getSourceUrl());
        imageBo.setInputParams(bo.getInputParams() == null ? null : JSON.toJSONString(bo.getInputParams()));
        return aiTaskService.submitImageTask(imageBo);
    }

    private AiAppMode findMode(Long appId, String modeCode)
    {
        return aiApplicationMapper.selectEnabledModeListByAppId(appId).stream()
            .filter(item -> modeCode.equals(item.getModeCode()))
            .findFirst()
            .orElseThrow(() -> new ServiceException("应用模式不存在或已停用"));
    }

    private void assertAppModelVersionAllowed(Long appId, Long modelId, Long versionId)
    {
        List<AiAppModelRelation> modelList = aiApplicationMapper.selectEnabledModelListByAppId(appId);
        AiAppModelRelation relation = modelList.stream()
            .filter(item -> modelId.equals(item.getModelId()))
            .findFirst()
            .orElseThrow(() -> new ServiceException("当前应用不支持该模型"));
        boolean versionAllowed = aiApplicationMapper.selectEnabledVersionListByModelId(relation.getModelId()).stream()
            .anyMatch(item -> versionId.equals(item.getVersionId()));
        if (!versionAllowed)
        {
            throw new ServiceException("当前应用不支持该模型版本");
        }
    }
}
