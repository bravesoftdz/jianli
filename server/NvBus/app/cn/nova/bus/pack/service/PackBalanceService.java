package cn.nova.bus.pack.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.pack.model.PackBalance;
import cn.nova.utils.orm.PropertyFilter;

public interface PackBalanceService {
	/**
	 * 列表查询
	 * @param propertyFilter
	 * @return
	 */
	List<Map<String, Object>> getList(List<PropertyFilter> propertyFilter);

	/**
	 * 单位结算/单车结算
	 * @param packBalance
	 * @param packids TODO
	 * @return 
	 */
	//Long balance(PackBalance packBalance, String packids);


}
