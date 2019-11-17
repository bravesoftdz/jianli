package cn.nova.bus.query.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import cn.nova.bus.query.service.TicketCheckQryService;
import cn.nova.bus.query.service.impl.TicketCheckQryServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * 检票查询
 * 
 * @author hhz
 * 
 */
public class TicketCheckQryAction extends BaseAction{
	TicketCheckQryService ticketCheckQryService;

	long departinvoicesid; // 根据结算单ID 查找扣费单明细
	long printby;

	// 返回结果
	private List<Map<String, Object>> resultmap;
	private List<Map<String, Object>> detailresultmap; // 结算单明细
	private List<Map<String, Object>> deductdetailresultmap;// 扣费单明显
	private List<Map<String, Object>> scheduleMissmap;
	private List<Map<String, Object>> vehicleReportmap;

	private boolean ticketnoVisible;
	
	
	
	/**
	 * 检票日志查询
	 * @return
	 */
	public String qrychecklog(){
		try {
			List<PropertyFilter> propertyFilterList = ServletPropertyFilterUtil
					.buildFromHttpRequest();
			ticketCheckQryService = new TicketCheckQryServiceImpl();
			setResultmap(ticketCheckQryService.qrychecklog(propertyFilterList));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	
	/**
	 * 检票员工作月报
	 * @return
	 */
	public String qrycheckworkmonth(){
		try {
			List<PropertyFilter> propertyFilterList = ServletPropertyFilterUtil
					.buildFromHttpRequest();
			ticketCheckQryService = new TicketCheckQryServiceImpl();
			setResultmap(ticketCheckQryService.qrycheckworkmonth(propertyFilterList));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 结算单情况查询
	 * 
	 * @return
	 */
	public String DepartinvoicesStuation() {
		try {
			List<PropertyFilter> propertyFilterList = ServletPropertyFilterUtil
					.buildFromHttpRequest();
			ticketCheckQryService = new TicketCheckQryServiceImpl();
			setResultmap(ticketCheckQryService
					.queryDepartinvoices(propertyFilterList, printby));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 结算单明细情况查询
	 * 
	 * @return
	 */
	public String departinvoicesDetailStuation() {
		try {
			List<PropertyFilter> propertyFilterList = ServletPropertyFilterUtil
					.buildFromHttpRequest();
			ticketCheckQryService = new TicketCheckQryServiceImpl();
			setDetailresultmap(ticketCheckQryService
					.querydepartinvoicesDetail(propertyFilterList));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 扣费单明细情况查询
	 * 
	 * @return
	 */
	public String queryDeductdetail() {
		try {
			List<PropertyFilter> propertyFilterList = ServletPropertyFilterUtil
					.buildFromHttpRequest();
			ticketCheckQryService = new TicketCheckQryServiceImpl();
			setDeductdetailresultmap(ticketCheckQryService
					.queryDeductdetail(propertyFilterList));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 班次漏乘情况查询
	 * 
	 * @return
	 */
	public String findScheduleMissStuation() {
		try {
			List<PropertyFilter> propertyFilterList = ServletPropertyFilterUtil
					.buildFromHttpRequest();
			ticketCheckQryService = new TicketCheckQryServiceImpl();
			setScheduleMissmap(ticketCheckQryService
					.queryScheduleMiss(propertyFilterList,ticketnoVisible));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 班次报班情况查询
	 * 
	 * @return
	 */
	public String findVehicleReportStuation() {
		try {
			List<PropertyFilter> propertyFilterList = ServletPropertyFilterUtil
					.buildFromHttpRequest();
			ticketCheckQryService = new TicketCheckQryServiceImpl();
			setVehicleReportmap(ticketCheckQryService
					.queryVehicleReport(propertyFilterList));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 班次混检情况查询 
	 * @return
	 */
	public String findTicketmixcheck() {
		try {
			List<PropertyFilter> propertyFilterList = ServletPropertyFilterUtil
					.buildFromHttpRequest();
			ticketCheckQryService = new TicketCheckQryServiceImpl();
			setResultmap(ticketCheckQryService
					.queryTicketmixcheck(propertyFilterList));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 班次检票汇总表
	 * 
	 * @return
	 */
	public String queryScheduleCheckSum(){
		try{
			ticketCheckQryService = new TicketCheckQryServiceImpl();
			setResultmap(ticketCheckQryService.queryScheduleCheckSum(
					ServletPropertyFilterUtil.buildFromHttpRequest()));			
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

	public List<Map<String, Object>> getDetailresultmap() {
		return detailresultmap;
	}

	public void setDetailresultmap(List<Map<String, Object>> detailresultmap) {
		this.detailresultmap = detailresultmap;
	}

	public List<Map<String, Object>> getDeductdetailresultmap() {
		return deductdetailresultmap;
	}

	public void setDeductdetailresultmap(
			List<Map<String, Object>> deductdetailresultmap) {
		this.deductdetailresultmap = deductdetailresultmap;
	}

	public long getDepartinvoicesid() {
		return departinvoicesid;
	}

	public void setDepartinvoicesid(long departinvoicesid) {
		this.departinvoicesid = departinvoicesid;
	}
	
	public long getPrintby() {
		return printby;
	}

	public void setPrintby(long printby) {
		this.printby = printby;
	}

	public List<Map<String, Object>> getScheduleMissmap() {
		return scheduleMissmap;
	}

	public void setScheduleMissmap(List<Map<String, Object>> scheduleMissmap) {
		this.scheduleMissmap = scheduleMissmap;
	}

	public List<Map<String, Object>> getVehicleReportmap() {
		return vehicleReportmap;
	}

	public void setVehicleReportmap(List<Map<String, Object>> vehicleReportmap) {
		this.vehicleReportmap = vehicleReportmap;
	}


	public boolean isTicketnoVisible() {
		return ticketnoVisible;
	}


	public void setTicketnoVisible(boolean ticketnoVisible) {
		this.ticketnoVisible = ticketnoVisible;
	}
	
}
