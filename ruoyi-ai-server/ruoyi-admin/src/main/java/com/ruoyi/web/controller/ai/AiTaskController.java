package com.ruoyi.web.controller.ai;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.system.domain.AiTask;
import com.ruoyi.system.service.IAiTaskService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
        AjaxResult result = AjaxResult.success();
        result.put("task", aiTaskService.selectAiTaskById(taskId));
        result.put("resultList", aiTaskService.selectAiTaskResultListByTaskId(taskId));
        return result;
    }
}
