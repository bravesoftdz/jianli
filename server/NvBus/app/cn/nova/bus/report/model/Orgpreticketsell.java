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


@Entity
public class Orgpreticketsell implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="ORGPRETICKETSELL_ID_GENERATOR", sequenceName="SEQ_REPORT")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="ORGPRETICKETSELL_ID_GENERATOR")
	private long id;

  @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

  @Temporal( TemporalType.DATE)
	private Date departdate;

	private BigDecimal eticketfee;

	private BigDecimal eticketmoney;

	private long eticketnum;

	private long orgid;

	private BigDecimal presycticketmoney;

	private long presynticketnum;

	private BigDecimal preticketmoney;

	private long preticketnum;

  @Temporal( TemporalType.DATE)
	private Date saledate;

	private long scheduleorgid;

  @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

  public Orgpreticketsell() {
  }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Date getDepartdate() {
		return this.departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
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

	public BigDecimal getPresycticketmoney() {
		return this.presycticketmoney;
	}

	public void setPresycticketmoney(BigDecimal presycticketmoney) {
		this.presycticketmoney = presycticketmoney;
	}

	public long getPresynticketnum() {
		return this.presynticketnum;
	}

	public void setPresynticketnum(long presynticketnum) {
		this.presynticketnum = presynticketnum;
	}

	public BigDecimal getPreticketmoney() {
		return this.preticketmoney;
	}

	public void setPreticketmoney(BigDecimal preticketmoney) {
		this.preticketmoney = preticketmoney;
	}

	public long getPreticketnum() {
		return this.preticketnum;
	}

	public void setPreticketnum(long preticketnum) {
		this.preticketnum = preticketnum;
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

	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

}