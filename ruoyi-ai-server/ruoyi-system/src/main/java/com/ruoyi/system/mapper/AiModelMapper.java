package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.AiModel;
import java.util.List;

/**
 * AI 模型配置 数据层
 *
 * @author codex
 */
public interface AiModelMapper
{
    public AiModel selectAiModelById(Long modelId);

    public List<AiModel> selectAiModelList(AiModel aiModel);

    public int insertAiModel(AiModel aiModel);

    public int updateAiModel(AiModel aiModel);

    public int deleteAiModelById(Long modelId);

    public int deleteAiModelByIds(Long[] modelIds);
}
