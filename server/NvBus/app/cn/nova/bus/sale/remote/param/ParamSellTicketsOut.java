/**
 * 
 */
package cn.nova.bus.sale.remote.param;

import java.util.List;

import cn.nova.utils.commons.MethodResult;

/**
 * @author ice
 * 锁位返回结果类
 */
public class ParamSellTicketsOut extends MethodResult {
	
	private static final long serialVersionUID = 296626399259709896L;
	private List<ParamSellTicketOut> selledtickets;//售出的座位明细

	public List<ParamSellTicketOut> getSelledtickets() {
		return selledtickets;
	}

	public void setSelledtickets(List<ParamSellTicketOut> selledtickets) {
		this.selledtickets = selledtickets;
	}
	
}
