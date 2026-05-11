package com.ruoyi.web.controller.app;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.framework.web.service.AppSecurityUtils;
import com.ruoyi.system.domain.AiCardCode;
import com.ruoyi.system.domain.vo.AppCardCodeRedeemBo;
import com.ruoyi.system.service.IAiCardCodeService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 小程序端卡密接口
 *
 * @author codex
 */
@RestController
@RequestMapping("/app/cardCode")
public class AppCardCodeController
{
    @Autowired
    private IAiCardCodeService aiCardCodeService;

    @PostMapping("/redeem")
    public AjaxResult redeem(@Valid @RequestBody AppCardCodeRedeemBo bo)
    {
        AiCardCode cardCode = aiCardCodeService.redeemCardCode(AppSecurityUtils.getUserId(), bo.getCardCode());
        AjaxResult result = AjaxResult.success("兑换成功");
        result.put("cardCode", cardCode);
        return result;
    }
}
