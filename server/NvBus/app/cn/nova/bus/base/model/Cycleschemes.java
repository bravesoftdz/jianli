package cn.nova.bus.base.model;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * The persistent class for the CYCLESCHEMES database table.
 * 
 */
@Entity
public class Cycleschemes implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "CYCLESCHEMES_ID_GENERATOR", sequenceName="SEQ_CYCLESCHEMES",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "CYCLESCHEMES_ID_GENERATOR")
	private long id;

	private Long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	@Override
	public String toString() {
		return "Cyclescheme [id=" + id + ", createby=" + createby
				+ ", createtime=" + createtime + ", drivernum=" + drivernum
				+ ", driverperiod=" + driverperiod + ", driverstep="
				+ driverstep + ", enddate=" + enddate + ", name=" + name
				+ ", startdate=" + startdate + ", stewardnum=" + stewardnum
				+ ", stewardperiod=" + stewardperiod + ", stewardstep="
				+ stewardstep + ", updateby=" + updateby + ", updatetime="
				+ updatetime + ", vehicleperiod=" + vehicleperiod
				+ ", vehiclestep=" + vehiclestep + ", orgid=" + orgid
				+ ", schedulecycles=" + schedulecycles + "]";
	}

	private byte drivernum;

	private byte driverperiod;

	private byte driverstep;

	@Temporal(TemporalType.DATE)
	private Date enddate;

	private String name;

	@Temporal(TemporalType.DATE)
	private Date startdate;

	private byte stewardnum;

	private byte stewardperiod;

	private byte stewardstep;

	private Long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private byte vehicleperiod;

	private byte vehiclestep;
	
	private Long orgid;

	private long routeid;
	

	public long getRouteid() {
		return routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}

	@OneToMany(cascade = { CascadeType.REFRESH,CascadeType.REMOVE }, mappedBy = "cyclescheme")
	private Set<Schedulecycle> schedulecycles;

	public Set<Schedulecycle> getSchedulecycles() {
		return schedulecycles;
	}

	public void setSchedulecycles(Set<Schedulecycle> schedulecycles) {
		this.schedulecycles = schedulecycles;
	}

	public Cycleschemes() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Long getOrgid() {
		return orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
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

	public Byte getDrivernum() {
		return this.drivernum;
	}

	public void setDrivernum(Byte drivernum) {
		this.drivernum = drivernum;
	}

	public Byte getDriverperiod() {
		return this.driverperiod;
	}

	public void setDriverperiod(Byte driverperiod) {
		this.driverperiod = driverperiod;
	}

	public Byte getDriverstep() {
		return this.driverstep;
	}

	public void setDriverstep(Byte driverstep) {
		this.driverstep = driverstep;
	}

	public Date getEnddate() {
		return this.enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getStartdate() {
		return this.startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public Byte getStewardnum() {
		return this.stewardnum;
	}

	public void setStewardnum(Byte stewardnum) {
		this.stewardnum = stewardnum;
	}

	public Byte getStewardperiod() {
		return this.stewardperiod;
	}

	public void setStewardperiod(Byte stewardperiod) {
		this.stewardperiod = stewardperiod;
	}

	public Byte getStewardstep() {
		return this.stewardstep;
	}

	public void setStewardstep(Byte stewardstep) {
		this.stewardstep = stewardstep;
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

	public Byte getVehicleperiod() {
		return this.vehicleperiod;
	}

	public void setVehicleperiod(Byte vehicleperiod) {
		this.vehicleperiod = vehicleperiod;
	}

	public Byte getVehiclestep() {
		return this.vehiclestep;
	}

	public void setVehiclestep(Byte vehiclestep) {
		this.vehiclestep = vehiclestep;
	}

}