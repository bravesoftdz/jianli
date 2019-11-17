package cn.nova.bus.base.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Schedulevipdiscount;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class SchedulevipdiscountDao extends EntityManagerDaoSurport {

	public boolean isExist(Long discountid, String vipgrade) {
		StringBuilder sql = new StringBuilder(
				"select s from Schedulevipdiscount s where s.schedulediscountid=");
		sql.append(discountid);
		sql.append(" and s.vipgrade=");
		sql.append(vipgrade);
		Query query = getEntityManager().createQuery(sql.toString());
		List list = query.getResultList();
		if (list.isEmpty()) {
			return false;
		}
		return true;
	}

	public String getVipgrade(Long id) {
		StringBuilder sql = new StringBuilder(
				"select t.vipgrade from Schedulevipdiscount t where t.id=");
		sql.append(id);
		Query query = getEntityManager().createQuery(sql.toString());
		return (String) query.getSingleResult();
	}

	public Long getdiscountid(Long id) {
		StringBuilder sql = new StringBuilder(
				"select t.schedulediscountid from Schedulevipdiscount t where t.id=");
		sql.append(id);
		Query query = getEntityManager().createQuery(sql.toString());
		return (Long) query.getSingleResult();
	}

	public List getByid(Long id) {
		StringBuilder sql = new StringBuilder(
				"select t from Schedulevipdiscount t where t.schedulediscountid=");
		sql.append(id);
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select t,u.name as createname, us.name as updatename, sc.code as schedulename ");
		sql.append(" from Schedulevipdiscount t, Userinfo u,Userinfo us, Schedulediscount s, Schedule sc where ");
		sql.append(" t.createby = u.id and t.updateby=us.id and t.schedulediscountid=s.id and s.scheduleid=sc.id");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public Schedulevipdiscount findByid(Long id) {
		StringBuilder sql = new StringBuilder(
				"select t from Schedulevipdiscount t where t.id=");
		sql.append(id);
		Query query = getEntityManager().createQuery(sql.toString());
		return (Schedulevipdiscount) query.getSingleResult();
	}

	public Schedulevipdiscount getByschedulediscountid(Long schedulediscountid,
			String vipgrade) {
		StringBuilder sql = new StringBuilder(
				"select t from Schedulevipdiscount t where t.vipgrade=:vipgrade ");
		sql.append(" and t.schedulediscountid=:schedulediscountid ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("vipgrade", vipgrade);
		query.setParameter("schedulediscountid", schedulediscountid);
		if (query.getResultList().isEmpty()) {
			return null;
		}
		return (Schedulevipdiscount) query.getSingleResult();
	}

}
