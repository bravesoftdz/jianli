package cn.nova.bus.query.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.query.dao.DispatchQueryDao;
import cn.nova.bus.query.dao.QuerySpecialOrderInfoDao;
import cn.nova.bus.query.service.QuerySpecialOrderInfoService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

public  class QuerySpecialOrderInfoServiceImpl implements
QuerySpecialOrderInfoService{
	private QuerySpecialOrderInfoDao SpecialOrderInfoDao;
	
	/**
	 *特殊订单退款明细
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@Override
	
	public List<Map<String, Object>> querySpecialOrderInfo(
			List<PropertyFilter> propertyFilterList) {
		SpecialOrderInfoDao = new QuerySpecialOrderInfoDao();
		return ListUtil
				.listToMap(
						new Object[] { "name", "orderno", "departdate",
								"price", "insurefee", "status", "returnfee",
								"returncause", "returnperson", "returntime",
								"remark" }, SpecialOrderInfoDao
								.querySpecialOrderInfo(propertyFilterList),
						new Object[] { String.class, String.class,
								String.class, String.class, String.class,
								String.class, String.class, String.class,
								String.class, String.class, String.class });
	}
	
}
