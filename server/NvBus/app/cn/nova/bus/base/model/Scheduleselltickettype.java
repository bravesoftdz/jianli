package cn.nova.bus.base.model;

import java.io.Serializable;
import java.math.BigDecimal;
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
@Table(name = "SCHEDULESELLTICKETTYPE")
@EntityListeners(value = { SyncCodeGenerate.class })
public class Scheduleselltickettype implements Serializable {

	private static final long serialVersionUID = 1L;
	@Id
	@SequenceGenerator(name = "SCHEDULESELLTICKETTYPE_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SCHEDULESELLTICKETTYPE_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;
	private long createby;
	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date createtime;
	private long tickettypeid;
	private long orgid;
	private String type;
	private long typeid;
	private long updateby;
	private String remarks;
	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date updatetime;

	@Column(nullable = false, length = 40)
	private String synccode;

	private String canselltype;

	@Column(nullable = false, precision = 4, scale = 2)
	private BigDecimal cansellvalue;

	public Scheduleselltickettype() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
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

	@Column(nullable = false, length = 10)
	public long getTickettypeid() {
		return this.tickettypeid;
	}

	public void setTickettypeid(long tickettypeid) {
		this.tickettypeid = tickettypeid;
	}

	@Column(nullable = false, precision = 10)
	public long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(long orgid) {
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
	public long getTypeid() {
		return this.typeid;
	}

	public void setTypeid(long typeid) {
		this.typeid = typeid;
	}

	@Column(precision = 10)
	public long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(long updateby) {
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

	public String getCanselltype() {
		return canselltype;
	}

	public void setCanselltype(String canselltype) {
		this.canselltype = canselltype;
	}

	public BigDecimal getCansellvalue() {
		return cansellvalue;
	}

	public void setCansellvalue(BigDecimal cansellvalue) {
		this.cansellvalue = cansellvalue;
	}

}
