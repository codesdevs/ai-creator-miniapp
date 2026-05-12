package com.ruoyi.web.controller.app;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.framework.web.service.AppSecurityUtils;
import com.ruoyi.system.domain.AiTask;
import com.ruoyi.system.domain.vo.AppApplicationSubmitBo;
import com.ruoyi.system.service.IAiApplicationService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * 小程序端应用配置接口
 */
@RestController
@RequestMapping("/app/application")
public class AppApplicationController
{
    @Autowired
    private IAiApplicationService aiApplicationService;

    @GetMapping("/home")
    public AjaxResult home()
    {
        return AjaxResult.success(aiApplicationService.selectHome());
    }

    @GetMapping("/detail")
    public AjaxResult detail(@RequestParam(required = false) Long appId, @RequestParam(required = false) String appCode)
    {
        return AjaxResult.success(aiApplicationService.selectDetail(appId, appCode));
    }

    @PostMapping("/submit")
    public AjaxResult submit(@Valid @RequestBody AppApplicationSubmitBo bo)
    {
        bo.setUserId(AppSecurityUtils.getUserId());
        AiTask task = aiApplicationService.submitApplication(bo);
        AjaxResult result = AjaxResult.success("任务创建成功");
        result.put("taskId", task.getTaskId());
        result.put("taskNo", task.getTaskNo());
        result.put("status", task.getStatus());
        return result;
    }
}
