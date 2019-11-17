/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.base.service<br/>
 * <b>文件名：</b>ScheduleseatreserveService.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2011-8-9-下午05:48:04<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Scheduleseatreserve;
import cn.nova.bus.exception.ServiceException;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>ScheduleseatreserveService<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */
public interface ScheduleseatreserveService {
	
	public List<Map<String, Object>> qryScheduleVehiclebrandmodel(long scheduleid);
	
	public List<Map<String, Object>> qryScheduleseatreserve(long scheduleid)
			throws ServiceException;

	public Scheduleseatreserve saveScheduleseatreserve(
			Scheduleseatreserve scheduleseatreserve,boolean issameroute) throws ServiceException;

	public boolean delScheduleseatreserve(
			Scheduleseatreserve scheduleseatreserve) throws ServiceException;

}
