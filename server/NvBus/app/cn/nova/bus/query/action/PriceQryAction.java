package cn.nova.bus.query.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.query.service.PriceQueryService;
import cn.nova.bus.query.service.impl.PriceQueryServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class PriceQryAction extends BaseAction{
	private List<Map<String, Object>> schedulepricelist;	
	private List<Map<String, Object>> ticketpricelist;	
	private Scheduleplan scheduleplan;	
	
	public String qrySchedulePrice() {
		try {
			PriceQueryService priceqryService = new PriceQueryServiceImpl();
			setSchedulepricelist(priceqryService.QuerySchedulePrice(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public List<Map<String, Object>> getTicketpricelist() {
		return ticketpricelist;
	}

	public void setTicketpricelist(List<Map<String, Object>> ticketpricelist) {
		this.ticketpricelist = ticketpricelist;
	}

	public Scheduleplan getScheduleplan() {
		return scheduleplan;
	}

	public void setScheduleplan(Scheduleplan scheduleplan) {
		this.scheduleplan = scheduleplan;
	}

	public List<Map<String, Object>> getSchedulepricelist() {
		return schedulepricelist;
	}

	public void setSchedulepricelist(List<Map<String, Object>> schedulepricelist) {
		this.schedulepricelist = schedulepricelist;
	}
	
}
