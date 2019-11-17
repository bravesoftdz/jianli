/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.balance.service<br/>
 * <b>文件名：</b>Vehicleviolation.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-9-11 下午05:02:48<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.balance.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.model.Vehicleviolation;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>Vehicleviolation.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-9-11 下午05:02:48<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface VehicleviolationService {

	public Long save(Vehicleviolation vehicleviolation, Global global) throws ServiceException;

	public boolean delete(Long id) throws ServiceException;

	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList);

	/**
	 * @param vehicleviolation
	 * @param global
	 */
	public long processVehicleviolation(Vehicleviolation vehicleviolation,
			Global global) throws ServiceException ;

	/**
	 * @param vehicleid
	 * @return
	 */
	public String getRoutename(long vehicleid);

}
