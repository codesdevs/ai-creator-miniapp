package com.ruoyi.web.controller.ai;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.AiOrder;
import com.ruoyi.system.domain.vo.AdminOrderHandleBo;
import com.ruoyi.system.service.IAiOrderService;
import jakarta.validation.Valid;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/ai/order")
public class AiOrderController extends BaseController
{
    @Autowired
    private IAiOrderService aiOrderService;

    @PreAuthorize("@ss.hasPermi('ai:order:list')")
    @GetMapping("/list")
    public TableDataInfo list(AiOrder aiOrder)
    {
        startPage();
        List<AiOrder> list = aiOrderService.selectAiOrderList(aiOrder);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('ai:order:query')")
    @GetMapping("/{orderId}")
    public AjaxResult getInfo(@PathVariable Long orderId)
    {
        return success(aiOrderService.selectAiOrderById(orderId));
    }

    @PreAuthorize("@ss.hasPermi('ai:order:handle')")
    @Log(title = "充值订单处理", businessType = BusinessType.UPDATE)
    @PostMapping("/handle")
    public AjaxResult handle(@Valid @RequestBody AdminOrderHandleBo bo)
    {
        return success(aiOrderService.adminHandleOrder(bo));
    }
}
