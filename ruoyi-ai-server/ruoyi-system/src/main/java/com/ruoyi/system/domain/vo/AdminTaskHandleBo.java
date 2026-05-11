package com.ruoyi.system.domain.vo;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

/**
 * 后台人工处理任务入参
 *
 * @author codex
 */
public class AdminTaskHandleBo
{
    @NotNull(message = "任务ID不能为空")
    private Long taskId;

    @NotBlank(message = "任务状态不能为空")
    private String status;

    private String failReason;

    private String remark;

    private Boolean refund;

    public Long getTaskId()
    {
        return taskId;
    }

    public void setTaskId(Long taskId)
    {
        this.taskId = taskId;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getFailReason()
    {
        return failReason;
    }

    public void setFailReason(String failReason)
    {
        this.failReason = failReason;
    }

    public String getRemark()
    {
        return remark;
    }

    public void setRemark(String remark)
    {
        this.remark = remark;
    }

    public Boolean getRefund()
    {
        return refund;
    }

    public void setRefund(Boolean refund)
    {
        this.refund = refund;
    }
}
