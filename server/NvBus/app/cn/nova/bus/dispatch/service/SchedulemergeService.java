package cn.nova.bus.dispatch.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.dispatch.model.Schedulemerge;
import cn.nova.bus.dispatch.model.Schedulestatuslog;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

public interface SchedulemergeService {

	public Schedulemerge save(Schedulemerge schedulemerge,
			Schedulestatuslog statuslog, String oldseats, String newseats)
			throws ServiceException;

	public boolean delete(Schedulemerge schedulemerge);

	public boolean delete(Long id);

	public List<Schedulemerge> query();

	public Schedulemerge getById(Long id);

	/**
	 * 查询并班信息
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList);

	public Schedulemerge getByplanid(Long scheduleplanid);

	public boolean equals(Long oldschedleid, Long newscheduleid);

	public boolean isContain(Schedulemerge schedulemerge);

	public boolean hasSeatnum(Schedulemerge schedulemerge);

	public boolean isbegincheck(Long scheduleplanid);

	public boolean isTicketpriceUniqe(Schedulemerge schedulemerge);

	public boolean isTimeout(Long scheduleplanid, Date departdate);

	public boolean isdeparted(Long scheduleplanid);

	public List<Map<String, Object>> queryScheduleplan(
			List<PropertyFilter> buildFromHttpRequest);

}
