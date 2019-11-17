package cn.nova.bus.base.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import cn.nova.utils.orm.listener.AuditLogListener;
import cn.nova.utils.orm.listener.SyncCodeGenerate;
@Entity
@Table(name = "SETDRIVERVEHICLE")
@EntityListeners({ SyncCodeGenerate.class, AuditLogListener.class })
public class SetDriverVehicle implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@SequenceGenerator(name = "SETDRIVERVEHICLE_ID_GENERATOR", sequenceName = "SEQ_PUB", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SETDRIVERVEHICLE_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;
	
	@Column(precision = 10, nullable = false)
	private Long orgid;
	
	@Column(precision = 10, nullable = false)
	private Long vehicleid;
	
	@Column(precision = 10, nullable = false)
	private Long driverid;
	
	@Column(length = 100)
	private String remark;
	
	@Column(nullable = false, precision = 10)
	private Long createby;		//创建人
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date createtime;		//创建时间
	
	@Column(precision=10, nullable=false)
	private Long updateby;		//修改人
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date updatetime;		//修改时间
	
	@Transient
	private String vehicleids;

	public long getId() {
		return id;
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

	public Long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(Long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public Long getDriverid() {
		return driverid;
	}

	public void setDriverid(Long driverid) {
		this.driverid = driverid;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
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

	public String getVehicleids() {
		return vehicleids;
	}

	public void setVehicleids(String vehicleids) {
		this.vehicleids = vehicleids;
	}

	
}
