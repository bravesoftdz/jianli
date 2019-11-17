/**
 * <b>项目名：</b>NvBusWeb<br/>
 * <b>包名：</b>cn.nova.bus.report.action<br/>
 * <b>文件名：</b>StationDepartinvoiceAction.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2012-2-21 上午10:02:31 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.service.VehicleStationDepartinvoiceService;
import cn.nova.bus.report.service.impl.VehicleStationDepartinvoiceServiceImpl;

/**
 * <b>类描述：车辆停靠点运量汇总表</b><br/>
 * <b>类名称：</b>StationDepartinvoiceDao.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-2-21 上午08:53:58 <br/>
 * <b>关键修改：机构ID修改为String 类型</b><br/>
 * <b>修改时间：2012-4-19</b><br/>
 * <b>修改人：黄浩泽</b><br/>
 */
public class VehicleStationDepartinvoiceAction extends BaseAction{

	// 返回结果
	private List<Map<String, Object>> resultmap;
	private Date startdate;
	private Date enddate;
	private Long vehicleid;
	private String orgid;
	private Long routeid;
	private Long stationid;
	
	public String query() {
		try {
			VehicleStationDepartinvoiceService vehicleStationDepartinvoiceService = new VehicleStationDepartinvoiceServiceImpl();
			setResultmap(vehicleStationDepartinvoiceService.query(orgid,startdate,
					enddate, vehicleid,routeid,stationid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			e.getMessage();
		}
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

	public Long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(Long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public String getOrgid() {
		return orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}

	public Long getRouteid() {
		return routeid;
	}

	public void setRouteid(Long routeid) {
		this.routeid = routeid;
	}

	public Long getStationid() {
		return stationid;
	}

	public void setStationid(Long stationid) {
		this.stationid = stationid;
	}

}
