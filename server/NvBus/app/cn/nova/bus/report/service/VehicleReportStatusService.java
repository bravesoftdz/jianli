/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.report.service<br/>
 * <b>文件名：</b>VehicleReportStatusService.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-8-29 下午01:51:48<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>VehicleReportStatusService.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-8-29 下午01:51:48<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface VehicleReportStatusService {

	/**
	 * 车辆报班情况一览表
	 * 
	 * @param departdate
	 * @param orgid
	 * @return
	 */
	List<Map<String, Object>> queryVehicleReportStatus(Date departdate,
			String orgid, String reportway);

	/**
	 * 车辆售票流量统计
	 * 
	 * @param orgid
	 * @param departstation
	 * @param departdate
	 * @param routeid
	 * @param unitid
	 * @param vehicletypeid
	 * @param stationid
	 * @param scheduleid
	 * @param enddate
	 * @param isEmpty
	 * @return
	 */
	List<Map<String, Object>> queryVehicleTicketCount(String orgid,
			long departstation, Date departdate, long routeid, long unitid,
			long vehicletypeid, long stationid, long scheduleid, Date enddate,
			String sellorgid, Date selldate, Date sellenddate, Boolean isEmpty);

}
