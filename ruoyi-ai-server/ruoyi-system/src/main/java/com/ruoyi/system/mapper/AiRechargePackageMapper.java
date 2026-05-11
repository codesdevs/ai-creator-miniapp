package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.AiRechargePackage;
import java.util.List;

public interface AiRechargePackageMapper
{
    public AiRechargePackage selectAiRechargePackageById(Long packageId);

    public List<AiRechargePackage> selectAiRechargePackageList(AiRechargePackage aiRechargePackage);

    public int insertAiRechargePackage(AiRechargePackage aiRechargePackage);

    public int updateAiRechargePackage(AiRechargePackage aiRechargePackage);
}
