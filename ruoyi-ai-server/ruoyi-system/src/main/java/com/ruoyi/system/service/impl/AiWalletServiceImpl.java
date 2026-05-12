package com.ruoyi.system.service.impl;

import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.system.domain.AiWallet;
import com.ruoyi.system.domain.AiWalletFlow;
import com.ruoyi.system.mapper.AiWalletFlowMapper;
import com.ruoyi.system.mapper.AiWalletMapper;
import com.ruoyi.system.service.IAiWalletService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
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
        try
        {
            aiWalletMapper.insertAiWallet(wallet);
        }
        catch (DuplicateKeyException ex)
        {
            // 并发创建同一用户钱包时，复用已创建记录。
        }
        return aiWalletMapper.selectAiWalletByUserId(userId);
    }

    @Override
    public AiWallet selectAiWalletByUserId(Long userId)
    {
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
        getOrCreateWallet(userId);
        int rows = aiWalletMapper.consumePower(userId, powerNum);
        if (rows <= 0)
        {
            throw new ServiceException("算力不足，请先充值");
        }
        AiWallet wallet = aiWalletMapper.selectAiWalletByUserId(userId);
        int afterBalance = wallet.getBalancePower() == null ? 0 : wallet.getBalancePower();
        insertFlow(userId, bizType, bizId, "CONSUME", powerNum, afterBalance + powerNum, afterBalance, remark);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void grantPower(Long userId, Integer powerNum, String bizType, Long bizId, String remark)
    {
        if (powerNum == null || powerNum <= 0)
        {
            throw new ServiceException("赠送算力必须大于0");
        }
        getOrCreateWallet(userId);
        int rows = aiWalletMapper.grantPower(userId, powerNum);
        if (rows <= 0)
        {
            throw new ServiceException("钱包不存在");
        }
        AiWallet wallet = aiWalletMapper.selectAiWalletByUserId(userId);
        int afterBalance = wallet.getBalancePower() == null ? 0 : wallet.getBalancePower();
        insertFlow(userId, bizType, bizId, "GRANT", powerNum, afterBalance - powerNum, afterBalance, remark);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void rechargePower(Long userId, Integer powerNum, String bizType, Long bizId, String remark)
    {
        if (powerNum == null || powerNum <= 0)
        {
            throw new ServiceException("充值算力必须大于0");
        }
        getOrCreateWallet(userId);
        int rows = aiWalletMapper.rechargePower(userId, powerNum);
        if (rows <= 0)
        {
            throw new ServiceException("钱包不存在");
        }
        AiWallet wallet = aiWalletMapper.selectAiWalletByUserId(userId);
        int afterBalance = wallet.getBalancePower() == null ? 0 : wallet.getBalancePower();
        insertFlow(userId, bizType, bizId, "GRANT", powerNum, afterBalance - powerNum, afterBalance, remark);
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
