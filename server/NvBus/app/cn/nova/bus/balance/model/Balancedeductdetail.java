package cn.nova.bus.balance.model;

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
import javax.persistence.Transient;

@Entity
public class Balancedeductdetail implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "BALANCEDD_ID_GENERATOR", sequenceName = "SEQ_BALANCE", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "BALANCEDD_ID_GENERATOR")
	private long id;

	private long balancedeductitemid;

	@JoinColumn(name = "BALANCEID", nullable = true)
	@ManyToOne(cascade = { CascadeType.REFRESH, CascadeType.PERSIST })
	private Balance balance;

	private BigDecimal deductmoney;

	private long balanceunitid;

	private String status;
	
    private String deductitemname;
	
	public String getDeductitemname() {
		return deductitemname;
	}

	public void setDeductitemname(String deductitemname) {
		this.deductitemname = deductitemname;
	}

	public Long getBalancevehicleid() {
		return balancevehicleid;
	}

	public void setBalancevehicleid(Long balancevehicleid) {
		this.balancevehicleid = balancevehicleid;
	}

	private long orgid;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private long createby;

	private Long balancevehicleid;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private long updateby;


	@Transient
	private String opertype;

	@Transient
	private String name;

	private BigDecimal divdedeductmoney;
	
	
	public BigDecimal getDivdedeductmoney() {
		return divdedeductmoney;
	}

	public void setDivdedeductmoney(BigDecimal divdedeductmoney) {
		this.divdedeductmoney = divdedeductmoney;
	}

	public Balancedeductdetail() {

	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getBalancedeductitemid() {
		return balancedeductitemid;
	}

	public void setBalancedeductitemid(long balancedeductitemid) {
		this.balancedeductitemid = balancedeductitemid;
	}

	public Balance getBalance() {
		return balance;
	}

	public void setBalance(Balance balance) {
		this.balance = balance;
	}

	public BigDecimal getDeductmoney() {
		return deductmoney;
	}

	public void setDeductmoney(BigDecimal deductmoney) {
		this.deductmoney = deductmoney;
	}

	public long getBalanceunitid() {
		return balanceunitid;
	}

	public void setBalanceunitid(long balanceunitid) {
		this.balanceunitid = balanceunitid;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public long getCreateby() {
		return createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public String getOpertype() {
		return opertype;
	}

	public void setOpertype(String opertype) {
		this.opertype = opertype;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}	
}
