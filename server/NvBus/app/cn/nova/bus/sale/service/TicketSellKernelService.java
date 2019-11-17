/**
 * 
 */
package cn.nova.bus.sale.service;

import java.util.List;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.param.ParamFindScheduleIn;
import cn.nova.bus.sale.param.ParamLockSeatsIn;
import cn.nova.bus.sale.param.ParamSellTicketsIn;
import cn.nova.bus.sale.remote.param.ParamFindSchedulesOut;
import cn.nova.bus.sale.remote.param.ParamLockSeatsOut;
import cn.nova.bus.sale.remote.param.ParamSellTicketOut;
import cn.nova.bus.sale.remote.param.ParamSellTicketsOut;
import cn.nova.bus.sale.remote.param.ParamUnLockSeatOut;


/**
 * @author ice
 * 核心售票业务接口，各种售票都式最后都调用些接口售票
 *
 */
public interface TicketSellKernelService {
	
	/**
	 * 查询可售班次
	 * @param findScheduleParam 查询条件 
	 * @see ParamFindScheduleIn
	 * @return 查询结果列表
	 */
	//所有地方都要调用      取班次列表  票价、座位数、发车时间等
	public ParamFindSchedulesOut findSchedule(ParamFindScheduleIn paramFindScheduleIn);

	/**
	 * 查询班次座位状态  本地售票 &联网售票
	 * @param propertyFilters
	 * @return  Scheduleseats 按seatno排序   MethodResult     
	 */
//	public List<Map<String,Object>> findScheduleseats(List<PropertyFilter> propertyFilters);
	
	
	
	/**
	 * 锁定座位
	 * 
	 * 锁定座位 按照参数中发车日期、发车时间、车次、起点站、终点站等信息锁定座位，并将参数中的订单号与锁定的座位信息进行关联，返回锁定座位的信息。
	 * 必须按订单的参数同时锁定全部座位，不可只锁定部分座位；
	 * 因网络数据传输原因造成调用锁座接口后不能正常获取到返回结果、或返回结果出现数据丢包等情况，需要重新调用锁座接口。对于相同的订单号重复请求，如已锁定座位成功，返回已锁定座位的结果（按返回值数据结构），不能出现重复锁座的情况。  
	 * 锁定座位时必须按匹配seattypecode,pricetypecode的对价格进行校验，如价格有差异，返回锁定失败。  

	 * @param seatnos   尝试锁定的座位号
	 * @return 返回解锁时间，锁定失败时返回null
	 * @throws ServiceException 
	 * 
	 * 
	 */
	public ParamLockSeatsOut lockSeat(ParamLockSeatsIn paramLockSeatsIn) throws ServiceException;
	
	

	/**
	 * 解锁座位
	 * @param orderno 订单号，由客户端生成GUID字符串
	 * @param scheduleplanid 班次计划id
	 * @param seatno 座位号
	 * @return 返回解锁结果
	 * @throws Exception 
	 */
	public ParamUnLockSeatOut unlockSeat(String orderno,Long scheduleplanid,List<Short> seatnos);
	
	/**
	 * 解锁座位
	 * @param orderno 订单号，由客户端生成GUID字符串
	 * @param scheduleplanid 班次计划id
	 * @return 返回解锁结果
	 */
	public ParamUnLockSeatOut unlockSeat(String orderno,Long scheduleplanid);
	
	/**
	 * 解锁座位
	 * @param orderno 订单号，由客户端生成GUID字符串    RemoteInvokeAuxiliaryProperty没用到
	 * @return 返回解锁结果   MethodResult   WSResult
	 */ 
	public ParamUnLockSeatOut unlockSeat(String orderno);	
	
	
	

	
	
	/**
	 * 售票方法
	 * @param orders 售票订单信息,一个订单可售多张车票
	 * @return 售票结果信息  methodResult.object存储售票记录，结构为List<Map<String,Object>>
	 * @throws ServiceException 
	 * @throws Exception 
	 * 
	 */
	public ParamSellTicketsOut sellTicket(ParamSellTicketsIn order) throws ServiceException, Exception;

	/**
	 * 站外售票方法
	 * @param orders 售票订单信息,一个订单可售多张车票
	 * @return 售票结果信息  methodResult.object存储售票记录，结构为List<Map<String,Object>>
	 * @throws ServiceException 
	 * @throws Exception 
	 * 
	 */
	public ParamSellTicketsOut SellReceipt(ParamSellTicketsIn order) throws ServiceException, Exception;
	
	public ParamSellTicketsOut ticketRePrintAndChangeTicketNo(
			long ticketsellid, String curTicketNo,long userid,long ticketoutletsid,String ip) throws ServiceException;
	/**
	 * 查询订单信息
	 * @param orderno 订单号
	 * @return Object对象存储TicketOrdersOut
	 */
//	public MethodResult GetOrderInfo(String orderno);
	
}
