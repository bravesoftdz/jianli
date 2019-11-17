package cn.nova.bus.report.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
public class Invoicesidx implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@SequenceGenerator(name = "INVOICESIDX_ID_GENERATOR", sequenceName = "SEQ_REPORT", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "INVOICESIDX_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;

	private String datatype;

	private String schtype;

	@Column(nullable = false)
	private Long orgid;

	@Temporal(TemporalType.DATE)
	private Date departdate;

	private String totalamount;

	private Integer planschnum;

	private Integer actschnum;

	private Integer laterschnum;

	private Integer seats;

	private Integer canceltickets;

	private Long totalpeopledistance;

	private Integer routes;

	private Integer ticketnum;

	private BigDecimal totalincome;

	private Long peopledistance;

	private Long selltickets;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private Long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private Long updateby;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getDatatype() {
		return datatype;
	}

	public void setDatatype(String datatype) {
		this.datatype = datatype;
	}

	public String getSchtype() {
		return schtype;
	}

	public void setSchtype(String schtype) {
		this.schtype = schtype;
	}

	public Long getOrgid() {
		return orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public String getTotalamount() {
		return totalamount;
	}

	public void setTotalamount(String totalamount) {
		this.totalamount = totalamount;
	}

	public Integer getPlanschnum() {
		return planschnum;
	}

	public void setPlanschnum(Integer planschnum) {
		this.planschnum = planschnum;
	}

	public Integer getActschnum() {
		return actschnum;
	}

	public void setActschnum(Integer actschnum) {
		this.actschnum = actschnum;
	}

	public Integer getLaterschnum() {
		return laterschnum;
	}

	public void setLaterschnum(Integer laterschnum) {
		this.laterschnum = laterschnum;
	}

	public Integer getSeats() {
		return seats;
	}

	public void setSeats(Integer seats) {
		this.seats = seats;
	}

	public Integer getCanceltickets() {
		return canceltickets;
	}

	public void setCanceltickets(Integer canceltickets) {
		this.canceltickets = canceltickets;
	}

	public Long getTotalpeopledistance() {
		return totalpeopledistance;
	}

	public void setTotalpeopledistance(Long totalpeopledistance) {
		this.totalpeopledistance = totalpeopledistance;
	}

	public Integer getRoutes() {
		return routes;
	}

	public void setRoutes(Integer routes) {
		this.routes = routes;
	}

	public Integer getTicketnum() {
		return ticketnum;
	}

	public void setTicketnum(Integer ticketnum) {
		this.ticketnum = ticketnum;
	}

	public BigDecimal getTotalincome() {
		return totalincome;
	}

	public void setTotalincome(BigDecimal totalincome) {
		this.totalincome = totalincome;
	}

	public Long getPeopledistance() {
		return peopledistance;
	}

	public void setPeopledistance(Long peopledistance) {
		this.peopledistance = peopledistance;
	}

	public Long getSelltickets() {
		return selltickets;
	}

	public void setSelltickets(Long selltickets) {
		this.selltickets = selltickets;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Long getCreateby() {
		return createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public Long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

	
}
