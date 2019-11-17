/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.checkticket.service.impl<br/>
 * <b>文件名：</b>DepartinvoicesManagerServiceImpl.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2011-7-13 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.checkticket.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.balance.model.Vehicleviolation;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Ticketoutlets;
import cn.nova.bus.base.model.Unit;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.base.model.Vehiclebrandmodel;
import cn.nova.bus.base.model.Vehicletype;
import cn.nova.bus.bill.model.Billinuse;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.BillinuseService;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BillinuseServiceImpl;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.checkticket.dao.DepartinvoiceDao;
import cn.nova.bus.checkticket.dao.DepartinvoicesManagerDao;
import cn.nova.bus.checkticket.model.Departinvoices;
import cn.nova.bus.checkticket.model.Departinvoicesdeductdetail;
import cn.nova.bus.checkticket.service.DepartinvoiceService;
import cn.nova.bus.checkticket.service.DepartinvoicesManagerService;
import cn.nova.bus.checkticket.vo.DepartinvoicesVo;
import cn.nova.bus.common.ConstDefiniens;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.dispatch.plugin.PluginFunction;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.sale.dao.TicketDao;
import cn.nova.bus.sale.model.RemoteTicketsell;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;
import models.ActionNode;
import util.Appvar;

/**
 * <b>类描述：</b> <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-7-13 下午02:38:39 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("unchecked")
public class DepartinvoicesManagerServiceImpl implements
		DepartinvoicesManagerService {

	private BillinuseService billinuseService = new BillinuseServiceImpl();
	
	private DepartinvoicesManagerDao departinvoicesManagerDao = new DepartinvoicesManagerDao();
	
	private DepartinvoiceService departinvoiceService = new DepartinvoiceServiceImpl();
	
	private TicketDao ticketdao = new TicketDao();
	
	private ParameterService parameterService = new ParameterServiceImpl();

	
	private BilltypeService billtypeService = new BilltypeServiceImpl();
	/**
	 * 查询结算单信息
	 */
	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		
		if(propertyFilterList!=null && propertyFilterList.size() >0){
			for(int i=propertyFilterList.size()-1;i>=0;i--){	
			PropertyFilter propertyFilter=propertyFilterList.get(i);
			if("t!scheduleid".equals(propertyFilter.getPropertyFullName())){
				long id= (Long) propertyFilter.getMatchValue();
				if(id>0){
					String schedulecode=departinvoicesManagerDao.queryScheduleCode(id);
					PropertyFilter propertyFilter_new =new PropertyFilter("LIKES_sc!code",schedulecode);
					propertyFilterList.remove(propertyFilter);
					propertyFilterList.add(propertyFilter_new);			
				}
			}
			}
		}

		return ListUtil
				.listToMap(new Object[] { 
					 	"id","departinvoicesno", "scheduleplanid",  "departdate",  "scheduleid",          
					 	"departtime", "departstationid",   "vehicleid" ,  "reportid",    "ticketnum",          
					  "totalamount", "stationservicefee",  "fueladditionfee",  "othterfee" ,"agentfee",           
					  "balanceamount", "printorgid", "printip" , "printby", "printtime",          
					  "cancelstationid",  "cancelby",  "canceltime", "status", "balanceid",          
					  "balancestationid",   "balanceby",   "balancedate",  "supplyticketnum",   "supplyamount" ,      
					  "supplybalanceamount", "createtime",   "createby",  "updatetime", "updateby",           
					  "printway",  "balanceunitid",    "moreprice",   "iscomputeno", "isreplace",          
					  "driver1id", "driver2id", "steward1id", "ticketoutletsid", "seller",             
					  "packes", "packbalanceprice", "departinvoicesid" ,
						"schedulename",
						"departstationname", "statusname", "vehiclename",
						"reportname", "orgname", "printname", "balancename",
						"createname", "updatename", "balancestationname",
						"cancelname", "cancelstationname", "routename",
						"endstationname", "seatnum", "unitname","totalbalancemoney","balanceunitname","departtimes","balanceno","checkmoney"
						,"nopaperticketnum","paperticketnum","handtickets","isapproved"},
						departinvoicesManagerDao.query(propertyFilterList),
						new Object[] {
								Long.class,	String.class,Long.class,Date.class,Long.class,	
								String.class,Long.class,Long.class,Long.class,Long.class,
								BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
								BigDecimal.class,Long.class,String.class,Long.class,Timestamp.class,
								Long.class,	Long.class,	Timestamp.class,String.class,Long.class,	
								Long.class,	Long.class,	Date.class,Long.class,BigDecimal.class,
								BigDecimal.class,Timestamp.class,Long.class,Timestamp.class,Long.class,
								String.class, Long.class,BigDecimal.class,Boolean.class,Boolean.class,
								Long.class,Long.class,Long.class,Long.class,Long.class,
								Long.class,BigDecimal.class,Long.class,		
								String.class,
								String.class, String.class, String.class,
								String.class, String.class, String.class,
								String.class, String.class, String.class,
								String.class, String.class, String.class,
								String.class, String.class, Short.class,
								String.class,BigDecimal.class ,String.class,String.class,String.class,BigDecimal.class,Long.class,Long.class,Long.class,Boolean.class});	
