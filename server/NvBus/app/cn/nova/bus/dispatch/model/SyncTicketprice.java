package cn.nova.bus.dispatch.model;

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
import javax.persistence.Transient;

import cn.nova.utils.orm.listener.SyncCodeGenerate;

@Entity
@EntityListeners(value = { SyncCodeGenerate.class})
@Table(name = "TICKETPRICE")
public class SyncTicketprice implements Serializable {
	
	private static final long serialVersionUID = 1132546546L;

	@Id
	@SequenceGenerator(name = "TICKETPRICE_ID_GENERATOR", sequenceName = "SEQ_TICKETPRICE", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "TICKETPRICE_ID_GENERATOR")
	@Column(nullable = false, unique = true)
	private Long id;
	/*班次运行计划ID*/
	private Long scheduleplanid;
	
	private Long createby;
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;
	/*发车日期*/
	@Temporal(TemporalType.DATE)
	private Date departdate;
	/*发车站点id*/
	private Long departstationid;
	/*到达站点id*/
	private Long reachstationid;
	/*全票票价*/
	private BigDecimal fullprice;
	/*半票票价*/
	private BigDecimal halfprice;
	/*学生票价*/
	private BigDecimal studentprice;
	/*售票状态 0 不可售 1 可售*/
	private boolean issellable;
	/*组织机构 ID*/
	private Long orgid;
	/*不自动取消留位数*/
	private short unautocancelreserveseatnum;
	/*自动取消留位数*/
	private short autocancelreserveseatnum;
	/*固定留位数*/
	private short fixedreserveseatnum;
	/*运行时间，相对发车站点 单位小时*/
	private BigDecimal runtime;
	/*班次id*/
	@Column(nullable = false)
	private Long scheduleid;
	@Transient
	public String schedulesynccode;
	/*站务费*/
	private BigDecimal stationservicefee;
	/*燃油附加费*/
	private BigDecimal fueladditionfee;
	/*座位号列表，如：1,2,3,4,5*/
	private String seatnos;
	/*座位数*/
	private short seatnum;
	/*座位类型描述:如上铺、下铺、软座、普通座、商务座、豪华座 取数据字典*/
	private String seattype;
	/*已售座位数*/
	private short soldeatnum;
	/**/
	private Long updateby;
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;
	/*发车站点距离到达站点的里程（公里）*/
	private Integer distance;
	/*发车站点距离到达站点的结算里程（公里）*/
	private Integer balancedistance;
	/*上限票价*/
	private BigDecimal toplimitprice;
	/*下限票价*/
	private BigDecimal lowerlimitprice;
	/*同步码*/
	private String synccode;
	/*票价差*/
	private BigDecimal moreprice;
	
	@Transient
	private Integer flag;
	
	@Transient
	private String departstationname;
	@Transient
	private String reachstationname;
	@Transient
	private String orgname;
	@Transient
	public String orgcode;
	@Transient
	private String schedulecode;
	
    //优惠票 、 往返票 、 联程票
	private BigDecimal discountprice;

	private BigDecimal roundprice;

	private BigDecimal connectprice;
	
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
	
