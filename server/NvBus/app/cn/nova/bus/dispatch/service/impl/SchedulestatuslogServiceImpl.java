package cn.nova.bus.dispatch.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.dispatch.dao.SchedulestatuslogDao;
import cn.nova.bus.dispatch.model.Schedulestatuslog;
import cn.nova.bus.dispatch.service.SchedulestatuslogService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("unchecked")
public class SchedulestatuslogServiceImpl implements SchedulestatuslogService {

	
	private SchedulestatuslogDao dao = new SchedulestatuslogDao();

	@Override
	public boolean save(Schedulestatuslog schedulemergecancel) {
		if (schedulemergecancel.getId() == 0) {
			return dao.save(schedulemergecancel);
		} else {
			return dao.update(schedulemergecancel);
		}
	}

	@Override
	public boolean delete(Schedulestatuslog schedulestatus) {
		return dao.delete(schedulestatus);
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Schedulestatuslog.class, id);
	}

	@Override
	public List<Schedulestatuslog> query() {
		return dao.query(Schedulestatuslog.class, null);
	}

	@Override
	public Schedulestatuslog getById(Long id) {
		return (Schedulestatuslog) dao.get(Schedulestatuslog.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Schedulestatuslog.class,
				"schedulename" }, dao.query(propertyFilterList), new Object[] {
				Schedulestatuslog.class, String.class });
	}

	@Override
	public Long getId(Long scheduleid, Date departdate) {
		List<Schedulestatuslog> list = dao.getstatuslog(scheduleid, departdate);
		if (list.isEmpty()) {
			return (long) 0;
		}
		return list.get(0).getId();
	}

	@Override
	public Schedulestatuslog getSchedulestatuslog(Long scheduleid, Date departdate) {
		List<Schedulestatuslog> list = dao.getstatuslog(scheduleid, departdate);
		return list.get(0);  // dao.getSchedulestatuslog(scheduleid, departdate);
	}
	
}
