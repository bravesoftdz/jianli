package cn.nova.bus.pack.vo;

import java.io.Serializable;
import java.util.Date;

public class PacktturnoverVO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String upmoneydate;// 营收日期
	private long sellby;// 办理员
	private String sendpacks;// 受理件数
	private String sendpackamount;// 受理金额
	private String pickups;// 提领件数
	private String pickupamount;// 提领金额
	private String depositpieces;// 寄存件数
	private String recaptionspieces;// 小件提取件数
	private String goodsamount;// 寄存金额
	private String moneypayable;// 应缴款
	private String actupmoney;// 实缴款
	private String lastlost;// 上期溢欠款
	private String lost;// 本期溢欠款
	private long receiver;// 收款人
	private Date receipttime;// 收款时间
	private String receiptip;// 收款ip
	private String remak;// 备注
	private long orgid;// 收站机构
	private Date createtime;//			
	private long createby;//			
	private Date updatetime;//	
	private long updateby;//	
	
	
	public String getUpmoneydate() {
		return upmoneydate;
	}
	public void setUpmoneydate(String upmoneydate) {
		this.upmoneydate = upmoneydate;
	}
	public long getSellby() {
		return sellby;
	}
	public void setSellby(long sellby) {
		this.sellby = sellby;
	}
	public String getSendpacks() {
		return sendpacks;
	}
	public void setSendpacks(String sendpacks) {
		this.sendpacks = sendpacks;
	}
	public String getSendpackamount() {
		return sendpackamount;
	}
	public void setSendpackamount(String sendpackamount) {
		this.sendpackamount = sendpackamount;
	}
	public String getPickups() {
		return pickups;
	}
	public void setPickups(String pickups) {
		this.pickups = pickups;
	}
	public String getPickupamount() {
		return pickupamount;
	}
	public void setPickupamount(String pickupamount) {
		this.pickupamount = pickupamount;
	}
	public String getDepositpieces() {
		return depositpieces;
	}
	public void setDepositpieces(String depositpieces) {
		this.depositpieces = depositpieces;
	}
	public String getRecaptionspieces() {
		return recaptionspieces;
	}
	public void setRecaptionspieces(String recaptionspieces) {
		this.recaptionspieces = recaptionspieces;
	}
	public String getGoodsamount() {
		return goodsamount;
	}
	public void setGoodsamount(String goodsamount) {
		this.goodsamount = goodsamount;
	}
	public String getMoneypayable() {
		return moneypayable;
	}
	public void setMoneypayable(String moneypayable) {
		this.moneypayable = moneypayable;
	}
	public String getActupmoney() {
		return actupmoney;
	}
	public void setActupmoney(String actupmoney) {
		this.actupmoney = actupmoney;
	}
	public String getLastlost() {
		return lastlost;
	}
	public void setLastlost(String lastlost) {
		this.lastlost = lastlost;
	}
	public String getLost() {
		return lost;
	}
	public void setLost(String lost) {
		this.lost = lost;
	}
	public long getReceiver() {
		return receiver;
	}
	public void setReceiver(long receiver) {
		this.receiver = receiver;
	}
	public Date getReceipttime() {
		return receipttime;
	}
	public void setReceipttime(Date receipttime) {
		this.receipttime = receipttime;
	}
	public String getReceiptip() {
		return receiptip;
	}
	public void setReceiptip(String receiptip) {
		this.receiptip = receiptip;
	}
	public String getRemak() {
		return remak;
	}
	public void setRemak(String remak) {
		this.remak = remak;
	}
	public long getOrgid() {
		return orgid;
	}
	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}
	public Date getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	public long getCreateby() {
		return createby;
	}
	public void setCreateby(long createby) {
		this.createby = createby;
	}
	public Date getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}
	public long getUpdateby() {
		return updateby;
	}
	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}
	
	
}
