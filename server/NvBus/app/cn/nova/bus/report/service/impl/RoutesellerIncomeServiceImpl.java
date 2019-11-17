/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.report.service<br/>
 * <b>文件名：</b>RoutesellerIncomeServiceImpl.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b> 2012-11-29  <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.dao.RoutesellerIncomeDao;
import cn.nova.bus.report.service.RoutesellerIncomeService;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：线路售票统计表</b><br/>
 * <b>类名称：</b>RoutesellerIncomeServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b>2012-11-29</b> <br/>
 */
public class RoutesellerIncomeServiceImpl implements RoutesellerIncomeService {

	private RoutesellerIncomeDao routesellerIncomeDao = new RoutesellerIncomeDao();

	/**
	 * 线路售票统计表
	 * 
	 * @param String
	 *            orgids,Date startdate,Date enddate, Boolean issellgroup
	 * @return
	 */
	@Override
	public List<Map<String, Object>> queryRouteIncome(String orgids,
			Date startdate, Date enddate, Boolean issellgroup, Long seller,
			Boolean isstationgroup, Boolean isroutegroup, String districttype,
			Boolean isworkwaysgroup, String workways, Long stationid,
			Long routeid, Boolean iscodegroup, Long scheduleid,
			Long ticketoutletsid, Boolean isticketoutletsgroup) {
		routesellerIncomeDao = new RoutesellerIncomeDao();
		return ListUtil.listToMap(new Object[] { "routename",
				"stationname", "sellname", "workwaysname", "ticketoutletsname",
				"totalprice", "totalnum", "stationservicefee",
				"fueladditionfee", "computefee", "coolairfee", "additionfee",
				"waterfee", "insurefee", "otherfee", "totalfee", "incomeprice",
				"ticketnum", "ticketprice", "halfticketnum", "halfticketprice",
				"studentticketnum", "studentticketprice", "discountticketnum",
				"discountticketprice", "returnnum", "returnprice",
				"returncharges", "cancelnum", "cancelprice", "revenueprice",
				"changenum", "changeservicefee", "totalpersonnum",
				"nonfactpeoplenum", "xianjinprice", "factpeoplenum",
				"totalpeopleprice", "netprice", "code" }, routesellerIncomeDao
				.queryRouteIncome(orgids, startdate, enddate, issellgroup,
						seller, isstationgroup, isroutegroup, districttype,
						isworkwaysgroup, workways, stationid, routeid,
						iscodegroup, scheduleid, ticketoutletsid,
						isticketoutletsgroup), new Object[] { String.class,
				String.class, String.class, String.class, String.class,
				BigDecimal.class, Long.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				Long.class, BigDecimal.class, Long.class, BigDecimal.class,
				Long.class, BigDecimal.class, Long.class, BigDecimal.class,
				Long.class, BigDecimal.class, Long.class, Long.class,
				BigDecimal.class, BigDecimal.class, Long.class,
				BigDecimal.class, Long.class, Long.class, BigDecimal.class,
				Long.class, BigDecimal.class, BigDecimal.class, String.class });
	}
}
