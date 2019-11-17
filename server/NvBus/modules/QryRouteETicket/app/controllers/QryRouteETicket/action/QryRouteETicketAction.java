package controllers.QryRouteETicket.action;

import java.util.List;
import java.util.Map;

import controllers.QryRouteETicket.service.QryRouteETicketService;
import controllers.QryRouteETicket.service.Impl.QryRouteETicketServiceImpl;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.query.service.TicketSellQryService;
import cn.nova.bus.query.service.impl.TicketSellQryServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class QryRouteETicketAction extends BaseAction {
	
	QryRouteETicketService routeETicketService;
	private List<Map<String, Object>> qrymap;
	
	

	public List<Map<String, Object>> getQrymap() {
		return qrymap;
	}



	public void setQrymap(List<Map<String, Object>> qrymap) {
		this.qrymap = qrymap;
	}



	/**
	 * 电子票明细查询
	 * 
	 * @return
	 */
	public String queryRouteETicket() {
		try {
			routeETicketService = new QryRouteETicketServiceImpl();
			setQrymap(routeETicketService.queryRouteETicket(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

}
