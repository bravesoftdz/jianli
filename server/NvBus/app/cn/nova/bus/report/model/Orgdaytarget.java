package cn.nova.bus.report.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.bus.system.model.Organization;
import cn.nova.utils.business.BusinessFieldType;


@Entity
public class Orgdaytarget implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="ORGDAYTARGET_ID_GENERATOR", sequenceName="SEQ_REPORT")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="ORGDAYTARGET_ID_GENERATOR")
	private long id;

	private BigDecimal additionfee;

	private BigDecimal cancelmoney;

	private long cancelnum;

	private BigDecimal computefee;

	private BigDecimal coolairfee;

	@Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

	private BigDecimal eticketfee;

	private BigDecimal eticketmoney;

	private long eticketnum;

	private long orgid;

	private BigDecimal preinvoiceamount;

	private long preinvoicesnum;

	private long preticketnum;

	private BigDecimal pretotalamount;

	private BigDecimal returnhandcharge;

	private BigDecimal returnmoney;

	private long returnnum;

  @Temporal( TemporalType.DATE)
	private Date saledate;

	private long scheduleorgid;

	private BigDecimal servicefee;

	private BigDecimal stationservicefee;

	private BigDecimal syncadditionfee;

	private BigDecimal synccancelmoney;

	private long synccancelnum;

	private BigDecimal synccomputefee;

	private BigDecimal synccoolairfee;

	private long syncpreticketnum;

	private BigDecimal syncpretotalamount;

	private BigDecimal syncreturnhandcharge;

	private BigDecimal syncreturnmoney;

	private long syncreturnnum;

	private BigDecimal syncservicefee;

	private BigDecimal syncstationservicefee;

	private long syncticketnum;

	private BigDecimal synctotalamount;

	private long ticketnum;

	private BigDecimal totalamount;

  @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

  public Orgdaytarget() {
  }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public BigDecimal getAdditionfee() {
		return this.additionfee;
	}

	public void setAdditionfee(BigDecimal additionfee) {
		this.additionfee = additionfee;
	}

	public BigDecimal getCancelmoney() {
		return this.cancelmoney;
	}

	public void setCancelmoney(BigDecimal cancelmoney) {
		this.cancelmoney = cancelmoney;
	}

	public long getCancelnum() {
		return this.cancelnum;
	}

	public void setCancelnum(long cancelnum) {
		this.cancelnum = cancelnum;
	}

	public BigDecimal getComputefee() {
		return this.computefee;
	}

	public void setComputefee(BigDecimal computefee) {
		this.computefee = computefee;
	}

	public BigDecimal getCoolairfee() {
		return this.coolairfee;
	}

	public void setCoolairfee(BigDecimal coolairfee) {
		this.coolairfee = coolairfee;
	}

	public BigDecimal getEticketfee() {
		return this.eticketfee;
	}

	public void setEticketfee(BigDecimal eticketfee) {
		this.eticketfee = eticketfee;
	}

	public BigDecimal getEticketmoney() {
		return this.eticketmoney;
	}

	public void setEticketmoney(BigDecimal eticketmoney) {
		this.eticketmoney = eticketmoney;
	}

	public long getEticketnum() {
		return this.eticketnum;
	}

	public void setEticketnum(long eticketnum) {
		this.eticketnum = eticketnum;
	}

	public long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public BigDecimal getPreinvoiceamount() {
		return this.preinvoiceamount;
	}

	public void setPreinvoiceamount(BigDecimal preinvoiceamount) {
		this.preinvoiceamount = preinvoiceamount;
	}

	public long getPreinvoicesnum() {
		return this.preinvoicesnum;
	}

	public void setPreinvoicesnum(long preinvoicesnum) {
		this.preinvoicesnum = preinvoicesnum;
	}

	public long getPreticketnum() {
		return this.preticketnum;
	}

	public void setPreticketnum(long preticketnum) {
		this.preticketnum = preticketnum;
	}

	public BigDecimal getPretotalamount() {
		return this.pretotalamount;
	}

	public void setPretotalamount(BigDecimal pretotalamount) {
		this.pretotalamount = pretotalamount;
	}

	public BigDecimal getReturnhandcharge() {
		return this.returnhandcharge;
	}

	public void setReturnhandcharge(BigDecimal returnhandcharge) {
		this.returnhandcharge = returnhandcharge;
	}

	public BigDecimal getReturnmoney() {
		return this.returnmoney;
	}

	public void setReturnmoney(BigDecimal returnmoney) {
		this.returnmoney = returnmoney;
	}

	public long getReturnnum() {
		return this.returnnum;
	}

	public void setReturnnum(long returnnum) {
		this.returnnum = returnnum;
	}

	public Date getSaledate() {
		return this.saledate;
	}

	public void setSaledate(Date saledate) {
		this.saledate = saledate;
	}

	public long getScheduleorgid() {
		return this.scheduleorgid;
	}

	public void setScheduleorgid(long scheduleorgid) {
		this.scheduleorgid = scheduleorgid;
	}

	public BigDecimal getServicefee() {
		return this.servicefee;
	}

	public void setServicefee(BigDecimal servicefee) {
		this.servicefee = servicefee;
	}

	public BigDecimal getStationservicefee() {
		return this.stationservicefee;
	}

	public void setStationservicefee(BigDecimal stationservicefee) {
		this.stationservicefee = stationservicefee;
	}

	public BigDecimal getSyncadditionfee() {
		return this.syncadditionfee;
	}

	public void setSyncadditionfee(BigDecimal syncadditionfee) {
		this.syncadditionfee = syncadditionfee;
	}

	public BigDecimal getSynccancelmoney() {
		return this.synccancelmoney;
	}

	public void setSynccancelmoney(BigDecimal synccancelmoney) {
		this.synccancelmoney = synccancelmoney;
	}

	public long getSynccancelnum() {
		return this.synccancelnum;
	}

	public void setSynccancelnum(long synccancelnum) {
		this.synccancelnum = synccancelnum;
	}

	public BigDecimal getSynccomputefee() {
		return this.synccomputefee;
	}

	public void setSynccomputefee(BigDecimal synccomputefee) {
		this.synccomputefee = synccomputefee;
	}

	public BigDecimal getSynccoolairfee() {
		return this.synccoolairfee;
	}

	public void setSynccoolairfee(BigDecimal synccoolairfee) {
		this.synccoolairfee = synccoolairfee;
	}

	public long getSyncpreticketnum() {
		return this.syncpreticketnum;
	}

	public void setSyncpreticketnum(long syncpreticketnum) {
		this.syncpreticketnum = syncpreticketnum;
	}

	public BigDecimal getSyncpretotalamount() {
		return this.syncpretotalamount;
	}

	public void setSyncpretotalamount(BigDecimal syncpretotalamount) {
		this.syncpretotalamount = syncpretotalamount;
	}

	public BigDecimal getSyncreturnhandcharge() {
		return this.syncreturnhandcharge;
	}

	public void setSyncreturnhandcharge(BigDecimal syncreturnhandcharge) {
		this.syncreturnhandcharge = syncreturnhandcharge;
	}

	public BigDecimal getSyncreturnmoney() {
		return this.syncreturnmoney;
	}

	public void setSyncreturnmoney(BigDecimal syncreturnmoney) {
		this.syncreturnmoney = syncreturnmoney;
	}

	public long getSyncreturnnum() {
		return this.syncreturnnum;
	}

	public void setSyncreturnnum(long syncreturnnum) {
		this.syncreturnnum = syncreturnnum;
	}

	public BigDecimal getSyncservicefee() {
		return this.syncservicefee;
	}

	public void setSyncservicefee(BigDecimal syncservicefee) {
		this.syncservicefee = syncservicefee;
	}

	public BigDecimal getSyncstationservicefee() {
		return this.syncstationservicefee;
	}

	public void setSyncstationservicefee(BigDecimal syncstationservicefee) {
		this.syncstationservicefee = syncstationservicefee;
	}

	public long getSyncticketnum() {
		return this.syncticketnum;
	}

	public void setSyncticketnum(long syncticketnum) {
		this.syncticketnum = syncticketnum;
	}

	public BigDecimal getSynctotalamount() {
		return this.synctotalamount;
	}

	public void setSynctotalamount(BigDecimal synctotalamount) {
		this.synctotalamount = synctotalamount;
	}

	public long getTicketnum() {
		return this.ticketnum;
	}

	public void setTicketnum(long ticketnum) {
		this.ticketnum = ticketnum;
	}

	public BigDecimal getTotalamount() {
		return this.totalamount;
	}

	public void setTotalamount(BigDecimal totalamount) {
		this.totalamount = totalamount;
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