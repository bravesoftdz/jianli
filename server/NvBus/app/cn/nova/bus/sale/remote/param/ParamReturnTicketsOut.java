/**
 * 
 */
package cn.nova.bus.sale.remote.param;

import java.util.List;

import cn.nova.utils.commons.MethodResult;

/**
 * @author ice
 * 退票输出参数类
 */
public class ParamReturnTicketsOut extends MethodResult {

	private static final long serialVersionUID = 5323632686737243094L;
	private List<ParamReturnTicketOut> returnTickets;//退票明细列表

	public List<ParamReturnTicketOut> getReturnTickets() {
		return returnTickets;
	}

	public void setReturnTickets(List<ParamReturnTicketOut> returnTickets) {
		this.returnTickets = returnTickets;
	}

}
