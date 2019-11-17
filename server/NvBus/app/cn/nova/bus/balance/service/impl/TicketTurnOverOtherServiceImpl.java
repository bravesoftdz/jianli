package cn.nova.bus.balance.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.dao.TicketTurnOverOtherDao;
import cn.nova.bus.balance.model.TicketTurnOverOther;
import cn.nova.bus.balance.service.TicketTurnOverOtherService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

public class TicketTurnOverOtherServiceImpl implements
		TicketTurnOverOtherService {
	TicketTurnOverOtherDao ticketTurnOverOtherDao = null;

	// 保存
	@Override
	public TicketTurnOverOther saveTicketTurnOverOther(
			TicketTurnOverOther ticketTurnOverOther) {
		ticketTurnOverOtherDao = new TicketTurnOverOtherDao();
		ticketTurnOverOther = (TicketTurnOverOther)ticketTurnOverOtherDao.merge(ticketTurnOverOther);
		return ticketTurnOverOther;
	}

	// 查询
	@Override
	public List<Map<String, Object>> qryTicketTurnOverOther(
			List<PropertyFilter> propertyFilterList) {
		ticketTurnOverOtherDao = new TicketTurnOverOtherDao();
		return ListUtil.listToMap(new Object[] { "orgname", "tickettime",
				"money", "seller", "remarks", "createtime", "updateby",
				"updatetime" }, ticketTurnOverOtherDao
				.qryTicketTurnOverOther(propertyFilterList), new Object[] {
				String.class, Date.class, Double.class, String.class,
				String.class, Date.class, String.class, Date.class });
	}
}
