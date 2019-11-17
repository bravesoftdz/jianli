package cn.nova.bus.balance.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.model.Balancedeductapply;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

public interface BalancedeductapplyService {

	public List<Map<String, Object>> qryDeductitemApply(
			List<PropertyFilter> propertyFilterList);

	public Balancedeductapply saveBalancedeductapply(
			Balancedeductapply balancedeductapply) throws ServiceException;

	public boolean delBalancedeductapply(Balancedeductapply balancedeductapply)
			throws ServiceException;

	// 审核扣费应用
	public boolean auditDeductApply(Balancedeductapply balancedeductapply,Global global)
			throws ServiceException;
	
	// 取消审核扣费应用
	public boolean cancelAuditDeductApply(Balancedeductapply balancedeductapply)
			throws ServiceException;
	
	public List<Map<String, Object>> qryBalancedeductapplysell(long applyid);	
}
