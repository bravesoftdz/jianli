package cn.nova.bus.dispatch.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * The persistent class for the SCHEDULEMERGECANCEL database table. 
 * 并班取消记录
 */
@Entity
public class Schedulemergecancel implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long schedulemergeid;

	private Long canceluserid;

	private Long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private String reason;

	public Schedulemergecancel() {
	}

	public long getSchedulemergeid() {
		return this.schedulemergeid;
	}

	public void setSchedulemergeid(long schedulemergeid) {
		this.schedulemergeid = schedulemergeid;
	}

	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getReason() {
		return this.reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public Long getCanceluserid() {
		return canceluserid;
	}

	public void setCanceluserid(Long canceluserid) {
		this.canceluserid = canceluserid;
	}

	public Long getCreateby() {
		return createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

}