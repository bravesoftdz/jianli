package cn.nova.bus.base.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Digitaldictionarydetail;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class SchedulediscountDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select t,r.code as code, r.name as name, s.code as helpcode, ");
		sql.append("s.starttime as starttime, st.name as endstationid, r.id as routeid, ");
		sql.append("org.name as orgname, s.id as scheduleid ");
		sql.append(" from Schedulediscount t , Userinfo u, Route r, ");
		sql.append("Schedule s, Organization org, Station st where t.createby=u.id and t.scheduleid=s.id and ");
		sql.append("s.route.id=r.id and t.orgid=org.id and r.endstationid=st.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();

	}

	@SuppressWarnings("unchecked")
	public List<Digitaldictionarydetail> queryvipdiscount() {
		StringBuilder sql = new StringBuilder(
				"select t from Digitaldictionarydetail t where ");
		sql.append(" t.digitaldictionary.id='38'");
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	public Long getSchedulediscountId() {
		StringBuilder sql = new StringBuilder(
				"select max(s.id) from Schedulediscount s");
		Query query = getEntityManager().createQuery(sql.toString());
		return (Long) query.getSingleResult();
	}

	public Long getId(Long scheduleid, Date startdate, Date enddate) {
		StringBuilder sql = new StringBuilder(
				"select t.id from Schedulediscount t where t.scheduleid=");
		sql.append(scheduleid);
		sql.append(" and t.startdate=");
		sql.append(startdate);
		sql.append(" and t.enddate=");
		sql.append(enddate);
		Query query = getEntityManager().createQuery(sql.toString());
		return (Long) query.getSingleResult();
	}

	public Long getSeheduleid(String routeid, String code) {
		String sql = "select s.id from Schedule s, Route r where s.route.id=r.id and ";
		sql = sql + "r.id='" + routeid + "' and s.code='" + code + "'";
		Query query = em.createQuery(sql);
		return (Long) query.getSingleResult();
	}

}
