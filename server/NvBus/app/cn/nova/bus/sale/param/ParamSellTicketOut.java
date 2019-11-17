/**
 * 
 */
package cn.nova.bus.sale.param;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * @author ice
 * 售票返回结果类
 */
public class ParamSellTicketOut implements Serializable {
	
	private static final long serialVersionUID = -4850596007232642759L;
	private long ticketsellid;
	private String orderno;//订单号（使用GUID）

	
	private Date departdate;
	private String routename;
	private String startstationname;
	private String endstationname;

	private String schedulecode;
	private String schedulesynccode;
	private String workways;
	private boolean isovertime;
	private boolean islinework;
    private String scheduleremarks;
    
	private String departorgcode;
	private String departstationcode;
	private String reachstationcode;
	private String departstationname;
	private String reachstationname;
	private String reachstationsecondname;
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

	private String seattypecode;//座位类型编码
	private String seattypename;//座位类型名称
	private String tickettypecode;//价格类型编码
	private String tickettypename;//价格类型名称
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
	public boolean isIsovertime() {
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
	public boolean isIslinework() {
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
	 * @return the departorgcode
	 */
	public String getDepartorgcode() {
		return departorgcode;
	}
	/**
	 * @param departorgcode the departorgcode to set
	 */
	public void setDepartorgcode(String departorgcode) {
		this.departorgcode = departorgcode;
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
	public boolean isIsroundtrip() {
		return isroundtrip;
	}
	/**
	 * @param isroundtrip the isroundtrip to set
	 */
	public void setIsroundtrip(boolean isroundtrip) {
		this.isroundtrip = isroundtrip;
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
	 * @return the tickettypecode
	 */
	public String getTickettypecode() {
		return tickettypecode;
	}
	/**
	 * @param tickettypecode the tickettypecode to set
	 */
	public void setTickettypecode(String tickettypecode) {
		this.tickettypecode = tickettypecode;
	}
	/**
	 * @return the tickettypename
	 */
	public String getTickettypename() {
		return tickettypename;
	}
	/**
	 * @param tickettypename the tickettypename to set
	 */
	public void setTickettypename(String tickettypename) {
		this.tickettypename = tickettypename;
	}
	
}
