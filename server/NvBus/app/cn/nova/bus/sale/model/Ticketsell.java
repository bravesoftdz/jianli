package cn.nova.bus.sale.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import cn.nova.bus.archive.model.Customer;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Ticketoutlets;
import cn.nova.bus.checkticket.model.Departinvoices;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.utils.orm.listener.UpdateEticketsellListener;

/**
 * The persistent class for the TICKETSELL database table.
 * 
 */
@Entity
@Table(name = "TICKETSELL")
@EntityListeners({UpdateEticketsellListener.class })
public class Ticketsell implements Serializable, Cloneable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "TICKETSELL_ID_GENERATOR", sequenceName = "SEQ_TICKETSELL", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "TICKETSELL_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;

	@Column(length = 60)
	private String buspark;

	@Column(nullable = false, precision = 2)
	private byte carrychildnum;

	// @Column(nullable=false, precision=10)
	// private long checkedby;

	@JoinColumn(name = "CHECKEDBY", nullable = true)
	@ManyToOne(fetch = FetchType.LAZY)
	private Userinfo checkedby;

	// @Column(precision=10)
	// private Long checkstationid;

	@JoinColumn(name = "CHECKSTATIONID", nullable = true)
	@ManyToOne(fetch = FetchType.LAZY)
	private Station checkstation;

	@Temporal(TemporalType.TIMESTAMP)
	private Date checktime;

	@Column(nullable = false, precision = 10)
	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date createtime;

	// @Column(precision=10)
	// private Long customerid;
	//
	@JoinColumn(name = "CUSTOMERID", nullable = true)
	@OneToOne(fetch = FetchType.LAZY)
	private Customer customer;

	private BigDecimal moreprice;
	
	private String tiksno;

	public BigDecimal getMoreprice() {
		return moreprice;
	}

	public void setMoreprice(BigDecimal moreprice) {
		this.moreprice = moreprice;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	@Temporal(TemporalType.DATE)
	@Column(nullable = false)
	private Date departdate;

	// @Column(nullable=false, precision=10)
	// private long departinvoicesby;
	@JoinColumn(name = "DEPARTINVOICESBY", nullable = true)
	@ManyToOne(fetch = FetchType.LAZY)
	private Userinfo departinvoicesby;

	public Userinfo getDepartinvoicesby() {
		return departinvoicesby;
	}

	public void setDepartinvoicesby(Userinfo departinvoicesby) {
		this.departinvoicesby = departinvoicesby;
	}

	// @Column(nullable=false, precision=10)
	// private long departinvoicesid;
	@JoinColumn(name = "DEPARTINVOICESID", nullable = true)
	@ManyToOne(fetch = FetchType.LAZY)
	private Departinvoices departinvoices;

	@Temporal(TemporalType.TIMESTAMP)
	private Date departinvoicestime;

	@Column(nullable = false, precision = 10)
	private long departstationid;

	@Column(nullable = false, length = 5)
	private String departtime;

	@Column(nullable = false, precision = 4, scale = 3)
	private BigDecimal discountrate;

	@Column(precision = 10)
	private Long distance;

	@Column(precision = 10, scale = 2)
	private BigDecimal fullprice;

	// @Column(precision=10)
	// private Long handticketoutletsid;

	@JoinColumn(name = "HANDTICKETOUTLETSID", nullable = true)
	@ManyToOne(fetch = FetchType.LAZY)
	private Ticketoutlets handticketoutlets;

	@Column(nullable = false, precision = 1)
	private boolean ischecked;

	@Column(nullable = false, precision = 1)
	private boolean isdepartinvoices;

	@Column(nullable = false, precision = 1)
	private boolean islinework;

	@Column(nullable = false, precision = 10)
	private long orgid;

	@Column(nullable = false, length = 10)
	private String paymethod;

	@Column(nullable = false, precision = 10, scale = 2)
	private BigDecimal price;

	@Column(nullable = false, precision = 10, scale = 2)
	private BigDecimal servicefee;

	@Column(nullable = false, precision = 10)
	private long reachstationid;

	@Column(nullable = false, precision = 10)
	private long scheduleid;

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

	@Column(nullable = false, precision = 10, scale = 2)
	private BigDecimal stationservicefee;

	@Column(nullable = false, precision = 10, scale = 2)
	private BigDecimal fueladditionfee;

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

	// @Column(nullable=false, precision=10)
	// private long turnoverid;

	@Column(nullable = true, precision = 10)
	private Long turnoverdetailid;

	@Column(nullable = false, precision = 10)
	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date updatetime;

	@Column(nullable = false, precision = 10)
	private long scheduleplanid;

	@JoinColumn(name = "VEHICLEREPORTID", nullable = true)
	@ManyToOne(fetch = FetchType.LAZY)
	private Vehiclereport vehiclereport;

	private String seattype;

	private BigDecimal toplimitprice;

	private BigDecimal waterfee;

	private BigDecimal insurefee;

	private BigDecimal otherfee;

	@Column(nullable = false, length = 40)
	private String orderno;

	private String ticketoutletsname;
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = true)
	private Date olddepartdate;
	
	private String customername;
	
	private String certificatetypename;
	
	private String certificateno;

	private Long vehicleid;
	
	private String departinvoicesno;
	
	private Long vehiclebrandmodelid;
	
	private String returnfeemode;
	
	//是否是窗口售电子票
	private boolean iseticketsell;
	//窗口电子票号
	private String eticketno;
	public Ticketsell() {
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

	public byte getCarrychildnum() {
		return this.carrychildnum;
	}

	public void setCarrychildnum(byte carrychildnum) {
		this.carrychildnum = carrychildnum;
	}

	public Date getChecktime() {
		return this.checktime;
	}

	public void setChecktime(Date checktime) {
		this.checktime = checktime;
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

	public Date getDepartinvoicestime() {
		return this.departinvoicestime;
	}

	public void setDepartinvoicestime(Date departinvoicestime) {
		this.departinvoicestime = departinvoicestime;
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

	public boolean getIschecked() {
		return this.ischecked;
	}

	public void setIschecked(boolean ischecked) {
		this.ischecked = ischecked;
	}

	public boolean getIsdepartinvoices() {
		return this.isdepartinvoices;
	}

	public void setIsdepartinvoices(boolean isdepartinvoices) {
		this.isdepartinvoices = isdepartinvoices;
	}

	public boolean getIslinework() {
		return this.islinework;
	}

	public void setIslinework(boolean islinework) {
		this.islinework = islinework;
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

	public long getScheduleid() {
		return this.scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
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

	public void setFueladditionfee(BigDecimal fueladditionfee) {
		this.fueladditionfee = fueladditionfee;
	}

	public BigDecimal getFueladditionfee() {
		return fueladditionfee;
	}

	public void setVehiclereport(Vehiclereport vehiclereport) {
		this.vehiclereport = vehiclereport;
	}

	public Vehiclereport getVehiclereport() {
		return vehiclereport;
	}

	public void setServicefee(BigDecimal servicefee) {
		this.servicefee = servicefee;
	}

	public BigDecimal getServicefee() {
		return servicefee;
	}

	public Userinfo getCheckedby() {
		return checkedby;
	}

	public void setCheckedby(Userinfo checkedby) {
		this.checkedby = checkedby;
	}

	public Station getCheckstation() {
		return checkstation;
	}

	public void setCheckstation(Station checkstation) {
		this.checkstation = checkstation;
	}

	public Departinvoices getDepartinvoices() {
		return departinvoices;
	}

	public void setDepartinvoices(Departinvoices departinvoices) {
		this.departinvoices = departinvoices;
	}

	public Ticketoutlets getHandticketoutlets() {
		return handticketoutlets;
	}

	public void setHandticketoutlets(Ticketoutlets handticketoutlets) {
		this.handticketoutlets = handticketoutlets;
	}

	public void setSeattype(String seattype) {
		this.seattype = seattype;
	}

	public String getSeattype() {
		return seattype;
	}

	public void setToplimitprice(BigDecimal toplimitprice) {
		this.toplimitprice = toplimitprice;
	}

	public BigDecimal getToplimitprice() {
		return toplimitprice;
	}

	public void setTurnoverdetailid(Long turnoverdetailid) {
		this.turnoverdetailid = turnoverdetailid;
	}

	public Long getTurnoverdetailid() {
		return turnoverdetailid;
	}

	public void setBatchno(String batchno) {
		this.batchno = batchno;
	}

	public String getBatchno() {
		return batchno;
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

	public String getTicketoutletsname() {
		return ticketoutletsname;
	}

	public void setTicketoutletsname(String ticketoutletsname) {
		this.ticketoutletsname = ticketoutletsname;
	}

	public long getScheduleplanid() {
		return scheduleplanid;
	}

	public void setScheduleplanid(long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	public String getTiksno() {
		return tiksno;
	}

	public void setTiksno(String tiksno) {
		this.tiksno = tiksno;
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

	public Long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(Long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public String getDepartinvoicesno() {
		return departinvoicesno;
	}

	public void setDepartinvoicesno(String departinvoicesno) {
		this.departinvoicesno = departinvoicesno;
	}

	public Long getVehiclebrandmodelid() {
		return vehiclebrandmodelid;
	}

	public void setVehiclebrandmodelid(Long vehiclebrandmodelid) {
		this.vehiclebrandmodelid = vehiclebrandmodelid;
	}
	public Date getOlddepartdate() {
		return olddepartdate;
	}

	public void setOlddepartdate(Date olddepartdate) {
		this.olddepartdate = olddepartdate;
	}
	
	
	public String getReturnfeemode() {
		return returnfeemode;
	}

	public void setReturnfeemode(String returnfeemode) {
		this.returnfeemode = returnfeemode;
	}

	public boolean isIseticketsell() {
		return iseticketsell;
	}

	public void setIseticketsell(boolean iseticketsell) {
		this.iseticketsell = iseticketsell;
	}

	public String getEticketno() {
		return eticketno;
	}

	public void setEticketno(String eticketno) {
		this.eticketno = eticketno;
	}

	@Override
	public Object clone() {
		Object o = null;
		try {
			o = super.clone();
		} catch (CloneNotSupportedException e) {
			// TODO Auto-generated catch block
			play.Logger.error(e.getMessage(), e);
		}
		return o;
	}
}