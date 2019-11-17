package cn.nova.bus.price.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.dao.FormulaitemAboutDao;
import cn.nova.bus.price.model.Formulaitemdistance;
import cn.nova.bus.price.model.Formulaitemfixedvalue;
import cn.nova.bus.price.model.Formulaitemformula;
import cn.nova.bus.price.model.Formulaitemorggrade;
import cn.nova.bus.price.model.Formulaitemprice;
import cn.nova.bus.price.model.Formulaitemroadgrade;
import cn.nova.bus.price.model.Formulaitemroute;
import cn.nova.bus.price.model.Formulaitemroutestop;
import cn.nova.bus.price.model.Formulaitemschedule;
import cn.nova.bus.price.model.Formulaitemvehcile;
import cn.nova.bus.price.model.Formulaitemvehcileroadgrad;
import cn.nova.bus.price.model.Ticketpriceformulaitem;
import cn.nova.bus.price.service.FormulaitemService;
import cn.nova.utils.orm.jpa.ListUtil;
/**
 * @author lck
 * 
 */
public class FormulaitemServiceImpl implements FormulaitemService {

	private FormulaitemAboutDao formulaitemAboutDao = new FormulaitemAboutDao();

	@Override
	public List<Map<String, Object>> query(String flag,
			Ticketpriceformulaitem ticketpriceformulaitem) {
		if ("0".equals(flag))// 车型相关
			return ListUtil.listToMap(new Object[] { Formulaitemvehcile.class,
					"vehiclename" }, formulaitemAboutDao
					.queryFormulaitemvehcile(ticketpriceformulaitem),
					new Object[] { Formulaitemvehcile.class, String.class });
		else if ("1".equals(flag))// 公路等级相关
			return ListUtil
					.listToMap(new Object[] { Formulaitemroadgrade.class,
							"roadgradename" }, formulaitemAboutDao
							.queryFormulaitemRoadgrade(ticketpriceformulaitem),
							new Object[] { Formulaitemroadgrade.class,
									String.class });
		else if ("2".equals(flag))// 车型公路等级相关
			return ListUtil.listToMap(new Object[] {
					Formulaitemvehcileroadgrad.class, "roadgradename",
					"vehiclename" }, formulaitemAboutDao
					.queryFormulaitemVehRoadgrade(ticketpriceformulaitem),
					new Object[] { Formulaitemvehcileroadgrad.class,
							String.class, String.class });
		else if ("3".equals(flag))// 客运站等级相关
			return ListUtil.listToMap(new Object[] { Formulaitemorggrade.class,
					"stationgradename" }, formulaitemAboutDao
					.queryFormulaitemStationgrade(ticketpriceformulaitem),
					new Object[] { Formulaitemorggrade.class, String.class });
		else if ("4".equals(flag))// 班次相关
			return ListUtil.listToMap(new Object[] { Formulaitemschedule.class,
					"routename", "code", "starttime" }, formulaitemAboutDao
					.queryFormulaitemSchedule(ticketpriceformulaitem),
					new Object[] { Formulaitemschedule.class, String.class,
							String.class, String.class });
		else if ("5".equals(flag))// 线路相关
			return ListUtil.listToMap(new Object[] { Formulaitemroute.class,
					"routename" }, formulaitemAboutDao
					.queryFormulaitemroute(ticketpriceformulaitem),
					new Object[] { Formulaitemroute.class, String.class });
		else if ("6".equals(flag))// 线路停靠点相关
			return ListUtil.listToMap(new Object[] {
					Formulaitemroutestop.class, "routename", "stationname" },
					formulaitemAboutDao
							.queryFormulaitemroutestop(ticketpriceformulaitem),
					new Object[] { Formulaitemroutestop.class, String.class,
							String.class });
		else if ("7".equals(flag))// 票价区间相关
			return ListUtil.listToMap(new Object[] { Formulaitemprice.class },
					formulaitemAboutDao
							.queryFormulaitemPrice(ticketpriceformulaitem),
					new Object[] { Formulaitemprice.class });
		else if ("8".equals(flag))// 里程区间相关
			return ListUtil.listToMap(
					new Object[] { Formulaitemdistance.class },
					formulaitemAboutDao
							.queryFormulaitemdistance(ticketpriceformulaitem),
					new Object[] { Formulaitemdistance.class });
		else if ("9".equals(flag))// 固定值相关
			return ListUtil.listToMap(
					new Object[] { Formulaitemfixedvalue.class },
					formulaitemAboutDao
							.queryFormulaitemfixed(ticketpriceformulaitem),
					new Object[] { Formulaitemfixedvalue.class });	
		else if ("10".equals(flag))// 表达式相关
			return ListUtil.listToMap(
					new Object[] { Formulaitemformula.class },
					formulaitemAboutDao
							.queryFormulaitemformula(ticketpriceformulaitem),
					new Object[] { Formulaitemformula.class});				
		else
			return ListUtil.listToMap(new Object[] { Formulaitemvehcile.class,
					"vehiclename" }, formulaitemAboutDao
					.queryFormulaitemvehcile(ticketpriceformulaitem),
					new Object[] { Formulaitemvehcile.class, String.class });
	}

