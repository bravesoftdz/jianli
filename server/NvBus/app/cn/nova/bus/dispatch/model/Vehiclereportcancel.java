package cn.nova.bus.dispatch.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * The persistent class for the VEHICLEREPORTCANCEL database table.
 * 
 */
@Entity
public class Vehiclereportcancel implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique = true, nullable = false)
	private long reportid;

	private long createby;

	public long getReportid() {
		return reportid;
	}

	public void setReportid(long reportid) {
		this.reportid = reportid;
	}

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private String reason;

	private long reportcancelby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date reportcanceltime;

	public Vehiclereportcancel() {
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

	public String getReason() {
		return this.reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public long getReportcancelby() {
		return this.reportcancelby;
	}

	public void setReportcancelby(long reportcancelby) {
		this.reportcancelby = reportcancelby;
	}

	public Date getReportcanceltime() {
		return this.reportcanceltime;
	}

	public void setReportcanceltime(Date reportcanceltime) {
		this.reportcanceltime = reportcanceltime;
	}

}