package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.AiTaskResult;
import java.util.List;

/**
 * AI 任务结果 数据层
 *
 * @author codex
 */
public interface AiTaskResultMapper
{
    public List<AiTaskResult> selectAiTaskResultListByTaskId(Long taskId);
}