	// 车型相关部分
	@Override
	public boolean saveformulaitemvehcile(Formulaitemvehcile formulaitemvehcile)
			throws ServiceException {
		if (formulaitemAboutDao.isExistformulaitemvehcile(formulaitemvehcile)) {
			throw new ServiceException("0018");
		}
		if (formulaitemvehcile.getId() == 0) {
			formulaitemAboutDao.getEntityManager().persist(formulaitemvehcile);
		} else {
			formulaitemAboutDao.getEntityManager().merge(formulaitemvehcile);
		}
		return true;
	}

	@Override
	public boolean delformulaitemvehcile(Formulaitemvehcile formulaitemvehcile)
			throws ServiceException {
		Formulaitemvehcile oldformulaitemvehcile = formulaitemAboutDao
				.getEntityManager().find(Formulaitemvehcile.class,
						formulaitemvehcile.getId());
		formulaitemAboutDao.getEntityManager().remove(oldformulaitemvehcile);
		formulaitemAboutDao.getEntityManager().flush();
		return true;
	}

	// 线路相关部分
	@Override
	public boolean saveformulaitemroute(Formulaitemroute formulaitemroute)
			throws ServiceException {
		if (formulaitemAboutDao.isExistformulaitemroute(formulaitemroute)) {
			throw new ServiceException("0019");
		}
		if (formulaitemroute.getId() == 0) {
			formulaitemAboutDao.getEntityManager().persist(formulaitemroute);
		} else {
			formulaitemAboutDao.getEntityManager().merge(formulaitemroute);
		}
		return true;
	}

	// 线路相关部分批量保存
	@Override
	public boolean saveformulaitemroutes(Formulaitemroute formulaitemroute,
			String routeidlist) throws ServiceException {
		String routeids[] = routeidlist.split(",");
		for (String srouteid : routeids) {
			Long routeid = new Long(srouteid);
			Formulaitemroute obj = formulaitemAboutDao.queryFormulaitemroute(
					formulaitemroute.getTicketpriceformulaitem(), routeid);
			if (obj == null) {
				obj = new Formulaitemroute();
				obj.setCreateby(formulaitemroute.getCreateby());
				obj.setCreatetime(new Date());
				obj.setTicketpriceformulaitem(formulaitemroute
						.getTicketpriceformulaitem());
				obj.setUpdateby(formulaitemroute.getCreateby());
				obj.setUpdatetime(new Date());
				obj.setValue(formulaitemroute.getValue());
				obj.setRouteid(routeid);
				formulaitemAboutDao.getEntityManager().persist(obj);
			} else {
				obj.setValue(formulaitemroute.getValue());
				obj.setUpdateby(formulaitemroute.getCreateby());
				obj.setUpdatetime(new Date());
				formulaitemAboutDao.getEntityManager().merge(obj);
			}

		}
		return true;
	}

