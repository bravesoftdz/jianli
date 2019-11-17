package cn.nova.bus.checkticket.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import cn.nova.bus.base.model.Schedule;

/**
 * The persistent class for the DEPARTINVOICESOTHERDETAIL database table.
 * 
 */
@Entity
public class Departinvoicesotherdetail implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "DEPARTINVOICESOTHERDETAIL_ID_GENERATOR", sequenceName = "SEQ_DEPARTINVOICES",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "DEPARTINVOICESOTHERDETAIL_ID_GENERATOR")
	private long id;

	private BigDecimal agentfee;

	private BigDecimal balanceamount;

	private Long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	@Temporal(TemporalType.DATE)
	private Date departdate;

	private Long departinvoicesotherid;

	private String departtime;

	private long distance;

	private Long fromstationid;

	private BigDecimal othterfee;

	private BigDecimal price;
	
	private BigDecimal balanceprice;

	private Long reachstationid;

	@JoinColumn(name = "SCHEDULEID", nullable = true)
	@OneToOne
	private Schedule schedule;

	private BigDecimal stationservicefee;

	private String status;

	private long ticketnum;

	private Long tickettypeid;

	private BigDecimal totalamount;

	private Long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;
	
	@Transient
	private String ticketids;
	
	public String getTicketids() {
		return ticketids;
	}

	public void setTicketids(String ticketids) {
		this.ticketids = ticketids;
	}

	public Departinvoicesotherdetail() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}
	
	public BigDecimal getAgentfee() {
		return this.agentfee;
	}

	public void setAgentfee(BigDecimal agentfee) {
		this.agentfee = agentfee;
	}

	public BigDecimal getBalanceamount() {
		return this.balanceamount;
	}

	public void setBalanceamount(BigDecimal balanceamount) {
		this.balanceamount = balanceamount;
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

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public Long getDepartinvoicesotherid() {
		return departinvoicesotherid;
	}

	public void setDepartinvoicesotherid(Long departinvoicesotherid) {
		this.departinvoicesotherid = departinvoicesotherid;
	}

	public String getDeparttime() {
		return departtime;
	}

	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}

	public long getDistance() {
		return distance;
	}

	public void setDistance(long distance) {
		this.distance = distance;
	}

	public Long getFromstationid() {
		return fromstationid;
	}

	public void setFromstationid(Long fromstationid) {
		this.fromstationid = fromstationid;
	}

	public BigDecimal getOthterfee() {
		return othterfee;
	}

	public void setOthterfee(BigDecimal othterfee) {
		this.othterfee = othterfee;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public Long getReachstationid() {
		return reachstationid;
	}

	public void setReachstationid(Long reachstationid) {
		this.reachstationid = reachstationid;
	}

	public BigDecimal getStationservicefee() {
		return stationservicefee;
	}

	public void setStationservicefee(BigDecimal stationservicefee) {
		this.stationservicefee = stationservicefee;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public long getTicketnum() {
		return ticketnum;
	}

	public void setTicketnum(long ticketnum) {
		this.ticketnum = ticketnum;
	}

	public Long getTickettypeid() {
		return tickettypeid;
	}

	public void setTickettypeid(Long tickettypeid) {
		this.tickettypeid = tickettypeid;
	}

	public BigDecimal getTotalamount() {
		return totalamount;
	}

	public void setTotalamount(BigDecimal totalamount) {
		this.totalamount = totalamount;
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

	public Schedule getSchedule() {
		return schedule;
	}

	public void setSchedule(Schedule schedule) {
		this.schedule = schedule;
	}

	public BigDecimal getBalanceprice() {
		return balanceprice;
	}

	public void setBalanceprice(BigDecimal balanceprice) {
		this.balanceprice = balanceprice;
	}
	

}