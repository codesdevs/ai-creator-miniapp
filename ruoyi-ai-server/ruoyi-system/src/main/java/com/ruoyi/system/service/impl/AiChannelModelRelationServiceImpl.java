package com.ruoyi.system.service.impl;

import com.ruoyi.system.domain.AiChannelModelRelation;
import com.ruoyi.system.mapper.AiChannelModelRelationMapper;
import com.ruoyi.system.service.IAiChannelModelRelationService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AiChannelModelRelationServiceImpl implements IAiChannelModelRelationService
{
    @Autowired
    private AiChannelModelRelationMapper aiChannelModelRelationMapper;

    @Override
    public AiChannelModelRelation selectAiChannelModelRelationById(Long relationId)
    {
        return aiChannelModelRelationMapper.selectAiChannelModelRelationById(relationId);
    }

    @Override
    public List<AiChannelModelRelation> selectAiChannelModelRelationList(AiChannelModelRelation aiChannelModelRelation)
    {
        return aiChannelModelRelationMapper.selectAiChannelModelRelationList(aiChannelModelRelation);
    }

    @Override
    public int insertAiChannelModelRelation(AiChannelModelRelation aiChannelModelRelation)
    {
        return aiChannelModelRelationMapper.insertAiChannelModelRelation(aiChannelModelRelation);
    }

    @Override
    public int updateAiChannelModelRelation(AiChannelModelRelation aiChannelModelRelation)
    {
        return aiChannelModelRelationMapper.updateAiChannelModelRelation(aiChannelModelRelation);
    }

    @Override
    public int deleteAiChannelModelRelationById(Long relationId)
    {
        return aiChannelModelRelationMapper.deleteAiChannelModelRelationById(relationId);
    }

    @Override
    public int deleteAiChannelModelRelationByIds(Long[] relationIds)
    {
        return aiChannelModelRelationMapper.deleteAiChannelModelRelationByIds(relationIds);
    }
}
