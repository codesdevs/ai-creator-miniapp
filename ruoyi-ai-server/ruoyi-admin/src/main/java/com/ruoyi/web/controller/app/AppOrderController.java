package com.ruoyi.web.controller.app;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.framework.web.service.AppSecurityUtils;
import com.ruoyi.system.domain.AiOrder;
import com.ruoyi.system.domain.vo.AppRechargeSubmitBo;
import com.ruoyi.system.service.IAiOrderService;
import com.ruoyi.system.service.IAiRechargePackageService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 小程序端充值订单接口
 *
 * @author codex
 */
@RestController
@RequestMapping("/app/order")
public class AppOrderController
{
    @Autowired
    private IAiRechargePackageService aiRechargePackageService;

    @Autowired
    private IAiOrderService aiOrderService;

    @GetMapping("/packageList")
    public AjaxResult packageList()
    {
        return AjaxResult.success(aiRechargePackageService.selectEnabledRechargePackageList());
    }

    @PostMapping("/submitRecharge")
    public AjaxResult submitRecharge(@Valid @RequestBody AppRechargeSubmitBo bo)
    {
        AiOrder order = aiOrderService.createRechargeOrder(AppSecurityUtils.getUserId(), bo.getPackageId(), bo.getPayConfigId());
        AjaxResult result = AjaxResult.success("充值订单创建成功");
        result.put("order", order);
        result.put("payTip", "当前为开发阶段，请在后台将订单处理为已支付以模拟到账");
        return result;
    }

    @GetMapping("/myRechargeList")
    public AjaxResult myRechargeList()
    {
        return AjaxResult.success(aiOrderService.selectUserOrderList(AppSecurityUtils.getUserId()));
    }
}
