package cn.nova.bus.report.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface UnitRouteVehicleReportService {

/**
 * 班次发班运量统计表
 * @param orgids  班次所属机构
 * @param startdate
 * @param enddate
 * 统计参数
 * @param type 
 * @param scheduleorg 班次机构
 * @param printorg    打单机构
 * @param unit		     结算单位
 * @param carunit	     车属单位
 * @param route		     线路
 * @param schedule	     班次
 * @param vehicle	    车牌
 * @return
 */
	public List<Map<String,Object>> queryUnitRouteVehicleReport(
			String orgids, Date startdate,Date enddate,String groupby,
			long vehicleid,String districttype, String type,String vehicleunitid) ;
	public List<Map<String, Object>> queryinfo(String orgids);
}
