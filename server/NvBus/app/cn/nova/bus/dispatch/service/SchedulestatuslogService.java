package cn.nova.bus.dispatch.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.dispatch.model.Schedulestatuslog;
import cn.nova.utils.orm.PropertyFilter;

public interface SchedulestatuslogService {

	public boolean save(Schedulestatuslog schedulestatuslog);

	public boolean delete(Schedulestatuslog schedulestatuslog);

	public boolean delete(Long id);

	public List<Schedulestatuslog> query();

	public Schedulestatuslog getById(Long id);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

	public Long getId(Long scheduleid, Date departdate);

	public Schedulestatuslog getSchedulestatuslog(Long scheduleid, Date departdate);

}
