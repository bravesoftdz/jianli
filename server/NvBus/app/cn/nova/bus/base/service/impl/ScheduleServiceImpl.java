package cn.nova.bus.base.service.impl;

/**
 * 
 * <p>
 * Title: 班次信息
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
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import play.db.jpa.JPA;
import util.SystemException;
import util.UserTransaction;
import cn.nova.bus.base.dao.ScheduleDao;
import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Routestop;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Schedulelongstop;
import cn.nova.bus.base.model.Schedulestop;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Ticketentrance;
import cn.nova.bus.base.model.Vehiclepark;
import cn.nova.bus.base.service.ScheduleService;
import cn.nova.bus.base.vo.SchedulestopVo;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.system.dao.DigitaldictionarydetailDao;
import cn.nova.bus.system.model.Digitaldictionary;
import cn.nova.bus.system.model.Digitaldictionarydetail;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;

public class ScheduleServiceImpl implements ScheduleService {

	private IDAO<Schedule> dao = new EntityManagerDaoSurport<Schedule>();

	private ScheduleDao scheduleDao = new ScheduleDao();
	//private UserTransaction usertransaction = new UserTransaction();

	//
	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList,String schedulestatus) {
		return ListUtil.listToMap(new Object[] { "id", "routeid", "orgid",
				"code", "worktype", "workways", "districttype", "type",
				"starttime", "runtime", "isproprietary", "isovertime",
				"issellreturnticket", "islinework", "isoriginator",
				"issaleafterreport", "iscanmixcheck", "planseatnum",
				"viastation", "printinfo", "remarks", "isaudited",
				"isauditpass", "isactive", "createtime", "createby",
				"updatetime", "updateby", "endtime", "spacinginterval",
				"synccode", "orgname", "routename", "username",
				"ticketentrance", "vehcilepark", "startstationid",
				"endstationid", "routeid", "entranceid", "parkid",
				"islongstop", "isfixseat", "isneedfinger", "driverfingernum",
				"endstation", "startstationprice","isautoreport" },
				scheduleDao.query(propertyFilterList,schedulestatus,""), new Object[] {
						Long.class, Long.class, Long.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, BigDecimal.class, boolean.class,
						boolean.class, boolean.class, boolean.class,
						boolean.class, boolean.class, boolean.class,
						short.class, String.class, String.class, String.class,
						boolean.class, boolean.class, boolean.class,
						Timestamp.class, Long.class, Timestamp.class,
						Long.class, String.class, short.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Boolean.class, Boolean.class,
						Boolean.class, Long.class, String.class,
						BigDecimal.class, Boolean.class });
	}

	@SuppressWarnings("unchecked")
	@Override
	public Schedule save(Schedule schedule) throws ServiceException {
		if (schedule.getStarttime().length() != 5) {
			String starttime = schedule.getStarttime();
			int pos = starttime.indexOf(":");
			if (pos > 0) {
				String hh = starttime.substring(0, pos);
				String mm = starttime.substring(pos + 1, starttime.length());
				if (hh.length() == 1) {
					hh = "0" + hh;
				}
				if (mm.length() == 1) {
					mm = "0" + mm;
				}
				schedule.setStarttime(hh + ":" + mm);
			}
		}
		if (schedule.getId() == 0) {
			if (scheduleDao.isExistSchedulehelpCode(schedule.getCode(),
					schedule.getOrgid())) {
				throw new ServiceException(schedule.getCode(), "0001");
			}
			schedule.setCreatetime(new Timestamp(System.currentTimeMillis()));
			schedule.setUpdatetime(new Timestamp(System.currentTimeMillis()));

			Route route = scheduleDao.getRoute(schedule.getRoute().getId());
			Ticketentrance ticketentrance = scheduleDao
					.getTicketentrance(schedule.getTicketentranceid());
			Vehiclepark vehiclepark = scheduleDao.getVehiclepark(schedule
					.getVehcileparkid());

			List<Schedulestop> listSchedulestop = new ArrayList<Schedulestop>();
			String viastation = "";
			List<Routestop> routestoplist = route.getRoutestops();
			for (Routestop routestop : routestoplist) {
				if (routestop.getIsactive()) {
					Schedulestop schedulestop = new Schedulestop();
					schedulestop.setCreateby(schedule.getCreateby());
					schedulestop.setCreatetime(new Date());
					int o = routestop.getOrderno();
					schedulestop.setOrderno(o);
					schedulestop.setIsactive(true);
					schedulestop.setIssellable(true);
					if (routestop.getStationid() == route.getStartstationid()) {
						schedulestop.setDeparttime(schedule.getStarttime());
						schedulestop.setRuntime(new BigDecimal(0.0));
						schedulestop.setTicketentrance(ticketentrance);
						schedulestop.setIsdepart(true);
						schedulestop.setVehiclepark(vehiclepark);
					} else if (routestop.getStationid() == route
							.getEndstationid()) {
						schedulestop.setIsdepart(false);
						schedulestop.setRuntime(schedule.getRuntime());
					} else {
						schedulestop.setIsdepart(false);
						Station st = (Station) scheduleDao.get(Station.class,
								routestop.getStationid());
						if (st != null) {
							viastation = viastation + "," + st.getName();
						}
					}
					schedulestop.setSchedule(schedule);
					schedulestop.setStationid(routestop.getStationid());
					schedulestop.setUpdateby(schedule.getCreateby());
					schedulestop.setUpdatetime(new Date());
					listSchedulestop.add(schedulestop);
				}
			}
			if (viastation.length() > 0) {
				viastation = viastation.substring(1);
			}
			schedule.setViastation(viastation);
			schedule.setSchedulestop(listSchedulestop);
			return dao.merge(schedule);
		} else {
			Schedule ss = (Schedule) scheduleDao.get(Schedule.class,
					schedule.getId());
			if (ss.getRoute().getId() != schedule.getRoute().getId()) {
				// 班次改变了所属线路
				List<Schedulestop> stlist = ss.getSchedulestop();
				for (Schedulestop st : stlist) {
					scheduleDao.delete(st);
				}
				Route route = (Route) scheduleDao.get(Route.class, schedule
						.getRoute().getId());
				Ticketentrance ticketentrance = scheduleDao
						.getTicketentrance(schedule.getTicketentranceid());
				Vehiclepark vehiclepark = scheduleDao.getVehiclepark(schedule
						.getVehcileparkid());
				for (Routestop st : route.getRoutestops()) {
					Schedulestop schedulestop = new Schedulestop();
					schedulestop.setCreateby(schedule.getUpdateby());
					schedulestop.setCreatetime(new Date());
					if (scheduleDao.isDepart(st.getStationid())) {
						schedulestop.setRuntime(new BigDecimal(0));
						schedulestop.setDeparttime(schedule.getStarttime());
						schedulestop.setIsdepart(true);
						schedulestop.setTicketentrance(ticketentrance);
						schedulestop.setVehiclepark(vehiclepark);
					} else {
						schedulestop.setRuntime(schedule.getRuntime());
						schedulestop.setIsdepart(false);
					}
					schedulestop.setIsactive(st.getIsactive());
					schedulestop.setIssellable(st.getIsactive());
					schedulestop.setOrderno(st.getOrderno());
					schedulestop.setStationid(st.getStationid());
					schedulestop.setSchedule(schedule);

					schedulestop.setUpdateby(schedule.getUpdateby());
					schedulestop.setUpdatetime(new Date());
					scheduleDao.merge(schedulestop);
				}
				schedule.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				return dao.merge(schedule);
			} else {
				schedule.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				Schedulestop schedulestop = scheduleDao
						.getScheduleStartstop(schedule);
				Ticketentrance ticketentrance = scheduleDao
						.getTicketentrance(schedule.getTicketentranceid());
				Vehiclepark vehiclepark = scheduleDao.getVehiclepark(schedule
						.getVehcileparkid());
				schedulestop.setDeparttime(schedule.getStarttime());
				schedulestop.setTicketentrance(ticketentrance);
				schedulestop.setVehiclepark(vehiclepark);
				if (schedule.getIsEditOtherSchedule()) { // 同时修改同线路的其他班次
					List<Schedule> schedulelist = scheduleDao
							.getScheuleByRoute(schedule.getRoute().getId());
					for (Schedule otherschedule : schedulelist) {
						if (otherschedule.getIsactive()) {
							otherschedule.setDistricttype(schedule
									.getDistricttype());
							otherschedule.setRuntime(schedule.getRuntime());
							otherschedule.setWorkways(schedule.getWorkways());
							otherschedule.setWorktype(schedule.getWorktype());
							otherschedule.setType(schedule.getType());
							otherschedule.setTicketentranceid(schedule
									.getTicketentranceid());
							otherschedule.setVehcileparkid(schedule
									.getVehcileparkid());
							otherschedule.setIscanmixcheck(schedule
									.getIscanmixcheck());
							otherschedule.setIsauditpass(schedule
									.getIsauditpass());
							otherschedule.setIsoriginator(schedule
									.getIsoriginator());
							otherschedule.setIssellreturnticket(schedule
									.getIssellreturnticket());
							otherschedule.setIssaleafterreport(schedule
									.getIssaleafterreport());
							otherschedule.setIsproprietary(schedule
									.getIsproprietary());
							otherschedule.setIsfixseat(schedule.isIsfixseat());
							if (schedule.getPrintinfo() != null) {
								otherschedule.setPrintinfo(schedule
										.getPrintinfo());
							}
							if (schedule.getRemarks() != null) {
								otherschedule.setRemarks(schedule.getRemarks());
							}
							Schedulestop sstop = scheduleDao
									.getScheduleStartstop(otherschedule);
							Ticketentrance entrance = scheduleDao
									.getTicketentrance(otherschedule
											.getTicketentranceid());
							Vehiclepark park = scheduleDao
									.getVehiclepark(otherschedule
											.getVehcileparkid());
							sstop.setTicketentrance(entrance);
							sstop.setVehiclepark(park);
							otherschedule.setUpdatetime(new Timestamp(System
									.currentTimeMillis()));
							dao.merge(otherschedule);
						}
					}
				}
				return dao.merge(schedule);
			}
		}

	}

	// 生成班次编码：起点站助记码+终点站站助记码+5位流水号
	/*
	 * @SuppressWarnings("unchecked") private String getScheduleCode(long
	 * routeid) { String code = ""; String sql =
	 * "select o.code||s1.helpcode||s2.helpcode as code  from Route r,Station s1,Station s2,Organization o "
	 * + " where r.startstationid=s1.id and r.endstationid=" +
	 * " s2.id and r.orgid=o.id and r.id=" + routeid; List<Object> result =
	 * dao.find(sql);
	 * 
	 * if (result != null && result.size() == 1) { code =
	 * result.get(0).toString(); sql =
	 * "select max(s.code) as code from Schedule s"; result = dao.find(sql); if
	 * (result.size() == 1 && result.get(0) != null) { String curcode =
	 * result.get(0).toString(); Long lcode = new
	 * Long(curcode.substring(curcode.length() - 5, curcode.length())); curcode
	 * = (++lcode).toString(); curcode = StringUtils.strPad(curcode, 5, "0");
	 * code = code + curcode; } else { code = code + "00001"; } return code; }
	 * 
	 * return ""; }
	 */
	@Override
	public boolean delSchedule(long id, long userid) throws ServiceException {
		if (scheduleDao.isExistSchedulecycle(id)) {
			// 该班次已经设置了班次循环，不允许删除！
			throw new ServiceException("0319");
		}
		Schedule schedule = dao.get(Schedule.class, id);
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String departdates = sf.format(new Date());
		Date departdate = new Date();
		try {
			departdate = sf.parse(departdates);
		} catch (ParseException e) {
			play.Logger.error(e.getMessage(), e);
		}
		if (scheduleDao.isExistScheduleplan(id, departdate)) {
			// 该班次未来还有营运计划，不允许删除！
			throw new ServiceException("0302");
		}
		schedule.setIsactive(false);
		schedule.setIsdelete(true);
		schedule.setUpdateby(userid);
		schedule.setUpdatetime(new Timestamp(System.currentTimeMillis()));
		dao.merge(schedule);
		return true;
	}

	// 班次停靠点部分
	@SuppressWarnings("unchecked")
	@Override
	public Schedulestop saveScheduleStop(Schedulestop schedulestop)
			throws ServiceException {
		if (schedulestop.getId() == 0) {
			if (scheduleDao.isExistSchedulestop(schedulestop.getSchedule(),
					schedulestop.getStationid(), true) != null) {
				throw new ServiceException("0009");
			}
		}
		Schedulestop result = null;
		// 判断有没有注销的
		Schedulestop schedulestop_old = scheduleDao.isExistSchedulestop(
				schedulestop.getSchedule(), schedulestop.getStationid(), false);

		if (schedulestop_old != null) {
			if (schedulestop.getIsdepart()) {
				schedulestop_old.setDeparttime(schedulestop.getDeparttime());
				schedulestop_old.setIsdepart(schedulestop.getIsdepart());
				schedulestop_old.setTicketentrance(schedulestop
						.getTicketentrance());
				schedulestop_old.setVehiclepark(schedulestop.getVehiclepark());
			} else {
				schedulestop_old.setTicketentrance(null);
				schedulestop_old.setVehiclepark(null);
				schedulestop_old.setDeparttime(null);
			}
			schedulestop_old.setIsactive(true);
			schedulestop_old.setIssellable(schedulestop.isIssellable());
			schedulestop_old.setRuntime(schedulestop.getRuntime());
			schedulestop_old.setUpdateby(schedulestop.getUpdateby());
			schedulestop_old.setUpdatetime(new Date());
			result = scheduleDao.getEntityManager().merge(schedulestop_old);
		} else {

			Schedule schedule = (Schedule) scheduleDao.get(Schedule.class,
					schedulestop.getSchedule().getId());
			// Route route = (Route) scheduleDao.get(Route.class,
			// schedule.getRoute().getId());
			List<Routestop> rlist = scheduleDao.getRoutestop(schedule.getId());
			List<Schedulestop> sslist = schedule.getSchedulestop();
			for (Schedulestop ss : sslist) {
				for (Routestop rst : rlist) {
					if (ss.getStationid() == rst.getStationid()) {
						ss.setOrderno(rst.getOrderno());
						ss.setUpdatetime(new Date());
						ss.setUpdateby(schedulestop.getCreateby());
						scheduleDao.merge(ss);
						scheduleDao.getEntityManager().flush();
						break;
					}
				}
			}
			Routestop rs = scheduleDao.getRoutestop(schedulestop.getSchedule()
					.getId(), schedulestop.getStationid());
			schedulestop.setOrderno(rs.getOrderno());
			schedulestop.setCreatetime(new Date());
			schedulestop.setUpdatetime(new Date());
			schedulestop.setUpdateby(schedulestop.getCreateby());
			if (!schedulestop.getIsdepart()) {
				schedulestop.setTicketentrance(null);
				schedulestop.setVehiclepark(null);
				schedulestop.setDeparttime(null);
			}
			result = scheduleDao.getEntityManager().merge(schedulestop);
		}
		Schedule schedule = (Schedule) scheduleDao.get(Schedule.class, result
				.getSchedule().getId());
		Route route = (Route) scheduleDao.get(Route.class, schedule.getRoute()
				.getId());
		if (route.getStartstationid() == result.getStationid()) {
			schedule.setStarttime(result.getDeparttime());
		}
		schedule.setViastation(getViastation(schedule));
		scheduleDao.getEntityManager().merge(schedule);
		return result;
	}

	@SuppressWarnings("unchecked")
	private String getViastation(Schedule schedule) {
		String viastation = "";
		long endstationid = schedule.getRoute().getEndstationid();
		List<Schedulestop> stlist = schedule.getSchedulestop();
		for (Schedulestop st : stlist) {
			if (st.getIsactive() && (!st.getIsdepart())
					&& st.getStationid() != endstationid) {
				Station s = (Station) scheduleDao.get(Station.class,
						st.getStationid());
				viastation = viastation + "," + s.getName();
			}
		}
		if (viastation.length() > 0) {
			viastation = viastation.substring(1);
		}
		return viastation;
	}

	@Override
	public List<Map<String, Object>> qryScheduleStop(long scheduleid)
			throws ServiceException {
		return ListUtil.listToMap(new Object[] { Schedulestop.class,
				"stationname", "ticketentrance", "vehiclepark" },
				scheduleDao.getSchedulestop(scheduleid), new Object[] {
						Schedulestop.class, String.class, String.class,
						String.class });
	}

	@Override
	public List<Map<String, Object>> qryScheduleStop(long scheduleid,
			long stationid) {
		List<Object> objects = new ArrayList<Object>();
		objects.add(scheduleDao.getSchedulestop(scheduleid, stationid));
		return ListUtil.listToMap(new Object[] { Schedulestop.class }, objects,
				new Object[] { Schedulestop.class });
	}

	@Override
	public List<Map<String, Object>> qryRouteStop(Schedule schedule) {
		return ListUtil.listToMap(new Object[] { "id", "name", "code" },
				scheduleDao.getRoutestop(schedule.getRoute()), new Object[] {
						Long.class, String.class, String.class });
	}

	@Override
	public boolean delScheduleStop(long id, long userid)
			throws ServiceException {
		Schedulestop schedulestop = scheduleDao.getEntityManager().find(
				Schedulestop.class, id);
		schedulestop.setIsactive(false);
		schedulestop.setUpdateby(userid);
		schedulestop.setUpdatetime(new Timestamp(System.currentTimeMillis()));
		scheduleDao.getEntityManager().merge(schedulestop);
		return true;
	}

	@Override
	public List<Map<String, Object>> createDistrictTree() {

		return null;
	}

	// 班次长停部分
	@Override
	public List<Map<String, Object>> qrySchedulelongstop(Schedule schedule)
			throws ServiceException {
		return ListUtil.listToMap(new Object[] { Schedulelongstop.class,
				"approvename", "createdname", "code", "routename" },
				scheduleDao.getSchedulelongstop(schedule), new Object[] {
						Schedulelongstop.class, String.class, String.class,
						String.class, String.class });
	}

	@SuppressWarnings("unchecked")
	@Override
	public Schedulelongstop saveScheduleLong(Schedulelongstop schedulelongstop)
			throws ServiceException {
		if (scheduleDao.checkLongDate(schedulelongstop)) {
			throw new ServiceException("0012");
		}
		/*
		List<Scheduleplan>  splist=scheduleDao.qryScheduleplan(schedulelongstop.getSchedule().getId(),
				schedulelongstop.getStartdate(), schedulelongstop
				.getEnddate());
		long updateby=schedulelongstop.getCreateby();
		
		for(Scheduleplan sp:splist){
			sp.setIssellable(true);
			List<Schedulestatus> sslist=sp.getSchedulestatuslist();
			for(Schedulestatus ss:sslist){
				ss.setStatus("1");//停班
				ss.setUpdatetime(new Date());
				ss.setUpdateby(updateby);
			}
			List<Ticketprice> tplist=sp.getTicketpricelist();
			for(Ticketprice tp:tplist){
				tp.setIssellable(false);
				tp.setUpdateby(updateby);
				tp.setUpdatetime(new Date());
			}
			sp.setUpdateby(updateby);
			sp.setUpdatetime(new Date());
			scheduleDao.merge(sp);
		}*/
		/*
		if (scheduleDao.isExistScheduleplan(schedulelongstop.getSchedule()
				.getId(), schedulelongstop.getStartdate(), schedulelongstop
				.getEnddate())) {
			// 该日期段已经有营运计划，请先删除！
			throw new ServiceException("0291");
		}*/
		if (schedulelongstop.getId() == 0) {
			schedulelongstop.setCreatetime(new Date());
			schedulelongstop.setUpdatetime(new Date());
			scheduleDao.save(schedulelongstop);
		} else {
			schedulelongstop.setUpdatetime(new Date());
			scheduleDao.merge(schedulelongstop);
		}
		return schedulelongstop;
	}

	@Override
	public Schedulelongstop saveScheduleLong(Schedulelongstop schedulelongstop,
			Digitaldictionarydetail digitaldictionarydetail)
			throws ServiceException {
		schedulelongstop = saveScheduleLong(schedulelongstop);

		if (digitaldictionarydetail.getId() < 0) {
			DigitaldictionarydetailDao ddao = new DigitaldictionarydetailDao();
			Digitaldictionary digitaldictionary = (Digitaldictionary) JPA
					.em()
					.createQuery(
							"select dy from Digitaldictionary dy where dy.tablename='schedulelongstop' and dy.columnname='reason'")
					.getSingleResult();
			Object[] datas = (Object[]) JPA
					.em()
					.createQuery(
							"select max(cast(code as integer))+1 as code,max(orderno)+1 as orderno from Digitaldictionarydetail where digitaldictionaryid="
									+ digitaldictionary.getId())
					.getSingleResult();
			digitaldictionarydetail.setCode(datas[0] + "");
			digitaldictionarydetail.setOrderno(Short.parseShort(datas[1] + ""));
			digitaldictionarydetail.setDigitaldictionary(digitaldictionary);
			digitaldictionarydetail.setUpdateby(schedulelongstop.getUpdateby());
			digitaldictionarydetail.setCreateby(schedulelongstop.getCreateby());
			digitaldictionarydetail.setCreatetime(new Date());
			digitaldictionarydetail.setUpdatetime(new Date());
			ddao.merge(digitaldictionarydetail);
		}

		return schedulelongstop;
	}

	@Override
	public boolean delSchedulelongstop(Schedulelongstop schedulelongstop)
			throws ServiceException {
		Schedulelongstop temp = scheduleDao.getEntityManager().find(
				Schedulelongstop.class, schedulelongstop.getId());
		scheduleDao.getEntityManager().remove(temp);
		return true;
	}

	@Override
	public Schedule getScheduleByCode(String code, Long orgid, Date departdate) {
		return scheduleDao.getScheduleByCode(code, orgid, departdate);
	}

	@Override
	public List<Map<String, Object>> qryScheduleStopTwo(long scheduleid)
			throws ServiceException {
		return ListUtil.listToMap(new Object[] { "id", "stationid",
				"issellable", "isdepart", "remark1", "remark2", "stationname",
				"ticketentrance", "vehiclepark" },
				scheduleDao.getSchedulestopTwo(scheduleid), new Object[] {
						Long.class, Long.class, boolean.class, boolean.class,
						String.class, String.class, String.class, String.class,
						String.class });
	}

	@Override
	public boolean updateScheduleAll(Schedule schedule, String scheduleids,
			String stationids, List<SchedulestopVo> stationlist)
			throws ServiceException {
		// 修改班次基本信息
		StringBuffer sb = new StringBuffer("update Schedule set updateby="
				+ schedule.getUpdateby());
		sb.append(",updatetime=sysdate,worktype=" + schedule.getWorktype());
		sb.append(",workways=" + schedule.getWorkways());
		sb.append(",districttype=" + schedule.getDistricttype());
		sb.append(",type=" + schedule.getType());
		sb.append(",runtime=" + schedule.getRuntime());
		sb.append(",printinfo='" + schedule.getPrintinfo() + "'");
		sb.append(",isoriginator=" + (schedule.getIsoriginator() ? 1 : 0));
		sb.append(",issaleafterreport="
				+ (schedule.getIssaleafterreport() ? 1 : 0));
		sb.append(",planseatnum=" + schedule.getPlanseatnum());
		sb.append(",endstation='" + schedule.getEndstation() + "'");
		sb.append(",startstationprice='" + schedule.getStartstationprice()
				+ "'");
		sb.append(",issellreturnticket="
				+ (schedule.getIssellreturnticket() ? 1 : 0));
		sb.append(" where id in " + scheduleids + "");

		int upnum = scheduleDao.getEntityManager()
				.createNativeQuery(sb.toString()).executeUpdate();

		// 修改班次站点停靠信息
		if (stationlist != null) {
			for (SchedulestopVo st : stationlist) {
				if (st.getRemark1() == null || "null".equals(st.getRemark1())) {
					st.setRemark1("");
				}
				if (st.getRemark2() == null || "null".equals(st.getRemark2())) {
					st.setRemark2("");
				}
				sb = new StringBuffer("update Schedulestop ");
				sb.append(" set updatetime=sysdate,issellable="
						+ (st.isIssellable() ? 1 : 0));
				sb.append(",remark1='" + st.getRemark1() + "'");
				sb.append(",remark2='" + st.getRemark2() + "'");
				if (st.isIsdepart()) {
					// 如果是发车站就修改检票口,乘车库
					sb.append(",ticketentranceid="
							+ schedule.getTicketentranceid());
					sb.append(",vehcileparkid=" + schedule.getVehcileparkid());
				} else {
					// 否则置为''
					sb.append(",ticketentranceid=''");
					sb.append(",vehcileparkid=''");
				}
				sb.append(" where scheduleid in " + scheduleids);
				sb.append(" and stationid =" + st.getStationid());

				upnum = scheduleDao.getEntityManager()
						.createNativeQuery(sb.toString()).executeUpdate();
			}
		}
		// ////修改班次站点检票口,乘车库
		// sb=new StringBuffer("update Schedulestop ");
		// sb.append("set ticketentranceid="+schedule.getTicketentranceid());
		// sb.append(",vehcileparkid="+schedule.getVehcileparkid());
		// sb.append(" where scheduleid in "+scheduleids);
		// sb.append(" and stationid in "+stationids);
		// upnum=scheduleDao.getEntityManager().createNativeQuery(sb.toString()).executeUpdate();
		//
		return true;

	}

	@Override
	public List<Map<String, Object>> findrouteid(long scheduleid) {
		// TODO Auto-generated method stub
		
		return ListUtil.listToMap(new Object[] { "routeid" },
				scheduleDao.findrouteid(scheduleid), new Object[] {Long.class });
	}

	@Override
	public Schedule AddSchedulesave(Schedule schedule, Date startdate,
			Date enddate,long mbscheduleid) throws ServiceException {
		if (schedule.getStarttime().length() != 5) {
			String starttime = schedule.getStarttime();
			int pos = starttime.indexOf(":");
			if (pos > 0) {
				String hh = starttime.substring(0, pos);
				String mm = starttime.substring(pos + 1, starttime.length());
				if (hh.length() == 1) {
					hh = "0" + hh;
				}
				if (mm.length() == 1) {
					mm = "0" + mm;
				}
				schedule.setStarttime(hh + ":" + mm);
			}
		}
		//校验，这个线路中的班次code是否存在班次记录， 如果存在，只修改；不再校验，每次都重新生成班次，防止在营运计划生成班次计划时，覆盖了原班次信息
//		Schedule oldschedule = scheduleDao.findScheduleByAddCode(schedule.getCode(),schedule.getOrgid(),schedule.getRoute().getId());
//		if(oldschedule!=null){
//			schedule.setId(oldschedule.getId());
//			schedule.setCreatetime(oldschedule.getCreatetime());
//			schedule.setCreateby(oldschedule.getCreateby());
//		}
		if (scheduleDao.isExistScheduleplanByCode(schedule.getCode(),
				schedule.getOrgid(),startdate,enddate)) {
			throw new ServiceException(schedule.getCode(), "0690"); //该班次号在此日期段内已经存在班次计划！
		}
		if (schedule.getId() == 0) {
			schedule.setCreatetime(new Timestamp(System.currentTimeMillis()));
			schedule.setUpdatetime(new Timestamp(System.currentTimeMillis()));

			Schedule mbschedule = (Schedule) scheduleDao.get(Schedule.class, mbscheduleid);
			List<Schedulestop> listSchedulestop = new ArrayList<Schedulestop>();
			String viastation = "";
			List<Schedulestop> mblit = mbschedule.getSchedulestop();
			//取模板的班次停靠点记录，完全复制
			for (Schedulestop ss : mblit) {
				Schedulestop nss=new Schedulestop();
				nss.setCreateby(schedule.getCreateby());
				nss.setCreatetime(new Date());
				if(ss.getIsdepart()){
					nss.setDeparttime(schedule.getStarttime());
				}else{
					nss.setDeparttime(ss.getDeparttime());
				}
				nss.setIsactive(ss.getIsactive());
				nss.setIsdepart(ss.getIsdepart());
				nss.setIssellable(ss.isIssellable());
				nss.setOrderno(ss.getOrderno());
				nss.setRuntime(ss.getRuntime());
				nss.setSchedule(schedule);
				if(ss.getStationid()>0){
					Station st = (Station) scheduleDao.get(Station.class,ss.getStationid());
					if (st != null) {
						viastation = viastation + "," + st.getName();
					}
				}
				nss.setStationid(ss.getStationid());
				nss.setTicketentrance(ss.getTicketentrance());
				nss.setUpdateby(schedule.getCreateby());
				nss.setUpdatetime(new Date());
				nss.setVehiclepark(ss.getVehiclepark());
				listSchedulestop.add(nss);
			}
			if (viastation.length() > 0) {
				viastation = viastation.substring(1);
			}
			schedule.setViastation(viastation);
			schedule.setSchedulestop(listSchedulestop);
			return dao.merge(schedule);
		} else {
			schedule.setUpdatetime(new Timestamp(System.currentTimeMillis()));
			Schedulestop schedulestop = scheduleDao
					.getScheduleStartstop(schedule);
			Ticketentrance ticketentrance = scheduleDao
					.getTicketentrance(schedule.getTicketentranceid());
			Vehiclepark vehiclepark = scheduleDao.getVehiclepark(schedule
					.getVehcileparkid());
			schedulestop.setDeparttime(schedule.getStarttime());
			schedulestop.setTicketentrance(ticketentrance);
			schedulestop.setVehiclepark(vehiclepark);
			if (schedule.getIsEditOtherSchedule()) { // 同时修改同线路的其他班次
				List<Schedule> schedulelist = scheduleDao
						.getScheuleByRoute(schedule.getRoute().getId());
				for (Schedule otherschedule : schedulelist) {
					if (otherschedule.getIsactive()) {
						otherschedule.setDistricttype(schedule
								.getDistricttype());
						otherschedule.setRuntime(schedule.getRuntime());
						otherschedule.setWorkways(schedule.getWorkways());
						otherschedule.setWorktype(schedule.getWorktype());
						otherschedule.setType(schedule.getType());
						otherschedule.setTicketentranceid(schedule
								.getTicketentranceid());
						otherschedule.setVehcileparkid(schedule
								.getVehcileparkid());
						otherschedule.setIscanmixcheck(schedule
								.getIscanmixcheck());
						otherschedule.setIsauditpass(schedule
								.getIsauditpass());
						otherschedule.setIsoriginator(schedule
								.getIsoriginator());
						otherschedule.setIssellreturnticket(schedule
								.getIssellreturnticket());
						otherschedule.setIssaleafterreport(schedule
								.getIssaleafterreport());
						otherschedule.setIsproprietary(schedule
								.getIsproprietary());
						otherschedule.setIsfixseat(schedule.isIsfixseat());
						if (schedule.getPrintinfo() != null) {
							otherschedule.setPrintinfo(schedule
									.getPrintinfo());
						}
						if (schedule.getRemarks() != null) {
							otherschedule.setRemarks(schedule.getRemarks());
						}
						Schedulestop sstop = scheduleDao
								.getScheduleStartstop(otherschedule);
						Ticketentrance entrance = scheduleDao
								.getTicketentrance(otherschedule
										.getTicketentranceid());
						Vehiclepark park = scheduleDao
								.getVehiclepark(otherschedule
										.getVehcileparkid());
						sstop.setTicketentrance(entrance);
						sstop.setVehiclepark(park);
						otherschedule.setUpdatetime(new Timestamp(System
								.currentTimeMillis()));
						dao.merge(otherschedule);
					}
				}
			}
			return dao.merge(schedule);
			
		}

	}

	@Override
	public List<Map<String, Object>> querySchedule(List<PropertyFilter> propertyFilterList, String schedulestatus) {
		return ListUtil.listToMap(new Object[] { "id", "routeid", "orgid",
				"code", "worktype", "workways", "districttype", "type",
				"starttime", "runtime", "isproprietary", "isovertime",
				"issellreturnticket", "islinework", "isoriginator",
				"issaleafterreport", "iscanmixcheck", "planseatnum",
				"viastation", "printinfo", "remarks", "isaudited",
				"isauditpass", "isactive", "createtime", "createby",
				"updatetime", "updateby", "endtime", "spacinginterval",
				"synccode", "orgname", "routename", "username",
				"ticketentrance", "vehcilepark", "startstationid",
				"endstationid", "routeid", "entranceid", "parkid",
				"islongstop", "isfixseat", "isneedfinger", "driverfingernum",
				"endstation", "startstationprice","isautoreport" },
				scheduleDao.querySchedule(propertyFilterList,schedulestatus), new Object[] {
						Long.class, Long.class, Long.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, BigDecimal.class, boolean.class,
						boolean.class, boolean.class, boolean.class,
						boolean.class, boolean.class, boolean.class,
						short.class, String.class, String.class, String.class,
						boolean.class, boolean.class, boolean.class,
						Timestamp.class, Long.class, Timestamp.class,
						Long.class, String.class, short.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Boolean.class, Boolean.class,
						Boolean.class, Long.class, String.class,
						BigDecimal.class, Boolean.class });
	}
	
	@Override
	public List<Map<String, Object>> selfcheckSchedule(
			Date departdate,long departstationid,long vehicleid,long reportorgid) {
		return ListUtil.listToMap(new Object[] {"id","name",
				"departdate","isdepart","islinework"},
				scheduleDao.selfcheckSchedule(departdate,departstationid,vehicleid,reportorgid), new Object[] {
						 Long.class,String.class, String.class,boolean.class,boolean.class});
		 
		 
	}
}
