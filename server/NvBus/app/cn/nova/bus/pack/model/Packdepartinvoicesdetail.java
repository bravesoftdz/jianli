package cn.nova.bus.pack.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


@Entity
@Table(name = "PACKDEPARTINVOICESDETAIL")
public class Packdepartinvoicesdetail implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "PACKDEPARTINVOICESDETAIL_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "PACKDEPARTINVOICESDETAIL_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;
	
	private long packdepartinvoicesid;
	
	private long sendstationid;	
	
	private long tostationid;
	
	private short pieces;

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal shipprice;// number(6,2) y 托运费

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal packfee;// number(6,2) y 包装费

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal handfee;// number(6,2) y 发货装卸费
	  
	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal custodial;// number(6,2) y 保管费

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal transitfee;// number(6,2) y 中转费

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal insuredamount;// number(6,2) y 保价金额

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal insurancefee;// number(6,2) y 保价费

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal deliveryfee;// 送货费

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal servicefee;// number(6,2) y 服务费
	
	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal packprice;// number(6,2) y 代收货款

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal otherfee;// number(6,2) y 其他费用

	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal totalfee;// number(6,2) y 合计金额
	
	@Column(nullable = true, precision = 6, scale = 2)
	private BigDecimal balanceamount;// number(6,2) y 结算金额	

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;// date n sys;//date

	@Column(nullable=false)
	
	private long createby;// number(10) n

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;// date n sys;//date

	@Column(nullable=false)
	
	private long updateby;// number(10) n
	
	
	public Packdepartinvoicesdetail() {
		// TODO Auto-generated constructor stub
	}


	public long getId() {
		return id;
	}


	public void setId(long id) {
		this.id = id;
	}


	public long getPackdepartinvoicesid() {
		return packdepartinvoicesid;
	}


	public void setPackdepartinvoicesid(long packdepartinvoicesid) {
		this.packdepartinvoicesid = packdepartinvoicesid;
	}


	public long getSendstationid() {
		return sendstationid;
	}


	public void setSendstationid(long sendstationid) {
		this.sendstationid = sendstationid;
	}


	public long getTostationid() {
		return tostationid;
	}


	public void setTostationid(long tostationid) {
		this.tostationid = tostationid;
	}


	public short getPieces() {
		return pieces;
	}


	public void setPieces(short pieces) {
		this.pieces = pieces;
	}


	public BigDecimal getShipprice() {
		return shipprice;
	}


	public void setShipprice(BigDecimal shipprice) {
		this.shipprice = shipprice;
	}


	public BigDecimal getPackfee() {
		return packfee;
	}


	public void setPackfee(BigDecimal packfee) {
		this.packfee = packfee;
	}


	public BigDecimal getHandfee() {
		return handfee;
	}


	public void setHandfee(BigDecimal handfee) {
		this.handfee = handfee;
	}


	public BigDecimal getCustodial() {
		return custodial;
	}


	public void setCustodial(BigDecimal custodial) {
		this.custodial = custodial;
	}


	public BigDecimal getTransitfee() {
		return transitfee;
	}


	public void setTransitfee(BigDecimal transitfee) {
		this.transitfee = transitfee;
	}


	public BigDecimal getInsuredamount() {
		return insuredamount;
	}


	public void setInsuredamount(BigDecimal insuredamount) {
		this.insuredamount = insuredamount;
	}


	public BigDecimal getInsurancefee() {
		return insurancefee;
	}


	public void setInsurancefee(BigDecimal insurancefee) {
		this.insurancefee = insurancefee;
	}


	public BigDecimal getDeliveryfee() {
		return deliveryfee;
	}


	public void setDeliveryfee(BigDecimal deliveryfee) {
		this.deliveryfee = deliveryfee;
	}


	public BigDecimal getServicefee() {
		return servicefee;
	}


	public void setServicefee(BigDecimal servicefee) {
		this.servicefee = servicefee;
	}


	public BigDecimal getPackprice() {
		return packprice;
	}


	public void setPackprice(BigDecimal packprice) {
		this.packprice = packprice;
	}


	public BigDecimal getOtherfee() {
		return otherfee;
	}


	public void setOtherfee(BigDecimal otherfee) {
		this.otherfee = otherfee;
	}


	public BigDecimal getTotalfee() {
		return totalfee;
	}


	public void setTotalfee(BigDecimal totalfee) {
		this.totalfee = totalfee;
	}


	public BigDecimal getBalanceamount() {
		return balanceamount;
	}


	public void setBalanceamount(BigDecimal balanceamount) {
		this.balanceamount = balanceamount;
	}


	public Date getCreatetime() {
		return createtime;
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
	
}
