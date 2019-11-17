package cn.nova.bus.insure.model;

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

@Entity
@Table(name = "INSURANCE")
public class Insurance implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "INSURANCE_ID_GENERATOR", sequenceName = "SEQ_INSURE", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "INSURANCE_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;

	@Column(nullable = false, precision = 10)
	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date createtime;

	@Column(nullable = false, precision = 10)
	private long customerid;

	@Column(nullable = false, length = 30)
	private String batchno;

	@Column(nullable = false, length = 30)
	private String insuranceno;

	@Column(nullable = false, length = 10)
	private String insurancestatus;

	@Column(precision = 10, scale = 2, nullable = false)
	private BigDecimal insureamount;

	@Column(precision = 10, nullable = false)
	private long insurersid;

	@Column(precision = 10, nullable = false)
	private long insuretypeid;

	@Column(nullable = false, precision = 1)
	private boolean isselfschedule;

	@Column(nullable = false, precision = 10)
	private long orgid;

	@Column(nullable = false, length = 10)
	private String paymethod;

	@Column(precision = 10, scale = 2, nullable = false)
	private BigDecimal premium;

	@Column(nullable = false, precision = 10)
	private long sellby;

	@Column(nullable = false, precision = 10)
	private long sellid;

	@Column(nullable = false, length = 40)
	private String sellip;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date selltime;

	@Column(nullable = false, length = 10)
	private String sellway;

	@Column(nullable = false, precision = 10)
	private long ticketoutletsid;

	@Column(nullable = false, precision = 10)
	private long turnoverdetailid;

	@Column(nullable = false, precision = 10)
	private Long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date updatetime;

	@Column(nullable = true, length = 30)
	private String polnumber;

	private String bkserial;

	private String validatecode;

	private String platforminsuranceno;
	
	private String orderno;

	public Insurance() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
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

	public long getCustomerid() {
		return this.customerid;
	}

	public void setCustomerid(long customerid) {
		this.customerid = customerid;
	}

	public String getInsuranceno() {
		return this.insuranceno;
	}

	public void setInsuranceno(String insuranceno) {
		this.insuranceno = insuranceno;
	}

	public String getInsurancestatus() {
		return this.insurancestatus;
	}

	public void setInsurancestatus(String insurancestatus) {
		this.insurancestatus = insurancestatus;
	}

	public BigDecimal getInsureamount() {
		return this.insureamount;
	}

	public void setInsureamount(BigDecimal insureamount) {
		this.insureamount = insureamount;
	}

	public long getInsurersid() {
		return this.insurersid;
	}

	public void setInsurersid(long insurersid) {
		this.insurersid = insurersid;
	}

	public long getInsuretypeid() {
		return this.insuretypeid;
	}

	public void setInsuretypeid(long insuretypeid) {
		this.insuretypeid = insuretypeid;
	}

	public boolean getIsselfschedule() {
		return this.isselfschedule;
	}

	public void setIsselfschedule(boolean isselfschedule) {
		this.isselfschedule = isselfschedule;
	}

	public long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public String getPaymethod() {
		return this.paymethod;
	}

	public void setPaymethod(String paymethod) {
		this.paymethod = paymethod;
	}

	public BigDecimal getPremium() {
		return this.premium;
	}

	public void setPremium(BigDecimal premium) {
		this.premium = premium;
	}

	public long getSellby() {
		return this.sellby;
	}

	public void setSellby(long sellby) {
		this.sellby = sellby;
	}

	public long getSellid() {
		return this.sellid;
	}

	public void setSellid(long sellid) {
		this.sellid = sellid;
	}

	public String getSellip() {
		return this.sellip;
	}

	public void setSellip(String sellip) {
		this.sellip = sellip;
	}

	public Date getSelltime() {
		return this.selltime;
	}

	public void setSelltime(Date selltime) {
		this.selltime = selltime;
	}

	public String getSellway() {
		return this.sellway;
	}

	public void setSellway(String sellway) {
		this.sellway = sellway;
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

	public void setBatchno(String batchno) {
		this.batchno = batchno;
	}

	public String getBatchno() {
		return batchno;
	}

	public String getPolnumber() {
		return polnumber;
	}

	public void setPolnumber(String polnumber) {
		this.polnumber = polnumber;
	}

	public String getBkserial() {
		return bkserial;
	}

	public void setBkserial(String bkserial) {
		this.bkserial = bkserial;
	}

	public String getValidatecode() {
		return validatecode;
	}

	public void setValidatecode(String validatecode) {
		this.validatecode = validatecode;
	}

	public String getPlatforminsuranceno() {
		return platforminsuranceno;
	}

	public void setPlatforminsuranceno(String platforminsuranceno) {
		this.platforminsuranceno = platforminsuranceno;
	}
	
	public String getOrderno() {
		return orderno;
	}
	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}	
}
