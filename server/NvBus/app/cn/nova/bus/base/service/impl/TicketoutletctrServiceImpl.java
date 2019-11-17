package cn.nova.bus.base.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.TicketoutletctrDao;
import cn.nova.bus.base.model.Ticketoutletsctr;
import cn.nova.bus.base.service.TicketoutletctrService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

public class TicketoutletctrServiceImpl implements TicketoutletctrService {
	private TicketoutletctrDao dao= new TicketoutletctrDao();

	@Override
	public List<Map<String, Object>> queryTicketoutletsctr(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "id", "ticketoutletsid",
				"ticketoutletsname", "carrychildrate", "maxsellmoney",
				"createname", "createtime", "updatename", "updatetime" },
				dao.queryTicketoutletsctr(propertyFilterList), new Object[] {
						Long.class, Long.class, String.class, BigDecimal.class,
						BigDecimal.class, String.class, Date.class,
						String.class, Date.class });
	}

	@Override
	public Ticketoutletsctr save(Ticketoutletsctr ticketoutletsctr)
			throws ServiceException {
		// TODO Auto-generated method stub	
		if(ticketoutletsctr.getId() != -1){
			//说明之前已经存在，为修改操作
			Ticketoutletsctr ticketoutletsctr_old = dao.getEntityManager().find(Ticketoutletsctr.class, ticketoutletsctr.getId());
			ticketoutletsctr.setCreateby(ticketoutletsctr_old.getCreateby());
			ticketoutletsctr.setCreatetime(ticketoutletsctr_old.getCreatetime());
			ticketoutletsctr.setTicketoutletsid(ticketoutletsctr_old.getTicketoutletsid());
		}
			ticketoutletsctr=(Ticketoutletsctr) dao.merge(ticketoutletsctr);
		return ticketoutletsctr;
	}

	@Override
	public Ticketoutletsctr delete(Ticketoutletsctr ticketoutletsctr)
			throws ServiceException {
		TicketoutletctrDao dao=new TicketoutletctrDao();
		ticketoutletsctr= dao.getEntityManager().find(Ticketoutletsctr.class, ticketoutletsctr.getId());
		dao.delete(ticketoutletsctr);	
		return ticketoutletsctr;
	}

}
