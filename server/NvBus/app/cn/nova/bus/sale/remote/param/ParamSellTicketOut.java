/**
 * 
 */
package cn.nova.bus.sale.remote.param;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * @author ice
 * 售票返回结果类
 */
public class ParamSellTicketOut implements Serializable {
	
	private static final long serialVersionUID = 1824572585303783026L;
	private long ticketsellid;
	private String orderno;//订单号（使用GUID）
	
	private Date departDate;
	private String routeName;
	private String startStationName;
	private String endStationName;

	private String scheduleCode;
	private String scheduleSyncSode;
	private String workways;
	private boolean isovertime;
	private boolean islinework;
    private String scheduleremarks;
    
//	private String departOrgCode;
	private String departStationCode;
	private String reachStationCode;
	private String departStationName;
	private String reachStationName;
	private String reachStationSecondName;
	private String departtime;
	private long distance;
    private BigDecimal fullprice;
    private BigDecimal discountrate;
    private BigDecimal price;
    private BigDecimal moreprice;
    private BigDecimal servicefee;
    private BigDecimal toplimitprice;
    
    private BigDecimal fueladditionfee;
    private BigDecimal stationservicefee;
	private BigDecimal computefee;
	private BigDecimal coolairfee;
	private BigDecimal additionfee;
	private BigDecimal waterfee;
	private BigDecimal insurefee;
	private BigDecimal otherfee;
	
    private String ticketno;
    private short seatno;
    private String seatnostr;
    private byte carrychildnum;
    private String ticketentrance;
    private String buspark;
    private String paymethod;
	
	private String certificatetype;
	private String certificateno;
	private String customername;
	 
	private String planvehicletype;
	private String planvehiclegrade;
	private String planvehicletypecustomname;
	private String planunitname;
	private String planbrandmodel;
	private String planvehicleno;
	
	//线路回程票有效天数
	private short returntripvaliddays = 0;
	//是否往返票
	private boolean isroundtrip = false;

	private String seattypeCode;//座位类型编码
	private String seattypeName;//座位类型名称
	private String tickettypeCode;//价格类型编码
	private String tickettypeName;//价格类型名称
	
