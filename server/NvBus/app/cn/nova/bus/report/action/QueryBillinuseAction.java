package cn.nova.bus.report.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.service.QueryBillinuseService;
import cn.nova.bus.report.service.impl.QueryBillinuseServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class QueryBillinuseAction extends BaseAction{
	private QueryBillinuseService queryBillinuseService;
	// 返回结果
	private List<Map<String, Object>> resultmap;
	private List<Map<String, Object>> billdetailmap;
	private List<Map<String, Object>> ticketmap;
	private Date startdate;
	private Date enddate;
	private Long recipients;
	private String status;
	private String orgids;
	private Long billtypeid;
	private Long storageid;
	private String startticketno ;
	private String endticketno;
	/**
	 * 售票员票证使用情况查询
	 * 
	 * @return
	 */
	public String queryBillinuse() {
		try {
			queryBillinuseService = new QueryBillinuseServiceImpl();
			setResultmap(queryBillinuseService.queryBillinuseReport(startdate,
					enddate, recipients, status));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			e.getMessage();
		}
		return "json";
	}

	/**
	 * 站务分公司使用票证明细帐
	 */
	public String queryBilldetailReport() {
		queryBillinuseService = new QueryBillinuseServiceImpl();
		setBilldetailmap(queryBillinuseService.queryBilldetailReport(orgids,
				startdate, enddate, recipients, status, billtypeid, storageid));
		return "json";
	}

	/**
	 * 车票使用汇总表
	 */
	public String queryTicketReport(){
		queryBillinuseService = new QueryBillinuseServiceImpl();
		setTicketmap(queryBillinuseService.queryTicketReport(
		ServletPropertyFilterUtil.buildFromHttpRequest(),startticketno,endticketno));
		return "json";
	}

	/**
	 * 车票换号重打查询
	 * @return
	 */
	public String queryTicketReprint(){
		queryBillinuseService = new QueryBillinuseServiceImpl();
		setResultmap(queryBillinuseService.queryTicketReprint(ServletPropertyFilterUtil.buildFromHttpRequest()));
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

	public Long getRecipients() {
		return recipients;
	}

	public void setRecipients(Long recipients) {
		this.recipients = recipients;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public List<Map<String, Object>> getBilldetailmap() {
		return billdetailmap;
	}

	public void setBilldetailmap(List<Map<String, Object>> billdetailmap) {
		this.billdetailmap = billdetailmap;
	}

	public String getOrgids() {
		return orgids;
	}

	public void setOrgids(String orgids) {
		this.orgids = orgids;
	}

	public Long getBilltypeid() {
		return billtypeid;
	}

	public void setBilltypeid(Long billtypeid) {
		this.billtypeid = billtypeid;
	}

	public Long getStorageid() {
		return storageid;
	}

	public void setStorageid(Long storageid) {
		this.storageid = storageid;
	}

	public List<Map<String, Object>> getTicketmap() {
		return ticketmap;
	}

	public void setTicketmap(List<Map<String, Object>> ticketmap) {
		this.ticketmap = ticketmap;
	}

	public String getStartticketno() {
		return startticketno;
	}

	public void setStartticketno(String startticketno) {
		this.startticketno = startticketno;
	}

	public String getEndticketno() {
		return endticketno;
	}

	public void setEndticketno(String endticketno) {
		this.endticketno = endticketno;
	}

}
