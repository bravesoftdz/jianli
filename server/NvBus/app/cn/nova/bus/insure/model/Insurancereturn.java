package cn.nova.bus.insure.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;


/**
 * The persistent class for the INSURANCERETURN database table.
 * 
 */
@Entity
@Table(name="INSURANCERETURN")
public class Insurancereturn implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false, precision=10)
	private long insuranceid;

	@Column(nullable=false, precision=10)
	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date createtime;

	@Column(nullable=false, precision=10, scale=2)
	private BigDecimal premium;

	@Column(length=100)
	private String remarks;

	@Column(nullable=false, precision=10)
	private Long returnby;

	@Column(nullable=false, length=40)
	private String returnip;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date returntime;

	@Column(nullable=false, length=10)
	private String returnway;

	@Column(nullable=false, precision=10)
	private long ticketoutletsid;

	@Column(nullable=false, precision=10)
	private long turnoverdetailid;
	
	@Column(nullable=false, precision=10)
	private Long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date updatetime;    
    private String  returnfeemode;
    private String  returnmethod;
    private String  paymethod;
    public Insurancereturn() {
    }

	public long getInsuranceid() {
		return this.insuranceid;
	}

	public void setInsuranceid(long insuranceid) {
		this.insuranceid = insuranceid;
	}

	public long getCreateby() {
		return this.createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public BigDecimal getPremium() {
		return this.premium;
	}

	public void setPremium(BigDecimal premium) {
		this.premium = premium;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Long getReturnby() {
		return this.returnby;
	}

	public void setReturnby(Long returnby) {
		this.returnby = returnby;
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

	public String getReturnway() {
		return this.returnway;
	}

	public void setReturnway(String returnway) {
		this.returnway = returnway;
	}

	public long getTicketoutletsid() {
		return this.ticketoutletsid;
	}

	public void setTicketoutletsid(long ticketoutletsid) {
		this.ticketoutletsid = ticketoutletsid;
	}

	public Long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public void setTurnoverdetailid(long turnoverdetailid) {
		this.turnoverdetailid = turnoverdetailid;
	}

	public long getTurnoverdetailid() {
		return turnoverdetailid;
	}

	public String getReturnfeemode() {
		return returnfeemode;
	}

	public void setReturnfeemode(String returnfeemode) {
		this.returnfeemode = returnfeemode;
	}

	public String getReturnmethod() {
		return returnmethod;
	}

	public void setReturnmethod(String returnmethod) {
		this.returnmethod = returnmethod;
	}

	public String getPaymethod() {
		return paymethod;
	}

	public void setPaymethod(String paymethod) {
		this.paymethod = paymethod;
	}

}