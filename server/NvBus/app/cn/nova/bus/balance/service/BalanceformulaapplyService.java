package cn.nova.bus.balance.service;

/**
 * 
 * <p>
 * Title: 结算公式扣费应用
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2011
 * </p>
 * <p>
 * Company: nova
 * </p>
 * 
 * @author lanckun
 * @version 0.1
 */
import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.model.Balanceformulaapply;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

public interface BalanceformulaapplyService {
	public List<Map<String, Object>> qryBalanceformula(String orgids);

	public List<Map<String, Object>> qryBalanceformulaApply(
			List<PropertyFilter> propertyFilterList);

	public Balanceformulaapply saveBalanceformulaapply(
			Balanceformulaapply balanceformulaapply) throws ServiceException;

	public boolean delBalancedeductapply(Balanceformulaapply balanceformulaapply)
			throws ServiceException;

	// 审核扣费公式应用
	public boolean auditBalanceformulaapply(
			Balanceformulaapply balanceformulaapply, Global global)
			throws ServiceException;

	// 取消审核扣费公式应用
	public boolean cancelBalanceformulaapply(
			Balanceformulaapply balanceformulaapply, Global global)
			throws ServiceException;

}
