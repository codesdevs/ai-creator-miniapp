package com.ruoyi.system.service;

import com.ruoyi.system.domain.AiPayConfig;
import java.util.List;

public interface IAiPayConfigService
{
    public AiPayConfig selectAiPayConfigById(Long payConfigId);

    public List<AiPayConfig> selectAiPayConfigList(AiPayConfig aiPayConfig);

    public AiPayConfig selectDefaultEnabledPayConfig();

    public int insertAiPayConfig(AiPayConfig aiPayConfig);

    public int updateAiPayConfig(AiPayConfig aiPayConfig);
}
