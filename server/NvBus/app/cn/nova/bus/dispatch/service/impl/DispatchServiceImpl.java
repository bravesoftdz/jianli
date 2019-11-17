package cn.nova.bus.dispatch.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.persistence.LockModeType;
import javax.persistence.Query;

import play.Play;

import com.sun.xml.bind.v2.runtime.unmarshaller.XsiNilLoader.Array;

import models.ActionNode;
import util.Appvar;
import util.CommonUtil;
import util.CurrentUtil;
import cn.nova.bus.archive.model.Driver;
import cn.nova.bus.archive.model.Steward;
import cn.nova.bus.base.model.Cardissue;
import cn.nova.bus.base.model.Cycleschemesvehicle;
import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.base.model.Vehiclebrandmodel;
import cn.nova.bus.check.model.Securitycheck;
import cn.nova.bus.check.service.SecuritycheckService;
import cn.nova.bus.check.service.VehicledistanceactiveService;
import cn.nova.bus.check.service.impl.SecuritycheckServiceImpl;
import cn.nova.bus.check.service.impl.VehicledistanceactiveServiceImpl;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.common.PluginDefiniens;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.dao.DispatchServiceDao;
import cn.nova.bus.dispatch.dao.SeatreserveDao;
import cn.nova.bus.dispatch.model.Roadbillprint;
import cn.nova.bus.dispatch.model.Schedulemerge;
import cn.nova.bus.dispatch.model.Schedulestatuslog;
import cn.nova.bus.dispatch.model.Seatreserve;
import cn.nova.bus.dispatch.model.Vehicledriverreport;
import cn.nova.bus.dispatch.model.Vehiclelate;
import cn.nova.bus.dispatch.model.Vehiclelost;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.dispatch.model.Vehiclereportcancel;
import cn.nova.bus.dispatch.model.Vehiclerouteconctrl;
import cn.nova.bus.dispatch.plugin.PluginFunction;
import cn.nova.bus.dispatch.service.DispatchService;
import cn.nova.bus.dispatch.service.GenTicketpriceByHandpriceService;
import cn.nova.bus.dispatch.service.SeatreserveService;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.log.service.OperationLogService;
import cn.nova.bus.log.service.impl.OperationLogServiceImpl;
import cn.nova.bus.price.model.Handprice;
import cn.nova.bus.price.model.Handpriceitem;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Schedulevehiclepeopleplan;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.price.model.Ticketpriceformulaitem;
import cn.nova.bus.price.model.Ticketpriceitem;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.bus.util.PluginFunctionUtil;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;
import cn.nova.utils.orm.jpa.ListUtil;


public class DispatchServiceImpl implements DispatchService {

	
	private DispatchServiceDao dispatchServiceDao = new DispatchServiceDao();
	
	private IDAO<Vehiclereport> dao = new EntityManagerDaoSurport<Vehiclereport>();

	
	private ParameterService parameterService = new ParameterServiceImpl();
	
	//private VehicleService vehicleService = new VehicleServiceImpl();

	
	private SecuritycheckService securitycheckService = new SecuritycheckServiceImpl();

	
	private OperationLogService operationLogService = new OperationLogServiceImpl();

	
	//private TicketService ticketService = new TicketServiceImpl();

	
	private SeatreserveService seatreserveService = new SeatreserveServiceImpl();
	
	
	private IDAO idao = new EntityManagerDaoSurport();
	
	//private UserTransaction usertransaction = new UserTransaction();
	
	//车辆应班
	private Vehicledriverreport vdriver;
	
	private int reportinterval = 0;    //报班时间间隔
	
	@Override
	public List<Map<String, Object>> qryScheduleplan(//IC卡报班页面查询---
			List<PropertyFilter> propertyFilterList, long curstationid,
			Date departdate,long qrycurstationid) {
		if (departdate == null) {
			System.out
					.println("DispatchServiceImpl.qryScheduleplan departdate");
			java.text.SimpleDateFormat sf = new SimpleDateFormat("yyyy-mm-dd");
			try {
				departdate = sf.parse(sf.format(new Date()));
			} catch (ParseException e) {
				departdate = new Date();
				play.Logger.error(e.getMessage(), e);
			}
		}
//		if(propertyFilterList!=null && propertyFilterList.size() >0){
//			for(int i=propertyFilterList.size()-1;i>=0;i--){	
//			PropertyFilter propertyFilter=propertyFilterList.get(i);
//			if("s!code".equals(propertyFilter.getPropertyFullName())){
//				String schedulecode= (String) propertyFilter.getMatchValue();
//					PropertyFilter propertyFilter_new =new PropertyFilter("LIKES_s!code",schedulecode);
//					propertyFilterList.remove(propertyFilter);
//					propertyFilterList.add(propertyFilter_new);			
//				}
//			}
//		}
		List<Object> list = dispatchServiceDao.qryScheduleplan2(
				propertyFilterList, curstationid, departdate,qrycurstationid);
		return ListUtil.listToMap(new Object[] {"schtype", "reportorgid", "reportid",
				"id", "orgid", "departdate", "scheduleid", "code", "seatnum",
				"autocancelreserveseatnum", "unautocancelreserveseatnum",
				"fixedreserveseatnum", "soldeatnum", "issellable",
				"startstationid", "endstationid", "runtime", "distance",
				"highdistance", "worktype", "workways", "districttype",
				"scheduletype", "isproprietary", "isovertime",
				"issellreturnticket", "islinework", "endtime",
				"spacinginterval", "isoriginator", "issaleafterreport",
				"iscanmixcheck", "departstationid", "departstation",
				"endstation", "departtime", "ticketentrance", "buspark",
				"isreported", "isbegincheck", "isdeparted", "status",
				"reporttime", "vehicleid", "vehicleno", "planvehicleid",
				"planvehicle", "planvehicletypeid", "planvehicletype",
				"planvehiclebrandmodelid", "planunitid", "routename",
				"leaveseat", "isemptyvehicle", "reportunit", "reportname",
				"planunit", "plandriver1id", "plandriver1", "plandriver2id",
				"plandriver2", "plandriver3id", "plandriver3","plandriver4id","plandriver4",
				"plansteward1id", "plansteward1", "plansteward2id",
				"plansteward2", "remarks", "schedulestatusid","reporddriver1",
				"reporddriver2","reporddriver3","reporddriver4","rationseatnum","isreplace","driverfingernum","balanceunitid","balanceunitname",
				"contractenddate","liabilityinsureenddate","compulsoryinsureenddate","licenseenddate","workenddate","roadno","stewardname"
				, "reporddriver1id", "reporddriver2id", "reporddriver3id", "reporddriver4id", "stewardid","driverquanpin"}, list,  //驾驶员全拼 driverquanpin
				new Object[] {String.class, Long.class, Long.class, Long.class, Long.class,
						Date.class, Long.class, String.class, Short.class,
						Short.class, Short.class, Short.class, Short.class,
						boolean.class, Long.class, Long.class,
						BigDecimal.class, Integer.class, Integer.class,
						String.class, String.class, String.class, String.class,
						boolean.class, boolean.class, boolean.class,
						boolean.class, String.class, Short.class,
						boolean.class, boolean.class, boolean.class,
						Long.class, String.class, String.class, String.class,
						String.class, String.class, boolean.class,
						boolean.class, boolean.class, String.class,
						Timestamp.class, Long.class, String.class, Long.class,
						String.class, Long.class, String.class, Long.class,
						Long.class, String.class, Integer.class, boolean.class,
						String.class, String.class, String.class, long.class,
						String.class, long.class, String.class, long.class,
						String.class,long.class,String.class, long.class, String.class, long.class,
						String.class, String.class, long.class,String.class,
						String.class,String.class,String.class,String.class,boolean.class,Integer.class,long.class,String.class,
						Date.class,Date.class,Date.class,Date.class,Date.class,String.class,String.class
						, Long.class, Long.class, Long.class, Long.class, Long.class,String.class});
	}

	@Override
	public List<Map<String, Object>> qryRouteTree(long orgid) {
		return ListUtil.listToMap(new Object[] { "name", "code", "arealevel",
				"pcode" }, dispatchServiceDao.qryRouteTree(orgid),
				new Object[] { String.class, String.class, Short.class,
						String.class });
	}

	
	
	@Override
	public List<Map<String, Object>> qryCurOrg(String orgids) {
		return ListUtil.listToMap(new Object[] { Station.class, "orgid" },
				dispatchServiceDao.qryStation(orgids), new Object[] {
						Station.class, long.class });
	}

	@Override
	public List<Map<String, Object>> qryDriver(Long driverid) {
		return ListUtil.listToMap(new Object[] { "id", "picture",
				"drivinglicenseenddate","qualificationenddate","workenddate"},
				dispatchServiceDao.qryDriver(driverid), new Object[] {
						Long.class, String.class,Date.class,Date.class,Date.class });
	}

	@Override
	public List<Map<String, Object>> qryDriverbycardno(String cardno) {
		return ListUtil.listToMap(new Object[] { "id", "drivername" },
				dispatchServiceDao.qryDriverbycardno(cardno), new Object[] {
						Long.class, String.class });
	}

	@Override
	public List<Map<String, Object>> qrySchedulevehiclepeopleplan(
			Long scheduleid, Long departstationid, Date departdate) {
		return ListUtil.listToMap(new Object[] { "id", "plandriver1id",
				"plandriver2id", "plandriver3id", "plandriver4id",
				"plansteward1id", "islinework", "seatnum", "soldeatnum",
				"autocancelreserveseatnum", "unautocancelreserveseatnum",
				"fixedreserveseatnum", "leaveseat", "departtime",
				"planvehicletypeid", "planvehicleid", "orderno", "vehicleno",
				"vehicletypename", "unitname", "code", "driver1", "driver2",
				"driver3", "driver4", "stwname1", "vehicleseatnum",
				"endstation", "routename", "planunitid","driverfingernum" }, dispatchServiceDao
				.qrySchedulevehiclepeopleplan(scheduleid, departstationid,
						departdate), new Object[] { Long.class, Long.class,
				Long.class, Long.class, Long.class, Long.class, boolean.class,
				Short.class, Short.class, Short.class, Short.class,
				Short.class, Short.class, String.class, Long.class, Long.class,
				Short.class, String.class, String.class, String.class,
				String.class, String.class, String.class, String.class,
				String.class, String.class, Short.class, String.class,
				String.class, Long.class,Short.class });
	}

	@Override
	public List<Map<String, Object>> qryVehiclereport(
			Vehiclereport vehiclereport) {
		return ListUtil.listToMap(new Object[] { Vehiclereport.class,
				"vehicleno", "code", "driver1", "driver2", "driver3",
				"driver4", "stwname1", "seatnum" },
				dispatchServiceDao.qryVehiclereport(vehiclereport),
				new Object[] { Vehiclereport.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, Short.class });
	}

	// 取消报到
	@SuppressWarnings({ "unchecked"})
	@Override
	public boolean cancelReport(Vehiclereport vehiclereport, long curStationid,
			String ip) throws ServiceException {
		//
		Global global = CurrentUtil.getGlobal();
		Scheduleplan scheduleplan = (Scheduleplan) dispatchServiceDao.get(
				LockModeType.PESSIMISTIC_READ, Scheduleplan.class,
				vehiclereport.getScheduleplanid());
		// 该班次已有检票记录，不允许取消报到
		if (dispatchServiceDao.isCheckTicket(vehiclereport.getId(),
				scheduleplan.getId())) {
			throw new ServiceException("0072");
		}
		Schedule schedule = (Schedule) dispatchServiceDao.get(Schedule.class,
				scheduleplan.getScheduleid());
		// 修改班次状态
		List<Schedulestatus> schedulestatuslist = scheduleplan
				.getSchedulestatuslist();
		//判断取消报道的流水班中是否还有已经报道的车辆.如果有.则不修改其班次的班次状态. 孙越 2016年7月12日 15:02:08
		boolean isreported = false;
		if(scheduleplan.getIslinework()){
			isreported = dispatchServiceDao.checkIsCanCancel(scheduleplan.getId());
		}

		// 若是始发班次取消报班、配载站也取消报班
		Organization curorg = (Organization) dispatchServiceDao.get(
				Organization.class, scheduleplan.getOrgid());
		String isautoreport = parameterService.findParamValue("2012",
				curorg.getId());
		int maxActiveReportOrder = 0;//该班次最后报班记录中的报班序号
		if ("1".equals(isautoreport)
				&& curorg.getStation().getId() == curStationid
				&& !scheduleplan.getIslinework()) {
			for (Schedulestatus schedulestatus : schedulestatuslist) {
				schedulestatus.setIsreported(isreported);
				schedulestatus.setIsbegincheck(false);
				//取消报班不修改班次状态，若如是停售状态
				if(schedulestatus.getStatus().equals("2")){
					schedulestatus.setStatus("0");
				}
				schedulestatus.setUpdateby(vehiclereport.getUpdateby());
				schedulestatus.setUpdatetime(new Date());
				dispatchServiceDao.merge(schedulestatus);
			}
			List<Vehiclereport> vrps = dispatchServiceDao
			.qryVehiclereport(scheduleplan.getId());
			for (Vehiclereport vr : vrps) {
				// 本次报到车辆是否已发班
				if (vr.isIsdeparted()) {
					throw new ServiceException("0071");
				}		
				// 取消报道
				vr.setIsactive(false);
				vr.setUpdateby(vehiclereport.getUpdateby());
				vr.setUpdatetime(new Date());
				if (!scheduleplan.getIslinework()) {
					Vehiclelate vehiclelate = dispatchServiceDao
							.getVehiclelate(vr.getId());
					// 该晚点违约金已经结算，不允许取消报到
					if (vehiclelate != null) {
						if (vehiclelate.getBalance()!=null) {
							throw new ServiceException("0074");
						}
						dispatchServiceDao.delete(vehiclelate);
					}
				}
				Vehiclereportcancel vehiclereportcancel = new Vehiclereportcancel();
				vehiclereportcancel
						.setCreateby(vehiclereport.getUpdateby());
				vehiclereportcancel.setCreatetime(new Date());
				vehiclereportcancel.setReason(vehiclereport.getReason());
				vehiclereportcancel.setReportcancelby(vehiclereport
						.getUpdateby());
				vehiclereportcancel.setReportcanceltime(new Date());
				vehiclereportcancel.setReportid(vr.getId());
				dispatchServiceDao.merge(vehiclereportcancel);
				dispatchServiceDao.merge(vr);
			}
			//获取该班次最后报班记录中的报班序号
			maxActiveReportOrder = getMaxActiveReportOrder(vrps.get(0).getScheduleplanid(),
					vrps.get(0).getReportorgid(), vrps.get(0).getId());
		} else {
			// 只取消当前站点的报到记录
			for (Schedulestatus schedulestatus : schedulestatuslist) {
				if (schedulestatus.getDepartstationid() == curStationid) {
					schedulestatus.setIsreported(isreported);
					schedulestatus.setIsbegincheck(false);
					//取消报班不修改班次状态，若如是停售状态
					//schedulestatus.setStatus("0");
					schedulestatus.setUpdateby(vehiclereport.getUpdateby());
					schedulestatus.setUpdatetime(new Date());
					Vehiclereport curvehiclereport = (Vehiclereport) dispatchServiceDao
							.get(Vehiclereport.class, vehiclereport.getId());
					// 本次报到车辆是否已发班
					if (curvehiclereport.isIsdeparted()) {
						throw new ServiceException("0071");
					}
					if (!curvehiclereport.getIsactive()) {
						// 该报到记录已经取消
						throw new ServiceException("0070");
					}
					// 取消报道
					curvehiclereport.setIsactive(false);
					curvehiclereport.setUpdateby(vehiclereport.getUpdateby());
					curvehiclereport.setUpdatetime(new Date());
					if (!scheduleplan.getIslinework()) {
						Vehiclelate vehiclelate = dispatchServiceDao
								.getVehiclelate(curvehiclereport.getId());
						// 该晚点违约金已经结算，不允许取消报到
						if (vehiclelate != null) {
							if (vehiclelate.getBalance()!=null) {
								throw new ServiceException("0074");
							}
							dispatchServiceDao.delete(vehiclelate);
						}
					}
					dispatchServiceDao.merge(curvehiclereport);

					Vehiclereportcancel vehiclereportcancel = new Vehiclereportcancel();
					vehiclereportcancel
							.setCreateby(vehiclereport.getUpdateby());
					vehiclereportcancel.setCreatetime(new Date());
					vehiclereportcancel.setReason(vehiclereport.getReason());
					vehiclereportcancel.setReportcancelby(vehiclereport
							.getUpdateby());
					vehiclereportcancel.setReportcanceltime(new Date());
					vehiclereportcancel.setReportid(curvehiclereport.getId());
					dispatchServiceDao.merge(vehiclereportcancel);
					//获取该班次最后报班记录中的报班序号
					maxActiveReportOrder = getMaxActiveReportOrder(curvehiclereport.getScheduleplanid(),
							curvehiclereport.getReportorgid(), curvehiclereport.getId());
				}
			}
		}
		if(schedule.getWorktype().equals("2")){
			List<Schedulestatus> sslist=scheduleplan.getSchedulestatuslist();
			for(Schedulestatus ss:sslist){
				ss.setIsreported(isreported);
				ss.setIsbegincheck(false);
				ss.setUpdateby(vehiclereport.getCreateby());
				ss.setUpdatetime(new Date());
				dispatchServiceDao.merge(ss);
			}
		}

		// 非流水班才修改座位数		
		if (!scheduleplan.getIslinework() && !schedule.isIsfixseat()) {
			Schedulevehiclepeopleplan sp = scheduleplan
					.getSchedulevehiclepeopleplanlist().get(0);
			Vehiclebrandmodel vm = (Vehiclebrandmodel) dispatchServiceDao.get(
					Vehiclebrandmodel.class, sp.getPlanvehiclebrandmodelid());
			short seatnum = vm.getRationseatnum();
			String ischangeseat = parameterService
			.findParamValue("2031", curorg.getId());
			//只有不修改车型和票价时，才启用2031
			String ischangeprice =parameterService.findParamValue("9050",curorg.getId());
			if("0".equals(ischangeprice)&&ischangeseat.equals("1") && !schedule.isIsfixseat()){
				// 修改座位数
				changeSeats_(scheduleplan, seatnum,
						vehiclereport.getCreateby());
			}
			/*short oldseats = scheduleplan.getSeatnum();
			if (seatnum != scheduleplan.getSeatnum()) {
				scheduleplan.setSeatnum(seatnum);
				scheduleplan.setUpdateby(vehiclereport.getUpdateby());
				scheduleplan.setUpdatetime(new Date());
				long totalnum = scheduleplan.getAutocancelreserveseatnum()
						+ scheduleplan.getUnautocancelreserveseatnum()
						+ scheduleplan.getFixedreserveseatnum()
						+ scheduleplan.getSoldeatnum();
				if ((scheduleplan.getSeatnum() - totalnum) < 0) {
					throw new ServiceException("0323");
				}

				List<Scheduleseats> scheduleseatslist = scheduleplan
						.getScheduleseatslist();

				// 先更原来的座位状态
				if (scheduleseatslist.size() < scheduleplan.getSeatnum()) {
					// 增加新的座位信息
					short curseatno = (short) (oldseats + 1);
					for (short seatno = curseatno; seatno <= seatnum; seatno++) {
						Scheduleseats scheduleseats = addScheduleseats(seatno,
								scheduleplan, scheduleseatslist.get(0));
						scheduleseatslist.add(scheduleseats);
						// dispatchServiceDao.merge(scheduleseats);
					}
				} else if (scheduleseatslist.size() > scheduleplan.getSeatnum()) {
					// 新车辆座位数比原来座位数少
					boolean isallspaceseat = true;
					for (Scheduleseats scheduleseats : scheduleseatslist) {
						// 只有后面所有座位是空座才允许删除
						if (scheduleseats.getSeatno() > seatnum){
							if("2".equals(scheduleseats.getStatus())){
								isallspaceseat = false;
							}
						}
					}	
					
					if (isallspaceseat) {
						// 只有后面所有座位是空座才允许删除
						Iterator<Scheduleseats> sit = scheduleseatslist
								.iterator();
						while (sit.hasNext()) {
							Scheduleseats ss = sit.next();
							if (ss.getSeatno() > seatnum
									&& "0".equals(ss.getStatus())) {
								dispatchServiceDao.getEntityManager()
										.remove(ss);
								sit.remove();

							}
						}
					}
					
				}

				int fixseat = 0;
				int unautoseat = 0;
				int autoseat = 0;
				for (Scheduleseats ss : scheduleseatslist) {
					if (ss.getStatus().equals("2")) {
						// soldseats.add(ss.getSeatno());
					} else if (ss.getStatus().equals("3")) {
						fixseat++;
					} else if (ss.getStatus().equals("4")) {
						autoseat++;
					} else if (ss.getStatus().equals("5")) {
						unautoseat++;
					}
				}

				// 修改执行票价的座位数
				List<Ticketprice> ticketprices = scheduleplan
						.getTicketpricelist();
				for (Ticketprice tp : ticketprices) {
					tp.setUpdateby(vehiclereport.getUpdateby());
					tp.setUpdatetime(new Date());
					short seats = 0;
					if (scheduleplan.getIslinework()) {
						tp.setSeatnum(scheduleplan.getSeatnum());
					} else {
						for (Scheduleseats ss : scheduleseatslist) {
							if (tp.getSeattype().equals(ss.getSeattype())) {
								seats++;
							}
						}
						tp.setSeatnum(seats);
					}
					tp.setAutocancelreserveseatnum((short) autoseat);
					tp.setUnautocancelreserveseatnum((short) unautoseat);
					tp.setFixedreserveseatnum((short) fixseat);
				}
			}*/
		} 
		
		//该班次最后报班记录中的报班序号
		scheduleplan.setReportorderno(maxActiveReportOrder);
		scheduleplan.setUpdateby(vehiclereport.getUpdateby());
		dispatchServiceDao.merge(scheduleplan);
		//取消报班后证件审查更改status=0（未报班）扩展点----十堰插件
		ActionNode actionNode = Appvar.routes.get("CANCELVEHICLEREPORTLICENSECHECKEXPORT");// 由插件名,获得插件
		//查询是否使用了certificatecheck证件审核插件；从Appvar.routes中获取扩张点插件名、插件类、插件方法
		PluginFunction.DoPlugin(vehiclereport, global,actionNode);
		return true;
	}


