package cn.nova.bus.base.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.utils.orm.listener.SyncCodeGenerate;

/**
 * The persistent class for the ROUTE database table.
 * 
 */
@Entity
@Table(name = "ROUTE")
@EntityListeners({ SyncCodeGenerate.class })
public class Route implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "ROUTE_ID_GENERATOR", sequenceName = "SEQ_ROUTE", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ROUTE_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;

	@Column(nullable = false, length = 30)
	private String code;

	@Column(nullable = false, precision = 10)
	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date createtime;

	@Column(nullable = false, length = 10)
	private String direction;

	@Column(nullable = false, precision = 5)
	private int distance;

	@Column(nullable = false, length = 10)
	private String districttype;

	@Column(nullable = false, precision = 10)
	private long endstationid;

	@Column(nullable = false, length = 10)
	private String grade;

	@Column(nullable = false, precision = 5)
	private int highdistance;

	@Column(nullable = false, precision = 1)
	private boolean isactive;

	@Column(nullable = false, precision = 1)
	private boolean isaudited;

	@Column(nullable = false, precision = 1)
	private boolean isauditpass;
	
	@Column(precision = 10)
	private Long printtemplateid;

	@Column(length = 10)
	private String jianpin;

	@Column(nullable = false, length = 60)
	private String name;

	@Column(nullable = false, precision = 10)
	private long orgid;

	@Column(length = 100)
	private String remarks;

	@Column(nullable = false, precision = 10)
	private long startstationid;

	@Column(nullable = false, length = 10)
	private String type;

	@Column(precision = 10, nullable = false)
	private Long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date updatetime;

	@Column(nullable = false)
	private boolean islocaldelete;
	
	private boolean isrealnameticket;
	@Column(nullable = false, length = 40)
	private String synccode;

	// bi-directional many-to-one association to Routestop
	@OneToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE }, fetch = FetchType.LAZY, mappedBy = "route")
	@OrderBy(value = "orderno ASC")
	private List<Routestop> routestops;

	@OneToMany(mappedBy = "route", fetch = FetchType.LAZY)
	private List<Schedule> schedules;
	
	public boolean isIsrealnameticket() {
		return isrealnameticket;
	}

	public void setIsrealnameticket(boolean isrealnameticket) {
		this.isrealnameticket = isrealnameticket;
	}

	// bi-directional many-to-one association to Routeroad
	@OneToMany(mappedBy = "route" , fetch = FetchType.LAZY)
	private List<Routeroad> routeroads;

	@Column(nullable = false, precision = 4)
	private short returntripvaliddays;
	
	//报班时间间隔，该线路在设置的时间间隔内部允许报班，0：不限制，单位：小时
	@Column(nullable = true, precision = 4)
	private short reportinterval;  
	
	public List<Schedule> getSchedules() {
		return schedules;
	}

	public void setSchedules(List<Schedule> schedules) {
		this.schedules = schedules;
	}

	public Route() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
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

	public String getDirection() {
		return this.direction;
	}

	public void setDirection(String direction) {
		this.direction = direction;
	}

	public int getDistance() {
		return this.distance;
	}

	public void setDistance(int distance) {
		this.distance = distance;
	}

	public String getDistricttype() {
		return this.districttype;
	}

	public void setDistricttype(String districttype) {
		this.districttype = districttype;
	}

	public long getEndstationid() {
		return this.endstationid;
	}

	public void setEndstationid(long endstationid) {
		this.endstationid = endstationid;
	}

	public String getGrade() {
		return this.grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public int getHighdistance() {
		return this.highdistance;
	}

	public void setHighdistance(int highdistance) {
		this.highdistance = highdistance;
	}

	public boolean getIsactive() {
		return this.isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public boolean getIsaudited() {
		return this.isaudited;
	}

	public void setIsaudited(boolean isaudited) {
		this.isaudited = isaudited;
	}

	public boolean getIsauditpass() {
		return this.isauditpass;
	}

	public void setIsauditpass(boolean isauditpass) {
		this.isauditpass = isauditpass;
	}

	public String getJianpin() {
		return this.jianpin;
	}

	public void setJianpin(String jianpin) {
		this.jianpin = jianpin;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public long getStartstationid() {
		return this.startstationid;
	}

	public void setStartstationid(long startstationid) {
		this.startstationid = startstationid;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public List<Routestop> getRoutestops() {
		return this.routestops;
	}

	public void setRoutestops(List<Routestop> routestops) {
		this.routestops = routestops;
	}

	public void setRouteroads(List<Routeroad> routeroads) {
		this.routeroads = routeroads;
	}

	public List<Routeroad> getRouteroads() {
		return routeroads;
	}

	public boolean isIslocaldelete() {
		return islocaldelete;
	}

	public String getSynccode() {
		return synccode;
	}

	public void setIslocaldelete(boolean islocaldelete) {
		this.islocaldelete = islocaldelete;
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

	public short getReturntripvaliddays() {
		return returntripvaliddays;
	}

	public void setReturntripvaliddays(short returntripvaliddays) {
		this.returntripvaliddays = returntripvaliddays;
	}

	public short getReportinterval() {
		return reportinterval;
	}

	public void setReportinterval(short reportinterval) {
		this.reportinterval = reportinterval;
	}

	public Long getPrinttemplateid() {
		return printtemplateid;
	}

	public void setPrinttemplateid(Long printtemplateid) {
		this.printtemplateid = printtemplateid;
	}

	
	
}