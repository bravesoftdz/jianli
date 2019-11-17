package cn.nova.bus.sale.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.model.Ticketdeliver;
import cn.nova.utils.orm.PropertyFilter;

public interface TicketdeliverService {

	public Ticketdeliver save(Ticketdeliver ticketdeliver) throws ServiceException;

	public boolean delete(Ticketdeliver ticketdeliver);

	public boolean delete(Long id) throws ServiceException;

	public List<Ticketdeliver> query();

	public Ticketdeliver getById(Long id);

	/**
	 * 查询送票记录
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

}
