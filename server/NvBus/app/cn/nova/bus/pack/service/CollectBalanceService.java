package cn.nova.bus.pack.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.pack.model.CollectBalance;
import cn.nova.utils.orm.PropertyFilter;

public interface CollectBalanceService {

	/**
	 * 列表查询
	 * @param propertyFilter
	 * @return
	 */
	List<Map<String, Object>> getList(List<PropertyFilter> propertyFilter);

	/**
	 * 代收货款结算
	 * @param collectBalance
	 * @param packids
	 * @return
	 */
	Long balance(CollectBalance collectBalance, String packids);

}
