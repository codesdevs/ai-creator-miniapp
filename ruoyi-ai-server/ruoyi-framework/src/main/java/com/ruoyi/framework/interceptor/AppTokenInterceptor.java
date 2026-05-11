package com.ruoyi.framework.interceptor;

import com.alibaba.fastjson2.JSON;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.framework.web.service.AppLoginUser;
import com.ruoyi.framework.web.service.AppSecurityUtils;
import com.ruoyi.framework.web.service.AppTokenService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

/**
 * C端 token 拦截器
 *
 * @author codex
 */
@Component
public class AppTokenInterceptor implements HandlerInterceptor
{
    @Autowired
    private AppTokenService appTokenService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception
    {
        AppLoginUser loginUser = appTokenService.getLoginUser(request);
        if (loginUser == null)
        {
            writeUnauthorized(response, "未登录或登录已过期");
            return false;
        }
        appTokenService.verifyToken(loginUser);
        AppSecurityUtils.setLoginUser(loginUser);
        return true;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception
    {
        AppSecurityUtils.clear();
    }

    private void writeUnauthorized(HttpServletResponse response, String message) throws Exception
    {
        response.setStatus(200);
        response.setCharacterEncoding("utf-8");
        response.setContentType("application/json");
        response.getWriter().write(JSON.toJSONString(AjaxResult.error(401, message)));
    }
}
