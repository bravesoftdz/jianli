package cn.nova.bus.report.service;

import java.util.Date;
import java.util.List;
import java.util.Map;



/**
 * <b>类描述：线路售票统计表</b><br/>
 * <b>类名称：</b>RoutesellerIncomeService.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 */
public interface RoutesellerIncomeService {

	/**
	 * 线路售票统计表
	 * @param seller 
	 * @param scheduleid 
	 * @param iscodegroup 
	 * @param String
	 *       orgids,Date startdate,Date enddate, Boolean issellgroup 
	 * @return
	 */
	public List<Map<String, Object>> queryRouteIncome(String orgids, Date startdate, Date enddate, 
			Boolean issellgroup, Long seller, Boolean isstationgroup,Boolean isroutegroup,String districttype,Boolean isworkwaysgroup,String workways,Long stationid,Long routeid, Boolean iscodegroup, Long scheduleid, Long ticketoutletsid, Boolean isticketoutletsgroup) ;

}
