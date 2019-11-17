/**
 * 
 */
package cn.nova.bus.sale.remote.param;

import java.util.List;

import cn.nova.utils.commons.MethodResult;

/**
 * @author ice
 * 废票输出参数类
 */
public class ParamCancelTicketsOut extends MethodResult {

	private static final long serialVersionUID = 5751097820776938278L;
	private List<ParamCancelTicketOut> cancelTickets;//退票明细列表
	
	public List<ParamCancelTicketOut> getCancelTickets() {
		return cancelTickets;
	}
	public void setCancelTickets(List<ParamCancelTicketOut> cancelTickets) {
		this.cancelTickets = cancelTickets;
	}

}
