/**
 * 
 */
package cn.nova.bus.sale.remote.param;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * @author ice
 * 废票输出参数类 单条记录
 */
public class ParamCancelTicketOut implements Serializable,Cloneable {

	private static final long serialVersionUID = -1661720453028120416L;
	private String orderno;//订单号 不允许为空
	private String ticketno;//退票的车票票号 不允许为空
	private String scheduleCode;//班次代码		
	private String tickettypeCode;//票类型		
	private Date departdate;//4	发车日期	
	private String departtime;//发车时间	
	private String seatno;//座位号	
	private String departStationCode;//始发站编码	
	private String departStationName;//始发站名称	
	private String reachStationCode;//到达站编码	
	private String reachStationName;//到达站名称	
	private Date selltime;//售票时间	
	private BigDecimal price;//票价	
	private BigDecimal charge;//退票手续费		
	
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
	 * @return the seatno
	 */
	public String getSeatno() {
		return seatno;
	}
	/**
	 * @param seatno the seatno to set
	 */
	public void setSeatno(String seatno) {
		this.seatno = seatno;
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
	 * @return the selltime
	 */
	public Date getSelltime() {
		return selltime;
	}
	/**
	 * @param selltime the selltime to set
	 */
	public void setSelltime(Date selltime) {
		this.selltime = selltime;
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
	 * @return the charge
	 */
	public BigDecimal getCharge() {
		return charge;
	}
	/**
	 * @param charge the charge to set
	 */
	public void setCharge(BigDecimal charge) {
		this.charge = charge;
	}
	
}
