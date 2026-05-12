package com.ruoyi.system.service;

import java.util.Map;
import com.ruoyi.system.domain.AiTask;
import com.ruoyi.system.domain.vo.AppApplicationSubmitBo;

/**
 * 小程序 AI 应用配置 服务层
 */
public interface IAiApplicationService
{
    public Map<String, Object> selectHome();

    public Map<String, Object> selectDetail(Long appId, String appCode);

    public AiTask submitApplication(AppApplicationSubmitBo bo);
}
