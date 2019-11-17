package cn.nova.bus.pack.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.utils.orm.listener.SyncCodeGenerate;

@Entity
@Table(name="PACKTTURNOVERDETAIL")
@EntityListeners({SyncCodeGenerate.class})
public class Packtturnoverdetail implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@SequenceGenerator(name = "PACKTTURNOVERDETAIL_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "PACKTTURNOVERDETAIL_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 6)
	private long id;//	number(10)	n
	
	private long packtturnoverid;
	
	@Temporal( TemporalType.DATE)
	private Date moneydate;
	
	private long sellby;//	number(10)	n			办理员
		
	private String ticketstartno;
		
	private String ticketendno;

	@Temporal( TemporalType.TIMESTAMP)
	private Date turnovertime;
	
	@Temporal( TemporalType.TIMESTAMP)
	private Date audittime;
		
	private int sendpacks;//	number(6)	y			受理件数
	
	private BigDecimal sendpackamount;//	number(10,2)	n			受理营收
	private int pickups;//	NUMBER(6)	y			提领件数
	
	private BigDecimal pickupamount;//	number(10,2)	y			提领营收
	
	private BigDecimal moneypayable;//	number(10,2)	y			应缴款
	
	@Column(nullable=false, precision=1)
	private boolean isturnover;
	
	@Column(nullable=false, precision=1)
	private boolean isaudit;
	
	private String batchno;
	
	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal shipprice;// number(6,2) y 托运费

	@Column(precision = 6, scale = 2)
	private BigDecimal packfee;// number(6,2) y 包装费

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal handfee;// number(6,2) y 发货装卸费

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal unloadfee;// number(6,2) y 到货装卸费
	  
	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal custodial;// number(6,2) y 保管费

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal transitfee;// number(6,2) y 中转费

	@Column(nullable = true, precision = 8, scale = 2)
	private BigDecimal insuredamount;// number(8,2) y 保价金额

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal insurancefee;// number(6,2) y 保价费

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal deliveryfee;// 送货费

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal insurance;// number(6,2) y 保险费
	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal servicefee;// number(6,2) y 服务费

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal otherfee;// number(6,2) y 其他费用
	
	@Column(nullable = true, precision = 8, scale = 2)
	private BigDecimal packprice;// number(8,2) y 代收货款
	
	private String synccode;
	
	private long orgid;//	number(10)	y			收站机构id
	
	private String datafrom;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;//	date	n	sysdate		
	private long createby;//	number(10)	n			
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;//	date	n	sysdate		
	private long updateby;//	number(10)	n
	private long cancelnum; 
	private long returnnum; 
	private long ticketnum; 
	private BigDecimal returnhandcharge; 
	private BigDecimal returnmoney;
	
	private String paymethod;// 增加行包付款方式字段    maxiao 2016年11月23日15:44:06
	
	public long getCancelnum() {
		return cancelnum;
	}

	public void setCancelnum(long cancelnum) {
		this.cancelnum = cancelnum;
	}

	public long getReturnnum() {
		return returnnum;
	}

	public void setReturnnum(long returnnum) {
		this.returnnum = returnnum;
	}

	public long getTicketnum() {
		return ticketnum;
	}

	public void setTicketnum(long ticketnum) {
		this.ticketnum = ticketnum;
	}

	public BigDecimal getReturnhandcharge() {
		return returnhandcharge;
	}

	public void setReturnhandcharge(BigDecimal returnhandcharge) {
		this.returnhandcharge = returnhandcharge;
	}

	public BigDecimal getReturnmoney() {
		return returnmoney;
	}

	public void setReturnmoney(BigDecimal returnmoney) {
		this.returnmoney = returnmoney;
	}

	public Packtturnoverdetail() {
		// TODO Auto-generated constructor stub
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getPacktturnoverid() {
		return packtturnoverid;
	}

	public void setPacktturnoverid(long packtturnoverid) {
		this.packtturnoverid = packtturnoverid;
	}

	public Date getMoneydate() {
		return moneydate;
	}

	public void setMoneydate(Date moneydate) {
		this.moneydate = moneydate;
	}

	public long getSellby() {
		return sellby;
	}

	public void setSellby(long sellby) {
		this.sellby = sellby;
	}

	public String getTicketstartno() {
		return ticketstartno;
	}

	public void setTicketstartno(String ticketstartno) {
		this.ticketstartno = ticketstartno;
	}

	public String getTicketendno() {
		return ticketendno;
	}

	public void setTicketendno(String ticketendno) {
		this.ticketendno = ticketendno;
	}

	public Date getTurnovertime() {
		return turnovertime;
	}

	public void setTurnovertime(Date turnovertime) {
		this.turnovertime = turnovertime;
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

	public BigDecimal getMoneypayable() {
		return moneypayable;
	}

	public void setMoneypayable(BigDecimal moneypayable) {
		this.moneypayable = moneypayable;
	}

	public boolean isIsturnover() {
		return isturnover;
	}

	public void setIsturnover(boolean isturnover) {
		this.isturnover = isturnover;
	}

	public String getBatchno() {
		return batchno;
	}

	public void setBatchno(String batchno) {
		this.batchno = batchno;
	}

	public BigDecimal getShipprice() {
		return shipprice;
	}

	public void setShipprice(BigDecimal shipprice) {
		this.shipprice = shipprice;
	}

	public BigDecimal getPackfee() {
		return packfee;
	}

	public void setPackfee(BigDecimal packfee) {
		this.packfee = packfee;
	}

	public BigDecimal getHandfee() {
		return handfee;
	}

	public void setHandfee(BigDecimal handfee) {
		this.handfee = handfee;
	}

	public BigDecimal getUnloadfee() {
		return unloadfee;
	}

	public void setUnloadfee(BigDecimal unloadfee) {
		this.unloadfee = unloadfee;
	}

	public BigDecimal getCustodial() {
		return custodial;
	}

	public void setCustodial(BigDecimal custodial) {
		this.custodial = custodial;
	}

	public BigDecimal getTransitfee() {
		return transitfee;
	}

	public void setTransitfee(BigDecimal transitfee) {
		this.transitfee = transitfee;
	}

	public BigDecimal getInsuredamount() {
		return insuredamount;
	}

	public void setInsuredamount(BigDecimal insuredamount) {
		this.insuredamount = insuredamount;
	}

	public BigDecimal getInsurancefee() {
		return insurancefee;
	}

	public void setInsurancefee(BigDecimal insurancefee) {
		this.insurancefee = insurancefee;
	}

	public BigDecimal getDeliveryfee() {
		return deliveryfee;
	}

	public void setDeliveryfee(BigDecimal deliveryfee) {
		this.deliveryfee = deliveryfee;
	}

	public BigDecimal getInsurance() {
		return insurance;
	}

	public void setInsurance(BigDecimal insurance) {
		this.insurance = insurance;
	}

	public BigDecimal getServicefee() {
		return servicefee;
	}

	public void setServicefee(BigDecimal servicefee) {
		this.servicefee = servicefee;
	}

	public BigDecimal getOtherfee() {
		return otherfee;
	}

	public void setOtherfee(BigDecimal otherfee) {
		this.otherfee = otherfee;
	}

	public BigDecimal getPackprice() {
		return packprice;
	}

	public void setPackprice(BigDecimal packprice) {
		this.packprice = packprice;
	}

	public String getSynccode() {
		return synccode;
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

	public long getOrgid() {
		return orgid;
	}

	public String getDatafrom() {
		return datafrom;
	}

	public void setDatafrom(String datafrom) {
		this.datafrom = datafrom;
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

	public Date getAudittime() {
		return audittime;
	}

	public void setAudittime(Date audittime) {
		this.audittime = audittime;
	}

	public boolean isIsaudit() {
		return isaudit;
	}

	public void setIsaudit(boolean isaudit) {
		this.isaudit = isaudit;
	}

	public String getPaymethod() {
		return paymethod;
	}

	public void setPaymethod(String paymethod) {
		this.paymethod = paymethod;
	}

	
	
	

}
