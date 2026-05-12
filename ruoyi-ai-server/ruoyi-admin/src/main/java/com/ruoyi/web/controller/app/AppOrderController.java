package com.ruoyi.web.controller.app;

import com.ruoyi.common.config.AiCreatorProperties;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.framework.web.service.AppSecurityUtils;
import com.ruoyi.system.domain.AiOrder;
import com.ruoyi.system.domain.AiPayConfig;
import com.ruoyi.system.domain.vo.AppRechargeSubmitBo;
import com.ruoyi.system.service.IAiOrderService;
import com.ruoyi.system.service.IAiPayConfigService;
import com.ruoyi.system.service.IAiRechargePackageService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.DeleteMapping;
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

    @Autowired
    private IAiPayConfigService aiPayConfigService;

    @Autowired
    private AiCreatorProperties aiCreatorProperties;

    @GetMapping("/packageList")
    public AjaxResult packageList()
    {
        return AjaxResult.success(aiRechargePackageService.selectEnabledRechargePackageList());
    }

    @GetMapping("/payConfigList")
    public AjaxResult payConfigList()
    {
        AiPayConfig query = new AiPayConfig();
        query.setStatus("0");
        return AjaxResult.success(aiPayConfigService.selectAiPayConfigList(query));
    }

    @PostMapping("/submitRecharge")
    public AjaxResult submitRecharge(@Valid @RequestBody AppRechargeSubmitBo bo)
    {
        AiOrder order = aiOrderService.createRechargeOrder(AppSecurityUtils.getUserId(), bo.getPackageId(), bo.getPayConfigId());
        AjaxResult result = AjaxResult.success("充值订单创建成功");
        result.put("order", order);
        result.put("payTip", buildPayTip());
        return result;
    }

    @GetMapping("/myRechargeList")
    public AjaxResult myRechargeList()
    {
        return AjaxResult.success(aiOrderService.selectUserOrderList(AppSecurityUtils.getUserId()));
    }

    @GetMapping("/{orderId}")
    public AjaxResult rechargeDetail(@PathVariable Long orderId)
    {
        AiOrder order = aiOrderService.selectUserOrderById(AppSecurityUtils.getUserId(), orderId);
        AjaxResult result = AjaxResult.success(order);
        if ("WAIT_PAY".equals(order.getOrderStatus()))
        {
            result.put("payTip", buildPayTip());
        }
        return result;
    }

    @PostMapping("/{orderId}/mockPay")
    public AjaxResult mockPay(@PathVariable Long orderId)
    {
        AiOrder order = aiOrderService.mockPayUserOrder(AppSecurityUtils.getUserId(), orderId);
        AjaxResult result = AjaxResult.success("模拟支付成功");
        result.put("order", order);
        return result;
    }

    @DeleteMapping("/{orderId}")
    public AjaxResult cancelRecharge(@PathVariable Long orderId)
    {
        return AjaxResult.success(aiOrderService.cancelUserOrder(AppSecurityUtils.getUserId(), orderId));
    }

    private String buildPayTip()
    {
        if (aiCreatorProperties.getPayment().isMockEnabled())
        {
            return "当前已启用开发态模拟支付，可在订单详情中直接完成到账";
        }
        return "订单已创建，请按当前支付渠道完成支付";
    }
}
