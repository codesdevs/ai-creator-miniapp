package com.ruoyi.web.controller.app;

import com.ruoyi.common.config.AiCreatorProperties;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.system.domain.AiAppUser;
import com.ruoyi.system.domain.vo.AppDevLoginBo;
import com.ruoyi.system.domain.vo.AppWxLoginBo;
import com.ruoyi.system.service.IAiAppUserService;
import com.ruoyi.framework.web.service.AppLoginUser;
import com.ruoyi.framework.web.service.AppSecurityUtils;
import com.ruoyi.framework.web.service.AppTokenService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * C端认证接口
 *
 * @author codex
 */
@RestController
@RequestMapping("/app/auth")
public class AppAuthController
{
    @Autowired
    private IAiAppUserService aiAppUserService;

    @Autowired
    private AppTokenService appTokenService;

    @Autowired
    private AiCreatorProperties aiCreatorProperties;

    @PostMapping("/devLogin")
    public AjaxResult devLogin(@Valid @RequestBody AppDevLoginBo bo)
    {
        if (!aiCreatorProperties.getDev().isLoginEnabled())
        {
            throw new ServiceException("开发登录未启用");
        }
        AiAppUser user = aiAppUserService.devLogin(bo);
        return buildLoginResult(user);
    }

    @PostMapping("/wxLogin")
    public AjaxResult wxLogin(@Valid @RequestBody AppWxLoginBo bo)
    {
        AiAppUser user = aiAppUserService.wxLogin(bo);
        return buildLoginResult(user);
    }

    private AjaxResult buildLoginResult(AiAppUser user)
    {
        AppLoginUser loginUser = new AppLoginUser();
        loginUser.setUserId(user.getUserId());
        loginUser.setNickName(user.getNickName());
        String token = appTokenService.createToken(loginUser);

        AjaxResult result = AjaxResult.success();
        result.put("token", token);
        result.put("user", user);
        return result;
    }

    @GetMapping("/profile")
    public AjaxResult profile()
    {
        Long userId = AppSecurityUtils.getUserId();
        return AjaxResult.success(aiAppUserService.selectAiAppUserById(userId));
    }

    @PostMapping("/logout")
    public AjaxResult logout()
    {
        AppLoginUser loginUser = AppSecurityUtils.getLoginUser();
        if (loginUser != null)
        {
            appTokenService.delLoginUser(loginUser.getToken());
        }
        return AjaxResult.success("退出成功");
    }
}
