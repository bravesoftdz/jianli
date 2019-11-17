package cn.nova.bus.report.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.dao.SalerRevenueDao;
import cn.nova.bus.report.dao.TicketsellbysalerdayDao;
import cn.nova.bus.report.param.Reportparam;
import cn.nova.bus.report.service.SalerRevenueService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * 
 * <p>
 * Title: 营收报表服务接口
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2011
 * </p>
 * <p>
 * Company: nova
 * </p>
 * 
 * @author lanckun
 * @version 0.1
 */
public class SalerRevenueServiceImpl implements SalerRevenueService {

	private SalerRevenueDao salerRevenueDao = new SalerRevenueDao();

	/**
	 * 售票员售票情况日报表
	 * 
	 * @param String
	 *            orgids,Date startdate,Date enddate
	 * @param boolean isbyseller ,boolean isbyserlldate
	 * @return
	 */

	@Override
	public List<Map<String, Object>> querySalerdayRevenue(String orgids,
			Date startdate, Date enddate, boolean isbyseller,
			boolean isbyselldate,String sellerids,String ticketoutletid,String paymethod) {
		TicketsellbysalerdayDao salerRevenueDao=new TicketsellbysalerdayDao();
		return ListUtil.listToMap(new Object[] { "code", "name", "orgname",
				"selldate", "ticketoutlet", "paymethod", "datescheduleincome",
				"sellnum", "normalnum", "totalprice", "cancelnum",
				"cancelmoeny", "returnnum", "returnprice","returncustomerprice", "returnfee",
				"fueladditionfee", "servicefee", "nomalsellnum",
				"nomaltotalprice", "stationservicefee", "computefee",
				"coolairfee", "additionfee", "totalfee", "badnum", "upmoney",
				"moreprice", "waterfee", "insurefee", "otherfee",
				"stationincome","takeeticketnum", "changenum", "adjustnum", "damagednum",
				"ticketreturnnum", "totalusenum" }, salerRevenueDao
				.querySalerdayRevenue(orgids, startdate, enddate, isbyseller,
						isbyselldate, sellerids, ticketoutletid, paymethod),
				new Object[] { String.class, String.class, String.class,
						Date.class, String.class, String.class,
						BigDecimal.class, Integer.class, Integer.class,
						BigDecimal.class, Integer.class, BigDecimal.class,
						Integer.class, BigDecimal.class, BigDecimal.class,BigDecimal.class,
						BigDecimal.class, BigDecimal.class, long.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						long.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, Integer.class, Integer.class, Integer.class,
						Integer.class, Integer.class, Integer.class });
		
		/*salerRevenueDao = new SalerRevenueDao();
		return ListUtil.listToMap(new Object[] { "code", "name", "orgname",
				"selldate", "datescheduleincome", "sellnum","normalnum", "totalprice",
				"cancelnum", "cancelmoeny", "returnnum", "returnprice","returnfee",
				"fueladditionfee", "servicefee", "nomalsellnum", "nomaltotalprice",
				"stationservicefee", "computefee", "coolairfee", "additionfee",
				"totalfee", "badnum", "upmoney", "moreprice", "waterfee",
				"insurefee", "otherfee", "stationincome","ticketoutlet"
				//【改签凭证数】【补票凭证数】【 坏票数】【 退票数】【 总张数】  李电志2016年4月27日 15:57:07
				,"changenum","adjustnum","damagednum","ticketreturnnum","totalusenum","paymethod" 
		}, salerRevenueDao
				.querySalerdayRevenue(orgids, startdate, enddate, isbyseller,
						isbyselldate,sellerids,ticketoutletid,paymethod), new Object[] { String.class,
				String.class, String.class, Date.class, BigDecimal.class,
				Integer.class,Integer.class, BigDecimal.class, Integer.class, BigDecimal.class,
				Integer.class, BigDecimal.class, BigDecimal.class,BigDecimal.class,
				BigDecimal.class, long.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, long.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,String.class
				,Integer.class ,Integer.class ,Integer.class ,Integer.class ,Integer.class,String.class
		});*/
	}

