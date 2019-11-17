package cn.nova.bus.report.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.dao.FinancialReportDao;
import cn.nova.bus.report.service.FinancialReportService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * 
 * <b>类描述：财务报表DAO</b><br/>
 * <b>类名称：</b>FinancialReportService<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>主要模块：班线结算统计表:scheduleRouteBalanceRpt。
 * 				各站互售互退营收汇总表:eachTickeIncomeSumRpt 
 * 				财务收支平衡表:FinancialBalanceRpt
 * 				财物收支月平衡表:FinancialBalanceMonthRpt
 * 				运量单运量台账:DepartInvoincesRpt</b><br/>
 * <b>关键修改：添加 班线结算统计表:scheduleRouteBalanceRpt。
 * 				各站互售互退营收汇总表eachTickeIncomeSumRpt
 * <b>修改内容： 添加运量单运量台账DepartInvoincesRpt</b><br/> 
 * <b>修改时间： 2013-05-20</b><br/>
 * <b>修改人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * 
 * 
 */
public class FinancialReportServiceImpl implements FinancialReportService {
	private FinancialReportDao financialReportdao = new FinancialReportDao();
	/**
	 * 班线结算统计表
	 * 
	 * @param
	 * @return
	 */
	@Override
	public List<Map<String, Object>> scheduleRouteBalanceRpt(String orgids,
			Date startdate, Date enddate, Long vehicleid, Long stationid) {
		financialReportdao = new FinancialReportDao();
		List<Object> list = financialReportdao.scheduleRouteBalanceRpt(orgids,
				startdate, enddate, vehicleid, stationid);
		return ListUtil.listToMap(new Object[] { "endname", "ticketypename",
				"price", "distance", "peopledistance", "ticketnum", "allprice",
				"date1", "date2", "date3", "date4", "date5", "date6", "date7",
				"date8", "date9", "date10", "date11", "date12", "date13",
				"date14", "date15", "date16", "date17", "date18", "date19",
				"date20", "date21", "date22", "date23", "date24", "date25",
				"date26", "date27", "date28", "date29", "date30", "date31",
				"Bdate1", "Bdate2", "Bdate3", "Bdate4", "Bdate5", "Bdate6",
				"Bdate7", "Bdate8", "Bdate9", "Bdate10", "Bdate11", "Bdate12",
				"Bdate13", "Bdate14", "Bdate15", "Bdate16", "Bdate17",
				"Bdate18", "Bdate19", "Bdate20", "Bdate21", "Bdate22",
				"Bdate23", "Bdate24", "Bdate25", "Bdate26", "Bdate27",
				"Bdate28", "Bdate29", "Bdate30", "Bdate31" }, list,
				new Object[] { String.class, String.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, Long.class,
						BigDecimal.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Long.class });
	}

	/**
	 * 各站互售互退营收汇总表
	 * 
	 * @param
	 * @return
	 */
	public List<Map<String, Object>> eachTickeIncomeSumRpt(
			List<PropertyFilter> propertyFilterList) {
		financialReportdao = new FinancialReportDao();
		return ListUtil.listToMap(
				new Object[] { "sellorg", "scheduleorg", "sellnum",
						"sellprice", "returnnum", "returnprice", "returnfee",
						"canclenum", "cancleprice", "allnum", "allprice" },
				financialReportdao.eachTickeIncomeSumRpt(propertyFilterList),
				new Object[] { String.class, String.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class });
	}

