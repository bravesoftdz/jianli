package cn.nova.bus.base.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Cycleschemes;
import cn.nova.bus.base.model.Cycleschemesdriver;
import cn.nova.bus.base.model.Cycleschemesschedule;
import cn.nova.bus.base.model.Cycleschemessteward;
import cn.nova.bus.base.model.Cycleschemesvehicle;
import cn.nova.bus.base.model.Schedulecycle;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;


@SuppressWarnings("rawtypes")
public class CycleschemeDao extends EntityManagerDaoSurport {
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder("select distinct u.name as username, ")
				.append(" s.id,s.name,s.startdate,s.enddate,")
				.append(" s.vehicleperiod,s.vehiclestep,s.drivernum,")
				.append(" s.driverperiod,s.driverstep,s.stewardnum,")
				.append(" s.stewardperiod,s.stewardstep,s.createtime,")
				.append(" s.createby,s.updatetime,s.updateby,s.orgid,nvl(s.routeid,ss.routeid) routeid ")
				.append(" from Cycleschemes s  ")
				.append(" LEFT JOIN cycleschemesvehicle cv on cv.cycleschemesid = s.id")
				.append(" LEFT JOIN Cycleschemesschedule sc  ")
				.append(" on sc.cycleschemesid = s.id ")
				.append(" LEFT JOIN Schedule ss on sc.scheduleid=ss.id,Userinfo u")
				.append(" where s.createby=u.id");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by s.name,s.startdate ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public Schedulecycle getSchedulecycle(Schedulecycle schedulecycle) {
		StringBuilder sql = new StringBuilder("select s").append(
				" from Schedulecycle s where  s.type=:type  ").append(
				" and s.cyclescheme = :cyclescheme");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("type", schedulecycle.getType());
		query.setParameter("cyclescheme", schedulecycle.getCyclescheme());
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? (Schedulecycle) list.get(0)
				: null;

	}

	// 在本组中是否已经存在该循环班次
	@SuppressWarnings("unchecked")
	public boolean isExistByschedule(Cycleschemesschedule cycleschemesschedule) {
		if (cycleschemesschedule.getId() == 0) {
			StringBuilder sql = new StringBuilder("select s")
					.append(" from Cycleschemesschedule s where s.scheduleid=:scheduleid")
					.append(" and s.cyclescheme = :cyclescheme");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("scheduleid",
					cycleschemesschedule.getScheduleid());
			query.setParameter("cyclescheme",
					cycleschemesschedule.getCyclescheme());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		} else {
			StringBuilder sql = new StringBuilder("select s")
					.append(" from Cycleschemesschedule s where s.scheduleid=:scheduleid")
					.append(" and s.cyclescheme = :cyclescheme and s.id!=:id");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("id", cycleschemesschedule.getId());
			query.setParameter("scheduleid",
					cycleschemesschedule.getScheduleid());
			query.setParameter("cyclescheme",
					cycleschemesschedule.getCyclescheme());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		}
	}

	// 在其他组中本日期段是否已经存在该循环班次
	@SuppressWarnings("unchecked")
	public boolean isExistOtherByschedule(
			Cycleschemesschedule cycleschemesschedule) {
		Cycleschemes cyclescheme = (Cycleschemes) get(Cycleschemes.class,
				cycleschemesschedule.getCyclescheme().getId());
		StringBuilder sql = new StringBuilder("select s")
				.append(" from Cycleschemesschedule s, Cycleschemes c where s.scheduleid=:scheduleid")
				.append(" and s.cyclescheme != :cyclescheme and s.cyclescheme=c ")
				.append(" and ((c.startdate>=:startdate and c.startdate<=:enddate) ")
				.append(" or (c.startdate<=:startdate and c.enddate>=:enddate)")
				.append(" or (c.startdate<=:startdate and c.enddate>=:startdate)")
				.append(" or (c.startdate>=:startdate and c.enddate<=:enddate))");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", cycleschemesschedule.getScheduleid());
		query.setParameter("cyclescheme", cycleschemesschedule.getCyclescheme());
		query.setParameter("startdate", cyclescheme.getStartdate());
		query.setParameter("enddate", cyclescheme.getEnddate());
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? true : false;
	}

	@SuppressWarnings("unchecked")
	public byte getMaxscheduleOrder(Cycleschemesschedule cycleschemesschedule) {
		StringBuilder sql = new StringBuilder(
				"select MAX(s.orderno) as orderno").append(
				" from Cycleschemesschedule s where ").append(
				"  s.cyclescheme = :cyclescheme");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("cyclescheme", cycleschemesschedule.getCyclescheme());
		List<Object> list = query.getResultList();
		if (list != null && list.size() > 0 && list.get(0) != null) {
			return (Byte) list.get(0);
		}
		return 0;
	}

