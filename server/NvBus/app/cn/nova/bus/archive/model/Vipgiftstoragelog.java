package cn.nova.bus.archive.model;

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
 * The persistent class for the VIPGIFTSTORAGELOG database table.
 * 
 */
@Entity
public class Vipgiftstoragelog implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="VIPGIFTSTORAGELOG_ID_GENERATOR", sequenceName="SEQ_PUB")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="VIPGIFTSTORAGELOG_ID_GENERATOR")
	private long id;

	private long afterstoragequantity;

	private long beforestoragequantity;

	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

	@Column(name="\"OPERATION\"")
	private String operation;

	private long quantity;

	private String remarks;

	private long vipgiftid;

    public Vipgiftstoragelog() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getAfterstoragequantity() {
		return this.afterstoragequantity;
	}

	public void setAfterstoragequantity(long afterstoragequantity) {
		this.afterstoragequantity = afterstoragequantity;
	}

	public long getBeforestoragequantity() {
		return this.beforestoragequantity;
	}

	public void setBeforestoragequantity(long beforestoragequantity) {
		this.beforestoragequantity = beforestoragequantity;
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

	public String getOperation() {
		return this.operation;
	}

	public void setOperation(String operation) {
		this.operation = operation;
	}

	public long getQuantity() {
		return this.quantity;
	}

	public void setQuantity(long quantity) {
		this.quantity = quantity;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public long getVipgiftid() {
		return this.vipgiftid;
	}

	public void setVipgiftid(long vipgiftid) {
		this.vipgiftid = vipgiftid;
	}

}