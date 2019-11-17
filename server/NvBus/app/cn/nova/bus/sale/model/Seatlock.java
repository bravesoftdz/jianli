package cn.nova.bus.sale.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the SEATLOCK database table.
 * 
 */
@Entity
@Table(name="SEATLOCK")
public class Seatlock implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private SeatlockPK id;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date autounlocktime;

    @Temporal( TemporalType.DATE)
	@Column(nullable=false)
	private Date departdate;

	@Column(nullable=false, precision=10)
	private long lockby;

	@Column(nullable=false, length=40)
	private String lockip;

	@Column(nullable=false, precision=10)
	private long lockorgid;

	@Column(nullable=false, precision=10)
	private long lockticketoutletsid;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date locktime;

	@Column(nullable=false, length=1)
	private String oldstatus;

	@Column(nullable=false, length=40)
	private String orderno;

	@Column(nullable=false, precision=10)
	private long scheduleid;

	private Byte carrychildnum;

    public Seatlock() {
    }

	public SeatlockPK getId() {
		return this.id;
	}

	public void setId(SeatlockPK id) {
		this.id = id;
	}
	
	public Date getAutounlocktime() {
		return this.autounlocktime;
	}

	public void setAutounlocktime(Date autounlocktime) {
		this.autounlocktime = autounlocktime;
	}

	public Date getDepartdate() {
		return this.departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public long getLockby() {
		return this.lockby;
	}

	public void setLockby(long lockby) {
		this.lockby = lockby;
	}

	public String getLockip() {
		return this.lockip;
	}

	public void setLockip(String lockip) {
		this.lockip = lockip;
	}

	public long getLockorgid() {
		return this.lockorgid;
	}

	public void setLockorgid(long lockorgid) {
		this.lockorgid = lockorgid;
	}

	public long getLockticketoutletsid() {
		return this.lockticketoutletsid;
	}

	public void setLockticketoutletsid(long lockticketoutletsid) {
		this.lockticketoutletsid = lockticketoutletsid;
	}

	public Date getLocktime() {
		return this.locktime;
	}

	public void setLocktime(Date locktime) {
		this.locktime = locktime;
	}

	public String getOldstatus() {
		return this.oldstatus;
	}

	public void setOldstatus(String oldstatus) {
		this.oldstatus = oldstatus;
	}

	public String getOrderno() {
		return this.orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	public long getScheduleid() {
		return this.scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public Byte getCarrychildnum() {
		return carrychildnum;
	}

	public void setCarrychildnum(Byte carrychildnum) {
		this.carrychildnum = carrychildnum;
	}

}