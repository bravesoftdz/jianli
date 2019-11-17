package cn.nova.bus.sale.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.utils.orm.listener.SyncCodeGenerate;


/**
 * The persistent class for the TICKETTURNOVERDETAIL database table.
 * 
 */
@Entity
@Table(name="TICKETTURNOVERDETAIL")
@EntityListeners({SyncCodeGenerate.class})
public class Ticketturnoverdetail implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="TICKETTURNOVERDETAIL_ID_GENERATOR", sequenceName="SEQ_TICKETSELL",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="TICKETTURNOVERDETAIL_ID_GENERATOR")
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

	@Column(nullable=false, precision=1)
	private boolean isturnover;

    @Temporal( TemporalType.DATE)
	@Column(nullable=false)
	private Date moneydate;

	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal moneypayable;

	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal noncashmoney;

	@Column(nullable=false, precision=9)
	private int noncashnum;

	@Column(nullable=false, precision=15, scale=2)
	private BigDecimal nonvouchermoneypayable;

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

	@Column(nullable=false, length=20)
	private String ticketendno;

	@Column(nullable=false, length=20)
	private String ticketstartno;

	@ManyToOne(cascade = { CascadeType.REFRESH, CascadeType.PERSIST })
	@JoinColumn(name = "TICKETTURNOVERID", nullable = true)
	private Ticketturnover ticketturnover;

    @Temporal( TemporalType.TIMESTAMP)
	private Date turnovertime;

	@Column(nullable=false, precision=10)
	private Long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date updatetime;

	@Column(nullable=false, precision=10)
	private long billinuseid;
    
	@Column(nullable=false, length=30)
	private String batchno;
    
	@Column(nullable=false, precision=9)
    private int sellreturntripnum;

	@Column(nullable=false, precision=9)
    private int returnprintnum;
	
	@Column(nullable=false, precision=9)
    private int billdamagednum;
    
	@Column(nullable=false, precision=9)
	private int changenum;

	@Column( precision=15)
	private BigDecimal eticketreturncharge;
	
	@Column( precision=15)
	private BigDecimal eticketreturnmoney;
	
	@Column( precision=9)
	private Integer eticketreturnnum;
	
	@Column( precision=10, scale=2)
	private BigDecimal eservicefee;
	
	@Column( precision=10, scale=2)
	private BigDecimal ebookservicefee;
	
	@Column( precision=10, scale=2)
	private BigDecimal echangeservicefee;
	
	public int getChangenum() {
		return changenum;
	}

	public void setChangenum(int changenum) {
		this.changenum = changenum;
	}

	private BigDecimal stationservicefee;

	private BigDecimal fueladditionfee;

	private BigDecimal computefee;

	private BigDecimal coolairfee;

	private BigDecimal additionfee;	

	private BigDecimal waterfee;

	private BigDecimal insurefee;

	private BigDecimal otherfee;
	
	private String synccode;
	
	/**
	 * 售票、改签、补票等打印物理票张数：包含车票数、改签凭证数、补票凭证数
	 */
	private int ticketprintnum;
	
	/**
	 * 改签凭证打印张数
	 */
	private int changeprintnum;
	
	/**
	 * 补票凭证打印张数
	 */
	private int supplementprintnum;
	
	private BigDecimal noncashmoneypayable;//非现金应缴款
	
	private int eticketreturnbacknum; //电子票原路返还的退票总张数
	
	private BigDecimal eticketreturnbackmoney;//电子票原路返还的退票总金额
	
	private BigDecimal eticketreturnbackcharge;//电子票原路返还的总退票手续费
	
	private int returnnumweb;//退网售车票原路返还的退票总张数
	
	private BigDecimal chargesweb;//网售车票原路返还的退票手续费
	
	private BigDecimal returnamountweb;//网售车票原路返还的退票金额
	
	private BigDecimal lost;//网售车票原路返还的退票金额
	
	private BigDecimal money;//网售车票原路返还的退票金额
	
    public Ticketturnoverdetail() {
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

	public boolean isIsturnover() {
		return isturnover;
	}

	public void setIsturnover(boolean isturnover) {
		this.isturnover = isturnover;
	}

	public Date getMoneydate() {
		return moneydate;
	}

	public void setMoneydate(Date moneydate) {
		this.moneydate = moneydate;
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

	public String getTicketendno() {
		return ticketendno;
	}

	public void setTicketendno(String ticketendno) {
		this.ticketendno = ticketendno;
	}

	public String getTicketstartno() {
		return ticketstartno;
	}

	public void setTicketstartno(String ticketstartno) {
		this.ticketstartno = ticketstartno;
	}

	public Ticketturnover getTicketturnover() {
		return ticketturnover;
	}

	public void setTicketturnover(Ticketturnover ticketturnover) {
		this.ticketturnover = ticketturnover;
	}

	public Date getTurnovertime() {
		return turnovertime;
	}

	public void setTurnovertime(Date turnovertime) {
		this.turnovertime = turnovertime;
	}

	public Long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public void setChangeservicefee(BigDecimal changeservicefee) {
		this.changeservicefee = changeservicefee;
	}

	public BigDecimal getChangeservicefee() {
		return changeservicefee;
	}

	public long getBillinuseid() {
		return billinuseid;
	}

	public void setBillinuseid(long billinuseid) {
		this.billinuseid = billinuseid;
	}

	public String getBatchno() {
		return batchno;
	}

	public void setBatchno(String batchno) {
		this.batchno = batchno;
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

	public String getSynccode() {
		return synccode;
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

	public BigDecimal getEticketreturncharge() {
		return eticketreturncharge;
	}

	public void setEticketreturncharge(BigDecimal eticketreturncharge) {
		this.eticketreturncharge = eticketreturncharge;
	}

	public BigDecimal getEticketreturnmoney() {
		return eticketreturnmoney;
	}

	public void setEticketreturnmoney(BigDecimal eticketreturnmoney) {
		this.eticketreturnmoney = eticketreturnmoney;
	}

	public Integer getEticketreturnnum() {
		return eticketreturnnum;
	}

	public void setEticketreturnnum(Integer eticketreturnnum) {
		this.eticketreturnnum = eticketreturnnum;
	}

	public BigDecimal getEservicefee() {
		return eservicefee;
	}

	public void setEservicefee(BigDecimal eservicefee) {
		this.eservicefee = eservicefee;
	}

	public BigDecimal getEbookservicefee() {
		return ebookservicefee;
	}

	public void setEbookservicefee(BigDecimal ebookservicefee) {
		this.ebookservicefee = ebookservicefee;
	}

	public BigDecimal getEchangeservicefee() {
		return echangeservicefee;
	}

	public void setEchangeservicefee(BigDecimal echangeservicefee) {
		this.echangeservicefee = echangeservicefee;
	}

	public BigDecimal getChargesweb() {
		return chargesweb;
	}

	public void setChargesweb(BigDecimal chargesweb) {
		this.chargesweb = chargesweb;
	}

	public BigDecimal getReturnamountweb() {
		return returnamountweb;
	}

	public void setReturnamountweb(BigDecimal returnamountweb) {
		this.returnamountweb = returnamountweb;
	}

	public int getTicketprintnum() {
		return ticketprintnum;
	}

	public void setTicketprintnum(int ticketprintnum) {
		this.ticketprintnum = ticketprintnum;
	}

	public int getChangeprintnum() {
		return changeprintnum;
	}

	public void setChangeprintnum(int changeprintnum) {
		this.changeprintnum = changeprintnum;
	}

	public int getSupplementprintnum() {
		return supplementprintnum;
	}

	public void setSupplementprintnum(int supplementprintnum) {
		this.supplementprintnum = supplementprintnum;
	}

	public BigDecimal getNoncashmoneypayable() {
		return noncashmoneypayable;
	}

	public void setNoncashmoneypayable(BigDecimal noncashmoneypayable) {
		this.noncashmoneypayable = noncashmoneypayable;
	}

	public int getEticketreturnbacknum() {
		return eticketreturnbacknum;
	}

	public void setEticketreturnbacknum(int eticketreturnbacknum) {
		this.eticketreturnbacknum = eticketreturnbacknum;
	}

	public BigDecimal getEticketreturnbackmoney() {
		return eticketreturnbackmoney;
	}

	public void setEticketreturnbackmoney(BigDecimal eticketreturnbackmoney) {
		this.eticketreturnbackmoney = eticketreturnbackmoney;
	}

	public BigDecimal getEticketreturnbackcharge() {
		return eticketreturnbackcharge;
	}

	public void setEticketreturnbackcharge(BigDecimal eticketreturnbackcharge) {
		this.eticketreturnbackcharge = eticketreturnbackcharge;
	}

	public int getReturnnumweb() {
		return returnnumweb;
	}

	public void setReturnnumweb(int returnnumweb) {
		this.returnnumweb = returnnumweb;
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
	
}