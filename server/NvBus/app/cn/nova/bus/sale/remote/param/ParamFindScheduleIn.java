/**
 * 
 */
package cn.nova.bus.sale.remote.param;

import java.io.Serializable;
import java.util.Date;

/**
 * @author ice 查找班次信息参数类
 */
public class ParamFindScheduleIn implements Serializable {

	protected static final long serialVersionUID = -1488150942213840747L;

	protected Date departDate;// 发车日期 不允许为空
	protected String sellOrgCode;// 售票机构 不允许为空
	protected String sellIp;// 售票人IP 不允许为空
	protected String sellerCode; // 售票人code 不允许为空
	protected String sellway;// 售票方式 不允许为空

	// reachStationcode和schedulecode不允许同时为空,且不允许同时有值
	protected String reachStationCode;// 到站code
	protected String scheduleCode;// 班次code

	protected String ticketoutletsCode;// 售票点code 用于限制可售班次，可售站点 大部份售票方式下不允许为空

	// departStationcode和departDistrictCode不允许同时有值
	protected String departStationCode;// 发车站点code
	protected String departDistrictCode;// 发车站所属区域code

	protected String seatTypeCode; // 座位类型编码

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
	 * @return the departDistrictCode
	 */
	public String getDepartDistrictCode() {
		return departDistrictCode;
	}

	/**
	 * @param departDistrictCode
	 *            the departDistrictCode to set
	 */
	public void setDepartDistrictCode(String departDistrictCode) {
		this.departDistrictCode = departDistrictCode;
	}

	/**
	 * @return the seatTypeCode
	 */
	public String getSeatTypeCode() {
		return seatTypeCode;
	}

	/**
	 * @param seatTypeCode
	 *            the seatTypeCode to set
	 */
	public void setSeatTypeCode(String seatTypeCode) {
		this.seatTypeCode = seatTypeCode;
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
		return "departDate=" + departDate + ",sellOrgCode=" + nvl(sellOrgCode)
				+ ",sellIp=" + nvl(sellIp) + ",sellerCode=" + nvl(sellerCode)
				+ ",sellway=" + nvl(sellway) + ",reachStationCode="
				+ nvl(reachStationCode) + ",scheduleCode=" + nvl(scheduleCode)
				+ ",ticketoutletsCode=" + nvl(ticketoutletsCode)
				+ ",departStationCode=" + nvl(departStationCode)
				+ ",departDistrictCode=" + nvl(departDistrictCode)
				+ ",seatTypeCode=" + nvl(seatTypeCode);
	}
}
