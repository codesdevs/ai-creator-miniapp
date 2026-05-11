package com.ruoyi.system.service.impl;

import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.uuid.IdUtils;
import com.ruoyi.system.domain.AiModel;
import com.ruoyi.system.domain.AiModelVersion;
import com.ruoyi.system.domain.AiTask;
import com.ruoyi.system.domain.AiTaskResult;
import com.ruoyi.system.domain.vo.AppImageTaskSubmitBo;
import com.ruoyi.system.mapper.AiTaskMapper;
import com.ruoyi.system.mapper.AiTaskResultMapper;
import com.ruoyi.system.service.IAiModelService;
import com.ruoyi.system.service.IAiModelVersionService;
import com.ruoyi.system.service.IAiTaskService;
import com.ruoyi.system.service.IAiWalletService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * AI 任务 服务层实现
 *
 * @author codex
 */
@Service
public class AiTaskServiceImpl implements IAiTaskService
{
    @Autowired
    private AiTaskMapper aiTaskMapper;

    @Autowired
    private AiTaskResultMapper aiTaskResultMapper;

    @Autowired
    private IAiModelService aiModelService;

    @Autowired
    private IAiModelVersionService aiModelVersionService;

    @Autowired
    private IAiWalletService aiWalletService;

    @Override
    public AiTask selectAiTaskById(Long taskId)
    {
        return aiTaskMapper.selectAiTaskById(taskId);
    }

    @Override
    public List<AiTask> selectAiTaskList(AiTask aiTask)
    {
        return aiTaskMapper.selectAiTaskList(aiTask);
    }

    @Override
    public List<AiTaskResult> selectAiTaskResultListByTaskId(Long taskId)
    {
        return aiTaskResultMapper.selectAiTaskResultListByTaskId(taskId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public AiTask submitImageTask(AppImageTaskSubmitBo bo)
    {
        AiModel model = aiModelService.selectAiModelById(bo.getModelId());
        if (model == null || !"0".equals(model.getStatus()))
        {
            throw new ServiceException("模型不存在或已停用");
        }
        AiModelVersion version = aiModelVersionService.selectAiModelVersionById(bo.getVersionId());
        if (version == null || !"0".equals(version.getStatus()))
        {
            throw new ServiceException("模型版本不存在或已停用");
        }
        if (!bo.getModelId().equals(version.getModelId()))
        {
            throw new ServiceException("模型和版本不匹配");
        }

        AiTask task = new AiTask();
        Long userId = bo.getUserId() == null ? 1L : bo.getUserId();
        task.setTaskNo("T" + DateUtils.dateTimeNow() + IdUtils.fastSimpleUUID().substring(0, 8).toUpperCase());
        task.setUserId(userId);
        task.setModelId(model.getModelId());
        task.setModelVersionId(version.getVersionId());
        task.setTaskType("IMAGE");
        task.setCreateMode(bo.getCreateMode());
        task.setPromptText(bo.getPromptText());
        task.setNegativePrompt(bo.getNegativePrompt());
        task.setStyleCode(bo.getStyleCode());
        task.setRatioCode(bo.getRatioCode());
        task.setSourceUrl(bo.getSourceUrl());
        task.setStatus("PENDING");
        task.setPowerCost(version.getPowerCost());
        task.setSubmitTime(DateUtils.getNowDate());
        task.setRemark("任务已创建，待接入实际模型执行器");
        aiTaskMapper.insertAiTask(task);
        aiWalletService.consumePower(userId, version.getPowerCost(), "TASK_SUBMIT", task.getTaskId(), "提交图片生成任务扣减算力");
        return aiTaskMapper.selectAiTaskById(task.getTaskId());
    }
}
