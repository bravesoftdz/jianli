/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.price.service.impl<br/>
 * <b>文件名：</b>GenScheduleplanServiceImpl.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2011-7-11-下午02:20:45<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.price.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import models.ActionNode;
import util.Appvar;
import util.CommonUtil;
//import util.CurrentUtil;
import util.JsonUtil;
import util.RemoteApi;
import util.RpcUtil;
import util.SystemException;
import util.UserTransaction;
import cn.nova.bus.base.model.Cycleschemes;
import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Routestop;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Schedulelongstop;
import cn.nova.bus.base.model.Scheduleseatreserve;
import cn.nova.bus.base.model.Schedulestop;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Ticketentrance;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.base.model.Vehiclebrandmodel;
import cn.nova.bus.base.model.Vehiclepark;
import cn.nova.bus.base.model.Vehiclespace;
import cn.nova.bus.base.model.Vehicletype;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dispatch.model.Seatreserve;
import cn.nova.bus.dispatch.service.SeatreserveService;
import cn.nova.bus.dispatch.service.impl.SeatreserveServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.dao.GenScheduleplanServiceDao;
import cn.nova.bus.price.model.Fuelfeegradeapply;
import cn.nova.bus.price.model.Handholidayprice;
import cn.nova.bus.price.model.Handholidaypriceitem;
import cn.nova.bus.price.model.Handprice;
import cn.nova.bus.price.model.Handpriceitem;
import cn.nova.bus.price.model.Routeprice;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleplanlog;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Schedulevehiclepeopleplan;
import cn.nova.bus.price.model.Standardprice;
import cn.nova.bus.price.model.Standardpriceitem;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.price.model.Ticketpriceformulaitem;
import cn.nova.bus.price.model.Ticketpriceitem;
import cn.nova.bus.price.service.GenScheduleplanService;
import cn.nova.bus.price.service.RoutepriceService;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.service.TicketService;
import cn.nova.bus.sale.service.impl.TicketServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.service.OrganizationService;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.OrganizationServiceImpl;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.bus.util.PluginFunctionUtil;
import cn.nova.utils.commons.CollectionUtils;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;
/*import controllers.SchedulepresaleApply.dao.SchedulePreSaleapplyDao;
import controllers.SchedulepresaleApply.model.SchedulepresaleApply;*/

/**
 * <b>类描述：营运计划管理</b><br/>
 * <b>类名称：</b>GenScheduleplanServiceImpl<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：增加了票价差的对运营计划生产的影响</b><br/>
 * <b>修改时间：2012-02</b><br/>
 * <b>修改人：lck</b><br/>
 * <b>关键修改：修改生成加班班次的运营计划， 最大生成计划天数去自动生成运营计划天数，而非预售天数:line on 2076</b><br/>
 * <b>修改时间：2013-06-05</b><br/>
 * <b>修改人：hhz</b><br/>
 * 
 */

public class GenScheduleplanServiceImpl implements GenScheduleplanService {
	final private int insideInvokFalse = -67101735;
	
	private GenScheduleplanServiceDao genScheduleplanServiceDao = new GenScheduleplanServiceDao();
	
	private ParameterService parameterService = new ParameterServiceImpl();
	
	private OrganizationService organizationService = new OrganizationServiceImpl();
	
	private TicketService ticketService = new TicketServiceImpl();
	
	SeatreserveService seatreserveService = new SeatreserveServiceImpl();  //修改座位保留表
	
	private RoutepriceService routepriceService = new RoutepriceServiceImpl();
//	private SchedulePreSaleapplyDao schedulePreSaleapplyDao = new SchedulePreSaleapplyDao();//新增班次预售票dao,进行处理插入申请状态

	@Resource
	private UserTransaction userTransaction = new UserTransaction();
	private Long createby;
	private long orgid;
	private long vehicletypeid = 0;
	private short seatnum = 0;// 座位数
	private short leave = 0;// 剩余座位数
	private short lockseatnum = 0;// 锁位数
	private short fixedreserveseatnum = 0;// 固定留位数
	private short soldeatnum = 0;// 已售数
	private short autocancelreserveseatnum = 0;// 自动取消留位数
	private short unautocancelreserveseatnum = 0;// 不自动取消留位数
	private String result = "";
	private boolean isexisthandholidayprice = true;
	private boolean isstandardprice = false;
	private List<Schedulestop> departstoplist;// 班次上车点
	private List<Schedulestop> reachstoplist;// 班次停靠点
	private List<Routestop> routestoplist;// 线路停靠点
	private List<Handprice> handpricelist;
	private List<Handholidayprice> handholidaypricelist;
	//private List<Ticketprice> ticketpricelist = new ArrayList<Ticketprice>();
	private List<Object> scheduleplanloglist;
	private boolean iserror = false;
	private Vehicletype vehicletype;// 计划循环车型信息
	private Vehicle planvehicle;// 计划车辆
	private List<Schedulevehiclepeopleplan> schedulevehiclepeopleplans;
	private List<Schedulevehiclepeopleplan> schedulevehiclepeopleplanlist;//
	private Schedulevehiclepeopleplan schedulevehiclepeopleplan;// /
    private String pricerule="0";
	@Override
	public List<Map<String, Object>> generateScheduleplan(
			Scheduleplanlog scheduleplanlog) throws ServiceException {

		if ("D".equals(scheduleplanlog.getOperationtype())) {
			return delScheduleplan(scheduleplanlog);
		}
		if (scheduleplanlog.getStartdate().after(scheduleplanlog.getEnddate())) {
			new ServiceException("0054");
		}
		if (scheduleplanlog.getStartdate()
				.before(DateUtils.add(new Date(), -1))) {
			new ServiceException("0055");
		}
		scheduleplanloglist = new ArrayList<Object>();
		Date startdate = scheduleplanlog.getStartdate();
		Date enddate = scheduleplanlog.getEnddate();
		createby = scheduleplanlog.getUserid();

		vehicletype = new Vehicletype();
		int days = DateUtils.getIntervalDays(startdate, enddate);
		Date departdate = new Date();
		for (int i = 0; i <= days; i++) {
			departdate = DateUtils.add(startdate, i);
			List<Schedule> schedulelist = null;
			String departdatestr = StringUtils.dateToStr(departdate);
			if ("2".equals(scheduleplanlog.getType())) {
				// 按选中班次生成,scheduleplanlog.getScheduleids()=="(12,13)"
				schedulelist = genScheduleplanServiceDao
						.qrySchedule(scheduleplanlog.getScheduleids());
			} else if ("1".equals(scheduleplanlog.getType())) {
				schedulelist = genScheduleplanServiceDao.qryScheduleByroute(
						scheduleplanlog.getTypeid(), departdate);
			} else {
				schedulelist = genScheduleplanServiceDao.qryScheduleByOrg(
						scheduleplanlog.getTypeid(), departdate);
			}
			for (Schedule schedule : schedulelist) {
				pricerule = parameterService.findParamValue(ParamterConst.Param_1042,
						schedule.getOrgid());		
				MethodResult result = genScheduleplan(scheduleplanlog,
						schedule, departdate);
				if (result.getResult() == MethodResult.SUCCESS) {
					String s = schedule.getCode() + "班次：" + departdatestr
							+ "生成计划成功！";
					saveScheduleplanlog(scheduleplanlog, s, schedule.getId());
				}
			}// 循环班次

		}// 循环天数
		return ListUtil.listToMap(new Object[] { Scheduleplanlog.class },
				scheduleplanloglist, new Object[] { Scheduleplanlog.class });
	}

	// 删除已生成车辆驾乘人员计划信息
	private boolean delSchedulevehiclepeopleplan(Scheduleplan scheduleplan) {
		schedulevehiclepeopleplans = scheduleplan
				.getSchedulevehiclepeopleplanlist();
		for (Schedulevehiclepeopleplan schedulevehiclepeopleplan : schedulevehiclepeopleplans) {
			genScheduleplanServiceDao.getEntityManager().remove(
					schedulevehiclepeopleplan);
		}
		schedulevehiclepeopleplans.clear();
		genScheduleplanServiceDao.getEntityManager().flush();
		return true;
	}

	// 生成车辆驾乘人员计划信息
	private List<Schedulevehiclepeopleplan> saveSchedulevehiclepeopleplan(
			Scheduleplan scheduleplan) {
		List<Schedulevehiclepeopleplan> schedulevehiclepeopleplans = new ArrayList<Schedulevehiclepeopleplan>();
		Schedulevehiclepeopleplan curSchedulevehiclepeopleplan;
		for (Schedulevehiclepeopleplan obj : schedulevehiclepeopleplanlist) {
			curSchedulevehiclepeopleplan = addSchedulevehiclepeopleplan(
					scheduleplan, obj);
			schedulevehiclepeopleplans.add(curSchedulevehiclepeopleplan);
		}
		return schedulevehiclepeopleplans;
	}

	// 添加车辆驾乘人员计划信息
	private Schedulevehiclepeopleplan addSchedulevehiclepeopleplan(
			Scheduleplan scheduleplan, Schedulevehiclepeopleplan obj) {
		Schedulevehiclepeopleplan schedulevehiclepeopleplan = new Schedulevehiclepeopleplan();
		schedulevehiclepeopleplan.setScheduleplan(scheduleplan);
		schedulevehiclepeopleplan.setCreateby(createby);
		schedulevehiclepeopleplan.setCreatetime(new Date());
		schedulevehiclepeopleplan.setDepartdate(scheduleplan.getDepartdate());
		schedulevehiclepeopleplan.setOrderno(obj.getOrderno());
		schedulevehiclepeopleplan.setPlandriver1(obj.getPlandriver1());
		schedulevehiclepeopleplan.setPlandriver2(obj.getPlandriver2());
		schedulevehiclepeopleplan.setPlandriver3(obj.getPlandriver3());
		schedulevehiclepeopleplan.setPlandriver4(obj.getPlandriver4());
		schedulevehiclepeopleplan.setPlansteward1(obj.getPlansteward1());
		schedulevehiclepeopleplan.setPlansteward2(obj.getPlansteward2());
		schedulevehiclepeopleplan.setPlanvehiclebrandmodelid(obj
				.getPlanvehiclebrandmodelid());
		schedulevehiclepeopleplan.setPlanvehicle(obj.getPlanvehicle());
		schedulevehiclepeopleplan.setPlanvehicletypeid(obj
				.getPlanvehicletypeid());
		schedulevehiclepeopleplan.setScheduleid(scheduleplan.getScheduleid());
		schedulevehiclepeopleplan.setUpdateby(createby);
		schedulevehiclepeopleplan.setUpdatetime(new Date());
		schedulevehiclepeopleplan.setOrgid(orgid);
		schedulevehiclepeopleplan.setPlanunit(obj.getPlanunit());
		return schedulevehiclepeopleplan;
	}

	// 生成班次状态
	private List<Schedulestatus> saveSchedulestatus(Scheduleplan scheduleplan) {
		List<Schedulestatus> schedulestatuslist = new ArrayList<Schedulestatus>();
		for (Schedulestop schedulestop : departstoplist) {
			Schedulestatus schedulestatus = addSchedulestatus(schedulestop,
					scheduleplan);
			schedulestatuslist.add(schedulestatus);
		}
		return schedulestatuslist;
	}

	// 新增班次状态信息
	@SuppressWarnings("unchecked")
	private Schedulestatus addSchedulestatus(Schedulestop schedulestop,
			Scheduleplan scheduleplan) {
		Schedulestatus schedulestatus = new Schedulestatus();
		Vehiclepark vehiclepark = (Vehiclepark) genScheduleplanServiceDao.get(
				Vehiclepark.class, schedulestop.getVehiclepark().getId());
		Ticketentrance ticketentrance = (Ticketentrance) genScheduleplanServiceDao
				.get(Ticketentrance.class, schedulestop.getTicketentrance()
						.getId());
		schedulestatus.setBuspark(vehiclepark.getName());
		schedulestatus.setCreateby(createby);
		schedulestatus.setCreatetime(new Date());
		schedulestatus.setDepartdate(scheduleplan.getDepartdate());
		schedulestatus.setDepartstationid(schedulestop.getStationid());
		if (scheduleplan.getIslinework()) {
			schedulestatus.setDeparttime(scheduleplan.getEndtime());
		} else {
			schedulestatus.setDeparttime(schedulestop.getDeparttime());
		}
		schedulestatus.setIsbegincheck(false);
		schedulestatus.setIsdeparted(false);
		schedulestatus.setIsemptyvehicle(false);
		schedulestatus.setIsreported(false);
		schedulestatus.setOrgid(orgid);
		schedulestatus.setScheduleid(scheduleplan.getScheduleid());
		schedulestatus.setScheduleplan(scheduleplan);
		schedulestatus.setStatus("0");
		schedulestatus.setTicketentrance(ticketentrance.getName());
		schedulestatus.setUpdateby(createby);
		schedulestatus.setUpdatetime(new Date());
		return schedulestatus;
	}

	// 更新班次状态信息
	@SuppressWarnings("unchecked")
	private Schedulestatus updateSchedulestatus(Schedulestatus schedulestatus,
			Schedulestop schedulestop, Scheduleplan scheduleplan) {
		Vehiclepark vehiclepark = (Vehiclepark) genScheduleplanServiceDao.get(
				Vehiclepark.class, schedulestop.getVehiclepark().getId());
		Ticketentrance ticketentrance = (Ticketentrance) genScheduleplanServiceDao
				.get(Ticketentrance.class, schedulestop.getTicketentrance()
						.getId());
		schedulestatus.setBuspark(vehiclepark.getName());
		if (scheduleplan.getIslinework()) {
			schedulestatus.setDeparttime(scheduleplan.getEndtime());
		} else {
			schedulestatus.setDeparttime(schedulestop.getDeparttime());
		}
		schedulestatus.setTicketentrance(ticketentrance.getName());
		schedulestatus.setUpdateby(createby);
		schedulestatus.setUpdatetime(new Date());
		return genScheduleplanServiceDao.getEntityManager().merge(
				schedulestatus);
	}

	// 保存班次座位
	private List<Scheduleseats> saveScheduleseats(short seatnum,
			Scheduleplan scheduleplan, String reserveseats[],
			Vehiclebrandmodel planvehiclebrandmodel) {
		List<Scheduleseats> scheduleseatslist = new ArrayList<Scheduleseats>();
		for (short seatno = 1; seatno <= seatnum; seatno++) {
			Scheduleseats scheduleseats = addScheduleseats(seatno,
					scheduleplan, reserveseats, planvehiclebrandmodel);
			scheduleseatslist.add(scheduleseats);
		}
		return scheduleseatslist;
	}

	// 新增班次座位
	private Scheduleseats addScheduleseats(short seatno,
			Scheduleplan scheduleplan, String reserveseats[],
			Vehiclebrandmodel planvehiclebrandmodel) {
		Scheduleseats scheduleseats = new Scheduleseats();
		scheduleseats.setCreateby(createby);
		scheduleseats.setCreatetime(new Date());
		scheduleseats.setDepartdate(scheduleplan.getDepartdate());
		scheduleseats.setOrgid(orgid);
		scheduleseats.setScheduleid(scheduleplan.getScheduleid());
		scheduleseats.setScheduleplan(scheduleplan);
		scheduleseats.setSeatno(seatno);
		Vehiclespace vehiclespace = genScheduleplanServiceDao.qryVehiclespace(
				planvehiclebrandmodel, seatno);
		if (vehiclespace != null) {
			scheduleseats.setSeattype(vehiclespace.getSeattype());
		} else {
			scheduleseats.setSeattype("0");
		}
		if (isexisthandholidayprice) {
			for (Handholidayprice handholidayprice : handholidaypricelist) {
				String seattypes = handholidayprice.getSeats();
				String seatlist[] = seattypes.split(",");
				if (StringUtils.contains(seatlist, String.valueOf(seatno))) {
					scheduleseats.setSeattype(handholidayprice.getSeattype());
					break;
				}
			}
		}else if(isstandardprice){
			scheduleseats.setSeattype("0");
		}else{
			for (Handprice handprice : handpricelist) {
				String seats = handprice.getSeats();
				String seatlist[] = seats.split(",");
				if (StringUtils.contains(seatlist, String.valueOf(seatno))) {
					scheduleseats.setSeattype(handprice.getSeattype());
					break;
				}
			}
		}

		scheduleseats.setStatus("0");
		if (reserveseats != null && reserveseats.length > 0) {
			if (StringUtils.contains(reserveseats, String.valueOf(seatno))) {
				scheduleseats.setStatus("3");// 3固定留位
			}
		}
		scheduleseats.setUpdateby(createby);
		scheduleseats.setUpdatetime(new Date());
		return scheduleseats;
	}

	// 修改班次座位信息
	private Scheduleseats updateScheduleseats(Scheduleseats scheduleseats,
			String reserveseats[], Vehiclebrandmodel planvehiclebrandmodel) {
		Vehiclespace vehiclespace = genScheduleplanServiceDao.qryVehiclespace(
				planvehiclebrandmodel, scheduleseats.getSeatno());
		if (vehiclespace != null) {
			scheduleseats.setSeattype(vehiclespace.getSeattype());
		}
		if (isexisthandholidayprice) {
			for (Handholidayprice handholidayprice : handholidaypricelist) {
				String seattypes = handholidayprice.getSeats();
				String seatlist[] = seattypes.split(",");
				if (StringUtils.contains(seatlist,
						String.valueOf(scheduleseats.getSeatno()))) {
					scheduleseats.setSeattype(handholidayprice.getSeattype());
					break;
				}
			}
		}else if(isstandardprice){
			scheduleseats.setSeattype("0");
		}else {
			for (Handprice handprice : handpricelist) {
				String seattypes = handprice.getSeats();
				String seatlist[] = seattypes.split(",");
				if (StringUtils.contains(seatlist,
						String.valueOf(scheduleseats.getSeatno()))) {
					scheduleseats.setSeattype(handprice.getSeattype());
					break;
				}
			}
		}
		if (scheduleseats.getStatus().equals("0")
				|| scheduleseats.getStatus().equals("3")) {
			scheduleseats.setStatus("0");
			if (reserveseats != null && reserveseats.length > 0) {
				if (StringUtils.contains(reserveseats,
						String.valueOf(scheduleseats.getSeatno()))) {
					scheduleseats.setStatus("3");// 3固定留位
				}
			}
		}
		scheduleseats.setUpdateby(createby);
		scheduleseats.setUpdatetime(new Date());
		return scheduleseats;
	}
	
