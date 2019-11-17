package cn.nova.bus.report.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.utils.orm.PropertyFilter;

public interface CustomerBookingService {

	/**
	 * 订票统计查询
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> QueryCustomerBooking(
			String orgid,Date startdate,Date enddate);

	/**
	 * 班次预售情况查询
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> QueryPersellSum(
			List<PropertyFilter> propertyFilterList);

}
