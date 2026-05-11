package com.ruoyi.system.service.impl;

import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.uuid.IdUtils;
import com.ruoyi.system.domain.AiOrder;
import com.ruoyi.system.domain.AiPayConfig;
import com.ruoyi.system.domain.AiRechargePackage;
import com.ruoyi.system.domain.vo.AdminOrderHandleBo;
import com.ruoyi.system.mapper.AiOrderMapper;
import com.ruoyi.system.service.IAiPayConfigService;
import com.ruoyi.system.service.IAiRechargePackageService;
import com.ruoyi.system.service.IAiOrderService;
import com.ruoyi.system.service.IAiWalletService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AiOrderServiceImpl implements IAiOrderService
{
    @Autowired
    private AiOrderMapper aiOrderMapper;

    @Autowired
    private IAiWalletService aiWalletService;

    @Autowired
    private IAiRechargePackageService aiRechargePackageService;

    @Autowired
    private IAiPayConfigService aiPayConfigService;

    @Override
    public AiOrder selectAiOrderById(Long orderId)
    {
        return aiOrderMapper.selectAiOrderById(orderId);
    }

    @Override
    public List<AiOrder> selectAiOrderList(AiOrder aiOrder)
    {
        return aiOrderMapper.selectAiOrderList(aiOrder);
    }

    @Override
    public List<AiOrder> selectUserOrderList(Long userId)
    {
        AiOrder query = new AiOrder();
        query.setUserId(userId);
        return aiOrderMapper.selectAiOrderList(query);
    }

    @Override
    public int insertAiOrder(AiOrder aiOrder)
    {
        aiOrder.setCreateTime(DateUtils.getNowDate());
        return aiOrderMapper.insertAiOrder(aiOrder);
    }

    @Override
    public int updateAiOrder(AiOrder aiOrder)
    {
        aiOrder.setUpdateTime(DateUtils.getNowDate());
        return aiOrderMapper.updateAiOrder(aiOrder);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public AiOrder createRechargeOrder(Long userId, Long packageId, Long payConfigId)
    {
        if (userId == null)
        {
            throw new ServiceException("用户信息不能为空");
        }
        if (packageId == null)
        {
            throw new ServiceException("套餐ID不能为空");
        }

        AiRechargePackage rechargePackage = aiRechargePackageService.selectAiRechargePackageById(packageId);
        if (rechargePackage == null)
        {
            throw new ServiceException("充值套餐不存在");
        }
        if (!StringUtils.equals("0", rechargePackage.getStatus()))
        {
            throw new ServiceException("充值套餐已停用");
        }

        AiPayConfig payConfig = payConfigId == null
            ? aiPayConfigService.selectDefaultEnabledPayConfig()
            : aiPayConfigService.selectAiPayConfigById(payConfigId);
        if (payConfig == null)
        {
            throw new ServiceException("支付配置不存在");
        }
        if (!StringUtils.equals("0", payConfig.getStatus()))
        {
            throw new ServiceException("支付配置已停用");
        }

        AiOrder order = new AiOrder();
        order.setOrderNo(buildOrderNo());
        order.setUserId(userId);
        order.setPackageId(rechargePackage.getPackageId());
        order.setPackageName(rechargePackage.getPackageName());
        order.setPayConfigId(payConfig.getPayConfigId());
        order.setPayChannel(payConfig.getPayChannel());
        order.setPowerNum(rechargePackage.getPowerNum());
        order.setBonusPowerNum(rechargePackage.getBonusPowerNum());
        order.setPayAmount(rechargePackage.getSalePrice());
        order.setOrderStatus("WAIT_PAY");
        order.setRemark("小程序端创建充值订单");
        insertAiOrder(order);
        return aiOrderMapper.selectAiOrderById(order.getOrderId());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public AiOrder adminHandleOrder(AdminOrderHandleBo bo)
    {
        AiOrder order = aiOrderMapper.selectAiOrderById(bo.getOrderId());
        if (order == null)
        {
            throw new ServiceException("订单不存在");
        }
        String beforeStatus = order.getOrderStatus();
        order.setOrderStatus(bo.getOrderStatus());
        order.setThirdOrderNo(bo.getThirdOrderNo());
        order.setRemark(bo.getRemark());
        if ("PAID".equals(bo.getOrderStatus()) && !"PAID".equals(beforeStatus))
        {
            order.setPayTime(DateUtils.getNowDate());
            aiWalletService.rechargePower(order.getUserId(),
                (order.getPowerNum() == null ? 0 : order.getPowerNum()) + (order.getBonusPowerNum() == null ? 0 : order.getBonusPowerNum()),
                "ORDER_RECHARGE", order.getOrderId(), "充值订单到账：" + order.getOrderNo());
        }
        order.setUpdateTime(DateUtils.getNowDate());
        aiOrderMapper.updateAiOrder(order);
        return aiOrderMapper.selectAiOrderById(order.getOrderId());
    }

    private String buildOrderNo()
    {
        return "RC" + DateUtils.dateTimeNow() + IdUtils.fastSimpleUUID().substring(0, 6).toUpperCase();
    }
}
