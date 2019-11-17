package cn.nova.bus.base.vo;

import java.math.BigDecimal;
import java.util.Date;

import cn.nova.bus.base.model.Vehiclepark;

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

public class SchedulestopVo {

	private long id;

	private long createby;

	private Date createtime;

	private String departtime;

	private boolean isactive;

	private boolean isdepart;

	private byte orderno;

	private BigDecimal runtime;

	private long stationid;

	private String remark1;

	private String remark2;

	private String remark3;

	private String remark4;

	private String remark5;

	private String synccode;

	private Long ticketentranceid;

	private boolean issellable;

	private long updateby;

	private Date updatetime;

	private Long vehicleparkid;

	private long scheduleid;

	private String stationname;
	private String ticketentrance;
	private String opertype;
	private String vehiclepark;

	public SchedulestopVo() {
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getCreateby() {
		return createby;
	}

	public void setCreateby(long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getDeparttime() {
		return departtime;
	}

	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}

	public boolean isIsactive() {
		return isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public boolean isIsdepart() {
		return isdepart;
	}

	public void setIsdepart(boolean isdepart) {
		this.isdepart = isdepart;
	}

	public byte getOrderno() {
		return orderno;
	}

	public void setOrderno(byte orderno) {
		this.orderno = orderno;
	}

	public BigDecimal getRuntime() {
		return runtime;
	}

	public void setRuntime(BigDecimal runtime) {
		this.runtime = runtime;
	}

	public long getStationid() {
		return stationid;
	}

	public void setStationid(long stationid) {
		this.stationid = stationid;
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

	public Long getTicketentranceid() {
		return ticketentranceid;
	}

	public void setTicketentranceid(Long ticketentranceid) {
		this.ticketentranceid = ticketentranceid;
	}

	public boolean isIssellable() {
		return issellable;
	}

	public void setIssellable(boolean issellable) {
		this.issellable = issellable;
	}

	public long getUpdateby() {
		return updateby;
	}

	public void setUpdateby(long updateby) {
		this.updateby = updateby;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public Long getVehicleparkid() {
		return vehicleparkid;
	}

	public void setVehicleparkid(Long vehicleparkid) {
		this.vehicleparkid = vehicleparkid;
	}

	public long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public String getStationname() {
		return stationname;
	}

	public void setStationname(String stationname) {
		this.stationname = stationname;
	}

	public String getTicketentrance() {
		return ticketentrance;
	}

	public void setTicketentrance(String ticketentrance) {
		this.ticketentrance = ticketentrance;
	}

	public String getOpertype() {
		return opertype;
	}

	public void setOpertype(String opertype) {
		this.opertype = opertype;
	}

	public String getVehiclepark() {
		return vehiclepark;
	}

	public void setVehiclepark(String vehiclepark) {
		this.vehiclepark = vehiclepark;
	}

}