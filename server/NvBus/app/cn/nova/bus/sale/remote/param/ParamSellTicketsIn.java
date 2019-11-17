/**
 * 
 */
package cn.nova.bus.sale.remote.param;

import java.io.Serializable;
import java.util.List;

/**
 * @author ice
 * 售票参数类
 */
public class ParamSellTicketsIn implements Serializable {

	private static final long serialVersionUID = 4224603031926304549L;
	private String sellOrgCode;//调用者机构  //不允许为空
	private String sellIp;//操作者IP  //不允许为空
	private String sellerCode;//用户id //不允许为空
	
	private String batchno;
	private String startTicketNO;  //不允许为空
	
	private String ticketoutletsname;
	private String ticketoutletsCode;
	private String sellway;  //不允许为空
    private String paymethod; //不允许为空
	
	private String orderno;//订单号  //不允许为空
//	private int seatnums;//整张订单要出售座位总数
//	private BigDecimal totalmoney;
	
	private boolean billCustomManage=false; //调用者自己管理票证跳号及应缴款

	private List<ParamSellTicketIn>  sellseats;//要售出的座位列表

	/**
	 * @return the sellOrgCode
	 */
	public String getSellOrgCode() {
		return sellOrgCode;
	}

	/**
	 * @param sellOrgCode the sellOrgCode to set
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
	 * @param sellIp the sellIp to set
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
	 * @param sellerCode the sellerCode to set
	 */
	public void setSellerCode(String sellerCode) {
		this.sellerCode = sellerCode;
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
	 * @return the startTicketNO
	 */
	public String getStartTicketNO() {
		return startTicketNO;
	}

	/**
	 * @param startTicketNO the startTicketNO to set
	 */
	public void setStartTicketNO(String startTicketNO) {
		this.startTicketNO = startTicketNO;
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
	 * @return the sellway
	 */
	public String getSellway() {
		return sellway;
	}

	/**
	 * @param sellway the sellway to set
	 */
	public void setSellway(String sellway) {
		this.sellway = sellway;
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
	 * @return the sellseats
	 */
	public List<ParamSellTicketIn> getSellseats() {
		return sellseats;
	}

	/**
	 * @param sellseats the sellseats to set
	 */
	public void setSellseats(List<ParamSellTicketIn> sellseats) {
		this.sellseats = sellseats;
	}

	public String getPaymethod() {
		return paymethod;
	}

	public void setPaymethod(String paymethod) {
		this.paymethod = paymethod;
	}

	public boolean getBillCustomManage() {
		return billCustomManage;
	}

	public void setBillCustomManage(boolean billCustomManage) {
		this.billCustomManage = billCustomManage;
	}
	private String nvl(String s) {
		if (s != null) {
			return s;
		} else {
			return "";
		}
	}
	public String getTicketoutletsname() {
		return ticketoutletsname;
	}

	public void setTicketoutletsname(String ticketoutletsname) {
		this.ticketoutletsname = ticketoutletsname;
	}

	@Override
	public String toString() {
		return "sellOrgCode=" + nvl(sellOrgCode)
				+ ",sellIp=" + nvl(sellIp) + ",sellerCode="
				+ nvl(sellerCode) + ",batchno=" + nvl(batchno) + ",startTicketNO="
				+ nvl(startTicketNO) + ",ticketoutletsCode="
				+ nvl(ticketoutletsCode) + ",sellway=" + nvl(sellway)
				+ ",paymethod=" + nvl(paymethod)
				+ ",orderno=" + nvl(orderno);
	}
}
