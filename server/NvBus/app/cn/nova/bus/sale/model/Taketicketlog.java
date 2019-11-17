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

/**
 * The persistent class for the TAKETICKETLOG database table.
 * 
 */
@Entity
@Table(name = "TAKETICKETLOG")
public class Taketicketlog implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@SequenceGenerator(name = "TAKETICKETLOG_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "TAKETICKETLOG_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;
	private String sellorgname;
	private String schorgname;
	private String ticketno;
	private Date departdate;
	private String departtime;
	private String schcode;
	private String departstationname;
	private String reachstationname;
	private String tickettypename;
	private BigDecimal ticketprice;
	private long seatno;
	private String orderno;
	private String password;
	private String customername;
	private String certificateno;
	private String mobilephone;

	@Temporal(TemporalType.TIMESTAMP)
	private Date selltime;

	@Temporal(TemporalType.TIMESTAMP)
	private Date taketime;
	private String takeway;
	private String status;
	private String operatorname;
	private String operatorgname;
	private String ticketoutletsname;
	private String takecompute;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;
	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;
	private long updateby;
	private String remark;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getSellorgname() {
		return sellorgname;
	}

	public void setSellorgname(String sellorgname) {
		this.sellorgname = sellorgname;
	}

	public String getSchorgname() {
		return schorgname;
	}

	public void setSchorgname(String schorgname) {
		this.schorgname = schorgname;
	}

	public String getTicketno() {
		return ticketno;
	}

	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public String getDeparttime() {
		return departtime;
	}

	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}

	public String getSchcode() {
		return schcode;
	}

	public void setSchcode(String schcode) {
		this.schcode = schcode;
	}

	public String getDepartstationname() {
		return departstationname;
	}

	public void setDepartstationname(String departstationname) {
		this.departstationname = departstationname;
	}

	public String getReachstationname() {
		return reachstationname;
	}

	public void setReachstationname(String reachstationname) {
		this.reachstationname = reachstationname;
	}

	public String getTickettypename() {
		return tickettypename;
	}

	public void setTickettypename(String tickettypename) {
		this.tickettypename = tickettypename;
	}

	public BigDecimal getTicketprice() {
		return ticketprice;
	}

	public void setTicketprice(BigDecimal ticketprice) {
		this.ticketprice = ticketprice;
	}

	public long getSeatno() {
		return seatno;
	}

	public void setSeatno(long seatno) {
		this.seatno = seatno;
	}

	public String getOrderno() {
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getCustomername() {
		return customername;
	}

	public void setCustomername(String customername) {
		this.customername = customername;
	}

	public String getCertificateno() {
		return certificateno;
	}

	public void setCertificateno(String certificateno) {
		this.certificateno = certificateno;
	}

	public String getMobilephone() {
		return mobilephone;
	}

	public void setMobilephone(String mobilephone) {
		this.mobilephone = mobilephone;
	}

	public Date getSelltime() {
		return selltime;
	}

	public void setSelltime(Date selltime) {
		this.selltime = selltime;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getOperatorname() {
		return operatorname;
	}

	public void setOperatorname(String operatorname) {
		this.operatorname = operatorname;
	}

	public String getOperatorgname() {
		return operatorgname;
	}

	public void setOperatorgname(String operatorgname) {
		this.operatorgname = operatorgname;
	}

	public String getTicketoutletsname() {
		return ticketoutletsname;
	}

	public void setTicketoutletsname(String ticketoutletsname) {
		this.ticketoutletsname = ticketoutletsname;
	}

	public String getTakecompute() {
		return takecompute;
	}

	public void setTakecompute(String takecompute) {
		this.takecompute = takecompute;
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

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}
