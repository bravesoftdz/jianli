package cn.nova.bus.bill.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.bill.dao.BilllogDao;
import cn.nova.bus.bill.model.Billlog;
import cn.nova.bus.bill.service.BilllogService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * @author 蒋伟
 * 
 */

public class BilllogServiceImpl implements BilllogService {

	private BilllogDao dao = new BilllogDao();

	@Override
	public Billlog save(Billlog billlog) {
		if (billlog.getId() <= 0) {
			return dao.merge(billlog);
		} else {
			return dao.merge(billlog);
		}
	}

	@Override
	public Billlog findById(Long id) {
		return dao.get(Billlog.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Billlog.class, "typename",
				"operator", "logname" }, dao.query(propertyFilterList),
				new Object[] { Billlog.class, String.class, String.class,
						String.class });
	}

}
