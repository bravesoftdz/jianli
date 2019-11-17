package controllers.QryRouteETicket.service.Impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.query.dao.TicketSellQryDao;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;
import controllers.QryRouteETicket.dao.QryRouteETicketDao;
import controllers.QryRouteETicket.service.QryRouteETicketService;

public class QryRouteETicketServiceImpl implements QryRouteETicketService {

	@Override
	public List<Map<String, Object>> queryRouteETicket(
			List<PropertyFilter> propertyFilterList) {
		QryRouteETicketDao	qryRouteETicketdao = new QryRouteETicketDao();
		return ListUtil.listToMap(
				new Object[] { "orgname", "routename", "departdate","departname","tickets","totalprice"},
						qryRouteETicketdao.queryRouteETicket(propertyFilterList),
				new Object[] { String.class, String.class, Date.class, String.class, BigDecimal.class, BigDecimal.class});
	}

}