	@Override
	public boolean delformulaitemroute(Formulaitemroute formulaitemroute)
			throws ServiceException {
		Formulaitemroute oldformulaitemroute = formulaitemAboutDao
				.getEntityManager().find(Formulaitemroute.class,
						formulaitemroute.getId());
		formulaitemAboutDao.getEntityManager().remove(oldformulaitemroute);
		formulaitemAboutDao.getEntityManager().flush();
		return true;
	}

	// 线路停靠点相关
	@Override
	public boolean saveformulaitemrouteStop(
			Formulaitemroutestop formulaitemroutestop) throws ServiceException {
		if (formulaitemAboutDao
				.isExistformulaitemRouteStop(formulaitemroutestop)) {
			throw new ServiceException("0026");
		}
		if (formulaitemroutestop.getId() == 0) {
			formulaitemAboutDao.getEntityManager()
					.persist(formulaitemroutestop);
		} else {
			formulaitemAboutDao.getEntityManager().merge(formulaitemroutestop);
		}
		return true;
	}

	@Override
	public boolean delformulaitemrouteStop(
			Formulaitemroutestop formulaitemroutestop) throws ServiceException {
		Formulaitemroutestop oldformulaitemroutestop = formulaitemAboutDao
				.getEntityManager().find(Formulaitemroutestop.class,
						formulaitemroutestop.getId());
		formulaitemAboutDao.getEntityManager().remove(oldformulaitemroutestop);
		formulaitemAboutDao.getEntityManager().flush();
		return true;
	}

	// 里程区间相关
	@Override
	public boolean saveformulaitemdistance(
			Formulaitemdistance formulaitemdistance) throws ServiceException {
		if (formulaitemAboutDao.isExistformulaitemDistance(formulaitemdistance)) {
			throw new ServiceException("0028");
		}
		if (formulaitemdistance.getId() == 0) {
			formulaitemAboutDao.getEntityManager().persist(formulaitemdistance);
		} else {
			formulaitemAboutDao.getEntityManager().merge(formulaitemdistance);
		}
		return true;
	}

	@Override
	public boolean delformulaitemdistance(
			Formulaitemdistance formulaitemdistance) throws ServiceException {
		Formulaitemdistance oldformulaitemdistance = formulaitemAboutDao
				.getEntityManager().find(Formulaitemdistance.class,
						formulaitemdistance.getId());
		formulaitemAboutDao.getEntityManager().remove(oldformulaitemdistance);
		formulaitemAboutDao.getEntityManager().flush();
		return true;
	}

	// 票价区间相关
	@Override
	public boolean saveformulaitemprice(Formulaitemprice formulaitemprice)
			throws ServiceException {
		if (formulaitemAboutDao.isExistformulaitemPrice(formulaitemprice)) {
			throw new ServiceException("0029");
		}
		if (formulaitemprice.getId() == 0) {
			formulaitemAboutDao.getEntityManager().persist(formulaitemprice);
		} else {
			formulaitemAboutDao.getEntityManager().merge(formulaitemprice);
		}
		return true;
	}

	@Override
	public boolean delformulaitemprice(Formulaitemprice formulaitemprice)
			throws ServiceException {
		Formulaitemprice oldformulaitemprice = formulaitemAboutDao
				.getEntityManager().find(Formulaitemprice.class,
						formulaitemprice.getId());
		formulaitemAboutDao.getEntityManager().remove(oldformulaitemprice);
		formulaitemAboutDao.getEntityManager().flush();
		return true;
	}

	// 客运站等级相关
	@Override
	public boolean saveformulaitemStationGrade(
			Formulaitemorggrade formulaitemorggrade) throws ServiceException {
		if (formulaitemAboutDao
				.isExistformulaitemStationGrade(formulaitemorggrade)) {
			throw new ServiceException("0030");
		}
		if (formulaitemorggrade.getId() == 0) {
			formulaitemAboutDao.getEntityManager().persist(formulaitemorggrade);
		} else {
			formulaitemAboutDao.getEntityManager().merge(formulaitemorggrade);
		}
		return true;
	}

