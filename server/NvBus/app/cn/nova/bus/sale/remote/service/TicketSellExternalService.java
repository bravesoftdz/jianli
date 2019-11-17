/**
 * 
 */
package cn.nova.bus.sale.remote.service;

import java.util.Date;
import java.util.List;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.remote.param.ParamAvailableTicketOut;
import cn.nova.bus.sale.remote.param.ParamBilldamageIn;
import cn.nova.bus.sale.remote.param.ParamCancelTicketsIn;
import cn.nova.bus.sale.remote.param.ParamCancelTicketsOut;
import cn.nova.bus.sale.remote.param.ParamDepartStationsOut;
import cn.nova.bus.sale.remote.param.ParamFindScheduleIn;
import cn.nova.bus.sale.remote.param.ParamFindSchedulesOut;
import cn.nova.bus.sale.remote.param.ParamLockSeatsIn;
import cn.nova.bus.sale.remote.param.ParamLockSeatsOut;
import cn.nova.bus.sale.remote.param.ParamPrintOut;
import cn.nova.bus.sale.remote.param.ParamPrintOuts;
import cn.nova.bus.sale.remote.param.ParamQueryPrintTicketOut;
import cn.nova.bus.sale.remote.param.ParamReturnTicketsIn;
import cn.nova.bus.sale.remote.param.ParamReturnTicketsOut;
import cn.nova.bus.sale.remote.param.ParamSellTicketsIn;
import cn.nova.bus.sale.remote.param.ParamSellTicketsOut;
import cn.nova.bus.sale.remote.param.ParamStationsOut;
import cn.nova.bus.sale.remote.param.ParamTicketReturnQrysOut;
import cn.nova.bus.sale.remote.param.ParamUnLockSeatOut;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.TicketOrder;


/**
 * @author ice
 * 核心售票业务接口，各种售票都式最后都调用些接口售票
 *
 */
public interface TicketSellExternalService {
	
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
	public ParamLockSeatsOut lockSeat(ParamLockSeatsIn paramLockSeatsIn);
	
	

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
	 * @throws Exception 
	 * @throws ServiceException 
	 * 
	 */
	public ParamSellTicketsOut sellTicket(ParamSellTicketsIn order) throws Exception;

	public ParamSellTicketsOut ticketRePrintAndChangeTicketNo(
			String oldTicketno, String curTicketNo,String usercode,String ticketoutletscode,String ip);
	
	/**
	 * 站外售票方法
	 * @param orders 售票订单信息,一个订单可售多张车票
	 * @return 售票结果信息  methodResult.object存储售票记录，结构为List<Map<String,Object>>
	 * @throws Exception 
	 * @throws ServiceException 
	 */
	public ParamSellTicketsOut SellReceipt(ParamSellTicketsIn order) throws Exception;
	
	/**
	 * 查询订单信息
	 * @param orderno 订单号
	 * @return Object对象存储TicketOrdersOut
	 */
//	public MethodResult GetOrderInfo(String orderno);

	/**
	 * 取所有上车站
	 * @param lastUpdateTime 更新时间点，日期时间类型。
	 * @return 
	 */
	public ParamDepartStationsOut GetAllDepartStation(Date lastUpdateTime);
	
	
	/**
	 * 取站点信息(获取指定更新时间点以后的站点表变更数据) 
	 * @param lastUpdateTime 更新时间点，日期时间类型。
	 * @return
	 */
	public ParamStationsOut  GetAllStation(Date lastUpdateTime);

//	/**
//	 * 锁票参数查询 获取客运系统锁座参数 
//	 * @return
//	 */
//	public ParamLockParamOut GetLockParam(String usercode);

	/**
	 * 票号获取 获取指定工号的售票操作员的物理票号。 
	 * @param usercode 操作员工号
	 * @return
	 */
	public ParamAvailableTicketOut GetAvailableTicket(String usercode,String curTicketNo);
	
	/**
	 * 坏票登记
	 * @param paramBilldamageIn 坏票登记输入参数
	 * @return
	 */
	public MethodResult billdamage(ParamBilldamageIn paramBilldamageIn);
	
	/**
	 * 退票前查询
	 * @param orderno
	 * @param ticketnos
	 * @return
	 */
	public ParamTicketReturnQrysOut ticketRetrunQry(String orderno,List<String> ticketnos);
	
	/**
	 * 废票前查询
	 * @param orderno
	 * @param ticketnos
	 * @return
	 */
	public ParamTicketReturnQrysOut ticketCancelQry(String orderno,List<String> ticketnos);
	
	/**
	 * 退票
	 * @param paramReturnTicketsIn
	 * @return
	 */
	public ParamReturnTicketsOut returnticket(ParamReturnTicketsIn paramReturnTicketsIn);
	
	/**
	 * 废票
	 * @param paramCancelTicketsIn
	 * @return
	 */
	public ParamCancelTicketsOut cancelticket(ParamCancelTicketsIn paramCancelTicketsIn);
	
	
	/**
	 * 取票查询接口
	* @param custType 类型
	 * @param custNo 号码
	 * @param custPin 验证码
	 * @return
	 */
	public ParamQueryPrintTicketOut TicketList(String custType,String custNo,String custPin);
	
	/**
	 * 取票打印接口
	* @param orderNo 订单ID
	 * @param ticketID 售票ID
	 * @param cTicketNo 当前票号
	 * @return
	 */
	public ParamPrintOuts TicketPrint(String orderNo,String ticketID,String cTicketNo,String userCode);
	
	

	
}
