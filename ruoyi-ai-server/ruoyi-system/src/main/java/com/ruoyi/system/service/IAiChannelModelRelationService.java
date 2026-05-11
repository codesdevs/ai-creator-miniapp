package com.ruoyi.system.service;

import com.ruoyi.system.domain.AiChannelModelRelation;
import java.util.List;

public interface IAiChannelModelRelationService
{
    public AiChannelModelRelation selectAiChannelModelRelationById(Long relationId);

    public List<AiChannelModelRelation> selectAiChannelModelRelationList(AiChannelModelRelation aiChannelModelRelation);

    public int insertAiChannelModelRelation(AiChannelModelRelation aiChannelModelRelation);

    public int updateAiChannelModelRelation(AiChannelModelRelation aiChannelModelRelation);

    public int deleteAiChannelModelRelationById(Long relationId);

    public int deleteAiChannelModelRelationByIds(Long[] relationIds);
}
