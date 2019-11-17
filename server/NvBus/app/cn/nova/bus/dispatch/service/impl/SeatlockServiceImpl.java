package cn.nova.bus.dispatch.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.service.SeatlockService;
import cn.nova.bus.sale.model.Seatlock;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;

@SuppressWarnings("deprecation")

public class SeatlockServiceImpl implements SeatlockService {

	
	private IDAO<Seatlock> dao = new EntityManagerDaoSurport<Seatlock>();

	@Override
	public boolean save(Seatlock seatlock) {
		if (seatlock.getScheduleid() == 0) {
			return dao.save(seatlock);
		} else {
			return dao.update(seatlock);
		}
	}

	@Override
	public boolean delete(Seatlock schedulestatus) {
		return dao.delete(schedulestatus);
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Seatlock.class, id);
	}

	@Override
	public List<Seatlock> query() {
		return dao.query(Seatlock.class, null);
	}

	@Override
	public Seatlock getById(Long id) {
		return dao.get(Seatlock.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return null;
	}

}