	// 晚点处理
	@Override
	public Vehiclelate vehicleLater(Vehiclereport vehiclereport,
			Scheduleplan scheduleplan, String departtime)
			throws ServiceException {
		if (scheduleplan.getIslinework()) {
			return null;
		}
		// 计算是否做晚点处理
		// 提前报到分钟数
		long beforeminutes = new Long(parameterService.findParamValue(ParamterConst.Param_2001,
				vehiclereport.getOrgid()));
		/*
		 * if (beforeminutes == 0) { return null; }
		 */
		String departDatestr = StringUtils.dateToStr(vehiclereport
				.getDepartdate());
		String departTimes = departDatestr + ' ' + departtime;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		try {
			Date departDate = format.parse(departTimes);
			long s1 = departDate.getTime();
			long s2 = System.currentTimeMillis();
			// 晚点分钟数
			long laterMinutes = (s2 - s1) / 60 / 1000 + beforeminutes;
			System.out.println("晚点分钟数=" + laterMinutes);
			// 晚点,进行晚点处罚
			if (laterMinutes > 0) {
				Vehiclelate vehiclelate = new Vehiclelate();
				vehiclelate.setCreateby(vehiclereport.getCreateby());
				vehiclelate.setCreatetime(new Date());
				vehiclelate.setDepartdate(vehiclereport.getDepartdate());
				vehiclelate.setReason(vehiclereport.getReason());
				vehiclelate.setScheduleid(vehiclereport.getScheduleid());
				vehiclelate.setVehicleid(vehiclereport.getVehicleid());
				vehiclelate.setReportid(vehiclereport.getId());
				// 违约金额
				BigDecimal forfeit;
				// 每晚报到分钟数
				long perLaterMinutes = new Long(
						parameterService.findParamValue(ParamterConst.Param_2002,
								vehiclereport.getOrgid()));
				if (perLaterMinutes == 0) {
					vehiclelate.setForfeit(new BigDecimal(0));
					return vehiclelate;
				}
				// 每晚报到罚款金额
				long perlaterMoney = new Long(parameterService.findParamValue(
						ParamterConst.Param_2003, vehiclereport.getOrgid()));
				if (perlaterMoney == 0) {
					vehiclelate.setForfeit(new BigDecimal(0));
					return vehiclelate;
				}
				// 1按脱班计算违约金,0不按脱班计算违约金
				String calType = parameterService.findParamValue(ParamterConst.Param_2004,
						vehiclereport.getOrgid());
				if (ParamterConst.COMMON_FLAG.FALG_YES.equals(calType)) {
					// 晚指定分钟数以上按脱班计算违约金
					long standarMinutes = new Long(
							parameterService.findParamValue(ParamterConst.Param_2005,
									vehiclereport.getOrgid()));

					if (standarMinutes > 0 && laterMinutes >= standarMinutes) {
						// 0按脱班次计算违约金,1按最大营业额计算
						String laterType = parameterService.findParamValue(
								ParamterConst.Param_2006, vehiclereport.getOrgid());
						if (ParamterConst.COMMON_FLAG.FALG_NO.equals(laterType)) {
							// 次脱班金额
							long laterMoney = new Long(
									parameterService.findParamValue(ParamterConst.Param_2007,
											vehiclereport.getOrgid()));
							forfeit = new BigDecimal(laterMoney);
						} else {
							// 倍数计算违约金
							forfeit = calPenalty(scheduleplan,
									vehiclereport.getOrgid());
						}
					} else {
						long fee = laterMinutes / perLaterMinutes
								* perlaterMoney;
						//增加日志
						play.Logger.info("晚点罚金计算", "laterMinutes" + laterMinutes + 
								"  2005参数" + perLaterMinutes + " perlaterMoney" + perlaterMoney + "fee" + fee + 
								"scheduleplanid" + scheduleplan.getId());
						forfeit = new BigDecimal(fee);
					}
				} else {
					long fee = laterMinutes / perLaterMinutes * perlaterMoney;
					forfeit = new BigDecimal(fee);
				}
				vehiclelate.setForfeit(forfeit);
				return vehiclelate;
			} else {
				return null;
			}
		} catch (ParseException e) {
			play.Logger.error(e.getMessage(), e);
		}

		// 晚点处理结束
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public long laterMinutes(Long departstationid, Long scheduleid,
			Date departDate) throws ServiceException {
		// 计算是否做晚点处理
		// 提前报到分钟数
		Schedule schedule = (Schedule) dispatchServiceDao.get(Schedule.class,
				scheduleid);
		Scheduleplan scheduleplan = dispatchServiceDao.getScheduleplan(
				schedule.getOrgid(), departDate, scheduleid);
		if (scheduleplan.getIslinework()) {
			return 0;
		} else {
			Schedulestatus schedulestatus = dispatchServiceDao
					.getSchedulestatus(departstationid, scheduleid, departDate);
			if (schedulestatus.getIsreported()) {
				return 0;
			}
			long beforeminutes = new Long(parameterService.findParamValue(
					ParamterConst.Param_2001, schedule.getOrgid()));
			String departDatestr = StringUtils.dateToStr(departDate);
			String departTime = departDatestr + ' '
					+ schedulestatus.getDeparttime();
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			try {
				Date departDatetime = format.parse(departTime);
				long s1 = departDatetime.getTime();
				long s2 = System.currentTimeMillis();
				// 晚点分钟数
				long laterMinutes = (s2 - s1) / 60 / 1000 + beforeminutes;
				System.out.println("晚点分钟数=" + laterMinutes);
				// 晚点,进行晚点处罚
				if (laterMinutes > 0) {
					return laterMinutes;
				} else {
					return 0;
				}
			} catch (ParseException e) {
				play.Logger.error(e.getMessage(), e);
				return 0;
			}
		}
	}

	// 脱班操作
	@SuppressWarnings("unchecked")
	@Override
	public boolean vehicleLost(Vehiclelost vehiclelost) throws ServiceException {
		Scheduleplan scheduleplan = (Scheduleplan) dispatchServiceDao.get(
				Scheduleplan.class, vehiclelost.getScheduleplanid());
		if (isInvalid(scheduleplan.getDepartdate())) {
			throw new ServiceException("0092");
		}
		if (scheduleplan.getIslinework()) {
			// 流水班不需要进行脱班操作
			throw new ServiceException("0076");
		}
		// 当前操作者的机构ID
		Organization org = (Organization) dispatchServiceDao.get(
				Organization.class, vehiclelost.getOrgid());
		long departstationid = org.getStation().getId();
		List<Schedulestatus> schedulestatuslist = scheduleplan
				.getSchedulestatuslist();
		List<Schedulevehiclepeopleplan> schedulevehiclepeopleplanlist = scheduleplan
				.getSchedulevehiclepeopleplanlist();
		Schedulevehiclepeopleplan schedulevehiclepeopleplan = schedulevehiclepeopleplanlist
				.get(0);
		if (schedulevehiclepeopleplan.getPlanunit() != null
				&& schedulevehiclepeopleplan.getPlanunit().getId() != vehiclelost
						.getUnitid()) {
			// 计划营运单位与脱班车辆的营运单位不一样，不需要进行脱班操作
			throw new ServiceException("0078");
		}
		if (vehiclelost.getVehicle() != null
				&& schedulevehiclepeopleplan.getPlanvehicle() != null) {
			if (vehiclelost.getVehicle().getId() != schedulevehiclepeopleplan
					.getPlanvehicle().getId()) {
				// 计划车辆与脱班车辆不一样，不需要进行脱班操作
				throw new ServiceException("0077");
			}
		}
		String beforestatus = "0";
		String afterstatus = "4";
		if (org.getId() == scheduleplan.getOrgid()) {
			for (Schedulestatus schedulestatus : schedulestatuslist) {
				if (schedulestatus.getIsreported()) {
					// 该班次已经报到不允许进行脱班操作
					throw new ServiceException("0075");
				}
			}
			for (Schedulestatus schedulestatus : schedulestatuslist) {
				// 脱班
				beforestatus = schedulestatus.getStatus();
				schedulestatus.setStatus("4");
				schedulestatus.setUpdateby(vehiclelost.getCreateby());
				schedulestatus.setUpdatetime(new Date());
				dispatchServiceDao.merge(schedulestatus);
			}
		} else {
			// 在配客站点进行脱班操作
			for (Schedulestatus schedulestatus : schedulestatuslist) {
				if (schedulestatus.getDepartstationid() == departstationid) {
					// 脱班
					schedulestatus.setStatus("4");
					schedulestatus.setUpdateby(vehiclelost.getCreateby());
					schedulestatus.setUpdatetime(new Date());
					dispatchServiceDao.merge(schedulestatus);
				}
			}
		}

		BigDecimal forfeit = new BigDecimal(0);
		if (vehiclelost.getIspunish()) {
			// 0按脱班次计算违约金,1按最大营业额计算
			String calType = parameterService.findParamValue(ParamterConst.Param_2006,
					vehiclelost.getOrgid());
			if (ParamterConst.COMMON_FLAG.FALG_NO.equals(calType)) {
				// 次脱班金额
				long laterMoney = new Long(parameterService.findParamValue(
						ParamterConst.Param_2007, vehiclelost.getOrgid()));
				forfeit = new BigDecimal(laterMoney);   
			} else {
				// 倍数计算违约金
				forfeit = calPenalty(scheduleplan, vehiclelost.getOrgid());
			}
		}
		if (vehiclelost.getVehicle() != null
				&& vehiclelost.getVehicle().getId() == 0) {
			vehiclelost.setVehicle(null);
		}
		vehiclelost.setBalanceid(0);
		vehiclelost.setDepartdate(scheduleplan.getDepartdate());
		vehiclelost.setCreatetime(new Date());
		vehiclelost.setStatus("4");// 脱班
		vehiclelost.setForfeit(forfeit);         //2006参数为0时，没有乘以脱班次数
		Vehicle v = (Vehicle) dispatchServiceDao.get(Vehicle.class, vehiclelost
				.getVehicle().getId());
		vehiclelost.setUnitid(v.getUnitid());
		// 记录日志操作
		Schedulestatuslog schedulestatuslog = new Schedulestatuslog();
		schedulestatuslog.setBeforestatus(beforestatus);
		schedulestatuslog.setAfterstatus(afterstatus);

		schedulestatuslog.setCreateby(vehiclelost.getCreateby());
		schedulestatuslog.setCreatetime(new Date());
		schedulestatuslog.setDepartdate(scheduleplan.getDepartdate());
		// 脱班
		schedulestatuslog.setOperationtype("7");
		schedulestatuslog.setOrgid(vehiclelost.getOrgid());
		schedulestatuslog.setReason(vehiclelost.getReason());
		schedulestatuslog.setScheduleid(scheduleplan.getScheduleid());
		dispatchServiceDao.merge(vehiclelost);
		dispatchServiceDao.merge(schedulestatuslog);
		return true;
	}

	private BigDecimal calPenalty(Scheduleplan scheduleplan, Long orgid) {
		// 倍数计算违约金
		try {
			BigDecimal multiple = new BigDecimal(
					parameterService.findParamValue(ParamterConst.Param_2008, orgid));
			BigDecimal maxPrice = new BigDecimal(0);
			List<Ticketprice> ticketpricelist = scheduleplan
					.getTicketpricelist();
			for (Ticketprice ticketprice : ticketpricelist) {
				if (ticketprice.getFullprice().compareTo(maxPrice) > 0) {
					maxPrice = ticketprice.getFullprice();
				}
			}
			BigDecimal seatnum = new BigDecimal(scheduleplan.getSeatnum());
			return maxPrice.multiply(seatnum).multiply(multiple);
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			return new BigDecimal(0);
		}

	}

	// 顶班操作
	@SuppressWarnings("unchecked")
	@Override
	public boolean chanagePlanVehicle(
			Schedulevehiclepeopleplan vehiclepeopleplan)
			throws ServiceException {
		Scheduleplan scheduleplan = (Scheduleplan) dispatchServiceDao
				.get(Scheduleplan.class, vehiclepeopleplan.getScheduleplan()
						.getId());
		if (isInvalid(scheduleplan.getDepartdate())) {
			throw new ServiceException("0092");
		}
		if (scheduleplan.getIslinework()) {
			// 流水班不需要进行顶班操作
			throw new ServiceException("0079");
		}
		List<Schedulestatus> schedulestatuslist = scheduleplan
				.getSchedulestatuslist();
		for (Schedulestatus schedulestatus : schedulestatuslist) {
			if (schedulestatus.getStatus().equals("1")) {
				// 该班次已经报停
				throw new ServiceException("0097");
			}
			if (schedulestatus.getIsreported()) {
				// 该班次已经报到不允许进行顶班操作
				throw new ServiceException("0080");
			}
		}
		List<Schedulevehiclepeopleplan> schedulevehiclepeopleplanlist = scheduleplan
				.getSchedulevehiclepeopleplanlist();
		Schedulevehiclepeopleplan schedulevehiclepeopleplan = schedulevehiclepeopleplanlist
				.get(0);
		boolean ischange = false;
		if (schedulevehiclepeopleplan.getPlanunit() != null
				&& vehiclepeopleplan.getPlanunit() != null
				&& schedulevehiclepeopleplan.getPlanunit() != vehiclepeopleplan
						.getPlanunit()) {
			ischange = true;
		}
		if (schedulevehiclepeopleplan.getPlanvehicle() != null) {
			if (vehiclepeopleplan.getPlanvehicle().getId() != schedulevehiclepeopleplan
					.getPlanvehicle().getId()) {
				ischange = true;
			}
		} else if (vehiclepeopleplan.getPlanvehicle().getId() > 0) {
			ischange = true;
		}
		if ((schedulevehiclepeopleplan.getPlandriver1() != null)) {
			if (vehiclepeopleplan.getPlandriver1().getId() != schedulevehiclepeopleplan
					.getPlandriver1().getId()) {
				ischange = true;
			}
		} else if (vehiclepeopleplan.getPlandriver1().getId() > 0) {
			ischange = true;
		}
		if ((schedulevehiclepeopleplan.getPlandriver2() != null)) {
			if (vehiclepeopleplan.getPlandriver2().getId() != schedulevehiclepeopleplan
					.getPlandriver2().getId()) {
				ischange = true;
			}
		} else if (vehiclepeopleplan.getPlandriver2().getId() > 0) {
			ischange = true;
		}
		if ((schedulevehiclepeopleplan.getPlandriver3() != null)) {
			if (vehiclepeopleplan.getPlandriver3().getId() != schedulevehiclepeopleplan
					.getPlandriver3().getId()) {
				ischange = true;
			}
		} else if (vehiclepeopleplan.getPlandriver3().getId() > 0) {
			ischange = true;
		}
		if ((schedulevehiclepeopleplan.getPlandriver4() != null)) {
			if (vehiclepeopleplan.getPlandriver4().getId() != schedulevehiclepeopleplan
					.getPlandriver4().getId()) {
				ischange = true;
			}
		} else if (vehiclepeopleplan.getPlandriver4().getId() > 0) {
			ischange = true;
		}

		if (schedulevehiclepeopleplan.getPlansteward1() != null) {
			if (vehiclepeopleplan.getPlansteward1().getId() != schedulevehiclepeopleplan
					.getPlansteward1().getId()) {
				ischange = true;
			}
		} else if (vehiclepeopleplan.getPlansteward1().getId() > 0) {
			ischange = true;
		}
		if (!ischange) {
			throw new ServiceException("0081");
		}

		// 初始化为状态
		String afterstatus = "0";// 正常
		String beforestatus = "0";// 正常
		// 当前操作者的机构ID
		Organization org = (Organization) dispatchServiceDao.get(
				Organization.class, vehiclepeopleplan.getOrgid());
		for (Schedulestatus schedulestatus : schedulestatuslist) {
			if (schedulestatus.getDepartstationid() == org.getStation().getId()) {
				beforestatus = schedulestatus.getStatus();
			}
		}
		// 计划营运单位与顶班营运单位不一样时才进行脱班操作
		if (schedulevehiclepeopleplan.getPlanunit() != null
				&& vehiclepeopleplan.getPlanunit() != null
				&& schedulevehiclepeopleplan.getPlanunit() != vehiclepeopleplan
						.getPlanunit()) {
			Vehiclelost vehiclelost = dispatchServiceDao.getVehiclelost(
					scheduleplan.getId(), vehiclepeopleplan.getOrgid());
			// 若还没进行脱班操作先进行脱班操作
			if (vehiclelost == null) {
				vehiclelost = new Vehiclelost();
				vehiclelost.setCreateby(vehiclepeopleplan.getCreateby());
				vehiclelost.setIsautolost(true);
				vehiclelost.setOrgid(vehiclepeopleplan.getOrgid());
				vehiclelost.setScheduleid(scheduleplan.getScheduleid());
				vehiclelost.setScheduleplanid(scheduleplan.getId());
				vehiclelost.setIspunish(false);
				vehicleLost(vehiclelost);
				// 进行脱班操作后
				beforestatus = "4";
			}
		}
		if (scheduleplan.getOrgid() == vehiclepeopleplan.getOrgid()) {
			for (Schedulestatus schedulestatus : schedulestatuslist) {
				schedulestatus.setUpdateby(vehiclepeopleplan.getCreateby());
				schedulestatus.setStatus("0");
				schedulestatus.setUpdatetime(new Date());
				dispatchServiceDao.merge(schedulestatus);
			}
		} else {
			for (Schedulestatus schedulestatus : schedulestatuslist) {
				if (schedulestatus.getDepartstationid() == org.getStation()
						.getId()) {
					schedulestatus.setUpdateby(vehiclepeopleplan.getCreateby());
					schedulestatus.setStatus("0");
					schedulestatus.setUpdatetime(new Date());
					dispatchServiceDao.merge(schedulestatus);
				}
			}
		}
		schedulevehiclepeopleplan.setPlanunit(vehiclepeopleplan.getPlanunit());
		if (vehiclepeopleplan.getPlanvehicle().getId() > 0)
			schedulevehiclepeopleplan.setPlanvehicle(vehiclepeopleplan
					.getPlanvehicle());
		if (vehiclepeopleplan.getPlandriver1().getId() > 0)
			schedulevehiclepeopleplan.setPlandriver1(vehiclepeopleplan
					.getPlandriver1());
		if (vehiclepeopleplan.getPlandriver2().getId() > 0)
			schedulevehiclepeopleplan.setPlandriver2(vehiclepeopleplan
					.getPlandriver2());
		if (vehiclepeopleplan.getPlandriver3().getId() > 0)
			schedulevehiclepeopleplan.setPlandriver3(vehiclepeopleplan
					.getPlandriver3());
		if (vehiclepeopleplan.getPlandriver4().getId() > 0)
			schedulevehiclepeopleplan.setPlandriver4(vehiclepeopleplan
					.getPlandriver4());
		if (vehiclepeopleplan.getPlansteward1().getId() > 0)
			schedulevehiclepeopleplan.setPlansteward1(vehiclepeopleplan
					.getPlansteward1());
		schedulevehiclepeopleplan.setUpdateby(vehiclepeopleplan.getCreateby());
		schedulevehiclepeopleplan.setUpdatetime(new Date());
		dispatchServiceDao.merge(schedulevehiclepeopleplan);
		// 记录日志操作
		Schedulestatuslog schedulestatuslog = new Schedulestatuslog();
		schedulestatuslog.setAfterstatus(afterstatus);
		schedulestatuslog.setBeforestatus(beforestatus);
		schedulestatuslog.setCreateby(vehiclepeopleplan.getCreateby());
		schedulestatuslog.setCreatetime(new Date());
		schedulestatuslog.setDepartdate(scheduleplan.getDepartdate());
		schedulestatuslog.setOperationtype("8"); // 顶班
		schedulestatuslog.setOrgid(vehiclepeopleplan.getOrgid());
		schedulestatuslog.setScheduleid(scheduleplan.getScheduleid());
		dispatchServiceDao.merge(schedulestatuslog);
		return true;

	}

	/**
	 * 停售
	 */
	@SuppressWarnings("unchecked")
	@Override
	public boolean stopTicketsell(long scheduleplanid, long departstationid,
			Global global) throws ServiceException {
		Scheduleplan scheduleplan = (Scheduleplan) dispatchServiceDao.get(
				Scheduleplan.class, scheduleplanid);
		if (isInvalid(scheduleplan.getDepartdate())) {
			throw new ServiceException("0092");
		}

		List<Schedulestatus> schedulestatuslist = scheduleplan
				.getSchedulestatuslist();
		for (Schedulestatus schedulestatus : schedulestatuslist) {
			if (schedulestatus.getDepartstationid() == departstationid) {
				if (schedulestatus.getStatus().equals("1")) {
					// 该班次已经报停无需进行停售操作
					throw new ServiceException("0098");
				}
				if (!schedulestatus.getStatus().equals("0")) {
					// 该班次状态已经改变，请查询查询
					throw new ServiceException("0093");
				}
			}
		}
		Organization orgsch = (Organization) dispatchServiceDao.get(
				Organization.class, scheduleplan.getOrgid());
		String isautostopsell = parameterService.findParamValue(ParamterConst.Param_2017,
				orgsch.getId());
		if (ParamterConst.COMMON_FLAG.FALG_YES.equals(isautostopsell)
				&& orgsch.getStation().getId() == departstationid) {
			// 若是始发站操作
			// 初始化为状态
			String afterstatus = "5";// 停售
			String beforestatus = "0";// 正常
			for (Schedulestatus schedulestatus : schedulestatuslist) {
				beforestatus = schedulestatus.getStatus();
				// 记录日志操作
				Schedulestatuslog schedulestatuslog = new Schedulestatuslog();
				schedulestatuslog.setAfterstatus(afterstatus);
				schedulestatuslog.setBeforestatus(beforestatus);
				schedulestatuslog.setCreateby(global.getUserinfo().getId());
				schedulestatuslog.setCreatetime(new Date());
				schedulestatuslog.setDepartdate(scheduleplan.getDepartdate());
				schedulestatuslog.setOperationtype("3");// 停售
				schedulestatuslog.setOrgid(global.getOrganization().getId());
				schedulestatuslog.setScheduleid(scheduleplan.getScheduleid());
				dispatchServiceDao.merge(schedulestatuslog);

				schedulestatus.setUpdateby(global.getUserinfo().getId());
				schedulestatus.setStatus("5");
				schedulestatus.setUpdatetime(new Date());
				dispatchServiceDao.merge(schedulestatus);
			}
		} else {
			// 初始化为状态
			String afterstatus = "5";// 停售
			String beforestatus = "0";// 正常
			for (Schedulestatus schedulestatus : schedulestatuslist) {
				if (schedulestatus.getDepartstationid() == departstationid) {
					beforestatus = schedulestatus.getStatus();
					// 记录日志操作
					Schedulestatuslog schedulestatuslog = new Schedulestatuslog();
					schedulestatuslog.setAfterstatus(afterstatus);
					schedulestatuslog.setBeforestatus(beforestatus);
					schedulestatuslog.setCreateby(global.getUserinfo().getId());
					schedulestatuslog.setCreatetime(new Date());
					schedulestatuslog.setDepartdate(scheduleplan
							.getDepartdate());
					schedulestatuslog.setOperationtype("3");// 停售
					schedulestatuslog
							.setOrgid(global.getOrganization().getId());
					schedulestatuslog.setScheduleid(scheduleplan
							.getScheduleid());
					dispatchServiceDao.merge(schedulestatuslog);

					schedulestatus.setUpdateby(global.getUserinfo().getId());
					schedulestatus.setStatus("5");
					schedulestatus.setUpdatetime(new Date());
					dispatchServiceDao.merge(schedulestatus);
				}
			}
		}
		Schedule schedule = (Schedule) dispatchServiceDao.get(Schedule.class,
				scheduleplan.getScheduleid());
		String result = "停售：班次号：" + schedule.getCode() + ",发车日期："
				+ DateUtils.formatDate(scheduleplan.getDepartdate())
				+ "由可售改为不可售。";
		Operationlog operationLog = new Operationlog();
		operationLog.setIp(global.getIpAddress());
		operationLog.setContent(result);
		operationLog.setModule("综合调度->营运计划调整");
		operationLog.setOperatetime(new Date());
		operationLog.setOperation("停售");
		operationLog.setSessionid(global.getSessionID());
		operationLog.setUserid(global.getUserinfo().getId());
		dispatchServiceDao.merge(operationLog);
		return true;

	}

	private boolean isInvalid(Date departdate) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date();
		try {
			now = format.parse(format.format(new Date()));
		} catch (ParseException e) {
			play.Logger.error(e.getMessage(), e);
			return false;
		}
		if (departdate.getTime() < now.getTime()) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 发售
	 */
	@SuppressWarnings("unchecked")
	@Override
	public boolean allowTicketsell(long scheduleplanid, long departstationid,
			Global global) throws ServiceException {
		Scheduleplan scheduleplan = (Scheduleplan) dispatchServiceDao.get(
				Scheduleplan.class, scheduleplanid);
		if (isInvalid(scheduleplan.getDepartdate())) {
			throw new ServiceException("0092");
		}
		List<Schedulestatus> schedulestatuslist = scheduleplan
				.getSchedulestatuslist();
		for (Schedulestatus schedulestatus : schedulestatuslist) {
			if (schedulestatus.getDepartstationid() == departstationid) {
				if (schedulestatus.getStatus().equals("1")) {
					// 该班次已经报停
					throw new ServiceException("0097");
				}
				if (!schedulestatus.getStatus().equals("5")) {
					// 该班次状态已经改变，请查询查询
					throw new ServiceException("0093");
				}
			}
		}
		Organization orgsch = (Organization) dispatchServiceDao.get(
				Organization.class, scheduleplan.getOrgid());
		String isautostopsell = parameterService.findParamValue(ParamterConst.Param_2017,
				orgsch.getId());
		// 初始化为状态
		String afterstatus = "0";// 正常
		String beforestatus = "5";// 停售
		if (ParamterConst.COMMON_FLAG.FALG_YES.equals(isautostopsell)
				&& orgsch.getStation().getId() == departstationid) {
			for (Schedulestatus schedulestatus : schedulestatuslist) {

				beforestatus = schedulestatus.getStatus();
				// 记录日志操作
				Schedulestatuslog schedulestatuslog = new Schedulestatuslog();
				schedulestatuslog.setAfterstatus(afterstatus);
				schedulestatuslog.setBeforestatus(beforestatus);
				schedulestatuslog.setCreateby(global.getUserinfo().getId());
				schedulestatuslog.setCreatetime(new Date());
				schedulestatuslog.setDepartdate(scheduleplan.getDepartdate());
				schedulestatuslog.setOperationtype("4");// 取消停售
				schedulestatuslog.setOrgid(global.getOrganization().getId());
				schedulestatuslog.setScheduleid(scheduleplan.getScheduleid());
				dispatchServiceDao.merge(schedulestatuslog);

				schedulestatus.setUpdateby(global.getUserinfo().getId());
				schedulestatus.setStatus("0");
				schedulestatus.setUpdatetime(new Date());
				dispatchServiceDao.merge(schedulestatus);

			}

		} else {

			for (Schedulestatus schedulestatus : schedulestatuslist) {
				if (schedulestatus.getDepartstationid() == departstationid) {
					beforestatus = schedulestatus.getStatus();
					// 记录日志操作
					Schedulestatuslog schedulestatuslog = new Schedulestatuslog();
					schedulestatuslog.setAfterstatus(afterstatus);
					schedulestatuslog.setBeforestatus(beforestatus);
					schedulestatuslog.setCreateby(global.getUserinfo().getId());
					schedulestatuslog.setCreatetime(new Date());
					schedulestatuslog.setDepartdate(scheduleplan
							.getDepartdate());
					schedulestatuslog.setOperationtype("4");// 取消停售
					schedulestatuslog
							.setOrgid(global.getOrganization().getId());
					schedulestatuslog.setScheduleid(scheduleplan
							.getScheduleid());
					dispatchServiceDao.merge(schedulestatuslog);
					schedulestatus.setUpdateby(global.getUserinfo().getId());
					schedulestatus.setStatus("0");
					schedulestatus.setUpdatetime(new Date());
					dispatchServiceDao.merge(schedulestatus);

				}
			}
		}
		// 若是始发站
		if (scheduleplan.getStartstationid() == departstationid) {
			scheduleplan.setIssellable(true);
			scheduleplan.setUpdateby(global.getUserinfo().getId());
			scheduleplan.setUpdatetime(new Date());
			dispatchServiceDao.merge(scheduleplan);
		}
		Schedule schedule = (Schedule) dispatchServiceDao.get(Schedule.class,
				scheduleplan.getScheduleid());
		String result = "发售：班次号：" + schedule.getCode() + ",发车日期："
				+ DateUtils.formatDate(scheduleplan.getDepartdate())
				+ "由不可售改为可售。";
		Operationlog operationLog = new Operationlog();
		operationLog.setIp(global.getIpAddress());
		operationLog.setContent(result);
		operationLog.setModule("综合调度->营运计划调整");
		operationLog.setOperatetime(new Date());
		operationLog.setOperation("发售");
		operationLog.setSessionid(global.getSessionID());
		operationLog.setUserid(global.getUserinfo().getId());
		dispatchServiceDao.merge(operationLog);
		return true;
	}

	// 停班
	@SuppressWarnings("unchecked")
	@Override
	public boolean stopScheduleplan(long scheduleplanid, long departstationid,
			long createby) throws ServiceException {
		Scheduleplan scheduleplan = (Scheduleplan) dispatchServiceDao.get(
				Scheduleplan.class, scheduleplanid);
		if (isInvalid(scheduleplan.getDepartdate())) {
			throw new ServiceException("0092");
		}
		/*
		 * if (scheduleplan.getSoldeatnum() > 0) { throw new
		 * ServiceException("0096"); }
		 */
		Organization org = dispatchServiceDao.getOrganization(departstationid);
		if (scheduleplan.getOrgid() != org.getId()) {
			throw new ServiceException("0094");
		}
		List<Schedulestatus> schedulestatuslist = scheduleplan
				.getSchedulestatuslist();
		for (Schedulestatus schedulestatus : schedulestatuslist) {
			if (schedulestatus.getIsreported()) {
				// 该班次已经报到不允许进行报停操作
				throw new ServiceException("0095");
			}
		}
		// 初始化为状态
		String afterstatus = "1";// 报停
		String beforestatus = "0";// 正常
		for (Schedulestatus schedulestatus : schedulestatuslist) {
			beforestatus = schedulestatus.getStatus();
			schedulestatus.setUpdateby(createby);
			schedulestatus.setStatus("1");
			schedulestatus.setUpdatetime(new Date());
			dispatchServiceDao.merge(schedulestatus);
			// 记录日志操作
			Schedulestatuslog schedulestatuslog = new Schedulestatuslog();
			schedulestatuslog.setAfterstatus(afterstatus);
			schedulestatuslog.setBeforestatus(beforestatus);
			schedulestatuslog.setCreateby(createby);
			schedulestatuslog.setCreatetime(new Date());
			schedulestatuslog.setDepartdate(scheduleplan.getDepartdate());
			schedulestatuslog.setOperationtype("0");// 报停 操作
			schedulestatuslog.setOrgid(org.getId());
			schedulestatuslog.setScheduleid(scheduleplan.getScheduleid());
			dispatchServiceDao.merge(schedulestatuslog);
		}
		scheduleplan.setIssellable(false);
		scheduleplan.setUpdateby(createby);
		scheduleplan.setUpdatetime(new Date());
		dispatchServiceDao.merge(scheduleplan);

		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean allowScheduleplan(long scheduleplanid, long departstationid,
			String ip, long createby) throws ServiceException {
		Scheduleplan scheduleplan = (Scheduleplan) dispatchServiceDao.get(
				Scheduleplan.class, scheduleplanid);
		if (isInvalid(scheduleplan.getDepartdate())) {
			throw new ServiceException("0092");
		}
		Organization org = dispatchServiceDao.getOrganization(departstationid);
		if (scheduleplan.getOrgid() != org.getId()) {
			throw new ServiceException("0094");
		}
		String departdatestr = StringUtils.dateToStr(scheduleplan
				.getDepartdate());
		Schedule schedule = (Schedule) dispatchServiceDao.get(Schedule.class,
				scheduleplan.getScheduleid());
		Station station = (Station) dispatchServiceDao.get(Station.class,
				scheduleplan.getEndstationid());
		String result = "发车日期：" + departdatestr + "，到站：" + station.getName()
				+ ",班次号：" + schedule.getCode();
		List<Schedulestatus> schedulestatuslist = scheduleplan
				.getSchedulestatuslist();
		// 初始化为状态
		String afterstatus = "0";// 正常
		String beforestatus = "1";// 报停
		for (Schedulestatus schedulestatus : schedulestatuslist) {
			if (schedulestatus.getDepartstationid() == departstationid) {
				if (!schedulestatus.getStatus().equals("1")) {
					throw new ServiceException("0093");
				}
				beforestatus = schedulestatus.getStatus();
				schedulestatus.setUpdateby(createby);
				schedulestatus.setStatus("0");
				schedulestatus.setUpdatetime(new Date());
				dispatchServiceDao.merge(schedulestatus);
				// 记录状态日志
				Schedulestatuslog schedulestatuslog = new Schedulestatuslog();
				schedulestatuslog.setAfterstatus(afterstatus);
				schedulestatuslog.setBeforestatus(beforestatus);
				schedulestatuslog.setCreateby(createby);
				schedulestatuslog.setCreatetime(new Date());
				schedulestatuslog.setDepartdate(scheduleplan.getDepartdate());
				schedulestatuslog.setOperationtype("1");// 报停 恢复操作
				schedulestatuslog.setOrgid(org.getId());
				schedulestatuslog.setScheduleid(scheduleplan.getScheduleid());
				dispatchServiceDao.merge(schedulestatuslog);
				// 保存操作日志
				Operationlog operationLog = new Operationlog();
				operationLog.setIp(ip);
				operationLog.setContent(result + "进行停班恢复处理");
				operationLog.setModule("综合调度->恢复停班");
				operationLog.setOperatetime(new Date());
				operationLog.setOperation("恢复停班");
				operationLog.setSessionid("无session");
				operationLog.setUserid(createby);
				operationLogService.savelog(operationLog);
			}
		}
		List<Ticketprice> tps = scheduleplan.getTicketpricelist();
		for (Ticketprice tp : tps) {
			tp.setIssellable(true);
			tp.setUpdateby(createby);
			tp.setUpdatetime(new Date());
			dispatchServiceDao.merge(tp);
		}
		scheduleplan.setIssellable(true);
		scheduleplan.setUpdateby(createby);
		scheduleplan.setUpdatetime(new Date());
		dispatchServiceDao.merge(scheduleplan);
		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Roadbillprint saveRoadbill(Roadbillprint roadbillprint)
			throws ServiceException {
		roadbillprint.setCreatetime(new Date());
		BigDecimal sequence = dispatchServiceDao.querySequence();
	    roadbillprint.setWaybillnumber(sequence);
		return (Roadbillprint) dispatchServiceDao.merge(roadbillprint);
	}

	// 放空操作
	@SuppressWarnings("unchecked")
	@Override
	public boolean departScheduleNoPrint(Vehiclereport vehiclereport)
			throws ServiceException {
		Scheduleplan scheduleplan = (Scheduleplan) dispatchServiceDao.get(
				Scheduleplan.class, vehiclereport.getScheduleplanid());
		if (isInvalid(scheduleplan.getDepartdate())) {
			throw new ServiceException("0092");
		}
		Organization org = (Organization) dispatchServiceDao.get(
				Organization.class, vehiclereport.getReportorgid());
		long departstationid = org.getStation().getId();
		if (dispatchServiceDao.getTicketsellCount(scheduleplan.getId(),
				departstationid) > 0) {
			throw new ServiceException("0100");
		}
		List<Schedulestatus> schedulestatuslist = scheduleplan
				.getSchedulestatuslist();
		// 初始化为状态
		String afterstatus = "0";// 正常
		String beforestatus = "0";// 正常
		for (Schedulestatus schedulestatus : schedulestatuslist) {
			if (schedulestatus.getDepartstationid() == departstationid) {
				beforestatus = schedulestatus.getStatus();
				schedulestatus.setUpdateby(vehiclereport.getCreateby());
				schedulestatus.setIsemptyvehicle(true);
				schedulestatus.setIsdeparted(true);
				schedulestatus.setUpdatetime(new Date());
				dispatchServiceDao.merge(schedulestatus);
			}
		}
		boolean isalldepart = true;
		for (Schedulestatus schedulestatus : schedulestatuslist) {
			if (!schedulestatus.getIsdeparted()) {
				isalldepart = false;
			}
		}
		if (isalldepart) {
			scheduleplan.setIssellable(false);
			scheduleplan.setUpdateby(vehiclereport.getCreateby());
			scheduleplan.setUpdatetime(new Date());
			dispatchServiceDao.merge(scheduleplan);
		}
		// 记录日志操作
		Schedulestatuslog schedulestatuslog = new Schedulestatuslog();
		schedulestatuslog.setAfterstatus(afterstatus);
		schedulestatuslog.setBeforestatus(beforestatus);
		schedulestatuslog.setCreateby(vehiclereport.getCreateby());
		schedulestatuslog.setCreatetime(new Date());
		schedulestatuslog.setDepartdate(scheduleplan.getDepartdate());
		schedulestatuslog.setOperationtype("9");// 放空操作
		schedulestatuslog.setOrgid(vehiclereport.getReportorgid());
		schedulestatuslog.setScheduleid(scheduleplan.getScheduleid());
		dispatchServiceDao.merge(schedulestatuslog);
		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean undodepartScheduleNoPrint(Vehiclereport vehiclereport)
			throws ServiceException {
		Scheduleplan scheduleplan = (Scheduleplan) dispatchServiceDao.get(
				Scheduleplan.class, vehiclereport.getScheduleplanid());
		if (isInvalid(scheduleplan.getDepartdate())) {
			throw new ServiceException("0092");
		}
		Organization org = (Organization) dispatchServiceDao.get(
				Organization.class, vehiclereport.getReportorgid());
		long departstationid = org.getStation().getId();
		List<Schedulestatus> schedulestatuslist = scheduleplan
				.getSchedulestatuslist();
		// 初始化为状态
		String afterstatus = "0";// 正常
		String beforestatus = "0";// 正常
		for (Schedulestatus schedulestatus : schedulestatuslist) {
			if (schedulestatus.getDepartstationid() == departstationid) {
				beforestatus = schedulestatus.getStatus();
				schedulestatus.setUpdateby(vehiclereport.getCreateby());
				schedulestatus.setIsemptyvehicle(false);
				schedulestatus.setIsdeparted(false);
				schedulestatus.setUpdatetime(new Date());
				dispatchServiceDao.merge(schedulestatus);
			}
		}
		scheduleplan.setIssellable(true);
		scheduleplan.setUpdateby(vehiclereport.getCreateby());
		scheduleplan.setUpdatetime(new Date());
		dispatchServiceDao.merge(scheduleplan);
		// 记录日志操作
		Schedulestatuslog schedulestatuslog = new Schedulestatuslog();
		schedulestatuslog.setAfterstatus(afterstatus);
		schedulestatuslog.setBeforestatus(beforestatus);
		schedulestatuslog.setCreateby(vehiclereport.getCreateby());
		schedulestatuslog.setCreatetime(new Date());
		schedulestatuslog.setDepartdate(scheduleplan.getDepartdate());
		schedulestatuslog.setOperationtype("10");// 取消放空操作
		schedulestatuslog.setOrgid(vehiclereport.getReportorgid());
		schedulestatuslog.setScheduleid(scheduleplan.getScheduleid());
		dispatchServiceDao.merge(schedulestatuslog);
		return true;
	}
	
	/*
	 * 车辆进站协议有效期校验
	 */
	private void checkPullinAgreement(Vehicle vehicle) throws ServiceException {
		if (vehicle.getPullinagreementno() != null && !"".equals(vehicle.getPullinagreementno())) {
			if (DateUtils.compare(new Date(), vehicle.getPullinStartdate()) < 0
					|| DateUtils.compare(vehicle.getPullinEnddate(), new Date()) < 0) {
				throw new ServiceException("0486");
			}
		} else {
			throw new ServiceException("0485");
		}
	}

	/*
	 * 车辆证件有效期验证
	 */
	private void checkVehicledate(Vehicle vehicle) throws ServiceException {		
		if (vehicle.getLicensestartdate() != null
				&& vehicle.getLicenseenddate() != null
				&& vehicle.getLiabilityinsurestartdate() != null
				&& vehicle.getLiabilityinsureenddate() != null
				&& vehicle.getCompulsoryinsurestartdate() != null
				&& vehicle.getCompulsoryinsureenddate() != null
				&& vehicle.getWorkstartdate() != null
				&& vehicle.getWorkenddate() != null) {
			if (DateUtils.compare(new Date(), vehicle.getLicensestartdate()) < 0
					|| DateUtils.compare(vehicle.getLicenseenddate(),
							new Date()) < 0) {
				throw new ServiceException("0401");
			}
			if (DateUtils.compare(new Date(),
					vehicle.getLiabilityinsurestartdate()) < 0
					|| DateUtils.compare(vehicle.getLiabilityinsureenddate(),
							new Date()) < 0) {
				throw new ServiceException("0402");
			}
			if (DateUtils.compare(new Date(),
					vehicle.getCompulsoryinsurestartdate()) < 0
					|| DateUtils.compare(vehicle.getCompulsoryinsureenddate(),
							new Date()) < 0) {
				throw new ServiceException("0403");
			}
			if (DateUtils.compare(new Date(), vehicle.getWorkstartdate()) < 0
					|| DateUtils.compare(vehicle.getWorkenddate(), new Date()) < 0) {
				throw new ServiceException("0404");
			}
		} else {
			throw new ServiceException("0400");
		}
		//20615 内蒙古通达南站站务需求 begin tianhb 2018年6月7日  证件到期提醒增加 线路标志牌和经营许可证 (未设置日期时则不校验) BEGIND
		if(null != vehicle.getRoadstartdate() && null != vehicle.getRoadenddate()){
			if (DateUtils.compare(new Date(), vehicle.getRoadstartdate()) < 0
					|| DateUtils.compare(vehicle.getRoadenddate(), new Date()) < 0) {
				throw new BusinessException("该车辆线路标志牌日期已过期，不允许报班！");
			}
		}
		if(null != vehicle.getBusinesscertificatestartdate() && null != vehicle.getBusinesscertificateenddate()){
			if (DateUtils.compare(new Date(), vehicle.getBusinesscertificatestartdate()) < 0
					|| DateUtils.compare(vehicle.getBusinesscertificateenddate(), new Date()) < 0) {
				throw new BusinessException("该车辆经营许可证日期已过期，不允许报班！");
			}
		}
		//20615 内蒙古通达南站站务需求 begin tianhb 2018年6月7日  证件到期提醒增加 线路标志牌和经营许可证 (未设置日期时则不校验) BEGIND
	}

	//返回true允许报班，false不允许报班
	private boolean checkRouteReportInterval(long scheduleid) {

		Date maxRouteTime = null;   //最近报班时间
		//报班时间间隔
		List<Object> interlist = dispatchServiceDao.qryRouteReportIntervalValue(scheduleid);
		if(interlist!=null && interlist.size()>0){
			reportinterval = ( (BigDecimal)interlist.get(0) ).intValue();
		}
		if(reportinterval==0){
			return true;
		}
		//最近报班时间
		List<Object> timelist = dispatchServiceDao.qryRouteReportInterval(scheduleid);
		if(timelist!=null && timelist.size()>0){
			if(timelist.get(0)==null){
				return true;
			}
			maxRouteTime = (Date) timelist.get(0);
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(maxRouteTime);
			//允许的报班时间
			calendar.add(Calendar.MINUTE, reportinterval);
			Date allowDate = calendar.getTime();
			//System.out.println("最近报班时间："+maxRouteTime+"————报班时间间隔："+reportinterval+"————允许报班时间："+allowDate);
			//当前时间
			Date currentTime = new Date();
			//System.out.println( "是否不允许报班："+currentTime.before(allowDate) );
			//计算
			if(currentTime.before(allowDate)){
				//不可以报班
				return false;// "该线路两次报班时间间隔小于最小时间间隔["+reportinterval+"]，不能报班！";
			}
		}	
		return true;
	}
	private String checkDriverReportInterval(long driverid,int reportinterval) {
		//int reportinterval = 0;    //报班时间间隔
		Date maxDriverTime = null;   //最近报班时间
		//报班时间间隔
		//Global global = CurrentUtil.getGlobal();
		//String paVal = parameterService.findParamValue(ParamterConst.Param_2025, global.getOrganization().getId());
		//reportinterval =  new Integer(paVal);
		//最近报班时间
		List<Object> timelist = dispatchServiceDao.qryDriverReportInterval(driverid);
		if(timelist!=null && timelist.size()>0){
			if(timelist.get(0)==null){
				return null;
			}
			maxDriverTime = (Date) timelist.get(0);
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(maxDriverTime);
			//允许的报班时间
			calendar.add(Calendar.MINUTE, reportinterval);
			Date allowDate = calendar.getTime();
			//当前时间
			Date currentTime = new Date();
			//计算
			if(currentTime.before(allowDate)){
				//不可以报班
				return "两次报班时间间隔小于'2025'参数设置的值["+reportinterval+"]，不能报班！";
			}
		}	
		return null;
	}
	
	public void checkRoadNoAndBusinesscertificateno(Vehicle vehicle, Global global) {
		String vehicleIsAudit = parameterService.findParamValue(ParamterConst.Param_2054,
				global.getUserinfo().getOrgid());

	}
	
	@SuppressWarnings("unchecked")
	@Override
	public MethodResult vehicleReport(Vehiclereport vehiclereport,
			Vehicledriverreport vdp, Long departstationid, String vehicleno,
			Global global) throws ServiceException {
		long start = System.currentTimeMillis();
		vdriver=null;
		Map<String, Object> requestMap = new HashMap<String, Object>();
		System.out.println("start2=" + start);
		MethodResult result = new MethodResult();
		Scheduleplan scheduleplan = (Scheduleplan) dispatchServiceDao.get(Scheduleplan.class,vehiclereport.getScheduleplanid());	
		
		
		if (scheduleplan == null) {
			// 该车辆当天没有营运信息！
			throw new ServiceException("0234");
		}
		Vehicle reportvehicle = (Vehicle) dispatchServiceDao.get(Vehicle.class,vehiclereport.getVehicleid());	
		//参数2054: 车牌管理中未审核的车辆是否允许报班，0不允许，1允许
		String vehicleIsAudit = parameterService.findParamValue(ParamterConst.Param_2054,
				global.getUserinfo().getOrgid());
		if(("0".equals(vehicleIsAudit)) && (!reportvehicle.getIsaudited())){
			throw new ServiceException("2054");//2049参数值为0，该车牌未审核，不允许报班。
		}
		
		// 参数2083: IC卡报班时是否开启线路标志牌有效期验证, 0:不校验,1:校验
		String p2083 = parameterService.findParamValue(ParamterConst.Param_2083,
				global.getUserinfo().getOrgid());
		if ("1".equals(p2083)) {
			if (null == reportvehicle.getRoadno() || "".equals(reportvehicle.getRoadno())) {
				throw new BusinessException("该车辆线路标志牌为空,不允许报班!");
			}
			if (null == reportvehicle.getRoadenddate()
					|| DateUtils.compare(reportvehicle.getRoadenddate(), new Date()) < 0) {
				throw new BusinessException("该车辆线路标志牌已过期,不允许报班!");
			}
		}

		// 参数2084: IC卡报班时是否开启经营许可证有效期验证, 0:不校验,1:校验
		String p2084 = parameterService.findParamValue(ParamterConst.Param_2084, global.getUserinfo().getOrgid());
		if ("1".equals(p2084)) {
			if (null == reportvehicle.getBusinesscertificateno()
					|| "".equals(reportvehicle.getBusinesscertificateno())) {
				throw new BusinessException("该车辆经营许可证为空,不允许报班!");
			}
			if (null == reportvehicle.getBusinesscertificateenddate()
					|| DateUtils.compare(reportvehicle.getBusinesscertificateenddate(), new Date()) < 0) {
				throw new BusinessException("该车辆经营许可证已过期,不允许报班!");
			}
		}
		
		//校验移至 扩展点   IC卡报班时是否开启车辆综合性能检测和技术等级评定有效期验证,0:不校验，1:校验
		ActionNode actionNode = Appvar.routes.get("ACCESSTECHNIALANDVEHICLE");
		if (actionNode != null){
			PluginFunction.DoPlugin(reportvehicle, global,actionNode);
		}
		Organization orgreport = (Organization) dispatchServiceDao
				.getOrgInfo(departstationid);
		if(orgreport==null){
			orgreport=(Organization) dispatchServiceDao.get(Organization.class, scheduleplan.getOrgid());
		}
		//证件审查扩展点
		actionNode = Appvar.routes.get("VEHICLEREPORTLICENSECHECKEXPORT");// 由插件名,获得插件
		//十堰：vehicle表的isneedcheck字段 是否开启报班时证件审核
		if (reportvehicle.getIsneedcheck()==true){
			//查询是否使用了certificatecheck证件审核插件；从Appvar.routes中获取扩张点插件名、插件类、插件方法
			PluginFunction.DoPlugin(vehiclereport, global,actionNode);
		}
		String definelost = parameterService.findParamValue(ParamterConst.Param_2047,
				global.getUserinfo().getOrgid());
		if(definelost.equals("1")){
		//脱班晚点处理扩展点
		requestMap.put("scheduleid",vehiclereport.getScheduleid());
		//requestMap.put("vehicleid", vehiclereport.getVehicleid());
		requestMap.put("scheduleplanid", vehiclereport.getScheduleplanid());
		Map<Object, Object> queryresult = PluginFunctionUtil.doPlugin(
				"ISEXISTSCHEDULELOSTTREATMENT", requestMap);
		if("1".equals(queryresult.get("isUsePlugin"))){
			String exceptionCode = (String)queryresult.get("exceptionCode");
			if(exceptionCode != null && !"".equals(exceptionCode)){
				throw new BusinessException(exceptionCode);
			}
		}
		}
		
		//酒精测试记录扩展点
		actionNode = Appvar.routes.get("ALCOHOLTESTEREXPORT");
		PluginFunction.DoPlugin(vehiclereport, global,actionNode);
		
		/*任务号2680：通过【报到】功能按钮进行手动输入车牌号或者IC卡号进行报班时，取消判断   该车辆可营运班次   设置的条件；
		//扩展点: 车辆运营班次设置。若在车辆运营班次设置车辆的可营运班次，则IC卡报班的班次列表信息取车辆营运班次设置的班次信息。
		actionNode = Appvar.routes.get("VEHICLEREPORTCONCTREXPORT");
		PluginFunction.DoPlugin(vehiclereport, global,actionNode);
		*/
		
		String begincheck = parameterService.findParamValue(ParamterConst.Param_2009,
				orgreport.getId());

		vehiclereport.setOrgid(orgreport.getId());
		Schedule schedule = (Schedule) dispatchServiceDao.get(Schedule.class,
				scheduleplan.getScheduleid());
		short seatnum = 0;// 车辆座位数
		//todo..
		//同线路报班时间隔时间限制判断 p2037
		String checkReportInterval = parameterService.findParamValue(ParamterConst.Param_2037, orgreport.getId());
		if(checkReportInterval.equals("1")){
			if (!checkRouteReportInterval(schedule.getId())){
				throw new ServiceException("0758");
			}
		}
		String mustcheck = parameterService.findParamValue(ParamterConst.Param_2013, orgreport.getId());
		//20160805 温泉中心站需求：报班时已过发车日期的班次（报到当天以前的班次）报班时不判断车辆是否已安检或是否安检通过，可直接报班
		if(mustcheck.equals("1") && (util.DateUtils.compare(scheduleplan.getDepartdate(), new Date()) >= 0)){
			//检查安检
			MethodResult res=checkVehicle(vehiclereport.getVehicleid(),vehiclereport.getDepartdate(),orgreport.getId());
			if(res.getResult()<0){
				throw new ServiceException("0292");				
			}
		}	
		
		//2030驾驶员证件过期是否允许报班:1允许，0不允许
		String checkDriverValid = parameterService.findParamValue(ParamterConst.Param_2030, orgreport.getId());
		String checkDriverAuditing = parameterService.findParamValue(ParamterConst.Param_2056, orgreport.getId());
		long driver1id=0;
		long driver2id=0;
		long driver3id=0;
		long driver4id=0;
		if(checkDriverValid.equals("0") || checkDriverAuditing.equals("0")){	
			if(vehiclereport.getDriver1()!=null&&vehiclereport.getDriver1().getId()>0){
				driver1id=vehiclereport.getDriver1().getId();
			}
			if(vehiclereport.getDriver2()!=null&&vehiclereport.getDriver2().getId()>0){
				driver2id=vehiclereport.getDriver2().getId();
			}
			if(vehiclereport.getDriver3()!=null&&vehiclereport.getDriver3().getId()>0){
				driver3id=vehiclereport.getDriver3().getId();
			}
			if(vehiclereport.getDriver4()!=null&&vehiclereport.getDriver4().getId()>0){
				driver4id=vehiclereport.getDriver4().getId();
			}			
		}
		String temp = "";
		if(checkDriverValid.equals("0")){
			temp = showValidate(orgreport.getId(),driver1id,driver2id,driver3id,driver4id);
		}
		if(checkDriverAuditing.equals("0")){
			checkDriverAuditing(orgreport.getId(),driver1id,driver2id,driver3id,driver4id);
		}
		
		//同驾驶员（由2025参数控制）驾驶员两次报班的最小时间间隔
		String driverInterval = parameterService.findParamValue(ParamterConst.Param_2025, orgreport.getId());
		int reportinterval=0;
		try{
			reportinterval =  new Integer(driverInterval); 
		}catch(Exception e){
			play.Logger.error(e.getMessage());
		}
		if(reportinterval>0){
			if(vehiclereport.getDriver1()!=null&&vehiclereport.getDriver1().getId()>0){
				if(checkDriverReportInterval(vehiclereport.getDriver1().getId(),reportinterval)!=null){
					//驾驶员报班间隔不能小于系统中规定的时间
					throw new ServiceException("0759");
				}
			}
			if(vehiclereport.getDriver2()!=null&&vehiclereport.getDriver2().getId()>0){
				if(checkDriverReportInterval(vehiclereport.getDriver2().getId(),reportinterval)!=null){
					//驾驶员报班间隔不能小于系统中规定的时间
					throw new ServiceException("0759");
				}
			}
			if(vehiclereport.getDriver3()!=null&&vehiclereport.getDriver3().getId()>0){
				if(checkDriverReportInterval(vehiclereport.getDriver3().getId(),reportinterval)!=null){
					//驾驶员报班间隔不能小于系统中规定的时间
					throw new ServiceException("0759");
				}
			}
		}
		//6015:车辆GPS检查是否必须合格才能进行报班：0否，1是
		String ischeckGPS= parameterService.findParamValue(ParamterConst.Param_6015, orgreport.getId());
		if(ischeckGPS.equals("1")){
			 // 6010:安检有效时间类型：0当日有效，1:24小时有效
			String checktype= parameterService.findParamValue(ParamterConst.Param_6010, orgreport.getId());
			List<Object> list=dispatchServiceDao.qryGps(vehiclereport.getDepartdate(),vehiclereport.getVehicleid(),checktype);
			if(list==null||list.size()==0){
				//该车辆必须通过GPS安检合格才能报到！
				throw new ServiceException("0760");
			}
		}
		// 若是非流水班次
		if (!scheduleplan.getIslinework()) {
			// 新增判断当前计划车辆座位类型和报到车辆座位类型一致，判断计划车每种座位类型已售和报到车此种座位类型数量进行比较,如果大于则不允许报班
			if (IsPemissionReportbySeattype(vehiclereport)) {
				throw new ServiceException("6118");
			}

		}
		//0143 是否开启车辆里程限制
		String ischeckdistance= parameterService.findParamValue(ParamterConst.Param_0143, orgreport.getId());
		if(ischeckdistance.equals("1")){
			VehicledistanceactiveService vs= new VehicledistanceactiveServiceImpl();
			vs.qryVheicledistiance(vehiclereport.getVehicleid(), orgreport.getId(), false);
		}
		//6006 是否开启车辆二期维护有效期
		String ismaintain= parameterService.findParamValue(ParamterConst.Param_6006, orgreport.getId());
		if(ismaintain.equals("1")){
			VehicledistanceactiveService vs= new VehicledistanceactiveServiceImpl();
			vs.qryVheicledistiance(vehiclereport.getVehicleid(), orgreport.getId(), true);
		}
		// 车辆报班是否校验进站协议有效期
	    String pullinReport = parameterService
	        .findParamValue(ParamterConst.Param_2036, orgreport.getId());
	    if ("0".equals(pullinReport)) {
	      checkPullinAgreement(reportvehicle);
	    }
		
		vehiclereport.setIsreplace(vehiclereport.getIsTempVehicle());
//		// 若为临时车牌先保存车辆信息  注释 把是否临时车辆判断改为顶班否
//		if (vehiclereport.getIsTempVehicle() && vehicleno != null) {
//			reportvehicle = saveVehicle(vehiclereport, vehicleno);
//			vehiclereport.setVehicleid(reportvehicle.getId());
//		}
		//if (reportvehicle == null) {
		reportvehicle = (Vehicle) dispatchServiceDao.get(Vehicle.class,
					vehiclereport.getVehicleid());
		//}		
		//查询上次报到的非流水班发车时间     或者        流水班上次报到时间
		String checkreporttimeresult = checkreporttime(reportvehicle.getId(),scheduleplan,departstationid);
		if(checkreporttimeresult!=null){
			//您本日已经报到其它班次，且发车时间距离本班次发车时间不足?分钟
			throw new BusinessException(checkreporttimeresult);
		}
		//判断车辆是否只允许车辆报到在已指定的线路中
		String ismastbe = parameterService.findParamValue(ParamterConst.Param_2021,orgreport.getId());
		if(ismastbe.equals(ParamterConst.COMMON_FLAG.FALG_YES)){	
			//如果是抛出错误:该车辆只能报到车辆指定的线路：+线路名称
			isOnlyReportRoute(reportvehicle.getId(),schedule.getId());		
		}	
		
		if (!reportvehicle.getStatus().equals("0")) {
			// 该车辆不是营运状态，不允许报到！
			throw new ServiceException("0345");
		}
		// 行驶证、保险过期的车辆是否允许报到(临时车不做判断)
		String allowreport2 = parameterService
				.findParamValue(ParamterConst.Param_2019, orgreport.getId());
		if (ParamterConst.COMMON_FLAG.FALG_NO.equals(allowreport2) && (!vehiclereport.getIsTempVehicle())) {
			checkVehicledate(reportvehicle);
		}
		seatnum = reportvehicle.getSeatnum();
		//long rationseatnum =reportvehicle.getRationseatnum();
		// 已售座位数大于车辆的乘客座位数且小于该车辆核定座位数,是否允许报到
		String allowreport3 = parameterService
				.findParamValue(ParamterConst.Param_2022, orgreport.getId());
		if (!scheduleplan.getIslinework()) {			
			if (seatnum < scheduleplan.getSoldeatnum()) {
				if(allowreport3.equals(ParamterConst.COMMON_FLAG.FALG_YES)){
					//已售大于车辆座位数也允许报班
					/*if (rationseatnum < scheduleplan.getSoldeatnum()){
						// 报到车辆座位数小于该班次已售座位数,不许报到
						throw new ServiceException("0069");
					}*/						
				}else{
					// 报到车辆座位数小于该班次已售座位数,不许报到
					throw new ServiceException("0069");
				}
				
			}
		}
		// 若是非流水班次
		String ischangeseat = parameterService.findParamValue("2031", orgreport.getId());
		if (!scheduleplan.getIslinework() && !schedule.isIsfixseat()&&ischangeseat.equals("1")) {
			//changeSeats(scheduleplan, seatnum, vehiclereport.getCreateby());
			// 报到车辆座位数小于班次座位数
			List<Scheduleseats> sst = scheduleplan.getScheduleseatslist();
			Iterator<Scheduleseats> it = sst.iterator();
			while (it.hasNext()) {
				Scheduleseats ss = it.next();
				if (ss.getSeatno() > seatnum) {
					if (ss.getStatus().equals("2")) {
						/**
						 * 若车站的座位数大于车辆报到的实际座位个数 并且其中有已售的座位 则不允许报到
						 * 姜蓥瑞2015年8月19日11:15:51
						 */
						throw new ServiceException("6117");
					}
				}
			}
		}

		// 开始锁记录
		Schedulestatus schedulestatus = dispatchServiceDao.getSchedulestatus(
				vehiclereport.getScheduleplanid(), departstationid);
		if ((!scheduleplan.getIslinework()) && schedulestatus.getIsreported()) {
			throw new ServiceException("0064");
		}
		String status = schedulestatus.getStatus();
		// 班次状态:正常\报停、晚点、被并
		if ("1".equals(status)) {
			throw new ServiceException("0065");
		}
		// 被并
		if ("3".equals(status)) {
			throw new ServiceException("0066");
		}
		
		// 若报到站机构ID 不等于班次机构ID，则是配客班次，
		if (orgreport.getId() != schedule.getOrgid()) {
			//2010:始发站未报到，配客站是否允许报到,
			
//			String allowreport = parameterService.findParamValue("2010",
//					orgreport.getId());
			
			String allowreport = parameterService.findParamValue(ParamterConst.Param_2010,
					global.getUserinfo().getOrgid());
			Organization schedulorg = (Organization) dispatchServiceDao.get(Organization.class, schedule.getOrgid());
			//始发站，是否已发车
			boolean isrepored = dispatchServiceDao.isReproted(
					vehiclereport.getScheduleplanid(),schedulorg.getStation().getId());
			//是否站未报到，且不许允许配客站报到，则抛出错误
			if (!isrepored && ParamterConst.COMMON_FLAG.FALG_NO.equals(allowreport)) {
				//该班次始发站未报到，配客站不允许报到
				throw new ServiceException("0067");
			}
		}
		// 开始更新
		// 计算是否做晚点处理
		// 提前报到分钟数
		Vehiclelate vehiclelate = null;
		//判断参数2047，晚点定义；
		String definelate = parameterService.findParamValue(ParamterConst.Param_2047,
				global.getUserinfo().getOrgid());
		if(definelate.equals("0")){
			vehiclelate = vehicleLater(vehiclereport, scheduleplan,
				schedulestatus.getDeparttime());
		if (vehiclelate != null) {
			// 班次状态:正常\报停、晚点、被并
			schedulestatus.setStatus("2");
		}
		}
		// 晚点处理结束
		schedulestatus.setIsreported(true);
		if (ParamterConst.COMMON_FLAG.FALG_YES.equals(begincheck)) {
			schedulestatus.setIsbegincheck(true);
			if(schedule.getWorktype().equals("2")){
				List<Schedulestatus> sslist=scheduleplan.getSchedulestatuslist();
				for(Schedulestatus ss:sslist){
					ss.setIsreported(true);
					ss.setIsbegincheck(true);
					ss.setUpdateby(vehiclereport.getCreateby());
					ss.setUpdatetime(new Date());
					dispatchServiceDao.merge(ss);
				}
			}
		}
		short orderno = 0;
		// 若是始发站进行报到
		if (vehiclereport.getOrgid() == vehiclereport.getReportorgid()) {
			if (scheduleplan.getIssaleafterreport()) {
				scheduleplan.setIssellable(true);
				scheduleplan.setUpdateby(vehiclereport.getCreateby());
				scheduleplan.setUpdatetime(new Date());
				dispatchServiceDao.merge(scheduleplan);
			}
			
			String isautoreport = parameterService.findParamValue("2012",
					vehiclereport.getOrgid());
			// 配客站自动进行报到
			if ("1".equals(isautoreport)) {
				List<Schedulestatus> schedulestatuslist = dispatchServiceDao
						.qrySchedulestatus(vehiclereport.getScheduleplanid(),
								departstationid);
				for (Schedulestatus curSchedulestatus : schedulestatuslist) {
					// 班次状态:正常\报停、晚点、被并
					if (("0".equals(curSchedulestatus.getStatus()) || "2"
							.equals(curSchedulestatus.getStatus()))
							&& (scheduleplan.getIslinework() || (!scheduleplan
									.getIslinework() && !curSchedulestatus
									.getIsreported()))) {
						Organization curOrg = dispatchServiceDao
								.getOrganization(curSchedulestatus
										.getDepartstationid());
						if(curOrg==null){
							continue;
							//curOrg=(Organization) dispatchServiceDao.get(Organization.class, scheduleplan.getOrgid());
						}
						curSchedulestatus.setIsreported(true);
						if (ParamterConst.COMMON_FLAG.FALG_YES.equals(begincheck)) {
							curSchedulestatus.setIsbegincheck(true);
						}
						orderno = 0;
						curSchedulestatus.setStatus(schedulestatus.getStatus());
						curSchedulestatus.setUpdateby(vehiclereport
								.getCreateby());
						curSchedulestatus.setUpdatetime(new Date());
						Vehiclereport cur = new Vehiclereport();
						cur.setCreateby(vehiclereport.getCreateby());
						cur.setCreatetime(new Date());
						cur.setDepartdate(vehiclereport.getDepartdate());
						cur.setDriver1(vehiclereport.getDriver1());
						cur.setDriver2(vehiclereport.getDriver2());
						cur.setDriver3(vehiclereport.getDriver3());
						cur.setDriver4(vehiclereport.getDriver4());
						cur.setIsactive(true);
						if(vehiclereport.getOrderno()>0){
							cur.setOrderno(vehiclereport.getOrderno());
						}else{
						    cur.setOrderno(orderno);
						}
						cur.setOrgid(vehiclereport.getOrgid());
						cur.setReportorgid(curOrg.getId());
						cur.setReporttime(new Date());
						cur.setReportway("0");
						cur.setScheduleid(vehiclereport.getScheduleid());
						cur.setScheduleplanid(vehiclereport.getScheduleplanid());
						cur.setSteward1(vehiclereport.getSteward1());
						cur.setSteward2(vehiclereport.getSteward2());
						cur.setUpdateby(vehiclereport.getCreateby());
						cur.setUpdatetime(new Date());
						cur.setVehicleid(vehiclereport.getVehicleid());
						cur.setIsreplace(vehiclereport.isIsreplace());
						dispatchServiceDao.merge(curSchedulestatus);
						dao.merge(cur);
					}
				}
			}
		} else {
//			vehiclereport.setReportorgid(orgreport.getId());
			vehiclereport.setReportorgid(global.getUserinfo().getOrgid());
		}
		// 若是流水班次
		if (scheduleplan.getIslinework()) {
			//如果是手动输入的车辆，则进入
			if(vehiclereport.getOrderno()<=0){
				orderno = dispatchServiceDao.getMaxOrderno(vehiclereport);
				orderno = (short) (orderno + 1);
				vehiclereport.setOrderno(orderno);
			}
			//--判断是否更新计划车辆信息  0：否，1是      
//			Schedulevehiclepeopleplan svp=scheduleplan.getSchedulevehiclepeopleplanlist().get(0);
			Schedulevehiclepeopleplan svp =null;
			List<Schedulevehiclepeopleplan> svplist = scheduleplan.getSchedulevehiclepeopleplanlist();
			//取页面传入的orderno 对应的人员计划
			for (Schedulevehiclepeopleplan svplan : svplist) {
				if(svplan.getOrderno()==vehiclereport.getOrderno()){
					svp = svplan;
					break;
				}
			}
			if(svp!=null){//判断是否更新计划车辆信息  0：不更新，大于等于1更新      
				String isupvehcleplan = parameterService.findParamValue(ParamterConst.Param_3034,vehiclereport.getOrgid());
				if (!ParamterConst.COMMON_FLAG.FALG_NO.equals(isupvehcleplan)) {//只要不是0，就更新
					svp.setPlanvehicle(reportvehicle);
					svp.setPlanvehiclebrandmodelid(reportvehicle.getVehiclebrandmodelid());
					svp.setPlanvehicletypeid(reportvehicle.getVehicletypeid());
				}
				dispatchServiceDao.merge(svp);
			}
		}else{// 非流水班次
			Schedulevehiclepeopleplan svp=scheduleplan.getSchedulevehiclepeopleplanlist().get(0);
			if(svp!=null){//判断是否更新计划车辆信息  0：不更新，大于等于1更新      
				String isupvehcleplan = parameterService.findParamValue(ParamterConst.Param_3034,vehiclereport.getOrgid());
				if (!ParamterConst.COMMON_FLAG.FALG_NO.equals(isupvehcleplan)) {//只要不是0，就更新
					svp.setPlanvehicle(reportvehicle);
					svp.setPlanvehiclebrandmodelid(reportvehicle.getVehiclebrandmodelid());
					svp.setPlanvehicletypeid(reportvehicle.getVehicletypeid());
				}
				dispatchServiceDao.merge(svp);
			}
			vehiclereport.setOrderno(orderno);
		}
		result.setObject(vehiclereport.getScheduleplanid());
		vehiclereport.setReportway("1");
//		vehiclereport.setOrderno(orderno);
		vehiclereport.setReporttime(new Date());
		vehiclereport.setIsactive(true);
		vehiclereport.setCreatetime(new Date());
		vehiclereport.setUpdateby(vehiclereport.getCreateby());
		vehiclereport.setUpdatetime(new Date());
		schedulestatus.setUpdateby(vehiclereport.getCreateby());
		schedulestatus.setUpdatetime(new Date());
		dispatchServiceDao.merge(schedulestatus);
		vehiclereport = dao.merge(vehiclereport);
		vdriver=vdp;
		if (vdriver!=null){
			//保存驾驶员信息（车辆应班登记表）
			saveVehicledriverreport(vehiclereport,reportvehicle,schedulestatus);
		}
		String lateinfo = "";
		if (vehiclelate != null) {
			vehiclelate.setReportid(vehiclereport.getId());
			// 班次状态:正常\报停、晚点、被并
			lateinfo = "，并做了晚点处理！";
			dispatchServiceDao.getEntityManager().merge(vehiclelate);
		}

		
		/**
		 * C卡报班时，若报到车型与班次循环中计划车型不一致时，且报到车型为班次硬调票价中设置的车型时，
		 * 自动更新计划车型并取对应车型的票价。修改后IC卡报到页面，车辆类型与售票车型将保持一致。
		 * 若报到车型与班次硬调票价中设置的车型都不一致时，不更新计划车型及对应车型的票价。 姜蓥瑞 2015年9月17日18:17:14
		 */
		if (!scheduleplan.getIslinework()&&!schedule.isIsfixseat()) {
//			updateSeattypetoTicketprice(vehiclereport, global,scheduleplan.getFixedreserveseatnum()>0?new Short(scheduleplan.getFixedreserveseatnum()).toString():"0");
			result =updateSeattypetoAll(vehiclereport, global, scheduleplan.getFixedreserveseatnum()>0?new Short(scheduleplan.getFixedreserveseatnum()).toString():"0");
			if(result.getResult()==0){
				return result;
			}else{
				lateinfo += result.getResultMsg();
			}
		}
		String extinguishers = "";
		//判断灭火器
		if (reportvehicle.getExtinguisherenddate() != null) {
			String p2093 = parameterService
					.findParamValue(ParamterConst.Param_2093,CurrentUtil.getGlobal().getOrganization().getId());
			if (DateUtils.compare(new Date(), reportvehicle.getExtinguisherstartdate()) < 0
					|| DateUtils.compare(reportvehicle.getExtinguisherenddate(),
							new Date()) < 0) {
				if ("0".equals(p2093)) {
					throw new BusinessException("车辆携带的灭火器已过期，不允许报班！");
				}
				if ("1".equals(p2093)) {
					extinguishers = "车辆携带的灭火器已过期";
				}
			}
		}		
		//该班次最后报班记录中的报班序号
		scheduleplan.setReportorderno(vehiclereport.getOrderno());
		scheduleplan.setUpdateby(vehiclereport.getUpdateby());
		dispatchServiceDao.merge(scheduleplan);
		result.setResult(1);
		result.setResultMsg(reportvehicle.getVehicleno() + "：车辆报到成功！"
				+ lateinfo+temp + extinguishers);
		long middle = System.currentTimeMillis();
		System.out.println("执行时间=" + (middle - start));
		
		return result;
	}
	
	/**
	 *获取该班次最后报班记录中的报班序号
	 */
	private int getMaxActiveReportOrder(long scheduleplanid, long reportorgid, long reportId){
		int order = 0;
		List<Vehiclereport> list = dispatchServiceDao.qryVehiclereport(scheduleplanid, reportorgid, reportId);
		if(list != null && list.size() > 0){
			order = list.get(0).getOrderno();
		}
		return order;
	}
	
	private String checkDriverAuditing(long orgid, long driver1id, long driver2id,
			long driver3id, long driver4id) throws ServiceException {
		String msg ="";
		long flag = 0;
		String temp ="";
		//证件有效期到期提示天数
		int showdate = Integer.parseInt(parameterService.findParamValue(ParamterConst.Param_2024, orgid));
		if(driver1id !=0){
			temp = "正驾驶员的";
			Driver driver1 = (Driver) idao.get(Driver.class, driver1id);
			if ( driver1.getSincerityauditingdate() !=null
					&&DateUtils.compare(driver1.getSincerityauditingdate(),new Date()) < 0 ){
				throw new ServiceException(msg+temp,"0478");	//驾驶员的诚信考核已过期，不允许报班！				
			}
			if ( driver1.getContinuingeducationdate() !=null
					&&DateUtils.compare(driver1.getContinuingeducationdate(),new Date()) < 0 ){
				throw new ServiceException(msg+temp,"0479");	//驾驶员的继续教育已过期，不允许报班！			
			}
							
		
			if ( driver1.getSincerityauditingdate() !=null
					&&DateUtils.compare(driver1.getSincerityauditingdate(),new Date()) >= 0 
					&&DateUtils.compare( DateUtils.add(driver1.getSincerityauditingdate(),-showdate) ,new Date())<0){
				temp = temp +"诚信考核有效期还有"
					+DateUtils.getIntervalDays(new Date(),DateUtils.add(driver1.getSincerityauditingdate(),2))
					+"天过期!";
				flag = -1;
			}
			if (driver1.getContinuingeducationdate()!=null
					&&DateUtils.compare(driver1.getContinuingeducationdate(),new Date()) >= 0 
					&&DateUtils.compare( DateUtils.add(driver1.getContinuingeducationdate(),-showdate) ,new Date())<0) {
				temp = temp +"继续教育有效期还有"
				+DateUtils.getIntervalDays(new Date(),DateUtils.add(driver1.getContinuingeducationdate(),2))
				+"天过期!";
				flag = -1;
			}	
			if(flag == -1){
				msg = temp;
			}
			flag = 0;
		}
		if(driver2id != 0 ){
			Driver driver2 = (Driver) idao.get(Driver.class, driver2id);
			temp = "  副驾驶员1的";
			if ( driver2.getSincerityauditingdate() !=null
					&&DateUtils.compare(driver2.getSincerityauditingdate(),new Date()) < 0 ){
				throw new ServiceException(msg+temp,"0478");	//驾驶员的诚信考核已过期，不允许报班！				
			}
			if ( driver2.getContinuingeducationdate() !=null
					&&DateUtils.compare(driver2.getContinuingeducationdate(),new Date()) < 0 ){
				throw new ServiceException(msg+temp,"0479");	//驾驶员的继续教育已过期，不允许报班！			
			}
							
		
			if ( driver2.getSincerityauditingdate() !=null
					&&DateUtils.compare(driver2.getSincerityauditingdate(),new Date()) >= 0 
					&&DateUtils.compare( DateUtils.add(driver2.getSincerityauditingdate(),-showdate) ,new Date())<0){
				temp = temp +"诚信考核有效期还有"
					+DateUtils.getIntervalDays(new Date(),DateUtils.add(driver2.getSincerityauditingdate(),2))
					+"天过期!";
				flag = -1;
			}
			if (driver2.getContinuingeducationdate()!=null
					&&DateUtils.compare(driver2.getContinuingeducationdate(),new Date()) >= 0 
					&&DateUtils.compare( DateUtils.add(driver2.getContinuingeducationdate(),-showdate) ,new Date())<0) {
				temp = temp +"继续教育有效期还有"
				+DateUtils.getIntervalDays(new Date(),DateUtils.add(driver2.getContinuingeducationdate(),2))
				+"天过期!";
				flag = -1;
			}	
			if(flag == -1){
				msg = temp;
			}
			flag = 0;
		}
		if(driver3id != 0 ){
			Driver driver3 = (Driver) idao.get(Driver.class, driver3id);
			temp ="  副驾驶员2的";
			if ( driver3.getSincerityauditingdate() !=null
					&&DateUtils.compare(driver3.getSincerityauditingdate(),new Date()) < 0 ){
				throw new ServiceException(msg+temp,"0478");	//驾驶员的诚信考核已过期，不允许报班！				
			}
			if ( driver3.getContinuingeducationdate() !=null
					&&DateUtils.compare(driver3.getContinuingeducationdate(),new Date()) < 0 ){
				throw new ServiceException(msg+temp,"0479");	//驾驶员的继续教育已过期，不允许报班！			
			}
							
		
			if ( driver3.getSincerityauditingdate() !=null
					&&DateUtils.compare(driver3.getSincerityauditingdate(),new Date()) >= 0 
					&&DateUtils.compare( DateUtils.add(driver3.getSincerityauditingdate(),-showdate) ,new Date())<0){
				temp = temp +"诚信考核有效期还有"
					+DateUtils.getIntervalDays(new Date(),DateUtils.add(driver3.getSincerityauditingdate(),2))
					+"天过期!";
				flag = -1;
			}
			if (driver3.getContinuingeducationdate()!=null
					&&DateUtils.compare(driver3.getContinuingeducationdate(),new Date()) >= 0 
					&&DateUtils.compare( DateUtils.add(driver3.getContinuingeducationdate(),-showdate) ,new Date())<0) {
				temp = temp +"继续教育有效期还有"
				+DateUtils.getIntervalDays(new Date(),DateUtils.add(driver3.getContinuingeducationdate(),2))
				+"天过期!";
				flag = -1;
			}	
			if(flag == -1){
				msg = temp;
			}
			flag = 0;
		}
		if(driver4id != 0 ){
			Driver driver4 = (Driver) idao.get(Driver.class, driver4id);
			temp ="  副驾驶员3的";
			if ( driver4.getSincerityauditingdate() !=null
					&&DateUtils.compare(driver4.getSincerityauditingdate(),new Date()) < 0 ){
				throw new ServiceException(msg+temp,"0478");	//驾驶员的诚信考核已过期，不允许报班！				
			}
			if ( driver4.getContinuingeducationdate() !=null
					&&DateUtils.compare(driver4.getContinuingeducationdate(),new Date()) < 0 ){
				throw new ServiceException(msg+temp,"0479");	//驾驶员的继续教育已过期，不允许报班！			
			}
							
		
			if ( driver4.getSincerityauditingdate() !=null
					&&DateUtils.compare(driver4.getSincerityauditingdate(),new Date()) >= 0 
					&&DateUtils.compare( DateUtils.add(driver4.getSincerityauditingdate(),-showdate) ,new Date())<0){
				temp = temp +"诚信考核有效期还有"
					+DateUtils.getIntervalDays(new Date(),DateUtils.add(driver4.getSincerityauditingdate(),2))
					+"天过期!";
				flag = -1;
			}
			if (driver4.getContinuingeducationdate()!=null
					&&DateUtils.compare(driver4.getContinuingeducationdate(),new Date()) >= 0 
					&&DateUtils.compare( DateUtils.add(driver4.getContinuingeducationdate(),-showdate) ,new Date())<0) {
				temp = temp +"继续教育有效期还有"
				+DateUtils.getIntervalDays(new Date(),DateUtils.add(driver4.getContinuingeducationdate(),2))
				+"天过期!";
				flag = -1;
			}	
			if(flag == -1){
				msg = temp;
			}
			flag = 0;
		}
		if (msg !="" && !msg.equals("")) {
			return msg;
		}else{
			return null;
		}
		
	}

	/**
	 * C卡报班时，若报到车型与班次循环中计划车型不一致时，且报到车型为班次硬调票价中设置的车型时，
	 * 自动更新计划车型并取对应车型的票价。修改后IC卡报到页面，车辆类型与售票车型将保持一致。
	 * 若报到车型与班次硬调票价中设置的车型都不一致时，不更新计划车型及对应车型的票价。 姜蓥瑞 2015年9月17日18:17:14
	 */
	public boolean updateSeattypetoTicketprice(Vehiclereport vehiclereport,
			Global global,String reservedseatnums) throws ServiceException {
		// 报到车型和计划车型不一致时候是否修改计划车型及对应票价
		dispatchServiceDao.getEntityManager().flush();
		if ("1".equals(parameterService.findParamValue("9050", global
				.getOrganization().getId()))) {
			int flag = 0;// 定义一个标识，座位图只保存一遍
			int oneflag = 0;
			int seatk=0;//表示之前是一种座位类型，当前报到车是两种，取座位号
			int difseatno = 0 ;//表示两种座位类型完全不同
			// boolean seattypeflag = true;//定义个标识，对于有相同座位类型进行报班的问题
			List<Scheduleseats> totalscheduleseats = null;
			// 先通过车辆报到表找到报到车辆信息
			Vehicle vehicle = (Vehicle) dispatchServiceDao.get(Vehicle.class,
					vehiclereport.getVehicleid());

			Schedule schedule = (Schedule) dispatchServiceDao.get(
					Schedule.class, vehiclereport.getScheduleid()); // 班次
			Long schedulePlanceId = vehiclereport.getScheduleplanid();// 班次计划ID
			// 得到要更新的班次车辆人员计划
			Schedulevehiclepeopleplan schedulevehiclepeopleplan = dispatchServiceDao
					.getSchedulevehiclepeopleplanList(schedulePlanceId);
			// 得到要更新的执行票价
			List<Ticketprice> ticketpricelist = dispatchServiceDao.getSchTicketPriceList(schedulePlanceId);
			// 新定义一个list，用来存放更新后的执行票价list
			List<Ticketprice> finalticketpricelist = new ArrayList<Ticketprice>();
			
			//定义一个Map 用来对应ticketprice和组成项
			Map pricetoitems = new HashMap<String,List>();
			
			//此段代码用来重新创建执行票价和创建票价组成项的对象
			for (int i = 0; i < ticketpricelist.size(); i++) {
				Ticketprice tp = ticketpricelist.get(i);
				List<Ticketpriceitem> ticketpriceitemlist = tp.getTicketpriceitemlist();
				List<Ticketpriceitem> ticketpriceitemlist_new = new ArrayList<Ticketpriceitem>();
				for (Ticketpriceitem ticketpriceitem : ticketpriceitemlist) {
					Ticketpriceitem tpitem = createTicketpriceitem(ticketpriceitem);
					ticketpriceitemlist_new.add(tpitem);
				}
				Ticketprice ticketprice = createNewTicketprice(tp, null);
				finalticketpricelist.add(ticketprice);
				//由于票价组成项都是相同的，取最后一次tickeprice记录的票价组成项保存到finalticketpriceitemlist
				pricetoitems.put(ticketprice.getScheduleplanid()+ticketprice.getReachstationid(), ticketpriceitemlist_new);
			}

			// 根据报到车辆得到报到车辆的座位类型，车型，硬调票价
			List handpricelist = dispatchServiceDao.findvehicleprice(schedule,vehiclereport);
			if (handpricelist.size() == 0) // 如果报到的车辆没有设置应调票价则不进行更新
				return false;
			// 判断当前报到的计划车辆座位类型大于计划车辆的作为类型，则对计划车辆座位类型的list进行处理，添加到相应个数到报到座位类型个数
			while (handpricelist.size() > finalticketpricelist.size()) {
				for (int i = 0; i < ticketpricelist.size(); i++) {
					Ticketprice ticketPricetem = ticketpricelist.get(i);

					Ticketprice ticketprice = createNewTicketprice(ticketPricetem, null);
					finalticketpricelist.add(ticketprice);
				}
			}
			/*
		    for (Ticketprice tp : ticketpricelist) {
				dispatchServiceDao.delete(tp);
			}
			dispatchServiceDao.getEntityManager().flush();
			ticketpricelist.clear();*/
			dispatchServiceDao.deleteTicketprices(schedulePlanceId);

			
			// 查询出之前班次座位状态记录
			Scheduleplan splan = dispatchServiceDao.findScheduleseats(schedulePlanceId);
			List<Scheduleseats> scheduleseatlist = null;
			if (splan==null)
			{
				return false;
			}
			else
			{
				scheduleseatlist = splan.getScheduleseatslist();
			}
			//相当于创建一个新的list,之前list用来删除数据库对象，此对象用来暂时保存
			sortIntMethod(scheduleseatlist);
			List<Scheduleseats> finalscheduleseatlist = new ArrayList<Scheduleseats>();

			/**
			 * 此段代码用来处理报班车辆座位数如果小于计划车辆座位数，先把之前班次座位进行处理 即相当于处理座位图
			 */

			Map<String, Object> handpriceMapFirst = (Map<String, Object>) handpricelist.get(0);
			
			finalscheduleseatlist.addAll(scheduleseatlist);
			
			int seatnums = Integer.parseInt(handpriceMapFirst.get("seatnum").toString());
			//当新报道车辆的座位数小于原来座位数，要把执行多余座位数进行删除
			Iterator it = scheduleseatlist.iterator();
			while (it.hasNext()) {
				Scheduleseats schseat = (Scheduleseats) it.next();
				if (schseat.getSeatno() > seatnums) {
					dispatchServiceDao.getEntityManager().remove(schseat);
					it.remove();
				}else//班次座位全部从库里删除
				{
					dispatchServiceDao.delete(schseat);
					it.remove();
				}

			}
			dispatchServiceDao.merge(splan);//删除班次座位对象
			dispatchServiceDao.getEntityManager().flush();
			
			/**
			 * end
			 */
			/**
			 * handprice记录更新到ticketprice scheduleseats座位图状态进行更新
			 */
			if (handpricelist != null && handpricelist.size() > 0) {
				/**
				 * map,map1用来取对应到达站， 因为同一班次座位图更新的话只用按照其中的一个到达站进行更新
				 */
				Map<String, Object> map = null;
//				Map<String, Object> map11 = null;
				//用来保存座位图，用来最后做处理用
				totalscheduleseats= new ArrayList<Scheduleseats>();
				//定义一个list用来为中途站的可售数获取数据使用
				List<Ticketprice> Stopsoldnumlist = new ArrayList<Ticketprice>();
				
				//先查询出硬调票价list，准备去更新到ticketprice表中
				for (int i = 0; i < handpricelist.size(); i++) {
					map = (Map<String, Object>) handpricelist.get(i);
				/*	long reachstationidLast = 0L;
					if (i > 0) {
						map11 = (Map<String, Object>) handpricelist.get(i - 1);
						reachstationidLast = Long.parseLong(map11.get("reachstationid").toString());
					}*/
					long reachstationid = Long.parseLong(map.get("reachstationid").toString());
//					if (reachstationidLast != reachstationid&& reachstationidLast > 0)
//						flag = false;
					//准备好的ticketpricelist记录要进行更新
					for (Ticketprice ticketprice : finalticketpricelist) {
						// 保存班次座位表信息
						if (ticketprice.getReachstationid() == reachstationid) {
							ticketprice.setFullprice((BigDecimal) map.get("fullprice"));
							ticketprice.setHalfprice((BigDecimal) map.get("halfprice"));
							ticketprice.setStudentprice((BigDecimal) map.get("studentprice"));
							ticketprice.setSeatnum(Short.parseShort(map.get("seatnum").toString()));
							int seatslen = map.get("seats").toString().split(",").length;
							if (seatslen == 1&& ("0".equals(map.get("seats").toString()) ||
									"全部".equals(map.get("seats").toString()))) // 只有一种座位类型
							{
								int soldcount = 0;
								for (Scheduleseats scheduleseats : finalscheduleseatlist) {
									// 判断已售数
									if ("2".equals(scheduleseats.getStatus())) {
										soldcount++;
										// 获取要进行更新的售票记录
										if(oneflag<1)
										{
											Ticketsell ts = getTicketsell(schedulePlanceId,scheduleseats.getSeatno());
											ts.setSeattype(map.get("seattype").toString());
											dispatchServiceDao.merge(ts);
										}
									}
									if(oneflag<1)
									{
										scheduleseats.setSeattype(map.get("seattype").toString());
										scheduleseats.setUpdatetime(new Date());
										totalscheduleseats.add(scheduleseats);
									}
									// dispatchServiceDao.merge(scheduleseats);
								}
								if(oneflag<1)//考虑多个到达站问题
								{
									int scheduleseatAddSize = Integer.parseInt(map.get("seatnum").toString())- totalscheduleseats.size();
									List scheduleseatsReportAddList = new ArrayList();
	
									for (int k = 0; k < scheduleseatAddSize; k++)// 报到车辆座位数多余计划车辆，且只有一种座位类型
									{
										int seatNo = finalscheduleseatlist.size()+ k + 1;
										Scheduleseats scheduleseats = new Scheduleseats();
										scheduleseats.setDepartdate(finalscheduleseatlist.get(0).getDepartdate());
										scheduleseats.setOrgid(finalscheduleseatlist.get(0).getOrgid());
										scheduleseats.setScheduleid(finalscheduleseatlist.get(0).getScheduleid());
										scheduleseats.setScheduleplan(finalscheduleseatlist.get(0).getScheduleplan());
										scheduleseats.setStatus("0");
										scheduleseats.setSeatno((short) seatNo);
										scheduleseats.setSeattype(map.get("seattype").toString());
										scheduleseats.setCreateby(finalscheduleseatlist.get(0).getCreateby());
										scheduleseats.setUpdateby(finalscheduleseatlist.get(0).getUpdateby());
										scheduleseats.setCreatetime(new Date());
										scheduleseats.setUpdatetime(new Date());
										scheduleseatsReportAddList.add(scheduleseats);
										// dispatchServiceDao.merge(scheduleseats);
									}
									/*for(int m=0;m<scheduleseatsReportAddList.size();m++)
									{
										scheduleseatslist.add((Scheduleseats)scheduleseatsReportAddList.get(m));
									}*/
									oneflag++;
									totalscheduleseats.addAll(scheduleseatsReportAddList);
								}
								ticketprice.setSoldeatnum((short) soldcount);
							} else {
								if(oneflag==0)//只有当报到车辆的座位类型是两种的时候
								ticketprice.setSeatnum((short) seatslen);
							}
							
							String[] seatnoarr = map.get("seats").toString().split(",");
							Scheduleseats scheduleseats = null;
							int soldnum = 0;
							int seatnoval = 0;
							// 1。新报道车辆座位数大于计划车辆座位数，直接进行移位（保证座位备注信息一致）
							if((seatnoarr.length > 1||(seatnoarr.length==1&&!"全部".equals(seatnoarr[0])&&Integer.parseInt(seatnoarr[0])!=0)) && flag<2)
							{
								flag++;
								seatnoval = Integer.parseInt(ticketprice.getSeatnos().split(",")[0]);
								soldnum = 0;
								for (int j = Integer.parseInt(seatnoarr[0]); j < Integer.parseInt(seatnoarr[0]) + seatslen; j++) {
									//需要判断未换车报到以前每种座位类型第一个座位号
									if((seatnoval<=finalscheduleseatlist.size()&&seatnoval>0)||(difseatno>0))//两种座位类型都不同都走这个逻辑
									{	
										if(isequalBothtwoseattypes(vehiclereport))//两种座位类型完全不同要考虑，之前是小车每种座位类型都有售票，当前是大车
											{
												if(difseatno<finalscheduleseatlist.size())
												{
													scheduleseats=createScheseats(finalscheduleseatlist.get(difseatno));
													difseatno++;
												}else
												{
													scheduleseats = null;
												}
												
											}
										else{
											scheduleseats= createScheseats(finalscheduleseatlist.get(seatnoval - 1));
										}
									}else if(seatnoval==0&&seatk<finalscheduleseatlist.size())//表示之前报到的车只有一种座位
									{
										scheduleseats = finalscheduleseatlist.get(seatk);
										seatk++;
									}else
									{
										scheduleseats = null;
									}
									if(seatnoval>0)
									{
										seatnoval++;
									}
									//表示当座位类型一致的时候直接放进list
									if(scheduleseats!=null&&scheduleseats.getSeattype().equals(map.get("seattype").toString()))
									{
										//对已售记录进行更新售票记录的座位号
										if("2".equals(scheduleseats.getStatus()))
										{
											Ticketsell ts = getTicketsell(schedulePlanceId,scheduleseats.getSeatno());
											ts.setSeattype(scheduleseats.getSeattype());
											ts.setSeatno((short)j);
											dispatchServiceDao.merge(ts);
											if(seatnoval==0)
												soldnum++;
										}
										
										scheduleseats.setSeatno((short)j);
										
										//scheduleseats创建新对象进行添加
										totalscheduleseats.add(scheduleseats);
									
									}
									else if(scheduleseats==null||!scheduleseats.getSeattype().equals(map.get("seattype").toString()))//表示座位类型不一致，（新报道车辆的相同座位类型多出来的座位数）
									{
											Scheduleseats scheduleseatstem = finalscheduleseatlist.get(0);
											Scheduleseats ss = new Scheduleseats();
											ss.setDepartdate(scheduleseatstem.getDepartdate());
											ss.setOrgid(scheduleseatstem.getOrgid());
											ss.setScheduleid(scheduleseatstem.getScheduleid());
											ss.setScheduleplan(scheduleseatstem.getScheduleplan());
											if(scheduleseats!=null&&scheduleseats.getStatus().equals("2"))
											{
												Ticketsell ts = getTicketsell(schedulePlanceId,scheduleseats.getSeatno());
												ts.setSeattype(scheduleseats.getSeattype());
												ts.setSeatno((short)j);
												dispatchServiceDao.merge(ts);
												
												ss.setStatus("0");//表示两种座位类型，应为未售状态
												ss.setTickettype(null);
												
												//todo 此处需要判断如果是两中座位类型都不一致的则要写成已售状态，如果两种座位类型都一致则为不可售
												if((seatnoval==0)||isequalBothtwoseattypes(vehiclereport))//只有一种座位类型时候才进行统计已售数
												{
													ss.setStatus("2");
													ss.setTickettype(scheduleseats.getTickettype());
													ss.setSeattype(map.get("seattype").toString());
													soldnum++;
												}
											}else
											{
												ss.setStatus("0");
												ss.setTickettype(null);
											}
											ss.setSeattype(map.get("seattype").toString());
											ss.setSeatno((short)j);
											ss.setCreateby(scheduleseatstem.getCreateby());
											ss.setUpdateby(scheduleseatstem.getUpdateby());
											ss.setCreatetime(new Date());
											ss.setUpdatetime(new Date());
										 
											totalscheduleseats.add(ss);
									}
							
								}
							}
							
							ticketprice.setSeatnos(map.get("seats").toString());
							//此处两个if不能合在一起写，因为两种不同座位类型存在0也要计数的时候
							if(isequalBothtwoseattypes(vehiclereport))//两种座位类型都不相同
							{
								ticketprice.setSoldeatnum((short)soldnum);
							}
							if(seatnoval==0)//表示只有一种座位类型或者，此时应该更新已售书
							{
								if(soldnum>0)//当已售数有计算结果则更新
								ticketprice.setSoldeatnum((short)soldnum);
							}
							ticketprice.setSeattype(map.get("seattype").toString());
							Stopsoldnumlist.add(ticketprice);
							if(flag>=2)//用来获取ticketprice中途站的可售数  在判断一次，中途站可售数进行判断
							{	
								for(Ticketprice tprice:Stopsoldnumlist)
								{
									if(ticketprice.getSeattype().equals(tprice.getSeattype())&&tprice.getSoldeatnum()>0)
									{
										ticketprice.setSoldeatnum(tprice.getSoldeatnum());
									}
								}
							}
							Ticketprice tt = dispatchServiceDao.getEntityManager().merge(ticketprice);
							finalticketpricelist.remove(ticketprice);
							List<Ticketpriceitem> tpilist = (List<Ticketpriceitem>)pricetoitems.get(tt.getScheduleplanid()+tt.getReachstationid());
							for (Ticketpriceitem tpi : tpilist) {
								tpi.setTicketprice(tt);
								tpi.setTicketpriceid(tt.getId());
								dispatchServiceDao.merge(tpi);
							}
							break;
						}
					}

				}
				schedulevehiclepeopleplan.setPlanvehiclebrandmodelid(vehicle.getVehiclebrandmodelid());
				schedulevehiclepeopleplan.setPlanvehicletypeid(((BigDecimal) map.get("vehicletypeid")).longValue());
				schedulevehiclepeopleplan.setPlanvehicle(vehicle);
				dispatchServiceDao.merge(schedulevehiclepeopleplan);
			}

			// 单独处理下，如果执行票价存在多余记录进行删除,(如果计划车是多种座位类型，报到车是一种的情况)
			List<Ticketprice> ticketpricelistres = dispatchServiceDao
					.getSchTicketPriceList(schedulePlanceId);
			for (Ticketprice ticketprice : ticketpricelistres) {
				if (ticketprice.getSeatnos().equals("0")|| ticketprice.getSeatnos().equals("全部")) {
					for (Ticketprice ticketprice1 : ticketpricelistres) {
						if (ticketprice.getReachstationid() == ticketprice1.getReachstationid()
								&& !"0".equals(ticketprice1.getSeatnos())
								&& !("全部".equals(ticketprice1.getSeatnos()))) {
							dispatchServiceDao.deleteTicketprice(ticketprice1.getId());
						}
					}
				}
			}
			//单独写一个方法对自动取消留位和非自动取消留位进行处理
			if(totalscheduleseats.size()>0)
			{
				updateSeatReserve(totalscheduleseats);
			}
			updateScheduleSeates(totalscheduleseats,reservedseatnums);

		}
		return true;
	}

	private void saveVehicledriverreport(Vehiclereport vehiclereport, Vehicle reportvehicle, Schedulestatus schedulestatus) {
		if(vdriver!=null){
		Date now=new Date();
		Vehicledriverreport vpd=new Vehicledriverreport();
		vpd.setClassmember(vdriver.getClassmember());
		vpd.setCreateby(vehiclereport.getCreateby());
		vpd.setCreatetime(now);
		vpd.setDdrivinglicenseres(vdriver.getDdrivinglicenseres());
		vpd.setDepartdate(vehiclereport.getDepartdate());
		vpd.setDispatcher(vdriver.getDispatcher());
		vpd.setDqualificationres(vdriver.getDqualificationres());
		vpd.setDrivername(vdriver.getDrivername());
		vpd.setDriversign(vdriver.getDriversign());
		vpd.setDworknores(vdriver.getDworknores());
		vpd.setOrgid(vehiclereport.getReportorgid());
		vpd.setRationseatnum(reportvehicle.getRationseatnum());
		vpd.setReporttime(now);
		vpd.setScheduleid(vehiclereport.getScheduleid());
		vpd.setStewardname(vdriver.getStewardname());
		vpd.setUpdateby(vehiclereport.getCreateby());
		vpd.setUpdatetime(now);
		vpd.setVdriverlicenseres(vdriver.getVdriverlicenseres());
		vpd.setVehicleno(reportvehicle.getVehicleno());
		vpd.setVehiclereportid(vehiclereport.getId());
		vpd.setVnotenum(vdriver.getVnotenum());
		vpd.setVroadnores(vdriver.getVroadnores());
		vpd.setVworknores(vdriver.getVworknores());
		vpd.setIsdeparted(false);
		vpd.setDeparttime(schedulestatus.getDeparttime());
		vpd.setScheduleplanid(vehiclereport.getScheduleplanid());
		if(vehiclereport.getDriver1()!=null){
			vpd.setDriverid(vehiclereport.getDriver1().getId());
		}
		Securitycheck scd=dispatchServiceDao.querySecuritycheck(vehiclereport.getVehicleid(),vehiclereport.getDepartdate());
		if(scd!=null){
			if(vehiclereport.getDriver1()!=null){
				scd.setDriverid(vehiclereport.getDriver1().getId());
				vpd.setDrivername(vehiclereport.getDriver1().getName());
				scd.setUpdatetime(new Date());
				dispatchServiceDao.merge(scd);
			}else{
				if(vehiclereport.getDriver2()!=null){
					scd.setDriverid(vehiclereport.getDriver2().getId());
					scd.setUpdatetime(new Date());
					dispatchServiceDao.merge(scd);
				}
			}
		}
		//
		if(vdriver.getDrivername2()!=null &&vdriver.getDrivername2().length()>1){
//			Date now=new Date();
			Vehicledriverreport vpd2=new Vehicledriverreport();
			vpd2.setClassmember(vdriver.getClassmember());
			vpd2.setCreateby(vehiclereport.getCreateby());
			vpd2.setCreatetime(now);
			vpd2.setDdrivinglicenseres(vdriver.getDdrivinglicenseres2());
			vpd2.setDepartdate(vehiclereport.getDepartdate());
			vpd2.setDispatcher(vdriver.getDispatcher());
			vpd2.setDqualificationres(vdriver.getDqualificationres2());
			vpd2.setDrivername(vdriver.getDrivername2());
			vpd2.setDriversign(vdriver.getDriversign2());
			vpd2.setDworknores(vdriver.getDworknores2());
			vpd2.setOrgid(vehiclereport.getReportorgid());
			vpd2.setRationseatnum(reportvehicle.getRationseatnum());
			vpd2.setReporttime(now);
			vpd2.setScheduleid(vehiclereport.getScheduleid());
			vpd2.setStewardname(vdriver.getStewardname());
			vpd2.setUpdateby(vehiclereport.getCreateby());
			vpd2.setUpdatetime(now);
			vpd2.setIsdeparted(false);
			vpd2.setDeparttime(schedulestatus.getDeparttime());
			vpd2.setScheduleplanid(vehiclereport.getScheduleplanid());
			vpd2.setVdriverlicenseres(vdriver.getVdriverlicenseres());
			vpd2.setVehicleno(reportvehicle.getVehicleno());
			vpd2.setVehiclereportid(vehiclereport.getId());
			vpd2.setVnotenum(vdriver.getVnotenum());
			vpd2.setVroadnores(vdriver.getVroadnores());
			vpd2.setVworknores(vdriver.getVworknores());
			if(vehiclereport.getDriver2()!=null){
				vpd2.setDriverid(vehiclereport.getDriver2().getId());
			}
			dispatchServiceDao.merge(vpd2);
		}
		dispatchServiceDao.merge(vpd);
		}
	}
	
	// 创建票价分项记录
	private Ticketpriceitem createTicketpriceitem(
			Ticketpriceitem ticketpriceitem) {
		Ticketpriceitem tpi = new Ticketpriceitem();
		tpi.setCode(ticketpriceitem.getCode());
		tpi.setCreateby(ticketpriceitem.getCreateby());
		tpi.setCreatetime(new Date());
		tpi.setDepartdate(ticketpriceitem.getDepartdate());
		tpi.setIsautoadjust(ticketpriceitem.isIsautoadjust());
		tpi.setName(ticketpriceitem.getName());
		tpi.setOpertype(ticketpriceitem.getOpertype());
		tpi.setPrice(ticketpriceitem.getPrice());
		tpi.setTicketpriceformulaitemid(ticketpriceitem
				.getTicketpriceformulaitemid());
		tpi.setUpdatetime(new Date());
		tpi.setUpdateby(ticketpriceitem.getUpdateby());
		tpi.setTickettype(ticketpriceitem.getTickettype());

		return tpi;

	}

	/*
	 * qryVehicle方法：<br/> <br/>
	 * 
	 * @param cardno
	 * 
	 * @return
	 * 
	 * @see
	 * cn.nova.bus.dispatch.service.DispatchService#qryVehicle(java.lang.String)
	 * 
	 * @exception
	 */
	@Override
	public List<Map<String, Object>> qryVehicle(String cardno)
			throws ServiceException {
		
		Cardissue cs = dispatchServiceDao.getCardissue(cardno);
		if (cs != null) {
			// 0正常,1已退,2挂失,3作废,4过期 取数据字典 ;
			if (cs.getStatus().equals("2")) {
				// 该IC卡已经挂失，不能报到！
				throw new ServiceException("0237");
			} else if (cs.getStatus().equals("3")) {
				// 该IC卡已经作废，不能报到！
				throw new ServiceException("0238");
			} else if (cs.getStatus().equals("4")) {
				// 该IC卡已经过期，不能报到！
				throw new ServiceException("0239");
			}
		}		
		List<Object> list = dispatchServiceDao.qryVehicle(cardno);
		if (list == null || list.size()==0) {
			// 该IC卡没有对应的车辆信息！
			throw new ServiceException("0233");
		}
		return ListUtil.listToMap(new Object[] { "id", "vehicleno", "seatnum",
				"unitid", "unitname","balanceunitid","balanceunitname", "vehicletypeid", "vehicletypename","isneedfinger",
				"licenseenddate","liabilityinsureenddate","workenddate","roadno","compulsoryinsureenddate","contractenddate"},
				list, new Object[] { Long.class, String.class, Short.class,
						Long.class, String.class,Long.class,String.class, Long.class, String.class, String.class,
						String.class,String.class,String.class,String.class,String.class,String.class});
	}

	/*
	 * checkVehicle方法：<br/> <br/>
	 * 
	 * @param vehcielid
	 * 
	 * @param departdate
	 * 
	 * @return
	 * 
	 * @throws ServiceException
	 * 
	 * @see cn.nova.bus.dispatch.service.DispatchService#checkVehicle(long,
	 * java.util.Date)
	 * 
	 * @exception
	 */
	@Override
	public MethodResult checkVehicle(long vehcielid, Date departdate,long orgid)
			throws ServiceException {
		// MethodResult result = new MethodResult();
		// 返回的-1未检 1合格 0不合格 2是无安检计划无需校验安检,3:24小时内安检合格
		return securitycheckService
				.getVehicleCheckResult(vehcielid, departdate,orgid);
	}

	@Override
	public List<Map<String, Object>> getScheduleplanroute(Date departdate,
			long departstationid, String cardno,String serialnumber) throws ServiceException {
		return ListUtil.listToMap(new Object[] { "id", "routeid", "vehicleno",
				"seatnum","isneedfinger","scheduleid" }, dispatchServiceDao.qryVehicleByCard(cardno,serialnumber),
				new Object[] { Long.class, Long.class, String.class,
						Short.class,boolean.class,String.class });
	}

	@Override
	public List<Map<String, Object>> qryScheduleplan(
			List<PropertyFilter> propertyFilterList,Long vehicleid,boolean isautodispatch) {
		List listscheduleplan = null;
		/**
		 * 若在车辆运营班次设置车辆的可营运班次，则IC卡报班的班次列表信息取车辆营运班次设置的班次信息 
		 * 姜蓥瑞 2015年9月7日15:46:39
		 */		List<PropertyFilter> propertyFilterList_schedule  = new ArrayList<PropertyFilter>();
		 		propertyFilterList_schedule.addAll(propertyFilterList);
				String pluginName = PluginDefiniens.VEHICLEREPORTQRYSCHEDULEPLAN; // 插件名
				Map<String, Object> requestMap = new HashMap<String, Object>();
				requestMap.put("propertyFilterList",propertyFilterList_schedule);// 扩展点中使用到的参数
				requestMap.put("vehicleid", vehicleid);
				try {
					Map<Object, Object> result = PluginFunctionUtil.doPlugin(
							pluginName, requestMap);
					listscheduleplan =  (List) result.get("qryScheduleplan");
				if("1".equals(result.get("isUsePlugin"))){
//				if (list_schedule != null && list_schedule.size()>0){
					//
				} else { 
						//先查班次运行计划
					    listscheduleplan = dispatchServiceDao.qryScheduleplan(propertyFilterList,vehicleid, isautodispatch);  //默认
					    if(listscheduleplan == null || listscheduleplan.size()==0){
					    	//车辆可营运线路\班次
							listscheduleplan = dispatchServiceDao.qryScheduleplanWithRouteconctrl(propertyFilterList, vehicleid,isautodispatch);
							if(listscheduleplan == null || listscheduleplan.size()==0){
								 //车辆营运线路
								 listscheduleplan=dispatchServiceDao.qryScheduleplanWithPlanvehicle(propertyFilterList, vehicleid,isautodispatch);
							}
					    }
					}
				} catch (ServiceException e) {
					e.printStackTrace();
					play.Logger.info("" + e);
				} catch (Exception e) {
					e.printStackTrace();
					play.Logger.info("" + e);
				}


		return ListUtil.listToMap(
				new Object[] { "id", "endstationid", "endstationname", "code",
						"departtime", "seatnum", "soldeatnum", "scheduleid",
						"departdate", "routedistance", "driverfingernum",
						"driver1", "driver2", "steward1", "unitname","vehicleseat" },
				listscheduleplan, new Object[] { Long.class, Long.class,
						String.class, String.class, String.class, Short.class,
						Short.class, Long.class, Date.class, Integer.class,
						Integer.class, Long.class, Long.class, Long.class,
						String.class,Short.class });
	}

	@SuppressWarnings("unchecked")
	private void changeSeats_(Scheduleplan scheduleplan, short seatnum,
			long createby) throws ServiceException {
		// short seatnum = reportvehicle.getSeatnum();

		// 若是非流水班次
		if (!scheduleplan.getIslinework()) {

			// 报到车辆座位数小于该班次已售座位数,不许报到
			//if (seatnum < scheduleplan.getSoldeatnum()) {
			//	throw new ServiceException("0069");
			//}

			// 报到车辆座位数小于班次座位数，是否允许报到
			/*String allowreport = parameterService.findParamValue("2011",
					scheduleplan.getOrgid());
			if ("0".equals(allowreport) && seatnum < scheduleplan.getSeatnum()) {
				throw new ServiceException("0068");
			}
			if (seatnum < scheduleplan.getSoldeatnum()
					+ scheduleplan.getAutocancelreserveseatnum()
					+ scheduleplan.getUnautocancelreserveseatnum()
					+ scheduleplan.getFixedreserveseatnum()) {
				// 报到车辆的座位数小于该班次非空座位数，不允许报到！
				throw new ServiceException("0379");
			}*/
			// 报到车辆座位数小于班次座位数
			if (seatnum >= scheduleplan.getSoldeatnum()
					&& seatnum <= scheduleplan.getSeatnum()) {
				List<Scheduleseats> sst = scheduleplan.getScheduleseatslist();
				int fixseat = 0;
				int delfixseat = 0;
				int unautoseat = 0;
				int autoseat = 0;
				List<Short> soldseats = new ArrayList<Short>();
				List<Short> autoseats = new ArrayList<Short>();
				List<Short> unautoseats = new ArrayList<Short>();
				//遍历班次座位，将班次座位数改为报到车辆的座位数
				Iterator<Scheduleseats> it = sst.iterator();
				while (it.hasNext()) {
					Scheduleseats ss = it.next();
					if (ss.getSeatno() > seatnum) {
						if (ss.getStatus().equals("2")) {
							/**
							 * 若车站的座位数大于车辆报到的实际座位个数
							 * 并且其中有已售的座位 则不允许报到
							 * 姜蓥瑞2015年8月19日11:15:51
							 */
							throw new ServiceException("6117");
//							soldseats.add(ss.getSeatno());
						} else if (ss.getStatus().equals("3")) { 
							fixseat++;
						} else if (ss.getStatus().equals("4")) {
							autoseat++;
							autoseats.add(ss.getSeatno());
						} else if (ss.getStatus().equals("5")) {
							unautoseat++;
							unautoseats.add(ss.getSeatno());
						}
						dispatchServiceDao.delete(ss);
						it.remove();
					}
				}
				
				boolean isqryseat = false;
//				for (Short seatno : soldseats) {  //姜蓥瑞注释 2015年8月19日11:12:12
//					isqryseat = false;
//					Ticketsell ts = ticketService.getTicket(
//							scheduleplan.getId(), seatno);
//					// 改到空座上
//					for (Scheduleseats aa : sst) {
//						if (aa.getSeatno() <= seatnum
//								&& aa.getStatus().equals("0")) {
//							// 找到空座
//							isqryseat = true;
//							ts.setSeatno(aa.getSeatno());
//							ts.setUpdateby(createby);
//							ts.setUpdatetime(new Date());
//							aa.setStatus("2");
//							aa.setTickettype(ts.getTickettype());
//							aa.setUpdateby(createby);
//							aa.setUpdatetime(new Date());
//							break;
//						}
//					}
//					if (!isqryseat) {
//						// 报到车辆未找到可改签的空座，不允许报到！
//						throw new ServiceException("0375");
//					}
//				}

				
					for (int i = 0; i < fixseat; i++) {
						isqryseat = false;
						// 改到空座上
						for (Scheduleseats aa : sst) {
							if (aa.getSeatno() <= seatnum
									&& aa.getStatus().equals("0")) {
								// 找到空座
								isqryseat = true;
								aa.setStatus("3");
								aa.setUpdateby(createby);
								aa.setUpdatetime(new Date());
								break;
							}
						}
						if (!isqryseat) {
							delfixseat++;
							// 报到车辆未找到可固定留位的空座，不允许报到！
							// throw new ServiceException("0376");
						}
					}
//				}
				// for (int i = 0; i < autoseat; i++) {
				for (short seatno : autoseats) {
					isqryseat = false;
					// 改到空座上
					for (Scheduleseats aa : sst) {
						if (aa.getSeatno() <= seatnum
								&& aa.getStatus().equals("0")) {
							Seatreserve seatreserve = seatreserveService
									.getSeatreserve(scheduleplan.getId(),
											scheduleplan.getDepartdate(),
											seatno);
							if (seatreserve != null) {
								seatreserve.setSeatno(aa.getSeatno());
								seatreserve.setUpdateby(createby);
								seatreserve.setUpdatetime(new Date());
								dispatchServiceDao.merge(seatreserve);
							}
							// 找到空座
							isqryseat = true;
							aa.setStatus("4");
							aa.setUpdateby(createby);
							aa.setUpdatetime(new Date());
							break;
						}
					}
					if (!isqryseat) {
						// 报到车辆未找到自动取消留位的空座，不允许报到！
						throw new ServiceException("0377");
					}
				}
				
				//增加参数控制：将固定座位修改到空座上还是直接截断  0、不截断，1、截断。  李电志  2015年6月9日 09:47:40 
				String isTrunc = parameterService.findParamValue(ParamterConst.Param_3035,scheduleplan.getOrgid());
				if (ParamterConst.COMMON_FLAG.FALG_YES.equals(isTrunc)) {//截断    修改自动取消留位数
					scheduleplan.setUnautocancelreserveseatnum((short)(scheduleplan.getUnautocancelreserveseatnum() - unautoseat));
					//更新班次计划表
					dispatchServiceDao.merge(scheduleplan);
				}
				// for (int i = 0; i < unautoseat; i++) {
				if (ParamterConst.COMMON_FLAG.FALG_NO.equals(isTrunc)) {//0的值  不截断
					for (short seatno : unautoseats) {
						isqryseat = false;
						// 改到空座上
						for (Scheduleseats aa : sst) {
							if (aa.getSeatno() <= seatnum
									&& aa.getStatus().equals("0")) {
								Seatreserve seatreserve = seatreserveService
										.getSeatreserve(scheduleplan.getId(),
												scheduleplan.getDepartdate(),
												seatno);
								if (seatreserve != null) {
									seatreserve.setSeatno(aa.getSeatno());
									seatreserve.setUpdateby(createby);
									seatreserve.setUpdatetime(new Date());
									dispatchServiceDao.merge(seatreserve);
								}
								// 找到空座
								isqryseat = true;
								aa.setStatus("5");
								aa.setUpdateby(createby);
								aa.setUpdatetime(new Date());
								break;
							}
						}
						if (!isqryseat) {
							// 报到车辆未找到不自动取消留位的空座，不允许报到！
							throw new ServiceException("0378");
						}
					}
				}
				
				if (delfixseat > 0) {
					scheduleplan.setFixedreserveseatnum((short) (scheduleplan
							.getFixedreserveseatnum() - delfixseat));
				}
				/*
				 * if (unautoseat > 0) { scheduleplan
				 * .setUnautocancelreserveseatnum((short) (scheduleplan
				 * .getUnautocancelreserveseatnum() - unautoseat)); } if
				 * (autoseat > 0) { scheduleplan
				 * .setAutocancelreserveseatnum((short) (scheduleplan
				 * .getAutocancelreserveseatnum() - autoseat)); }
				 */
				List<Ticketprice> tps = scheduleplan.getTicketpricelist();
				for (Ticketprice tp : tps) {
					if (ParamterConst.COMMON_FLAG.FALG_YES.equals(isTrunc)) {//截断后面的留位数  修改执行票价表中的非自动取消留位数  李电志 2015年7月4日 15:25:18
						tp.setUnautocancelreserveseatnum((short) (tp.getUnautocancelreserveseatnum() - unautoseat));
					}
					if (delfixseat > 0) {
						tp.setFixedreserveseatnum((short) (tp
								.getFixedreserveseatnum() - delfixseat));
					}
					/*
					 * if (unautoseat > 0) {
					 * tp.setUnautocancelreserveseatnum((short) (tp
					 * .getUnautocancelreserveseatnum() - unautoseat)); } if
					 * (autoseat > 0) { tp.setAutocancelreserveseatnum((short)
					 * (tp .getAutocancelreserveseatnum() - autoseat)); }
					 */
					if (tp.getSeatnos().equals("0")) {
						if (tp.getSeatnum() > seatnum) {
							tp.setSeatnum(seatnum);
							tp.setUpdateby(createby);
							tp.setUpdatetime(new Date());
							dispatchServiceDao.merge(tp);
						}
					} else {
						String curseatnos = "";
						String seatnos = tp.getSeatnos();
						String[] seats = seatnos.split(",");
						if("全部".equals(tp.getSeatnos())){
							for (int i = 1; i <= seatnum; i++) {
								curseatnos = curseatnos + "," + i;
							}
						}else{
						for (int i = 0; i < seats.length; i++) {
							short seat = new Short(seats[i]);
							if (seat <= seatnum) {
								curseatnos = curseatnos + "," + seats[i];
							}
						}
						}
						curseatnos = curseatnos.substring(1,
								curseatnos.length());
						if (tp.getSeatnum() > seatnum) {
							tp.setSeatnum(seatnum);
						}
						tp.setSeatnos(curseatnos);
						tp.setUpdateby(createby);
						tp.setUpdatetime(new Date());
						dispatchServiceDao.merge(tp);
					}
				}
				for (Ticketprice tp : tps) {
					short curseatnum = 0;
					for (Scheduleseats ss : sst) {
						if (ss.getSeattype().equals(tp.getSeattype())) {
							curseatnum++;
						}
					}
					if(curseatnum==0){
						tp.setSeatnum(seatnum);
					}else{
						tp.setSeatnum(curseatnum);
					}
					tp.setUpdateby(createby);
					tp.setUpdatetime(new Date());
				}
				scheduleplan.setSeatnum(seatnum);
				scheduleplan.setUpdateby(createby);
				scheduleplan.setUpdatetime(new Date());
				dispatchServiceDao.merge(scheduleplan);

			}
			// 若报到车辆座位数大于班次座位数，则改变班次座位数
			else if (seatnum > scheduleplan.getSeatnum()) {
				short seatno = (short) (scheduleplan.getSeatnum() + 1);
				String seattype = "0";
				List<Ticketprice> tps = scheduleplan.getTicketpricelist();
				if (tps != null && tps.size() > 0) {
					seattype = tps.get(0).getSeattype();
				}
				int morenum = seatnum - scheduleplan.getSeatnum();
				String seatnos = "";
				for (int i = seatno; i <= seatnum; i++) {
					seatnos = seatnos + "," + i;
					short _seatno=(short) i;
					if(!dispatchServiceDao.isExistScheduleseats(scheduleplan.getId(),_seatno)){
						Scheduleseats ss = new Scheduleseats();
						ss.setCreateby(createby);
						ss.setCreatetime(new Date());
						ss.setDepartdate(scheduleplan.getDepartdate());
						ss.setOrgid(scheduleplan.getOrgid());
						ss.setScheduleid(scheduleplan.getScheduleid());
						ss.setScheduleplan(scheduleplan);
						ss.setSeatno((short) i);
						ss.setSeattype(seattype);
						ss.setStatus("0");// 空座
						ss.setUpdateby(createby);
						ss.setUpdatetime(new Date());
						dispatchServiceDao.getEntityManager().merge(ss);
					}
				}

				for (Ticketprice tp : tps) {
					if (tp.getSeattype().equals(seattype)) {
						tp.setSeatnum((short) (tp.getSeatnum() + morenum));//票价中座位数应该更新为原座位数+报到车辆多出来的座位数，而不应更新为报到车辆座位数
//						tp.setSeatnum(seatnum);
						//修改ticketprice表中seatnos记录为 :'全部,16,16,16,...'错误格式问题
						if (!tp.getSeatnos().equals("0")&&!tp.getSeatnos().equals("全部")) {
							tp.setSeatnos(tp.getSeatnos() + seatnos);
						}
						tp.setUpdateby(createby);
						tp.setUpdatetime(new Date());
						dispatchServiceDao.getEntityManager().merge(tp);
					}
				}
				scheduleplan.setSeatnum(seatnum);
				scheduleplan.setUpdateby(createby);
				scheduleplan.setUpdatetime(new Date());
				dispatchServiceDao.merge(scheduleplan);
			}
		}
	}
	@SuppressWarnings("unchecked")
	private void changeSeats(Scheduleplan scheduleplan, short seatnum,
			long createby) throws ServiceException {
		// short seatnum = reportvehicle.getSeatnum();
		// 若是非流水班次
		if (!scheduleplan.getIslinework()) {

			// 报到车辆座位数小于该班次已售座位数,不许报到
			//if (seatnum < scheduleplan.getSoldeatnum()) {
			//	throw new ServiceException("0069");
			//}

			// 报到车辆座位数小于班次座位数，是否允许报到
			String allowreport = parameterService.findParamValue("2011",
					scheduleplan.getOrgid());
			if ("0".equals(allowreport) && seatnum < scheduleplan.getSeatnum()) {
				throw new ServiceException("0068");
			}
//			if (seatnum < scheduleplan.getSoldeatnum()
//					+ scheduleplan.getAutocancelreserveseatnum()
//					+ scheduleplan.getUnautocancelreserveseatnum()
//					+ scheduleplan.getFixedreserveseatnum()) {
//				// 报到车辆的座位数小于该班次非空座位数，不允许报到！
//				throw new ServiceException("0379");
//			}
			// 报到车辆座位数小于班次座位数
			if (seatnum >= scheduleplan.getSoldeatnum()
					&& seatnum <= scheduleplan.getSeatnum()) {
				List<Scheduleseats> sst = scheduleplan.getScheduleseatslist();
				int fixseat = 0;
				int delfixseat = 0;
				int unautoseat = 0;
				int autoseat = 0;
				int vacantseat = 0;//空座
				List<Short> soldseats = new ArrayList<Short>();
				List<Short> autoseats = new ArrayList<Short>();
				List<Short> unautoseats = new ArrayList<Short>();
				//遍历班次座位，将班次座位数改为报到车辆的座位数
				Iterator<Scheduleseats> it = sst.iterator();
				while (it.hasNext()) {
					Scheduleseats ss = it.next();
					if (ss.getSeatno() > seatnum) {
						if (ss.getStatus().equals("0")) {
							vacantseat++;
						}else if (ss.getStatus().equals("2")) {
							/**
							 * 若车站的座位数大于车辆报到的实际座位个数
							 * 并且其中有已售的座位 则不允许报到
							 * 姜蓥瑞2015年8月19日11:15:51
							 */
							throw new ServiceException("6117");
//							soldseats.add(ss.getSeatno());
						} else if (ss.getStatus().equals("3")) { 
							fixseat++;
						} else if (ss.getStatus().equals("4")) {
							autoseat++;
							autoseats.add(ss.getSeatno());
						} else if (ss.getStatus().equals("5")) {
							unautoseat++;
							unautoseats.add(ss.getSeatno());
						}
						dispatchServiceDao.delete(ss);
						it.remove();
					}
				}
				
				boolean isqryseat = false;
//				for (Short seatno : soldseats) {  //姜蓥瑞注释 2015年8月19日11:12:12
//					isqryseat = false;
//					Ticketsell ts = ticketService.getTicket(
//							scheduleplan.getId(), seatno);
//					// 改到空座上
//					for (Scheduleseats aa : sst) {
//						if (aa.getSeatno() <= seatnum
//								&& aa.getStatus().equals("0")) {
//							// 找到空座
//							isqryseat = true;
//							ts.setSeatno(aa.getSeatno());
//							ts.setUpdateby(createby);
//							ts.setUpdatetime(new Date());
//							aa.setStatus("2");
//							aa.setTickettype(ts.getTickettype());
//							aa.setUpdateby(createby);
//							aa.setUpdatetime(new Date());
//							break;
//						}
//					}
//					if (!isqryseat) {
//						// 报到车辆未找到可改签的空座，不允许报到！
//						throw new ServiceException("0375");
//					}
//				}

				
					for (int i = 0; i < fixseat; i++) {
						isqryseat = false;
						// 改到空座上
						for (Scheduleseats aa : sst) {
							if (aa.getSeatno() <= seatnum
									&& aa.getStatus().equals("0")) {
								// 找到空座
								isqryseat = true;
								aa.setStatus("3");
								aa.setUpdateby(createby);
								aa.setUpdatetime(new Date());
								break;
							}
						}
						if (!isqryseat) {
							delfixseat++;
							// 报到车辆未找到可固定留位的空座，不允许报到！
							// throw new ServiceException("0376");
						}
					}
//				}
				// for (int i = 0; i < autoseat; i++) {
				for (short seatno : autoseats) {
					isqryseat = false;
					// 改到空座上
					for (Scheduleseats aa : sst) {
						if (aa.getSeatno() <= seatnum
								&& aa.getStatus().equals("0")) {
							Seatreserve seatreserve = seatreserveService
									.getSeatreserve(scheduleplan.getId(),
											scheduleplan.getDepartdate(),
											seatno);
							if (seatreserve != null) {
								seatreserve.setSeatno(aa.getSeatno());
								seatreserve.setUpdateby(createby);
								seatreserve.setUpdatetime(new Date());
								dispatchServiceDao.merge(seatreserve);
							}
							// 找到空座
							isqryseat = true;
							aa.setStatus("4");
							aa.setUpdateby(createby);
							aa.setUpdatetime(new Date());
							break;
						}
					}
					if (!isqryseat) {
						// 报到车辆未找到自动取消留位的空座，不允许报到！
						throw new ServiceException("0377");
					}
				}
				
				//增加参数控制：将固定座位修改到空座上还是直接截断  0、不截断，1、截断。  李电志  2015年6月9日 09:47:40 
				String isTrunc = parameterService.findParamValue(ParamterConst.Param_3035,scheduleplan.getOrgid());
				if (ParamterConst.COMMON_FLAG.FALG_YES.equals(isTrunc)) {//截断    修改自动取消留位数
					//移动的个数
					int mvnum =0;
					//剩余空座需要保留，移动到前面的留位中
					for (int i = 0; i < vacantseat; i++){
						isqryseat = false;
						// 改到不自动取消留位上
						for (Scheduleseats aa : sst) {
							if (aa.getSeatno() <= seatnum
									&& aa.getStatus().equals("5")) {
								mvnum +=1;
								// 修改为空座
								isqryseat = true;
								aa.setStatus("0");
								aa.setUpdateby(createby);
								aa.setUpdatetime(new Date());
								//删除留位记录
								Seatreserve seatreserve = seatreserveService
										.getSeatreserve(scheduleplan.getId(),
												scheduleplan.getDepartdate(),
												aa.getSeatno());
								if(seatreserve==null){
									continue;
								}
								dispatchServiceDao.delete(seatreserve);
								break;
							}
						}
					}
					//删除seatnum之后的所有留位信息
					List<Seatreserve> srlist = dispatchServiceDao
							.getSeatreserves(scheduleplan.getId(),
									scheduleplan.getDepartdate(),
									seatnum);
					for (Seatreserve seatreserve : srlist) {
						dispatchServiceDao.delete(seatreserve);
					}
					unautoseat = unautoseat+mvnum;
					scheduleplan.setUnautocancelreserveseatnum((short)(scheduleplan.getUnautocancelreserveseatnum() - unautoseat));
					//更新班次计划表
					dispatchServiceDao.merge(scheduleplan);
				}
				// for (int i = 0; i < unautoseat; i++) {
				if (ParamterConst.COMMON_FLAG.FALG_NO.equals(isTrunc)) {//0的值  不截断
					for (short seatno : unautoseats) {
						isqryseat = false;
						// 改到空座上
						for (Scheduleseats aa : sst) {
							if (aa.getSeatno() <= seatnum
									&& aa.getStatus().equals("0")) {
								Seatreserve seatreserve = seatreserveService
										.getSeatreserve(scheduleplan.getId(),
												scheduleplan.getDepartdate(),
												seatno);
								if (seatreserve != null) {
									seatreserve.setSeatno(aa.getSeatno());
									seatreserve.setUpdateby(createby);
									seatreserve.setUpdatetime(new Date());
									dispatchServiceDao.merge(seatreserve);
								}
								// 找到空座
								isqryseat = true;
								aa.setStatus("5");
								aa.setUpdateby(createby);
								aa.setUpdatetime(new Date());
								break;
							}
						}
						if (!isqryseat) {
							// 报到车辆未找到不自动取消留位的空座，不允许报到！
							throw new ServiceException("0378");
						}
					}
				}
				
				if (delfixseat > 0) {
					scheduleplan.setFixedreserveseatnum((short) (scheduleplan
							.getFixedreserveseatnum() - delfixseat));
				}
				/*
				 * if (unautoseat > 0) { scheduleplan
				 * .setUnautocancelreserveseatnum((short) (scheduleplan
				 * .getUnautocancelreserveseatnum() - unautoseat)); } if
				 * (autoseat > 0) { scheduleplan
				 * .setAutocancelreserveseatnum((short) (scheduleplan
				 * .getAutocancelreserveseatnum() - autoseat)); }
				 */
				List<Ticketprice> tps = scheduleplan.getTicketpricelist();
				for (Ticketprice tp : tps) {
					if (ParamterConst.COMMON_FLAG.FALG_YES.equals(isTrunc)) {//截断后面的留位数  修改执行票价表中的非自动取消留位数  李电志 2015年7月4日 15:25:18
						tp.setUnautocancelreserveseatnum((short) (tp.getUnautocancelreserveseatnum() - unautoseat));
					}
					if (delfixseat > 0) {
						tp.setFixedreserveseatnum((short) (tp
								.getFixedreserveseatnum() - delfixseat));
					}
					/*
					 * if (unautoseat > 0) {
					 * tp.setUnautocancelreserveseatnum((short) (tp
					 * .getUnautocancelreserveseatnum() - unautoseat)); } if
					 * (autoseat > 0) { tp.setAutocancelreserveseatnum((short)
					 * (tp .getAutocancelreserveseatnum() - autoseat)); }
					 */
					if (tp.getSeatnos().equals("0")) {
						if (tp.getSeatnum() > seatnum) {
							tp.setSeatnum(seatnum);
							tp.setUpdateby(createby);
							tp.setUpdatetime(new Date());
							dispatchServiceDao.merge(tp);
						}
					} else {
						String curseatnos = "";
						String seatnos = tp.getSeatnos();
						String[] seats = seatnos.split(",");
						if("全部".equals(tp.getSeatnos())){
							for (int i = 1; i <= seatnum; i++) {
								curseatnos = curseatnos + "," + i;
							}
						}else{
						for (int i = 0; i < seats.length; i++) {
							short seat = new Short(seats[i]);
							if (seat <= seatnum) {
								curseatnos = curseatnos + "," + seats[i];
							}
						}
						}
						curseatnos = curseatnos.substring(1,
								curseatnos.length());
						if (tp.getSeatnum() > seatnum) {
							tp.setSeatnum(seatnum);
						}
						tp.setSeatnos(curseatnos);
						tp.setUpdateby(createby);
						tp.setUpdatetime(new Date());
						dispatchServiceDao.merge(tp);
					}
				}
				for (Ticketprice tp : tps) {
					short curseatnum = 0;
					for (Scheduleseats ss : sst) {
						if (ss.getSeattype().equals(tp.getSeattype())) {
							curseatnum++;
						}
					}
					if(curseatnum==0){
						tp.setSeatnum(seatnum);
					}else{
						tp.setSeatnum(curseatnum);
					}
					tp.setUpdateby(createby);
					tp.setUpdatetime(new Date());
				}
				scheduleplan.setSeatnum(seatnum);
				scheduleplan.setUpdateby(createby);
				scheduleplan.setUpdatetime(new Date());
				dispatchServiceDao.merge(scheduleplan);

			}
			// 若报到车辆座位数大于班次座位数，则改变班次座位数
			else if (seatnum > scheduleplan.getSeatnum()) {
				short seatno = (short) (scheduleplan.getSeatnum() + 1);
				String seattype = "0";
				List<Ticketprice> tps = scheduleplan.getTicketpricelist();
				if (tps != null && tps.size() > 0) {
					seattype = tps.get(0).getSeattype();
				}
				int morenum = seatnum - scheduleplan.getSeatnum();
				String seatnos = "";
				for (int i = seatno; i <= seatnum; i++) {
					seatnos = seatnos + "," + i;
					short _seatno=(short) i;
					if(!dispatchServiceDao.isExistScheduleseats(scheduleplan.getId(),_seatno)){
						Scheduleseats ss = new Scheduleseats();
						ss.setCreateby(createby);
						ss.setCreatetime(new Date());
						ss.setDepartdate(scheduleplan.getDepartdate());
						ss.setOrgid(scheduleplan.getOrgid());
						ss.setScheduleid(scheduleplan.getScheduleid());
						ss.setScheduleplan(scheduleplan);
						ss.setSeatno((short) i);
						ss.setSeattype(seattype);
						ss.setStatus("0");// 空座
						ss.setUpdateby(createby);
						ss.setUpdatetime(new Date());
						dispatchServiceDao.getEntityManager().merge(ss);
					}
				}

				for (Ticketprice tp : tps) {
					if (tp.getSeattype().equals(seattype)) {
						tp.setSeatnum((short) (tp.getSeatnum() + morenum));//票价中座位数应该更新为原座位数+报到车辆多出来的座位数，而不应更新为报到车辆座位数
//						tp.setSeatnum(seatnum);
						//修改ticketprice表中seatnos记录为 :'全部,16,16,16,...'错误格式问题
						if (!tp.getSeatnos().equals("0")&&!tp.getSeatnos().equals("全部")) {
							tp.setSeatnos(tp.getSeatnos() + seatnos);
						}
						tp.setUpdateby(createby);
						tp.setUpdatetime(new Date());
						dispatchServiceDao.getEntityManager().merge(tp);
					}
				}
				scheduleplan.setSeatnum(seatnum);
				scheduleplan.setUpdateby(createby);
				scheduleplan.setUpdatetime(new Date());
				dispatchServiceDao.merge(scheduleplan);
			}
		}
	}
	// 换车报到
	@SuppressWarnings("unchecked")
	@Override
	public boolean changeReportVehicle(Vehiclereport vehiclereport,
			long departstationid, String ip, Global global) throws ServiceException {
		Vehiclereport oldreport = (Vehiclereport) dispatchServiceDao.get(
				Vehiclereport.class, vehiclereport.getId());
		if (oldreport.isIsdeparted()) {
			// 该班次已经发班，不允许换车报到
			throw new ServiceException("0339");
		}
		
		Vehicle oldvehicle = (Vehicle) dispatchServiceDao.get(Vehicle.class,
				oldreport.getVehicleid());
		Scheduleplan scheduleplan = (Scheduleplan) dispatchServiceDao.get(
				Scheduleplan.class, vehiclereport.getScheduleplanid());
		Vehicle newvehicle = (Vehicle) dispatchServiceDao.get(Vehicle.class,
				vehiclereport.getVehicleid());
		vehiclereport.setScheduleid(scheduleplan.getScheduleid());
		List<Schedulestatus> sslist = scheduleplan.getSchedulestatuslist();
		String departtime = scheduleplan.getStarttime();
		Schedulestatus ss = sslist.get(0);
		departtime = ss.getDeparttime();
		if (ss.getIsdeparted()) {
			// 该班次已经发班，不允许换车报到
			throw new ServiceException("0339");
		}
		Schedule schedule = (Schedule) dispatchServiceDao.get(Schedule.class,
				scheduleplan.getScheduleid());
		
		//查询上次报到的非流水班发车时间     或者        流水班上次报到时间
		String checkreporttimeresult = checkreporttime(newvehicle.getId(),scheduleplan,departstationid);
		if(checkreporttimeresult!=null){
			//您本日已经报到其它班次，且发车时间距离本班次发车时间不足?分钟
			throw new BusinessException(checkreporttimeresult);
		}
		
		
		
		//十堰：vehicle表的isneedcheck字段 是否开启报班时证件审核
		if (newvehicle.getIsneedcheck()==true){
			//证件审查扩展点
			ActionNode actionNode = Appvar.routes.get("VEHICLEREPORTLICENSECHECKEXPORT");// 由插件名,获得插件
			//查询是否使用了certificatecheck证件审核插件；从Appvar.routes中获取扩张点插件名、插件类、插件方法
			PluginFunction.DoPlugin(vehiclereport, global,actionNode);
		}
			
		//判断车辆是否只允许车辆报到在已指定的线路中
		String ismastbe = parameterService.findParamValue(ParamterConst.Param_2021,oldreport.getOrgid());
		if(ismastbe.equals(ParamterConst.COMMON_FLAG.FALG_YES)){	
			//如果是抛出错误:该车辆只能报到车辆指定的线路：+线路名称
			isOnlyReportRoute(newvehicle.getId(),schedule.getId());		
		}
		// 已售座位数大于车辆的乘客座位数且小于该车辆核定座位数,是否允许报到
		String allowreport3 = parameterService
				.findParamValue(ParamterConst.Param_2022, oldreport.getId());
		if (!scheduleplan.getIslinework()) {			
			if (newvehicle.getSeatnum() < scheduleplan.getSoldeatnum()) {
				if(allowreport3.equals(ParamterConst.COMMON_FLAG.FALG_YES)){
					/*if (newvehicle.getRationseatnum() < scheduleplan.getSoldeatnum()){
						// 报到车辆座位数小于该班次已售座位数,不许报到
						throw new ServiceException("0069");
					}*/						
				}else{
					// 报到车辆座位数小于该班次已售座位数,不许报到
					throw new ServiceException("0069");
				}
				
			}
		}
		
		if (!scheduleplan.getIslinework() && !schedule.isIsfixseat()) {
			
			
			if (IsPemissionReportbySeattype(vehiclereport)) {
				throw new ServiceException("6118");
			}
			// 修改座位数
//			changeSeats(scheduleplan, newvehicle.getSeatnum(),
//					vehiclereport.getCreateby(),"1");
			/**
			 * C卡报班时，若报到车型与班次循环中计划车型不一致时，且报到车型为班次硬调票价中设置的车型时，
			 * 自动更新计划车型并取对应车型的票价。修改后IC卡报到页面，车辆类型与售票车型将保持一致。
			 * 若报到车型与班次硬调票价中设置的车型都不一致时，不更新计划车型及对应车型的票价。 姜蓥瑞 2015年9月17日18:17:14
			 */
//			updateSeattypetoTicketprice(vehiclereport, global,scheduleplan.getFixedreserveseatnum()>0?new Short(scheduleplan.getFixedreserveseatnum()).toString():"0");
			updateSeattypetoAll(vehiclereport, global, scheduleplan.getFixedreserveseatnum()>0?new Short(scheduleplan.getFixedreserveseatnum()).toString():"0");
		}
		/*String ischangeseat = parameterService.findParamValue("2031", oldreport.getOrgid());
		if (!scheduleplan.getIslinework()) {
			if(ischangeseat.equals("1") && !schedule.isIsfixseat()){
			// 修改座位数
				changeSeats(scheduleplan, newvehicle.getSeatnum(),
					vehiclereport.getCreateby());
			}
		}*/
		
		//取消报班后证件审查更改status=0（未报班）扩展点----十堰插件
		ActionNode actionNode = Appvar.routes.get("CANCELVEHICLEREPORTLICENSECHECKEXPORT");// 由插件名,获得插件
		//查询是否使用了certificatecheck证件审核插件；从Appvar.routes中获取扩张点插件名、插件类、插件方法
		PluginFunction.DoPlugin(oldreport, global,actionNode);
		//根据车牌号更换新的驾驶员
		List<Map<String,Object>> vehdrilist = null;
		actionNode = Appvar.routes.get("VEHICLEREPORTLICENSECHECKEXPORT");// 由插件名,获得插件
		if(actionNode != null) {
			//十堰的特殊情况
			vehdrilist = dispatchServiceDao.qryVehicleDriverAudit(vehiclereport.getVehicleid());
		}
		else {
			//没有必要取班次循环的驾驶员，因为班次不变，即使换车报到也会与第一次报到的驾驶员保持一致
			vehdrilist = dispatchServiceDao.qryVehicleDriverSet(vehiclereport.getVehicleid()); //优先顺序：2
			if(vehdrilist!=null && vehdrilist.size()>0){
				//
			}else{
				vehdrilist = dispatchServiceDao.qryVehicleDriver(vehiclereport.getVehicleid());//优先顺序：3
			}
		}
		vehdrilist = CommonUtil.list2Map(vehdrilist, new String[]{ 
				"drivername", "driverid",
				"vehicleno","vehicleid","firstdate",
				"drivercopilot1name","drivercopilot1id",
				"vehiclecopilot1no","vehiclecopilot1id","first1date" });
		if (vehdrilist != null && vehdrilist.size()>0){
			Driver driver = new Driver();
			driver.setId( Long.parseLong(vehdrilist.get(0).get("driverid").toString()) );
			oldreport.setDriver1(driver); 
		}
		
		// 若为流水班则不修改
		oldreport.setVehicleid(vehiclereport.getVehicleid());
		oldreport.setUpdateby(vehiclereport.getCreateby());
		oldreport.setUpdatetime(new Date());
		dispatchServiceDao.merge(oldreport);
		// 保存操作日志
		String result = "报到ID=" + oldreport.getId() + ",发车日期："
				+ DateUtils.formatDate(scheduleplan.getDepartdate()) + ",班次号:"
				+ schedule.getCode() + ",发车时间:" + departtime + "已报到车辆："
				+ oldvehicle.getVehicleno() + "进行换车报到，新报到车辆为："
				+ newvehicle.getVehicleno();
		Operationlog operationLog = new Operationlog();
		operationLog.setIp(ip);
		operationLog.setContent(result);
		operationLog.setModule("综合调度->IC卡报班");
		operationLog.setOperatetime(new Date());
		operationLog.setOperation("换车报到");
		operationLog.setSessionid("无session");
		operationLog.setUserid(vehiclereport.getCreateby());
		operationLogService.savelog(operationLog);
		return true;
	}

	@Override
	public List<Map<String, Object>> qryScheduleplanroute(long vehicleid)
			throws ServiceException {
		return ListUtil.listToMap(new Object[] { "id", "routeid", "vehicleno",
				"seatnum","isneedfinger","scheduleid" }, dispatchServiceDao.qryVehicleById(vehicleid),
				new Object[] { Long.class, Long.class, String.class,
						Short.class,boolean.class, Long.class });
	}

	/* (non-Javadoc)
	 * 车辆运行计划查询
	 * @see cn.nova.bus.dispatch.service.DispatchService#qryVehicleRunplan(java.lang.Long, java.util.Date)
	 */
	@Override
	public List<Map<String, Object>> qryVehicleRunplan(Long vehicleid, Date departdate) {
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>(); 	
		List<Object> list=dispatchServiceDao.qryVehicleRunplan(vehicleid, departdate);
		Map<String,Object> daymap = new HashMap<String, Object>();		
		for (Object object : list) {
			Object[] objects = (Object[]) object;			
			if(daymap.containsKey(objects[0])){
				String key=objects[0].toString();
				String value= daymap.get(objects[0])+","+objects[1];
				daymap.remove(key);
				daymap.put(key, value);
			}else{
				daymap.put(objects[0].toString(), objects[1]);
				
			}
		}
		Map<String,Object> fieldtypemap = new HashMap<String, Object>();	
		Set<String> key =daymap.keySet();
		for(Iterator<String> it2=key.iterator();it2.hasNext();){
			Map<String,Object> curmap = new HashMap<String, Object>();			
			String value= (String) it2.next();
			curmap.put("day", value);
			curmap.put("name", daymap.get(value));
			result.add(curmap);			
		}
		fieldtypemap.put("day", Integer.class);
		fieldtypemap.put("name", String.class);				
		fieldtypemap.put("DATA-FLAG",String.class);				
		result.add(fieldtypemap);
		return result;
	}
	
	/**
	 * 判断车辆是否只允许车辆报到在已指定的线路中
	 * (该方法 客户端和服务端(本类的其他方法) 都有用到)
	 * @param vehicleid: 要报到的车辆
	 * @param scheduleid: 要报到的班次
	 * @throws ServiceException
	 */
	@SuppressWarnings("unchecked")
	@Override
	public boolean isOnlyReportRoute(long vehicleid,long scheduleid) throws ServiceException {
			Vehicle vehicle = (Vehicle) dispatchServiceDao.get(Vehicle.class,vehicleid);
			//如果线路为空，说明该车没有指定线路，则可以报到。
			Schedule schedule = (Schedule)dispatchServiceDao.get(Schedule.class, scheduleid);
			boolean flag = true;
			//判断车牌中指定线路
			if(vehicle.getRoute()!=null){
				Route route = (Route)dispatchServiceDao.get(Route.class,vehicle.getRoute().getId());
				//如果有车辆有指定线路，且报到的班次所属线路不等于车辆指定线路 则抛出错误
				if(route!=null && route.getId() == schedule.getRoute().getId()){
					//该车辆只能报到车辆指定的线路：+线路名称
					flag = false;
				}
			}
			//判断 可运营设置中指定的线路
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			propertyFilters.add(new PropertyFilter("EQL_t!vehicleid", vehicleid));
			List<Vehiclerouteconctrl> vrclist = dispatchServiceDao.find(Vehiclerouteconctrl.class, propertyFilters);
			for (Vehiclerouteconctrl vehiclerouteconctrl : vrclist) {
				if(vehiclerouteconctrl.getRouteid()==schedule.getRoute().getId()){
					flag = false;
					break;
				}
			}
			//判断 车辆循环组计划表中指定的线路
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!vehicle.id", vehicleid));
			List<Cycleschemesvehicle> csvclist = dispatchServiceDao.find(Cycleschemesvehicle.class, propertyFilters);
			for (Cycleschemesvehicle csv : csvclist) {
				if(csv.getCyclescheme().getRouteid()==schedule.getRoute().getId()){
					flag = false;
					break;
				}
			}
			if(flag){
				throw new ServiceException("0430");
			}
			return true;
	}
	
	/**
	 * 查询上次报到的非流水班发车时间     或者        流水班上次报到时间
	 * @param vehicleid
	 * @param scheduleplan
	 * @param departstationid
	 * @return
	 */
	@Override
	public String checkreporttime(long vehicleid,Scheduleplan scheduleplan,long departstationid){
		
		int intervals = Integer.parseInt(parameterService.findParamByStation(ParamterConst.Param_2020, departstationid));
		if(intervals>0){
			Schedulestatus schedulestatus = dispatchServiceDao
					.getSchedulestatus(departstationid, scheduleplan.getScheduleid(), scheduleplan.getDepartdate());
			//取当天本车牌已报到班次的最大发车时间（ 正常班取发车时间，流水班取报到时间） 
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			propertyFilters.add(new PropertyFilter("EQD_sp!departdate", scheduleplan.getDepartdate()));
			propertyFilters.add(new PropertyFilter("EQD_vr!departdate", scheduleplan.getDepartdate()));
			propertyFilters.add(new PropertyFilter("EQD_ss!departdate", scheduleplan.getDepartdate()));
			propertyFilters.add(new PropertyFilter("EQL_vr!vehicleid", vehicleid));
			propertyFilters.add(new PropertyFilter("EQL_ss!departstationid", departstationid));
			StringBuilder sb = new StringBuilder();
			sb.append("select max(case when sp.islinework=1 ")
			.append("         then to_char(vr.reporttime,'hh24:mi') else ss.departtime end)")
			.append("    From vehiclereport vr,scheduleplan sp,schedulestatus ss")
			.append("	where sp.id=vr.scheduleplanid")
			.append("	and ss.scheduleplanid=sp.id")
			.append("	and vr.isactive=1")
			.append(PropertyFilter.toJpql(propertyFilters,true));
			Query query = dao.getEntityManager().createNativeQuery(sb.toString());
			JPAPropertyFilterUtil.setParameter(query, propertyFilters);
			String lastdeparttimeschedule = (String) query.getSingleResult();
			if(lastdeparttimeschedule!=null){
				Date thisscheduledeparttime = null;
				if(scheduleplan.getIslinework()){
					thisscheduledeparttime = new Date();
				}else{
					thisscheduledeparttime = DateUtils.mergerDateAndTime(scheduleplan.getDepartdate(), schedulestatus.getDeparttime());
				}
				Date lastdepartdatetime =DateUtils.mergerDateAndTime(scheduleplan.getDepartdate(), lastdeparttimeschedule);
				if(DateUtils.compare(lastdepartdatetime, thisscheduledeparttime, "yyyy-MM-dd HH:mm:ss")>0){
					return "您已经报到过该发车时间以后的班次，请先取消报到其他班次！";
				}
				if(DateUtils.add(lastdepartdatetime,Calendar.MINUTE, intervals)
				  .after(thisscheduledeparttime)){
					return "您本日已经报到其它班次，且发车时间距离本班次发车时间不足"+intervals+"分钟";
				}
			}
		}
		return null;
	}
	
	
	/**
	 * 正副驾驶员的证件判断及有效期到期提示
	 * @param orgid
	 * @param driver1id 正驾驶员
	 * @param driver2id 副驾驶员1
	 * @param driver3id 副驾驶员2
	 * @param driver4id 副驾驶员3
	 * @return
	 */
	@Override
	public String showValidate(long orgid, long driver1id,
			long driver2id, long driver3id, long driver4id) throws ServiceException {
		String msg ="";
		long flag = 0;
		String temp ="";
		//证件有效期到期提示天数
		int showdate = Integer.parseInt(parameterService.findParamValue(ParamterConst.Param_2024, orgid));
		if(driver1id !=0){
			temp = "正驾驶员的";
			Driver driver1 = (Driver) idao.get(Driver.class, driver1id);
			if ( driver1.getDrivinglicenseenddate() !=null
					&&DateUtils.compare(driver1.getDrivinglicenseenddate(),new Date()) < 0 ){
				throw new ServiceException(msg+temp,"0446");	//驾驶证已过期，不允许报班！					
			}
			if ( driver1.getQualificationenddate() !=null
					&&DateUtils.compare(driver1.getQualificationenddate(),new Date()) < 0 ){
				throw new ServiceException(msg+temp,"0447");	//从业资格证已过期，不允许报班！					
			}
			if ( driver1.getWorkenddate() !=null
					&&DateUtils.compare(driver1.getWorkenddate(),new Date()) < 0 ){
				throw new ServiceException(msg+temp,"0448");	//准驾证已过期，不允许报班！					
			}					
		
			if ( driver1.getDrivinglicenseenddate() !=null
					&&DateUtils.compare(driver1.getDrivinglicenseenddate(),new Date()) >= 0 
					&&DateUtils.compare( DateUtils.add(driver1.getDrivinglicenseenddate(),-showdate) ,new Date())<0){
				temp = temp +"驾驶证有效期还有"
					+DateUtils.getIntervalDays(new Date(),DateUtils.add(driver1.getDrivinglicenseenddate(),2))
					+"天过期!";
				flag = -1;
			}
			if (driver1.getQualificationenddate()!=null
					&&DateUtils.compare(driver1.getQualificationenddate(),new Date()) >= 0 
					&&DateUtils.compare( DateUtils.add(driver1.getQualificationenddate(),-showdate) ,new Date())<0) {
				temp = temp +"从业资格证有效期还有"
				+DateUtils.getIntervalDays(new Date(),DateUtils.add(driver1.getQualificationenddate(),2))
				+"天过期!";
				flag = -1;
			}
			if (driver1.getWorkenddate()!=null
					&&DateUtils.compare(driver1.getWorkenddate(),new Date()) >= 0 
					&&DateUtils.compare( DateUtils.add(driver1.getWorkenddate(),-showdate) ,new Date())<0) {
				temp = temp +"准驾证有效期还有"
				+DateUtils.getIntervalDays(new Date(),DateUtils.add(driver1.getWorkenddate(),2))
				+"天过期!";
				flag = -1;
			}	
			if(flag == -1){
				msg = temp;
			}
			flag = 0;
		}
		if(driver2id != 0 ){
			Driver driver2 = (Driver) idao.get(Driver.class, driver2id);
			temp = "  副驾驶员1的";
			if ( driver2.getDrivinglicenseenddate() !=null
					&&DateUtils.compare(driver2.getDrivinglicenseenddate(),new Date()) < 0 ){
				throw new ServiceException(msg+temp,"0446");	//驾驶证已过期，不允许报班！					
			}
			if ( driver2.getQualificationenddate() !=null
					&&DateUtils.compare(driver2.getQualificationenddate(),new Date()) < 0 ){
				throw new ServiceException(msg+temp,"0447");	//从业资格证已过期，不允许报班！					
			}
			if ( driver2.getWorkenddate() !=null
					&&DateUtils.compare(driver2.getWorkenddate(),new Date()) < 0 ){
				throw new ServiceException(msg+temp,"0448");	//准驾证已过期，不允许报班！					
			}		
			if ( driver2.getDrivinglicenseenddate() !=null
					&&DateUtils.compare(driver2.getDrivinglicenseenddate(),new Date()) >= 0 
					&&DateUtils.compare( DateUtils.add(driver2.getDrivinglicenseenddate(),-showdate) ,new Date())<0){
				temp = temp +"驾驶证有效期还有"
					+DateUtils.getIntervalDays(new Date(),DateUtils.add(driver2.getDrivinglicenseenddate(),2))
					+"天过期!";
				flag = -1;
			}
			if (driver2.getQualificationenddate()!=null
					&&DateUtils.compare(driver2.getQualificationenddate(),new Date()) >= 0 
					&&DateUtils.compare( DateUtils.add(driver2.getQualificationenddate(),-showdate) ,new Date())<0) {
				temp = temp +"从业资格证有效期还有"
				+DateUtils.getIntervalDays(new Date(),DateUtils.add(driver2.getQualificationenddate(),2))
				+"天过期!";
				flag = -1;
			}
			if (driver2.getWorkenddate()!=null
					&&DateUtils.compare(driver2.getWorkenddate(),new Date()) >= 0 
					&&DateUtils.compare( DateUtils.add(driver2.getWorkenddate(),-showdate) ,new Date())<0) {
				temp = temp +"准驾证有效期还有"
				+DateUtils.getIntervalDays(new Date(),DateUtils.add(driver2.getWorkenddate(),2))
				+"天过期!";
				flag = -1;
			}		
			if(flag == -1){
				msg = msg + temp;
			}
			flag = 0;
		}	if(driver3id != 0 ){
			Driver driver3 = (Driver) idao.get(Driver.class, driver3id);
			temp ="  副驾驶员2的";
			if ( driver3.getDrivinglicenseenddate() !=null
					&&DateUtils.compare(driver3.getDrivinglicenseenddate(),new Date()) < 0 ){
				throw new ServiceException(msg+temp,"0446");	//驾驶证已过期，不允许报班！					
			}
			if ( driver3.getQualificationenddate() !=null
					&&DateUtils.compare(driver3.getQualificationenddate(),new Date()) < 0 ){
				throw new ServiceException(msg+temp,"0447");	//从业资格证已过期，不允许报班！					
			}
			if ( driver3.getWorkenddate() !=null
					&&DateUtils.compare(driver3.getWorkenddate(),new Date()) < 0 ){
				throw new ServiceException(msg+temp,"0448");	//准驾证已过期，不允许报班！					
			}		
			if ( driver3.getDrivinglicenseenddate() !=null
					&&DateUtils.compare(driver3.getDrivinglicenseenddate(),new Date()) >= 0 
					&&DateUtils.compare( DateUtils.add(driver3.getDrivinglicenseenddate(),-showdate) ,new Date())<0){
				temp = temp +"驾驶证有效期还有"
					+DateUtils.getIntervalDays(new Date(),DateUtils.add(driver3.getDrivinglicenseenddate(),2))
					+"天过期!";
				flag = -1;
			}
			if (driver3.getQualificationenddate()!=null
					&&DateUtils.compare(driver3.getQualificationenddate(),new Date()) >= 0 
					&&DateUtils.compare( DateUtils.add(driver3.getQualificationenddate(),-showdate) ,new Date())<0) {
				temp = temp +"从业资格证有效期还有"
				+DateUtils.getIntervalDays(new Date(),DateUtils.add(driver3.getQualificationenddate(),2))
				+"天过期!";
				flag = -1;
			}
			if (driver3.getWorkenddate()!=null
					&&DateUtils.compare(driver3.getWorkenddate(),new Date()) >= 0 
					&&DateUtils.compare( DateUtils.add(driver3.getWorkenddate(),-showdate) ,new Date())<0) {
				temp = temp +"准驾证有效期还有"
				+DateUtils.getIntervalDays(new Date(),DateUtils.add(driver3.getWorkenddate(),2))
				+"天过期!";
				flag = -1;
			}
			if(flag == -1){
				msg = msg + temp;
			}
			flag = 0;
		}
		if(driver4id != 0 ){
			Driver driver4 = (Driver) idao.get(Driver.class, driver4id);
			temp ="  副驾驶员3的";
			if ( driver4.getDrivinglicenseenddate() !=null
					&&DateUtils.compare(driver4.getDrivinglicenseenddate(),new Date()) < 0 ){
				throw new ServiceException(msg+temp,"0446");	//驾驶证已过期，不允许报班！					
			}
			if ( driver4.getQualificationenddate() !=null
					&&DateUtils.compare(driver4.getQualificationenddate(),new Date()) < 0 ){
				throw new ServiceException(msg+temp,"0447");	//从业资格证已过期，不允许报班！					
			}
			if ( driver4.getWorkenddate() !=null
					&&DateUtils.compare(driver4.getWorkenddate(),new Date()) < 0 ){
				throw new ServiceException(msg+temp,"0448");	//准驾证已过期，不允许报班！					
			}		
			if ( driver4.getDrivinglicenseenddate() !=null
					&&DateUtils.compare(driver4.getDrivinglicenseenddate(),new Date()) >= 0 
					&&DateUtils.compare( DateUtils.add(driver4.getDrivinglicenseenddate(),-showdate) ,new Date())<0){
				temp = temp +"驾驶证有效期还有"
					+DateUtils.getIntervalDays(new Date(),DateUtils.add(driver4.getDrivinglicenseenddate(),2))
					+"天过期!";
				flag = -1;
			}
			if (driver4.getQualificationenddate()!=null
					&&DateUtils.compare(driver4.getQualificationenddate(),new Date()) >= 0 
					&&DateUtils.compare( DateUtils.add(driver4.getQualificationenddate(),-showdate) ,new Date())<0) {
				temp = temp +"从业资格证有效期还有"
				+DateUtils.getIntervalDays(new Date(),DateUtils.add(driver4.getQualificationenddate(),2))
				+"天过期!";
				flag = -1;
			}
			if (driver4.getWorkenddate()!=null
					&&DateUtils.compare(driver4.getWorkenddate(),new Date()) >= 0 
					&&DateUtils.compare( DateUtils.add(driver4.getWorkenddate(),-showdate) ,new Date())<0) {
				temp = temp +"准驾证有效期还有"
				+DateUtils.getIntervalDays(new Date(),DateUtils.add(driver4.getWorkenddate(),2))
				+"天过期!";
				flag = -1;
			}		
			if(flag == -1){
				msg = msg + temp;
			}
			flag = 0;
		}
		if (msg !="" && !msg.equals("")) {
			return msg;
		}else{
			return "";
		}
	}
	/**
	 * IC卡报班同线路间隔时间限制判断
	 * @param scheduleid
	 * @return 
	 */
	@Override
	public String qryRouteReportInterval(long scheduleid) {
		int reportinterval = 0;    //报班时间间隔
		Date maxRouteTime = null;   //最近报班时间
		//报班时间间隔
		List<Object> interlist = dispatchServiceDao.qryRouteReportIntervalValue(scheduleid);
		if(interlist!=null && interlist.size()>0){
			reportinterval = ( (BigDecimal)interlist.get(0) ).intValue();
		}
		
		//最近报班时间
		List<Object> timelist = dispatchServiceDao.qryRouteReportInterval(scheduleid);
		if(timelist!=null && timelist.size()>0){
			if(timelist.get(0)==null){
				return null;
			}
			maxRouteTime = (Date) timelist.get(0);
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(maxRouteTime);
			//允许的报班时间
			calendar.add(Calendar.MINUTE, reportinterval);
			Date allowDate = calendar.getTime();
			//System.out.println("最近报班时间："+maxRouteTime+"————报班时间间隔："+reportinterval+"————允许报班时间："+allowDate);
			//当前时间
			Date currentTime = new Date();
			//System.out.println( "是否不允许报班："+currentTime.before(allowDate) );
			//计算
			if(currentTime.before(allowDate)){
				//不可以报班
				return "该线路两次报班时间间隔小于最小时间间隔["+reportinterval+"]，不能报班！";
			}
		}	
		return null;
	}
	/**
	 * IC卡报班驾驶员两次报班的最小时间间隔限制判断
	 * @param driverid
	 * @return 
	 */
	@Override
	public String qryDriverReportInterval(long driverid) {
		int reportinterval = 0;    //报班时间间隔
		Date maxDriverTime = null;   //最近报班时间
		//报班时间间隔
		Global global = CurrentUtil.getGlobal();
		String paVal = parameterService.findParamValue(ParamterConst.Param_2025, global.getOrganization().getId());
		reportinterval =  new Integer(paVal);
		//最近报班时间
		List<Object> timelist = dispatchServiceDao.qryDriverReportInterval(driverid);
		if(timelist!=null && timelist.size()>0){
			if(timelist.get(0)==null){
				return null;
			}
			maxDriverTime = (Date) timelist.get(0);
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(maxDriverTime);
			//允许的报班时间
			calendar.add(Calendar.MINUTE, reportinterval);
			Date allowDate = calendar.getTime();
			//当前时间
			Date currentTime = new Date();
			//计算
			if(currentTime.before(allowDate)){
				//不可以报班
				return "两次报班时间间隔小于'2025'参数设置的值["+reportinterval+"]，不能报班！";
			}
		}	
		return null;
	}

	/**
	 * 更新班次计划表座位信息 李电志 2015年6月5日 11:55:20  待确认
	 */
	@Override
	public void updateSchedulePlan(Long scheduleplanid, int schedulePlanSeatnum) {
		
	}

	/**
	 * 取消并班实现  李电志 2015年6月17日 10:13:29
	 * @author 
	 */
	@Override
	public String cancleShift(String schedulename, Date departdate,long oldscheduleplanid)  throws ServiceException {
		/*
		 * 查询当前日期下的该班次最近一次的并班信息,获取被并班次号、原座位号、并入班次号、新座位号
		 * 判断被并班次当天被并次数，只一次修改班次状态为正常状态，多余一次不修改被并状态。
		 * 判断被并班次的原座位状态是否为售出状态，售出不能取消并班。未售出则将该座位信息修改。
		 * 删除最近的并班记录，增加一条取消并班记录，增加n条取消并班座位信息记录。
		 */
		//获取被并班次的id，根据schedulename、departdate
		//查询该班次所有并班信息
		List<Schedulemerge> listAll = dispatchServiceDao.qryLastSchedulemergeNewAll(oldscheduleplanid);
		if (listAll != null && listAll.size() > 0) {
			Schedulemerge sm = listAll.get(0);//获取最后一次并班信息
			//并入班次
			String newSeats = sm.getNewseats();//并入班次座位信息
			long newSchuleId = sm.getScheduleplanid();//并入班次id
			//判断并入班次的那几张票的检票状态，如果已检则不能取消并班
			//截断座位号
			String newSeat = newSeats.substring(0, newSeats.length()-1);
			//获取并入班次座位信息
			List<Scheduleseats> listScheduleseatsin = dispatchServiceDao.qryScheduleseatsIn(newSchuleId,newSeat);
			int length = listScheduleseatsin.size();
			boolean isCheck = false;//是否检票标志
			for (int i = 0; i < length; i++) {
				Scheduleseats scheduleseats = listScheduleseatsin.get(i);
				if ("7".equals(scheduleseats.getStatus())) {//车票状态为7，已检。
					isCheck = true;
				}
			}
			//被并班次
			String oldSeats = sm.getOldseats();//被并班次座位信息
			//截断座位号
			String oldSeat = oldSeats.substring(0, oldSeats.length()-1);
			long oldSchulePlanId = sm.getOldscheduleplanid();//被并班次计划id
			//更新被并班次座位信息：已售出的座位不能取消并班
			//获取被并班次座位信息
			List<Scheduleseats> listScheduleseats = dispatchServiceDao.qryScheduleseats(oldSchulePlanId,oldSeat);
			//判断每个座位的状态，都是空座才能取消并班
			int len = listScheduleseats.size();
			boolean flg = false;//是否不都是空座标志  false:都是空座，true：不都是空座
			for (int i = 0; i < len; i++) {
				Scheduleseats scheduleseats = listScheduleseats.get(i);
				if (!"0".equals(scheduleseats.getStatus())) {//如果有一个不是空座
					flg = true;
				}
			}
			if (isCheck) {//车票已检
				throw new ServiceException("6112");
			} else {
				if (flg) {//不都是空座位
//					System.out.println("不都是空座！提示");
					//被并班次座位不为空
					throw new ServiceException("6113");
				} else {//跟新两个班次的座位情况：并入班次的几个座位变为正常状态；被并班次的座位被还原。再更新车票对应的明细信息
					//将被并座位状态还原
					for (int i = 0; i < len; i++) {//被并的座位个数
						//恢复被并班次的座位信息
						Scheduleseats scheduleseats = listScheduleseats.get(i);//被并班次相应座位的信息：取消之前应该是空座
						Scheduleseats scheduleseatsin = listScheduleseatsin.get(i);//并入之后的座位信息
						scheduleseats.setCreateby(scheduleseatsin.getCreateby());
						scheduleseats.setCreatetime(scheduleseatsin.getCreatetime());
						scheduleseats.setDepartdate(scheduleseatsin.getDepartdate());
						scheduleseats.setSeattype(scheduleseatsin.getSeattype());
						scheduleseats.setStatus(scheduleseatsin.getStatus());
						scheduleseats.setTickettype(scheduleseatsin.getTickettype());
						scheduleseats.setUpdateby(scheduleseatsin.getUpdateby());
						scheduleseats.setUpdatetime(scheduleseatsin.getUpdatetime());
						
						//清空并入班次的信息
//							scheduleseatsin.setCreateby(null);
//							scheduleseatsin.setCreatetime(null);
//							scheduleseatsin.setDepartdate(null);
//							scheduleseatsin.setSeattype(null);
						scheduleseatsin.setStatus("0");
						scheduleseatsin.setTickettype("0");
//							scheduleseatsin.setUpdateby(null);
//							scheduleseatsin.setUpdatetime(null);
						
						//更新两个座位信息dispatchServiceDao.merge(vr);
						dispatchServiceDao.merge(scheduleseats);//恢复被并班次座位信息
						dispatchServiceDao.merge(scheduleseatsin);//恢复并入班次座位的信息：清空
						
					}
						
					//获取两个班次的运行计划，修改售出的票数
					Scheduleplan oldshceduelplan = (Scheduleplan) dispatchServiceDao.get(Scheduleplan.class, sm.getOldscheduleplanid());
					Scheduleplan newscheduelplan = (Scheduleplan) dispatchServiceDao.get(Scheduleplan.class, sm.getScheduleplanid());
					oldshceduelplan.setSoldeatnum((short)(oldshceduelplan.getSoldeatnum() + len));
					newscheduelplan.setSoldeatnum((short)(newscheduelplan.getSoldeatnum() - len));
					
					
//					【黄石 5.041fix】班次A售出5个座位，并班到没有售座位的班次B，然后在综合调度取消班次A的并班，售票界面显示班次A没有售出座位，班次B售出5个座位。
					/**
					 * 2016年3月4日10:40:11 姜蓥瑞  begin
					 */
					List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
					filters.clear();
					
					filters.add(new PropertyFilter("EQL_t!scheduleplan.id",oldshceduelplan.getId()));
					List<Ticketprice> listpriceold= dispatchServiceDao.find(Ticketprice.class, filters);
					for(Ticketprice listpriceold_:listpriceold){
						listpriceold_.setSoldeatnum((short)(listpriceold_.getSoldeatnum()+len));
						dispatchServiceDao.merge(listpriceold_);
					}
						filters.clear();
					
					filters.add(new PropertyFilter("EQL_t!scheduleplan.id",newscheduelplan.getId()));
					List<Ticketprice> listpricenew= dispatchServiceDao.find(Ticketprice.class, filters);
					for(Ticketprice listpricenew_:listpricenew){
						listpricenew_.setSoldeatnum((short)(listpricenew_.getSoldeatnum()-len));
						dispatchServiceDao.merge(listpricenew_);
					}
					
					
					
					/**
					 * 2016年3月4日10:40:11 姜蓥瑞 end
					 */

					dispatchServiceDao.merge(oldshceduelplan);
					dispatchServiceDao.merge(newscheduelplan);
					//更改Ticketsell表信息：还原车票信息
//						List<Ticketsell> listTickSellOld = dispatchServiceDao.getTicketsells(sm.getOldscheduleplanid(),oldSeat);//原班次车票信息
					List<Ticketsell> listTickSellNew = dispatchServiceDao.getTicketsells(sm.getScheduleplanid(),newSeat);//并入班次车票信息
					//还原两个班次的车型座位图信息
					int tsLen = listTickSellNew.size();
					String[] seats = oldSeat.split(",");//获取原座位号数组
					Short[] ss = new Short[seats.length];//转化
					for (int i = 0; i < ss.length; i++) {
						ss[i] =Short.parseShort(seats[i]);
					}
					Scheduleplan scheduleplan = (Scheduleplan) dispatchServiceDao.get(Scheduleplan.class, oldscheduleplanid);
					//修改售票信息
					for (int i = 0; i < tsLen; i++) {
						Ticketsell tsNew = listTickSellNew.get(i);
						tsNew.setScheduleplanid(oldscheduleplanid);//班次计划id
						tsNew.setScheduleid(scheduleplan.getScheduleid());//班次id
						tsNew.setSeatno(ss[i]);//座位号
						dispatchServiceDao.merge(tsNew);
					}
					
					if (listAll.size() == 1) {//只被并班一次，修改被并班次状态为正常状态。否则还是被并状态
						//通过oldSchulePlanId 获取 Schedulestatus 的id
						List<Long> schedulestatusId = dispatchServiceDao.getScheduleStatus(oldSchulePlanId);
						long id = (long)schedulestatusId.get(0);
						Schedulestatus schedulestatus = (Schedulestatus) dispatchServiceDao.get(Schedulestatus.class, id);
//						Schedulestatus schedulestatus = schedulestatusNew.get(0);
//						System.out.println(isUpStatus);
						//获取该班次被并次数信息 ，只被并班一次，修改被并班次状态为正常状态。否则还是被并状态
						schedulestatus.setStatus("0");//修改班次状态  0 ： 正常、3：被并
						dispatchServiceDao.merge(schedulestatus);
						
					}
					
					//最后删除并班记录Schedulemerge sm
					sm.setIscancel(true);
					dispatchServiceDao.merge(sm);
//						usertransaction.commit();//提交事务
				}
			}
		}else {//并班信息不存在,提示取消失败
			throw new ServiceException("6114");
		}
		return null;
	}

	/**
	 * 获取报道车辆信息 李电志 2015年7月29日 02:48:40
	 *//*
	@Override
	public Vehicle getVehicleInfo(Long vehicleId) throws ServiceException {
		Vehicle vehicle = (Vehicle) dispatchServiceDao.get(Vehicle.class, vehicleId);
		return vehicle;
	}

	*//**
	 * 获取车辆品牌型号表信息  李电志  2015年7月29日 03:00:53
	 *//*
	@Override
	public Vehiclebrandmodel getVehiclebrandmodelInfo(Long vehiclebrandmodelid)
			throws ServiceException {
		Vehiclebrandmodel vehiclebrandmodel = (Vehiclebrandmodel) dispatchServiceDao.get(Vehicle.class, vehiclebrandmodelid);
		return vehiclebrandmodel;
	}

	*//**
	 * 获取车辆座位图明细表信息 李电志 2015年7月29日 03:12:38
	 *//*
	@Override
	public List<Vehicleseatplandetail> getVehicleseatplandetailInfo(
			Long vehiclebrandmodelid) throws ServiceException {
		List<Vehicleseatplandetail> vehicleseatplandetailList = dispatchServiceDao.getVehicleseatplandetailInfo(vehiclebrandmodelid);
		return vehicleseatplandetailList;
	}

	*//**
	 * 获取车辆内部空间表信息 李电志 2015年7月29日 03:29:40
	 *//*
	@Override
	public Vehiclespace getVehicleSpaceInfo(Long vehicleSpaceId)
			throws ServiceException {
		Vehiclespace vehiclespace = (Vehiclespace) dispatchServiceDao.get(Vehiclespace.class, vehicleSpaceId);
		return vehiclespace;
	}

	*//**
	 * 获取执行票价表ticketprice的信息  李电志 2015年7月29日 05:51:37
	 */
	
	public List<Ticketprice> getSchTicketPriceList(
			Long schedulePlanceId) throws ServiceException {
		List<Ticketprice> list = dispatchServiceDao.getSchTicketPriceList(schedulePlanceId);
		return list;
	}

	/**
	 * 更新执行票价表ticketprice的信息  李电志 2015年7月29日 05:51:37
	 *//*
	@Override
	public boolean updateTicketPrice(Ticketprice ticketprice)
			throws ServiceException {
		dispatchServiceDao.merge(ticketprice);
		return true;
	}*/


	 /**
    * 被并班次恢复售票
    * 将被并班次改为可售状态 
    * 座位不还原
    * 姜蓥瑞   2015年8月3日10:18:53
    */
	
	public String cansaleticket(long oldscheduleplanid)  throws ServiceException {
		dispatchServiceDao = new DispatchServiceDao();
		List<Schedulemerge> listAll = dispatchServiceDao.qryLastSchedulemergeNewAll(oldscheduleplanid);//根据被并scheduleplanid 得到scheduleplanid的并班记录
		if (listAll.size()>0 && listAll != null ){
			List<Long> schedulestatusId = dispatchServiceDao.getScheduleStatus(oldscheduleplanid);//如果有并班记录 根据并班记录的scheduleplanid 得到ScheduleStatus ID
			Long id=schedulestatusId.get(0);
			Schedulestatus schedulestatus = (Schedulestatus) dispatchServiceDao.get(Schedulestatus.class, id); //根据ScheduleStatusid 得到ScheduleStatus对象
			schedulestatus.setStatus("0"); //ScheduleStatus Status"0"为正常 原来为"3" 是被并
			dispatchServiceDao.merge(schedulestatus);	
						
			Schedulemerge schedulemerge = listAll.get(0);//得到最后一次并班信息
			schedulemerge.setIsactive(false);
			schedulemerge.setIscancel(false);
			
		}else{
			//并班信息不存在 无法并班售票
			throw new ServiceException("6115");
		}
		
		return "被并班次恢复售票成功！";
	}

	@Override
	public List qryVehicleDriver(long vehicleid, Date departdate, long scheduleid) throws ServiceException {
		dispatchServiceDao = new DispatchServiceDao();
		List list = null;
		ActionNode actionNode = Appvar.routes.get("VEHICLEREPORTLICENSECHECKEXPORT");// 由插件名,获得插件
		if(actionNode != null) {
			//十堰的特殊情况
			list = dispatchServiceDao.qryVehicleDriverAudit(vehicleid);
		}
		else {
			list = dispatchServiceDao.qryVehicleDriverCycle(departdate, scheduleid);//优先顺序：1
			if(list!=null && list.size()>0){
				//
			}else{
				list = dispatchServiceDao.qryVehicleDriverSet(vehicleid); //优先顺序：2
			}
			if(list!=null && list.size()>0){
				//
			}else{
				list = dispatchServiceDao.qryVehicleDriver(vehicleid);//优先顺序：3
			}
		}
		return ListUtil.listToMap(new Object[] { "drivername", "driverid",
				"vehicleno","vehicleid","firstdate",
				"drivercopilot1name","drivercopilot1id",
				"vehiclecopilot1no","vehiclecopilot1id","first1date",
				"drivercopilot2name","drivercopilot2id","drivercopilot3name","drivercopilot3id"},
				list, 
				new Object[] {String.class, Long.class, 
				String.class, Long.class, Date.class,
				String.class, Long.class, 
				String.class, Long.class, Date.class,
				String.class,Long.class,String.class,Long.class});
	}
	
	/**
	 * C卡报班时，若报到车型与班次循环中计划车型不一致时，且报到车型为班次硬调票价中设置的车型时，
	 * 自动更新计划车型并取对应车型的票价。修改后IC卡报到页面，车辆类型与售票车型将保持一致。
	 * 若报到车型与班次硬调票价中设置的车型都不一致时，不更新计划车型及对应车型的票价。
	 *  姜蓥瑞 2015年9月17日18:17:14
	 */
	@Override
	public boolean updateSeattypetoTicketprice(Vehiclereport vehiclereport,Global global)  throws ServiceException{
		
	if(ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_9050, global.getOrganization().getId()))){
		//先通过车辆报到表找到报到车辆信息
		Vehicle vehicle = (Vehicle) dispatchServiceDao.get(Vehicle.class, vehiclereport.getVehicleid());
		Schedule schedule = (Schedule) dispatchServiceDao.get(Schedule.class, vehiclereport.getScheduleid()); //班次
		Date now=new Date();
		if(!schedule.getIslinework()){
			Long schedulePlanceId = vehiclereport.getScheduleplanid();// 班次计划ID
			//得到要更新的班次车辆人员计划
			Schedulevehiclepeopleplan   schedulevehiclepeopleplan  =dispatchServiceDao.getSchedulevehiclepeopleplanList(schedulePlanceId);
			//得到要更新的执行票价
			List<Ticketprice> ticketpricelist = dispatchServiceDao.getSchTicketPriceList(schedulePlanceId);
			List<Handprice> hlist=dispatchServiceDao.findvehicleprice(vehicle,schedule);
			boolean isupdate=false;
			for(Ticketprice tp:ticketpricelist){
				for(Handprice hp:hlist){
					if(tp.getDepartstationid()==hp.getDepartstationid()&&tp.getReachstationid()==hp.getReachstationid()
						&&tp.getSeattype().equals(hp.getSeattype()) 
						&&hp.getVehicletypeid()==vehicle.getVehicletypeid()	){
							tp.setFullprice(hp.getFullprice());
							tp.setHalfprice(hp.getHalfprice());
							tp.setStudentprice(hp.getStudentprice());
							tp.setMoreprice(hp.getMoreprice());
							List<Handpriceitem> hpitems = hp.getHandpriceitemlist();
							List<Ticketpriceitem> tplists=tp.getTicketpriceitemlist();
							for(Ticketpriceitem tpitem:tplists){
								for (Handpriceitem hpi : hpitems) {
									if (hpi.getTickettype().equals("Q")&&hpi.getTickettype().equals(tpitem.getTickettype())
										&&hpi.getTicketpriceformulaitemid()==tpitem.getTicketpriceformulaitemid()) {
										tpitem.setPrice(hpi.getPrice());
										dispatchServiceDao.merge(tpitem);
										break;
									}
								}
							}
							isupdate=true;
							tp.setUpdatetime(now);
							dispatchServiceDao.merge(tp);
							break;
					}	
				}
			}
			if(isupdate){
				schedulevehiclepeopleplan.setPlanvehiclebrandmodelid(vehicle.getVehiclebrandmodelid());
				schedulevehiclepeopleplan.setPlanvehicletypeid(vehicle.getVehicletypeid());
				schedulevehiclepeopleplan.setPlanvehicle(vehicle);
				schedulevehiclepeopleplan.setUpdatetime(now);
				dispatchServiceDao.merge(schedulevehiclepeopleplan);
			}
			
		}
	}	
		return true;
	
	}
public boolean delvehicleroutectrl(long id){
		
		Vehiclerouteconctrl vc = (Vehiclerouteconctrl) dispatchServiceDao
		.get(Vehiclerouteconctrl.class, id);
			if(vc==null){
					return false;
				}
			dispatchServiceDao.del(vc);
		return true;
	}
	public boolean savevehicleroute(long id, Long orgid, Long vehicleid,
			String routeid, Global global)  throws Exception {
		Date now = new Date();
		if (id == 0) {
			 routeid = routeid.substring(0, routeid.length() - 1);
			String[] split = routeid.split(",");
			for (String routeid_s : split) {
				Vehiclerouteconctrl vc = new Vehiclerouteconctrl();
				vc.setOrgid(orgid);
				vc.setVehicleid(vehicleid);
				vc.setRouteid(Long.parseLong(routeid_s));
				vc.setCreateby(CurrentUtil.getGlobal().getUserinfo().getId());
				vc.setUpdateby(CurrentUtil.getGlobal().getUserinfo().getId());
				vc.setCreatetime(now);
				vc.setUpdatetime(now);
				dispatchServiceDao.merge(vc);
			}
			return true;
			//修改
		} else {
				Vehiclerouteconctrl vc = (Vehiclerouteconctrl) dispatchServiceDao
						.get(Vehiclerouteconctrl.class, id);
				boolean exists = dispatchServiceDao.existsVehicleroute(vehicleid,routeid,id);
					if(exists){
						throw new Exception("该线路与车辆组合已存在!");
					}
				vc.setRouteid(Long.parseLong(routeid));
				vc.setUpdateby(CurrentUtil.getGlobal().getUserinfo().getId());
				vc.setUpdatetime(now);
				dispatchServiceDao.merge(vc);
			return true;
			}
	}
	@Override
	public List<Map<String, Object>> qryvehiclerouteset(List<PropertyFilter> buildFromHttpRequest) throws ServiceException {
		return ListUtil.listToMap(new Object[] { 
				"id","vehicleno", "routename", "createby",
				"createtime","updateby","updatetime","orgname","routeid","vehicleid" }, dispatchServiceDao.qryvehiclerouteset(buildFromHttpRequest),
				new Object[] {
				Long.class, String.class, String.class, String.class,
						Timestamp.class, String.class,Timestamp.class,String.class,Long.class,Long.class });
	}
	@Override
	public List<Map<String, Object>> qryroutebyvid(Long vehicleid){
		return ListUtil.listToMap(new Object[] { Route.class,"isselect" }, dispatchServiceDao.qryroutebyvid(vehicleid),
				new Object[] {Route.class,boolean.class });
	}

	@Override
	public List qryAutoReport(List<PropertyFilter> buildFromHttpRequest) {
		return ListUtil.listToMap(new Object[] { 
				"vehicleid","vehicleno", "unitid", "unitname", "cardno" }, 
				dispatchServiceDao.qryAutoReport(buildFromHttpRequest),
				new Object[] {
				Long.class, String.class, Long.class, String.class, String.class });
	}

	@Override
	public String showExaminCheck(long vehicleid,long orgid, long driverid, long driver1id,
			long stewardid, Date departdate,long scheduleid) throws Exception {
		String returnstr="";
		//校验进站检查是否有记录
		String arrivercheck = dispatchServiceDao.findArriveStationCheck(vehicleid,departdate,orgid,driverid,driver1id,scheduleid);
		returnstr +=arrivercheck;
		//校验五证三险一卡有效期检查是否通过
		String certificatecheck = dispatchServiceDao.findcertificate(vehicleid,departdate,orgid);   
		returnstr +=certificatecheck;
		return returnstr;
	}
	@Override
	public int checkUnitPermisssion(Long vehicleid, String unitflag)
			throws Exception {
		int vehicleSize = 0;
		if("1".equals(unitflag)){//只能报本司车辆
			vehicleSize = dispatchServiceDao.findOwnUnitPermission(vehicleid);
		}else if("2".equals(unitflag)){
			vehicleSize = dispatchServiceDao.findOutUnitPermission(vehicleid);
		}else{
			vehicleSize = 1;
		}
		return vehicleSize;
	}
	
	// 创建执行票价表
	private Ticketprice createNewTicketprice(Ticketprice ticketpricetem,
			List list) {
		Ticketprice ticketprice = new Ticketprice();
		ticketprice.setAutocancelreserveseatnum(ticketpricetem
				.getAutocancelreserveseatnum());
		ticketprice.setBalancedistance(ticketpricetem.getBalancedistance());
		ticketprice.setCreateby(ticketpricetem.getCreateby());
		ticketprice.setCreatetime(new Date());
		ticketprice.setDepartdate(ticketpricetem.getDepartdate());
		ticketprice.setDepartstationid(ticketpricetem.getDepartstationid());
		ticketprice.setDepartstationname(ticketpricetem.getDepartstationname());
		ticketprice.setDistance(ticketpricetem.getDistance());
		ticketprice.setFixedreserveseatnum(ticketpricetem
				.getFixedreserveseatnum());
		ticketprice.setFueladditionfee(ticketpricetem.getFueladditionfee());
		ticketprice.setFullprice(ticketpricetem.getFullprice());
		ticketprice.setHalfprice(ticketpricetem.getHalfprice());
		ticketprice.setIssellable(ticketpricetem.getIssellable());
		ticketprice.setLowerlimitprice(ticketpricetem.getLowerlimitprice());
		ticketprice.setMoreprice(ticketpricetem.getMoreprice());
		ticketprice.setOpertype(ticketpricetem.getOpertype());
		ticketprice.setOrgid(ticketpricetem.getOrgid());
		ticketprice.setReachstationid(ticketpricetem.getReachstationid());
		ticketprice.setReachstationname(ticketpricetem.getReachstationname());
		ticketprice.setRuntime(ticketpricetem.getRuntime());
		ticketprice.setScheduleid(ticketpricetem.getScheduleid());
		ticketprice.setScheduleplan(ticketpricetem.getScheduleplan());
		ticketprice.setScheduleplanid(ticketpricetem.getScheduleplanid());
		ticketprice.setSeatnos(ticketpricetem.getSeatnos());
		ticketprice.setSeatnum(ticketpricetem.getSeatnum());
		ticketprice.setSeattype(ticketpricetem.getSeattype());
		ticketprice.setSoldeatnum(ticketpricetem.getSoldeatnum());
		ticketprice.setStationservicefee(ticketpricetem.getStationservicefee());
		ticketprice.setStudentprice(ticketpricetem.getStudentprice());
		ticketprice.setTicketpriceitemlist(list);
		ticketprice.setToplimitprice(ticketpricetem.getToplimitprice());
		ticketprice.setUnautocancelreserveseatnum(ticketpricetem
				.getUnautocancelreserveseatnum());
		ticketprice.setUpdateby(ticketpricetem.getUpdateby());
		ticketprice.setUpdatetime(new Date());
		return ticketprice;
	}
	public static void sortIntMethod(List list){  
	    Collections.sort(list, new Comparator(){  
	        public int compare(Object o1, Object o2) {  
	            Scheduleseats ss1=(Scheduleseats)o1;  
	            Scheduleseats ss2=(Scheduleseats)o2;  
	            if(ss1.getSeatno()>ss2.getSeatno()){  
	                return 1;  
	            }else if(ss1.getSeatno()==ss2.getSeatno()){  
	                return 0;  
	            }else{  
	                return -1;  
	            }  
	        }             
	    });  
	    System.out.println("/////////////排序之后///////////////");  
	    for(int i=0;i<list.size();i++){  
	    	Scheduleseats st=(Scheduleseats)list.get(i);  
	        play.Logger.info("st.seatno="+st.getSeatno());  
	    }  
	}
	
	/**
	 * 用来查询要更新的ticketsell 记录
	 */
	private Ticketsell getTicketsell(long scheduleplanid, short seatno) {
		return dispatchServiceDao.getTicketsell(scheduleplanid, seatno);
	}
	//用来判断是否是两种座位类型并且两种座位类型都不相同  liyi 20160512
    public boolean isequalBothtwoseattypes(Vehiclereport vehiclereport)
    {boolean result = false;
	// 获取计划车型作为类型和已售座位数
	List<Map<String, Object>> planSeattypeAndSoldnumlist = dispatchServiceDao
			.qryPlanseattypeAndSoldnum(vehiclereport.getScheduleplanid());
	List<Map<String, Object>> reportSeattypeAndseatnum = dispatchServiceDao
			.qryreportseattypeAndnums(vehiclereport);
	// 只有当计划车和报到车都是两种座位类型时候才考虑（暂时只考虑两种座位类型完全相同的）
	if (planSeattypeAndSoldnumlist.size() == 2
			&& reportSeattypeAndseatnum.size() == 2) {
		// 计划的
		Map<String, Object> plantypeAndsoldnummap = planSeattypeAndSoldnumlist
				.get(0);
		Map<String, Object> plantypeAndsoldnummap1 = planSeattypeAndSoldnumlist
				.get(1);
		// 报到的
		Map<String, Object> reporttypeAndseatsmap = reportSeattypeAndseatnum
				.get(0);
		Map<String, Object> reporttypeAndseatsmap1 = reportSeattypeAndseatnum
				.get(1);
		if (!plantypeAndsoldnummap.get("seattype").equals(
				reporttypeAndseatsmap.get("seattype"))
				&& !plantypeAndsoldnummap1.get("seattype").equals(
						reporttypeAndseatsmap1.get("seattype"))&&!plantypeAndsoldnummap.get("seattype").equals(
								reporttypeAndseatsmap1.get("seattype"))
								&& !plantypeAndsoldnummap1.get("seattype").equals(
										reporttypeAndseatsmap.get("seattype"))) {
				result = true;
		} else {
				result = false;
		}

	}
	return result;
    }
    public Scheduleseats createScheseats(Scheduleseats sseats)
    {
    	Scheduleseats resseat = new Scheduleseats();
    	resseat.setDepartdate(sseats.getDepartdate());
    	resseat.setOrgid(sseats.getOrgid());
    	resseat.setScheduleid(sseats.getScheduleid());
    	resseat.setScheduleplan(sseats.getScheduleplan());
    	resseat.setStatus(sseats.getStatus());
    	resseat.setTickettype(sseats.getTickettype());
    	resseat.setSeattype(sseats.getSeattype());
    	resseat.setSeatno(sseats.getSeatno());
    	resseat.setCreateby(sseats.getCreateby());
    	resseat.setUpdateby(sseats.getUpdateby());
    	resseat.setCreatetime(new Date());
    	resseat.setUpdatetime(new Date());
    	
    	return resseat;
    }
  //20160627 liyi 用来处理自动取消留位和非自动取消留位
	public boolean updateSeatReserve(List<Scheduleseats> list)
	{
		boolean result = false;
		Long scheduleplanid = list.get(0).getScheduleplan().getId();
		//先查询出Seatreserve对象中的list
		SeatreserveDao reserdao = new SeatreserveDao();
		//用来
		List<Seatreserve> reservelist = reserdao.getreservelist(scheduleplanid);
		//删除多余的留位记录
		int index=0;
		for(Scheduleseats sseat : list)
		{
			if("4".equals(sseat.getStatus())||"5".equals(sseat.getStatus()))
			{
				if(index<reservelist.size())
				{
					reservelist.get(index).setSeatno(sseat.getSeatno());
					index++;
				}
			}
		}
		for(Seatreserve sreser : reservelist)
		{
			dispatchServiceDao.getEntityManager().merge(sreser);
		}
		
		return result;
	}
	//liyi 20160319 更新此方法，来处理报到时候留位
	private void updateScheduleSeates(List<Scheduleseats> scheduleseatslist,String reservedseatnums) {
	//修改此处逻辑为从后往前保存，未来保存留位信息  liyi 20160319
		SeatreserveService reserveservice = new SeatreserveServiceImpl();
		Scheduleseats scheduleseat = scheduleseatslist.get(0);
		int count = 0;//用来判断当前留位是否已经满足要预留座位数
		int reseveredcount = 0;//用来查询当前已经有多少个留位
		int needreseveredcount = 0;
		String seatnos = "";//用来拼接要留的座位号  如下形式：2，3，4，5
		
		//用来判断当前已有多少个空位，计算出当前需要留位的个数
		for(int j=0;j<scheduleseatslist.size();j++)
		{
			if(scheduleseatslist.get(j).getStatus().equals("5"))
				reseveredcount++;
		}
		if(reservedseatnums==null||reservedseatnums.length()==0){
			needreseveredcount=0;
		}else{
			needreseveredcount = Integer.valueOf(reservedseatnums)-reseveredcount;
		}
		for (int i = scheduleseatslist.size()-1; i >=0 ; i--) {
			Scheduleseats ss = scheduleseatslist.get(i);
			//空位状态改成不自动取消留位
			if("0".equals(ss.getStatus())&&count<needreseveredcount)
			{
				ss.setStatus("5");
				seatnos = seatnos + ss.getSeatno() +",";
				count++;
				play.Logger.info(ss.getDepartdate() + "--" + ss.getScheduleid() + "--" + ss.getSeatno()+"--"+ss.getStatus());
			}
//			dispatchServiceDao.merge(ss);
		}
		for (int i = 0; i <scheduleseatslist.size() ; i++) {
			Scheduleseats ss = scheduleseatslist.get(i);
			dispatchServiceDao.merge(ss);
		}
//		dispatchServiceDao.getEntityManager().flush();
		//20160319 liyi 用来操作留位seatreserve表
		List<Seatreserve> seatreserves = new ArrayList<Seatreserve>();//用来存放留位对象的list
		if(seatnos.split(",").length>1)
		{
			for(int i=0;i<seatnos.split(",").length;i++)
			{
				//用来操作留位
				Seatreserve seatreserve = createSeatreserve();
				seatreserve.setScheduleid(scheduleseat.getScheduleid());
				seatreserve.setScheduleplanid(scheduleseat.getScheduleplan().getId());
				seatreserve.setDeparttime(scheduleseat.getScheduleplan().getStarttime());
				seatreserve.setOrgid(scheduleseat.getOrgid());
				seatreserve.setDepartdate(scheduleseat.getDepartdate());
				seatreserve.setSeatno(new Short(seatnos.split(",")[i]));
				seatreserves.add(seatreserve);
			}
			dao.getEntityManager().getTransaction().commit();
			reserveservice.save(seatreserves);
		}
		
	}
	//20160319 liyi 创建留位对象 Seatreserve，用来处理报到时候留位
	public Seatreserve createSeatreserve()
	{
		Global global = CurrentUtil.getGlobal();
		Seatreserve seatreserve = new Seatreserve();
		Date now = new Date();
		seatreserve.setReserveby(global.getUserinfo().getId());
		seatreserve.setReserveip(global.getIpAddress());
		seatreserve.setCreateby(global.getUserinfo().getId());
		seatreserve.setUpdateby(global.getUserinfo().getId());
		seatreserve.setReserveway("0");// 留位
		seatreserve.setSellstate("R");
		seatreserve.setServiceprice(new BigDecimal(0.00));
		seatreserve.setCarrychildnum((byte)0);
		seatreserve.setTicketoutletsid(global.getTicketoutlets().getId());
		seatreserve.setIsautocancel(false);
		seatreserve.setTurnoverdetail(null);
		seatreserve.setCreatetime(now);
		seatreserve.setUpdatetime(now);
		seatreserve.setReservetime(now);
		seatreserve.setOrgid(global.getOrganization().getId());
		
		return seatreserve;
	}
	/**
	 * 新增判断当前计划车辆座位类型和报到车辆座位类型一致，判断计划车每种座位类型已售和报到车此种座位类型数量进行比较,如果大于则不允许报班
	 */
	private boolean IsPemissionReportbySeattype(Vehiclereport vehiclereport) {
		boolean result = false;
		// 获取计划车型作为类型和已售座位数
		List<Map<String, Object>> planSeattypeAndSoldnumlist = dispatchServiceDao
				.qryPlanseattypeAndSoldnum(vehiclereport.getScheduleplanid());
		List<Map<String, Object>> reportSeattypeAndseatnum = dispatchServiceDao
				.qryreportseattypeAndnums(vehiclereport);
		// 只有当计划车和报到车都是两种座位类型时候才考虑（暂时只考虑两种座位类型完全相同的）
		if (planSeattypeAndSoldnumlist.size() == 2
				&& reportSeattypeAndseatnum.size() == 2) {
			// 计划的
			Map<String, Object> plantypeAndsoldnummap = planSeattypeAndSoldnumlist
					.get(0);
			Map<String, Object> plantypeAndsoldnummap1 = planSeattypeAndSoldnumlist
					.get(1);
			// 报到的
			Map<String, Object> reporttypeAndseatsmap = reportSeattypeAndseatnum
					.get(0);
			Map<String, Object> reporttypeAndseatsmap1 = reportSeattypeAndseatnum
					.get(1);
			if (plantypeAndsoldnummap.get("seattype").equals(
					reporttypeAndseatsmap.get("seattype"))
					&& plantypeAndsoldnummap1.get("seattype").equals(
							reporttypeAndseatsmap1.get("seattype"))) {
				int soldnum1 = Integer.parseInt(plantypeAndsoldnummap.get(
						"soldnum").toString());
				int soldnum2 = Integer.parseInt(plantypeAndsoldnummap1.get(
						"soldnum").toString());

				int seatnum1 = reporttypeAndseatsmap.get("seats").toString()
						.split(",").length;
				int seatnum2 = reporttypeAndseatsmap1.get("seats").toString()
						.split(",").length;
				if (soldnum1 > seatnum1 || soldnum2 > seatnum2)// 已售数大于报到车对应座位类型数量，返回true，true时抛异常不允许报到
				{
					result = true;
				}// todo 暂时先知考虑这一种不能报班的情况
				else
					result = false;
			} else if (plantypeAndsoldnummap.get("seattype").equals(
					reporttypeAndseatsmap1.get("seattype"))
					&& plantypeAndsoldnummap1.get("seattype").equals(
							reporttypeAndseatsmap.get("seattype"))) {
				int soldnum1 = Integer.parseInt(plantypeAndsoldnummap.get(
						"soldnum").toString());
				int soldnum2 = Integer.parseInt(plantypeAndsoldnummap1.get(
						"soldnum").toString());

				int seatnum1 = reporttypeAndseatsmap.get("seats").toString()
						.split(",").length;
				int seatnum2 = reporttypeAndseatsmap1.get("seats").toString()
						.split(",").length;
				if (soldnum1 > seatnum2 || soldnum2 > seatnum1)// 已售数大于报到车对应座位类型数量，返回true，true时抛异常不允许报到
				{
					result = true;
				}// todo 暂时先知考虑这一种不能报班的情况
				else
					result = false;
			}
			// Map.Entry<String, String> map = (Entry<String, String>)
			// plantypeAndsoldnummap.entrySet();

		}
		return result;
	}
	/**
	 * 修改座位重构（增加上下铺票价价格）
	 * @param scheduleplan
	 * @param seatnum
	 * @param createby
	 * @param overload
	 * @throws ServiceException
	 */
	@SuppressWarnings("unchecked")
	private void changeSeats(Scheduleplan scheduleplan, short seatnum,
			long createby,String overload) throws ServiceException {
		// 若是非流水班次
		if (!scheduleplan.getIslinework()) {
			scheduleplan.setSeatnum(seatnum);
			// 报到车辆座位数小于班次座位数
			if (seatnum >= scheduleplan.getSoldeatnum()
					&& seatnum <= scheduleplan.getSeatnum()) {
				List<Scheduleseats> sst = scheduleplan.getScheduleseatslist();
				int fixseat = 0;
				int delfixseat = 0;
				int unautoseat = 0;
				int autoseat = 0;
				List<Short> soldseats = new ArrayList<Short>();
				List<Short> autoseats = new ArrayList<Short>();
				List<Short> unautoseats = new ArrayList<Short>();
				// 遍历班次座位，将班次座位数改为报到车辆的座位数
				Iterator<Scheduleseats> it = sst.iterator();
				while (it.hasNext()) {
					Scheduleseats ss = it.next();
					if (ss.getSeatno() > seatnum) {
						if (ss.getStatus().equals("2")) {
							/**
							 * 若车站的座位数大于车辆报到的实际座位个数 并且其中有已售的座位 则不允许报到
							 * 姜蓥瑞2015年8月19日11:15:51
							 */
							throw new ServiceException("6117");
							// soldseats.add(ss.getSeatno());
						} else if (ss.getStatus().equals("3")) {
							fixseat++;
						} else if (ss.getStatus().equals("4")) {
							autoseat++;
							autoseats.add(ss.getSeatno());
						} else if (ss.getStatus().equals("5")) {
							unautoseat++;
							unautoseats.add(ss.getSeatno());
						}
						dispatchServiceDao.delete(ss);
						it.remove();
					}
				}

				boolean isqryseat = false;

				for (int i = 0; i < fixseat; i++) {
					isqryseat = false;
					// 改到空座上
					for (Scheduleseats aa : sst) {
						if (aa.getSeatno() <= seatnum&& aa.getStatus().equals("0")) {
							// 找到空座
							isqryseat = true;
							aa.setStatus("3");
							aa.setUpdateby(createby);
							aa.setUpdatetime(new Date());
							break;
						}
					}
					if (!isqryseat) {
						delfixseat++;
						// 报到车辆未找到可固定留位的空座，不允许报到！
						// throw new ServiceException("0376");
					}
				}
				for (short seatno : autoseats) {
					isqryseat = false;
					// 改到空座上
					for (Scheduleseats aa : sst) {
						if (aa.getSeatno() <= seatnum&& aa.getStatus().equals("0")) {
							Seatreserve seatreserve = seatreserveService.getSeatreserve
									(scheduleplan.getId(),scheduleplan.getDepartdate(),seatno);
							if (seatreserve != null) {
								seatreserve.setSeatno(aa.getSeatno());
								seatreserve.setUpdateby(createby);
								seatreserve.setUpdatetime(new Date());
								dispatchServiceDao.merge(seatreserve);
							}
							// 找到空座
							isqryseat = true;
							aa.setStatus("4");
							aa.setUpdateby(createby);
							aa.setUpdatetime(new Date());
							break;
						}
					}
					if (!isqryseat) {
						// 报到车辆未找到自动取消留位的空座，不允许报到！
						throw new ServiceException("0377");
					}
				}

				// 增加参数控制：将固定座位修改到空座上还是直接截断 0、不截断，1、截断。 李电志 2015年6月9日 09:47:40
				String isTrunc = parameterService.findParamValue("3035",
						scheduleplan.getOrgid());
				if ("1".equals(isTrunc)) {// 截断 修改自动取消留位数
					scheduleplan
							.setUnautocancelreserveseatnum((short) (scheduleplan
									.getUnautocancelreserveseatnum() - unautoseat));
					// 更新班次计划表
					// dispatchServiceDao.merge(scheduleplan);
				}
				// for (int i = 0; i < unautoseat; i++) {
				if ("0".equals(isTrunc)) {// 0的值 不截断
					for (short seatno : unautoseats) {
						isqryseat = false;
						// 改到空座上
						for (Scheduleseats ss : sst) {
							if (ss.getSeatno() <= seatnum
									&& ss.getStatus().equals("0")) {
								Seatreserve seatreserve = seatreserveService
										.getSeatreserve(scheduleplan.getId(),
												scheduleplan.getDepartdate(),
												seatno);
								if (seatreserve != null) {
									seatreserve.setSeatno(ss.getSeatno());
									seatreserve.setUpdateby(createby);
									seatreserve.setUpdatetime(new Date());
									dispatchServiceDao.merge(seatreserve);
								}
								// 找到空座
								isqryseat = true;
								ss.setStatus("5");
								ss.setUpdateby(createby);
								ss.setUpdatetime(new Date());
								break;
							}
						}
						if (!isqryseat) {
							// 报到车辆未找到不自动取消留位的空座，不允许报到！
							throw new ServiceException("0378");
						}
					}
				}

				if (delfixseat > 0) {
					scheduleplan.setFixedreserveseatnum((short) (scheduleplan.getFixedreserveseatnum() - delfixseat));
				}
				scheduleplan.setSeatnum(seatnum);
				scheduleplan.setUpdateby(createby);
				scheduleplan.setUpdatetime(new Date());
				dispatchServiceDao.merge(scheduleplan);

			}
			// 若报到车辆座位数大于班次座位数，则改变班次座位数
			else if (seatnum > scheduleplan.getSeatnum()) {
				scheduleplan.setUpdateby(createby);
				scheduleplan.setUpdatetime(new Date());
				dispatchServiceDao.merge(scheduleplan);
			}
		}
	}
	
	public MethodResult updateSeattypetoAll(Vehiclereport vehiclereport,
			Global global,String reservedseatnums) throws ServiceException {
		// 报到车型和计划车型不一致时候是否修改计划车型及对应票价
		MethodResult result = new MethodResult();
		Long schedulePlanceId = vehiclereport.getScheduleplanid();// 班次计划ID
		Vehicle vehicle = (Vehicle) dispatchServiceDao.get(Vehicle.class,
				vehiclereport.getVehicleid());
		//对Scheduleplan加锁
		Scheduleplan splan = dispatchServiceDao.findScheduleseats(schedulePlanceId);
		if ("1".equals(parameterService.findParamValue("9050", global
				.getOrganization().getId()))) {
			List<Scheduleseats> scheduleseatlist = null;
			if (splan==null){
				result.setResult(0);
				result.setResultMsg("班次计划不存在！");
				return result;
			}else{
				scheduleseatlist = splan.getScheduleseatslist();
			}
			
			Schedule schedule = (Schedule) dispatchServiceDao.get(
					Schedule.class, vehiclereport.getScheduleid()); // 班次
			//获取已售、留位、固定留位数
			int soldandreservernum = splan.getSoldeatnum()+splan.getAutocancelreserveseatnum()
					+splan.getUnautocancelreserveseatnum()+splan.getFixedreserveseatnum();
			//如果报到车辆的总座位数小于已售、留位、固定留位的和，则不更新。
			if(soldandreservernum>vehicle.getSeatnum()){
				result.setResult(0);
				result.setResultMsg("该班次的已售已留数大于报到车辆的总座位数，不允许报到！");
				return result;
			}
			//校验售票记录中最大座位号是否大于报到车辆的总坐位数
			List<Ticketsell> ticketselllist =dispatchServiceDao.findTicketsells(schedulePlanceId);
			if(ticketselllist!=null&&ticketselllist.size()>0){
				if(ticketselllist.get(ticketselllist.size()-1).getSeatno()>vehicle.getSeatnum()){
					result.setResult(0);
					result.setResultMsg("该班次已售最大座位号大于报到车辆的总座位数，不允许报到！");
					return result;
				}
			}
			// 根据报到车辆得到报到车辆的座位类型，车型，硬调票价
			List<Handprice> handpricelist = dispatchServiceDao.findHandprices(schedule,vehicle);
			if(handpricelist==null||handpricelist.size()==0){
				//没有硬调票价就至修改座位数，不修改票价以及座位类型by lck 20161130
				changeSeats(splan, vehicle.getSeatnum(), vehiclereport.getCreateby());
				result.setResult(1);
				result.setResultMsg("报到车辆对应的硬调票价未设置，不修改票价！");
				return result;
			}
			//校验固定留位最大座位号是否大于报到车辆总坐位数
			int maxfixSeatno = dispatchServiceDao.findScheduleseatreserver(schedulePlanceId);
			if(maxfixSeatno>vehicle.getSeatnum()){
				result.setResult(0);
				result.setResultMsg("该班次固定留位最大座位号大于报到车辆的总座位数，不允许报到！");
				return result;
			}
			//对坐位图进行排序
			sortIntMethod(scheduleseatlist);
			List<Seatreserve> seatreserverlist = dispatchServiceDao.findSeatreserves(schedulePlanceId);
			//对留位记录进行移位操作---begin
			play.Logger.info("----对座位状态表和留位表进行移位开始-----");
			//查出留位表中大于报到班次总座位数的记录 ，保存到临时list中
			List<Seatreserve> srlist = new ArrayList<Seatreserve>();
			Iterator srit = seatreserverlist.iterator();
			while (srit.hasNext()) {
				Seatreserve sr = (Seatreserve) srit.next();
				if(sr.getSeatno()>vehicle.getSeatnum()){
					srlist.add(sr);
				}
			}
			
			//如果存在记录，则为小车报大班,直接进行移位操作
			//记录移位操作，例如 10——3号座
			Map<Short,Short> map = new HashMap<Short,Short>();
			for (Seatreserve sr : srlist) {
				for (Scheduleseats ss : scheduleseatlist) {
					if("0".equals(ss.getStatus())){
						map.put(sr.getSeatno(), ss.getSeatno());
						play.Logger.info("---原座位"+sr.getSeatno()+"移动至空位"+ss.getSeatno());
						if(sr.isIsautocancel()){
							ss.setStatus("4");
						}else{
							ss.setStatus("5");
						}
						break;
					}
				}
			}
			//修改留位表记录
			for (Map.Entry<Short,Short> entry : map.entrySet()) { 
				for (Seatreserve sr : seatreserverlist) {
					if(sr.getSeatno()==entry.getKey()){
						sr.setSeatno(entry.getValue());
						break;
					}
				}
			}
			play.Logger.info("----对座位状态表和留位表进行移位结束-----");
			//如果小车报大班，则删除多余座位
			if(scheduleseatlist.size()>vehicle.getSeatnum()){
				Iterator it = scheduleseatlist.iterator();
				while (it.hasNext()) {
					Scheduleseats ss = (Scheduleseats) it.next();
					if(ss.getSeatno()>vehicle.getSeatnum()){
						dispatchServiceDao.getEntityManager().remove(ss);
						it.remove();
					}
				}
			}else{//否则，添加新的座位信息
				int scheduleseatAddSize = vehicle.getSeatnum()-scheduleseatlist.size();
				int maxseatno =scheduleseatlist.size();
				for (int k = 1; k <= scheduleseatAddSize; k++)// 报到车辆座位数多余计划车辆，且只有一种座位类型
				{
					int seatNo = maxseatno+k;
					Scheduleseats scheduleseats = new Scheduleseats();
					scheduleseats.setDepartdate(scheduleseatlist.get(0).getDepartdate());
					scheduleseats.setOrgid(scheduleseatlist.get(0).getOrgid());
					scheduleseats.setScheduleid(scheduleseatlist.get(0).getScheduleid());
					scheduleseats.setScheduleplan(scheduleseatlist.get(0).getScheduleplan());
					scheduleseats.setStatus("0");
					scheduleseats.setSeatno((short) seatNo);
					scheduleseats.setSeattype("0");//先默认为0
					scheduleseats.setCreateby(scheduleseatlist.get(0).getCreateby());
					scheduleseats.setUpdateby(scheduleseatlist.get(0).getUpdateby());
					scheduleseats.setCreatetime(new Date());
					scheduleseats.setUpdatetime(new Date());
					scheduleseatlist.add(scheduleseats);
				}
			}
			dispatchServiceDao.merge(splan);
			dispatchServiceDao.getEntityManager().flush();

			
			// 得到要更新的执行票价
			List<Ticketprice> ticketpricelist = splan.getTicketpricelist();
			int oldseattypenum = 1;//原座位类型的个数
			if(ticketpricelist!=null&&ticketpricelist.size()>0){
				String seattpe = ticketpricelist.get(0).getSeattype();
				List<String> list = new ArrayList<String>();
				list.add(seattpe);
				Iterator it = ticketpricelist.iterator();
				while (it.hasNext()) {
					Ticketprice tp = (Ticketprice) it.next();
					if(list.indexOf(tp.getSeattype())==-1){//计算老的座位类型的个数
						list.add(tp.getSeattype());
						oldseattypenum+=1;
					}
					dispatchServiceDao.getEntityManager().remove(tp);
					it.remove();
				}
				dispatchServiceDao.merge(splan);//删除执行票价
				dispatchServiceDao.getEntityManager().flush();
			}

			GenTicketpriceByHandpriceService genticketserver = new GenTicketpriceByHandpriceServiceImpl();
			//重新按硬调票价生成新报到车辆对应的执行票价
			ticketpricelist=genticketserver.genTicketprice(handpricelist, splan, global, schedule, 
					vehicle.getVehicletypeid(), vehicle.getSeatnum());
			if(ticketpricelist==null||ticketpricelist.size()==0){
				result.setResult(0);
				result.setResultMsg("修改执行票价失败！");
				return result;
			}
			//取出不同座位类型对应的终点站的票价信息，保存到seattypelist 中
			List<Ticketprice> seattypelist = new ArrayList<Ticketprice>();
			for (Ticketprice tp : ticketpricelist) {
				if(tp.getScheduleid()==splan.getScheduleid()&&tp.getDepartdate()==splan.getDepartdate()
						&&tp.getDepartstationid()==splan.getStartstationid()&&tp.getReachstationid()==splan.getEndstationid()){
					seattypelist.add(tp);
				}
			}
			//修改售票表、班次状态表、留位表中的坐位状态
			for (Ticketprice tp : seattypelist) {
				if("0".equals(tp.getSeatnos())||"全部".equals(tp.getSeatnos())){
					for (Ticketsell ts : ticketselllist) {
						ts.setSeattype(tp.getSeattype());
						dispatchServiceDao.merge(ts);
					}
					for (Seatreserve sr : seatreserverlist) {
//						sr.setSeattype(tp.getSeattype());
						dispatchServiceDao.merge(sr);
					}
					for (Scheduleseats ss : scheduleseatlist) {
						ss.setSeattype(tp.getSeattype());
					}
				}else{
					String seats = tp.getSeatnos();
					String[] seatnos =seats.split(",");
					List list = Arrays.asList(seatnos);  
					//记录每种坐位类型的已售、留位数
					short soldnum = 0;
					short autonum = 0;
					short unautonum = 0;
					short fixednum = 0;
					//处理售票记录开始---------------------------------------------
					for (Ticketsell ts : ticketselllist) {
						//如果票价表的坐位字符串包含售票记录的座位号，则更新售票表坐位类型
						if((list.indexOf(ts.getSeatno()+""))!=-1){
							if(!(oldseattypenum>=2&&seattypelist.size()>=2)){//oldseattypenum>=2&&seattypelist.size()>=2,这种情况下面单独处理
								ts.setSeattype(tp.getSeattype());
								dispatchServiceDao.merge(ts);
								soldnum +=1;
							}else{
								soldnum +=1;//多种座位类型到多种的，先赋初始值，后面移位后重新计算
							}
						}
					}
					//处理售票记录结束---------------------------------------------
					for (Seatreserve sr : seatreserverlist) {
						if((list.indexOf(sr.getSeatno()+""))!=-1){
//							sr.setSeattype(tp.getSeattype());  //可以不增加此字段，如果留位需要对应上下铺，则需要增加
							dispatchServiceDao.merge(sr);
							if(sr.isIsautocancel()){
								autonum+=1;
							}else{
								unautonum+=1;
							}
						}
					}
					for (Scheduleseats ss : scheduleseatlist) {
						if((list.indexOf(ss.getSeatno()+""))!=-1){
							ss.setSeattype(tp.getSeattype());
							if("3".equals(ss.getStatus())){
								fixednum+=1;
							}
						}
					}
					//根据不同座位类型，重新计算已售、留位数
					for (Ticketprice newtp : ticketpricelist) {
						if(newtp.getSeattype().equals(tp.getSeattype())){
							newtp.setSoldeatnum(soldnum);
							newtp.setAutocancelreserveseatnum(autonum);
							newtp.setUnautocancelreserveseatnum(unautonum);
							newtp.setFixedreserveseatnum(fixednum);
						}
					}
				}
			}
			//多种座位类型报多张时，需要对应座位类型进行移位操作，并重新计算已售数
			if(oldseattypenum>=2&&seattypelist.size()>=2){
				//移动坐位开始---------------------------------------------
				for (Ticketprice tp : seattypelist) {
					if(!"0".equals(tp.getSeatnos())&&!"全部".equals(tp.getSeatnos())){
						String seats = tp.getSeatnos();
						String[] seatnos =seats.split(",");
						List list = Arrays.asList(seatnos);  
						play.Logger.info("售票记录移位开始--------------------------");
						for (Ticketsell ts : ticketselllist) {
							//如果票价表的坐位字符串包含售票记录的座位号
							if((list.indexOf(ts.getSeatno()+""))!=-1){
								//如果售票记录的座位类型不同，则进行移位
								if(!ts.getSeattype().equals(tp.getSeattype())){
									boolean ismodify = false;//修改售票记录个数
									boolean isExistSeattype = false;//报到车辆的坐位类型是否包含售票记录中的坐位类型
									for (Ticketprice tptype : seattypelist) {
										if(ts.getSeattype().equals(tptype.getSeattype())){
											isExistSeattype =true;
											break;
										}
									}
									if(isExistSeattype){//如果包含则进行移位。否则不做处理，直接修改
										short needdelseatno =ts.getSeatno();
										for (Scheduleseats ss : scheduleseatlist) {
											if(needdelseatno==ss.getSeatno()){//原座位置为空座
												ss.setStatus("0");
												ss.setTickettype("");
												break;
											}
										}
										for (Scheduleseats ss : scheduleseatlist) {
											if(ss.getSeattype().equals(ts.getSeattype())){//移动到形同坐位类型的空位上
												if("0".equals(ss.getStatus())){
													play.Logger.info("售票记录移位：座位号："+ts.getSeatno()+" 移动至座位号："+ss.getSeatno());
													ts.setSeatno(ss.getSeatno());
													ss.setStatus(ts.getIschecked()?"7":"2");
													ss.setTickettype(ts.getTickettype());
													dispatchServiceDao.merge(ts);
													ismodify=true;
													break;
												}
											}
										}
										if(!ismodify){
											result.setResult(0);
											result.setResultMsg("相同座位类型余座不足，不能报班！");
											return result;
										}
									}else{//不包含的时候，直接修改坐位类型
										ts.setSeattype(tp.getSeattype());
										dispatchServiceDao.merge(ts);
									}
								}
							}
						}
						play.Logger.info("售票记录移位结束--------------------------");
					}
				}
				//移动坐位结束---------------------------------------------
				//重新计算多种到多种的座位类型的已售数-------------
				for (Ticketprice tp : seattypelist) {
					if(!"0".equals(tp.getSeatnos())&&!"全部".equals(tp.getSeatnos())){
						String seats = tp.getSeatnos();
						String[] seatnos =seats.split(",");
						List list = Arrays.asList(seatnos);  
						short soldnum = 0;
						for (Ticketsell ts : ticketselllist) {
							//如果票价表的坐位字符串包含售票记录的座位号，则更新售票表坐位类型
							if((list.indexOf(ts.getSeatno()+""))!=-1){
								ts.setSeattype(tp.getSeattype());
								dispatchServiceDao.merge(ts);
								soldnum +=1;
							}
						}
						//根据不同座位类型，重新计算已售、留位数
						for (Ticketprice newtp : ticketpricelist) {
							if(newtp.getSeattype().equals(tp.getSeattype())){
								newtp.setSoldeatnum(soldnum);
							}
						}
					}
				}
				//重新计算多种到多种的座位类型的已售数结束-------------
			}
			splan.setSeatnum(vehicle.getSeatnum());
			splan.setUpdatetime(new Date());
			splan.setTicketpricelist(ticketpricelist);
			dispatchServiceDao.merge(splan);
		}else{
			String ischangeseat = parameterService.findParamValue("2031", global.getOrganization().getId());
			if (ischangeseat.equals("1")) {
				changeSeats(splan, vehicle.getSeatnum(), vehiclereport.getCreateby());
			}
		}
		result.setResult(1);
		return result;
	}
	
	/**
	 * 修改司乘人员
	 */
	public MethodResult editDriverSteward(Global global, Vehiclereport vehiclereport) throws Exception {
		MethodResult methodResult = new MethodResult();
		
		Vehiclereport report = (Vehiclereport) dispatchServiceDao.get(LockModeType.PESSIMISTIC_READ, Vehiclereport.class, vehiclereport.getId());
		if(!report.getIsactive()){
			//验证该班次是否报到
			methodResult.setResult(MethodResult.FAILURE);
			methodResult.setResultMsg("该班次已取消报到，不允许修改司乘人员！");
			return methodResult;
		}
		Date date = new Date();
		report.setDriver1(vehiclereport.getDriver1());
		report.setDriver2(vehiclereport.getDriver2());
		report.setSteward1(vehiclereport.getSteward1());
		report.setUpdateby(global.getUserinfo().getId());
		report.setUpdatetime(date);
		
		try {
			report = (Vehiclereport) dispatchServiceDao.merge(report);
			methodResult = updateVehicledriverreport(report, global, date);//处理 车辆发/班登记表
			
		} catch (Exception e) {
			play.Logger.error("修改司乘人员失败：", e);
			methodResult.setResult(MethodResult.FAILURE);
			methodResult.setResultMsg("修改失败！");
		}
		return methodResult;
	}
	/**
	 * 处理 车辆发/班登记表
	 * @param vehiclereport
	 * @throws Exception 
	 */
	private MethodResult updateVehicledriverreport(Vehiclereport vehiclereport, Global global, Date date) throws Exception{
		List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
		filters.add(new PropertyFilter("EQL_t!vehiclereportid", vehiclereport.getId()));
		List<Vehicledriverreport> vdrList = dispatchServiceDao.find(Vehicledriverreport.class, filters);
		
		String vnotenum = "合格";//例检合格通知单。执行报班操作时，该字段取自报班页面的“安检结果”，前台可手动勾选。此处默认合格，若之前有司乘人员，则取之前司乘人员记录中该字段。
		if(vdrList != null && vdrList.size() > 0){
			//删除之前的司乘人员之前存在车辆发/应班登记表记录
			for (Vehicledriverreport vdr : vdrList) {
				vnotenum = vdr.getVnotenum();
				dispatchServiceDao.delete(vdr);
			}
		}
		
		filters.clear();
		filters.add(new PropertyFilter("EQL_t!id", vehiclereport.getVehicleid()));
		Vehicle reportvehicle = (Vehicle) dispatchServiceDao.find(Vehicle.class, filters).get(0);
		Schedulestatus schedulestatus = dispatchServiceDao.getSchedulestatus(vehiclereport.getScheduleplanid(), global.getStationID());
		Steward steward = null;
		if(vehiclereport.getSteward1() != null){
			steward = (Steward) dispatchServiceDao.get(Steward.class, vehiclereport.getSteward1().getId());
		}
		
		MethodResult methodResult = new MethodResult();
		methodResult.setResult(MethodResult.SUCCESS);
		methodResult.setResultMsg("修改成功！");//若没有添加驾驶员，则返回修改成功！
		
		if(vehiclereport.getDriver1() != null){
			//保存驾驶员1
			Driver driver = (Driver) dispatchServiceDao.get(Driver.class, vehiclereport.getDriver1().getId());
			play.Logger.info(vehiclereport.getId() + "该条报到记录，修改司乘人员1，原driver1=" + driver);
			methodResult = saveVehicledriverreport(vehiclereport, schedulestatus, global, driver, steward, reportvehicle, vnotenum, date);
			if(methodResult.getResult() == MethodResult.FAILURE){
				return methodResult;
			}
		}
		if(vehiclereport.getDriver2() != null){
			//保存驾驶员2
			Driver driver = (Driver) dispatchServiceDao.get(Driver.class, vehiclereport.getDriver2().getId());
			play.Logger.info(vehiclereport.getId() + "该条报到记录，修改司乘人员2，原driver2=" + driver);
			methodResult = saveVehicledriverreport(vehiclereport, schedulestatus, global, driver, steward, reportvehicle, vnotenum, date);
		}
		
		return methodResult;
	}
	/**
	 * 保存报班驾驶员记录：
	 * 		按参数是否开启来校验证件是否过期。
	 * 		校验参数：2030，
	 */
	private MethodResult saveVehicledriverreport(Vehiclereport vehiclereport,
			Schedulestatus schedulestatus, Global global, Driver driver,
			Steward steward, Vehicle reportvehicle, String vnotenum, Date date) throws Exception{
		MethodResult methodResult = new MethodResult();
		methodResult.setResult(MethodResult.SUCCESS);
		methodResult.setResultMsg("修改成功！");
		
		Vehicledriverreport vpd = new Vehicledriverreport();
		vpd.setClassmember(global.getUserinfo().getName());
		vpd.setCreateby(global.getUserinfo().getId());
		vpd.setCreatetime(date);
		
		//2030驾驶员证件过期是否允许报班，0不允许，1允许，默认为0
		boolean isNotCheckDriver = ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_2030,
				global.getOrganization().getId()));
		if(driver.getDrivinglicense() == null){
			vpd.setDdrivinglicenseres("合格");
		}else{
			if((util.DateUtils.compare(date, driver.getDrivinglicensestartdate()) >= 0)
					&& (util.DateUtils.compare(date, driver.getDrivinglicenseenddate()) <= 0)){
				vpd.setDdrivinglicenseres("合格");//驾驶证，取自驾驶员：驾驶证有效起止日期
			}else{
				if(isNotCheckDriver){
					vpd.setDdrivinglicenseres("不合格");
				}else{
					methodResult.setResult(MethodResult.FAILURE);
					methodResult.setResultMsg("2030参数设置为0，" + driver.getName() + "驾驶证已过期，不允许报班！");
					return methodResult;
				}
			}
		}
		if(driver.getQualification() == null){
			vpd.setDqualificationres("合格");
		}else{
			if((util.DateUtils.compare(date, driver.getQualificationstartdate()) >= 0)
					&& (util.DateUtils.compare(date, driver.getQualificationenddate()) <= 0)){
				vpd.setDqualificationres("合格");//从业资格证 合格，取自驾驶员：从业资格证起止日期
			}else{
				if(isNotCheckDriver){
					vpd.setDqualificationres("不合格");
				}else{
					methodResult.setResult(MethodResult.FAILURE);
					methodResult.setResultMsg("2030参数设置为0，" + driver.getName() + "从业资格证已过期，不允许报班！");
					return methodResult;
				}
			}
		}
		if(driver.getWorkno() == null){
			vpd.setDworknores("合格");
		}else{
			if((util.DateUtils.compare(date, driver.getWorkstartdate()) >= 0)
					&& (util.DateUtils.compare(date, driver.getWorkenddate()) <= 0)){
				vpd.setDworknores("合格");//上岗证(前台可勾选)，取自驾驶员：准驾证起止日期
			}else{
				if(isNotCheckDriver){
					vpd.setDworknores("不合格");
				}else{
					methodResult.setResult(MethodResult.FAILURE);
					methodResult.setResultMsg("2030参数设置为0，" + driver.getName() + "上岗证(准驾证)已过期，不允许报班！");
					return methodResult;
				}
			}
		}
		vpd.setDepartdate(vehiclereport.getDepartdate());
		vpd.setDispatcher(global.getUserinfo().getName());
		vpd.setDrivername(driver.getName());//驾驶员签名
		vpd.setDriversign(driver.getName());
		vpd.setOrgid(global.getUserinfo().getOrgid());//添加者所属组织机构id
		vpd.setRationseatnum(reportvehicle.getRationseatnum());//核载人数
		vpd.setReporttime(date);
		vpd.setScheduleid(vehiclereport.getScheduleid());
		if(steward != null){
			vpd.setStewardname(steward.getName());//乘务员
		}
		vpd.setUpdateby(global.getUserinfo().getId());
		vpd.setUpdatetime(date);
		
		//6002车辆安检时是否判断行驶证、保险的有效期，0不判断，1判断。由于车辆已报班，则此处不需要判断车辆是否可以报班，只需给出车辆相应证件是否在有效期内即可。
		if(reportvehicle.getDriverlicense() == null){
			vpd.setVdriverlicenseres("合格");
		}else{
			if((util.DateUtils.compare(date, reportvehicle.getLicensestartdate()) >= 0)
					&& (util.DateUtils.compare(date, reportvehicle.getLicenseenddate()) <= 0)){
				vpd.setVdriverlicenseres("合格");//行驶证 合格,取自车辆：行驶证起止日期
			}else{
				vpd.setVdriverlicenseres("不合格");
			}
		}
		vpd.setVehicleno(reportvehicle.getVehicleno());
		vpd.setVehiclereportid(vehiclereport.getId());
		vpd.setVnotenum(vnotenum);//例检合格通知单
		
		if(reportvehicle.getRoadno() == null){
			vpd.setVroadnores("合格");
		}else{
			if((util.DateUtils.compare(date, reportvehicle.getRoadstartdate()) >= 0)
					&& (util.DateUtils.compare(date, reportvehicle.getRoadenddate()) <= 0)){
				vpd.setVroadnores("合格");//线路标志牌,取自车辆：线路标志牌起止时间
			}else{
				vpd.setVroadnores("不合格");
			}
		}
		if(reportvehicle.getLiabilityinsureno() == null){
			vpd.setVworknores("合格");
		}else{
			if((util.DateUtils.compare(date, reportvehicle.getLiabilityinsurestartdate()) >= 0)
					&& (util.DateUtils.compare(date, reportvehicle.getLiabilityinsureenddate()) <= 0)){
				vpd.setVworknores("合格");//道路运输证,取自车辆:承运人责任险起止日期
			}else{
				vpd.setVworknores("不合格");
			}
		}
		
		vpd.setIsdeparted(false);
		vpd.setDeparttime(schedulestatus.getDeparttime());
		vpd.setScheduleplanid(vehiclereport.getScheduleplanid());
		vpd.setDriverid(driver.getId());
		dispatchServiceDao.merge(vpd);
		
		Securitycheck scd = dispatchServiceDao.querySecuritycheck(vehiclereport.getVehicleid(),vehiclereport.getDepartdate());
		if(scd != null){
			//修改安检驾驶员字段
			if(vehiclereport.getDriver1() != null){
				scd.setDriverid(vehiclereport.getDriver1().getId());
				scd.setUpdateby(global.getUserinfo().getId());
				scd.setUpdatetime(date);
				dispatchServiceDao.merge(scd);
			}else{
				if(vehiclereport.getDriver2() != null){
					scd.setDriverid(vehiclereport.getDriver2().getId());
					scd.setUpdateby(global.getUserinfo().getId());
					scd.setUpdatetime(date);
					dispatchServiceDao.merge(scd);
				}
			}
		}
		
		return methodResult;
	}
	
