package com.ruoyi.web.controller.ai;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.AiPayConfig;
import com.ruoyi.system.service.IAiPayConfigService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/ai/payConfig")
public class AiPayConfigController extends BaseController
{
    @Autowired
    private IAiPayConfigService aiPayConfigService;

    @PreAuthorize("@ss.hasPermi('ai:payConfig:list')")
    @GetMapping("/list")
    public TableDataInfo list(AiPayConfig aiPayConfig)
    {
        startPage();
        List<AiPayConfig> list = aiPayConfigService.selectAiPayConfigList(aiPayConfig);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('ai:payConfig:query')")
    @GetMapping("/{payConfigId}")
    public AjaxResult getInfo(@PathVariable Long payConfigId)
    {
        return success(aiPayConfigService.selectAiPayConfigById(payConfigId));
    }

    @PreAuthorize("@ss.hasPermi('ai:payConfig:add')")
    @Log(title = "支付配置", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AiPayConfig aiPayConfig)
    {
        return toAjax(aiPayConfigService.insertAiPayConfig(aiPayConfig));
    }

    @PreAuthorize("@ss.hasPermi('ai:payConfig:edit')")
    @Log(title = "支付配置", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AiPayConfig aiPayConfig)
    {
        return toAjax(aiPayConfigService.updateAiPayConfig(aiPayConfig));
    }
}
