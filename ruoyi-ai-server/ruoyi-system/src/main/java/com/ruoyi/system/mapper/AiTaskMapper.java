package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.AiTask;
import java.util.List;

/**
 * AI 任务 数据层
 *
 * @author codex
 */
public interface AiTaskMapper
{
    public AiTask selectAiTaskById(Long taskId);

    public List<AiTask> selectAiTaskList(AiTask aiTask);

    public int insertAiTask(AiTask aiTask);

    public int updateAiTask(AiTask aiTask);
}
