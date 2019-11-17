package cn.nova.bus.balance.model;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

@Entity
public class Balancestationdeduct {
	@Id
	@SequenceGenerator(name = "BALANCEDESD_ID_GENERATOR", sequenceName = "SEQ_BALANCE", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "BALANCEDESD_ID_GENERATOR")
	private long id;

	private long stationid;

	private long vehicleid;

	private BigDecimal deductmoney;

	private long orgid;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private long updateby;

	@Transient
	private String opertype;

	@Transient
	private String name;

	@Transient
	private long ticketnum;

	@Transient
	private BigDecimal totalfee;

	public Balancestationdeduct() {

	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getStationid() {
		return stationid;
	}

	public void setStationid(long stationid) {
		this.stationid = stationid;
	}

	public long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public BigDecimal getDeductmoney() {
		return deductmoney;
	}

	public void setDeductmoney(BigDecimal deductmoney) {
		this.deductmoney = deductmoney;
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

	public String getOpertype() {
		return opertype;
	}

	public void setOpertype(String opertype) {
		this.opertype = opertype;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public long getTicketnum() {
		return ticketnum;
	}

	public void setTicketnum(long ticketnum) {
		this.ticketnum = ticketnum;
	}

	public BigDecimal getTotalfee() {
		return totalfee;
	}

	public void setTotalfee(BigDecimal totalfee) {
		this.totalfee = totalfee;
	}
}
