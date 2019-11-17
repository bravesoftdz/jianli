package cn.nova.bus.dispatch.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.LockModeType;

import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Unit;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.base.model.Vehiclebrandmodel;
import cn.nova.bus.base.model.Vehicletype;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.dao.SchedulevehiclepeopleplanDao;
import cn.nova.bus.dispatch.dao.TicketpriceDao;
import cn.nova.bus.dispatch.service.ScheduleplanService;
import cn.nova.bus.dispatch.service.SchedulevehiclepeopleplanService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Schedulevehiclepeopleplan;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;

@SuppressWarnings("unchecked")
public class SchedulevehiclepeopleplanServiceImpl implements
		SchedulevehiclepeopleplanService {

	@SuppressWarnings("rawtypes")

	private IDAO dao = new EntityManagerDaoSurport();
	private SchedulevehiclepeopleplanDao schedulevehiclepeopleplanDao = new SchedulevehiclepeopleplanDao();

	//private TicketpriceDao ticketpricedao = new TicketpriceDao();

	private ScheduleplanService planService = new ScheduleplanServiceImpl();

	@Override
	public boolean save(Schedulevehiclepeopleplan schedulestatus) {
		if (schedulestatus.getId() == 0) {
			return dao.save(schedulestatus);
		} else {
			return dao.update(schedulestatus);
		}
	}

	/**
	 * // 调整计划车型
	 */
	@SuppressWarnings("deprecation")
	@Override
	public boolean savePlanvehicletype(Schedulevehiclepeopleplan peopleplan,
			String ip) throws ServiceException {
		Schedulevehiclepeopleplan schedulepeopleplan = (Schedulevehiclepeopleplan) dao
				.get(LockModeType.PESSIMISTIC_READ,
						Schedulevehiclepeopleplan.class, peopleplan.getId());
		schedulepeopleplan.setPlanvehicletypeid(peopleplan
				.getPlanvehicletypeid());
		schedulepeopleplan.setPlanvehiclebrandmodelid(peopleplan
				.getPlanvehiclebrandmodelid());
		String log = "";
		if (peopleplan.getPlanvehicle() != null) {
			schedulepeopleplan.setPlanvehicle(peopleplan.getPlanvehicle());
			Vehicle vehicle = (Vehicle) schedulevehiclepeopleplanDao.get(
					Vehicle.class, peopleplan.getPlanvehicle().getId());
			Unit unit = (Unit) schedulevehiclepeopleplanDao.get(Unit.class,
					vehicle.getUnitid());
			schedulepeopleplan.setPlanunit(unit);
			schedulepeopleplan.setPlanvehicletypeid(vehicle.getVehicletypeid());
			schedulepeopleplan.setPlanvehiclebrandmodelid(vehicle
					.getVehiclebrandmodelid());
			peopleplan.setPlanvehiclebrandmodelid(vehicle
					.getVehiclebrandmodelid());
			peopleplan.setPlanvehicletypeid(vehicle.getVehicletypeid());
			log = "计划车辆调整为：" + vehicle.getVehicleno() + ",座位数调整为:"
					+ vehicle.getSeatnum();
		} else if (peopleplan.getPlanunit() != null) {
			schedulepeopleplan.setPlanunit(peopleplan.getPlanunit());
			Unit unit = (Unit) schedulevehiclepeopleplanDao.get(Unit.class,
					peopleplan.getPlanunit().getId());
			log = "计划营运单位调整为:" + unit.getName() + ",计划车辆调整为空";
			schedulepeopleplan.setPlanvehicle(null);
		} else {
			schedulepeopleplan.setPlanunit(null);
			schedulepeopleplan.setPlanvehicle(null);
			log = "计划车辆调整为空";
		}

		Vehiclebrandmodel vehiclebrandmodel = (Vehiclebrandmodel) dao.get(
				Vehiclebrandmodel.class,
				peopleplan.getPlanvehiclebrandmodelid());
		peopleplan.setPlanvehicletypeid(vehiclebrandmodel.getVehicletypeid());
		Scheduleplan scheduleplan = (Scheduleplan) dao.get(Scheduleplan.class,
				schedulepeopleplan.getScheduleplan().getId());
		scheduleplan.setSeatnum(vehiclebrandmodel.getRationseatnum());
		scheduleplan.setUpdateby(peopleplan.getUpdateby());
		scheduleplan.setUpdatetime(new Date());
		if (!scheduleplan.getIslinework()) {
			long totalnum = scheduleplan.getAutocancelreserveseatnum()
					+ scheduleplan.getUnautocancelreserveseatnum()
					+ scheduleplan.getFixedreserveseatnum()
					+ scheduleplan.getSoldeatnum();
			if ((scheduleplan.getSeatnum() - totalnum) < 0) {
				throw new ServiceException("0323");
			}
		}
		planService.saveseatnum(scheduleplan, (long) 1, ip,null);// 调整车型后调整相应的座位数

		// 保存日志
		Operationlog operationLog = new Operationlog();
		Schedule schedule = (Schedule) dao.get(Schedule.class,
				schedulepeopleplan.getScheduleid());
		Vehicletype vehicletype = (Vehicletype) dao.get(Vehicletype.class,
				schedulepeopleplan.getPlanvehicletypeid());
		Vehicletype newvehicletype = (Vehicletype) dao.get(Vehicletype.class,
				peopleplan.getPlanvehicletypeid());
		String result = "调整车型,班次号：" + schedule.getCode() + " 发车日期："
				+ DateUtils.formatDate(schedulepeopleplan.getDepartdate())
				+ " 车型由" + vehicletype.getName() + " 调整为："
				+ newvehicletype.getName() + ',' + log;
		operationLog.setIp(ip);
		operationLog.setContent(result);
		operationLog.setModule("综合调度->营运计划调整");
		operationLog.setOperatetime(new Date());
		operationLog.setOperation("调整计划车型");
		operationLog.setSessionid("无session");
		operationLog.setUserid(peopleplan.getUpdateby());
		dao.merge(operationLog);
		return dao.update(schedulepeopleplan);
	}

	/**
	 * // 调整计划司机
	 */
	@Override
	public boolean savePlandriver(Schedulevehiclepeopleplan peopleplan) {
		Schedulevehiclepeopleplan schedulepeopleplan = (Schedulevehiclepeopleplan) dao
				.get(LockModeType.PESSIMISTIC_READ,
						Schedulevehiclepeopleplan.class, peopleplan.getId());
		if (peopleplan.getPlandriver1().getId() > 0) {
			schedulepeopleplan.setPlandriver1(peopleplan.getPlandriver1());
		} else {
			schedulepeopleplan.setPlandriver1(null);
		}
		if (peopleplan.getPlandriver2().getId() > 0) {
			schedulepeopleplan.setPlandriver2(peopleplan.getPlandriver2());
		} else {
			schedulepeopleplan.setPlandriver2(null);
		}
		if (peopleplan.getPlandriver3().getId() > 0) {
			schedulepeopleplan.setPlandriver3(peopleplan.getPlandriver3());
		} else {
			schedulepeopleplan.setPlandriver3(null);
		}
		if (peopleplan.getPlandriver4().getId() > 0) {
			schedulepeopleplan.setPlandriver4(peopleplan.getPlandriver4());
		} else {
			schedulepeopleplan.setPlandriver4(null);
		}
		return dao.update(schedulepeopleplan);
	}

	@Override
	public boolean savePlansteward(Schedulevehiclepeopleplan peopleplan) {// 调整计划乘务员
		Schedulevehiclepeopleplan schedulepeopleplan = (Schedulevehiclepeopleplan) dao
				.get(LockModeType.PESSIMISTIC_READ,
						Schedulevehiclepeopleplan.class, peopleplan.getId());
		if (peopleplan.getPlansteward1().getId() > 0) {
			schedulepeopleplan.setPlansteward1(peopleplan.getPlansteward1());
		} else {
			schedulepeopleplan.setPlansteward1(null);
		}
		if (peopleplan.getPlansteward2().getId() > 0) {
			schedulepeopleplan.setPlansteward2(peopleplan.getPlansteward2());
		} else {
			schedulepeopleplan.setPlansteward2(null);
		}
		return dao.update(schedulepeopleplan);
	}

	@Override
	public boolean savePlanvehicle(Schedulevehiclepeopleplan peopleplan,
			String ip) {// 计划车辆调整
		Schedulevehiclepeopleplan schedulepeopleplan = (Schedulevehiclepeopleplan) dao
				.get(LockModeType.PESSIMISTIC_READ,
						Schedulevehiclepeopleplan.class, peopleplan.getId());
		schedulepeopleplan.setPlanvehicle(peopleplan.getPlanvehicle());

		Operationlog operationLog = new Operationlog();
		Schedule schedule = (Schedule) dao.get(Schedule.class,
				schedulepeopleplan.getScheduleid());
		Vehicle vehicle = (Vehicle) dao.get(Vehicle.class,
				schedulepeopleplan.getId());
		Vehicle newvehicle = (Vehicle) dao.get(Vehicle.class,
				schedulepeopleplan.getId());
		String result = "调整车辆,班次号：" + schedule.getCode() + " 发车日期："
				+ DateUtils.formatDate(schedulepeopleplan.getDepartdate())
				+ " 车辆由" + vehicle.getCardno() + "调整为："
				+ newvehicle.getCardno();
		operationLog.setIp(ip);
		operationLog.setContent(result);
		operationLog.setModule("综合调度->营运计划调整");
		operationLog.setOperatetime(new Date());
		operationLog.setOperation("调整车辆");
		operationLog.setSessionid("无session");
		operationLog.setUserid(schedulepeopleplan.getUpdateby());
		dao.merge(operationLog);

		return dao.update(schedulepeopleplan);
	}

	@Override
	public boolean delete(Schedulevehiclepeopleplan schedulestatus) {
		return dao.delete(schedulestatus);
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Schedulevehiclepeopleplan.class, id);
	}

	@Override
	public List<Schedulevehiclepeopleplan> query() {
		return dao.query(Schedulevehiclepeopleplan.class, null);
	}

	@Override
	public Schedulevehiclepeopleplan getById(Long id) {
		return (Schedulevehiclepeopleplan) dao.get(
				Schedulevehiclepeopleplan.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return null;
	}
}
