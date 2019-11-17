/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.dispatch.service<br/>
 * <b>文件名：</b>VehiclelostService.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2011-6-28-下午01:36:23<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.dispatch.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import cn.nova.bus.dispatch.model.Vehiclelost;

/**
 * <b>类描述：车辆脱班服务接口</b><br/>
 * <b>类名称：</b>VehiclelostService<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */
public interface VehiclelostService {
	// 根据发车日期段、车辆ID,如：(12,45), 获取车辆脱班信息
	public List<Vehiclelost> getVehiclelosts(Date fromdepart, Date enddepart,
			String vehicleids);
	
	// 根据发车日期段、车辆ID,如：(12,45), 获取车辆脱班信息
	public BigDecimal getVehiclelostDeduct(Date fromdepart, Date enddepart,
			String vehicleids);

	/**
	 * 获取班次晚点脱班插件中的罚金   
	 * @param fromdepart
	 * @param todepart
	 * @param vehicleids
	 */
	public Object[] qryScheduleLostTreatment(Date fromdepart, Date todepart,
			String vehicleids, String schedulestatus);
}
