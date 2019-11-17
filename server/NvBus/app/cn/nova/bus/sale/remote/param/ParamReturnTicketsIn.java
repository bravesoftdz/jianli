/**
 * 
 */
package cn.nova.bus.sale.remote.param;

import java.io.Serializable;
import java.util.List;

/**
 * @author ice
 * 退票输入参数类
 */
public class ParamReturnTicketsIn implements Serializable {

	private static final long serialVersionUID = 2349587556984319814L;
	private String returnPrintStartNo; //退票打印凭证的起始票号
	private String returnUserCode; //退票人
	private String returnIp;//退票IP
	private String ticketoutletsCode;//退票所在售票点
	private String returnOrgCode; //退票机构编码
	private boolean billCustomManage=false; //调用者自己管理票证跳号及应缴款

	private List<ParamReturnTicketIn> returnTickets;//退票明细列表

	/**
	 * @return the returnPrintStartNo
	 */
	public String getReturnPrintStartNo() {
		return returnPrintStartNo;
	}

	/**
	 * @param returnPrintStartNo the returnPrintStartNo to set
	 */
	public void setReturnPrintStartNo(String returnPrintStartNo) {
		this.returnPrintStartNo = returnPrintStartNo;
	}

	/**
	 * @return the returnUserCode
	 */
	public String getReturnUserCode() {
		return returnUserCode;
	}

	/**
	 * @param returnUserCode the returnUserCode to set
	 */
	public void setReturnUserCode(String returnUserCode) {
		this.returnUserCode = returnUserCode;
	}

	/**
	 * @return the returnIp
	 */
	public String getReturnIp() {
		return returnIp;
	}

	/**
	 * @param returnIp the returnIp to set
	 */
	public void setReturnIp(String returnIp) {
		this.returnIp = returnIp;
	}

	/**
	 * @return the ticketoutletsCode
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
	 * @return the returnTickets
	 */
	public List<ParamReturnTicketIn> getReturnTickets() {
		return returnTickets;
	}

	/**
	 * @param returnTickets the returnTickets to set
	 */
	public void setReturnTickets(List<ParamReturnTicketIn> returnTickets) {
		this.returnTickets = returnTickets;
	}

	public String getReturnOrgCode() {
		return returnOrgCode;
	}

	public void setReturnOrgCode(String returnOrgCode) {
		this.returnOrgCode = returnOrgCode;
	}

	public boolean getBillCustomManage() {
		return billCustomManage;
	}

	public void setBillCustomManage(boolean billCustomManage) {
		this.billCustomManage = billCustomManage;
	}


}
