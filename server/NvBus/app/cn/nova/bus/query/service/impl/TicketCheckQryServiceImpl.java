package cn.nova.bus.query.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.query.dao.TicketCheckQryDao;
import cn.nova.bus.query.service.TicketCheckQryService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：检票查询 </b><br/>
 * <b>类名称：</b>TicketCheckQryServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-4 <br/>
 * <b>关键修改：修改班次报班情况查询，</b><br/>
 * <b>修改时间：2013-4-11</b><br/>
 * <b>修改人：hhz</b><br/>
 */
public class TicketCheckQryServiceImpl implements TicketCheckQryService {

	private TicketCheckQryDao ticketCheckQryDao = new TicketCheckQryDao();

	@Override
	public List<Map<String, Object>> queryDepartinvoices(
			List<PropertyFilter> propertyFilterList,long printby) {
		ticketCheckQryDao = new TicketCheckQryDao();
//		if(propertyFilterList!=null && propertyFilterList.size() >0){
//			for(int i=propertyFilterList.size()-1;i>=0;i--){	
//				PropertyFilter propertyFilter=propertyFilterList.get(i);
//				if("s!id".equals(propertyFilter.getPropertyFullName().toString())){
//					long id= (Long) propertyFilter.getMatchValue();
//					if(id>0){
//						String schedulecode=ticketCheckQryDao.queryScheduleCode(id);
//						PropertyFilter propertyFilter_new =new PropertyFilter("LIKES_s!code",schedulecode);
//						propertyFilterList.remove(propertyFilter);
//						propertyFilterList.add(propertyFilter_new);			
//					}
//				}
//			}
//		}
		return ListUtil.listToMap(new Object[] { "departstationname", "id",
				"orgname", "departinvoicesno", "status", "departdate",
				"departtime", "routename", "schedulecode", "unitname",
				"vehicleno", "seatnum", "vehicletypname", "ticketnum",
				"totalamount", "stationservicefee", "printip", "printbyname",
				"printtime", "supplyticketnum", "supplyamount",
				"supplybalanceamount", "d1name", "d2name", "d3name", "d4name",
				"s1name", "s2name", "type", "worktype", "fueladditionfee",
				"othterfee", "agentfee", "balanceamount", "balanceunitname",
				"moreprice" },
				ticketCheckQryDao.queryDepartinvoices(propertyFilterList, printby),
				new Object[] { String.class, Long.class, String.class,
						String.class, String.class, Date.class, String.class,
						String.class, String.class, String.class, String.class,
						Long.class, String.class, Long.class, BigDecimal.class,
						BigDecimal.class, String.class, String.class,
						Timestamp.class, Long.class, BigDecimal.class,
						BigDecimal.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						String.class, BigDecimal.class });
	}

	@Override
	public List<Map<String, Object>> querydepartinvoicesDetail(
			List<PropertyFilter> propertyFilterList) {
		ticketCheckQryDao = new TicketCheckQryDao();
		return ListUtil
				.listToMap(new Object[] { "fromstaionname", "reachstationname",
						"tickettypename", "distance", "price", "ticketnum",
						"totalamount", "fueladditionfee", "othterfee",
						"agentfee", "balanceamount", "issupply",
						"stationservicefee", "moreprice" }, ticketCheckQryDao
						.querydepartinvoicesDetail(propertyFilterList),
						new Object[] { String.class, String.class,
								String.class, Long.class, BigDecimal.class,
								Long.class, BigDecimal.class, BigDecimal.class,
								BigDecimal.class, BigDecimal.class,
								BigDecimal.class, boolean.class,
								BigDecimal.class, BigDecimal.class });
	}

