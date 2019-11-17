package cn.nova.bus.sale.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

/**
 * @author lck
 * 
 */
public interface TicketService {
	/**
	 * 根据票号查询车票
	 * 
	 * @param 票号
	 * @return 车票信息
	 */
	public Ticketsell getTicket(String ticketno) throws ServiceException;

	
	/**
	 * 根据票号、发车日期限制查询车票
	 * 
	 * @param 票号
	 * @return 车票信息
	 */
	public Ticketsell getTicket(String ticketno,Date departdate) throws ServiceException;
	
	/**
	 * 根据座位号查询车票
	 * 
	 * @param 班次计划is
	 *            ,座位号
	 * @return 车票信息
	 */
	public Ticketsell getTicket(long scheduleplanid, Short seatno)
			throws ServiceException;

	/**
	 * 查询所有车票，在重打车票时使用
	 */
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList);
	
	/**
	 * 查询单表
	 * @param propertyFilters
	 * @return
	 */
	public List<Map<String, Object>> find(List<PropertyFilter> propertyFilters);

	/**
	 * 改票查询
	 * @param propertyFilters
	 * @return
	 */
	List<Map<String, Object>> findTicketChange(
			List<PropertyFilter> propertyFilters,Global global);

	/**
	 * 查代售异站票
	 * @param propertyFilterList
	 * @return
	 */
	List<Map<String, Object>> queryTicketsellagent(
			List<PropertyFilter> propertyFilterList);

	/**
	 * 查询售本站票+售异站票的总数
	 * @param propertyFilterList
	 * @return
	 */
	List<Map<String, Object>> qryTicketsell(
			List<PropertyFilter> propertyFilterList);
	
	/**
	 * 根据票号、发车日期限制查询车票
	 * 
	 * @param 票号
	 * @return 车票信息
	 */
	public List<Ticketsell> getTickets(String ticketno,Date departdate) throws ServiceException;
	
	//根据票号和日期判断当前车票数量是否唯一   add by liyi
	public List<Map<String, Object>> getTicketcout(String ticketno,Date departdate,String certificateno);
	//通过票号和日期查询出多条记录的显示方法	add by liyi
	public List<Map<String, Object>> getmulTicketlist(String ticketno,Date departdate,String certificateno);
	
	//public List<Ticketsell> qryTickets(String ticketnos, Date departdate) ;
	
	public boolean lineworkexistdepart(String ticketno,String depardate); 
	
	
	/**
	 * 根据售票记录，校验密文是否正确
	 * @param ticketsell 售票记录
	 * @return 
	 */
	public boolean checkTicketByTicket(Ticketsell ticketsell);

	/**
	 * @Title queryTicketByTicketno
	 * @Description 查询单表(售票表)，关联departinvoicesothersell
	 * @param ticketno
	 * @return List<Map<String,Object>> 
	 * @author tianhb
	 * @date 2016年6月13日-下午9:48:09
	 * @update 
	 * @throws
	 */
	public List<Map<String, Object>> queryTicketByTicketno(String ticketno);

	/**
	 * @Title queryTicketByDepartinvoicesotherid
	 * @Description 查询单表(售票表)，关联departinvoicesothersell
	 * @param departinvoicesotherid
	 * @return  List<Map<String,Object>> 
	 * @author tianhb
	 * @date 2016年6月13日-下午9:48:15
	 * @update 
	 * @throws
	 */
	public List<Map<String, Object>> queryTicketByDepartinvoicesotherdetailid(Long departinvoicesotherdetailid);
	
}
