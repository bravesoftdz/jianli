package cn.nova.bus.balance.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.model.TicketTurnOverOther;
import cn.nova.utils.orm.PropertyFilter;

public interface TicketTurnOverOtherService {
	public TicketTurnOverOther saveTicketTurnOverOther(
			TicketTurnOverOther ticketTurnOverOther);
	
	public List<Map<String, Object>> qryTicketTurnOverOther(List<PropertyFilter> propertyFilterList);
}
