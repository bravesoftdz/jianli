package cn.nova.bus.query.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.param.Reportparam;
import cn.nova.utils.orm.PropertyFilter;

public interface DispatchQryService {

	/**
	 * 客运班线发车时刻表
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryScheduleDepartTime(
			List<PropertyFilter> propertyFilterList);

	/**
	 * 客运站班次运营情况
	 * @param propertyFilterList
	 * @return
	 */
	List<Map<String, Object>> queryScheduleRunSituation(
			List<PropertyFilter> propertyFilterList,long curstationid, Date departdate,String sellorgid);
	
	/**
	 * 班次运营情况---售票明细汇总表
	 * @param propertyFilterList
	 * @return
	 */
	List<Map<String, Object>> querySoldSituation(int scheduleplanid,int scheduleid);
	
	/**
	 * 脱班班次情况查询
	 * @param propertyFilterList
	 * @return
	 */
	List<Map<String, Object>> queryVehicleLost(
			List<PropertyFilter> propertyFilterList);

	/**
	 * 班次报停情况查询
	 * @param propertyFilterList
	 * @return
	 */
	List<Map<String, Object>> queryVehicleStop(
			List<PropertyFilter> propertyFilterList,String vehicleno,String loststatus);

	/**
	 * 晚点班次情况查询
	 * @param propertyFilterList
	 * @return
	 */
	List<Map<String, Object>> queryVehicleLate(
			List<PropertyFilter> propertyFilterList,String notbalance);

	/**
	 * 并班班次情况查询
	 * @param propertyFilterList
	 * @return
	 */
	List<Map<String, Object>> queryschedulemerge(
			List<PropertyFilter> propertyFilterList);

	/**
	 * 班次并班车票明细情况查询
	 * @param propertyFilterList
	 * @return
	 */
	List<Map<String, Object>> queryschedulemergeDetail(
			List<PropertyFilter> propertyFilterList);
	
	/**
	 * 客运站加班情况
	 * @param propertyFilterList
	 * @return
	 */
	List<Map<String, Object>> queryOvertimeSchedule(
			List<PropertyFilter> propertyFilterList,long curstationid);
	
	/**
	 * 满座班次查询
	 * * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryFullSeatSchedule(List<PropertyFilter> propertyFilterList);
	
	
	/**
	 * 车辆应班登记表
	 */
	
	public List<Map<String, Object>> queryVehicleLicense(Reportparam rp);
	
	/**
	 * 运量单的车票明细
	 * @param departinvoicesid
	 * @return
	 */
	public List<Map<String, Object>> queryTicketInfo(long departinvoicesid);
}
