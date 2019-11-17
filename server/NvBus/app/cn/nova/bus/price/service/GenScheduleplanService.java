package cn.nova.bus.price.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleplanlog;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;

public interface GenScheduleplanService {
	// 生成营运计划
	public List<Map<String, Object>> generateScheduleplan(
			Scheduleplanlog scheduleplanlog) throws ServiceException;

	// 查询营运计划
	public List<Map<String, Object>> qryScheduleplan(
			List<PropertyFilter> propertyFilterList);

	// 查询票价信息
	public List<Map<String, Object>> qryTicketprice(Scheduleplan scheduleplan);

	// 查询票价分项信息
	public List<Map<String, Object>> qryTicketpriceitem(long ticketpriceid,
			String tickettype);

	// 查询班次座位图
	public List<Map<String, Object>> qryScheduleseats(Scheduleplan scheduleplan);

	// 实现营运计划的按天生成
	public MethodResult genScheduleplan(Scheduleplanlog scheduleplanlog,
			Schedule schedule, Date departdate) throws ServiceException;

	// 加班班次的营运计划生成
	public List<Map<String, Object>> generateOvertimeplan(
			Scheduleplanlog scheduleplanlog) throws ServiceException;
	
	// 由作业生成生成营运计划
	public void autoGenerateScheduleplanold();
	
	// 查询同线路的所有班次（包括未过期的加班班次）
	public List<Map<String, Object>> qrySchedules(long routeid) throws ServiceException;
	
	// 由作业生成生成营运计划
	public void autoGenerateScheduleplan();
	
}
