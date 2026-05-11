package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.AiProvider;
import java.util.List;

public interface AiProviderMapper
{
    public AiProvider selectAiProviderById(Long providerId);

    public List<AiProvider> selectAiProviderList(AiProvider aiProvider);

    public int insertAiProvider(AiProvider aiProvider);

    public int updateAiProvider(AiProvider aiProvider);

    public int deleteAiProviderById(Long providerId);

    public int deleteAiProviderByIds(Long[] providerIds);
}
