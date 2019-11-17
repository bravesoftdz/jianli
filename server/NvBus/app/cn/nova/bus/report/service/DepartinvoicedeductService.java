/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.report.service<br/>
 * <b>文件名：</b>DepartinvoicedeductService.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b> 2012-4-25 下午04:39:41 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.utils.orm.PropertyFilter;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>DepartinvoicedeductService.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-4-25 下午04:39:41	<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface DepartinvoicedeductService {

	/**
	 * 查询固定扣费项目
	 * @param startdate
	 * @param enddate
	 * @param orgid
	 * @param printorgid
	 * @return
	 */
	List<Map<String, Object>> queryDeduct(Date startdate, Date enddate,
			String orgid, Long printorgid);

	/**
	 * 车辆结算汇总查询
	 * @param buildFromHttpRequest
	 * @return
	 */
	List<Map<String, Object>> queryVehicleDepartinvoices(
			List<PropertyFilter> buildFromHttpRequest,String balancetypeflag,String orgid);

	/**
	 * 客运结算统计表
	 * @param orgids
	 * @param routeid
	 * @param vehicleid
	 * @param startdate
	 * @param enddate
	 * @return
	 */
	List<Map<String, Object>> queryDepartinvoices(String orgids, Long routeid,
			Long vehicleid, Date startdate, Date enddate);
	
	/**
	 * 线路结算汇总表
	 * @param buildFromHttpRequest
	 * @return
	 */
	List<Map<String, Object>> routebalancereport(
			List<PropertyFilter> buildFromHttpRequest);
}
