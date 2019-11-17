package cn.nova.bus.report.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.service.StationRouteReportService;
import cn.nova.bus.report.service.impl.StationRouteReportServiceImpl;

/**
 * <b>类描述：</b>客运班线调查统计表<br/>
 * <b>类名称：</b>StationRouteReportAction.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b>2013-08-08 上午09:34:11 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class StationRouteReportAction extends BaseAction{

	// 返回结果
	private List<Map<String, Object>> resultmap;
	private Date startdate;
	private Date enddate;
	private String orgids;
	
	public String query() {
		try {
			StationRouteReportService stationRouteReportService = new StationRouteReportServiceImpl();
			stationRouteReportService = new StationRouteReportServiceImpl();
			setResultmap(stationRouteReportService.query(orgids,startdate,enddate));
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

	public String getOrgids() {
		return orgids;
	}

	public void setOrgids(String orgids) {
		this.orgids = orgids;
	}
	
}
