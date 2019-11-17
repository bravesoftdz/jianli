package cn.nova.bus.dispatch.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * The persistent class for the SCHEDULEMERGE database table.
 * 班次并班
 */
@Entity
public class Schedulemerge implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@SequenceGenerator(name = "SCHEDULEMERGE_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SCHEDULEMERGE_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	private long id;
	
	private Long createby;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;
	
	@Temporal(TemporalType.DATE)
	private Date departdate;
	
	private boolean iscancel;
	
	private boolean isactive;
	
	private Long newscheduleid;
	
	private Long oldscheduleid;
	
	private Long oldscheduleplanid;
	
	private Long orgid;
	
	private String reason;
	
	private Long scheduleplanid;
	
	private Long userid;

	private String oldseats;
	
	private String newseats;
	
	public String getOldseats() {
		return oldseats;
	}

	public void setOldseats(String oldseats) {
		this.oldseats = oldseats;
	}

	public String getNewseats() {
		return newseats;
	}

	public void setNewseats(String newseats) {
		this.newseats = newseats;
	}

	public Schedulemerge() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
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

	public boolean isIscancel() {
		return iscancel;
	}

	public void setIscancel(boolean iscancel) {
		this.iscancel = iscancel;
	}

	public Long getNewscheduleid() {
		return newscheduleid;
	}

	public void setNewscheduleid(Long newscheduleid) {
		this.newscheduleid = newscheduleid;
	}

	public Long getOldscheduleid() {
		return oldscheduleid;
	}

	public void setOldscheduleid(Long oldscheduleid) {
		this.oldscheduleid = oldscheduleid;
	}

	public Long getOldscheduleplanid() {
		return oldscheduleplanid;
	}

	public void setOldscheduleplanid(Long oldscheduleplanid) {
		this.oldscheduleplanid = oldscheduleplanid;
	}

	public Long getOrgid() {
		return orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public Long getScheduleplanid() {
		return scheduleplanid;
	}

	public void setScheduleplanid(Long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	public Long getUserid() {
		return userid;
	}

	public void setUserid(Long userid) {
		this.userid = userid;
	}

	public boolean isIsactive() {
		return isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}
	

}