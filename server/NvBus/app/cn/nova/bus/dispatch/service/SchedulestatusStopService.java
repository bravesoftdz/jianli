/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.dispatch.service<br/>
 * <b>文件名：</b>SchedulestatusStop.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2011-9-18-上午11:21:52<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.dispatch.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.dispatch.model.Schedulecancel;
import cn.nova.bus.dispatch.model.Vehiclelost;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Scheduleplanlog;

/**
 * <b>类描述：实现班次批量停班接口</b><br/>
 * <b>类名称：</b>SchedulestatusStop<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */
public interface SchedulestatusStopService {
	public List<Map<String, Object>> stopSchedule(
			Scheduleplanlog scheduleplanlog,Vehiclelost vehiclelost,Schedulecancel schedulecancel) throws ServiceException;
	
	public List<Map<String, Object>> updateSchedulestatus(
			Scheduleplanlog scheduleplanlog,Vehiclelost vehiclelost,Schedulecancel schedulecancel) throws ServiceException;
	
	public List<Map<String, Object>> saleTickets(
			Scheduleplanlog scheduleplanlog) throws ServiceException;
	
	/**
	 * 证件过期自动停班
	 */
	public void autoStopScheduleplan();
}
