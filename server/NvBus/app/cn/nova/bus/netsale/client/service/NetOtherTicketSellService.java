/**
 * 
 */
package cn.nova.bus.netsale.client.service;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import cn.nova.bus.dispatch.model.SeatreserveIn;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.RemoteInvokeAuxiliaryProperty;
import cn.nova.utils.commons.TicketOrder;


/**
 * @author ice
 *
 */
public interface NetOtherTicketSellService {
	
	/**
	 * 查询跨区配客班次最新状态（正常、报停、晚点、被并、脱班、停售）
	 * @param departdate 发车日期
	 * @param schedulesynccode 班次synccode
	 * @return 班次状态编码
	 */
	public String findSchedulestatus(Date departdate,String schedulesynccode);
	
	/**
	 * 修改配客站营运类型
	 * */
	public MethodResult modifySchedulePlanStatus(Date departdate,String schedulesynccode, String worktype);
	
	/**
	 * 查询班次剩余座位数
	 * @param propertyFilters
	 * @return mehtodResult.object存储对象为Object[]{List<cn.nova.centre.base.model.Ticketprice>,String(departtime)}
	 */
	public MethodResult findTicketPrices(Date departdate,String schedulesynccode,String departstationcode,String reachstationcode,String seattype);
	
	/**
	 * 查询班次座位状态
	 * @param propertyFilters
	 * @return mehtodResult.object存储对象为List<Map<String,Object>>
	 */
	public MethodResult findScheduleseats(Date departdate,String schedulesynccode);
	
	/**
	 * 售票方法
	 * @param orders 售票订单信息,一个订单可售多张车票
	 * @return 售票结果信息  methodResult.object存储售票记录，结构为List<Map<String,Object>>
	 * @throws ServiceException 
	 */
	public MethodResult sellTicket(RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty,TicketOrder order);
	
	/**
	 * 锁定座位
	 * @param orderno 订单号，由客户端生成GUID字符串
	 * @param scheduleplanid 班次计划id
	 * @param seatno   座位号
	 * @return methodResult.object存储[Date,List<Short>] 返回解锁时间及实际锁定的座位号列表，锁定失败时返回null
	 */
	public MethodResult lockSeat(RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty,Date departdate,String schedulesynccode,UUID orderno,List<Short> seatnos,List<String> selectSeatStatus,String selectSeattype);
	
	/**
	 * 解锁座位
	 * @param orderno 订单号，由客户端生成GUID字符串
	 * @return methodResult.object存储boolean 返回解锁结果
	 */
	public MethodResult unlockSeat(RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty,UUID orderno);

	/**
	 * 修改票号
	 * @param oldTicketno
	 * @param newTicketNo
	 * @return
	 */
	public MethodResult changeTicketNo(RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty,String oldTicketno, String newTicketNo);	
	
	/**
	 * 联网订票
	 * @param remoteInvokeAuxiliaryProperty
	 * @param paramSeatreserve
	 */
	public MethodResult reserveSeat(RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty, SeatreserveIn sin);
}
