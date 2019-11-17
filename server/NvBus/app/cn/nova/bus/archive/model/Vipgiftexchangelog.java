package cn.nova.bus.archive.model;

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
 * The persistent class for the VIPGIFTEXCHANGELOG database table.
 * 
 */
@Entity
@Table(name = "VIPGIFTEXCHANGELOG")
@EntityListeners({ SyncCodeGenerate.class })
public class Vipgiftexchangelog implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4957163542694239140L;

	@Id
	@SequenceGenerator(name = "VIPGIFTEXCHANGELOG_ID_GENERATOR", sequenceName = "SEQ_PUB")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "VIPGIFTEXCHANGELOG_ID_GENERATOR")
	private long id;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private long quantity;

	private long remainstoragequantity;

	private BigDecimal remainvipamount;

	private String remarks;

	private BigDecimal vipamount;

	private long vipgiftid;

	@Column(nullable = false, precision = 10)
	private long vipid;

	@Column(nullable = false, length = 40)
	private String synccode;

	public Vipgiftexchangelog() {
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

	public long getQuantity() {
		return this.quantity;
	}

	public void setQuantity(long quantity) {
		this.quantity = quantity;
	}

	public long getRemainstoragequantity() {
		return this.remainstoragequantity;
	}

	public void setRemainstoragequantity(long remainstoragequantity) {
		this.remainstoragequantity = remainstoragequantity;
	}

	public BigDecimal getRemainvipamount() {
		return this.remainvipamount;
	}

	public void setRemainvipamount(BigDecimal remainvipamount) {
		this.remainvipamount = remainvipamount;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public BigDecimal getVipamount() {
		return this.vipamount;
	}

	public void setVipamount(BigDecimal vipamount) {
		this.vipamount = vipamount;
	}

	public long getVipgiftid() {
		return this.vipgiftid;
	}

	public void setVipgiftid(long vipgiftid) {
		this.vipgiftid = vipgiftid;
	}

	public long getVipid() {
		return this.vipid;
	}

	public void setVipid(long vipid) {
		this.vipid = vipid;
	}

	public String getSynccode() {
		return synccode;
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

	public long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

}