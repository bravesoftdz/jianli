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
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.utils.orm.listener.SyncCodeGenerate;

/**
 * The persistent class for the SCHEDULEPERSELLDAYS database table.
 * 
 */

@Entity
@Table(name = "SCHEDULEPERSELLDAYS")
@EntityListeners(value = { SyncCodeGenerate.class })
public class Scheduleperselldays implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7084648987619849443L;
	@Id
	@SequenceGenerator(name = "SCHEDULEPERSELLDAYS_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SCHEDULEPERSELLDAYS_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private Long id;
	private Long createby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date createtime;
	private Long perserlldays;
	private Long orgid;
	private String type;
	private Long typeid;
	private Long updateby;
	private String remarks;
	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date updatetime;

	@Column(nullable = false, length = 40)
	private String synccode;

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
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

	@Column(nullable = false, length = 10)
	public Long getPerserlldays() {
		return this.perserlldays;
	}

	public void setPerserlldays(Long perserlldays) {
		this.perserlldays = perserlldays;
	}

	@Column(nullable = false, precision = 10)
	public Long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	@Column(nullable = false, precision = 10)
	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Column(nullable = false, precision = 10)
	public Long getTypeid() {
		return this.typeid;
	}

	public void setTypeid(Long typeid) {
		this.typeid = typeid;
	}

	@Column(precision = 10)
	public Long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

	@Temporal(TemporalType.DATE)
	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	@Column(precision = 100)
	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getSynccode() {
		return synccode;
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}
}