package cn.nova.bus.sale.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.dao.TicketdeliverDao;
import cn.nova.bus.sale.model.Ticketdeliver;
import cn.nova.bus.sale.service.TicketdeliverService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("unchecked")
public class TicketdeliverServiceImpl implements TicketdeliverService {


	private TicketdeliverDao dao = new TicketdeliverDao();

	@Override
	public Ticketdeliver save(Ticketdeliver ticketdeliver) throws ServiceException {
		if (ticketdeliver.getId() == 0) {
			return (Ticketdeliver) dao.merge(ticketdeliver);
		} else {
			return (Ticketdeliver) dao.merge(ticketdeliver);
		}
	}

	@Override
	public boolean delete(Ticketdeliver ticketdeliver) {
		return dao.delete(ticketdeliver);
	}

	@Override
	public boolean delete(Long id) throws ServiceException {
		if (dao.hasRecord(id)) {
			throw new ServiceException("0128");
		}
		return dao.delete(Ticketdeliver.class, id);
	}

	@Override
	public List<Ticketdeliver> query() {
		return dao.query(Ticketdeliver.class, null);
	}

	@Override
	public Ticketdeliver getById(Long id) {
		return (Ticketdeliver) dao.get(Ticketdeliver.class, id);
	}

	/**
	 * 送票记录查询
	 */
	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Ticketdeliver.class,
				"orgname", "createname", "updatename" },
				dao.query(propertyFilterList), new Object[] {
						Ticketdeliver.class, String.class, String.class,
						String.class });
	}

}
