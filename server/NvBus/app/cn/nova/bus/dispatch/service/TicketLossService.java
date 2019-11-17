package cn.nova.bus.dispatch.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.dispatch.model.TicketLoss;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.utils.orm.PropertyFilter;

public interface TicketLossService {
	
	TicketLoss getTicketLossById(Long id);
	
	public List<Map<String, Object>> query(TicketLoss tl);
	
	public List<Map<String, Object>> queryTicketSell(Ticketsell ts);
	
	public boolean save(TicketLoss tl);
	
	public int update(TicketLoss tl);

	List<TicketLoss> getTicketLossByTicketSellId(Long id);
}
