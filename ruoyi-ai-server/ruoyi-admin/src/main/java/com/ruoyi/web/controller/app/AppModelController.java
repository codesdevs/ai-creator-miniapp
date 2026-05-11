package com.ruoyi.web.controller.app;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.system.domain.AiModel;
import com.ruoyi.system.domain.AiModelVersion;
import com.ruoyi.system.service.IAiModelService;
import com.ruoyi.system.service.IAiModelVersionService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * 小程序端模型接口
 *
 * @author codex
 */
@RestController
@RequestMapping("/app/model")
public class AppModelController
{
    @Autowired
    private IAiModelService aiModelService;

    @Autowired
    private IAiModelVersionService aiModelVersionService;

    /**
     * 获取模型列表
     */
    @GetMapping("/list")
    public AjaxResult list(@RequestParam(required = false) String modelType)
    {
        AiModel query = new AiModel();
        query.setStatus("0");
        query.setModelType(modelType);
        List<AiModel> list = aiModelService.selectAiModelList(query);
        return AjaxResult.success(list);
    }

    /**
     * 获取模型详情
     */
    @GetMapping("/detail/{modelId}")
    public AjaxResult detail(@PathVariable Long modelId)
    {
        AiModel model = aiModelService.selectAiModelById(modelId);
        if (model == null || !"0".equals(model.getStatus()))
        {
            return AjaxResult.error("模型不存在或已停用");
        }

        AiModelVersion query = new AiModelVersion();
        query.setModelId(modelId);
        query.setStatus("0");
        List<AiModelVersion> versionList = aiModelVersionService.selectAiModelVersionList(query);

        AjaxResult result = AjaxResult.success();
        result.put("model", model);
        result.put("versionList", versionList);
        return result;
    }

    /**
     * 获取模型版本列表
     */
    @GetMapping("/versionList/{modelId}")
    public AjaxResult versionList(@PathVariable Long modelId)
    {
        AiModelVersion query = new AiModelVersion();
        query.setModelId(modelId);
        query.setStatus("0");
        return AjaxResult.success(aiModelVersionService.selectAiModelVersionList(query));
    }
}