	//新增公式票价
	private Ticketprice addTicketprice(Standardprice standardprice,
			Scheduleplan scheduleplan, String[] reserveseats) {
		
		Ticketprice ticketprice = new Ticketprice();
		ticketprice.setCreateby(createby);
		ticketprice.setCreatetime(new Date());
		ticketprice.setDepartdate(scheduleplan.getDepartdate());
		ticketprice.setDepartstationid(standardprice.getDepartstationid());
		Schedule schedule = (Schedule) genScheduleplanServiceDao.get(
				Schedule.class, scheduleplan.getScheduleid());
		ticketprice.setFullprice(standardprice.getFullprice());
		ticketprice.setHalfprice(genScheduleplanServiceDao.actPrice(
				standardprice.getFullprice(),
				standardprice.getHalfprice(), scheduleplan.getDepartdate(),
				"B", schedule));
		ticketprice.setStudentprice(genScheduleplanServiceDao.actPrice(
				standardprice.getFullprice(),
				standardprice.getStudentprice(),
				scheduleplan.getDepartdate(), "X", schedule));
		ticketprice.setDiscountprice(genScheduleplanServiceDao.actPrice(
				standardprice.getFullprice(),
				standardprice.getDiscountprice(),
				scheduleplan.getDepartdate(), "Y", schedule));
		ticketprice.setRoundprice(genScheduleplanServiceDao.actPrice(
				standardprice.getFullprice(),
				standardprice.getRoundprice(),
				scheduleplan.getDepartdate(), "W", schedule));
		ticketprice.setConnectprice(genScheduleplanServiceDao.actPrice(
				standardprice.getFullprice(),
				standardprice.getConnectprice(),
				scheduleplan.getDepartdate(), "L", schedule));
				// 1四舍五入、2舍去、3入、4小于5角进到5角，高于5角进到1元,将1042参数的进位方法封装到mathPriceByRule方法
				BigDecimal halfprice = routepriceService.mathPriceByRule(pricerule, ticketprice.getHalfprice());
				BigDecimal studentprice = routepriceService.mathPriceByRule(pricerule, ticketprice.getStudentprice());
				ticketprice.setHalfprice(halfprice);
				ticketprice.setStudentprice(studentprice);
		ticketprice.setDiscountprice(routepriceService.mathPriceByRule(pricerule, ticketprice.getDiscountprice()));
		ticketprice.setRoundprice(routepriceService.mathPriceByRule(pricerule, ticketprice.getRoundprice()));
		ticketprice.setConnectprice(routepriceService.mathPriceByRule(pricerule, ticketprice.getConnectprice()));
				
		ticketprice.setMoreprice(new BigDecimal(0));
		//新增参数控制，班次要申请才可售
		//Global global = CurrentUtil.getGlobal();
	/*	String tt = parameterService.findParamValue("0036",scheduleplan.getOrgid());
		if("1".equals(tt))//1表示启用，班次不可售
		{
			ticketprice.setIssellable(false);
		}
		else
		{
			ticketprice.setIssellable(true);
		}*/
		ticketprice.setIssellable(true);
		ticketprice.setOrgid(orgid);
		ticketprice.setReachstationid(standardprice.getReachstationid());
		if (scheduleplan.getIslinework()) {
			ticketprice.setSeatnum(seatnum);
		} else {
			//String seats = handholidayprice.getSeats();
			//String seatlist[] = seats.split(",");
			//short curseatnum = (short) seatlist.length;
			//if ("0".equals(seats)||"全部".equals(seats)) {
				// ticketprice.setResidueseatnum(seatnum);
				ticketprice.setSeatnum(seatnum);
			//} else {
			//	// ticketprice.setResidueseatnum(curseatnum);
			//	ticketprice.setSeatnum(curseatnum);
			//}
			if (reserveseats != null && reserveseats.length > 0) {
				ticketprice.setFixedreserveseatnum((short) reserveseats.length);
			}
		}
		for (Schedulestop schedulestop : reachstoplist) {
			if (schedulestop.getStationid() == scheduleplan
					.getEndstationid()) {
				ticketprice.setRuntime(schedulestop.getRuntime());
				
			/*	if("1".equals(tt))//0表示启用，班次不可售
				{
					ticketprice.setIssellable(false);
				}else*/
				
					ticketprice.setIssellable(schedulestop.isIssellable());
			}

		}
		ticketprice.setScheduleid(scheduleplan.getScheduleid());
		ticketprice.setScheduleplan(scheduleplan);
		ticketprice.setSeatnos("0");
		ticketprice.setSeattype("0");
		ticketprice.setSoldeatnum(soldeatnum);

		ticketprice.setUpdateby(createby);
		ticketprice.setUpdatetime(new Date());
		int departdistance = 0;
		int reacherdistance = 0;
		for (Routestop routestop : routestoplist) {
			if (routestop.getStationid() == standardprice
					.getReachstationid()) {
				reacherdistance = routestop.getDistance();
			}
			if (routestop.getStationid() == standardprice
					.getDepartstationid()) {
				departdistance = routestop.getDistance();
			}
		}
		ticketprice.setBalancedistance(reacherdistance - departdistance);
		ticketprice.setDistance(reacherdistance - departdistance);

		ticketprice.setToplimitprice(standardprice.getToplimitprice());
		ticketprice.setLowerlimitprice(standardprice.getLowerlimitprice());
		ticketprice.setAutocancelreserveseatnum(scheduleplan
				.getAutocancelreserveseatnum());
		ticketprice.setUnautocancelreserveseatnum(scheduleplan
				.getUnautocancelreserveseatnum());
		ticketprice.setFixedreserveseatnum(scheduleplan
				.getFixedreserveseatnum());

		ticketprice.setStationservicefee(new BigDecimal(0));
		ticketprice.setFueladditionfee(new BigDecimal(0));
		return ticketprice;
	}
	
	// 新增节日票价
	@SuppressWarnings("unchecked")
	private Ticketprice addTicketprice(Handholidayprice handholidayprice,
			Scheduleplan scheduleplan, String[] reserveseats) {
		Ticketprice ticketprice = new Ticketprice();
		ticketprice.setCreateby(createby);
		ticketprice.setCreatetime(new Date());
		ticketprice.setDepartdate(scheduleplan.getDepartdate());
		ticketprice.setDepartstationid(handholidayprice.getDepartstationid());
		Schedule schedule = (Schedule) genScheduleplanServiceDao.get(
				Schedule.class, scheduleplan.getScheduleid());
		ticketprice.setFullprice(handholidayprice.getFullprice());
		ticketprice.setHalfprice(genScheduleplanServiceDao.actPrice(
				handholidayprice.getFullprice(),
				handholidayprice.getHalfprice(), scheduleplan.getDepartdate(),
				"B", schedule));
		ticketprice.setStudentprice(genScheduleplanServiceDao.actPrice(
				handholidayprice.getFullprice(),
				handholidayprice.getStudentprice(),
				scheduleplan.getDepartdate(), "X", schedule));
		ticketprice.setDiscountprice(genScheduleplanServiceDao.actPrice(
				handholidayprice.getFullprice(),
				handholidayprice.getDiscountprice(),
				scheduleplan.getDepartdate(), "Y", schedule));
		ticketprice.setRoundprice(genScheduleplanServiceDao.actPrice(
				handholidayprice.getFullprice(),
				handholidayprice.getRoundprice(),
				scheduleplan.getDepartdate(), "W", schedule));
		ticketprice.setConnectprice(genScheduleplanServiceDao.actPrice(
				handholidayprice.getFullprice(),
				handholidayprice.getConnectprice(),
				scheduleplan.getDepartdate(), "L", schedule));
		// ticketprice.setHalfprice(handholidayprice.getHalfprice());
		// ticketprice.setStudentprice(handholidayprice.getStudentprice());
		if (ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue("5001", null))) {
			ticketprice.setMoreprice(handholidayprice.getMoreprice());
		} else {
			ticketprice.setMoreprice(new BigDecimal(0));
		}
		//新增参数控制，班次要申请才可售
		//Global global = CurrentUtil.getGlobal();
		/*String tt = parameterService.findParamValue("0036",scheduleplan.getOrgid());
		if("1".equals(tt))//1表示启用，班次不可售
		{
			ticketprice.setIssellable(false);
		}
		else
		{
			ticketprice.setIssellable(true);
		}*/
		ticketprice.setIssellable(true);
		ticketprice.setOrgid(orgid);
		ticketprice.setReachstationid(handholidayprice.getReachstationid());
		if (scheduleplan.getIslinework()) {
			ticketprice.setSeatnum(seatnum);
		} else {
			String seats = handholidayprice.getSeats();
			String seatlist[] = seats.split(",");
			short curseatnum = (short) seatlist.length;
			if ("0".equals(seats)||"全部".equals(seats)) {
				// ticketprice.setResidueseatnum(seatnum);
				ticketprice.setSeatnum(seatnum);
			} else {
				// ticketprice.setResidueseatnum(curseatnum);
				ticketprice.setSeatnum(curseatnum);
			}
			if (reserveseats != null && reserveseats.length > 0) {
				ticketprice.setFixedreserveseatnum((short) reserveseats.length);
			}
		}
		for (Schedulestop schedulestop : reachstoplist) {
			if (schedulestop.getStationid() == handholidayprice
					.getReachstationid()) {
				ticketprice.setRuntime(schedulestop.getRuntime());
				
			/*	if("1".equals(tt))//0表示启用，班次不可售
				{
					ticketprice.setIssellable(false);
				}else*/
				
				ticketprice.setIssellable(schedulestop.isIssellable());
			}

		}
		ticketprice.setScheduleid(scheduleplan.getScheduleid());
		ticketprice.setScheduleplan(scheduleplan);
		ticketprice.setSeatnos(handholidayprice.getSeats());
		ticketprice.setSeattype(handholidayprice.getSeattype());
		ticketprice.setSoldeatnum(soldeatnum);

		ticketprice.setUpdateby(createby);
		ticketprice.setUpdatetime(new Date());
		int departdistance = 0;
		int reacherdistance = 0;
		for (Routestop routestop : routestoplist) {
			if (routestop.getStationid() == handholidayprice
					.getReachstationid()) {
				reacherdistance = routestop.getDistance();
			}
			if (routestop.getStationid() == handholidayprice
					.getDepartstationid()) {
				departdistance = routestop.getDistance();
			}
		}
		ticketprice.setBalancedistance(reacherdistance - departdistance);
		ticketprice.setDistance(reacherdistance - departdistance);

		ticketprice.setToplimitprice(handholidayprice.getToplimitprice());
		ticketprice.setLowerlimitprice(handholidayprice.getLowerlimitprice());
		ticketprice.setAutocancelreserveseatnum(scheduleplan
				.getAutocancelreserveseatnum());
		ticketprice.setUnautocancelreserveseatnum(scheduleplan
				.getUnautocancelreserveseatnum());
		ticketprice.setFixedreserveseatnum(scheduleplan
				.getFixedreserveseatnum());

		ticketprice.setStationservicefee(new BigDecimal(0));
		ticketprice.setFueladditionfee(new BigDecimal(0));
		return ticketprice;
	}

	// 新增线路票价
	@SuppressWarnings("unchecked")
	private Ticketprice addTicketprice(Routeprice routeprice,
			Scheduleplan scheduleplan, String[] reserveseats) {
		Ticketprice ticketprice = new Ticketprice();
		ticketprice.setCreateby(createby);
		ticketprice.setCreatetime(new Date());
		ticketprice.setDepartdate(scheduleplan.getDepartdate());
		ticketprice.setDepartstationid(routeprice.getFromstationid());
		Schedule schedule = (Schedule) genScheduleplanServiceDao.get(
				Schedule.class, scheduleplan.getScheduleid());
		ticketprice.setFullprice(routeprice.getPrice());
		String rate=parameterService.findParamValue(ParamterConst.Param_0017, schedule.getOrgid());
		ticketprice.setHalfprice(genScheduleplanServiceDao.actPrice(
				routeprice.getPrice(),
				routeprice.getPrice().multiply(new BigDecimal(rate)), scheduleplan.getDepartdate(),
				"B", schedule));
		ticketprice.setStudentprice(genScheduleplanServiceDao.actPrice(
				routeprice.getPrice(),
				routeprice.getPrice(),
				scheduleplan.getDepartdate(), "X", schedule));
		// 1四舍五入、2舍去、3入、4小于5角进到5角，高于5角进到1元
		BigDecimal halfprice = routepriceService.mathPriceByRule(pricerule, ticketprice.getHalfprice());
		BigDecimal studentprice = routepriceService.mathPriceByRule(pricerule, ticketprice.getStudentprice());
		ticketprice.setHalfprice(halfprice);
		ticketprice.setStudentprice(studentprice);

		ticketprice.setMoreprice(new BigDecimal(0));

		//新增参数控制，参数开启，班次需审批才可售
		//Global global = CurrentUtil.getGlobal();
/*		String tt = parameterService.findParamValue("0036",scheduleplan.getOrgid());
		if("1".equals(tt))//1表示启用，班次不可售
		{
			ticketprice.setIssellable(false);
		}
		else
		{
			ticketprice.setIssellable(true);
		}*/
		
		ticketprice.setIssellable(true);
		ticketprice.setOrgid(orgid);
		ticketprice.setReachstationid(routeprice.getReachstationid());
		ticketprice.setSeatnum(seatnum);
		if (!scheduleplan.getIslinework()) {
			if (reserveseats != null && reserveseats.length > 0) {
				ticketprice.setFixedreserveseatnum((short) reserveseats.length);
			}
		}
		for (Schedulestop schedulestop : reachstoplist) {
			if (schedulestop.getStationid() == routeprice.getReachstationid()) {
				ticketprice.setRuntime(schedulestop.getRuntime());
				
			/*	if("1".equals(tt))//0表示启用，班次不可售
				{
					ticketprice.setIssellable(false);
				}else*/
				ticketprice.setIssellable(schedulestop.isIssellable());
			}
		}
		ticketprice.setScheduleid(scheduleplan.getScheduleid());
		ticketprice.setScheduleplan(scheduleplan);
		ticketprice.setSeatnos("0");
		ticketprice.setSeattype("0");
		ticketprice.setSoldeatnum(soldeatnum);

		ticketprice.setUpdateby(createby);
		ticketprice.setUpdatetime(new Date());
		int departdistance = 0;
		int reacherdistance = 0;
		for (Routestop routestop : routestoplist) {
			if (routestop.getStationid() == routeprice.getReachstationid()) {
				reacherdistance = routestop.getDistance();
			}
			if (routestop.getStationid() == routeprice.getFromstationid()) {
				departdistance = routestop.getDistance();
			}
		}
		ticketprice.setBalancedistance(reacherdistance - departdistance);
		ticketprice.setDistance(reacherdistance - departdistance);

		ticketprice.setToplimitprice(routeprice.getPrice().multiply(new BigDecimal(2)));
		ticketprice.setLowerlimitprice(routeprice.getPrice());
		ticketprice.setAutocancelreserveseatnum(scheduleplan
				.getAutocancelreserveseatnum());
		ticketprice.setUnautocancelreserveseatnum(scheduleplan
				.getUnautocancelreserveseatnum());
		ticketprice.setFixedreserveseatnum(scheduleplan
				.getFixedreserveseatnum());

		ticketprice.setStationservicefee(new BigDecimal(0));
		ticketprice.setFueladditionfee(new BigDecimal(0));
		return ticketprice;
	}

	// 取硬调票价保存
	@SuppressWarnings("unchecked")
	private Ticketprice addTicketprice(Handprice handprice,
			Scheduleplan scheduleplan, String[] reserveseats) {
		Ticketprice ticketprice = new Ticketprice();
		ticketprice.setCreateby(createby);
		ticketprice.setCreatetime(new Date());
		ticketprice.setDepartdate(scheduleplan.getDepartdate());
		ticketprice.setDepartstationid(handprice.getDepartstationid());
		ticketprice.setFullprice(handprice.getFullprice());
		Date departdate = scheduleplan.getDepartdate();
		Schedule schedule = (Schedule) genScheduleplanServiceDao.get(
				Schedule.class, scheduleplan.getScheduleid());
		ticketprice.setHalfprice(genScheduleplanServiceDao.actPrice(
				handprice.getFullprice(), handprice.getHalfprice(), departdate,
				"B", schedule));
		ticketprice.setStudentprice(genScheduleplanServiceDao.actPrice(
				handprice.getFullprice(), handprice.getStudentprice(),
				departdate, "X", schedule));
		ticketprice.setDiscountprice(genScheduleplanServiceDao.actPrice(
				handprice.getFullprice(), handprice.getDiscountprice(),
				departdate, "Y", schedule));
		ticketprice.setRoundprice(genScheduleplanServiceDao.actPrice(
				handprice.getFullprice(), handprice.getRoundprice(),
				departdate, "W", schedule));
		ticketprice.setConnectprice(genScheduleplanServiceDao.actPrice(
				handprice.getFullprice(), handprice.getConnectprice(),
				departdate, "L", schedule));
		if (ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue("5001", null))) {
			ticketprice.setMoreprice(handprice.getMoreprice());
		} else {
			ticketprice.setMoreprice(new BigDecimal(0));
		}
		
		//Global global = CurrentUtil.getGlobal();
