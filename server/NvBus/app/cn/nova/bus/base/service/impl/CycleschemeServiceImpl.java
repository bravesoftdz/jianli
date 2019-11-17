package cn.nova.bus.base.service.impl;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import cn.nova.bus.base.dao.CycleschemeDao;
import cn.nova.bus.base.model.Cycleschemes;
import cn.nova.bus.base.model.Cycleschemesdriver;
import cn.nova.bus.base.model.Cycleschemesschedule;
import cn.nova.bus.base.model.Cycleschemessteward;
import cn.nova.bus.base.model.Cycleschemesvehicle;
import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Schedulecycle;
import cn.nova.bus.base.model.Vehiclebrandmodel;
import cn.nova.bus.base.service.CycleschemeService;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;


public class CycleschemeServiceImpl implements CycleschemeService {

	private CycleschemeDao cycleschemeDao = new CycleschemeDao();

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "username", "id", "name",
				"startdate", "enddate", "vehicleperiod", "vehiclestep",
				"drivernum", "driverperiod", "driverstep", "stewardnum",
				"stewardperiod", "stewardstep", "createtime", "createby",
				"updatetime", "updateby", "orgid","routeid" },
				cycleschemeDao.query(propertyFilterList), new Object[] {
						String.class, Long.class, String.class, Date.class,
						Date.class, Short.class, Short.class, Short.class,
						Short.class, Short.class, Short.class, Short.class,
						Short.class, Timestamp.class, Long.class,
						Timestamp.class, Long.class, Long.class, Long.class });
	}

	@Override
	public Cycleschemes save(Cycleschemes cyclescheme) throws ServiceException {
		Route route=(Route) cycleschemeDao.get(Route.class, cyclescheme.getRouteid());
		cyclescheme.setOrgid(route.getOrgid());
		return cycleschemeDao.getEntityManager().merge(cyclescheme);
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean delCyclescheme(Cycleschemes cyclescheme)
			throws ServiceException {
		Cycleschemes obj = (Cycleschemes) cycleschemeDao.get(				
				Cycleschemes.class, cyclescheme.getId());
		//查询循环驾驶员 ,循环乘务员
		if(cycleschemeDao.qryCycleschemesdriver(cyclescheme).size()>0 ||
			cycleschemeDao.qryCycleschemessteward(cyclescheme).size()>0){
			return false;
		}
		cycleschemeDao.delSchedulecycle(cyclescheme);
		cycleschemeDao.delCycleschemesvehicle(cyclescheme);
		//删除循环班次
		cycleschemeDao.delCycleschemesschedule(cyclescheme);
		/*if (schedulecycles.size() > 0) {
			throw new ServiceException("0039");
		}*/
		cycleschemeDao.delete(obj);
		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> qrySchedulecycle(Cycleschemes cyclescheme) {
		if (cyclescheme == null) {
			List<Object> cycleschemelist = new ArrayList<Object>();
			Object[] obj = new Object[] { 1, true };
			cycleschemelist.add(obj);
			return ListUtil.listToMap(new Object[] { "status" },
					cycleschemelist, new Object[] { boolean.class });
		} else {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("type", "0");
			map.put("cyclescheme", cyclescheme);
			List<Schedulecycle> list = cycleschemeDao.find(Schedulecycle.class,
					map);
			if (list.size() > 0) {
				Schedulecycle schedulecycle = list.get(0);
				String rules = schedulecycle.getRule();
				char[] rule = rules.toCharArray();
				List<Object> cycleschemelist = new ArrayList<Object>();
				for (char c : rule) {
					if (c == '1') {
						Object[] obj = new Object[] { true };
						cycleschemelist.add(obj);
					} else {
						Object[] obj = new Object[] { false };
						cycleschemelist.add(obj);
					}
				}
				return ListUtil.listToMap(new Object[] { "status" },
						cycleschemelist, new Object[] { boolean.class });
			} else {
				List<Object> cycleschemelist = new ArrayList<Object>();
				Object[] obj = new Object[] { true };
				cycleschemelist.add(obj);
				return ListUtil.listToMap(new Object[] { "status" },
						cycleschemelist, new Object[] { boolean.class });
			}
		}
	}

	// 循环规则
	@Override
	public boolean saveSchedulecycle(Schedulecycle schedulecycle)
			throws ServiceException {
		Schedulecycle oldschedulecycle = cycleschemeDao
				.getSchedulecycle(schedulecycle);
		if (oldschedulecycle == null) {
			cycleschemeDao.getEntityManager().persist(schedulecycle);
		} else {
			oldschedulecycle.setRule(schedulecycle.getRule());
			cycleschemeDao.getEntityManager().merge(oldschedulecycle);
		}
		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> qrySchedulecycles(Cycleschemes cyclescheme) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cyclescheme", cyclescheme);
		return ListUtil.listToMap(new Object[] { Schedulecycle.class },
				cycleschemeDao.find(Schedulecycle.class, map),
				new Object[] { Schedulecycle.class });

	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean delSchedulecycle(Schedulecycle schedulecycle)
			throws ServiceException {
		Schedulecycle obj = (Schedulecycle) cycleschemeDao.get(
				Schedulecycle.class, schedulecycle.getId());
		cycleschemeDao.delete(obj);
		return true;
	}

	// 查询班次循环信息
	@Override
	public List<Map<String, Object>> qryCycleschemesschedule(
			Cycleschemes cyclescheme) {
		return ListUtil.listToMap(new Object[] { "id", "orderno", "helpcode",
				"starttime", "createtime", "scheduleid" },
				cycleschemeDao.qryCycleschemesschedule(cyclescheme),
				new Object[] { Long.class, Short.class, String.class,
						String.class, Timestamp.class, Long.class });
	}

	// 保存循环班次
	@Override
	public boolean saveCycleschemesschedule(
			Cycleschemesschedule cycleschemesschedule, Long types) throws ServiceException {
		/*if (cycleschemeDao.isExistByschedule(cycleschemesschedule)) {
			throw new ServiceException("0040");
		}
		if (cycleschemeDao.isExistOtherByschedule(cycleschemesschedule)) {
			throw new ServiceException("0041");
		}*/
		boolean flag = false;
		byte orderno = 1;
		//判断操作，types为0是修改，1为添加。
		if (types == 0L){
			cycleschemeDao.delCycleschemesschedule(cycleschemesschedule.getCyclescheme());
			cycleschemeDao.getEntityManager().flush();
		}else{
			orderno=(byte)(cycleschemeDao.qryCycleschemesschedule(cycleschemesschedule.getCyclescheme()).size()+1);
		}
		
		//cycleschemeDao.delCycleschemesschedule(cycleschemesschedule.getCyclescheme());
		//cycleschemeDao.getEntityManager().flush();
		String[] scheduleidlist = cycleschemesschedule.getScheduleids().split(",");
		//byte orderno = 1;
		for(String schduleid : scheduleidlist){
			long curscheduleid = Long.valueOf(schduleid);
			Cycleschemesschedule cs = new Cycleschemesschedule();
			cs.setCreateby(cycleschemesschedule.getCreateby());
			cs.setCreatetime(new Date());
			cs.setCyclescheme(cycleschemesschedule.getCyclescheme());
			cs.setOrderno(orderno ++);
			cs.setScheduleid(curscheduleid);
			cs.setUpdateby(cycleschemesschedule.getCreateby());
			cs.setUpdatetime(new Date());
			if(cycleschemeDao.isExistByschedule(cs)){
				flag = false;
				break;
			}else{
				flag = cycleschemeDao.save(cs);
			}
			
			
//			orderno=(byte) (orderno+1);
		}
		/*
		if (cycleschemesschedule.getId() == 0) {
			Byte orderno = cycleschemeDao
					.getMaxscheduleOrder(cycleschemesschedule);
			orderno = (byte) (orderno + 1);
			cycleschemesschedule.setOrderno(orderno);
			cycleschemeDao.getEntityManager().persist(cycleschemesschedule);
		} else {
			cycleschemeDao.getEntityManager().merge(cycleschemesschedule);
		}*/
		return flag;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean delCycleschemesschedule(
			Cycleschemesschedule cycleschemesschedule) throws ServiceException {
		Cycleschemesschedule entity = (Cycleschemesschedule) cycleschemeDao
				.get(Cycleschemesschedule.class, cycleschemesschedule.getId());
		Byte orderno = entity.getOrderno();
		List<Object> list = cycleschemeDao.getSchedule(entity);
		cycleschemeDao.delete(entity);
		for (int i = 0; i < list.size(); i++) {
			Cycleschemesschedule next = (Cycleschemesschedule) list.get(i);
			next.setOrderno((byte) (orderno + i));
			next.setUpdatetime(new Date());
			cycleschemeDao.merge(next);
		}
		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean nextCycleschemesschedule(
			Cycleschemesschedule cycleschemesschedule) throws ServiceException {
		Cycleschemesschedule curentity = (Cycleschemesschedule) cycleschemeDao
				.get(Cycleschemesschedule.class, cycleschemesschedule.getId());
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("orderno", (byte) (curentity.getOrderno() + 1));
		map.put("cyclescheme", curentity.getCyclescheme());
		List<Object> list = cycleschemeDao
				.find(Cycleschemesschedule.class, map);
		Byte curorderno = curentity.getOrderno();
		Cycleschemesschedule nextentity = (Cycleschemesschedule) list.get(0);
		curentity.setOrderno((byte) (curorderno + 1));
		nextentity.setOrderno(curorderno);
		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean priorCycleschemesschedule(
			Cycleschemesschedule cycleschemesschedule) throws ServiceException {
		Cycleschemesschedule curentity = (Cycleschemesschedule) cycleschemeDao
				.get(Cycleschemesschedule.class, cycleschemesschedule.getId());
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("orderno", (byte) (curentity.getOrderno() - 1));
		map.put("cyclescheme", curentity.getCyclescheme());
		List<Object> list = cycleschemeDao
				.find(Cycleschemesschedule.class, map);
		Byte curorderno = curentity.getOrderno();
		Cycleschemesschedule priorentity = (Cycleschemesschedule) list.get(0);
		curentity.setOrderno((byte) (curorderno - 1));
		priorentity.setOrderno(curorderno);
		return true;
	}

	// 循环车辆
	@Override
	public List<Map<String, Object>> qryCycleschemesvehicle(
			Cycleschemes cyclescheme) {
		return ListUtil.listToMap(new Object[] { "id", "orderno", "unitname",
				"vehicletypename", "brandname", "vehicleno", "vehicleid",
				"createtime", "unitid" ,"brandid","vehicletypeid","rationseatnum","customname"},
				cycleschemeDao.qryCycleschemesvehicle(cyclescheme),
				new Object[] { Long.class, Short.class, String.class,
						String.class, String.class, String.class, Long.class,
						Timestamp.class, Long.class , Long.class , Long.class,
						Short.class, String.class});
	}

	@Override
	public boolean saveCycleschemesvehicle(
			Cycleschemesvehicle cycleschemesvehicle) throws ServiceException {
		/*if (cycleschemeDao.isExistByCycleschemesvehicle(cycleschemesvehicle)) {
			throw new ServiceException("0042");
		}*/
		Vehiclebrandmodel vb=(Vehiclebrandmodel) cycleschemeDao.get(Vehiclebrandmodel.class,cycleschemesvehicle.getVehiclebrandmodelid());
		cycleschemesvehicle.setVehicletypeid(vb.getVehicletypeid());
		if (cycleschemesvehicle.getId() == 0) {
			Byte orderno = cycleschemeDao
					.getMaxVehicleOrder(cycleschemesvehicle);
			orderno = (byte) (orderno + 1);
			cycleschemesvehicle.setOrderno(orderno);
			cycleschemeDao.getEntityManager().persist(cycleschemesvehicle);
		} else {
			cycleschemeDao.getEntityManager().merge(cycleschemesvehicle);
		}
		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean delCycleschemesvehicle(
			Cycleschemesvehicle cycleschemesvehicle) throws ServiceException {
		Cycleschemesvehicle entity = (Cycleschemesvehicle) cycleschemeDao.get(
				Cycleschemesvehicle.class, cycleschemesvehicle.getId());
		Byte orderno = entity.getOrderno();
		List<Object> list = cycleschemeDao.getVehicle(entity);
		cycleschemeDao.delete(entity);
		for (int i = 0; i < list.size(); i++) {
			Cycleschemesvehicle next = (Cycleschemesvehicle) list.get(i);
			next.setOrderno((byte) (orderno + i));
			next.setUpdatetime(new Date());
			cycleschemeDao.merge(next);
		}
		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean nextCycleschemesvehicle(
			Cycleschemesvehicle cycleschemesvehicle) throws ServiceException {
		Cycleschemesvehicle curentity = (Cycleschemesvehicle) cycleschemeDao
				.get(Cycleschemesvehicle.class, cycleschemesvehicle.getId());
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("orderno", (byte) (curentity.getOrderno() + 1));
		map.put("cyclescheme", curentity.getCyclescheme());
		List<Object> list = cycleschemeDao.find(Cycleschemesvehicle.class, map);
		Byte curorderno = curentity.getOrderno();
		Cycleschemesvehicle nextentity = (Cycleschemesvehicle) list.get(0);
		curentity.setOrderno((byte) (curorderno + 1));
		nextentity.setOrderno(curorderno);
		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean priorCycleschemesvehicle(
			Cycleschemesvehicle cycleschemesvehicle) throws ServiceException {
		Cycleschemesvehicle curentity = (Cycleschemesvehicle) cycleschemeDao
				.get(Cycleschemesvehicle.class, cycleschemesvehicle.getId());
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("orderno", (byte) (curentity.getOrderno() - 1));
		map.put("cyclescheme", curentity.getCyclescheme());
		List<Object> list = cycleschemeDao.find(Cycleschemesvehicle.class, map);
		Byte curorderno = curentity.getOrderno();
		Cycleschemesvehicle priorentity = (Cycleschemesvehicle) list.get(0);
		curentity.setOrderno((byte) (curorderno - 1));
		priorentity.setOrderno(curorderno);
		return true;
	}

	// 循环驾驶员
	@Override
	public List<Map<String, Object>> qryCycleschemesdrive(
			Cycleschemes cyclescheme) {
		return ListUtil.listToMap(new Object[] { "id", "orderno", "drivername",
				"code", "createtime", "driverid" },
				cycleschemeDao.qryCycleschemesdriver(cyclescheme),
				new Object[] { Long.class, Short.class, String.class,
						String.class, Timestamp.class, Long.class });
	}

	@Override
	public boolean saveCycleschemesdrive(Cycleschemesdriver cycleschemesdrive)
			throws ServiceException {
		if (cycleschemesdrive.getId() == 0) {
			Byte orderno = cycleschemeDao.getMaxDriverOrder(cycleschemesdrive);
			orderno = (byte) (orderno + 1);
			cycleschemesdrive.setOrderno(orderno);
		}
		cycleschemeDao.getEntityManager().merge(cycleschemesdrive);
		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean delCycleschemesdrive(Cycleschemesdriver cycleschemesdrive)
			throws ServiceException {
		Cycleschemesdriver entity = (Cycleschemesdriver) cycleschemeDao.get(
				Cycleschemesdriver.class, cycleschemesdrive.getId());
		Byte orderno = entity.getOrderno();
		List<Object> list = cycleschemeDao.getDriver(entity);
		cycleschemeDao.delete(entity);
		for (int i = 0; i < list.size(); i++) {
			Cycleschemesdriver next = (Cycleschemesdriver) list.get(i);
			next.setOrderno((byte) (orderno + i));
			next.setUpdatetime(new Date());
			cycleschemeDao.merge(next);
		}
		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean nextCycleschemesdrive(Cycleschemesdriver cycleschemesdrive)
			throws ServiceException {
		Cycleschemesdriver curentity = (Cycleschemesdriver) cycleschemeDao.get(
				Cycleschemesdriver.class, cycleschemesdrive.getId());
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("orderno", (byte) (curentity.getOrderno() + 1));
		map.put("cyclescheme", curentity.getCyclescheme());
		List<Object> list = cycleschemeDao.find(Cycleschemesdriver.class, map);
		Byte curorderno = curentity.getOrderno();
		Cycleschemesdriver nextentity = (Cycleschemesdriver) list.get(0);
		curentity.setOrderno((byte) (curorderno + 1));
		nextentity.setOrderno(curorderno);
		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean priorCycleschemesdrive(Cycleschemesdriver cycleschemesdrive)
			throws ServiceException {
		Cycleschemesdriver curentity = (Cycleschemesdriver) cycleschemeDao.get(
				Cycleschemesdriver.class, cycleschemesdrive.getId());
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("orderno", (byte) (curentity.getOrderno() - 1));
		map.put("cyclescheme", curentity.getCyclescheme());
		List<Object> list = cycleschemeDao.find(Cycleschemesdriver.class, map);
		Byte curorderno = curentity.getOrderno();
		Cycleschemesdriver priorentity = (Cycleschemesdriver) list.get(0);
		curentity.setOrderno((byte) (curorderno - 1));
		priorentity.setOrderno(curorderno);
		return true;
	}

	// 循环乘务员
	@Override
	public List<Map<String, Object>> qryCycleschemessteward(
			Cycleschemes cyclescheme) {
		return ListUtil.listToMap(new Object[] { "id", "orderno",
				"stewardname", "code", "createtime", "stewardid" },
				cycleschemeDao.qryCycleschemessteward(cyclescheme),
				new Object[] { Long.class, Short.class, String.class,
						String.class, Timestamp.class, Long.class });
	}

	@Override
	public boolean saveCycleschemessteward(
			Cycleschemessteward cycleschemessteward) throws ServiceException {
		if (cycleschemessteward.getId() == 0) {
			Byte orderno = cycleschemeDao
					.getMaxStewardOrder(cycleschemessteward);
			orderno = (byte) (orderno + 1);
			cycleschemessteward.setOrderno(orderno);
		}
		cycleschemeDao.getEntityManager().merge(cycleschemessteward);
		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean delCycleschemessteward(
			Cycleschemessteward cycleschemessteward) throws ServiceException {
		Cycleschemessteward entity = (Cycleschemessteward) cycleschemeDao.get(
				Cycleschemessteward.class, cycleschemessteward.getId());
		Byte orderno = entity.getOrderno();
		List<Object> list = cycleschemeDao.getSteward(entity);
		cycleschemeDao.delete(entity);
		for (int i = 0; i < list.size(); i++) {
			Cycleschemessteward next = (Cycleschemessteward) list.get(i);
			next.setOrderno((byte) (orderno + i));
			next.setUpdatetime(new Date());
			cycleschemeDao.merge(next);
		}
		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean nextCycleschemessteward(
			Cycleschemessteward cycleschemessteward) throws ServiceException {
		Cycleschemessteward curentity = (Cycleschemessteward) cycleschemeDao
				.get(Cycleschemessteward.class, cycleschemessteward.getId());
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("orderno", (byte) (curentity.getOrderno() + 1));
		map.put("cyclescheme", curentity.getCyclescheme());
		List<Object> list = cycleschemeDao.find(Cycleschemessteward.class, map);
		Byte curorderno = curentity.getOrderno();
		Cycleschemessteward nextentity = (Cycleschemessteward) list.get(0);
		curentity.setOrderno((byte) (curorderno + 1));
		nextentity.setOrderno(curorderno);
		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean priorCycleschemessteward(
			Cycleschemessteward cycleschemessteward) throws ServiceException {
		Cycleschemessteward curentity = (Cycleschemessteward) cycleschemeDao
				.get(Cycleschemessteward.class, cycleschemessteward.getId());
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("orderno", (byte) (curentity.getOrderno() - 1));
		map.put("cyclescheme", curentity.getCyclescheme());
		List<Object> list = cycleschemeDao.find(Cycleschemessteward.class, map);
		Byte curorderno = curentity.getOrderno();
		Cycleschemessteward priorentity = (Cycleschemessteward) list.get(0);
		curentity.setOrderno((byte) (curorderno - 1));
		priorentity.setOrderno(curorderno);
		return true;
	}
}
