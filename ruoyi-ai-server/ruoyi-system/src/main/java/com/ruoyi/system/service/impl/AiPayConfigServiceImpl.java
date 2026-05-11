package com.ruoyi.system.service.impl;

import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.system.domain.AiPayConfig;
import com.ruoyi.system.mapper.AiPayConfigMapper;
import com.ruoyi.system.service.IAiPayConfigService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AiPayConfigServiceImpl implements IAiPayConfigService
{
    @Autowired
    private AiPayConfigMapper aiPayConfigMapper;

    @Override
    public AiPayConfig selectAiPayConfigById(Long payConfigId)
    {
        return aiPayConfigMapper.selectAiPayConfigById(payConfigId);
    }

    @Override
    public List<AiPayConfig> selectAiPayConfigList(AiPayConfig aiPayConfig)
    {
        return aiPayConfigMapper.selectAiPayConfigList(aiPayConfig);
    }

    @Override
    public AiPayConfig selectDefaultEnabledPayConfig()
    {
        AiPayConfig query = new AiPayConfig();
        query.setStatus("0");
        List<AiPayConfig> list = aiPayConfigMapper.selectAiPayConfigList(query);
        return list.isEmpty() ? null : list.get(0);
    }

    @Override
    public int insertAiPayConfig(AiPayConfig aiPayConfig)
    {
        aiPayConfig.setCreateTime(DateUtils.getNowDate());
        return aiPayConfigMapper.insertAiPayConfig(aiPayConfig);
    }

    @Override
    public int updateAiPayConfig(AiPayConfig aiPayConfig)
    {
        aiPayConfig.setUpdateTime(DateUtils.getNowDate());
        return aiPayConfigMapper.updateAiPayConfig(aiPayConfig);
    }
}
