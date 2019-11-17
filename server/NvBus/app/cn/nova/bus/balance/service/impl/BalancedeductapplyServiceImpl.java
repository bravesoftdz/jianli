package cn.nova.bus.balance.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.dao.BalancedeductitemApplyDao;
import cn.nova.bus.balance.model.Balanceaudit;
import cn.nova.bus.balance.model.Balancedeductapply;
import cn.nova.bus.balance.model.Balancedeductapplysell;
import cn.nova.bus.balance.model.Balancedeductitem;
import cn.nova.bus.balance.service.BalancedeductapplyService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;


public class BalancedeductapplyServiceImpl implements BalancedeductapplyService {


	private BalancedeductitemApplyDao balancedeductitemApplyDao = new BalancedeductitemApplyDao();

	@Override
	public Balancedeductapply saveBalancedeductapply(
			Balancedeductapply balancedeductapply) throws ServiceException {
		if ((balancedeductapply.getOrg()!=null || balancedeductapply.getRoute()!=null
				||balancedeductapply.getRoute()!=null||balancedeductapply.getSchedule()!=null
				||balancedeductapply.getVehicle()!=null||balancedeductapply.getUnit()!=null)
			&&	(balancedeductitemApplyDao.isExistApply(balancedeductapply))) {
			// 应用的日期段不能交叉！
			throw new ServiceException("0160");
		}
		String orgidst=balancedeductapply.getOrgids();
		String typestr=balancedeductapply.getTypes();
		// 若进行修改操作则需重新审核
		if (balancedeductapply.getId() > 0) {
			balancedeductapply.setIsaudited(false);
			balancedeductapply.setIsauditpass(false);
			balancedeductapply.setAuditor(null);
		}
		balancedeductapply=balancedeductitemApplyDao.getEntityManager().merge(
				balancedeductapply);
		if(orgidst!=null &&orgidst.length()>0){
			long curid=balancedeductapply.getId();			
			    balancedeductitemApplyDao.delBalancedeductapplysell(curid);
				String[] orgids=orgidst.split(",");
				String[] types=typestr.split(",");
				int i=0;
				for(String ob:orgids){
					long id=new Long(ob);
					Balancedeductapplysell	bs=new Balancedeductapplysell();
					bs.setBalancedeductapplyid(balancedeductapply.getId());
					bs.setCreateby(balancedeductapply.getUpdateby());
					bs.setCreatetime(new Date());
					bs.setUpdateby(balancedeductapply.getUpdateby());
					bs.setUpdatetime(new Date());
					bs.setType(types[i]);
					i=i+1;
					bs.setDataid(id);
					balancedeductitemApplyDao.save(bs);
				}	
		}
		 return balancedeductapply;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean delBalancedeductapply(Balancedeductapply balancedeductapply)
			throws ServiceException {
		Balancedeductapply obj = (Balancedeductapply) balancedeductitemApplyDao
				.get(Balancedeductapply.class, balancedeductapply.getId());
		if (obj.getIsaudited()) {
			// 该扣费应用已经审核，不能删除
			throw new ServiceException("0161");
		}
		obj.setIsactive(false);
		obj.setUpdateby(balancedeductapply.getCreateby());
		obj.setUpdatetime(new Date());
		balancedeductitemApplyDao.getEntityManager().merge(obj);
		return true;
	}

	@Override
	public List<Map<String, Object>> qryDeductitemApply(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "id", "balancedeductitemid",
				"balancededucttargetid", "startdate", "enddate", "isaudited",
				"isauditpass", "remarks", "isactive", "createtime", "createby",
				"updatetime", "updateby", "createname", "updatename",
				"schedulecode", "routename", "unitname", "vehicleno",
				"targetname", "itemname", "auditorname", "scheduleid",
				"routeid", "unitid", "vehicleid", "orgid", "orgname",
				"deducttype", "deductmoney", "isdeductbeforebalance" },
				balancedeductitemApplyDao
						.queryBalancedeductitemApply(propertyFilterList),
				new Object[] { long.class, long.class, long.class, Date.class,
						Date.class, boolean.class, boolean.class, String.class,
						boolean.class, Timestamp.class, long.class,
						Timestamp.class, long.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						Long.class, Long.class, Long.class, Long.class,
						Long.class, String.class, String.class,
						BigDecimal.class, boolean.class });
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean auditDeductApply(Balancedeductapply balancedeductapply,
			Global global) throws ServiceException {
		Balancedeductapply obj = (Balancedeductapply) balancedeductitemApplyDao
				.get(Balancedeductapply.class, balancedeductapply.getId());
		if (obj.getIsaudited()) {
			// 该扣费应用已经审核过！
			throw new ServiceException("0163");
		}
		Balancedeductitem Balancedeductitem = (Balancedeductitem) balancedeductitemApplyDao
				.get(Balancedeductitem.class, obj.getBalancedeductitemid());

		obj.setIsaudited(true);
		obj.setIsauditpass(true);
		Userinfo u = (Userinfo) balancedeductitemApplyDao.get(Userinfo.class,
				balancedeductapply.getAuditor().getId());
		obj.setAuditor(u);
		obj.setUpdateby(balancedeductapply.getAuditor().getId());
		obj.setUpdatetime(new Date());
		Balanceaudit ba = new Balanceaudit();
		ba.setAudittime(new Date());
		ba.setAuditby(balancedeductapply.getAuditor().getId());
		ba.setAuditip(global.getIpAddress());
		ba.setCreateby(balancedeductapply.getAuditor().getId());
		ba.setCreatetime(new Date());
		ba.setIsauditpass(true);
		ba.setOrgid(Balancedeductitem.getOrgid());
		ba.setType("3");// 结算固定扣费应用
		ba.setTypeid(obj.getId());
		balancedeductitemApplyDao.getEntityManager().merge(ba);
		balancedeductitemApplyDao.getEntityManager().merge(obj);
		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean cancelAuditDeductApply(Balancedeductapply balancedeductapply)
			throws ServiceException {
		Balancedeductapply obj = (Balancedeductapply) balancedeductitemApplyDao
				.get(Balancedeductapply.class, balancedeductapply.getId());
		if (!obj.getIsaudited()) {
			// 该扣费应用还未审核！
			throw new ServiceException("0164");
		}
		obj.setIsaudited(false);
		obj.setIsauditpass(false);
		obj.setAuditor(null);
		obj.setUpdateby(balancedeductapply.getAuditor().getId());
		obj.setUpdatetime(new Date());
		balancedeductitemApplyDao.getEntityManager().merge(obj);
		return true;
	}
	@Override
	public List<Map<String, Object>> qryBalancedeductapplysell(long applyid) {
		return ListUtil.listToMap(new Object[] {"isselect","orgid","name","type","typename" },
				balancedeductitemApplyDao.qyrBalancedeductapplysell(applyid),
				new Object[] {boolean.class, long.class, String.class, String.class, String.class});
	}
}
