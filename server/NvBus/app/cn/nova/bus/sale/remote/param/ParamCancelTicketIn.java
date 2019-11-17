/**
 * 
 */
package cn.nova.bus.sale.remote.param;

import java.io.Serializable;

/**
 * @author ice
 * 废票输入参数类 单条记录
 */
public class ParamCancelTicketIn implements Serializable,Cloneable {

	private static final long serialVersionUID = 8138922574658387440L;
	private String orderno;//订单号 不允许为空
	private String ticketno;//要退票的车票票号 不允许为空
	
	public String getOrderno() {
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	public String getTicketno() {
		return ticketno;
	}

	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
	}
	
}
