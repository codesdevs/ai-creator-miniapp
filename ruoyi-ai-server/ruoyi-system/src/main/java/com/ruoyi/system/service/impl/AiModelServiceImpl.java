package com.ruoyi.system.service.impl;

import com.ruoyi.system.domain.AiModel;
import com.ruoyi.system.mapper.AiModelMapper;
import com.ruoyi.system.service.IAiModelService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * AI 模型配置 服务层实现
 *
 * @author codex
 */
@Service
public class AiModelServiceImpl implements IAiModelService
{
    @Autowired
    private AiModelMapper aiModelMapper;

    @Override
    public AiModel selectAiModelById(Long modelId)
    {
        return aiModelMapper.selectAiModelById(modelId);
    }

    @Override
    public List<AiModel> selectAiModelList(AiModel aiModel)
    {
        return aiModelMapper.selectAiModelList(aiModel);
    }

    @Override
    public int insertAiModel(AiModel aiModel)
    {
        return aiModelMapper.insertAiModel(aiModel);
    }

    @Override
    public int updateAiModel(AiModel aiModel)
    {
        return aiModelMapper.updateAiModel(aiModel);
    }

    @Override
    public int deleteAiModelById(Long modelId)
    {
        return aiModelMapper.deleteAiModelById(modelId);
    }

    @Override
    public int deleteAiModelByIds(Long[] modelIds)
    {
        return aiModelMapper.deleteAiModelByIds(modelIds);
    }
}
