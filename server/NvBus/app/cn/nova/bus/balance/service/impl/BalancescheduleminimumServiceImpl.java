package cn.nova.bus.balance.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.dao.BalancescheduleminimumDao;
import cn.nova.bus.balance.model.Balancescheduleminimum;
import cn.nova.bus.balance.service.BalancescheduleminimumService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("unchecked")
public class BalancescheduleminimumServiceImpl implements
		BalancescheduleminimumService {

	
	private BalancescheduleminimumDao dao = new BalancescheduleminimumDao();

	@Override
	public boolean save(Balancescheduleminimum turnover) {
		if (turnover.getId() == 0) {
			return dao.save(turnover);
		} else {
			return dao.update(turnover);
		}
	}

	@Override
	public boolean delete(Balancescheduleminimum turnover) {
		if (turnover != null) {
			return dao.del(turnover);
		} else {
			return false;
		}
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Balancescheduleminimum.class, id);
	}

	@Override
	public List<Balancescheduleminimum> query() {
		return dao.query(Balancescheduleminimum.class, null);
	}

	@Override
	public Balancescheduleminimum getById(Long id) {
		return (Balancescheduleminimum) dao.get(Balancescheduleminimum.class,
				id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Balancescheduleminimum.class,
				"createname", "updatename", "vehicleno", "schedulename" },
				dao.query(propertyFilterList), new Object[] {
						Balancescheduleminimum.class, String.class,
						String.class, String.class, String.class });
	}

	@Override
	public Date getdepartdate(Long id) {
		return dao.getdepartdate(id);
	}

}
