package cn.nova.bus.sale.model;

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

@Entity
@Table(name = "TICKETSELLOTHER")
public class Ticketsellother implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "TICKETSELLOTHER_ID_GENERATOR", sequenceName = "SEQ_TICKETSELL", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "TICKETSELLOTHER_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;

	@Column(nullable = false, length = 60)
	private String agentname;

	@Column(nullable = false, precision = 10)
	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date createtime;

	@Column(length = 40)
	private String eticketid;

	@Column(length = 20)
	private String eticketno;

	@Column(nullable = false, precision = 1)
	private boolean istaked;

	@Column(length = 40)
	private String orderno;

	@Column(nullable = false, length = 20)
	private String password;

	@Column(precision = 10)
	private Long printby;

	@Column(nullable = false, precision = 10, scale = 2)
	private BigDecimal serviceprice;

	@Column(nullable = false, precision = 10)
	private long ticketsellid;

	@Column(nullable = false, precision = 10)
	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date updatetime;

	@Temporal(TemporalType.TIMESTAMP)
	private Date taketime;

	@Column(length = 10)
	private String takeway;

	public Ticketsellother() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getAgentname() {
		return this.agentname;
	}

	public void setAgentname(String agentname) {
		this.agentname = agentname;
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

	public String getEticketid() {
		return this.eticketid;
	}

	public void setEticketid(String eticketid) {
		this.eticketid = eticketid;
	}

	public String getEticketno() {
		return this.eticketno;
	}

	public void setEticketno(String eticketno) {
		this.eticketno = eticketno;
	}

	public boolean getIstaked() {
		return this.istaked;
	}

	public void setIstaked(boolean istaked) {
		this.istaked = istaked;
	}

	public String getOrderno() {
		return this.orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Long getPrintby() {
		return this.printby;
	}

	public void setPrintby(Long printby) {
		this.printby = printby;
	}

	public BigDecimal getServiceprice() {
		return this.serviceprice;
	}

	public void setServiceprice(BigDecimal serviceprice) {
		this.serviceprice = serviceprice;
	}

	public long getTicketsellid() {
		return this.ticketsellid;
	}

	public void setTicketsellid(long ticketsellid) {
		this.ticketsellid = ticketsellid;
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

	public Date getTaketime() {
		return taketime;
	}

	public void setTaketime(Date taketime) {
		this.taketime = taketime;
	}

	public String getTakeway() {
		return takeway;
	}

	public void setTakeway(String takeway) {
		this.takeway = takeway;
	}

}