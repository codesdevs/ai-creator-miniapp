package com.ruoyi.system.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.annotation.Excel.ColumnType;
import java.io.Serializable;
import java.util.Date;

/**
 * 卡密对象 ai_c_card_code
 *
 * @author codex
 */
public class AiCardCode implements Serializable
{
    private static final long serialVersionUID = 1L;

    @Excel(name = "卡密ID", cellType = ColumnType.NUMERIC)
    private Long cardCodeId;
    @Excel(name = "卡包ID", cellType = ColumnType.NUMERIC)
    private Long packageId;
    @Excel(name = "卡包名称")
    private String packageName;
    @Excel(name = "卡密")
    private String cardCode;
    @Excel(name = "基础算力", cellType = ColumnType.NUMERIC)
    private Integer powerNum;
    @Excel(name = "赠送算力", cellType = ColumnType.NUMERIC)
    private Integer bonusPowerNum;
    @Excel(name = "状态", readConverterExp = "0=未使用,1=已使用,2=停用")
    private String status;
    private Long usedUserId;
    @Excel(name = "关联订单ID", cellType = ColumnType.NUMERIC)
    private Long orderId;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "使用时间", width = 20, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date usedTime;
    private String createBy;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "创建时间", width = 20, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    private String updateBy;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateTime;
    @Excel(name = "备注", width = 30)
    private String remark;
    @Excel(name = "用户编号")
    private String userNo;
    @Excel(name = "使用用户")
    private String nickName;

    public Long getCardCodeId() { return cardCodeId; }
    public void setCardCodeId(Long cardCodeId) { this.cardCodeId = cardCodeId; }
    public Long getPackageId() { return packageId; }
    public void setPackageId(Long packageId) { this.packageId = packageId; }
    public String getPackageName() { return packageName; }
    public void setPackageName(String packageName) { this.packageName = packageName; }
    public String getCardCode() { return cardCode; }
    public void setCardCode(String cardCode) { this.cardCode = cardCode; }
    public Integer getPowerNum() { return powerNum; }
    public void setPowerNum(Integer powerNum) { this.powerNum = powerNum; }
    public Integer getBonusPowerNum() { return bonusPowerNum; }
    public void setBonusPowerNum(Integer bonusPowerNum) { this.bonusPowerNum = bonusPowerNum; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Long getUsedUserId() { return usedUserId; }
    public void setUsedUserId(Long usedUserId) { this.usedUserId = usedUserId; }
    public Long getOrderId() { return orderId; }
    public void setOrderId(Long orderId) { this.orderId = orderId; }
    public Date getUsedTime() { return usedTime; }
    public void setUsedTime(Date usedTime) { this.usedTime = usedTime; }
    public String getCreateBy() { return createBy; }
    public void setCreateBy(String createBy) { this.createBy = createBy; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public String getUpdateBy() { return updateBy; }
    public void setUpdateBy(String updateBy) { this.updateBy = updateBy; }
    public Date getUpdateTime() { return updateTime; }
    public void setUpdateTime(Date updateTime) { this.updateTime = updateTime; }
    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
    public String getUserNo() { return userNo; }
    public void setUserNo(String userNo) { this.userNo = userNo; }
    public String getNickName() { return nickName; }
    public void setNickName(String nickName) { this.nickName = nickName; }
}
