/**
 * 
 */
package cn.nova.bus.sale.remote.param;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * @author ice
 * 查询班次结果类 单条记录
 */
@Entity
public class ParamDepartSchedule implements Serializable {

	private static final long serialVersionUID = -811240038309332191L;
	
	private Date departdate;//发车日期  
	private String schedulecode;// 班次编号                                               
	private String schedulesynccode;
	private String departtime;// 发车时间(“HH:mm”24小时字符串格式;如“13：15”)                             
	private String departstationcode;// 发车站编码                                           
	private String reachstationcode;// 到达站编码
	private String departstationname;// 发车站名称                                           
	private String reachstationname;// 到达站名称
	private String reachstationsecondname;
	private String startstationname;
	private String endstationname;

	private String buspark;// 乘车卡位  可为空                                                        
	private String seattypecode;// 座位类型                                                        
	private String seattypename;// 座位类型名称                                                    

//	private String fullpricecode;//全票编码
	private BigDecimal fullprice;// 全票价格                                                   
//	private String halfpricecode;// 半票编码                                                      
	private BigDecimal halfprice;// 半价票价格                                                    
//	private String studentpricecode;// 学生票编码                                                   
	private BigDecimal studentprice;// 学生票价格                                                 
	
	private BigDecimal runtime;//运行时长 （小时）
	
	private Date updatetime; //更新时间                                                                
	
	
	@Id
	private long id;
	private long carrychildnum;
	private long endstationid;
	private long orgid; //班次所属机构
	private long scheduleid;
	private long scheduleplanid;
	private long departstationid;
	private long reachstationid;
	private long routeid;
	private long residuecarrychildnum;
	private long startstationid;
	
	private boolean issellable;//是否可售
	private boolean isoriginator;
	private boolean issaleafterreport;
	private boolean isreported;
	private boolean isdeparted;
	private boolean islinework;
	private boolean isovertime;
	private boolean isproprietary;
	private boolean issellreturnticket;
	private boolean isbegincheck;
	private boolean isemptyvehicle;
	private boolean isroundtrip;
	
	private String districttype;
	private String endtime;
	private String remarks;
	private String scheduletype;
	private String starttime;
	private String worktype;
	private String workways;
	
	private String status;
	private String ticketentrance;
	private String seatnos;
	private String seattype;

	private int distance;  //发车站跟到站里程（公里）        
	private int balancedistance;
	
	private short spacinginterval;
	private short unautocancelreserveseatnum;
	private short fixedreserveseatnum;
	private short autocancelreserveseatnum;
	private short seatnum;//剩余座位数                                                   
	private short soldeatnum;
	private short residueseatnum;
	private short returntripvaliddays;

	private BigDecimal stationservicefee;
	private BigDecimal fueladditionfee;
	private BigDecimal toplimitprice;
	private BigDecimal lowerlimitprice;
	private BigDecimal moreprice;			

	private String routename;
	private String scheduleremarks;
	private String planvehicletype;
	private String planvehiclegrade;
	private String planvehicletypecustomname;
	private Long planvheicletypeid;
	private String planvehicleno;
	private Long planvehicleid;
	private String planunitname; 
	private Long planunitid;
	private String planbrandmodel;
	private Long planbrandmodelid;
	
