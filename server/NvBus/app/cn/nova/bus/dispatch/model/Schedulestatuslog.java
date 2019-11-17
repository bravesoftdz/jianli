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
 * The persistent class for the SCHEDULESTATUSLOG database table.
 * 
 */
@Entity
public class Schedulestatuslog implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "SCHEDULESTATUSLOG_ID_GENERATOR", sequenceName = "SEQ_VEHICLEREPORT",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SCHEDULESTATUSLOG_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	private long id;

	private String afterstatus;

	private String beforestatus;

	private Long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	@Temporal(TemporalType.DATE)
	private Date departdate;

	private String operationtype;

	private Long orgid;

	private String reason;

	private Long scheduleid;

	public Schedulestatuslog() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getAfterstatus() {
		return this.afterstatus;
	}

	public void setAfterstatus(String afterstatus) {
		this.afterstatus = afterstatus;
	}

	public String getBeforestatus() {
		return this.beforestatus;
	}

	public void setBeforestatus(String beforestatus) {
		this.beforestatus = beforestatus;
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

	public String getOperationtype() {
		return operationtype;
	}

	public void setOperationtype(String operationtype) {
		this.operationtype = operationtype;
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

	public Long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(Long scheduleid) {
		this.scheduleid = scheduleid;
	}

}