package cn.nova.bus.price.model;

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
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import cn.nova.bus.balance.model.Balancedeductapply;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.system.model.Organization;
import cn.nova.utils.orm.listener.RemoveListenerForSync;
import cn.nova.utils.orm.listener.SyncCodeGenerate;

@Entity
@Table(name = "SCHEDULEPLAN")
@EntityListeners(value = { SyncCodeGenerate.class,RemoveListenerForSync.class })
public class Scheduleplan implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name = "SCHEDULEPLAN_ID_GENERATOR", sequenceName = "SEQ_SCHEDULEPLAN", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SCHEDULEPLAN_ID_GENERATOR")
	@Column(unique = true, nullable = false, precision = 10)
	private long id;

	@Column(nullable = false, precision = 4)
	private short autocancelreserveseatnum;

	@Column(nullable = false, precision = 10)
	private long createby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date createtime;

	@Temporal(TemporalType.DATE)
	@Column(nullable = false)
	private Date departdate;

	@Column(nullable = false, precision = 5)
	private int distance;

	@Column(nullable = false, length = 10)
	private String districttype;

	@Column(nullable = false, precision = 10)
	private long endstationid;

	@Column(length = 5)
	private String endtime;

	private String remarks;

	@Column(nullable = false, precision = 4)
	private short fixedreserveseatnum;

	@Column(nullable = false, precision = 5)
	private int highdistance;

	@Column(nullable = false, precision = 1)
	private boolean iscanmixcheck;

	@Column(nullable = false, precision = 1)
	private boolean islinework;

	@Column(nullable = false, precision = 1)
	private boolean isoriginator;

	@Column(nullable = false, precision = 1)
	private boolean isovertime;

	@Column(nullable = false, precision = 1)
	private boolean isproprietary;

	@Column(nullable = false, precision = 1)
	private boolean issaleafterreport;

	@Column(nullable = false, precision = 1)
	private boolean issellable;

	@Column(nullable = false, precision = 1)
	private boolean issellreturnticket;

	@Column(nullable = false, precision = 10)
	private long orgid;

	@Column(nullable = false, precision = 4, scale = 1)
	private BigDecimal runtime;

	@Column(nullable = false, precision = 10)
	private long scheduleid;

	@Column(nullable = false, length = 10)
	private String scheduletype;

	@Column(nullable = false, precision = 4)
	private short seatnum;

	@Column(nullable = false, precision = 4)
	private short soldeatnum;

	@Column(nullable = false, precision = 4)
	private short carrychildnum;

	@Column(nullable = false, precision = 4)
	private short spacinginterval;

	@Column(nullable = false, precision = 10)
	private long startstationid;

	@Column(nullable = false, length = 5)
	private String starttime;

	@Column(nullable = false, precision = 4)
	private short unautocancelreserveseatnum;

	@Column(precision = 10, nullable = false)
	private Long updateby;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date updatetime;

	@Column(nullable = false, length = 10)
	private String worktype;

	@Column(nullable = false, length = 10)
	private String workways;

	@Column(nullable = false, length = 40)
	private String synccode;
	/*
	@ManyToOne
	@JoinColumn(name = "stationfeeapplyid", nullable = true)
	private Balancedeductapply stationfeeapply;

	@ManyToOne
	@JoinColumn(name = "fueladditionfeeapplyid", nullable = true)
	private Balancedeductapply fueladditionfeeapply;*/

	private Long stationfeeapplyid;
	
	public Long getStationfeeapplyid() {
		return stationfeeapplyid;
	}

	public void setStationfeeapplyid(Long stationfeeapplyid) {
		this.stationfeeapplyid = stationfeeapplyid;
	}

	public Long getFueladditionfeeapplyid() {
		return fueladditionfeeapplyid;
	}

	public void setFueladditionfeeapplyid(Long fueladditionfeeapplyid) {
		this.fueladditionfeeapplyid = fueladditionfeeapplyid;
	}

	private Long fueladditionfeeapplyid;
	
	
	@OneToMany(cascade = { CascadeType.ALL }, fetch = FetchType.LAZY, mappedBy = "scheduleplan")
	private List<Ticketprice> ticketpricelist;

	@OneToMany(cascade = { CascadeType.ALL }, fetch = FetchType.LAZY, mappedBy = "scheduleplan")
	private List<Schedulestatus> schedulestatuslist;

	@OneToMany(cascade = { CascadeType.ALL }, fetch = FetchType.LAZY, mappedBy = "scheduleplan")
	private List<Scheduleseats> scheduleseatslist;

	@OneToMany(cascade = { CascadeType.ALL }, fetch = FetchType.LAZY, mappedBy = "scheduleplan")
	private List<Schedulevehiclepeopleplan> schedulevehiclepeopleplanlist;

	/*	public Balancedeductapply getFueladditionfeeapply() {
		return fueladditionfeeapply;
	}

	public void setFueladditionfeeapply(Balancedeductapply fueladditionfeeapply) {
		this.fueladditionfeeapply = fueladditionfeeapply;
	}*/
	/**
	 * 报到序号
	 */
	private int reportorderno;
	
	@Transient
	private int cursoldeatnum;

	@Transient
	private int curcarrychildnum;
	
	public int getCursoldeatnum() {
		return cursoldeatnum;
	}

	public void setCursoldeatnum(int cursoldeatnum) {
		this.cursoldeatnum = cursoldeatnum;
	}

	public int getCurcarrychildnum() {
		return curcarrychildnum;
	}

	public void setCurcarrychildnum(int curcarrychildnum) {
		this.curcarrychildnum = curcarrychildnum;
	}



	public void setSynccode(String synccode) {
		this.synccode = synccode;
	}

	public String getSynccode() {
		return synccode;
	}

	public List<Schedulevehiclepeopleplan> getSchedulevehiclepeopleplanlist() {
		return schedulevehiclepeopleplanlist;
	}

	public void setSchedulevehiclepeopleplanlist(
			List<Schedulevehiclepeopleplan> schedulevehiclepeopleplanlist) {
		this.schedulevehiclepeopleplanlist = schedulevehiclepeopleplanlist;
	}

	public List<Schedulestatus> getSchedulestatuslist() {
		return schedulestatuslist;
	}

	public void setSchedulestatuslist(List<Schedulestatus> schedulestatuslist) {
		this.schedulestatuslist = schedulestatuslist;
	}

	public List<Scheduleseats> getScheduleseatslist() {
		return scheduleseatslist;
	}

	public void setScheduleseatslist(List<Scheduleseats> scheduleseatslist) {
		this.scheduleseatslist = scheduleseatslist;
	}

	public List<Ticketprice> getTicketpricelist() {
		return ticketpricelist;
	}

	public void setTicketpricelist(List<Ticketprice> ticketpricelist) {
		this.ticketpricelist = ticketpricelist;
	}

	public Scheduleplan() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public short getAutocancelreserveseatnum() {
		return autocancelreserveseatnum;
	}

	public void setAutocancelreserveseatnum(short autocancelreserveseatnum) {
		this.autocancelreserveseatnum = autocancelreserveseatnum;
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

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public int getDistance() {
		return distance;
	}

	public void setDistance(int distance) {
		this.distance = distance;
	}

	public String getDistricttype() {
		return districttype;
	}

	public void setDistricttype(String districttype) {
		this.districttype = districttype;
	}

	public long getEndstationid() {
		return endstationid;
	}

	public void setEndstationid(long endstationid) {
		this.endstationid = endstationid;
	}

	public String getEndtime() {
		return endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}

	public short getFixedreserveseatnum() {
		return fixedreserveseatnum;
	}

	public void setFixedreserveseatnum(short fixedreserveseatnum) {
		this.fixedreserveseatnum = fixedreserveseatnum;
	}

	public int getHighdistance() {
		return highdistance;
	}

	public void setHighdistance(int highdistance) {
		this.highdistance = highdistance;
	}

	public boolean getIscanmixcheck() {
		return iscanmixcheck;
	}

	public void setIscanmixcheck(boolean iscanmixcheck) {
		this.iscanmixcheck = iscanmixcheck;
	}

	public boolean getIslinework() {
		return islinework;
	}

	public void setIslinework(boolean islinework) {
		this.islinework = islinework;
	}

	public boolean getIsoriginator() {
		return isoriginator;
	}

	public void setIsoriginator(boolean isoriginator) {
		this.isoriginator = isoriginator;
	}

	public boolean getIsovertime() {
		return isovertime;
	}

	public void setIsovertime(boolean isovertime) {
		this.isovertime = isovertime;
	}

	public boolean getIsproprietary() {
		return isproprietary;
	}

	public void setIsproprietary(boolean isproprietary) {
		this.isproprietary = isproprietary;
	}

	public boolean getIssaleafterreport() {
		return issaleafterreport;
	}

	public void setIssaleafterreport(boolean issaleafterreport) {
		this.issaleafterreport = issaleafterreport;
	}

	public boolean getIssellable() {
		return issellable;
	}

	public void setIssellable(boolean issellable) {
		this.issellable = issellable;
	}

	public boolean getIssellreturnticket() {
		return issellreturnticket;
	}

	public void setIssellreturnticket(boolean issellreturnticket) {
		this.issellreturnticket = issellreturnticket;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public BigDecimal getRuntime() {
		return runtime;
	}

	public void setRuntime(BigDecimal runtime) {
		this.runtime = runtime;
	}

	public long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public String getScheduletype() {
		return scheduletype;
	}

	public void setScheduletype(String scheduletype) {
		this.scheduletype = scheduletype;
	}

	public short getSeatnum() {
		return seatnum;
	}

	public void setSeatnum(short seatnum) {
		this.seatnum = seatnum;
	}

	public short getSoldeatnum() {
		return soldeatnum;
	}

	public void setSoldeatnum(short soldeatnum) {
		this.soldeatnum = soldeatnum;
	}

	public short getSpacinginterval() {
		return spacinginterval;
	}

	public void setSpacinginterval(short spacinginterval) {
		this.spacinginterval = spacinginterval;
	}

	public long getStartstationid() {
		return startstationid;
	}

	public void setStartstationid(long startstationid) {
		this.startstationid = startstationid;
	}

	public String getStarttime() {
		return starttime;
	}

	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}

	public short getUnautocancelreserveseatnum() {
		return unautocancelreserveseatnum;
	}

	public void setUnautocancelreserveseatnum(short unautocancelreserveseatnum) {
		this.unautocancelreserveseatnum = unautocancelreserveseatnum;
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

	public String getWorktype() {
		return worktype;
	}

	public void setWorktype(String worktype) {
		this.worktype = worktype;
	}

	public String getWorkways() {
		return workways;
	}

	public void setWorkways(String workways) {
		this.workways = workways;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public void setCarrychildnum(short carrychildnum) {
		this.carrychildnum = carrychildnum;
	}

	public short getCarrychildnum() {
		return carrychildnum;
	}
/*
	public Balancedeductapply getStationfeeapply() {
		return stationfeeapply;
	}

	public void setStationfeeapply(Balancedeductapply stationfeeapply) {
		this.stationfeeapply = stationfeeapply;
	}*/

	public int getReportorderno() {
		return reportorderno;
	}

	public void setReportorderno(int reportorderno) {
		this.reportorderno = reportorderno;
	}
	
}