package cn.nova.bus.insure.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.bus.sale.model.Ticketturnover;


/**
 * The persistent class for the INSURANCETURNOVERDETAIL database table.
 * 
 */
@Entity
@Table(name="INSURANCETURNOVERDETAIL")
public class Insuranceturnoverdetail implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="INSURANCETURNOVERDETAIL_ID_GENERATOR", sequenceName="SEQ_TICKETSELL",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="INSURANCETURNOVERDETAIL_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;

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

	@Column(nullable=false, length=20)
	private String ticketendno;

	@Column(nullable=false, length=20)
	private String ticketstartno;

	@ManyToOne
	@JoinColumn(name = "TICKETTURNOVERID", nullable = true)
	private Ticketturnover ticketturnover;

    @Temporal( TemporalType.TIMESTAMP)
	private Date turnovertime;

	@Column(nullable=false, precision=10)
	private Long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date updatetime;
    
	@Column( precision=15)
	private BigDecimal ereturncharge;
	
	@Column( precision=15)
	private BigDecimal ereturnmoney;
	
	@Column( precision=9)
	private Integer ereturnnum;
    
	private BigDecimal noncashmoneypayable;
	
	private int  ereturnbacknum;
	
	private BigDecimal ereturnbackmoney;
	
	private BigDecimal money;
	
	private BigDecimal lost;
	
    public Insuranceturnoverdetail() {
    	ereturncharge=new BigDecimal(0);
    	ereturnmoney=new BigDecimal(0);
    	noncashmoneypayable=new BigDecimal(0);
    	ereturnbackmoney=new BigDecimal(0);
    	money=new BigDecimal(0);
    	lost=new BigDecimal(0);
    	ereturnnum=0;
    	ereturnbacknum=0;
    }

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
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

	public BigDecimal getEreturncharge() {
		return ereturncharge;
	}

	public void setEreturncharge(BigDecimal ereturncharge) {
		this.ereturncharge = ereturncharge;
	}

	public BigDecimal getEreturnmoney() {
		return ereturnmoney;
	}

	public void setEreturnmoney(BigDecimal ereturnmoney) {
		this.ereturnmoney = ereturnmoney;
	}

	public Integer getEreturnnum() {
		return ereturnnum;
	}

	public void setEreturnnum(Integer ereturnnum) {
		this.ereturnnum = ereturnnum;
	}
	
	public BigDecimal getNoncashmoneypayable() {
		return noncashmoneypayable;
	}

	public void setNoncashmoneypayable(BigDecimal noncashmoneypayable) {
		this.noncashmoneypayable = noncashmoneypayable;
	}

	public int getEreturnbacknum() {
		return ereturnbacknum;
	}

	public void setEreturnbacknum(int ereturnbacknum) {
		this.ereturnbacknum = ereturnbacknum;
	}

	public BigDecimal getEreturnbackmoney() {
		return ereturnbackmoney;
	}

	public void setEreturnbackmoney(BigDecimal ereturnbackmoney) {
		this.ereturnbackmoney = ereturnbackmoney;
	}

	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	public BigDecimal getLost() {
		return lost;
	}

	public void setLost(BigDecimal lost) {
		this.lost = lost;
	}
	
}