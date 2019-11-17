package cn.nova.bus.base.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.utils.orm.listener.SyncCodeGenerate;

@Entity
@Table(name = "VEHICLESPACESOLDPICTURE")
@EntityListeners(SyncCodeGenerate.class)
public class Vehiclespacesoldpicture implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "VEHICLESPACESOLDPICTURE_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "VEHICLESPACESOLDPICTURE_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;

	@Column(nullable = false, precision = 10)
	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date createtime;

	@Column(nullable = false, precision = 1)
	private boolean isactive;

	@Column(nullable = false, precision = 1)
	private boolean islocaldelete;

	@Lob()
	@Column(nullable = false)
	private byte[] soldpicture;

	@Column(nullable = false, precision = 10)
	private long ticktypeid;

	@Column(nullable = false, precision = 10)
	private Long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date updatetime;

	@Column(nullable = false, precision = 10)
	private long vehiclespaceid;

	@Column(nullable = false, length = 40)
	private String synccode;

	public Vehiclespacesoldpicture() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

	public String getSynccode() {
		return synccode;
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

	public byte[] getSoldpicture() {
		return this.soldpicture;
	}

	public void setSoldpicture(byte[] soldpicture) {
		this.soldpicture = soldpicture;
	}

	public long getTicktypeid() {
		return this.ticktypeid;
	}

	public void setTicktypeid(long ticktypeid) {
		this.ticktypeid = ticktypeid;
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

	public long getVehiclespaceid() {
		return this.vehiclespaceid;
	}

	public void setVehiclespaceid(long vehiclespaceid) {
		this.vehiclespaceid = vehiclespaceid;
	}

}