	/**
	 * 财务收支平衡表
	 * 
	 * @param
	 * @return
	 */
	public List<Map<String, Object>> FinancialBalanceRpt(String orgid,
			Date startdate, Date enddate) {
		financialReportdao = new FinancialReportDao();
		return ListUtil.listToMap(new Object[] { "opdate", "orgname",
				"daysellpassnum", "daysellpassprice", "dayselldaynum",
				"dayselldayprice", "daysellprenum", "daysellpreprice",
				"daysellpassdayreturnnum", "daysellpassdayreturnprice",
				"dayselldayreturnnum", "dayselldayreturnprice",
				"daysellpredayreturnnum", "daysellpredayreturnprice",
				"daysellprereturnnum", "daysellprereturnprice",
				"daysellpassdaycancelnum", "daysellpassdaycanceprice",
				"dayselldaycancelnum", "dayselldaycanceprice",
				"daysellpredaycancelnum", "daysellpredaycanceprice",
				"daysellprecancelnum", "daysellprecancelprice", "daysellnum",
				"daysellprice", "passselldaynum", "passselldayprice",
				"perselldaynum", "perselldayprice", "passreturndaynum",
				"dayreturnnum", "dayreturnprice", "passreturndayprice",
				"passsellpredayreturnnum", "passsellpredayreturnprice",
				"passselldaycancelnum", "passselldaycancelprice",
				"passsellpredaycancelnum", "passsellpredaycancelprice",
				"daycancelnum", "daycancelprice", "departnum", "departprice",
				"missnum", "missprice", "incomenum", "incomeprice",
				"dayselldayprereturnnum", "dayselldayprereturnprice",
				"dayselldayprecancenum", "dayselldayprecanceprice" },
				financialReportdao.FinancialBalanceRpt(orgid, startdate,
						enddate), new Object[] { Date.class, String.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class });
	}
	

	/**
	 * 财务收支月平衡表
	 * 
	 * @param
	 * @return
	 */
	public List<Map<String, Object>> FinancialBalanceMonthRpt(String orgid,
			Date startdate, Date enddate) {
		financialReportdao = new FinancialReportDao();
		return ListUtil.listToMap(new Object[] { "opdate", "orgname",
				"daysellpassnum", "daysellpassprice", "dayselldaynum",
				"dayselldayprice", "daysellprenum", "daysellpreprice",
				"daysellpassdayreturnnum", "daysellpassdayreturnprice",
				"dayselldayreturnnum", "dayselldayreturnprice",
				"daysellpredayreturnnum", "daysellpredayreturnprice",
				"daysellprereturnnum", "daysellprereturnprice",
				"daysellpassdaycancelnum", "daysellpassdaycanceprice",
				"dayselldaycancelnum", "dayselldaycanceprice",
				"daysellpredaycancelnum", "daysellpredaycanceprice",
				"daysellprecancelnum", "daysellprecancelprice", "daysellnum",
				"daysellprice", "passselldaynum", "passselldayprice",
				"perselldaynum", "perselldayprice", "passreturndaynum",
				"dayreturnnum", "dayreturnprice", "passreturndayprice",
				"passsellpredayreturnnum", "passsellpredayreturnprice",
				"passselldaycancelnum", "passselldaycancelprice",
				"passsellpredaycancelnum", "passsellpredaycancelprice",
				"daycancelnum", "daycancelprice", "departnum", "departprice",
				"missnum", "missprice", "incomenum", "incomeprice",
				"dayselldayprereturnnum", "dayselldayprereturnprice",
				"dayselldayprecancenum", "dayselldayprecanceprice",
				"passsellpassdaycencelnum", "passsellpassdaycencelprice",
				"passsellpassdayreturnnum","passsellpassdayreturnprice",
				"moneypayable","returnhandcharge","servicefee",
				"bookservicefee","changeservicefee","sellpeople",
				"sellothernum","sellotherprice","sellotherreturnnum",
				"sellotherreturnprice","selllocalnum","selllocalprice",
				"selllocalreturnnum","selllocalreturnprice","totalfee",
				"a1","a2","a3","a6","b7","a9","b9"},
				financialReportdao.FinancialBalanceMonthRpt(orgid, startdate,
						enddate), new Object[] { String.class, String.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class, 
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class,BigDecimal.class,
						BigDecimal.class, BigDecimal.class,BigDecimal.class,
						BigDecimal.class,BigDecimal.class,BigDecimal.class,
						
						BigDecimal.class,BigDecimal.class,BigDecimal.class,
						BigDecimal.class,BigDecimal.class,BigDecimal.class,
						BigDecimal.class});
	}

