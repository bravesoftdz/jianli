package cn.nova.bus.report.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.utils.orm.PropertyFilter;

/**
 * 
 * <b>类描述：财务报表接口</b><br/>
 * <b>类名称：</b>FinancialReportService<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>1关键修改：添加 班线结算统计表:scheduleRouteBalanceRpt </b><br/>
 * <b>修改内容：添加财物收支月平衡表</b><br/> 
 * <b>修改时间：2013-02-27</b><br/>
 * <b>2关键修改：运量单运量台账:DepartInvoincesRpt </b><br/>
 * <b>修改时间：2013-05-20</b><br/>
 * <b>修改人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 *
 */
public interface FinancialReportService {

	/**
	 * 班线结算统计表
	 * 
	 * @param
	 * @return
	 */
	public List<Map<String, Object>> scheduleRouteBalanceRpt(String orgids,
			Date startdate, Date enddate, Long vehicleid,Long stationid);
	/**
	 * 各站互售互退营收汇总表
	 * 
	 * @param
	 * @return
	 */
	public List<Map<String, Object>> eachTickeIncomeSumRpt(List<PropertyFilter> propertyFilterList);
	
	/**
	 * 财务收支平衡表
	 * 
	 * @param
	 * @return
	 */
	public List<Map<String, Object>> FinancialBalanceRpt(String orgid,Date startdate,Date enddate);
	

	/**
	 * 财务收支月平衡表
	 * 
	 * @param
	 * @return
	 */
	public List<Map<String, Object>> FinancialBalanceMonthRpt(String orgid,Date startdate,Date enddate);
	
	/**
	 * 运量单运量台账
	 * * @param propertyFilterList,
	 *  add by lck 2011-09-29(from TicketCheckQryService.java)
	 *  update by hhz 2013-05-20
	 * @return
	 */
	public List<Map<String, Object>> DepartInvoincesRpt(Date startdate,Date enddate, int departinvoicestype,String printorgid, List<PropertyFilter> propertyFilterList);
	
	/**
	 * 客运收入、支出平衡表-赣州
	 * 
	 * @param
	 * @return
	 */
	public List<Map<String, Object>> FinancialBalanceGZ(String orgid,Date startdate,Date enddate);
	
	/**
	 *  单位营收统计表-赣州
	 * 
	 * @param
	 * @return
	 */
	public List<Map<String, Object>> IncomeReportGZ(String orgid,Long routeid,Date startdate,Date enddate);
	
	//班次日结算表
	public List<Map<String, Object>> qryScheduleBalancePrice(String sellorgids,long routeid,Date startdate, Date enddate,
			String workways,int isovertime);
	
	//线路日结算表
	public List<Map<String, Object>> qryRouteBalancePrice(String sellorgids,long routeid, Date startdate, Date enddate,
			String workways);
	
	public List<Map<String, Object>> qryRouteBalanceIncome(Date startdate, Date enddate,Long scheduleid,Long routeid,Long stationid,Boolean isroutegroup,Boolean isstationgroup,Boolean isschedulegroup);
	
}
