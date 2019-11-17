package cn.nova.bus.pack.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.pack.dao.PackpointDao;
import cn.nova.bus.pack.model.Packfee;
import cn.nova.bus.pack.model.Packpoint;
import cn.nova.bus.pack.service.PackpointService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

public class PackpointServiceImpl implements PackpointService {

	private PackpointDao pointDao = new PackpointDao();
	
	@Override
	public List<Map<String, Object>> query() {
		return ListUtil.listToMap(new Object[]{Packpoint.class}, pointDao.query(),new Object[]{Packfee.class});
	}

	@Override
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList) {
			return ListUtil.listToMap(new Object[]{Packpoint.class}, pointDao.query(propertyFilterList),new Object[]{Packfee.class});
	}

	@Override
	public boolean delete(Packpoint p, long userid) {
		pointDao.delete(p);
		return true;
	}

	@Override
	public Packpoint savePackpoint(Packpoint p) {
		
		if(p.getId() == 0) {
			pointDao.save(p);
		}else {
			pointDao.getEntityManager().merge(p);
		}
		
		return p;
	}

}
