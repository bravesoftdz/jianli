package cn.nova.bus.query.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.query.dao.AccountantReportDao;
import cn.nova.bus.query.service.AccountantReportService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：售票员售退废报表;客运班线动态表;客运班线动态同比表</b><br/>
 * <b>类名称：</b>AccountantReportServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-4-28  <br/>
 * <b>关键修改：修改售票员售退废报表</b><br/>
 * <b>修改时间：2012-06-29</b><br/>
 * <b>修改人：hhz</b><br/>
 */
public class AccountantReportServiceImpl implements AccountantReportService {

	private AccountantReportDao accountantReportDao = new AccountantReportDao();

	/**
	 *售票员售退废报表
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@Override
	public List<Map<String, Object>> querySellerDailyReport(
			List<PropertyFilter> propertyFilterList,boolean groupbydate,String paymethod) {
		accountantReportDao = new AccountantReportDao();
		return ListUtil.listToMap(new Object[] { "orgname", "username",
				 "opratedate", "sellcount","sellreturncount","sellprice", "fee",
				"returncount", "returnmoney", "chargesmoney", "canclecount",
				"cancleprice", "bookfee","totalprice", "changeservicefee", "allcount",
				"allmoney","eticketnum","changenum","cashmoneypayable","electronicpayment","nonvouchermoneypayable","totalfee" },
				accountantReportDao.querySellerDailyReport(propertyFilterList,groupbydate,paymethod),
				new Object[] { String.class, String.class,
						String.class, BigDecimal.class, BigDecimal.class,BigDecimal.class,BigDecimal.class, 
						BigDecimal.class, BigDecimal.class,BigDecimal.class, BigDecimal.class, 
						BigDecimal.class,BigDecimal.class, BigDecimal.class, BigDecimal.class,BigDecimal.class,
						BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
						BigDecimal.class});
	}

	/**
	 * 客运班线动态表
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@Override
	public List<Map<String, Object>> queryRouteDynamic(String orgids,
			Date startdate, Date enddate, String departorgs,String vehicletype,String districttype,String workways) {
		accountantReportDao = new AccountantReportDao();
		return ListUtil.listToMap(new Object[] { "name", "schnum", "seats",
				"ticketnum", "totalamount", "stationservicefee", "computefee",
				"coolairfee", "additionfee","firefee","waterfee",
				"insurefee","otherfee","totalfee", "agentfee", "balanceamount",
				"stationincome", "routedistance", "peopledistance", "rate",
				"seatrate", "incomerate","moreprice" }, accountantReportDao
				.queryRouteDynamic(orgids, startdate, enddate,departorgs,vehicletype,districttype,workways), new Object[] {
				String.class, BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class,BigDecimal.class,
				BigDecimal.class,BigDecimal.class,BigDecimal.class,
				BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, String.class, String.class, String.class, BigDecimal.class});
		
	}
	
	/**
	 * 客运班线动态同比表
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@Override
	public List<Map<String, Object>> qryRouteDynamicCompare(
			List<PropertyFilter> propertyFilterList,boolean isbyroute,boolean isbydate) {
		accountantReportDao = new AccountantReportDao();
		return ListUtil.listToMap(new Object[] { 
				"sellincome","sellincome1","sellincomeComp","sellincomePercent",
				"departdate","routename", "schnum", "seats",
				"ticketnum", "totalamount", "stationservicefee", "computefee",
				"coolairfee", "additionfee", "agentfee", "balanceamount",
				"stationincome", "routedistance", "peopledistance", "rate",
				"seatrate", "incomerate",
				"schnum1", "schnumComp","schnumPercent",
				"seats1","seatsComp","seatsPercent",
				"ticketnum1","ticketnumComp","ticketnumPercent",
				"totalamount1","totalamountComp","totalamountPercent",
				"stationservicefee1","stationservicefeeComp","stationservicefeePercent",
				"computefee1","computefeeComp","computefeePercent",
				"coolairfee1","coolairfeeComp","coolairfeePercent",
				"additionfee1","additionfeeComp","additionfeePercent",
				"agentfee1","agentfeeComp","agentfeePercent",
				"balanceamount1","balanceamountComp","balanceamountPercent",
				"stationincome1","stationincomeComp","stationincomePercent",
				"routedistance1","routedistanceComp","routedistancePercent",
				"peopledistance1","peopledistanceComp","peopledistancePercent",
				"rate1","rateComp","ratePercent",
				"seatrate1","seatrateComp","seatratePercent",
				"incomerate1","incomerateComp","incomeratePercent"},
				accountantReportDao.queryRouteDynamicCompare(propertyFilterList,isbyroute,isbydate)
				, new Object[] {	
			BigDecimal.class,BigDecimal.class,String.class,String.class,
			Date.class,String.class, long.class, long.class, long.class,
			BigDecimal.class, BigDecimal.class, BigDecimal.class,
			BigDecimal.class, BigDecimal.class, BigDecimal.class,
			BigDecimal.class, BigDecimal.class, BigDecimal.class,
			BigDecimal.class, String.class, String.class, String.class,
			long.class, long.class, String.class,
			long.class,long.class,String.class,
			long.class,long.class, String.class,
			BigDecimal.class,BigDecimal.class,String.class,
			BigDecimal.class,BigDecimal.class,String.class,
			BigDecimal.class,BigDecimal.class,String.class,
			BigDecimal.class, BigDecimal.class,String.class,
			BigDecimal.class, BigDecimal.class,String.class,
			BigDecimal.class,BigDecimal.class,String.class,
			BigDecimal.class, BigDecimal.class,String.class,
			BigDecimal.class, BigDecimal.class,String.class,
			BigDecimal.class,BigDecimal.class,String.class,
			BigDecimal.class, BigDecimal.class,String.class,
			String.class, String.class,String.class,
			String.class, String.class,String.class,
			String.class,String.class,String.class }
		);
	}

}
