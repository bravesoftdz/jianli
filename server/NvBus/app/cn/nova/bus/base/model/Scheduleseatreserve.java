package cn.nova.bus.base.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.utils.orm.listener.AuditLogListener;

/**
 * 
 * <p>
 * Title: 班次座位固定预留信息
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2011
 * </p>
 * <p>
 * Company: nova
 * </p>
 * 
 * @author lanckun
 * @version 0.1
 */
@Entity
@EntityListeners({ AuditLogListener.class })
public class Scheduleseatreserve implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "SCHEDULESEATRESERVE_ID_GENERATOR", sequenceName = "SEQ_SCHEDULESEATRESERVE", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SCHEDULESEATRESERVE_ID_GENERATOR")
	private long id;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	@Temporal(TemporalType.DATE)
	private Date enddate;

	private boolean isactive;

	private long scheduleid;

	private String seatnos;

	private Short seatnum;

	@Temporal(TemporalType.DATE)
	private Date startdate;

	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private long vehicletypeid;

	private long vehiclebrandmodelid;

	private String remarks;

	public Scheduleseatreserve() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Long getCreateby() {
		return this.createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Date getEnddate() {
		return this.enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public boolean getIsactive() {
		return this.isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public Long getScheduleid() {
		return this.scheduleid;
	}

	public void setScheduleid(Long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public String getSeatnos() {
		return this.seatnos;
	}

	public void setSeatnos(String seatnos) {
		this.seatnos = seatnos;
	}

	public Short getSeatnum() {
		return this.seatnum;
	}

	public void setSeatnum(Short seatnum) {
		this.seatnum = seatnum;
	}

	public Date getStartdate() {
		return this.startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public Long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public Long getVehicletypeid() {
		return this.vehicletypeid;
	}

	public void setVehicletypeid(Long vehicletypeid) {
		this.vehicletypeid = vehicletypeid;
	}

	public long getVehiclebrandmodelid() {
		return vehiclebrandmodelid;
	}

	public void setVehiclebrandmodelid(long vehiclebrandmodelid) {
		this.vehiclebrandmodelid = vehiclebrandmodelid;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
}