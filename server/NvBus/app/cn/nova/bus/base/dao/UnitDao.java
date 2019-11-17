package cn.nova.bus.base.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class UnitDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select t,u.name as createname, us.name as updatename, ");
		sql.append(" d.name as districtname,d.id as districtid from Unit t ,Userinfo u");
		sql.append(",Userinfo us, District d where t.createby=u.id and t.districtid=d.id ");
		sql.append(" and t.updateby=us.id and t.isactive=1 ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public List getUnitList(String value, String key) {
		String temp = null;
		if (value.equals("name")) {
			temp = " t.name='";
		} else if (value.equals("fullname")) {
			temp = " t.fullname='";
		} else if (value.equals("code")) {
			temp = " t.code='";
		} else if (value.equals("cardno")) {
			temp = " t.cardno='";
		}
		String sql = "select t from Unit t where " + temp + key + "'";
		sql = sql + " and t.isactive=1 ";
		Query query = getEntityManager().createQuery(sql);
		return query.getResultList();
	}

	public List getVehicle(long id) {
		StringBuffer sql = new StringBuffer("select t from Vehicle t ");
		sql.append(" where t.isactive=1 and t.unitid=:id");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("id", id);
		return query.getResultList();
	}

	public List<Object> qryUnitInfo() {
		StringBuffer sql = new StringBuffer("");
		sql.append(" select districtid,code,fullname,contactperson,type from unit u ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}
}
