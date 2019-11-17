/**
 * 
 */
package cn.nova.bus.sale.remote.param;

import java.io.Serializable;

/**
 * @author ice
 * 坏票登记参数类
 */
public class ParamBilldamageIn implements Serializable {

	private static final long serialVersionUID = -241950048971280642L;
	private String usercode;//领票人编码  //不允许为空
	private String batchno;//领票批次号  
	private String curticketno;//当前票号  //不允许为空
	private long damagednum;//废票数量  大于0
	private String opusercode;//废票人编码  //不允许为空
	private String reason;//废票原因  //不允许为空
	private String ip;
	private String ticketoutletsCode;//售票点编码
	
	/**
	 * @return the usercode
	 */
	public String getUsercode() {
		return usercode;
	}
	/**
	 * @param usercode the usercode to set
	 */
	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}
	/**
	 * @return the batchno
	 */
	public String getBatchno() {
		return batchno;
	}
	/**
	 * @param batchno the batchno to set
	 */
	public void setBatchno(String batchno) {
		this.batchno = batchno;
	}
	/**
	 * @return the curticketno
	 */
	public String getCurticketno() {
		return curticketno;
	}
	/**
	 * @param curticketno the curticketno to set
	 */
	public void setCurticketno(String curticketno) {
		this.curticketno = curticketno;
	}
	/**
	 * @return the damagednum
	 */
	public long getDamagednum() {
		return damagednum;
	}
	/**
	 * @param damagednum the damagednum to set
	 */
	public void setDamagednum(long damagednum) {
		this.damagednum = damagednum;
	}
	/**
	 * @return the opusercode
	 */
	public String getOpusercode() {
		return opusercode;
	}
	/**
	 * @param opusercode the opusercode to set
	 */
	public void setOpusercode(String opusercode) {
		this.opusercode = opusercode;
	}
	/**
	 * @return the reason
	 */
	public String getReason() {
		return reason;
	}
	/**
	 * @param reason the reason to set
	 */
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getTicketoutletsCode() {
		return ticketoutletsCode;
	}
	public void setTicketoutletsCode(String ticketoutletsCode) {
		this.ticketoutletsCode = ticketoutletsCode;
	}
	
}
