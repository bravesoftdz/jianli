package cn.nova.bus.query.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.query.dao.DispatchQueryDao;
import cn.nova.bus.query.service.DispatchQryService;
import cn.nova.bus.report.param.Reportparam;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

public class DispatchQryServiceImpl implements DispatchQryService {

	private DispatchQueryDao dispatchQuerydao = new DispatchQueryDao();

	@Override
	public List<Map<String, Object>> queryScheduleDepartTime(
			List<PropertyFilter> propertyFilterList) {
		dispatchQuerydao = new DispatchQueryDao();
		return ListUtil.listToMap(new Object[] { "routename","departdate","distance",
				"runtime", "endstationname", "reachstationname", "starttime" },
				dispatchQuerydao.queryScheduleDepartTime(propertyFilterList),
				new Object[] { String.class, Date.class,short.class, BigDecimal.class,
						String.class, String.class, String.class });
	}

	@Override
	public List<Map<String, Object>> queryScheduleRunSituation(
			List<PropertyFilter> propertyFilterList, long curstationid,
			Date departdate,String sellorgid) {
		dispatchQuerydao = new DispatchQueryDao();
//		if(propertyFilterList!=null && propertyFilterList.size() >0){
//			for(int i=propertyFilterList.size()-1;i>=0;i--){	
//				PropertyFilter propertyFilter=propertyFilterList.get(i);
//				if("s!id".equals(propertyFilter.getPropertyFullName().toString())){
//					long id= (Long) propertyFilter.getMatchValue();
//					if(id>0){
//						String schedulecode=dispatchQuerydao.queryScheduleCode(id);
//						PropertyFilter propertyFilter_new =new PropertyFilter("LIKES_s!code",schedulecode);
//						propertyFilterList.remove(propertyFilter);
//						propertyFilterList.add(propertyFilter_new);			
//					}
//				}
//			}
//		}
		
		
		return ListUtil
		.listToMap(
				new Object[] { "schtype", "autocancelreserveseatnum",
						"unautocancelreserveseatnum", "departtime",
						"scheduleplanid", "departdate", "seatnum",
						"fixedreserveseatnum", "soldeatnum",
						"issellable", "workways", "districttype",
						"scheduletype", "isproprietary", "isovertime",
						"departname", "schedulename", "unitname",
						"startroutename", "endroutename", "begincheck",
						"vehicleno", "reportvehicleno", "status",
						"ticketentrance", "buspark", "viastation",
						"driver1", "driver2", "driver3", "steward1",
						"steward2", "vtname", "routename",
						"schedulevehiclepeopleplanid",
						"schedulestatusid", "vehicletypeid",
						"vehiclebrandmodelid", "scheduleid", "orgid",
						"planvehicleid", "d1id", "d2id", "d3id",
						"s1id", "s2id", "islinework", "routeid",
						"reservenum", "isdeparted",
						"issaleafterreport", "runtime", "worktype",
						"isoriginator", "issellreturnticket",
						"iscanmixcheck", "brandmodelname", "orgname",
						"reporttime", "departstationid", "planunit",
						"remarks", "carrychildnum", "planunitid",
						"localsell", "othersell","endtime" }, 
						dispatchQuerydao.queryScheduleRunSituation(
						propertyFilterList, curstationid, departdate,sellorgid
						), new Object[] {
						String.class, Short.class, Short.class,
						String.class, Long.class, Date.class,
						Short.class, Short.class, Short.class,
						Boolean.class, String.class, String.class,
						String.class, Boolean.class, Boolean.class,
						String.class, String.class, String.class,
						String.class, String.class, Boolean.class,
						String.class, String.class, String.class,
						String.class, String.class, String.class,
						String.class, String.class, String.class,
						String.class, String.class, String.class,
						String.class, Long.class, Long.class,
						Long.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Boolean.class,
						Long.class, short.class, Boolean.class,
						Boolean.class, BigDecimal.class, String.class,
						Boolean.class, Boolean.class, Boolean.class,
						String.class, String.class, Timestamp.class,
						Long.class, String.class, String.class,
						Short.class, Long.class, Integer.class,
						Integer.class,String.class });
	}

