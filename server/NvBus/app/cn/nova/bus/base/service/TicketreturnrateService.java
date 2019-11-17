package cn.nova.bus.base.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Ticketreturnrate;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

/**
 * @author ice
 *
 */
public interface TicketreturnrateService {

	public List<Map<String,Object>> query(List<PropertyFilter> propertyFilters);
	public Ticketreturnrate merge(Ticketreturnrate ticketreturnrate) throws ServiceException;
	public boolean delete(Ticketreturnrate ticketreturnrate) throws ServiceException;
	/**
	 * 按距发车时间小时数取出退票费率
	 * @return
	 */
	public BigDecimal getticketreturnrate(long orgid, BigDecimal hours);
	public BigDecimal getticketreturnrate(long orgid, BigDecimal hours,Date departtime,boolean islinework);
	
} 
