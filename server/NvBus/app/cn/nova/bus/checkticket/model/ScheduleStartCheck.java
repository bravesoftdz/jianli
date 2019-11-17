package cn.nova.bus.checkticket.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;


@Entity
public class ScheduleStartCheck {	
	@Id
	@SequenceGenerator(name = "SCHEDULESTARTCHECK_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SCHEDULESTARTCHECK_ID_GENERATOR")
	private long id; 
	
	private long scheduleid ;
	
	private long vehicleid ;
	
	private long orgid ;
	
	private Date departdate ;
	
	private long driver1id ;
	
	 private long driver2id;
	 
	 private long driver3id;
	 
	 private long driver4id;
	 
	 private Date createtime;
	 
	 private long createby; 
	 
	 private Date updatetime; 
	 
	 private long updateby;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public long getDriver1id() {
		return driver1id;
	}

	public void setDriver1id(long driver1id) {
		this.driver1id = driver1id;
	}

	public long getDriver2id() {
		return driver2id;
	}

	public void setDriver2id(long driver2id) {
		this.driver2id = driver2id;
	}

	public long getDriver3id() {
		return driver3id;
	}

	public void setDriver3id(long driver3id) {
		this.driver3id = driver3id;
	}

	public long getDriver4id() {
		return driver4id;
	}

	public void setDriver4id(long driver4id) {
		this.driver4id = driver4id;
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
	 
	 
}
