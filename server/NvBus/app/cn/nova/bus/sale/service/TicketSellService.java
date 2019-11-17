/**
 * 
 */
package cn.nova.bus.sale.service;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.sale.model.NetScheduleDetail;
import cn.nova.bus.sale.model.ScheduleAskCondition;
import cn.nova.bus.sale.model.ScheduleDetail;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.model.Ticketsellother;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.TicketOrder;
import cn.nova.utils.commons.TicketPrintInfo;
import cn.nova.utils.orm.PropertyFilter;


/**
 * @author ice
 *
 */
public interface TicketSellService {
	
	/**
	 * 查询可售班次
	 * @param scheduleAskCondition 查询条件 
	 * @see ScheduleAskCondition
	 * @return 查询结果列表
	 */
	public List<Map<String,Object>> findSchedule(ScheduleAskCondition scheduleAskCondition,Global global);
	
	/**
	 * 查询已售班次详情
	 * @param scheduleAskCondition 查询条件 
	 * @see ScheduleAskCondition
	 * @return 查询结果列表
	 */
	public List<Map<String,Object>> findScheduleDetail(ScheduleDetail scheduleDetail);
	public List<Map<String,Object>> findScheduleDetail2(ScheduleDetail scheduleDetail);
	public Schedule findScheduleByCode(NetScheduleDetail sd);
	
	/**
	 * 查询班次剩余座位数
	 * @param propertyFilters
	 * @return
	 */
	public List<Ticketprice> findTicketPrices(List<PropertyFilter> propertyFilters);
	
	/**
	 * 查询班次剩余座位数
	 * @param ticketpriceid
	 * @param 当前售票点
	 * @return
	 */
	public Ticketprice findTicketPrices(long ticketpriceid,long ticketoutletsid);
	
	/**
	 * 查询班次座位状态
	 * @param propertyFilters
	 * @return
	 */
//	public List<Map<String,Object>> findScheduleseats(List<PropertyFilter> propertyFilters);
	
	/**
	 * 查询班次座位状态,支持分段售票
	 * @param ticketpriceid 售票界面显示座位图的票价ID
	 * @return 班次座位状态
	 * @throws Exception 
	 */
	public MethodResult findScheduleseatsByTicketpriceId(long ticketpriceid,Global global) throws Exception;
	
	/**
	 * 售票方法
	 * @param orders 售票订单信息,一个订单可售多张车票
	 * @return 售票结果信息  methodResult.object存储售票记录，结构为List<Map<String,Object>>
	 * @throws ServiceException 
	 * @throws Exception 
	 */
	public MethodResult sellTicket(String transationId, TicketOrder order,Global global) throws ServiceException, Exception;
	
	
	/**
	 * 改签方法
	 * @param orders 售票订单信息,一个订单中只有一张张车票
	 * @param ticketIdToBeChange 要改签的车票
	 * @param insuranceIdToBeChange 要改签的保险
	 * @return 售票结果信息  methodResult.object存储售票记录，结构为List<Map<String,Object>>
	 * @throws ServiceException 
	 * @throws Exception 
	 */
	public MethodResult changeTicket(String transationId, TicketOrder order,List<Long> ticketIdToBeChanges,List<Long> insuranceIdToBeChanges,Global global) throws ServiceException, Exception;
	
	/**
	 * 改签方法:
	 * 包括：本地改为本地
	 * 		 本地改为联网
	 * 		 联网改为本地
	 */
	public MethodResult changeTicket_All(String transationId, TicketOrder order, List<Long> ticketIdToBeChanges,List<Long> insuranceIdToBeChanges,Global global) throws ServiceException, Exception;
	
	/**
	 * 锁定座位
	 * @param orderno 订单号，由客户端生成GUID字符串
	 * @param scheduleplanid 班次计划id
	 * @param seatno   座位号
	 * @return 返回解锁时间，锁定失败时返回null
	 */
	public Date lockSeat(UUID orderno,long scheduleplanid,List<Short> seatnos,List<String> selectSeatStatus,String selectSeattype,Global global) throws Exception;
	
	/**
	 * 解锁座位
	 * @param orderno 订单号，由客户端生成GUID字符串
	 * @param scheduleplanid 班次计划id
	 * @param seatno   座位号
	 * @return 返回解锁结果
	 * @throws Exception 
	 */
	public boolean unlockSeat(UUID orderno,Long scheduleplanid,List<Short> seatnos) throws Exception;
	/**
	 * 解锁座位
	 * @param orderno 订单号，由客户端生成GUID字符串
	 * @param scheduleplanid 班次计划id
	 * @return 返回解锁结果
	 */
	public boolean unlockSeat(UUID orderno,Long scheduleplanid) throws Exception;
	
	/**
	 * 解锁座位
	 * @param orderno 订单号，由客户端生成GUID字符串
	 * @return 返回解锁结果
	 */
	public boolean unlockSeat(UUID orderno) throws Exception;	
	
	/**
	 * 查询车票打印信息（用于重打车票）
	 * @param 
	 * @return 
	 */
	public List<TicketPrintInfo> getTicketPrintInfo(List<PropertyFilter> propertyFilters,String oldticketno);

	/**
	 * 查询车票打印信息（用于换票号重打车票）
	 * @param ticketsellid 原车票ID 
	 * @param curTicketNo 当前票号
	 * @return 
	 */
	public TicketPrintInfo getTicketPrintInfoAndChangeTicketNo(long ticketsellid,String curTicketNo,Global global) throws ServiceException ;
	/**
	 * 根据获取实例
	 * @param id
	 * @return
	 */
	Ticketsell getTicketsellById(Long id);
	
	int updateTicketStatusById(Long id, int statusCode);
	/**
	 * 查询订票信息
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> qryseatreserve(List<PropertyFilter> propertyFilterList,long orgid);
	
	/**
	 * 查询团体票信息
	 * @param propertyFilterList
	 * @return
	 */
	public List<Ticketsell> findTuanTicketsell(String ticketno,Date departdate,long scheduleplanid);
	
	/**
	 * 将团体票的座位号转化成特殊字符串，例如1，2，3，5，7，9 转化为   1-3，5-7，9
	 * @param propertyFilterList
	 * @return
	 */
	public String seatnoToSeatstr(List<Short> list);
	
	/**
	 * 通过卖的票的id获取到电子票取票信息
	 * @param ticketsellid
	 */
	public void qryTicketsellotherByTicketsellid(long ticketsellid) throws ServiceException ;

	public MethodResult proEticketsell(MethodResult methodResult);
}
