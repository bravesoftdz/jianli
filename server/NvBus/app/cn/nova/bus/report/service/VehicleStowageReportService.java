package cn.nova.bus.report.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * <b>类描述：车辆营运配载统计表</b><br/>
 * <b>类名称：</b>VehicleStowageReportService.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-4-28  <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface VehicleStowageReportService {
	
	/**
	 * 车辆营运配载统计表
	 * @param startdate
	 * @param enddate
	 * @param orgid
	 * @param routeid
	 * @param isovertime
	 * @return
	 */
	public List<Map<String, Object>> queryVehicleStowage(
			Date startdate, Date enddate,String orgid,
			Long routeid,String isovertime);
}
