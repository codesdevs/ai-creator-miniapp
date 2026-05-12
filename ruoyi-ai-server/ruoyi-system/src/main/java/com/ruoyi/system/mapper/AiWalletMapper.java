package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.AiWallet;
import org.apache.ibatis.annotations.Param;

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

    public int consumePower(@Param("userId") Long userId, @Param("powerNum") Integer powerNum);

    public int grantPower(@Param("userId") Long userId, @Param("powerNum") Integer powerNum);

    public int rechargePower(@Param("userId") Long userId, @Param("powerNum") Integer powerNum);
}
