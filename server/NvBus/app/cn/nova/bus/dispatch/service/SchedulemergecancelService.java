package cn.nova.bus.dispatch.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.dispatch.model.Schedulemergecancel;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface SchedulemergecancelService {

	public boolean save(Schedulemergecancel schedulemergecancel, Long oldscheduleplanid) throws ServiceException;

	public boolean delete(Schedulemergecancel schedulemergecancel);

	public boolean delete(Long id);

	public List<Schedulemergecancel> query();

	public Schedulemergecancel getById(Long id);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

	public Schedulemergecancel getBymergeid(Long scheduleplanid);

	public boolean isExist(Long schedulemergeid);

	public Long findSchedulemergecancelid();

}
