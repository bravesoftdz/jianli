package cn.nova.openapi.sevice;

import java.util.List;
import java.util.Map;

import cn.nova.bus.netsale.model.TicketInfo;
import cn.nova.bus.netsale.model.TicketReturnInfo;
import cn.nova.bus.sale.model.ScheduleAskCondition;
import cn.nova.openapi.model.EncryptRequest;
import cn.nova.openapi.model.request.SeatOrder;
import cn.nova.openapi.model.request.TicketSellOrder;
import cn.nova.openapi.model.response.TicketDetail;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.TicketOrder;

/**
 * 适配器接口
 * @author Mark
 *
 */
public interface OpenApiAdapter {
	/**
	 * 查询联网班次
	 * @param scheduleAskCondition 查询条件 
	 * @see ScheduleAskCondition
	 * @return List<Map<String,Object>> 查询结果列表
	 * @throws Exception 
	 */
	public MethodResult findSchedule(ScheduleAskCondition scheduleAskCondition) throws Exception;
	
	/**
	 * 查询发车站，并封装成List<Map>类型
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> findDepartStation(String param);
	
	/**
	 * 查询发车站，返回对象列表。
	 * @param param
	 * @return
	 */
	public List<Object>  findDepartStation2Array(String param);
	
	/**
	 * 查询到达站
	 * @param departcityid
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> findReachtation(String departcityid,String param);
	
	/**
	 * 锁座
	 * @param param
	 * @return
	 */
	public MethodResult lockSeat(SeatOrder param);
	
	/**
	 * 买票
	 * @param param
	 * @param order
	 * @param ticketentrance
	 * @param buspark
	 * @return
	 */
	public MethodResult sellTick(TicketSellOrder param, TicketOrder order, String  ticketentrance,String buspark);
	
	/**
	 * 解锁
	 * @param param
	 * @return
	 */
	public MethodResult unLockSeat(EncryptRequest param);
	
	/**
	 * 废票
	 * @param opentickets
	 * @return
	 */
	public MethodResult cancelTicket(List<TicketInfo> opentickets);
	
	/**
	 * 退票
	 * @param opentickets
	 * @return
	 */
	public MethodResult returnTicket(List<TicketReturnInfo> opentickets);
	
	/**
	 * 换票号重打
	 * @param param
	 * @return
	 */
	public MethodResult changeTicket(EncryptRequest param);
	
	/**
	 * 查询订单,通过订单号
	 * @param param
	 * @return
	 */
	public TicketDetail querySell(String orderno);
}
