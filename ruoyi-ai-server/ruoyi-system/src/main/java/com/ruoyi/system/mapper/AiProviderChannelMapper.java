package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.AiProviderChannel;
import java.util.List;

public interface AiProviderChannelMapper
{
    public AiProviderChannel selectAiProviderChannelById(Long channelId);

    public List<AiProviderChannel> selectAiProviderChannelList(AiProviderChannel aiProviderChannel);

    public int insertAiProviderChannel(AiProviderChannel aiProviderChannel);

    public int updateAiProviderChannel(AiProviderChannel aiProviderChannel);

    public int deleteAiProviderChannelById(Long channelId);

    public int deleteAiProviderChannelByIds(Long[] channelIds);
}