/*		String tt = parameterService.findParamValue("0036",scheduleplan.getOrgid());
		if("1".equals(tt))//1表示启用，班次不可售
		{
			ticketprice.setIssellable(false);
		}
		else
		{
			ticketprice.setIssellable(true);
		}
		System.out.println(ticketprice.getIssellable());*/
		
		ticketprice.setIssellable(true);
		ticketprice.setOrgid(orgid);
		ticketprice.setReachstationid(handprice.getReachstationid());
		if (scheduleplan.getIslinework()) {
			ticketprice.setSeatnum(seatnum);
		} else {
			String seats = handprice.getSeats();
			String seatlist[] = seats.split(",");
			short curseatnum = (short) seatlist.length;
			if ("0".equals(seats) || "全部".equals(seats)) {
				// ticketprice.setResidueseatnum(seatnum);
				ticketprice.setSeatnum(seatnum);

			} else if (seatnum < curseatnum) {
				ticketprice.setSeatnum(seatnum);
			} else {
				// ticketprice.setResidueseatnum(curseatnum);
				ticketprice.setSeatnum(curseatnum);
//				ticketprice.setSeatnum(seatnum);//硬调票价如果选择厂牌座位数设成核定
			}
			if (reserveseats != null && reserveseats.length > 0) {
				ticketprice.setFixedreserveseatnum((short) reserveseats.length);
			}
		}

		for (Schedulestop schedulestop : reachstoplist) {
			if (schedulestop.getStationid() == handprice.getReachstationid()) {
				ticketprice.setRuntime(schedulestop.getRuntime());
				
			/*	if("1".equals(tt))//0表示启用，班次不可售
				{
					ticketprice.setIssellable(false);
				}else*/
				ticketprice.setIssellable(schedulestop.isIssellable());
			}

		}
		ticketprice.setScheduleid(scheduleplan.getScheduleid());
		ticketprice.setScheduleplan(scheduleplan);
		ticketprice.setSeatnos(handprice.getSeats());
		ticketprice.setSeattype(handprice.getSeattype());
		ticketprice.setSoldeatnum(soldeatnum);
		ticketprice.setUpdateby(createby);
		ticketprice.setUpdatetime(new Date());
		int departdistance = 0;
		int reacherdistance = 0;

		for (Routestop routestop : routestoplist) {
			if (routestop.getStationid() == handprice.getReachstationid()) {
				reacherdistance = routestop.getDistance();
			}
			if (routestop.getStationid() == handprice.getDepartstationid()) {
				departdistance = routestop.getDistance();
			}
		}
		ticketprice.setBalancedistance(reacherdistance - departdistance);
		ticketprice.setDistance(reacherdistance - departdistance);
		ticketprice.setToplimitprice(handprice.getToplimitprice());
		ticketprice.setLowerlimitprice(handprice.getLowerlimitprice());
		ticketprice.setAutocancelreserveseatnum(scheduleplan
				.getAutocancelreserveseatnum());
		ticketprice.setUnautocancelreserveseatnum(scheduleplan
				.getUnautocancelreserveseatnum());
		ticketprice.setFixedreserveseatnum(scheduleplan
				.getFixedreserveseatnum());
		/*
		 * BigDecimal stationservicefee = ticketpriceformulaitemService .getFormulaitemfee(ticketprice.getFullprice(),
		 * orgid, handprice.getScheduleid(), handprice.getDepartstationid(), handprice.getReachstationid(), distance,
		 * "站务费"); BigDecimal fueladditionfee = ticketpriceformulaitemService
		 * .getFormulaitemfee(ticketprice.getFullprice(), orgid, handprice.getScheduleid(),
		 * handprice.getDepartstationid(), handprice.getReachstationid(), distance, "燃油费");
		 */
		ticketprice.setStationservicefee(new BigDecimal(0));
		ticketprice.setFueladditionfee(new BigDecimal(0));
		return ticketprice;
	}

	@SuppressWarnings("unchecked")
	private boolean saveScheduleplanlog(Scheduleplanlog log, String result,
			Long scheduleid) {
		System.out.println(result);
		try {
			userTransaction.begin();
			Scheduleplanlog scheduleplanlog = new Scheduleplanlog();
			scheduleplanlog.setCreateby(createby);
			scheduleplanlog.setCreatetime(new Date());
			scheduleplanlog.setOperationtype(log.getOperationtype());
			scheduleplanlog.setOrgid(log.getOrgid());
			scheduleplanlog.setStartdate(log.getStartdate());
			scheduleplanlog.setType(log.getType());
			scheduleplanlog.setUserid(createby);
			scheduleplanlog.setEnddate(log.getEnddate());
			if ("2".equals(scheduleplanlog.getType())) {
				scheduleplanlog.setTypeid(scheduleid);
			} else if ("1".equals(scheduleplanlog.getType())) {
				scheduleplanlog.setTypeid(log.getTypeid());
			} else {
				scheduleplanlog.setTypeid(new Long(0));
			}
			scheduleplanlog.setIp(log.getIp());
			scheduleplanlog.setResult(result);
			scheduleplanlog.setCreatetime(new Date());
			scheduleplanloglist.add(scheduleplanlog);
			genScheduleplanServiceDao.merge(scheduleplanlog);
			userTransaction.commit();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
		}
		return true;
	}

	@SuppressWarnings("unchecked")
	private List<Map<String, Object>> delScheduleplan(
			Scheduleplanlog scheduleplanlog) throws ServiceException {
		if (scheduleplanlog.getStartdate().after(scheduleplanlog.getEnddate())) {
			new ServiceException("0054");
		}
		if (scheduleplanlog.getStartdate()
				.before(DateUtils.add(new Date(), -1))) {
			new ServiceException("0055");
		}
		scheduleplanloglist = new ArrayList<Object>();
		Date startdate = scheduleplanlog.getStartdate();
		Date enddate = scheduleplanlog.getEnddate();
		createby = scheduleplanlog.getUserid();
		orgid = scheduleplanlog.getOrgid();
		Date departdate = new Date();
		int days = DateUtils.getIntervalDays(startdate, enddate);
		List<Schedule> schedulelist = genScheduleplanServiceDao
				.qryOrgdelSchedule(scheduleplanlog);
		for (int i = 0; i <= days; i++) {
			departdate = DateUtils.add(startdate, i);
			String departdatestr = StringUtils.dateToStr(departdate);
			for (Schedule schedule : schedulelist) {
				try {
					System.out.println("班次号:" + schedule.getCode()
							+ "开始删除运行计划---------------------------------");
					userTransaction.begin();
					iserror = false;
					// 获取班次计划
					Scheduleplan scheduleplan = genScheduleplanServiceDao
							.getScheduleplan(schedule.getId(), departdate,
									orgid);
					if (scheduleplan == null) {
						userTransaction.rollback();
						result = schedule.getCode() + "班次：" + departdatestr
								+ "计划删除失败，原因是该班次计划还未生成！";
						saveScheduleplanlog(scheduleplanlog, result,
								schedule.getId());
						continue;
					}
					if (scheduleplan.getSoldeatnum() > 0) {
						userTransaction.rollback();
						result = schedule.getCode() + "班次：" + departdatestr
								+ "计划删除失败，原因该班次已有售票信息！";
						saveScheduleplanlog(scheduleplanlog, result,
								schedule.getId());
						continue;
					}
					if (scheduleplan.getAutocancelreserveseatnum() > 0
							|| scheduleplan.getUnautocancelreserveseatnum() > 0) {
						userTransaction.rollback();
						result = schedule.getCode() + "班次：" + departdatestr
								+ "计划删除失败，原因该班次已有留票信息！";
						saveScheduleplanlog(scheduleplanlog, result,
								schedule.getId());
						continue;
					}
					if (genScheduleplanServiceDao
							.isexistSellticket(scheduleplan.getId())) {
						userTransaction.rollback();
						result = schedule.getCode() + "班次：" + departdatestr
								+ "计划删除失败，原因是该天已有售票信息！";
						saveScheduleplanlog(scheduleplanlog, result,
								schedule.getId());
						continue;
					}
					List<Schedulestatus> schedulestatuslist = scheduleplan
							.getSchedulestatuslist();
					for (Schedulestatus schedulestatus : schedulestatuslist) {
						// 0 正常
						if ("2".equals(schedulestatus.getStatus())) {
							// 2 晚点
							userTransaction.rollback();
							result = schedule.getCode() + "班次：" + departdatestr
									+ "计划删除失败，原因是该班次已经做晚点处理！";
							saveScheduleplanlog(scheduleplanlog, result,
									schedule.getId());
							iserror = true;
							break;
						} else if ("3".equals(schedulestatus.getStatus())) {
							// 3 被并
							userTransaction.rollback();
							result = schedule.getCode() + "班次：" + departdatestr
									+ "计划删除失败，原因是该班次已经做并班处理！";
							saveScheduleplanlog(scheduleplanlog, result,
									schedule.getId());
							iserror = true;
							break;
						}// 报班后不允许删除班次计划
						else if (schedulestatus.getIsdeparted()
								|| schedulestatus.getIsreported()) {
							userTransaction.rollback();
							result = schedule.getCode() + "班次：" + departdatestr
									+ "计划删除失败，原因是该班次已经报到！";
							saveScheduleplanlog(scheduleplanlog, result,
									schedule.getId());
							iserror = true;
							break;
						} else if (schedulestatus.getIsbegincheck()) {
							userTransaction.rollback();
							result = schedule.getCode() + "班次：" + departdatestr
									+ "计划删除失败，原因是该班次已经开检！";
							saveScheduleplanlog(scheduleplanlog, result,
									schedule.getId());
							iserror = true;
							break;
						}
					}
					if (!iserror) {
						genScheduleplanServiceDao.delete(scheduleplan);
						userTransaction.commit();
						result = schedule.getCode() + "班次：" + departdatestr
								+ "计划删除成功！";
						saveScheduleplanlog(scheduleplanlog, result,
								schedule.getId());
					}
				} catch (Exception e) {
					iserror = true;
					System.out.println("回滚异常Exception");
					try {
						userTransaction.rollback();
					} catch (IllegalStateException e1) {
						e1.printStackTrace();
					} catch (SecurityException e1) {
						e1.printStackTrace();
					} catch (SystemException e1) {
						e1.printStackTrace();
					}
					play.Logger.error(e.getMessage(), e);
					result = schedule.getCode() + "班次：" + departdatestr
							+ "删除计划失败，原因:";
					result = result + e.getMessage();
					saveScheduleplanlog(scheduleplanlog, result,
							schedule.getId());
				}
			}
		}
		return ListUtil.listToMap(new Object[] { Scheduleplanlog.class },
				scheduleplanloglist, new Object[] { Scheduleplanlog.class });
	}

	@Override
	public List<Map<String, Object>> qryScheduleplan(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "ischoose", "id", "orgid",
				"departdate", "scheduleid", "seatnum",
				"autocancelreserveseatnum", "unautocancelreserveseatnum",
				"fixedreserveseatnum", "soldeatnum", "issellable",
				"startstationid", "endstationid", "starttime", "runtime",
				"distance", "highdistance", "worktype", "workways",
				"districttype", "scheduletype", "isproprietary", "isovertime",
				"issellreturnticket", "islinework", "endtime",
				"spacinginterval", "isoriginator", "issaleafterreport",
				"iscanmixcheck", "remarks", "stationfeeapplyid",
				"fueladditionfeeapplyid", "carrychildnum", "orgname",
				"routename", "routeid", "code", "departstation",
				"reachstation", "buspark", "departtime", "isbegincheck",
				"isdeparted", "isreported", "status", "ticketentrance",
				"vehicletypename", "vehicleno", "brandname", "brandmodelid",
				"driver1", "driver2", "driver3", "steward1", "createtime" },
				genScheduleplanServiceDao.qryScheduleplan(propertyFilterList),
				new Object[] { Boolean.class, Long.class, Long.class,
						Date.class, Long.class, Short.class, Short.class,
						Short.class, Short.class, Short.class, boolean.class,
						Long.class, Long.class, String.class, BigDecimal.class,
						Integer.class, Integer.class, String.class,
						String.class, String.class, String.class,
						boolean.class, boolean.class, boolean.class,
						boolean.class, String.class, Short.class,
						boolean.class, boolean.class, boolean.class,
						String.class, Long.class, Long.class, Short.class,
						String.class, String.class, Long.class, String.class,
						String.class, String.class, String.class, String.class,
						boolean.class, boolean.class, boolean.class,
						String.class, String.class, String.class, String.class,
						String.class, Long.class, String.class, String.class,
						String.class, String.class, Timestamp.class });
	}

	@Override
	public List<Map<String, Object>> qryTicketprice(Scheduleplan scheduleplan) {
		return ListUtil.listToMap(
				new Object[] { "departstation", "reachstation", "id", "runtime", "seattype", "seatnos", "seatnum",
						"soldeatnum", "fullprice", "halfprice", "studentprice", "issellable", "distance",
						"balancedistance", "toplimitprice", "lowerlimitprice", "autocancelreserveseatnum",
						"unautocancelreserveseatnum", "fixedreserveseatnum", "stationservicefee", "fueladditionfee",
						"residueseatnum", "moreprice", "discountprice", "roundprice", "connectprice" },
				genScheduleplanServiceDao.qryTicketprice(scheduleplan),
				new Object[] { String.class, String.class, Long.class, BigDecimal.class, String.class, String.class,
						Short.class, Short.class, BigDecimal.class, BigDecimal.class, BigDecimal.class, boolean.class,
						Long.class, Long.class, BigDecimal.class, BigDecimal.class, Short.class, Short.class,
						Short.class, BigDecimal.class, BigDecimal.class, Short.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class });
	}

	@Override
	public List<Map<String, Object>> qryTicketpriceitem(long ticketpriceid,
			String tickettype) {
		return ListUtil.listToMap(new Object[] { "code", "name", "price", "id",
				"tickettype", "isautoadjust", "ticketpriceid",
				"ticketpriceformulaitemid" }, genScheduleplanServiceDao
				.qryTicketpriceitem(ticketpriceid, tickettype), new Object[] {
				String.class, String.class, BigDecimal.class, long.class,
				String.class, boolean.class, long.class, long.class });
	}

