/**
 * 
 */
package cn.nova.bus.sale.param;



/**
 * @author ice
 * 查找班次信息参数类
 */
public class ParamFindScheduleIn extends cn.nova.bus.sale.remote.param.ParamFindScheduleIn {
	
	private static final long serialVersionUID = -8326667493922283590L;
	private long sellOrgID;//售票机构 不允许为空
	private long sellerId; //售票人ID 不允许为空
	
	//reachStationId和scheduleId不允许同时为空,且不允许同时有值
	private Long reachStationId;//到站ID
	private Long scheduleId;//班次ID
	
	private Long ticketoutletsId;//售票点ID 用于限制可售班次，可售站点  大部份售票方式下不允许为空
	
	//departStationId和departDistrictCode不允许同时有值
	private Long departStationId;//发车站点ID
	private Long departDistrictId;//发车站所属区域ID
	
	private Long customerId;//订票人ID
	
	private Long ticketIdToBeChange; //换票原车票ID

	public  ParamFindScheduleIn(cn.nova.bus.sale.remote.param.ParamFindScheduleIn paramFindScheduleIn){
		this.departDate = paramFindScheduleIn.getDepartDate();
		this.sellOrgCode = paramFindScheduleIn.getSellOrgCode();
		this.sellIp = paramFindScheduleIn.getSellIp();
		this.sellerCode = paramFindScheduleIn.getSellerCode();
		this.sellway = paramFindScheduleIn.getSellway();
		this.reachStationCode = paramFindScheduleIn.getReachStationCode();
		this.scheduleCode = paramFindScheduleIn.getScheduleCode();
		this.ticketoutletsCode = paramFindScheduleIn.getTicketoutletsCode();
		this.departStationCode = paramFindScheduleIn.getDepartStationCode();
		this.departDistrictCode = paramFindScheduleIn.getDepartDistrictCode();
		this.seatTypeCode = paramFindScheduleIn.getSeatTypeCode();
	}
	
	/**
	 * @return the sellOrgID
	 */
	public long getSellOrgID() {
		return sellOrgID;
	}

	/**
	 * @param sellOrgID the sellOrgID to set
	 */
	public void setSellOrgID(long sellOrgID) {
		this.sellOrgID = sellOrgID;
	}

	/**
	 * @return the sellerId
	 */
	public long getSellerId() {
		return sellerId;
	}

	/**
	 * @param sellerId the sellerId to set
	 */
	public void setSellerId(long sellerId) {
		this.sellerId = sellerId;
	}

	/**
	 * @return the reachStationId
	 */
	public Long getReachStationId() {
		return reachStationId;
	}

	/**
	 * @param reachStationId the reachStationId to set
	 */
	public void setReachStationId(Long reachStationId) {
		this.reachStationId = reachStationId;
	}

	/**
	 * @return the scheduleId
	 */
	public Long getScheduleId() {
		return scheduleId;
	}

	/**
	 * @param scheduleId the scheduleId to set
	 */
	public void setScheduleId(Long scheduleId) {
		this.scheduleId = scheduleId;
	}

	/**
	 * @return the ticketoutletsId
	 */
	public Long getTicketoutletsId() {
		return ticketoutletsId;
	}

	/**
	 * @param ticketoutletsId the ticketoutletsId to set
	 */
	public void setTicketoutletsId(Long ticketoutletsId) {
		this.ticketoutletsId = ticketoutletsId;
	}

	/**
	 * @return the departStationId
	 */
	public Long getDepartStationId() {
		return departStationId;
	}

	/**
	 * @param departStationId the departStationId to set
	 */
	public void setDepartStationId(Long departStationId) {
		this.departStationId = departStationId;
	}

	/**
	 * @return the departDistrictId
	 */
	public Long getDepartDistrictId() {
		return departDistrictId;
	}

	/**
	 * @param departDistrictId the departDistrictId to set
	 */
	public void setDepartDistrictId(Long departDistrictId) {
		this.departDistrictId = departDistrictId;
	}

	/**
	 * @return the customerId
	 */
	public Long getCustomerId() {
		return customerId;
	}

	/**
	 * @param customerId the customerId to set
	 */
	public void setCustomerId(Long customerId) {
		this.customerId = customerId;
	}

	/**
	 * @return the ticketIdToBeChange
	 */
	public Long getTicketIdToBeChange() {
		return ticketIdToBeChange;
	}

	/**
	 * @param ticketIdToBeChange the ticketIdToBeChange to set
	 */
	public void setTicketIdToBeChange(Long ticketIdToBeChange) {
		this.ticketIdToBeChange = ticketIdToBeChange;
	}
	
}
