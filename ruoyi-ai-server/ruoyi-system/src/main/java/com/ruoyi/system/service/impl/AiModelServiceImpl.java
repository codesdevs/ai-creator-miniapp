package com.ruoyi.system.service.impl;

import com.ruoyi.system.domain.AiModel;
import com.ruoyi.system.mapper.AiModelMapper;
import com.ruoyi.system.service.IAiModelService;
import java.util.List;
import java.util.Locale;
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
        return normalizeModel(aiModelMapper.selectAiModelById(modelId));
    }

    @Override
    public List<AiModel> selectAiModelList(AiModel aiModel)
    {
        List<AiModel> list = aiModelMapper.selectAiModelList(aiModel);
        list.forEach(this::normalizeModel);
        return list;
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

    private AiModel normalizeModel(AiModel model)
    {
        if (model == null)
        {
            return null;
        }
        if (isBlank(model.getIconUrl()))
        {
            model.setIconUrl(resolveMiniAppIcon(model.getModelCode()));
        }
        if (isBlank(model.getCoverUrl()) && !isBlank(model.getIconUrl()))
        {
            model.setCoverUrl(model.getIconUrl());
        }
        return model;
    }

    private String resolveMiniAppIcon(String modelCode)
    {
        if (isBlank(modelCode))
        {
            return "";
        }
        String normalized = modelCode.trim().toLowerCase(Locale.ROOT);
        if (normalized.contains("jimeng"))
        {
            return "/static/images/application/index/tpcz/jmai.png";
        }
        if (normalized.contains("keling"))
        {
            return "/static/images/application/index/tpcz/klai.png";
        }
        if (normalized.contains("seedream"))
        {
            return "/static/images/application/index/tpcz/seedream.png";
        }
        if (normalized.contains("banana"))
        {
            return "/static/images/application/index/tpcz/banana.png";
        }
        if (normalized.contains("gpt-image-2") || normalized.contains("gpt-image"))
        {
            return "/static/images/application/index/tpcz/gpt-image-2.png";
        }
        if (normalized.contains("midjourney"))
        {
            return "/static/images/application/index/tpcz/midjourney.png";
        }
        if (normalized.contains("luma"))
        {
            return "/static/images/application/index/tpcz/luma.png";
        }
        if (normalized.contains("sora2") || normalized.contains("sora"))
        {
            return "/static/images/application/index/tpcz/sora2.png";
        }
        if (normalized.contains("tongyi-wanxiang") || normalized.contains("wanxiang") || normalized.contains("tywx"))
        {
            return "/static/images/application/index/tpcz/tywx.png";
        }
        return "";
    }

    private boolean isBlank(String value)
    {
        return value == null || value.trim().isEmpty();
    }
}
