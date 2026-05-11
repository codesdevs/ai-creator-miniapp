package com.ruoyi.system.service.impl;

import com.ruoyi.system.domain.AiModelVersion;
import com.ruoyi.system.mapper.AiModelVersionMapper;
import com.ruoyi.system.service.IAiModelVersionService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * AI 模型版本 服务层实现
 *
 * @author codex
 */
@Service
public class AiModelVersionServiceImpl implements IAiModelVersionService
{
    @Autowired
    private AiModelVersionMapper aiModelVersionMapper;

    @Override
    public AiModelVersion selectAiModelVersionById(Long versionId)
    {
        return aiModelVersionMapper.selectAiModelVersionById(versionId);
    }

    @Override
    public List<AiModelVersion> selectAiModelVersionList(AiModelVersion aiModelVersion)
    {
        return aiModelVersionMapper.selectAiModelVersionList(aiModelVersion);
    }

    @Override
    public List<AiModelVersion> selectAiModelVersionListByModelId(Long modelId)
    {
        return aiModelVersionMapper.selectAiModelVersionListByModelId(modelId);
    }

    @Override
    public int insertAiModelVersion(AiModelVersion aiModelVersion)
    {
        return aiModelVersionMapper.insertAiModelVersion(aiModelVersion);
    }

    @Override
    public int updateAiModelVersion(AiModelVersion aiModelVersion)
    {
        return aiModelVersionMapper.updateAiModelVersion(aiModelVersion);
    }

    @Override
    public int deleteAiModelVersionById(Long versionId)
    {
        return aiModelVersionMapper.deleteAiModelVersionById(versionId);
    }

    @Override
    public int deleteAiModelVersionByIds(Long[] versionIds)
    {
        return aiModelVersionMapper.deleteAiModelVersionByIds(versionIds);
    }
}
