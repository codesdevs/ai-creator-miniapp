package com.ruoyi.system.service.impl;

import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.system.domain.AiWallet;
import com.ruoyi.system.domain.AiWalletFlow;
import com.ruoyi.system.mapper.AiWalletFlowMapper;
import com.ruoyi.system.mapper.AiWalletMapper;
import com.ruoyi.system.service.IAiWalletService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * AI 钱包 服务层实现
 *
 * @author codex
 */
@Service
public class AiWalletServiceImpl implements IAiWalletService
{
    @Autowired
    private AiWalletMapper aiWalletMapper;

    @Autowired
    private AiWalletFlowMapper aiWalletFlowMapper;

    @Override
    public AiWallet getOrCreateWallet(Long userId)
    {
        AiWallet wallet = aiWalletMapper.selectAiWalletByUserId(userId);
        if (wallet != null)
        {
            return wallet;
        }
        wallet = new AiWallet();
        wallet.setUserId(userId);
        wallet.setBalancePower(0);
        wallet.setFreezePower(0);
        wallet.setTotalRechargePower(0);
        wallet.setTotalConsumePower(0);
        wallet.setTotalGivePower(0);
        aiWalletMapper.insertAiWallet(wallet);
        return aiWalletMapper.selectAiWalletByUserId(userId);
    }

    @Override
    public List<AiWalletFlow> selectAiWalletFlowList(AiWalletFlow aiWalletFlow)
    {
        return aiWalletFlowMapper.selectAiWalletFlowList(aiWalletFlow);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void consumePower(Long userId, Integer powerNum, String bizType, Long bizId, String remark)
    {
        if (powerNum == null || powerNum <= 0)
        {
            return;
        }
        AiWallet wallet = getOrCreateWallet(userId);
        int beforeBalance = wallet.getBalancePower() == null ? 0 : wallet.getBalancePower();
        if (beforeBalance < powerNum)
        {
            throw new ServiceException("算力不足，请先充值");
        }
        int afterBalance = beforeBalance - powerNum;
        wallet.setBalancePower(afterBalance);
        wallet.setTotalConsumePower((wallet.getTotalConsumePower() == null ? 0 : wallet.getTotalConsumePower()) + powerNum);
        aiWalletMapper.updateAiWallet(wallet);
        insertFlow(userId, bizType, bizId, "CONSUME", powerNum, beforeBalance, afterBalance, remark);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void grantPower(Long userId, Integer powerNum, String bizType, Long bizId, String remark)
    {
        if (powerNum == null || powerNum <= 0)
        {
            throw new ServiceException("赠送算力必须大于0");
        }
        AiWallet wallet = getOrCreateWallet(userId);
        int beforeBalance = wallet.getBalancePower() == null ? 0 : wallet.getBalancePower();
        int afterBalance = beforeBalance + powerNum;
        wallet.setBalancePower(afterBalance);
        wallet.setTotalGivePower((wallet.getTotalGivePower() == null ? 0 : wallet.getTotalGivePower()) + powerNum);
        aiWalletMapper.updateAiWallet(wallet);
        insertFlow(userId, bizType, bizId, "GRANT", powerNum, beforeBalance, afterBalance, remark);
    }

    private void insertFlow(Long userId, String bizType, Long bizId, String changeType, Integer powerNum,
            Integer beforeBalance, Integer afterBalance, String remark)
    {
        AiWalletFlow flow = new AiWalletFlow();
        flow.setUserId(userId);
        flow.setBizType(bizType);
        flow.setBizId(bizId);
        flow.setChangeType(changeType);
        flow.setPowerNum(powerNum);
        flow.setBeforeBalance(beforeBalance);
        flow.setAfterBalance(afterBalance);
        flow.setRemark(remark);
        aiWalletFlowMapper.insertAiWalletFlow(flow);
    }
}
