package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Ticketoutletsunsellstation;
import cn.nova.utils.orm.PropertyFilter;

public interface TicketoutletsunsellstationService {

	public Boolean save(Ticketoutletsunsellstation sellstation, String ticketoutletsids);

	public boolean delete(Ticketoutletsunsellstation sellstation);

	public boolean delete(Long id);

	public List<Ticketoutletsunsellstation> query();

	public Ticketoutletsunsellstation getById(Long id);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

	public boolean equals(Ticketoutletsunsellstation ticketoutletsunsellstation);

	public String getValue(Long ticketoutlessid, String type, Long typeid,
			Long stationid);

	public Long findId(String code);

}