	/**
	 * 扣费明细情况查询
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryDeductdetail(
			List<PropertyFilter> propertyFilterList) {
		ticketCheckQryDao = new TicketCheckQryDao();
		// List<Map<String, Object>> together = null;
		List<Map<String, Object>> deductapply;
		List<Map<String, Object>> formulaapply;

		Object[] fileds = new Object[] { "typenme", "objectname", "itemname",
				"type", "deductmoney", "vehicleno", "scheduename", "routename",
				"unitname", "startdate", "enddate", "remarks" };

		Object[] filedtype = new Object[] { String.class, String.class,
				String.class, String.class, BigDecimal.class, String.class,
				String.class, String.class, String.class, Timestamp.class,
				Timestamp.class, String.class };

		deductapply = ListUtil.listToMap(fileds, ticketCheckQryDao
				.queryDeductdetailDeductapply(propertyFilterList), filedtype);
		formulaapply = ListUtil.listToMap(fileds, ticketCheckQryDao
				.queryDeductdetailFormulaapply(propertyFilterList), filedtype);
		// if(deductapply.size()!=0){
		// for (int i = 0; i < deductapply.size(); i++) {
		// Map<String, Object> map1 = deductapply.get(i);
		// together.add(map1);
		// }
		// }
		if (formulaapply.size() != 0) {
			for (int i = 0; i < formulaapply.size(); i++) {
				Map<String, Object> map2 = formulaapply.get(i);
				deductapply.add(map2);
			}
		}
		return deductapply;
	}

	/**
	 * 班次漏乘情况查询 * @param propertyFilterList
	 * 
	 * @return
	 */
	@Override
	public List<Map<String, Object>> queryScheduleMiss(
			List<PropertyFilter> propertyFilterList,boolean ticketnoVisible) {
		ticketCheckQryDao = new TicketCheckQryDao();
		if(propertyFilterList!=null && propertyFilterList.size() >0){
			for(int i=propertyFilterList.size()-1;i>=0;i--){	
				PropertyFilter propertyFilter=propertyFilterList.get(i);
				if("s!id".equals(propertyFilter.getPropertyFullName().toString())){
					long id= (Long) propertyFilter.getMatchValue();
					if(id>0){
						String schedulecode=ticketCheckQryDao.queryScheduleCode(id);
						PropertyFilter propertyFilter_new =new PropertyFilter("LIKES_s!code",schedulecode);
						propertyFilterList.remove(propertyFilter);
						propertyFilterList.add(propertyFilter_new);			
					}
				}
			}
		}		
		Object[] resultname = new Object[] { "orgname", "ticketno",
				"sellbyname", "selltime", "schedulecode", "reachstationname",
				"departstationname", "departdate", "departtime", "seatno",
				"tickettypename", "price", "stationservicefee", "distance",
				"buspark", "islinework", "isovertime", "ticketoutletsname",
				"sellip", "routename", "ischecked", "computefee", "coolairfee",
				"additionfee", "waterfee", "insurefee", "otherfee",
				"fueladditionfee", "subtotal" };
		Object[] resulttype = new Object[] { String.class, String.class,
				String.class, Timestamp.class, String.class, String.class,
				String.class, Date.class, String.class, Long.class,
				String.class, BigDecimal.class, BigDecimal.class, Long.class,
				String.class, boolean.class, boolean.class, String.class,
				String.class, String.class, boolean.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class };
		// 正常的漏乘票
		List<Map<String, Object>> result = ListUtil.listToMap(resultname,
				ticketCheckQryDao.queryScheduleMiss(propertyFilterList, ticketnoVisible),
				resulttype);

		// // 过了发车时间的漏乘票，（过了发车时间再退票的漏乘）
		// List<Map<String, Object>> lateDepart = ListUtil.listToMap(resultname,
		// ticketCheckQryDao.queryScheduleMissDepart(propertyFilterList),
		// resulttype);
		// if (lateDepart != null && lateDepart.size() > 0) {
		// for (int i = 0; i < lateDepart.size(); i++) {
		// Map<String, Object> map2 = lateDepart.get(i);
		// result.add(map2);
		// }
		// }

		return result;
	}

	/**
	 * 班次报班情况查询
	 */
	@Override
	public List<Map<String, Object>> queryVehicleReport(
			List<PropertyFilter> propertyFilterList) {
		ticketCheckQryDao = new TicketCheckQryDao();
		if(propertyFilterList!=null && propertyFilterList.size() >0){
			for(int i=propertyFilterList.size()-1;i>=0;i--){	
	 			PropertyFilter propertyFilter=propertyFilterList.get(i);
				if("s!id".equals(propertyFilter.getPropertyFullName().toString())){
					long id= (Long) propertyFilter.getMatchValue();
					if(id>0){
						String schedulecode=ticketCheckQryDao.queryScheduleCode(id);
						PropertyFilter propertyFilter_new =new PropertyFilter("LIKES_s!code",schedulecode);
						propertyFilterList.remove(propertyFilter);
						propertyFilterList.add(propertyFilter_new);			
					}
				}
			}
		}
		return ListUtil.listToMap(new Object[] { "unitname", "isreported",
				"status", "orgname", "schedulecode", "departtime", "routename",
				"departdate", "reporttime", "vehicleno", "seatnum",
				"islinework", "isovertime", "planunitname", "planvehicleno",
				"drivername1", "drivername2", "drivername3", "drivername4",
				"stewardname1", "stewardname2", "plandriver1", "plandriver2",
				"plandriver3", "plandriver4", "plansteward1", "plansteward2" },
				ticketCheckQryDao.queryVehicleReport(propertyFilterList),
				new Object[] { String.class, boolean.class, String.class,
						String.class, String.class, String.class, String.class,
						Date.class, Timestamp.class, String.class, Long.class,
						boolean.class, boolean.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class });
	}