	@Override
	public boolean delformulaitemStationGrade(
			Formulaitemorggrade formulaitemorggrade) throws ServiceException {
		Formulaitemorggrade oldformulaitemorggrade = formulaitemAboutDao
				.getEntityManager().find(Formulaitemorggrade.class,
						formulaitemorggrade.getId());
		formulaitemAboutDao.getEntityManager().remove(oldformulaitemorggrade);
		formulaitemAboutDao.getEntityManager().flush();
		return true;
	}

	// 公路等级相关
	@Override
	public boolean saveformulaitemRoadGrade(
			Formulaitemroadgrade formulaitemroadgrade) throws ServiceException {
		if (formulaitemAboutDao
				.isExistformulaitemRoadGrade(formulaitemroadgrade)) {
			throw new ServiceException("0031");
		}
		if (formulaitemroadgrade.getId() == 0) {
			formulaitemAboutDao.getEntityManager()
					.persist(formulaitemroadgrade);
		} else {
			formulaitemAboutDao.getEntityManager().merge(formulaitemroadgrade);
		}
		return true;
	}

	@Override
	public boolean delformulaitemRoadGrade(
			Formulaitemroadgrade formulaitemroadgrade) throws ServiceException {
		Formulaitemroadgrade oldformulaitemroadgrade = formulaitemAboutDao
				.getEntityManager().find(Formulaitemroadgrade.class,
						formulaitemroadgrade.getId());
		formulaitemAboutDao.getEntityManager().remove(oldformulaitemroadgrade);
		formulaitemAboutDao.getEntityManager().flush();
		return true;
	}

	// 车型公路等级
	@Override
	public boolean saveformulaitemVehRoadGrade(
			Formulaitemvehcileroadgrad formulaitemvehcileroadgrad)
			throws ServiceException {
		if (formulaitemAboutDao
				.isExistformulaitemVchRoadGrade(formulaitemvehcileroadgrad)) {
			throw new ServiceException("0032");
		}
		if (formulaitemvehcileroadgrad.getId() == 0) {
			formulaitemAboutDao.getEntityManager().persist(
					formulaitemvehcileroadgrad);
		} else {
			formulaitemAboutDao.getEntityManager().merge(
					formulaitemvehcileroadgrad);
		}
		return true;
	}

	@Override
	public boolean delformulaitemVehRoadGrade(
			Formulaitemvehcileroadgrad formulaitemvehcileroadgrad)
			throws ServiceException {
		Formulaitemvehcileroadgrad oldformulaitemvehcileroadgrad = formulaitemAboutDao
				.getEntityManager().find(Formulaitemvehcileroadgrad.class,
						formulaitemvehcileroadgrad.getId());
		formulaitemAboutDao.getEntityManager().remove(
				oldformulaitemvehcileroadgrad);
		formulaitemAboutDao.getEntityManager().flush();
		return true;
	}

	// 班次相关
	@Override
	public boolean saveformulaitemSchedule(
			Formulaitemschedule formulaitemschedule) throws ServiceException {
		if (formulaitemAboutDao.isExistformulaitemSchedule(formulaitemschedule)) {
			throw new ServiceException("0034");
		}
		if (formulaitemschedule.getId() == 0) {
			formulaitemAboutDao.getEntityManager().persist(formulaitemschedule);
		} else {
			formulaitemAboutDao.getEntityManager().merge(formulaitemschedule);
		}
		return true;
	}

	@Override
	public boolean delformulaitemSchedule(
			Formulaitemschedule formulaitemschedule) throws ServiceException {
		Formulaitemschedule obj = formulaitemAboutDao.getEntityManager().find(
				Formulaitemschedule.class, formulaitemschedule.getId());
		formulaitemAboutDao.getEntityManager().remove(obj);
		formulaitemAboutDao.getEntityManager().flush();
		return true;
	}

}
