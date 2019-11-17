package cn.nova.bus.query.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import util.DateUtils;
import cn.nova.bus.archive.model.Customer;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.bill.model.Billdamaged;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.query.dao.TicketSellQryDao;
import cn.nova.bus.query.param.Qryparam;
import cn.nova.bus.query.service.TicketSellQryService;
import cn.nova.bus.query.vo.SaleLocalTicketQryVo;
import cn.nova.bus.query.vo.TicketsellQryVo;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.security.Global;
import cn.nova.bus.util.PaginationReportName;
import cn.nova.bus.util.ReportUtil;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：售票情况查询query,</b><br/>
 * <b>类名称：</b>TicketSellQryDao.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-4-28 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class TicketSellQryServiceImpl implements TicketSellQryService {

	private TicketSellQryDao ticketsellqrydao = new TicketSellQryDao();
	private BilltypeService billtypeService = new BilltypeServiceImpl();

	@Override
	public List<Map<String, Object>> query(Qryparam qp,Global global) {
		ticketsellqrydao = new TicketSellQryDao();
		Billtype billtype = billtypeService.findByCode("Ticket");
		if(billtype!=null){
			qp.setTicketlength(billtype.getTicketnolength());
		}
		List<TicketsellQryVo> list=ticketsellqrydao.query(qp);
		List<Object> list2=new ReportUtil<TicketsellQryVo>().saveToFile(list,global,PaginationReportName.TICKETSELLQRY);
		//List<Object> list3=ReportUtil.readFromFile(TicketsellQryVo.class,global,PaginationReportName.TICKETSELLQRY,PaginationReportName.PAGESIZE,PaginationReportName.FIRST);
		return ListUtil.listToMap(new Object[] {TicketsellQryVo.class} ,list2, new Object[] {TicketsellQryVo.class});
		/*return ListUtil.listToMap(
				new Object[] { "sellip", "selltime", "buspark", "ticketentrance", "price", "fueladditionfee",
						"stationservicefee", "discountrate", "fullprice", "distance", "carrychildnum", "departdate",
						"departtime", "seatno", "ticketno", "sellway", "ticketstatus", "paymethod", "orgname",
						"schedulecode", "dpartname", "reachname", "sellname", "ischecked", "isdepartinvoices",
						"islocal", "vehicletypename", "tickettypename", "islinework", "ticketoutletname",
						"customername", "certificateno", "certificatetypename", "hticketoutlesname", "houtletsaddress",
						"checkedname", "checkstationname", "departinvoicesbyname", "departinvoicesno",
						"departinvoicestime", "servicefee", "vehiclebrandmodelname", "checktime", "computefee",
						"coolairfee", "additionfee", "isovertime", "routename", "ticketprice", "returnamount",
						"returnbyname", "returntime", "returnway", "moreprice", "otherfee", "insurefee", "waterfee",
						"serviceprice", "subtotal", "printname", "printorgname", "vehicleno", "olddepartdate",
						"returnmethod","batchno" },
				ticketsellqrydao.query(qp),
				new Object[] { String.class, Timestamp.class, String.class, String.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, Long.class, BigDecimal.class, Long.class, byte.class,
						Date.class, String.class, byte.class, String.class, String.class, String.class, String.class,
						String.class, String.class, String.class, String.class, String.class, boolean.class,
						boolean.class, boolean.class, String.class, String.class, boolean.class, String.class,
						String.class, String.class, String.class, String.class, String.class, String.class,
						String.class, String.class, String.class, Timestamp.class, BigDecimal.class, String.class,
						Timestamp.class, BigDecimal.class, BigDecimal.class, BigDecimal.class, boolean.class,
						String.class, BigDecimal.class, BigDecimal.class, String.class, Timestamp.class, String.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, String.class, String.class, String.class, Date.class, boolean.class,String.class });*/
	}

	

	@Override
	public List<Map<String, Object>> queryPersell(
			List<PropertyFilter> propertyFilterList) {
		ticketsellqrydao = new TicketSellQryDao();
		List<Map<String, Object>> together = null;
		List<Map<String, Object>> local;
		List<Map<String, Object>> other;
		boolean isexcut = false;
		Object[] fileds = new Object[] { "stationservicefee", "selltime",
				"departdate", "departtime", "sellip", "price", "seatno",
				"ticketno", "ticketstatus", "ticketoutlestname", "sellname",
				"orgname", "departstationname", "reachstationname",
				"schedulecode", "tickettypename", "islocal", "computefee",
				"coolairfee", "additionfee", "waterfee", "insurefee",
				"otherfee", "moreprice", "subtotal", "paymethod"};
		Object[] filedtype = new Object[] { BigDecimal.class, Timestamp.class,
				Date.class, String.class, String.class, BigDecimal.class,
				short.class, String.class, String.class, String.class,
				String.class, String.class, String.class, String.class,
				String.class, String.class, boolean.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, String.class };
		if (propertyFilterList != null && propertyFilterList.size() > 0) {
			for (int t = 0; t < propertyFilterList.size(); t++) {
				if (propertyFilterList.get(t).getPropertyFullName() // 本站票
						.equals("ts!islocalticket")
						&& (Boolean) propertyFilterList.get(t).getMatchValue()) {
					propertyFilterList.remove(t);
					local = ListUtil.listToMap(fileds, ticketsellqrydao
							.queryPerselllocal(propertyFilterList), filedtype);
					together = local;
					isexcut = true;
					continue;
				} else if (propertyFilterList.get(t).getPropertyFullName()// 异站票
						.equals("ts!islocalticket")
						&& !(Boolean) propertyFilterList.get(t).getMatchValue()) {
					propertyFilterList.remove(t);
					other = ListUtil.listToMap(fileds, ticketsellqrydao
							.queryPersellother(propertyFilterList), filedtype);
					together = other;
					isexcut = true;
					continue;
				}
			}
		}
		if (!isexcut) {
			local = ListUtil.listToMap(fileds,
					ticketsellqrydao.queryPerselllocal(propertyFilterList),
					filedtype);
			other = ListUtil.listToMap(fileds,
					ticketsellqrydao.queryPersellother(propertyFilterList),
					filedtype);
			for (int i = 0; i < other.size(); i++) {
				Map<String, Object> map = other.get(i);
				local.add(map);
			}

			together = local;
		}
		return together;
	}

	public List<Map<String, Object>> queryTicketchange(
			List<PropertyFilter> propertyFilterList) {
		ticketsellqrydao = new TicketSellQryDao();
		if(propertyFilterList!=null && propertyFilterList.size() >0){
			for(int i=propertyFilterList.size()-1;i>=0;i--){	
				PropertyFilter propertyFilter=propertyFilterList.get(i);
				if("os!id".equals(propertyFilter.getPropertyFullName())){
					long id= (Long) propertyFilter.getMatchValue();
					if(id>0){
						String schedulecode=ticketsellqrydao.queryScheduleCode(id);
						PropertyFilter propertyFilter_new =new PropertyFilter("LIKES_os!code",schedulecode);
						propertyFilterList.remove(propertyFilter);
						propertyFilterList.add(propertyFilter_new);			
					}
				}
			}
		}
		return ListUtil.listToMap(new Object[] { "changetime", "olddepartdate",
				"newdepartdate", "oldticketno", "newticketno", "oldseatno",
				"newseatno", "changeip", "remarks", "tickettype", "price",
				"stationservicefee", "sellname", "changebyname",
				"changeticketoutlets", "olddeparttime", "newdeparttime",
				"oldschedulecode", "newschedulecode", "orgname",
				"tickettypename", "computefee", "coolairfee", "additionfee",
				"waterfee", "insurefee", "otherfee", "moreprice", "subtotal",
				"servicefee" ,"changeticketno","paymethod"},
				ticketsellqrydao.queryTicketchange(propertyFilterList),
				new Object[] { Timestamp.class, Date.class, Date.class,
						String.class, String.class, short.class, short.class,
						String.class, String.class, String.class,
						BigDecimal.class, BigDecimal.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,String.class,String.class });

	}

	@Override
	public List<Map<String, Object>> queryReserveTicket(
			List<PropertyFilter> propertyFilterList) {
		ticketsellqrydao = new TicketSellQryDao();
		if(propertyFilterList!=null && propertyFilterList.size() >0){
			for(int i=propertyFilterList.size()-1;i>=0;i--){	
				PropertyFilter propertyFilter=propertyFilterList.get(i);
				if("s!id".equals(propertyFilter.getPropertyFullName().toString())){
					long id= (Long) propertyFilter.getMatchValue();
					if(id>0){
						String schedulecode=ticketsellqrydao.queryScheduleCode(id);
						PropertyFilter propertyFilter_new =new PropertyFilter("LIKES_s!code",schedulecode);
						propertyFilterList.remove(propertyFilter);
						propertyFilterList.add(propertyFilter_new);			
					}
				}
			}
		}
		return ListUtil.listToMap(new Object[] { "fullprice", "seatno",
				"serviceprice", "carrychildnum", "isautocancel",
				"autocanceltime", "reservetime", "reserveip", "reserveway",
				"sellstate", "remarks", "canceltime", "departdate",
				"departtime", "schedulecode", "departstationname",
				"customername", "reachstationname", "reservebyname",
				"cencelbyname", "orgname", "tickettypename",
				"ticketoutletsname" ,"certificateno"},
				ticketsellqrydao.queryReserveTicket(propertyFilterList),
				new Object[] { BigDecimal.class, short.class, BigDecimal.class,
						short.class, boolean.class, Timestamp.class,
						Timestamp.class, String.class, String.class,
						String.class, String.class, Timestamp.class,
						Date.class, String.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class, String.class,String.class });

	}

	@Override
	public List<Map<String, Object>> queryTicketreturn(
			List<PropertyFilter> propertyFilterList, String schedulecode,
			Long routeid,Qryparam qp) {
		ticketsellqrydao = new TicketSellQryDao();
		List<Map<String, Object>> together = null;
		List<Map<String, Object>> local = null;
		List<Map<String, Object>> other = null;
		boolean isexcut = false;
		Object[] fileds = new Object[] { "selltime", "ticketno", "islocal",
				"ticketprice", "returnamount", "returnvoucherno", "returntime",
				"returnip", "returnway", "charges", "returnbyname",
				"returnbycode", "sellbyname", "stationservicefee",
				"schedulecode", "departdate", "departtime", "seatno",
				"orgname", "billbypename", "billcode", "reachstationname",
				"departstationname", "remarks", "ticketoutletsname",
				"scheduleorgname", "computefee", "coolairfee", "additionfee",
				"waterfee", "insurefee", "otherfee", "moreprice", "subtotal",
				"routename","signcharges","signbyname","signreason","signtime","chargesweb","returnmethod" };
		Object[] filedtype = new Object[] { Timestamp.class, String.class,
				boolean.class, BigDecimal.class, BigDecimal.class,
				String.class, Timestamp.class, String.class, String.class,
				BigDecimal.class, String.class, String.class, String.class,
				BigDecimal.class, String.class, Date.class, String.class,
				short.class, String.class, String.class, String.class,
				String.class, String.class, String.class, String.class,
				String.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				String.class, BigDecimal.class,String.class,String.class,String.class,String.class,boolean.class };
		if (propertyFilterList != null && propertyFilterList.size() > 0) {
			for (int t = 0; t < propertyFilterList.size(); t++) {
				if (propertyFilterList.get(t).getPropertyFullName() // 本站票
						.equals("tr!isselfschedule")
						&& (Boolean) propertyFilterList.get(t).getMatchValue()) {
					local = ListUtil.listToMap(fileds, ticketsellqrydao
							.queryTicketreturn(propertyFilterList,
									schedulecode, routeid,qp), filedtype);
					together = local;
					isexcut = true;
					continue;
				} else if (propertyFilterList.get(t).getPropertyFullName()// 异站票
						.equals("tr!isselfschedule")
						&& !(Boolean) propertyFilterList.get(t).getMatchValue()) {
					other = ListUtil.listToMap(fileds, ticketsellqrydao
							.queryTicketreturnOther(propertyFilterList,
									schedulecode,qp), filedtype);
					together = other;
					isexcut = true;
					continue;
				}
			}
		}
		if (!isexcut) {
			local = ListUtil.listToMap(fileds, ticketsellqrydao
					.queryTicketreturn(propertyFilterList, schedulecode,
							routeid,qp), filedtype);
			other = ListUtil.listToMap(fileds, ticketsellqrydao
					.queryTicketreturnOther(propertyFilterList, schedulecode,qp),
					filedtype);
			for (int i = 0; i < other.size(); i++) {
				Map<String, Object> map = other.get(i);
				local.add(map);
			}
			together = local;
		}
		return together;
	}

	@Override
	public List<Map<String, Object>> queryTickeCancle(
			List<PropertyFilter> propertyFilterList) {
		ticketsellqrydao = new TicketSellQryDao();
		List<Map<String, Object>> together = null;
		List<Map<String, Object>> local;
		List<Map<String, Object>> other;
		boolean isexcut = false;
		Object[] fileds = new Object[] { "cancelstationname", "canceltime",
				"ticketno", "departdate", "departtime", "seatno",
				"departstationname", "reachstationname", "tickettypename",
				"stationservicefee", "sellbyname", "sellbycode", "selltime",
				"cancelbycode", "cancelbyname", "cancelip", "remarks",
				"schedulecode", "islocal", "cancelway", "ticketprice",
				"computefee", "coolairfee", "additionfee", "waterfee",
				"insurefee", "otherfee", "moreprice", "subtotal" };
		Object[] filedtype = new Object[] { String.class, Timestamp.class,
				String.class, Date.class, String.class, short.class,
				String.class, String.class, String.class, BigDecimal.class,
				String.class, String.class, Timestamp.class, String.class,
				String.class, String.class, String.class, String.class,
				boolean.class, String.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class };
		if (propertyFilterList != null && propertyFilterList.size() > 0) {
			for (int t = 0; t < propertyFilterList.size(); t++) {
				if (propertyFilterList.get(t).getPropertyFullName() // 本站票
						.equals("tc!isselfschedule")
						&& (Boolean) propertyFilterList.get(t).getMatchValue()) {
					local = ListUtil.listToMap(fileds, ticketsellqrydao
							.queryTicketCancel(propertyFilterList), filedtype);
					together = local;
					isexcut = true;
					continue;
				} else if (propertyFilterList.get(t).getPropertyFullName()// 异站票
						.equals("tc!isselfschedule")
						&& !(Boolean) propertyFilterList.get(t).getMatchValue()) {
					other = ListUtil.listToMap(fileds, ticketsellqrydao
							.queryTicketCancelOther(propertyFilterList),
							filedtype);
					together = other;
					isexcut = true;
					continue;
				}
			}
		}
		if (!isexcut) {
			local = ListUtil.listToMap(fileds,
					ticketsellqrydao.queryTicketCancel(propertyFilterList),
					filedtype);
			other = ListUtil
					.listToMap(fileds, ticketsellqrydao
							.queryTicketCancelOther(propertyFilterList),
							filedtype);
			for (int i = 0; i < other.size(); i++) {
				Map<String, Object> map = other.get(i);
				local.add(map);
			}
			together = local;
		}
		return together;
	}

	/**
	 * 坏票登记情况查询
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryBilldamaged(
			List<PropertyFilter> propertyFilterList) {
		ticketsellqrydao = new TicketSellQryDao();
		return ListUtil.listToMap(
				new Object[] { "orgname", "ticketoutletname", "recordbyname",
						"billtypename", "recordtime", Billdamaged.class },
				ticketsellqrydao.queryBilldamaged(propertyFilterList),
				new Object[] { String.class, String.class, String.class,
						String.class, Timestamp.class, Billdamaged.class });
	}

	/**
	 * 异站退本站票
	 */
	@Override
	public List<Map<String, Object>> queryReturnLocal(
			List<PropertyFilter> propertyFilterList) {
		ticketsellqrydao = new TicketSellQryDao();
		if(propertyFilterList!=null && propertyFilterList.size() >0){
			for(int i=propertyFilterList.size()-1;i>=0;i--){	
				PropertyFilter propertyFilter=propertyFilterList.get(i);
				if("s!id".equals(propertyFilter.getPropertyFullName().toString())){
					long id= (Long) propertyFilter.getMatchValue();
					if(id>0){
						String schedulecode=ticketsellqrydao.queryScheduleCode(id);
						PropertyFilter propertyFilter_new =new PropertyFilter("LIKES_s!code",schedulecode);
						propertyFilterList.remove(propertyFilter);
						propertyFilterList.add(propertyFilter_new);			
					}
				}
			}
		}
		return ListUtil.listToMap(new Object[] { "selltime", "ticketno",
				"ticketprice", "returnamount", "returnvoucherno", "returntime",
				"returnip", "returnway", "charges", "returnbyname",
				"returnbycode", "sellbyname", "stationservicefee",
				"schedulecode", "departdate", "departtime", "seatno",
				"orgname", "billbypename", "billcode", "reachstationname",
				"departstationname", "remarks", "returnorgname", "computefee",
				"coolairfee", "additionfee", "waterfee", "insurefee",
				"otherfee", "moreprice", "subtotal", "routename" },
				ticketsellqrydao.queryReturnLocla(propertyFilterList),
				new Object[] { Timestamp.class, String.class, BigDecimal.class,
						BigDecimal.class, String.class, Timestamp.class,
						String.class, String.class, BigDecimal.class,
						String.class, String.class, String.class,
						BigDecimal.class, String.class, Date.class,
						String.class, short.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						String.class });
	}

	/**
	 * 分布式、集中式异站售本站
	 */
	@Override
	public List<Map<String, Object>> queryFocusSaleLocal(
			List<PropertyFilter> propertyFilterList,Global global,Qryparam qp) {
		ticketsellqrydao = new TicketSellQryDao();
		
		List<SaleLocalTicketQryVo> list=ticketsellqrydao.queryFocusSaleLocal(propertyFilterList,global.getOrganization().getId(),qp);
		List<Object> list2=new ReportUtil<SaleLocalTicketQryVo>().saveToFile(list,global,PaginationReportName.SALELOCALTICKETQRY);
		return ListUtil.listToMap(new Object[] {SaleLocalTicketQryVo.class} ,list2, new Object[] {SaleLocalTicketQryVo.class});
/*		return ListUtil.listToMap(
				new Object[] {"currorgname","orderno","returnway",
						"istaked","taketime","sellway","paymethod",
						"sellip", "selltime", "buspark", "price",
						"discountrate", "fullprice", "distance", "islinework",
						"ticketentrance", "departdate", "departtime", "seatno",
						"ticketno", "ticketstatus", "tickettype",
						"stationservicefee", "ischecked", "checktime",
						"checkedname", "checkstationname", "sellname",
						"reachstationname", "departstationname",
						"schedulecode", "tickettypename", "agentname",
						"remarks", "charges", "returnip", "ticketoutletname",
						"returnsationname", "returnbyname", "returntime",
						"vehicletypename", "orgname", "isdepartinvoices",
						"computefee", "coolairfee", "additionfee", "waterfee",
						"insurefee", "otherfee", "moreprice", "subtotal",
						"routename","olddepartdate","manualreturnnum","manualreturnmoney" },
				ticketsellqrydao.queryFocusSaleLocal(propertyFilterList,orgid,qp),
				new Object[] {String.class,String.class,String.class,
						String.class,String.class,String.class,String.class,
						String.class, Timestamp.class, String.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						Long.class, boolean.class, String.class, Date.class,
						String.class, short.class, String.class, String.class,
						String.class, BigDecimal.class, boolean.class,
						Timestamp.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class, String.class,
						BigDecimal.class, String.class, String.class,
						String.class, String.class, Timestamp.class,
						String.class, String.class, boolean.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, String.class ,Date.class,
						BigDecimal.class,BigDecimal.class });*/
	}

	/**
	 * 分布式、集中式本站售异站
	 */
	@Override
	public List<Map<String, Object>> queryFocusSaleOther(
			List<PropertyFilter> propertyFilterList, String scheduleorgid,
			Long orgid) {
		ticketsellqrydao = new TicketSellQryDao();
		return ListUtil.listToMap(new Object[] { "sellorgname","ticketoutletsname","orderno","distance","ticketentrance",
				"departdate", "departtime", "sellip","fullprice","tickettype","returnway","sellway","paymethod", "price", "seatno",
				"ticketno", "selltime", "ticketstatus", "sellname",
				"schedulecode", "remarks", "charges", "returnip", "returntime",
				"returnsationname", "returnbyname", "departstationname",
				"reachstationname", "orgname", "stationservicefee",
				"computefee", "coolairfee", "additionfee", "waterfee",
				"insurefee", "otherfee", "moreprice", "subtotal" },
				ticketsellqrydao.queryFocusSaleOther(propertyFilterList,
						scheduleorgid, orgid),//
				new Object[] { String.class,String.class,String.class, long.class,String.class,
						Date.class, String.class,String.class,BigDecimal.class,String.class,String.class,String.class,String.class, BigDecimal.class, short.class,
						String.class, Timestamp.class, String.class,
						String.class, String.class, String.class,
						BigDecimal.class, String.class, Timestamp.class,
						String.class, String.class, String.class, String.class,
						String.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class });
	}

	/**
	 * 电子票明细查询
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@Override
	public List<Map<String, Object>> queryTicketDetail(Qryparam qp) {
		ticketsellqrydao = new TicketSellQryDao();
		return ListUtil.listToMap(
				new Object[] { "sellip", "selltime", "buspark", "ticketentrance", "price", "fueladditionfee",
						"stationservicefee", "discountrate", "fullprice", "distance", "carrychildnum", "departdate",
						"departtime", "seatno", "ticketno", "sellway", "ticketstatus", "paymethod", "orgname",
						"schedulecode", "dpartname", "reachname", "sellname", "ischecked", "isdepartinvoices",
						"islocal", "vehicletypename", "tickettypename", "islinework", "ticketoutletname",
						"customername", "hticketoutlesname", "houtletsaddress", "checkedname", "checkstationname",
						"departinvoicesbyname", "departinvoicesno", "departinvoicestime", "servicefee",
						"vehiclebrandmodelname", "checktime", "computefee", "coolairfee", "additionfee", "isovertime",
						"routename", "ticketprice", "returnamount", "returnbyname", "returntime", "returnway",
						"moreprice", "otherfee", "insurefee", "waterfee", "serviceprice", "subtotal", "printname",
						"printorgname", "certificatetype", "certificateno", "mobilephone", "email", "lastbuytickettime",
						"taketime", "istaked", "orderno" },
				ticketsellqrydao.queryTicketDetail(qp),
				new Object[] { String.class, Timestamp.class, String.class, String.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, Long.class, BigDecimal.class, Long.class, byte.class,
						Date.class, String.class, byte.class, String.class, String.class, String.class, String.class,
						String.class, String.class, String.class, String.class, String.class, boolean.class,
						boolean.class, boolean.class, String.class, String.class, boolean.class, String.class,
						String.class, String.class, String.class, String.class, String.class, String.class,
						String.class, Timestamp.class, BigDecimal.class, String.class, Timestamp.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class, boolean.class, String.class,
						BigDecimal.class, BigDecimal.class, String.class, Timestamp.class, String.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, String.class, String.class, String.class, String.class, String.class,
						String.class, Timestamp.class, Timestamp.class, boolean.class, String.class });
	}

	/**
	 * 远程检票信息查询
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> queryrRemoteticketsell(
			List<PropertyFilter> propertyFilterList) {
		ticketsellqrydao = new TicketSellQryDao();
		return ListUtil.listToMap(new Object[] {
		"ticketno", "departdate", "schedulecode", "departtime", "seatno",
				"vehicletypename", "vehicleno", "serviceprice", "islinework",
				"carrychildnum", "distance", "fullprice", "tickettype",
				"discountrate", "stationservicefee", "fueladditionfee",
				"price", "paymethod", "ticketentrance", "buspark",
				"ticketoutletsname", "sellby", "selltime", "sellip", "sellway",
				"ticketstatus", "batchno", "servicefee", "toplimitprice",
				"seattype", "computefee", "additionfee", "coolairfee",
				"moreprice", "orderno", "waterfee", "insurefee", "otherfee",
				"checkby", "checktime", "checktype", "isdepartinvoices",
				"ischecked", "departinvoicestime"

				, "dorgname", "corgname", "sellorgname", "dpartname",
				"reachname", "sellbyname", "routename", "subtotal",
				"tickettypename" },
				ticketsellqrydao.queryrRemoteticketsell(propertyFilterList),
				new Object[] { String.class, Date.class, String.class,
						String.class, Integer.class, String.class, String.class,
						BigDecimal.class, boolean.class, Integer.class,
						Long.class, BigDecimal.class, String.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, String.class, String.class,
						String.class, String.class, String.class,
						Timestamp.class, String.class, String.class,
						String.class, String.class, BigDecimal.class,
						BigDecimal.class, String.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						String.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, String.class, Timestamp.class,
						String.class, boolean.class, boolean.class,
						Timestamp.class

						, String.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						BigDecimal.class, String.class });
	}

	@Override
	public List<Map<String, Object>> qryTaketicketlog(String operatorgname,
			String sellticketorgid, String ticketoutletsid, Date dtpstartdate,
			Date dtpenddate) {
		ticketsellqrydao = new TicketSellQryDao();
		return ListUtil.listToMap(new Object[] {"sellorgname","schorgname","ticketno","departdate","departtime","schcode","departstationname"
				,"reachstationname","tickettypename","ticketprice","seatno","orderno","password","customername"
				,"certificateno","mobilephone","selltime","taketime","takeway","status","operatorname"
				,"operatorgname","ticketoutletsname","takecompute","remark"},
				ticketsellqrydao.qryTaketicketlog(operatorgname,sellticketorgid,
						ticketoutletsid,dtpstartdate,dtpenddate),
				new Object[] { String.class,String.class,String.class,Date.class,String.class,String.class,String.class,
			String.class,String.class,BigDecimal.class,long.class,String.class,String.class,String.class,
			String.class,String.class,Timestamp.class,Timestamp.class,String.class,String.class,String.class,
			String.class,String.class,String.class,String.class});
	}
	
	@Override
	public List<Map<String, Object>> queryChangeCancelTicket(List<PropertyFilter> propertyFilterList,String sign, Date dtpstartdate, Date dtpenddate) {
		ticketsellqrydao = new TicketSellQryDao();
		if ("0".equals(sign)) {
			return ListUtil.listToMap(
					new Object[] { "name", "id", "cancelnum", "cancelmoney", "eticketnum", "eticketmoney" },
					ticketsellqrydao.queryChangeCancelTicket(propertyFilterList,sign,dtpstartdate,dtpenddate), new Object[] { String.class,
							long.class, long.class, BigDecimal.class, long.class, BigDecimal.class });
		} else if ("1".equals(sign)) {//1 废票
			return ListUtil.listToMap(
					new Object[] { "ticketno", "price" },
					ticketsellqrydao.queryChangeCancelTicket(propertyFilterList,sign,dtpstartdate,dtpenddate), new Object[] { long.class, BigDecimal.class });
		} else if ("2".equals(sign)) {//2 换票
			return ListUtil.listToMap(
					new Object[] { "ticketno", "price" },
					ticketsellqrydao.queryChangeCancelTicket(propertyFilterList,sign,dtpstartdate,dtpenddate), new Object[] { long.class, BigDecimal.class });
		} else {
			return null;
		}
	}
	
	public boolean saveCustomerinfo(String certificateno, long customerid, String customername, Date birthday, String sex, String ticketno) throws ServiceException {
		//Customer customer = (Customer) ticketsellqrydao.get(Customer.class, customerid);
		Customer customer =ticketsellqrydao.findCustomer(certificateno);
		Ticketsell ts = ticketsellqrydao.findTicketsell(ticketno);
		if(ts==null){
			//车票不存在
			throw new ServiceException("0187");
		}
		customer.setName(customername);
		Date now = new Date();
		if(customer==null){
			customer = new Customer();
			customer.setCertificateno(certificateno);
			customer.setCertificatetype("0");
			customer.setName(customername);
			customer.setBirthday(birthday);
			customer.setSex(sex);
			customer.setInputway("0");
			customer.setLastbuytickettime(now);
			customer.setOrgid(CurrentUtil.getGlobal().getOrganization().getId());
			customer.setCreateby(CurrentUtil.getGlobal().getUserinfo().getId());
			customer.setUpdateby(CurrentUtil.getGlobal().getUserinfo().getId());
			customer.setCreatetime(now);
			customer.setUpdatetime(now);
		}
		Customer c = (Customer) ticketsellqrydao.merge(customer);
		ts.setCustomer(c);
		ticketsellqrydao.merge(ts);
		return true;
	}
	/**
	 * 安全接口根据日期和票号查看票的有效性
	 */
	@Override
	public Map<String,String> checkTicketValidity(String datetoDay,
			String strTicketNumber) {
		Map<String,String> map = new HashMap<String,String>();
		Ticketsell ts = ticketsellqrydao.findTicketsell(strTicketNumber);
		if(ts==null){
			map.put("boolTicketValidity", "0");
		}else {
			
			if(ts.getDepartdate()!=null && ts.getTicketstatus().equals("0") && DateUtils.compare(ts.getDepartdate(), DateUtils.strToDate(datetoDay))==0){
				map.put("boolTicketValidity", "1");
			}else{
				map.put("boolTicketValidity", "0");
			}
			Long schduleid = ts.getScheduleid();
			Map<String,Object> param = new HashMap<String, Object>();
			param.put("id", schduleid);
			List<Schedule> scheduleList = ticketsellqrydao.find(Schedule.class,param);
			if(scheduleList!=null && scheduleList.size()==1){
				map.put("strBusReportNumber", scheduleList.get(0).getCode());
			}
		}
		return map;
	}
}
