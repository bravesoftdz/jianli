package cn.nova.bus.pack.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.model.PackIntegrateRule;
import cn.nova.utils.orm.PropertyFilter;

public interface PackIntegrateRuleService {
	/**
	 * 积分转换金额
	 * @param integrater
	 * @param clienttype
	 * @param orgid
	 * @return
	 */
	public List<Map<String, Object>> integraterToMoney(long integrater,
			String clienttype, long orgid);

	/**
	 * 金额转换积分
	 * @param money
	 * @param clienttype
	 * @param orgid
	 * @return
	 */
	public List<Map<String, Object>> moneyToIntegrater(BigDecimal money,
			long clienttype, long orgid);

	/**
	 * 获取积分转换金额百分比
	 * @param clienttype
	 * @param orgid
	 * @return
	 */
	public List<Map<String, Object>> queryPercent(String clienttype, long orgid);

	/**
	 * 查询积分规则
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryPackIntegrateRule(
			List<PropertyFilter> propertyFilterList);

	/**
	 * 保存积分规则
	 * @param packIntegrateRule
	 * @return
	 * @throws ServiceException
	 */
	public PackIntegrateRule savePackIntegrateRule(PackIntegrateRule packIntegrateRule) throws ServiceException ;
	/**
	 * 查找匹配的积分规则
	 * @param packIntegrateRule
	 * @return
	 */
	public PackIntegrateRule query(PackIntegrateRule packIntegrateRule);
	/**
	 * 删除积分规则
	 * @param packIntegrateRule
	 * @return
	 */
	public boolean delPackIntegrateRule(PackIntegrateRule packIntegrateRule);
}
