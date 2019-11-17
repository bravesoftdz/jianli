package cn.nova.bus.sale.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.model.Ticketchange;
import cn.nova.bus.sale.model.Ticketreturn;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;

public interface TicketreturnService {
	
	public MethodResult find(List<PropertyFilter> propertyFilters,Long loginorgid) throws Exception;
	
	public boolean returnTickets(List<Ticketreturn> ticketreturns,Global global,
			String vipcardno,String vipgrade,BigDecimal vipmoney,BigDecimal vippoint,boolean canprint,long returnby) throws ServiceException, Exception;
	
	/**
	 * 异售本改签为本地票时，将原售票站的车票状态改为改签，并记录改签信息
	 */
	public boolean changeOtherSellLocalTickets(List<Ticketreturn> ticketreturns, Ticketchange ticketchange, Global global,
			String vipcardno,String vipgrade,BigDecimal vipmoney,BigDecimal vippoint,boolean canprint) throws ServiceException, Exception;

	/**
	 * 换车票重打退票凭证
	 * @param isselfschedule 是否本站班次
	 * @param ticketsellid 售票ID
	 * @param curTicketNo  当前票号
	 * @param global
	 * @return
	 * @throws ServiceException
	 */
	public Ticketreturn rePrintTicketreturnAndChangeTicketNo(boolean isselfschedule,
			long ticketsellid, String curTicketNo, Global global)
			throws ServiceException;

	/**
	 * 查询车票的票价分项合计
	 * @param isselfschedule
	 * @param ticketsellid
	 * @return 票价分项合计
	 * @throws ServiceException
	 */
	public BigDecimal findticketfee(boolean isselfschedule, long ticketsellid)
			throws ServiceException;
	
	/**
	 * 查询退票费
	 * @param isselfschedule
	 * @param ticketsellid
	 * @return 退票费
	 * @throws ServiceException
	 */	
	public BigDecimal findReturnFee(long ticketsellid) throws Exception;
	
	/**
	 * 重打退票凭证
	 * @param ticketsellid：车票id
	 * @param newReturnvoucherno：新凭证号
	 */
	public List<Map<String, Object>> reprintReturnvoucher(Global global, Long ticketsellid, String newReturnvoucherno) throws Exception;

	public boolean returnTickets(List<Ticketreturn> ticketreturns, Global global, boolean b) throws Exception;
}