	/**
	 * 统计车载人数
	 * #11356：车载人数=实载人数（未发班则统计截止打印路单时的已售数，已发班则统计检票数）+报到驾驶员人数+报到乘务员人数
	 * @param stationid
	 * @param scheduleplanid
	 * @return
	 */
	public Integer coutVehicleLoadNum(Date printtime, Long stationid, Long scheduleplanid, Long vehiclereportid){
		return dispatchServiceDao.coutVehicleLoadNum(printtime, stationid, scheduleplanid, vehiclereportid).intValue();
	}
	
	/**
	 * 统计检票人数
	 */
	@Override
	public int countCheckednum(Long scheduleplanid) {
		Scheduleplan sp = (Scheduleplan) dispatchServiceDao.get(Scheduleplan.class, scheduleplanid);
		return dispatchServiceDao.countCheckednum(sp);
	}
	
	@Override
	public Vehiclereport queryVehiclereport(long vehiclereportid) {
		return (Vehiclereport) dispatchServiceDao.get(Vehiclereport.class, vehiclereportid);
	}
	
	@Override
	public Vehicle queryVehicle(long vehicleid) {
		return (Vehicle) dispatchServiceDao.get(Vehicle.class, vehicleid);
	}

	@Override
	public List<Map<String, Object>> qryLicenseByCode(String codes) {
		List<Object> list = dispatchServiceDao.qryLicenseByCode(codes);
		return ListUtil.listToMap(new Object[] {"id", "licensetype", "licensetypeid","code","orgid",
				"vehicleno","name","enddate","credentialsno","resultmsg"}, //车牌号，驾驶员姓名，证件截止日期，证件号码,审查结果
				list,
				new Object[] {Long.class,String.class,Long.class,String.class,Long.class,
				String.class,String.class,Date.class,String.class,String.class
		});
	}

