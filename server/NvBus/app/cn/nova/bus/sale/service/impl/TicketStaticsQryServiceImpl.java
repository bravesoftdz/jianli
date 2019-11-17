package cn.nova.bus.sale.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.sale.dao.TicketStaticsQryDao;
import cn.nova.bus.sale.service.TicketStaticsQryService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

public class TicketStaticsQryServiceImpl implements TicketStaticsQryService {
	
	private TicketStaticsQryDao dao = new TicketStaticsQryDao();

	@Override
	public List<Map<String, Object>> query(int sellticketunit,Date beginselltime,Date endselltime) {
		// TODO Auto-generated method stub
		return ListUtil.listToMap(new Object[] {"ticketunit","ticketnum" ,
				"ticketprice", "returnnum", "returnprice", "charges", "changenum","balanceticketnum","netbalanceprice","balanceprice",
				"cancelnum", "cancelprice" },
				dao.query(sellticketunit,beginselltime,endselltime), new Object[] {
						 String.class, long.class,
						 BigDecimal.class, long.class, BigDecimal.class,BigDecimal.class,long.class,long.class,BigDecimal.class,BigDecimal.class,
						 long.class, BigDecimal.class});
	}

}
