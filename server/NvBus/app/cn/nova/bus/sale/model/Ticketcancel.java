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
import javax.persistence.Transient;


/**
 * The persistent class for the TICKETCANCEL database table.
 * 
 */
@Entity
@Table(name="TICKETCANCEL")
public class Ticketcancel implements Serializable {
	private static final long serialVersionUID = 1L;

	@Transient
	private String opertype;
	@Transient
	private boolean iscancelticket;
	@Transient
	private boolean iscancelinsure;
	@Transient
	private long insurancesellby;
	@Transient
	private Long cancelinsureid;

	@Id
	@SequenceGenerator(name="TICKETCANCEL_ID_GENERATOR", sequenceName="SEQ_TICKETSELL",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="TICKETCANCEL_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;

	@Column(nullable=false, precision=10)
	private long cancelby;

	@Column(nullable=false, length=40)
	private String cancelip;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date canceltime;

	@Column(nullable=false, precision=10)
	private long createby;

    @Temporal( TemporalType.DATE)
	@Column(nullable=false)
	private Date createtime;

	@Column(nullable=false, precision=1)
	private boolean isselfschedule;

	@Column(length=100)
	private String remarks;
	
	@Column(nullable=false, length=10)
	private String cancelway;

	@Column(nullable=false, precision=10)
	private long sellid;

	@Column(nullable=false, precision=10)
	private long ticketoutletsid;

	@Column(nullable=true, precision=10)
	private Long turnoverdetailid;

	@Column(nullable=false, precision=10, scale=2)
	private BigDecimal ticketprice;
	
	@Column(nullable=false, precision=10)
	private long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date updatetime;

	@Column(nullable=false, precision=10)
	private long sellby;

	public Ticketcancel() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
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

	public boolean getIsselfschedule() {
		return this.isselfschedule;
	}

	public void setIsselfschedule(boolean isselfschedule) {
		this.isselfschedule = isselfschedule;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public long getSellid() {
		return this.sellid;
	}

	public void setSellid(long sellid) {
		this.sellid = sellid;
	}

	public long getTicketoutletsid() {
		return this.ticketoutletsid;
	}

	public void setTicketoutletsid(long ticketoutletsid) {
		this.ticketoutletsid = ticketoutletsid;
	}

	public long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
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

	public void setCancelway(String cancelway) {
		this.cancelway = cancelway;
	}

	public String getCancelway() {
		return cancelway;
	}

	public void setCancelinsureid(Long cancelinsureid) {
		this.cancelinsureid = cancelinsureid;
	}

	public Long getCancelinsureid() {
		return cancelinsureid;
	}

	public void setIscancelinsure(boolean iscancelinsure) {
		this.iscancelinsure = iscancelinsure;
	}

	public boolean getIscancelinsure() {
		return iscancelinsure;
	}

	public void setOpertype(String opertype) {
		this.opertype = opertype;
	}

	public String getOpertype() {
		return opertype;
	}

	public void setTicketprice(BigDecimal ticketprice) {
		this.ticketprice = ticketprice;
	}

	public BigDecimal getTicketprice() {
		return ticketprice;
	}

	public void setSellby(long sellby) {
		this.sellby = sellby;
	}

	public long getSellby() {
		return sellby;
	}

	public void setIscancelticket(boolean iscancelticket) {
		this.iscancelticket = iscancelticket;
	}

	public boolean getIscancelticket() {
		return iscancelticket;
	}

	public void setInsurancesellby(long insurancesellby) {
		this.insurancesellby = insurancesellby;
	}

	public long getInsurancesellby() {
		return insurancesellby;
	}

}