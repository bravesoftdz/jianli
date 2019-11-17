package cn.nova.bus.balance.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class BalancescheduleminimumDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select t,u.name as createname, us.name as updatename, v.vehicleno as vehicleno, ");
		sql.append(" s.helpcode as schedulename from Balancescheduleminimum t, Userinfo u, Userinfo us, Vehicle v, ");
		sql.append(" Schedule s where t.createby = u.id and t.updateby=us.id and ");
		sql.append(" t.scheduleid=s.id and t.vehicleid = v.id and v.schedule.id=s.id");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public Date getdepartdate(Long id){
		StringBuffer sql = new StringBuffer("select t.starttime from Schedule t where t.id=");
		sql.append(id);
		Query query = getEntityManager().createQuery(sql.toString());
		return (Date) query.getSingleResult();
	}
}