	/**
	 * 本站售异站汇总表
	 * 
	 * @param String
	 *            orgids,Date startdate,Date enddate
	 * @return
	 */
	@Override
	public List<Map<String, Object>> querySalerSyncOrgRevenue(String orgids,
			Date startdate, Date enddate, long orgid,String datetype,long currorgid, Boolean isgroupbyday, String besaleorgids) {
		salerRevenueDao = new SalerRevenueDao();
		if(isgroupbyday){
		return ListUtil.listToMap(new Object[] { "sellorgname","orgname","selldate","departdate", "sellnum",
				"totalprice", "returnnum", "returnprice","returnfee", "cancelnum",
				"cancelmoeny", "receivemoney","divideprice","payprice", 
				"stationservicefee", "computefee",//"synreturnsynnum","synreturnsynprice",
				"coolairfee", "additionfee","insurefee", "waterfee","otherfee", "totalfee", 
				"baseprice",//"localincome",  
//				"moreprice", 
				"fueladditionfee" }, salerRevenueDao
				.querySalerSyncOrgRevenue(orgids, startdate, enddate, orgid,datetype,currorgid,isgroupbyday,besaleorgids),
				new Object[] { String.class, String.class,Date.class,Date.class, long.class, 
					BigDecimal.class,long.class, BigDecimal.class,BigDecimal.class, long.class,
						BigDecimal.class,BigDecimal.class, BigDecimal.class,BigDecimal.class, //long.class,
						BigDecimal.class, BigDecimal.class, //BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, 
						BigDecimal.class, BigDecimal.class, BigDecimal.class });//,BigDecimal.class, BigDecimal.class
		}else{
			return ListUtil.listToMap(new Object[] { "sellorgname","orgname", "sellnum",
					"totalprice", "returnnum", "returnprice","returnfee", "cancelnum",
					"cancelmoeny", "receivemoney","divideprice","payprice", 
					"stationservicefee", "computefee",//"synreturnsynnum","synreturnsynprice",
					"coolairfee", "additionfee","insurefee", "waterfee","otherfee", "totalfee", 
					"baseprice",//"localincome",  
//					"moreprice", 
					"fueladditionfee" }, salerRevenueDao
					.querySalerSyncOrgRevenue(orgids, startdate, enddate, orgid,datetype,currorgid,isgroupbyday,besaleorgids),
					new Object[] { String.class, String.class, long.class, 
						BigDecimal.class,long.class, BigDecimal.class,BigDecimal.class, long.class,
							BigDecimal.class,BigDecimal.class, BigDecimal.class,BigDecimal.class, //long.class,
							BigDecimal.class, BigDecimal.class, //BigDecimal.class,
							BigDecimal.class, BigDecimal.class, BigDecimal.class,
							BigDecimal.class, BigDecimal.class, 
							BigDecimal.class, BigDecimal.class, BigDecimal.class });//,BigDecimal.class, BigDecimal.class	
		}
		
	}

	@Override
	public List<Map<String, Object>> querySyncOrg(long orgid) {
		salerRevenueDao = new SalerRevenueDao();
		return ListUtil.listToMap(new Object[] { "id", "name", "code" },
				salerRevenueDao.querySyncOrg(orgid), new Object[] { long.class,
						String.class, String.class });
	}

