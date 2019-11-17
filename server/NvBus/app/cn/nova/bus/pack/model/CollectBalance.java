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

/**
 * 代收货款结算单
 * @author Administrator
 *
 */
@Entity
@Table(name = "COLLECTBALANCE")
public class CollectBalance implements Serializable, Cloneable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@SequenceGenerator(name = "COLLECTBALANCE_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "COLLECTBALANCE_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private Long id;
	private Long vehicleid;
	private Integer packnum;
	@Column(nullable = true, precision = 15, scale = 3)
	private BigDecimal shipprice;
	@Column(nullable = true, precision = 15, scale = 3)
	private BigDecimal packprice;
	@Column(nullable = true, precision = 15, scale = 3)
	private BigDecimal balanceprice;
	private Long balancby;
	@Temporal(TemporalType.DATE)
	private Date balancetime;
	private String balanceip;
	private Long cancelby;
	@Temporal(TemporalType.DATE)
	private Date cleartime;
	private String cancelip;
	private String status;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getVehicleid() {
		return vehicleid;
	}
	public void setVehicleid(Long vehicleid) {
		this.vehicleid = vehicleid;
	}
	public Integer getPacknum() {
		return packnum;
	}
	public void setPacknum(Integer packnum) {
		this.packnum = packnum;
	}
	public BigDecimal getShipprice() {
		return shipprice;
	}
	public void setShipprice(BigDecimal shipprice) {
		this.shipprice = shipprice;
	}
	public BigDecimal getPackprice() {
		return packprice;
	}
	public void setPackprice(BigDecimal packprice) {
		this.packprice = packprice;
	}
	public BigDecimal getBalanceprice() {
		return balanceprice;
	}
	public void setBalanceprice(BigDecimal balanceprice) {
		this.balanceprice = balanceprice;
	}
	public Long getBalancby() {
		return balancby;
	}
	public void setBalancby(Long balancby) {
		this.balancby = balancby;
	}
	public Date getBalancetime() {
		return balancetime;
	}
	public void setBalancetime(Date balancetime) {
		this.balancetime = balancetime;
	}
	public String getBalanceip() {
		return balanceip;
	}
	public void setBalanceip(String balanceip) {
		this.balanceip = balanceip;
	}
	public Long getCancelby() {
		return cancelby;
	}
	public void setCancelby(Long cancelby) {
		this.cancelby = cancelby;
	}
	public Date getCleartime() {
		return cleartime;
	}
	public void setCleartime(Date cleartime) {
		this.cleartime = cleartime;
	}
	public String getCancelip() {
		return cancelip;
	}
	public void setCancelip(String cancelip) {
		this.cancelip = cancelip;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
}
