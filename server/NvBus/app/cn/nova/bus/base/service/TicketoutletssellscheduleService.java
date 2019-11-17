package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Ticketoutletssellschedule;
import cn.nova.utils.orm.PropertyFilter;

public interface TicketoutletssellscheduleService {

	public Ticketoutletssellschedule save(Ticketoutletssellschedule ssellschedulte);

	public boolean delete(Ticketoutletssellschedule ssellschedulte);

	public boolean delete(Long id);

	public List<Ticketoutletssellschedule> query();

	public Ticketoutletssellschedule getById(Long id);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

	public boolean equals(Long ticketoutlessid, String type, Long typeid);

	public String getValue(Long ticketoutlessid, String type, Long typeid);

	public Long findId(String code);

}
