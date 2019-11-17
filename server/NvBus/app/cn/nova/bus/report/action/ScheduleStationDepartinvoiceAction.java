/**
 * <b>项目名：</b>NvBusWeb<br/>
 * <b>包名：</b>cn.nova.bus.report.action<br/>
 * <b>文件名：</b>ScheduleStationDepartinvoiceAction.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2012-2-29 下午01:30:18 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.service.ScheduleStationDepartinvoiceService;
import cn.nova.bus.report.service.impl.ScheduleStationDepartinvoiceServiceImpl;

/**
 * <b>类描述：班线和停靠点运量汇总表</b><br/>
 * <b>类名称：</b>ScheduleStationDepartinvoiceAction.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-2-29 下午01:30:18 <br/>
 * <b>关键修改：添加线路查询条件</b><br/>
 * <b>修改时间：2012-06-29</b><br/>
 * <b>修改人：hhz</b><br/>
 */
public class ScheduleStationDepartinvoiceAction extends BaseAction{

	// 返回结果
	private List<Map<String, Object>> resultmap;
	private String orgid;
	private Date startdate;
	private Date enddate;
	private Long routeid;
	private Long scheduleid;

	public String query() {
		try {
			ScheduleStationDepartinvoiceService scheduleDepartinvoiceService = new ScheduleStationDepartinvoiceServiceImpl();
			setResultmap(scheduleDepartinvoiceService.query(orgid, startdate,
					enddate, routeid,scheduleid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public void setResultmap(List<Map<String, Object>> resultmap) {
		this.resultmap = resultmap;
	}

	public List<Map<String, Object>> getResultmap() {
		return resultmap;
	}

	public String getOrgid() {
		return orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
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

	public Long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(Long scheduleid) {
		this.scheduleid = scheduleid;
	}

}
