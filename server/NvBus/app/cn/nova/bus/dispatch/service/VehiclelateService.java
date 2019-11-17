/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.dispatch.service<br/>
 * <b>文件名：</b>VehiclelateService.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2011-6-28-上午10:31:12<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.dispatch.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import cn.nova.bus.dispatch.model.Vehiclelate;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;


/**
 * <b>类描述：车辆晚点处理接口服务</b><br/>
 * <b>类名称：</b>VehiclelateService<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */
public interface VehiclelateService {

	// 根据发车日期段、车辆ID,如：(12,45), 获取车辆脱班信息
	public List<Vehiclelate> qryVehiclelates(Date fromdepart, Date enddepart,
			String vehicleids);
	
	// 根据发车日期段、车辆ID,如：(12,45), 获取车辆脱班信息
	public BigDecimal qryVehiclelatesDeduct(Date fromdepart, Date enddepart,
			String vehicleids);
	
	public boolean schVehicleLater(long schedulestatusid,Global globa) throws ServiceException;
	
}
