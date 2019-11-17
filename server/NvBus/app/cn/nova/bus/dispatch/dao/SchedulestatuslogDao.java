package cn.nova.bus.dispatch.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.model.Schedulestatuslog;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class SchedulestatuslogDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select t, s.name as schedulename from Schedulestatuslog t, Schedule s where t.scheduleid=s.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public Schedulestatuslog getSchedulestatuslog(Long scheduleid,
			Date departdate) {
		StringBuffer sql = new StringBuffer(
				"select t from Schedulestatuslog t where t.scheduleid=");
		sql.append(scheduleid).append(" and t.departdate=:departdate");
		Query query = getEntityManager().createQuery(sql.toString())
				.setParameter("departdate", departdate);
		return (Schedulestatuslog) query.getSingleResult();
	}

	@SuppressWarnings("unchecked")
	public List<Schedulestatuslog> getstatuslog(Long scheduleid, Date departdate) {
		StringBuffer sql = new StringBuffer(
				"select t from Schedulestatuslog t ");
		sql.append("where t.scheduleid=")
		.append(scheduleid).append(" and t.departdate=:departdate");
		Query query = getEntityManager().createQuery(sql.toString()).setParameter("departdate", departdate);
		return query.getResultList();
	}

}
