package cn.nova.bus.dispatch.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.model.Schedulemergecancel;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class SchedulemergecancelDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select s,se.code as schedulename,u.name as cancelname,us.name as createname ");
		sql.append(
				" from Schedulemergecancel s, Schedulemerge sc, Scheduleplan sp, Schedule se ,Userinfo u, ")
				.append(" Userinfo us where s.schedulemergeid=sc.id and sc.scheduleplanid=sp.id and ")
				.append(" sp.scheduleid=se.id and s.canceluserid=u.id and s.createby=us.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public Schedulemergecancel getBymergeid(Long schedulemergeid) {
		StringBuffer sql = new StringBuffer(
				"select t from Schedulemergecancel t where t.schedulemergeid=");
		sql.append(schedulemergeid);
		Query query = getEntityManager().createQuery(sql.toString());
		return (Schedulemergecancel) query.getSingleResult();
	}

	public List getSchedulemergecancel(Long schedulemergeid) {
		StringBuffer sql = new StringBuffer(
				"select t from Schedulemergecancel t where t.schedulemergeid=");
		sql.append(schedulemergeid);
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	public Long getSchedulemergecancelid() {
		StringBuffer sql = new StringBuffer(
				"select max(t.id) from Schedulemergecancel t");
		Query query = getEntityManager().createQuery(sql.toString());
		return (Long) query.getSingleResult();
	}

}
