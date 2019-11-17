package cn.nova.bus.dispatch.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

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
@Table(name = "SCHEDULEPLAN")
@EntityListeners(value = { SyncCodeGenerate.class })
public class SyncScheduleplan implements Serializable {
	
	private static final long serialVersionUID = 1561325465461L;

	@Id
	@SequenceGenerator(name = "SCHEDULEPLAN_ID_GENERATOR", sequenceName = "SEQ_SCHEDULEPLAN", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SCHEDULEPLAN_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private Long id;
	/*所属车站id*/
	private Long orgid;
	/*发车日期*/
	@Temporal(TemporalType.DATE)
	private Date departdate;
	/*自动取消留位数*/
	private short autocancelreserveseatnum;
	/*班次id*/
	private Long scheduleid;
	@Transient
	public String schedulesynccode;
	/*座位数*/
	private short seatnum;
	/*不自动取消留位数*/
	private short unautocancelreserveseatnum;
	/**/
	private Long createby;
	/**/
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;
	/*里程(公里)冗余*/
	private Integer distance;
	/*区域类别：1县内、2县际、3市际、4省际、5国际*/
	private String districttype;
	/*终点站ID*/
	private Long endstationid;
	/*结束时间*/
	@Column(length = 5)
	private String endtime;
	/*备注*/
	private String remarks;
	/*固定留位数*/
	private short fixedreserveseatnum;
	/*高速里程(公里)冗余*/
	private Integer highdistance;
	/*是否允许混检*/
	private boolean iscanmixcheck;
	/*是否流水班次*/
	private boolean islinework;
	/*是否始发班次（非过路班次）*/
	private boolean isoriginator;
	/*加班班次*/
	private boolean isovertime;
	/*是否本站专有班次*/
	private boolean isproprietary;
	/*是否报到后售票*/
	private boolean issaleafterreport;
	/*是否可售 0 不可售 1 可售*/
	private boolean issellable;
	/*是否售回程票（终点站）*/
	private boolean issellreturnticket;
	/*运行时间*/
	private BigDecimal runtime;
	/*班次类型：1四定、2普通*/
	private String scheduletype;
	/*已售座位数*/
	private short soldeatnum;
	/*已带儿童数*/
	private short carrychildnum;
	/*发车时间间隔*/
	private short spacinginterval;
	/*始发站ID*/
	private Long startstationid;
	/*始发时间*/
	private String starttime;
	/**/
	private Long updateby;
	/**/
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;
	/*营运类别：1单营、2共营*/
	private String worktype;
	/*营运方式（直达、普通、城乡公交、的士）*/
	private String workways;
	/**/
	private String synccode;
	
	@Transient
	private Integer flag;
	
	@Transient
	private String orgcode;
	@Transient
	private String schedulecode;
	@Transient
	private String startstationname;
	@Transient
	private String endstationname;
	
	/*票价表记录*/
	@Transient
	private List<SyncTicketprice> ticketpricelist;
	/*班次状态表记录*/
	@Transient
	private List<SyncSchedulestatus> schedulestatuslist;
	/*班次车辆驾乘人员运行计划表记录*/
	@Transient
	private List<SyncSchedulevehiclepeopleplan> schedulevehiclepeopleplanlist;
	
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
	public Long getOrgid() {
		return orgid;
	}
	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}
	public Date getDepartdate() {
		return departdate;
	}
	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}
	public short getAutocancelreserveseatnum() {
		return autocancelreserveseatnum;
	}
	public void setAutocancelreserveseatnum(short autocancelreserveseatnum) {
		this.autocancelreserveseatnum = autocancelreserveseatnum;
	}
	public Long getScheduleid() {
		return scheduleid;
	}
	public void setScheduleid(Long scheduleid) {
		this.scheduleid = scheduleid;
	}
	public short getSeatnum() {
		return seatnum;
	}
	public void setSeatnum(short seatnum) {
		this.seatnum = seatnum;
	}
	public short getUnautocancelreserveseatnum() {
		return unautocancelreserveseatnum;
	}
	public void setUnautocancelreserveseatnum(short unautocancelreserveseatnum) {
		this.unautocancelreserveseatnum = unautocancelreserveseatnum;
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
	public Integer getDistance() {
		return distance;
	}
	public void setDistance(Integer distance) {
		this.distance = distance;
	}
	public String getDistricttype() {
		return districttype;
	}
	public void setDistricttype(String districttype) {
		this.districttype = districttype;
	}
	public Long getEndstationid() {
		return endstationid;
	}
	public void setEndstationid(Long endstationid) {
		this.endstationid = endstationid;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public short getFixedreserveseatnum() {
		return fixedreserveseatnum;
	}
	public void setFixedreserveseatnum(short fixedreserveseatnum) {
		this.fixedreserveseatnum = fixedreserveseatnum;
	}
	public Integer getHighdistance() {
		return highdistance;
	}
	public void setHighdistance(Integer highdistance) {
		this.highdistance = highdistance;
	}
	public boolean getIscanmixcheck() {
		return iscanmixcheck;
	}
	public void setIscanmixcheck(boolean iscanmixcheck) {
		this.iscanmixcheck = iscanmixcheck;
	}
	public boolean getIslinework() {
		return islinework;
	}
	public void setIslinework(boolean islinework) {
		this.islinework = islinework;
	}
	public boolean getIsoriginator() {
		return isoriginator;
	}
	public void setIsoriginator(boolean isoriginator) {
		this.isoriginator = isoriginator;
	}
	public boolean getIsovertime() {
		return isovertime;
	}
	public void setIsovertime(boolean isovertime) {
		this.isovertime = isovertime;
	}
	public boolean getIsproprietary() {
		return isproprietary;
	}
	public void setIsproprietary(boolean isproprietary) {
		this.isproprietary = isproprietary;
	}
	public boolean getIssaleafterreport() {
		return issaleafterreport;
	}
	public void setIssaleafterreport(boolean issaleafterreport) {
		this.issaleafterreport = issaleafterreport;
	}
	public boolean getIssellable() {
		return issellable;
	}
	public void setIssellable(boolean issellable) {
		this.issellable = issellable;
	}
	public boolean getIssellreturnticket() {
		return issellreturnticket;
	}
	public void setIssellreturnticket(boolean issellreturnticket) {
		this.issellreturnticket = issellreturnticket;
	}
	public BigDecimal getRuntime() {
		return runtime;
	}
	public void setRuntime(BigDecimal runtime) {
		this.runtime = runtime;
	}
	public String getScheduletype() {
		return scheduletype;
	}
	public void setScheduletype(String scheduletype) {
		this.scheduletype = scheduletype;
	}
	public short getSoldeatnum() {
		return soldeatnum;
	}
	public void setSoldeatnum(short soldeatnum) {
		this.soldeatnum = soldeatnum;
	}
	public short getCarrychildnum() {
		return carrychildnum;
	}
	public void setCarrychildnum(short carrychildnum) {
		this.carrychildnum = carrychildnum;
	}
	public short getSpacinginterval() {
		return spacinginterval;
	}
	public void setSpacinginterval(short spacinginterval) {
		this.spacinginterval = spacinginterval;
	}
	public Long getStartstationid() {
		return startstationid;
	}
	public void setStartstationid(Long startstationid) {
		this.startstationid = startstationid;
	}
	public String getStarttime() {
		return starttime;
	}
	public void setStarttime(String starttime) {
		this.starttime = starttime;
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
	public String getWorktype() {
		return worktype;
	}
	public void setWorktype(String worktype) {
		this.worktype = worktype;
	}
	public String getWorkways() {
		return workways;
	}
	public void setWorkways(String workways) {
		this.workways = workways;
	}
	public String getSynccode() {
		return synccode;
	}
	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

	public String getOrgcode() {
		return orgcode;
	}
	public void setOrgcode(String orgcode) {
		this.orgcode = orgcode;
	}
	public String getSchedulecode() {
		return schedulecode;
	}
	public void setSchedulecode(String schedulecode) {
		this.schedulecode = schedulecode;
	}
	public String getStartstationname() {
		return startstationname;
	}
	public void setStartstationname(String startstationname) {
		this.startstationname = startstationname;
	}
	public String getEndstationname() {
		return endstationname;
	}
	public void setEndstationname(String endstationname) {
		this.endstationname = endstationname;
	}
	public List<SyncTicketprice> getTicketpricelist() {
		return ticketpricelist;
	}
	public void setTicketpricelist(List<SyncTicketprice> ticketpricelist) {
		this.ticketpricelist = ticketpricelist;
	}
	public List<SyncSchedulestatus> getSchedulestatuslist() {
		return schedulestatuslist;
	}
	public void setSchedulestatuslist(List<SyncSchedulestatus> schedulestatuslist) {
		this.schedulestatuslist = schedulestatuslist;
	}
	public List<SyncSchedulevehiclepeopleplan> getSchedulevehiclepeopleplanlist() {
		return schedulevehiclepeopleplanlist;
	}
	public void setSchedulevehiclepeopleplanlist(List<SyncSchedulevehiclepeopleplan> schedulevehiclepeopleplanlist) {
		this.schedulevehiclepeopleplanlist = schedulevehiclepeopleplanlist;
	}
	@Override
	public String toString() {
		return "SyncScheduleplan [id=" + id + ", orgid=" + orgid + ", departdate=" + departdate
				+ ", autocancelreserveseatnum=" + autocancelreserveseatnum + ", scheduleid=" + scheduleid
				+ ", schedulesynccode=" + schedulesynccode + ", seatnum=" + seatnum + ", unautocancelreserveseatnum="
				+ unautocancelreserveseatnum + ", createby=" + createby + ", createtime=" + createtime + ", distance="
				+ distance + ", districttype=" + districttype + ", endstationid=" + endstationid + ", endtime="
				+ endtime + ", remarks=" + remarks + ", fixedreserveseatnum=" + fixedreserveseatnum + ", highdistance="
				+ highdistance + ", iscanmixcheck=" + iscanmixcheck + ", islinework=" + islinework + ", isoriginator="
				+ isoriginator + ", isovertime=" + isovertime + ", isproprietary=" + isproprietary
				+ ", issaleafterreport=" + issaleafterreport + ", issellable=" + issellable + ", issellreturnticket="
				+ issellreturnticket + ", runtime=" + runtime + ", scheduletype=" + scheduletype + ", soldeatnum="
				+ soldeatnum + ", carrychildnum=" + carrychildnum + ", spacinginterval=" + spacinginterval
				+ ", startstationid=" + startstationid + ", starttime=" + starttime + ", updateby=" + updateby
				+ ", updatetime=" + updatetime + ", worktype=" + worktype + ", workways=" + workways + ", synccode="
				+ synccode + ", flag=" + flag + ", orgcode=" + orgcode + ", schedulecode=" + schedulecode
				+ ", startstationname=" + startstationname + ", endstationname=" + endstationname + ", ticketpricelist="
				+ ticketpricelist + ", schedulestatuslist=" + schedulestatuslist + ", schedulevehiclepeopleplanlist="
				+ schedulevehiclepeopleplanlist + "]";
	}

	
}