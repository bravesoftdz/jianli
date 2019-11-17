package cn.nova.bus.checkticket.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.checkticket.dao.RoutechecktimeDao;
import cn.nova.bus.checkticket.model.Routechecktime;
import cn.nova.bus.checkticket.service.RoutechecktimeService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

public class RoutechecktimeServiceImpl implements RoutechecktimeService{

	private RoutechecktimeDao dao = new RoutechecktimeDao();
	
	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[]{Routechecktime.class,
				"routename","orgname","createname","updatename"},
				dao.query(propertyFilterList),
				new Object[]{Routechecktime.class, String.class, String.class, String.class, String.class} );
	}

	@SuppressWarnings("unchecked")
	@Override
	public Routechecktime findById(Long id) {
		return (Routechecktime) dao.get(Routechecktime.class, id);
	}

	@Override
	public Long getRoutechecktimeId(Long orgid, Long routeid) {
		return dao.getRoutechecktimeId(orgid, routeid);
	}

	@SuppressWarnings("unchecked")
	@Override
	public Routechecktime save(Routechecktime routechecktime){
		return (Routechecktime) dao.merge(routechecktime);
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean delete(Long id) {
		return dao.delete(Routechecktime.class, id);
	}

	@Override
	public long getRoutechecktimeId(long routeid) {
		// TODO Auto-generated method stub
		return dao.qryRoutechecktime(routeid);
	}

}
