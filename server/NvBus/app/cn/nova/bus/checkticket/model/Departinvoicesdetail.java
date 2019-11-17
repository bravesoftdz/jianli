package cn.nova.bus.checkticket.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

@Entity
public class Departinvoicesdetail implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "DEPARTINVOICESDETAIL_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "DEPARTINVOICESDETAIL_ID_GENERATOR")
	@Column(unique = true, nullable = false)
	private long id;

	@Column(nullable = false)
	private BigDecimal agentfee;

	@Column(nullable = false)
	private BigDecimal othterfee;

	@Column(nullable = false)
	private BigDecimal balanceamount;

	@Column(nullable = false)
	private long createby;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	@Column(nullable = false)
	@Temporal(TemporalType.DATE)
	private Date departdate;

	@Column(nullable = false)
	private String departtime;

	@Column(nullable = false)
	private long distance;

	@Column(nullable = false)
	private long fromstationid;

	@Column(nullable = false)
	private boolean issupply;

	@Column(nullable = false)
	private BigDecimal fueladditionfee;

	@Column(nullable = false)
	private BigDecimal price;

	@Column(nullable = false)
	private long reachstationid;

	@Column(nullable = false)	private long scheduleid;

	@Column(nullable = false)
	private BigDecimal stationservicefee;

	@Column(nullable = false)
	private long ticketnum;

	@Column(nullable = false)
	private String tickettype;

	@Column(nullable = false)
	private BigDecimal totalamount;

	@Column(nullable = false)
	private long updateby;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	@JoinColumn(name = "DEPARTINVOICESID", nullable = false)
	@ManyToOne(cascade = { CascadeType.REFRESH, CascadeType.PERSIST })
	private Departinvoices departinvoices;

	@Transient
	private String ticketids;

	@Transient
	List<Departinvoicesdeductdetail> departinvoicesdeductdetails;

	private BigDecimal moreprice;
	
	private int nopaperticketnum;//无纸质车票张数(包含未取票的电子票,网售票,窗口售电子票等 但不包含手持机售出的票)
	
	private int paperticketnum;//纸质车票张数(包含取票的电子票,网售票,窗口售等 但不包含手持机售出的票)
	
	public BigDecimal getMoreprice() {
		return moreprice;
	}

	public void setMoreprice(BigDecimal moreprice) {
		this.moreprice = moreprice;
	}

	public List<Departinvoicesdeductdetail> getDepartinvoicesdeductdetails() {
		return departinvoicesdeductdetails;
	}

	public void setDepartinvoicesdeductdetails(
			List<Departinvoicesdeductdetail> departinvoicesdeductdetails) {
		this.departinvoicesdeductdetails = departinvoicesdeductdetails;
	}

	public String getTicketids() {
		return ticketids;
	}

	public void setTicketids(String ticketids) {
		this.ticketids = ticketids;
	}

	public Departinvoicesdetail() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getTickettype() {
		return tickettype;
	}

	public void setTickettype(String tickettype) {
		this.tickettype = tickettype;
	}

	public BigDecimal getBalanceamount() {
		return this.balanceamount;
	}

	public void setBalanceamount(BigDecimal balanceamount) {
		this.balanceamount = balanceamount;
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

	public String getDeparttime() {
		return this.departtime;
	}

	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}

	public long getDistance() {
		return this.distance;
	}

	public void setDistance(long distance) {
		this.distance = distance;
	}

	public long getFromstationid() {
		return this.fromstationid;
	}

	public void setFromstationid(long fromstationid) {
		this.fromstationid = fromstationid;
	}

	public boolean getIssupply() {
		return this.issupply;
	}

	public void setIssupply(boolean issupply) {
		this.issupply = issupply;
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

	public BigDecimal getStationservicefee() {
		return this.stationservicefee;
	}

	public void setStationservicefee(BigDecimal stationservicefee) {
		this.stationservicefee = stationservicefee;
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

	public Departinvoices getDepartinvoices() {
		return departinvoices;
	}

	public void setDepartinvoices(Departinvoices departinvoices) {
		this.departinvoices = departinvoices;
	}

	public BigDecimal getFueladditionfee() {
		return fueladditionfee;
	}

	public void setFueladditionfee(BigDecimal fueladditionfee) {
		this.fueladditionfee = fueladditionfee;
	}

	public BigDecimal getAgentfee() {
		return agentfee;
	}

	public void setAgentfee(BigDecimal agentfee) {
		this.agentfee = agentfee;
	}

	public BigDecimal getOthterfee() {
		return othterfee;
	}

	public void setOthterfee(BigDecimal othterfee) {
		this.othterfee = othterfee;
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
	
}