package cn.nova.bus.bill.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * The persistent class for the BILLDAMAGED database table.
 * 
 */
@Entity
@Table(name = "BILLDAMAGED")
public class Billdamaged implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "BILLDAMAGED_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "BILLDAMAGED_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;

	@Column(nullable = false, precision = 10)
	private long amount;

	@Column(nullable = false, precision = 10)
	private long billtypeid;

	@Column(nullable = false, precision = 10)
	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date createtime;

	@Column(nullable = false, length = 100)
	private String damageddscribe;

	@Column(nullable = false, precision = 10)
	private long endno;

	@Column(nullable = false, precision = 10)
	private long recordby;

	@Column(nullable = false, length = 40)
	private String recordip;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date recordtime;

	@Column(nullable = false, precision = 10)
	private long startno;

	@Column(nullable = false, precision = 10)
	private long ticketoutletsid;	

	@Column(nullable=false, precision=10)
	private long turnoverdetailid;
	
	@Column(nullable = false, precision = 10)
	private Long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date updatetime;

	@Column(nullable = false, precision = 10)
	private long billinuseid;

	public Billdamaged() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getAmount() {
		return this.amount;
	}

	public void setAmount(long amount) {
		this.amount = amount;
	}

	public long getBilltypeid() {
		return this.billtypeid;
	}

	public void setBilltypeid(long billtypeid) {
		this.billtypeid = billtypeid;
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

	public String getDamageddscribe() {
		return this.damageddscribe;
	}

	public void setDamageddscribe(String damageddscribe) {
		this.damageddscribe = damageddscribe;
	}

	public long getEndno() {
		return this.endno;
	}

	public void setEndno(long endno) {
		this.endno = endno;
	}

	public long getRecordby() {
		return this.recordby;
	}

	public void setRecordby(long recordby) {
		this.recordby = recordby;
	}

	public String getRecordip() {
		return this.recordip;
	}

	public void setRecordip(String recordip) {
		this.recordip = recordip;
	}

	public Date getRecordtime() {
		return this.recordtime;
	}

	public void setRecordtime(Date recordtime) {
		this.recordtime = recordtime;
	}

	public long getStartno() {
		return this.startno;
	}

	public void setStartno(long startno) {
		this.startno = startno;
	}

	public long getTicketoutletsid() {
		return this.ticketoutletsid;
	}

	public void setTicketoutletsid(long ticketoutletsid) {
		this.ticketoutletsid = ticketoutletsid;
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

	public long getBillinuseid() {
		return billinuseid;
	}

	public void setBillinuseid(long billinuseid) {
		this.billinuseid = billinuseid;
	}

	public void setTurnoverdetailid(long turnoverdetailid) {
		this.turnoverdetailid = turnoverdetailid;
	}

	public long getTurnoverdetailid() {
		return turnoverdetailid;
	}

}