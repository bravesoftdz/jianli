package cn.nova.bus.query.service;

import java.util.List;
import java.util.Map;

import cn.nova.utils.orm.PropertyFilter;

public interface PriceQueryService {

	/**
	 * 班次票价查询
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> QuerySchedulePrice(
			List<PropertyFilter> propertyFilterList);

}
