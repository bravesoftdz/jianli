package cn.nova.bus.balance.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class VehicleturnoverDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select t,u.name as createname, o.name as orgname,us.name as updatename, v.vehicleno as vehicleno, ");
		sql.append(" ui.name as receivername from Vehicleturnover t, Userinfo u, Organization o, Userinfo us, Vehicle v, ");
		sql.append(" Userinfo ui where t.createby = u.id and t.receiver=ui.id");
		sql.append(" and t.receiptorgid = o.id and t.updateby=us.id and t.vehicleid = v.id");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public List vehicleidUnique(Long vehicleid) {
		StringBuffer sql = new StringBuffer(
				"select t from Vehicleturnover t where t.isbalance=0 and t.vehicleid = ");
		sql.append(vehicleid);
		Query query = getEntityManager().createQuery(sql.toString());
		List list = query.getResultList();
		return list;
	}

}
