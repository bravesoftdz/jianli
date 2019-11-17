package cn.nova.bus.dispatch.model;

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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import play.data.binding.As;
import cn.nova.bus.archive.model.Customer;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.sale.model.Ticketturnoverdetail;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.utils.orm.jpa.ReceiveOnly;

/**
 * The persistent class for the SEATRESERVE database table.
 * 
 */
@Entity
public class Seatreserve implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "SEATRESERVE_ID_GENERATOR", sequenceName="SEQ_TICKETSELL",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEATRESERVE_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	private long id;

	@Temporal(TemporalType.TIMESTAMP)
	private Date autocanceltime;

	@ManyToOne
	@JoinColumn(name = "CANCELBY", nullable = true)
	private Userinfo cancel;

	@Temporal(TemporalType.TIMESTAMP)
	private Date canceltime;

	private byte carrychildnum;

	private Long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

    @Transient
    @ReceiveOnly
    private long customerid;

    @ManyToOne
	@JoinColumn(name = "CUSTOMERID", nullable = true)
	private Customer customer;

	@Temporal(TemporalType.DATE)
	private Date departdate;

    @Transient
    @ReceiveOnly
    private long departstationid;

	@ManyToOne
	@JoinColumn(name = "DEPARTSTATIONID", nullable = true)
	private Station departstation;

	private String departtime;

	private BigDecimal fullprice;

	private boolean isautocancel;

	private Long orgid;

	private String password;

    @Transient
    @ReceiveOnly
    private long reachstationid;

    @ManyToOne
	@JoinColumn(name = "REACHSTATIONID", nullable = true)
	private Station reachstation;

	private String remarks;
	
	
	private Long reserveby;

	private String reserveip;

	@Temporal(TemporalType.TIMESTAMP)
	private Date reservetime;

	private String reserveway;

	private Long scheduleid;

	private Long scheduleplanid;

	private short seatno;

	private String sellstate;

	private BigDecimal serviceprice;

	private Long ticketoutletsid;

	private String tickettype;

	@ManyToOne
	@JoinColumn(name = "TURNOVERDETAILID", nullable = true)
	private Ticketturnoverdetail turnoverdetail;

	private Long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

    @Transient
    @ReceiveOnly
    private String opertype;
    
	@Transient
    private Boolean isnet;
	
	@Transient
	private Long reserveorgid;//留票机构
	
	@Transient
	private String schedulecode;

	@Transient
	private String schedulesynccode;

	@Transient
	private String departstationcode;

	@Transient
	private String reachstationcode;
	
	@Transient
	private String routename;
	
	public String getOpertype() {
		return opertype;
	}

	public void setOpertype(String opertype) {
		this.opertype = opertype;
	}

	public Seatreserve() {
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Date getAutocanceltime() {
		return autocanceltime;
	}

	@As("yyyy-MM-dd HH:mm:ss")
	public void setAutocanceltime(Date autocanceltime) {
		this.autocanceltime = autocanceltime;
	}

	public Userinfo getCancel() {
		return cancel;
	}

	public void setCancel(Userinfo cancel) {
		this.cancel = cancel;
	}

	public Date getCanceltime() {
		return canceltime;
	}

	public void setCanceltime(Date canceltime) {
		this.canceltime = canceltime;
	}

	public byte getCarrychildnum() {
		return carrychildnum;
	}

	public void setCarrychildnum(byte carrychildnum) {
		this.carrychildnum = carrychildnum;
	}

	public Long getCreateby() {
		return createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public String getDeparttime() {
		return departtime;
	}

	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}

	public BigDecimal getFullprice() {
		return fullprice;
	}

	public void setFullprice(BigDecimal fullprice) {
		this.fullprice = fullprice;
	}

	public boolean isIsautocancel() {
		return isautocancel;
	}

	public void setIsautocancel(boolean isautocancel) {
		this.isautocancel = isautocancel;
	}

	public Long getOrgid() {
		return orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public Long getReserveby() {
		return reserveby;
	}

	public void setReserveby(Long reserveby) {
		this.reserveby = reserveby;
	}

	public String getReserveip() {
		return reserveip;
	}

	public void setReserveip(String reserveip) {
		this.reserveip = reserveip;
	}

	public Date getReservetime() {
		return reservetime;
	}

	public void setReservetime(Date reservetime) {
		this.reservetime = reservetime;
	}

	public String getReserveway() {
		return reserveway;
	}

	public void setReserveway(String reserveway) {
		this.reserveway = reserveway;
	}

	public Long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(Long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public Long getScheduleplanid() {
		return scheduleplanid;
	}

	public void setScheduleplanid(Long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	public short getSeatno() {
		return seatno;
	}

	public void setSeatno(short seatno) {
		this.seatno = seatno;
	}

	public String getSellstate() {
		return sellstate;
	}

	public void setSellstate(String sellstate) {
		this.sellstate = sellstate;
	}

	public BigDecimal getServiceprice() {
		return serviceprice;
	}

	public void setServiceprice(BigDecimal serviceprice) {
		this.serviceprice = serviceprice;
	}

	public Long getTicketoutletsid() {
		return ticketoutletsid;
	}

	public void setTicketoutletsid(Long ticketoutletsid) {
		this.ticketoutletsid = ticketoutletsid;
	}

	public Long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public Station getDepartstation() {
		return departstation;
	}

	public void setDepartstation(Station departstation) {
		this.departstation = departstation;
	}

	public Station getReachstation() {
		return reachstation;
	}

	public void setReachstation(Station reachstation) {
		this.reachstation = reachstation;
	}

	public void setTickettype(String tickettype) {
		this.tickettype = tickettype;
	}

	public String getTickettype() {
		return tickettype;
	}

	public void setTurnoverdetail(Ticketturnoverdetail turnoverdetail) {
		this.turnoverdetail = turnoverdetail;
	}

	public Ticketturnoverdetail getTurnoverdetail() {
		return turnoverdetail;
	}

	public void setCustomerid(long customerid) {
		this.customerid = customerid;
	}

	public long getCustomerid() {
		return customerid;
	}

	public long getDepartstationid() {
		return departstationid;
	}

	public void setDepartstationid(long departstationid) {
		this.departstationid = departstationid;
	}

	public long getReachstationid() {
		return reachstationid;
	}

	public void setReachstationid(long reachstationid) {
		this.reachstationid = reachstationid;
	}

	public Boolean getIsnet() {
		return isnet;
	}

	public void setIsnet(Boolean isnet) {
		this.isnet = isnet;
	}

	public Long getReserveorgid() {
		return reserveorgid;
	}

	public void setReserveorgid(Long reserveorgid) {
		this.reserveorgid = reserveorgid;
	}

	public String getSchedulecode() {
		return schedulecode;
	}

	public void setSchedulecode(String schedulecode) {
		this.schedulecode = schedulecode;
	}

	public String getSchedulesynccode() {
		return schedulesynccode;
	}

	public void setSchedulesynccode(String schedulesynccode) {
		this.schedulesynccode = schedulesynccode;
	}

	public String getDepartstationcode() {
		return departstationcode;
	}

	public void setDepartstationcode(String departstationcode) {
		this.departstationcode = departstationcode;
	}

	public String getReachstationcode() {
		return reachstationcode;
	}

	public void setReachstationcode(String reachstationcode) {
		this.reachstationcode = reachstationcode;
	}

	public String getRoutename() {
		return routename;
	}

	public void setRoutename(String routename) {
		this.routename = routename;
	}

}