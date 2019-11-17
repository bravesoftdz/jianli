package cn.nova.bus.balance.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.model.Ticketturnoverdifadjust;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

public interface TicketturnoverdifadjustService {
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters);

	public Ticketturnoverdifadjust save(Ticketturnoverdifadjust tdifadjusts);

	public boolean delete(Ticketturnoverdifadjust ticketdifadjust,Global global);
}
