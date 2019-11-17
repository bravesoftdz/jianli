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

/**
 * The persistent class for the TICKETSELLAGENT database table.
 * 
 */
@Entity
@Table(name = "REMOTETICKETSELL")
public class RemoteTicketsell implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "REMOTETICKETSELL_ID_GENERATOR", sequenceName = "SEQ_TICKETSELL", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "REMOTETICKETSELL_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;

	private String buspark;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	@Temporal(TemporalType.DATE)
	private Date departdate;

	private long departstationid;

	private String departtime;

	private BigDecimal discountrate;

	private Long distance;

	private BigDecimal fullprice;

	private BigDecimal servicefee;

	private byte carrychildnum;

	private BigDecimal fueladditionfee;

	private boolean islinework;

	private long departorgid;

	private long checkorgid;

	private String paymethod;

	private BigDecimal price;

	private long reachstationid;

	private String schedulecode;

	private short seatno;

	private String sellby;

	private String sellip;

	@Temporal(TemporalType.TIMESTAMP)
	private Date selltime;

	private String sellway;

	private BigDecimal serviceprice;

	private BigDecimal stationservicefee;

	private BigDecimal computefee;

	private BigDecimal coolairfee;

	private BigDecimal additionfee;

	private String ticketentrance;

	private String batchno;

	private String ticketno;

	private String ticketoutletsname;

	private String ticketstatus;

	private String tickettype;

	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date updatetime;

	private String checkby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date checktime;

	private String vehicleno;

	private String vehicletypename;

	private String seattype;

	private BigDecimal toplimitprice;

	private BigDecimal moreprice;

	private BigDecimal waterfee;

	private BigDecimal insurefee;

	private BigDecimal otherfee;

	private String orderno;

	private String checktype;
	
	private Long scheduleplanid;
	
	private Long vehiclereportid;
	
	private boolean ischecked;	
	
	private Long departinvoicesid;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date departinvoicestime;
	
	private Long departinvoicesby;
	
	private Long ticketsellorgid;
	
	public Date getDepartinvoicestime() {
		return departinvoicestime;
	}

	public void setDepartinvoicestime(Date departinvoicestime) {
		this.departinvoicestime = departinvoicestime;
	}

	public Long getDepartinvoicesby() {
		return departinvoicesby;
	}

	public void setDepartinvoicesby(Long departinvoicesby) {
		this.departinvoicesby = departinvoicesby;
	}

	public Long getDepartinvoicesid() {
		return departinvoicesid;
	}

	public void setDepartinvoicesid(Long departinvoicesid) {
		this.departinvoicesid = departinvoicesid;
	}

	public boolean isIschecked() {
		return ischecked;
	}

	public void setIschecked(boolean ischecked) {
		this.ischecked = ischecked;
	}

	private boolean isdepartinvoices;
	
	public boolean isIsdepartinvoices() {
		return isdepartinvoices;
	}

	public void setIsdepartinvoices(boolean isdepartinvoices) {
		this.isdepartinvoices = isdepartinvoices;
	}

	public Long getVehiclereportid() {
		return vehiclereportid;
	}

	public void setVehiclereportid(Long vehiclereportid) {
		this.vehiclereportid = vehiclereportid;
	}


	
	public String getChecktype() {
		return checktype;
	}

	public void setChecktype(String checktype) {
		this.checktype = checktype;
	}

	public Long getScheduleplanid() {
		return scheduleplanid;
	}

	public void setScheduleplanid(Long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	public RemoteTicketsell() {
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

	public String getVehicleno() {
		return this.vehicleno;
	}

	public void setVehicleno(String vehicleno) {
		this.vehicleno = vehicleno;
	}

	public void setFueladditionfee(BigDecimal fueladditionfee) {
		this.fueladditionfee = fueladditionfee;
	}

	public BigDecimal getFueladditionfee() {
		return fueladditionfee;
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

	public long getDepartorgid() {
		return departorgid;
	}

	public void setDepartorgid(long departorgid) {
		this.departorgid = departorgid;
	}

	public long getCheckorgid() {
		return checkorgid;
	}

	public void setCheckorgid(long checkorgid) {
		this.checkorgid = checkorgid;
	}

	public String getTicketoutletsname() {
		return ticketoutletsname;
	}

	public void setTicketoutletsname(String ticketoutletsname) {
		this.ticketoutletsname = ticketoutletsname;
	}

	public String getSellby() {
		return sellby;
	}

	public void setSellby(String sellby) {
		this.sellby = sellby;
	}

	public String getCheckby() {
		return checkby;
	}

	public void setCheckby(String checkby) {
		this.checkby = checkby;
	}

	public Date getChecktime() {
		return checktime;
	}

	public void setChecktime(Date checktime) {
		this.checktime = checktime;
	}

	public String getVehicletypename() {
		return vehicletypename;
	}

	public void setVehicletypename(String vehicletypename) {
		this.vehicletypename = vehicletypename;
	}

	public Long getTicketsellorgid() {
		return ticketsellorgid;
	}

	public void setTicketsellorgid(Long ticketsellorgid) {
		this.ticketsellorgid = ticketsellorgid;
	}
	
}