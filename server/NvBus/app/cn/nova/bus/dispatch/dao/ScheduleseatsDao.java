package cn.nova.bus.dispatch.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.LockModeType;
import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class ScheduleseatsDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select t, o.name as orgname from Scheduleseats t, Organization o where t.orgid=o.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public Scheduleseats findByseatno(Long scheduleplanid, short seatno) {
		StringBuffer sql = new StringBuffer(
				"select t from Scheduleseats t where t.scheduleplan.id=:scheduleplanid");
		sql.append(" and t.seatno=:seatno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("seatno", seatno);
		query.setLockMode(LockModeType.PESSIMISTIC_READ);
		List<Scheduleseats> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	@SuppressWarnings("unchecked")
	public Scheduleseats findSeatnoBySeattype(Long scheduleplanid,
			short seatno, String seattype) {
		StringBuffer sql = new StringBuffer(
				"select t from Scheduleseats t where t.scheduleplan.id=:scheduleplanid");
		sql.append(" and t.seatno=:seatno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("seatno", seatno);
		List<Scheduleseats> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	public Long getScheduleplanid(Long scheduleid, Date departdate) {
		StringBuffer sql = new StringBuffer(
				"select t.id from Scheduleplan t where t.scheduleid=");
		sql.append(scheduleid).append(" and t.departdate=").append(departdate)
				.append(" group by t.seatno");
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return (long) 0;
		}
		return (Long) query.getSingleResult();
	}

	@SuppressWarnings("unchecked")
	public List<Scheduleseats> getScheduleseats(Long scheduleplanid,
			String status) {
		StringBuffer sql = new StringBuffer(
				"select t from Scheduleseats t where t.scheduleplan.id=:scheduleplanid ");
		sql.append(" and t.status in (").append(status);
		sql.append(") order by t.seatno desc");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Scheduleseats> getScheduleseatsBySeattype(Long scheduleplanid,
			String status, String seattype) {
		StringBuffer sql = new StringBuffer(
				"select t from Scheduleseats t where t.scheduleplan.id=:scheduleplanid ");
		if (seattype != null) {
			sql.append(" and t.seattype='" + seattype + "' ");
		}
		sql.append(" and t.status in (").append(status);
		sql.append(") order by t.seatno desc");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Scheduleseats> getScheduleseatsByplanid(Long scheduleplanid) {
		StringBuffer sql = new StringBuffer(
				"select t from Scheduleseats t where t.scheduleplan.id=");
		sql.append(scheduleplanid);
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	public short getSeatno(Long scheduleplanid) {
		StringBuffer sql = new StringBuffer("select nvl(max(s.seatno),0) from ");
		sql.append(" Scheduleseats s where s.scheduleplan.id=:scheduleplanid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		return (Short) query.getSingleResult();
	}

}