//		return ListUtil
//				.listToMap(new Object[] { Departinvoices.class, "schedulename",
//						"departstationname", "statusname", "vehiclename",
//						"reportname", "orgname", "printname", "balancename",
//						"createname", "updatename", "balancestationname",
//						"cancelname", "cancelstationname", "routename",
//						"endstationname", "seatnum", "unitname","totalbalancemoney","balanceunitname" },
//						departinvoicesManagerDao.query(propertyFilterList),
//						new Object[] { Departinvoices.class, String.class,
//								String.class, String.class, String.class,
//								String.class, String.class, String.class,
//								String.class, String.class, String.class,
//								String.class, String.class, String.class,
//								String.class, String.class, Short.class,
//								String.class,BigDecimal.class ,String.class});
	}

	@Override
	public boolean save(Departinvoices departinvoices) {
		if (departinvoices.getId() == 0) {
			return departinvoicesManagerDao.save(departinvoices);
		}
		return departinvoicesManagerDao.update(departinvoices);
	}

	/**
	 * 注销结算单
	 */
	@Override
	public boolean cancel(Departinvoices departinvoices,Global global)
			throws ServiceException {
		Departinvoices dd = (Departinvoices) departinvoicesManagerDao.get(
				Departinvoices.class, departinvoices.getId());
		int limitday = new Integer(parameterService.findParamValue(ParamterConst.Param_3042,   //3019改3042
				dd.getPrintorgid()));
		if (DateUtils.getIntervalDays(dd.getDepartdate(), new Date()) >= limitday) {
			// 已超过注销结算单天数
			throw new ServiceException("0368");
		}
		Scheduleplan scheduleplan=(Scheduleplan) departinvoicesManagerDao.get(Scheduleplan.class, dd.getScheduleplanid());
		List<Scheduleseats> seatslist=scheduleplan.getScheduleseatslist();
		List<Ticketsell> list = ticketdao.getTicketResult(departinvoices
				.getId());
		if (!list.isEmpty()) {
			for (int i = 0; i < list.size(); i++) {
				Ticketsell ticketsell = (Ticketsell) ticketdao.get(
						Ticketsell.class, list.get(i).getId());
				ticketsell.setIsdepartinvoices(false);
				ticketsell.setDepartinvoices(null);
				ticketsell.setDepartinvoicesby(null);
				ticketsell.setDepartinvoicestime(null);
				ticketsell.setUpdateby(departinvoices.getUpdateby());
				ticketsell.setUpdatetime(new Date());
				ticketdao.merge(ticketsell);
				if(!scheduleplan.getIslinework()){
					for(Scheduleseats seats:seatslist){
						if(seats.getSeatno()==ticketsell.getSeatno()){
							seats.setStatus("7");//已检
							seats.setUpdateby(departinvoices.getUpdateby());
							seats.setUpdatetime(new Date());
							departinvoicesManagerDao.getEntityManager().merge(seats);
						}
					}
				}
			}
		}
		List<RemoteTicketsell> rlist = ticketdao.getRemoteTicketsell(departinvoices.getId());
		if (!rlist.isEmpty()) {
			for (int i = 0; i < rlist.size(); i++) {
				RemoteTicketsell ts = (RemoteTicketsell) ticketdao.get(
						RemoteTicketsell.class, rlist.get(i).getId());
				ts.setIsdepartinvoices(false);
				ts.setDepartinvoicesid(null);
				ts.setDepartinvoicesby(null);
				ts.setDepartinvoicestime(null);
				ts.setUpdateby(departinvoices.getUpdateby());
				ts.setUpdatetime(new Date());
				ticketdao.merge(ts);
				if(!scheduleplan.getIslinework()){
					for(Scheduleseats seats:seatslist){
						if(seats.getSeatno()==ts.getSeatno()){
							seats.setStatus("7");//已检
							seats.setUpdateby(departinvoices.getUpdateby());
							seats.setUpdatetime(new Date());
							departinvoicesManagerDao.getEntityManager().merge(seats);
						}
					}
				}
			}
		}
		/*
		 * List<Departinvoicesdetail> dlist = dservice.getResult(departinvoices
		 * .getId()); if (!dlist.isEmpty()) { for (int i = 0; i < dlist.size();
		 * i++) { Departinvoicesdetail invoicesdetail = dservice
		 * .getDepartinvoicesdetail(dlist.get(i).getId());
		 * invoicesdetail.setStatus("1");
		 * invoicesdetail.setUpdateby(departinvoices.getUpdateby());
		 * invoicesdetail.setUpdatetime(departinvoices.getUpdatetime());
		 * dservice.save(invoicesdetail); } }
		 */
		//非流水班情况，才校验是否有多张
		if (scheduleplan.getIslinework()||!departinvoicesManagerDao.isOtherDeprartinvoices(dd.getDepartdate(),dd.getScheduleplanid(),dd.getId())){
			// 取消报到表的发班状态
			Vehiclereport vr = (Vehiclereport) departinvoicesManagerDao.get(
					Vehiclereport.class, departinvoices.getReportid());
			vr.setIsdeparted(false);
			vr.setUpdateby(departinvoices.getUpdateby());
			vr.setUpdatetime(new Date());
			departinvoicesManagerDao.getEntityManager().merge(vr);
		}
		String QueryFirstCheckNodeName = "CANCELFIRSTCHECK";
		ActionNode actionNode = Appvar.routes.get(QueryFirstCheckNodeName);
		if(actionNode!=null){
			Vehiclereport vehiclereport = (Vehiclereport) departinvoicesManagerDao.get(Vehiclereport.class, departinvoices.getReportid());
			Map<String, Long> map = new HashMap<String, Long>();
			map.put("vehiclereportid", vehiclereport.getId());
			PluginFunction.DoPlugin(map, global,actionNode);
		}	
		return departinvoicesManagerDao.update(departinvoices);
	}

	/**
	 * 判断结算单是否已经结算
	 */
	@Override
	public boolean isDepartinvoices(long scheduleplanid)
			throws ServiceException {
		if (departinvoicesManagerDao.isDepartinvoices(scheduleplanid)) {
			throw new ServiceException("0309");
		}
		return false;
	}

	@Override
	public Departinvoices getById(long id) {
		return (Departinvoices) departinvoicesManagerDao.get(
				Departinvoices.class, id);
	}

	/**
	 * 补开结算单时、获取未开运量的信息
	 */
	@Override
	public List<Map<String, Object>> queryResult(String isdepartinvoices,
			Long scheduleplanid, Long departinvoicesid, long vehiclereportid) {
		return ListUtil
				.listToMap(new Object[] { "checkedname", "departdate",
						"starttime", "seatnum", "soldeatnum", "ticketentrance",
						"buspark", "yeschecked", "nochecked", "code",
						"startname", "endname", "typename", "d1name", "d2name",
						"d3name", "d4name", "s1name", "s2name", "vehicleno",
						"brandname", "unitname", "routename", "distance",
						"balanceunitname" }, departinvoicesManagerDao
						.queryResult(isdepartinvoices, scheduleplanid,
								departinvoicesid, vehiclereportid),
						new Object[] { String.class, Date.class, String.class,
								String.class, String.class, String.class,
								String.class, String.class, String.class,
								String.class, String.class, String.class,
								String.class, String.class, String.class,
								String.class, String.class, String.class,
								String.class, String.class, String.class,
								String.class, String.class, Integer.class,
								String.class });
	}

	/*
	 * chanageDepartinvoices方法：换车打印<br/> <br/>
	 * 
	 * @param departinvoicesid
	 * 
	 * @return
	 * 
	 * @throws ServiceException
	 * 
	 * @see cn.nova.bus.checkticket.service.DepartinvoicesManagerService#
	 * chanageDepartinvoices(long)
	 * 
	 * @exception
	 */
	@Override
	public List<Map<String, Object>> chanageDepartinvoices(Global global,
			long scheduleplanid, long vehiclereportid, long newvehicleid,
			String printip, String departinvoicesno,
			boolean iscomputeno) throws ServiceException, ParseException {
		long departstationid=global.getOrganization().getId();
		long updateby=global.getUserinfo().getId();
		List<Departinvoices> dds = departinvoicesManagerDao.qryDepartinvoices(
				scheduleplanid, vehiclereportid);
		if (dds == null || dds.size() == 0) {
			// 已注销
			throw new ServiceException("0311");
		}
		Userinfo userinfo = (Userinfo) departinvoicesManagerDao.get(
				Userinfo.class, updateby);
		Station cancelstation = (Station) departinvoicesManagerDao.get(
				Station.class, departstationid);
		// 注销结算单，并更新车票
		for (Departinvoices dd : dds) {
			if (dd.getStatus().equals("2")) {
				// 已结算
				throw new ServiceException("0310");
			}
			List<Departinvoicesdeductdetail> ddts = dd
					.getDepartinvoicesdeductdetails();
			for (Departinvoicesdeductdetail ddt : ddts) {
				ddt.setStatus("1");
				ddt.setUpdateby(updateby);
				ddt.setUpdatetime(new Date());
				departinvoicesManagerDao.merge(ddt);
			}
			/*
			 * List<Departinvoicesdetail> ddes = dd.getDepartinvoicesdetails();
			 * for (Departinvoicesdetail dde : ddes) { //dde.setStatus("1");
			 * dde.setUpdateby(updateby); dde.setUpdatetime(new Date());
			 * departinvoicesManagerDao.merge(dde); }
			 */
			dd.setStatus("1");
			dd.setUpdateby(updateby);
			dd.setUpdatetime(new Date());

			dd.setCancel(userinfo);
			dd.setCancelstation(cancelstation);
			dd.setCanceltime(new Date());
			departinvoicesManagerDao.updateDepartTickets(dd.getId());
			//注销远检的结算单
			int record=departinvoicesManagerDao.updateDepartRemoteTickets(dd.getId());
			System.out.println(record);
		}
		// 取消发班
		departinvoiceService.cancelDepartinvoices(departstationid,
				scheduleplanid, vehiclereportid, updateby);

		Vehicle newvehicle = (Vehicle) departinvoicesManagerDao.get(
				Vehicle.class, newvehicleid);
		Scheduleplan scheduleplan = (Scheduleplan) departinvoicesManagerDao
				.get(Scheduleplan.class, scheduleplanid);
		Vehiclereport vehiclereport = (Vehiclereport) departinvoicesManagerDao
				.get(Vehiclereport.class, vehiclereportid);
		short seatnum = newvehicle.getSeatnum();
		// 若非流水班次,修改座位数
		if (!scheduleplan.getIslinework()) {
			String allowreport = parameterService.findParamValue(ParamterConst.Param_2010,
					scheduleplan.getOrgid());
			// 新车辆座位数小于已售座位数，不允许更换！
			if (seatnum < scheduleplan.getSoldeatnum()) {
				throw new ServiceException("0312");
			}
			List<Scheduleseats> sst = scheduleplan.getScheduleseatslist();
			short maxseat = 0;
			for (Scheduleseats ss : sst) {
				if (!ss.getStatus().equals("0")) {
					if (ss.getSeatno() > maxseat) {
						maxseat = ss.getSeatno();
					}
				}
			}
			if (seatnum < maxseat) {
				// 新车辆座位数小于该班次最大的非空座座位号，不允许更换！
				throw new ServiceException("0313");
			}
			// 报到车辆座位数小于班次座位数，是否允许报到
			allowreport = parameterService.findParamValue("2011",
					vehiclereport.getOrgid());
			if (ParamterConst.COMMON_FLAG.FALG_NO.equals(allowreport) && seatnum < scheduleplan.getSeatnum()) {
				throw new ServiceException("0068");
			}
			// 报到车辆座位数小于班次座位数
			if (seatnum > scheduleplan.getSoldeatnum()
					&& seatnum < scheduleplan.getSeatnum()) {
				Iterator<Scheduleseats> it = sst.iterator();
				while (it.hasNext()) {
					Scheduleseats ss = it.next();
					if (ss.getSeatno() > seatnum) {
						departinvoicesManagerDao.delete(ss);
						it.remove();
					}
				}
				List<Ticketprice> tps = scheduleplan.getTicketpricelist();
				for (Ticketprice tp : tps) {
					if (tp.getSeatnos().equals("0")||tp.getSeatnos().equals("全部")) {
						if (tp.getSeatnum() > seatnum) {
							tp.setSeatnum(seatnum);
							tp.setUpdateby(vehiclereport.getCreateby());
							tp.setUpdatetime(new Date());
							departinvoicesManagerDao.merge(tp);
						}
					} else {
						String curseatnos = "";
						String seatnos = tp.getSeatnos();
						String[] seats = seatnos.split(",");
						for (int i = 0; i < seats.length; i++) {
							short seat = new Short(seats[i]);
							if (seat <= seatnum) {
								curseatnos = curseatnos + "," + seats[i];
							}
						}
						curseatnos = curseatnos.substring(1,
								curseatnos.length());
						if (tp.getSeatnum() > seatnum) {
							tp.setSeatnum(seatnum);
						}
						tp.setSeatnos(curseatnos);
						tp.setUpdateby(vehiclereport.getCreateby());
						tp.setUpdatetime(new Date());
						departinvoicesManagerDao.merge(tp);
					}
				}
				scheduleplan.setSeatnum(seatnum);
				scheduleplan.setUpdateby(vehiclereport.getCreateby());
				scheduleplan.setUpdatetime(new Date());
				departinvoicesManagerDao.merge(scheduleplan);

			}
			// 若报到车辆座位数大于班次座位数，则改变班次座位数
			else if (seatnum > scheduleplan.getSeatnum()) {
				short seatno = (short) (scheduleplan.getSeatnum() + 1);
				String seattype = "0";
				List<Ticketprice> tps = scheduleplan.getTicketpricelist();
				if (tps != null && tps.size() > 0) {
					seattype = tps.get(0).getSeattype();
				}
				String seatnos = "";
				for (int i = seatno; i <= seatnum; i++) {
					seatnos = seatnos + "," + seatno;
					Scheduleseats ss = new Scheduleseats();
					ss.setCreateby(vehiclereport.getCreateby());
					ss.setCreatetime(new Date());
					ss.setDepartdate(scheduleplan.getDepartdate());
					ss.setOrgid(scheduleplan.getOrgid());
					ss.setScheduleid(scheduleplan.getScheduleid());
					ss.setScheduleplan(scheduleplan);
					ss.setSeatno((short) i);
					ss.setSeattype(seattype);
					ss.setStatus("0");// 空座
					ss.setUpdateby(vehiclereport.getCreateby());
					ss.setUpdatetime(new Date());
					departinvoicesManagerDao.getEntityManager().merge(ss);
				}

				for (Ticketprice tp : tps) {
					if (tp.getSeattype().equals(seattype)) {
						tp.setSeatnum(seatnum);
						if (!tp.getSeatnos().equals("0")) {
							tp.setSeatnos(tp.getSeatnos() + seatnos);
						}
						tp.setUpdateby(vehiclereport.getCreateby());
						tp.setUpdatetime(new Date());
						departinvoicesManagerDao.getEntityManager().merge(tp);
					}
				}
				scheduleplan.setSeatnum(seatnum);
				scheduleplan.setUpdateby(vehiclereport.getCreateby());
				scheduleplan.setUpdatetime(new Date());
				departinvoicesManagerDao.merge(scheduleplan);
			}
		}
		// 更新报到车辆
		vehiclereport.setIsdeparted(false);
		vehiclereport.setVehicleid(newvehicle.getId());
		// vehiclereport.setVehicletypeid(newvehicle.getVehicletypeid());
		vehiclereport.setUpdateby(updateby);
		vehiclereport.setUpdatetime(new Date());
		departinvoicesManagerDao.merge(vehiclereport);
		String printway = "2";// 换车打印
		// 重新发班打单
		return departinvoiceService.schDepartinvoice(global,
				scheduleplanid, vehiclereportid, printip, 
				departinvoicesno, printway, iscomputeno);
	}

	@Override
	public List<Map<String, Object>> qryunchecktickets(Date departdate,
			long vehicleid,  String batchno,String ticketno,String schedulecode,String departtime) {

		return ListUtil.listToMap(new Object[] { "isselect", "id",
				"departdate", "departtime", "code", "stationname", "ticketno","seatno",
				"vehicleno", "price", "selltime", "sellbyname", "reportid",
				"scheduleplanid", "routename","sellotherid","istaked" }, departinvoicesManagerDao
				.qryunchecktickets(departdate, vehicleid,  batchno,ticketno,schedulecode,departtime),
				new Object[] { boolean.class, String.class,
						Date.class,	String.class, String.class, String.class, String.class,	String.class,
						String.class,BigDecimal.class, Timestamp.class,
						String.class, long.class, long.class, String.class ,Long.class,Integer.class});
	}

	@Override
	public List<Map<String, Object>> printDepartinvoices(Global global,
			long scheduleplanid, long vehiclereportid, String ticketids,
			String departinvoicesno) throws ServiceException, ParseException {
		Date now=new Date();
		Scheduleplan sp=(Scheduleplan) departinvoicesManagerDao.get(Scheduleplan.class, scheduleplanid);
		Vehiclereport vehiclereport=(Vehiclereport) departinvoicesManagerDao.get(Vehiclereport.class, vehiclereportid);		
		List<Ticketsell> tlist=departinvoicesManagerDao.qryunchecktickets(sp.getDepartdate(),ticketids);
		long checkedby=global.getUserinfo().getId();
		Organization org=global.getOrganization();
		Station checkstation = org.getStation();
		Userinfo userinfo = new Userinfo();
		userinfo.setId(checkedby);	
		long createdby=checkedby;
		Ticketoutlets tout=departinvoicesManagerDao.qryTicketoutlet(org.getId());
		for(Ticketsell ticket:tlist){
			String ticketstatus = ticket.getTicketstatus();
			// 正常、退票、废票
			if ("1".equals(ticketstatus)) {
				// 该车票已退
				throw new ServiceException(ticket.getTicketno(),"0121");
			} else if ("2".equals(ticketstatus)) {
				// 该车票已废
				throw new ServiceException(ticket.getTicketno(), "0122");
			} else if ("4".equals(ticketstatus)) {
				// 该车票挂失
				throw new ServiceException(ticket.getTicketno(), "0471");
			}
			ticket.setCheckstation(checkstation);
			ticket.setCheckedby(userinfo);
			ticket.setChecktime(now);
			ticket.setUpdateby(checkedby);
			ticket.setUpdatetime(now);
			ticket.setIschecked(true);
			ticket.setVehiclereport(vehiclereport);
			
			List<Scheduleseats> scheduleseatslist = sp.getScheduleseatslist();
			for (Scheduleseats seat : scheduleseatslist) {
				if (ticket.getSeatno() == seat.getSeatno()) {
					seat.setStatus("8");// 
					seat.setTickettype(ticket.getTickettype());
					seat.setUpdateby(checkedby);
					seat.setUpdatetime(now);
					departinvoicesManagerDao.getEntityManager().merge(seat);
					break;
				}
			}				
			//departinvoicesManagerDao.getEntityManager().merge(ticket);
		}
		Billtype billtype = billtypeService.findByCode(ConstDefiniens.BalanceBill);
		Billinuse billinuse = billinuseService.getBilluse(billtype.getId(),
				checkedby, new Long(departinvoicesno));
		String curDepartinvoicesno =departinvoicesno;
		if (billinuse == null || "2".equals(billinuse.getStatus())) {
			// 您的票据已经用完
			throw new ServiceException("0143");
		}
		if (billinuse.getNextno() > billinuse.getEndno() + 1) {
			// 当前票段剩余票数不够打印
			throw new ServiceException("0171");
		}
		// 补零操作
		curDepartinvoicesno = String.valueOf(billinuse.getNextno());

		if (billtype.getTicketnolength() != curDepartinvoicesno.length()) {
			curDepartinvoicesno = StringUtils.strPad(curDepartinvoicesno,
					(int) billtype.getTicketnolength(), "0");
		}
		if (!curDepartinvoicesno.equals(departinvoicesno)) {
			// 您的票据当前号码与系统的号码不一致，请重置票号！
			throw new ServiceException("0144");
		}
		List<Object> dvlist = new ArrayList<Object>();

		Vehicle vehicle = (Vehicle) departinvoicesManagerDao.get(Vehicle.class,
				vehiclereport.getVehicleid());
		Vehicletype vehicletype = (Vehicletype) departinvoicesManagerDao.get(
				Vehicletype.class, vehicle.getVehicletypeid());
		Vehiclebrandmodel vb = (Vehiclebrandmodel) departinvoicesManagerDao
				.get(Vehiclebrandmodel.class, vehicle.getVehiclebrandmodelid());
		Unit unit = (Unit) departinvoicesManagerDao.get(Unit.class,
				vehicle.getUnitid());
		Unit balanceunit = (Unit) departinvoicesManagerDao.get(Unit.class,
				vehicle.getBalanceunitid());
		String printip = global.getIpAddress();
		DepartinvoiceServiceImpl dep = new DepartinvoiceServiceImpl();
		DepartinvoicesVo departinvoicesVo = new DepartinvoicesVo();
		Schedulestatus schedulestatus = sp.getSchedulestatuslist().get(0);
		String printway = "1";// 补打
		departinvoicesVo = dep.createDepartinvoice(global, sp, vehicle, tlist,
				vehiclereport, now, vehicletype, vb, unit, balanceunit,
				schedulestatus.getDeparttime(), true, printip,
				departinvoicesno, printway);
		if (tout != null) {
			departinvoicesVo.setTicketoutname(tout.getName());
			departinvoicesVo.setTicketoutshort(tout.getJianpin());
		}
		dvlist.add(departinvoicesVo);
		if(!sp.getIslinework()){
			schedulestatus.setUpdateby(createdby);
			schedulestatus.setIsdeparted(true);			
			schedulestatus.setUpdatetime(now);
			departinvoicesManagerDao.getEntityManager().merge(schedulestatus);			
		}
		vehiclereport.setIsdeparted(true);
		vehiclereport.setUpdateby(createdby);
		vehiclereport.setUpdatetime(now);
		departinvoicesManagerDao.getEntityManager().merge(vehiclereport);		

		billinuse.setNextno(billinuse.getNextno() + 1);
		// 本次若是最后一张票据
		if (billinuse.getNextno() > billinuse.getEndno()) {
			billinuse.setStatus("2");
		}
		billinuse.setUpdateby(createdby);
		billinuse.setUpdatetime(new Date());
		departinvoicesManagerDao.getEntityManager().merge(billinuse);

		return ListUtil.listToMap(new Object[] { DepartinvoicesVo.class },
				dvlist, new Object[] { DepartinvoicesVo.class });
		
	}

	@Override
	public String qryvehisecuresult(Long vehiclereportid) {
		
		DepartinvoiceDao departinvoiceDao = new DepartinvoiceDao();
		Vehiclereport vehiclereport = (Vehiclereport) departinvoiceDao.get(
				Vehiclereport.class, vehiclereportid);
		if (vehiclereport != null) {
			List list = new ArrayList();
			list = departinvoiceDao.qrysecuresult(vehiclereport);
			if (list != null && list.size() > 0) {// 说明已经安检
				return (String) list.get(0);
			} else {// 未安检
				return null;
			}
		} else {
			return null;
		}
	}
	@Override
	public List<Departinvoices> queryDepartInvoicesBySchedulePlanId(
			long scheduleplanid) throws ServiceException {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleplanid", scheduleplanid));
		propertyFilters.add(new PropertyFilter("EQS_t!status", "0"));
		return departinvoicesManagerDao.find(Departinvoices.class,propertyFilters);
	}

	@Override
	public void updateVehicleviolation(long departinvoicesid) {
		List<Vehicleviolation> queryVehicleviolation = departinvoicesManagerDao.queryVehicleviolation(departinvoicesid);
		if (queryVehicleviolation != null) {
			for (Vehicleviolation vehicleviolation : queryVehicleviolation) {
				//将结算单Id更新为空
                vehicleviolation.setDepartinvoicesid(null);   
                //将“已打单”状态更新为“未结算”；
                if ("4".equals(vehicleviolation.getStatus())) {    
                	vehicleviolation.setStatus("0");          
                }
                departinvoicesManagerDao.merge(vehicleviolation);
			}
		}
	}

	
	/**
	 * 根据车辆id,查询车辆的报到记录
	 */
	@Override
	public List<Map<String, Object>> qryVehicleReport(long vehicleid, Date departdate, long scheduleplanid) {
		List<Object> list = departinvoicesManagerDao.qryVehicleReport(vehicleid, departdate, scheduleplanid);
		List sigleObj = new ArrayList();
		if (list.size() > 0 && list != null) {
			sigleObj.add(list.get(0));
		}
		return ListUtil.listToMap(new Object[] {Vehiclereport.class},
				sigleObj,
			new Object[] {Vehiclereport.class});
	}
	
	@Override
	public List<Map<String, Object>> qryNonomalSchadd(Global global) {
		return ListUtil.listToMap(new Object[] { "routename", "schedulecode","departdate",
				"departtime", "soldeatnum", "vehicleparkname" },
				departinvoicesManagerDao.qryNonomalSchadd( global), new Object[] {
						String.class, String.class, Date.class, String.class,long.class,
						String.class });
	}
	
	@Override
	public List<Map<String, Object>> qryNonomalSch(long stationid) {
		return ListUtil.listToMap(new Object[] { "departdate", "name","code",
				"departtime", "soldeatnum", "statusname",
				"reason" },
				departinvoicesManagerDao.qryNonomalSch(stationid), new Object[] {
						Date.class, String.class, String.class, String.class,String.class,
						String.class, String.class });
	}
	
	@Override
	public List<Map<String, Object>> qryTicketsellsByVehicle(Date departdate,
			long vehiclereportid, long scheduleplanid,String departinvoicesno) {
		return ListUtil.listToMap(new Object[] { "departdate", "name",
				"ticketno", "code", "departtime", "reachname", "seatno",
				"tickettypename", "price", "dticketstatus" },//,"departinvoicesno"
				departinvoicesManagerDao.qryTicketsellsByVehicle(departdate,
						vehiclereportid, scheduleplanid,departinvoicesno), new Object[] {
						Date.class, String.class, String.class, String.class,
						String.class, String.class, long.class, String.class,
						BigDecimal.class, String.class });//,String.class
	}
	@Override
	public List<Map<String, Object>> qryDepartinvoices(Date departdate,
			long vehicleid, long printorgid,Date departdateend) {
		return ListUtil.listToMap(new Object[] { "scheduleplanid","vehiclereportid","departdate", "routename",
				"code", "departtime", "vehicleno", "departinvoicesno", "tickets",
				"ticketnum", "balanceamount","reportid","scheduleplanid","stationname","departstatus" }, departinvoicesManagerDao
				.qryDepartinvoices(departdate, vehicleid, printorgid,departdateend),
				new Object[] { long.class,long.class ,Date.class, String.class,String.class,
						String.class, String.class, String.class, long.class,
						long.class, BigDecimal.class,long.class,long.class ,String.class,String.class});
	}

	@Override
	public List<Map<String, Object>> qryReportSchs(Date departdate,
			long vehicleid, long orgid) {
		return ListUtil.listToMap(new Object[] { "code", "departtime","reportid","scheduleplanid" },
				departinvoicesManagerDao.qryReportSchs(departdate, vehicleid,
						orgid), new Object[] { String.class, String.class,long.class,long.class });
	}
}
