/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.dispatch.service.impl<br/>
 * <b>文件名：</b>ScheduleplusServiceImpl.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2011-7-11-下午02:20:45<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.dispatch.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import play.db.jpa.JPA;
import util.CurrentUtil;
import cn.nova.bus.balance.model.Balancedeductapply;
import cn.nova.bus.balance.model.Balanceformulaapply;
import cn.nova.bus.base.dao.ScheduleDao;
import cn.nova.bus.base.model.Cycleschemes;
import cn.nova.bus.base.model.Cycleschemesdriver;
import cn.nova.bus.base.model.Cycleschemesschedule;
import cn.nova.bus.base.model.Cycleschemessteward;
import cn.nova.bus.base.model.Cycleschemesvehicle;
import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Routestop;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Schedulecycle;
import cn.nova.bus.base.model.Schedulestop;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Unit;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.base.model.Vehiclebrandmodel;
import cn.nova.bus.base.service.ScheduleService;
import cn.nova.bus.base.service.impl.ScheduleServiceImpl;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dispatch.dao.ScheduleplusDao;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.dispatch.service.ScheduleplusService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.log.service.OperationLogService;
import cn.nova.bus.log.service.impl.OperationLogServiceImpl;
import cn.nova.bus.price.model.Handholidayprice;
import cn.nova.bus.price.model.Handholidaypriceitem;
import cn.nova.bus.price.model.Handprice;
import cn.nova.bus.price.model.Handpriceitem;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleplanlog;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Schedulevehiclepeopleplan;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.price.model.Ticketpriceitem;
import cn.nova.bus.price.service.TicketpriceformulaService;
import cn.nova.bus.price.service.impl.GenScheduleplanServiceImpl;
import cn.nova.bus.price.service.impl.TicketpriceformulaServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>ScheduleplusServiceImpl<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */
public class ScheduleplusServiceImpl implements ScheduleplusService {

	
	private ScheduleplusDao scheduleplusDao = new ScheduleplusDao();

	
	private ScheduleService scheduleService = new ScheduleServiceImpl();

	
	private ScheduleDao scheduleDao = new ScheduleDao();

	
	private OperationLogService operationLogService = new OperationLogServiceImpl();

	
	private TicketpriceformulaService ticketpriceformulaService = new TicketpriceformulaServiceImpl();
	
	private ParameterService parameterService = new ParameterServiceImpl();
	/*
	 * qryScheduleplus方法：<br/> <br/>
	 * 
	 * @param propertyFilterList
	 * 
	 * @return
	 * 
	 * @see
	 * cn.nova.bus.dispatch.service.ScheduleplusService#qryScheduleplus(java
	 * .util.List)
	 * 
	 * @exception
	 */
	@Override
	public List<Map<String, Object>> qryScheduleplus(
			List<PropertyFilter> propertyFilterList) {
		//跟班次查询中一样调用班次管理中的查询
		return ListUtil.listToMap(
				new Object[] { "id", "routeid", "orgid", "code", "worktype",
						"workways", "districttype", "type", "starttime",
						"runtime", "isproprietary", "isovertime",
						"issellreturnticket", "islinework", "isoriginator",
						"issaleafterreport", "iscanmixcheck", "planseatnum",
						"viastation", "printinfo", "remarks", "isaudited",
						"isauditpass", "isactive", "createtime", "createby",
						"updatetime", "updateby", "endtime", "spacinginterval",
						"synccode", "orgname", "routename", "username",
						"ticketentrance", "vehcilepark", "startstationid",
						"endstationid", "routeid", "entranceid", "parkid",
						"islongstop","isfixseat","isneedfinger","driverfingernum","endstation","startstationprice","isautoreport" }, scheduleDao.query(propertyFilterList,"0","isovertime"),
				new Object[] { Long.class, Long.class, Long.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class, BigDecimal.class,
						boolean.class, boolean.class, boolean.class,
						boolean.class, boolean.class, boolean.class,
						boolean.class, short.class, String.class, String.class,
						String.class, boolean.class, boolean.class,
						boolean.class, Timestamp.class, Long.class,
						Timestamp.class, Long.class, String.class, short.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class, Long.class, Long.class,
						Long.class, Long.class, Long.class, Boolean.class, Boolean.class ,Boolean.class, long.class
						, String.class, String.class,boolean.class});
	}

