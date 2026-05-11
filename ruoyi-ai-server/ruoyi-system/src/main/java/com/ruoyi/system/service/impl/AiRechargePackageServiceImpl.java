package com.ruoyi.system.service.impl;

import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.system.domain.AiRechargePackage;
import com.ruoyi.system.mapper.AiRechargePackageMapper;
import com.ruoyi.system.service.IAiRechargePackageService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AiRechargePackageServiceImpl implements IAiRechargePackageService
{
    @Autowired
    private AiRechargePackageMapper aiRechargePackageMapper;

    @Override
    public AiRechargePackage selectAiRechargePackageById(Long packageId)
    {
        return aiRechargePackageMapper.selectAiRechargePackageById(packageId);
    }

    @Override
    public List<AiRechargePackage> selectAiRechargePackageList(AiRechargePackage aiRechargePackage)
    {
        return aiRechargePackageMapper.selectAiRechargePackageList(aiRechargePackage);
    }

    @Override
    public List<AiRechargePackage> selectEnabledRechargePackageList()
    {
        AiRechargePackage query = new AiRechargePackage();
        query.setStatus("0");
        return aiRechargePackageMapper.selectAiRechargePackageList(query);
    }

    @Override
    public int insertAiRechargePackage(AiRechargePackage aiRechargePackage)
    {
        aiRechargePackage.setCreateTime(DateUtils.getNowDate());
        return aiRechargePackageMapper.insertAiRechargePackage(aiRechargePackage);
    }

    @Override
    public int updateAiRechargePackage(AiRechargePackage aiRechargePackage)
    {
        aiRechargePackage.setUpdateTime(DateUtils.getNowDate());
        return aiRechargePackageMapper.updateAiRechargePackage(aiRechargePackage);
    }
}
