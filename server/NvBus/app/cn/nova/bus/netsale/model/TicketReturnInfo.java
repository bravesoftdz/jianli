package cn.nova.bus.netsale.model;

import java.math.BigDecimal;



/**
 * 用于车站与中心交互的退车票信息
 * @author ice
 *
 */
public class TicketReturnInfo extends TicketInfo {
	private static final long serialVersionUID = 1L;

//	@Transient
	private String orderno;
	//电子票ID
	private String eticketid;
	private String returnBilltypecode;
	private BigDecimal charges;
	private String returnbatchno;
	private String returnvoucherno;
	private String schplansynccode;
	
	private String eticketno;// 配载站电子票号
	
	public String getEticketno() {
		return eticketno;
	}
	public void setEticketno(String eticketno) {
		this.eticketno = eticketno;
	}
	
	public String getOrderno() {
		return orderno;
	}
	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}
	public String getSchplansynccode() {
		return schplansynccode;
	}
	public void setSchplansynccode(String schplansynccode) {
		this.schplansynccode = schplansynccode;
	}
	public String getEticketid() {
		return eticketid;
	}
	public void setEticketid(String eticketid) {
		this.eticketid = eticketid;
	}
	/**
	 * 
	 * @return 退票凭证类型编码
	 */
	public String getReturnBilltypecode() {
		return returnBilltypecode;
	}
	public void setReturnBilltypecode(String returnBilltypecode) {
		this.returnBilltypecode = returnBilltypecode;
	}
	/**
	 * 
	 * @return 手续费
	 */
	public BigDecimal getCharges() {
		return charges;
	}
	public void setCharges(BigDecimal charges) {
		this.charges = charges;
	}
	/**
	 * 
	 * @return 退票批次号
	 */
	public String getReturnbatchno() {
		return returnbatchno;
	}
	public void setReturnbatchno(String returnbatchno) {
		this.returnbatchno = returnbatchno;
	}
	/**
	 * 
	 * @return 退票票号
	 */
	public String getReturnvoucherno() {
		return returnvoucherno;
	}
	public void setReturnvoucherno(String returnvoucherno) {
		this.returnvoucherno = returnvoucherno;
	}

}