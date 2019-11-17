package cn.nova.bus.base.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class InitcardDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select t,u.name as createname, o.name as orgname");
		sql.append(" from Initcard t, Userinfo u, Organization o where t.createby=u.id ");
		sql.append(" and t.orgid=o.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by t.cardno ");
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public boolean isExist(String cardno, String cardtype) {
		String sql = "select t from Initcard t where ";
		if (cardno == null || "".equals(cardno)) {
			sql = sql + " t.cardtype='" + cardtype + "'";
		} else if (cardtype == null || "".equals(cardtype)) {
			sql = sql + " t.cardno='" + cardno + "'";
		} else {
			sql = sql + " t.cardtype='" + cardtype + "' and t.cardno='"
					+ cardno + "'";
		}
		Query query = em.createQuery(sql);
		List list = query.getResultList();
		if (list.isEmpty()) {
			return false;
		}
		return true;
	}

	public Long findById(String serialnumber) {
		String sql = "select t.id from Initcard t where t.serialnumber='"
				+ serialnumber + "'";
		Query query = getEntityManager().createQuery(sql);
		List list = query.getResultList();
		if (list.isEmpty()) {
			return (long) 0;
		}
		return (Long) query.getSingleResult();
	}

	public boolean isExist(String serialnumber) {
		String sql = "select t from Initcard t where ";
		if (serialnumber != null || !"".equals(serialnumber)) {
			sql = sql + " t.serialnumber='" + serialnumber + "'";
		}
		Query query = em.createQuery(sql);
		List list = query.getResultList();
		if (list.isEmpty()) {
			return false;
		}
		return true;
	}

	public Billtype getBilltype(String cardtype) {
		StringBuffer sql = new StringBuffer("select t from Billtype t where ");
		if ("0".equals(cardtype)) {
			sql.append("  t.code='Vehicle'");
		} else if ("1".equals(cardtype)) {
			sql.append("  t.code='Driver'");
		} else if ("2".equals(cardtype)) {
			sql.append("  t.code='Steward'");
		} else if ("3".equals(cardtype)) {
			sql.append("  t.code='Vip'");
		} else if ("4".equals(cardtype)) {
			sql.append("  t.code='Userinfo'");
		} else if ("5".equals(cardtype)) {
			sql.append("  t.code='Unit' ");
		}
		Query query = getEntityManager().createQuery(sql.toString());
		return (Billtype) query.getSingleResult();
	}
}
