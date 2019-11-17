package cn.nova.bus.report.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.service.BusparkScheduleReportService;
import cn.nova.bus.report.service.impl.BusparkScheduleReportServiceImpl;

public class BusparkScheduleReportAction extends BaseAction{
	// 返回结果
	private List<Map<String, Object>> resultmap;

	private Date departdate;
	private long orgid;

	/**
	 * 查询异站机构
	 * 
	 * @return
	 */
	public String queryBusparkScheduleReport() {
		try {
			BusparkScheduleReportService busparkScheduleReportService = new BusparkScheduleReportServiceImpl();
			setResultmap(busparkScheduleReportService.query(orgid,departdate));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public List<Map<String, Object>> getResultmap() {
		return resultmap;
	}

	public void setResultmap(List<Map<String, Object>> resultmap) {
		this.resultmap = resultmap;
	}
}
