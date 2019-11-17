/**
 * 
 */
package cn.nova.bus.eticketsale.service;

import java.util.Date;

import cn.nova.centre.ws.model.LockSeatesInfo;
import cn.nova.centre.ws.model.SellseatsOrderInfo;
import cn.nova.centre.ws.model.UpdateEticketsInfo;
import cn.nova.utils.commons.MethodResult;


/**
 * @author ice
 *
 */
public interface ETicketSellService {
	
/****************************************网上售票调用************************************************/
	/**
	 * 锁定座位
	 * @param lockSeatesInfo 锁位输入信息
	 * @return Object对象为LockSeatesOut，锁定失败时返回null
	 */
	public MethodResult lockSeat(LockSeatesInfo lockSeatesInfo);
	
	/**
	 * 解锁座位
	 * @param orderno 订单号，由客户端生成GUID字符串
	 * @return boolean 返回解锁结果
	 */
	public MethodResult unlockSeat(String orderno);	

	/**
	 * 售票方法
	 * @param orders 售票订单信息,一个订单可售多张车票
	 * @return 售票结果信息  methodResult.object存储售票记录，结构为SellseatsOrderOut
	 */
	public MethodResult sellTicket(String sellorgcode,SellseatsOrderInfo order);
	
	/**
	 * 查询订单信息
	 * @param orderno 订单号
	 * @return Object对象存储TicketOrdersOut
	 */
	public MethodResult GetOrderInfo(String orderno);
	
	/**
	 * 查询最新票价、剩余座位数
	 * @param departdate 发车日期
	 * @param schedulecode 班次编码
	 * @param departstationcode 发车站
	 * @param reachstationcode 到达站
	 * @return Object对象存储QueriedSeatsOrderOut
	 */
	public MethodResult GetSeatInfo(Date departdate,String schedulecode,String departstationcode,String reachstationcode);

	/**
	 * 电子票票号、验证码修改
	 * @param xxx
	 * @return  object存储boolean类型
	 */
	public MethodResult UpdateEticket(UpdateEticketsInfo updateEticketsInfo);
	
	/**
	 * 
	 * @param bathno 物理票号批次号
	 * @param ticketno 物理票号
	 * @param eticketid 电子票ID
	 * @return 无
	 */
	public MethodResult takeTicket(String batchno,String ticketno,String eticketid);
	
}
