package cn.nova.bus.sale.remote.param;

import java.util.List;

import cn.nova.utils.commons.MethodResult;

public class ParamQueryPrintTicketOut extends MethodResult {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7386527881028545315L;
	private List<ParamQueryPrintTicket> paramQueryPrintTickets;//取票列表

	public List<ParamQueryPrintTicket> getParamQueryPrintTickets() {
		return paramQueryPrintTickets;
	}

	public void setParamQueryPrintTickets(
			List<ParamQueryPrintTicket> paramQueryPrintTickets) {
		this.paramQueryPrintTickets = paramQueryPrintTickets;
	}

}