	@Override
	public List<Map<String, Object>> querySoldSituation(int scheduleplanid,
			int scheduleid) {
		dispatchQuerydao = new DispatchQueryDao();
		return ListUtil
				.listToMap(new Object[] { "ticketoutletsname", "dapartname",
						"endname", "tickettypename", "allprice", "ticketnum",
						"price" }, dispatchQuerydao.querySoldSituation(
						scheduleplanid, scheduleid), new Object[] {
						String.class, String.class, String.class, String.class,
						BigDecimal.class, Integer.class, BigDecimal.class });
	}

	@Override
	public List<Map<String, Object>> queryVehicleLate(
			List<PropertyFilter> propertyFilterList,String notbalance) {
		dispatchQuerydao = new DispatchQueryDao();
		if(propertyFilterList!=null && propertyFilterList.size() >0){
			for(int i=propertyFilterList.size()-1;i>=0;i--){	
				PropertyFilter propertyFilter=propertyFilterList.get(i);
				if("s!id".equals(propertyFilter.getPropertyFullName().toString())){
					long id= (Long) propertyFilter.getMatchValue();
					if(id>0){
						String schedulecode=dispatchQuerydao.queryScheduleCode(id);
						PropertyFilter propertyFilter_new =new PropertyFilter("LIKES_s!code",schedulecode);
						propertyFilterList.remove(propertyFilter);
						propertyFilterList.add(propertyFilter_new);			
					}
				}
			}
		}
		return ListUtil.listToMap(new Object[] { "orgname", "departdate",
				"routename", "schedulecode", "unitname", "repotvehicle",
				 "reporttime", "reason", "forfeit", "isbalance",
				"status", "departtime","latermin" },
				dispatchQuerydao.queryVehicleLate(propertyFilterList,notbalance),
				new Object[] { String.class, Date.class, String.class,
						String.class, String.class, String.class,
						Timestamp.class, String.class, BigDecimal.class,
						boolean.class, String.class, String.class,long.class });
	}

	@Override
	public List<Map<String, Object>> queryVehicleLost(
			List<PropertyFilter> propertyFilterList) {
		dispatchQuerydao = new DispatchQueryDao();
		if(propertyFilterList!=null && propertyFilterList.size() >0){
			for(int i=propertyFilterList.size()-1;i>=0;i--){	
				PropertyFilter propertyFilter=propertyFilterList.get(i);
				if("s!id".equals(propertyFilter.getPropertyFullName().toString())){
					long id= (Long) propertyFilter.getMatchValue();
					if(id>0){
						String schedulecode=dispatchQuerydao.queryScheduleCode(id);
						PropertyFilter propertyFilter_new =new PropertyFilter("LIKES_s!code",schedulecode);
						propertyFilterList.remove(propertyFilter);
						propertyFilterList.add(propertyFilter_new);			
					}
				}
			}
		}
		return ListUtil.listToMap(new Object[] { "orgname", "routename",
				"departdate", "schdulecode", "unitname", "vehicleno",
				"schedulestatus", "departtime", "createtime", "reason",
				"forfeit", "isbalance", "reportname", "createname" },
				dispatchQuerydao.queryVehicleLost(propertyFilterList),
				new Object[] { String.class, String.class, Date.class,
						String.class, String.class, String.class, String.class,
						String.class, Timestamp.class, String.class,
						BigDecimal.class, boolean.class, String.class,
						String.class });
	}

	@Override
	public List<Map<String, Object>> queryVehicleStop(
			List<PropertyFilter> propertyFilterList, String vehicleno,String loststatus) {
		dispatchQuerydao = new DispatchQueryDao();
		if(propertyFilterList!=null && propertyFilterList.size() >0){
			for(int i=propertyFilterList.size()-1;i>=0;i--){	
				PropertyFilter propertyFilter=propertyFilterList.get(i);
				if("s!id".equals(propertyFilter.getPropertyFullName().toString())){
					long id= (Long) propertyFilter.getMatchValue();
					if(id>0){
						String schedulecode=dispatchQuerydao.queryScheduleCode(id);
						PropertyFilter propertyFilter_new =new PropertyFilter("LIKES_s!code",schedulecode);
						propertyFilterList.remove(propertyFilter);
						propertyFilterList.add(propertyFilter_new);			
					}
				}
			}
		}
		return ListUtil.listToMap(new Object[] { "orgname", "routename",
				"departdate", "schdulecode", "vehicleno", "schedulestatus",
				"departtime", "createtime", "reason", "reportname",
				"createname" }, dispatchQuerydao.queryVehicleStop(
				propertyFilterList, vehicleno,loststatus), new Object[] { String.class,
				String.class, Date.class, String.class, String.class,
				String.class, String.class, Timestamp.class, String.class,
				String.class, String.class });
	}

