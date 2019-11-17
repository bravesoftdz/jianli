package cn.nova.bus.balance.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.dao.TicketturnoverdifadjustDao;
import cn.nova.bus.balance.model.Ticketturnoverdifadjust;
import cn.nova.bus.balance.service.TicketturnoverdifadjustService;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

public class TicketturnoverdifadjustServiceImpl implements
		TicketturnoverdifadjustService {
	private TicketturnoverdifadjustDao ticketturnoverdifadjustDao=new TicketturnoverdifadjustDao();

	@Override
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters) {
		Object[] fileds = { "id", "moneydate", "seller", "difmoney", "orgid",
				"remark", "createtime", "createby", "updatetime", "updateby",
				"sellername", "createbyname", "updatebyname" };
		Object[] filedtypes = { Long.class, Date.class, Long.class,
				BigDecimal.class, Long.class, String.class, Timestamp.class,
				Long.class, Timestamp.class, Long.class, String.class,
				String.class, String.class };
		return ListUtil.listToMap(fileds,
				ticketturnoverdifadjustDao.find(propertyFilters), filedtypes);
	}

	@Override
	public Ticketturnoverdifadjust save(Ticketturnoverdifadjust tdifadjusts ) {
		tdifadjusts=(Ticketturnoverdifadjust) ticketturnoverdifadjustDao.merge(tdifadjusts);
		return tdifadjusts;
	}

	@Override
	public boolean delete(
			Ticketturnoverdifadjust ticketdifadjust,Global global) {
		Ticketturnoverdifadjust aj=(Ticketturnoverdifadjust) ticketturnoverdifadjustDao.get(Ticketturnoverdifadjust.class, ticketdifadjust.getId());
		if(aj!=null){
		  ticketturnoverdifadjustDao.delete(aj);
		}
		return true;
	}

}
