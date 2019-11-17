package cn.nova.bus.base.model;

import java.io.Serializable;
import java.math.BigDecimal;
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
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.utils.orm.listener.AuditLogListener;
import cn.nova.utils.orm.listener.SyncCodeGenerate;

/**
 * 
 * <p>
 * Title: 班次停靠点信息
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2011
 * </p>
 * <p>
 * Company: nova
 * </p>
 * 
 * @author lanckun
 * @version 0.1
 */
@Entity
@Table(name = "SCHEDULESTOP")
@EntityListeners({ SyncCodeGenerate.class})
public class Schedulestop implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "SCHEDULESTOP_ID_GENERATOR", sequenceName = "SEQ_SCHEDULESTOP", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SCHEDULESTOP_ID_GENERATOR")
	private long id;

	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private String departtime;

	private boolean isactive;

	private boolean isdepart;

	private int orderno;

	private BigDecimal runtime;

	private long stationid;

	private String remark1;

	private String remark2;

	private String remark3;

	private String remark4;

	private String remark5;

	@Column(nullable = false, length = 40)
	private String synccode;

	@JoinColumn(name = "TICKETENTRANCEID", nullable = true)
	@OneToOne(cascade = { CascadeType.REFRESH })
	private Ticketentrance ticketentrance;

	public Ticketentrance getTicketentrance() {
		return ticketentrance;
	}

	public void setTicketentrance(Ticketentrance ticketentrance) {
		this.ticketentrance = ticketentrance;
	}

	private boolean issellable;

	private long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	@JoinColumn(name = "VEHCILEPARKID", nullable = true)
	@OneToOne(cascade = { CascadeType.REFRESH })
	private Vehiclepark vehiclepark;

	public Vehiclepark getVehiclepark() {
		return vehiclepark;
	}

	public void setVehiclepark(Vehiclepark vehiclepark) {
		this.vehiclepark = vehiclepark;
	}

	@ManyToOne
	@JoinColumn(name = "SCHEDULEID", nullable = false)
	private Schedule schedule;

	// 该字段不对数据库表进行映射
	// private Long scheduleid;
	// private Long vehicleparkid;
	// private String stationname;
	// private String ticketentrance;

	public Schedule getSchedule() {
		return schedule;
	}

	public void setSchedule(Schedule schedule) {
		this.schedule = schedule;
	}

	public Schedulestop() {
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

	public String getDeparttime() {
		return this.departtime;
	}

	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}

	public boolean getIsactive() {
		return this.isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public boolean getIsdepart() {
		return this.isdepart;
	}

	public void setIsdepart(boolean isdepart) {
		this.isdepart = isdepart;
	}

	public int getOrderno() {
		return this.orderno;
	}

	public void setOrderno(int orderno) {
		this.orderno = orderno;
	}

	public BigDecimal getRuntime() {
		return this.runtime;
	}

	public void setRuntime(BigDecimal runtime) {
		this.runtime = runtime;
	}

	public long getStationid() {
		return this.stationid;
	}

	public void setStationid(long stationid) {
		this.stationid = stationid;
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

	public boolean isIssellable() {
		return issellable;
	}

	public void setIssellable(boolean issellable) {
		this.issellable = issellable;
	}

	public String getRemark1() {
		return remark1;
	}

	public void setRemark1(String remark1) {
		this.remark1 = remark1;
	}

	public String getRemark2() {
		return remark2;
	}

	public void setRemark2(String remark2) {
		this.remark2 = remark2;
	}

	public String getRemark3() {
		return remark3;
	}

	public void setRemark3(String remark3) {
		this.remark3 = remark3;
	}

	public String getRemark4() {
		return remark4;
	}

	public void setRemark4(String remark4) {
		this.remark4 = remark4;
	}

	public String getRemark5() {
		return remark5;
	}

	public void setRemark5(String remark5) {
		this.remark5 = remark5;
	}

	public String getSynccode() {
		return synccode;
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}
}