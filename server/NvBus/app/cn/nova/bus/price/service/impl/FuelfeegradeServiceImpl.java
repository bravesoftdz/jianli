package cn.nova.bus.price.service.impl;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.dao.FuelfeegradeDao;
import cn.nova.bus.price.model.Fuelfeegrade;
import cn.nova.bus.price.model.Fuelfeegradeapply;
import cn.nova.bus.price.model.Fuelfeegradedetail;
import cn.nova.bus.price.service.FuelfeegradeService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;


public class FuelfeegradeServiceImpl implements FuelfeegradeService {


	private FuelfeegradeDao fuelfeegradeDao = new FuelfeegradeDao();

	@Override
	public List<Map<String, Object>> qryFuelfeegrade(String orgids) {
		return ListUtil.listToMap(new Object[] { Fuelfeegrade.class,
				"createname", "updatename", "orgname" },
				fuelfeegradeDao.qryFuelfeegrades(orgids), new Object[] {
						Fuelfeegrade.class, String.class, String.class,
						String.class });
	}

	@Override
	public List<Map<String, Object>> qryFuelfeegrade(long orgid) {
		return ListUtil.listToMap(new Object[] { Fuelfeegrade.class },
				fuelfeegradeDao.qryFuelfeegrades(orgid),
				new Object[] { Fuelfeegrade.class });
	}

	@Override
	public Fuelfeegrade saveFuelfeegrade(Fuelfeegrade fuelfeegrade)
			throws ServiceException {
		List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
		filters.clear();
		filters.add(new PropertyFilter("EQI_t!grade", fuelfeegrade.getGrade()));
		filters.add(new PropertyFilter("EQL_t!orgid", fuelfeegrade.getOrgid()));
		if (fuelfeegrade.getId() == 0) {
			List<Fuelfeegrade> flist = fuelfeegradeDao.qryFuelfeegrade(filters);
			if (flist != null && flist.size() > 0) {
				// 该档次的油价区间已经添加！
				throw new ServiceException("0405");
			}
			fuelfeegrade.setCreatetime(new Date());
			fuelfeegrade.setUpdatetime(new Date());
			fuelfeegrade.setUpdateby(fuelfeegrade.getCreateby());
		} else {
			filters.add(new PropertyFilter("NOEQL_t!id", fuelfeegrade.getId()));
			List<Fuelfeegrade> flist = fuelfeegradeDao.qryFuelfeegrade(filters);
			if (flist != null && flist.size() > 0) {
				// 该档次的油价区间已经添加！
				throw new ServiceException("0405");
			}
			fuelfeegrade.setUpdatetime(new Date());
		}
		return fuelfeegradeDao.getEntityManager().merge(fuelfeegrade);
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean delFuelfeegrade(Fuelfeegrade fuelfeegrade) {
		Fuelfeegrade ff = (Fuelfeegrade) fuelfeegradeDao.get(
				Fuelfeegrade.class, fuelfeegrade.getId());
		List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
		filters.clear();
		filters.add(new PropertyFilter("EQL_t!fuelfeegradeid", fuelfeegrade
				.getId()));
		List<Fuelfeegradeapply> fplist = fuelfeegradeDao
				.qryFuelfeegradeapply(filters);
		for (Fuelfeegradeapply fp : fplist) {
			fuelfeegradeDao.delete(fp);
		}
		filters.clear();
		filters.add(new PropertyFilter("EQL_t!fuelfeegradeid", fuelfeegrade
				.getId()));
		List<Fuelfeegradedetail> fflist = fuelfeegradeDao
				.qryFuelfeegradedetail(filters);
		for (Fuelfeegradedetail fd : fflist) {
			fuelfeegradeDao.delete(fd);
		}
		fuelfeegradeDao.delete(ff);
		return true;
	}

	@Override
	public List<Map<String, Object>> qryFuelfeegradedetail(long fuelfeegradeid) {
		return ListUtil.listToMap(new Object[] { Fuelfeegradedetail.class,
				"createname", "updatename" },
				fuelfeegradeDao.qryFuelfeegradedetail(fuelfeegradeid),
				new Object[] { Fuelfeegradedetail.class, String.class,
						String.class });
	}

	@Override
	public Fuelfeegradedetail saveFuelfeegradedetail(
			Fuelfeegradedetail fuelfeegradedetail) throws ServiceException {
		if (fuelfeegradeDao.isExistFuelfeegradedetail(fuelfeegradedetail)) {
			// 营运里程不能交叉！
			throw new ServiceException("0406");
		}
		if (fuelfeegradedetail.getId() == 0) {
			fuelfeegradedetail.setCreatetime(new Date());
			fuelfeegradedetail.setUpdatetime(new Date());
			fuelfeegradedetail.setUpdateby(fuelfeegradedetail.getCreateby());
		} else {
			fuelfeegradedetail.setUpdatetime(new Date());
		}
		return fuelfeegradeDao.getEntityManager().merge(fuelfeegradedetail);
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean delFuelfeegradedetail(Fuelfeegradedetail fuelfeegradedetail) {
		Fuelfeegradedetail ff = (Fuelfeegradedetail) fuelfeegradeDao.get(
				Fuelfeegradedetail.class, fuelfeegradedetail.getId());
		fuelfeegradeDao.delete(ff);
		return true;
	}

	@Override
	public List<Map<String, Object>> qryFuelfeegradeapply(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "id", "fuelfeegradeid",
				"fromdate", "todate", "routeid", "createby", "createtime",
				"updateby", "updatetime", "createname", "updatename",
				"routename", "grade", "vehicletypename", "vehicletypeid" },
				fuelfeegradeDao.qryFuelfeegradeapplys(propertyFilterList),
				new Object[] { Long.class, Long.class, Date.class, Date.class,
						Long.class, Long.class, Timestamp.class, Long.class,
						Timestamp.class, String.class, String.class,
						String.class, String.class, String.class, Long.class });
	}

	@Override
	public Fuelfeegradeapply saveFuelfeegradeapply(
			Fuelfeegradeapply fuelfeegradeapply) throws ServiceException {
		if (fuelfeegradeDao.isExistFuelfeegradeapply(fuelfeegradeapply)) {
			// 应用日期不能交叉！
			throw new ServiceException("0407");
		}
		if (fuelfeegradeapply.getId() == 0) {
			fuelfeegradeapply.setCreatetime(new Date());
			fuelfeegradeapply.setUpdatetime(new Date());
			fuelfeegradeapply.setUpdateby(fuelfeegradeapply.getCreateby());
		} else {
			fuelfeegradeapply.setUpdatetime(new Date());
		}
		return fuelfeegradeDao.getEntityManager().merge(fuelfeegradeapply);
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean delFuelfeegradeapply(Fuelfeegradeapply fuelfeegradeapply) {
		Fuelfeegradeapply ff = (Fuelfeegradeapply) fuelfeegradeDao.get(
				Fuelfeegradeapply.class, fuelfeegradeapply.getId());
		fuelfeegradeDao.delete(ff);
		return true;
	}

	@Override
	public List<Map<String, Object>> qryRoutes(long orgid) {
		return ListUtil.listToMap(new Object[] { "selected", "id", "name",
				"jianpin" }, fuelfeegradeDao.qryRoutes(orgid), new Object[] {
				boolean.class, long.class, String.class, String.class });
	}
}
