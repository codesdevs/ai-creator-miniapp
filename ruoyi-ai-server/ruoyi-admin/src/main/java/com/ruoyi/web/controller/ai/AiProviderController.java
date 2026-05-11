package com.ruoyi.web.controller.ai;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.AiProvider;
import com.ruoyi.system.service.IAiProviderService;
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

@RestController
@RequestMapping("/ai/provider")
public class AiProviderController extends BaseController
{
    @Autowired
    private IAiProviderService aiProviderService;

    @PreAuthorize("@ss.hasPermi('ai:provider:list')")
    @GetMapping("/list")
    public TableDataInfo list(AiProvider aiProvider)
    {
        startPage();
        List<AiProvider> list = aiProviderService.selectAiProviderList(aiProvider);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('ai:provider:query')")
    @GetMapping("/{providerId}")
    public AjaxResult getInfo(@PathVariable Long providerId)
    {
        return success(aiProviderService.selectAiProviderById(providerId));
    }

    @PreAuthorize("@ss.hasPermi('ai:provider:add')")
    @Log(title = "AI提供商", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody AiProvider aiProvider)
    {
        aiProvider.setCreateBy(getUsername());
        return toAjax(aiProviderService.insertAiProvider(aiProvider));
    }

    @PreAuthorize("@ss.hasPermi('ai:provider:edit')")
    @Log(title = "AI提供商", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody AiProvider aiProvider)
    {
        aiProvider.setUpdateBy(getUsername());
        return toAjax(aiProviderService.updateAiProvider(aiProvider));
    }

    @PreAuthorize("@ss.hasPermi('ai:provider:remove')")
    @Log(title = "AI提供商", businessType = BusinessType.DELETE)
    @DeleteMapping("/{providerIds}")
    public AjaxResult remove(@PathVariable Long[] providerIds)
    {
        return toAjax(aiProviderService.deleteAiProviderByIds(providerIds));
    }
}
