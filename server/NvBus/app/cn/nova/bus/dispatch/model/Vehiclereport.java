package cn.nova.bus.dispatch.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import play.data.binding.As;

import cn.nova.bus.archive.model.Driver;
import cn.nova.bus.archive.model.Steward;



/**
 * The persistent class for the VEHICLEREPORT database table.
 * 
 */
@Entity
public class Vehiclereport implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="VEHICLEREPORT_ID_GENERATOR", sequenceName="SEQ_VEHICLEREPORT",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="VEHICLEREPORT_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	private long id;

	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

    @Temporal( TemporalType.DATE)
	private Date departdate;

	@JoinColumn(name = "DRIVER1ID", nullable = true)
	@OneToOne
	private Driver driver1;
	
	@JoinColumn(name = "DRIVER2ID", nullable = true)
	@OneToOne
	private Driver driver2;	


	
	@JoinColumn(name = "DRIVER3ID", nullable = true)
	@OneToOne
	private Driver driver3;

	@JoinColumn(name = "DRIVER4ID", nullable = true)
	@OneToOne
	private Driver driver4;

	@JoinColumn(name = "STEWARD1ID", nullable = true)
	@OneToOne
	private Steward steward1;
	
	@JoinColumn(name = "STEWARD2ID", nullable = true)
	@OneToOne
	private Steward steward2;	
	
	private boolean isactive;

	private short orderno;

	private long orgid;

	private long reportorgid;

    @Temporal( TemporalType.TIMESTAMP)
	private Date reporttime;

	private String reportway;

	private long scheduleid;

	private long scheduleplanid;

	private long updateby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date updatetime;

	private long vehicleid;
	
	
	private boolean isdeparted;
	
	private boolean isreplace;
	
	@Transient
	private long balanceunitid;
	
	

	public long getBalanceunitid() {
		return balanceunitid;
	}

	public void setBalanceunitid(long balanceunitid) {
		this.balanceunitid = balanceunitid;
	}

	public boolean isIsdeparted() {
		return isdeparted;
	}

	public void setIsdeparted(boolean isdeparted) {
		this.isdeparted = isdeparted;
	}

	//该字段作为记录的操作类型字段，不对数据库表进行映射
    @Transient
	private String flag;
    
    //用作判断是否是临时车牌
    @Transient
	private boolean isTempVehicle;
    //用作是晚点时输入原因
    @Transient
	private String reason;
    
   
    public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public boolean getIsTempVehicle() {
		return isTempVehicle;
	}

	public void setIsTempVehicle(boolean isTempVehicle) {
		this.isTempVehicle = isTempVehicle;
	}

	@Transient
	private long vehiclebrandid;
    


	public long getVehiclebrandid() {
		return vehiclebrandid;
	}

	public void setVehiclebrandid(long vehiclebrandid) {
		this.vehiclebrandid = vehiclebrandid;
	}

	@Transient
	private long unitid;
    
    public long getUnitid() {
		return unitid;
	}

	public void setUnitid(long unitid) {
		this.unitid = unitid;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public Vehiclereport() {
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

	public Date getDepartdate() {
		return this.departdate;
	}

	@As("yyyy-MM-dd HH:mm:ss")
	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public boolean getIsactive() {
		return this.isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public short getOrderno() {
		return this.orderno;
	}

	public void setOrderno(short orderno) {
		this.orderno = orderno;
	}

	public long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public long getReportorgid() {
		return this.reportorgid;
	}

	public void setReportorgid(long reportorgid) {
		this.reportorgid = reportorgid;
	}

	public Date getReporttime() {
		return this.reporttime;
	}

	public void setReporttime(Date reporttime) {
		this.reporttime = reporttime;
	}

	public String getReportway() {
		return this.reportway;
	}

	public void setReportway(String reportway) {
		this.reportway = reportway;
	}

	public long getScheduleid() {
		return this.scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public long getScheduleplanid() {
		return this.scheduleplanid;
	}

	public void setScheduleplanid(long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
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

	public long getVehicleid() {
		return this.vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}
	public Driver getDriver1() {
		return driver1;
	}

	public void setDriver1(Driver driver1) {
		this.driver1 = driver1;
	}

	public Driver getDriver2() {
		return driver2;
	}

	public void setDriver2(Driver driver2) {
		this.driver2 = driver2;
	}

	public Driver getDriver3() {
		return driver3;
	}

	public void setDriver3(Driver driver3) {
		this.driver3 = driver3;
	}

	public Driver getDriver4() {
		return driver4;
	}

	public void setDriver4(Driver driver4) {
		this.driver4 = driver4;
	}

	public Steward getSteward1() {
		return steward1;
	}

	public void setSteward1(Steward steward1) {
		this.steward1 = steward1;
	}

	public Steward getSteward2() {
		return steward2;
	}

	public void setSteward2(Steward steward2) {
		this.steward2 = steward2;
	}

	public boolean isIsreplace() {
		return isreplace;
	}

	public void setIsreplace(boolean isreplace) {
		this.isreplace = isreplace;
	}
	

}