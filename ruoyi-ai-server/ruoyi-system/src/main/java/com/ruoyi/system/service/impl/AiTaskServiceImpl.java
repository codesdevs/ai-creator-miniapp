package com.ruoyi.system.service.impl;

import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.uuid.IdUtils;
import com.ruoyi.system.domain.AiModel;
import com.ruoyi.system.domain.AiModelVersion;
import com.ruoyi.system.domain.AiTask;
import com.ruoyi.system.domain.AiTaskResult;
import com.ruoyi.system.domain.vo.AdminTaskHandleBo;
import com.ruoyi.system.domain.vo.AppImageTaskSubmitBo;
import com.ruoyi.system.mapper.AiTaskMapper;
import com.ruoyi.system.mapper.AiTaskResultMapper;
import com.ruoyi.system.mapper.AiWalletFlowMapper;
import com.ruoyi.system.service.IAiModelService;
import com.ruoyi.system.service.IAiModelVersionService;
import com.ruoyi.system.service.IAiTaskService;
import com.ruoyi.system.service.IAiWalletService;
import java.util.Date;
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
    private static final long MOCK_RUNNING_THRESHOLD_MS = 3_000L;

    private static final long MOCK_FINISH_THRESHOLD_MS = 8_000L;

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

    @Autowired
    private AiWalletFlowMapper aiWalletFlowMapper;

    @Override
    public AiTask selectAiTaskById(Long taskId)
    {
        return hydrateMockTask(aiTaskMapper.selectAiTaskById(taskId));
    }

    @Override
    public List<AiTask> selectAiTaskList(AiTask aiTask)
    {
        List<AiTask> list = aiTaskMapper.selectAiTaskList(aiTask);
        list.forEach(this::hydrateMockTask);
        return list;
    }

    @Override
    public List<AiTaskResult> selectAiTaskResultListByTaskId(Long taskId)
    {
        return aiTaskResultMapper.selectAiTaskResultListByTaskId(taskId);
    }

    @Override
    public AiTask selectUserTaskDetail(Long userId, Long taskId)
    {
        AiTask task = hydrateMockTask(aiTaskMapper.selectAiTaskById(taskId));
        if (task == null || !userId.equals(task.getUserId()))
        {
            throw new ServiceException("任务不存在");
        }
        return task;
    }

    @Override
    public List<AiTask> selectUserTaskList(Long userId)
    {
        AiTask query = new AiTask();
        query.setUserId(userId);
        query.setTaskType("IMAGE");
        return selectAiTaskList(query);
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

    @Override
    @Transactional(rollbackFor = Exception.class)
    public AiTask adminHandleTask(AdminTaskHandleBo bo)
    {
        AiTask task = aiTaskMapper.selectAiTaskById(bo.getTaskId());
        if (task == null)
        {
            throw new ServiceException("任务不存在");
        }

        task.setStatus(bo.getStatus());
        task.setRemark(bo.getRemark());
        if ("FAIL".equals(bo.getStatus()))
        {
            task.setFailReason(StringUtils.defaultIfBlank(bo.getFailReason(), "后台人工处理为失败"));
            task.setFinishTime(new Date());
            aiTaskMapper.updateAiTask(task);
            if (Boolean.TRUE.equals(bo.getRefund()) && !hasRefunded(task.getTaskId()))
            {
                aiWalletService.grantPower(task.getUserId(), task.getPowerCost(), "TASK_REFUND", task.getTaskId(), "后台处理失败任务退款");
            }
        }
        else if ("SUCCESS".equals(bo.getStatus()))
        {
            task.setFailReason("");
            task.setFinishTime(new Date());
            aiTaskMapper.updateAiTask(task);
            insertMockResultsIfAbsent(task);
        }
        else
        {
            task.setFailReason("");
            aiTaskMapper.updateAiTask(task);
        }
        return aiTaskMapper.selectAiTaskById(task.getTaskId());
    }

    private AiTask hydrateMockTask(AiTask task)
    {
        if (task == null || task.getSubmitTime() == null)
        {
            return task;
        }
        if ("SUCCESS".equals(task.getStatus()) || "FAIL".equals(task.getStatus()))
        {
            return task;
        }

        long elapsedMs = System.currentTimeMillis() - task.getSubmitTime().getTime();
        if (elapsedMs >= MOCK_FINISH_THRESHOLD_MS)
        {
            return finalizeMockTask(task);
        }
        if (elapsedMs >= MOCK_RUNNING_THRESHOLD_MS && !"RUNNING".equals(task.getStatus()))
        {
            task.setStatus("RUNNING");
            task.setRemark("模型正在生成结果，请稍候查看");
            aiTaskMapper.updateAiTask(task);
            return aiTaskMapper.selectAiTaskById(task.getTaskId());
        }
        return task;
    }

    private AiTask finalizeMockTask(AiTask task)
    {
        boolean success = Math.abs(task.getTaskNo().hashCode()) % 10 < 8;
        task.setFinishTime(new Date());
        if (success)
        {
            task.setStatus("SUCCESS");
            task.setFailReason("");
            task.setRemark("演示任务已生成完成");
            aiTaskMapper.updateAiTask(task);
            insertMockResultsIfAbsent(task);
        }
        else
        {
            task.setStatus("FAIL");
            task.setFailReason("演示环境模拟执行失败，请调整提示词后重试");
            task.setRemark("演示任务执行失败，已退回本次扣减算力");
            aiTaskMapper.updateAiTask(task);
            if (!hasRefunded(task.getTaskId()))
            {
                aiWalletService.grantPower(task.getUserId(), task.getPowerCost(), "TASK_REFUND", task.getTaskId(), "演示任务失败退回算力");
            }
        }
        return aiTaskMapper.selectAiTaskById(task.getTaskId());
    }

    private boolean hasRefunded(Long taskId)
    {
        return aiWalletFlowMapper.countAiWalletFlowByBiz("TASK_REFUND", taskId, "GRANT") > 0;
    }

    private void insertMockResultsIfAbsent(AiTask task)
    {
        List<AiTaskResult> resultList = aiTaskResultMapper.selectAiTaskResultListByTaskId(task.getTaskId());
        if (!resultList.isEmpty())
        {
            return;
        }
        String ratio = task.getRatioCode() == null || task.getRatioCode().isBlank() ? "1:1" : task.getRatioCode();
        int[] size = resolveMockSize(ratio);
        String seed = String.valueOf(task.getTaskId());

        AiTaskResult first = new AiTaskResult();
        first.setTaskId(task.getTaskId());
        first.setResultType("IMAGE");
        first.setWidth(size[0]);
        first.setHeight(size[1]);
        first.setSeqNo(1);
        first.setCoverUrl("https://picsum.photos/seed/ai-task-" + seed + "/" + size[0] + "/" + size[1]);
        first.setFileUrl(first.getCoverUrl());
        aiTaskResultMapper.insertAiTaskResult(first);

        AiTaskResult second = new AiTaskResult();
        second.setTaskId(task.getTaskId());
        second.setResultType("IMAGE");
        second.setWidth(size[0]);
        second.setHeight(size[1]);
        second.setSeqNo(2);
        second.setCoverUrl("https://picsum.photos/seed/ai-task-" + seed + "-b/" + size[0] + "/" + size[1]);
        second.setFileUrl(second.getCoverUrl());
        aiTaskResultMapper.insertAiTaskResult(second);
    }

    private int[] resolveMockSize(String ratio)
    {
        return switch (ratio)
        {
            case "9:16" -> new int[] { 900, 1600 };
            case "16:9" -> new int[] { 1600, 900 };
            case "3:4" -> new int[] { 900, 1200 };
            case "4:3" -> new int[] { 1200, 900 };
            default -> new int[] { 1024, 1024 };
        };
    }
}
