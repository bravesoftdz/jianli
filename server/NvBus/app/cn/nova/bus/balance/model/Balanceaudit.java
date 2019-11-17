package cn.nova.bus.balance.model;

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
 * The persistent class for the BALANCEAUDIT database table.
 * 
 */
@Entity
public class Balanceaudit implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="BALANCEAUDIT_ID_GENERATOR", sequenceName="SEQ_BALANCE",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="BALANCEAUDIT_ID_GENERATOR")
	private long id;

	private long auditby;

	private String auditip;

    @Temporal( TemporalType.TIMESTAMP)
	private Date audittime;

	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

	private boolean isauditpass;

	private long orgid;

	private String remarks;

	private String type;

	private long typeid;

    public Balanceaudit() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getAuditby() {
		return this.auditby;
	}

	public void setAuditby(long auditby) {
		this.auditby = auditby;
	}

	public String getAuditip() {
		return this.auditip;
	}

	public void setAuditip(String auditip) {
		this.auditip = auditip;
	}

	public Date getAudittime() {
		return this.audittime;
	}

	public void setAudittime(Date audittime) {
		this.audittime = audittime;
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

	public boolean getIsauditpass() {
		return this.isauditpass;
	}

	public void setIsauditpass(boolean isauditpass) {
		this.isauditpass = isauditpass;
	}

	public long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public long getTypeid() {
		return this.typeid;
	}

	public void setTypeid(long typeid) {
		this.typeid = typeid;
	}

}