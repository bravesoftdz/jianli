/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.dispatch.service<br/>
 * <b>文件名：</b>ScheduleplusService.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2011-7-11-下午02:15:36<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.dispatch.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>ScheduleplusService<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */
public interface ScheduleplusService {
	// 查询加班班次信息
	public List<Map<String, Object>> qryScheduleplus(
			List<PropertyFilter> propertyFilterList);

	// 班次加班
	public long Scheduleplus(long scheduleid, Date startdate, Date enddate,
			Schedule schedule, long unitid, long vehicletypeid, long vehicleid,
			long vehiclebrandmodelid, String ip) throws ServiceException;

	// 查询同线路的其他班次
	public List<Map<String, Object>> qryOtherSchedule(long routeid);

	// 查询班次的循环车型信息
	public List<Map<String, Object>> qryScheduleCycle(long scheduleid);

	public boolean updateSchedulestop(long scheduleid, String schedulestopids,
			long updateby) throws ServiceException;

	public List<Map<String, Object>> qrySchedulestation(long scheduleid)
			throws ServiceException;

	// 按照班次计划进行班次加班
	public long Scheduleplus(long scheduleplanid, Date startdate, Date enddate,
			Schedule schedule, long vehiclebrandmodelid,long unitid,  long vehicleid,
			String ip, long balanceformulaid,int delayminute,int status,boolean issellstopstation,
			long balancedeductitemid,boolean isreport,short planseatnums
			) throws ServiceException;
	
	//根据线路ID自动生成班次号
	public String genSchCode(long routeid, Date startdate, Date enddate);
	
	
	// 线路班次加班
	public long ScheduleRouteplus(long routeid,Date startdate, Date enddate,
			Schedule schedule,long vehiclebrandmodelid, String ip, short planseatnums) throws ServiceException;

}
