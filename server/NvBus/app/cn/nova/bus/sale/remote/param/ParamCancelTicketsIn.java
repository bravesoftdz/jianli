/**
 * 
 */
package cn.nova.bus.sale.remote.param;

import java.io.Serializable;
import java.util.List;

/**
 * @author ice
 * 废票输入参数类
 */
public class ParamCancelTicketsIn implements Serializable {

	private static final long serialVersionUID = 2349587556984319814L;
	private String cancelUserCode; //废票人
	private String cancelIp;//废票IP
	private String ticketoutletsCode;//废票所在售票点
	private String cancelOrgCode; //废票机构编码
	private boolean billCustomManage=false; //调用者自己管理票证跳号及应缴款

	private List<ParamCancelTicketIn> cancelTickets;//废票明细列表

	/**
	 * @cancel the cancelUserCode
	 */
	public String getCancelUserCode() {
		return cancelUserCode;
	}

	/**
	 * @param cancelUserCode the cancelUserCode to set
	 */
	public void setCancelUserCode(String cancelUserCode) {
		this.cancelUserCode = cancelUserCode;
	}

	/**
	 * @cancel the cancelIp
	 */
	public String getCancelIp() {
		return cancelIp;
	}

	/**
	 * @param cancelIp the cancelIp to set
	 */
	public void setCancelIp(String cancelIp) {
		this.cancelIp = cancelIp;
	}

	/**
	 * @cancel the ticketoutletsCode
	 */
	public String getTicketoutletsCode() {
		return ticketoutletsCode;
	}

	/**
	 * @param ticketoutletsCode the ticketoutletsCode to set
	 */
	public void setTicketoutletsCode(String ticketoutletsCode) {
		this.ticketoutletsCode = ticketoutletsCode;
	}

	/**
	 * @cancel the cancelTickets
	 */
	public List<ParamCancelTicketIn> getCancelTickets() {
		return cancelTickets;
	}

	/**
	 * @param cancelTickets the cancelTickets to set
	 */
	public void setCancelTickets(List<ParamCancelTicketIn> cancelTickets) {
		this.cancelTickets = cancelTickets;
	}

	public String getCancelOrgCode() {
		return cancelOrgCode;
	}

	public void setCancelOrgCode(String cancelOrgCode) {
		this.cancelOrgCode = cancelOrgCode;
	}

	public boolean getBillCustomManage() {
		return billCustomManage;
	}

	public void setBillCustomManage(boolean billCustomManage) {
		this.billCustomManage = billCustomManage;
	}


}
