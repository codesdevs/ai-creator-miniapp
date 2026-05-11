package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.AiOrder;
import java.util.List;

public interface AiOrderMapper
{
    public AiOrder selectAiOrderById(Long orderId);

    public List<AiOrder> selectAiOrderList(AiOrder aiOrder);

    public int insertAiOrder(AiOrder aiOrder);

    public int updateAiOrder(AiOrder aiOrder);
}
