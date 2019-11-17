/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.check.service<br/>
 * <b>文件名：</b>VehicledistanceactiveService.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b> 2013-5  <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.check.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.check.model.Vehicledistanceactive;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;

/**
 * <b>类描述：车辆行驶里程管理</b><br/>
 * <b>类名称：</b>VehicledistanceactiveService.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b>2013-5-3  <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface VehicledistanceactiveService {

	/**
	 * 查询车辆最后一次激活记录，在主页面显示。
	 * @param startdate
	 * @param enddate
	 * @param vehicleid
	 * @param userid
	 * @param orgid
	 * @return
	 */
	public List<Map<String, Object>> queryLastActive(Date startdate,Date enddate,long vehicleid,long userid,long orgid);
	
	/**
	 * 查询历史激活记录
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryHistoryActive(List<PropertyFilter> propertyFilterList);
	
	/**
	 * 查询车辆已发班里程，二维有效期，用于安检和报到，如果达到日期限制或里程限制给出相应提示
	 * @param vehicleid
	 * @param orgid
	 * @param iscomparedate: true比较里程，false比较二维有效期
	 * @return
	 * @throws ServiceException
	 */
	public String qryVheicledistiance(long vehicleid,long orgid,boolean iscomparedate) throws ServiceException;
	
	/**
	 * 激活车辆里程限制，如果起开而有效期起限制也同时修改车辆二维日期，加上系统设置的天数
	 * @param v
	 * @return
	 */
	public Vehicledistanceactive saveVehicledistanceactive(Vehicledistanceactive v) ;
}
