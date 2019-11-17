package cn.nova.bus.report.action;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.report.service.QueryBalanceitemService;
import cn.nova.bus.report.service.QuerySellBalanceSummaryService;
import cn.nova.bus.report.service.impl.QueryBalanceitemServiceImpl;
import cn.nova.bus.report.service.impl.QuerySellBalanceSummaryServiceImpl;

public class QuerySellBalanceSummaryAction extends BaseAction{
	private List<Map<String, Object>> sellbalancelist;
	
	
	private String printorgids;
	private String sellorgids;
	private Date startdate;
	private Date enddate;
	private Long routeid;
	private Long scheduleid;
	private Long vehicleid;
	/**
	 * 售票点结算汇总表 查询
	 * 
	 * @return
	 */
	public String query() {
		try {
			QuerySellBalanceSummaryServiceImpl sellbalanceService = new QuerySellBalanceSummaryServiceImpl();
			setSellbalancelist(sellbalanceService.query(printorgids,sellorgids,
					 startdate, enddate, routeid, scheduleid, vehicleid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			e.getMessage();
		}
		return "json";
	}
	
	public List<Map<String, Object>> getSellbalancelist() {
		return sellbalancelist;
	}
	public void setSellbalancelist(List<Map<String, Object>> sellbalancelist) {
		this.sellbalancelist = sellbalancelist;
	}

	public String getPrintorgids() {
		return printorgids;
	}

	public void setPrintorgids(String printorgids) {
		this.printorgids = printorgids;
	}

	public String getSellorgids() {
		return sellorgids;
	}

	public void setSellorgids(String sellorgids) {
		this.sellorgids = sellorgids;
	}

	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public Long getRouteid() {
		return routeid;
	}

	public void setRouteid(Long routeid) {
		this.routeid = routeid;
	}

	public Long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(Long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public Long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(Long vehicleid) {
		this.vehicleid = vehicleid;
	}
}