	@Override
	public List<Map<String, Object>> qryDriverReport(String driverids,
			Date departdate) {
		if (driverids.startsWith(",")) {
			driverids = driverids.substring(1);
		}
		//查询已报班的司机
		List<Object[]> list = dispatchServiceDao.qryDriverReport(driverids,departdate);
		//查询司机
		List<String> driverList = dispatchServiceDao.qryDriver(driverids);
		Set set = new HashSet();
		//将所有司机的姓名进行返回，去重
		if (list != null && list.size() > 0) {
			for (Object[] obj : list) {
				for (int i=1; i <= 4; i++ ) {
					if ((String)obj[i] != null) {  //1,2,3,4号驾驶员
						for (String drivernameone : driverList) {  //避免没有在前台展示的驾驶员也提示
							if (drivernameone.equals((String)obj[i])) { 
								set.add(obj[i]);
							}
						}
					}
				}
			}
		}
		Iterator iterator = set.iterator();
		String driverNames = null;
		while (iterator.hasNext()) {
			if (driverNames == null) {
				driverNames = iterator.next().toString();
			} else {
				driverNames = driverNames + "," + iterator.next().toString();
			}
		}
		List listreturn = new LinkedList();
		if (driverNames != null) {
			String[] drivernamesplit = driverNames.split(",");
			for (String drivername : drivernamesplit) {
				listreturn.add(drivername);
			}		
		}
		return ListUtil.listToMap(new Object[] {"drivername"}, 
				listreturn,
				new Object[] {String.class});
	}
	
}
