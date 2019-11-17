package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Ticketoutlets;
import cn.nova.bus.base.model.Ticketoutletsctr;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface TicketoutletctrService {
	public List<Map<String, Object>> queryTicketoutletsctr(List<PropertyFilter> buildFromHttpRequest);
	public Ticketoutletsctr save(Ticketoutletsctr ticketoutletsctr) throws ServiceException;
	public Ticketoutletsctr delete(Ticketoutletsctr ticketoutletsctr) throws ServiceException;
}
