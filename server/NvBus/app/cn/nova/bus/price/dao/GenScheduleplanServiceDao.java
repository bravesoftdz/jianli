package cn.nova.bus.price.dao;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.LockModeType;
import javax.persistence.Query;

import cn.nova.bus.base.model.Cycleschemes;
import cn.nova.bus.base.model.Cycleschemesdriver;
import cn.nova.bus.base.model.Cycleschemesschedule;
import cn.nova.bus.base.model.Cycleschemessteward;
import cn.nova.bus.base.model.Cycleschemesvehicle;
import cn.nova.bus.base.model.Routestop;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Schedulecycle;
import cn.nova.bus.base.model.Schedulelongstop;
import cn.nova.bus.base.model.Scheduleseatreserve;
import cn.nova.bus.base.model.Schedulestop;
import cn.nova.bus.base.model.Ticketdiscount;
import cn.nova.bus.base.model.Vehiclebrandmodel;
import cn.nova.bus.base.model.Vehiclespace;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.price.model.Fuelfeegradeapply;
import cn.nova.bus.price.model.Fuelfeegradedetail;
import cn.nova.bus.price.model.Handholidayprice;
import cn.nova.bus.price.model.Handprice;
import cn.nova.bus.price.model.Routeprice;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleplanlog;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Schedulevehiclepeopleplan;
import cn.nova.bus.price.model.Standardprice;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.price.model.Ticketpriceformulaitem;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class GenScheduleplanServiceDao extends EntityManagerDaoSurport {

	// 获取制作的班次信息
	@SuppressWarnings("unchecked")
	public List<Schedule> qrySchedule(String scheduleids) {
		StringBuilder sql = new StringBuilder("select s from Schedule s")
				.append(" where (s.isactive=1 or (s.isactive=0 and s.isovertime=1))  and s.isdelete = 0 and s.id IN " + scheduleids);
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	// 获取制作的班次信息
	@SuppressWarnings("unchecked")
	public List<Schedule> qryScheduleByroute(long routeid, Date departdate) {

		StringBuilder sql = new StringBuilder("select s from Schedule s")
				.append(" where s.isactive=1 and s.route.id=:routeid").append(
						" and s.isovertime=0  ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("routeid", routeid);
		List<Schedule> list = query.getResultList();

		sql = new StringBuilder("select distinct s from Schedule s,")
				.append(" Cycleschemes cs,Cycleschemesschedule css")
				.append(" where s.isactive=1 and s.isovertime=1")
				.append(" and s.id=css.scheduleid and cs=css.cyclescheme")
				.append(" and cs.startdate<=:departdate and cs.enddate>=:departdate")
				.append(" and s.route.id=:routeid and s.isdelete = 0 ");
		query = getEntityManager().createQuery(sql.toString());
		query.setParameter("routeid", routeid);
		query.setParameter("departdate", departdate);
		list.addAll(query.getResultList());
		return list;
	}

	// 获取制作的班次信息
	@SuppressWarnings("unchecked")
	public List<Schedule> qryScheduleByOrg(long orgid, Date departdate) {
		StringBuilder sql = new StringBuilder("select s from Schedule s")
				.append(" where s.isactive=1 and s.orgid=:orgid").append(
						" and s.isovertime=0");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		List<Schedule> list = query.getResultList();

		sql = new StringBuilder("select distinct s from Schedule s,")
				.append(" Cycleschemes cs,Cycleschemesschedule css")
				.append(" where s.isactive=1 and s.isovertime=1")
				.append(" and s.id=css.scheduleid and cs=css.cyclescheme")
				.append(" and cs.startdate<=:departdate and cs.enddate>=:departdate")
				.append(" and s.orgid=:orgid and s.isdelete = 0 ");
		query = getEntityManager().createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("departdate", departdate);
		list.addAll(query.getResultList());
		return list;

	}

	// 获取加班的班次循环信息
	@SuppressWarnings("unchecked")
	public List<Cycleschemes> qryCycleschemes(long scheduleid, Date curdate) {
		StringBuilder sql = new StringBuilder()
				.append("select c from Cycleschemes c,Cycleschemesschedule cy")
				.append(" where c = cy.cyclescheme  ")
				.append(" and c.enddate>=:curdate and cy.scheduleid=:scheduleid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("curdate", curdate);
		return query.getResultList();
	}

	// 获取循环的班次信息
	@SuppressWarnings("unchecked")
	public List<Schedule> qryOrgSchedule(Scheduleplanlog scheduleplanlog,
			Date departdate) {
		StringBuilder sql = new StringBuilder("");
		Query query = null;
		if ("2".equals(scheduleplanlog.getType())) {
			sql.append(
					"select DISTINCT s from Cycleschemes c, Cycleschemesschedule cy, Schedule s")
					.append(" where c = cy.cyclescheme and cy.scheduleid = s.id")
					.append(" and s.isactive=1 and c.startdate<=:departdate ")
					.append(" and c.enddate>=:departdate and s.id IN")
					.append(scheduleplanlog.getScheduleids());
			query = getEntityManager().createQuery(sql.toString());
			query.setParameter("departdate", departdate);

		} else if ("1".equals(scheduleplanlog.getType())) {
			sql.append(
					"select DISTINCT s from Cycleschemes c, Cycleschemesschedule cy, Schedule s")
					.append(" where c = cy.cyclescheme and cy.scheduleid = s.id")
					.append(" and s.isactive=1 ")
					.append(" and c.startdate<=:departdate and c.enddate>=:departdate")
					.append(" and s.route.id=:routeid");
			query = getEntityManager().createQuery(sql.toString());
			query.setParameter("routeid", scheduleplanlog.getTypeid());
			query.setParameter("departdate", departdate);
		} else {
			sql.append(
					"select DISTINCT s from Cycleschemes c, Cycleschemesschedule cy, Schedule s")
					.append(" where c = cy.cyclescheme and cy.scheduleid = s.id")
					.append(" and s.isactive=1 ")
					.append(" and c.startdate<=:departdate and c.enddate>=:departdate")
					.append(" and s.orgid=:orgid");
			query = getEntityManager().createQuery(sql.toString());
			query.setParameter("orgid", scheduleplanlog.getOrgid());
			query.setParameter("departdate", departdate);
		}
		return query.getResultList();
	}

	// 删除计划时获取的班次信息
	@SuppressWarnings("unchecked")
	public List<Schedule> qryOrgdelSchedule(Scheduleplanlog scheduleplanlog) {
		StringBuilder sql = new StringBuilder("");
		Query query = null;
		// 班次
		if ("2".equals(scheduleplanlog.getType())) {
			sql.append("select s from Schedule s").append(" where s.id IN ")
					.append(scheduleplanlog.getScheduleids());
			query = getEntityManager().createQuery(sql.toString());

		}
		// 线路
		else if ("1".equals(scheduleplanlog.getType())) {
			sql.append("select s from Schedule s").append(
					" where  s.route.id=:routeid and s.isactive=1");
			query = getEntityManager().createQuery(sql.toString());
			query.setParameter("routeid", scheduleplanlog.getTypeid());
		} else {
			// 机构
			sql.append("select s from Schedule s").append(
					" where  s.orgid=:orgid  and s.isactive=1");
			query = getEntityManager().createQuery(sql.toString());
			query.setParameter("orgid", scheduleplanlog.getOrgid());
		}
		return query.getResultList();
	}

	public boolean isCycleschemes(Schedule schedule, Date departdate) {
		// 获取循环组中的循环数
		StringBuilder sql = new StringBuilder(
				"select COUNT(cv) from Cycleschemes c,Cycleschemesvehicle cv, Cycleschemesschedule cs")
				.append(" where c=cv.cyclescheme and c=cs.cyclescheme and cs.scheduleid=:scheduleid")
				.append(" and c.startdate<=:departdate and c.enddate>=:departdate");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", schedule.getId());
		query.setParameter("departdate", departdate);
		// 循环数
		return (Long) query.getSingleResult() == 0 ? false : true;
	}
	public boolean isexistSch(String code, Date departdate) {
		StringBuilder sql = new StringBuilder(
				"select count(*) from Scheduleplan sp,Schedule s")
				.append(" where sp.scheduleid=s.id and sp.departdate=:departdate and s.code=:code");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("code", code);
		query.setParameter("departdate", departdate);
		return (Long) query.getSingleResult() == 0 ? false : true;
	}
	// 获取循环车辆人员信息
	@SuppressWarnings("unchecked")
	public List<Schedulevehiclepeopleplan> getSchedulevehiclepeopleplan(
			Schedule schedule, Date departdate) {
		Query query = null;
		EntityManager em = getEntityManager();

		// 获取循环组中的循环数
		StringBuilder sql = new StringBuilder(
				"select COUNT(cv) from Cycleschemes c,Cycleschemesvehicle cv, Cycleschemesschedule cs")
				.append(" where c=cv.cyclescheme and c=cs.cyclescheme and cs.scheduleid=:scheduleid")
				.append(" and c.startdate<=:departdate and c.enddate>=:departdate");
		query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", schedule.getId());
		query.setParameter("departdate", departdate);
		// 循环数
		Long vehiclecount = (Long) query.getSingleResult();
		if (vehiclecount == 0) {
			// 还未进行设置循环信息
			return null;
		}

		sql = new StringBuilder(
				"select s from Cycleschemes c, Cycleschemesschedule cy,Schedulecycle s")
				.append(" where c = cy.cyclescheme and cy.scheduleid = :scheduleid")
				.append(" and c=s.cyclescheme")
				.append(" and c.startdate<=:departdate and c.enddate>=:departdate")
				.append(" and c.startdate=(select max(t.startdate)")
				.append("  from Cycleschemes t, Cycleschemesschedule cs where t = cs.cyclescheme")
				.append("    and cs.scheduleid =:scheduleid and t.startdate<=:departdate and t.enddate>=:departdate)");
		query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", schedule.getId());
		query.setParameter("departdate", departdate);
		List<Schedulecycle> schedulecyclelist = query.getResultList();
		// 正常某一日期一个班次只属于一个循环组
		for (Schedulecycle schedulecycle : schedulecyclelist) {
			Cycleschemes cycleschemes = (Cycleschemes) get(Cycleschemes.class,
					schedulecycle.getCyclescheme().getId());

			String rule = schedulecycle.getRule();
			// 间隔日期
			int intervaldays = DateUtils.getIntervalDays(departdate,
					cycleschemes.getStartdate());

			// 该日期是否有运营
			boolean isrun = false;

			// 按天循环
			if ("0".equals(schedulecycle.getType())) {
				int pos = intervaldays % (rule.length());
				if ("1".equals(rule.substring(pos, pos + 1))) {
					intervaldays = intervaldays / rule.length();// 第N次循环
					isrun = true;
				}
			}
			// 按周循环
			else if ("1".equals(schedulecycle.getType())) {
				int weekday = DateUtils.getCurWeekDay(departdate);
				if (rule.contains(String.valueOf(weekday))) {
					isrun = true;
				}

			}
			// 按农历月循环
			else if ("2".equals(schedulecycle.getType())) {
				String curlunar = DateUtils.getLunar(departdate);
				String lunars[] = rule.split(",");
				for (String lunar : lunars) {
					if (lunar.equals(curlunar)) {
						isrun = true;
					}
				}
			}
			// 按新历月循环
			else if ("3".equals(schedulecycle.getType())) {
				String curday = DateUtils.getDay(departdate);
				String lunars[] = rule.split(",");
				for (String lunar : lunars) {
					if (lunar.equals(curday)) {
						isrun = true;
					}
				}
			}
			if (isrun) {
				List<Schedulevehiclepeopleplan> schedulevehiclepeopleplanlist = new ArrayList<Schedulevehiclepeopleplan>();
				// 获取循环组中的循环班次
				sql = new StringBuilder(
						"select cy from Cycleschemes c, Cycleschemesschedule cy")
						.append(" where c = cy.cyclescheme and cy.cyclescheme=:cyclescheme and cy.scheduleid=:scheduleid");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("cyclescheme",
						schedulecycle.getCyclescheme());
				query.setParameter("scheduleid", schedule.getId());
				Cycleschemesschedule cycleschemesschedule = (Cycleschemesschedule) query
						.getSingleResult();
				// 循环班次序号
				int scheduleorderno = cycleschemesschedule.getOrderno() - 1;
				// 获取循环组中的驾驶员循环数
				sql = new StringBuilder(
						"select COUNT(cd) from Cycleschemesdriver cd")
						.append(" where cd.cyclescheme=:cycleschemes");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("cycleschemes", cycleschemes);
				// 驾驶员循环数
				Long drivecount = (Long) query.getSingleResult();

				// 获取循环组中的乘务员循环数
				sql = new StringBuilder(
						"select COUNT(cd) from Cycleschemessteward cd")
						.append(" where cd.cyclescheme=:cycleschemes");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("cycleschemes", cycleschemes);
				// 乘务员循环数
				Long stewardcount = (Long) query.getSingleResult();

				Schedulevehiclepeopleplan schedulevehiclepeopleplan;
				// 若是流水班次
				if (schedule.getIslinework()) {
					sql = new StringBuilder(
							"select count(cy) from  Cycleschemesschedule cy")
							.append(" where  cy.cyclescheme=:cyclescheme");
					query = getEntityManager().createQuery(sql.toString());
					query.setParameter("cyclescheme",
							schedulecycle.getCyclescheme());
					Long schcount = (Long) query.getSingleResult();
					int startm = DateUtils.toMinute(schedule.getStarttime());
					int endm = DateUtils.toMinute(schedule.getEndtime());
					short interval = schedule.getSpacinginterval();
					int schedulenum;
					if (interval > 0) {
						schedulenum = (endm - startm) / interval;
					} else {
						schedulenum = 1;
					}
					//if(schcount==1){
						for (int i = 0; i < schedulenum; i++) {
							scheduleorderno = i;
							schedulevehiclepeopleplan = genSchedulevehiclepeopleplan(
									cycleschemes, schedulecycle, scheduleorderno,
									intervaldays, vehiclecount, drivecount,
									stewardcount);
							schedulevehiclepeopleplan.setOrderno((short) i);
							schedulevehiclepeopleplanlist
									.add(schedulevehiclepeopleplan);
						}
						return schedulevehiclepeopleplanlist;
					/*}else{
						schedulevehiclepeopleplan = genSchedulevehiclepeopleplan(
									cycleschemes, schedulecycle, scheduleorderno,
									intervaldays, vehiclecount, drivecount,
									stewardcount);
						schedulevehiclepeopleplanlist
									.add(schedulevehiclepeopleplan);
						return schedulevehiclepeopleplanlist;
					}*/
				} else {
					schedulevehiclepeopleplan = genSchedulevehiclepeopleplan(
							cycleschemes, schedulecycle, scheduleorderno,
							intervaldays, vehiclecount, drivecount,
							stewardcount);
					if (schedulevehiclepeopleplan == null) {
						return null;
					}
					schedulevehiclepeopleplanlist
							.add(schedulevehiclepeopleplan);
					return schedulevehiclepeopleplanlist;
				}
			}
		}
		return null;
	}

	private Schedulevehiclepeopleplan genSchedulevehiclepeopleplan(
			Cycleschemes cycleschemes, Schedulecycle schedulecycle,
			int scheduleorderno, int intervaldays, Long vehiclecount,
			Long drivecount, Long stewardcount) {

		Schedulevehiclepeopleplan schedulevehiclepeopleplan = new Schedulevehiclepeopleplan();

		// 车辆循环周期
		int vehicleperiod = cycleschemes.getVehicleperiod();
		// 车辆循环步长
		int vehiclestep = cycleschemes.getVehiclestep();
		// 驾驶员循环周期
		int driverperiod = cycleschemes.getDriverperiod();
		// 驾驶员循环步长
		int driverstep = cycleschemes.getDriverstep();
		// 一个班次的驾驶员人数
		short drivernum = cycleschemes.getDrivernum();
		// 乘务员循环周期
		int stewardperiod = cycleschemes.getStewardperiod();
		// 乘务员循环步长
		int stewardstep = cycleschemes.getStewardstep();
		// 一个班次的乘务员人数
		short stewardnum = cycleschemes.getStewardnum();

		double vhicleorderno = 0;// 车辆的序号
		double driverorderno = 0;// 驾驶员的序号
		byte orderno;
		Cycleschemesvehicle cycleschemesvehicle;

		// 计算循环车辆的序号=(间隔日期/循环周期 * 循环步长 + 循环班次序号)取模 车辆循环数
		if (vehicleperiod == 0) {
			vhicleorderno = scheduleorderno % vehiclecount;
			orderno = (byte) (Double.valueOf(vhicleorderno).byteValue() + 1);// 暂时加1
		} else {
			vhicleorderno = (Math.floor(intervaldays / vehicleperiod)
					* vehiclestep + scheduleorderno)
					% vehiclecount + 1;
			orderno = (byte) (Double.valueOf(vhicleorderno).byteValue());// 不加1
		}

		cycleschemesvehicle = getCycleschemesvehicle(cycleschemes, orderno);
		if (cycleschemesvehicle == null) {
			return null;
		}
		schedulevehiclepeopleplan.setPlanunit(cycleschemesvehicle.getUnit());
		schedulevehiclepeopleplan.setPlanvehicle(cycleschemesvehicle
				.getVehicle());
		schedulevehiclepeopleplan
				.setPlanvehiclebrandmodelid(cycleschemesvehicle
						.getVehiclebrandmodelid());
		schedulevehiclepeopleplan.setPlanvehicletypeid(cycleschemesvehicle
				.getVehicletypeid());

		// 有设置才进行计算驾驶员的序号,并且当班驾驶员人数要大于0
		if (drivecount > 0 && drivernum > 0) {
			if (driverperiod == 0) {
				driverorderno = scheduleorderno % drivecount;
			}
			// 计算循环驾驶员的序号=(间隔日期/循环周期 * 循环步长 + 循环班次序号)取模驾驶员循环数
			else {
				driverorderno = (Math.floor(intervaldays / driverperiod)
						* driverstep + scheduleorderno)
						% drivecount + 1;
			}
			orderno = (byte) driverorderno;
			Cycleschemesdriver cycleschemesdrive;
			// 当班驾驶员人数
			switch (drivernum) {
			case 1: {
				cycleschemesdrive = getCycleschemesdriver(cycleschemes, (byte)(orderno==0?drivecount:orderno));
				schedulevehiclepeopleplan.setPlandriver1(cycleschemesdrive
						.getDriver());
				break;
			}
			case 2: {								
				cycleschemesdrive = getCycleschemesdriver(cycleschemes, (byte)(orderno==0?drivecount:orderno));
				schedulevehiclepeopleplan.setPlandriver1(cycleschemesdrive
						.getDriver());
				orderno = (byte) ((driverorderno + 1) % drivecount==0?drivecount:(driverorderno + 1) % drivecount);// 取下一个驾驶员序号
	//			orderno = (byte) ((orderno + 1)==0?drivecount:(orderno + 1));// 下标从1开始所以要加1
				cycleschemesdrive = getCycleschemesdriver(cycleschemes, orderno);
				schedulevehiclepeopleplan.setPlandriver2(cycleschemesdrive
						.getDriver());
				break;
			}
			case 3: {								
				cycleschemesdrive = getCycleschemesdriver(cycleschemes, orderno);
				schedulevehiclepeopleplan.setPlandriver1(cycleschemesdrive
						.getDriver());
				orderno = (byte) ((driverorderno + 1) % drivecount==0?drivecount:(driverorderno + 1) % drivecount);
				cycleschemesdrive = getCycleschemesdriver(cycleschemes, orderno);
				schedulevehiclepeopleplan.setPlandriver2(cycleschemesdrive
						.getDriver());
				orderno = (byte) ((driverorderno + 2) % drivecount==0?drivecount:(driverorderno + 2) % drivecount);
				cycleschemesdrive = getCycleschemesdriver(cycleschemes, orderno);
				schedulevehiclepeopleplan.setPlandriver3(cycleschemesdrive
						.getDriver());
				break;
			}
			case 4: {										
				cycleschemesdrive = getCycleschemesdriver(cycleschemes, (byte)(orderno==0?drivecount:orderno));
				schedulevehiclepeopleplan.setPlandriver1(cycleschemesdrive
						.getDriver());
				orderno = (byte) ((driverorderno + 1) % drivecount==0?drivecount:(driverorderno + 1) % drivecount);
				cycleschemesdrive = getCycleschemesdriver(cycleschemes, orderno);
				schedulevehiclepeopleplan.setPlandriver2(cycleschemesdrive
						.getDriver());
				orderno = (byte) ((driverorderno + 2) % drivecount==0?drivecount:(driverorderno + 2) % drivecount);
				cycleschemesdrive = getCycleschemesdriver(cycleschemes, orderno);
				schedulevehiclepeopleplan.setPlandriver3(cycleschemesdrive
						.getDriver());
				orderno = (byte) ((driverorderno + 3) % drivecount==0?drivecount:(driverorderno + 3) % drivecount);
				cycleschemesdrive = getCycleschemesdriver(cycleschemes, orderno);
				schedulevehiclepeopleplan.setPlandriver4(cycleschemesdrive
						.getDriver());
				break;
			}
			}
		}
		// 当班乘务员
		// 有设置才进行计算,即乘务员的循环数大于0,并且当班乘务员人数要大于0
		if (stewardcount > 0 && stewardnum > 0) {
			double stewardorderno = 0;// 乘务员的序号
			if (stewardperiod == 0) {
				stewardorderno = scheduleorderno % stewardcount;
			}
			// 计算循环乘务员的序号=(间隔日期/循环周期 * 循环步长 + 循环班次序号)取模乘务员循环数
			else {
				stewardorderno = (Math.floor(intervaldays / stewardperiod)
						* stewardstep + scheduleorderno)
						% stewardcount + 1;
			}
			orderno = (byte) stewardorderno;
			Cycleschemessteward cycleschemessteward;
			// 当班乘务员人数
			switch (stewardnum) {
			case 1: {								
				cycleschemessteward = getCycleschemessteward(cycleschemes,
						(byte)(orderno==0?stewardcount:orderno));
				schedulevehiclepeopleplan.setPlansteward1(cycleschemessteward
						.getSteward());
				break;
			}
			case 2: {								
				cycleschemessteward = getCycleschemessteward(cycleschemes,
						(byte)(orderno==0?stewardcount:orderno));
				schedulevehiclepeopleplan.setPlansteward1(cycleschemessteward
						.getSteward());
				orderno = (byte) ((stewardorderno + 1) % stewardcount==0?stewardcount:(stewardorderno + 1) % stewardcount);// 取下一个乘务员序号				
//				orderno = (byte) (orderno + 1==0?stewardcount:orderno+1);// 下标从1开始所以要加1
				cycleschemessteward = getCycleschemessteward(cycleschemes,
						orderno);
				schedulevehiclepeopleplan.setPlansteward2(cycleschemessteward
						.getSteward());
				break;
			}
			}
		}
		return schedulevehiclepeopleplan;
	}

	// 是否已经生成计划
	@SuppressWarnings("unchecked")
	public Scheduleplan getScheduleplan(long scheduleid, Date departdate,
			Long orgid) {

		StringBuilder sql = new StringBuilder(
				"select c from Scheduleplan c where c.scheduleid=:scheduleid")
				.append(" and c.departdate=:departdate and c.orgid=:orgid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setLockMode(LockModeType.PESSIMISTIC_READ);
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("departdate", departdate);
		query.setParameter("orgid", orgid);
		List<Scheduleplan> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	// 获取班次固定预留信息
	@SuppressWarnings("unchecked")
	public Scheduleseatreserve getScheduleseatreserve(long scheduleid,
			Date departdate, long vehiclebrandmodelid) {

		StringBuilder sql = new StringBuilder(
				"select c from Scheduleseatreserve c where c.scheduleid=:scheduleid")
				.append(" and c.startdate<=:departdate and c.enddate>=:departdate and c.isactive=1")
				.append(" and c.vehiclebrandmodelid=:vehiclebrandmodelid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("departdate", departdate);
		query.setParameter("vehiclebrandmodelid", vehiclebrandmodelid);
		List<Scheduleseatreserve> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	// 获取班次已售座位数
	public Short getSchedulesoldeatnum(long scheduleid, Date departdate) {

		StringBuilder sql = new StringBuilder(
				"select count(c) from Ticketsell c where c.scheduleid=:scheduleid")
				.append(" and c.departdate=:departdate and c.ticketstatus='0' and c.tickettype <> 'E' ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("departdate", departdate);
		Short count = ((Long) query.getSingleResult()).shortValue();
		return count;
	}

	// 获取班次某一座位状态数
	public Short getScheduleseats(long scheduleid, Date departdate,
			String status) {

		StringBuilder sql = new StringBuilder(
				"select count(c) from Scheduleseats c where c.scheduleid=:scheduleid")
				.append(" and c.departdate=:departdate and c.status=:status");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("departdate", departdate);
		query.setParameter("status", status);
		Short count = ((Long) query.getSingleResult()).shortValue();
		return count;
	}

	// 获取班次硬调节日票价信息
	@SuppressWarnings("unchecked")
	public List<Handholidayprice> getHandholidayprice(long scheduleid,
			Date departdate, long vehicletypeid) {

		StringBuilder sql = new StringBuilder(
				"select c from Handholidayprice c where c.scheduleid=:scheduleid")
				.append(" and c.startdate<=:departdate and c.enddate>=:departdate")
				.append(" and c.vehicletypeid=:vehicletypeid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("departdate", departdate);
		query.setParameter("vehicletypeid", vehicletypeid);
		List<Handholidayprice> list = query.getResultList();
		return list;
	}

	// 获取班次硬调节日票价信息
	@SuppressWarnings("unchecked")
	public List<Handholidayprice> getHandholidayprice(long scheduleid,
			Date departdate, long vehicletypeid,
			Vehiclebrandmodel vehiclebrandmodel) {

		StringBuilder sql = new StringBuilder(
				"select c from Handholidayprice c where  c.startdate<=:departdate and c.enddate>=:departdate ")
				.append(" and c.scheduleid=:scheduleid and c.vehicletypeid=:vehicletypeid order by c.updatetime desc");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("departdate", departdate);
		query.setParameter("vehicletypeid", vehicletypeid);
		List<Handholidayprice> list1 = query.getResultList();
		long holidayid = 0;
		if (list1 != null && list1.size() > 0) {
			holidayid = list1.get(0).getHolidayid();
		}

		sql = new StringBuilder(
				"select c from Handholidayprice c,Schedulestop s,Schedulestop st where c.scheduleid=:scheduleid")
				.append(" and c.startdate<=:departdate and c.enddate>=:departdate")
				.append(" and c.vehicletypeid=:vehicletypeid")
				.append(" and c.vehiclebrandmodel=:vehiclebrandmodel")
				.append(" and c.holidayid=:holidayid")
				.append(" and c.scheduleid=st.schedule.id")
				.append(" and c.departstationid=st.stationid and st.isactive=1")				
				.append(" and c.reachstationid=s.stationid and s.schedule.id=c.scheduleid")
				.append(" and s.isactive=1");
		query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("departdate", departdate);
		query.setParameter("vehicletypeid", vehicletypeid);
		query.setParameter("holidayid", holidayid);

		query.setParameter("vehiclebrandmodel", vehiclebrandmodel);
		List<Handholidayprice> list = query.getResultList();
		if (list == null || list.size() == 0) {
			sql = new StringBuilder(
					"select c from Handholidayprice c,Schedulestop s,Schedulestop st where c.scheduleid=:scheduleid")
					.append(" and c.startdate<=:departdate and c.enddate>=:departdate")
					.append(" and c.vehicletypeid=:vehicletypeid")
					.append(" and c.holidayid=:holidayid")
					.append(" and c.scheduleid=st.schedule.id")
					.append(" and c.departstationid=st.stationid and st.isactive=1")						
					.append(" and c.reachstationid=s.stationid and s.schedule.id=c.scheduleid")
					.append(" and s.isactive=1");
			query = getEntityManager().createQuery(sql.toString());
			query.setParameter("scheduleid", scheduleid);
			query.setParameter("departdate", departdate);
			query.setParameter("vehicletypeid", vehicletypeid);
			query.setParameter("holidayid", holidayid);
			list = query.getResultList();
		}
		return list;
	}

	// 获取班次硬调票价信息,增加删除的停靠点不查询出来，即不生成营运计划票价
	@SuppressWarnings("unchecked")
	public List<Handprice> getHandprice(long scheduleid, long vehicletypeid) {

		StringBuilder sql = new StringBuilder(
				"select c from Handprice c,Schedulestop ss,Schedulestop st ")
				.append(" where c.scheduleid=:scheduleid")
				.append(" and c.scheduleid=ss.schedule.id and c.reachstationid=ss.stationid")
				.append(" and ss.isactive=1 and c.scheduleid=st.schedule.id")
				.append(" and c.departstationid=st.stationid and st.isactive=1")
				.append(" and c.vehicletypeid=:vehicletypeid")
				.append(" and c.vehiclebrandmodel=null");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("vehicletypeid", vehicletypeid);
		List<Handprice> list = query.getResultList();
		return list;
	}
	
	// 获取班次硬调票价信息,增加删除的停靠点不查询出来，即不生成营运计划票价
	@SuppressWarnings("unchecked")
	public List<Handprice> getHandprice(long scheduleid) {

		StringBuilder sql = new StringBuilder(
				"select c from Handprice c,Schedulestop ss,Schedulestop st ")
				.append(" where c.scheduleid=:scheduleid")
				.append(" and c.scheduleid=ss.schedule.id and c.reachstationid=ss.stationid")
				.append(" and ss.isactive=1 and c.scheduleid=st.schedule.id")
				.append(" and c.departstationid=st.stationid and st.isactive=1")
				.append(" and c.vehiclebrandmodel=null");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		List<Handprice> list = query.getResultList();
		//去掉多种类型重复，导致ticketprice 违反唯一报错问题
		if(list.size()==0){
			return null;
		}
		long vehicletypeid = list.get(0).getVehicletypeid();
		Iterator<Handprice> iter = list.iterator();  
		while(iter.hasNext()){  
			Handprice hp = iter.next();  
		    if(hp.getVehicletypeid()!=vehicletypeid){  
		        iter.remove();  
		    }  
		}  
		return list;
	}
	
	public Schedule getSchedule(long routeid) {
		StringBuilder sql = new StringBuilder(
				"select s from Handprice c,Schedulestop ss,Schedulestop st,Schedule s ")
				.append(" where c.scheduleid=s.id")
				.append(" and c.scheduleid=ss.schedule.id and c.reachstationid=ss.stationid")
				.append(" and ss.isactive=1 and c.scheduleid=st.schedule.id")
				.append(" and c.departstationid=st.stationid and st.isactive=1 and s.isactive=1 ")
				.append(" and s.route.id=:routeid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("routeid", routeid);
		List<Schedule> list = query.getResultList();
		return list!=null&&list.size()>0?list.get(0):null;
	}

	// 获取班次硬调票价信息,增加删除的停靠点不查询出来，即不生成营运计划票价
	@SuppressWarnings("unchecked")
	public List<Handprice> getHandprice(long scheduleid, long vehicletypeid,
			Vehiclebrandmodel vehiclebrandmodel,String isbyVehicletype) {

		StringBuilder sql = new StringBuilder(
				"select c from Handprice c,Schedulestop ss,Schedulestop st  where c.scheduleid=:scheduleid")
				.append(" and c.scheduleid=ss.schedule.id and c.reachstationid=ss.stationid")
				.append(" and ss.isactive=1 and c.scheduleid=st.schedule.id")
				.append(" and c.departstationid=st.stationid and st.isactive=1")
				.append(" and c.vehicletypeid=:vehicletypeid")
				.append(" and c.vehiclebrandmodel=:vehiclebrandmodel");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("vehicletypeid", vehicletypeid);
		query.setParameter("vehiclebrandmodel", vehiclebrandmodel);
		List<Handprice> list = query.getResultList();
		//若不根据车型取票价
		if(isbyVehicletype.equals(ParamterConst.COMMON_FLAG.FALG_NO)){
			if(list == null || list.size() == 0){
				sql = new StringBuilder(
						"select c from Handprice c,Schedulestop ss,Schedulestop st  where c.scheduleid=:scheduleid")
						.append(" and c.scheduleid=ss.schedule.id and c.reachstationid=ss.stationid")
						.append(" and ss.isactive=1 and c.scheduleid=st.schedule.id")
						.append(" and c.departstationid=st.stationid and st.isactive=1")
						.append(" and c.vehicletypeid=:vehicletypeid and c.vehiclebrandmodel is null ");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("scheduleid", scheduleid);
				query.setParameter("vehicletypeid", vehicletypeid);
				list = query.getResultList();
				if(list == null || list.size() == 0){
					sql = new StringBuilder(
							"select c from Handprice c,Schedulestop ss,Schedulestop st  where c.scheduleid=:scheduleid")
							.append(" and c.scheduleid=ss.schedule.id and c.reachstationid=ss.stationid")
							.append(" and ss.isactive=1 and c.scheduleid=st.schedule.id")
							.append(" and c.departstationid=st.stationid and st.isactive=1")
							.append(" and c.vehicletypeid=:vehicletypeid");
					query = getEntityManager().createQuery(sql.toString());
					query.setParameter("scheduleid", scheduleid);
					query.setParameter("vehicletypeid", vehicletypeid);
					list = query.getResultList();
				}
			}
			return list;
		}else{
			if(list == null || list.size() == 0){
				sql = new StringBuilder(
						"select c from Handprice c,Schedulestop ss,Schedulestop st where c.scheduleid=:scheduleid")
						.append(" and c.scheduleid=ss.schedule.id and c.reachstationid=ss.stationid")
						.append(" and c.scheduleid=st.schedule.id")
						.append(" and c.departstationid=st.stationid and st.isactive=1")
						.append(" and c.vehicletypeid=:vehicletypeid")
						.append(" and ss.isactive=1 order by c.fullprice desc");
				query = getEntityManager().createQuery(sql.toString());
				query.setParameter("scheduleid", scheduleid);
				query.setParameter("vehicletypeid", vehicletypeid);			
				list = query.getResultList();				
				if (list == null || list.size() == 0) {
					sql = new StringBuilder(
							"select c from Handprice c,Schedulestop ss,Schedulestop st where c.scheduleid=:scheduleid")
							.append(" and c.scheduleid=ss.schedule.id and c.reachstationid=ss.stationid")
							.append(" and c.scheduleid=st.schedule.id")
							.append(" and c.departstationid=st.stationid and st.isactive=1")
							.append(" and ss.isactive=1 and c.vehiclebrandmodel is not null ");
					query = getEntityManager().createQuery(sql.toString());
					query.setParameter("scheduleid", scheduleid);
					list = query.getResultList();
					if (list != null && list.size() > 0) {
						Handprice hp = list.get(0);
						if (hp.getVehiclebrandmodel() == null) {
							sql = new StringBuilder(
									"select c from Handprice c,Schedulestop ss,Schedulestop st where c.scheduleid=:scheduleid")
									.append(" and c.scheduleid=ss.schedule.id and c.reachstationid=ss.stationid")
									.append(" and ss.isactive=1")
									.append(" and c.scheduleid=st.schedule.id")
									.append(" and c.departstationid=st.stationid and st.isactive=1")								
									.append(" and c.vehicletypeid=:vehicletypeid");
							query = getEntityManager().createQuery(sql.toString());
							query.setParameter("scheduleid", scheduleid);
							query.setParameter("vehicletypeid", hp.getVehicletypeid());
							list = query.getResultList();
						} else {
							sql = new StringBuilder(
									"select c from Handprice c,Schedulestop ss,Schedulestop st where c.scheduleid=:scheduleid")
									.append(" and c.scheduleid=ss.schedule.id and c.reachstationid=ss.stationid")
									.append(" and ss.isactive=1")
									.append(" and c.scheduleid=st.schedule.id")
									.append(" and c.departstationid=st.stationid and st.isactive=1")								
									.append(" and c.vehicletypeid=:vehicletypeid")
									.append(" and c.vehiclebrandmodel=:vehiclebrandmodel");
							query = getEntityManager().createQuery(sql.toString());
							query.setParameter("scheduleid", scheduleid);
							query.setParameter("vehicletypeid", hp.getVehicletype());
							query.setParameter("vehiclebrandmodel", hp.getVehiclebrandmodel());
							list = query.getResultList();
						}
					}
				}
			}
		}
		return list;
	}

	// 获取班次上车站信息
	// 获取班次停靠点信息
	@SuppressWarnings("unchecked")
	public List<Schedulestop> getOrgSchedulestop(long scheduleid,
			boolean isdepart, boolean isactive) {
		StringBuilder sql = new StringBuilder(" select t from Schedulestop t where t.schedule.id = :scheduleid")
				.append(" and t.isactive=:isactive and t.isdepart=:isdepart order by orderno");
		Query query = getEntityManager().createQuery(sql.toString());		
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("isdepart", isdepart);
		query.setParameter("isactive", isactive);
		List<Schedulestop> list = query.getResultList();
		if(list!=null){
			return list;
		}
		return null;
//		return query.getResultList();
	}

	// 获取班次所属线路里程信息
	@SuppressWarnings("unchecked")
	public List<Routestop> getRoutestop(long routeid) {
		StringBuilder sql = new StringBuilder(
				"select t from Routestop t where t.route.id = :routeid")
				.append(" and t.isactive=1 ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("routeid", routeid);
		return query.getResultList();
	}

	// 获取公式票价信息
	@SuppressWarnings("unchecked")
	public List<Standardprice> getStandardprice(long scheduleid,
			long vehicletypeid) {
		StringBuilder sql = new StringBuilder(
				"select s from Standardprice s where ")
				.append(" s.scheduleid = :scheduleid and s.vehicletypeid=:vehicletypeid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("vehicletypeid", vehicletypeid);
		return query.getResultList();
	}

	// 判断某一个上车站是否有售票记录
	public boolean isexistSellticket(long scheduleplanid, long departstationid) {

		StringBuilder sql = new StringBuilder(
				"select count(c) from Ticketsell c where c.scheduleplanid=:scheduleplanid")
				.append(" and c.departstationid=:departstationid ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("departstationid", departstationid);
		Short count = ((Long) query.getSingleResult()).shortValue();
		return count > 0;
	}

	// 判断是否有售票记录
	public boolean isexistSellticket(long scheduleplanid) {

		StringBuilder sql = new StringBuilder(
				"select count(c) from Ticketsell c where c.scheduleplanid=:scheduleplanid ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		Short count = ((Long) query.getSingleResult()).shortValue();
		return count > 0;
	}

	// 查询 循环的车辆信息
	public Cycleschemesvehicle getCycleschemesvehicle(
			Cycleschemes cycleschemes, byte orderno) {
		StringBuilder sql = new StringBuilder(
				"select c from Cycleschemesvehicle c").append(
				" where c.cyclescheme=:cyclescheme ").append(
				" and c.orderno=:orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("cyclescheme", cycleschemes);
		query.setParameter("orderno", orderno);
		List list = query.getResultList();
		return (Cycleschemesvehicle) (list != null && list.size() > 0 ? list
				.get(0) : null);
	}

	// 查询 循环的驾驶员信息
	public Cycleschemesdriver getCycleschemesdriver(Cycleschemes cycleschemes,
			byte orderno) {
		StringBuilder sql = new StringBuilder(
				"select cd from Cycleschemesdriver cd")
				.append(" where cd.cyclescheme=:cycleschemes and cd.orderno=:orderno ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("cycleschemes", cycleschemes);
		query.setParameter("orderno", orderno);
		return (Cycleschemesdriver) query.getSingleResult();
	}

	// 查询 循环的乘务员信息
	public Cycleschemessteward getCycleschemessteward(
			Cycleschemes cycleschemes, byte orderno) {
		StringBuilder sql = new StringBuilder(
				"select cd from Cycleschemessteward cd")
				.append(" where cd.cyclescheme=:cycleschemes and cd.orderno=:orderno ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("cycleschemes", cycleschemes);
		query.setParameter("orderno", orderno);
		return (Cycleschemessteward) query.getSingleResult();
	}

	// 查询 循环车辆人员信息
	@SuppressWarnings("unchecked")
	public List<Schedulevehiclepeopleplan> getSchedulevehiclepeopleplan(
			Scheduleplan scheduleplan) {
		StringBuilder sql = new StringBuilder(
				"select s from Schedulevehiclepeopleplan s")
				.append(" where s.scheduleplan=:scheduleplan ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplan", scheduleplan);
		return query.getResultList();
	}
	// 查询营运计划信息
	//营运计划管理中的查询
	@SuppressWarnings("unchecked")
	public List<Object> qryScheduleplan(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select 0 as ischoose,sp.id,sp.orgid,sp.departdate,")
				.append(" sp.scheduleid,sp.seatnum,sp.autocancelreserveseatnum,")
				.append(" sp.unautocancelreserveseatnum,sp.fixedreserveseatnum,sp.soldeatnum,")
				.append(" sp.issellable,sp.startstationid,sp.endstationid,")
				.append(" sp.starttime,sp.runtime,sp.distance,sp.highdistance,"
						+ "	sp.worktype,sp.workways,sp.districttype,"
						+ "	sp.scheduletype,sp.isproprietary,sp.isovertime,"
						+ "	sp.issellreturnticket,sp.islinework,sp.endtime,"
						+ "	sp.spacinginterval,	sp.isoriginator,sp.issaleafterreport,"
						+ "	sp.iscanmixcheck,sp.remarks,sp.stationfeeapplyid,"
						+ "	sp.fueladditionfeeapplyid,sp.carrychildnum,"
						+ "org.name as orgname,r.name as routename,r.id as routeid, s.code,s1.name as departstation,")
				.append(" s2.name as reachstation,ss.buspark,trim(ss.departtime) as departtime,ss.isbegincheck,")
				.append(" ss.isdeparted,ss.isreported,ss.status,ss.ticketentrance,")
				.append(" vt.name as vehicletypename,v.vehicleno,vb.brandname,vb.id as brandmodelid,")
				.append(" d1.name as driver1,d2.name as driver2,")
				.append(" d3.name as driver3,sw1.name as steward1,sp.createtime")
				.append(" from Scheduleplan sp,Schedule s,")
				.append(" Schedulevehiclepeopleplan sv ")
				.append(" LEFT JOIN vehicle v on sv.planvehicleid=v.id")
				.append(" LEFT JOIN driver d1 on sv.plandriver1id=d1.id")
				.append(" LEFT JOIN driver d2 on sv.plandriver2id=d2.id")
				.append(" LEFT JOIN driver d3 on sv.plandriver3id=d3.id")
				.append(" LEFT JOIN steward sw1 on sv.plansteward1id=sw1.id,")
				.append(" Vehicletype vt, Route r, Station s1, Station s2, Schedulestatus ss,")
				.append("Organization org, vehiclebrandmodel vb where sp.scheduleid = s.id")
				.append(" and sv.planvehicletypeid = vt.id  and sp.id = sv.scheduleplanid")
				.append(" and sv.planvehiclebrandmodelid = vb.id")
				.append(" and sv.orderno = 0 and s.routeid= r.id")
				.append(" and ss.departstationid = s1.id  and sp.endstationid = s2.id")
				.append(" and sp.id = ss.scheduleplanid and ss.orgid = org.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by org.id,r.id,ss.departtime ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	// 查询营运计划票价信息
	@SuppressWarnings("unchecked")
	public List<Object> qryTicketprice(Scheduleplan scheduleplan) {
		StringBuilder sql = new StringBuilder(
				"select s1.name as departstation,s2.name as reachstation,")
				.append(" t.id,t.runtime,t.seattype,t.seatnos,")
				.append(" t.seatnum,t.soldeatnum,t.fullprice,t.halfprice,")
				.append(" t.studentprice,t.issellable,t.distance,t.balancedistance,")
				.append(" t.toplimitprice,t.lowerlimitprice,t.autocancelreserveseatnum,")
				.append(" t.unautocancelreserveseatnum,t.fixedreserveseatnum,")
				.append(" t.stationservicefee,t.fueladditionfee,")
				.append(" (t.seatnum-t.soldeatnum-t.unautocancelreserveseatnum-t.fixedreserveseatnum-t.autocancelreserveseatnum")
				.append(" )as residueseatnum,t.moreprice,t.discountprice,t.roundprice,t.connectprice from")
				.append(" Ticketprice t,Station s1,Station s2,schedulestop ss1,schedulestop ss2")
				.append(" where t.departstationid=s1.id")
				.append(" and t.reachstationid=s2.id and t.scheduleplanid=:scheduleplanid")
				.append(" and ss1.scheduleid=t.scheduleid and t.departstationid=ss1.stationid")
				.append(" and ss2.scheduleid=t.scheduleid and t.reachstationid=ss2.stationid");
		sql.append(" order by ss1.orderno,ss2.orderno ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplan.getId());
		return query.getResultList();
	}

	// 查询营运计划票价信息
	@SuppressWarnings("unchecked")
	public List<Object> qryTicketpriceitem(long ticketpriceid, String tickettype) {
		StringBuilder sql = new StringBuilder("select tp.code,tp.name,t.price,")
				.append(" t.id,t.tickettype,t.isautoadjust,t.ticketpriceid,t.ticketpriceformulaitemid from")
				.append(" Ticketpriceitem t,Ticketpriceformulaitem tp where ")
				.append(" t.ticketpriceformulaitemid=tp.id and t.ticketpriceid=:ticketpriceid")
				.append(" and t.tickettype=:tickettype");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("ticketpriceid", ticketpriceid);
		query.setParameter("tickettype", tickettype);
		return query.getResultList();
	}

	// 查询 票价项目信息
	public Ticketpriceformulaitem getTicketpriceformulaitem(
			long ticketpriceformulaitemid) {
		StringBuilder sql = new StringBuilder(
				"select s from Ticketpriceformulaitem s")
				.append(" where s.id=:ticketpriceformulaitemid ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitemid", ticketpriceformulaitemid);
		return (Ticketpriceformulaitem) query.getSingleResult();
	}

	// 查询 是基础运价的票价项目
	@SuppressWarnings("unchecked")
	public List<Ticketpriceformulaitem> getTicketpriceformulaitems(long orgid) {
		StringBuilder sql = new StringBuilder(
				"select s from Ticketpriceformulaitem s")
				.append(" where s.orgid=:orgid and s.isfreight=1 and s.isactive=1");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		return query.getResultList();
	}

	// 获取班次座位信息
	@SuppressWarnings("unchecked")
	public List<Object> qryScheduleseats(Scheduleplan scheduleplan) {
		StringBuilder sql = new StringBuilder(
				"select c from Scheduleseats c where c.scheduleplan=:scheduleplan");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplan", scheduleplan);
		return query.getResultList();
	}

	// 获取班次票价信息
	@SuppressWarnings("unchecked")
	public List<Ticketprice> qryTicketprices(Scheduleplan scheduleplan) {
		StringBuilder sql = new StringBuilder(
				"select c from Ticketprice c where c.scheduleplan=:scheduleplan");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplan", scheduleplan);
		return query.getResultList();
	}
	// 获取该厂牌的乘客座位数
	@SuppressWarnings("unchecked")
	public long getBrandSeat(long vehiclebrandmodelid) {
		StringBuilder sql = new StringBuilder(
				"select count(vs) from Vehicleseatplandetail vs,Vehiclespace vp")
				.append(" where vs.vehiclespaceid=vp.id and vs.vehicleseatplan.id=:vehiclebrandmodelid")
				.append(" and vp.ispassengerseat=1");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("vehiclebrandmodelid", vehiclebrandmodelid);
		List<Object> list = query.getResultList();
		if (list != null && list.size() > 0) {
			return (Long) list.get(0);
		} else {
			return 0;
		}
	}

	// 查询 班次的长停信息
	@SuppressWarnings("unchecked")
	public List<Schedulelongstop> getSchedulelongstop(long scheduleid,
			Date departdate) {
		StringBuilder sql = new StringBuilder(
				"select s from Schedulelongstop s")
				.append(" where s.schedule.id=:scheduleid and s.startdate<=:departdate and s.enddate>=:departdate");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("departdate", departdate);
		return query.getResultList();
	}

	// 查询用户
	@SuppressWarnings("unchecked")
	public Userinfo getAdmin() {
		StringBuilder sql = new StringBuilder("select s from Userinfo s")
				.append(" where s.code=:code");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("code", "ADMIN");
		List<Userinfo> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;

	}

	// 查询用户
	@SuppressWarnings("unchecked")
	public Date getMaxDepartdate(long orgid) {
		StringBuilder sql = new StringBuilder(
				"select max(s.departdate) from Scheduleplan s")
				.append(" where s.orgid=:orgid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		List<Object> list = query.getResultList();
		return (Date) (list != null && list.size() > 0 ? list.get(0) : null);

	}

	// 查询机构
	@SuppressWarnings("unchecked")
	public List<Organization> qryOrganization() {
		StringBuilder sql = new StringBuilder(
				"select distinct s from Organization s,Route r")
				.append(" where s.id=r.orgid and r.isactive=1");
		Query query = getEntityManager().createQuery(sql.toString());
		List<Organization> list = query.getResultList();
		return list;

	}

	// 根据厂牌查询座位类型
	@SuppressWarnings("unchecked")
	public Vehiclespace qryVehiclespace(Vehiclebrandmodel vehiclebrandmodel,
			short seatno) {
		StringBuilder sql = new StringBuilder(
				"select vs from Vehiclespace vs,Vehicleseatplandetail vp,Vehicleseatplan v")
				.append(" where vs.id = vp.vehiclespaceid and vp.vehicleseatplan=v")
				.append(" and vs.isactive='1' and vp.seatno=:seatno and v.vehiclebrandmodelid=:vehiclebrandmodelid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("vehiclebrandmodelid", vehiclebrandmodel.getId());
		query.setParameter("seatno", seatno);
		List<Vehiclespace> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;

	}

	// 根据线路ID查询班次
	@SuppressWarnings("unchecked")
	public List<Object> qrySchedules(long routeid) {
		StringBuilder sql = new StringBuilder(
				"selecT s.id, s.code as name, trim(s.starttime) as starttime,s.code"
						+ "  from Schedule s"
						+ " where  s.routeid=:routeid and s.isdelete = 0 and s.isactive=1 " //不显示加班班次or (s.isactive=0 and s.isovertime=1 and s.updatetime >= sysdate -30)
						+ " order by s.starttime");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("routeid", routeid);
		return query.getResultList();

	}

	@SuppressWarnings("unchecked")
	public List<Object> qryTicketprice(long ticketpriceid) {
		StringBuilder sql = new StringBuilder("select r from Ticketprice r")
				.append(" where r.id = :ticketpriceid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceid", ticketpriceid);
		return query.getResultList();
	}

	// 根据班次计划ID查询已售的停靠站点，防止已售票的票价被删除
	@SuppressWarnings("unchecked")
	public List<Ticketsell> qrySoldTickets(long scheduleplanid, Date departdate) {
		StringBuilder sql = new StringBuilder(
				"select c from Ticketsell c where c.scheduleplanid=:scheduleplanid")
				.append(" and c.departdate=:departdate  and c.ticketstatus='0'");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("departdate", departdate);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Fuelfeegradeapply> qryFuelfeegradeapply(Date departdate,
			long routeid, long vehicletypeid) {
		StringBuilder sql = new StringBuilder("select t ")
				.append(" from Fuelfeegradeapply t where t.routeid=:routeid")
				.append(" and t.fromdate<=:departdate and t.todate>=:departdate")
				.append(" and t.vehicletype.id=:vehicletypeid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("routeid", routeid);
		query.setParameter("vehicletypeid", vehicletypeid);
		List<Fuelfeegradeapply> list = query.getResultList();
		if (list == null || list.size() == 0) {
			sql = new StringBuilder("select t ")
					.append(" from Fuelfeegradeapply t where t.routeid=:routeid")
					.append(" and t.fromdate<=:departdate and t.todate>=:departdate");
			query = getEntityManager().createQuery(sql.toString());
			query.setParameter("departdate", departdate);
			query.setParameter("routeid", routeid);
			return query.getResultList();
		}
		return list;
	}

	@SuppressWarnings("unchecked")
	public BigDecimal qryFuelfeegradedetail(long fuelfeegradeid, long distance) {
		StringBuilder sql = new StringBuilder("select t ")
				.append(" from Fuelfeegradedetail t where t.fuelfeegradeid=:fuelfeegradeid")
				.append(" and t.fromdistance<=:distance and t.todistance>=:distance");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("fuelfeegradeid", fuelfeegradeid);
		query.setParameter("distance", distance);
		List<Fuelfeegradedetail> list = query.getResultList();
		if (list != null && list.size() > 0 && list.get(0).getFee() != null) {
			return list.get(0).getFee();
		} else {
			return new BigDecimal(0);
		}
	}
	
	public List<Routeprice> qryRouteprice(long routeid, Date departdate) {
		StringBuilder sql = new StringBuilder("select rp from Routeprice  rp")
				.append(" where rp.todate>=:departdate and rp.routeid =:routeid")
				.append("    and rp.fromdate<=:departdate and rp.isbaseprice = 0")
				.append("    and rp.fromdate = (select max(rp.fromdate) from Routeprice rp")
				.append("   where rp.todate >=:departdate ")
				.append("     and rp.routeid =:routeid  and rp.fromdate <=:departdate )");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("routeid", routeid);
		List<Routeprice> list = query.getResultList();
		if (list == null || list.size()== 0) {
			sql = new StringBuilder("select rp from Routeprice  rp")
			.append(" where rp.todate>=:departdate and rp.routeid =:routeid")
			.append("  and rp.fromdate<=:departdate  and rp.isbaseprice=1");
			query = getEntityManager().createQuery(sql.toString());
			query.setParameter("departdate", departdate);
			query.setParameter("routeid", routeid);
			list = query.getResultList();
		}
		return list;
	}
	public boolean isexistSchstop(long scheduleid, long stationid) {
		StringBuilder sql = new StringBuilder("select s from Schedulestop  s")
				.append(" where s.isactive=1 and s.issellable=1")
				.append("  and s.schedule.id=:scheduleid  and s.stationid=:stationid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("stationid", stationid);
		query.setParameter("scheduleid", scheduleid);
		List<Schedulestop> list = query.getResultList();
		return list != null &&list.size()>0?true:false;
	}
	@SuppressWarnings("unchecked")
	public BigDecimal actPrice(BigDecimal fullprice, BigDecimal price,
			Date departdate, String tickettype, Schedule schedule) {
		StringBuilder sql = new StringBuilder("select t ")
				.append(" from Ticketdiscount t where t.startdate<=:departdate")
				.append(" and t.enddate>=:departdate and t.datatype=2")
				.append(" and t.tickettype=:tickettype and t.dataid=:dataid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("tickettype", tickettype);
		query.setParameter("dataid", schedule.getId());
		List<Ticketdiscount> list = query.getResultList();
		if (list != null && list.size() > 0) {
			Ticketdiscount td = list.get(0);
			return fullprice.multiply(td.getDefaultdiscountrate()).setScale(0,
					BigDecimal.ROUND_HALF_UP);
		}
		sql = new StringBuilder("select t ")
				.append(" from Ticketdiscount t where t.startdate<=:departdate")
				.append(" and t.enddate>=:departdate and t.datatype=1")
				.append(" and t.tickettype=:tickettype and t.dataid=:dataid");
		query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("tickettype", tickettype);
		query.setParameter("dataid", schedule.getRoute().getId());
		list = query.getResultList();
		if (list != null && list.size() > 0) {
			Ticketdiscount td = list.get(0);
			return fullprice.multiply(td.getDefaultdiscountrate()).setScale(0,
					BigDecimal.ROUND_HALF_UP);
		}
		sql = new StringBuilder("select t ")
				.append(" from Ticketdiscount t where t.startdate<=:departdate")
				.append(" and t.enddate>=:departdate and t.datatype=0")
				.append(" and t.tickettype=:tickettype and t.dataid=:dataid");
		query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("tickettype", tickettype);
		query.setParameter("dataid", schedule.getOrgid());
		list = query.getResultList();
		if (list != null && list.size() > 0) {
			Ticketdiscount td = list.get(0);
			return fullprice.multiply(td.getDefaultdiscountrate()).setScale(0,
					BigDecimal.ROUND_HALF_UP);
		}
		return price;
	}
	
	@SuppressWarnings("unchecked")
	public Scheduleseats findByseatno(long scheduleplanid, short seatno) {
		StringBuffer sql = new StringBuffer(
				"select t from Scheduleseats t where t.scheduleplan.id=:scheduleplanid");
		sql.append(" and t.seatno=:seatno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("seatno", seatno);
		List<Scheduleseats> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}
	public Ticketpriceformulaitem qryTicketpriceformulaitem(long orgid,String code) {
		StringBuffer sql = new StringBuffer(
				"select t from Ticketpriceformulaitem t where t.orgid=:orgid and t.code=:code");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("code", code);
		List<Ticketpriceformulaitem> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	public List<Standardprice> queryStandardprice(long scheduleid,long vehicletypeid) {
		StringBuffer sql = new StringBuffer(
				"select t from Standardprice t where t.scheduleid=:scheduleid and t.vehicletypeid=:vehicletypeid ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("vehicletypeid", vehicletypeid);
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}
	

	public List<Ticketpriceformulaitem> queryticketpriceformulaitem(long orgid) {
		StringBuffer sql = new StringBuffer(
				"select t from Ticketpriceformulaitem t where t.orgid=:orgid ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		return query.getResultList();
	}	
	
	//查询 班次是否长停，是getSchedulelongstop的休整
	public boolean isSchedulelongstop(long scheduleid,
			Date departdate) {
		StringBuilder sql = new StringBuilder(
				"select s from Schedulelongstop s")
				.append(" where s.schedule.id=:scheduleid and s.startdate<=:departdate and s.enddate>=:departdate ");//
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("departdate", departdate);
		List<Schedulelongstop> list = query.getResultList();
//		System.out.println("list.size():=======>"+list.size());
		if(list == null || list.size() < 1){
			return false;
		}else{
			return true;
		}
	}

}
