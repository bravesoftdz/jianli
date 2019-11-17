package cn.nova.bus.pack.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.dao.PackfeeDao;
import cn.nova.bus.pack.model.Packfee;
import cn.nova.bus.pack.model.Packfeetype;
import cn.nova.bus.pack.service.PackfeeService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

public class PackfeeServiceImpl implements PackfeeService {
	
	
	private PackfeeDao packfeeDao = new PackfeeDao();

	@Override
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters) {
		return ListUtil.listToMap(new Object[]{Packfee.class,"orgname", "pricetype"}, packfeeDao.query(propertyFilters),new Object[]{Packfee.class,String.class,
			 String.class});
	}

	@SuppressWarnings("unchecked")
	@Override
	public Packfee savePackfee(Packfee packfee) throws ServiceException {
		if (packfeeDao.isExistformDistanceWeight(packfee)) {
			throw new ServiceException("0443");
		}
		if (packfee.getId() == 0) {
			packfeeDao.save(packfee);
		} else {
			packfeeDao.getEntityManager().merge(packfee);
		}
		return packfee;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean deletePackfee(Packfee packfee, long userid)
			throws ServiceException {
		packfeeDao.del(packfee);
		return true;
	}

	@Override
	public List<Map<String, Object>> query() {
		return ListUtil.listToMap(new Object[]{Packfee.class,"orgname", "pricetype"}, packfeeDao.query(),new Object[]{Packfee.class,String.class,
			 String.class});
	}

}
