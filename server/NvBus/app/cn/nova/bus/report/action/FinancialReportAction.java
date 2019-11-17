package cn.nova.bus.report.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.service.FinancialReportService;
import cn.nova.bus.report.service.impl.FinancialReportServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * 
 * <b>类描述：财务报表接口</b><br/>
 * <b>类名称：</b>FinancialReportService<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>修改时间：2012-07-19</b><br/>
 * <b>关键修改：添加
 * 班线结算统计表:scheduleRouteBalanceRpt。各站互售互退营收汇总表eachTickeIncomeSumRpt</b><br/>
 * <b>修改时间：2013-02-27</b><br/>
 * <b>修改内容：添加财物收支月平衡表</b><br/>
 * <b>修改人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 */
public class FinancialReportAction extends BaseAction {

	private FinancialReportService financialReportService;
	// 返回结果
	private List<Map<String, Object>> resultmap;
	private String orgids;
	private Date startdate;
	private Date enddate;
	private Long vehicleid;
	private Long stationid;
	private Long routeid;
	private Long scheduleid;
	private String workways;
	private int departinvoicestype;
	private int isovertime;	
	private String printorgid;
	private Boolean isroutegroup = false;//是否按线路分组
	private Boolean isstationgroup = false;//是否按停靠站点分组
	private Boolean isschedulegroup = false;//是否按班次分组

	// 班次日结算表
	public String qryScheduleBalancePrice() {
		try {
			financialReportService = new FinancialReportServiceImpl();
			setResultmap(financialReportService.qryScheduleBalancePrice(orgids,
					routeid, startdate,enddate, workways,isovertime));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			e.getMessage();
		}
		return "json";
	}
	// 线路日结算表
	public String qryRouteBalancePrice() {
		try {
			financialReportService = new FinancialReportServiceImpl();
			setResultmap(financialReportService.qryRouteBalancePrice(orgids,
					routeid,  startdate,enddate, workways));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			e.getMessage();
		}
		return "json";
	}
	
	public String qryRouteBalanceIncome() {
		try {
			financialReportService = new FinancialReportServiceImpl();
			setResultmap(financialReportService.qryRouteBalanceIncome(startdate,enddate,scheduleid,routeid,stationid,isroutegroup,isstationgroup,isschedulegroup));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			e.getMessage();
		}
		return "json";
	}
	/**
	 * 班线结算统计表
	 * 
	 * @param
	 * @return
	 */
	public String scheduleRouteBalanceRpt() {
		try {
			financialReportService = new FinancialReportServiceImpl();
			setResultmap(financialReportService.scheduleRouteBalanceRpt(orgids,
					startdate, enddate, vehicleid, stationid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			e.getMessage();
		}
		return "json";
	}

	/**
	 * 各站互售互退营收汇总表
	 * 
	 * @param
	 * @return
	 */
	public String eachTickeIncomeSumRpt() {
		try {
			List<PropertyFilter> propertyFilterList = ServletPropertyFilterUtil
					.buildFromHttpRequest();
			financialReportService = new FinancialReportServiceImpl();
			setResultmap(financialReportService
					.eachTickeIncomeSumRpt(propertyFilterList));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			e.getMessage();
		}
		return "json";
	}

	/**
	 * 财务收支平衡表
	 * 
	 * @param
	 * @return
	 */
	public String financialBalanceRpt() {
		try {
			financialReportService = new FinancialReportServiceImpl();
			setResultmap(financialReportService.FinancialBalanceRpt(orgids,
					startdate, enddate));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			e.getMessage();
		}
		return "json";
	}

	/**
	 * 财务收支月平衡表
	 * 
	 * @param
	 * @return
	 */
	public String financialBalanceMonthRpt() {
		try {
			financialReportService = new FinancialReportServiceImpl();
			setResultmap(financialReportService.FinancialBalanceMonthRpt(
					orgids, startdate, enddate));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			e.getMessage();
		}
		return "json";
	}

	/**
	 * 运量单运量台账
	 * 
	 * @return
	 */
	public String queryDepartInvoinces() {
		try {
			financialReportService = new FinancialReportServiceImpl();
			setResultmap(financialReportService.DepartInvoincesRpt(startdate,
					enddate, departinvoicestype,printorgid, ServletPropertyFilterUtil.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 客运收入、支出平衡表-赣州
	 * 
	 * @return
	 */
	public String qryFinancialBalanceGZ() {
		try {
			financialReportService = new FinancialReportServiceImpl();
			setResultmap(financialReportService.FinancialBalanceGZ(orgids,
					startdate, enddate));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 单位营收统计表-赣州
	 * 
	 * @return
	 */
	public String incomeReportGZ() {
		try {
			financialReportService = new FinancialReportServiceImpl();
			setResultmap(financialReportService.IncomeReportGZ(orgids, routeid,
					startdate, enddate));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public List<Map<String, Object>> getResultmap() {
		return resultmap;
	}

	public void setResultmap(List<Map<String, Object>> resultmap) {
		this.resultmap = resultmap;
	}

	public String getOrgids() {
		return orgids;
	}

	public void setOrgids(String orgids) {
		this.orgids = orgids;
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

	public Long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(Long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public Long getStationid() {
		return stationid;
	}

	public void setStationid(Long stationid) {
		this.stationid = stationid;
	}

	public Long getRouteid() {
		return routeid;
	}

	public void setRouteid(Long routeid) {
		this.routeid = routeid;
	}

	public String getWorkways() {
		return workways;
	}

	public void setWorkways(String workways) {
		this.workways = workways;
	}

	public int getIsovertime() {
		return isovertime;
	}
	public void setIsovertime(int isovertime) {
		this.isovertime = isovertime;
	}
	public Boolean getIsroutegroup() {
		return isroutegroup;
	}
	public void setIsroutegroup(Boolean isroutegroup) {
		this.isroutegroup = isroutegroup;
	}
	public Boolean getIsstationgroup() {
		return isstationgroup;
	}
	public void setIsstationgroup(Boolean isstationgroup) {
		this.isstationgroup = isstationgroup;
	}
	public Boolean getIsschedulegroup() {
		return isschedulegroup;
	}
	public void setIsschedulegroup(Boolean isschedulegroup) {
		this.isschedulegroup = isschedulegroup;
	}
	public Long getScheduleid() {
		return scheduleid;
	}
	public void setScheduleid(Long scheduleid) {
		this.scheduleid = scheduleid;
	}
	public int getDepartinvoicestype() {
		return departinvoicestype;
	}
	public void setDepartinvoicestype(int departinvoicestype) {
		this.departinvoicestype = departinvoicestype;
	}
	public String getPrintorgid() {
		return printorgid;
	}
	public void setPrintorgid(String printorgid) {
		this.printorgid = printorgid;
	}	
	
}
