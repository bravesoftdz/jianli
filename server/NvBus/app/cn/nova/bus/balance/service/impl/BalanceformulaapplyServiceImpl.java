package cn.nova.bus.balance.service.impl;

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

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.dao.BalanceformulaapplyDao;
import cn.nova.bus.balance.model.Balanceaudit;
import cn.nova.bus.balance.model.Balanceformula;
import cn.nova.bus.balance.model.Balanceformulaapply;
import cn.nova.bus.balance.service.BalanceformulaapplyService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;


public class BalanceformulaapplyServiceImpl implements
		BalanceformulaapplyService {

	private BalanceformulaapplyDao balanceformulaapplyDao = new BalanceformulaapplyDao();

	@Override
	public List<Map<String, Object>> qryBalanceformula(String orgids) {
		return ListUtil.listToMap(new Object[] { "id", "formula",
				"formulaname", "parentid" },
				balanceformulaapplyDao.qryBalanceformula(orgids), new Object[] {
						Long.class, String.class, String.class, Long.class });
	}

	@Override
	public List<Map<String, Object>> qryBalanceformulaApply(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil
				.listToMap(
						new Object[] { "id", "balanceformulaid",
								"balancededucttargetid", "startdate",
								"enddate", "isaudited", "isauditpass",
								"remarks", "isactive", "createtime",
								"createby", "updatetime", "updateby",
								"createname", "updatename", "schedulecode",
								"routename", "unitname", "vehicleno",
								"targetname", "auditorname", "formulaname",
								"scheduleid", "routeid", "unitid", "vehicleid",
								"orgid", "orgname", "parentid" },
						balanceformulaapplyDao
								.qryBalanceformulaapply(propertyFilterList),
						new Object[] { long.class, long.class, long.class,
								Date.class, Date.class, boolean.class,
								boolean.class, String.class, boolean.class,
								Timestamp.class, long.class, Timestamp.class,
								long.class, String.class, String.class,
								String.class, String.class, String.class,
								String.class, String.class, String.class,
								String.class, Long.class, Long.class,
								Long.class, Long.class, Long.class,
								String.class, Long.class });
	}

	@Override
	public Balanceformulaapply saveBalanceformulaapply(
			Balanceformulaapply balanceformulaapply) throws ServiceException {
		if (balanceformulaapplyDao.isExistApply(balanceformulaapply)) {
			// 应用的日期段不能交叉！
			throw new ServiceException("0160");
		}
		// 若进行修改操作则需重新审核
		if (balanceformulaapply.getId() > 0) {
			balanceformulaapply.setIsaudited(false);
			balanceformulaapply.setIsauditpass(false);
			balanceformulaapply.setAuditor(null);
		}
		return balanceformulaapplyDao.getEntityManager().merge(
				balanceformulaapply);
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean delBalancedeductapply(Balanceformulaapply balanceformulaapply)
			throws ServiceException {
		Balanceformulaapply obj = (Balanceformulaapply) balanceformulaapplyDao
				.get(Balanceformulaapply.class, balanceformulaapply.getId());
		if (obj.getIsaudited()) {
			// 该扣费应用已经审核，不能删除
			throw new ServiceException("0161");
		}
		obj.setIsactive(false);
		obj.setUpdateby(balanceformulaapply.getCreateby());
		obj.setUpdatetime(new Date());
		balanceformulaapplyDao.getEntityManager().merge(obj);
		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean auditBalanceformulaapply(
			Balanceformulaapply balanceformulaapply, Global global)
			throws ServiceException {
		Balanceformulaapply obj = (Balanceformulaapply) balanceformulaapplyDao
				.get(Balanceformulaapply.class, balanceformulaapply.getId());
		if (obj.getIsaudited()) {
			// 该扣费应用已经审核过！
			throw new ServiceException("0163");
		}
		Balanceformula balanceformula = (Balanceformula) balanceformulaapplyDao
				.get(Balanceformula.class, obj.getBalanceformulaid());
		obj.setIsaudited(true);
		obj.setIsauditpass(true);
		Userinfo u = (Userinfo) balanceformulaapplyDao.get(Userinfo.class,
				balanceformulaapply.getAuditor().getId());
		obj.setAuditor(u);
		obj.setUpdateby(balanceformulaapply.getAuditor().getId());
		obj.setUpdatetime(new Date());
		Balanceaudit ba = new Balanceaudit();
		ba.setAudittime(new Date());
		ba.setAuditby(balanceformulaapply.getAuditor().getId());
		ba.setAuditip(global.getIpAddress());
		ba.setCreateby(balanceformulaapply.getAuditor().getId());
		ba.setCreatetime(new Date());
		ba.setIsauditpass(true);
		ba.setOrgid(balanceformula.getOrgid());
		ba.setType("1");// 结算公式扣费应用
		ba.setTypeid(obj.getId());
		balanceformulaapplyDao.getEntityManager().merge(obj);
		balanceformulaapplyDao.getEntityManager().merge(ba);
		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean cancelBalanceformulaapply(
			Balanceformulaapply balanceformulaapply, Global global)
			throws ServiceException {
		Balanceformulaapply obj = (Balanceformulaapply) balanceformulaapplyDao
				.get(Balanceformulaapply.class, balanceformulaapply.getId());
		if (!obj.getIsaudited()) {
			// 该扣费应用还未审核！
			throw new ServiceException("0164");
		}
		obj.setIsaudited(false);
		obj.setIsauditpass(false);
		obj.setAuditor(null);
		obj.setUpdateby(balanceformulaapply.getAuditor().getId());
		obj.setUpdatetime(new Date());
		balanceformulaapplyDao.getEntityManager().merge(obj);
		return true;
	}
}
