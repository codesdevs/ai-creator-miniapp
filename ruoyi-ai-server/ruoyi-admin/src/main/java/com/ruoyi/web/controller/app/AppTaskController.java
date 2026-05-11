package com.ruoyi.web.controller.app;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.framework.web.service.AppSecurityUtils;
import com.ruoyi.system.domain.AiTask;
import com.ruoyi.system.service.IAiTaskService;
import com.ruoyi.system.domain.vo.AppImageTaskSubmitBo;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 小程序端任务接口
 *
 * @author codex
 */
@RestController
@RequestMapping("/app/task")
public class AppTaskController
{
    @Autowired
    private IAiTaskService aiTaskService;

    /**
     * 提交图片生成任务
     */
    @PostMapping("/submitImage")
    public AjaxResult submitImage(@Valid @RequestBody AppImageTaskSubmitBo bo)
    {
        bo.setUserId(AppSecurityUtils.getUserId());
        AiTask task = aiTaskService.submitImageTask(bo);
        AjaxResult result = AjaxResult.success("任务创建成功");
        result.put("taskId", task.getTaskId());
        result.put("taskNo", task.getTaskNo());
        result.put("status", task.getStatus());
        return result;
    }

    /**
     * 查询任务详情
     */
    @GetMapping("/detail/{taskId}")
    public AjaxResult detail(@PathVariable Long taskId)
    {
        AjaxResult result = AjaxResult.success();
        result.put("task", aiTaskService.selectAiTaskById(taskId));
        result.put("resultList", aiTaskService.selectAiTaskResultListByTaskId(taskId));
        return result;
    }
}