	private String districttypeCode; //区域类型 区域类别：1县内、2县际、3市际、4省际、5国际
	private String districttypeName; //区域类型 区域类别：1县内、2县际、3市际、4省际、5国际
	/**
	 * @return the ticketsellid
	 */
	public long getTicketsellid() {
		return ticketsellid;
	}
	/**
	 * @param ticketsellid the ticketsellid to set
	 */
	public void setTicketsellid(long ticketsellid) {
		this.ticketsellid = ticketsellid;
	}
	/**
	 * @return the orderno
	 */
	public String getOrderno() {
		return orderno;
	}
	/**
	 * @param orderno the orderno to set
	 */
	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}
	/**
	 * @return the departDate
	 */
	public Date getDepartDate() {
		return departDate;
	}
	/**
	 * @param departDate the departDate to set
	 */
	public void setDepartDate(Date departDate) {
		this.departDate = departDate;
	}
	/**
	 * @return the routeName
	 */
	public String getRouteName() {
		return routeName;
	}
	/**
	 * @param routeName the routeName to set
	 */
	public void setRouteName(String routeName) {
		this.routeName = routeName;
	}
	/**
	 * @return the startStationName
	 */
	public String getStartStationName() {
		return startStationName;
	}
	/**
	 * @param startStationName the startStationName to set
	 */
	public void setStartStationName(String startStationName) {
		this.startStationName = startStationName;
	}
	/**
	 * @return the endStationName
	 */
	public String getEndStationName() {
		return endStationName;
	}
	/**
	 * @param endStationName the endStationName to set
	 */
	public void setEndStationName(String endStationName) {
		this.endStationName = endStationName;
	}
	/**
	 * @return the scheduleCode
	 */
	public String getScheduleCode() {
		return scheduleCode;
	}
	/**
	 * @param scheduleCode the scheduleCode to set
	 */
	public void setScheduleCode(String scheduleCode) {
		this.scheduleCode = scheduleCode;
	}
	/**
	 * @return the scheduleSyncSode
	 */
	public String getScheduleSyncSode() {
		return scheduleSyncSode;
	}
	/**
	 * @param scheduleSyncSode the scheduleSyncSode to set
	 */
	public void setScheduleSyncSode(String scheduleSyncSode) {
		this.scheduleSyncSode = scheduleSyncSode;
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
	 * @return the departStationCode
	 */
	public String getDepartStationCode() {
		return departStationCode;
	}
	/**
	 * @param departStationCode the departStationCode to set
	 */
	public void setDepartStationCode(String departStationCode) {
		this.departStationCode = departStationCode;
	}
	/**
	 * @return the reachStationCode
	 */
	public String getReachStationCode() {
		return reachStationCode;
	}
	/**
	 * @param reachStationCode the reachStationCode to set
	 */
	public void setReachStationCode(String reachStationCode) {
		this.reachStationCode = reachStationCode;
	}
	/**
	 * @return the departStationName
	 */
	public String getDepartStationName() {
		return departStationName;
	}
	/**
	 * @param departStationName the departStationName to set
	 */
	public void setDepartStationName(String departStationName) {
		this.departStationName = departStationName;
	}
	/**
	 * @return the reachStationName
	 */
	public String getReachStationName() {
		return reachStationName;
	}
	/**
	 * @param reachStationName the reachStationName to set
	 */
	public void setReachStationName(String reachStationName) {
		this.reachStationName = reachStationName;
	}
	/**
	 * @return the reachStationSecondName
	 */
	public String getReachStationSecondName() {
		return reachStationSecondName;
	}
	/**
	 * @param reachStationSecondName the reachStationSecondName to set
	 */
	public void setReachStationSecondName(String reachStationSecondName) {
		this.reachStationSecondName = reachStationSecondName;
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
	 * @return the distance
	 */
	public long getDistance() {
		return distance;
	}
	/**
	 * @param distance the distance to set
	 */
	public void setDistance(long distance) {
		this.distance = distance;
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
	 * @return the discountrate
	 */
	public BigDecimal getDiscountrate() {
		return discountrate;
	}
	/**
	 * @param discountrate the discountrate to set
	 */
	public void setDiscountrate(BigDecimal discountrate) {
		this.discountrate = discountrate;
	}
	/**
	 * @return the price
	 */
	public BigDecimal getPrice() {
		return price;
	}
	/**
	 * @param price the price to set
	 */
	public void setPrice(BigDecimal price) {
		this.price = price;
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
	 * @return the servicefee
	 */
	public BigDecimal getServicefee() {
		return servicefee;
	}
	/**
	 * @param servicefee the servicefee to set
	 */
	public void setServicefee(BigDecimal servicefee) {
		this.servicefee = servicefee;
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
	 * @return the computefee
	 */
	public BigDecimal getComputefee() {
		return computefee;
	}
	/**
	 * @param computefee the computefee to set
	 */
	public void setComputefee(BigDecimal computefee) {
		this.computefee = computefee;
	}
	/**
	 * @return the coolairfee
	 */
	public BigDecimal getCoolairfee() {
		return coolairfee;
	}
	/**
	 * @param coolairfee the coolairfee to set
	 */
	public void setCoolairfee(BigDecimal coolairfee) {
		this.coolairfee = coolairfee;
	}
	/**
	 * @return the additionfee
	 */
	public BigDecimal getAdditionfee() {
		return additionfee;
	}
	/**
	 * @param additionfee the additionfee to set
	 */
	public void setAdditionfee(BigDecimal additionfee) {
		this.additionfee = additionfee;
	}
	/**
	 * @return the waterfee
	 */
	public BigDecimal getWaterfee() {
		return waterfee;
	}
	/**
	 * @param waterfee the waterfee to set
	 */
	public void setWaterfee(BigDecimal waterfee) {
		this.waterfee = waterfee;
	}
	/**
	 * @return the insurefee
	 */
	public BigDecimal getInsurefee() {
		return insurefee;
	}
	/**
	 * @param insurefee the insurefee to set
	 */
	public void setInsurefee(BigDecimal insurefee) {
		this.insurefee = insurefee;
	}
	/**
	 * @return the otherfee
	 */
	public BigDecimal getOtherfee() {
		return otherfee;
	}
	/**
	 * @param otherfee the otherfee to set
	 */
	public void setOtherfee(BigDecimal otherfee) {
		this.otherfee = otherfee;
	}
	/**
	 * @return the ticketno
	 */
	public String getTicketno() {
		return ticketno;
	}
	/**
	 * @param ticketno the ticketno to set
	 */
	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
	}
	/**
	 * @return the seatno
	 */
	public short getSeatno() {
		return seatno;
	}
	/**
	 * @param seatno the seatno to set
	 */
	public void setSeatno(short seatno) {
		this.seatno = seatno;
	}
	/**
	 * @return the seatnostr
	 */
	public String getSeatnostr() {
		return seatnostr;
	}
	/**
	 * @param seatnostr the seatnostr to set
	 */
	public void setSeatnostr(String seatnostr) {
		this.seatnostr = seatnostr;
	}
	/**
	 * @return the carrychildnum
	 */
	public byte getCarrychildnum() {
		return carrychildnum;
	}
	/**
	 * @param carrychildnum the carrychildnum to set
	 */
	public void setCarrychildnum(byte carrychildnum) {
		this.carrychildnum = carrychildnum;
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
	 * @return the paymethod
	 */
	public String getPaymethod() {
		return paymethod;
	}
	/**
	 * @param paymethod the paymethod to set
	 */
	public void setPaymethod(String paymethod) {
		this.paymethod = paymethod;
	}
	/**
	 * @return the certificatetype
	 */
	public String getCertificatetype() {
		return certificatetype;
	}
	/**
	 * @param certificatetype the certificatetype to set
	 */
	public void setCertificatetype(String certificatetype) {
		this.certificatetype = certificatetype;
	}
	/**
	 * @return the certificateno
	 */
	public String getCertificateno() {
		return certificateno;
	}
	/**
	 * @param certificateno the certificateno to set
	 */
	public void setCertificateno(String certificateno) {
		this.certificateno = certificateno;
	}
	/**
	 * @return the customername
	 */
	public String getCustomername() {
		return customername;
	}
	/**
	 * @param customername the customername to set
	 */
	public void setCustomername(String customername) {
		this.customername = customername;
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
	 * @return the seattypeCode
	 */
	public String getSeattypeCode() {
		return seattypeCode;
	}
	/**
	 * @param seattypeCode the seattypeCode to set
	 */
	public void setSeattypeCode(String seattypeCode) {
		this.seattypeCode = seattypeCode;
	}
	/**
	 * @return the seattypeName
	 */
	public String getSeattypeName() {
		return seattypeName;
	}
	/**
	 * @param seattypeName the seattypeName to set
	 */
	public void setSeattypeName(String seattypeName) {
		this.seattypeName = seattypeName;
	}
	/**
	 * @return the tickettypeCode
	 */
	public String getTickettypeCode() {
		return tickettypeCode;
	}
	/**
	 * @param tickettypeCode the tickettypeCode to set
	 */
	public void setTickettypeCode(String tickettypeCode) {
		this.tickettypeCode = tickettypeCode;
	}
	/**
	 * @return the tickettypeName
	 */
	public String getTickettypeName() {
		return tickettypeName;
	}
	/**
	 * @param tickettypeName the tickettypeName to set
	 */
	public void setTickettypeName(String tickettypeName) {
		this.tickettypeName = tickettypeName;
	}
	/**
	 * @return the districttypeCode
	 */
	public String getDistricttypeCode() {
		return districttypeCode;
	}
	/**
	 * @param districttypeCode the districttypeCode to set
	 */
	public void setDistricttypeCode(String districttypeCode) {
		this.districttypeCode = districttypeCode;
	}
	/**
	 * @return the districttypeName
	 */
	public String getDistricttypeName() {
		return districttypeName;
	}
	/**
	 * @param districttypeName the districttypeName to set
	 */
	public void setDistricttypeName(String districttypeName) {
		this.districttypeName = districttypeName;
	}
	/**
	 * @return the serialversionuid
	 */
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	
}
