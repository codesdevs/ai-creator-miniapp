package com.ruoyi.web.controller.ai;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.system.domain.AiAppUserInvite;
import com.ruoyi.system.service.IAiAppUserInviteService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * C端用户邀请关系管理
 *
 * @author codex
 */
@RestController
@RequestMapping("/ai/userInvite")
public class AiUserInviteController extends BaseController
{
    @Autowired
    private IAiAppUserInviteService aiAppUserInviteService;

    @PreAuthorize("@ss.hasPermi('ai:userInvite:list')")
    @GetMapping("/list")
    public TableDataInfo list(AiAppUserInvite aiAppUserInvite)
    {
        startPage();
        List<AiAppUserInvite> list = aiAppUserInviteService.selectAiAppUserInviteList(aiAppUserInvite);
        return getDataTable(list);
    }
}
