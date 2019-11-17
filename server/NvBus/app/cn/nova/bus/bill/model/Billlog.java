package cn.nova.bus.bill.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.bus.system.model.Userinfo;

/**
 * The persistent class for the BILLLOG database table.
 * 
 */
@Entity
public class Billlog implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "BILLLOG_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "BILLLOG_ID_GENERATOR")
	private long id;

	private long billinventoryid;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private long endno;

	private String operationtype;

	private long startno;

	@ManyToOne
	@JoinColumn(name = "LOGUSER", nullable = true)
	private Userinfo loguser;

	public Billlog() {
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

	public String getOperationtype() {
		return operationtype;
	}

	public void setOperationtype(String operationtype) {
		this.operationtype = operationtype;
	}

	public long getStartno() {
		return startno;
	}

	public void setStartno(long startno) {
		this.startno = startno;
	}

	public Userinfo getLoguser() {
		return loguser;
	}

	public void setLoguser(Userinfo loguser) {
		this.loguser = loguser;
	}

}