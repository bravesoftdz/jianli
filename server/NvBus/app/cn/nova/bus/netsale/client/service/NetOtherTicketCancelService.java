/**
 * 
 */
package cn.nova.bus.netsale.client.service;

import java.util.List;

import cn.nova.bus.netsale.model.TicketInfo;
import cn.nova.utils.commons.MethodResult;


/**
 * @author ice
 *
 */
public interface NetOtherTicketCancelService {
	
	/**
	 * 废票方法
	 * @param tickets 要废票的车票列表
	 * @return 废票结果信息  
	 */
	public MethodResult cancelTickets(List<TicketInfo> tickets,String cancelbyname,String ticketoutlets);
	
}
