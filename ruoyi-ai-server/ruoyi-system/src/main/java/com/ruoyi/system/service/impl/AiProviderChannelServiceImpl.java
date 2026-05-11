package com.ruoyi.system.service.impl;

import com.ruoyi.system.domain.AiProviderChannel;
import com.ruoyi.system.mapper.AiProviderChannelMapper;
import com.ruoyi.system.service.IAiProviderChannelService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AiProviderChannelServiceImpl implements IAiProviderChannelService
{
    @Autowired
    private AiProviderChannelMapper aiProviderChannelMapper;

    @Override
    public AiProviderChannel selectAiProviderChannelById(Long channelId)
    {
        return aiProviderChannelMapper.selectAiProviderChannelById(channelId);
    }

    @Override
    public List<AiProviderChannel> selectAiProviderChannelList(AiProviderChannel aiProviderChannel)
    {
        return aiProviderChannelMapper.selectAiProviderChannelList(aiProviderChannel);
    }

    @Override
    public int insertAiProviderChannel(AiProviderChannel aiProviderChannel)
    {
        return aiProviderChannelMapper.insertAiProviderChannel(aiProviderChannel);
    }

    @Override
    public int updateAiProviderChannel(AiProviderChannel aiProviderChannel)
    {
        return aiProviderChannelMapper.updateAiProviderChannel(aiProviderChannel);
    }

    @Override
    public int deleteAiProviderChannelById(Long channelId)
    {
        return aiProviderChannelMapper.deleteAiProviderChannelById(channelId);
    }

    @Override
    public int deleteAiProviderChannelByIds(Long[] channelIds)
    {
        return aiProviderChannelMapper.deleteAiProviderChannelByIds(channelIds);
    }
}
