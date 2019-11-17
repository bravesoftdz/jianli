package cn.nova.bus.checkticket.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import cn.nova.bus.balance.model.Balance;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Unit;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.model.Userinfo;

@Entity
@Table(name = "DEPARTINVOICES")
public class Departinvoices implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "DEPARTINVOICES_ID_GENERATOR", sequenceName = "SEQ_DEPARTINVOICES", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "DEPARTINVOICES_ID_GENERATOR")
	@Column(nullable = false, unique = true)
	private long id;

	@Column(nullable = false)
	private BigDecimal agentfee;

	@Column(nullable = false)
	private BigDecimal balanceamount;

	@JoinColumn(name = "BALANCEBY", nullable = true)
	@ManyToOne
	private Userinfo balanceby;

	@Temporal(TemporalType.DATE)
	private Date balancedate;

	@JoinColumn(name = "BALANCEID", nullable = true)
	@ManyToOne
	private Balance balance;

	@JoinColumn(name = "BALANCESTATIONID", nullable = true)
	@ManyToOne
	private Station balancestation;

	@JoinColumn(name = "CANCELBY", nullable = true)
	@ManyToOne
	private Userinfo cancel;

	@JoinColumn(name = "CANCELSTATIONID", nullable = true)
	@ManyToOne
	private Station cancelstation;

	@Temporal(TemporalType.TIMESTAMP)
	private Date canceltime;

	@Column(nullable = false)
	private long createby;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	@Column(nullable = false)
	@Temporal(TemporalType.DATE)
	private Date departdate;

	@Column(nullable = false)
	private String departinvoicesno;

	@Column(nullable = false)
	private long departstationid;

	@Column(nullable = false)
	private String departtime;

	@Column(nullable = false)
	private BigDecimal othterfee;

	@Column(nullable = false)
	private long printby;

	@Column(nullable = false)
	private String printip;

	@Column(nullable = false)
	private long printorgid;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date printtime;

	@Column(nullable = false)
	private long reportid;

	@Column(nullable = false)
	private long scheduleid;

	@Column(nullable = false)
	private long scheduleplanid;

	@Column(nullable = false)
	private BigDecimal fueladditionfee;

	@Column(nullable = false)
	private BigDecimal stationservicefee;

	@Column(nullable = false)
	private String status;

	@Column(nullable = false)
	private BigDecimal supplyamount;

	@Column(nullable = false)
	private BigDecimal supplybalanceamount;

	@Column(nullable = false)
	private long supplyticketnum;

	@Column(nullable = false)
	private long ticketnum;

	@Column(nullable = false)
	private BigDecimal totalamount;

	@Column(nullable = false)
	private long updateby;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	@Column(nullable = false)
	private long vehicleid;

	@OneToMany(cascade = { CascadeType.ALL }, fetch = FetchType.LAZY, mappedBy = "departinvoices")
	private List<Departinvoicesdetail> Departinvoicesdetails;

	@OneToMany(cascade = { CascadeType.ALL }, fetch = FetchType.LAZY, mappedBy = "departinvoices")
	private List<Departinvoicesdeductdetail> Departinvoicesdeductdetails;

	private long balanceunitid;

	@Transient
	private boolean isovertime;

	private String printway;

	private BigDecimal moreprice;

	private boolean isreplace;

	private boolean iscomputeno;
	@Transient
	private int freetickets;
	
	//新增驾驶员ID,乘务员ID
	private Long driver1id;

	private Long driver2id;
	
	private Long steward1id;
	
	private long  packes ;
	
	private Long seller;
	
	//售票点id
	private long ticketoutletsid;
	
	private int nopaperticketnum;//无纸质车票张数(包含未取票的电子票,网售票,窗口售电子票等 但不包含手持机售出的票)
	
	private int paperticketnum;//纸质车票张数(包含取票的电子票,网售票,窗口售等 但不包含手持机售出的票)
	
	private boolean isapproved;//审验
	
	private int eticketnum;//电子票总票数，包含：电子票取票、未取票总张数
	
	private int handticketnum;//手持机总票数，包含：手持机售票的总张数
	
	public long getPackes() {
		return packes;
	}

	public void setPackes(long packes) {
		this.packes = packes;
	}

	public BigDecimal getPackbalanceprice() {
		return packbalanceprice;
	}

	public void setPackbalanceprice(BigDecimal packbalanceprice) {
		this.packbalanceprice = packbalanceprice;
	}

	private BigDecimal packbalanceprice; 
	
	public Long getDriver1id() {
		return driver1id;
	}

	public void setDriver1id(Long driver1id) {
		this.driver1id = driver1id;
	}

	public Long getDriver2id() {
		return driver2id;
	}

	public void setDriver2id(Long driver2id) {
		this.driver2id = driver2id;
	}


	public Long getSteward1id() {
		return steward1id;
	}

	public void setSteward1id(Long steward1id) {
		this.steward1id = steward1id;
	}

	public int getFreetickets() {
		return freetickets;
	}

	public void setFreetickets(int freetickets) {
		this.freetickets = freetickets;
	}

	public BigDecimal getMoreprice() {
		return moreprice;
	}

	public void setMoreprice(BigDecimal moreprice) {
		this.moreprice = moreprice;
	}

	public String getPrintway() {
		return printway;
	}

	public void setPrintway(String printway) {
		this.printway = printway;
	}

	public boolean isIsovertime() {
		return isovertime;
	}

	public void setIsovertime(boolean isovertime) {
		this.isovertime = isovertime;
	}

	public Departinvoices() {
	}

	public BigDecimal getFueladditionfee() {
		return fueladditionfee;
	}

	public void setFueladditionfee(BigDecimal fueladditionfee) {
		this.fueladditionfee = fueladditionfee;
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public BigDecimal getAgentfee() {
		return this.agentfee;
	}

	public void setAgentfee(BigDecimal agentfee) {
		this.agentfee = agentfee;
	}

	public BigDecimal getBalanceamount() {
		return this.balanceamount;
	}

	public void setBalanceamount(BigDecimal balanceamount) {
		this.balanceamount = balanceamount;
	}

	public Date getBalancedate() {
		return this.balancedate;
	}

	public void setBalancedate(Date balancedate) {
		this.balancedate = balancedate;
	}

	public Userinfo getBalanceby() {
		return balanceby;
	}

	public void setBalanceby(Userinfo balanceby) {
		this.balanceby = balanceby;
	}

	public Balance getBalance() {
		return balance;
	}

	public void setBalance(Balance balance) {
		this.balance = balance;
	}

	public Station getBalancestation() {
		return balancestation;
	}

	public void setBalancestation(Station balancestation) {
		this.balancestation = balancestation;
	}

	public Userinfo getCancel() {
		return cancel;
	}

	public void setCancel(Userinfo cancel) {
		this.cancel = cancel;
	}

	public Station getCancelstation() {
		return cancelstation;
	}

	public void setCancelstation(Station cancelstation) {
		this.cancelstation = cancelstation;
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

	public Date getDepartdate() {
		return this.departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public String getDepartinvoicesno() {
		return this.departinvoicesno;
	}

	public void setDepartinvoicesno(String departinvoicesno) {
		this.departinvoicesno = departinvoicesno;
	}

	public long getDepartstationid() {
		return this.departstationid;
	}

	public void setDepartstationid(long departstationid) {
		this.departstationid = departstationid;
	}

	public String getDeparttime() {
		return this.departtime;
	}

	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}

	public BigDecimal getOthterfee() {
		return this.othterfee;
	}

	public void setOthterfee(BigDecimal othterfee) {
		this.othterfee = othterfee;
	}

	public long getPrintby() {
		return this.printby;
	}

	public void setPrintby(long printby) {
		this.printby = printby;
	}

	public String getPrintip() {
		return this.printip;
	}

	public void setPrintip(String printip) {
		this.printip = printip;
	}

	public long getPrintorgid() {
		return this.printorgid;
	}

	public void setPrintorgid(long printorgid) {
		this.printorgid = printorgid;
	}

	public Date getPrinttime() {
		return this.printtime;
	}

	public void setPrinttime(Date printtime) {
		this.printtime = printtime;
	}

	public long getReportid() {
		return this.reportid;
	}

	public void setReportid(long reportid) {
		this.reportid = reportid;
	}

	public long getScheduleid() {
		return this.scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public long getScheduleplanid() {
		return this.scheduleplanid;
	}

	public void setScheduleplanid(long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	public BigDecimal getStationservicefee() {
		return this.stationservicefee;
	}

	public void setStationservicefee(BigDecimal stationservicefee) {
		this.stationservicefee = stationservicefee;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public BigDecimal getSupplyamount() {
		return this.supplyamount;
	}

	public void setSupplyamount(BigDecimal supplyamount) {
		this.supplyamount = supplyamount;
	}

	public BigDecimal getSupplybalanceamount() {
		return this.supplybalanceamount;
	}

	public void setSupplybalanceamount(BigDecimal supplybalanceamount) {
		this.supplybalanceamount = supplybalanceamount;
	}

	public long getSupplyticketnum() {
		return this.supplyticketnum;
	}

	public void setSupplyticketnum(long supplyticketnum) {
		this.supplyticketnum = supplyticketnum;
	}

	public long getTicketnum() {
		return this.ticketnum;
	}

	public void setTicketnum(long ticketnum) {
		this.ticketnum = ticketnum;
	}

	public BigDecimal getTotalamount() {
		return this.totalamount;
	}

	public void setTotalamount(BigDecimal totalamount) {
		this.totalamount = totalamount;
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

	public long getVehicleid() {
		return this.vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public List<Departinvoicesdetail> getDepartinvoicesdetails() {
		return Departinvoicesdetails;
	}

	public void setDepartinvoicesdetails(
			List<Departinvoicesdetail> departinvoicesdetails) {
		Departinvoicesdetails = departinvoicesdetails;
	}

	public List<Departinvoicesdeductdetail> getDepartinvoicesdeductdetails() {
		return Departinvoicesdeductdetails;
	}

	public void setDepartinvoicesdeductdetails(
			List<Departinvoicesdeductdetail> departinvoicesdeductdetails) {
		Departinvoicesdeductdetails = departinvoicesdeductdetails;
	}

	public long getBalanceunitid() {
		return balanceunitid;
	}

	public void setBalanceunitid(long balanceunitid) {
		this.balanceunitid = balanceunitid;
	}

	public boolean isIscomputeno() {
		return iscomputeno;
	}

	public void setIscomputeno(boolean iscomputeno) {
		this.iscomputeno = iscomputeno;
	}

	public boolean isIsreplace() {
		return isreplace;
	}

	public void setIsreplace(boolean isreplace) {
		this.isreplace = isreplace;
	}

	public Long getSeller() {
		return seller;
	}

	public void setSeller(Long seller) {
		this.seller = seller;
	}

	public long getTicketoutletsid() {
		return ticketoutletsid;
	}

	public void setTicketoutletsid(long ticketoutletsid) {
		this.ticketoutletsid = ticketoutletsid;
	}

	public int getNopaperticketnum() {
		return nopaperticketnum;
	}

	public void setNopaperticketnum(int nopaperticketnum) {
		this.nopaperticketnum = nopaperticketnum;
	}

	public int getPaperticketnum() {
		return paperticketnum;
	}

	public void setPaperticketnum(int paperticketnum) {
		this.paperticketnum = paperticketnum;
	}

	public boolean isIsapproved() {
		return isapproved;
	}

	public void setIsapproved(boolean isapproved) {
		this.isapproved = isapproved;
	}

	public int getEticketnum() {
		return eticketnum;
	}

	public void setEticketnum(int eticketnum) {
		this.eticketnum = eticketnum;
	}

	public int getHandticketnum() {
		return handticketnum;
	}

	public void setHandticketnum(int handticketnum) {
		this.handticketnum = handticketnum;
	}
	
}