	@Override
	public List<Map<String, Object>> queryschedulemerge(
			List<PropertyFilter> propertyFilterList) {
		dispatchQuerydao = new DispatchQueryDao();
		if(propertyFilterList!=null && propertyFilterList.size() >0){
			for(int i=propertyFilterList.size()-1;i>=0;i--){	
				PropertyFilter propertyFilter=propertyFilterList.get(i);
				if("os!id".equals(propertyFilter.getPropertyFullName().toString())){
					long id= (Long) propertyFilter.getMatchValue();
					if(id>0){
						String schedulecode=dispatchQuerydao.queryScheduleCode(id);
						PropertyFilter propertyFilter_new =new PropertyFilter("LIKES_os!code",schedulecode);
						propertyFilterList.remove(propertyFilter);
						propertyFilterList.add(propertyFilter_new);			
					}
				}
			}
		}
		
		return ListUtil.listToMap(new Object[] { "id", "oldschedulecode",
				"newschedulecode", "olddepartdate", "newdepartdate",
				"oldseatnum", "newseatnum", "oldroutename", "newroutename",
				"reason", "createname", "iscancel", "orgname" },
				dispatchQuerydao.queryschedulemerge(propertyFilterList),
				new Object[] { Integer.class, String.class, String.class,
						Date.class, Date.class, Integer.class, Integer.class,
						String.class, String.class, String.class, String.class,
						boolean.class, String.class });
	}

	@Override
	public List<Map<String, Object>> queryschedulemergeDetail(
			List<PropertyFilter> propertyFilterList) {
		dispatchQuerydao = new DispatchQueryDao();
		return ListUtil.listToMap(new Object[] { "oldseatno", "newseatno",
				"ticketno", "orgname", "carrychildnum", "departstaioname",
				"reachestationname", "ticketype", "price", "ticketentrance",
				"buspark", "ticketoutletsname", "selltime", "customername",
				"checkbyname", "ticketstatus", "seattype" },
				dispatchQuerydao.queryschedulemergeDetail(propertyFilterList),
				new Object[] { String.class, String.class, String.class,
						String.class, Integer.class, String.class,
						String.class, String.class, BigDecimal.class,
						String.class, String.class, String.class,
						Timestamp.class, String.class, String.class,
						String.class, String.class });
	}

	@Override
	public List<Map<String, Object>> queryOvertimeSchedule(
			List<PropertyFilter> propertyFilterList, long curstationid) {
		dispatchQuerydao = new DispatchQueryDao();
		return ListUtil
				.listToMap(new Object[] { "autocancelreserveseatnum",
						"unautocancelreserveseatnum", "departtime",
						"scheduleplanid", "departdate", "seatnum",
						"fixedreserveseatnum", "soldeatnum", "issellable",
						"workways", "districttype", "scheduletype",
						"isproprietary", "isovertime", "departname",
						"schedulename", "unitname", "startroutename",
						"endroutename", "begincheck", "vehicleno",
						"reportvehicleno", "status", "ticketentrance",
						"buspark", "viastation", "driver1", "driver2",
						"driver3", "steward1", "steward2", "vtname",
						"routename", "schedulevehiclepeopleplanid",
						"schedulestatusid", "vehicletypeid",
						"vehiclebrandmodelid", "scheduleid", "orgid",
						"planvehicleid", "d1id", "d2id", "d3id", "s1id",
						"s2id", "islinework", "routeid", "reservenum",
						"isdeparted", "issaleafterreport", "runtime",
						"worktype", "isoriginator", "issellreturnticket",
						"iscanmixcheck", "brandmodelname", "orgname",
						"reporttime", "departstationid", "balanceid",
						"balanceunitname", "sellprice" },
						dispatchQuerydao.queryOverTimeSchedule(
								propertyFilterList, curstationid),
						new Object[] { Short.class, Short.class, String.class,
								Long.class, Date.class, Short.class,
								Short.class, Short.class, Boolean.class,
								String.class, String.class, String.class,
								Boolean.class, Boolean.class, String.class,
								String.class, String.class, String.class,
								String.class, Boolean.class, String.class,
								String.class, String.class, String.class,
								String.class, String.class, String.class,
								String.class, String.class, String.class,
								String.class, String.class, String.class,
								Long.class, Long.class, Long.class, Long.class,
								Long.class, Long.class, Long.class, Long.class,
								Long.class, Long.class, Long.class, Long.class,
								Boolean.class, Long.class, short.class,
								Boolean.class, Boolean.class, BigDecimal.class,
								String.class, Boolean.class, Boolean.class,
								Boolean.class, String.class, String.class,
								Timestamp.class, Long.class, Long.class,
								String.class, BigDecimal.class });
	}

