package cn.nova.bus.sale.model;

import java.util.Date;

/**
 * 班次查询条件类
 * @author ice
 *
 */
public class ScheduleAskCondition {
//	private boolean isnet;
	private Date departDate;
	private Long departStationId;
	private long reachStationId;
	private long scheduleid;
	private long seller;
	private String ip;
	private long ticketoutletsid;
	private String sellway;
	private Long ticketIdToBeChange;
	private long customerid;
	private String reachStationName;
	
	private String districtcode;//按区域查询发车站的班次
	
	
	/**
	 * 
	 * @return 到达站点名称
	 */	
	public String getReachStationName() {
		return reachStationName;
	}
	
	/**
	 * 
	 * @param reachStationId 到达站点名称
	 */
	public void setReachStationName(String reachStationName) {
		this.reachStationName = reachStationName;
	}

	/**
	 * 
	 * @return 到达站点id
	 */
	public long getReachStationId() {
		return reachStationId;
	}
	
	/**
	 * 
	 * @param reachStationId 到达站点id
	 */
	public void setReachStationId(long reachStationId) {
		this.reachStationId = reachStationId;
	}
	
	/**
	 * 
	 * @return 售票员id
	 */
	public long getSeller() {
		return seller;
	}
	
	/**
	 * 
	 * @param seller 售票员id
	 */
	public void setSeller(long seller) {
		this.seller = seller;
	}
	
	/**
	 * 
	 * @return 售票电脑ip
	 */
	public String getIp() {
		return ip;
	}
	
	/**
	 * 
	 * @param ip 售票电脑ip
	 */
	public void setIp(String ip) {
		this.ip = ip;
	}
	
	/**
	 * 
	 * @return 售票点id
	 */
	public long getTicketoutletsid() {
		return ticketoutletsid;
	}
	
	/**
	 * 
	 * @param ticketoutletsid 售票点id
	 */
	public void setTicketoutletsid(long ticketoutletsid) {
		this.ticketoutletsid = ticketoutletsid;
	}
	
	/**
	 * 
	 * @return 查询界面 eg:售票、补票、售票问讯
	 */
	public String getSellway() {
		return sellway;
	}
	
	/**
	 * 
	 * @param sellway 查询界面 eg:售票、补票、售票问讯
	 */
	public void setSellway(String sellway) {
		this.sellway = sellway;
	}
	
	/**
	 * 
	 * @param departDate 发车日期
	 */
	public void setDepartDate(Date deaprtDate) {
		this.departDate = deaprtDate;
	}
	
	/**
	 * 
	 * @return 发车日期
	 */
	public Date getDepartDate() {
		return departDate;
	}
	
	/**
	 * 
	 * @param departStationId 上车点
	 */
	public void setDepartStationId(Long departStationId) {
		this.departStationId = departStationId;
	}
	
	/**
	 * 
	 * @return 上车点
	 */
	public Long getDepartStationId() {
		return departStationId;
	}

	public void setTicketIdToBeChange(Long ticketIdToBeChange) {
		this.ticketIdToBeChange = ticketIdToBeChange;
	}

	public Long getTicketIdToBeChange() {
		return ticketIdToBeChange;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public long getScheduleid() {
		return scheduleid;
	}

	/**
	 * 
	 * @return 订票顾客id
	 */
	public long getCustomerid() {
		return customerid;
	}

	public void setCustomerid(long customerid) {
		this.customerid = customerid;
	}

	public String getDistrictcode() {
		return districtcode;
	}

	public void setDistrictcode(String districtcode) {
		this.districtcode = districtcode;
	}

}
