/**
 * 
 */
package cn.nova.bus.sale.remote.param;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * @author ice 查找班次信息参数类
 */
public class ParamLockSeatsIn implements Serializable {

	private static final long serialVersionUID = 4331333834490410327L;
	private String orderno;// 订单号（使用Gucode） 不允许为空
	private String sellway;// 售票方式 不允许为空
	private String sellOrgCode;// 调用者机构 不允许为空
	private String sellIp;// 操作者IP 不允许为空
	private String sellerCode;// 用户code 不允许为空
	private String ticketoutletsCode;
	private String ticketoutletsname;

	// private String departOrgCode;//发车机构code 不允许为空

	private Date departDate;// 发车日期 不允许为空
	private String scheduleCode;// 班次编号 不允许为空
	// scheduleCode和scheduleSyncCode不允许同时为空
	private String scheduleSyncCode;// 班次SYNCCODE

	private int locktime = 0;// 锁定座位保留时间 为0表示取参数

	private List<String> selectSeatStatus; // 可选座位状态 不允许为空

	// 用于校验
	private String departStationCode;// 始发车站code 不允许为空
	private String reachStationCode;// 到达车站code
	private String departtime;// 发车时间

	private List<ParamLockseatIn> lockseats;// 锁位座位明细列表

	/**
	 * @return the orderno
	 */
	public String getOrderno() {
		return orderno;
	}

	/**
	 * @param orderno
	 *            the orderno to set
	 */
	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	/**
	 * @return the sellway
	 */
	public String getSellway() {
		return sellway;
	}

	/**
	 * @param sellway
	 *            the sellway to set
	 */
	public void setSellway(String sellway) {
		this.sellway = sellway;
	}

	/**
	 * @return the sellOrgCode
	 */
	public String getSellOrgCode() {
		return sellOrgCode;
	}

	/**
	 * @param sellOrgCode
	 *            the sellOrgCode to set
	 */
	public void setSellOrgCode(String sellOrgCode) {
		this.sellOrgCode = sellOrgCode;
	}

	/**
	 * @return the sellIp
	 */
	public String getSellIp() {
		return sellIp;
	}

	/**
	 * @param sellIp
	 *            the sellIp to set
	 */
	public void setSellIp(String sellIp) {
		this.sellIp = sellIp;
	}

	/**
	 * @return the sellerCode
	 */
	public String getSellerCode() {
		return sellerCode;
	}

	/**
	 * @param sellerCode
	 *            the sellerCode to set
	 */
	public void setSellerCode(String sellerCode) {
		this.sellerCode = sellerCode;
	}

	/**
	 * @return the ticketoutletsCode
	 */
	public String getTicketoutletsCode() {
		return ticketoutletsCode;
	}

	/**
	 * @param ticketoutletsCode
	 *            the ticketoutletsCode to set
	 */
	public void setTicketoutletsCode(String ticketoutletsCode) {
		this.ticketoutletsCode = ticketoutletsCode;
	}

	/**
	 * @return the ticketoutletsname
	 */
	public String getTicketoutletsname() {
		return ticketoutletsname;
	}

	/**
	 * @param ticketoutletsname
	 *            the ticketoutletsname to set
	 */
	public void setTicketoutletsname(String ticketoutletsname) {
		this.ticketoutletsname = ticketoutletsname;
	}

	/**
	 * @return the departDate
	 */
	public Date getDepartDate() {
		return departDate;
	}

	/**
	 * @param departDate
	 *            the departDate to set
	 */
	public void setDepartDate(Date departDate) {
		this.departDate = departDate;
	}

	/**
	 * @return the scheduleCode
	 */
	public String getScheduleCode() {
		return scheduleCode;
	}

	/**
	 * @param scheduleCode
	 *            the scheduleCode to set
	 */
	public void setScheduleCode(String scheduleCode) {
		this.scheduleCode = scheduleCode;
	}

	/**
	 * @return the scheduleSyncCode
	 */
	public String getScheduleSyncCode() {
		return scheduleSyncCode;
	}

	/**
	 * @param scheduleSyncCode
	 *            the scheduleSyncCode to set
	 */
	public void setScheduleSyncCode(String scheduleSyncCode) {
		this.scheduleSyncCode = scheduleSyncCode;
	}

	/**
	 * @return the locktime
	 */
	public int getLocktime() {
		return locktime;
	}

	/**
	 * @param locktime
	 *            the locktime to set
	 */
	public void setLocktime(int locktime) {
		this.locktime = locktime;
	}

	/**
	 * @return the selectSeatStatus
	 */
	public List<String> getSelectSeatStatus() {
		return selectSeatStatus;
	}

	/**
	 * @param selectSeatStatus
	 *            the selectSeatStatus to set
	 */
	public void setSelectSeatStatus(List<String> selectSeatStatus) {
		this.selectSeatStatus = selectSeatStatus;
	}

	/**
	 * @return the departStationCode
	 */
	public String getDepartStationCode() {
		return departStationCode;
	}

	/**
	 * @param departStationCode
	 *            the departStationCode to set
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
	 * @param reachStationCode
	 *            the reachStationCode to set
	 */
	public void setReachStationCode(String reachStationCode) {
		this.reachStationCode = reachStationCode;
	}

	/**
	 * @return the departtime
	 */
	public String getDeparttime() {
		return departtime;
	}

	/**
	 * @param departtime
	 *            the departtime to set
	 */
	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}

	/**
	 * @return the lockseats
	 */
	public List<ParamLockseatIn> getLockseats() {
		return lockseats;
	}

	/**
	 * @param lockseats
	 *            the lockseats to set
	 */
	public void setLockseats(List<ParamLockseatIn> lockseats) {
		this.lockseats = lockseats;
	}

	private String nvl(String s) {
		if (s != null) {
			return s;
		} else {
			return "";
		}
	}

	@Override
	public String toString() {
		return "departDate=" + departDate + ",orderno=" + nvl(orderno)
				+ ",sellway=" + nvl(sellway) + ",sellOrgCode="
				+ nvl(sellOrgCode) + ",sellIp=" + nvl(sellIp) + ",sellerCode="
				+ nvl(sellerCode) + ",ticketoutletsCode="
				+ nvl(ticketoutletsCode) + ",scheduleCode=" + nvl(scheduleCode)
				+ ",ticketoutletsCode=" + nvl(ticketoutletsCode)
				+ ",departStationCode=" + nvl(departStationCode)
				+ ",reachStationCode=" + nvl(reachStationCode)
				+ ",scheduleSyncCode=" + nvl(scheduleSyncCode) + ",locktime="
				+ locktime + ",departtime=" + nvl(departtime) + ",sellway="
				+ nvl(sellway);
	}
}