	/*
	 * Scheduleplus方法：班次加班<br/> <br/>
	 * 
	 * @param schedule
	 * 
	 * @return
	 * 
	 * @throws ServiceException
	 * 
	 * @see
	 * cn.nova.bus.dispatch.service.ScheduleplusService#Scheduleplus(cn.nova
	 * .bus.base.model.Schedule)
	 * 
	 * @exception
	 */
	// 班次加班 - 加班
	@SuppressWarnings("unchecked")
	@Override
	public long Scheduleplus(long scheduleid, Date startdate, Date enddate,
			Schedule schedule, long unitid, long vehicletypeid, long vehicleid,
			long vehiclebrandmodelid, String ip) throws ServiceException {
		//如果存在该班次号对应的班次，且没有营运计划，则注销该班次号对应的班次
		if (!scheduleDao.isExistScheduleplanByCode(schedule.getCode(),
				schedule.getOrgid(),startdate,enddate)&&
				scheduleDao.isExistSchedulehelpCode(schedule.getCode(),
						schedule.getOrgid())) {
			scheduleDao.updateScheduleIsactive(schedule.getCode(),schedule.getOrgid());
		}
		// 删除过期的加班班次以及班次循环
		delValidateOverschedule(schedule.getOrgid(), schedule.getCreateby());
		schedule.setIsovertime(true);
		schedule.setIsactive(true);
		schedule.setIsaudited(true);
		schedule.setIslinework(false);
		schedule.setIsauditpass(true);
		schedule.setSpacinginterval((short) 0);
		schedule.setIsfixseat(schedule.isIsfixseat());
		schedule.setUpdateby(schedule.getCreateby());
		schedule.setUpdatetime(new Date());
//		schedule = scheduleService.save(schedule);
		schedule = scheduleService.AddSchedulesave(schedule,startdate,enddate,scheduleid);
		Route route = schedule.getRoute();
		// 保存循环组信息
		Cycleschemes cs = new Cycleschemes();
		cs.setCreateby(schedule.getCreateby());
		cs.setCreatetime(new Date());
		cs.setDrivernum((byte) 0);
		cs.setDriverperiod((byte) 0);
		cs.setDriverstep((byte) 0);
		cs.setEnddate(enddate);
		cs.setName(route.getName());
		cs.setOrgid(schedule.getOrgid());
		cs.setStartdate(startdate);
		cs.setStewardnum((byte) 0);
		cs.setStewardstep((byte) 0);
		cs.setUpdateby(schedule.getCreateby());
		cs.setUpdatetime(new Date());
		cs.setVehicleperiod((byte) 0);
		cs.setVehiclestep((byte) 0);
		cs = scheduleplusDao.getEntityManager().merge(cs);
		// 保存循环策略
		Schedulecycle sc = new Schedulecycle();
		sc.setCreateby(schedule.getCreateby());
		sc.setCreatetime(new Date());
		sc.setCyclescheme(cs);
		sc.setRule("1");
		sc.setType("0");// 0按天;
		sc.setUpdateby(schedule.getCreateby());
		sc.setUpdatetime(new Date());
		scheduleplusDao.getEntityManager().merge(sc);
		// 保存循环班次信息
		Cycleschemesschedule csc = new Cycleschemesschedule();
		csc.setCreateby(schedule.getCreateby());
		csc.setCreatetime(new Date());
		csc.setCyclescheme(cs);
		csc.setOrderno((byte) 1);
		csc.setScheduleid(schedule.getId());
		csc.setUpdateby(schedule.getCreateby());
		csc.setUpdatetime(new Date());
		scheduleplusDao.getEntityManager().merge(csc);
		// 保存循环车辆
		Cycleschemesvehicle cv = new Cycleschemesvehicle();
		cv.setCreateby(schedule.getCreateby());
		cv.setCreatetime(new Date());
		cv.setVehiclebrandmodelid(vehiclebrandmodelid);
		cv.setCyclescheme(cs);
		cv.setOrderno((byte) 1);
		if (unitid > 0) {
			Unit unit = new Unit();
			unit.setId(unitid);
			cv.setUnit(unit);
		}
		cv.setUpdateby(schedule.getCreateby());
		cv.setUpdatetime(new Date());
		Vehicle vehicle = null;
		if (vehicleid > 0) {
			vehicle = (Vehicle) scheduleplusDao.get(Vehicle.class, vehicleid);
			cv.setVehicle(vehicle);
			cv.setVehiclebrandmodelid(vehicle.getVehiclebrandmodelid());
		}
		cv.setVehicletypeid(vehicletypeid);
		scheduleplusDao.getEntityManager().merge(cv);

		// 获取模版班次票价信息
		List<Handprice> hps = scheduleplusDao.qryHandprice(scheduleid,
				vehicletypeid);
		if (hps == null || hps.size() == 0) {
			// 该模版班次不存在该车型的硬调票价！
			// throw new ServiceException("0269");
			// 若不存在改车型的票价，则重新生成公式票价以及应调票价
			ticketpriceformulaService.genPrice(schedule.getOrgid(), schedule
					.getRoute().getId(), schedule.getId(), vehicletypeid,
					schedule.getCreateby());
			scheduleplusDao.getEntityManager().flush();
			hps = scheduleplusDao.qryHandprice(scheduleid);
		}
		if (hps == null || hps.size() == 0) {
			throw new ServiceException("0269");
		}
		//不再覆盖相同线路的相同班次号的班次记录，
		//hps不为空时：如果存在同线路班次，则查看是否有硬调票价 如果有 删除
//		List<Handprice> oldhps = scheduleplusDao.qryHandprice(schedule.getId(),
//				vehicletypeid);
//		for (Handprice oldhd : oldhps) {
//			scheduleplusDao.getEntityManager().remove(oldhd);
//		}
//		scheduleplusDao.getEntityManager().flush();
		
		// 保存硬调票价
		StringBuilder hdidsanditemids = new StringBuilder();
		for (Handprice hp : hps) {
			Handprice entity = new Handprice();
			if (vehicle != null) {
				entity.setVehiclebrandmodelid(vehicle.getVehiclebrandmodelid());
			} else {
				entity.setVehiclebrandmodelid(vehiclebrandmodelid);
			}
			entity.setCreateby(schedule.getCreateby());
			entity.setCreatetime(new Date());
			entity.setDepartstationid(hp.getDepartstationid());
			entity.setFullprice(hp.getFullprice());
			entity.setHalfprice(hp.getHalfprice());
			entity.setDiscountprice(hp.getDiscountprice());
			entity.setRoundprice(hp.getRoundprice());
			entity.setConnectprice(hp.getConnectprice());
			entity.setReachstationid(hp.getReachstationid());
			entity.setScheduleid(schedule.getId());
			entity.setUpdateby(schedule.getCreateby());
			entity.setUpdatetime(new Date());
			entity.setSeattype(hp.getSeattype());
			entity.setSeats(hp.getSeats());
			entity.setStudentprice(hp.getStudentprice());
			entity.setVehicletypeid(vehicletypeid);
			entity.setLowerlimitprice(hp.getLowerlimitprice());
			entity.setToplimitprice(hp.getToplimitprice());
			entity.setMoreprice(hp.getMoreprice());
			List<Handpriceitem> curhpilist = new ArrayList<Handpriceitem>();
			List<Handpriceitem> hpilist = hp.getHandpriceitemlist();
			hdidsanditemids.append(";硬调票价id："+hp.getId());
			hdidsanditemids.append("--票价分项个数："+hpilist.size()+" ;");
			// 保存票价分项
			for (Handpriceitem hpi : hpilist) {
				Handpriceitem curhi = new Handpriceitem();
				curhi.setCreateby(schedule.getCreateby());
				curhi.setCreatetime(new Date());
				curhi.setHandprice(entity);
				curhi.setIsautoadjust(hpi.getIsautoadjust());
				curhi.setPrice(hpi.getPrice());
				curhi.setTicketpriceformulaitemid(hpi
						.getTicketpriceformulaitemid());
				curhi.setTickettype(hpi.getTickettype());
				curhi.setUpdateby(schedule.getCreateby());
				curhi.setUpdatetime(new Date());
				curhpilist.add(curhi);
			}
			entity.setHandpriceitemlist(curhpilist);
			scheduleplusDao.getEntityManager().merge(entity);
		}
		List<Handholidayprice> hhps = scheduleplusDao.qryHandHolidayprice(
				scheduleid, vehicletypeid, startdate);
		if (hhps != null && hhps.size() > 0) {
			//删除旧的节日票价信息，重新生成
//			List<Handholidayprice> oldhhps = scheduleplusDao.qryHandHolidayprice(
//					schedule.getId(), vehicletypeid, startdate);
//			for (Handholidayprice oldhhp : oldhhps) {
//				scheduleplusDao.getEntityManager().remove(oldhhp);
//			}
//			scheduleplusDao.getEntityManager().flush();
			for (Handholidayprice hhp : hhps) {
				Handholidayprice obj = new Handholidayprice();
				obj.setCreateby(schedule.getCreateby());
				obj.setCreatetime(new Date());
				obj.setDepartstationid(hhp.getDepartstationid());
				obj.setEnddate(hhp.getEnddate());
				obj.setFullprice(hhp.getFullprice());
				obj.setHalfprice(hhp.getHalfprice());
				obj.setDiscountprice(hhp.getDiscountprice());
				obj.setRoundprice(hhp.getRoundprice());
				obj.setConnectprice(hhp.getConnectprice());
				obj.setHolidayid(hhp.getHolidayid());
				obj.setLowerlimitprice(hhp.getLowerlimitprice());
				obj.setReachstationid(hhp.getReachstationid());
				obj.setScheduleid(schedule.getId());
				obj.setSeats(hhp.getSeats());
				obj.setSeattype(hhp.getSeattype());
				obj.setStartdate(hhp.getStartdate());
				obj.setStudentprice(hhp.getStudentprice());
				obj.setToplimitprice(hhp.getToplimitprice());
				obj.setMoreprice(hhp.getMoreprice());
				obj.setUpdateby(schedule.getCreateby());
				obj.setUpdatetime(new Date());
				obj.setVehiclebrandmodel(hhp.getVehiclebrandmodel());
				obj.setVehicletypeid(hhp.getVehicletypeid());
				List<Handholidaypriceitem> newhhis = new ArrayList<Handholidaypriceitem>();
				List<Handholidaypriceitem> hhpis = hhp
						.getHandholidaypriceitemlist();
				for (Handholidaypriceitem hi : hhpis) {
					Handholidaypriceitem nhi = new Handholidaypriceitem();
					nhi.setCode(hi.getCode());
					nhi.setCreateby(schedule.getCreateby());
					nhi.setCreatetime(new Date());
					nhi.setHandholidayprice(obj);
					nhi.setIsautoadjust(hi.getIsautoadjust());
					nhi.setName(hi.getName());
					nhi.setPrice(hi.getPrice());
					nhi.setTicketpriceformulaitemid(hi
							.getTicketpriceformulaitemid());
					nhi.setTickettype(hi.getTickettype());
					nhi.setUpdateby(schedule.getCreateby());
					nhi.setUpdatetime(new Date());
					newhhis.add(nhi);
				}
				obj.setHandholidaypriceitemlist(newhhis);
				scheduleplusDao.merge(obj);
			}

		}

		// 保存操作日志
		Operationlog operationLog = new Operationlog();
		operationLog.setIp(ip);
		String content = "加班日期：" + StringUtils.dateToStr(startdate) + "至"
				+ StringUtils.dateToStr(enddate);
		content = content + "，班次号：" + schedule.getCode() + "，营运线路："
				+ route.getName()+hdidsanditemids.toString();
		operationLog.setContent(content);
		operationLog.setModule("班次加班");
		operationLog.setOperatetime(new Date());
		operationLog.setOperation("加班");
		operationLog.setSessionid("无session");
		operationLog.setUserid(schedule.getCreateby());
		operationLogService.savelog(operationLog);
		return schedule.getId();
	}

