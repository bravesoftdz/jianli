package cn.nova.bus.base.model;

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
 * The persistent class for the TICKETTYPEPERMISSION database table.
 * 车票类型可售权限控制(售票员/角色/售票点/机构)
 */
@Entity
public class Tickettypepermission implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "TICKETTYPEPERMISSION_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "TICKETTYPEPERMISSION_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;

	private Long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private long tickettypeid;

	private String type;

	private long typeid;

	private Long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	public Tickettypepermission() {
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

	public long getTickettypeid() {
		return tickettypeid;
	}

	public void setTickettypeid(long tickettypeid) {
		this.tickettypeid = tickettypeid;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public long getTypeid() {
		return typeid;
	}

	public void setTypeid(long typeid) {
		this.typeid = typeid;
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

}