	/**
	 * 异站售本站汇总表
	 * 
	 * @param String
	 *            orgids,Date startdate,Date enddate
	 * @return
	 */
	@Override
	public List<Map<String, Object>> querySyncSaleLocal(String orgids,
			Date startdate, Date enddate, String schorgids,String datetype,long currorgid, Boolean isolddate, Boolean isgroupbyday) {
		salerRevenueDao = new SalerRevenueDao();
		if(isgroupbyday){
		return ListUtil.listToMap(new Object[] { "sellorgname","orgname", "selldate","sellnum",
				"totalprice", "returnnum", "returnprice", "returnfee","cancelnum",
				"cancelmoeny", "receivemoney","divideprice",
				"localincome","payprice","stationservicefee", "computefee",
				"coolairfee", "additionfee","insurefee", 
				"waterfee", "otherfee","fueladditionfee","totalfee", "baseprice","manualreturnnum","manualreturnmoney"
				 }, salerRevenueDao.querySyncSaleLocal(
				orgids, startdate, enddate, schorgids,datetype,currorgid,isolddate,isgroupbyday), new Object[] {
				String.class,String.class,Date.class, long.class, 
				BigDecimal.class, long.class,BigDecimal.class,BigDecimal.class, long.class, 
				BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
				BigDecimal.class, BigDecimal.class,BigDecimal.class, 
				BigDecimal.class,BigDecimal.class, BigDecimal.class,
				BigDecimal.class,BigDecimal.class, BigDecimal.class, BigDecimal.class,BigDecimal.class,
				BigDecimal.class,BigDecimal.class
				});
		}else{
			return ListUtil.listToMap(new Object[] { "sellorgname","orgname","sellnum",
					"totalprice", "returnnum", "returnprice", "returnfee","cancelnum",
					"cancelmoeny", "receivemoney","divideprice",
					"localincome","payprice","stationservicefee", "computefee",
					"coolairfee", "additionfee","insurefee", 
					"waterfee", "otherfee","fueladditionfee","totalfee", "baseprice","manualreturnnum","manualreturnmoney"
					 }, salerRevenueDao.querySyncSaleLocal(
					orgids, startdate, enddate, schorgids,datetype,currorgid,isolddate,isgroupbyday), new Object[] {
					String.class,String.class, long.class, 
					BigDecimal.class, long.class,BigDecimal.class,BigDecimal.class, long.class, 
					BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
					BigDecimal.class, BigDecimal.class,BigDecimal.class, 
					BigDecimal.class,BigDecimal.class, BigDecimal.class,
					BigDecimal.class,BigDecimal.class, BigDecimal.class, BigDecimal.class,BigDecimal.class,
					BigDecimal.class,BigDecimal.class
					});
		}
	}

	/**
	 * 客运站划拨明细表
	 * 
	 * @param String
	 *            orgids,Date startdate,Date enddate
	 * @return
	 */
	@Override
	public List<Map<String, Object>> queryInvoincesDetail(String orgids,
			List<PropertyFilter> propertyFilterList) {
		salerRevenueDao = new SalerRevenueDao();
		//遍历propertyFilterList
		if(propertyFilterList!=null && propertyFilterList.size() >0){
			for(int i=propertyFilterList.size()-1;i>=0;i--){	
				PropertyFilter propertyFilter=propertyFilterList.get(i);
				if("s!id".equals(propertyFilter.getPropertyFullName())){
					long id= (Long) propertyFilter.getMatchValue();
					if(id>0){
						String schedulecode=salerRevenueDao.queryScheduleCode(id);
						PropertyFilter propertyFilter_new =new PropertyFilter("LIKES_s!code",schedulecode);
						propertyFilterList.remove(propertyFilter);
						propertyFilterList.add(propertyFilter_new);			
					}
				}
			}
		}
		return ListUtil.listToMap(new Object[] { "departdate", "invoinceno",
				"departtime", "routename", "code", "vehicleno", "ticketnum",
				"totalamount", "stationservicefee", "computefee", "coolairfee",
				"additionfee", "basefee", "agentfee", "balanceamount",
				"unitname", "balaceunitname", "remark", "printtime",
				"typename", "peopledistance", "waterfee", "insurefee",
				"otherfee", "fueladditionfee", "subtotal", "moreprice" },
				salerRevenueDao
						.queryInvoincesDetail(orgids, propertyFilterList),
				new Object[] { Date.class, String.class, String.class,
						String.class, String.class, String.class, long.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, String.class,
						String.class, String.class, Timestamp.class,
						String.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class });
	}

