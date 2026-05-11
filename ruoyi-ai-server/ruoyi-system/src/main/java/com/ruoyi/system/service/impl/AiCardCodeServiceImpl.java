package com.ruoyi.system.service.impl;

import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.uuid.IdUtils;
import com.ruoyi.system.domain.AiCardCode;
import com.ruoyi.system.domain.AiRechargePackage;
import com.ruoyi.system.domain.vo.AdminCardCodeGenerateBo;
import com.ruoyi.system.mapper.AiCardCodeMapper;
import com.ruoyi.system.service.IAiCardCodeService;
import com.ruoyi.system.service.IAiRechargePackageService;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AiCardCodeServiceImpl implements IAiCardCodeService
{
    @Autowired
    private AiCardCodeMapper aiCardCodeMapper;

    @Autowired
    private IAiRechargePackageService aiRechargePackageService;

    @Override
    public AiCardCode selectAiCardCodeById(Long cardCodeId)
    {
        return aiCardCodeMapper.selectAiCardCodeById(cardCodeId);
    }

    @Override
    public List<AiCardCode> selectAiCardCodeList(AiCardCode aiCardCode)
    {
        return aiCardCodeMapper.selectAiCardCodeList(aiCardCode);
    }

    @Override
    public int insertAiCardCode(AiCardCode aiCardCode)
    {
        fillPackageSnapshot(aiCardCode);
        if (StringUtils.isBlank(aiCardCode.getCardCode()))
        {
            aiCardCode.setCardCode(buildCardCode());
        }
        aiCardCode.setStatus(StringUtils.defaultIfBlank(aiCardCode.getStatus(), "0"));
        aiCardCode.setCreateTime(DateUtils.getNowDate());
        return aiCardCodeMapper.insertAiCardCode(aiCardCode);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int batchGenerateAiCardCode(AdminCardCodeGenerateBo bo)
    {
        if (bo.getQuantity() == null || bo.getQuantity() < 1 || bo.getQuantity() > 200)
        {
            throw new ServiceException("生成数量需在1到200之间");
        }
        AiRechargePackage rechargePackage = getRechargePackage(bo.getPackageId());
        List<AiCardCode> list = new ArrayList<>();
        for (int i = 0; i < bo.getQuantity(); i++)
        {
            AiCardCode cardCode = new AiCardCode();
            cardCode.setPackageId(rechargePackage.getPackageId());
            cardCode.setPackageName(rechargePackage.getPackageName());
            cardCode.setPowerNum(rechargePackage.getPowerNum());
            cardCode.setBonusPowerNum(rechargePackage.getBonusPowerNum());
            cardCode.setCardCode(buildCardCode());
            cardCode.setStatus("0");
            cardCode.setCreateTime(DateUtils.getNowDate());
            cardCode.setRemark(StringUtils.defaultString(bo.getRemark()));
            list.add(cardCode);
        }
        return aiCardCodeMapper.batchInsertAiCardCode(list);
    }

    @Override
    public int deleteAiCardCodeByIds(Long[] cardCodeIds)
    {
        return aiCardCodeMapper.deleteAiCardCodeByIds(cardCodeIds);
    }

    private void fillPackageSnapshot(AiCardCode aiCardCode)
    {
        AiRechargePackage rechargePackage = getRechargePackage(aiCardCode.getPackageId());
        aiCardCode.setPackageName(rechargePackage.getPackageName());
        aiCardCode.setPowerNum(rechargePackage.getPowerNum());
        aiCardCode.setBonusPowerNum(rechargePackage.getBonusPowerNum());
    }

    private AiRechargePackage getRechargePackage(Long packageId)
    {
        if (packageId == null)
        {
            throw new ServiceException("卡包ID不能为空");
        }
        AiRechargePackage rechargePackage = aiRechargePackageService.selectAiRechargePackageById(packageId);
        if (rechargePackage == null)
        {
            throw new ServiceException("卡包不存在");
        }
        return rechargePackage;
    }

    private String buildCardCode()
    {
        return "CK" + IdUtils.fastSimpleUUID().substring(0, 14).toUpperCase();
    }
}
