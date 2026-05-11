package com.ruoyi.web.controller.ai;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.system.domain.AiAppUser;
import com.ruoyi.system.service.IAiAppUserService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * C端用户管理
 *
 * @author codex
 */
@RestController
@RequestMapping("/ai/user")
public class AiUserController extends BaseController
{
    @Autowired
    private IAiAppUserService aiAppUserService;

    @PreAuthorize("@ss.hasPermi('ai:user:list')")
    @GetMapping("/list")
    public TableDataInfo list(AiAppUser aiAppUser)
    {
        startPage();
        List<AiAppUser> list = aiAppUserService.selectAiAppUserList(aiAppUser);
        return getDataTable(list);
    }
}
