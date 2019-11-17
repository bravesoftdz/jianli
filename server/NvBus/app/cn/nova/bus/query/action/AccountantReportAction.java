package cn.nova.bus.query.action;

import cn.nova.bus.action.BaseAction;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.nova.bus.query.service.AccountantReportService;
import cn.nova.bus.query.service.impl.AccountantReportServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：售票员售退废报表;客运班线动态表;客运班线动态同比表</b><br/>
 * <b>类名称：</b>AccountantReportAction.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-4-28  <br/>
 * <b>关键修改：修改售票员售退废报表；添加公有变量：groupbydate</b><br/>
 * <b>修改时间：2012-06-29</b><br/>
 * <b>修改人：hhz</b><br/>
 */
public class AccountantReportAction extends BaseAction{
	AccountantReportService accountantReportService;
	// 返回结果
	private List<Map<String, Object>> addobject;
	private List<Map<String, Object>> resultmap;
	private List<Map<String, Object>> routeDynamic; // 班线动态
	private String orgids;
	private Date startdate;
	private Date enddate;
	private String departorgs;
	private boolean groupbydate;
	private String vehicletype;
	private String districttype;
	private String workways;
	private boolean isbyroute;
	private boolean isbydate;
	private String paymethod;
	
	/**
	 * 售票员售退废报表
	 * 
	 * @return
	 */
	public String querySellerDailyReport() {
		try {
			List<PropertyFilter> propertyFilterList = ServletPropertyFilterUtil
					.buildFromHttpRequest();
			accountantReportService = new AccountantReportServiceImpl();
			setResultmap(accountantReportService
					.querySellerDailyReport(propertyFilterList,groupbydate,paymethod));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 客运班线动态表
	 * 
	 * @return
	 */
	public String queryRouteDynamic() {
		try {
			accountantReportService = new AccountantReportServiceImpl();
			setRouteDynamic(accountantReportService.queryRouteDynamic(orgids,
					startdate, enddate, departorgs,vehicletype,districttype,workways));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 客运班线动态对比表
	 * 
	 * @return
	 */
	public String routeDynamicCompare() {
		try {
			accountantReportService = new AccountantReportServiceImpl();
			setRouteDynamic(accountantReportService
					.qryRouteDynamicCompare(ServletPropertyFilterUtil
							.buildFromHttpRequest(),isbyroute,isbydate));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 添加对比项目
	 * 
	 * @return
	 */
	public String addcompare() {
		try {
			List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
			Map<String, Object> item1 = new HashMap<String, Object>();
			item1.put("id", "10");
			item1.put("name", "发班数");
			item1.put("code", "schnum1");
			result.add(item1);
			Map<String, Object> item2 = new HashMap<String, Object>();
			item2.put("id", "20");
			item2.put("name", "总座位数");
			item2.put("code", "seats1");
			result.add(item2);
			Map<String, Object> item3 = new HashMap<String, Object>();
			item3.put("id", "30");
			item3.put("name", "人数");
			item3.put("code", "ticketnum1");
			result.add(item3);
			Map<String, Object> item4 = new HashMap<String, Object>();
			item4.put("id", "40");
			item4.put("name", "检票金额");
			item4.put("code", "totalamount1");
			result.add(item4);
			Map<String, Object> item5 = new HashMap<String, Object>();
			item5.put("id", "50");
			item5.put("name", "结算金额");
			item5.put("code", "balanceamount1");
			result.add(item5);
			Map<String, Object> item6 = new HashMap<String, Object>();
			item6.put("id", "60");
			item6.put("name", "车站收入");
			item6.put("code", "stationincome1");
			result.add(item6);
			Map<String, Object> item7 = new HashMap<String, Object>();
			item7.put("id", "70");
			item7.put("name", "客运代理费");
			item7.put("code", "agentfee1");
			result.add(item7);
			Map<String, Object> item8 = new HashMap<String, Object>();
			item8.put("id", "80");
			item8.put("name", "站务费");
			item8.put("code", "stationservicefee1");
			result.add(item8);
			Map<String, Object> item9 = new HashMap<String, Object>();
			item9.put("id", "90");
			item9.put("name", "微机费");
			item9.put("code", "computefee1");
			result.add(item9);
			Map<String, Object> item10 = new HashMap<String, Object>();
			item10.put("id", "111");
			item10.put("name", "空调费");
			item10.put("code", "coolairfee1");
			result.add(item10);
			Map<String, Object> item11 = new HashMap<String, Object>();
			item11.put("id", "121");
			item11.put("name", "附加费");
			item11.put("code", "additionfee1");
			result.add(item11);
			Map<String, Object> item12 = new HashMap<String, Object>();
			item12.put("id", "131");
			item12.put("name", "线路总公里");
			item12.put("code", "routedistance1");
			result.add(item12);
			Map<String, Object> item13 = new HashMap<String, Object>();
			item13.put("id", "141");
			item13.put("name", "周转量");
			item13.put("code", "peopledistance1");
			result.add(item13);
			Map<String, Object> item14 = new HashMap<String, Object>();
			item14.put("id", "151");
			item14.put("name", "实载率");
			item14.put("code", "rate1");
			result.add(item14);
			Map<String, Object> item15 = new HashMap<String, Object>();
			item15.put("id", "161");
			item15.put("name", "座位利用率");
			item15.put("code", "seatrate1");
			result.add(item15);
			Map<String, Object> item16 = new HashMap<String, Object>();
			item16.put("id", "171");
			item16.put("name", "营收比重");
			item16.put("code", "incomerate1");
			result.add(item16);
			Map<String, Object> item17 = new HashMap<String, Object>();
			item17.put("id", "181");
			item17.put("name", "售票收入");
			item17.put("code", "sellincome");
			result.add(item17);
			setAddobject(result);
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
		}
		return "json";
	}

	public List<Map<String, Object>> getResultmap() {
		return resultmap;
	}

	public void setResultmap(List<Map<String, Object>> resultmap) {
		this.resultmap = resultmap;
	}

	public List<Map<String, Object>> getRouteDynamic() {
		return routeDynamic;
	}

	public void setRouteDynamic(List<Map<String, Object>> routeDynamic) {
		this.routeDynamic = routeDynamic;
	}

	public String getOrgids() {
		return orgids;
	}

	public void setOrgids(String orgids) {
		this.orgids = orgids;
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

	public List<Map<String, Object>> getAddobject() {
		return addobject;
	}

	public void setAddobject(List<Map<String, Object>> addobject) {
		this.addobject = addobject;
	}

	public String getDepartorgs() {
		return departorgs;
	}

	public void setDepartorgs(String departorgs) {
		this.departorgs = departorgs;
	}

	public boolean isGroupbydate() {
		return groupbydate;
	}

	public void setGroupbydate(boolean groupbydate) {
		this.groupbydate = groupbydate;
	}

	public String getVehicletype() {
		return vehicletype;
	}

	public void setVehicletype(String vehicletype) {
		this.vehicletype = vehicletype;
	}

	public boolean isIsbyroute() {
		return isbyroute;
	}

	public void setIsbyroute(boolean isbyroute) {
		this.isbyroute = isbyroute;
	}

	public boolean isIsbydate() {
		return isbydate;
	}

	public void setIsbydate(boolean isbydate) {
		this.isbydate = isbydate;
	}
	public String getDistricttype() {
		return districttype;
	}

	public void setDistricttype(String districttype) {
		this.districttype = districttype;
	}

	public String getWorkways() {
		return workways;
	}

	public void setWorkways(String workways) {
		this.workways = workways;
	}

	public String getPaymethod() {
		return paymethod;
	}

	public void setPaymethod(String paymethod) {
		this.paymethod = paymethod;
	}
	
	
}
