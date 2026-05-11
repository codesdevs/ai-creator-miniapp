package com.ruoyi.web.controller.ai;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.AiRechargePackage;
import com.ruoyi.system.service.IAiRechargePackageService;
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
@RequestMapping("/ai/rechargePackage")
public class AiRechargePackageController extends BaseController
{
    @Autowired
    private IAiRechargePackageService aiRechargePackageService;

    @PreAuthorize("@ss.hasPermi('ai:rechargePackage:list')")
    @GetMapping("/list")
    public TableDataInfo list(AiRechargePackage aiRechargePackage)
    {
        startPage();
        List<AiRechargePackage> list = aiRechargePackageService.selectAiRechargePackageList(aiRechargePackage);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('ai:rechargePackage:query')")
    @GetMapping("/{packageId}")
    public AjaxResult getInfo(@PathVariable Long packageId)
    {
        return success(aiRechargePackageService.selectAiRechargePackageById(packageId));
    }

    @PreAuthorize("@ss.hasPermi('ai:rechargePackage:add')")
    @Log(title = "充值套餐", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody AiRechargePackage aiRechargePackage)
    {
        return toAjax(aiRechargePackageService.insertAiRechargePackage(aiRechargePackage));
    }

    @PreAuthorize("@ss.hasPermi('ai:rechargePackage:edit')")
    @Log(title = "充值套餐", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody AiRechargePackage aiRechargePackage)
    {
        return toAjax(aiRechargePackageService.updateAiRechargePackage(aiRechargePackage));
    }
}
