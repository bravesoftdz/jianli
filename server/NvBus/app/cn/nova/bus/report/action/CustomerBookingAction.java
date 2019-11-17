package cn.nova.bus.report.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.service.CustomerBookingService;
import cn.nova.bus.report.service.impl.CustomerBookingServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class CustomerBookingAction extends BaseAction{
	private List<Map<String, Object>> cbklist;
	private List<Map<String, Object>> resultmap;
	
	private String orgid;
	private Date startdate;
	private Date enddate;
	     
	private CustomerBookingService bookingService;
	
	public String queryCustomerBooking(){
		bookingService = new CustomerBookingServiceImpl();
		setCbklist(bookingService.QueryCustomerBooking(orgid, startdate, enddate));
		return "json";
	}
	
	/**
	 *  班次预售情况查询
	 * @return
	 */
	public String QueryPersellSum(){
		List<PropertyFilter> propertyFilterList = ServletPropertyFilterUtil
		.buildFromHttpRequest();
		bookingService = new CustomerBookingServiceImpl();
		setResultmap(bookingService.QueryPersellSum(propertyFilterList));
		return "json";	
	}

	public List<Map<String, Object>> getCbklist() {
		return cbklist;
	}

	public void setCbklist(List<Map<String, Object>> cbklist) {
		this.cbklist = cbklist;
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

	public List<Map<String, Object>> getResultmap() {
		return resultmap;
	}

	public void setResultmap(List<Map<String, Object>> resultmap) {
		this.resultmap = resultmap;
	}
	
}