	/**
	 * 各分公司划拨汇总表
	 * 
	 * @param
	 * @return
	 */
	@Override
	public List<Map<String, Object>> queryBalanceUnitInvoinces(String orgids,
			int type, List<PropertyFilter> propertyFilterList) {
		salerRevenueDao = new SalerRevenueDao();
		return ListUtil.listToMap(new Object[] { "name", "balanceunit",
				"unitname", "invoicesnonum", "schedulenum", "ticketnum",
				"totalamount", "stationservicefee", "computefee", "coolairfee",
				"additionfee", "fuelfee", "otherfee", "insurefee", "waterfee",
				"basemount", "agentfee", "subtotal", "income", "balanceamount",
				"moreprice" }, salerRevenueDao.queryBalanceUnitInvoinces(
				orgids, type, propertyFilterList), new Object[] { String.class,
				String.class, String.class, Integer.class, Integer.class,
				Integer.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class });
	}

	/**
	 * 客运站结算汇总表
	 * 
	 * @param
	 * @return
	 */
	@Override
	public List<Map<String, Object>> queryStationBalanceInvoinces(Reportparam rp) {
		salerRevenueDao = new SalerRevenueDao();
		List<Object> list = null;
		//取出班次id
		Long scheduleid=rp.getScheduleid();
		if(scheduleid>0){
			rp.setSchedulecode(salerRevenueDao.queryScheduleCode(scheduleid));
		}
		//
		if("1".equals(rp.getHandflag())){
			list = salerRevenueDao.queryStationBalanceInvoinces(rp);
		}else if("2".equals(rp.getHandflag())){
			list = salerRevenueDao.queryHandStationBalanceInvoinces(rp);
		}else{
			list = salerRevenueDao.queryStationBalanceInvoinces(rp);
			List<Object> handlist = salerRevenueDao.queryHandStationBalanceInvoinces(rp);
			list.addAll(handlist);
		}
		if (!rp.isIsshowzerotickets()) {
			Iterator<Object> its = list.iterator();
			while (its.hasNext()) {
				Object[] ob = (Object[]) its.next();
				if (ob[6].toString().equals("0")) {
					its.remove();
				}
			}
		}
		return ListUtil.listToMap(new Object[] {"endstation", "name", "vehicleno", "seats",
				"invoincenum", "schnum", "ticketnum", "totalamount",
				"balanceamount", "invoinceprice", "moreprice",
				"stationservicefee", "fueladditionfee", "computefee",
				"coolairfee", "additionfee", "waterfee", "insurefee",
				"otherfee", "totalfee", "peopledistance", "allpeopledistance",
				"rate","laowufee","canamount","ticketsellnum","allprice","balancetype" }, list, new Object[] { String.class,String.class, String.class,
				Integer.class, Integer.class, Integer.class, Integer.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, Long.class, Long.class, String.class,BigDecimal.class,BigDecimal.class,Integer.class,BigDecimal.class , String.class});
	}

	/**
	 * 长途站预售票查询情况表（跨月汇总）
	 * 
	 * @param month
	 * @return
	 */
	public List<Map<String, Object>> queryPresellMonthRevenue(String orgids,
			Date month, Boolean isSellLocal) {
		salerRevenueDao = new SalerRevenueDao();
		return ListUtil.listToMap(new Object[] { "departname", "departdate",
				"sellorgname", "sellnum", "sellmoney", "invoicesmoney",
				"stationservicefee", "computefee", "coolairfee", "additionfee",
				"fueladditionfee", "thismonthreturnnum",
				"thismonthreturnmoney", "thismonthreturncharges",
				"nextmonthreturnnum", "nextmonthreturnmoney",
				"nextmonthreturncharges", "checknum", "checkmoney" },
				salerRevenueDao.queryPresellMonthRevenue(orgids, month,
						isSellLocal), new Object[] { String.class, Date.class,
						String.class, Integer.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						Integer.class, BigDecimal.class, BigDecimal.class,
						Integer.class, BigDecimal.class, BigDecimal.class,
						Integer.class, BigDecimal.class });
	}

