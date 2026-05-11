package com.ruoyi.system.service;

import com.ruoyi.system.domain.AiTask;
import com.ruoyi.system.domain.AiTaskResult;
import com.ruoyi.system.domain.vo.AdminTaskHandleBo;
import com.ruoyi.system.domain.vo.AppImageTaskSubmitBo;
import java.util.List;

/**
 * AI 任务 服务层
 *
 * @author codex
 */
public interface IAiTaskService
{
    public AiTask selectAiTaskById(Long taskId);

    public List<AiTask> selectAiTaskList(AiTask aiTask);

    public List<AiTaskResult> selectAiTaskResultListByTaskId(Long taskId);

    public AiTask submitImageTask(AppImageTaskSubmitBo bo);

    public AiTask selectUserTaskDetail(Long userId, Long taskId);

    public List<AiTask> selectUserTaskList(Long userId);

    public boolean hasTaskRefunded(Long taskId);

    public AiTask adminHandleTask(AdminTaskHandleBo bo);
}
