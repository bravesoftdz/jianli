/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.base.service<br/>
 * <b>文件名：</b>ViprechargeService.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-11-30 下午05:28:43<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.utils.orm.PropertyFilter;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>ViprechargeService.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-11-30 下午05:28:43<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface ViprechargeService {

	/**
	 * VIP充值明细查询
	 * @param buildFromHttpRequest
	 * @return
	 */
	List<Map<String, Object>> queryViprecharge(
			List<PropertyFilter> buildFromHttpRequest);

	/**
	 * VIP消费查询
	 * @param buildFromHttpRequest
	 * @return
	 */
	List<Map<String, Object>> queryVipconsume(
			List<PropertyFilter> buildFromHttpRequest);

	/**
	 * VIP购票汇总
	 * @param buildFromHttpRequest
	 * @return
	 */
	List<Map<String, Object>> qryVipsellticket(
			List<PropertyFilter> buildFromHttpRequest);

	/**
	 * @param propertyFilterList
	 * @return
	 * VIP消费明细查询
	 */
	List<Map<String, Object>> queryVipconsumeldetail(
			List<PropertyFilter> propertyFilterList);

}
