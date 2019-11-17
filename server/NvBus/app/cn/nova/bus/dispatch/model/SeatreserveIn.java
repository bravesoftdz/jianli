package cn.nova.bus.dispatch.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;

public class SeatreserveIn implements Serializable {

	/**
	 * serialVersionUID:
	 */
	private static final long serialVersionUID = -6380627996572366302L;

	private String reserveOrgCode;// 调用者机构 //不允许为空
	private String reserveIp;// 操作者IP //不允许为空
	private String reserverCode;// 用户id //不允许为空

	private String ticketoutletsname;

	private String ticketoutletsCode;

	@Temporal(TemporalType.TIMESTAMP)
	private Date reservetime;

	private boolean isautocancel;

	@Temporal(TemporalType.TIMESTAMP)
	private Date autocanceltime;

	//private String schplanSynccode;

	private Date departDate; // 非空
	private String schedulecode;
	private String schedulesynccode;

	private long departstationid;
	private long reachstationid;
	private String orgcode;

	private String departStationCode; // 非空
	private String reachStationCode; // 非空
	private String departtime;

	private BigDecimal serviceprice;

	private BigDecimal fullprice;

	private String seatnostr;
	private byte carrychildnum;

	private Long customerid;

	private String sex;
	private String certificatetype;
	private String certificateno;
	private String mobilephone;
	private String name;
	private String customersynccode;
	private String routename;

	private List<Seatreserveno> seatlist;//座位列表


	public Long getCustomerid() {
		return customerid;
	}

	public void setCustomerid(Long customerid) {
		this.customerid = customerid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMobilephone() {
		return mobilephone;
	}

	public void setMobilephone(String mobilephone) {
		this.mobilephone = mobilephone;
	}

	public Date getDepartDate() {
		return departDate;
	}

	public void setDepartDate(Date departDate) {
		this.departDate = departDate;
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

	public String getDepartStationCode() {
		return departStationCode;
	}

	public void setDepartStationCode(String departStationCode) {
		this.departStationCode = departStationCode;
	}

	public String getReachStationCode() {
		return reachStationCode;
	}

	public void setReachStationCode(String reachStationCode) {
		this.reachStationCode = reachStationCode;
	}

	public String getDeparttime() {
		return departtime;
	}

	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}

	public String getSeatnostr() {
		return seatnostr;
	}

	public void setSeatnostr(String seatnostr) {
		this.seatnostr = seatnostr;
	}

	public byte getCarrychildnum() {
		return carrychildnum;
	}

	public void setCarrychildnum(byte carrychildnum) {
		this.carrychildnum = carrychildnum;
	}

	public String getCertificatetype() {
		return certificatetype;
	}

	public void setCertificatetype(String certificatetype) {
		this.certificatetype = certificatetype;
	}

	public String getCertificateno() {
		return certificateno;
	}

	public void setCertificateno(String certificateno) {
		this.certificateno = certificateno;
	}

	public String getReserveOrgCode() {
		return reserveOrgCode;
	}

	public void setReserveOrgCode(String reserveOrgCode) {
		this.reserveOrgCode = reserveOrgCode;
	}

	public String getReserveIp() {
		return reserveIp;
	}

	public void setReserveIp(String reserveIp) {
		this.reserveIp = reserveIp;
	}

	public String getReserverCode() {
		return reserverCode;
	}

	public void setReserverCode(String reserverCode) {
		this.reserverCode = reserverCode;
	}

	public String getTicketoutletsname() {
		return ticketoutletsname;
	}

	public void setTicketoutletsname(String ticketoutletsname) {
		this.ticketoutletsname = ticketoutletsname;
	}

	public String getTicketoutletsCode() {
		return ticketoutletsCode;
	}

	public void setTicketoutletsCode(String ticketoutletsCode) {
		this.ticketoutletsCode = ticketoutletsCode;
	}

	public Date getReservetime() {
		return reservetime;
	}

	public void setReservetime(Date reservetime) {
		this.reservetime = reservetime;
	}

	public Date getAutocanceltime() {
		return autocanceltime;
	}

	public void setAutocanceltime(Date autocanceltime) {
		this.autocanceltime = autocanceltime;
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

	public BigDecimal getServiceprice() {
		return serviceprice;
	}

	public void setServiceprice(BigDecimal serviceprice) {
		this.serviceprice = serviceprice;
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

	public String getOrgcode() {
		return orgcode;
	}

	public void setOrgcode(String orgcode) {
		this.orgcode = orgcode;
	}

	public List<Seatreserveno> getSeatlist() {
		return seatlist;
	}

	public void setSeatlist(List<Seatreserveno> seatlist) {
		this.seatlist = seatlist;
	}

	public String getCustomersynccode() {
		return customersynccode;
	}

	public void setCustomersynccode(String customersynccode) {
		this.customersynccode = customersynccode;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getRoutename() {
		return routename;
	}

	public void setRoutename(String routename) {
		this.routename = routename;
	}
	
}
