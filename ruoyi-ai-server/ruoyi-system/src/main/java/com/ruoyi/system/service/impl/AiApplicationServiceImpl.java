package com.ruoyi.system.service.impl;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.uuid.IdUtils;
import com.ruoyi.system.domain.AiApp;
import com.ruoyi.system.domain.AiAppCategory;
import com.ruoyi.system.domain.AiAppHomeSection;
import com.ruoyi.system.domain.AiAppMode;
import com.ruoyi.system.domain.AiAppModelRelation;
import com.ruoyi.system.domain.AiModelVersion;
import com.ruoyi.system.domain.AiTask;
import com.ruoyi.system.domain.AiTaskResult;
import com.ruoyi.system.domain.vo.AppApplicationSubmitBo;
import com.ruoyi.system.domain.vo.AppImageTaskSubmitBo;
import com.ruoyi.system.mapper.AiApplicationMapper;
import com.ruoyi.system.mapper.AiTaskMapper;
import com.ruoyi.system.mapper.AiTaskResultMapper;
import com.ruoyi.system.service.IAiApplicationService;
import com.ruoyi.system.service.IAiTaskService;
import com.ruoyi.system.service.IAiWalletService;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

    @Autowired
    private AiTaskMapper aiTaskMapper;

    @Autowired
    private AiTaskResultMapper aiTaskResultMapper;

    @Autowired
    private IAiWalletService aiWalletService;

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
    @Transactional(rollbackFor = Exception.class)
    public AiTask submitApplication(AppApplicationSubmitBo bo)
    {
        AiApp app = aiApplicationMapper.selectEnabledApp(bo.getAppId(), bo.getAppCode());
        if (app == null)
        {
            throw new ServiceException("应用不存在或已下架");
        }
        AiAppMode mode = findMode(app.getAppId(), bo.getModeCode());
        if ("TEXT".equals(app.getAbilityType()))
        {
            return submitTextApplication(app, mode, bo);
        }
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

    private AiTask submitTextApplication(AiApp app, AiAppMode mode, AppApplicationSubmitBo bo)
    {
        AiAppModelRelation relation = selectSubmitRelation(app.getAppId(), bo.getModelId());
        Long versionId = bo.getVersionId() == null ? relation.getDefaultVersionId() : bo.getVersionId();
        if (versionId == null)
        {
            throw new ServiceException("文本应用未配置默认模型版本");
        }
        assertAppModelVersionAllowed(app.getAppId(), relation.getModelId(), versionId);

        Integer powerCost = mode.getPowerCost() != null && mode.getPowerCost() > 0 ? mode.getPowerCost() : app.getPowerCost();
        if (powerCost == null)
        {
            powerCost = 0;
        }

        AiTask task = new AiTask();
        task.setTaskNo("T" + DateUtils.dateTimeNow() + IdUtils.fastSimpleUUID().substring(0, 8).toUpperCase());
        task.setUserId(bo.getUserId() == null ? 1L : bo.getUserId());
        task.setAppId(app.getAppId());
        task.setModeId(mode.getModeId());
        task.setModelId(relation.getModelId());
        task.setModelVersionId(versionId);
        task.setTaskType("TEXT");
        task.setCreateMode(mode.getModeType());
        task.setPromptText(bo.getPromptText());
        task.setNegativePrompt(bo.getNegativePrompt());
        task.setStatus("SUCCESS");
        task.setPowerCost(powerCost);
        task.setInputParams(bo.getInputParams() == null ? null : JSON.toJSONString(bo.getInputParams()));
        task.setSubmitTime(DateUtils.getNowDate());
        task.setFinishTime(DateUtils.getNowDate());
        task.setRemark("文本应用已完成，本阶段使用内置文本执行器生成结果");
        aiTaskMapper.insertAiTask(task);

        aiWalletService.consumePower(task.getUserId(), powerCost, "TASK_SUBMIT", task.getTaskId(), "提交文本创作任务扣减算力");

        AiTaskResult result = new AiTaskResult();
        result.setTaskId(task.getTaskId());
        result.setResultType("TEXT");
        result.setResultText(buildTextResult(app, mode, bo));
        result.setSeqNo(1);
        aiTaskResultMapper.insertAiTaskResult(result);
        return aiTaskMapper.selectAiTaskById(task.getTaskId());
    }

    private String buildTextResult(AiApp app, AiAppMode mode, AppApplicationSubmitBo bo)
    {
        String length = bo.getInputParams() == null || bo.getInputParams().get("length") == null
            ? "" : String.valueOf(bo.getInputParams().get("length"));
        JSONObject payload = new JSONObject();
        payload.put("应用", app.getAppName());
        payload.put("模式", mode.getModeName());
        payload.put("篇幅", StringUtils.defaultIfBlank(length, "默认"));
        payload.put("原始内容", bo.getPromptText());
        return "【" + mode.getModeName() + "】\n"
            + "已根据你的输入生成一版可编辑文案。\n\n"
            + "核心表达：" + bo.getPromptText() + "\n\n"
            + "建议用途：可继续在此基础上补充产品卖点、人群、语气和发布渠道。\n\n"
            + "配置摘要：" + JSON.toJSONString(payload);
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

    private AiAppModelRelation selectSubmitRelation(Long appId, Long preferredModelId)
    {
        List<AiAppModelRelation> modelList = aiApplicationMapper.selectEnabledModelListByAppId(appId);
        if (modelList.isEmpty())
        {
            throw new ServiceException("应用未配置可用模型");
        }
        if (preferredModelId == null)
        {
            return modelList.get(0);
        }
        return modelList.stream()
            .filter(item -> preferredModelId.equals(item.getModelId()))
            .findFirst()
            .orElseThrow(() -> new ServiceException("当前应用不支持该模型"));
    }
}