	/**
	 * 运量单运量台账
	 */
	@Override
	public List<Map<String, Object>> DepartInvoincesRpt(Date startdate,Date enddate, int departinvoicestype,String printorgid, 
			List<PropertyFilter> propertyFilterList) {
		financialReportdao = new FinancialReportDao();
		if(propertyFilterList!=null && propertyFilterList.size() >0){
			for(int i=propertyFilterList.size()-1;i>=0;i--){	
				PropertyFilter propertyFilter=propertyFilterList.get(i);
				if("s!id".equals(propertyFilter.getPropertyFullName())){
					long id= (Long) propertyFilter.getMatchValue();
					if(id>0){
						String schedulecode=financialReportdao.queryScheduleCode(id);
						PropertyFilter propertyFilter_new =new PropertyFilter("LIKES_s!code",schedulecode);
						propertyFilterList.remove(propertyFilter);
						propertyFilterList.add(propertyFilter_new);			
					}
				}
			}

		}
		return ListUtil.listToMap(new Object[] { 
				"departinvoicesno","rname","schedulecode","districttypename","isovertime",
				"printtime","departdate","departtime","vehicleno",
				"printbyname","totalamount","stationservicefee",
				"computefee","coolairfee","additionfee","waterfee",
				"insurefee","otherfee","fueladditionfee","jbffee","agentfee",
				"balanceamount","peopledistance","ticketnum",
				"fullnum", "halfnum", "shortnum", 
				"middlenum","longnum", "totalnum","allcountfee","dptype"},
				financialReportdao.DepartInvoincesRpt(startdate,enddate,departinvoicestype,printorgid,propertyFilterList),
			new Object[] { 
			String.class, String.class, String.class,String.class,boolean.class,
			String.class,Date.class, String.class, String.class,
			String.class,BigDecimal.class,BigDecimal.class,
			BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
			BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
			BigDecimal.class,BigDecimal.class,Long.class,Long.class,
			Integer.class, Integer.class,Integer.class, 
			Integer.class, Integer.class,Integer.class,BigDecimal.class,String.class });
	}
	
	/**
	 * 客运收入、支出平衡表-赣州
	 * 
	 * @param
	 * @return
	 */
	@Override
	public List<Map<String, Object>> FinancialBalanceGZ(String orgid,
			Date startdate, Date enddate) {
		financialReportdao = new FinancialReportDao();
		return ListUtil.listToMap(new Object[] { 
				"opdate","name","a","b","passselldayprice",
				"allmoney","balanceamount","agentfee","subtotal",
				"missprice","daysellpreprice","daysellprereturnprice",
				"daysellprecancelprice","persellprice","servicefee",
				"returnhandcharge","bookservicefee","changeservicefee",
				"waterfee","insurefee","otherfee","fueladditionfee",
                "stationservicefee" ,"additionfee" ,"computefee",
                "coolairfee","totalfee"},
			financialReportdao.FinancialBalanceGZ(orgid,startdate,enddate),
			new Object[] { 
			String.class, String.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
			BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
			BigDecimal.class,BigDecimal.class,BigDecimal.class,
			BigDecimal.class,BigDecimal.class ,BigDecimal.class,
			BigDecimal.class,BigDecimal.class ,BigDecimal.class,
			BigDecimal.class,BigDecimal.class ,BigDecimal.class,
			BigDecimal.class,BigDecimal.class ,BigDecimal.class,
			BigDecimal.class,BigDecimal.class ,BigDecimal.class });
	}
	
	/**
	 *  单位营收统计表-赣州
	 * 
	 * @param
	 * @return
	 */
	@Override
	public List<Map<String, Object>> IncomeReportGZ(String orgid, Long routeid,
			Date startdate, Date enddate) {
		financialReportdao = new FinancialReportDao();
		return ListUtil.listToMap(new Object[] { 
				"orgname","routename",
				"countsellnum","countsellprice","countreturnnum",
				"countreturnprice","countcancelnum","countcancleprice",
				"returncharges","sellnum","sellprice",
				"missnum","misprice","countpage",
				"totalamount","ticketnum","stationservicefee","computefee",
				"coolairfee","additionfee","basefee",
				"agentfee","balanceamount","waterfee",
				"insurefee","otherfee","fueladditionfee",
				"moreprice","subtotal"},
			financialReportdao.IncomeReportGZ(orgid,routeid,startdate,enddate),
			new Object[] { 
			String.class, String.class,
			BigDecimal.class,BigDecimal.class,BigDecimal.class,
			BigDecimal.class,BigDecimal.class,BigDecimal.class,
			BigDecimal.class,BigDecimal.class,BigDecimal.class,
			BigDecimal.class,BigDecimal.class ,BigDecimal.class,
			BigDecimal.class,BigDecimal.class ,BigDecimal.class ,BigDecimal.class,
			BigDecimal.class,BigDecimal.class ,BigDecimal.class,
			BigDecimal.class,BigDecimal.class ,BigDecimal.class,
			BigDecimal.class,BigDecimal.class ,BigDecimal.class,
			BigDecimal.class,BigDecimal.class});
	}
	
