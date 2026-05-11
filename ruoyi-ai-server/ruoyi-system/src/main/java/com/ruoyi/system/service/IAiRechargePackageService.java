package com.ruoyi.system.service;

import com.ruoyi.system.domain.AiRechargePackage;
import java.util.List;

public interface IAiRechargePackageService
{
    public AiRechargePackage selectAiRechargePackageById(Long packageId);

    public List<AiRechargePackage> selectAiRechargePackageList(AiRechargePackage aiRechargePackage);

    public List<AiRechargePackage> selectEnabledRechargePackageList();

    public int insertAiRechargePackage(AiRechargePackage aiRechargePackage);

    public int updateAiRechargePackage(AiRechargePackage aiRechargePackage);
}
