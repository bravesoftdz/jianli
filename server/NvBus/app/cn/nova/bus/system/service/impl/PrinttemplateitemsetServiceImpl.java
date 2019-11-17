package cn.nova.bus.system.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.dao.PrinttemplateitemsetDao;
import cn.nova.bus.system.model.Printtemplateitemset;
import cn.nova.bus.system.service.PrinttemplateitemsetService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;


public class PrinttemplateitemsetServiceImpl implements
		PrinttemplateitemsetService {

	
	private PrinttemplateitemsetDao printtemplateitemsetDao = new PrinttemplateitemsetDao();

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Printtemplateitemset.class,
				"itemname", "vehicleno", "createdname", "updatedname",
				"templatename", "printtemplatetypeid" },
				printtemplateitemsetDao
						.qryPrinttemplateitemset(propertyFilterList),
				new Object[] { Printtemplateitemset.class, String.class,
						String.class, String.class, String.class, String.class,
						Long.class });
	}

	@Override
	public Printtemplateitemset save(Printtemplateitemset printtemplateitemset)
			throws ServiceException {
		if (printtemplateitemsetDao
				.isExistPrinttemplateitemset(printtemplateitemset)) {
			// 该车辆该项目的打印设置已经添加！
			throw new ServiceException("0306");
		}
		return printtemplateitemsetDao.getEntityManager().merge(
				printtemplateitemset);
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean delete(long id) {
		Printtemplateitemset pi = (Printtemplateitemset) printtemplateitemsetDao
				.get(Printtemplateitemset.class, id);
		return printtemplateitemsetDao.delete(pi);
	}

	@Override
	public List<Map<String, Object>> query(long orgid, long vehicleid,
			String templatename) {
		return ListUtil
				.listToMap(new Object[] { "itemcode" },
						printtemplateitemsetDao.qryPrinttemplateitemset(orgid,
								vehicleid, templatename),
						new Object[] { String.class });
	}

}
