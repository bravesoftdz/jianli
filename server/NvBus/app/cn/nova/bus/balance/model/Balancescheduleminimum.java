package cn.nova.bus.balance.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * The persistent class for the BALANCESCHEDULEMINIMUM database table. 班次保底人数结算
 */
@Entity
public class Balancescheduleminimum implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "BALANCESCHEDULEMINIMUM_ID_GENERATOR", sequenceName = "SEQ_BALANCE", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "BALANCESCHEDULEMINIMUM_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
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

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	@Temporal(TemporalType.DATE)
	private Date departdate;

	private long departinvoicesid;

	private BigDecimal fullprice;

	private long minimum;

	private long scheduleid;

	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private long vehicleid;

	private BigDecimal lessmoney;

	private long lessnum;
	
	public long getLessnum() {
		return lessnum;
	}

	public void setLessnum(long lessnum) {
		this.lessnum = lessnum;
	}

	public Balancescheduleminimum() {
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
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

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public long getDepartinvoicesid() {
		return departinvoicesid;
	}

	public void setDepartinvoicesid(long departinvoicesid) {
		this.departinvoicesid = departinvoicesid;
	}

	public BigDecimal getFullprice() {
		return fullprice;
	}

	public void setFullprice(BigDecimal fullprice) {
		this.fullprice = fullprice;
	}

	public long getMinimum() {
		return minimum;
	}

	public void setMinimum(long minimum) {
		this.minimum = minimum;
	}

	public long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
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

	public long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public BigDecimal getLessmoney() {
		return lessmoney;
	}

	public void setLessmoney(BigDecimal lessmoney) {
		this.lessmoney = lessmoney;
	}

}