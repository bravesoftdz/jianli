package cn.nova.bus.price.model;

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


/**
 * The persistent class for the STATIONHOLIDAYPRICE database table.
 * 
 */
@Entity
public class Stationholidayprice implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="STATIONHOLIDAYPRICE_ID_GENERATOR", sequenceName="SEQ_TICKETPRICE",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="STATIONHOLIDAYPRICE_ID_GENERATOR")
	private long id;

	private BigDecimal createby;

    @Temporal( TemporalType.DATE)
	private Date createtime;

	private BigDecimal departstationid;

    @Temporal( TemporalType.DATE)
	private Date enddate;

	private BigDecimal fullprice;

	private BigDecimal halfprice;

	private BigDecimal holidayid;

	private BigDecimal orgid;

	private BigDecimal reachstationid;

    @Temporal( TemporalType.DATE)
	private Date startdate;

	private BigDecimal studentprice;

	private BigDecimal updateby;

    @Temporal( TemporalType.DATE)
	private Date updatetime;

    public Stationholidayprice() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public BigDecimal getCreateby() {
		return this.createby;
	}

	public void setCreateby(BigDecimal createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public BigDecimal getDepartstationid() {
		return this.departstationid;
	}

	public void setDepartstationid(BigDecimal departstationid) {
		this.departstationid = departstationid;
	}

	public Date getEnddate() {
		return this.enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public BigDecimal getFullprice() {
		return this.fullprice;
	}

	public void setFullprice(BigDecimal fullprice) {
		this.fullprice = fullprice;
	}

	public BigDecimal getHalfprice() {
		return this.halfprice;
	}

	public void setHalfprice(BigDecimal halfprice) {
		this.halfprice = halfprice;
	}

	public BigDecimal getHolidayid() {
		return this.holidayid;
	}

	public void setHolidayid(BigDecimal holidayid) {
		this.holidayid = holidayid;
	}

	public BigDecimal getOrgid() {
		return this.orgid;
	}

	public void setOrgid(BigDecimal orgid) {
		this.orgid = orgid;
	}

	public BigDecimal getReachstationid() {
		return this.reachstationid;
	}

	public void setReachstationid(BigDecimal reachstationid) {
		this.reachstationid = reachstationid;
	}

	public Date getStartdate() {
		return this.startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public BigDecimal getStudentprice() {
		return this.studentprice;
	}

	public void setStudentprice(BigDecimal studentprice) {
		this.studentprice = studentprice;
	}

	public BigDecimal getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(BigDecimal updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

}