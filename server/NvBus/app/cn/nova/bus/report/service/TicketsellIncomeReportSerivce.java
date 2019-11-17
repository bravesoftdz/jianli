package cn.nova.bus.report.service;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.utils.orm.PropertyFilter;

/**
 * <b>类描述：售票报表</b><br/>
 * <b>类名称：</b>TicketsellIncomeReportSerivce.java<br/>
 * <b>功能模块：</b>1，售票营收统计表<br/>
 *             </b>2，售票点班线售票情况表<br/>
 * <b>创建人：</b><a href="mailto:liaojunchang@nova.net.cn">廖俊昌</a><br/>
 * <b>创建时间：</b>2012-09-05<br/>
 * <b>关键修改：添加报表</b><br/>
 * <b>修改时间：2013-11-22</b><br/>
 * <b>修改人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz<br/>
 */
public interface TicketsellIncomeReportSerivce {
	
	/**
	 * 营收运量统计表
	 * @param sellendtime 
	 * @param sellstarttime 
	 * @param month
	 * @param checkstationid
	 * @param routeid
	 * @param unitid
	 * @return
	 */
	public List<Map<String, Object>> queryIncomeReport(String sellorgid,Long sellerid,String ticketstatus ,
			boolean ischangeticket,String returnticketno,Date sellstartdatetime,Date sellenddatetime,Date departstartdate,Date departenddate,Long reportnum, String sellstarttime, String sellendtime, String ticketoutletsid);
	
	public List<Map<String, Object>> queryCancel_return(String sellorgid,Long sellerid,String ticketstatus ,
			boolean ischangeticket,String returnticketno,Date sellstartdatetime,Date sellenddatetime,Date departstartdate,Date departenddate,Long reportnum,String column1,String column2,String column3);
	
	/**
	 * 售票点班线售票情况表
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> qryTicketoutletsSellroute(List<PropertyFilter> propertyFilterList);

	public List<Map<String, Object>> CustomerBuyTicketSituation(List<PropertyFilter> buildFromHttpRequest,
			boolean isgroupbyroute, int groupby, int groupbywhat);
	
}
