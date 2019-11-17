package cn.nova.bus.price.action;

import java.util.List;
import java.util.Map;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Routeprice;
import cn.nova.bus.price.model.StandardBasePrice;
import cn.nova.bus.price.service.StandardBasePriceService;
import cn.nova.bus.price.service.impl.StandardBasePriceServiceImpl;

public class StandardBasePriceAction extends BaseAction {
	private StandardBasePriceService service = new StandardBasePriceServiceImpl();
	private List<Map<String, Object>> results;
	private List<StandardBasePrice> routebasepricelist;
	private String ids;
	private long routeid;

	public String query() {
		try {
			List<Map<String, Object>> routeprices = service.query(routeid);
			setResults(routeprices);
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
		}
		return "json";
	}
	public String update() {
		try {
			setResults(service.update(routebasepricelist));
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
		}
		return "json";
	}

	public String delRouteBaseprice() {
		if (service.delRouteBaseprice(ids)) {
			markSuccess();
		} else {
			markFail();
		}
		return "json";
	}
	public String saveRouteBaseprice() {
		play.Logger.info(ids);
		if (service.saveRouteBaseprice(ids)) {
			markSuccess();
		} else {
			markFail();
		}
		return "json";
	}

	public List<Map<String, Object>> getResults() {
		return results;
	}

	public void setResults(List<Map<String, Object>> results) {
		this.results = results;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public long getRouteid() {
		return routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}
	public List<StandardBasePrice> getRoutebasepricelist() {
		return routebasepricelist;
	}
	public void setRoutebasepricelist(List<StandardBasePrice> routebasepricelist) {
		this.routebasepricelist = routebasepricelist;
	}
	

}
