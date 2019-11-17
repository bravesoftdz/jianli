package cn.nova.bus.sale.model;

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
 * Payinfodetail entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "PAYINFODETAIL")
public class Payinfodetail implements java.io.Serializable {

	// Fields

	private long id;
	private long payinfoid;
	@Temporal(TemporalType.TIMESTAMP)
	private Date returntime;
	private String returnstatus;
	private long returnby;
	private double returnprice;
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;
	private long createby;
	private String ip;

	//增加 payinfodetail 退票数、退票金额；退保险数、退保险金额
	
	private BigDecimal tickets;
	
	private BigDecimal ticketprice;
	
	private BigDecimal insures;
	
	private BigDecimal insurefee;
	
	public BigDecimal getTickets() {
		return tickets;
	}

	public void setTickets(BigDecimal tickets) {
		this.tickets = tickets;
	}

	public BigDecimal getTicketprice() {
		return ticketprice;
	}

	public void setTicketprice(BigDecimal ticketprice) {
		this.ticketprice = ticketprice;
	}

	public BigDecimal getInsures() {
		return insures;
	}

	public void setInsures(BigDecimal insures) {
		this.insures = insures;
	}

	public BigDecimal getInsurefee() {
		return insurefee;
	}

	public void setInsurefee(BigDecimal insurefee) {
		this.insurefee = insurefee;
	}
	
	// Constructors

	/** default constructor */
	public Payinfodetail() {
	}


	// Property accessors
	@Id
	@SequenceGenerator(name="PAYINFODETAIL_ID_GENERATOR", sequenceName="SEQ_PAYINFO",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="PAYINFODETAIL_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false)
	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getPayinfoid() {
		return this.payinfoid;
	}

	public void setPayinfoid(long payinfoid) {
		this.payinfoid = payinfoid;
	}

	public Date getReturntime() {
		return this.returntime;
	}

	public void setReturntime(Date returntime) {
		this.returntime = returntime;
	}

	public String getReturnstatus() {
		return this.returnstatus;
	}

	public void setReturnstatus(String returnstatus) {
		this.returnstatus = returnstatus;
	}

	public long getReturnby() {
		return this.returnby;
	}

	public void setReturnby(long returnby) {
		this.returnby = returnby;
	}

	public double getReturnprice() {
		return this.returnprice;
	}

	public void setReturnprice(double returnprice) {
		this.returnprice = returnprice;
	}

	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public long getCreateby() {
		return this.createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public String getIp() {
		return this.ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

}