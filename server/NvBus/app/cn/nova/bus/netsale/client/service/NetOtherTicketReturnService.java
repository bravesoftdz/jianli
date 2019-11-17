/**
 * 
 */
package cn.nova.bus.netsale.client.service;

import java.util.List;

import cn.nova.bus.netsale.model.TicketReturnInfo;
import cn.nova.utils.commons.MethodResult;


/**
 * @author ice
 *
 */
public interface NetOtherTicketReturnService {
	
	/**
	 * 废票方法
	 * @param tickets 要废票的车票列表
	 * @return 废票结果信息  
	 */
	public MethodResult returnTickets(List<TicketReturnInfo> tickets,String cancelbyname,String ticketoutlets);
	
	/**
	 * 联网改签
	 */
	public MethodResult changetickets_O2L(List<TicketReturnInfo> tickets, String cancelbyname,String ticketoutlets);
}
