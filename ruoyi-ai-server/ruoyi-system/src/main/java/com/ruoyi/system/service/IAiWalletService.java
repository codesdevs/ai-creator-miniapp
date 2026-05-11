package com.ruoyi.system.service;

import com.ruoyi.system.domain.AiWallet;
import com.ruoyi.system.domain.AiWalletFlow;
import java.util.List;

/**
 * AI 钱包 服务层
 *
 * @author codex
 */
public interface IAiWalletService
{
    public AiWallet getOrCreateWallet(Long userId);

    public List<AiWalletFlow> selectAiWalletFlowList(AiWalletFlow aiWalletFlow);

    public void consumePower(Long userId, Integer powerNum, String bizType, Long bizId, String remark);

    public void grantPower(Long userId, Integer powerNum, String bizType, Long bizId, String remark);
}
