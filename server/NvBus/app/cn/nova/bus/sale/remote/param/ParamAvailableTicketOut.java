/**
 * 
 */
package cn.nova.bus.sale.remote.param;

import cn.nova.utils.commons.MethodResult;

/**
 * @author ice
 *
 */
public class ParamAvailableTicketOut extends MethodResult {
	private static final long serialVersionUID = -645928604182747939L;
	private String batchno;
	private String curticketno;//当前物理票号
	private String endticketno;//截止票号
	
	public String getCurticketno() {
		return curticketno;
	}
	public void setCurticketno(String curticketno) {
		this.curticketno = curticketno;
	}
	public String getEndticketno() {
		return endticketno;
	}
	public void setEndticketno(String endticketno) {
		this.endticketno = endticketno;
	}
	public String getBatchno() {
		return batchno;
	}
	public void setBatchno(String batchno) {
		this.batchno = batchno;
	}

}
