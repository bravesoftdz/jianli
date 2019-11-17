package cn.nova.bus.dispatch.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "FINGERCACHE")
public class FingerCache {
	
	@Id
	@SequenceGenerator(name="FINGERCACHE_ID_GENERATOR", sequenceName="SEQ_PUB",allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="FINGERCACHE_ID_GENERATOR")
	@Column(name = "ID", unique = true, nullable = false, precision = 10, scale = 0)
	private long id;
	
	private long vehicleid;
	
	private long driverorstewardid;
	
	private String driverorstewardname;
	
	private String driverorstewardmark;//驾驶员或乘务员标记，1为驾驶员，2为乘务员
	
	@Temporal( TemporalType.DATE)
	private Date savedate;
	
	private Long orgid;
	
	@Temporal( TemporalType.TIMESTAMP)
	private Date createtime ;
	
	@Temporal( TemporalType.TIMESTAMP)
	private Date updatetime ;
	
	private Long createby;
	
	private Long updateby;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public long getDriverorstewardid() {
		return driverorstewardid;
	}

	public void setDriverorstewardid(long driverorstewardid) {
		this.driverorstewardid = driverorstewardid;
	}

	public String getDriverorstewardname() {
		return driverorstewardname;
	}

	public void setDriverorstewardname(String driverorstewardname) {
		this.driverorstewardname = driverorstewardname;
	}

	public String getDriverorstewardmark() {
		return driverorstewardmark;
	}

	public void setDriverorstewardmark(String driverorstewardmark) {
		this.driverorstewardmark = driverorstewardmark;
	}

	public Date getSavedate() {
		return savedate;
	}

	public void setSavedate(Date savedate) {
		this.savedate = savedate;
	}

	public Long getOrgid() {
		return orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
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

	public Long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}
}
