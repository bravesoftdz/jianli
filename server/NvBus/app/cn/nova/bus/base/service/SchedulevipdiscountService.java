package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Schedulevipdiscount;
import cn.nova.utils.orm.PropertyFilter;

public interface SchedulevipdiscountService {

	public Schedulevipdiscount save(Schedulevipdiscount vipdiscount);

	public boolean delete(Schedulevipdiscount vipdiscount);

	public boolean delete(Long id);

	public List<Schedulevipdiscount> query();

	public boolean isExist(Long discountid, String vipgrade);

	public String getVipgrade(Long id);

	public Long getdiscountid(Long id);
	
	public Schedulevipdiscount getByid(Long id);

	public List<Map<String, Object>> query(List<PropertyFilter> buildFromHttpRequest);

}
