package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.AiPayConfig;
import java.util.List;

public interface AiPayConfigMapper
{
    public AiPayConfig selectAiPayConfigById(Long payConfigId);

    public List<AiPayConfig> selectAiPayConfigList(AiPayConfig aiPayConfig);

    public int insertAiPayConfig(AiPayConfig aiPayConfig);

    public int updateAiPayConfig(AiPayConfig aiPayConfig);
}
