package cn.nova.bus.pack.model;

import java.io.Serializable;
import java.math.BigDecimal;
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
import javax.persistence.Transient;

@Entity
@Table(name = "PACKBALANCE")
public class PackBalance implements Serializable, Cloneable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "PACKBALANCE_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "PACKBALANCE_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;
	private long packnos; // number(10)
	private long pieces; // number(10)
	private BigDecimal packmoney; // number(15,3)
	private BigDecimal packprice; // number(15,3)
	private BigDecimal packdeductmoney; // number(15,3)
	private BigDecimal packbalancemoney; // number(15,3)
	private long balancby; // number(10)
	private long cancelby; // number(10)
	private long createby; // number(10)
	private long orgid;// number(10)
	private long updateby; // number(10)
	private String datatype; // varchar2(10)
	private String packbalanceno; // varchar2(20)
	private String balanceunitname; // varchar2(100)
	private String cancelip;// varchar2(255)
	private String balanceip; // varchar2(255)
	private String status; // char(1)
	@Temporal(TemporalType.TIMESTAMP)
	private Date balancetime; // date
	@Temporal(TemporalType.TIMESTAMP)
	private Date cleartime;// date
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;// date
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;// date

	@Transient
	private String ids;
	
	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public long getPacknos() {
		return packnos;
	}

	public void setPacknos(long packnos) {
		this.packnos = packnos;
	}

	public long getPieces() {
		return pieces;
	}

	public void setPieces(long pieces) {
		this.pieces = pieces;
	}

	public long getBalancby() {
		return balancby;
	}

	public void setBalancby(long balancby) {
		this.balancby = balancby;
	}

	public long getCancelby() {
		return cancelby;
	}

	public void setCancelby(long cancelby) {
		this.cancelby = cancelby;
	}

	public long getCreateby() {
		return createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public String getDatatype() {
		return datatype;
	}

	public void setDatatype(String datatype) {
		this.datatype = datatype;
	}

	public String getPackbalanceno() {
		return packbalanceno;
	}

	public void setPackbalanceno(String packbalanceno) {
		this.packbalanceno = packbalanceno;
	}

	public String getBalanceunitname() {
		return balanceunitname;
	}

	public void setBalanceunitname(String balanceunitname) {
		this.balanceunitname = balanceunitname;
	}

	public String getCancelip() {
		return cancelip;
	}

	public void setCancelip(String cancelip) {
		this.cancelip = cancelip;
	}

	public String getBalanceip() {
		return balanceip;
	}

	public void setBalanceip(String balanceip) {
		this.balanceip = balanceip;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getBalancetime() {
		return balancetime;
	}

	public void setBalancetime(Date balancetime) {
		this.balancetime = balancetime;
	}

	public Date getCleartime() {
		return cleartime;
	}

	public void setCleartime(Date cleartime) {
		this.cleartime = cleartime;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public BigDecimal getPackmoney() {
		return packmoney;
	}

	public void setPackmoney(BigDecimal packmoney) {
		this.packmoney = packmoney;
	}

	public BigDecimal getPackprice() {
		return packprice;
	}

	public void setPackprice(BigDecimal packprice) {
		this.packprice = packprice;
	}

	public BigDecimal getPackdeductmoney() {
		return packdeductmoney;
	}

	public void setPackdeductmoney(BigDecimal packdeductmoney) {
		this.packdeductmoney = packdeductmoney;
	}

	public BigDecimal getPackbalancemoney() {
		return packbalancemoney;
	}

	public void setPackbalancemoney(BigDecimal packbalancemoney) {
		this.packbalancemoney = packbalancemoney;
	}

	public void setId(long id) {
		this.id = id;
	}

}
