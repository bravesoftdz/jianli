package cn.nova.bus.balance.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

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
 * The persistent class for the VEHICLETURNOVER database table. 
 * 车辆预缴款
 */
@Entity
public class Vehicleturnover implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@SequenceGenerator(name="VEHICLETURNOVER_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="VEHICLETURNOVER_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	private long id;

	@ManyToOne
	@JoinColumn(name = "balanceid", nullable = true)
	private Balance balance;
	
	private Long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private boolean isbalance;

	private BigDecimal money;

	private String receiptip;

	private Long receiptorgid;

	private Long receiver;

	private String remarks;

	@Temporal(TemporalType.TIMESTAMP)
	private Date turnovertime;

	private Long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private Long vehicleid;

	public Vehicleturnover() {
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}


	public Long getCreateby() {
		return createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public boolean isIsbalance() {
		return isbalance;
	}

	public void setIsbalance(boolean isbalance) {
		this.isbalance = isbalance;
	}

	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	public String getReceiptip() {
		return receiptip;
	}

	public void setReceiptip(String receiptip) {
		this.receiptip = receiptip;
	}

	public Long getReceiptorgid() {
		return receiptorgid;
	}

	public void setReceiptorgid(Long receiptorgid) {
		this.receiptorgid = receiptorgid;
	}

	public Long getReceiver() {
		return receiver;
	}

	public void setReceiver(Long receiver) {
		this.receiver = receiver;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Date getTurnovertime() {
		return turnovertime;
	}

	public void setTurnovertime(Date turnovertime) {
		this.turnovertime = turnovertime;
	}

	public Long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public Long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(Long vehicleid) {
		this.vehicleid = vehicleid;
	}
	public Balance getBalance() {
		return balance;
	}

	public void setBalance(Balance balance) {
		this.balance = balance;
	}
}