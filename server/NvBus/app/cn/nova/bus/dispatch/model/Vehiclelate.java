package cn.nova.bus.dispatch.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.bus.balance.model.Balance;


/**
 * The persistent class for the VEHICLELATE database table.
 * 
 */
@Entity
public class Vehiclelate implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="VEHICLELATE_ID_GENERATOR", sequenceName="SEQ_VEHICLEREPORT",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="VEHICLELATE_ID_GENERATOR")
	private long id;

	@JoinColumn(name = "BALANCEID", nullable = true)
	@ManyToOne(cascade = { CascadeType.REFRESH, CascadeType.PERSIST })
	private Balance balance;

	public Balance getBalance() {
		return balance;
	}

	public void setBalance(Balance balance) {
		this.balance = balance;
	}

	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

    @Temporal( TemporalType.DATE)
	private Date departdate;

	private BigDecimal forfeit;

	private String reason;

	private long reportid;  
	
	public long getReportid() {
		return reportid;
	}

	public void setReportid(long reportid) {
		this.reportid = reportid;
	}

	private long scheduleid;

	private long vehicleid;

    public Vehiclelate() {
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

	public Date getDepartdate() {
		return this.departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public BigDecimal getForfeit() {
		return this.forfeit;
	}

	public void setForfeit(BigDecimal forfeit) {
		this.forfeit = forfeit;
	}

	public String getReason() {
		return this.reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public long getScheduleid() {
		return this.scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public long getVehicleid() {
		return this.vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}
}