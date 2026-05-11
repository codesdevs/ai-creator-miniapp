package com.ruoyi.framework.web.service;

/**
 * C端上下文工具
 *
 * @author codex
 */
public class AppSecurityUtils
{
    private static final ThreadLocal<AppLoginUser> CONTEXT = new ThreadLocal<>();

    public static void setLoginUser(AppLoginUser loginUser)
    {
        CONTEXT.set(loginUser);
    }

    public static AppLoginUser getLoginUser()
    {
        return CONTEXT.get();
    }

    public static Long getUserId()
    {
        AppLoginUser loginUser = getLoginUser();
        return loginUser == null ? null : loginUser.getUserId();
    }

    public static void clear()
    {
        CONTEXT.remove();
    }
}
