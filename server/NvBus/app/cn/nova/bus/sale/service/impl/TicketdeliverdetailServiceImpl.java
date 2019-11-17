package cn.nova.bus.sale.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.dao.TicketdeliverdetailDao;
import cn.nova.bus.sale.model.Ticketdeliverdetail;
import cn.nova.bus.sale.service.TicketdeliverdetailService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("unchecked")
public class TicketdeliverdetailServiceImpl implements
		TicketdeliverdetailService {

	
	private TicketdeliverdetailDao dao = new TicketdeliverdetailDao();

	@Override
	public Ticketdeliverdetail save(Ticketdeliverdetail ticketdeliverdetail, int count)
			throws ServiceException {
		Ticketdeliverdetail detail = null;
		if (ticketdeliverdetail.getId() == 0) {
			if (count >= 0) {
				int length = ticketdeliverdetail.getTicketno().length();
				Long ticketno = Long.parseLong(ticketdeliverdetail.getTicketno());
				for (int i = 0; i < count; i++) {
					if (length > ticketno.toString().length()) {
						String temp="";
						for (int j = 0; j < length-ticketno.toString().length(); j++) {
							temp = temp + "0";
						}
						ticketdeliverdetail.setTicketno(temp + ticketno.toString());
					} else {
						ticketdeliverdetail.setTicketno(ticketno.toString());
					}
					if (isExist(ticketdeliverdetail.getDeliverid(),
							ticketdeliverdetail.getTicketno())) {// 送票人与对应票号是否已送过
						throw new ServiceException(ticketdeliverdetail.getTicketno(), "0124");
					}
					if (isExistTicketno("Ticketsell", ticketdeliverdetail.getTicketno())) {//是否存在该票号
						throw new ServiceException(ticketdeliverdetail.getTicketno(),
						"0129");
					}
//					if (!isExistTicketno("Ticketdeliverdetail",
//							ticketdeliverdetail.getTicketno())) {// 车票是否已送
//						throw new ServiceException(ticketdeliverdetail.getTicketno(),
//						"0130");
//					}
					if (dao.isDeparted(ticketdeliverdetail.getTicketno())) {//是否已发班
						throw new ServiceException(ticketdeliverdetail.getTicketno(), "0264");
					}
					detail = (Ticketdeliverdetail) dao.merge(ticketdeliverdetail);
					ticketno = ticketno + 1;
				}
			}
			return detail;
		} else {
			return (Ticketdeliverdetail) dao.merge(ticketdeliverdetail);
		}
	}

	@SuppressWarnings("rawtypes")
	private boolean isExistTicketno(String tablename, String ticketno) {
		List list = dao.getResultByTicketno(tablename, ticketno);
		if (list.isEmpty()) {
			return true;
		}
		return false;
	}

	@SuppressWarnings("rawtypes")
	private boolean isExist(Long deliverid, String ticketno) {
		List list = dao.getResult(deliverid, ticketno);
		if (list.isEmpty()) {
			return false;
		}
		return true;
	}

	@Override
	public boolean delete(Ticketdeliverdetail ticketdeliverdetail) {
		return dao.delete(ticketdeliverdetail);
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Ticketdeliverdetail.class, id);
	}

	@Override
	public List<Ticketdeliverdetail> query() {
		return dao.query(Ticketdeliverdetail.class, null);
	}

	@Override
	public Ticketdeliverdetail getById(Long id) {
		return (Ticketdeliverdetail) dao.get(Ticketdeliverdetail.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Ticketdeliverdetail.class,
				"schedulecode", "reachname", "departdate", "departtime",
				"seatno", "createname", "area", "address" },
				dao.query(propertyFilterList), new Object[] {
						Ticketdeliverdetail.class, String.class, String.class,
						Date.class, String.class, String.class, String.class,
						String.class, String.class });
	}

}
