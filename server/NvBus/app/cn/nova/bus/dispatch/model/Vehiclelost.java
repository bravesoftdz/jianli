package cn.nova.bus.dispatch.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import cn.nova.bus.base.model.Unit;
import cn.nova.bus.base.model.Vehicle;


/**
 * The persistent class for the VEHICLELOST database table.
 * 
 */
@Entity
public class Vehiclelost implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="VEHICLELOST_ID_GENERATOR", sequenceName="SEQ_VEHICLEREPORT",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="VEHICLELOST_ID_GENERATOR")
	private long id;

	private long balanceid;

	private long createby;

    @Temporal( TemporalType.TIMESTAMP)
	private Date createtime;

    @Temporal( TemporalType.DATE)
	private Date departdate;

	private BigDecimal forfeit;

	private boolean isautolost;

	private String reason;

	private long scheduleid;

	private long scheduleplanid;
	

	private long unitid;
	

	private String reportname ;

    private String status; 
    
    private String loststatus;
    
    

	public String getLoststatus() {
		return loststatus;
	}

	public void setLoststatus(String loststatus) {
		this.loststatus = loststatus;
	}

	@Transient
	private boolean ispunish;
	
	public boolean getIspunish() {
		return ispunish;
	}

	public void setIspunish(boolean ispunish) {
		this.ispunish = ispunish;
	}

	@JoinColumn(name = "VEHICLEID", nullable = true)
	@OneToOne
	private Vehicle vehicle;

	public Vehicle getVehicle() {
		return vehicle;
	}

	public void setVehicle(Vehicle vehicle) {
		this.vehicle = vehicle;
	}

	private long orgid;
	
    public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public Vehiclelost() {
    }

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getBalanceid() {
		return this.balanceid;
	}

	public void setBalanceid(long balanceid) {
		this.balanceid = balanceid;
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

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public BigDecimal getForfeit() {
		return this.forfeit;
	}

	public void setForfeit(BigDecimal forfeit) {
		this.forfeit = forfeit;
	}

	public boolean getIsautolost() {
		return this.isautolost;
	}

	public void setIsautolost(boolean isautolost) {
		this.isautolost = isautolost;
	}

	public String getReason() {
		return this.reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
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



	public String getReportname() {
		return reportname;
	}

	public void setReportname(String reportname) {
		this.reportname = reportname;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	

    
    public long getUnitid() {
		return unitid;
	}

	public void setUnitid(long unitid) {
		this.unitid = unitid;
	}
}