package cn.nova.bus.base.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.alibaba.fastjson.annotation.JSONField;

import cn.nova.utils.orm.listener.AuditLogListener;
import cn.nova.utils.orm.listener.SyncCodeGenerate;

/**
 * 
 * <p>
 * Title: 班次信息
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
@EntityListeners({ SyncCodeGenerate.class, AuditLogListener.class })
public class Schedule implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "SCHEDULE_ID_GENERATOR", sequenceName = "SEQ_SCHEDULE", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SCHEDULE_ID_GENERATOR")
	@Column(nullable = false, unique = true)
	private long id;


	private String code;

	private Long createby;

	@Temporal(TemporalType.TIMESTAMP)
	private Date createtime;

	private boolean isautoreport;
	
	private String districttype;


	private boolean isactive;


	private boolean isaudited;


	private boolean isauditpass;


	private boolean iscanmixcheck;


	private boolean islinework;


	private boolean isoriginator;


	private boolean isovertime;


	private boolean isproprietary;


	private boolean issaleafterreport;


	private boolean issellreturnticket;

	private Long orgid;


	private Short planseatnum;

	private String printinfo;

	private String remarks;


	private BigDecimal runtime;


	private String starttime;


	private String type;

	private long updateby;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatetime;

	private String viastation;


	private String worktype;


	private String workways;

	private String endtime;


	private Short spacinginterval;
	
	private String endstation;
	
	private BigDecimal startstationprice;


	@ManyToOne
	@JSONField(serialize=false)
	@JoinColumn(name = "ROUTEID", nullable = false)
	private Route route;

	@OneToMany(cascade = { CascadeType.ALL }, fetch = FetchType.LAZY, mappedBy = "schedule")
	private List<Schedulestop> schedulestop;

	// 该字段不对数据库表进行映射
	@Transient
	private Long ticketentranceid;
	// 该字段不对数据库表进行映射

	@Transient
	private Long vehcileparkid;

	// 不进行映射。是否编辑同线路其他班次
	@Transient
	private boolean isEditOtherSchedule;


	private String synccode;

	private boolean isfixseat;

	private boolean isneedfinger;

	private Short driverfingernum;
	
	private boolean isdelete;
	
	public boolean isIsfixseat() {
		return isfixseat;
	}

	public void setIsfixseat(boolean isfixseat) {
		this.isfixseat = isfixseat;
	}

	public Schedule() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
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

	public String getDistricttype() {
		return this.districttype;
	}

	public void setDistricttype(String districttype) {
		this.districttype = districttype;
	}

	public boolean getIsactive() {
		return this.isactive;
	}

	public void setIsactive(boolean isactive) {
		this.isactive = isactive;
	}

	public boolean getIsaudited() {
		return this.isaudited;
	}

	public void setIsaudited(boolean isaudited) {
		this.isaudited = isaudited;
	}

	public boolean getIsauditpass() {
		return this.isauditpass;
	}

	public void setIsauditpass(boolean isauditpass) {
		this.isauditpass = isauditpass;
	}

	public boolean getIscanmixcheck() {
		return this.iscanmixcheck;
	}

	public void setIscanmixcheck(boolean iscanmixcheck) {
		this.iscanmixcheck = iscanmixcheck;
	}

	public boolean getIslinework() {
		return this.islinework;
	}

	public void setIslinework(boolean islinework) {
		this.islinework = islinework;
	}

	public boolean getIsoriginator() {
		return this.isoriginator;
	}

	public void setIsoriginator(boolean isoriginator) {
		this.isoriginator = isoriginator;
	}

	public boolean getIsovertime() {
		return this.isovertime;
	}

	public void setIsovertime(boolean isovertime) {
		this.isovertime = isovertime;
	}

	public boolean getIsproprietary() {
		return this.isproprietary;
	}

	public void setIsproprietary(boolean isproprietary) {
		this.isproprietary = isproprietary;
	}

	public boolean getIssaleafterreport() {
		return this.issaleafterreport;
	}

	public void setIssaleafterreport(boolean issaleafterreport) {
		this.issaleafterreport = issaleafterreport;
	}

	public boolean getIssellreturnticket() {
		return this.issellreturnticket;
	}

	public void setIssellreturnticket(boolean issellreturnticket) {
		this.issellreturnticket = issellreturnticket;
	}

	public Long getOrgid() {
		return this.orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	public Short getPlanseatnum() {
		return this.planseatnum;
	}

	public void setPlanseatnum(Short planseatnum) {
		this.planseatnum = planseatnum;
	}

	public String getPrintinfo() {
		return this.printinfo;
	}

	public void setPrintinfo(String printinfo) {
		this.printinfo = printinfo;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public BigDecimal getRuntime() {
		return this.runtime;
	}

	public void setRuntime(BigDecimal runtime) {
		this.runtime = runtime;
	}

	public String getStarttime() {
		return this.starttime;
	}

	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
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

	public String getViastation() {
		return this.viastation;
	}

	public void setViastation(String viastation) {
		this.viastation = viastation;
	}

	public String getWorktype() {
		return this.worktype;
	}

	public void setWorktype(String worktype) {
		this.worktype = worktype;
	}

	public String getWorkways() {
		return this.workways;
	}

	public void setWorkways(String workways) {
		this.workways = workways;
	}

	public List<Schedulestop> getSchedulestop() {
		return schedulestop;
	}

	public void setSchedulestop(List<Schedulestop> schedulestop) {
		this.schedulestop = schedulestop;
	}

	public Long getTicketentranceid() {
		return ticketentranceid;
	}

	public void setTicketentranceid(Long ticketentranceid) {
		this.ticketentranceid = ticketentranceid;
	}

	public Long getVehcileparkid() {
		return vehcileparkid;
	}

	public void setVehcileparkid(Long vehcileparkid) {
		this.vehcileparkid = vehcileparkid;
	}

	public Route getRoute() {
		return route;
	}

	public void setRoute(Route route) {
		this.route = route;
	}

	public String getEndtime() {
		return endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}

	public Short getSpacinginterval() {
		return spacinginterval;
	}

	public void setSpacinginterval(Short spacinginterval) {
		this.spacinginterval = spacinginterval;
	}

	public String getSynccode() {
		return synccode;
	}

	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

	public Boolean getIsEditOtherSchedule() {
		return isEditOtherSchedule;
	}

	public void setIsEditOtherSchedule(Boolean isEditOtherSchedule) {
		this.isEditOtherSchedule = isEditOtherSchedule;
	}

	public boolean getIsneedfinger() {
		return isneedfinger;
	}

	public void setIsneedfinger(boolean isneedfinger) {
		this.isneedfinger = isneedfinger;
	}

	public Short getDriverfingernum() {
		return driverfingernum;
	}

	public void setDriverfingernum(Short driverfingernum) {
		this.driverfingernum = driverfingernum;
	}

	public String getEndstation() {
		return endstation;
	}

	public void setEndstation(String endstation) {
		this.endstation = endstation;
	}

	public BigDecimal getStartstationprice() {
		return startstationprice;
	}

	public void setStartstationprice(BigDecimal startstationprice) {
		this.startstationprice = startstationprice;
	}

	public boolean isIsdelete() {
		return isdelete;
	}

	public void setIsdelete(boolean isdelete) {
		this.isdelete = isdelete;
	}

	public boolean isIsautoreport() {
		return isautoreport;
	}

	public void setIsautoreport(boolean isautoreport) {
		this.isautoreport = isautoreport;
	}
	
	
	
}