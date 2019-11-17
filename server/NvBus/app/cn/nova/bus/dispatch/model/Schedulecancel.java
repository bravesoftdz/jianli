package cn.nova.bus.dispatch.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * 4.班次停班时，增加“通知网售旅客停班信息”、“网售票退票时全额退款款”、“停班原因”和“备注”信息，请查看参考页面图2。（20171212,
 * 关于雪天停运问题内部讨论）
 * 
 * @author Administrator
 */
@Entity
@Table(name = "SCHEDULECANCEL")
public class Schedulecancel implements Serializable {

	@Id
	@SequenceGenerator(name = "SCHEDULECANCEL_ID_GENERATOR", sequenceName = "SEQ_VEHICLEREPORT", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SCHEDULECANCEL_ID_GENERATOR")
	private long id;

	private long schedulestatusid;// 班次状态ID
	private long departstationid;// 发车站ID
	@Temporal(TemporalType.DATE)
	private Date departdate;// 发车日期
	private long scheduleid;// 班次ID
	private boolean returnallpriceflag;// 是否全额退款：0：不全额退，1：全额退款
	private String reason;// 原因
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;
	private long createby;
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;
	private long updateby;

	private String remarks;
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getSchedulestatusid() {
		return schedulestatusid;
	}

	public void setSchedulestatusid(long schedulestatusid) {
		this.schedulestatusid = schedulestatusid;
	}

	public long getDepartstationid() {
		return departstationid;
	}

	public void setDepartstationid(long departstationid) {
		this.departstationid = departstationid;
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

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public boolean getReturnallpriceflag() {
		return returnallpriceflag;
	}

	public void setReturnallpriceflag(boolean returnallpriceflag) {
		this.returnallpriceflag = returnallpriceflag;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
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

}
