package cn.nova.bus.bill.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.utils.orm.listener.AuditLogListener;
import cn.nova.utils.orm.listener.SyncCodeGenerate;

/**
 * The persistent class for the BILLINVENTORY database table.
 * 
 */
@Entity
@Table(name = "BILLINVENTORY")
@EntityListeners({ SyncCodeGenerate.class, AuditLogListener.class })
public class Billinventory implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "BILLINVENTORY_ID_GENERATOR", sequenceName = "SEQ_BILLINVENTORY", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "BILLINVENTORY_ID_GENERATOR")
	private long id;

	private long adder;

	private long availableenno;

	private long availablestartno;

	private String batchno;

	private long billtypeid;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private String description;

	private boolean isactive;

	private long orgid;

	private long putinendno;

	private long putinstartno;

	private String putintype;

	private long storageid;

	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private String synccode;

	public Billinventory() {
	}

	public long getAdder() {
		return adder;
	}

	public void setAdder(long adder) {
		this.adder = adder;
	}

	public long getAvailableenno() {
		return availableenno;
	}

	public void setAvailableenno(long availableenno) {
		this.availableenno = availableenno;
	}

	public long getAvailablestartno() {
		return availablestartno;
	}

	public void setAvailablestartno(long availablestartno) {
		this.availablestartno = availablestartno;
	}

	public long getBilltypeid() {
		return billtypeid;
	}

	public void setBilltypeid(long billtypeid) {
		this.billtypeid = billtypeid;
	}

	public long getCreateby() {
		return createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public boolean isIsactive() {
		return isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public long getPutinendno() {
		return putinendno;
	}

	public void setPutinendno(long putinendno) {
		this.putinendno = putinendno;
	}

	public long getPutinstartno() {
		return putinstartno;
	}

	public void setPutinstartno(long putinstartno) {
		this.putinstartno = putinstartno;
	}

	public long getStorageid() {
		return storageid;
	}

	public void setStorageid(long storageid) {
		this.storageid = storageid;
	}

	public long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getBatchno() {
		return this.batchno;
	}

	public void setBatchno(String batchno) {
		this.batchno = batchno;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPutintype() {
		return this.putintype;
	}

	public void setPutintype(String putintype) {
		this.putintype = putintype;
	}

	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public String getSynccode() {
		return synccode;
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

}