package cn.nova.bus.check.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.utils.orm.listener.AuditLogListener;
import cn.nova.utils.orm.listener.SyncCodeGenerate;

/**
 * The persistent class for the GPSCHECK database table. 
 * 车辆GPS检查
 */
@Entity
@EntityListeners({ SyncCodeGenerate.class, AuditLogListener.class })
public class Gpscheck {

	private static final long serialVersionUID = 1L;
	@Id
	@SequenceGenerator(name="GPSCHECK_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="GPSCHECK_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10 )
	private long id;
	
	@Column(nullable=false)
	private Long vehicleid;
	
	@Temporal(TemporalType.DATE)
	private Date checkdate;
	
	@Column(nullable=false, precision=10)
	private String checkresult;
	
	@Column( precision=100)
	private String remark;

	@Column(nullable=false, precision=10)
	private Long operater;

	@Column(nullable=false, precision=30)
	private String checkno;	

	@Column(nullable=false, precision=10)
	private Long orgid;
	
	@Column(nullable=false, precision=10)
	private Long updateby;
	
	@Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date updatetime;
	
	@Column(nullable=false, precision=10)
	private Long createby;
	
	@Temporal( TemporalType.TIMESTAMP)
	@Column(nullable=false)
	private Date createtime;
	
	public String getSynccode() {
		return synccode;
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

	private String synccode;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(Long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public Date getCheckdate() {
		return checkdate;
	}

	public void setCheckdate(Date checkdate) {
		this.checkdate = checkdate;
	}

	public String getCheckresult() {
		return checkresult;
	}

	public void setCheckresult(String checkresult) {
		this.checkresult = checkresult;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Long getOperater() {
		return operater;
	}

	public void setOperater(Long operater) {
		this.operater = operater;
	}

	public String getCheckno() {
		return checkno;
	}

	public void setCheckno(String checkno) {
		this.checkno = checkno;
	}

	public Long getOrgid() {
		return orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
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
	
}