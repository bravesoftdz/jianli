package cn.nova.bus.base.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * The persistent class for the TICKETOUTLETS database table.
 * 
 */
@Entity
@Table(name = "TICKETOUTSPRETICKETSELL")
public class Ticketoutspreticketsell implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "TICKETOUTSPRETICKETSELL_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "TICKETOUTSPRETICKETSELL_ID_GENERATOR")
	private long id;

	private long ticketoutsid;// number(10) not null,

	@Temporal(TemporalType.DATE)
	private Date saledate;

	@Temporal(TemporalType.DATE)
	private Date departdate;

	private String routecode;

	private long ticketnum;

	private BigDecimal ticketmoney;

	private String ticketoutletstype;

	private long orgid;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	public Ticketoutspreticketsell() {
		// TODO Auto-generated constructor stub
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getTicketoutsid() {
		return ticketoutsid;
	}

	public void setTicketoutsid(long ticketoutsid) {
		this.ticketoutsid = ticketoutsid;
	}

	public Date getSaledate() {
		return saledate;
	}

	public void setSaledate(Date saledate) {
		this.saledate = saledate;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public String getRoutecode() {
		return routecode;
	}

	public void setRoutecode(String routecode) {
		this.routecode = routecode;
	}

	public long getTicketnum() {
		return ticketnum;
	}

	public void setTicketnum(long ticketnum) {
		this.ticketnum = ticketnum;
	}

	public BigDecimal getTicketmoney() {
		return ticketmoney;
	}

	public void setTicketmoney(BigDecimal ticketmoney) {
		this.ticketmoney = ticketmoney;
	}

	public String getTicketoutletstype() {
		return ticketoutletstype;
	}

	public void setTicketoutletstype(String ticketoutletstype) {
		this.ticketoutletstype = ticketoutletstype;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
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

}