package cn.nova.bus.base.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import cn.nova.utils.orm.listener.SyncCodeGenerate;

@Entity
@Table(name = "VEHICLESEATPLANDETAIL")
@EntityListeners(SyncCodeGenerate.class)
public class Vehicleseatplandetail implements Serializable {
	private static final long serialVersionUID = -4685005456364615352L;

	// 该字段作为记录的操作类型字段
	@Transient
	private String opertype;

	@Id
	@SequenceGenerator(name = "VEHICLESEATPLANDETAIL_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "VEHICLESEATPLANDETAIL_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;

	@Column(nullable = false, precision = 2)
	private byte colno;

	@Column(nullable = false, precision = 10)
	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date createtime;

	@Column(nullable = false, precision = 3)
	private short height;

	@Column(length = 100)
	private String remarks;

	@Column(nullable = false, precision = 2)
	private byte rowno;

	@Column(precision = 3)
	private short seatno;

	@Column(precision = 10)
	private Long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	@Column(nullable = false, precision = 10)
	private long vehiclespaceid;

	@Column(nullable = false, precision = 3)
	private short width;

	@Column(nullable = false, length = 40)
	private String synccode;

	// bi-directional many-to-one association to Vehicleseatplan
	@ManyToOne
	@JoinColumn(name = "VEHICLEBRANDMODELID", nullable = false)
	private Vehicleseatplan vehicleseatplan;

	public Vehicleseatplandetail() {
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

	public byte getColno() {
		return this.colno;
	}

	public void setColno(byte colno) {
		this.colno = colno;
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

	public short getHeight() {
		return this.height;
	}

	public void setHeight(short height) {
		this.height = height;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public byte getRowno() {
		return this.rowno;
	}

	public void setRowno(byte rowno) {
		this.rowno = rowno;
	}

	public short getSeatno() {
		return this.seatno;
	}

	public void setSeatno(short seatno) {
		this.seatno = seatno;
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

	public short getWidth() {
		return this.width;
	}

	public void setWidth(short width) {
		this.width = width;
	}

	public Vehicleseatplan getVehicleseatplan() {
		return this.vehicleseatplan;
	}

	public void setVehicleseatplan(Vehicleseatplan vehicleseatplan) {
		this.vehicleseatplan = vehicleseatplan;
	}

	public void setOpertype(String opertype) {
		this.opertype = opertype;
	}

	public String getOpertype() {
		return opertype;
	}

}