	/**
	 * 班次混检情况查询
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryTicketmixcheck(
			List<PropertyFilter> propertyFilterList) {
		ticketCheckQryDao = new TicketCheckQryDao();
		return ListUtil.listToMap(new Object[] { "orgname", "ticketno",
				"oldticketno", "olddepartdate", "olddeparttime",
				"newdepartdate", "newdeparttime", "oldseatno", "newseatno",
				"actualvehicleseatnum", "createtime", "createbyname",
				"isdepartinvoices", "ticketstats", "newschedulecode",
				"oldschdulecode", "newroutename", "oldroutename",
				"startstation", "endstation", "mixchecktype",
				"oldstartstation", "oldendstation" },
				ticketCheckQryDao.queryTicketmixcheck(propertyFilterList),
				new Object[] { String.class, String.class, String.class,
						Date.class, String.class, Date.class, String.class,
						String.class, String.class, BigDecimal.class,
						Timestamp.class, String.class, boolean.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class });
	}

	/**
	 * 班次检票汇总表
	 * 
	 * @see cn.nova.bus.query.service.TicketCheckQryService#queryScheduleCheck(java.util.List)
	 */
	@Override
	public List<Map<String, Object>> queryScheduleCheckSum(
			List<PropertyFilter> propertyFilterList) {
		ticketCheckQryDao = new TicketCheckQryDao();
		if(propertyFilterList!=null && propertyFilterList.size() >0){
			for(int i=propertyFilterList.size()-1;i>=0;i--){	
				PropertyFilter propertyFilter=propertyFilterList.get(i);
				if("s!id".equals(propertyFilter.getPropertyFullName().toString())){
					long id= (Long) propertyFilter.getMatchValue();
					if(id>0){
						String schedulecode=ticketCheckQryDao.queryScheduleCode(id);
						PropertyFilter propertyFilter_new =new PropertyFilter("LIKES_s!code",schedulecode);
						propertyFilterList.remove(propertyFilter);
						propertyFilterList.add(propertyFilter_new);			
					}
				}
			}
		}
		return ListUtil.listToMap(new Object[] { "usercode", "checkname",
				"departnum", "checknum", "fee", "departpeplo" ,"price","checkprice","departinvoicesnum"},
				ticketCheckQryDao.queryScheduleCheckSum(propertyFilterList),
				new Object[] { String.class, String.class, Integer.class,
						Integer.class, BigDecimal.class, Integer.class, BigDecimal.class, BigDecimal.class , BigDecimal.class });

	}
	
	/**
	 * 检票员工作月报
	 */
	@Override
	public List<Map<String, Object>> qrycheckworkmonth(
			List<PropertyFilter> propertyFilterList) {
		ticketCheckQryDao = new TicketCheckQryDao();
		return ListUtil.listToMap(new Object[] { "code", "name", "sticketnum",
				"sdepartinvoicesno", "stotalamount", "fticketnum",
				"fdepartinvoicesno", "ftotalamount", "totalno"
				,"stationservicefee","balanceamount"},
				ticketCheckQryDao.qrycheckworkmonth(propertyFilterList),
				new Object[] { String.class, String.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class 
						, BigDecimal.class, BigDecimal.class});
	}
	
	@Override
	public List<Map<String, Object>> qrychecklog(List<PropertyFilter> propertyFilterList) {
		ticketCheckQryDao = new TicketCheckQryDao();
		return ListUtil.listToMap(new Object[] { "checktype","operationtype","ticketno","departdate","departtime","schedulecode","reachstation",
				"customername","certificatetype","certificateno","checkedby","checkedbycode","checkedip","checktime"},
				ticketCheckQryDao.qrychecklog(propertyFilterList),
				new Object[] { String.class, String.class, String.class,Date.class,String.class,String.class,String.class,
						String.class, String.class, String.class, String.class,String.class,String.class,Timestamp.class});
	}

}
