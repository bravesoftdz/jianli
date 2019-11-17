package cn.nova.bus.sale.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.model.Ticketdeliverdetail;
import cn.nova.utils.orm.PropertyFilter;

public interface TicketdeliverdetailService {

	public Ticketdeliverdetail save(Ticketdeliverdetail ticketdeliverdetail, int count)
			throws ServiceException;

	public boolean delete(Ticketdeliverdetail ticketdeliverdetail);

	public boolean delete(Long id);

	public List<Ticketdeliverdetail> query();

	public Ticketdeliverdetail getById(Long id);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

}
