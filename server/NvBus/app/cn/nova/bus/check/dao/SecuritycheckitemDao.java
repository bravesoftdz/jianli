package cn.nova.bus.check.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.check.model.Securitycheckitem;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class SecuritycheckitemDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
//		StringBuilder sql = new StringBuilder(
//				"select t, u.name as createname, us.name as updatename from");//原
//		sql.append(" Securitycheckitem t , Userinfo u, Userinfo us where t.createby=u.id and t.updateby=us.id ");//原

		StringBuilder sql = new StringBuilder(
		"select t.id,t.categorycode,t.name,t.describe,t.createtime,t.createby,t.updatetime,t.updateby,t.isroutinecheck, u.name as createname, us.name as updatename ");
        sql.append(" from Securitycheckitem t left join Userinfo u on t.createby=u.id left join Userinfo us on t.updateby=us.id where 1=1 ");
				
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
//		Query query = getEntityManager().createQuery(sql.toString());
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();

	}

	@SuppressWarnings("unchecked")
	public List<Securitycheckitem> getcheckitem(String name, String categorycode) {
		StringBuilder sql = new StringBuilder(
				"select t from Securitycheckitem t where t.name='");
		sql.append(name);
		sql.append("' and t.categorycode='");
		sql.append(categorycode);
		sql.append("'");
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	public Long getId(String name, String categorycode) {
		StringBuilder sql = new StringBuilder(
				"select t.id from Securitycheckitem t where t.name='");
		sql.append(name);
		sql.append("' and t.categorycode='");
		sql.append(categorycode);
		sql.append("'");
		Query query = getEntityManager().createQuery(sql.toString());
		return (Long) query.getSingleResult();
	}

	public List<Object> qrySecuritycheckfeeReport(
			List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT sec.notenum checkno,to_char(sec.checktime,'yyyy-MM-dd') checkdate, ")
		.append(" to_char(sec.checktime,'HH24:mi:ss') checktime,v.vehicleno,o.name orgname,sec.securityfee,u.name checkby ")
		.append(" FROM securitycheck sec  left join vehicle v on v.id = sec.vehicleid left join userinfo u on u.id = sec.checkby ") 
		.append(" left join organization o on o.id = v.orgid where 1=1 ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
}
