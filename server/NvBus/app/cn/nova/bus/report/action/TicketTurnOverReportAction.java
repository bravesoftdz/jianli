package cn.nova.bus.report.action;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.report.service.TicketTurnOverReportService;
import cn.nova.bus.report.service.impl.TicketTurnOverReportServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class TicketTurnOverReportAction extends BaseAction {
	private List<Map<String, Object>> resultmap;
	private int querytype; // 长短款标志
	private String title;
	private String orgids;
	private Date departdate;
	private Date enddate;
	private String tickettype; //票证类型
	private String ticketusetype; //票证使用类型
	
	private TicketTurnOverReportService ticketturnoverreportserivce;
	
	public String qryticketusedetail(){
		try {
			ticketturnoverreportserivce = new TicketTurnOverReportServiceImpl();
			setResultmap(ticketturnoverreportserivce.qryticketusedetail(orgids,departdate,enddate,tickettype,ticketusetype));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			e.getMessage();
		}
		return "json";
	}

	public String queryTicketErrorReport() {
		try {
			ticketturnoverreportserivce = new TicketTurnOverReportServiceImpl();
			Map<String, Object> returndatas = ticketturnoverreportserivce
					.queryTicketErrorReport(
							ServletPropertyFilterUtil.buildFromHttpRequest(),
							querytype);
			setResultmap((List<Map<String, Object>>)returndatas.get("resultmap"));
			setTitle(returndatas.get("title")+"");
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			e.getMessage();
		}
		return "json";
	}

	public List<Map<String, Object>> getResultmap() {
		return resultmap;
	}

	public void setResultmap(List<Map<String, Object>> resultmap) {
		this.resultmap = resultmap;
	}

	public int getQuerytype() {
		return querytype;
	}

	public void setQuerytype(int querytype) {
		this.querytype = querytype;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getOrgids() {
		return orgids;
	}

	public void setOrgids(String orgids) {
		this.orgids = orgids;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public String getTickettype() {
		return tickettype;
	}

	public void setTickettype(String tickettype) {
		this.tickettype = tickettype;
	}

	public String getTicketusetype() {
		return ticketusetype;
	}

	public void setTicketusetype(String ticketusetype) {
		this.ticketusetype = ticketusetype;
	}
	

}