	// 查询班次循环信息
	@SuppressWarnings("unchecked")
	public List<Object> qryCycleschemesschedule(Cycleschemes cyclescheme) {
		StringBuilder sql = new StringBuilder("select s.id,s.orderno,")
				.append(" d.code, trim(d.starttime) as starttime,s.createtime,s.scheduleid")
				.append(" from Cycleschemesschedule s, Schedule d")
				.append(" where s.scheduleid = d.id and s.cycleschemesid =:cycleschemesid")
				.append(" order by s.orderno, d.starttime");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("cycleschemesid", cyclescheme.getId());
		return query.getResultList();

	}

	@SuppressWarnings("unchecked")
	public List<Object> getSchedule(Cycleschemesschedule cycleschemesschedule) {
		StringBuilder sql = new StringBuilder("select s").append(
				" from Cycleschemesschedule s where  s.orderno>:orderno  ")
				.append(" and s.cyclescheme = :cyclescheme order by s.orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("orderno", cycleschemesschedule.getOrderno());
		query.setParameter("cyclescheme", cycleschemesschedule.getCyclescheme());
		return query.getResultList();

	}

	@SuppressWarnings("unchecked")
	public byte getMaxVehicleOrder(Cycleschemesvehicle cycleschemesvehicle) {
		StringBuilder sql = new StringBuilder(
				"select MAX(s.orderno) as orderno").append(
				" from Cycleschemesvehicle s where ").append(
				"  s.cyclescheme = :cyclescheme");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("cyclescheme", cycleschemesvehicle.getCyclescheme());
		List<Object> list = query.getResultList();
		if (list != null && list.size() > 0 && list.get(0) != null) {
			return (Byte) list.get(0);
		}
		return 0;
	}

	@SuppressWarnings("unchecked")
	public List<Object> getVehicle(Cycleschemesvehicle cycleschemesvehicle) {
		StringBuilder sql = new StringBuilder("select s").append(
				" from Cycleschemesvehicle s where  s.orderno>:orderno  ")
				.append(" and s.cyclescheme = :cyclescheme order by s.orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("orderno", cycleschemesvehicle.getOrderno());
		query.setParameter("cyclescheme", cycleschemesvehicle.getCyclescheme());
		return query.getResultList();

	}

	// 查询循环车辆
	@SuppressWarnings("unchecked")
	public List<Object> qryCycleschemesvehicle(Cycleschemes cyclescheme) {
		StringBuilder sql = new StringBuilder("select s.id,s.orderno,")
				.append(" u.name as unitname,vc.name as vehicletypename,")
				.append(" vm.brandname,v.vehicleno,v.id as vehicleid,s.createtime,")
				.append(" s.unitid,vm.id as brandid,s.vehicletypeid,vm.rationseatnum,vc.customname")
				.append(" from Cycleschemesvehicle s LEFT JOIN Vehicle v ")
				.append(" on s.vehicleid = v.id LEFT JOIN Unit u")
				.append(" on s.unitid=u.id ,")
				.append(" Vehicletype vc,vehiclebrandmodel vm  where ")
				.append(" vm.vehicletypeid = vc.id ")
				.append(" and s.vehiclebrandmodelid = vm.id and s.cycleschemesid =:cycleschemesid")
				.append(" order by s.orderno");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("cycleschemesid", cyclescheme.getId());
		return query.getResultList();

	}

	// 是否已经存在该车辆循环
	@SuppressWarnings("unchecked")
	public boolean isExistByCycleschemesvehicle(
			Cycleschemesvehicle cycleschemesvehicle) {
		if (cycleschemesvehicle.getId() == 0) {
			StringBuilder sql = new StringBuilder("select s")
					.append(" from Cycleschemesvehicle s where s.vehicletypeid=:vehicletypeid")
					.append(" and s.unitid=:unitid and s.cyclescheme = :cyclescheme");

			if (cycleschemesvehicle.getVehicle() != null)
				sql.append(" and s.vehicle=:vehicle");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("vehicletypeid",
					cycleschemesvehicle.getVehicletypeid());
			query.setParameter("cyclescheme",
					cycleschemesvehicle.getCyclescheme());
			//query.setParameter("unitid", cycleschemesvehicle.getUnitid());
			if (cycleschemesvehicle.getVehicle() != null)
				query.setParameter("vehicle", cycleschemesvehicle.getVehicle());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		} else {
			StringBuilder sql = new StringBuilder("select s")
					.append(" from Cycleschemesvehicle s where s.vehicletypeid=:vehicletypeid")
					.append(" and s.unitid=:unitid and s.cyclescheme = :cyclescheme and s.id!=:id");
			if (cycleschemesvehicle.getVehicle() != null)
				sql.append(" and s.vehicle=:vehicle");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("id", cycleschemesvehicle.getId());
			query.setParameter("vehicletypeid",
					cycleschemesvehicle.getVehicletypeid());
			query.setParameter("cyclescheme",
					cycleschemesvehicle.getCyclescheme());
			//query.setParameter("unitid", cycleschemesvehicle.getUnitid());
			if (cycleschemesvehicle.getVehicle() != null)
				query.setParameter("vehicle", cycleschemesvehicle.getVehicle());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		}
	}

	@SuppressWarnings("unchecked")
	public byte getMaxDriverOrder(Cycleschemesdriver cycleschemesdrive) {
		StringBuilder sql = new StringBuilder(
				"select MAX(s.orderno) as orderno").append(
				" from Cycleschemesdriver s where ").append(
				"  s.cyclescheme = :cyclescheme");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("cyclescheme", cycleschemesdrive.getCyclescheme());
		List<Object> list = query.getResultList();
		if (list != null && list.size() > 0 && list.get(0) != null) {
			return (Byte) list.get(0);
		}
		return 0;
	}

	@SuppressWarnings("unchecked")
	public List<Object> getDriver(Cycleschemesdriver cycleschemesdrive) {
		StringBuilder sql = new StringBuilder("select s").append(
				" from Cycleschemesdriver s where  s.orderno>:orderno  ")
				.append(" and s.cyclescheme = :cyclescheme order by s.orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("orderno", cycleschemesdrive.getOrderno());
		query.setParameter("cyclescheme", cycleschemesdrive.getCyclescheme());
		return query.getResultList();

	}

	// 查询循环驾驶员
	@SuppressWarnings("unchecked")
	public List<Object> qryCycleschemesdriver(Cycleschemes cyclescheme) {
		StringBuilder sql = new StringBuilder("select s.id,s.orderno,")
				.append(" d.name as drivername,d.code,s.createtime,s.driverid")
				.append(" from Cycleschemesdriver s,Driver d where  s.driverid=d.id  ")
				.append(" and s.cycleschemesid =:cycleschemesid order by s.orderno,d.name");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("cycleschemesid", cyclescheme.getId());
		return query.getResultList();

	}

	@SuppressWarnings("unchecked")
	public byte getMaxStewardOrder(Cycleschemessteward cycleschemessteward) {
		StringBuilder sql = new StringBuilder(
				"select MAX(s.orderno) as orderno").append(
				" from Cycleschemessteward s where ").append(
				"  s.cyclescheme = :cyclescheme");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("cyclescheme", cycleschemessteward.getCyclescheme());
		List<Object> list = query.getResultList();
		if (list != null && list.size() > 0 && list.get(0) != null) {
			return (Byte) list.get(0);
		}
		return 0;
	}

	@SuppressWarnings("unchecked")
	public List<Object> getSteward(Cycleschemessteward cycleschemessteward) {
		StringBuilder sql = new StringBuilder("select s").append(
				" from Cycleschemessteward s where  s.orderno>:orderno  ")
				.append(" and s.cyclescheme = :cyclescheme order by s.orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("orderno", cycleschemessteward.getOrderno());
		query.setParameter("cyclescheme", cycleschemessteward.getCyclescheme());
		return query.getResultList();

	}

	// 查询循环乘务员
	@SuppressWarnings("unchecked")
	public List<Object> qryCycleschemessteward(Cycleschemes cyclescheme) {
		StringBuilder sql = new StringBuilder("select s.id,s.orderno,")
				.append(" d.name as stewardname,d.code,s.createtime,s.stewardid")
				.append(" from Cycleschemessteward s,Steward d where  s.stewardid=d.id  ")
				.append(" and s.cycleschemesid = :cycleschemesid order by s.orderno,d.name");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("cycleschemesid", cyclescheme.getId());
		return query.getResultList();

	}
	
	
	// 删除班次循环信息
	public int delCycleschemesschedule(Cycleschemes cyclescheme ) {
		StringBuilder sql = new StringBuilder("delete ")
				.append(" from Cycleschemesschedule s")
				.append(" where s.cycleschemesid =:cycleschemesid");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("cycleschemesid", cyclescheme.getId());
		return query.executeUpdate();

	}
	
	// 删除循环车型信息
	public int delCycleschemesvehicle(Cycleschemes cyclescheme ) {
		StringBuilder sql = new StringBuilder("delete ")
				.append(" from Cycleschemesvehicle s")
				.append(" where s.cycleschemesid =:cycleschemesid");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("cycleschemesid", cyclescheme.getId());
		return query.executeUpdate();

	}
	
	
	// 删除循环规则信息
	public int delSchedulecycle(Cycleschemes cyclescheme ) {
		StringBuilder sql = new StringBuilder("delete ")
				.append(" from Schedulecycle s")
				.append(" where s.schemesid =:cycleschemesid");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("cycleschemesid", cyclescheme.getId());
		return query.executeUpdate();

	}
}
