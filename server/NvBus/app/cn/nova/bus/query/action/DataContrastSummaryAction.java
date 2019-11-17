package cn.nova.bus.query.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import cn.nova.bus.query.service.DataContrastSummaryService;
import cn.nova.bus.query.service.impl.DataContrastSummaryServiceImpl;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class DataContrastSummaryAction extends BaseAction{
	private List<Map<String, Object>> routeDSummary;
	private List<Map<String, Object>> ticketSummary;
	private List<Map<String, Object>> businessDSummary;
	private List<Map<String, Object>> networkTicketSummary;
	private List<Map<String, Object>> dayBookings;
	private List<Map<String, Object>> orgDSummary;
	private List<Map<String, Object>> schTickets;
	private List<Map<String, Object>> summarylist;
	
	private boolean isbynormal;
	private boolean isbylatter;
	
	private String titlename;

	private DataContrastSummaryService dataContrastSummaryService;

	/**
	 * 站务分公司班线数据情况汇总表
	 * 
	 * @return
	 */
	public String queryRouteDataSummary() {
		try {
			dataContrastSummaryService = new DataContrastSummaryServiceImpl();
			setRouteDSummary(dataContrastSummaryService.queryRouteDataSummary(
					ServletPropertyFilterUtil.buildFromHttpRequest(), isbynormal, isbylatter));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 站务分公司网点售票情况汇总表
	 * 
	 * @return
	 */
	public String queryTicketSummary() {
		try {
			dataContrastSummaryService = new DataContrastSummaryServiceImpl();
			setTicketSummary(dataContrastSummaryService
					.queryTicketSummary(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 站务分公司站场业务数据情况汇总表
	 * 
	 * @return
	 */
	public String queryBusinessSummary() {
		try {
			dataContrastSummaryService = new DataContrastSummaryServiceImpl();
			setBusinessDSummary(dataContrastSummaryService
					.queryBusinessSummary(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 联网售票统计报表
	 * 
	 * @return
	 */
	public String queryNetworkTicket() {
		try {
			dataContrastSummaryService = new DataContrastSummaryServiceImpl();
			MethodResult res=dataContrastSummaryService.queryNetworkTicket(ServletPropertyFilterUtil
					.buildFromHttpRequest());
			setNetworkTicketSummary((List<Map<String, Object>>) res.getObject());
			titlename=res.getResultMsg();
			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 日售票日报表报表
	 * 
	 * @return
	 */
	public String queryDayBookings() {
		try {
			dataContrastSummaryService = new DataContrastSummaryServiceImpl();
			setDayBookings(dataContrastSummaryService
					.queryDayBookings(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 站务作业统计报表
	 *  
	 * @return
	 */
	public String queryOrgDataSummary() {
		try {
			dataContrastSummaryService = new DataContrastSummaryServiceImpl();
			setSummarylist(dataContrastSummaryService
					.queryOrgDataSummary(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 站务分公司各班线票价情况汇总表 
	 * 
	 * @return
	 */
	public String querySchTicketprice() {
		try {
			dataContrastSummaryService = new DataContrastSummaryServiceImpl();
			setSummarylist(dataContrastSummaryService
					.querySchTicketprice(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 站务分公司进站车辆汇总表   
	 * 
	 * @return
	 */
	public String querydrawVehSummary() {
		try {
			dataContrastSummaryService = new DataContrastSummaryServiceImpl();
			setSummarylist(dataContrastSummaryService
					.queryDrawVehSummary(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public boolean isIsbynormal() {
		return isbynormal;
	}

	public void setIsbynormal(boolean isbynormal) {
		this.isbynormal = isbynormal;
	}

	public boolean isIsbylatter() {
		return isbylatter;
	}

	public void setIsbylatter(boolean isbylatter) {
		this.isbylatter = isbylatter;
	}

	public List<Map<String, Object>> getRouteDSummary() {
		return routeDSummary;
	}

	public void setRouteDSummary(List<Map<String, Object>> routeDSummary) {
		this.routeDSummary = routeDSummary;
	}

	public List<Map<String, Object>> getTicketSummary() {
		return ticketSummary;
	}

	public void setTicketSummary(List<Map<String, Object>> ticketSummary) {
		this.ticketSummary = ticketSummary;
	}

	public List<Map<String, Object>> getBusinessDSummary() {
		return businessDSummary;
	}

	public void setBusinessDSummary(List<Map<String, Object>> businessDSummary) {
		this.businessDSummary = businessDSummary;
	}

	public List<Map<String, Object>> getNetworkTicketSummary() {
		return networkTicketSummary;
	}

	public void setNetworkTicketSummary(
			List<Map<String, Object>> networkTicketSummary) {
		this.networkTicketSummary = networkTicketSummary;
	}

	public List<Map<String, Object>> getDayBookings() {
		return dayBookings;
	}

	public void setDayBookings(List<Map<String, Object>> dayBookings) {
		this.dayBookings = dayBookings;
	}

	public List<Map<String, Object>> getOrgDSummary() {
		return orgDSummary;
	}

	public void setOrgDSummary(List<Map<String, Object>> orgDSummary) {
		this.orgDSummary = orgDSummary;
	}

	public List<Map<String, Object>> getSchTickets() {
		return schTickets;
	}

	public void setSchTickets(List<Map<String, Object>> schTickets) {
		this.schTickets = schTickets;
	}

	public List<Map<String, Object>> getSummarylist() {
		return summarylist;
	}

	public void setSummarylist(List<Map<String, Object>> summarylist) {
		this.summarylist = summarylist;
	}

	public String getTitlename() {
		return titlename;
	}

	public void setTitlename(String titlename) {
		this.titlename = titlename;
	}
}
