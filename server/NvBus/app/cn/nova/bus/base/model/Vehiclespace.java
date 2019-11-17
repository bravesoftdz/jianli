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
@Table(name = "VEHICLESPACE")
@EntityListeners(SyncCodeGenerate.class)
public class Vehiclespace implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "VEHICLESPACE_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "VEHICLESPACE_ID_GENERATOR")
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
	private boolean ispassengerseat;

	@Column(nullable = false, precision = 1)
	private boolean islocaldelete;

	@Column(nullable = false, length = 20)
	private String name;

	@Lob()
	private byte[] picture;

	@Column(nullable = false, precision = 10)
	private Long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date updatetime;

	@Column(nullable = false, precision = 10)
	private long orgid;

	@Column(length = 10)
	private String seattype;

	@Column(nullable = false, length = 40)
	private String synccode;

	public Vehiclespace() {
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

	public String getSynccode() {
		return synccode;
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

	public boolean getIsactive() {
		return this.isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public boolean getIspassengerseat() {
		return this.ispassengerseat;
	}

	public void setIspassengerseat(boolean ispassengerseat) {
		this.ispassengerseat = ispassengerseat;
	}

	public boolean getIslocaldelete() {
		return this.islocaldelete;
	}

	public void setIslocaldelete(boolean islocaldelete) {
		this.islocaldelete = islocaldelete;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public byte[] getPicture() {
		return this.picture;
	}

	public void setPicture(byte[] picture) {
		this.picture = picture;
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

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setSeattype(String seattype) {
		this.seattype = seattype;
	}

	public String getSeattype() {
		return seattype;
	}

}