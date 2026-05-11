package com.ruoyi.web.controller.ai;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.AiModelVersion;
import com.ruoyi.system.service.IAiModelVersionService;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * AI 模型版本管理
 *
 * @author codex
 */
@RestController
@RequestMapping("/ai/modelVersion")
public class AiModelVersionController extends BaseController
{
    @Autowired
    private IAiModelVersionService aiModelVersionService;

    @PreAuthorize("@ss.hasPermi('ai:modelVersion:list')")
    @GetMapping("/list")
    public TableDataInfo list(AiModelVersion aiModelVersion)
    {
        startPage();
        List<AiModelVersion> list = aiModelVersionService.selectAiModelVersionList(aiModelVersion);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('ai:modelVersion:list')")
    @GetMapping("/listByModelId")
    public AjaxResult listByModelId(@RequestParam Long modelId)
    {
        return success(aiModelVersionService.selectAiModelVersionListByModelId(modelId));
    }

    @PreAuthorize("@ss.hasPermi('ai:modelVersion:query')")
    @GetMapping(value = "/{versionId}")
    public AjaxResult getInfo(@PathVariable Long versionId)
    {
        return success(aiModelVersionService.selectAiModelVersionById(versionId));
    }

    @PreAuthorize("@ss.hasPermi('ai:modelVersion:add')")
    @Log(title = "AI模型版本", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody AiModelVersion aiModelVersion)
    {
        aiModelVersion.setCreateBy(getUsername());
        return toAjax(aiModelVersionService.insertAiModelVersion(aiModelVersion));
    }

    @PreAuthorize("@ss.hasPermi('ai:modelVersion:edit')")
    @Log(title = "AI模型版本", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody AiModelVersion aiModelVersion)
    {
        aiModelVersion.setUpdateBy(getUsername());
        return toAjax(aiModelVersionService.updateAiModelVersion(aiModelVersion));
    }

    @PreAuthorize("@ss.hasPermi('ai:modelVersion:remove')")
    @Log(title = "AI模型版本", businessType = BusinessType.DELETE)
    @DeleteMapping("/{versionIds}")
    public AjaxResult remove(@PathVariable Long[] versionIds)
    {
        return toAjax(aiModelVersionService.deleteAiModelVersionByIds(versionIds));
    }
}
