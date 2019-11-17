package cn.nova.bus.report.action;

import cn.nova.bus.action.BaseAction;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.service.UnitRouteVehicleReportService;
import cn.nova.bus.report.service.impl.UnitRouteVehicleReportServiceImpl;

/**
 * <b>类描述：发班运量统计表</b><br/>
 * <b>类名称：</b>UnitRouteVehicleReportAction.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-8-22 上午 <br/>
 * <b>关键修改：添加统计方式：按车牌和线路统计</b><br/>
 * <b>修改时间：2013-03-21</b><br/>
 * <b>修改人：黄浩泽</b><br/>
 */
public class UnitRouteVehicleReportAction extends BaseAction{

	// 返回结果
	private List<Map<String, Object>> resultmap;
	private List<Map<String, Object>>  groupbylist;
	private Date startdate;
	private Date enddate;
	private String orgids;
	private String groupby;
	
	private String scheduleorg;
	private String printorg;
	private String unit;
	private String carunit;
	private String route;
	private String schedule;
	private String vehicle;
	private long vehicleid;
	private String districttype;
	private String type;
	private String orgid;
	private String vehicleunitid;
	private List<Map<String, Object>>  infolist;
	
	public String query() {
		try {
			UnitRouteVehicleReportService unitRouteVehicleReportService = new UnitRouteVehicleReportServiceImpl();
			List<Map<String, Object>> result=unitRouteVehicleReportService.queryUnitRouteVehicleReport(
					orgids, startdate, enddate, groupby,vehicleid,districttype,type,vehicleunitid);
			if(result!=null && result.size()>1){    //如果查询出结果，去掉里程合计
				int len=result.size()-2;			
				Map<String, Object> last = result.get(result.size()-2);
				last.remove("routedistance");	
				last.put("routedistance", "");
				result.set(len, last);
			}
			setResultmap(result);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			e.getMessage();
		}
		return "json";
	}	
	
	/**
	 * 统计项目
	 * 
	 * @return
	 */
	public String addgroupby() {
		try {
			List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
			Map<String, Object> item1 = new HashMap<String, Object>();
			item1.put("id", "1");
			item1.put("value", "按线路和结算单位统计");
			item1.put("code", "unit");
			result.add(item1);
			Map<String, Object> item2 = new HashMap<String, Object>();
			item2.put("id", "2");
			item2.put("value", "按线路和车牌统计");
			item2.put("code", "vehileno");
			result.add(item2);
			Map<String, Object> item3 = new HashMap<String, Object>();
			item3.put("id", "3");
			item3.put("value", "按线路和发车时间统计");
			item3.put("code", "starttime");
			result.add(item3);
			Map<String, Object> item4 = new HashMap<String, Object>();
			item4.put("id", "4");
			item4.put("value", "按车牌和线路统计");
			item4.put("code", "vehicleroute");
			result.add(item4);
			Map<String, Object> item5 = new HashMap<String, Object>();
			item5.put("id", "5");
			item5.put("value", "按发车日期统计");
			item5.put("code", "departdate");
			result.add(item5);
			Map<String, Object> item6 = new HashMap<String, Object>();
			item6.put("id", "6");
			item6.put("value", "按线路和车属单位统计");
			item6.put("code", "carunit");
			result.add(item6);
			Map<String, Object> item7 = new HashMap<String, Object>();
			item7.put("id", "7");
			item7.put("value", "按线路和班线类别统计");
			item7.put("code", "routetype");
			result.add(item7);	
			Map<String, Object> item8 = new HashMap<String, Object>();
			item8.put("id", "8");
			item8.put("value", "按车属单位和线路统计");
			item8.put("code", "routetype");
			result.add(item8);
			setGroupbylist(result);
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
		}
		return "json";
	}
	
	public String queryContactperson(){
		List<Map<String, Object>> result = new UnitRouteVehicleReportServiceImpl().queryinfo(orgid);
		setInfolist(result);
		return "json";
	}

	public List<Map<String, Object>> getResultmap() {
		return resultmap;
	}

	public void setResultmap(List<Map<String, Object>> resultmap) {
		this.resultmap = resultmap;
	}

	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public String getOrgids() {
		return orgids;
	}

	public void setOrgids(String orgids) {
		this.orgids = orgids;
	}

	public List<Map<String, Object>> getGroupbylist() {
		return groupbylist;
	}

	public void setGroupbylist(List<Map<String, Object>> groupbylist) {
		this.groupbylist = groupbylist;
	}

	public String getScheduleorg() {
		return scheduleorg;
	}

	public void setScheduleorg(String scheduleorg) {
		this.scheduleorg = scheduleorg;
	}

	public String getPrintorg() {
		return printorg;
	}

	public void setPrintorg(String printorg) {
		this.printorg = printorg;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getRoute() {
		return route;
	}

	public void setRoute(String route) {
		this.route = route;
	}

	public String getSchedule() {
		return schedule;
	}

	public void setSchedule(String schedule) {
		this.schedule = schedule;
	}

	public String getVehicle() {
		return vehicle;
	}

	public void setVehicle(String vehicle) {
		this.vehicle = vehicle;
	}

	public String getGroupby() {
		return groupby;
	}

	public void setGroupby(String groupby) {
		this.groupby = groupby;
	}

	public long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}
	
	public String getDistricttype() {
		return districttype;
	}
	
	public void setDistricttype(String districttype) {
		this.districttype = districttype;
	}

	public String getCarunit() {
		return carunit;
	}

	public void setCarunit(String carunit) {
		this.carunit = carunit;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getOrgid() {
		return orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}

	public String getvehicleunitid() {
		return vehicleunitid;
	}

	public void setvehicleunitid(String vehicleunitid) {
		this.vehicleunitid = vehicleunitid;
	}

	public List<Map<String, Object>> getInfolist() {
		return infolist;
	}

	public void setInfolist(List<Map<String, Object>> infolist) {
		this.infolist = infolist;
	}
	
}
