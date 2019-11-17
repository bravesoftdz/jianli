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

import cn.nova.bus.system.model.Organization;
import cn.nova.utils.orm.listener.AuditLogListener;
import cn.nova.utils.orm.listener.SyncCodeGenerate;

/**
 * The persistent class for the DISTRICT database table. 行政区域
 */
@Entity
@EntityListeners({ SyncCodeGenerate.class, AuditLogListener.class })
public class District implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "DISTRICT_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "DISTRICT_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	private long id;

	@Column(nullable = false)
	private String code;

	@Column(nullable = false)
	private String country;

	@Column(nullable = false)
	private Long createby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date createtime;

	private String fullname;

	@Column(nullable = false)
	private boolean isactive;

	@Column(nullable = false)
	private boolean islocaldelete;

	private String jianpin;

	@Column(nullable = false)
	private String name;

	@Column(nullable = false)
	private Long orgid;

	@Column(nullable = false)
	private Long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date updatetime;

	@Column(nullable = false, length = 30)
	private String synccode;

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

	public String getSynccode() {
		return synccode;
	}

	public District() {
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

	public String getCountry() {
		return this.country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public Long getCreateby() {
		return this.createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getFullname() {
		return this.fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public boolean getIsactive() {
		return this.isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public boolean getIslocaldelete() {
		return this.islocaldelete;
	}

	public void setIslocaldelete(boolean islocaldelete) {
		this.islocaldelete = islocaldelete;
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

	public Long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
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

}