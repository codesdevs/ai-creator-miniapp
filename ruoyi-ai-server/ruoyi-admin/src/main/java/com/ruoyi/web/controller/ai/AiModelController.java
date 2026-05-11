package com.ruoyi.web.controller.ai;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.AiModel;
import com.ruoyi.system.service.IAiModelService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * AI 模型配置管理
 *
 * @author codex
 */
@RestController
@RequestMapping("/ai/model")
public class AiModelController extends BaseController
{
    @Autowired
    private IAiModelService aiModelService;

    @PreAuthorize("@ss.hasPermi('ai:model:list')")
    @GetMapping("/list")
    public TableDataInfo list(AiModel aiModel)
    {
        startPage();
        List<AiModel> list = aiModelService.selectAiModelList(aiModel);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('ai:model:query')")
    @GetMapping(value = "/{modelId}")
    public AjaxResult getInfo(@PathVariable Long modelId)
    {
        return success(aiModelService.selectAiModelById(modelId));
    }

    @PreAuthorize("@ss.hasPermi('ai:model:add')")
    @Log(title = "AI模型配置", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody AiModel aiModel)
    {
        aiModel.setCreateBy(getUsername());
        return toAjax(aiModelService.insertAiModel(aiModel));
    }

    @PreAuthorize("@ss.hasPermi('ai:model:edit')")
    @Log(title = "AI模型配置", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody AiModel aiModel)
    {
        aiModel.setUpdateBy(getUsername());
        return toAjax(aiModelService.updateAiModel(aiModel));
    }

    @PreAuthorize("@ss.hasPermi('ai:model:remove')")
    @Log(title = "AI模型配置", businessType = BusinessType.DELETE)
    @DeleteMapping("/{modelIds}")
    public AjaxResult remove(@PathVariable Long[] modelIds)
    {
        return toAjax(aiModelService.deleteAiModelByIds(modelIds));
    }
}