	/*
	 * qryOtherSchedule方法：查询同线路的其他班次<br/> <br/>
	 * 
	 * @param routeid
	 * 
	 * @return
	 * 
	 * @see
	 * cn.nova.bus.dispatch.service.ScheduleplusService#qryOtherSchedule(long)
	 * 
	 * @exception
	 */
	@Override
	public List<Map<String, Object>> qryOtherSchedule(long routeid) {
		return ListUtil.listToMap(new Object[] { "worktype", "workways",
				"districttype", "type", "runtime", "isproprietary",
				"issellreturnticket", "isoriginator", "issaleafterreport",
				"iscanmixcheck", "printinfo", "ticketentranceid",
				"vehcileparkid" }, scheduleplusDao.qryOtherSchedule(routeid),
				new Object[] { String.class, String.class, String.class,
						String.class, BigDecimal.class, boolean.class,
						boolean.class, boolean.class, boolean.class,
						boolean.class, String.class, Long.class, Long.class });
	}

	@Override
	public List<Map<String, Object>> qryScheduleCycle(long scheduleid) {
		return ListUtil.listToMap(new Object[] { "unitid", "vehicletypeid",
				"unitname", "vehicletypename", "vehiclebrandmodelid" },
				scheduleplusDao.qryScheduleCycle(scheduleid), new Object[] {
						Long.class, Long.class, String.class, String.class,
						Long.class });
	}

	@Override
	public boolean updateSchedulestop(long scheduleid, String schedulestopids,
			long updateby) throws ServiceException {
		String[] stationidlist = schedulestopids.split(",");
		List<Schedulestop> sst = scheduleplusDao.qrySchedulestop(scheduleid);
		for (Schedulestop ss : sst) {
			if (StringUtils.contains(stationidlist, ss.getId() + "")) {
				ss.setIsactive(false);
				ss.setUpdateby(updateby);
				ss.setUpdatetime(new Date());
				scheduleplusDao.getEntityManager().merge(ss);
			} else if (!ss.getIsactive()) {
				ss.setIsactive(true);
				ss.setUpdateby(updateby);
				ss.setUpdatetime(new Date());
				scheduleplusDao.getEntityManager().merge(ss);
			}
		}
		return true;
	}

	@Override
	public List<Map<String, Object>> qrySchedulestation(long scheduleid)
			throws ServiceException {
		return ListUtil.listToMap(new Object[] { Schedulestop.class,
				"isselect", "stationname", "helpcode" },
				scheduleplusDao.getSchedulestop(scheduleid), new Object[] {
						Schedulestop.class, boolean.class, String.class,
						String.class });
	}

