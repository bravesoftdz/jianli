package cn.nova.bus.base.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Schedulediscount;
import cn.nova.bus.base.model.Schedulevipdiscount;
import cn.nova.utils.orm.PropertyFilter;

public interface SchedulediscountService {

	public Schedulediscount save(Schedulediscount count,
			List<Schedulevipdiscount> schedulevipdiscounts, String scheduleid,
			String ip);

	public boolean delete(Schedulediscount count);

	public boolean delete(Long id);

	public List<Schedulediscount> query();

	public Schedulediscount getById(Long id);

	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList);

	public Long getSeheduleid(String routeid, String helpcode);

	public Long getSchedulediscountId();

	public Long getId(Long scheduleid, Date startdate, Date enddate);

	public List<Map<String, Object>> queryvipdiscount(
			List<PropertyFilter> propertyFilterList, Long id);

}
