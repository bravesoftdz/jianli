package controllers.QueryWindowPayment.action;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.web.ServletPropertyFilterUtil;
import controllers.QueryWindowPayment.service.QueryWindowPaymentService;
import controllers.QueryWindowPayment.service.impl.QueryWindowPaymentServiceImpl;
import util.CurrentUtil;

/**
 * 
 * <b>类描述：</b>窗口电子支付对账明细表<br/>
 * <b>类描述：</b>窗口电子支付对账汇总表<br/>
 * 
 * @version 2017年10月23日16:25:45
 * @author Administrator
 *
 */
public class QueryWindowPaymentAction extends BaseAction {
	private QueryWindowPaymentService queryWindowPaymentService;
	
	// 返回结果
	private List<Map<String, Object>> resultList;
	
	/**
	 * 查询窗口电子支付明细
	 * @param beginDate： 交易开始日期
	 * @param endDate： 交易截止日期
	 * @return
	 */
	public String ticketEpayDetail(){
		Global g = CurrentUtil.getGlobal();
		queryWindowPaymentService = new QueryWindowPaymentServiceImpl();
		setResultList(queryWindowPaymentService.ticketEpayDetail(g ,beginDate, endDate, ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}
	/**
	 * <b>类描述：</b>窗口电子支付对账明细表<br/>
	 * 
	 * @return
	 */

	public String queryPayment() {
		queryWindowPaymentService = new QueryWindowPaymentServiceImpl();
		resultList = queryWindowPaymentService.queryPayment(ServletPropertyFilterUtil.buildFromHttpRequest(),beginDate, endDate);

		return "json";
	}
	private String datetype;
	public String getDatetype() {
		return datetype;
	}


	public void setDatetype(String datetype) {
		this.datetype = datetype;
	}
	private Date starttime;
	private Date endtime;
	

	public Date getStarttime() {
		return starttime;
	}


	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}


	public Date getEndtime() {
		return endtime;
	}


	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}
	/**
	 * 窗口电子支付汇总表
	 * 
	 * @param propertyFilterList
	 * @param summaryway
	 *            [ 0 支付方式分组 || 1 交易日期分组 || 2 交易日期和支付方式分组]
	 * @param datetype
	 *            [0 售票日期 || 1 发车日期]
	 * @return
	 */
	public String queryEpaymentTicketsSum(){
		queryWindowPaymentService = new QueryWindowPaymentServiceImpl();
		Global g = CurrentUtil.getGlobal();
		resultList = queryWindowPaymentService.queryEpaymentTicketsSum(ServletPropertyFilterUtil.buildFromHttpRequest()
				,summaryway,datetype,starttime,endtime,g);
		return "json";
	}
	
	private Date beginDate;
	private Date endDate;
	
	public Date getBeginDate() {
		return beginDate;
	}
	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	/**
	 * <b>类描述：</b>窗口电子支付对账汇总表<br/>
	 * 
	 * @return
	 */
	private String summaryway;
	
	public String queryPaymentSummary() {
		queryWindowPaymentService = new QueryWindowPaymentServiceImpl();
		resultList = queryWindowPaymentService.queryPaymentSummary(ServletPropertyFilterUtil.buildFromHttpRequest(),summaryway,beginDate,endDate);
		return "json";
	}

	private List<Map<String, Object>> helpmap;// 查询时返回的数据集,
	private String helpType;
	private String param;
	public String payMentList() {
		queryWindowPaymentService = new QueryWindowPaymentServiceImpl();
		helpmap = queryWindowPaymentService.find(helpType, param,ServletPropertyFilterUtil.buildFromHttpRequest());
		return "json";
	}
	
	
	public String getParam() {
		return param;
	}


	public void setParam(String param) {
		this.param = param;
	}


	public List<Map<String, Object>> getResultList() {
		return resultList;
	}

	public void setResultList(List<Map<String, Object>> resultList) {
		this.resultList = resultList;
	}

	public String getSummaryway() {
		return summaryway;
	}

	public void setSummaryway(String summaryway) {
		this.summaryway = summaryway;
	}

	public List<Map<String, Object>> getHelpmap() {
		return helpmap;
	}
	
	public void setHelpmap(List<Map<String, Object>> helpmap) {
		this.helpmap = helpmap;
	}

	public String getHelpType() {
		return helpType;
	}

	public void setHelpType(String helpType) {
		this.helpType = helpType;
	}
	
	
}