	/**
	 * 车辆划拨汇总表
	 * 
	 * @param String
	 *            orgids,Date startdate,Date enddate
	 * @return
	 */
	@Override
	public List<Map<String, Object>> queryVehicleIncome(String orgids,
			Date startdate, Date enddate,
			List<PropertyFilter> propertyFilterList, String printorgids) {
		salerRevenueDao = new SalerRevenueDao();
		return ListUtil.listToMap(new Object[] { "endstation", "balancename",
				"vehicleno", "distance", "totaldistance", "invoicesnonum",
				"schedulenum", "ticketnum", "totalamount", "stationservicefee",
				"computefee", "coolairfee", "additionfee", "fueladditionfee",
				"waterfee", "insurefee", "otherfee", "basemount", "agentfee",
				"income", "balanceamount", "peopledistance", "moreprice",
				"subtotal" }, salerRevenueDao.queryVehicleIncome(orgids,
				startdate, enddate, propertyFilterList, printorgids),
				new Object[] { String.class, String.class, String.class,
						long.class, long.class, Integer.class, Integer.class,
						Integer.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class });
	}

	@Override
	public List<Map<String, Object>> queryDayScheduleIncome(String orgids,
			Date startdate, Date enddate, Boolean isovertime,
			String schedulestatus) {
		salerRevenueDao = new SalerRevenueDao();
		return ListUtil.listToMap(new Object[] { "name", "departdate",
				"schnum", "seatnum", "soldeatnum", "totalprice" },
				salerRevenueDao.queryDayScheduleIncome(orgids, startdate,
						enddate, isovertime, schedulestatus), new Object[] {
						String.class, Date.class, long.class, long.class,
						long.class, BigDecimal.class });
	}

	@Override
	public List<Map<String, Object>> queryLocalOrg(String orgids) {
		salerRevenueDao = new SalerRevenueDao();
		return ListUtil.listToMap(new Object[] { "id", "name", "code" },
				salerRevenueDao.queryLocalOrg(orgids), new Object[] {
						long.class, String.class, String.class });
	}

	@Override
	public List<Map<String, Object>> queryDayIncome(String orgids,
			Date startdate, Date enddate, Long seller) {
		salerRevenueDao = new SalerRevenueDao();
		return ListUtil.listToMap(new Object[] { "selldate", "cancelnum",
				"cancelmoeny", "sellnum", "totalprice", "returnnum",
				"returnprice", "returnfee", "totalnum", "totalincome" },
				salerRevenueDao.queryDayIncome(orgids, startdate, enddate,
						seller), new Object[] { Date.class, long.class,
						BigDecimal.class, long.class, BigDecimal.class,
						long.class, BigDecimal.class, BigDecimal.class,
						long.class, BigDecimal.class });
	}

	@Override
	public List<Map<String, Object>> qrysellerdepartinvoices(long sellerid, String orgids, Date departstartdate,
			Date departenddate) {
		salerRevenueDao = new SalerRevenueDao();
		return ListUtil.listToMap(new Object[] { "seller","departdate","departinvoicesnum","ticketnum",
				"totalamount","balanceamount","stationservicefee","agentfee","otherfee","fueladditionfee" },
				salerRevenueDao.qrysellerdepartinvoices(sellerid,orgids,departstartdate,departenddate), 
				new Object[] { String.class, Date.class,long.class,long.class,
						BigDecimal.class,BigDecimal.class, BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class });
	}
}
