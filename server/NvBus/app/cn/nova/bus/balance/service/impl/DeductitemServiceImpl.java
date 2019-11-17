package cn.nova.bus.balance.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.dao.DeductitemDao;
import cn.nova.bus.balance.model.Deductitem;
import cn.nova.bus.balance.model.Deductroutestop;
import cn.nova.bus.balance.service.DeductitemService;
import cn.nova.bus.base.model.Route;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.model.Printtemplatetype;
import cn.nova.bus.system.model.Printtemplatetypeitem;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;


public class DeductitemServiceImpl implements DeductitemService {


	private DeductitemDao deductitemDao = new DeductitemDao();

	@SuppressWarnings("unchecked")
	@Override
	public Deductitem saveDeductitem(Deductitem deductitem)
			throws ServiceException {
		List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
		filters.clear();
		List<Deductitem> dlist = new ArrayList<Deductitem>();
		if (deductitem.getId() > 0) {
			filters.add(new PropertyFilter("EQS_d!name", deductitem.getName()));
			filters.add(new PropertyFilter("EQL_d!orgid", deductitem.getOrgid()));
			filters.add(new PropertyFilter("NOEQL_d!id", deductitem.getId()));
			dlist = deductitemDao.qryDeductitem(filters);
			if (dlist != null && dlist.size() > 0) {
				// 该扣费项目名称已经存在，请重新输入！
				throw new ServiceException("0146");
			}
			filters.add(new PropertyFilter("EQS_d!code", deductitem.getCode()));
			filters.add(new PropertyFilter("EQL_d!orgid", deductitem.getOrgid()));
			filters.add(new PropertyFilter("NOEQL_d!id", deductitem.getId()));
			dlist = deductitemDao.qryDeductitem(filters);
			if (dlist != null && dlist.size() > 0) {
				// 该扣费项目编码已经存在，请重新输入！
				throw new ServiceException("0427");
			}
		} else {
			filters.add(new PropertyFilter("EQS_d!name", deductitem.getName()));
			filters.add(new PropertyFilter("EQL_d!orgid", deductitem.getOrgid()));
			dlist = deductitemDao.qryDeductitem(filters);
			if (dlist != null && dlist.size() > 0) {
				// 该扣费项目名称已经存在，请重新输入！
				throw new ServiceException("0146");
			}
			filters.add(new PropertyFilter("EQS_d!code", deductitem.getName()));
			filters.add(new PropertyFilter("EQL_d!orgid", deductitem.getOrgid()));
			dlist = deductitemDao.qryDeductitem(filters);
			if (dlist != null && dlist.size() > 0) {
				// 该扣费项目编码已经存在，请重新输入！
				throw new ServiceException("0427");
			}
		}
		if(deductitem.isIsprintitem()){
			Printtemplatetype ptmp=	deductitemDao.qryPrinttemplatetype("运量结算单");
			if(ptmp!=null){
				if(!deductitemDao.qryPrinttemplatetypeitem(ptmp.getId(),deductitem.getName(),deductitem.getCode())){
					Printtemplatetypeitem pti=new Printtemplatetypeitem();
					pti.setIslist(false);
					pti.setItemcode(deductitem.getCode());
					pti.setItemname(deductitem.getName());
					pti.setItemtype("0");
					pti.setPrinttemplatetype(ptmp);
					deductitemDao.merge(pti);
				}
			}
		}
		return (Deductitem) deductitemDao.merge(deductitem);
	}