	@SuppressWarnings("unchecked")
	private void delValidateOverschedule(long orgid, long userid) {
		Date departdate = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			departdate = sf.parse(sf.format(new Date()));
			List<Cycleschemes> csslist = scheduleplusDao.qrySchedulecycle(
					orgid, departdate);
			Iterator<Cycleschemes> its = csslist.iterator();
			while (its.hasNext()) {
				Cycleschemes it = its.next();
				List<Cycleschemesschedule> csschedulelist = scheduleplusDao
						.qryCycleschemesschedule(it);
				for (Cycleschemesschedule cs : csschedulelist) {
					Schedule schedule = (Schedule) scheduleplusDao.get(
							Schedule.class, cs.getScheduleid());
					schedule.setIsactive(false);
					schedule.setUpdateby(userid);
					schedule.setUpdatetime(new Date());
					scheduleplusDao.getEntityManager().merge(schedule);//物理删除加班班次
					scheduleplusDao.getEntityManager().remove(cs);
				}
				List<Cycleschemesdriver> csdriverlist = scheduleplusDao
						.qryCycleschemesdriver(it);
				for (Cycleschemesdriver cs : csdriverlist) {
					scheduleplusDao.getEntityManager().remove(cs);
				}
				List<Cycleschemessteward> csstewardist = scheduleplusDao
						.qryCycleschemessteward(it);
				for (Cycleschemessteward cs : csstewardist) {
					scheduleplusDao.getEntityManager().remove(cs);
				}
				List<Cycleschemesvehicle> csvehicleist = scheduleplusDao
						.qryCycleschemesvehicle(it);
				for (Cycleschemesvehicle cs : csvehicleist) {
					scheduleplusDao.getEntityManager().remove(cs);
				}

				Set<Schedulecycle> sclist = it.getSchedulecycles();
				for (Schedulecycle sc : sclist) {
					scheduleplusDao.getEntityManager().remove(sc);
				}
				scheduleplusDao.getEntityManager().remove(it);
				scheduleplusDao.getEntityManager().flush();
			}

		} catch (ParseException e) {
			play.Logger.error(e.getMessage(), e);
		}
	}
	// 综合调度-按照班次计划 班次加班
	@SuppressWarnings("unchecked")
	@Override
	public long Scheduleplus(long scheduleplanid, Date startdate, Date enddate,
			Schedule schedule, long vehiclebrandmodelid,long unitid, long vehicleid,
			String ip, long balanceformulaid,int delayminute,int status,boolean issellstopstation,
			 long balancedeductitemid,boolean isreport,short planseatnums
			) throws ServiceException {
         
		Scheduleplan sp = (Scheduleplan) scheduleplusDao.get(
				Scheduleplan.class, scheduleplanid);
		if (scheduleDao.isExistScheduleplanByCode(schedule.getCode(),
				sp.getOrgid(),startdate,enddate)) {
			throw new ServiceException(schedule.getCode(), "0690"); //该班次号在此日期段内已经存在班次计划！
		}
//		if (scheduleDao.isExistSchedulehelpCode(schedule.getCode(),
//				sp.getOrgid())) {
//			throw new ServiceException(schedule.getCode(), "0001");
//		}
		if(schedule.getStarttime().length()!=5){
			//你输入的发车时间格式不对，请重新输入！
			throw new ServiceException(schedule.getCode(), "0420");
		}
		Schedule oldsch = (Schedule) scheduleplusDao.get(Schedule.class,
				sp.getScheduleid());
		Vehiclebrandmodel vb = (Vehiclebrandmodel) scheduleplusDao.get(
				Vehiclebrandmodel.class, vehiclebrandmodelid);
//		short seats = vb.getRationseatnum();// 根据厂牌取座位数
		short seats = planseatnums;
		Vehicle vehicle = null;
		Unit unit=null;
		// 保存班次信息 end
		if (vehicleid > 0) {
			vehicle = (Vehicle) scheduleplusDao.get(Vehicle.class, vehicleid);
			seats = vehicle.getSeatnum();
			unit = (Unit) scheduleplusDao.get(Unit.class, vehicle.getUnitid());
		}
		else if(unitid>0){
			unit = (Unit) scheduleplusDao.get(Unit.class, unitid);
		}
		// 保存班次信息 begin
		Schedule newsch = new Schedule();
		//校验，这个线路中的班次code是否存在班次记录， 如果存在，只修改
//		Schedule samerouteschedule = scheduleDao.findScheduleByAddCode(schedule.getCode(),oldsch.getRoute().getOrgid(),oldsch.getRoute().getId());
//		if(samerouteschedule!=null){
//			newsch.setId(samerouteschedule.getId());
//			newsch.setSynccode(samerouteschedule.getSynccode());
//		}
		newsch.setCode(schedule.getCode());
		newsch.setCreateby(schedule.getCreateby());
		newsch.setCreatetime(new Date());
		newsch.setDistricttype(sp.getDistricttype());
		newsch.setEndtime(sp.getEndtime());
		newsch.setIsactive(false);
		newsch.setIsaudited(true);
		newsch.setIsauditpass(true);
		newsch.setIsfixseat(schedule.isIsfixseat());
		newsch.setIscanmixcheck(sp.getIscanmixcheck());
		newsch.setIslinework(sp.getIslinework());
		newsch.setIsoriginator(sp.getIsoriginator());
		newsch.setIsovertime(true);
		newsch.setIsproprietary(sp.getIsproprietary());
		newsch.setIssaleafterreport(sp.getIssaleafterreport());
		newsch.setIssellreturnticket(sp.getIssellreturnticket());
		newsch.setOrgid(sp.getOrgid());
		newsch.setPlanseatnum(seats);// 根据厂牌取座位数
		newsch.setPrintinfo(oldsch.getPrintinfo());
		newsch.setRemarks(oldsch.getRemarks());
		newsch.setRoute(oldsch.getRoute());
		newsch.setRuntime(sp.getRuntime());
		newsch.setStarttime(schedule.getStarttime());
		newsch.setSpacinginterval(sp.getSpacinginterval());
		newsch.setTicketentranceid(oldsch.getTicketentranceid());
		newsch.setType(sp.getScheduletype());
		newsch.setUpdateby(schedule.getCreateby());
		newsch.setUpdatetime(new Date());
		newsch.setWorktype(schedule.getWorktype());
		newsch.setWorkways(sp.getWorkways());
		newsch.setViastation(oldsch.getViastation());
		List<Schedulestop> sslit = null;
		List<Schedulestop> newsslit =new ArrayList<Schedulestop>();
		sslit = oldsch.getSchedulestop();
		for (Schedulestop ss : sslit) {
			Schedulestop nss=new Schedulestop();
			nss.setCreateby(newsch.getCreateby());
			nss.setCreatetime(new Date());
			nss.setDeparttime(ss.getDeparttime());
			nss.setIsactive(ss.getIsactive());
			nss.setIsdepart(ss.getIsdepart());
			nss.setIssellable(ss.isIssellable());
			nss.setOrderno(ss.getOrderno());
			nss.setRuntime(ss.getRuntime());
			nss.setSchedule(newsch);
			nss.setStationid(ss.getStationid());
			nss.setTicketentrance(ss.getTicketentrance());
			nss.setUpdateby(newsch.getCreateby());
			nss.setUpdatetime(new Date());
			nss.setVehiclepark(ss.getVehiclepark());
			newsslit.add(nss);
		}
		newsch.setSchedulestop(newsslit);
		schedule = (Schedule) scheduleplusDao.merge(newsch);
		Route route =(Route) scheduleplusDao.get(Route.class, schedule.getRoute().getId());
		List<Routestop> rslist = scheduleplusDao.getroutestoplist(route.getId());
		//新增厂牌型号记录获取，用来准备数据查询handprice记录
		Vehiclebrandmodel vbm = (Vehiclebrandmodel) scheduleplusDao.get(Vehiclebrandmodel.class, vehiclebrandmodelid);
		List<Schedulestatus> oldsslist=scheduleplusDao.qrySchedulestatus(sp.getId());
		int days = DateUtils.getIntervalDays(startdate, enddate);
		Date departdate = new Date();
		boolean flag = true;
		for (int i = 0; i <= days; i++) {
			departdate = DateUtils.add(startdate, i);
			Scheduleplan spl = copyScheduleplan(sp, schedule, departdate,
					schedule.getCreateby(), seats);
			List<Schedulestatus> sslist = copySchedulestatus(oldsslist, spl, schedule.getStarttime(),
					delayminute,status);
			play.Logger.info("新生成的Schedulestatus记录的条数："+sslist.size());
			List<Scheduleseats> stlist = copyScheduleseats(
					sp.getScheduleseatslist(), spl, vb, sp
							.getSchedulevehiclepeopleplanlist().get(0)
							.getPlanvehiclebrandmodelid());
			//加班并报班，修改班次状态为报班
			if (isreport) {
				int oldsslen = oldsslist.size() ;
				if (null != vehicle) {
					for (int j = 0; j < oldsslen ; j++) {
						sslist.get(j).setIsreported(true);
						sslist.get(j).setIsbegincheck(true);
					}
				}
			}
			List<Ticketprice> tplist = new ArrayList<Ticketprice>();
			
			List<Schedulevehiclepeopleplan> svplist = copySchedulevehiclepeopleplan(
					sp.getSchedulevehiclepeopleplanlist(), spl, vb,unit, vehicle);
			List<Ticketprice> ticketpricelist = copyTicketprice(
					sp.getTicketpricelist(), spl, vb, sp
							.getSchedulevehiclepeopleplanlist().get(0));
			List<Handprice> hplist = copyHandprice(oldsch.getId(),vbm);
			if(issellstopstation){
				for(Ticketprice tp:ticketpricelist){
					if(tp.getReachstationid()!=route.getEndstationid()){
						tp.setIssellable(false);
					}
					
				}
			}
			//新增硬调票价
			if(flag)
			{	
//				if(hplist!=null){
//					//hps不为空时：如果存在同线路班次，则查看是否有硬调票价 如果有 删除
//					List<Handprice> oldhps = scheduleplusDao.qryHandprice(schedule.getId(),
//							vbm.getVehicletypeid());
//					for (Handprice oldhd : oldhps) {
//						scheduleplusDao.getEntityManager().remove(oldhd);
//					}
//					scheduleplusDao.getEntityManager().flush();
//				}
				for(Handprice hp:hplist)
				{
					flag = false;
					Handprice handprice = new Handprice();
					handprice.setVehiclebrandmodel(hp.getVehiclebrandmodel());
					handprice.setVehiclebrandmodelid(hp.getVehiclebrandmodelid());
					handprice.setVehicletype(hp.getVehicletype());
					handprice.setVehicletypeid(hp.getVehicletypeid());
					handprice.setVehicletypeids(hp.getVehicletypeids());
					handprice.setCreateby(hp.getCreateby());
					handprice.setCreatetime(new Date());
					handprice.setDepartstation(hp.getDepartstation());
					handprice.setDepartstationid(hp.getDepartstationid());
					handprice.setDistance(hp.getDistance());
					handprice.setFullprice(hp.getFullprice());
					handprice.setHalfprice(hp.getHalfprice());
					handprice.setHandpriceitemlist(hp.getHandpriceitemlist());
					handprice.setLowerlimitprice(hp.getLowerlimitprice());
					handprice.setMoreprice(hp.getMoreprice());
					handprice.setOpertype(hp.getOpertype());
					handprice.setReachstation(hp.getReachstation());
					handprice.setReachstationid(hp.getReachstationid());
					handprice.setScheduleid(schedule.getId());
					handprice.setSeats(hp.getSeats());
					handprice.setSeattype(hp.getSeattype());
					handprice.setStudentprice(hp.getStudentprice());
					handprice.setToplimitprice(hp.getToplimitprice());
					handprice.setDiscountprice(hp.getDiscountprice());
					handprice.setRoundprice(hp.getRoundprice());
					handprice.setConnectprice(hp.getConnectprice());
					handprice.setUpdateby(hp.getUpdateby());
					handprice.setUpdatetime(new Date());
					Handprice hprice = scheduleplusDao.getEntityManager().merge(handprice);
					//硬调票价组成项
					for(Handpriceitem hpi : hp.getHandpriceitemlist())
					{
						Handpriceitem hpitem = new Handpriceitem();
						hpitem.setCode(hpi.getCode());
						hpitem.setCreateby(hpi.getCreateby());
						hpitem.setCreatetime(new Date());
						hpitem.setHandprice(hprice);
						hpitem.setHandpriceid(hprice.getId());
						hpitem.setIsautoadjust(hpi.getIsautoadjust());
						hpitem.setName(hpi.getName());
						hpitem.setOpertype(hpi.getOpertype());
						hpitem.setPrice(hpi.getPrice());
						hpitem.setTicketpriceformulaitemid(hpi.getTicketpriceformulaitemid());
						hpitem.setTickettype(hpi.getTickettype());
						hpitem.setUpdateby(hpi.getUpdateby());
						hpitem.setUpdatetime(new Date());
						scheduleplusDao.getEntityManager().merge(hpitem);
					}
				}
			}
			spl.setSchedulestatuslist(sslist);
			spl.setScheduleseatslist(stlist);
			spl.setSchedulevehiclepeopleplanlist(svplist);
			if (!isreport) {
				spl.setTicketpricelist(ticketpricelist);
			}
			spl = scheduleplusDao.getEntityManager().merge(spl);
			if (i == 0) {
				scheduleplanid = spl.getId();
			}

			//增加加班并报班处理，
			if (isreport) {
				
				//查询出当前报到车型的
				if(vehicle!=null){
					if(vehicle.getVehiclebrandmodelid()==vb.getId()&&vehicle.getVehicletypeid()==vb.getVehicletypeid()){
						tplist = copyTicketprice(
								sp.getTicketpricelist(), spl, vb, sp
										.getSchedulevehiclepeopleplanlist().get(0));
					}else{
						List<Handprice> hplist1 = scheduleplusDao.qryHandprice1(sp.getScheduleid(),vehicle.getVehicletypeid(),vehicle.getVehiclebrandmodelid());
						for(Handprice hpc : hplist1)
							{
								ticketpricelist.clear();
								Ticketprice tp = addTicketprice(hpc,spl,newsslit,rslist);
								tplist.add(tp);
								
							}
					}
					
				}
				if(tplist!=null&&tplist.size()>0){
					spl.setTicketpricelist(tplist);
				}else{
					throw new ServiceException("0268");//该模版班次不存在该车型的硬调票价！
				}
				
				int oldsslen = oldsslist.size() ;
				play.Logger.info("加班并报班---开始生产报到记录，条数为："+oldsslen+"；班次计划id："+scheduleplanid);
				if (null != vehicle) {
					for (int j = 0; j < oldsslen; j++) {
						//生成报到信息
						Vehiclereport vehiclereport = new Vehiclereport();
						vehiclereport.setCreateby(sslist.get(j).getCreateby());//
						vehiclereport.setCreatetime(sslist.get(j).getCreatetime());//
						vehiclereport.setDepartdate(departdate);//发车日期
						vehiclereport.setDriver1(null);//驾驭员id
						vehiclereport.setDriver2(null);
						vehiclereport.setDriver3(null);
						vehiclereport.setDriver4(null);
						vehiclereport.setIsactive(true);//是否激活
						vehiclereport.setOrgid(schedule.getOrgid());//班次所属车站id
						vehiclereport.setReportorgid(schedule.getOrgid());//报到车站/配客点id
						vehiclereport.setReporttime(sslist.get(j).getCreatetime());//报到时间
						vehiclereport.setReportway("0");//报到方式：0自动报到、1手动报动 取数据字典
						vehiclereport.setScheduleid(schedule.getId());//班次id
						vehiclereport.setScheduleplanid(spl.getId());//班次运行计划ID,要取生成的班次计划的ID
						vehiclereport.setUnitid(unitid);
						vehiclereport.setUpdateby(sslist.get(j).getUpdateby());//
						vehiclereport.setUpdatetime(sslist.get(j).getUpdatetime());//
						vehiclereport.setVehicleid(vehicleid);//报到车牌id
						scheduleplusDao.merge(vehiclereport);
						
					}
				}
			}
			
		}
		// 保存扣费应用
		if (balanceformulaid > 0) {
			Balanceformulaapply ba = new Balanceformulaapply();
			Userinfo auditor = (Userinfo) scheduleplusDao.get(Userinfo.class,
					schedule.getCreateby());
			ba.setAuditor(auditor);
			// 按班次扣费
			ba.setBalancededucttargetid(4);
			ba.setCreateby(auditor.getId());
			ba.setCreatetime(new Date());
			ba.setEnddate(enddate);
			ba.setBalanceformulaid(balanceformulaid);
			ba.setIsactive(true);
			ba.setIsaudited(true);
			ba.setIsauditpass(true);
			ba.setSchedule(schedule);
			ba.setStartdate(startdate);
			ba.setUpdateby(auditor.getId());
			ba.setUpdatetime(new Date());
			scheduleplusDao.merge(ba);
		}
		//保存固定扣费应用
		if (balancedeductitemid > 0) {
			Balancedeductapply ba = new Balancedeductapply();
			Userinfo auditor = (Userinfo) scheduleplusDao.get(Userinfo.class,
					schedule.getCreateby());
			ba.setAuditor(auditor);
			// 按班次扣费
			ba.setBalancededucttargetid(4);
			ba.setCreateby(auditor.getId());
			ba.setCreatetime(new Date());
			ba.setEnddate(enddate);
			ba.setBalancedeductitemid(balancedeductitemid);
			ba.setIsactive(true);
			ba.setIsaudited(true);
			ba.setIsauditpass(true);
			ba.setSchedule(schedule);
			ba.setStartdate(startdate);
			ba.setUpdateby(auditor.getId());
			ba.setUpdatetime(new Date());
			scheduleplusDao.merge(ba);
		}

		// 保存操作日志
		Operationlog operationLog = new Operationlog();
		operationLog.setIp(ip);
		String content = "加班日期：" + StringUtils.dateToStr(startdate) + "至"
				+ StringUtils.dateToStr(enddate);
		content = content + "，班次号：" + schedule.getCode() + "，营运线路："
				+ oldsch.getRoute().getName();
		operationLog.setContent(content);
		operationLog.setModule("班次加班");
		operationLog.setOperatetime(new Date());
		operationLog.setOperation("加班");
		operationLog.setSessionid("无session");
		operationLog.setUserid(schedule.getCreateby());
		operationLogService.savelog(operationLog);
		return scheduleplanid;
	}

	private Scheduleplan copyScheduleplan(Scheduleplan oldsp,
			Schedule schedule, Date departdate, long createby, short seats) {
		Scheduleplan sp = new Scheduleplan();
		sp.setAutocancelreserveseatnum((short) 0);
		sp.setCarrychildnum((short) 0);
		sp.setCreateby(createby);
		sp.setCreatetime(new Date());
		sp.setDepartdate(departdate);
		sp.setDistance(oldsp.getDistance());
		sp.setDistricttype(oldsp.getDistricttype());
		sp.setEndstationid(oldsp.getEndstationid());
		sp.setEndtime(oldsp.getEndtime());
		sp.setFixedreserveseatnum((short) 0);
		sp.setHighdistance(oldsp.getHighdistance());
		sp.setIscanmixcheck(oldsp.getIscanmixcheck());
		sp.setIslinework(oldsp.getIslinework());
		sp.setIsoriginator(oldsp.getIsoriginator());
		sp.setIsovertime(true);
		sp.setIsproprietary(oldsp.getIsproprietary());
		sp.setIssaleafterreport(oldsp.getIssaleafterreport());
		sp.setIssellable(true);
		sp.setIssellreturnticket(oldsp.getIssellreturnticket());
		sp.setOrgid(oldsp.getOrgid());
		sp.setRemarks(oldsp.getRemarks());
		sp.setRuntime(oldsp.getRuntime());
		sp.setScheduleid(schedule.getId());
		sp.setScheduletype(oldsp.getScheduletype());
		sp.setSeatnum(seats);
		sp.setSoldeatnum((short) 0);
		sp.setSpacinginterval(oldsp.getSpacinginterval());
		sp.setStartstationid(oldsp.getStartstationid());
		sp.setStarttime(schedule.getStarttime());
		sp.setUnautocancelreserveseatnum((short) 0);
		sp.setUpdateby(createby);
		sp.setUpdatetime(new Date());
		sp.setWorktype(schedule.getWorktype());
		sp.setWorkways(oldsp.getWorkways());
		return sp;
	}

	private List<Schedulestatus> copySchedulestatus(
			List<Schedulestatus> oldslist, Scheduleplan sp, String departtime,int delayminute,int status) {
		List<Schedulestatus> sslist = new ArrayList<Schedulestatus>();
		String temp=departtime;
		for (Schedulestatus ss : oldslist) {
			Schedulestatus sc = new Schedulestatus();
			sc.setBuspark(ss.getBuspark());
			sc.setCreateby(sp.getCreateby());
			sc.setCreatetime(new Date());
			sc.setDepartdate(sp.getDepartdate());
			sc.setDepartstationid(ss.getDepartstationid());
			sc.setDeparttime(departtime);
			departtime=DateUtils.minuteToStr(DateUtils.toMinute(departtime)+delayminute);
			if(departtime.length()!=5){
				departtime=temp;
			}
			sc.setIsbegincheck(false);
			sc.setIsdeparted(false);
			sc.setIsemptyvehicle(false);
			sc.setIsreported(false);
			sc.setOrgid(ss.getOrgid());
			sc.setScheduleid(sp.getScheduleid());
			sc.setScheduleplan(sp);
			sc.setStatus(Integer.toString(status));
			sc.setTicketentrance(ss.getTicketentrance());
			sc.setUpdateby(sp.getCreateby());
			sc.setUpdatetime(new Date());
			sslist.add(sc);
		}

		return sslist;
	}

	private List<Scheduleseats> copyScheduleseats(List<Scheduleseats> oldslist,
			Scheduleplan sp, Vehiclebrandmodel vb, long oldvbid) {
		List<Scheduleseats> sslist = new ArrayList<Scheduleseats>();
		if (vb.getId() == oldvbid) {
			//若班次座位数与复制班次座位数不一致，则以新班次座位数为准！
			if (sp.getSeatnum() == oldslist.size()) {
				for (Scheduleseats ss : oldslist) {
					Scheduleseats st = new Scheduleseats();
					st.setCreateby(sp.getCreateby());
					st.setCreatetime(new Date());
					st.setDepartdate(sp.getDepartdate());
					st.setOrgid(sp.getOrgid());
					st.setScheduleid(sp.getScheduleid());
					st.setScheduleplan(sp);
					st.setSeatno(ss.getSeatno());
					st.setSeattype(ss.getSeattype());
					st.setStatus("0");// 空位
					st.setTickettype(null);
					st.setUpdateby(sp.getCreateby());
					st.setUpdatetime(new Date());
					sslist.add(st);
				}
			} else {
				for (int i = 1; i <= sp.getSeatnum(); i++) {
					Scheduleseats st = new Scheduleseats();
					st.setCreateby(sp.getCreateby());
					st.setCreatetime(new Date());
					st.setDepartdate(sp.getDepartdate());
					st.setOrgid(sp.getOrgid());
					st.setScheduleid(sp.getScheduleid());
					st.setScheduleplan(sp);
					st.setSeatno((short) i);
					st.setSeattype(oldslist.get(0).getSeattype());
					st.setStatus("0");// 空位
					st.setTickettype(null);
					st.setUpdateby(sp.getCreateby());
					st.setUpdatetime(new Date());
					sslist.add(st);
				}
			}
		} else {
			short seats = vb.getRationseatnum();
			for (short seatno = 1; seatno <= seats; seatno++) {
				Scheduleseats st = new Scheduleseats();
				st.setCreateby(sp.getCreateby());
				st.setCreatetime(new Date());
				st.setDepartdate(sp.getDepartdate());
				st.setOrgid(sp.getOrgid());
				st.setScheduleid(sp.getScheduleid());
				st.setScheduleplan(sp);
				st.setSeatno(seatno);
				st.setSeattype(oldslist.get(0).getSeattype());
				st.setStatus("0");// 空位
				st.setTickettype(null);
				st.setUpdateby(sp.getCreateby());
				st.setUpdatetime(new Date());
				sslist.add(st);
			}

		}

		return sslist;
	}

	@SuppressWarnings("unchecked")
	private List<Schedulevehiclepeopleplan> copySchedulevehiclepeopleplan(
			List<Schedulevehiclepeopleplan> oldslist, Scheduleplan sp,
			Vehiclebrandmodel vb,Unit unit, Vehicle vehicle) {

		List<Schedulevehiclepeopleplan> svplist = new ArrayList<Schedulevehiclepeopleplan>();

		Schedulevehiclepeopleplan sv = new Schedulevehiclepeopleplan();
		sv.setCreateby(sp.getCreateby());
		sv.setCreatetime(new Date());
		sv.setDepartdate(sp.getDepartdate());
		sv.setOrderno((short) 0);
		sv.setOrgid(sp.getOrgid());
		sv.setPlandriver1(oldslist.get(0).getPlandriver1());
		sv.setPlandriver2(oldslist.get(0).getPlandriver2());
		sv.setPlandriver3(oldslist.get(0).getPlandriver3());
		sv.setPlandriver4(oldslist.get(0).getPlandriver4());
		sv.setPlansteward1(oldslist.get(0).getPlansteward1());
		sv.setPlansteward2(oldslist.get(0).getPlansteward2());

		if (vehicle != null) {
			sv.setPlanvehicle(vehicle);
			sv.setPlanvehiclebrandmodelid(vehicle.getVehiclebrandmodelid());
			Unit u = (Unit) scheduleplusDao
					.get(Unit.class, vehicle.getUnitid());
			sv.setPlanunit(u);
			sv.setPlanvehicletypeid(vehicle.getVehicletypeid());

		}
		else {
			if(unit!=null){
				sv.setPlanunit(unit);
			}else{
				sv.setPlanunit(oldslist.get(0).getPlanunit());
			}
			sv.setPlanvehiclebrandmodelid(vb.getId());
			sv.setPlanvehicletypeid(vb.getVehicletypeid());				

		}

		sv.setScheduleid(sp.getScheduleid());
		sv.setScheduleplan(sp);
		sv.setUpdateby(sp.getCreateby());
		sv.setUpdatetime(new Date());
		svplist.add(sv);

		return svplist;
	}
	private List<Handprice> copyHandprice(long scheduleid,Vehiclebrandmodel vehiclebrandmodel)
	{
		List<Handprice> hplist = new ArrayList<Handprice>();
		
		hplist = scheduleplusDao.qryHandprice(scheduleid,vehiclebrandmodel);
		
		return hplist;
	}
	private List<Ticketprice> copyTicketprice(List<Ticketprice> oldslist,
			Scheduleplan sp, Vehiclebrandmodel vb, Schedulevehiclepeopleplan svp) {
		List<Ticketprice> tplist = new ArrayList<Ticketprice>();

		if (vb.getId() == svp.getPlanvehiclebrandmodelid()) {
			for (Ticketprice tp : oldslist) {
				Ticketprice ts = new Ticketprice();
				ts.setAutocancelreserveseatnum((short) 0);
				ts.setBalancedistance(tp.getBalancedistance());
				ts.setCreateby(sp.getCreateby());
				ts.setCreatetime(new Date());
				ts.setDepartdate(sp.getDepartdate());
				ts.setDepartstationid(tp.getDepartstationid());
				ts.setDistance(tp.getDistance());
				ts.setFixedreserveseatnum((short) 0);
				ts.setFueladditionfee(tp.getFueladditionfee());
				ts.setFullprice(tp.getFullprice());
				ts.setHalfprice(tp.getHalfprice());
				ts.setIssellable(tp.getIssellable());
				ts.setLowerlimitprice(tp.getLowerlimitprice());
				ts.setOrgid(tp.getOrgid());
				ts.setReachstationid(tp.getReachstationid());
				ts.setRuntime(tp.getRuntime());
				ts.setScheduleid(sp.getScheduleid());
				ts.setScheduleplan(sp);
				ts.setSeatnos(tp.getSeatnos());
				ts.setSeatnum(sp.getSeatnum());
				ts.setSeattype(tp.getSeattype());
				ts.setSoldeatnum((short) 0);
				ts.setStationservicefee(tp.getStationservicefee());
				ts.setStudentprice(tp.getStudentprice());
				ts.setToplimitprice(tp.getToplimitprice());
				ts.setUnautocancelreserveseatnum((short) 0);
				ts.setUpdateby(sp.getCreateby());
				ts.setUpdatetime(new Date());
				ts.setDiscountprice(tp.getDiscountprice());
				ts.setRoundprice(tp.getRoundprice());
				ts.setConnectprice(tp.getConnectprice());
				ts.setMoreprice(tp.getMoreprice());
				List<Ticketpriceitem> ticketpriceitemlist = new ArrayList<Ticketpriceitem>();
				for (Ticketpriceitem tpi : tp.getTicketpriceitemlist()) {
					Ticketpriceitem ti = new Ticketpriceitem();				
					ti.setCreateby(sp.getCreateby());
					ti.setCreatetime(new Date());
					ti.setDepartdate(sp.getDepartdate());
					ti.setIsautoadjust(tpi.isIsautoadjust());
					ti.setPrice(tpi.getPrice());
					ti.setTicketpriceformulaitemid(tpi
							.getTicketpriceformulaitemid());
					ti.setScheduleid(sp.getScheduleid());
					ti.setTicketprice(ts);
					ti.setUpdateby(sp.getCreateby());
					ti.setUpdatetime(new Date());
					ti.setTickettype(tpi.getTickettype());
					ticketpriceitemlist.add(ti);
				}
				ts.setTicketpriceitemlist(ticketpriceitemlist);
				tplist.add(ts);
			}
		} else {

			List<Ticketprice> newtplist = getdistinctPrice(oldslist);
			for (Ticketprice tp : newtplist) {
				Ticketprice ts = new Ticketprice();
				ts.setAutocancelreserveseatnum((short) 0);
				ts.setBalancedistance(tp.getBalancedistance());
				ts.setCreateby(sp.getCreateby());
				ts.setCreatetime(new Date());
				ts.setDepartdate(sp.getDepartdate());
				ts.setDepartstationid(tp.getDepartstationid());
				ts.setDistance(tp.getDistance());
				ts.setFixedreserveseatnum((short) 0);
				ts.setFueladditionfee(tp.getFueladditionfee());
				ts.setFullprice(tp.getFullprice());
				ts.setHalfprice(tp.getHalfprice());
				ts.setIssellable(tp.getIssellable());
				ts.setLowerlimitprice(tp.getLowerlimitprice());
				ts.setOrgid(tp.getOrgid());
				ts.setReachstationid(tp.getReachstationid());
				ts.setRuntime(tp.getRuntime());
				ts.setScheduleid(sp.getScheduleid());
				ts.setScheduleplan(sp);
				ts.setSeatnos(tp.getSeatnos());
				ts.setSeatnum(sp.getSeatnum());
				ts.setSeattype(tp.getSeattype());
				ts.setSoldeatnum((short) 0);
				ts.setStationservicefee(tp.getStationservicefee());
				ts.setStudentprice(tp.getStudentprice());
				ts.setToplimitprice(tp.getToplimitprice());
				ts.setUnautocancelreserveseatnum((short) 0);
				ts.setUpdateby(sp.getCreateby());
				ts.setUpdatetime(new Date());
				ts.setMoreprice(tp.getMoreprice());
				ts.setDiscountprice(tp.getDiscountprice());
				ts.setRoundprice(tp.getRoundprice());
				ts.setConnectprice(tp.getConnectprice());
				List<Ticketpriceitem> ticketpriceitemlist = new ArrayList<Ticketpriceitem>();
				for (Ticketpriceitem tpi : tp.getTicketpriceitemlist()) {
					Ticketpriceitem ti = new Ticketpriceitem();
					ti.setCreateby(sp.getCreateby());
					ti.setCreatetime(new Date());
					ti.setDepartdate(sp.getDepartdate());
					ti.setIsautoadjust(tpi.isIsautoadjust());
					ti.setPrice(tpi.getPrice());
					ti.setTicketpriceformulaitemid(tpi
							.getTicketpriceformulaitemid());
					ti.setScheduleid(sp.getScheduleid());
					ti.setTicketprice(ts);
					ti.setTickettype(tpi.getTickettype());
					ti.setUpdateby(sp.getCreateby());
					ti.setUpdatetime(new Date());

					ticketpriceitemlist.add(ti);
				}
				ts.setTicketpriceitemlist(ticketpriceitemlist);
				tplist.add(ts);
			}

		}
		return tplist;
	}

	private List<Ticketprice> getdistinctPrice(List<Ticketprice> oldlist) {
		List<Ticketprice> newlist = new ArrayList<Ticketprice>();
		Ticketprice tp1 = new Ticketprice();
		tp1 = oldlist.get(0);
		newlist.add(oldlist.get(0));
		for (Ticketprice tp : oldlist) {
			if (tp.getDepartstationid() != tp1.getDepartstationid()
					|| tp.getReachstationid() != tp1.getReachstationid()) {
				newlist.add(tp);
			}

		}
		return newlist.size() > 0 ? newlist : oldlist;
	}

	@SuppressWarnings("unchecked")
	@Override
	public String genSchCode(long routeid,Date startdate,Date enddate) {
		String schcode="";
		Route route = (Route) scheduleplusDao.get(Route.class, routeid);
		Station station = (Station) scheduleplusDao.get(Station.class, route.getEndstationid());
		String jianpin = station.getJianpin().substring(0, 2);
		Integer schcount = 1;
		try {
			String maxcode = scheduleDao.queryScheduleOvertimeCount(routeid, route.getOrgid(), startdate, enddate);
			schcount = Integer.parseInt(maxcode.substring(maxcode.length() - 3, maxcode.length()))+1;
		} catch (Exception e) {
			schcount = 1;
		}

		if (schcount < 10) {
			schcode = "J" + jianpin + "00" + schcount;
		} else if (schcount < 99) {
			schcode = "J" + jianpin + "0" + schcount;
		} else {
			schcode = "J" + jianpin + schcount;
		}
//		for(int i=1;i<500;i++){
//			if(i<10){
//				schcode="J"+jianpin+"00"+i;	
//			}else{
//				schcode="J"+jianpin+"0"+i;
//			}			
//			if (!scheduleDao.isExistSchedulehelpCode(schcode,route.getOrgid())){
//				break;
//			}
//		}
		return schcode;
	}

	@Override
	public long ScheduleRouteplus(long routeid,Date startdate,
			Date enddate, Schedule schedule, long vehiclebrandmodelid, String ip, short planseatnums)
			throws ServiceException {
		//JPA.em().getTransaction().begin();
		Route route =(Route) scheduleplusDao.get(Route.class,routeid);
		Vehiclebrandmodel vb=(Vehiclebrandmodel) scheduleplusDao.get(Vehiclebrandmodel.class, vehiclebrandmodelid);		
		schedule.setRoute(route);
		schedule.setOrgid(route.getOrgid());
		schedule.setIsovertime(true);
		schedule.setIsactive(true);
		schedule.setIsaudited(true);
		schedule.setIslinework(false);
		schedule.setIsauditpass(true);
		schedule.setCreateby(schedule.getCreateby());
		schedule.setCreatetime(new Date());
		schedule.setSpacinginterval((short) 0);
		//schedule.setIsfixseat(true);
		schedule.setDistricttype(route.getDistricttype());
		schedule.setIscanmixcheck(true);
		schedule.setIsfixseat(schedule.isIsfixseat());
		schedule.setIsneedfinger(false);
		schedule.setIsproprietary(false);
		schedule.setRuntime(new BigDecimal(0));
		schedule.setIssaleafterreport(false);
		schedule.setIssellreturnticket(false);
		schedule.setPlanseatnum(planseatnums);
		schedule.setType("0");
		schedule.setWorkways("0");
		schedule.setRuntime(scheduleplusDao.qryRuntime(route.getId()));
		schedule.setUpdateby(schedule.getCreateby());
		schedule.setUpdatetime(new Date());
		schedule= scheduleService.save(schedule);
//		schedule= scheduleService.AddSchedulesave(schedule,startdate,enddate);
		
		// 删除过期的加班班次以及班次循环
		delValidateOverschedule(schedule.getOrgid(), schedule.getCreateby());
		//Route route = schedule.getRoute();
		// 保存循环组信息
		Cycleschemes cs = new Cycleschemes();
		cs.setCreateby(schedule.getCreateby());
		cs.setCreatetime(new Date());
		cs.setDrivernum((byte) 0);
		cs.setDriverperiod((byte) 0);
		cs.setDriverstep((byte) 0);
		cs.setEnddate(enddate);
		cs.setName(route.getName());
		cs.setOrgid(schedule.getOrgid());
		cs.setStartdate(startdate);
		cs.setStewardnum((byte) 0);
		cs.setStewardstep((byte) 0);
		cs.setUpdateby(schedule.getCreateby());
		cs.setUpdatetime(new Date());
		cs.setVehicleperiod((byte) 0);
		cs.setVehiclestep((byte) 0);
		cs = scheduleplusDao.getEntityManager().merge(cs);
		// 保存循环策略
		Schedulecycle sc = new Schedulecycle();
		sc.setCreateby(schedule.getCreateby());
		sc.setCreatetime(new Date());
		sc.setCyclescheme(cs);
		sc.setRule("1");
		sc.setType("0");// 0按天;
		sc.setUpdateby(schedule.getCreateby());
		sc.setUpdatetime(new Date());
		scheduleplusDao.getEntityManager().merge(sc);
		// 保存循环班次信息
		Cycleschemesschedule csc = new Cycleschemesschedule();
		csc.setCreateby(schedule.getCreateby());
		csc.setCreatetime(new Date());
		csc.setCyclescheme(cs);
		csc.setOrderno((byte) 1);
		csc.setScheduleid(schedule.getId());
		csc.setUpdateby(schedule.getCreateby());
		csc.setUpdatetime(new Date());
		scheduleplusDao.getEntityManager().merge(csc);
		// 保存循环车辆
		Cycleschemesvehicle cv = new Cycleschemesvehicle();
		cv.setCreateby(schedule.getCreateby());
		cv.setCreatetime(new Date());
		cv.setVehiclebrandmodelid(vehiclebrandmodelid);
		cv.setCyclescheme(cs);
		cv.setOrderno((byte) 1);
		cv.setUpdateby(schedule.getCreateby());
		cv.setUpdatetime(new Date());
	
		cv.setVehicletypeid(vb.getVehicletypeid());
		scheduleplusDao.getEntityManager().merge(cv);
		JPA.em().getTransaction().commit();
		String scheduleids="("+schedule.getId()+")";
		Scheduleplanlog scheduleplanlog = new Scheduleplanlog();
		scheduleplanlog.setCreateby(schedule.getCreateby());
		scheduleplanlog.setOrgid(schedule.getOrgid());
		scheduleplanlog.setStartdate(startdate);
		scheduleplanlog.setEnddate(enddate);
		scheduleplanlog.setIsautogen(true);
		scheduleplanlog.setIp(ip);
		scheduleplanlog.setScheduleids(scheduleids);
		scheduleplanlog.setOperationtype("C");
		scheduleplanlog.setType("2");
		scheduleplanlog.setTypeid(schedule.getId());
		scheduleplanlog.setUserid(schedule.getCreateby());
		GenScheduleplanServiceImpl gs=new GenScheduleplanServiceImpl();
		gs.generateScheduleplan(scheduleplanlog);
		JPA.em().getTransaction().begin();
		schedule.setIsactive(false);//生成计划后，注销
		JPA.em().getTransaction().commit();
		return schedule.getId();
	}
	
	// 取硬调票价保存
	private Ticketprice addTicketprice(Handprice handprice,
			Scheduleplan scheduleplan,List<Schedulestop> schedulestoplist,List<Routestop> rslist) {
		Global global = CurrentUtil.getGlobal();
		Ticketprice ticketprice = new Ticketprice();
		ticketprice.setCreateby(global.getUserinfo().getId());
		ticketprice.setCreatetime(new Date());
		ticketprice.setDepartdate(scheduleplan.getDepartdate());
		ticketprice.setDepartstationid(handprice.getDepartstationid());
		ticketprice.setFullprice(handprice.getFullprice());
		Date departdate = scheduleplan.getDepartdate();
		Schedule schedule = (Schedule) scheduleplusDao.get(
				Schedule.class, scheduleplan.getScheduleid());
		ticketprice.setHalfprice(scheduleplusDao.actPrice(
				handprice.getFullprice(), handprice.getHalfprice(), departdate,
				"B", schedule));
		ticketprice.setStudentprice(scheduleplusDao.actPrice(
				handprice.getFullprice(), handprice.getStudentprice(),
				departdate, "X", schedule));
		if ("1".equals(parameterService.findParamValue("5001", null))) {
			ticketprice.setMoreprice(handprice.getMoreprice());
		} else {
			ticketprice.setMoreprice(new BigDecimal(0));
		}
		
		
		ticketprice.setIssellable(true);
		ticketprice.setOrgid(global.getOrganization().getId());
		ticketprice.setReachstationid(handprice.getReachstationid());
		
		//取出来班次座位图
		List<Scheduleseats> sslist = scheduleplan.getScheduleseatslist();
		
		if (scheduleplan.getIslinework()) {
			ticketprice.setSeatnum((short)999);
		} else {//非流水班  对ticketprice表中seatnum进行设置，要考虑多种座位类型的问题
			if("0".equals(handprice.getSeats())||"全部".equals(handprice.getSeats()))
			{
				ticketprice.setSeatnos("0");
				ticketprice.setSeatnum((short)scheduleplan.getSeatnum());
			}
			else
			{
				ticketprice.setSeatnum((short)handprice.getSeats().split(",").length);
				int index = Integer.parseInt(handprice.getSeats().split(",")[0]);
				for(int i=index;i<handprice.getSeats().split(",").length+index;i++)
				{
						Scheduleseats sseat = sslist.get(i-1);
						sseat.setSeattype(handprice.getSeattype());
				}
			}
		}

		for (Schedulestop schedulestop : schedulestoplist) {
			if (schedulestop.getStationid() == handprice.getReachstationid()) {
				ticketprice.setRuntime(schedulestop.getRuntime());
				
				ticketprice.setIssellable(schedulestop.isIssellable());
			}

		}
		ticketprice.setScheduleid(scheduleplan.getScheduleid());
		ticketprice.setScheduleplan(scheduleplan);
		ticketprice.setSeatnos(handprice.getSeats());
		ticketprice.setSeattype(handprice.getSeattype());
		ticketprice.setSoldeatnum((short)0);
		ticketprice.setUpdateby(global.getUserinfo().getId());
		ticketprice.setUpdatetime(new Date());
		int departdistance = 0;
		int reacherdistance = 0;

		for (Routestop routestop : rslist) {
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
		ticketprice.setStationservicefee(new BigDecimal(0));
		ticketprice.setFueladditionfee(new BigDecimal(0));
		// 生成票价分项
		List<Ticketpriceitem> ticketpriceitems = new ArrayList<Ticketpriceitem>();
		List<Handpriceitem> hpilist = handprice
				.getHandpriceitemlist();
		for (Handpriceitem hpi : hpilist) {
			if (hpi.getTickettype().equals("Q")) {
				// 只要生成全票的票价分项
				Ticketpriceitem ticketpriceitem = new Ticketpriceitem();
				ticketpriceitem.setCreateby(global.getUserinfo().getId());
				ticketpriceitem.setCreatetime(new Date());
				ticketpriceitem.setDepartdate(ticketprice.getDepartdate());
				ticketpriceitem.setIsautoadjust(hpi
						.getIsautoadjust());
				ticketpriceitem.setPrice(hpi.getPrice());
				ticketpriceitem.setScheduleid(handprice
						.getScheduleid());
				ticketpriceitem.setTicketprice(ticketprice);
				ticketpriceitem
				.setTicketpriceformulaitemid(hpi
						.getTicketpriceformulaitemid());
				ticketpriceitem.setTickettype(hpi
						.getTickettype());
				ticketpriceitem.setUpdateby(global.getUserinfo().getId());
				ticketpriceitem.setUpdatetime(new Date());
				ticketpriceitems.add(ticketpriceitem);
				play.Logger.info("补全数据开始：生成票价分项成功，ticketpriceId："+ticketprice.getId());
			}
		}
		ticketprice.setTicketpriceitemlist(ticketpriceitems);
		return ticketprice;
	}
}
