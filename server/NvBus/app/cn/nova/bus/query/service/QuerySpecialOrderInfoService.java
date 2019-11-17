package cn.nova.bus.query.service;

import java.util.List;
import java.util.Map;

import cn.nova.utils.orm.PropertyFilter;





public interface QuerySpecialOrderInfoService {
	/**
	 * 特殊订单退款明细
	 * @param propertyFilterList
	 * @return
	 */
	List<Map<String, Object>> querySpecialOrderInfo(
			List<PropertyFilter> propertyFilterList);
}
