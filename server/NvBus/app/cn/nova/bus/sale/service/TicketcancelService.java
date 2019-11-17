package cn.nova.bus.sale.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.model.Ticketcancel;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;

public interface TicketcancelService {
	
	public MethodResult find(List<PropertyFilter> propertyFilters,Long loginorgid) throws Exception;
	
	public boolean cancelTickets(List<Ticketcancel> ticketcancels,Global global,
			String vipcardno,String vipgrade,BigDecimal vipmoney,BigDecimal vippoint) throws ServiceException, Exception;
	public List<Map<String, Object>> findspecialticket(List<PropertyFilter> propertyFilters);
}
