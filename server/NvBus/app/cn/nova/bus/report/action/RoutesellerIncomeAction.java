package cn.nova.bus.report.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.service.RoutesellerIncomeService;
import cn.nova.bus.report.service.impl.RoutesellerIncomeServiceImpl;

public class RoutesellerIncomeAction extends BaseAction{
	// 返回结果
	private List<Map<String, Object>> resultmap;

	private String orgids;
	private Long seller;
	private Long stationid;
	private Long routeid;
	private String workways;
	private Date startdate;
	private Date enddate;
	private String grouptypes;
	private Boolean issellgroup = false;//是否按售票员分组
	private Boolean isstationgroup = false;//是否按停靠站点分组
	private Boolean isroutegroup = false;//是否按线路分组
	private Boolean isworkwaysgroup = false;//是否按营运方式分组
	private String districttype;//班次运营区域
	private Boolean iscodegroup = false;//是否按班次分组  李电志 2015年12月28日 15:07:07
	private Long scheduleid ;//是否按班次分组  李电志 2015年12月28日 15:07:07
	private Long ticketoutletsid;
	private Boolean isticketoutletsgroup = false;
	
	/**
	 * 线路停靠点售票统计表
	 * 
	 * @return
	 */
	public String queryRouteIncome() {
		if (grouptypes != null && grouptypes.trim().length() > 0) {
			if (grouptypes.contains("1")) {
				setIsstationgroup(true);
			} 
			if(grouptypes.contains("2")) {
				setIsroutegroup(true);
			} 
			if(grouptypes.contains("3")) {
				setIssellgroup(true);
			} 
		}
		try {
			RoutesellerIncomeService routesellerIncomeservice = new RoutesellerIncomeServiceImpl();
			resultmap = routesellerIncomeservice.queryRouteIncome(orgids,
					startdate, enddate, issellgroup, seller, isstationgroup, isroutegroup,districttype,isworkwaysgroup,workways,stationid,routeid
					,iscodegroup,scheduleid,ticketoutletsid,isticketoutletsgroup);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public List<Map<String, Object>> getResultmap() {
		return resultmap;
	}
	public void setResultmap(List<Map<String, Object>> resultmap) {
		this.resultmap = resultmap;
	}
	public String getOrgids() {
		return orgids;
	}
	public void setOrgids(String orgids) {
		this.orgids = orgids;
	}
	public Long getSeller() {
		return seller;
	}
	public void setSeller(Long seller) {
		this.seller = seller;
	}
	public Boolean getIssellgroup() {
		return issellgroup;
	}
	public void setIssellgroup(Boolean issellgroup) {
		this.issellgroup = issellgroup;
	}
	public Boolean getIsstationgroup() {
		return isstationgroup;
	}
	public void setIsstationgroup(Boolean isstationgroup) {
		this.isstationgroup = isstationgroup;
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
	public Boolean getIsroutegroup() {
		return isroutegroup;
	}
	public void setIsroutegroup(Boolean isroutegroup) {
		this.isroutegroup = isroutegroup;
	}
	public String getDistricttype() {
		return districttype;
	}
	public void setDistricttype(String districttype) {
		this.districttype = districttype;
	}
	
	public String getGrouptypes() {
		return grouptypes;
	}
	public void setGrouptypes(String grouptypes) {
		this.grouptypes = grouptypes;
	}
	public Long getStationid() {
		return stationid;
	}
	public void setStationid(Long stationid) {
		this.stationid = stationid;
	}
	public Long getRouteid() {
		return routeid;
	}
	public void setRouteid(Long routeid) {
		this.routeid = routeid;
	}
	public String getWorkways() {
		return workways;
	}
	public void setWorkways(String workways) {
		this.workways = workways;
	}
	public Boolean getIsworkwaysgroup() {
		return isworkwaysgroup;
	}
	public void setIsworkwaysgroup(Boolean isworkwaysgroup) {
		this.isworkwaysgroup = isworkwaysgroup;
	}
	public Boolean getIscodegroup() {
		return iscodegroup;
	}
	public void setIscodegroup(Boolean iscodegroup) {
		this.iscodegroup = iscodegroup;
	}
	public Long getScheduleid() {
		return scheduleid;
	}
	public void setScheduleid(Long scheduleid) {
		this.scheduleid = scheduleid;
	}
	public Long getTicketoutletsid() {
		return ticketoutletsid;
	}
	public void setTicketoutletsid(Long ticketoutletsid) {
		this.ticketoutletsid = ticketoutletsid;
	}
	public Boolean getIsticketoutletsgroup() {
		return isticketoutletsgroup;
	}
	public void setIsticketoutletsgroup(Boolean isticketoutletsgroup) {
		this.isticketoutletsgroup = isticketoutletsgroup;
	}
	
	
}
