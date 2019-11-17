package cn.nova.bus.check.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * The persistent class for the SECURITYCHECK database table. 
 * 车辆安检记录表
 */
@Entity
public class Securitycheck implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="SECURITYCHECK_ID_GENERATOR", sequenceName="SEQ_SECURITYCHECK",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="SECURITYCHECK_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	private long id;

	private String brake;

	private Long checkby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date checktime;

	private Long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private String drive;

	private String hang;

	private String leak;

	private String light;

	private String mirror;

	private String notenum;

	private Long orgid;

	private String result;

	private String safety;

	private String turn;

	private Long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private Long vehicleid;

	private String wheel;

	private String window;
	
	private String remarks;
	
	private String periodtype;
	
	private String camera;
	
	private String returncheck;
	
	private Long driverid;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date rechecktime;

	private String securityfee;
	
	private int reprinttimes; //#11365 车辆安检通知单重打次数
	
	public String getSecurityfee() {
		return securityfee;
	}

	public void setSecurityfee(String securityfee) {
		this.securityfee = securityfee;
	}

	public Securitycheck() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getBrake() {
		return brake;
	}

	public void setBrake(String brake) {
		this.brake = brake;
	}

	public Long getCheckby() {
		return checkby;
	}

	public void setCheckby(Long checkby) {
		this.checkby = checkby;
	}

	public Date getChecktime() {
		return checktime;
	}

	public void setChecktime(Date checktime) {
		this.checktime = checktime;
	}

	public Long getCreateby() {
		return createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getDrive() {
		return drive;
	}

	public void setDrive(String drive) {
		this.drive = drive;
	}

	public String getHang() {
		return hang;
	}

	public void setHang(String hang) {
		this.hang = hang;
	}

	public String getLeak() {
		return leak;
	}

	public void setLeak(String leak) {
		this.leak = leak;
	}

	public String getLight() {
		return light;
	}

	public void setLight(String light) {
		this.light = light;
	}

	public String getMirror() {
		return mirror;
	}

	public void setMirror(String mirror) {
		this.mirror = mirror;
	}

	public String getNotenum() {
		return notenum;
	}

	public void setNotenum(String notenum) {
		this.notenum = notenum;
	}

	public Long getOrgid() {
		return orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getSafety() {
		return safety;
	}

	public void setSafety(String safety) {
		this.safety = safety;
	}

	public String getTurn() {
		return turn;
	}

	public void setTurn(String turn) {
		this.turn = turn;
	}

	public Long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public Long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(Long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public String getWheel() {
		return wheel;
	}

	public void setWheel(String wheel) {
		this.wheel = wheel;
	}

	public String getWindow() {
		return window;
	}

	public void setWindow(String window) {
		this.window = window;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getPeriodtype() {
		return periodtype;
	}

	public void setPeriodtype(String periodtype) {
		this.periodtype = periodtype;
	}

	public String getCamera() {
		return camera;
	}

	public void setCamera(String camera) {
		this.camera = camera;
	}

	public String getReturncheck() {
		return returncheck;
	}

	public void setReturncheck(String returncheck) {
		this.returncheck = returncheck;
	}

	public Date getRechecktime() {
		return rechecktime;
	}

	public void setRechecktime(Date rechecktime) {
		this.rechecktime = rechecktime;
	}

	public Long getDriverid() {
		return driverid;
	}

	public void setDriverid(Long driverid) {
		this.driverid = driverid;
	}

	public int getReprinttimes() {
		return reprinttimes;
	}

	public void setReprinttimes(int reprinttimes) {
		this.reprinttimes = reprinttimes;
	}
	

}