	public Integer getFlag() {
		return flag;
	}
	public void setFlag(Integer flag) {
		this.flag = flag;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getScheduleplanid() {
		return scheduleplanid;
	}
	public void setScheduleplanid(Long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
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
	public Long getDepartstationid() {
		return departstationid;
	}
	public void setDepartstationid(Long departstationid) {
		this.departstationid = departstationid;
	}
	public Long getReachstationid() {
		return reachstationid;
	}
	public void setReachstationid(Long reachstationid) {
		this.reachstationid = reachstationid;
	}
	public BigDecimal getFullprice() {
		return fullprice;
	}
	public void setFullprice(BigDecimal fullprice) {
		this.fullprice = fullprice;
	}
	public BigDecimal getHalfprice() {
		return halfprice;
	}
	public void setHalfprice(BigDecimal halfprice) {
		this.halfprice = halfprice;
	}
	public BigDecimal getStudentprice() {
		return studentprice;
	}
	public void setStudentprice(BigDecimal studentprice) {
		this.studentprice = studentprice;
	}
	public boolean getIssellable() {
		return issellable;
	}
	public void setIssellable(boolean issellable) {
		this.issellable = issellable;
	}
	public Long getOrgid() {
		return orgid;
	}
	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}
	public short getUnautocancelreserveseatnum() {
		return unautocancelreserveseatnum;
	}
	public void setUnautocancelreserveseatnum(short unautocancelreserveseatnum) {
		this.unautocancelreserveseatnum = unautocancelreserveseatnum;
	}
	public short getAutocancelreserveseatnum() {
		return autocancelreserveseatnum;
	}
	public void setAutocancelreserveseatnum(short autocancelreserveseatnum) {
		this.autocancelreserveseatnum = autocancelreserveseatnum;
	}
	public short getFixedreserveseatnum() {
		return fixedreserveseatnum;
	}
	public void setFixedreserveseatnum(short fixedreserveseatnum) {
		this.fixedreserveseatnum = fixedreserveseatnum;
	}
	public BigDecimal getRuntime() {
		return runtime;
	}
	public void setRuntime(BigDecimal runtime) {
		this.runtime = runtime;
	}
	public Long getScheduleid() {
		return scheduleid;
	}
	public void setScheduleid(Long scheduleid) {
		this.scheduleid = scheduleid;
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
	public String getSeatnos() {
		return seatnos;
	}
	public void setSeatnos(String seatnos) {
		this.seatnos = seatnos;
	}
	public short getSeatnum() {
		return seatnum;
	}
	public void setSeatnum(short seatnum) {
		this.seatnum = seatnum;
	}
	public String getSeattype() {
		return seattype;
	}
	public void setSeattype(String seattype) {
		this.seattype = seattype;
	}
	public short getSoldeatnum() {
		return soldeatnum;
	}
	public void setSoldeatnum(short soldeatnum) {
		this.soldeatnum = soldeatnum;
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
	public Integer getDistance() {
		return distance;
	}
	public void setDistance(Integer distance) {
		this.distance = distance;
	}
	public Integer getBalancedistance() {
		return balancedistance;
	}
	public void setBalancedistance(Integer balancedistance) {
		this.balancedistance = balancedistance;
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
	public String getSynccode() {
		return synccode;
	}
	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}
	public BigDecimal getMoreprice() {
		return moreprice;
	}
	public void setMoreprice(BigDecimal moreprice) {
		this.moreprice = moreprice;
	}
	public String getDepartstationname() {
		return departstationname;
	}
	public void setDepartstationname(String departstationname) {
		this.departstationname = departstationname;
	}
	public String getReachstationname() {
		return reachstationname;
	}
	public void setReachstationname(String reachstationname) {
		this.reachstationname = reachstationname;
	}
	public String getOrgname() {
		return orgname;
	}
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}
	public String getSchedulecode() {
		return schedulecode;
	}
	public void setSchedulecode(String schedulecode) {
		this.schedulecode = schedulecode;
	}

	@Override
	public String toString() {
		return "SyncTicketprice [id=" + id + ", scheduleplanid=" + scheduleplanid + ", createby=" + createby
				+ ", createtime=" + createtime + ", departdate=" + departdate + ", departstationid=" + departstationid
				+ ", reachstationid=" + reachstationid + ", fullprice=" + fullprice + ", halfprice=" + halfprice
				+ ", studentprice=" + studentprice + ", issellable=" + issellable + ", orgid=" + orgid
				+ ", unautocancelreserveseatnum=" + unautocancelreserveseatnum + ", autocancelreserveseatnum="
				+ autocancelreserveseatnum + ", fixedreserveseatnum=" + fixedreserveseatnum + ", runtime=" + runtime
				+ ", scheduleid=" + scheduleid + ", schedulesynccode=" + schedulesynccode + ", stationservicefee="
				+ stationservicefee + ", fueladditionfee=" + fueladditionfee + ", seatnos=" + seatnos + ", seatnum="
				+ seatnum + ", seattype=" + seattype + ", soldeatnum=" + soldeatnum + ", updateby=" + updateby
				+ ", updatetime=" + updatetime + ", distance=" + distance + ", balancedistance=" + balancedistance
				+ ", toplimitprice=" + toplimitprice + ", lowerlimitprice=" + lowerlimitprice + ", synccode=" + synccode
				+ ", moreprice=" + moreprice + ", flag=" + flag + ", departstationname=" + departstationname
				+ ", reachstationname=" + reachstationname + ", orgname=" + orgname + ", orgcode=" + orgcode
				+ ", schedulecode=" + schedulecode + ", discountprice=" + discountprice + ", roundprice=" + roundprice
				+ ", connectprice=" + connectprice + "]";
	}
	
	
	
}
