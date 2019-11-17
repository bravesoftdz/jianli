/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.dispatch.service.impl<br/>
 * <b>文件名：</b>VehiclelostServiceImpl.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2011-6-28-下午01:40:47<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.dispatch.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import cn.nova.bus.dispatch.dao.VehiclelostDao;
import cn.nova.bus.dispatch.model.Vehiclelost;
import cn.nova.bus.dispatch.service.VehiclelostService;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>VehiclelostServiceImpl<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>O
 * <b>修改人：</b><br/>
 * 
 */
public class VehiclelostServiceImpl implements VehiclelostService {

	
	private VehiclelostDao vehiclelostDao = new VehiclelostDao();
	/*
	 * getVehiclelosts方法：<br/> <br/>
	 * 
	 * @param fromdepart
	 * 
	 * @param enddepart
	 * 
	 * @param vehicleids
	 * 
	 * @return
	 * 
	 * @see
	 * cn.nova.bus.dispatch.service.VehiclelostService#getVehiclelosts(java.
	 * util.Date, java.util.Date, java.lang.String)
	 * 
	 * @exception
	 */
	@Override
	public List<Vehiclelost> getVehiclelosts(Date fromdepart, Date enddepart,
			String vehicleids) {
		// 根据发车日期段、车辆ID,如：(12,45), 获取车辆脱班信息
		return vehiclelostDao.qryVehiclelost(fromdepart,enddepart,vehicleids);
	}
	/* getVehiclelostDeduct方法：<br/>
	 * <br/>
	 * @param fromdepart
	 * @param enddepart
	 * @param vehicleids
	 * @return 
	 * @see cn.nova.bus.dispatch.service.VehiclelostService#getVehiclelostDeduct(java.util.Date, java.util.Date, java.lang.String)
	 * @exception 
	 */
	@Override
	public BigDecimal getVehiclelostDeduct(Date fromdepart, Date enddepart,
			String vehicleids) {
		return vehiclelostDao.qryVehiclelostDeduct(fromdepart,enddepart,vehicleids);
	}
	@Override
	public Object[] qryScheduleLostTreatment(Date fromdepart, Date todepart,
			String vehicleids, String schedulestatus) {
		return vehiclelostDao.qryScheduleLostTreatment(fromdepart,todepart,vehicleids,schedulestatus);
		
	}

}
