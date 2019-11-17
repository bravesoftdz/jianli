package cn.nova.bus.query.service;

import java.util.List;
import java.util.Map;

import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;

public interface DataContrastSummaryService {

	/**
	 * 站务分公司班线数据情况汇总表
	 * @param propertyFilterList
	 * @param isbynormal
	 * @param isbylatter
	 * @return
	 */
	public List<Map<String, Object>> queryRouteDataSummary(List<PropertyFilter> propertyFilterList,
			boolean isbynormal,boolean isbylatter);
	
	/**
	 * 站务分公司网点售票情况汇总表
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryTicketSummary(List<PropertyFilter> propertyFilterList);
	
	/**
	 * 站务分公司站场业务数据情况汇总表
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryBusinessSummary(List<PropertyFilter> propertyFilterList);
	
	/**
	 * 联网售票统计报表
	 * @param propertyFilterList
	 * @return
	 */
	public  MethodResult queryNetworkTicket(List<PropertyFilter> propertyFilterList);
	
	/**
	 * 预售票日报表
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryDayBookings(List<PropertyFilter> propertyFilterList);
	
	/**
	 *站务作业统计报表  
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryOrgDataSummary(List<PropertyFilter> propertyFilterList);
	
	/**
	 *站务分公司各班线票价情况汇总表  
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> querySchTicketprice(List<PropertyFilter> propertyFilterList);
	
	/**
	 *站务分公司进站车辆汇总表  
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryDrawVehSummary(List<PropertyFilter> propertyFilterList);
}
