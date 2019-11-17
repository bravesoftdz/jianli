package cn.nova.bus.price.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import cn.nova.utils.orm.listener.RemoveListenerForSync;
import cn.nova.utils.orm.listener.SyncCodeGenerate;

@Entity
@EntityListeners(value = { SyncCodeGenerate.class,RemoveListenerForSync.class })
public class Schedulestatus implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "SCHEDULESTATUS_ID_GENERATOR", sequenceName = "SEQ_SCHEDULESTATUS", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SCHEDULESTATUS_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	private long id;

	private String buspark;

	@Column(nullable = false)
	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date createtime;

	@Temporal(TemporalType.DATE)
	@Column(nullable = false)
	private Date departdate;

	@Column(nullable = false)
	private long departstationid;

	@Column(nullable = false)
	private String departtime;

	@Column(nullable = false)
	private boolean isbegincheck;

	@Column(nullable = false)
	private boolean isdeparted;

	@Column(nullable = false)
	private boolean isreported;

	@Column(nullable = false)
	private boolean isemptyvehicle;

	@Column(nullable = false)
	private long orgid;

	@Column(nullable = false)
	private long scheduleid;

	@Column(nullable = false)
	private String status;

	@Column(nullable = false)
	private String ticketentrance;

	@Column(nullable = false)
	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date updatetime;

	@JoinColumn(name = "SCHEDULEPLANID", nullable = false)
	@ManyToOne(cascade = { CascadeType.REFRESH, CascadeType.PERSIST })
	private Scheduleplan scheduleplan;

	@Column(nullable = false, length = 40)
	private String synccode;

	@Transient
	private String code;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getStationname() {
		return stationname;
	}

	public void setStationname(String stationname) {
		this.stationname = stationname;
	}

	public String getOpertype() {
		return opertype;
	}

	public void setOpertype(String opertype) {
		this.opertype = opertype;
	}

	@Transient
	private String stationname;
	@Transient
	private String opertype;

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

	public String getSynccode() {
		return synccode;
	}

	public Schedulestatus() {
	}

	public boolean getIsemptyvehicle() {
		return isemptyvehicle;
	}

	public void setIsemptyvehicle(boolean isemptyvehicle) {
		this.isemptyvehicle = isemptyvehicle;
	}

	public Scheduleplan getScheduleplan() {
		return scheduleplan;
	}

	public void setScheduleplan(Scheduleplan scheduleplan) {
		this.scheduleplan = scheduleplan;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getBuspark() {
		return buspark;
	}

	public void setBuspark(String buspark) {
		this.buspark = buspark;
	}

	public long getCreateby() {
		return createby;
	}

	public void setCreateby(long createby) {
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

	public long getDepartstationid() {
		return departstationid;
	}

	public void setDepartstationid(long departstationid) {
		this.departstationid = departstationid;
	}

	public String getDeparttime() {
		return departtime;
	}

	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}

	public boolean getIsbegincheck() {
		return isbegincheck;
	}

	public void setIsbegincheck(boolean isbegincheck) {
		this.isbegincheck = isbegincheck;
	}

	public boolean getIsdeparted() {
		return isdeparted;
	}

	public void setIsdeparted(boolean isdeparted) {
		this.isdeparted = isdeparted;
	}

	public boolean getIsreported() {
		return isreported;
	}

	public void setIsreported(boolean isreported) {
		this.isreported = isreported;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getTicketentrance() {
		return ticketentrance;
	}

	public void setTicketentrance(String ticketentrance) {
		this.ticketentrance = ticketentrance;
	}

	public long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

}