package cn.nova.bus.checkticket.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import cn.nova.bus.balance.model.Balance;
import cn.nova.utils.orm.listener.SyncCodeGenerate;

/**
 * The persistent class for the DEPARTINVOICESDEDUCTDETAIL database table.
 * 
 */
//
@Entity
@Table(name = "DEPARTINVOICESDEDUCTDETAIL")
@EntityListeners({ SyncCodeGenerate.class })
public class Departinvoicesdeductdetail implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "DEPARTINVOICESDEDUCTDETAIL_ID_GENERATOR", sequenceName = "SEQ_BALANCE", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "DEPARTINVOICESDEDUCTDETAIL_ID_GENERATOR")
	private long id;

	private long balanceapplyid;

	private long balanceitemid;

	@JoinColumn(name = "BALANCEID", nullable = true)
	@ManyToOne(cascade = { CascadeType.REFRESH, CascadeType.PERSIST })
	private Balance balance;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private BigDecimal deductmoney;

	@Temporal(TemporalType.DATE)
	private Date departdate;

	@JoinColumn(name = "DEPARTINVOICESID", nullable = true)
	@ManyToOne(cascade = { CascadeType.REFRESH, CascadeType.PERSIST })
	private Departinvoices departinvoices;

	private boolean isdeductbeforebalance;

	private long parentbalanceitemid;

	private long scheduleid;

	private String status;

	private String type;

	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private String synccode;

	// 该字段作为记录的操作类型字段，不对数据库表进行映射
	@Transient
	private String opertype;

	@Transient
	private String name;

	@Transient
	private String code;

	@Transient
	private String departinvoicesno;

	public Departinvoicesdeductdetail() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getBalanceapplyid() {
		return this.balanceapplyid;
	}

	public void setBalanceapplyid(long balanceapplyid) {
		this.balanceapplyid = balanceapplyid;
	}

	public long getBalanceitemid() {
		return this.balanceitemid;
	}

	public void setBalanceitemid(long balanceitemid) {
		this.balanceitemid = balanceitemid;
	}

	public Balance getBalance() {
		return this.balance;
	}

	public void setBalance(Balance balance) {
		this.balance = balance;
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

	public BigDecimal getDeductmoney() {
		return this.deductmoney;
	}

	public void setDeductmoney(BigDecimal deductmoney) {
		this.deductmoney = deductmoney;
	}

	public Date getDepartdate() {
		return this.departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public Departinvoices getDepartinvoices() {
		return this.departinvoices;
	}

	public void setDepartinvoices(Departinvoices departinvoices) {
		this.departinvoices = departinvoices;
	}

	public boolean getIsdeductbeforebalance() {
		return this.isdeductbeforebalance;
	}

	public void setIsdeductbeforebalance(boolean isdeductbeforebalance) {
		this.isdeductbeforebalance = isdeductbeforebalance;
	}

	public long getParentbalanceitemid() {
		return this.parentbalanceitemid;
	}

	public void setParentbalanceitemid(long parentbalanceitemid) {
		this.parentbalanceitemid = parentbalanceitemid;
	}

	public long getScheduleid() {
		return this.scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
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

	public String getDepartinvoicesno() {
		return departinvoicesno;
	}

	public void setDepartinvoicesno(String departinvoicesno) {
		this.departinvoicesno = departinvoicesno;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
}