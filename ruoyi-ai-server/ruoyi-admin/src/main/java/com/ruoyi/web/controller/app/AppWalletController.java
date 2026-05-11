package com.ruoyi.web.controller.app;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.system.domain.AiWallet;
import com.ruoyi.system.domain.AiWalletFlow;
import com.ruoyi.system.service.IAiWalletService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * 小程序端钱包接口
 *
 * @author codex
 */
@RestController
@RequestMapping("/app/wallet")
public class AppWalletController extends BaseController
{
    @Autowired
    private IAiWalletService aiWalletService;

    @GetMapping("/info")
    public AjaxResult info(@RequestParam(defaultValue = "1") Long userId)
    {
        AiWallet wallet = aiWalletService.getOrCreateWallet(userId);
        return AjaxResult.success(wallet);
    }

    @GetMapping("/flowPage")
    public TableDataInfo flowPage(@RequestParam(defaultValue = "1") Long userId, AiWalletFlow aiWalletFlow)
    {
        aiWalletFlow.setUserId(userId);
        startPage();
        List<AiWalletFlow> list = aiWalletService.selectAiWalletFlowList(aiWalletFlow);
        return getDataTable(list);
    }
}
