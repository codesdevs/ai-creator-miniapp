package com.ruoyi.system.domain.vo;

import jakarta.validation.constraints.NotNull;

/**
 * 后台批量生成卡密参数
 *
 * @author codex
 */
public class AdminCardCodeGenerateBo
{
    @NotNull(message = "卡包ID不能为空")
    private Long packageId;

    @NotNull(message = "生成数量不能为空")
    private Integer quantity;

    private String remark;

    public Long getPackageId() { return packageId; }
    public void setPackageId(Long packageId) { this.packageId = packageId; }
    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
}
