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

import cn.nova.bus.report.service.StationDepartinvoiceService;
import cn.nova.bus.report.service.impl.StationDepartinvoiceServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>StationDepartinvoiceAction.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-2-21 上午10:02:31 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class StationDepartinvoiceAction extends BaseAction{
	// 返回结果
	private List<Map<String, Object>> resultmap;
	private Date startdate;
	private Date enddate;
	private Long stationid;
	private String orgid;
	
	public String query() {
		try {
			StationDepartinvoiceService stationDepartinvoiceService = new StationDepartinvoiceServiceImpl();
			setResultmap(stationDepartinvoiceService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
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

	public Long getStationid() {
		return stationid;
	}

	public void setStationid(Long stationid) {
		this.stationid = stationid;
	}

	public String getOrgid() {
		return orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}

}
