package cn.nova.bus.dispatch.model;

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
 * The persistent class for the ROADBILLPRINT database table.
 * 
 */
@Entity
public class Roadbillprint implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "ROADBILLPRINT_ID_GENERATOR", sequenceName = "SEQ_VEHICLEREPORT", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ROADBILLPRINT_ID_GENERATOR")
	private long id;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private long orgid;

	private String roadbillno;

	private long vehiclereportid;

	private short validateday;

	private long printby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date printtime;

	private String remark;
	
	private BigDecimal waybillnumber;    //路单编号

	public Roadbillprint() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
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

	public long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public String getRoadbillno() {
		return this.roadbillno;
	}

	public void setRoadbillno(String roadbillno) {
		this.roadbillno = roadbillno;
	}

	public long getVehiclereportid() {
		return this.vehiclereportid;
	}

	public void setVehiclereportid(long vehiclereportid) {
		this.vehiclereportid = vehiclereportid;
	}

	public short getValidateday() {
		return validateday;
	}

	public void setValidateday(short validateday) {
		this.validateday = validateday;
	}

	public long getPrintby() {
		return printby;
	}

	public void setPrintby(long printby) {
		this.printby = printby;
	}

	public Date getPrinttime() {
		return printtime;
	}

	public void setPrinttime(Date printtime) {
		this.printtime = printtime;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public BigDecimal getWaybillnumber() {
		return waybillnumber;
	}

	public void setWaybillnumber(BigDecimal waybillnumber) {
		this.waybillnumber = waybillnumber;
	}



}