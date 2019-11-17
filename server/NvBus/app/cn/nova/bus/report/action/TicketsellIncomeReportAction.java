package cn.nova.bus.report.action;

import cn.nova.bus.action.BaseAction;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import play.data.binding.As;
import cn.nova.bus.report.service.TicketsellIncomeReportSerivce;
import cn.nova.bus.report.service.impl.TicketsellIncomeReportSerivceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：营收报表</b><br/>
 * <b>类名称：</b>TicketsellIncomeReportAction.java<br/>
 * <b>创建人：</b><a href="mailto:liaojunchang@nova.net.cn">廖俊昌</a><br/>
 * <b>创建时间：</b>2012-09-05<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class TicketsellIncomeReportAction extends BaseAction{

	private TicketsellIncomeReportSerivce incomereportserivce;
	// 返回结果
	private List<Map<String, Object>> resultmap;
	private List<Map<String, Object>> ticketsellSearchbylist;
	private String sellorgid;
	private Long sellerid;
	private String ticketstatus;
	private boolean ischangeticket;
	private String returnticketno;
	private Date sellstartdatetime;
	private Date sellenddatetime;
	private Date departstartdate;
	private Date departenddate;
	private String sellstarttime;
	private String sellendtime;
	private Long reportnum;
	private String column1;
	private String column2;
	private String column3;
	private String cancel_returnTicketno;
	private String ticketoutletsid;
	private boolean isgroupbyroute;
	private int groupby;
	private int groupbywhat;

	/**
	 * 旅客购票情况统计
	 * @return
	 */
	public String CustomerBuyTicketSituation() {
		try {
			incomereportserivce = new TicketsellIncomeReportSerivceImpl();
			setResultmap(incomereportserivce.CustomerBuyTicketSituation(
					ServletPropertyFilterUtil.buildFromHttpRequest(), isgroupbyroute, groupby, groupbywhat));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			e.getMessage();
		}
		return "json";
	}
	

	/**
	 * 售票营收统计表
	 * 数据取自表ticketsell ,ticketreturn ,ticketchange
	 */
	public String query() {
		try {
			incomereportserivce = new TicketsellIncomeReportSerivceImpl();
			System.out.println(sellstarttime);
			System.out.println(sellendtime);
			setResultmap(
					incomereportserivce.queryIncomeReport(sellorgid,sellerid,ticketstatus,ischangeticket,
							returnticketno,sellstartdatetime,sellenddatetime,departstartdate,departenddate,reportnum,sellstarttime,sellendtime,ticketoutletsid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			e.getMessage();
		}
		return "json";
	}

	/**
	 * 统计项目
	 * 
	 * @return
	 */
	public String ticketsellSearchby() {
		try {
			List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
			Map<String, Object> item1 = new HashMap<String, Object>();
			item1.put("id", "1");
			item1.put("value", "售票员营收");
			item1.put("code", "reportnum");
			result.add(item1);
			Map<String, Object> item2 = new HashMap<String, Object>();
			item2.put("id", "2");
			item2.put("value", "售票站营收");
			item1.put("code", "reportnum");
			result.add(item2);
			Map<String, Object> item3 = new HashMap<String, Object>();
			item3.put("id", "3");
			item3.put("value", "始发站营收");
			item1.put("code", "reportnum");
			result.add(item3);
			setTicketsellSearchbylist(result);
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
		}
		return "json";
	}
	
	/**
	 * 统计项目
	 * 
	 * @return
	 */
	public String queryCancel_return() {
		incomereportserivce = new TicketsellIncomeReportSerivceImpl();
		setResultmap(incomereportserivce.queryCancel_return(sellorgid,sellerid,ticketstatus,ischangeticket,returnticketno,sellstartdatetime,sellenddatetime,departstartdate,departenddate,reportnum,column1,column2,column3));
		return "json";
	}
	
	/**
	 * 售票点班线售票情况表
	 * @param propertyFilterList
	 * @return
	 */
	public String TicketoutletsSellReport() {
		try {
			incomereportserivce = new TicketsellIncomeReportSerivceImpl();
			setResultmap(incomereportserivce.qryTicketoutletsSellroute(ServletPropertyFilterUtil
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

	public List<Map<String, Object>> getTicketsellSearchbylist() {
		return ticketsellSearchbylist;
	}

	public void setTicketsellSearchbylist(
			List<Map<String, Object>> ticketsellSearchbylist) {
		this.ticketsellSearchbylist = ticketsellSearchbylist;
	}

	public String getSellorgid() {
		return sellorgid;
	}

	public void setSellorgid(String sellorgid) {
		this.sellorgid = sellorgid;
	}

	public Long getSellerid() {
		return sellerid;
	}

	public void setSellerid(String sellerid) {
		this.sellerid = Long.parseLong(sellerid);
	}

	public String getTicketstatus() {
		return ticketstatus;
	}

	public void setTicketstatus(String ticketstatus) {
		this.ticketstatus = ticketstatus;
	}

	public boolean isIschangeticket() {
		return ischangeticket;
	}

	public void setIschangeticket(boolean ischangeticket) {
		this.ischangeticket = ischangeticket;
	}

	public String getReturnticketno() {
		return returnticketno;
	}

	public void setReturnticketno(String returnticketno) {
		this.returnticketno = returnticketno;
	}

	public Date getSellstartdatetime() {
		return sellstartdatetime;
	}

	public void setSellstartdatetime(Date sellstartdatetime) {
		this.sellstartdatetime = sellstartdatetime;
	}

	public Date getSellenddatetime() {
		return sellenddatetime;
	}

	public void setSellenddatetime(Date sellenddatetime) {
		this.sellenddatetime = sellenddatetime;
	}

	public Date getDepartstartdate() {
		return departstartdate;
	}

	public void setDepartstartdate(Date departstartdate) {
		this.departstartdate = departstartdate;
	}

	public Date getDepartenddate() {
		return departenddate;
	}

	@As("yyyy-MM-dd HH:mm:ss")
	public void setDepartenddate(Date departenddate) {
		this.departenddate = departenddate;
	}

	public Long getReportnum() {
		return reportnum;
	}

	public void setReportnum(Long reportnum) {
		this.reportnum = reportnum;
	}

	public String getColumn1() {
		return column1;
	}

	public void setColumn1(String column1) {
		this.column1 = column1;
	}

	public String getColumn2() {
		return column2;
	}

	public void setColumn2(String column2) {
		this.column2 = column2;
	}

	public String getColumn3() {
		return column3;
	}

	public void setColumn3(String column3) {
		this.column3 = column3;
	}

	public void setSellerid(Long sellerid) {
		this.sellerid = sellerid;
	}

	public String getCancel_returnTicketno() {
		return cancel_returnTicketno;
	}

	public void setCancel_returnTicketno(String cancel_returnTicketno) {
		this.cancel_returnTicketno = cancel_returnTicketno;
	}

	public String getSellstarttime() {
		return sellstarttime;
	}

	public void setSellstarttime(String sellstarttime) {
		this.sellstarttime = sellstarttime;
	}

	public String getSellendtime() {
		return sellendtime;
	}

	public void setSellendtime(String sellendtime) {
		this.sellendtime = sellendtime;
	}
	
	public String getTicketoutletsid() {
		return ticketoutletsid;
	}

	public void setTicketoutletsid(String ticketoutletsid) {
		this.ticketoutletsid = ticketoutletsid;
	}


	public boolean isIsgroupbyroute() {
		return isgroupbyroute;
	}


	public void setIsgroupbyroute(boolean isgroupbyroute) {
		this.isgroupbyroute = isgroupbyroute;
	}


	public int getGroupby() {
		return groupby;
	}


	public void setGroupby(int groupby) {
		this.groupby = groupby;
	}


	public int getGroupbywhat() {
		return groupbywhat;
	}


	public void setGroupbywhat(int groupbywhat) {
		this.groupbywhat = groupbywhat;
	}

	
}