	@Override
	public List<Map<String, Object>> queryFullSeatSchedule(
			List<PropertyFilter> propertyFilterList) {
		dispatchQuerydao = new DispatchQueryDao();
		return ListUtil.listToMap(new Object[] { "routename", "code",
				"departdate", "departtime", "seatnum", "soldeatnum",
				"autocancelreserveseatnum", "unautocancelreserveseatnum",
				"fixedreserveseatnum", "isovertime", "status", "isdeparted",
				"issaleafterreport" },
				dispatchQuerydao.queryFullSeatSchedule(propertyFilterList),
				new Object[] { String.class, String.class, Date.class,
						String.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						boolean.class, String.class, boolean.class,
						boolean.class });
	}

	@Override
	public List<Map<String, Object>> queryVehicleLicense(Reportparam rp) {
		dispatchQuerydao = new DispatchQueryDao();
		return ListUtil.listToMap(new Object[]{"orderno","vehicleno","departtime1","name",
				"qualification","drivinglicense","driverlicense","workno","rodeno","workno1","notenum",
				"seatnum","actpersons","driversign","classmember","dispatcher"}, 
				dispatchQuerydao.queryVehicleLicense(rp),
				new Object[]{Long.class,String.class,String.class,String.class,
			    String.class,String.class,String.class,String.class,String.class,String.class,String.class,
			    short.class,short.class,String.class,String.class,String.class});
		
//		return ListUtil.listToMap(new Object[] { "orgname","vehicleno", "departdate",
//				"scheduletype","name","drivinglicense", "qualification", "driverlicense", 
//				"workno","roadno", "seatnum", "ismaintain","signature" },
//				dispatchQuerydao.queryVehicleLicense(rp), new Object[] {
//						String.class,String.class, Date.class,
//						String.class,String.class,String.class, String.class,String.class, 
//						String.class,String.class, short.class,boolean.class, String.class });
	}
	
	@Override
	public List<Map<String, Object>> queryTicketInfo(long departinvoicesid) {
		dispatchQuerydao = new DispatchQueryDao();
		List list = new ArrayList<Object>();
		list = dispatchQuerydao.queryTicketInfo(departinvoicesid);
		if(list.size() == 0){
			list = dispatchQuerydao.queryDepartinvoicesOtherDetail(departinvoicesid);
		}
		
		
		
		
		
		return ListUtil.listToMap(new Object[] { 
				"sellip","selltime","buspark","ticketentrance",
				"ticketprice","fueladditionfee","stationservicefee",
				"discountrate","fullprice","distance","carrychildnum",
				"departdate","departtime","seatno","ticketno",
				"sellway","ticketstatus","paymethod","orgname",
				"schedulecode","dpartname","reachname","sellname",
				"vehicletypename", "tickettypename", "islinework",
				"ticketoutletname","customername","hticketoutlesname",
				"houtletsaddress","checkedname","checkstationname",
				"departinvoicesbyname","servicefee","vehiclebrandmodelname",
				"checktime","computefee",				
				"coolairfee","additionfee",
				"isovertime","routename","moreprice","otherfee",
				"insurefee","waterfee","serviceprice","subtotal" },
				list, 
				new Object[] {
				String.class, Timestamp.class, String.class, String.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				Long.class, BigDecimal.class, Long.class, byte.class,			
				Date.class, String.class, byte.class, String.class,			
				String.class, String.class, String.class, String.class,			
				String.class, String.class, String.class, String.class,
				String.class, String.class, boolean.class,			
				String.class, String.class, String.class, 				
				String.class, String.class, String.class,
				String.class,BigDecimal.class,String.class,
				Timestamp.class, BigDecimal.class,				
				BigDecimal.class,BigDecimal.class,
				boolean.class, String.class,BigDecimal.class, BigDecimal.class, 
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class});
	}
}
