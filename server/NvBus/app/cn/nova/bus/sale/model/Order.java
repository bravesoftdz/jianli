package cn.nova.bus.sale.model;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.*;

import java.util.Date;

/**
 * The persistent class for the orders database table.
 * 
 */
@Entity
@Table(name = "orders")
public class Order implements Serializable {
	private static final long serialVersionUID = 1L;

	
	@Id
	@SequenceGenerator(name="ORDER_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="ORDER_ID_GENERATOR")
	@Column(unique=true, nullable=false, precision=10)
	private long id;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private long departorgid;
	
	private String orderid;
	
	private String ordercardid;
	

	private long customerid;

	private BigDecimal orderservicecharge;

	private String orderauthcode;

	private String orderno;

	private int seatnum;

	private long sellorgid;

	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private String status;

	public Order() {
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

	public long getDepartorgid() {
		return departorgid;
	}

	public void setDepartorgid(long departorgid) {
		this.departorgid = departorgid;
	}

	public String getOrderno() {
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	public int getSeatnum() {
		return seatnum;
	}

	public void setSeatnum(int seatnum) {
		this.seatnum = seatnum;
	}

	public long getSellorgid() {
		return sellorgid;
	}

	public void setSellorgid(long sellorgid) {
		this.sellorgid = sellorgid;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public long getCustomerid() {
		return customerid;
	}

	public void setCustomerid(long customerid) {
		this.customerid = customerid;
	}

	public BigDecimal getOrderservicecharge() {
		return orderservicecharge;
	}

	public void setOrderservicecharge(BigDecimal orderservicecharge) {
		this.orderservicecharge = orderservicecharge;
	}

	public String getOrderauthcode() {
		return orderauthcode;
	}

	public void setOrderauthcode(String orderauthcode) {
		this.orderauthcode = orderauthcode;
	}

	public String getOrderid() {
		return orderid;
	}

	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}

	public String getOrdercardid() {
		return ordercardid;
	}

	public void setOrdercardid(String ordercardid) {
		this.ordercardid = ordercardid;
	}

}