package cn.nova.bus.dispatch.model;

import java.io.Serializable;
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
@Table(name = "SCHEDULESTATUS")
public class SyncSchedulestatus implements Serializable {
	
	private static final Long serialVersionUID = 116549815646L;

	@Id
	@SequenceGenerator(name = "SCHEDULESTATUS_ID_GENERATOR", sequenceName = "SEQ_SCHEDULESTATUS", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SCHEDULESTATUS_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	private Long id;
	/*上车卡位*/
	private String buspark;
	/**/
	private Long createby;
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;
	/*发车日期*/
	@Temporal(TemporalType.DATE)
	private Date departdate;
	/*发车站点id*/
	private Long departstationid;
	/*发车时间*/
	private String departtime;
	/*是否开始检票*/
	private boolean isbegincheck;
	/*是否已发班*/
	private boolean isdeparted;
	/*是否已报到*/
	private boolean isreported;
	/*是否放空*/
	private boolean isemptyvehicle;
	/**/
	private Long orgid;
	/*班次id*/
	private Long scheduleid;
	@Transient
	public String schedulesynccode;
	/*班次运行计划ID*/
	private Long scheduleplanid;
	/*班次状态（正常、报停、晚点、被并、脱班、停售）取数据字典*/
	private String status;
	/*检票口*/
	private String ticketentrance;
	/**/
	private Long updateby;
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;
	/*全局同步编码*/
	private String synccode;
	
	@Transient
	private Integer flag;
	@Transient
	private String schedulecode;
	@Transient
	private String scheduleorgname;
	@Transient
	public String scheduleorgcode;
	@Transient
	private String orgname;
	@Transient
	public String orgcode;
	@Transient
	private String departstationname;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getBuspark() {
		return buspark;
	}
	public void setBuspark(String buspark) {
		this.buspark = buspark;
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
	public boolean getIsemptyvehicle() {
		return isemptyvehicle;
	}
	public void setIsemptyvehicle(boolean isemptyvehicle) {
		this.isemptyvehicle = isemptyvehicle;
	}
	public Long getOrgid() {
		return orgid;
	}
	public void setOrgid(Long orgid) {
		this.orgid = orgid;
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
	public String getSynccode() {
		return synccode;
	}
	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}
	public Integer getFlag() {
		return flag;
	}
	public void setFlag(Integer flag) {
		this.flag = flag;
	}
	public String getSchedulecode() {
		return schedulecode;
	}
	public void setSchedulecode(String schedulecode) {
		this.schedulecode = schedulecode;
	}
	
	public String getScheduleorgname() {
		return scheduleorgname;
	}
	public void setScheduleorgname(String scheduleorgname) {
		this.scheduleorgname = scheduleorgname;
	}
	public String getOrgname() {
		return orgname;
	}
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}
	public String getDepartstationname() {
		return departstationname;
	}
	public void setDepartstationname(String departstationname) {
		this.departstationname = departstationname;
	}
	@Override
	public String toString() {
		return "SyncSchedulestatus [id=" + id + ", buspark=" + buspark + ", createby=" + createby + ", createtime="
				+ createtime + ", departdate=" + departdate + ", departstationid=" + departstationid + ", departtime="
				+ departtime + ", isbegincheck=" + isbegincheck + ", isdeparted=" + isdeparted + ", isreported="
				+ isreported + ", isemptyvehicle=" + isemptyvehicle + ", orgid=" + orgid + ", scheduleid=" + scheduleid
				+ ", schedulesynccode=" + schedulesynccode + ", scheduleplanid=" + scheduleplanid + ", status=" + status
				+ ", ticketentrance=" + ticketentrance + ", updateby=" + updateby + ", updatetime=" + updatetime
				+ ", synccode=" + synccode + ", flag=" + flag + ", schedulecode=" + schedulecode + ", scheduleorgname="
				+ scheduleorgname + ", scheduleorgcode=" + scheduleorgcode + ", orgname=" + orgname + ", orgcode="
				+ orgcode + ", departstationname=" + departstationname + "]";
	}
	
}
