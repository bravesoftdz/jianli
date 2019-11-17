package cn.nova.bus.report.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.dao.UnitRouteVehicleReportDao;
import cn.nova.bus.report.service.UnitRouteVehicleReportService;
import cn.nova.utils.orm.jpa.ListUtil;

public class UnitRouteVehicleReportServiceImpl implements
		UnitRouteVehicleReportService {
	private UnitRouteVehicleReportDao dao = new UnitRouteVehicleReportDao();

	
	/**
	 * 班次发班运量统计表
	 * @param orgids  班次所属机构
	 * @param startdate
	 * @param enddate
	 * @param scheduleorg 班次机构
	 * @param printorg    打单机构
	 * @param unit		     结算单位
	 * @param carunit	     车属单位
	 * @param route		     线路
	 * @param schedule	     班次
	 * @param vehicle	    车牌
	 */
	@Override
	public List<Map<String, Object>> queryUnitRouteVehicleReport(
			String orgids, Date startdate,Date enddate,String groupby,long vehicleid,String districttype,String type,String vehicleunitid) {
		dao = new UnitRouteVehicleReportDao();
		return ListUtil.listToMap(new Object[] { 				
				"firstname","secendname","invoicesnonum","schedulenum",
				"ticketnum","totalamount","stationservicefee","computefee",
				"coolairfee","additionfee","fueladditionfee","waterfee",
				"insurefee","otherfee","basemount","agentfee","income",
				"balanceamount","peopledistance","moreprice","subtotal",
				"seats","rate","seatrate","overtime","needschedulenum",
				"needpeopledistance","routedistance","comments"}, 
				dao.queryUnitRouteVehicleReport(orgids,startdate,enddate,groupby,vehicleid,districttype,type,vehicleunitid),
				new Object[] { String.class,String.class,BigDecimal.class,
				BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
				BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
				BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
				BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,String.class,
				String.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,String.class});
	}


	@Override
	public List<Map<String, Object>> queryinfo(String orgid) {	
		dao = new UnitRouteVehicleReportDao();
		return ListUtil.listToMap(new Object[] {"contactperson"},dao.queryinfo(orgid),new Object[] { String.class});		
	}
	
}
