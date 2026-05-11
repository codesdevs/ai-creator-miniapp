package com.ruoyi.system.service.impl;

import com.ruoyi.system.domain.AiProvider;
import com.ruoyi.system.mapper.AiProviderMapper;
import com.ruoyi.system.service.IAiProviderService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AiProviderServiceImpl implements IAiProviderService
{
    @Autowired
    private AiProviderMapper aiProviderMapper;

    @Override
    public AiProvider selectAiProviderById(Long providerId)
    {
        return aiProviderMapper.selectAiProviderById(providerId);
    }

    @Override
    public List<AiProvider> selectAiProviderList(AiProvider aiProvider)
    {
        return aiProviderMapper.selectAiProviderList(aiProvider);
    }

    @Override
    public int insertAiProvider(AiProvider aiProvider)
    {
        return aiProviderMapper.insertAiProvider(aiProvider);
    }

    @Override
    public int updateAiProvider(AiProvider aiProvider)
    {
        return aiProviderMapper.updateAiProvider(aiProvider);
    }

    @Override
    public int deleteAiProviderById(Long providerId)
    {
        return aiProviderMapper.deleteAiProviderById(providerId);
    }

    @Override
    public int deleteAiProviderByIds(Long[] providerIds)
    {
        return aiProviderMapper.deleteAiProviderByIds(providerIds);
    }
}
