/**
 * 
 */
package cn.nova.bus.onecard.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;

/**
 * 一卡通业务接口
 * @author ice
 *
 */
public interface OneCardService {
	
	/**
	 * 查询一卡通刷卡上车要显示的信息
	 * @param scheduleplanid
	 * @param checkstationid
	 * @param vehiclereportid
	 * @return
	 */
	public List<Map<String,Object>> findScheduleinfo(long scheduleplanid,long checkstationid,long vehiclereportid);
	
	/**
	 * 售票并检票
	 * @return
	 * @throws Exception 
	 */
	public MethodResult sellandcheck(Global global,String vipcardno,long vehiclereportid,long scheduleplanid,long checkstationid,String ticketentrance,boolean carrychild
			,String vipgrade,BigDecimal vipmoney,BigDecimal vippoint) throws Exception;

	/**
	 * 查询一卡通卡号当天的购票信息
	 * @param vipcardno
	 * @return
	 */
	public List<Map<String,Object>> findTicketinfo(String vipcardno);
	
	/**
	 * 退检并退票 , 只能退当天发车的车票，不收取手续费
	 * @param global
	 * @param checkstationid 检票站点
	 * @param ticketnos 要退票的票号列表
	 * @return
	 * @throws Exception 
	 */
	public MethodResult returncheckandsell(Global global,long checkstationid,List<String> ticketnos,String vipcardno
			,String vipgrade,BigDecimal vipmoney,BigDecimal vippoint) throws Exception;
}
