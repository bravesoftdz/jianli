package cn.nova.bus.bill.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * The persistent class for the BILLINUSE database table.
 * 
 */
@Entity
public class Billinuse implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "BILLINUSE_ID_GENERATOR", sequenceName="SEQ_BILLINUSE",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "BILLINUSE_ID_GENERATOR")
	private long id;

	private long billinventoryid;

	private long billtypeid;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private long endno;

	private boolean isactive;

	private long nextno;

	private long orgid;

	private long recipients;

	private long startno;

	private String status;

	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	public Billinuse() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getBillinventoryid() {
		return billinventoryid;
	}

	public void setBillinventoryid(long billinventoryid) {
		this.billinventoryid = billinventoryid;
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

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public long getEndno() {
		return endno;
	}

	public void setEndno(long endno) {
		this.endno = endno;
	}

	public boolean isIsactive() {
		return isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public long getNextno() {
		return nextno;
	}

	public void setNextno(long nextno) {
		this.nextno = nextno;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public long getRecipients() {
		return recipients;
	}

	public void setRecipients(long recipients) {
		this.recipients = recipients;
	}

	public long getStartno() {
		return startno;
	}

	public void setStartno(long startno) {
		this.startno = startno;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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