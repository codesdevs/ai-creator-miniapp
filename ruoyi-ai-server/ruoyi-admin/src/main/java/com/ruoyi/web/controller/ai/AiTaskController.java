package com.ruoyi.web.controller.ai;

import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.system.domain.AiTask;
import com.ruoyi.system.domain.vo.AdminTaskHandleBo;
import com.ruoyi.system.service.IAiTaskService;
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

/**
 * AI 任务管理
 *
 * @author codex
 */
@RestController
@RequestMapping("/ai/task")
public class AiTaskController extends BaseController
{
    @Autowired
    private IAiTaskService aiTaskService;

    @PreAuthorize("@ss.hasPermi('ai:task:list')")
    @GetMapping("/list")
    public TableDataInfo list(AiTask aiTask)
    {
        startPage();
        List<AiTask> list = aiTaskService.selectAiTaskList(aiTask);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('ai:task:query')")
    @GetMapping("/{taskId}")
    public AjaxResult getInfo(@PathVariable Long taskId)
    {
        AiTask task = aiTaskService.selectAiTaskById(taskId);
        AjaxResult result = AjaxResult.success();
        result.put("task", task);
        result.put("resultList", aiTaskService.selectAiTaskResultListByTaskId(taskId));
        result.put("refunded", "FAIL".equals(task.getStatus()) && aiTaskService.hasTaskRefunded(taskId));
        return result;
    }

    @PreAuthorize("@ss.hasPermi('ai:task:handle')")
    @Log(title = "AI任务人工处理", businessType = BusinessType.UPDATE)
    @PostMapping("/handle")
    public AjaxResult handle(@Valid @RequestBody AdminTaskHandleBo bo)
    {
        return AjaxResult.success(aiTaskService.adminHandleTask(bo));
    }
}
