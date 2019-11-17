/**
 * <b>项目名：</b>NvBusWeb<br/>
 * <b>包名：</b>cn.nova.bus.report.action<br/>
 * <b>文件名：</b>VehicleReportStatusAction.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-8-29 下午01:46:51<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.service.VehicleReportStatusService;
import cn.nova.bus.report.service.impl.VehicleReportStatusServiceImpl;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>VehicleReportStatusAction.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-8-29 下午01:46:51<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class VehicleReportStatusAction extends BaseAction{

	private VehicleReportStatusService vehicleReportStatusService;
	// 返回结果
	private List<Map<String, Object>> resultmap;
	private Date departdate;
	private String orgid;
	private String reportway;
	private long departstation;// 乘车站
	private long routeid;// 线路
	private long unitid;// 营运单位
	private long vehicletypeid;// 车型
	private long stationid;// 站点
	private long scheduleid;// 车次
	private Date enddate;
	private String sellorgid;// 售票机构
	private Date selldate;// 售票时间
	private Date sellenddate;// 售票结束时间
	private boolean isEmpty; // 是否查询售票数为0的班次

	/**
	 * 车辆报班情况一览表
	 * 
	 * @param startdate
	 * @return
	 */
	public String query() {
		try {
			vehicleReportStatusService = new VehicleReportStatusServiceImpl();
			setResultmap(vehicleReportStatusService.queryVehicleReportStatus(
					departdate, orgid, reportway));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			e.getMessage();
		}
		return "json";
	}

	/**
	 * 车辆售票流量统计
	 * 
	 * @param startdate
	 * @return
	 */
	public String queryTicket() {
		try {
			vehicleReportStatusService = new VehicleReportStatusServiceImpl();
			setResultmap(vehicleReportStatusService.queryVehicleTicketCount(
					orgid, departstation, departdate, routeid, unitid,
					vehicletypeid, stationid, scheduleid, enddate, sellorgid,
					selldate, sellenddate, isEmpty));
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

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public String getOrgid() {
		return orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}
	
	public Long getDepartstation() {
		return departstation;
	}

	public long getRouteid() {
		return routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}

	public long getUnitid() {
		return unitid;
	}

	public void setUnitid(long unitid) {
		this.unitid = unitid;
	}

	public long getVehicletypeid() {
		return vehicletypeid;
	}

	public void setVehicletypeid(long vehicletypeid) {
		this.vehicletypeid = vehicletypeid;
	}

	public long getStationid() {
		return stationid;
	}

	public void setStationid(long stationid) {
		this.stationid = stationid;
	}

	public long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public void setDepartstation(long departstation) {
		this.departstation = departstation;
	}

	public String getSellorgid() {
		return sellorgid;
	}

	public void setSellorgid(String sellorgid) {
		this.sellorgid = sellorgid;
	}

	public Date getSelldate() {
		return selldate;
	}

	public void setSelldate(Date selldate) {
		this.selldate = selldate;
	}

	public Date getSellenddate() {
		return sellenddate;
	}

	public void setSellenddate(Date sellenddate) {
		this.sellenddate = sellenddate;
	}

	public boolean getIsEmpty() {
		return isEmpty;
	}

	public void setIsEmpty(boolean isEmpty) {
		this.isEmpty = isEmpty;
	}

	public String getReportway() {
		return reportway;
	}

	public void setReportway(String reportway) {
		this.reportway = reportway;
	}

}
