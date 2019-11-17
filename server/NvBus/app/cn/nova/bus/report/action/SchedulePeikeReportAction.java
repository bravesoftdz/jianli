package cn.nova.bus.report.action;

import cn.nova.bus.action.BaseAction;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.service.SchedulePeikeReportService;
import cn.nova.bus.report.service.TicketsellIncomeReportSerivce;
import cn.nova.bus.report.service.impl.SchedulePeikeReportServiceImpl;
import cn.nova.bus.report.service.impl.TicketsellIncomeReportSerivceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：班次配客情况表</b><br/>
 * <b>类名称：</b>SchedulePeikeReportAction.java<br/>
 * <b>创建时间：</b>2014-11-10<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class SchedulePeikeReportAction extends BaseAction{

	private SchedulePeikeReportService  peikereportserivce;
	// 返回结果
	private List<Map<String, Object>> resultmap;
	private List<Map<String, Object>> countlist;
	private Date oldstartdepartdate;
	private String schedulecode;
	private Date countdepartdate;
	private String countschedulecode;
		
	/**
	 * 班次配客情况表
	 * @param propertyFilterList
	 * 
	 * @return
	 */
	public String qrySchedulePeike() {
		try {
			peikereportserivce = new SchedulePeikeReportServiceImpl();			
			setResultmap(peikereportserivce.qrySchedulePeike(ServletPropertyFilterUtil
					.buildFromHttpRequest(),oldstartdepartdate,schedulecode));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			e.getMessage();
		}
		return "json";
	}
	/**
	 * 查询各站点售票情况
	 */
	public String qryTicketoutcodeSellticket(){
		try {
			peikereportserivce = new SchedulePeikeReportServiceImpl();			
			setCountlist(peikereportserivce.qryTicketoutcodeSellticket(ServletPropertyFilterUtil
					.buildFromHttpRequest(),countdepartdate,countschedulecode));
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

	public Date getOldstartdepartdate() {
		return oldstartdepartdate;
	}

	public void setOldstartdepartdate(Date oldstartdepartdate) {
		this.oldstartdepartdate = oldstartdepartdate;
	}

	public String getSchedulecode() {
		return schedulecode;
	}

	public void setSchedulecode(String schedulecode) {
		this.schedulecode = schedulecode;
	}
	public List<Map<String, Object>> getCountlist() {
		return countlist;
	}
	public void setCountlist(List<Map<String, Object>> countlist) {
		this.countlist = countlist;
	}
	public Date getCountdepartdate() {
		return countdepartdate;
	}
	public void setCountdepartdate(Date countdepartdate) {
		this.countdepartdate = countdepartdate;
	}
	public String getCountschedulecode() {
		return countschedulecode;
	}
	public void setCountschedulecode(String countschedulecode) {
		this.countschedulecode = countschedulecode;
	}

}
