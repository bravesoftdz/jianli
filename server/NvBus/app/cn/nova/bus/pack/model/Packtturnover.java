package cn.nova.bus.pack.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
public class Packtturnover implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@SequenceGenerator(name = "PACKTTURNOVER_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "PACKTTURNOVER_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 6)
	private long id;//	number(10)	n		
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date upmoneydate;//	Date	n			营收日期
	private long sellby;//	number(10)	n			办理员
	private int sendpacks;//	number(6)	y			受理件数
	
	@Column(nullable = true, precision = 10, scale = 2)
	private BigDecimal sendpackamount;//	number(10,2)	n			受理营收
	private int pickups;//	NUMBER(6)	y			提领件数
	
	@Column(nullable = true, precision = 10, scale = 2)
	private BigDecimal pickupamount;//	number(10,2)	y			提领营收
	private int goods;//	varchar2(20)	y			寄存件数
	
	@Column(nullable = true, precision = 10, scale = 2)
	private BigDecimal goodsamount;//	number(10,2)	y			寄存营收
	@Column(nullable = true, precision = 10, scale = 2)
	private BigDecimal moneypayable;//	number(10,2)	y			应缴款
	@Column(nullable = true, precision = 10, scale = 2)
	private BigDecimal actupmoney;//	number(10,2)	y			实缴款
	@Column(nullable = true, precision = 10, scale = 2)
	private BigDecimal lastlost;//	number(10,2)	y			上期溢欠款(现金)
	@Column(nullable = true, precision = 10, scale = 2)
	private BigDecimal lost;//	number(10,2)	y			本期溢欠款(现金)
	
	@Column(nullable = true, precision = 10, scale = 2)
	private BigDecimal packstrike;
	
	private long receiver;//	number(10)	y			收款人id
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date receipttime;//	date	y			收款时间
	private String receiptip;//	varchar2(20)	y			收款ip
	private String remak;//	varchar2(50)	y			备注
	private long orgid;//	number(10)	y			收站机构id
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;//	date	n	sysdate		
	private long createby;//	number(10)	n			
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;//	date	n	sysdate		
	private long updateby;//	number(10)	n
	
	public Packtturnover() {
		// TODO Auto-generated constructor stub
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Date getUpmoneydate() {
		return upmoneydate;
	}

	public void setUpmoneydate(Date upmoneydate) {
		this.upmoneydate = upmoneydate;
	}

	public long getSellby() {
		return sellby;
	}

	public void setSellby(long sellby) {
		this.sellby = sellby;
	}

	public int getSendpacks() {
		return sendpacks;
	}

	public void setSendpacks(int sendpacks) {
		this.sendpacks = sendpacks;
	}

	public BigDecimal getSendpackamount() {
		return sendpackamount;
	}

	public void setSendpackamount(BigDecimal sendpackamount) {
		this.sendpackamount = sendpackamount;
	}

	public int getPickups() {
		return pickups;
	}

	public void setPickups(int pickups) {
		this.pickups = pickups;
	}

	public BigDecimal getPickupamount() {
		return pickupamount;
	}

	public void setPickupamount(BigDecimal pickupamount) {
		this.pickupamount = pickupamount;
	}

	public int getGoods() {
		return goods;
	}

	public void setGoods(int goods) {
		this.goods = goods;
	}

	public BigDecimal getGoodsamount() {
		return goodsamount;
	}

	public void setGoodsamount(BigDecimal goodsamount) {
		this.goodsamount = goodsamount;
	}

	public BigDecimal getMoneypayable() {
		return moneypayable;
	}

	public void setMoneypayable(BigDecimal moneypayable) {
		this.moneypayable = moneypayable;
	}

	public BigDecimal getActupmoney() {
		return actupmoney;
	}

	public void setActupmoney(BigDecimal actupmoney) {
		this.actupmoney = actupmoney;
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

	public BigDecimal getLastlost() {
		return lastlost;
	}

	public void setLastlost(BigDecimal lastlost) {
		this.lastlost = lastlost;
	}

	public BigDecimal getLost() {
		return lost;
	}

	public void setLost(BigDecimal lost) {
		this.lost = lost;
	}

	public BigDecimal getPackstrike() {
		return packstrike;
	}

	public void setPackstrike(BigDecimal packstrike) {
		this.packstrike = packstrike;
	}
	
	

}
