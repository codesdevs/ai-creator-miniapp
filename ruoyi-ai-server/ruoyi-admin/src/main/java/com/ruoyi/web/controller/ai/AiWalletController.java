package com.ruoyi.web.controller.ai;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.AiWallet;
import com.ruoyi.system.domain.AiWalletFlow;
import com.ruoyi.system.service.IAiWalletService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * AI 钱包管理
 *
 * @author codex
 */
@RestController
@RequestMapping("/ai/wallet")
public class AiWalletController extends BaseController
{
    @Autowired
    private IAiWalletService aiWalletService;

    @PreAuthorize("@ss.hasPermi('ai:wallet:list')")
    @GetMapping("/info")
    public AjaxResult info(@RequestParam Long userId)
    {
        AiWallet wallet = aiWalletService.selectAiWalletByUserId(userId);
        return success(wallet == null ? new AiWallet() : wallet);
    }

    @PreAuthorize("@ss.hasPermi('ai:wallet:list')")
    @GetMapping("/flowList")
    public TableDataInfo flowList(AiWalletFlow aiWalletFlow)
    {
        startPage();
        List<AiWalletFlow> list = aiWalletService.selectAiWalletFlowList(aiWalletFlow);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('ai:wallet:grant')")
    @Log(title = "AI钱包赠送算力", businessType = BusinessType.INSERT)
    @PostMapping("/grantPower")
    public AjaxResult grantPower(@RequestParam Long userId, @RequestParam Integer powerNum, @RequestParam(required = false) String remark)
    {
        aiWalletService.grantPower(userId, powerNum, "ADMIN_GRANT", userId, remark == null ? "后台赠送算力" : remark);
        return success();
    }
}
