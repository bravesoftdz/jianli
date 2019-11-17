package cn.nova.bus.base.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.utils.orm.listener.SyncCodeGenerate;

@Entity
@Table(name = "VEHICLESEATPLAN")
@EntityListeners(SyncCodeGenerate.class)
public class Vehicleseatplan implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique = true, nullable = false, precision = 10)
	private long vehiclebrandmodelid;

	@Column(nullable = false, precision = 10)
	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date createtime;

	@Column(nullable = false, precision = 1)
	private boolean isactive;

	@Column(nullable = false, precision = 1)
	private boolean islocaldelete;

	@Column(precision = 10)
	private Long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	@Column(nullable = false, length = 40)
	private String synccode;

	// bi-directional many-to-one association to Vehicleseatplandetail
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "vehicleseatplan")
	private List<Vehicleseatplandetail> vehicleseatplandetails;

	public Vehicleseatplan() {
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

	public String getSynccode() {
		return synccode;
	}

	public long getVehiclebrandmodelid() {
		return this.vehiclebrandmodelid;
	}

	public void setVehiclebrandmodelid(long vehiclebrandmodelid) {
		this.vehiclebrandmodelid = vehiclebrandmodelid;
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

	public List<Vehicleseatplandetail> getVehicleseatplandetails() {
		return this.vehicleseatplandetails;
	}

	public void setVehicleseatplandetails(
			List<Vehicleseatplandetail> vehicleseatplandetails) {
		this.vehicleseatplandetails = vehicleseatplandetails;
	}

}