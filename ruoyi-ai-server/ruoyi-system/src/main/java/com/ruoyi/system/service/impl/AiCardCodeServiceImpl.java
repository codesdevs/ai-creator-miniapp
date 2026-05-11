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
import com.ruoyi.system.service.IAiWalletService;
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

    @Autowired
    private IAiWalletService aiWalletService;

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
    @Transactional(rollbackFor = Exception.class)
    public AiCardCode redeemCardCode(Long userId, String cardCode)
    {
        if (userId == null)
        {
            throw new ServiceException("用户信息不能为空");
        }
        if (StringUtils.isBlank(cardCode))
        {
            throw new ServiceException("卡密不能为空");
        }
        AiCardCode entity = aiCardCodeMapper.selectAiCardCodeByCode(cardCode.trim().toUpperCase());
        if (entity == null)
        {
            throw new ServiceException("卡密不存在");
        }
        if (!StringUtils.equals("0", entity.getStatus()))
        {
            throw new ServiceException("卡密不可用");
        }

        entity.setStatus("1");
        entity.setUsedUserId(userId);
        entity.setUsedTime(DateUtils.getNowDate());
        entity.setUpdateTime(DateUtils.getNowDate());
        entity.setRemark(StringUtils.defaultIfBlank(entity.getRemark(), "卡密兑换"));
        aiCardCodeMapper.updateAiCardCode(entity);

        int power = (entity.getPowerNum() == null ? 0 : entity.getPowerNum()) + (entity.getBonusPowerNum() == null ? 0 : entity.getBonusPowerNum());
        aiWalletService.rechargePower(userId, power, "CARD_CODE_REDEEM", entity.getCardCodeId(), "卡密兑换到账：" + entity.getCardCode());
        return aiCardCodeMapper.selectAiCardCodeById(entity.getCardCodeId());
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
    public int updateAiCardCode(AiCardCode aiCardCode)
    {
        AiCardCode dbCardCode = aiCardCodeMapper.selectAiCardCodeById(aiCardCode.getCardCodeId());
        if (dbCardCode == null)
        {
            throw new ServiceException("卡密不存在");
        }
        if (StringUtils.equals("1", dbCardCode.getStatus()))
        {
            throw new ServiceException("已使用卡密不允许修改");
        }
        fillPackageSnapshot(aiCardCode);
        if (StringUtils.isBlank(aiCardCode.getCardCode()))
        {
            aiCardCode.setCardCode(dbCardCode.getCardCode());
        }
        else
        {
            aiCardCode.setCardCode(aiCardCode.getCardCode().trim().toUpperCase());
        }
        aiCardCode.setUsedUserId(dbCardCode.getUsedUserId());
        aiCardCode.setOrderId(dbCardCode.getOrderId());
        aiCardCode.setUsedTime(dbCardCode.getUsedTime());
        aiCardCode.setUpdateTime(DateUtils.getNowDate());
        return aiCardCodeMapper.updateAiCardCode(aiCardCode);
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
