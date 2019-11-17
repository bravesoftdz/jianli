/**
 * 
 */
package cn.nova.bus.sale.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;

/**
 * @author ice
 * 电子票取票服务
 */
public interface TakeTicketService {

	/**
	 * 按电子票号或电子验证码查询电子票信息 
	 * @param eticketno 电子票号
	 * @param epassword 电子票验证码
	 * @return
	 */
	public List<Map<String,Object>> findETicketInfo(String eticketno,String epassword);
	
	/**
	 * 
	 * @param bathno 物理票号批次号
	 * @param ticketno 物理票号
	 * @param eticketno 电子票号
	 * @param epassword 电子票校验码
	 * @return 电子票售票ID，失败返回0
	 * @throws ServiceException
	 */
	public long takeTicket(String ticketno,Long ticketsellotherid,long printbyid,String takeway) throws ServiceException;
	/**
	 * 
	 * @param bathno 物理票号批次号
	 * @param ticketno 物理票号
	 * @param eticketno 电子票号
	 * @param epassword 电子票校验码
	 * @return 电子票售票ID，失败返回0
	 * @throws ServiceException
	 */
	public long remoteTakeTicket(String batchno,String ticketno,String eticketno,String epassword,String takeway) throws ServiceException;

	/**
	 * 按身份证号 or 手机号+订单号 查询电子票信息 
	 * @param idcardno 身份证号
	 * @return
	 */
	public List<Map<String,Object>> findETicketInfoByCustomer(String idcardno,String orderno,String telno);
	
}
