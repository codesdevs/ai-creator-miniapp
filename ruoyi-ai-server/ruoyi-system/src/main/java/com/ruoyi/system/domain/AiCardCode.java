package com.ruoyi.system.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
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

    private Long cardCodeId;
    private Long packageId;
    private String packageName;
    private String cardCode;
    private Integer powerNum;
    private Integer bonusPowerNum;
    private String status;
    private Long usedUserId;
    private Long orderId;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date usedTime;
    private String createBy;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    private String updateBy;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateTime;
    private String remark;
    private String userNo;
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
