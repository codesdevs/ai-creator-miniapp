package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.AiModelVersion;
import java.util.List;

/**
 * AI 模型版本 数据层
 *
 * @author codex
 */
public interface AiModelVersionMapper
{
    public AiModelVersion selectAiModelVersionById(Long versionId);

    public List<AiModelVersion> selectAiModelVersionList(AiModelVersion aiModelVersion);

    public List<AiModelVersion> selectAiModelVersionListByModelId(Long modelId);

    public int insertAiModelVersion(AiModelVersion aiModelVersion);

    public int updateAiModelVersion(AiModelVersion aiModelVersion);

    public int deleteAiModelVersionById(Long versionId);

    public int deleteAiModelVersionByIds(Long[] versionIds);
}
