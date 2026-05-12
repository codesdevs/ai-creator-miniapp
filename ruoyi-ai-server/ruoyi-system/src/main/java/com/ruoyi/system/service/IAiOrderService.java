package com.ruoyi.system.service;

import com.ruoyi.system.domain.AiOrder;
import com.ruoyi.system.domain.vo.AdminOrderHandleBo;
import java.util.List;

public interface IAiOrderService
{
    public AiOrder selectAiOrderById(Long orderId);

    public List<AiOrder> selectAiOrderList(AiOrder aiOrder);

    public List<AiOrder> selectUserOrderList(Long userId);

    public AiOrder selectUserOrderById(Long userId, Long orderId);

    public int insertAiOrder(AiOrder aiOrder);

    public int updateAiOrder(AiOrder aiOrder);

    public AiOrder createRechargeOrder(Long userId, Long packageId, Long payConfigId);

    public AiOrder cancelUserOrder(Long userId, Long orderId);

    public AiOrder mockPayUserOrder(Long userId, Long orderId);

    public AiOrder adminHandleOrder(AdminOrderHandleBo bo);
}
