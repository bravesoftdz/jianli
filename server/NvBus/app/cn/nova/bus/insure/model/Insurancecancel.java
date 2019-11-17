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


/**
 * The persistent class for the INSURANCECANCEL database table.
 * 
 */
@Entity
@Table(name="INSURANCECANCEL")
public class Insurancecancel implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true, nullable=false, precision=10)
	private long insuranceid;

	@Column(nullable=false, precision=10)
	private long cancelby;

	@Column(nullable=false, length=40)
	private String cancelip;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date canceltime;

	@Column(nullable=false, precision=10, scale=2)
	private BigDecimal premium;

	@Column(nullable=false, precision=10)
	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date createtime;

	@Column(length=100)
	private String remarks;

	@Column(nullable=false, length=10)
	private String cancelway;

	@Column(nullable=false, precision=10)
	private long ticketoutletsid;

	@Column(nullable=false, precision=10)
	private long turnoverdetailid;
	
	@Column(nullable=false, precision=10)
	private Long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date updatetime;

	@Column(nullable=false, precision=10)
	private long sellby;

    public Insurancecancel() {
    }

	public long getInsuranceid() {
		return this.insuranceid;
	}

	public void setInsuranceid(long insuranceid) {
		this.insuranceid = insuranceid;
	}

	public long getCancelby() {
		return this.cancelby;
	}

	public void setCancelby(long cancelby) {
		this.cancelby = cancelby;
	}

	public String getCancelip() {
		return this.cancelip;
	}

	public void setCancelip(String cancelip) {
		this.cancelip = cancelip;
	}

	public Date getCanceltime() {
		return this.canceltime;
	}

	public void setCanceltime(Date canceltime) {
		this.canceltime = canceltime;
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

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
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

	public void setCancelway(String cancelway) {
		this.cancelway = cancelway;
	}

	public String getCancelway() {
		return cancelway;
	}

	public void setPremium(BigDecimal premium) {
		this.premium = premium;
	}

	public BigDecimal getPremium() {
		return premium;
	}

	public void setSellby(long sellby) {
		this.sellby = sellby;
	}

	public long getSellby() {
		return sellby;
	}

}