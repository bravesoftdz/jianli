package cn.nova.bus.balance.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.dao.VehicleturnoverDao;
import cn.nova.bus.balance.model.Vehicleturnover;
import cn.nova.bus.balance.service.VehicleturnoverService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("unchecked")
public class VehicleturnoverServiceImpl implements VehicleturnoverService {


	private VehicleturnoverDao dao = new VehicleturnoverDao();

	@Override
	public Vehicleturnover save(Vehicleturnover turnover) {
		if (turnover.getId() == 0) {
			return (Vehicleturnover) dao.merge(turnover);
		} else {
			return (Vehicleturnover) dao.merge(turnover);
		}
	}

	@Override
	public boolean delete(Vehicleturnover turnover) {
		if (turnover != null) {
			return dao.del(turnover);
		} else {
			return false;
		}
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Vehicleturnover.class, id);
	}

	@Override
	public List<Vehicleturnover> query() {
		return dao.query(Vehicleturnover.class, null);
	}

	@Override
	public Vehicleturnover getById(Long id) {
		return (Vehicleturnover) dao.get(Vehicleturnover.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Vehicleturnover.class,
				"createname", "orgname", "updatename", "vehicleno",
				"receivername" }, dao.query(propertyFilterList), new Object[] {
				Vehicleturnover.class, String.class, String.class,
				String.class, String.class, String.class });
	}

	@Override
	public boolean vehicleidUnique(Long vehicleid) {
		if (dao.vehicleidUnique(vehicleid).isEmpty()) {
			return false;
		}
		return true;
	}

}
