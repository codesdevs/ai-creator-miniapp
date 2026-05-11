package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.AiWalletFlow;
import java.util.List;

/**
 * AI 钱包流水 数据层
 *
 * @author codex
 */
public interface AiWalletFlowMapper
{
    public List<AiWalletFlow> selectAiWalletFlowList(AiWalletFlow aiWalletFlow);

    public int insertAiWalletFlow(AiWalletFlow aiWalletFlow);

    public int countAiWalletFlowByBiz(String bizType, Long bizId, String changeType);
}
