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

import cn.nova.bus.archive.model.Customer;

/**
 * The persistent class for the TICKETSELLAGENT database table.
 * 
 */
@Entity
@Table(name = "TICKETSELLAGENT")
public class Ticketsellagent implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "TICKETSELLAGENT_ID_GENERATOR", sequenceName = "SEQ_TICKETSELL", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "TICKETSELLAGENT_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;

	@Column(length = 60)
	private String buspark;

	@Column(nullable = false, precision = 10)
	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date createtime;

	@JoinColumn(name = "CUSTOMERID", nullable = true)
	@ManyToOne
	private Customer customer;

	@Temporal(TemporalType.DATE)
	@Column(nullable = false)
	private Date departdate;

	@Column(nullable = false, precision = 10)
	private long departstationid;

	@Column(length = 30)
	private String departstationname;

	@Column(nullable = false, length = 5)
	private String departtime;

	@Column(nullable = false, precision = 4, scale = 3)
	private BigDecimal discountrate;

	@Column(precision = 10)
	private Long distance;

	@Column(precision = 10, scale = 2)
	private BigDecimal fullprice;

	@Column(nullable = false, precision = 10, scale = 2)
	private BigDecimal servicefee;

	@Column(nullable = false, precision = 2)
	private byte carrychildnum;

	@Column(nullable = false, precision = 10, scale = 2)
	private BigDecimal fueladditionfee;

	@Column(nullable = false, precision = 1)
	private boolean islinework;

	@Column(length = 50)
	private String operatemodel;

	@Column(precision = 10)
	private long orgid;
	
	@Column(length = 30)
	private String orgname;

	@Column(nullable = false, length = 10)
	private String paymethod;

	@Column(nullable = false, precision = 10, scale = 2)
	private BigDecimal price;

	@Column(precision = 10)
	private long reachstationid;
	
	@Column(length = 30)
	private String reachstationname;

	@Column(nullable = false, length = 25)
	private String schedulecode;

	@Column(nullable = false, precision = 4)
	private short seatno;

	@Column(nullable = false, precision = 10)
	private long sellby;

	@Column(nullable = false, length = 40)
	private String sellip;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date selltime;

	@Column(nullable = false, length = 10)
	private String sellway;

	@Column(precision = 10, scale = 2)
	private BigDecimal serviceprice;

	@Column(nullable = false, precision = 10, scale = 2)
	private BigDecimal stationservicefee;

	@Column(nullable = false, precision = 10, scale = 2)
	private BigDecimal computefee;

	@Column(nullable = false, precision = 10, scale = 2)
	private BigDecimal coolairfee;

	@Column(nullable = false, precision = 10, scale = 2)
	private BigDecimal additionfee;

	@Column(nullable = false, length = 60)
	private String ticketentrance;

	@Column(nullable = false, length = 30)
	private String batchno;

	@Column(nullable = false, length = 20)
	private String ticketno;

	@Column(nullable = false, precision = 10)
	private long ticketoutletsid;

	@Column(nullable = false, length = 10)
	private String ticketstatus;

	@Column(nullable = false, length = 1)
	private String tickettype;

	@Column(nullable = false, precision = 10)
	private long turnoverdetailid;

	@Column(nullable = false, precision = 10)
	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date updatetime;

	@Column(length = 100)
	private String vehiclebrandmodelname;

	@Column(length = 20)
	private String vehicleno;

	@Column(precision = 10)
	private long vehicletypeid;

	@Column(length = 30)
	private String vehicletypename;

	@Column(length = 40)
	private String eticketid;

	private String seattype;

	private BigDecimal toplimitprice;

	private BigDecimal moreprice;

	private BigDecimal waterfee;

	private BigDecimal insurefee;

	private BigDecimal otherfee;

	@Column(nullable = false, length = 40)
	private String orderno;

	private String customername;
	
	private String certificatetypename;
	
	private String certificateno;
	
	public Ticketsellagent() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getBuspark() {
		return this.buspark;
	}

	public void setBuspark(String buspark) {
		this.buspark = buspark;
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

	public BigDecimal getDiscountrate() {
		return this.discountrate;
	}

	public void setDiscountrate(BigDecimal discountrate) {
		this.discountrate = discountrate;
	}

	public Long getDistance() {
		return this.distance;
	}

	public void setDistance(Long distance) {
		this.distance = distance;
	}

	public BigDecimal getFullprice() {
		return this.fullprice;
	}

	public void setFullprice(BigDecimal fullprice) {
		this.fullprice = fullprice;
	}

	public byte getCarrychildnum() {
		return this.carrychildnum;
	}

	public void setCarrychildnum(byte carrychildnum) {
		this.carrychildnum = carrychildnum;
	}

	public boolean getIslinework() {
		return this.islinework;
	}

	public void setIslinework(boolean islinework) {
		this.islinework = islinework;
	}

	public String getOperatemodel() {
		return this.operatemodel;
	}

	public void setOperatemodel(String operatemodel) {
		this.operatemodel = operatemodel;
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

	public BigDecimal getPrice() {
		return this.price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public long getReachstationid() {
		return this.reachstationid;
	}

	public void setReachstationid(long reachstationid) {
		this.reachstationid = reachstationid;
	}

	public String getSchedulecode() {
		return this.schedulecode;
	}

	public void setSchedulecode(String schedulecode) {
		this.schedulecode = schedulecode;
	}

	public short getSeatno() {
		return this.seatno;
	}

	public void setSeatno(short seatno) {
		this.seatno = seatno;
	}

	public long getSellby() {
		return this.sellby;
	}

	public void setSellby(long sellby) {
		this.sellby = sellby;
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

	public BigDecimal getServiceprice() {
		return this.serviceprice;
	}

	public void setServiceprice(BigDecimal serviceprice) {
		this.serviceprice = serviceprice;
	}

	public BigDecimal getStationservicefee() {
		return this.stationservicefee;
	}

	public void setStationservicefee(BigDecimal stationservicefee) {
		this.stationservicefee = stationservicefee;
	}

	public String getTicketentrance() {
		return this.ticketentrance;
	}

	public void setTicketentrance(String ticketentrance) {
		this.ticketentrance = ticketentrance;
	}

	public String getTicketno() {
		return this.ticketno;
	}

	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
	}

	public long getTicketoutletsid() {
		return this.ticketoutletsid;
	}

	public void setTicketoutletsid(long ticketoutletsid) {
		this.ticketoutletsid = ticketoutletsid;
	}

	public String getTicketstatus() {
		return this.ticketstatus;
	}

	public void setTicketstatus(String ticketstatus) {
		this.ticketstatus = ticketstatus;
	}

	public String getTickettype() {
		return this.tickettype;
	}

	public void setTickettype(String tickettype) {
		this.tickettype = tickettype;
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

	public String getVehiclebrandmodelname() {
		return this.vehiclebrandmodelname;
	}

	public void setVehiclebrandmodelname(String vehiclebrandmodelname) {
		this.vehiclebrandmodelname = vehiclebrandmodelname;
	}

	public String getVehicleno() {
		return this.vehicleno;
	}

	public void setVehicleno(String vehicleno) {
		this.vehicleno = vehicleno;
	}

	public long getVehicletypeid() {
		return this.vehicletypeid;
	}

	public void setVehicletypeid(long vehicletypeid) {
		this.vehicletypeid = vehicletypeid;
	}

	public void setFueladditionfee(BigDecimal fueladditionfee) {
		this.fueladditionfee = fueladditionfee;
	}

	public BigDecimal getFueladditionfee() {
		return fueladditionfee;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
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

	/**
	 * @return the servicefee
	 */
	public BigDecimal getServicefee() {
		return servicefee;
	}

	/**
	 * @param servicefee
	 *            the servicefee to set
	 */
	public void setServicefee(BigDecimal servicefee) {
		this.servicefee = servicefee;
	}

	/**
	 * @return the toplimitprice
	 */
	public BigDecimal getToplimitprice() {
		return toplimitprice;
	}

	/**
	 * @param toplimitprice
	 *            the toplimitprice to set
	 */
	public void setToplimitprice(BigDecimal toplimitprice) {
		this.toplimitprice = toplimitprice;
	}

	/**
	 * @return the seattype
	 */
	public String getSeattype() {
		return seattype;
	}

	/**
	 * @param seattype
	 *            the seattype to set
	 */
	public void setSeattype(String seattype) {
		this.seattype = seattype;
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

	public BigDecimal getMoreprice() {
		return moreprice;
	}

	public void setMoreprice(BigDecimal moreprice) {
		this.moreprice = moreprice;
	}

	public String getOrderno() {
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
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

	public String getDepartstationname() {
		return departstationname;
	}

	public void setDepartstationname(String departstationname) {
		this.departstationname = departstationname;
	}

	public String getOrgname() {
		return orgname;
	}

	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}

	public String getReachstationname() {
		return reachstationname;
	}

	public void setReachstationname(String reachstationname) {
		this.reachstationname = reachstationname;
	}

	public String getVehicletypename() {
		return vehicletypename;
	}

	public void setVehicletypename(String vehicletypename) {
		this.vehicletypename = vehicletypename;
	}

	public String getEticketid() {
		return eticketid;
	}

	public void setEticketid(String eticketid) {
		this.eticketid = eticketid;
	}
	public String getCustomername() {
		return customername;
	}

	public void setCustomername(String customername) {
		this.customername = customername;
	}

	public String getCertificatetypename() {
		return certificatetypename;
	}

	public void setCertificatetypename(String certificatetypename) {
		this.certificatetypename = certificatetypename;
	}

	public String getCertificateno() {
		return certificateno;
	}

	public void setCertificateno(String certificateno) {
		this.certificateno = certificateno;
	}

	
}