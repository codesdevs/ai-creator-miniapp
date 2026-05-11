package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.AiWallet;

/**
 * AI 钱包 数据层
 *
 * @author codex
 */
public interface AiWalletMapper
{
    public AiWallet selectAiWalletByUserId(Long userId);

    public int insertAiWallet(AiWallet aiWallet);

    public int updateAiWallet(AiWallet aiWallet);
}
