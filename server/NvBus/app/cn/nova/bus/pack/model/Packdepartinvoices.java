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


@Entity
@Table(name = "PACKDEPARTINVOICES")
public class Packdepartinvoices implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "PACKDEPARTINVOICES_ID_GENERATOR", sequenceName = "SEQ_DEPARTINVOICES", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "PACKDEPARTINVOICES_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;
	private boolean isaudit;
	private Long sellby;
	private Date audittime;

	private String departinvoicesno;
	
	private long scheduleplanid;
	
	@Temporal(TemporalType.DATE)
	private Date departdate;
	
	private long scheduleid;
	
	private String departtime;
	
	private long vehicleid;
	
	private long reportid;
	
	private long printorgid;

	private String printip;
	
	private long printby;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date printtime;
	
	private short pieces;

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal shipprice;// number(6,2) y 托运费

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal packfee;// number(6,2) y 包装费

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal handfee;// number(6,2) y 发货装卸费
	  
	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal custodial;// number(6,2) y 保管费

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal transitfee;// number(6,2) y 中转费

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal insuredamount;// number(6,2) y 保价金额

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal insurancefee;// number(6,2) y 保价费

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal deliveryfee;// 送货费

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal servicefee;// number(6,2) y 服务费
	
	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal packprice;// number(6,2) y 代收货款

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal otherfee;// number(6,2) y 其他费用

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal totalfee;// number(6,2) y 合计金额
	
	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal balanceamount;// number(6,2) y 结算金额

	private long cancelstationid;
	
	private long cancelby;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date canceltime;
	
	
	private String status;
	
	private long packbalanceid;

	private String printway;
	
	private String datatype;	

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;// date n sys;//date

	@Column(nullable=false)
	
	private long createby;// number(10) n

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;// date n sys;//date

	@Column(nullable=false)
	
	private long updateby;// number(10) n
	
	
	public Packdepartinvoices() {
		// TODO Auto-generated constructor stub
	}


	public long getId() {
		return id;
	}


	public void setId(long id) {
		this.id = id;
	}


	public String getDepartinvoicesno() {
		return departinvoicesno;
	}


	public void setDepartinvoicesno(String departinvoicesno) {
		this.departinvoicesno = departinvoicesno;
	}


	public long getScheduleplanid() {
		return scheduleplanid;
	}


	public void setScheduleplanid(long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}


	public Date getDepartdate() {
		return departdate;
	}


	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}


	public long getScheduleid() {
		return scheduleid;
	}


	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}


	public String getDeparttime() {
		return departtime;
	}


	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}


	public long getVehicleid() {
		return vehicleid;
	}


	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}


	public long getReportid() {
		return reportid;
	}


	public void setReportid(long reportid) {
		this.reportid = reportid;
	}


	public long getPrintorgid() {
		return printorgid;
	}


	public void setPrintorgid(long printorgid) {
		this.printorgid = printorgid;
	}


	public String getPrintip() {
		return printip;
	}


	public void setPrintip(String printip) {
		this.printip = printip;
	}


	public long getPrintby() {
		return printby;
	}


	public void setPrintby(long printby) {
		this.printby = printby;
	}


	public Date getPrinttime() {
		return printtime;
	}


	public void setPrinttime(Date printtime) {
		this.printtime = printtime;
	}


	public short getPieces() {
		return pieces;
	}


	public void setPieces(short pieces) {
		this.pieces = pieces;
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


	public BigDecimal getTotalfee() {
		return totalfee;
	}

	public BigDecimal getPackprice() {
		return packprice;
	}


	public void setPackprice(BigDecimal packprice) {
		this.packprice = packprice;
	}


	public void setTotalfee(BigDecimal totalfee) {
		this.totalfee = totalfee;
	}


	public BigDecimal getBalanceamount() {
		return balanceamount;
	}


	public void setBalanceamount(BigDecimal balanceamount) {
		this.balanceamount = balanceamount;
	}


	public long getCancelstationid() {
		return cancelstationid;
	}


	public void setCancelstationid(long cancelstationid) {
		this.cancelstationid = cancelstationid;
	}


	public long getCancelby() {
		return cancelby;
	}


	public void setCancelby(long cancelby) {
		this.cancelby = cancelby;
	}


	public Date getCanceltime() {
		return canceltime;
	}


	public void setCanceltime(Date canceltime) {
		this.canceltime = canceltime;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public long getPackbalanceid() {
		return packbalanceid;
	}


	public void setPackbalanceid(long packbalanceid) {
		this.packbalanceid = packbalanceid;
	}


	public String getPrintway() {
		return printway;
	}


	public void setPrintway(String printway) {
		this.printway = printway;
	}


	public String getDatatype() {
		return datatype;
	}


	public void setDatatype(String datatype) {
		this.datatype = datatype;
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


	public boolean isIsaudit() {
		return isaudit;
	}


	public void setIsaudit(boolean isaudit) {
		this.isaudit = isaudit;
	}


	

	public Long getSellby() {
		return sellby;
	}


	public void setSellby(Long sellby) {
		this.sellby = sellby;
	}


	public Date getAudittime() {
		return audittime;
	}


	public void setAudittime(Date audittime) {
		this.audittime = audittime;
	}

	
}
