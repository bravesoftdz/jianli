package cn.nova.bus.query.service;

import java.util.List;
import java.util.Map;

import cn.nova.utils.orm.PropertyFilter;

public interface TicketCheckQryService {

	/**
	 * 结算单情况查询(汇总查询)
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryDepartinvoices(List<PropertyFilter> propertyFilterList,long printby);
	
	/**
	 * 结算单明细情况查询
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> querydepartinvoicesDetail(List<PropertyFilter> propertyFilterList);
	
	/**
	 * 扣费明显情况查询
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryDeductdetail(List<PropertyFilter> propertyFilterList);
	/**
	 * 班次漏乘情况查询
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryScheduleMiss(List<PropertyFilter> propertyFilterList,boolean ticketnoVisible);

	/**
	 * 班次报班情况查询
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryVehicleReport(List<PropertyFilter> propertyFilterList);
	
	/**
	 * 班次混检情况查询
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryTicketmixcheck(List<PropertyFilter> propertyFilterList);

	/**
	 *  班次检票汇总表
	 * * @param propertyFilterList,
	 * @return
	 */
	public List<Map<String, Object>> queryScheduleCheckSum(List<PropertyFilter> propertyFilterList);

	public List<Map<String, Object>> qrycheckworkmonth(
			List<PropertyFilter> propertyFilterList);

	public List<Map<String, Object>> qrychecklog(List<PropertyFilter> propertyFilterList);
	
}
