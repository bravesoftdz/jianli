package cn.nova.bus.sale.model;

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
import javax.persistence.Transient;

import cn.nova.bus.bill.model.Billtype;


/**
 * The persistent class for the TICKETRETURN database table.
 * 
 */
@Entity
@Table(name="TICKETRETURN")
public class Ticketreturn implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Transient
	private String opertype;
	@Transient
	private boolean isreturnticket;
	@Transient
	private boolean isreturninsure;
	@Transient
	private Long returninsureid;

	@Id
	@SequenceGenerator(name="TICKETRETURN_ID_GENERATOR", sequenceName="SEQ_TICKETSELL",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="TICKETRETURN_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;

//	@Column(precision=10)
//	private BigDecimal billtypeid;
	@JoinColumn(name = "BILLTYPEID", nullable = true)
	@ManyToOne
	private Billtype billtype;

	@Column(nullable=false, precision=10, scale=2)
	private BigDecimal charges;

	@Column(nullable=false, precision=10)
	private Long createby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date createtime;

	@Column(nullable=false, precision=1)
	private Boolean isselfschedule;

	@Column(length=100)
	private String remarks;

	@Column(nullable=false, precision=10, scale=2)
	private BigDecimal returnamount;

	@Column(nullable=false, precision=10)
	private Long returnby;

	@Column(nullable=false, length=16)
	private String returnip;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date returntime;

	@Column(nullable=true, length=30)
	private String batchno;

	@Column(length=20)
	private String returnvoucherno;

	@Column(nullable=false, length=10)
	private String returnway;

	@Column(nullable=false, precision=10)
	private Long sellid;

	@Column(nullable=false, precision=10)
	private Long ticketoutletsid;

	@Column(nullable=false, precision=10, scale=2)
	private BigDecimal ticketprice;

	@Column(nullable=true, precision=10)
	private Long turnoverdetailid;
	
	@Column(nullable=false, precision=10)
	private Long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date updatetime;

    private String returnfeemode;

	private BigDecimal returnamountweb; // 网退旅客金额

    private BigDecimal chargesweb;		//网退手续费

    private Long returnmethod;			//退票途径 0车站,1 非车站
    
    private BigDecimal rate;//退票手续费率
    
    private String  paymethod;

    public String getReturnfeemode() {
		return returnfeemode;
	}

	public void setReturnfeemode(String returnfeemode) {
		this.returnfeemode = returnfeemode;
	}
    
	public BigDecimal getReturnamountweb() {
		return returnamountweb;
	}

	public void setReturnamountweb(BigDecimal returnamountweb) {
		this.returnamountweb = returnamountweb;
	}

	public BigDecimal getChargesweb() {
		return chargesweb;
	}

	public void setChargesweb(BigDecimal chargesweb) {
		this.chargesweb = chargesweb;
	}

	public Long getReturnmethod() {
		return returnmethod;
	}

	public void setReturnmethod(Long returnmethod) {
		this.returnmethod = returnmethod;
	}

	public Ticketreturn() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Billtype getBilltype() {
		return billtype;
	}

	public void setBilltype(Billtype billtype) {
		this.billtype = billtype;
	}

	public BigDecimal getCharges() {
		return this.charges;
	}

	public void setCharges(BigDecimal charges) {
		this.charges = charges;
	}


	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public BigDecimal getReturnamount() {
		return this.returnamount;
	}

	public void setReturnamount(BigDecimal returnamount) {
		this.returnamount = returnamount;
	}

	public String getReturnip() {
		return this.returnip;
	}

	public void setReturnip(String returnip) {
		this.returnip = returnip;
	}

	public Date getReturntime() {
		return this.returntime;
	}

	public void setReturntime(Date returntime) {
		this.returntime = returntime;
	}

	public String getReturnvoucherno() {
		return this.returnvoucherno;
	}

	public void setReturnvoucherno(String returnvoucherno) {
		this.returnvoucherno = returnvoucherno;
	}

	public String getReturnway() {
		return this.returnway;
	}

	public void setReturnway(String returnway) {
		this.returnway = returnway;
	}

	public BigDecimal getTicketprice() {
		return this.ticketprice;
	}

	public void setTicketprice(BigDecimal ticketprice) {
		this.ticketprice = ticketprice;
	}

	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public void setTurnoverdetailid(Long turnoverdetailid) {
		this.turnoverdetailid = turnoverdetailid;
	}

	public Long getTurnoverdetailid() {
		return turnoverdetailid;
	}

	public Long getCreateby() {
		return createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

	public Boolean getIsselfschedule() {
		return isselfschedule;
	}

	public void setIsselfschedule(Boolean isselfschedule) {
		this.isselfschedule = isselfschedule;
	}

	public Long getReturnby() {
		return returnby;
	}

	public void setReturnby(Long returnby) {
		this.returnby = returnby;
	}

	public Long getSellid() {
		return sellid;
	}

	public void setSellid(Long sellid) {
		this.sellid = sellid;
	}

	public Long getTicketoutletsid() {
		return ticketoutletsid;
	}

	public void setTicketoutletsid(Long ticketoutletsid) {
		this.ticketoutletsid = ticketoutletsid;
	}

	public Long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

	public void setOpertype(String opertype) {
		this.opertype = opertype;
	}

	public String getOpertype() {
		return opertype;
	}

	public void setIsreturninsure(boolean isreturninsure) {
		this.isreturninsure = isreturninsure;
	}

	public boolean getIsreturninsure() {
		return isreturninsure;
	}

	public void setReturninsureid(Long returninsureid) {
		this.returninsureid = returninsureid;
	}

	public Long getReturninsureid() {
		return returninsureid;
	}

	public void setIsreturnticket(boolean isreturnticket) {
		this.isreturnticket = isreturnticket;
	}

	public boolean getIsreturnticket() {
		return isreturnticket;
	}

	public void setBatchno(String batchno) {
		this.batchno = batchno;
	}

	public String getBatchno() {
		return batchno;
	}

	public BigDecimal getRate() {
		return rate;
	}

	public void setRate(BigDecimal rate) {
		this.rate = rate;
	}

	public String getPaymethod() {
		return paymethod;
	}

	public void setPaymethod(String paymethod) {
		this.paymethod = paymethod;
	}
	
	
}