	@Override
	public List<Map<String, Object>> qryDeductitem(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Deductitem.class,
				"createname", "updatename", "orgname" },
				deductitemDao.qryDeductitems(propertyFilterList), new Object[] {
						Deductitem.class, String.class, String.class,
						String.class });
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean delDeductitem(Deductitem deductitem) throws ServiceException {
		Deductitem di = (Deductitem) deductitemDao.get(Deductitem.class,
				deductitem.getId());
		if (di != null) {
			if (deductitemDao.qryDeductitemByCode(di.getOrgid(), di.getCode())) {
				// 该扣费项目已被使用，不允许删除！
				throw new ServiceException("0152");
			}
			di.setUpdateby(deductitem.getUpdateby());
			di.setUpdatetime(new Date());
			di.setIsactive(false);
			deductitemDao.merge(di);
		}
		return true;
	}

	// 查询扣费信息
	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> qryStationDeduct(long routeid) {
		Route route = (Route) deductitemDao.get(Route.class, routeid);
		List<Deductitem> dtlist = deductitemDao.qryDeductitem(route.getOrgid());
		List<Object> odlist = deductitemDao.qryDeducts(routeid);
		List<Object> sslist = deductitemDao.qryStationStop(routeid);
		List<Object> list = new ArrayList<Object>();
		Object[] newObject = new Object[2 + dtlist.size()];
		for (Object objs : sslist) {
			newObject = new Object[2 + dtlist.size()];
			Object[] obj = (Object[]) objs;
			newObject[0] = obj[0];
			newObject[1] = obj[1];
			for (int i = 2; i < dtlist.size() + 2; i++) {
				newObject[i] = 0;
			}
			list.add(newObject);
		}
		for (Object objs : odlist) {
			Object[] obj = (Object[]) objs;
			long stationid = new Long(obj[0].toString());
			long deductitemid = new Long(obj[1].toString());
			for (Object stobjs : list) {
				Object[] stobj = (Object[]) stobjs;
				long curstationid = new Long(stobj[0].toString());
				if (stationid == curstationid) {
					int i = 2;
					for (Deductitem dt : dtlist) {
						if (dt.getId() == deductitemid) {
							stobj[i] = obj[2];
						}
						i++;
					}
				}
			}
		}
		Object[] field = new Object[2 + dtlist.size()];
		Object[] fieldType = new Object[2 + dtlist.size()];

		field[0] = "stationid";
		field[1] = "到站";
		int i = 2;
		for (Deductitem dt : dtlist) {
			field[i] = dt.getName();
			i++;
		}
		fieldType[0] = Long.class;
		fieldType[1] = String.class;
		for (i = 0; i < dtlist.size(); i++) {
			fieldType[i + 2] = BigDecimal.class;
		}
		newObject = new Object[2 + dtlist.size()];
		for (i = 0; i < dtlist.size() + 2; i++) {
			newObject[i] = i + "";
		}
		list.add(newObject);
		return ListUtil.listToMap(field, list, fieldType);
	}

	// 批量保存线路停靠点扣费信息
	@SuppressWarnings("unchecked")
	@Override
	public boolean saveStationDeduct(List<Deductroutestop> drlist) {
		List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
		if (drlist == null || drlist.size() == 0) {
			return false;
		}
		Route route = (Route) deductitemDao.get(Route.class, drlist.get(0)
				.getRouteid());
		Map<String, Long> itemmap = new HashMap<String, Long>();
		for (Deductroutestop dr : drlist) {
			Deductitem dd = deductitemDao.qryDeductitem(route.getOrgid(),
					dr.getDeductname());
			if ((dd != null) && !itemmap.containsKey(dd.getName())) {
				itemmap.put(dd.getName(), dd.getId());
			}
		}
		for (Deductroutestop dr : drlist) {
			filters.clear();
			// System.out.println(dr.getDeductname() + "=" +
			// dr.getDeductmoney());
			filters.add(new PropertyFilter("EQL_dt!deductitemid", itemmap
					.get(dr.getDeductname())));
			filters.add(new PropertyFilter("EQL_dt!routeid", route.getId()));
			filters.add(new PropertyFilter("EQL_dt!stationid", dr
					.getStationid()));
			List<Deductroutestop> dlist = deductitemDao.qryDeducts(filters);
			if (dlist != null && dlist.size() > 0) {
				Deductroutestop ds = dlist.get(0);
				ds.setDeductmoney(dr.getDeductmoney());
				ds.setUpdateby(dr.getCreateby());
				ds.setUpdatetime(new Date());
				deductitemDao.merge(ds);
			} else {
				if(dr.getDeductmoney().compareTo(new BigDecimal(0))>0){
					Deductroutestop ds = new Deductroutestop();
					ds.setCreateby(dr.getCreateby());
					ds.setCreatetime(new Date());
					ds.setDeductitemid(itemmap.get(dr.getDeductname()));
					ds.setDeductmoney(dr.getDeductmoney());
					ds.setRouteid(route.getId());
					ds.setStationid(dr.getStationid());
					ds.setUpdateby(dr.getCreateby());
					ds.setUpdatetime(new Date());
					deductitemDao.merge(ds);
				}				
			}
		}
		return true;
	}

	@Override
	public List<Map<String, Object>> qryRouteDeduct(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] {"id", "routeid", "routename",
				"stationname", "itemname", "deductmoney", "createname",
				"createtime", "updatename", "updatetime" },
				deductitemDao.qryDeductroutestop(propertyFilterList),
				new Object[] { long.class,long.class, String.class, String.class,
						String.class, BigDecimal.class, String.class,
						Timestamp.class, String.class, Timestamp.class });
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean delDeductroutestop(Deductroutestop deductroutestop)
			throws ServiceException {
		Deductroutestop di = (Deductroutestop) deductitemDao.get(Deductroutestop.class,
				deductroutestop.getId());
		if (di != null) {
			return deductitemDao.delete(di);
		}
		return false;
	}

}
