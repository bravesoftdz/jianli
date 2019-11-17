package cn.nova.bus.checkticket.model;

import java.io.Serializable;
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

import play.data.binding.As;

@Entity
@Table(name = "OUTSTATIONCHECK")
public class Outstationcheck implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "OUTSTATIONCHECKID_GENERATOR", sequenceName = "SEQ_SECURITYCHECK", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "OUTSTATIONCHECKID_GENERATOR")
	@Column(nullable = false, unique = true)
	private long id;

	private Long scheduleplanid;

	@Temporal(TemporalType.DATE)
	private Date departdate;

	private long scheduleid;

	private String departtime;

	private long vehicleid;

	@Temporal(TemporalType.TIMESTAMP)
	private Date reporttime;

	@Temporal(TemporalType.TIMESTAMP)
	private Date outtime;
	private long seatnums;
	private long carrypeople;
	private long factpeople;
	private long fillpeople;
	private String runnochk;
	private String driverlicensechk;
	private String buscheckchk;
	private String maintainchk;
	private String roadnochk;
	private String driver1;
	private String drivinglicense1chk;
	private String qualification1chk;
	private String workno1chk;
	private String driver2;
	private String drivinglicense2chk;
	private String qualification2chk;
	private String workno2chk;
	private long checker;
	private String remark;
	private long orgid;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;
	private long createby;
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;
	private long updateby;
	
	private Boolean iscomplete; //证件是否齐全
	private Boolean isseatbelts; //是否系好安全带
	private Boolean isoverload; //是否超员
	private Long childnum; //免票儿童数
	private String steward1; //乘务员

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getScheduleplanid() {
		return scheduleplanid;
	}

	public void setScheduleplanid(long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public String getDeparttime() {
		return departtime;
	}

	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}

	public long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public Date getReporttime() {
		return reporttime;
	}

	@As("yyyy-MM-dd hh:mm:ss")
	public void setReporttime(Date reporttime) {
		this.reporttime = reporttime;
	}

	public Date getOuttime() {
		return outtime;
	}
	@As("yyyy-MM-dd hh:mm:ss")
	public void setOuttime(Date outtime) {
		this.outtime = outtime;
	}

	public long getSeatnums() {
		return seatnums;
	}

	public void setSeatnums(long seatnums) {
		this.seatnums = seatnums;
	}

	public long getCarrypeople() {
		return carrypeople;
	}

	public void setCarrypeople(long carrypeople) {
		this.carrypeople = carrypeople;
	}

	public long getFactpeople() {
		return factpeople;
	}

	public void setFactpeople(long factpeople) {
		this.factpeople = factpeople;
	}

	public long getFillpeople() {
		return fillpeople;
	}

	public void setFillpeople(long fillpeople) {
		this.fillpeople = fillpeople;
	}

	public String getRunnochk() {
		return runnochk;
	}

	public void setRunnochk(String runnochk) {
		this.runnochk = runnochk;
	}

	public String getDriverlicensechk() {
		return driverlicensechk;
	}

	public void setDriverlicensechk(String driverlicensechk) {
		this.driverlicensechk = driverlicensechk;
	}

	public String getBuscheckchk() {
		return buscheckchk;
	}

	public void setBuscheckchk(String buscheckchk) {
		this.buscheckchk = buscheckchk;
	}

	public String getMaintainchk() {
		return maintainchk;
	}

	public void setMaintainchk(String maintainchk) {
		this.maintainchk = maintainchk;
	}

	public String getRoadnochk() {
		return roadnochk;
	}

	public void setRoadnochk(String roadnochk) {
		this.roadnochk = roadnochk;
	}

	public String getDriver1() {
		return driver1;
	}

	public void setDriver1(String driver1) {
		this.driver1 = driver1;
	}

	public String getDrivinglicense1chk() {
		return drivinglicense1chk;
	}

	public void setDrivinglicense1chk(String drivinglicense1chk) {
		this.drivinglicense1chk = drivinglicense1chk;
	}

	public String getQualification1chk() {
		return qualification1chk;
	}

	public void setQualification1chk(String qualification1chk) {
		this.qualification1chk = qualification1chk;
	}

	public String getWorkno1chk() {
		return workno1chk;
	}

	public void setWorkno1chk(String workno1chk) {
		this.workno1chk = workno1chk;
	}

	public String getDriver2() {
		return driver2;
	}

	public void setDriver2(String driver2) {
		this.driver2 = driver2;
	}

	public String getDrivinglicense2chk() {
		return drivinglicense2chk;
	}

	public void setDrivinglicense2chk(String drivinglicense2chk) {
		this.drivinglicense2chk = drivinglicense2chk;
	}

	public String getQualification2chk() {
		return qualification2chk;
	}

	public void setQualification2chk(String qualification2chk) {
		this.qualification2chk = qualification2chk;
	}

	public String getWorkno2chk() {
		return workno2chk;
	}

	public void setWorkno2chk(String workno2chk) {
		this.workno2chk = workno2chk;
	}

	public long getChecker() {
		return checker;
	}

	public void setChecker(long checker) {
		this.checker = checker;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public long getCreateby() {
		return createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public Boolean getIscomplete() {
		return iscomplete;
	}

	public void setIscomplete(Boolean iscomplete) {
		this.iscomplete = iscomplete;
	}

	public Boolean getIsseatbelts() {
		return isseatbelts;
	}

	public void setIsseatbelts(Boolean isseatbelts) {
		this.isseatbelts = isseatbelts;
	}

	public Boolean getIsoverload() {
		return isoverload;
	}

	public void setIsoverload(Boolean isoverload) {
		this.isoverload = isoverload;
	}

	public Long getChildnum() {
		return childnum;
	}

	public void setChildnum(Long childnum) {
		this.childnum = childnum;
	}

	public String getSteward1() {
		return steward1;
	}

	public void setSteward1(String steward1) {
		this.steward1 = steward1;
	}

	public void setScheduleplanid(Long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}
	
}