//	private NetSeatreserveService getCentreInterface(MethodResult methodResult,
//			Organization localorg) {
//		Organization centreOrg = organizationService
//				.getDirectlyParentOrg(localorg);
//		if (centreOrg == null) {
//			methodResult.setResult(insideInvokFalse);
//			methodResult.setResultMsg("无法连接中心服务器:找不到" + localorg.getName()
//					+ "的上级机构");
//			return null;
//		}
//		try {
//			return (NetSeatreserveService) EJBFactory.getRemoteEJB(
//					NetSeatreserveService.class, centreOrg.getId());
//		} catch (NamingException e) {
//			methodResult.setResult(insideInvokFalse);
//			methodResult.setResultMsg("无法连接中心服务器:" + e.getMessage());
//			return null;
//		}
//	}

	@SuppressWarnings({ "unchecked" })
	@Override
	public List<Map<String, Object>> qryScheduleseats(Scheduleplan scheduleplan) {
		Scheduleplan sp = (Scheduleplan) genScheduleplanServiceDao.get(
				Scheduleplan.class, scheduleplan.getId());
		if (sp.getWorktype().equals("3")) {
			try {
				MethodResult res = new MethodResult();
				Organization organization = (Organization) genScheduleplanServiceDao
						.get(Organization.class, sp.getOrgid());
				Schedule schedule = (Schedule) genScheduleplanServiceDao.get(
						Schedule.class, sp.getScheduleid());
				Route route = (Route) genScheduleplanServiceDao.get(
						Route.class, schedule.getRoute().getId());
				Station departstation = (Station) genScheduleplanServiceDao
						.get(Station.class, route.getStartstationid());
				Station reachstation = (Station) genScheduleplanServiceDao.get(
						Station.class, route.getEndstationid());
				
//				NetSeatreserveService netSeatreserveService = getCentreInterface(
//						res, organization);
//				if (netSeatreserveService == null) {
//					return ListUtil.listToMap(
//							new Object[] { Scheduleseats.class },
//							genScheduleplanServiceDao
//									.qryScheduleseats(scheduleplan),
//							new Object[] { Scheduleseats.class });
//				}
				
//				res = netSeatreserveService.findSeatInfo(sp.getDepartdate(),
//						schedule.getSynccode(), departstation.getCode(),
//						reachstation.getCode());
				
				Map<String, String> requestMap = new HashMap<String, String>();
				requestMap.put("departdate", CommonUtil.dateToFullString(sp.getDepartdate()));
				requestMap.put("schedulesynccode", schedule.getSynccode());
				requestMap.put("departstationcode", departstation.getCode());
				requestMap.put("reachstationcode", reachstation.getCode());

				Organization centreOrg = organizationService.getDirectlyParentOrg(organization);
				String resultstr = RpcUtil.remoteCall(RpcUtil.getRemoteIp(centreOrg.getId()), RemoteApi.FIND_SEAT_INFO, requestMap);		
				res = JsonUtil.parseObject(resultstr, MethodResult.class);
				
				List<Object> lists = (List<Object>) res.getObject();
				List<Object> schedulseats = genScheduleplanServiceDao
						.qryScheduleseats(scheduleplan);
				if (lists == null || lists.size() == 0) {
					return ListUtil.listToMap(
							new Object[] { Scheduleseats.class },
							genScheduleplanServiceDao
									.qryScheduleseats(scheduleplan),
							new Object[] { Scheduleseats.class });
				} else {
					autocancelreserveseatnum = 0;
					fixedreserveseatnum = 0;
					unautocancelreserveseatnum = 0;
					soldeatnum = 0;
					for (Object obj : schedulseats) {
						Scheduleseats ss = (Scheduleseats) obj;
						// 3固定留位、4自动取消留位、5不自动取消留位
						for (Object robj : lists) {
							Object[] seats = JsonUtil.toObjctArray(robj);
							short seatno = new Short(seats[0].toString());
							String ticketype = seats[1].toString();
							String hint = seats[2].toString();
							String status = seats[3].toString();
							String seattype = seats[4].toString();
							if (ss.getSeatno() == seatno) {
								if (ss.getStatus().equals("0")) {
									ss.setTickettype(ticketype);
									ss.setSeattype(seattype);
									ss.setStatus(status);
									genScheduleplanServiceDao.merge(ss);
								}
								if (status.equals("2")) {
									soldeatnum = (short) (soldeatnum + 1);
								} else if (status.equals("3")) {
									fixedreserveseatnum = (short) (fixedreserveseatnum + 1);
								} else if (status.equals("4")) {
									autocancelreserveseatnum = (short) (autocancelreserveseatnum + 1);
								} else if (status.equals("5")) {
									unautocancelreserveseatnum = (short) (unautocancelreserveseatnum + 1);
								}
							}
						}
					}
					List<Ticketprice> tplist = genScheduleplanServiceDao
							.qryTicketprices(sp);
					sp.setAutocancelreserveseatnum(autocancelreserveseatnum);
					sp.setFixedreserveseatnum(fixedreserveseatnum);
					sp.setUnautocancelreserveseatnum(unautocancelreserveseatnum);
					sp.setSoldeatnum(soldeatnum);
					for (Ticketprice tp : tplist) {
						tp.setAutocancelreserveseatnum(autocancelreserveseatnum);
						tp.setFixedreserveseatnum(fixedreserveseatnum);
						tp.setUnautocancelreserveseatnum(unautocancelreserveseatnum);
						tp.setSoldeatnum(soldeatnum);
						genScheduleplanServiceDao.merge(tp);
					}
					genScheduleplanServiceDao.merge(sp);
					return ListUtil.listToMap(
							new Object[] { Scheduleseats.class }, schedulseats,
							new Object[] { Scheduleseats.class });
				}
			} catch (Exception e) {
				return ListUtil.listToMap(new Object[] { Scheduleseats.class },
						genScheduleplanServiceDao
								.qryScheduleseats(scheduleplan),
						new Object[] { Scheduleseats.class });
			}
		}
		return ListUtil.listToMap(new Object[] { Scheduleseats.class },
				genScheduleplanServiceDao.qryScheduleseats(scheduleplan),
				new Object[] { Scheduleseats.class });
	}

	private Ticketprice calTicketprice(Ticketprice tp) {
		BigDecimal fullprice = new BigDecimal(0);
		// BigDecimal halfprice = new BigDecimal(0);
		// BigDecimal studentprice = new BigDecimal(0);
		// BigDecimal toplimitprice = new BigDecimal(0);
		for (Ticketpriceitem ti : tp.getTicketpriceitemlist()) {
			if (ti.getTickettype().equals("Q")) {
				fullprice = fullprice.add(ti.getPrice());
			} else if (ti.getTickettype().equals("B")) {
				// halfprice = halfprice.add(ti.getPrice());
			} else if (ti.getTickettype().equals("X")) {
				// studentprice = studentprice.add(ti.getPrice());
			} else {
				// toplimitprice = toplimitprice.add(ti.getPrice());
			}
		}
		tp.setFullprice(fullprice);
		// tp.setHalfprice(halfprice);
		// tp.setStudentprice(studentprice);
		// tp.setToplimitprice(toplimitprice);
		return tp;
	}

	/*
	 * genScheduleplan方法：<br/> <br/>
	 * 
	 * @param scheduleplanlog
	 * 
	 * @param schedule
	 * 
	 * @return
	 * 
	 * @throws ServiceException
	 * 
	 * @see cn.nova.bus.price.service.GenScheduleplanService#genScheduleplan(cn.nova .bus.price.model.Scheduleplanlog,
	 * cn.nova.bus.base.model.Schedule)
	 * 
	 * @exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public MethodResult genScheduleplan(Scheduleplanlog scheduleplanlog,
			Schedule schedule, Date departdate) throws ServiceException {
		MethodResult result = new MethodResult();
		result.setResult(MethodResult.SUCCESS);
		orgid = schedule.getOrgid();
		String isfuadedcut = parameterService.findParamValue(ParamterConst.Param_0015, orgid);
		String isbyVehicletype = parameterService.findParamValue(ParamterConst.Param_0016, orgid);
		String value = parameterService.findParamValue(ParamterConst.Param_0009,
				scheduleplanlog.getOrgid());
		int days = Integer.valueOf(value);	
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Date curDate=new Date();
		try {
			curDate = sf.parse(sf.format(new Date()));
		} catch (ParseException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		Date enddate = DateUtils.add(curDate, days);
		String departdatestr = StringUtils.dateToStr(departdate);
		// 初始化变量
		seatnum = 0;// 座位数
		leave = 0;// 剩余座位数
		lockseatnum = 0;// 锁位数
		soldeatnum = 0;
		fixedreserveseatnum = 0;
		autocancelreserveseatnum = 0;
		unautocancelreserveseatnum = 0;
		try {
			userTransaction.begin();
			List<Schedulelongstop> sst = genScheduleplanServiceDao
					.getSchedulelongstop(schedule.getId(), departdate);
			
			boolean isstop = genScheduleplanServiceDao.isSchedulelongstop(schedule.getId(), departdate);
			String p20 = parameterService.findParamValue("0020",
					schedule.getOrgid());
			if ("0".equals(p20)&&isstop) {
				userTransaction.rollback();
				result.setResult(MethodResult.FAILURE);
				result.setResultMsg(schedule.getCode() + "班次：" + departdatestr
						+ "计划未生成,原因：该班次已经设置了长停信息！");
				saveScheduleplanlog(scheduleplanlog, result.getResultMsg(),
						schedule.getId());
				return result;
			}
			
			if (!genScheduleplanServiceDao.isCycleschemes(schedule, departdate)) {
				userTransaction.rollback();
				result.setResult(MethodResult.FAILURE);
				result.setResultMsg(schedule.getCode() + "班次：" + departdatestr
						+ "计划未生成,原因：该班次当天没有排班信息！");
				saveScheduleplanlog(scheduleplanlog, result.getResultMsg(),
						schedule.getId());
				return result;
			}

			// 获取当天循环车辆信息begin
			schedulevehiclepeopleplanlist = genScheduleplanServiceDao
					.getSchedulevehiclepeopleplan(schedule, departdate);
			Vehiclebrandmodel planvehiclebrandmodel = null;
			if (schedulevehiclepeopleplanlist == null
					|| schedulevehiclepeopleplanlist.size() == 0) {
				userTransaction.rollback();
				result.setResult(MethodResult.FAILURE);
				result.setResultMsg(schedule.getCode() + "班次：" + departdatestr
						+ "计划未生成,原因：该班次当天不营运！");
				saveScheduleplanlog(scheduleplanlog, result.getResultMsg(),
						schedule.getId());
				return result;
			} else {
				schedulevehiclepeopleplan = schedulevehiclepeopleplanlist
						.get(0);
				// 获取厂牌
				planvehiclebrandmodel = (Vehiclebrandmodel) genScheduleplanServiceDao
						.get(Vehiclebrandmodel.class, schedulevehiclepeopleplan
								.getPlanvehiclebrandmodelid());
				vehicletypeid = schedulevehiclepeopleplan
						.getPlanvehicletypeid();

				if (schedule.getIslinework()) {
					seatnum = schedule.getPlanseatnum();
					vehicletype = (Vehicletype) genScheduleplanServiceDao.get(
							Vehicletype.class,
							schedulevehiclepeopleplan.getPlanvehicletypeid());
				} else {
					// 获取座位数,若循环中设置 了车辆则取车辆信息
					if (schedulevehiclepeopleplan.getPlanvehicle() != null) {
						planvehicle = (Vehicle) genScheduleplanServiceDao.get(
								Vehicle.class, schedulevehiclepeopleplan
										.getPlanvehicle().getId());
						seatnum = planvehicle.getSeatnum();
						vehicletype = (Vehicletype) genScheduleplanServiceDao
								.get(Vehicletype.class,
										planvehicle.getVehicletypeid());

					} else
					// 获取座位数, 否则取厂牌信息座位数
					{
						planvehicle = null;
						vehicletype = (Vehicletype) genScheduleplanServiceDao
								.get(Vehicletype.class,
										schedulevehiclepeopleplan
												.getPlanvehicletypeid());
						seatnum = planvehiclebrandmodel.getRationseatnum();
					}

				}
			}
			// 获取当天循环车辆信息end
			Scheduleplan oldscheduleplan = genScheduleplanServiceDao
					.getScheduleplan(schedule.getId(), departdate, orgid);
			boolean isexistplan = oldscheduleplan != null ? true : false;
			if (isexistplan && scheduleplanlog.getIsautogen()) {
				userTransaction.rollback();
				result.setResult(MethodResult.FAILURE);
				return result;
			}
			if(!isexistplan){
				if (genScheduleplanServiceDao.isexistSch(schedule.getCode(), departdate)) {
					userTransaction.rollback();
					result.setResult(MethodResult.FAILURE);
					result.setResultMsg(schedule.getCode() + "班次：" + departdatestr
							+ "计划未生成,原因：该班次当天已有相同班次号！");
					saveScheduleplanlog(scheduleplanlog, result.getResultMsg(),
							schedule.getId());
					return result;
				}
			}
			System.out.println("班次号:" + schedule.getCode()
					+ "开始生成----------------------------------------");
			Scheduleseatreserve scheduleseatreserve=null;
			//若不是跨区配载的才生成固定留位信息
            if(!schedule.getWorktype().equals("3")){
			// 获取班次固定预留信息
				scheduleseatreserve = genScheduleplanServiceDao
						.getScheduleseatreserve(schedule.getId(), departdate,
							planvehiclebrandmodel.getId());
            }
			String reserveseats[] = null;
			if (scheduleseatreserve != null) {
				String seatnos = scheduleseatreserve.getSeatnos();
				seatnos = seatnos.replace(".", ",");
				reserveseats = seatnos.split(",");
			}
			if (scheduleseatreserve != null) {
				fixedreserveseatnum = scheduleseatreserve.getSeatnum();
			}
			int curtotalseatnum = soldeatnum + fixedreserveseatnum
					+ autocancelreserveseatnum + unautocancelreserveseatnum;
			if (seatnum < curtotalseatnum) {
				userTransaction.rollback();
				result.setResult(MethodResult.FAILURE);
				result.setResultMsg(schedule.getCode() + "班次：" + departdatestr
						+ "生成计划失败,原因：新调整车型座位数不能小于已售座位数+固定留位数+自动取消留位数+不自动取消留位数！");
				saveScheduleplanlog(scheduleplanlog, result.getResultMsg(),
						schedule.getId());
				return result;
			}

			Route route = (Route) genScheduleplanServiceDao.get(Route.class,
					schedule.getRoute().getId());

			// 获取节日票价信息

			handholidaypricelist = genScheduleplanServiceDao
					.getHandholidayprice(schedule.getId(), departdate,
							vehicletypeid, planvehiclebrandmodel);
			if (handholidaypricelist == null
					|| handholidaypricelist.size() == 0) {
				handholidaypricelist = genScheduleplanServiceDao
						.getHandholidayprice(schedule.getId(), departdate,
								vehicletypeid);
			}
			//是否使用线路票价
			String userouteprice = parameterService.findParamValue(ParamterConst.Param_0021,schedule.getOrgid());
			List<Routeprice> rplist=null;
			if(userouteprice.equals(ParamterConst.ROUTEPRICE_FLAG.FALG_ZERO)){
				rplist=genScheduleplanServiceDao.qryRouteprice(schedule.getRoute().getId(),departdate);
			}
			//如果使用公式票价
			if(userouteprice.equals(ParamterConst.ROUTEPRICE_FLAG.FALG_TWO)){
				//查询公式票价
				setIsstandardprice(true);
				isexisthandholidayprice = false;
			}else if (rplist == null || rplist.size()==0) {
				// 获取硬调票价信息
				if (handholidaypricelist == null
						|| handholidaypricelist.size() == 0) {
					isexisthandholidayprice = false;

					handpricelist = genScheduleplanServiceDao.getHandprice(
							schedule.getId(), vehicletypeid,
							planvehiclebrandmodel, isbyVehicletype);
					if (handpricelist == null || handpricelist.size() == 0) {
						handpricelist = genScheduleplanServiceDao.getHandprice(
								schedule.getId(), vehicletypeid);
					}
					
					if(CollectionUtils.isEmpty(handpricelist) && schedule.getIsovertime()){
						Schedule fsc=genScheduleplanServiceDao.getSchedule(schedule.getRoute().getId());
						if(fsc!=null){
							handpricelist = genScheduleplanServiceDao.getHandprice(
									fsc.getId());
							for(Handprice hp:handpricelist){
								hp.setScheduleid(schedule.getId());
							}
						}
					}
					
					if (handpricelist == null || handpricelist.size() == 0) {
						userTransaction.rollback();
						result.setResult(MethodResult.FAILURE);
						result.setResultMsg(schedule.getCode() + "班次："
								+ departdatestr + "生成计划失败,原因："
								+ vehicletype.getName() + "车型,厂牌型号为:"
								+ planvehiclebrandmodel.getBrandname()
								+","
								+ planvehiclebrandmodel.getModelcode()
								+ "硬调票价还未设置！");

						saveScheduleplanlog(scheduleplanlog,
								result.getResultMsg(), schedule.getId());
						return result;
					}

				} else {
					isexisthandholidayprice = true;
				}
			}
			// 班次上车站信息
			departstoplist = genScheduleplanServiceDao.getOrgSchedulestop(
					schedule.getId(), true, true);
			// 班次停靠站点
			reachstoplist = genScheduleplanServiceDao.getOrgSchedulestop(
					schedule.getId(), false, true);
			Ticketentrance startentrance=null;
			for (Schedulestop schedulestop : departstoplist) {
				if(schedulestop.getTicketentrance()!=null){
					startentrance=schedulestop.getTicketentrance();
				}
				if (schedulestop.getDeparttime() == null
						|| "".equals(schedulestop.getDeparttime())) {
					userTransaction.rollback();
					result.setResult(MethodResult.FAILURE);
					result.setResultMsg(schedule.getCode() + "班次："
							+ departdatestr + "生成计划失败,原因：" + "该班次停靠点序号为"
							+ schedulestop.getOrderno() + "未设置发车时间！");
					saveScheduleplanlog(scheduleplanlog, result.getResultMsg(),
							schedule.getId());
					return result;
				}
				if (schedulestop.getTicketentrance() == null) {
					schedulestop.setTicketentrance(startentrance);
				}
				if (schedulestop.getTicketentrance() == null) {
					userTransaction.rollback();
					result.setResult(MethodResult.FAILURE);
					result.setResultMsg(schedule.getCode() + "班次："
							+ departdatestr + "生成计划失败,原因：" + "该班次停靠点序号为"
							+ schedulestop.getOrderno() + "未设置检票口！");
					saveScheduleplanlog(scheduleplanlog, result.getResultMsg(),
							schedule.getId());
					return result;
				}
				if (schedulestop.getVehiclepark() == null) {
					userTransaction.rollback();
					result.setResult(MethodResult.FAILURE);
					result.setResultMsg(schedule.getCode() + "班次："
							+ departdatestr + "生成计划失败,原因：" + "该班次停靠点序号为"
							+ schedulestop.getOrderno() + "未设置上传卡位！");
					saveScheduleplanlog(scheduleplanlog, result.getResultMsg(),
							schedule.getId());
					return result;
				}
			}
			routestoplist = genScheduleplanServiceDao.getRoutestop(schedule
					.getRoute().getId());
			// tfisFreight =
			// genScheduleplanServiceDao.getTicketpriceformulaitems(orgid);
			List<Fuelfeegradeapply> fuelist = null;
			// 是否需要把燃油费生成到票价中
			if (ParamterConst.COMMON_FLAG.FALG_YES.equals(isfuadedcut)) {
				// 查询是否存在燃油费应用
				fuelist = genScheduleplanServiceDao.qryFuelfeegradeapply(
						departdate, schedule.getRoute().getId(), vehicletypeid);
			}
			List<Ticketprice> ticketpricelist = new ArrayList<Ticketprice>();
			
				
			// 还未生成计划
			if (!isexistplan) {
				try {
					soldeatnum = 0;
					// userTransaction.begin();
					Scheduleplan scheduleplan = new Scheduleplan();
					scheduleplan.setAutocancelreserveseatnum((short) 0);
					scheduleplan.setCreateby(createby);
					scheduleplan.setCreatetime(new Date());
					scheduleplan.setDepartdate(departdate);
					scheduleplan.setDistance(route.getDistance());
					scheduleplan.setDistricttype(schedule.getDistricttype());
					scheduleplan.setEndstationid(route.getEndstationid());
					scheduleplan.setEndtime(schedule.getEndtime());
					scheduleplan.setFixedreserveseatnum(fixedreserveseatnum);
					scheduleplan.setHighdistance(route.getHighdistance());
					scheduleplan.setIscanmixcheck(schedule.getIscanmixcheck());
					scheduleplan.setIslinework(schedule.getIslinework());
					scheduleplan.setIsoriginator(schedule.getIsoriginator());
					scheduleplan.setIsovertime(schedule.getIsovertime());
					scheduleplan.setIsproprietary(schedule.getIsproprietary());
					scheduleplan.setIssaleafterreport(schedule
							.getIssaleafterreport());
					scheduleplan.setIssellable(true);
					scheduleplan.setIssellreturnticket(schedule
							.getIssellreturnticket());
					scheduleplan.setOrgid(orgid);
					scheduleplan.setRuntime(schedule.getRuntime());
					scheduleplan.setScheduleid(schedule.getId());
					scheduleplan.setScheduletype(schedule.getType());
					scheduleplan.setSeatnum(seatnum);
					scheduleplan.setSoldeatnum((short) 0);
					scheduleplan.setSpacinginterval(schedule
							.getSpacinginterval());
					scheduleplan.setStartstationid(route.getStartstationid());
					scheduleplan.setStarttime(schedule.getStarttime());
					scheduleplan.setRemarks(schedule.getRemarks());
					scheduleplan
							.setUnautocancelreserveseatnum(unautocancelreserveseatnum);
					scheduleplan.setUpdateby(createby);
					scheduleplan.setUpdatetime(new Date());
					scheduleplan.setWorktype(schedule.getWorktype());
					scheduleplan.setWorkways(schedule.getWorkways());
					// scheduleplan.setStationfeeapply(stationfeebp);
					// scheduleplan.setFueladditionfeeapply(fueladditionfeebp);
					List<Scheduleseats> scheduleseatslist = null;
					// if (reserveseats != null) {
					// scheduleplan
					// .setFixedreserveseatnum((short) reserveseats.length);
					// }
					// scheduleplan.
					// 生成座位状态表,流水班次不生成座位状态表
					if (!scheduleplan.getIslinework()) {
						scheduleseatslist = saveScheduleseats(seatnum,
								scheduleplan, reserveseats,
								planvehiclebrandmodel);
					}
					// 生成班次状态
					List<Schedulestatus> schedulestatuslist = saveSchedulestatus(scheduleplan);
					if (sst != null && sst.size() > 0) {
						for (Schedulestatus schedulestatus : schedulestatuslist) {
							schedulestatus.setStatus("1");// 1报停
						}
					}else
					{
						for (Schedulestatus schedulestatus : schedulestatuslist) {
							schedulestatus.setStatus("0");// 1报停
						}
					}
					// 生成车辆驾驶员乘务员计划信息
					List<Schedulevehiclepeopleplan> schedulevehiclepeopleplanlist = saveSchedulevehiclepeopleplan(scheduleplan);
					// 以下生成票价
					ticketpricelist.clear();

					// 还未生成计划 若有线路票价
					if(rplist!=null && rplist.size()>0){
						for (Routeprice routeprice : rplist) {
							if (!genScheduleplanServiceDao.isexistSchstop(schedule.getId(),routeprice.getReachstationid())){
								continue;
							}
							// 保存票价
							Ticketprice ticketprice = addTicketprice(
									routeprice, scheduleplan,
									reserveseats);
							// 生成票价分项
							List<Ticketpriceitem> ticketpriceitems = new ArrayList<Ticketpriceitem>();
							// 只要生成全票的票价分项
							Ticketpriceitem ticketpriceitem = new Ticketpriceitem();
							ticketpriceitem.setCreateby(createby);
							ticketpriceitem.setCreatetime(new Date());
							ticketpriceitem.setDepartdate(departdate);
							ticketpriceitem.setIsautoadjust(true);
							ticketpriceitem.setPrice(routeprice.getPrice());
							ticketpriceitem.setScheduleid(schedule.getId());
							//F
							Ticketpriceformulaitem tfi = genScheduleplanServiceDao.qryTicketpriceformulaitem(orgid, "F");
							
							ticketpriceitem.setTicketprice(ticketprice);
							ticketpriceitem.setTicketpriceformulaitemid(tfi.getId());
							ticketpriceitem.setTickettype("Q");
							ticketpriceitem.setUpdateby(createby);
							ticketpriceitem.setUpdatetime(new Date());
							ticketpriceitems.add(ticketpriceitem);

							ticketprice
									.setTicketpriceitemlist(ticketpriceitems);

							ticketpricelist.add(ticketprice);
						}
					}
					else if (isexisthandholidayprice && handholidaypricelist.size()>0) {
						for (Handholidayprice handholidayprice : handholidaypricelist) {
							// 保存票价
							Ticketprice ticketprice = addTicketprice(
									handholidayprice, scheduleplan,
									reserveseats);
							BigDecimal moreprice = handholidayprice
									.getMoreprice();
							// 生成票价分项
							List<Ticketpriceitem> ticketpriceitems = new ArrayList<Ticketpriceitem>();
							List<Handholidaypriceitem> hpilist = handholidayprice
									.getHandholidaypriceitemlist();
							BigDecimal fuelfee = new BigDecimal(0);
							for (Handholidaypriceitem hpi : hpilist) {
								if (hpi.getTickettype().equals("Q")) {
									// 只要生成全票的票价分项
									Ticketpriceitem ticketpriceitem = new Ticketpriceitem();
									ticketpriceitem.setCreateby(createby);
									ticketpriceitem.setCreatetime(new Date());
									ticketpriceitem.setDepartdate(departdate);
									ticketpriceitem.setIsautoadjust(hpi
											.getIsautoadjust());
									ticketpriceitem.setPrice(hpi.getPrice());
									ticketpriceitem
											.setScheduleid(handholidayprice
													.getScheduleid());
									Ticketpriceformulaitem tfi = (Ticketpriceformulaitem) genScheduleplanServiceDao
											.get(Ticketpriceformulaitem.class,
													hpi.getTicketpriceformulaitemid());
									// K：为燃油费
									if (tfi.getCode().equals("K")) {
										// 获取燃油费
										if (fuelist != null
												&& fuelist.size() > 0) {
											long fuelfeegradeid = fuelist
													.get(0).getFuelfeegradeid();
											BigDecimal price = genScheduleplanServiceDao
													.qryFuelfeegradedetail(
															fuelfeegradeid,
															ticketprice
																	.getDistance());
											ticketpriceitem.setPrice(price);
											fuelfee = price;
										}
									}
									ticketpriceitem.setTicketprice(ticketprice);
									ticketpriceitem
											.setTicketpriceformulaitemid(hpi
													.getTicketpriceformulaitemid());
									ticketpriceitem.setTickettype(hpi
											.getTickettype());
									ticketpriceitem.setUpdateby(createby);
									ticketpriceitem.setUpdatetime(new Date());
									ticketpriceitems.add(ticketpriceitem);
								}
							}
							ticketprice
									.setTicketpriceitemlist(ticketpriceitems);
							if (fuelist != null && fuelist.size() > 0) {
								// 重新根据票价分项计算合计
								ticketprice = calTicketprice(ticketprice);
							}
							ticketprice.setFullprice(ticketprice.getFullprice()
									.add(moreprice));
							if (ParamterConst.COMMON_FLAG.FALG_YES.equals(isfuadedcut)) {
								ticketprice.setHalfprice(ticketprice
										.getHalfprice().add(moreprice)
										.add(fuelfee));
								ticketprice.setStudentprice(ticketprice
										.getStudentprice().add(moreprice)
										.add(fuelfee));
								ticketprice.setToplimitprice(ticketprice
										.getToplimitprice().add(fuelfee));
								ticketprice.setDiscountprice(ticketprice.getDiscountprice().add(moreprice).add(fuelfee));
								ticketprice.setRoundprice(ticketprice.getRoundprice().add(moreprice).add(fuelfee));
								ticketprice.setConnectprice(ticketprice.getConnectprice().add(moreprice).add(fuelfee));
							} else {
								ticketprice.setHalfprice(ticketprice
										.getHalfprice().add(moreprice));
								ticketprice.setStudentprice(ticketprice
										.getStudentprice().add(moreprice));
								ticketprice.setToplimitprice(ticketprice
										.getToplimitprice());
								ticketprice.setDiscountprice(ticketprice.getDiscountprice().add(moreprice));
								ticketprice.setRoundprice(ticketprice.getRoundprice().add(moreprice));
								ticketprice.setConnectprice(ticketprice.getConnectprice().add(moreprice));
							}

							ticketpricelist.add(ticketprice);
						}
					} else if (isstandardprice) {
						List<Standardprice> fitemlist = genScheduleplanServiceDao
								.queryStandardprice(schedule.getId(),
										vehicletype.getId());
						for (Standardprice standardprice : fitemlist) {
							// 获取公式票价
							// 保存票价
							Ticketprice ticketprice = addTicketprice(
									standardprice, scheduleplan, reserveseats);
							ticketpricelist.add(ticketprice);
							
							BigDecimal moreprice = ticketprice.getMoreprice();
							// 生成票价分项
							List<Ticketpriceitem> ticketpriceitems = new ArrayList<Ticketpriceitem>();
							List<Standardpriceitem> hpilist = standardprice.getStandardpriceitemlist();
							BigDecimal fuelfee = new BigDecimal(0);
							for (Standardpriceitem hpi : hpilist) {
								if (hpi.getTickettype().equals("Q")) {
									// 只要生成全票的票价分项
									Ticketpriceitem ticketpriceitem = new Ticketpriceitem();
									ticketpriceitem.setCreateby(createby);
									ticketpriceitem.setCreatetime(new Date());
									ticketpriceitem.setDepartdate(departdate);
									ticketpriceitem.setIsautoadjust(hpi
											.getIsautoadjust());
									ticketpriceitem.setPrice(hpi.getPrice());
									ticketpriceitem.setScheduleid(standardprice
											.getScheduleid());
									Ticketpriceformulaitem tfi = (Ticketpriceformulaitem) genScheduleplanServiceDao
											.get(Ticketpriceformulaitem.class,
													hpi.getTicketpriceformulaitemid());
									// K：为燃油费
									if (tfi.getCode().equals("K")) {
										// 获取燃油费
										if (fuelist != null
												&& fuelist.size() > 0) {
											long fuelfeegradeid = fuelist
													.get(0).getFuelfeegradeid();
											BigDecimal price = genScheduleplanServiceDao
													.qryFuelfeegradedetail(
															fuelfeegradeid,
															ticketprice
																	.getDistance());
											ticketpriceitem.setPrice(price);
											fuelfee = price;
										}
									}
									ticketpriceitem.setTicketprice(ticketprice);
									ticketpriceitem
											.setTicketpriceformulaitemid(hpi
													.getTicketpriceformulaitemid());
									ticketpriceitem.setTickettype(hpi
											.getTickettype());
									ticketpriceitem.setUpdateby(createby);
									ticketpriceitem.setUpdatetime(new Date());
									ticketpriceitems.add(ticketpriceitem);
								}
							}
							ticketprice
									.setTicketpriceitemlist(ticketpriceitems);
							if (fuelist != null && fuelist.size() > 0) {
								// 重新根据票价分项计算合计
								ticketprice = calTicketprice(ticketprice);
							}
							ticketprice.setFullprice(ticketprice.getFullprice()
									.add(moreprice));
							if (ParamterConst.COMMON_FLAG.FALG_YES.equals(isfuadedcut)) {
								ticketprice.setHalfprice(ticketprice
										.getHalfprice().add(moreprice)
										.add(fuelfee));
								ticketprice.setStudentprice(ticketprice
										.getStudentprice().add(moreprice)
										.add(fuelfee));
								ticketprice.setToplimitprice(ticketprice
										.getToplimitprice().add(fuelfee));
								ticketprice.setDiscountprice(ticketprice.getDiscountprice().add(moreprice).add(fuelfee));
								ticketprice.setRoundprice(ticketprice.getRoundprice().add(moreprice).add(fuelfee));
								ticketprice.setConnectprice(ticketprice.getConnectprice().add(moreprice).add(fuelfee));
							} else {
								ticketprice.setHalfprice(ticketprice
										.getHalfprice().add(moreprice));
								ticketprice.setStudentprice(ticketprice
										.getStudentprice().add(moreprice));
								ticketprice.setToplimitprice(ticketprice
										.getToplimitprice());
								ticketprice.setDiscountprice(ticketprice.getDiscountprice().add(moreprice));
								ticketprice.setRoundprice(ticketprice.getRoundprice().add(moreprice));
								ticketprice.setConnectprice(ticketprice.getConnectprice().add(moreprice));
							}
							ticketpricelist.add(ticketprice);
							
							
							
						}
					} else {
						for (Handprice handprice : handpricelist) {
							// 保存硬调票价
							Ticketprice ticketprice = addTicketprice(handprice,
									scheduleplan, reserveseats);
							if(handprice.getDiscountprice().compareTo(ticketprice.getDiscountprice())!=0){
								play.Logger.info("1:new handprice.getDiscountprice()="+handprice.getDiscountprice());
								play.Logger.info("1:new ticketprice.getDiscountprice()="+ticketprice.getDiscountprice());
							}
							play.Logger.info("schcode="+schedule.getCode()+"handprice.discountprice="+handprice.getDiscountprice()+",ticketprice.getDiscountprice="+ticketprice.getDiscountprice());
							
							BigDecimal moreprice = handprice.getMoreprice();
							// 生成票价分项
							List<Ticketpriceitem> ticketpriceitems = new ArrayList<Ticketpriceitem>();
							List<Handpriceitem> hpilist = handprice
									.getHandpriceitemlist();
							BigDecimal fuelfee = new BigDecimal(0);
							for (Handpriceitem hpi : hpilist) {
								if (hpi.getTickettype().equals("Q")) {
									// 只要生成全票的票价分项
									Ticketpriceitem ticketpriceitem = new Ticketpriceitem();
									ticketpriceitem.setCreateby(createby);
									ticketpriceitem.setCreatetime(new Date());
									ticketpriceitem.setDepartdate(departdate);
									ticketpriceitem.setIsautoadjust(hpi
											.getIsautoadjust());
									ticketpriceitem.setPrice(hpi.getPrice());
									ticketpriceitem.setScheduleid(handprice
											.getScheduleid());
									Ticketpriceformulaitem tfi = (Ticketpriceformulaitem) genScheduleplanServiceDao
											.get(Ticketpriceformulaitem.class,
													hpi.getTicketpriceformulaitemid());
									// K：为燃油费
									if (tfi.getCode().equals("K")) {
										// 获取燃油费
										if (fuelist != null
												&& fuelist.size() > 0) {
											long fuelfeegradeid = fuelist
													.get(0).getFuelfeegradeid();
											BigDecimal price = genScheduleplanServiceDao
													.qryFuelfeegradedetail(
															fuelfeegradeid,
															ticketprice
																	.getDistance());
											ticketpriceitem.setPrice(price);
											fuelfee = price;
										}
									}
									ticketpriceitem.setTicketprice(ticketprice);
									ticketpriceitem
											.setTicketpriceformulaitemid(hpi
													.getTicketpriceformulaitemid());
									ticketpriceitem.setTickettype(hpi
											.getTickettype());
									ticketpriceitem.setUpdateby(createby);
									ticketpriceitem.setUpdatetime(new Date());
									ticketpriceitems.add(ticketpriceitem);
								}
							}
							ticketprice
									.setTicketpriceitemlist(ticketpriceitems);
							if (fuelist != null && fuelist.size() > 0) {
								// 重新根据票价分项计算合计
								ticketprice = calTicketprice(ticketprice);
							}
							ticketprice.setFullprice(ticketprice.getFullprice()
									.add(moreprice));
							if (ParamterConst.COMMON_FLAG.FALG_YES.equals(isfuadedcut)) {
								ticketprice.setHalfprice(ticketprice
										.getHalfprice().add(moreprice)
										.add(fuelfee));
								ticketprice.setStudentprice(ticketprice
										.getStudentprice().add(moreprice)
										.add(fuelfee));
								ticketprice.setToplimitprice(ticketprice
										.getToplimitprice().add(fuelfee));
								ticketprice.setDiscountprice(ticketprice.getDiscountprice().add(moreprice).add(fuelfee));
								ticketprice.setRoundprice(ticketprice.getRoundprice().add(moreprice).add(fuelfee));
								ticketprice.setConnectprice(ticketprice.getConnectprice().add(moreprice).add(fuelfee));
							} else {
								ticketprice.setHalfprice(ticketprice
										.getHalfprice().add(moreprice));
								ticketprice.setStudentprice(ticketprice
										.getStudentprice().add(moreprice));
								ticketprice.setToplimitprice(ticketprice
										.getToplimitprice());
								ticketprice.setDiscountprice(ticketprice.getDiscountprice().add(moreprice));
								ticketprice.setRoundprice(ticketprice.getRoundprice().add(moreprice));
								ticketprice.setConnectprice(ticketprice.getConnectprice().add(moreprice));
							}
							ticketpricelist.add(ticketprice);
							if(handprice.getDiscountprice().compareTo(ticketprice.getDiscountprice())!=0){
								play.Logger.info("2:new handprice.getDiscountprice()="+handprice.getDiscountprice());
								play.Logger.info("2:new ticketprice.getDiscountprice()="+ticketprice.getDiscountprice());
							}
						}
					}// 生成票价结束

					scheduleplan.setTicketpricelist(ticketpricelist);
					if (scheduleplan.getIslinework()) {
						scheduleplan.setScheduleseatslist(null);
					} else {
						scheduleplan.setScheduleseatslist(scheduleseatslist);
						// 修改座位类型跟票价表一致
						boolean isseatprice = false;
						for (Scheduleseats scheduleseats : scheduleseatslist) {
							isseatprice = false;
							String seattype = "0";
							for (Ticketprice ticketprice : ticketpricelist) {
								seattype = ticketprice.getSeattype();
								String[] seatnos = ticketprice.getSeatnos()
										.split(",");
								String curseatno = String.valueOf(scheduleseats
										.getSeatno());
								if (StringUtils.contains(seatnos, curseatno)) {
									scheduleseats.setSeattype(ticketprice
											.getSeattype());
									isseatprice = true;
									break;
								}
							}
							if (!isseatprice) {
								scheduleseats.setSeattype(seattype);
							}
						}

					}
					scheduleplan.setSchedulestatuslist(schedulestatuslist);
					scheduleplan
							.setSchedulevehiclepeopleplanlist(schedulevehiclepeopleplanlist);
//					
//					List<Ticketprice> lt = scheduleplan.getTicketpricelist();
//					List<Ticketprice> newticketpricelist = new ArrayList<Ticketprice>(lt.size());					 
//					for(Ticketprice tp:lt){
//						newticketpricelist.add(tp);
//					}
//					
//					scheduleplan.setTicketpricelist(newticketpricelist);				
//					genScheduleplanServiceDao.getEntityManager().persist(
//							scheduleplan);
					
					//新增班次预售票申请参数打开的话，生成计划不可售，必须申请
					//Global global = CurrentUtil.getGlobal();
					/*String tt = parameterService.findParamValue("0036",scheduleplan.getOrgid());
					if("1".equals(tt))//1表示启用，班次不可售
					{
						scheduleplan.setIssellable(false);
						genScheduleplanServiceDao.getEntityManager().persist(
								scheduleplan);
						Global global = new Global();
						Organization org=(Organization) genScheduleplanServiceDao.get(Organization.class, orgid);						
						global.setOrganization(org);
						ActionNode actionNode = Appvar.routes.get("SCHEDULEPRESALEPLUGIN");
						PluginFunctionUtil.DoPlugin(scheduleplan, global, actionNode);
						SchedulepresaleApply schedulepresaleApply = null;
						if(schedulePreSaleapplyDao.qryschedulepresalebyscheduleplanid(scheduleplan.getId())!=null)
						{
							schedulepresaleApply = schedulePreSaleapplyDao.qryschedulepresalebyscheduleplanid(scheduleplan.getId());
						}else
						{
							
							schedulepresaleApply = new SchedulepresaleApply();
						}
						schedulepresaleApply.setOrgid(CurrentUtil.getGlobal().getUserinfo().getOrgid());
						schedulepresaleApply.setScheduleplanid(scheduleplan.getId());
						schedulepresaleApply.setApplystatus("0");
						schedulepresaleApply.setAuditstatus("0");
						schedulepresaleApply.setAuditadvice("");
						schedulepresaleApply.setApplytime(null);
						schedulepresaleApply.setAudittime(null);
						
						schedulepresaleApply.setApplypersonid(-1L);
						schedulepresaleApply.setAuditpersonid(-1L);
						schedulepresaleApply.setCreateby(global.getUserinfo().getId());
						schedulepresaleApply.setCreatetime(new Date());
						schedulepresaleApply.setUpdatetime(new Date());
						schedulepresaleApply.setUpdateby(global.getUserinfo().getId());
						
						
						schedulePreSaleapplyDao.merge(schedulepresaleApply);
					}else
					{
						
					}*/
					genScheduleplanServiceDao.getEntityManager().persist(
							scheduleplan);
					
					userTransaction.commit();
				} catch (Exception e) {
					System.out.println("回滚异常Exception");
					userTransaction.rollback();
					play.Logger.error(e.getMessage(), e);
					result.setResultMsg(schedule.getCode() + "班次："
							+ departdatestr + "生成计划失败，原因:");
					result.setResult(MethodResult.FAILURE);
					saveScheduleplanlog(scheduleplanlog, result.getResultMsg(),
							schedule.getId());
					return result;
				}
			}
			// 已经生成计划
			else {
				//* 自动生成计划时，若已经生成，则不再覆盖生成
				if(scheduleplanlog.getIsautogen()){
					userTransaction.rollback();
					result.setResult(MethodResult.FAILURE);
					result.setResultMsg(schedule.getCode() + "班次："
							+ departdatestr
							+ "计划已经生成！");
					saveScheduleplanlog(scheduleplanlog,
							result.getResultMsg(), schedule.getId());
					return result;
				}
				if(DateUtils.compare(departdate, enddate)>=0) {
					userTransaction.rollback();
					result.setResult(MethodResult.FAILURE);
					result.setResultMsg(schedule.getCode() + "班次："
							+ departdatestr
							+ "计划已经生成,并且发车日期小于最大的生成班次计划的天数！");
					saveScheduleplanlog(scheduleplanlog,
							result.getResultMsg(), schedule.getId());
					return result;
				}
				// 更新班次计划
				try {
					if (oldscheduleplan.getSoldeatnum() > seatnum) {
						userTransaction.rollback();
						result.setResult(MethodResult.FAILURE);
						result.setResultMsg(schedule.getCode() + "班次："
								+ departdatestr
								+ "生成计划失败,原因：计划车型或者车辆座位数小于已售座位数！");
						saveScheduleplanlog(scheduleplanlog,
								result.getResultMsg(), schedule.getId());
						return result;
					}
					soldeatnum = genScheduleplanServiceDao
							.getSchedulesoldeatnum(schedule.getId(), departdate);
					short cursoldeatnum = oldscheduleplan.getSoldeatnum();
					//配载班次售票记录在外站无法取到
					if (!oldscheduleplan.getWorktype().equals("3")  && soldeatnum != cursoldeatnum) {
						userTransaction.rollback();
						result.setResult(MethodResult.FAILURE);
						result.setResultMsg(schedule.getCode() + "班次："
								+ departdatestr + "生成计划失败,原因：实际售票数与系统表中已售数不符合！");
						saveScheduleplanlog(scheduleplanlog,
								result.getResultMsg(), schedule.getId());
						return result;
					}
					// 非流水班次才判断剩余座位数与实际是否符合
					if (!oldscheduleplan.getIslinework()) {
						leave = genScheduleplanServiceDao.getScheduleseats(
								schedule.getId(), departdate, "0");
						lockseatnum = genScheduleplanServiceDao
								.getScheduleseats(schedule.getId(), departdate,
										"1");

						fixedreserveseatnum = genScheduleplanServiceDao
								.getScheduleseats(schedule.getId(), departdate,
										"3");
						autocancelreserveseatnum = genScheduleplanServiceDao
								.getScheduleseats(schedule.getId(), departdate,
										"4");
						unautocancelreserveseatnum = genScheduleplanServiceDao
								.getScheduleseats(schedule.getId(), departdate,
										"5");
						// 验证剩余座位数是否与当前计算值符合
						if (!oldscheduleplan.getWorktype().equals("3")  && (oldscheduleplan.getSeatnum() - fixedreserveseatnum
								- lockseatnum - soldeatnum
								- autocancelreserveseatnum - unautocancelreserveseatnum) != leave) {
							userTransaction.rollback();
							result.setResult(MethodResult.FAILURE);
							result.setResultMsg(schedule.getCode() + "班次："
									+ departdatestr
									+ "生成计划失败,原因：实际剩余数与系统表中剩余数不符合！");
							saveScheduleplanlog(scheduleplanlog,
									result.getResultMsg(), schedule.getId());
							return result;
						}
						// 验证剩余座位数是否与当前计算值符合
						if (seatnum < fixedreserveseatnum + lockseatnum
								+ soldeatnum + autocancelreserveseatnum
								+ unautocancelreserveseatnum) {
							userTransaction.rollback();
							result.setResult(MethodResult.FAILURE);
							result.setResultMsg(schedule.getCode() + "班次："
									+ departdatestr
									+ "生成计划失败,原因：新车型剩余空座小于原来非空座数！");
							saveScheduleplanlog(scheduleplanlog,
									result.getResultMsg(), schedule.getId());
							return result;
						}
					}
					List<Schedulestatus> schedulestatuslist = oldscheduleplan
							.getSchedulestatuslist();
					for (Schedulestatus schedulestatus : schedulestatuslist) {
						if (schedulestatus.getIsreported()) {
							userTransaction.rollback();
							result.setResult(MethodResult.FAILURE);
							result.setResultMsg(schedule.getCode() + "班次："
									+ departdatestr + "生成计划失败,原因：该班次已经报到！");
							saveScheduleplanlog(scheduleplanlog,
									result.getResultMsg(), schedule.getId());
							return result;
						}
						
						/*if (sst != null && sst.size() > 0) {
							for (Schedulestatus ss : schedulestatuslist) {
								ss.setStatus("1");// 1报停
							}
						}
						else{
							for (Schedulestatus ss : schedulestatuslist) {
								ss.setStatus("0");// 正常
							}
						}*/
						//若原来存在班次计划，不改变班次状态
						/*else
						{
							for (Schedulestatus ss : schedulestatuslist) {
								ss.setStatus("0");// 1报停
							}
						}*/
						
					}

					List<Ticketsell> tslist = genScheduleplanServiceDao
							.qrySoldTickets(oldscheduleplan.getId(),
									oldscheduleplan.getDepartdate());
					boolean isexitstation = false;
					for (Ticketsell ts : tslist) {
						isexitstation = false;
						for (Schedulestop ss : departstoplist) {
							if (ts.getDepartstationid() == ss.getStationid()) {
								isexitstation = true;
								break;
							}
						}
						if (!isexitstation) {
							userTransaction.rollback();
							result.setResult(MethodResult.FAILURE);
							Station station = (Station) genScheduleplanServiceDao
									.get(Station.class, ts.getDepartstationid());
							result.setResultMsg(schedule.getCode() + "班次："
									+ departdatestr + "生成计划失败,原因：发车站站点"
									+ station.getName() + "已经售票，不允许删除！");
							saveScheduleplanlog(scheduleplanlog,
									result.getResultMsg(), schedule.getId());
							return result;
						}
						isexitstation = false;
						for (Schedulestop schedulestop : reachstoplist) {
							if (ts.getReachstationid() == schedulestop
									.getStationid()) {
								isexitstation = true;
								break;
							}
						}
						if (!isexitstation) {
							userTransaction.rollback();
							result.setResult(MethodResult.FAILURE);
							Station station = (Station) genScheduleplanServiceDao
									.get(Station.class, ts.getReachstationid());
							result.setResultMsg(schedule.getCode() + "班次："
									+ departdatestr + "生成计划失败,原因：停靠站点"
									+ station.getName() + "已经售票，不允许删除！");
							saveScheduleplanlog(scheduleplanlog,
									result.getResultMsg(), schedule.getId());
							return result;
						}
					}

					// 重新取一次固定留位信息，由于固定留位在基础表中有可能已经被删除
					if (scheduleseatreserve != null) {
						fixedreserveseatnum = scheduleseatreserve.getSeatnum();
					} else {
						fixedreserveseatnum = 0;
					}
					oldscheduleplan.setDistance(route.getDistance());
					oldscheduleplan.setDistricttype(schedule.getDistricttype());
					oldscheduleplan.setEndstationid(route.getEndstationid());
					oldscheduleplan.setEndtime(schedule.getEndtime());
					oldscheduleplan.setFixedreserveseatnum(fixedreserveseatnum);
					oldscheduleplan.setHighdistance(route.getHighdistance());
					oldscheduleplan.setIscanmixcheck(schedule
							.getIscanmixcheck());
					oldscheduleplan.setIslinework(schedule.getIslinework());
					oldscheduleplan.setIsoriginator(schedule.getIsoriginator());
					oldscheduleplan.setIsovertime(schedule.getIsovertime());
					oldscheduleplan.setIsproprietary(schedule
							.getIsproprietary());
					oldscheduleplan.setIssaleafterreport(schedule
							.getIssaleafterreport());
					oldscheduleplan.setIssellreturnticket(schedule
							.getIssellreturnticket());
					oldscheduleplan.setRuntime(schedule.getRuntime());
					oldscheduleplan.setScheduletype(schedule.getType());
					oldscheduleplan.setSpacinginterval(schedule
							.getSpacinginterval());
					oldscheduleplan
							.setStartstationid(route.getStartstationid());
					oldscheduleplan.setStarttime(schedule.getStarttime());
					oldscheduleplan.setUpdateby(createby);
					oldscheduleplan.setUpdatetime(new Date());
					oldscheduleplan.setRemarks(schedule.getRemarks());
					oldscheduleplan.setWorktype(schedule.getWorktype());
					oldscheduleplan.setWorkways(schedule.getWorkways());
					// if (reserveseats != null) {
					// oldscheduleplan
					// .setFixedreserveseatnum((short) reserveseats.length);
					// }
					// oldscheduleplan.setStationfeeapply(stationfeebp);
					// oldscheduleplan.setFueladditionfeeapply(fueladditionfeebp);
					// 重新生成班次状态信息begin
					boolean isexiststop = false;
					Iterator<Schedulestatus> it = schedulestatuslist.iterator();
					while (it.hasNext()) {
						isexiststop = false;
						Schedulestatus schedulestatus = it.next();
						for (Schedulestop schedulestop : departstoplist) {
							if (schedulestatus.getDepartstationid() == schedulestop
									.getStationid()) {
								isexiststop = true;
							}
						}
						if (!isexiststop) {
							genScheduleplanServiceDao.getEntityManager()
									.remove(schedulestatus);
							// genScheduleplanServiceDao.getEntityManager().flush();
							it.remove();
						}
					}

					for (Schedulestop schedulestop : departstoplist) {
						isexiststop = false;
						for (Schedulestatus schedulestatus : schedulestatuslist) {
							if (schedulestatus.getDepartstationid() == schedulestop
									.getStationid()) {
								isexiststop = true;
								updateSchedulestatus(schedulestatus,
										schedulestop, oldscheduleplan);
							}
						}
						if (!isexiststop) {
							genScheduleplanServiceDao.getEntityManager().merge(
									addSchedulestatus(schedulestop,
											oldscheduleplan));
						}
					}
					if (sst != null && sst.size() > 0) {
						for (Schedulestatus schedulestatus : schedulestatuslist) {
							schedulestatus.setStatus("1");// 1报停
						}
					}
					// 重新生成班次状态信息end
					List<Scheduleseats> scheduleseatslist = oldscheduleplan
							.getScheduleseatslist();
					if (oldscheduleplan.getIslinework()) {
						oldscheduleplan.setSeatnum(seatnum);
						for (Scheduleseats scheduleseats : scheduleseatslist) {
							genScheduleplanServiceDao.getEntityManager()
									.remove(scheduleseats);
						}
						scheduleseatslist.clear();
						genScheduleplanServiceDao.getEntityManager().flush();
					} else {
						// 先更原来的座位状态
						for (Scheduleseats scheduleseats : scheduleseatslist) {
							scheduleseats = updateScheduleseats(scheduleseats,
									reserveseats, planvehiclebrandmodel);
							genScheduleplanServiceDao.merge(scheduleseats);
						}
						if (seatnum > oldscheduleplan.getSeatnum()) {
							// 增加新的座位信息
							short curseatno = (short) (oldscheduleplan
									.getSeatnum() + 1);
							for (short seatno = curseatno; seatno <= seatnum; seatno++) {
								Scheduleseats scheduleseats = addScheduleseats(
										seatno, oldscheduleplan, reserveseats,
										planvehiclebrandmodel);
								genScheduleplanServiceDao.merge(scheduleseats);
							}
							oldscheduleplan.setSeatnum(seatnum);

						} else if (seatnum < oldscheduleplan.getSeatnum()) {
							// 新车辆座位数比原来座位数少
//							int fixseat = 0;
//							int unautoseat = 0;
//							int autoseat = 0;
							List<Short> soldseats = new ArrayList<Short>();
							/*
							 * Iterator<Scheduleseats> ssit = scheduleseatslist.iterator(); while (it.hasNext()) {
							 * Scheduleseats ss = ssit.next(); if (ss.getSeatno() > seatnum) { if
							 * (ss.getStatus().equals("2")) { soldseats.add(ss.getSeatno()); } else if
							 * (ss.getStatus().equals("3")) { fixseat++; } else if (ss.getStatus().equals("4")) {
							 * autoseat++; } else if (ss.getStatus().equals("5")) { unautoseat++;
							 * 
							 * genScheduleplanServiceDao.delete(ss); it.remove(); } }
							 */

							for (int j = seatnum + 1; j <= oldscheduleplan
									.getSeatnum(); j++) {
								short num = (short) j;
								Scheduleseats seats = genScheduleplanServiceDao
										.findByseatno(oldscheduleplan.getId(),
												num);
								if(seats!=null)
								{
									if (seats.getStatus().equals("2")) {
										soldseats.add(seats.getSeatno());
									} 
//									else if (seats.getStatus().equals("3")) {
//										fixseat++;
//									} else if (seats.getStatus().equals("4")) {
//										autoseat++;
//									} else if (seats.getStatus().equals("5")) {
//										unautoseat++;
//									}
								}else
								{
									userTransaction.rollback();
									result.setResult(MethodResult.FAILURE);
									result.setResultMsg(schedule.getCode()
											+ "班次：" + departdatestr
											+ "生成计划失败,原因：该班次未找到对应班次座位图！");
									saveScheduleplanlog(scheduleplanlog,
											result.getResultMsg(),
											schedule.getId());
									return result;
								}
								boolean isqryseat = false;
								for (Short seatno : soldseats) {
									isqryseat = false;
									Ticketsell ts = ticketService.getTicket(
											oldscheduleplan.getId(), seatno);
									// 改到空座上
									for (Scheduleseats aa : scheduleseatslist) {
										if (aa.getSeatno() <= seatnum
												&& aa.getStatus().equals("0")) {
											// 找到空座
											isqryseat = true;
											ts.setSeatno(aa.getSeatno());
											ts.setUpdateby(oldscheduleplan
													.getUpdateby());
											ts.setUpdatetime(new Date());
											aa.setStatus("2");
											aa.setTickettype(ts.getTickettype());
											aa.setUpdateby(oldscheduleplan
													.getUpdateby());
											aa.setUpdatetime(new Date());
											genScheduleplanServiceDao.merge(aa);
											break;
										}
									}
									if (!isqryseat) {
										userTransaction.rollback();
										result.setResult(MethodResult.FAILURE);
										result.setResultMsg(schedule.getCode()
												+ "班次：" + departdatestr
												+ "生成计划失败,原因：该班次已售"
												+ ts.getSeatno() + "号座位未找到可换位的空位！");
										saveScheduleplanlog(scheduleplanlog,
												result.getResultMsg(),
												schedule.getId());
										return result;
									}
								}

//								for (int i = 0; i < fixseat; i++) {
								if (seats.getStatus().equals("3")) {
									isqryseat = false;
									// 改到空座上
									for (Scheduleseats aa : scheduleseatslist) {
										if (aa.getSeatno() <= seatnum
												&& aa.getStatus().equals("0")) {
											// 找到空座
											isqryseat = true;
											aa.setStatus("3");
											aa.setUpdateby(oldscheduleplan
													.getUpdateby());
											aa.setUpdatetime(new Date());
											updateSeatreserve(oldscheduleplan,aa,seats);
											genScheduleplanServiceDao.merge(aa);
											break;
										}
									}
									if (!isqryseat) {
										userTransaction.rollback();
										result.setResult(MethodResult.FAILURE);
										result.setResultMsg(schedule.getCode()
												+ "班次：" + departdatestr
												+ "生成计划失败,原因：该班次固定留位未找到可换位的空位！");
										saveScheduleplanlog(scheduleplanlog,
												result.getResultMsg(),
												schedule.getId());
										return result;
									}
								}
//								for (int i = 0; i < autoseat; i++) {
								if (seats.getStatus().equals("4")) {
									isqryseat = false;
									// 改到空座上
									for (Scheduleseats aa : scheduleseatslist) {
										if (aa.getSeatno() <= seatnum
												&& aa.getStatus().equals("0")) {
											// 找到空座
											isqryseat = true;
											aa.setStatus("4");
											aa.setUpdateby(oldscheduleplan
													.getCreateby());
											aa.setUpdatetime(new Date());
											updateSeatreserve(oldscheduleplan,aa,seats);
											genScheduleplanServiceDao.merge(aa);
											break;
										}
									}
									if (!isqryseat) {
										userTransaction.rollback();
										result.setResult(MethodResult.FAILURE);
										result.setResultMsg(schedule.getCode()
												+ "班次：" + departdatestr
												+ "生成计划失败,原因：该班次自动取消留位未找到可换位的空位！");
										saveScheduleplanlog(scheduleplanlog,
												result.getResultMsg(),
												schedule.getId());
										return result;
									}
								}
//								for (int i = 0; i < unautoseat; i++) {
								if (seats.getStatus().equals("5")) {
									isqryseat = false;
									// 改到空座上
									for (Scheduleseats aa : scheduleseatslist) {
										if (aa.getSeatno() <= seatnum
												&& aa.getStatus().equals("0")) {
											// 找到空座
											isqryseat = true;
											aa.setStatus("5");
											aa.setUpdateby(oldscheduleplan
													.getCreateby());
											aa.setUpdatetime(new Date());
											updateSeatreserve(oldscheduleplan,aa,seats);
											genScheduleplanServiceDao.merge(aa);
											break;
										}
									}
									if (!isqryseat) {
										userTransaction.rollback();
										result.setResult(MethodResult.FAILURE);
										result.setResultMsg(schedule.getCode()
												+ "班次：" + departdatestr
												+ "生成计划失败,原因：该班次不自动取消留位未找到可换位的空位！");
										saveScheduleplanlog(scheduleplanlog,
												result.getResultMsg(),
												schedule.getId());
										return result;
									}
								}
							}

							
							Iterator<Scheduleseats> ssit = oldscheduleplan
									.getScheduleseatslist().iterator();
							while (ssit.hasNext()) {
								Scheduleseats ss = ssit.next();
								if (ss.getSeatno() > seatnum) {
									genScheduleplanServiceDao.delete(ss);
									ssit.remove();
								}
							}
							oldscheduleplan.setSeatnum(seatnum);
						}// 重新生成班次座位end
					}

					// 生成车辆驾驶员乘务员计划信息
					List<Schedulevehiclepeopleplan> newschedulevehiclepeopleplans = saveSchedulevehiclepeopleplan(oldscheduleplan);

					if (oldscheduleplan.getSchedulevehiclepeopleplanlist()
							.size() == newschedulevehiclepeopleplans.size()) {
						for (Schedulevehiclepeopleplan oldsv : oldscheduleplan
								.getSchedulevehiclepeopleplanlist()) {
							for (Schedulevehiclepeopleplan sv : newschedulevehiclepeopleplans) {
								if (sv.getOrderno() == oldsv.getOrderno()) {
									oldsv.setPlandriver1(sv.getPlandriver1());
									oldsv.setPlandriver2(sv.getPlandriver2());
									oldsv.setPlandriver3(sv.getPlandriver3());
									oldsv.setPlandriver4(sv.getPlandriver4());
									oldsv.setPlansteward1(sv.getPlansteward1());
									oldsv.setPlansteward2(sv.getPlansteward2());
									oldsv.setPlanunit(sv.getPlanunit());
									oldsv.setPlanvehicle(sv.getPlanvehicle());
									oldsv.setPlanvehiclebrandmodelid(sv
											.getPlanvehiclebrandmodelid());
									oldsv.setPlanvehicletypeid(sv
											.getPlanvehicletypeid());
									oldsv.setUpdateby(createby);
									oldsv.setUpdatetime(new Date());
									break;
								}
							}
						}
					} else {
						// 删除生成车辆驾驶员乘务员计划信息
						delSchedulevehiclepeopleplan(oldscheduleplan);
						oldscheduleplan
								.setSchedulevehiclepeopleplanlist(newschedulevehiclepeopleplans);
					}

					// 还未售票才允许重新生成票价
					// if (oldscheduleplan.getSoldeatnum() == 0) {
					// 重新生成票价
					ticketpricelist = oldscheduleplan.getTicketpricelist();
					List<Ticketprice> oldtplist = new ArrayList<Ticketprice>();
					for (Ticketprice ticketprice : ticketpricelist) {
						oldtplist.add(ticketprice);
					}
					for (Ticketprice ticketprice : ticketpricelist) {
						genScheduleplanServiceDao.getEntityManager().remove(
								ticketprice);
					}
					ticketpricelist.clear();
					genScheduleplanServiceDao.getEntityManager().flush();
					
					
					if(rplist!=null && rplist.size()>0){
						for (Routeprice routeprice : rplist) {
							if (!genScheduleplanServiceDao.isexistSchstop(schedule.getId(),routeprice.getReachstationid())){
								continue;
							}
							// 保存票价
							Ticketprice ticketprice = addTicketprice(
									routeprice, oldscheduleplan,
									reserveseats);
							// 生成票价分项
							List<Ticketpriceitem> ticketpriceitems = new ArrayList<Ticketpriceitem>();
							// 只要生成全票的票价分项
							Ticketpriceitem ticketpriceitem = new Ticketpriceitem();
							ticketpriceitem.setCreateby(createby);
							ticketpriceitem.setCreatetime(new Date());
							ticketpriceitem.setDepartdate(departdate);
							ticketpriceitem.setIsautoadjust(true);
							ticketpriceitem.setPrice(routeprice.getPrice());
							ticketpriceitem.setScheduleid(schedule.getId());
							//F
							Ticketpriceformulaitem tfi = genScheduleplanServiceDao.qryTicketpriceformulaitem(orgid, "F");
							
							ticketpriceitem.setTicketprice(ticketprice);
							ticketpriceitem.setTicketpriceformulaitemid(tfi.getId());
							ticketpriceitem.setTickettype("Q");
							ticketpriceitem.setUpdateby(createby);
							ticketpriceitem.setUpdatetime(new Date());
							ticketpriceitems.add(ticketpriceitem);

							ticketprice
									.setTicketpriceitemlist(ticketpriceitems);

							ticketpricelist.add(ticketprice);
						}
					}
					// // 若有节日票价
					else if (isexisthandholidayprice) {
						for (Handholidayprice handholidayprice : handholidaypricelist) {
							// 保存票价
							Ticketprice ticketprice = addTicketprice(
									handholidayprice, oldscheduleplan,
									reserveseats);
							BigDecimal moreprice = handholidayprice
									.getMoreprice();
							for (Ticketprice tp : oldtplist) {
								if (ticketprice.getDepartstationid() == tp
										.getDepartstationid()
										&& ticketprice.getReachstationid() == tp
												.getReachstationid()
										&& ticketprice.getSeattype().equals(
												tp.getSeattype())) {
									ticketprice.setAutocancelreserveseatnum(tp
											.getAutocancelreserveseatnum());
									ticketprice
											.setUnautocancelreserveseatnum(tp
													.getUnautocancelreserveseatnum());
									ticketprice.setSoldeatnum(tp
											.getSoldeatnum());
									// ticketprice.setFixedreserveseatnum(tp
									// .getFixedreserveseatnum());
								}
							}
							// 生成票价分项
							List<Ticketpriceitem> ticketpriceitems = new ArrayList<Ticketpriceitem>();
							List<Handholidaypriceitem> hpilist = handholidayprice
									.getHandholidaypriceitemlist();
							BigDecimal fuelfee = new BigDecimal(0);
							for (Handholidaypriceitem hpi : hpilist) {
								if (hpi.getTickettype().equals("Q")) {
									// 只要生成全票的票价分项
									Ticketpriceitem ticketpriceitem = new Ticketpriceitem();
									ticketpriceitem.setCreateby(createby);
									ticketpriceitem.setCreatetime(new Date());
									ticketpriceitem.setDepartdate(departdate);
									ticketpriceitem.setIsautoadjust(hpi
											.getIsautoadjust());
									ticketpriceitem.setPrice(hpi.getPrice());
									ticketpriceitem
											.setScheduleid(handholidayprice
													.getScheduleid());
									Ticketpriceformulaitem tfi = (Ticketpriceformulaitem) genScheduleplanServiceDao
											.get(Ticketpriceformulaitem.class,
													hpi.getTicketpriceformulaitemid());
									// K：为燃油费
									if (tfi.getCode().equals("K")) {
										// 获取燃油费
										if (fuelist != null
												&& fuelist.size() > 0) {
											long fuelfeegradeid = fuelist
													.get(0).getFuelfeegradeid();
											BigDecimal price = genScheduleplanServiceDao
													.qryFuelfeegradedetail(
															fuelfeegradeid,
															ticketprice
																	.getDistance());
											ticketpriceitem.setPrice(price);
											fuelfee = price;
										}
									}
									ticketpriceitem.setTicketprice(ticketprice);
									ticketpriceitem
											.setTicketpriceformulaitemid(hpi
													.getTicketpriceformulaitemid());
									ticketpriceitem.setTickettype(hpi
											.getTickettype());
									ticketpriceitem.setUpdateby(createby);
									ticketpriceitem.setUpdatetime(new Date());
									ticketpriceitems.add(ticketpriceitem);
								}
							}
							ticketprice
									.setTicketpriceitemlist(ticketpriceitems);
							if (fuelist != null && fuelist.size() > 0) {
								// 重新根据票价分项计算合计
								ticketprice = calTicketprice(ticketprice);
							}
							ticketprice.setFullprice(ticketprice.getFullprice()
									.add(moreprice));
							if (ParamterConst.COMMON_FLAG.FALG_YES.equals(isfuadedcut)) {
								ticketprice.setHalfprice(ticketprice
										.getHalfprice().add(moreprice)
										.add(fuelfee));
								ticketprice.setStudentprice(ticketprice
										.getStudentprice().add(moreprice)
										.add(fuelfee));
								ticketprice.setToplimitprice(ticketprice
										.getToplimitprice().add(fuelfee));
								ticketprice.setDiscountprice(ticketprice.getDiscountprice().add(moreprice).add(fuelfee));
								ticketprice.setRoundprice(ticketprice.getRoundprice().add(moreprice).add(fuelfee));
								ticketprice.setConnectprice(ticketprice.getConnectprice().add(moreprice).add(fuelfee));
							} else {
								ticketprice.setHalfprice(ticketprice
										.getHalfprice().add(moreprice));
								ticketprice.setStudentprice(ticketprice
										.getStudentprice().add(moreprice));
								ticketprice.setToplimitprice(ticketprice
										.getToplimitprice());
								ticketprice.setDiscountprice(ticketprice.getDiscountprice().add(moreprice));
								ticketprice.setRoundprice(ticketprice.getRoundprice().add(moreprice));
								ticketprice.setConnectprice(ticketprice.getConnectprice().add(moreprice));
							}
							ticketpricelist.add(ticketprice);
						}
					}else if(isstandardprice){
						List<Standardprice> fitemlist = genScheduleplanServiceDao
								.queryStandardprice(schedule.getId(),
										vehicletype.getId());
						for (Standardprice standardprice : fitemlist) {
							// 获取公式票价
							// 保存票价
							Ticketprice ticketprice = addTicketprice(
									standardprice, oldscheduleplan, reserveseats);
							ticketpricelist.add(ticketprice);
							
							BigDecimal moreprice = ticketprice.getMoreprice();
							// 生成票价分项
							List<Ticketpriceitem> ticketpriceitems = new ArrayList<Ticketpriceitem>();
							List<Standardpriceitem> hpilist = standardprice.getStandardpriceitemlist();
							BigDecimal fuelfee = new BigDecimal(0);
							for (Standardpriceitem hpi : hpilist) {
								if (hpi.getTickettype().equals("Q")) {
									// 只要生成全票的票价分项
									Ticketpriceitem ticketpriceitem = new Ticketpriceitem();
									ticketpriceitem.setCreateby(createby);
									ticketpriceitem.setCreatetime(new Date());
									ticketpriceitem.setDepartdate(departdate);
									ticketpriceitem.setIsautoadjust(hpi
											.getIsautoadjust());
									ticketpriceitem.setPrice(hpi.getPrice());
									ticketpriceitem.setScheduleid(standardprice
											.getScheduleid());
									Ticketpriceformulaitem tfi = (Ticketpriceformulaitem) genScheduleplanServiceDao
											.get(Ticketpriceformulaitem.class,
													hpi.getTicketpriceformulaitemid());
									// K：为燃油费
									if (tfi.getCode().equals("K")) {
										// 获取燃油费
										if (fuelist != null
												&& fuelist.size() > 0) {
											long fuelfeegradeid = fuelist
													.get(0).getFuelfeegradeid();
											BigDecimal price = genScheduleplanServiceDao
													.qryFuelfeegradedetail(
															fuelfeegradeid,
															ticketprice
																	.getDistance());
											ticketpriceitem.setPrice(price);
											fuelfee = price;
										}
									}
									ticketpriceitem.setTicketprice(ticketprice);
									ticketpriceitem
											.setTicketpriceformulaitemid(hpi
													.getTicketpriceformulaitemid());
									ticketpriceitem.setTickettype(hpi
											.getTickettype());
									ticketpriceitem.setUpdateby(createby);
									ticketpriceitem.setUpdatetime(new Date());
									ticketpriceitems.add(ticketpriceitem);
								}
							}
							ticketprice
									.setTicketpriceitemlist(ticketpriceitems);
							if (fuelist != null && fuelist.size() > 0) {
								// 重新根据票价分项计算合计
								ticketprice = calTicketprice(ticketprice);
							}
							ticketprice.setFullprice(ticketprice.getFullprice()
									.add(moreprice));
							if (ParamterConst.COMMON_FLAG.FALG_YES.equals(isfuadedcut)) {
								ticketprice.setHalfprice(ticketprice
										.getHalfprice().add(moreprice)
										.add(fuelfee));
								ticketprice.setStudentprice(ticketprice
										.getStudentprice().add(moreprice)
										.add(fuelfee));
								ticketprice.setToplimitprice(ticketprice
										.getToplimitprice().add(fuelfee));
								ticketprice.setDiscountprice(ticketprice.getDiscountprice().add(moreprice).add(fuelfee));
								ticketprice.setRoundprice(ticketprice.getRoundprice().add(moreprice).add(fuelfee));
								ticketprice.setConnectprice(ticketprice.getConnectprice().add(moreprice).add(fuelfee));
							} else {
								ticketprice.setHalfprice(ticketprice
										.getHalfprice().add(moreprice));
								ticketprice.setStudentprice(ticketprice
										.getStudentprice().add(moreprice));
								ticketprice.setToplimitprice(ticketprice
										.getToplimitprice());
								ticketprice.setDiscountprice(ticketprice.getDiscountprice().add(moreprice));
								ticketprice.setRoundprice(ticketprice.getRoundprice().add(moreprice));
								ticketprice.setConnectprice(ticketprice.getConnectprice().add(moreprice));
							}
							ticketpricelist.add(ticketprice);
							
							
							
						}
					} else {
						for (Handprice handprice : handpricelist) {
							Ticketprice ticketprice = addTicketprice(handprice,
									oldscheduleplan, reserveseats);
							if(handprice.getDiscountprice().compareTo(ticketprice.getDiscountprice())!=0){
								play.Logger.info("1:handprice.getDiscountprice()="+handprice.getDiscountprice());
								play.Logger.info("1:ticketprice.getDiscountprice()="+ticketprice.getDiscountprice());
							}
							BigDecimal moreprice = handprice.getMoreprice();
							for (Ticketprice tp : oldtplist) {
								if (ticketprice.getDepartstationid() == tp
										.getDepartstationid()
										&& ticketprice.getReachstationid() == tp
												.getReachstationid()
										&& ticketprice.getSeattype().equals(
												tp.getSeattype())) {
									ticketprice.setAutocancelreserveseatnum(tp
											.getAutocancelreserveseatnum());
									ticketprice
											.setUnautocancelreserveseatnum(tp
													.getUnautocancelreserveseatnum());
									ticketprice.setSoldeatnum(tp
											.getSoldeatnum());
								}
							}
							// 生成票价分项
							List<Ticketpriceitem> ticketpriceitems = new ArrayList<Ticketpriceitem>();
							List<Handpriceitem> hpilist = handprice
									.getHandpriceitemlist();
							BigDecimal fuelfee = new BigDecimal(0);
							for (Handpriceitem hpi : hpilist) {
								if (hpi.getTickettype().equals("Q")) {
									// 只要生成全票的票价分项
									Ticketpriceitem ticketpriceitem = new Ticketpriceitem();
									ticketpriceitem.setCreateby(createby);
									ticketpriceitem.setCreatetime(new Date());
									ticketpriceitem.setDepartdate(departdate);
									ticketpriceitem.setIsautoadjust(hpi
											.getIsautoadjust());
									ticketpriceitem.setPrice(hpi.getPrice());
									ticketpriceitem.setScheduleid(handprice
											.getScheduleid());
									Ticketpriceformulaitem tfi = (Ticketpriceformulaitem) genScheduleplanServiceDao
											.get(Ticketpriceformulaitem.class,
													hpi.getTicketpriceformulaitemid());
									// K：为燃油费
									if (tfi.getCode().equals("K")) {
										// 获取燃油费
										if (fuelist != null
												&& fuelist.size() > 0) {
											long fuelfeegradeid = fuelist
													.get(0).getFuelfeegradeid();
											BigDecimal price = genScheduleplanServiceDao
													.qryFuelfeegradedetail(
															fuelfeegradeid,
															ticketprice
																	.getDistance());
											ticketpriceitem.setPrice(price);
											fuelfee = price;
										}
									}
									ticketpriceitem.setTicketprice(ticketprice);
									ticketpriceitem
											.setTicketpriceformulaitemid(hpi
													.getTicketpriceformulaitemid());
									ticketpriceitem.setTickettype(hpi
											.getTickettype());
									ticketpriceitem.setUpdateby(createby);
									ticketpriceitem.setUpdatetime(new Date());
									ticketpriceitems.add(ticketpriceitem);
								}
							}
							ticketprice
									.setTicketpriceitemlist(ticketpriceitems);
							if (fuelist != null && fuelist.size() > 0) {
								// 重新根据票价分项计算合计
								ticketprice = calTicketprice(ticketprice);
							}
							ticketprice.setFullprice(ticketprice.getFullprice()
									.add(moreprice));
							if (ParamterConst.COMMON_FLAG.FALG_YES.equals(isfuadedcut)) {
								ticketprice.setHalfprice(ticketprice
										.getHalfprice().add(moreprice)
										.add(fuelfee));
								ticketprice.setStudentprice(ticketprice
										.getStudentprice().add(moreprice)
										.add(fuelfee));
								ticketprice.setToplimitprice(ticketprice
										.getToplimitprice().add(fuelfee));
								ticketprice.setDiscountprice(ticketprice.getDiscountprice().add(moreprice).add(fuelfee));
								ticketprice.setRoundprice(ticketprice.getRoundprice().add(moreprice).add(fuelfee));
								ticketprice.setConnectprice(ticketprice.getConnectprice().add(moreprice).add(fuelfee));
							} else {
								ticketprice.setHalfprice(ticketprice
										.getHalfprice().add(moreprice));
								ticketprice.setStudentprice(ticketprice
										.getStudentprice().add(moreprice));
								ticketprice.setToplimitprice(ticketprice
										.getToplimitprice());
								ticketprice.setDiscountprice(ticketprice.getDiscountprice().add(moreprice));
								ticketprice.setRoundprice(ticketprice.getRoundprice().add(moreprice));
								ticketprice.setConnectprice(ticketprice.getConnectprice().add(moreprice));
							}
							if(handprice.getDiscountprice().compareTo(ticketprice.getDiscountprice())!=0){
								play.Logger.info("2:handprice.getDiscountprice()="+handprice.getDiscountprice());
								play.Logger.info("2:ticketprice.getDiscountprice()="+ticketprice.getDiscountprice());
							}
							ticketpricelist.add(ticketprice);
						}
					}

					// }
					// 生成票价结束
					if (oldscheduleplan.getIslinework()) {
						oldscheduleplan.setScheduleseatslist(null);
					} else {
						// 修改座位类型跟票价表一致
						boolean isseatprice = false;
						Map<String, Short> seattypeFixedreserveseatnums = new HashMap<String, Short>();
						for (Scheduleseats scheduleseats : scheduleseatslist) {
							isseatprice = false;
							String seattype = "0";
							for (Ticketprice ticketprice : ticketpricelist) {
								seattype = ticketprice.getSeattype();
								String[] seatnos = ticketprice.getSeatnos()
										.split(",");
								String curseatno = String.valueOf(scheduleseats
										.getSeatno());
								if (StringUtils.contains(seatnos, curseatno)) {
									scheduleseats.setSeattype(ticketprice
											.getSeattype());
									isseatprice = true;
									break;
								}
							}
							if (!isseatprice) {
								scheduleseats.setSeattype(seattype);
							}
							if ("3".equals(scheduleseats.getStatus())) {
								if (seattypeFixedreserveseatnums
										.containsKey(seattype)) {
									seattypeFixedreserveseatnums
											.put(seattype,
													(short) (seattypeFixedreserveseatnums
															.get(seattype) + 1));
								} else {
									seattypeFixedreserveseatnums.put(seattype,
											(short) 1);
								}
							}
						}
						// 根据scheduleseats更新scheduleplan和ticketprice的固定留位数
						for (Ticketprice ticketprice : ticketpricelist) {
							if (seattypeFixedreserveseatnums
									.containsKey(ticketprice.getSeattype())) {
								ticketprice
										.setFixedreserveseatnum(seattypeFixedreserveseatnums
												.get(ticketprice.getSeattype()));
							} else {
								ticketprice.setFixedreserveseatnum((short) 0);
							}
						}
						oldscheduleplan.setFixedreserveseatnum((short) 0);
						for (Short _fixnum : seattypeFixedreserveseatnums
								.values()) {
							oldscheduleplan
									.setFixedreserveseatnum((short) (oldscheduleplan
											.getFixedreserveseatnum() + _fixnum));
						}
					}
//					genScheduleplanServiceDao.getEntityManager().merge(
//							oldscheduleplan);
					
					
					//新增班次预售票申请参数打开的话，生成计划不可售，必须申请
					//Global global = CurrentUtil.getGlobal();
					/*String tt = parameterService.findParamValue("0036",oldscheduleplan.getOrgid());
					if("1".equals(tt))//1表示启用，班次不可售
					{
						oldscheduleplan.setIssellable(false);
						genScheduleplanServiceDao.getEntityManager().persist(
								oldscheduleplan);
						Global global=new Global();
						Organization org=(Organization) genScheduleplanServiceDao.get(Organization.class, orgid);
						global.setOrganization(org);
						ActionNode actionNode = Appvar.routes.get("SCHEDULEPRESALEPLUGIN");
						PluginFunctionUtil.DoPlugin(oldscheduleplan, global, actionNode);
						SchedulepresaleApply schedulepresaleApply = null;
						if(schedulePreSaleapplyDao.qryschedulepresalebyscheduleplanid(oldscheduleplan.getId())!=null)
						{
							schedulepresaleApply = schedulePreSaleapplyDao.qryschedulepresalebyscheduleplanid(oldscheduleplan.getId());
						}else
						{
							
							schedulepresaleApply = new SchedulepresaleApply();
						}
						schedulepresaleApply.setOrgid(CurrentUtil.getGlobal().getUserinfo().getOrgid());
						schedulepresaleApply.setScheduleplanid(oldscheduleplan.getId());
						schedulepresaleApply.setApplystatus("0");
						schedulepresaleApply.setAuditstatus("0");
						schedulepresaleApply.setAuditadvice("");
						schedulepresaleApply.setApplytime(null);
						schedulepresaleApply.setAudittime(null);
						schedulepresaleApply.setApplypersonid(-1L);
						schedulepresaleApply.setAuditpersonid(-1L);
						schedulepresaleApply.setCreateby(global.getUserinfo().getId());
						schedulepresaleApply.setCreatetime(new Date());
						schedulepresaleApply.setUpdatetime(new Date());
						schedulepresaleApply.setUpdateby(global.getUserinfo().getId());
						
						
						schedulePreSaleapplyDao.merge(schedulepresaleApply);
					}else
					{
						
					}*/
					genScheduleplanServiceDao.getEntityManager().persist(
							oldscheduleplan);
//					
//					genScheduleplanServiceDao.getEntityManager().merge(
//							oldscheduleplan);
					
					
					userTransaction.commit();
				} catch (Exception e) {
					userTransaction.rollback();
					play.Logger.error(e.getMessage(), e);
					result.setResult(MethodResult.FAILURE);
					result.setResultMsg(schedule.getCode() + "班次："
							+ departdatestr + "生成计划失败，原因:");
					saveScheduleplanlog(scheduleplanlog, result.getResultMsg(),
							schedule.getId());
					return result;
				}
			}// 已经生成计划end
		} catch (Exception e) {
			result.setResult(MethodResult.FAILURE);
			try {
				userTransaction.rollback();
			} catch (IllegalStateException e1) {
				System.out.println("回滚异常IllegalStateException");
				e1.printStackTrace();
			} catch (SecurityException e1) {
				System.out.println("回滚异常SecurityException");
				e1.printStackTrace();
			} catch (SystemException e1) {
				System.out.println("回滚异常SystemException");
				e1.printStackTrace();
			}
			System.out.println("总体异常");
			result.setResultMsg(e.getMessage());
			saveScheduleplanlog(scheduleplanlog, result.getResultMsg(),
					schedule.getId());
			play.Logger.error(e.getMessage(), e);
		}
		return result;
	}

	/*
	 * generateOvertimeplan方法：加班班次营运计划生成<br/> <br/>
	 * 
	 * @param scheduleplanlog
	 * 
	 * @return
	 * 
	 * @throws ServiceException
	 * 
	 * @see cn.nova.bus.price.service.GenScheduleplanService#generateOvertimeplan
	 * (cn.nova.bus.price.model.Scheduleplanlog)
	 * 
	 * @exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> generateOvertimeplan(
			Scheduleplanlog scheduleplanlog) throws ServiceException {
		System.out.println("begin generateOvertimeplan^^^^^^^^^^^^^^^^^^");
		scheduleplanloglist = new ArrayList<Object>();
		long scheduleid = scheduleplanlog.getTypeid();
		Schedule schedule = (Schedule) genScheduleplanServiceDao.get(
				Schedule.class, scheduleid);
		schedule.setIsactive(false);
		//将加班班次状态置为注销状态，以便下次继续使用
		genScheduleplanServiceDao.getEntityManager().merge(schedule);
		
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		createby = scheduleplanlog.getCreateby();
		scheduleplanlog.setUserid(createby);
		Date departdate = scheduleplanlog.getStartdate();
		try {
			departdate = sf.parse(sf.format(new Date()));
		} catch (ParseException e) {
			play.Logger.error(e.getMessage(), e);
		}
		String departdatestr = StringUtils.dateToStr(departdate);
		List<Cycleschemes> cys = genScheduleplanServiceDao.qryCycleschemes(
				scheduleid, departdate);
		scheduleplanlog.setStartdate(departdate);
		scheduleplanlog.setEnddate(departdate);
		if (cys == null || cys.size() == 0) {
			String s = schedule.getCode() + "班次：" + departdatestr + "没有排班计划！";
			saveScheduleplanlog(scheduleplanlog, s, schedule.getId());
		} 
//		else if (cys.size() > 1) {
//			String s = schedule.getCode() + "班次生成计划失败，原因是：" + departdatestr
//					+ "排班计划重复！";
//			saveScheduleplanlog(scheduleplanlog, s, schedule.getId());
//		} 
		else {//班次加班，有可能会有多个日期段的循环
			for (Cycleschemes cy : cys) {
//				Cycleschemes cy = cys.get(0);
				Date startdate = cy.getStartdate();
				if (DateUtils.compare(startdate, departdate) < 0) {
					startdate = departdate;
				}
				Date enddate = cy.getEnddate();
				int days = DateUtils.getIntervalDays(startdate, enddate);
				// 自动生成运营计划的天数
				String value = parameterService.findParamValue(ParamterConst.Param_0009,
						scheduleplanlog.getOrgid());
				int intervaldays = new Integer(value);
				// 如果加班班次的结束日期大于自动生成的日期，则结束日期取自动生成的日期
				if (days > intervaldays) {
					days = intervaldays - 1;
					enddate = DateUtils.add(startdate, days);
				}
				scheduleplanlog.setStartdate(startdate);
				scheduleplanlog.setEnddate(enddate);
				vehicletype = new Vehicletype();
				for (int i = 0; i <= days; i++) {
					departdate = DateUtils.add(startdate, i);
					departdatestr = StringUtils.dateToStr(departdate);
					MethodResult result = genScheduleplan(scheduleplanlog,
							schedule, departdate);
					if (result.getResult() == MethodResult.SUCCESS) {
						String s = schedule.getCode() + "班次：" + departdatestr
								+ "生成计划成功！";
						saveScheduleplanlog(scheduleplanlog, s, schedule.getId());
					}
				}
			}
		}
		System.out.println("end generateOvertimeplan^^^^^^^^^^^^^^^^^^");
		return ListUtil.listToMap(new Object[] { Scheduleplanlog.class },
				scheduleplanloglist, new Object[] { Scheduleplanlog.class });
	}

	/*
	 * autoGenerateScheduleplan自动生成营运计划方法：<br/> <br/>
	 * 
	 * @return
	 * 
	 * @see cn.nova.bus.price.service.GenScheduleplanService#autoGenerateScheduleplan ()
	 * 
	 * @exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public void autoGenerateScheduleplanold() {
		try {
			Scheduleplanlog scheduleplanlog = new Scheduleplanlog();
			Userinfo admin = genScheduleplanServiceDao.getAdmin();
			if (admin == null) {
				admin = (Userinfo) genScheduleplanServiceDao.get(
						Userinfo.class, 0);
			}
			scheduleplanlog.setCreateby(admin.getId());
			scheduleplanlog.setUserid(admin.getId());
			List<Organization> orglist = genScheduleplanServiceDao
					.qryOrganization();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			for (Organization org : orglist) {
				System.out.println("begin generate: " + org.getName()
						+ org.getCode() + org.getAddress());
				scheduleplanlog.setOrgid(org.getId());
				String value = parameterService.findParamValue(ParamterConst.Param_0009,
						scheduleplanlog.getOrgid());
				int days = Integer.valueOf(value);
				/*Date maxDepartdate = genScheduleplanServiceDao
						.getMaxDepartdate(org.getId());
				if (maxDepartdate == null) {
					maxDepartdate = sf.parse(sf.format(new Date()));
				}*/
				Date curDate = sf.parse(sf.format(new Date()));
				Date startdate = curDate;
				Date enddate = DateUtils.add(curDate, days-1);
				/*if (DateUtils.compare(maxDepartdate, curDate) < 0) {
					startdate = curDate;
					enddate = DateUtils.add(curDate, days - 1);
				} else {
					int interval = DateUtils.getIntervalDays(maxDepartdate,
							curDate) + 1;
					if (interval >= days) {
						continue;
					} else {
						startdate = DateUtils.add(maxDepartdate, 1);
						enddate = DateUtils.add(curDate, days - 1);
					}
				}*/
				scheduleplanlog.setIsautogen(true);
				scheduleplanlog.setStartdate(startdate);
				scheduleplanlog.setEnddate(enddate);
				scheduleplanlog.setIp(org.getServersaddressIp());
				scheduleplanlog.setOperationtype("C");
				scheduleplanlog.setType("0");
				scheduleplanlog.setTypeid(org.getId());
				System.out.println("begin date: " + startdate + ",endate:"
						+ enddate);
				generateScheduleplan(scheduleplanlog);
				System.out.println("end generate");
			}
		} catch (Exception ex) {
			System.out.println("自动制作班次营运计划失败:");
			play.Logger.error(ex.getMessage(), ex);
		}
	}

	@Override
	public List<Map<String, Object>> qrySchedules(long routeid)
			throws ServiceException {

		return ListUtil.listToMap(new Object[] { "id", "name", "starttime",
				"code" }, genScheduleplanServiceDao.qrySchedules(routeid),
				new Object[] { long.class, String.class, String.class,
						String.class });
	}

	@SuppressWarnings("unchecked")
	@Override
	public void autoGenerateScheduleplan() {
		try {
			Scheduleplanlog scheduleplanlog = new Scheduleplanlog();
			Userinfo admin = genScheduleplanServiceDao.getAdmin();
			if (admin == null) {
				admin = (Userinfo) genScheduleplanServiceDao.get(
						Userinfo.class, 0);
			}
			scheduleplanlog.setCreateby(admin.getId());
			scheduleplanlog.setUserid(admin.getId());
			List<Organization> orglist = genScheduleplanServiceDao
					.qryOrganization();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			for (Organization org : orglist) {
				System.out.println("begin generate: " + org.getName()
						+ org.getCode());
				scheduleplanlog.setOrgid(org.getId());
				String value = parameterService.findParamValue(ParamterConst.Param_0009,
						scheduleplanlog.getOrgid());
				int days = Integer.valueOf(value);
				Date curDate = sf.parse(sf.format(new Date()));
				Date startdate = new Date();
				Date enddate = new Date();
				startdate = DateUtils.add(curDate, 2);
				enddate = DateUtils.add(curDate, days - 1);
				scheduleplanlog.setStartdate(startdate);
				scheduleplanlog.setEnddate(enddate);
				scheduleplanlog.setIsautogen(true);
				scheduleplanlog.setIp(org.getServersaddressIp());
				scheduleplanlog.setOperationtype("C");
				scheduleplanlog.setType("0");
				scheduleplanlog.setTypeid(org.getId());
				System.out.println("begin date: " + startdate + ",endate:"
						+ enddate);
				generateScheduleplan(scheduleplanlog);
				System.out.println("end generate");
			}
		} catch (Exception ex) {
			System.out.println("自动制作班次营运计划失败:");
			play.Logger.error(ex.getMessage(), ex);
		}
	}
	
	/**
	 * 修改座位保留表
	 * @param oldscheduleplan
	 * @param seat
	 */
	public void updateSeatreserve(Scheduleplan oldscheduleplan,Scheduleseats seat,Scheduleseats seatreserveold) {
		Seatreserve seatreserve = seatreserveService
				.getSeatreserve(oldscheduleplan.getId(),
						oldscheduleplan.getDepartdate(), seatreserveold.getSeatno());
		if (seatreserve != null) {
			seatreserve.setSeatno(seat.getSeatno());
			seatreserve.setUpdateby(seat.getUpdateby());
			seatreserve.setUpdatetime(seat.getUpdatetime());
			genScheduleplanServiceDao.merge(seatreserve);
		}
	}

	public boolean isIsstandardprice() {
		return isstandardprice;
	}

	public void setIsstandardprice(boolean isstandardprice) {
		this.isstandardprice = isstandardprice;
	}
}
