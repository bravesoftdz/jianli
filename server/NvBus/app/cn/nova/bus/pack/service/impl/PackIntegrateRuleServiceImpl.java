package cn.nova.bus.pack.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import util.SystemException;
import util.UserTransaction;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.dao.PackIntegrateRuleDao;
import cn.nova.bus.pack.dao.PackfeeDao;
import cn.nova.bus.pack.model.Client;
import cn.nova.bus.pack.model.PackIntegrateRule;
import cn.nova.bus.pack.model.Packfee;
import cn.nova.bus.pack.service.PackIntegrateRuleService;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

public class PackIntegrateRuleServiceImpl implements PackIntegrateRuleService {
	private PackIntegrateRuleDao packIntegrateRuleDao = new PackIntegrateRuleDao();

	@Override
	public List<Map<String, Object>> integraterToMoney(long integrater,
			String clienttype, long orgid) {
		return ListUtil.listToMap(new Object[] { "money" },
				packIntegrateRuleDao.integraterToMoney(integrater, clienttype,
						orgid), new Object[] { BigDecimal.class });

	}

	@Override
	public List<Map<String, Object>> moneyToIntegrater(BigDecimal money,
			long clienttype, long orgid) {
		return ListUtil.listToMap(new Object[] { "integrater" },
				packIntegrateRuleDao
						.moneyToIntegrater(money, clienttype, orgid),
				new Object[] { Long.class });
	}

	@Override
	public List<Map<String, Object>> queryPercent(String clienttype, long orgid) {
		return ListUtil.listToMap(new Object[] { "percent" },
				packIntegrateRuleDao.queryPercent(clienttype, orgid),
				new Object[] { float.class });

	}

	@Override
	public List<Map<String, Object>> queryPackIntegrateRule(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { PackIntegrateRule.class,
				"orgname","createname","updatename" }, packIntegrateRuleDao.query(propertyFilterList),
				new Object[] { PackIntegrateRule.class, String.class, String.class, String.class });
	}

	@Override
	public PackIntegrateRule savePackIntegrateRule(
			PackIntegrateRule packIntegrateRule) throws ServiceException {
		Global global = CurrentUtil.getGlobal();
		if (packIntegrateRule != null) {
			PackIntegrateRule pr = this.query(packIntegrateRule);
			if (packIntegrateRule.getId() > 0) {
				packIntegrateRule.setUpdatetime(new Date());
				packIntegrateRule.setUpdateby(global.getUserinfo().getId());
				packIntegrateRule.setCreatetime(pr.getCreatetime());
				packIntegrateRule.setCreateby(pr.getUpdateby());
				packIntegrateRuleDao.merge(packIntegrateRule);
			} else {
//				PackIntegrateRule pr = this.query(packIntegrateRule);
				//所属机构、客户类型、积分规则类型唯一，新增时如果数据库有记录，则按更新处理
				if (pr != null) {                                        
					pr.setUpdatetime(new Date());
					pr.setUpdateby(global.getUserinfo().getId());
					pr.setPrice(packIntegrateRule.getPrice());
					pr.setIntegrate(packIntegrateRule.getIntegrate());
					packIntegrateRuleDao.merge(pr);
				} else {
					packIntegrateRule.setUpdatetime(new Date());
					packIntegrateRule.setUpdateby(global.getUserinfo().getId());
					packIntegrateRule.setCreatetime(new Date());
					packIntegrateRule.setCreateby(global.getUserinfo().getId());
					packIntegrateRuleDao.save(packIntegrateRule);
				}
			}
		}
		return packIntegrateRule;
	}

	@Override
	public PackIntegrateRule query(PackIntegrateRule packIntegrateRule) {
		if (packIntegrateRule != null) {
			List<Object> packIntegrateRules = packIntegrateRuleDao.query(
					packIntegrateRule.getClienttype(),
					packIntegrateRule.getOrgid(), packIntegrateRule.getType());
			if (packIntegrateRules.size() > 0) {
				return (PackIntegrateRule) packIntegrateRules.get(0);
			} else {
				return null;
			}
		}
		return null;
	}

	/**
	 * 删除积分规则
	 * 
	 * @param packIntegrateRule
	 * @return
	 */
	public boolean delPackIntegrateRule(PackIntegrateRule packIntegrateRule) {
		return packIntegrateRuleDao.del(packIntegrateRule);
	}
}
