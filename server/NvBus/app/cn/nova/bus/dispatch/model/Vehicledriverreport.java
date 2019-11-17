package cn.nova.bus.dispatch.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
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

import cn.nova.bus.balance.model.Balance;

@Entity
public class Vehicledriverreport implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "VEHICLER_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "VEHICLER_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	private long id;

	private long vehiclereportid;

	private long scheduleid;

	@Temporal(TemporalType.DATE)
	private Date departdate;

	@Temporal(TemporalType.TIMESTAMP)
	private Date reporttime;

	private String vehicleno;

	private String drivername;

	private String ddrivinglicenseres;

	private String dqualificationres;

	private String vdriverlicenseres;

	private String vworknores;

	private String vroadnores;

	private String dworknores;

	private String vnotenum;

	private short rationseatnum;

	private long acttickets;

	private String driversign;

	@Transient
	private String drivername2;
	@Transient
	private String ddrivinglicenseres2;
	@Transient
	private String dqualificationres2;
	@Transient
	private String dworknores2;
	@Transient
	private String driversign2;

	private String classmember;

	private String dispatcher;

	private String stewardname;

	private long orgid;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private long updateby;

	private long driverid;

	private boolean isdeparted;

	private String departtime;
	
	private long scheduleplanid;
	
	
	public long getScheduleplanid() {
		return scheduleplanid;
	}

	public void setScheduleplanid(long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	public String getDeparttime() {
		return departtime;
	}

	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}

	public boolean isIsdeparted() {
		return isdeparted;
	}

	public void setIsdeparted(boolean isdeparted) {
		this.isdeparted = isdeparted;
	}

	public long getDriverid() {
		return driverid;
	}

	public void setDriverid(long driverid) {
		this.driverid = driverid;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getVehiclereportid() {
		return vehiclereportid;
	}

	public void setVehiclereportid(long vehiclereportid) {
		this.vehiclereportid = vehiclereportid;
	}

	public long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public Date getReporttime() {
		return reporttime;
	}

	public void setReporttime(Date reporttime) {
		this.reporttime = reporttime;
	}

	public String getVehicleno() {
		return vehicleno;
	}

	public void setVehicleno(String vehicleno) {
		this.vehicleno = vehicleno;
	}

	public String getDrivername() {
		return drivername;
	}

	public void setDrivername(String drivername) {
		this.drivername = drivername;
	}

	public String getDdrivinglicenseres() {
		return ddrivinglicenseres;
	}

	public void setDdrivinglicenseres(String ddrivinglicenseres) {
		this.ddrivinglicenseres = ddrivinglicenseres;
	}

	public String getDqualificationres() {
		return dqualificationres;
	}

	public void setDqualificationres(String dqualificationres) {
		this.dqualificationres = dqualificationres;
	}

	public String getVdriverlicenseres() {
		return vdriverlicenseres;
	}

	public void setVdriverlicenseres(String vdriverlicenseres) {
		this.vdriverlicenseres = vdriverlicenseres;
	}

	public String getVworknores() {
		return vworknores;
	}

	public void setVworknores(String vworknores) {
		this.vworknores = vworknores;
	}

	public String getVroadnores() {
		return vroadnores;
	}

	public void setVroadnores(String vroadnores) {
		this.vroadnores = vroadnores;
	}

	public String getDworknores() {
		return dworknores;
	}

	public void setDworknores(String dworknores) {
		this.dworknores = dworknores;
	}

	public String getVnotenum() {
		return vnotenum;
	}

	public void setVnotenum(String vnotenum) {
		this.vnotenum = vnotenum;
	}

	public short getRationseatnum() {
		return rationseatnum;
	}

	public void setRationseatnum(short rationseatnum) {
		this.rationseatnum = rationseatnum;
	}

	public long getActtickets() {
		return acttickets;
	}

	public void setActtickets(long acttickets) {
		this.acttickets = acttickets;
	}

	public String getDriversign() {
		return driversign;
	}

	public void setDriversign(String driversign) {
		this.driversign = driversign;
	}

	public String getClassmember() {
		return classmember;
	}

	public void setClassmember(String classmember) {
		this.classmember = classmember;
	}

	public String getDispatcher() {
		return dispatcher;
	}

	public void setDispatcher(String dispatcher) {
		this.dispatcher = dispatcher;
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

	public String getStewardname() {
		return stewardname;
	}

	public void setStewardname(String stewardname) {
		this.stewardname = stewardname;
	}

	public String getDrivername2() {
		return drivername2;
	}

	public void setDrivername2(String drivername2) {
		this.drivername2 = drivername2;
	}

	public String getDdrivinglicenseres2() {
		return ddrivinglicenseres2;
	}

	public void setDdrivinglicenseres2(String ddrivinglicenseres2) {
		this.ddrivinglicenseres2 = ddrivinglicenseres2;
	}

	public String getDqualificationres2() {
		return dqualificationres2;
	}

	public void setDqualificationres2(String dqualificationres2) {
		this.dqualificationres2 = dqualificationres2;
	}

	public String getDworknores2() {
		return dworknores2;
	}

	public void setDworknores2(String dworknores2) {
		this.dworknores2 = dworknores2;
	}

	public String getDriversign2() {
		return driversign2;
	}

	public void setDriversign2(String driversign2) {
		this.driversign2 = driversign2;
	}

}
