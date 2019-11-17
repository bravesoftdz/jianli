package controllers.QryRouteETicket.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.query.param.Qryparam;
import cn.nova.utils.orm.PropertyFilter;

public interface QryRouteETicketService {

	/**
	 * 电子票明细查询
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryRouteETicket(List<PropertyFilter> propertyFilterList);
	
	
	
}
