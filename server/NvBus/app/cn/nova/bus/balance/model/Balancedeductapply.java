package cn.nova.bus.balance.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Unit;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.model.Userinfo;

/**
 * The persistent class for the BALANCEDEDUCTAPPLY database table.
 * 
 */
@Entity
public class Balancedeductapply implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "BALANCEDEDUCTAPPLY_ID_GENERATOR", sequenceName = "SEQ_BALANCE",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "BALANCEDEDUCTAPPLY_ID_GENERATOR")
	private long id;

	private long balancedeductitemid;

	private long balancededucttargetid;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	@Temporal(TemporalType.DATE)
	private Date enddate;

	private boolean isactive;

	private boolean isaudited;

	private boolean isauditpass;

	private String remarks;

	@JoinColumn(name = "ROUTEID", nullable = true)
	@ManyToOne(cascade = { CascadeType.REFRESH, CascadeType.PERSIST })
	private Route route;

	@JoinColumn(name = "SCHEDULEID", nullable = true)
	@ManyToOne(cascade = { CascadeType.REFRESH, CascadeType.PERSIST })
	private Schedule schedule;

	@Temporal(TemporalType.DATE)
	private Date startdate;

	@JoinColumn(name = "UNITID", nullable = true)
	@ManyToOne(cascade = { CascadeType.REFRESH, CascadeType.PERSIST })
	private Unit unit;

	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	@JoinColumn(name = "VEHCILEID", nullable = true)
	@ManyToOne(cascade = { CascadeType.REFRESH, CascadeType.PERSIST })
	private Vehicle vehicle;

	
	
	@JoinColumn(name = "AUDITOR", nullable = true)
	@ManyToOne(cascade = { CascadeType.REFRESH, CascadeType.PERSIST })
	private Userinfo auditor;
	
	@JoinColumn(name = "ORGID", nullable = true)
	@ManyToOne(cascade = { CascadeType.REFRESH, CascadeType.PERSIST })
	private Organization org;
	
	@Transient
	private String orgids;
	
	@Transient
	private String types;
	
	public String getTypes() {
		return types;
	}

	public void setTypes(String types) {
		this.types = types;
	}

	public String getOrgids() {
		return orgids;
	}

	public void setOrgids(String orgids) {
		this.orgids = orgids;
	}

	public Userinfo getAuditor() {
		return auditor;
	}

	public Organization getOrg() {
		return org;
	}

	public void setOrg(Organization org) {
		this.org = org;
	}

	public void setAuditor(Userinfo auditor) {
		this.auditor = auditor;
	}

	public Balancedeductapply() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getBalancedeductitemid() {
		return this.balancedeductitemid;
	}

	public void setBalancedeductitemid(long balancedeductitemid) {
		this.balancedeductitemid = balancedeductitemid;
	}

	public long getBalancededucttargetid() {
		return this.balancededucttargetid;
	}

	public void setBalancededucttargetid(long balancededucttargetid) {
		this.balancededucttargetid = balancededucttargetid;
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

	public boolean getIsaudited() {
		return this.isaudited;
	}

	public void setIsaudited(boolean isaudited) {
		this.isaudited = isaudited;
	}

	public boolean getIsauditpass() {
		return this.isauditpass;
	}

	public void setIsauditpass(boolean isauditpass) {
		this.isauditpass = isauditpass;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Date getStartdate() {
		return this.startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public Route getRoute() {
		return route;
	}

	public void setRoute(Route route) {
		this.route = route;
	}

	public Schedule getSchedule() {
		return schedule;
	}

	public void setSchedule(Schedule schedule) {
		this.schedule = schedule;
	}

	public Unit getUnit() {
		return unit;
	}

	public void setUnit(Unit unit) {
		this.unit = unit;
	}

	public Vehicle getVehicle() {
		return vehicle;
	}

	public void setVehicle(Vehicle vehicle) {
		this.vehicle = vehicle;
	}

}