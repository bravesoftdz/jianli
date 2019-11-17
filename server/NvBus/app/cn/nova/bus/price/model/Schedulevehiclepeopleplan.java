package cn.nova.bus.price.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.bus.archive.model.Driver;
import cn.nova.bus.archive.model.Steward;
import cn.nova.bus.base.model.Unit;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.utils.orm.listener.RemoveListenerForSync;
import cn.nova.utils.orm.listener.SyncCodeGenerate;

@Entity
@EntityListeners(value = { SyncCodeGenerate.class,RemoveListenerForSync.class })
public class Schedulevehiclepeopleplan implements Serializable {
	private static final long serialVersionUID = 2638464826797646563L;

	@Id
	@SequenceGenerator(name = "SCHEDULEVEHICLEPEOPLEPLAN_ID_GENERATOR", sequenceName = "SEQ_SCHEDULEVEHPLAN", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SCHEDULEVEHICLEPEOPLEPLAN_ID_GENERATOR")
	@Column(nullable = false, unique = false)
	private long id;

	@Column(nullable = false)
	private long createby;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	@Column(nullable = false)
	@Temporal(TemporalType.DATE)
	private Date departdate;

	@Column(nullable = false)
	private short orderno;

	@Column(nullable = false)
	private long orgid;

	@JoinColumn(name = "PLANDRIVER1ID", nullable = true)
	@OneToOne
	private Driver plandriver1;

	@JoinColumn(name = "PLANDRIVER2ID", nullable = true)
	@OneToOne
	private Driver plandriver2;

	@JoinColumn(name = "PLANDRIVER3ID", nullable = true)
	@OneToOne
	private Driver plandriver3;

	@JoinColumn(name = "PLANDRIVER4ID", nullable = true)
	@OneToOne
	private Driver plandriver4;

	@JoinColumn(name = "PLANSTEWARD1ID", nullable = true)
	@OneToOne
	private Steward plansteward1;

	@JoinColumn(name = "PLANSTEWARD2ID", nullable = true)
	@OneToOne
	private Steward plansteward2;

	@ManyToOne
	@JoinColumn(name = "planunitid", nullable = true)
	private Unit planunit;

	@Column(nullable = false)
	private long planvehiclebrandmodelid;

	@JoinColumn(name = "PLANVEHICLEID", nullable = true)
	@OneToOne
	private Vehicle planvehicle;

	@Column(nullable = false)
	private long planvehicletypeid;

	@Column(nullable = false)
	private long scheduleid;

	@JoinColumn(name = "SCHEDULEPLANID", nullable = false)
	@ManyToOne(cascade = { CascadeType.REFRESH, CascadeType.PERSIST })
	private Scheduleplan scheduleplan;

	@Column(nullable = false)
	private long updateby;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	@Column(nullable = false, length = 40)
	private String synccode;

	public Schedulevehiclepeopleplan() {
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

	public String getSynccode() {
		return synccode;
	}

	public Scheduleplan getScheduleplan() {
		return scheduleplan;
	}

	public void setScheduleplan(Scheduleplan scheduleplan) {
		this.scheduleplan = scheduleplan;
	}

	public Vehicle getPlanvehicle() {
		return planvehicle;
	}

	public void setPlanvehicle(Vehicle planvehicle) {
		this.planvehicle = planvehicle;
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

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
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

	public long getPlanvehicletypeid() {
		return this.planvehicletypeid;
	}

	public void setPlanvehicletypeid(long planvehicletypeid) {
		this.planvehicletypeid = planvehicletypeid;
	}

	public long getScheduleid() {
		return this.scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
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

	public Driver getPlandriver1() {
		return plandriver1;
	}

	public void setPlandriver1(Driver plandriver1) {
		this.plandriver1 = plandriver1;
	}

	public Driver getPlandriver2() {
		return plandriver2;
	}

	public void setPlandriver2(Driver plandriver2) {
		this.plandriver2 = plandriver2;
	}

	public Driver getPlandriver3() {
		return plandriver3;
	}

	public void setPlandriver3(Driver plandriver3) {
		this.plandriver3 = plandriver3;
	}

	public Driver getPlandriver4() {
		return plandriver4;
	}

	public void setPlandriver4(Driver plandriver4) {
		this.plandriver4 = plandriver4;
	}

	public Steward getPlansteward1() {
		return plansteward1;
	}

	public void setPlansteward1(Steward plansteward1) {
		this.plansteward1 = plansteward1;
	}

	public Steward getPlansteward2() {
		return plansteward2;
	}

	public void setPlansteward2(Steward plansteward2) {
		this.plansteward2 = plansteward2;
	}

	public Unit getPlanunit() {
		return planunit;
	}

	public void setPlanunit(Unit planunit) {
		this.planunit = planunit;
	}

	public long getPlanvehiclebrandmodelid() {
		return planvehiclebrandmodelid;
	}

	public void setPlanvehiclebrandmodelid(long planvehiclebrandmodelid) {
		this.planvehiclebrandmodelid = planvehiclebrandmodelid;
	}
}