package cn.nova.bus.sale.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the TICKETTURNOVER database table.
 * 
 */
@Entity
@Table(name="TICKETTURNOVER")
public class Ticketturnover implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="TICKETTURNOVER_ID_GENERATOR", sequenceName="SEQ_TICKETSELL",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="TICKETTURNOVER_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;

	@Column(nullable=false, precision=10, scale=2)
	private BigDecimal bookservicefee;

	@Column(nullable=false, precision=10, scale=2)
	private BigDecimal changeservicefee;

	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal cancelmoney;

	@Column(nullable=false, precision=9)
	private int cancelnum;

	@Column(nullable=false, precision=10)
	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date createtime;

	@Column(nullable=false, precision=9)
	private int eticketnum;

	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal insurecancelmoney;

	@Column(nullable=false, precision=9)
	private int insurecancelnum;

	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal insurechargemoney;

	@Column(nullable=false, precision=9)
	private int insurechargenum;

	@Column(nullable=false, precision=9)
	private int insureeticketnum;

	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal insurenonvouchermoneypayable;

	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal insurereturnhandcharge;

	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal insurereturnmoney;

	@Column(nullable=false, precision=9)
	private int insurereturnnum;

	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal insuresellmoney;

	@Column(nullable=false, precision=9)
	private int insuresellnum;

	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal lastlost;

	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal lost;

	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal money;

	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal moneypayable;

	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal noncashmoney;

	@Column(nullable=false, precision=9)
	private int noncashnum;

	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal nonvouchermoneypayable;

	@Column(nullable=false, length=50)
	private String receiptip;

	@Column(nullable=false, precision=10)
	private long receiptorgid;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date receipttime;

	@Column(nullable=false, precision=10)
	private long receiver;

	@Column(length=255)
	private String remarks;

	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal returnhandcharge;

	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal returnmoney;

	@Column(nullable=false, precision=9)
	private int returnnum;

	@Column(nullable=false, precision=10)
	private long seller;

	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal sellmoney;

	@Column(nullable=false, precision=9)
	private int sellnum;

	@Column(nullable=false, precision=10, scale=2)
	private BigDecimal servicefee;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date turnovertime;

	@Column(nullable=false, precision=9)
    private int sellreturntripnum;

	@Column(nullable=false, precision=9)
    private int returnprintnum;
	
	@Column(nullable=false, precision=9)
    private int billdamagednum;
    
	
	private BigDecimal stationservicefee;

	private BigDecimal fueladditionfee;

	private BigDecimal computefee;

	private BigDecimal coolairfee;

	private BigDecimal additionfee;	

	private BigDecimal waterfee;

	private BigDecimal insurefee;

	private BigDecimal otherfee;
	
	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal ticketstrike;
	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal insurstrike;	
	
	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal ticketmoney;
	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal insuremoney;	
	
	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal ticketmoneypayable;
	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal insuremoneypayable;	
	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal balance;	
	
    public BigDecimal getStationservicefee() {
		return stationservicefee;
	}

	public void setStationservicefee(BigDecimal stationservicefee) {
		this.stationservicefee = stationservicefee;
	}

	public BigDecimal getFueladditionfee() {
		return fueladditionfee;
	}

	public void setFueladditionfee(BigDecimal fueladditionfee) {
		this.fueladditionfee = fueladditionfee;
	}

	public BigDecimal getComputefee() {
		return computefee;
	}

	public void setComputefee(BigDecimal computefee) {
		this.computefee = computefee;
	}

	public BigDecimal getCoolairfee() {
		return coolairfee;
	}

	public void setCoolairfee(BigDecimal coolairfee) {
		this.coolairfee = coolairfee;
	}

	public BigDecimal getAdditionfee() {
		return additionfee;
	}

	public void setAdditionfee(BigDecimal additionfee) {
		this.additionfee = additionfee;
	}

	public BigDecimal getWaterfee() {
		return waterfee;
	}

	public void setWaterfee(BigDecimal waterfee) {
		this.waterfee = waterfee;
	}

	public BigDecimal getInsurefee() {
		return insurefee;
	}

	public void setInsurefee(BigDecimal insurefee) {
		this.insurefee = insurefee;
	}

	public BigDecimal getOtherfee() {
		return otherfee;
	}

	public void setOtherfee(BigDecimal otherfee) {
		this.otherfee = otherfee;
	}

	public Ticketturnover() {
    }

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public BigDecimal getBookservicefee() {
		return bookservicefee;
	}

	public void setBookservicefee(BigDecimal bookservicefee) {
		this.bookservicefee = bookservicefee;
	}

	public BigDecimal getCancelmoney() {
		return cancelmoney;
	}

	public void setCancelmoney(BigDecimal cancelmoney) {
		this.cancelmoney = cancelmoney;
	}

	public int getCancelnum() {
		return cancelnum;
	}

	public void setCancelnum(int cancelnum) {
		this.cancelnum = cancelnum;
	}

	public long getCreateby() {
		return createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public int getEticketnum() {
		return eticketnum;
	}

	public void setEticketnum(int eticketnum) {
		this.eticketnum = eticketnum;
	}

	public BigDecimal getInsurecancelmoney() {
		return insurecancelmoney;
	}

	public void setInsurecancelmoney(BigDecimal insurecancelmoney) {
		this.insurecancelmoney = insurecancelmoney;
	}

	public int getInsurecancelnum() {
		return insurecancelnum;
	}

	public void setInsurecancelnum(int insurecancelnum) {
		this.insurecancelnum = insurecancelnum;
	}

	public BigDecimal getInsurechargemoney() {
		return insurechargemoney;
	}

	public void setInsurechargemoney(BigDecimal insurechargemoney) {
		this.insurechargemoney = insurechargemoney;
	}

	public int getInsurechargenum() {
		return insurechargenum;
	}

	public void setInsurechargenum(int insurechargenum) {
		this.insurechargenum = insurechargenum;
	}

	public int getInsureeticketnum() {
		return insureeticketnum;
	}

	public void setInsureeticketnum(int insureeticketnum) {
		this.insureeticketnum = insureeticketnum;
	}

	public BigDecimal getInsurenonvouchermoneypayable() {
		return insurenonvouchermoneypayable;
	}

	public void setInsurenonvouchermoneypayable(
			BigDecimal insurenonvouchermoneypayable) {
		this.insurenonvouchermoneypayable = insurenonvouchermoneypayable;
	}

	public BigDecimal getInsurereturnhandcharge() {
		return insurereturnhandcharge;
	}

	public void setInsurereturnhandcharge(BigDecimal insurereturnhandcharge) {
		this.insurereturnhandcharge = insurereturnhandcharge;
	}

	public BigDecimal getInsurereturnmoney() {
		return insurereturnmoney;
	}

	public void setInsurereturnmoney(BigDecimal insurereturnmoney) {
		this.insurereturnmoney = insurereturnmoney;
	}

	public int getInsurereturnnum() {
		return insurereturnnum;
	}

	public void setInsurereturnnum(int insurereturnnum) {
		this.insurereturnnum = insurereturnnum;
	}

	public BigDecimal getInsuresellmoney() {
		return insuresellmoney;
	}

	public void setInsuresellmoney(BigDecimal insuresellmoney) {
		this.insuresellmoney = insuresellmoney;
	}

	public int getInsuresellnum() {
		return insuresellnum;
	}

	public void setInsuresellnum(int insuresellnum) {
		this.insuresellnum = insuresellnum;
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

	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	public BigDecimal getMoneypayable() {
		return moneypayable;
	}

	public void setMoneypayable(BigDecimal moneypayable) {
		this.moneypayable = moneypayable;
	}

	public BigDecimal getNoncashmoney() {
		return noncashmoney;
	}

	public void setNoncashmoney(BigDecimal noncashmoney) {
		this.noncashmoney = noncashmoney;
	}

	public int getNoncashnum() {
		return noncashnum;
	}

	public void setNoncashnum(int noncashnum) {
		this.noncashnum = noncashnum;
	}

	public BigDecimal getNonvouchermoneypayable() {
		return nonvouchermoneypayable;
	}

	public void setNonvouchermoneypayable(BigDecimal nonvouchermoneypayable) {
		this.nonvouchermoneypayable = nonvouchermoneypayable;
	}

	public String getReceiptip() {
		return receiptip;
	}

	public void setReceiptip(String receiptip) {
		this.receiptip = receiptip;
	}

	public long getReceiptorgid() {
		return receiptorgid;
	}

	public void setReceiptorgid(long receiptorgid) {
		this.receiptorgid = receiptorgid;
	}

	public Date getReceipttime() {
		return receipttime;
	}

	public void setReceipttime(Date receipttime) {
		this.receipttime = receipttime;
	}

	public long getReceiver() {
		return receiver;
	}

	public void setReceiver(long receiver) {
		this.receiver = receiver;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
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

	public int getReturnnum() {
		return returnnum;
	}

	public void setReturnnum(int returnnum) {
		this.returnnum = returnnum;
	}

	public long getSeller() {
		return seller;
	}

	public void setSeller(long seller) {
		this.seller = seller;
	}

	public BigDecimal getSellmoney() {
		return sellmoney;
	}

	public void setSellmoney(BigDecimal sellmoney) {
		this.sellmoney = sellmoney;
	}

	public int getSellnum() {
		return sellnum;
	}

	public void setSellnum(int sellnum) {
		this.sellnum = sellnum;
	}

	public BigDecimal getServicefee() {
		return servicefee;
	}

	public void setServicefee(BigDecimal servicefee) {
		this.servicefee = servicefee;
	}

	public Date getTurnovertime() {
		return turnovertime;
	}

	public void setTurnovertime(Date turnovertime) {
		this.turnovertime = turnovertime;
	}

	public void setChangeservicefee(BigDecimal changeservicefee) {
		this.changeservicefee = changeservicefee;
	}

	public BigDecimal getChangeservicefee() {
		return changeservicefee;
	}

	public int getSellreturntripnum() {
		return sellreturntripnum;
	}

	public void setSellreturntripnum(int sellreturntripnum) {
		this.sellreturntripnum = sellreturntripnum;
	}

	public int getReturnprintnum() {
		return returnprintnum;
	}

	public void setReturnprintnum(int returnprintnum) {
		this.returnprintnum = returnprintnum;
	}

	public int getBilldamagednum() {
		return billdamagednum;
	}

	public void setBilldamagednum(int billdamagednum) {
		this.billdamagednum = billdamagednum;
	}

	public BigDecimal getTicketstrike() {
		return ticketstrike;
	}

	public void setTicketstrike(BigDecimal ticketstrike) {
		this.ticketstrike = ticketstrike;
	}

	public BigDecimal getInsurstrike() {
		return insurstrike;
	}

	public void setInsurstrike(BigDecimal insurstrike) {
		this.insurstrike = insurstrike;
	}

	public BigDecimal getTicketmoney() {
		return ticketmoney;
	}

	public void setTicketmoney(BigDecimal ticketmoney) {
		this.ticketmoney = ticketmoney;
	}

	public BigDecimal getInsuremoney() {
		return insuremoney;
	}

	public void setInsuremoney(BigDecimal insuremoney) {
		this.insuremoney = insuremoney;
	}

	public BigDecimal getTicketmoneypayable() {
		return ticketmoneypayable;
	}

	public void setTicketmoneypayable(BigDecimal ticketmoneypayable) {
		this.ticketmoneypayable = ticketmoneypayable;
	}

	public BigDecimal getInsuremoneypayable() {
		return insuremoneypayable;
	}

	public void setInsuremoneypayable(BigDecimal insuremoneypayable) {
		this.insuremoneypayable = insuremoneypayable;
	}

	public BigDecimal getBalance() {
		return balance;
	}

	public void setBalance(BigDecimal balance) {
		this.balance = balance;
	}

	
}