	//班次日结算表
	@Override
	public List<Map<String, Object>> qryScheduleBalancePrice(String sellorgids,long routeid,Date startdate, Date enddate,
			String workways,int isovertime) {
		financialReportdao = new FinancialReportDao();
		return ListUtil.listToMap(new Object[] { "code", "departtime",
				"reachname", "VEHICLENO", "ticketnum", "ticketprice",
				"departnum", "balanceprice","totalprice", 
//				"hcdepartnum", "hcbalanceprice",
				"lostnum", "lostprice", "zwticketnum", "zwprice","hjsellticketnum","hjsellticketprice",
				"hjdepartnum","hjdepartprice", "remark","unitname" },
				financialReportdao.qryScheduleBalancePrice(sellorgids, routeid,
						startdate,enddate, workways,isovertime), new Object[] { String.class,
						String.class, String.class, String.class, int.class,
						BigDecimal.class, int.class, BigDecimal.class,BigDecimal.class,
				//		int.class, BigDecimal.class,
						int.class, BigDecimal.class, int.class,
						BigDecimal.class,	int.class, BigDecimal.class,
						int.class, BigDecimal.class,String.class,String.class });
	}
	//线路日结算表
	@Override
	public List<Map<String, Object>> qryRouteBalancePrice(String sellorgids,long routeid,Date startdate, Date enddate,
			String workways) {
		financialReportdao = new FinancialReportDao();
		return ListUtil.listToMap(
				new Object[] {  "reachname", "sellnum", "totalprice",
						"localsch", "localdepartnum", "localbalanceprice",
						"syncsch", "syncdepartnum", "syncbalanceprice",
						"totalsch", "totaldepartnum", "totalbalanceprice",
						"lostnum", "lostprice", "zwbsticketnum", "zwbstotalmoney","zwwsticketnum","zwwstotalmoney",
						"fcticketnum","fcbalanceprice","fcstationservicefee", "hjsellnum", "hjtotalmoney" },
				financialReportdao.qryRouteBalancePrice(sellorgids, routeid,
						startdate, enddate, workways), new Object[] {
						 String.class, int.class,BigDecimal.class,
						 int.class, int.class,BigDecimal.class,
						 int.class,int.class,BigDecimal.class,
						 int.class, int.class,BigDecimal.class,
						 int.class, BigDecimal.class,int.class, BigDecimal.class,int.class, BigDecimal.class, 
						 int.class,BigDecimal.class, BigDecimal.class, int.class, BigDecimal.class });

	}
	
	@Override
	public List<Map<String, Object>> qryRouteBalanceIncome(Date startdate, Date enddate,Long scheduleid,Long routeid,Long stationid,Boolean isroutegroup,Boolean isstationgroup,Boolean isschedulegroup)
	{
		financialReportdao = new FinancialReportDao();
		String schedulecode="";
		if(scheduleid>0){
			schedulecode = financialReportdao.queryScheduleCode(scheduleid);
		}
		return ListUtil.listToMap(new Object[] { "name", "schedulename","reachname","schedulenum",
				"zxzdepartnum", "zxzbalanceprice", "ctzdepartnum",
				"ctzbalanceprice", "hcdepartnum", "hcbalanceprice",
				"totaldepartnum", "totalbalanceprice", "zwticketnum", "zwtotalmoney",
				"hjdepartnum", "hjbalanceprice","nonhjdepartnum","nonhjbalanceprice" },
				financialReportdao.qryRouteBalanceIncome(startdate,enddate,schedulecode,routeid,stationid,isroutegroup,isstationgroup,isschedulegroup),
				new Object[] { String.class, String.class,String.class,int.class, int.class,
						BigDecimal.class, int.class, BigDecimal.class,
						int.class, BigDecimal.class, int.class,
						BigDecimal.class, int.class, BigDecimal.class,
						int.class, BigDecimal.class,int.class, BigDecimal.class });
	}
}