	/**
	 * @return the departdate
	 */
	public Date getDepartdate() {
		return departdate;
	}
	/**
	 * @param departdate the departdate to set
	 */
	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}
	/**
	 * @return the schedulecode
	 */
	public String getSchedulecode() {
		return schedulecode;
	}
	/**
	 * @param schedulecode the schedulecode to set
	 */
	public void setSchedulecode(String schedulecode) {
		this.schedulecode = schedulecode;
	}
	/**
	 * @return the schedulesynccode
	 */
	public String getSchedulesynccode() {
		return schedulesynccode;
	}
	/**
	 * @param schedulesynccode the schedulesynccode to set
	 */
	public void setSchedulesynccode(String schedulesynccode) {
		this.schedulesynccode = schedulesynccode;
	}
	/**
	 * @return the departtime
	 */
	public String getDeparttime() {
		return departtime;
	}
	/**
	 * @param departtime the departtime to set
	 */
	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}
	/**
	 * @return the departstationcode
	 */
	public String getDepartstationcode() {
		return departstationcode;
	}
	/**
	 * @param departstationcode the departstationcode to set
	 */
	public void setDepartstationcode(String departstationcode) {
		this.departstationcode = departstationcode;
	}
	/**
	 * @return the reachstationcode
	 */
	public String getReachstationcode() {
		return reachstationcode;
	}
	/**
	 * @param reachstationcode the reachstationcode to set
	 */
	public void setReachstationcode(String reachstationcode) {
		this.reachstationcode = reachstationcode;
	}
	/**
	 * @return the departstationname
	 */
	public String getDepartstationname() {
		return departstationname;
	}
	/**
	 * @param departstationname the departstationname to set
	 */
	public void setDepartstationname(String departstationname) {
		this.departstationname = departstationname;
	}
	/**
	 * @return the reachstationname
	 */
	public String getReachstationname() {
		return reachstationname;
	}
	/**
	 * @param reachstationname the reachstationname to set
	 */
	public void setReachstationname(String reachstationname) {
		this.reachstationname = reachstationname;
	}
	/**
	 * @return the reachstationsecondname
	 */
	public String getReachstationsecondname() {
		return reachstationsecondname;
	}
	/**
	 * @param reachstationsecondname the reachstationsecondname to set
	 */
	public void setReachstationsecondname(String reachstationsecondname) {
		this.reachstationsecondname = reachstationsecondname;
	}
	/**
	 * @return the startstationname
	 */
	public String getStartstationname() {
		return startstationname;
	}
	/**
	 * @param startstationname the startstationname to set
	 */
	public void setStartstationname(String startstationname) {
		this.startstationname = startstationname;
	}
	/**
	 * @return the endstationname
	 */
	public String getEndstationname() {
		return endstationname;
	}
	/**
	 * @param endstationname the endstationname to set
	 */
	public void setEndstationname(String endstationname) {
		this.endstationname = endstationname;
	}
	/**
	 * @return the buspark
	 */
	public String getBuspark() {
		return buspark;
	}
	/**
	 * @param buspark the buspark to set
	 */
	public void setBuspark(String buspark) {
		this.buspark = buspark;
	}
	/**
	 * @return the seattypecode
	 */
	public String getSeattypecode() {
		return seattypecode;
	}
	/**
	 * @param seattypecode the seattypecode to set
	 */
	public void setSeattypecode(String seattypecode) {
		this.seattypecode = seattypecode;
	}
	/**
	 * @return the seattypename
	 */
	public String getSeattypename() {
		return seattypename;
	}
	/**
	 * @param seattypename the seattypename to set
	 */
	public void setSeattypename(String seattypename) {
		this.seattypename = seattypename;
	}
	/**
	 * @return the fullprice
	 */
	public BigDecimal getFullprice() {
		return fullprice;
	}
	/**
	 * @param fullprice the fullprice to set
	 */
	public void setFullprice(BigDecimal fullprice) {
		this.fullprice = fullprice;
	}
	/**
	 * @return the halfprice
	 */
	public BigDecimal getHalfprice() {
		return halfprice;
	}
	/**
	 * @param halfprice the halfprice to set
	 */
	public void setHalfprice(BigDecimal halfprice) {
		this.halfprice = halfprice;
	}
	/**
	 * @return the studentprice
	 */
	public BigDecimal getStudentprice() {
		return studentprice;
	}
	/**
	 * @param studentprice the studentprice to set
	 */
	public void setStudentprice(BigDecimal studentprice) {
		this.studentprice = studentprice;
	}
	/**
	 * @return the runtime
	 */
	public BigDecimal getRuntime() {
		return runtime;
	}
	/**
	 * @param runtime the runtime to set
	 */
	public void setRuntime(BigDecimal runtime) {
		this.runtime = runtime;
	}
	/**
	 * @return the updatetime
	 */
	public Date getUpdatetime() {
		return updatetime;
	}
	/**
	 * @param updatetime the updatetime to set
	 */
	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}
	/**
	 * @return the id
	 */
	public long getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(long id) {
		this.id = id;
	}
	/**
	 * @return the carrychildnum
	 */
	public long getCarrychildnum() {
		return carrychildnum;
	}
	/**
	 * @param carrychildnum the carrychildnum to set
	 */
	public void setCarrychildnum(long carrychildnum) {
		this.carrychildnum = carrychildnum;
	}
	/**
	 * @return the endstationid
	 */
	public long getEndstationid() {
		return endstationid;
	}
	/**
	 * @param endstationid the endstationid to set
	 */
	public void setEndstationid(long endstationid) {
		this.endstationid = endstationid;
	}
	/**
	 * @return the orgid
	 */
	public long getOrgid() {
		return orgid;
	}
	/**
	 * @param orgid the orgid to set
	 */
	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}
	/**
	 * @return the scheduleid
	 */
	public long getScheduleid() {
		return scheduleid;
	}
	/**
	 * @param scheduleid the scheduleid to set
	 */
	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}
	/**
	 * @return the scheduleplanid
	 */
	public long getScheduleplanid() {
		return scheduleplanid;
	}
	/**
	 * @param scheduleplanid the scheduleplanid to set
	 */
	public void setScheduleplanid(long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}
	/**
	 * @return the departstationid
	 */
	public long getDepartstationid() {
		return departstationid;
	}
	/**
	 * @param departstationid the departstationid to set
	 */
	public void setDepartstationid(long departstationid) {
		this.departstationid = departstationid;
	}
	/**
	 * @return the reachstationid
	 */
	public long getReachstationid() {
		return reachstationid;
	}
	/**
	 * @param reachstationid the reachstationid to set
	 */
	public void setReachstationid(long reachstationid) {
		this.reachstationid = reachstationid;
	}
	/**
	 * @return the routeid
	 */
	public long getRouteid() {
		return routeid;
	}
	/**
	 * @param routeid the routeid to set
	 */
	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}
	/**
	 * @return the residuecarrychildnum
	 */
	public long getResiduecarrychildnum() {
		return residuecarrychildnum;
	}
	/**
	 * @param residuecarrychildnum the residuecarrychildnum to set
	 */
	public void setResiduecarrychildnum(long residuecarrychildnum) {
		this.residuecarrychildnum = residuecarrychildnum;
	}
	/**
	 * @return the startstationid
	 */
	public long getStartstationid() {
		return startstationid;
	}
	/**
	 * @param startstationid the startstationid to set
	 */
	public void setStartstationid(long startstationid) {
		this.startstationid = startstationid;
	}
	/**
	 * @return the issellable
	 */
	public boolean getIssellable() {
		return issellable;
	}
	/**
	 * @param issellable the issellable to set
	 */
	public void setIssellable(boolean issellable) {
		this.issellable = issellable;
	}
	/**
	 * @return the isoriginator
	 */
	public boolean getIsoriginator() {
		return isoriginator;
	}
	/**
	 * @param isoriginator the isoriginator to set
	 */
	public void setIsoriginator(boolean isoriginator) {
		this.isoriginator = isoriginator;
	}
	/**
	 * @return the issaleafterreport
	 */
	public boolean getIssaleafterreport() {
		return issaleafterreport;
	}
	/**
	 * @param issaleafterreport the issaleafterreport to set
	 */
	public void setIssaleafterreport(boolean issaleafterreport) {
		this.issaleafterreport = issaleafterreport;
	}
	/**
	 * @return the isreported
	 */
	public boolean getIsreported() {
		return isreported;
	}
	/**
	 * @param isreported the isreported to set
	 */
	public void setIsreported(boolean isreported) {
		this.isreported = isreported;
	}
	/**
	 * @return the isdeparted
	 */
	public boolean getIsdeparted() {
		return isdeparted;
	}
	/**
	 * @param isdeparted the isdeparted to set
	 */
	public void setIsdeparted(boolean isdeparted) {
		this.isdeparted = isdeparted;
	}
	/**
	 * @return the islinework
	 */
	public boolean getIslinework() {
		return islinework;
	}
	/**
	 * @param islinework the islinework to set
	 */
	public void setIslinework(boolean islinework) {
		this.islinework = islinework;
	}
	/**
	 * @return the isovertime
	 */
	public boolean getIsovertime() {
		return isovertime;
	}
	/**
	 * @param isovertime the isovertime to set
	 */
	public void setIsovertime(boolean isovertime) {
		this.isovertime = isovertime;
	}
	/**
	 * @return the isproprietary
	 */
	public boolean getIsproprietary() {
		return isproprietary;
	}
	/**
	 * @param isproprietary the isproprietary to set
	 */
	public void setIsproprietary(boolean isproprietary) {
		this.isproprietary = isproprietary;
	}
	/**
	 * @return the issellreturnticket
	 */
	public boolean getIssellreturnticket() {
		return issellreturnticket;
	}
	/**
	 * @param issellreturnticket the issellreturnticket to set
	 */
	public void setIssellreturnticket(boolean issellreturnticket) {
		this.issellreturnticket = issellreturnticket;
	}
	/**
	 * @return the isbegincheck
	 */
	public boolean getIsbegincheck() {
		return isbegincheck;
	}
	/**
	 * @param isbegincheck the isbegincheck to set
	 */
	public void setIsbegincheck(boolean isbegincheck) {
		this.isbegincheck = isbegincheck;
	}
	/**
	 * @return the isemptyvehicle
	 */
	public boolean getIsemptyvehicle() {
		return isemptyvehicle;
	}
	/**
	 * @param isemptyvehicle the isemptyvehicle to set
	 */
	public void setIsemptyvehicle(boolean isemptyvehicle) {
		this.isemptyvehicle = isemptyvehicle;
	}
	/**
	 * @return the isroundtrip
	 */
	public boolean getIsroundtrip() {
		return isroundtrip;
	}
	/**
	 * @param isroundtrip the isroundtrip to set
	 */
	public void setIsroundtrip(boolean isroundtrip) {
		this.isroundtrip = isroundtrip;
	}
	/**
	 * @return the districttype
	 */
	public String getDistricttype() {
		return districttype;
	}
	/**
	 * @param districttype the districttype to set
	 */
	public void setDistricttype(String districttype) {
		this.districttype = districttype;
	}
	/**
	 * @return the endtime
	 */
	public String getEndtime() {
		return endtime;
	}
	/**
	 * @param endtime the endtime to set
	 */
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	/**
	 * @return the remarks
	 */
	public String getRemarks() {
		return remarks;
	}
	/**
	 * @param remarks the remarks to set
	 */
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	/**
	 * @return the scheduletype
	 */
	public String getScheduletype() {
		return scheduletype;
	}
	/**
	 * @param scheduletype the scheduletype to set
	 */
	public void setScheduletype(String scheduletype) {
		this.scheduletype = scheduletype;
	}
	/**
	 * @return the starttime
	 */
	public String getStarttime() {
		return starttime;
	}
	/**
	 * @param starttime the starttime to set
	 */
	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}
	/**
	 * @return the worktype
	 */
	public String getWorktype() {
		return worktype;
	}
	/**
	 * @param worktype the worktype to set
	 */
	public void setWorktype(String worktype) {
		this.worktype = worktype;
	}
	/**
	 * @return the workways
	 */
	public String getWorkways() {
		return workways;
	}
	/**
	 * @param workways the workways to set
	 */
	public void setWorkways(String workways) {
		this.workways = workways;
	}
	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	/**
	 * @return the ticketentrance
	 */
	public String getTicketentrance() {
		return ticketentrance;
	}
	/**
	 * @param ticketentrance the ticketentrance to set
	 */
	public void setTicketentrance(String ticketentrance) {
		this.ticketentrance = ticketentrance;
	}
	/**
	 * @return the seatnos
	 */
	public String getSeatnos() {
		return seatnos;
	}
	/**
	 * @param seatnos the seatnos to set
	 */
	public void setSeatnos(String seatnos) {
		this.seatnos = seatnos;
	}
	/**
	 * @return the seattype
	 */
	public String getSeattype() {
		return seattype;
	}
	/**
	 * @param seattype the seattype to set
	 */
	public void setSeattype(String seattype) {
		this.seattype = seattype;
	}
	/**
	 * @return the distance
	 */
	public int getDistance() {
		return distance;
	}
	/**
	 * @param distance the distance to set
	 */
	public void setDistance(int distance) {
		this.distance = distance;
	}
	/**
	 * @return the balancedistance
	 */
	public int getBalancedistance() {
		return balancedistance;
	}
	/**
	 * @param balancedistance the balancedistance to set
	 */
	public void setBalancedistance(int balancedistance) {
		this.balancedistance = balancedistance;
	}
	/**
	 * @return the spacinginterval
	 */
	public short getSpacinginterval() {
		return spacinginterval;
	}
	/**
	 * @param spacinginterval the spacinginterval to set
	 */
	public void setSpacinginterval(short spacinginterval) {
		this.spacinginterval = spacinginterval;
	}
	/**
	 * @return the unautocancelreserveseatnum
	 */
	public short getUnautocancelreserveseatnum() {
		return unautocancelreserveseatnum;
	}
	/**
	 * @param unautocancelreserveseatnum the unautocancelreserveseatnum to set
	 */
	public void setUnautocancelreserveseatnum(short unautocancelreserveseatnum) {
		this.unautocancelreserveseatnum = unautocancelreserveseatnum;
	}
	/**
	 * @return the fixedreserveseatnum
	 */
	public short getFixedreserveseatnum() {
		return fixedreserveseatnum;
	}
	/**
	 * @param fixedreserveseatnum the fixedreserveseatnum to set
	 */
	public void setFixedreserveseatnum(short fixedreserveseatnum) {
		this.fixedreserveseatnum = fixedreserveseatnum;
	}
	/**
	 * @return the autocancelreserveseatnum
	 */
	public short getAutocancelreserveseatnum() {
		return autocancelreserveseatnum;
	}
	/**
	 * @param autocancelreserveseatnum the autocancelreserveseatnum to set
	 */
	public void setAutocancelreserveseatnum(short autocancelreserveseatnum) {
		this.autocancelreserveseatnum = autocancelreserveseatnum;
	}
	/**
	 * @return the seatnum
	 */
	public short getSeatnum() {
		return seatnum;
	}
	/**
	 * @param seatnum the seatnum to set
	 */
	public void setSeatnum(short seatnum) {
		this.seatnum = seatnum;
	}
	/**
	 * @return the soldeatnum
	 */
	public short getSoldeatnum() {
		return soldeatnum;
	}
	/**
	 * @param soldeatnum the soldeatnum to set
	 */
	public void setSoldeatnum(short soldeatnum) {
		this.soldeatnum = soldeatnum;
	}
	/**
	 * @return the residueseatnum
	 */
	public short getResidueseatnum() {
		return residueseatnum;
	}
	/**
	 * @param residueseatnum the residueseatnum to set
	 */
	public void setResidueseatnum(short residueseatnum) {
		this.residueseatnum = residueseatnum;
	}
	/**
	 * @return the returntripvaliddays
	 */
	public short getReturntripvaliddays() {
		return returntripvaliddays;
	}
	/**
	 * @param returntripvaliddays the returntripvaliddays to set
	 */
	public void setReturntripvaliddays(short returntripvaliddays) {
		this.returntripvaliddays = returntripvaliddays;
	}
	/**
	 * @return the stationservicefee
	 */
	public BigDecimal getStationservicefee() {
		return stationservicefee;
	}
	/**
	 * @param stationservicefee the stationservicefee to set
	 */
	public void setStationservicefee(BigDecimal stationservicefee) {
		this.stationservicefee = stationservicefee;
	}
	/**
	 * @return the fueladditionfee
	 */
	public BigDecimal getFueladditionfee() {
		return fueladditionfee;
	}
	/**
	 * @param fueladditionfee the fueladditionfee to set
	 */
	public void setFueladditionfee(BigDecimal fueladditionfee) {
		this.fueladditionfee = fueladditionfee;
	}
	/**
	 * @return the toplimitprice
	 */
	public BigDecimal getToplimitprice() {
		return toplimitprice;
	}
	/**
	 * @param toplimitprice the toplimitprice to set
	 */
	public void setToplimitprice(BigDecimal toplimitprice) {
		this.toplimitprice = toplimitprice;
	}
	/**
	 * @return the lowerlimitprice
	 */
	public BigDecimal getLowerlimitprice() {
		return lowerlimitprice;
	}
	/**
	 * @param lowerlimitprice the lowerlimitprice to set
	 */
	public void setLowerlimitprice(BigDecimal lowerlimitprice) {
		this.lowerlimitprice = lowerlimitprice;
	}
	/**
	 * @return the moreprice
	 */
	public BigDecimal getMoreprice() {
		return moreprice;
	}
	/**
	 * @param moreprice the moreprice to set
	 */
	public void setMoreprice(BigDecimal moreprice) {
		this.moreprice = moreprice;
	}
	/**
	 * @return the routename
	 */
	public String getRoutename() {
		return routename;
	}
	/**
	 * @param routename the routename to set
	 */
	public void setRoutename(String routename) {
		this.routename = routename;
	}
	/**
	 * @return the scheduleremarks
	 */
	public String getScheduleremarks() {
		return scheduleremarks;
	}
	/**
	 * @param scheduleremarks the scheduleremarks to set
	 */
	public void setScheduleremarks(String scheduleremarks) {
		this.scheduleremarks = scheduleremarks;
	}
	/**
	 * @return the planvehicletype
	 */
	public String getPlanvehicletype() {
		return planvehicletype;
	}
	/**
	 * @param planvehicletype the planvehicletype to set
	 */
	public void setPlanvehicletype(String planvehicletype) {
		this.planvehicletype = planvehicletype;
	}
	/**
	 * @return the planvehiclegrade
	 */
	public String getPlanvehiclegrade() {
		return planvehiclegrade;
	}
	/**
	 * @param planvehiclegrade the planvehiclegrade to set
	 */
	public void setPlanvehiclegrade(String planvehiclegrade) {
		this.planvehiclegrade = planvehiclegrade;
	}
	/**
	 * @return the planvehicletypecustomname
	 */
	public String getPlanvehicletypecustomname() {
		return planvehicletypecustomname;
	}
	/**
	 * @param planvehicletypecustomname the planvehicletypecustomname to set
	 */
	public void setPlanvehicletypecustomname(String planvehicletypecustomname) {
		this.planvehicletypecustomname = planvehicletypecustomname;
	}
	/**
	 * @return the planvheicletypeid
	 */
	public Long getPlanvheicletypeid() {
		return planvheicletypeid;
	}
	/**
	 * @param planvheicletypeid the planvheicletypeid to set
	 */
	public void setPlanvheicletypeid(Long planvheicletypeid) {
		this.planvheicletypeid = planvheicletypeid;
	}
	/**
	 * @return the planvehicleno
	 */
	public String getPlanvehicleno() {
		return planvehicleno;
	}
	/**
	 * @param planvehicleno the planvehicleno to set
	 */
	public void setPlanvehicleno(String planvehicleno) {
		this.planvehicleno = planvehicleno;
	}
	/**
	 * @return the planvehicleid
	 */
	public Long getPlanvehicleid() {
		return planvehicleid;
	}
	/**
	 * @param planvehicleid the planvehicleid to set
	 */
	public void setPlanvehicleid(Long planvehicleid) {
		this.planvehicleid = planvehicleid;
	}
	/**
	 * @return the planunitname
	 */
	public String getPlanunitname() {
		return planunitname;
	}
	/**
	 * @param planunitname the planunitname to set
	 */
	public void setPlanunitname(String planunitname) {
		this.planunitname = planunitname;
	}
	/**
	 * @return the planunitid
	 */
	public Long getPlanunitid() {
		return planunitid;
	}
	/**
	 * @param planunitid the planunitid to set
	 */
	public void setPlanunitid(Long planunitid) {
		this.planunitid = planunitid;
	}
	/**
	 * @return the planbrandmodel
	 */
	public String getPlanbrandmodel() {
		return planbrandmodel;
	}
	/**
	 * @param planbrandmodel the planbrandmodel to set
	 */
	public void setPlanbrandmodel(String planbrandmodel) {
		this.planbrandmodel = planbrandmodel;
	}
	/**
	 * @return the planbrandmodelid
	 */
	public Long getPlanbrandmodelid() {
		return planbrandmodelid;
	}
	/**
	 * @param planbrandmodelid the planbrandmodelid to set
	 */
	public void setPlanbrandmodelid(Long planbrandmodelid) {
		this.planbrandmodelid = planbrandmodelid;
	}
}
