package com.ruoyi.system.domain.vo;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

/**
 * 后台订单处理参数
 *
 * @author codex
 */
public class AdminOrderHandleBo
{
    @NotNull(message = "订单ID不能为空")
    private Long orderId;

    @NotBlank(message = "订单状态不能为空")
    private String orderStatus;

    private String thirdOrderNo;

    private String remark;

    public Long getOrderId() { return orderId; }
    public void setOrderId(Long orderId) { this.orderId = orderId; }
    public String getOrderStatus() { return orderStatus; }
    public void setOrderStatus(String orderStatus) { this.orderStatus = orderStatus; }
    public String getThirdOrderNo() { return thirdOrderNo; }
    public void setThirdOrderNo(String thirdOrderNo) { this.thirdOrderNo = thirdOrderNo; }
    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
}
