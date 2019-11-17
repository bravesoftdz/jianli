package cn.nova.bus.price.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import cn.nova.utils.orm.listener.RemoveListenerForSync;
import cn.nova.utils.orm.listener.SyncCodeGenerate;

@Entity
@EntityListeners(value = { SyncCodeGenerate.class,RemoveListenerForSync.class })
public class Ticketprice implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "TICKETPRICE_ID_GENERATOR", sequenceName = "SEQ_TICKETPRICE", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "TICKETPRICE_ID_GENERATOR")
	@Column(nullable = false, unique = true)
	private long id;

	@Column(nullable = false)
	private long createby;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	@Column(nullable = false)
	@Temporal(TemporalType.DATE)
	private Date departdate;

	@Column(nullable = false)
	private long departstationid;

	@Column(nullable = false)
	private BigDecimal fullprice;

	@Column(nullable = false)
	private BigDecimal halfprice;

	@Column(nullable = false)
	private boolean issellable;

	@Column(nullable = false)
	private long orgid;

	@Column(nullable = false)
	private long reachstationid;

	@Column(nullable = false)
	private short unautocancelreserveseatnum;

	@Column(nullable = false)
	private short fixedreserveseatnum;

	@Column(nullable = false)
	private short autocancelreserveseatnum;

	private BigDecimal runtime;

	@Column(nullable = false)
	private long scheduleid;

	@Column(nullable = false)
	private BigDecimal stationservicefee;

	@Column(nullable = false)
	private BigDecimal fueladditionfee;

	@JoinColumn(name = "SCHEDULEPLANID", nullable = false)
	@ManyToOne(cascade = { CascadeType.REFRESH, CascadeType.PERSIST })
	private Scheduleplan scheduleplan;

	@Column(nullable = false)
	private String seatnos;

	@Column(nullable = false)
	private short seatnum;

	@Column(nullable = false)
	private String seattype;

	@Column(nullable = false)
	private short soldeatnum;

	@Column(nullable = false)
	private BigDecimal studentprice;

	@Column(nullable = false)
	private long updateby;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	@Column(nullable = false)
	private int distance;

	@Column(nullable = false)
	private int balancedistance;

	@Column(nullable = false)
	private BigDecimal toplimitprice;

	@Column(nullable = false)
	private BigDecimal lowerlimitprice;

	@OneToMany(cascade = { CascadeType.ALL }, mappedBy = "ticketprice")
	private List<Ticketpriceitem> ticketpriceitemlist;

	@Transient
	private long scheduleplanid;

	@Transient
	private String reachstationname;

	@Transient
	private String opertype;

	@Transient
	private String departstationname;

	@Column(nullable = false, length = 40)
	private String synccode;

	private BigDecimal moreprice;
    //优惠票 、 往返票 、 联程票
	private BigDecimal discountprice = BigDecimal.ZERO;//����Ĭ��ֵ
	
	private BigDecimal roundprice = BigDecimal.ZERO;//����Ĭ��ֵ
	
	private BigDecimal connectprice = BigDecimal.ZERO;//����Ĭ��ֵ

	public BigDecimal getMoreprice() {
		return moreprice;
	}

	public void setMoreprice(BigDecimal moreprice) {
		this.moreprice = moreprice;
	}

	public Ticketprice() {
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

	public String getSynccode() {
		return synccode;
	}

	public Scheduleplan getScheduleplan() {
		return scheduleplan;
	}

	public void setScheduleplan(Scheduleplan scheduleplan) {
		this.scheduleplan = scheduleplan;
	}

	public BigDecimal getToplimitprice() {
		return toplimitprice;
	}

	public void setToplimitprice(BigDecimal toplimitprice) {
		this.toplimitprice = toplimitprice;
	}

	public BigDecimal getLowerlimitprice() {
		return lowerlimitprice;
	}

	public void setLowerlimitprice(BigDecimal lowerlimitprice) {
		this.lowerlimitprice = lowerlimitprice;
	}

	public List<Ticketpriceitem> getTicketpriceitemlist() {
		return ticketpriceitemlist;
	}

	public void setTicketpriceitemlist(List<Ticketpriceitem> ticketpriceitemlist) {
		this.ticketpriceitemlist = ticketpriceitemlist;
	}

	public int getDistance() {
		return distance;
	}

	public void setDistance(int distance) {
		this.distance = distance;
	}

	public int getBalancedistance() {
		return balancedistance;
	}

	public void setBalancedistance(int balancedistance) {
		this.balancedistance = balancedistance;
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

	public BigDecimal getFullprice() {
		return this.fullprice;
	}

	public void setFullprice(BigDecimal fullprice) {
		this.fullprice = fullprice;
	}

	public BigDecimal getHalfprice() {
		return this.halfprice;
	}

	public void setHalfprice(BigDecimal halfprice) {
		this.halfprice = halfprice;
	}

	public boolean getIssellable() {
		return this.issellable;
	}

	public void setIssellable(boolean issellable) {
		this.issellable = issellable;
	}

	public long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public long getReachstationid() {
		return this.reachstationid;
	}

	public void setReachstationid(long reachstationid) {
		this.reachstationid = reachstationid;
	}

	public BigDecimal getRuntime() {
		return this.runtime;
	}

	public void setRuntime(BigDecimal runtime) {
		this.runtime = runtime;
	}

	public long getScheduleid() {
		return this.scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public String getSeatnos() {
		return this.seatnos;
	}

	public void setSeatnos(String seatnos) {
		this.seatnos = seatnos;
	}

	public short getSeatnum() {
		return this.seatnum;
	}

	public void setSeatnum(short seatnum) {
		this.seatnum = seatnum;
	}

	public String getSeattype() {
		return this.seattype;
	}

	public void setSeattype(String seattype) {
		this.seattype = seattype;
	}

	public short getSoldeatnum() {
		return this.soldeatnum;
	}

	public void setSoldeatnum(short soldeatnum) {
		this.soldeatnum = soldeatnum;
	}

	public BigDecimal getStudentprice() {
		return this.studentprice;
	}

	public void setStudentprice(BigDecimal studentprice) {
		this.studentprice = studentprice;
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

	public void setAutocancelreserveseatnum(short autocancelreserveseatnum) {
		this.autocancelreserveseatnum = autocancelreserveseatnum;
	}

	public short getAutocancelreserveseatnum() {
		return autocancelreserveseatnum;
	}

	public void setFixedreserveseatnum(short fixedreserveseatnum) {
		this.fixedreserveseatnum = fixedreserveseatnum;
	}

	public short getFixedreserveseatnum() {
		return fixedreserveseatnum;
	}

	public void setUnautocancelreserveseatnum(short unautocancelreserveseatnum) {
		this.unautocancelreserveseatnum = unautocancelreserveseatnum;
	}

	public short getUnautocancelreserveseatnum() {
		return unautocancelreserveseatnum;
	}

	public BigDecimal getStationservicefee() {
		return stationservicefee;
	}

	public void setStationservicefee(BigDecimal stationservicefee) {
		this.stationservicefee = stationservicefee;
	}

	public BigDecimal getFueladditionfee() {
		return fueladditionfee;
	}

	public void setFueladditionfee(BigDecimal fueladditionfee) {
		this.fueladditionfee = fueladditionfee;
	}

	public long getScheduleplanid() {
		return scheduleplanid;
	}

	public void setScheduleplanid(long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	public String getReachstationname() {
		return reachstationname;
	}

	public void setReachstationname(String reachstationname) {
		this.reachstationname = reachstationname;
	}

	public String getOpertype() {
		return opertype;
	}

	public void setOpertype(String opertype) {
		this.opertype = opertype;
	}

	public String getDepartstationname() {
		return departstationname;
	}

	public void setDepartstationname(String departstationname) {
		this.departstationname = departstationname;
	}

	public BigDecimal getDiscountprice() {
		return discountprice;
	}

	public void setDiscountprice(BigDecimal discountprice) {
		this.discountprice = discountprice;
	}

	public BigDecimal getRoundprice() {
		return roundprice;
	}

	public void setRoundprice(BigDecimal roundprice) {
		this.roundprice = roundprice;
	}

	public BigDecimal getConnectprice() {
		return connectprice;
	}

	public void setConnectprice(BigDecimal connectprice) {
		this.connectprice = connectprice;
	}
	

}