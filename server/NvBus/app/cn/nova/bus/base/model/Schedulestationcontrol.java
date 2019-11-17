package cn.nova.bus.base.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import cn.nova.utils.orm.listener.AuditLogListener;
import cn.nova.utils.orm.listener.SyncCodeGenerate;

/**
 * 班次站点售票控制 The persistent class for the SCHEDULESTATIONCONTROL database table.
 * 
 */
@Entity
@EntityListeners({ SyncCodeGenerate.class, AuditLogListener.class })
public class Schedulestationcontrol implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "SCHEDULESTATIONCONTROL_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SCHEDULESTATIONCONTROL_ID_GENERATOR")
	@Column(nullable = false, unique = true)
	private long id;

	@Column(nullable = false)
	private int cansellnum;

	@Column(nullable = false)
	private int canselltime;

	@Column(nullable = false)
	private long createby;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	@Column(nullable = false)
	private long departorgid;

	@Column(nullable = false)
	private long routeid;

	@Column(nullable = false)
	private long stationid;

	@Column(nullable = false)
	private long updateby;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	@Transient
	private boolean isselect;

	@Transient
	private String stationname;

	@Transient
	private String opertype;

	public String getOpertype() {
		return opertype;
	}

	public void setOpertype(String opertype) {
		this.opertype = opertype;
	}

	public Schedulestationcontrol() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public int getCansellnum() {
		return this.cansellnum;
	}

	public void setCansellnum(int cansellnum) {
		this.cansellnum = cansellnum;
	}

	public int getCanselltime() {
		return this.canselltime;
	}

	public void setCanselltime(int canselltime) {
		this.canselltime = canselltime;
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

	public long getDepartorgid() {
		return this.departorgid;
	}

	public void setDepartorgid(long departorgid) {
		this.departorgid = departorgid;
	}

	public long getRouteid() {
		return this.routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}

	public long getStationid() {
		return this.stationid;
	}

	public void setStationid(long stationid) {
		this.stationid = stationid;
	}

	public long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public boolean isIsselect() {
		return isselect;
	}

	public void setIsselect(boolean isselect) {
		this.isselect = isselect;
	}

	public String getStationname() {
		return stationname;
	}

	public void setStationname(String stationname) {
		this.stationname = stationname;
	}

}