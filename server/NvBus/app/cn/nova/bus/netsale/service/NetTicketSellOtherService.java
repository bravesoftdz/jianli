/**
 * 
 */
package cn.nova.bus.netsale.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import cn.nova.bus.dispatch.model.Seatreserve;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.model.ScheduleAskCondition;
import cn.nova.bus.sale.model.ScheduleDetail;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.RemoteInvokeAuxiliaryProperty;
import cn.nova.utils.commons.TicketOrder;
import cn.nova.utils.commons.TicketPrintInfo;
import cn.nova.utils.orm.PropertyFilter;


/**
 * @author ice
 *
 */
public interface NetTicketSellOtherService {
	
	/**
	 * 查询联网班次
	 * @param scheduleAskCondition 查询条件 
	 * @see ScheduleAskCondition
	 * @return List<Map<String,Object>> 查询结果列表
	 * @throws Exception 
	 */
	public MethodResult findNetSchedule(ScheduleAskCondition scheduleAskCondition,Global global) throws Exception;
	
	/**
	 * 查询联网班次已售详情
	 * @param scheduleDetail 查询条件 
	 * @see ScheduleDetail
	 * @return List<Map<String,Object>> 查询结果列表
	 * @throws Exception 
	 */
	public MethodResult findStowageScheduleDetail(ScheduleDetail scheduleDetail,Global global) throws Exception;
	
	/**
	 * 查询跨区配载班次已售详情
	 * @param scheduleDetail 查询条件 
	 * @see ScheduleDetail
	 * @return List<Map<String,Object>> 查询结果列表
	 * @throws Exception 
	 */
	public MethodResult findNetScheduleDetail(ScheduleDetail scheduleDetail,Global global) throws Exception;
	
	/**
	 * 查询跨区配载班次
	 * @param scheduleDetail 查询条件 
	 * @see ScheduleDetail
	 * @return List<Map<String,Object>> 查询结果列表
	 * @throws Exception 
	 */
	public MethodResult findStowageNetSchedule(List<Map<String,Object>> scheduleplanlist,Global global) throws Exception;
	
	/**
	 * 查询综合调度中配载班次已售数，留位数等
	 * @param scheduleDetail 查询条件 
	 * @see ScheduleDetail
	 * @return List<Map<String,Object>> 查询结果列表
	 * @throws Exception 
	 */
	public List<Map<String, Object>> findNetSoldnum(List<Map<String,Object>> scheduleplanlist,Global global) throws Exception;
	
	
	
	/**
	 * 查询班次剩余座位数
	 * @param propertyFilters
	 * @return List<Ticketprice> 
	 * @throws Exception 
	 */
	public MethodResult findTicketPrices(Date departdate, String schedulesynccode,String departstationcode,String reachstationcode,String seattype,Global global,String departtime) throws Exception;
	
	/**
	 * 查询班次座位状态
	 * @param propertyFilters
	 * @return List<Map<String,Object>>
	 * @throws Exception 
	 */
	public MethodResult findScheduleseats(Date departdate, String schedulesynccode,String departstationcode,Global global) throws Exception;
	
	/**
	 * 售票方法
	 * @param orders 售票订单信息,一个订单可售多张车票
	 * @return 售票结果信息  methodResult.object存储售票记录，结构为List<Map<String,Object>>
	 * @throws ServiceException 
	 * @throws Exception 
	 */
	public MethodResult sellTicket(String transactionid, TicketOrder order,Global global) throws ServiceException, Exception;
	
	/**
	 * 锁定座位
	 * @param orderno 订单号，由客户端生成GUID字符串
	 * @param scheduleplanid 班次计划id
	 * @param seatno   座位号
	 * @return Date 返回解锁时间，锁定失败时返回null
	 */
	public MethodResult lockSeat(UUID orderno,Date departdate, String schedulesynccode,String departstationcode, List<Short> seatnos,List<String> selectSeatStatus,String selectSeattype,Global global) throws Exception;
	
	/**
	 * 解锁座位
	 * @param orderno 订单号，由客户端生成GUID字符串
	 * @return 返回解锁结果boolean 
	 */
	public MethodResult unlockSeat(UUID orderno,String departstationcode,Global global) throws Exception;	
	
	/**
	 * 查询联网班次停靠点 
	 * @param propertyFilterList
	 * @return MethodResult.object中存储List<Map<String, Object>>
	 * @throws Exception 
	 */
	public MethodResult findSchedulestops(Date departdate, String schedulesynccode,String departstationcode,Global global) throws Exception;

	/**
	 * 查询车票打印信息
	 * @param 
	 * @return 
	 */
	public List<TicketPrintInfo> getTicketPrintInfo(List<PropertyFilter> propertyFilters);

	/**
	 * 江西省联网售票锁位
	 * @param departdate 发车日期
	 * @param departtime 发车时间
	 * @param routecode 线路编码
	 * @param schedulecode 班次编码
	 * @param departstationcode 发车站编码
	 * @param reachstationcode 到达站编码
	 * @param orderno 订单号
	 * @param seatnos 座位号列表
	 * @param tickettypelist 票种列表
	 * @param prices 票价列表
	 * @param selectSeattype 座位类型
	 * @return Date 返回解锁时间、List<String> 电子票ID，锁定失败时返回null
	 * @throws Exception 
	 */
	public MethodResult lockSeat_Jxs(
			Date departdate,String departtime, String routecode, String schedulecode, 
			String departstationcode, String reachstationcode, 
			UUID orderno,List<Short> seatnos, List<String> tickettypelist,List<BigDecimal> prices,
			String selectSeattype,Global global,int takekidnum) throws Exception;
	
	/**
	 * 换票号重打车票
	 * @param ticketsellid
	 * @param curTicketNo
	 * @param global
	 * @return
	 * @throws ServiceException
	 */
	public TicketPrintInfo getTicketPrintInfoAndChangeTicketNo(
			long ticketsellid, String curTicketNo,Global global) throws Exception;
	
	public void updateTicketpriceAndScheduleplan(short a,short b,short c,long d);
	
	/**
	 * 联网订票
	 * @param seatreserves
	 * @param global
	 * @return
	 */
	public MethodResult reserveSeat(String transactionid, List<Seatreserve> seatreserves, Global global);
}
