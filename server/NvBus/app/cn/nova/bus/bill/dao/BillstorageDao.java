package cn.nova.bus.bill.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.bill.model.Billstorage;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * @author 蒋伟
 * 
 */

public class BillstorageDao extends EntityManagerDaoSurport<Billstorage> {
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder("select b ,o.name as orgname, ");
		sql.append("  u.name as createname from Billstorage b,Organization o, Userinfo u ");
		sql.append(" where b.isactive='1' and b.orgid=o.id and b.createby=u.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public long getByid(String name, String value, String isactive) {
		StringBuilder sql = new StringBuilder("select b.id from Billstorage b ");
		if ("name".equals(name)) {
			sql.append(" where b.name=:value");
		} else if ("code".equals(name)) {
			sql.append(" where b.code=:value");
		}
		if (isactive != null) {
			sql.append(" and b.isactive=0");
		}
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("value", value);
		if (query.getResultList().isEmpty()) {
			return 0;
		}
		return (Long) query.getSingleResult();
	}
}
