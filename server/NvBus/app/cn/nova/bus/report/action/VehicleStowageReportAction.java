package cn.nova.bus.report.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.service.VehicleStowageReportService;
import cn.nova.bus.report.service.impl.VehicleStowageReportServiceImpl;

/**
 * <b>类描述：车辆营运配载统计表</b><br/>
 * <b>类名称：</b>VehicleStowageReportAction.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-4-28  <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class VehicleStowageReportAction extends BaseAction{

	// 返回结果
	private List<Map<String, Object>> resultmap;
	private Date startdate;
	private Date enddate;
	private Long routeid;
	private String orgid;
	private String isovertime;
	
	/**
	 * 车辆营运配载统计表 
	 * @param startdate
	 * @return
	 */
	public String query() {
		try {
			VehicleStowageReportService vehicleStowageReportService = new VehicleStowageReportServiceImpl();
			setResultmap(vehicleStowageReportService.queryVehicleStowage(startdate,
					enddate,orgid,routeid,isovertime));
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

	public Long getRouteid() {
		return routeid;
	}

	public void setRouteid(Long routeid) {
		this.routeid = routeid;
	}

	public String getOrgid() {
		return orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}

	public String getIsovertime() {
		return isovertime;
	}

	public void setIsovertime(String isovertime) {
		this.isovertime = isovertime;
	}
	
}
