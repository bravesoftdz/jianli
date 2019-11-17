package cn.nova.bus.base.dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("unchecked")
public class DistrictDao<District> extends EntityManagerDaoSurport<District> {

	public List<Object> query() {
		List<Object> list = new ArrayList<Object>();
		// 省份
		String sql = "select d.id,d.name,1 as area_level from District d where substring(d.code,3,6)='0000'";
		Query query = getEntityManager().createQuery(sql);
		list.addAll(query.getResultList());
		// 市
		sql = "select d.id,d.name,2 as area_level from District d where substring(d.code,5,6)='00'";
		query = getEntityManager().createQuery(sql);
		list.addAll(query.getResultList());

		sql = "select d.id,r.name 3 as area_level from Station s, District d, Route r"
				+ " where s.districtid=d.id and r.endstationid=s.id";
		query = getEntityManager().createQuery(sql);
		list.addAll(query.getResultList());

		return list;
	}

	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select t,u.name as username,us.name as updatename ");
		sql.append(" from District t ,Userinfo u, Userinfo us ");
		sql.append(" where t.createby=u.id and t.isactive=1 and t.updateby=us.id");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public Long getIdByCode(String code, String string) {
		StringBuffer sql = new StringBuffer(
				"select t.id from District t where t.code=:code ");
		if (string != null) {
			sql.append(" and t.isactive=0 ");
		}
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("code", code);
		if (query.getResultList().isEmpty()) {
			return (long) 0;
		}
		return (Long) query.getSingleResult();
	}

	public Long getIdByName(String name, String string) {
		StringBuffer sql = new StringBuffer(
				"select t.id from District t where t.name=:name ");
		if (string != null) {
			sql.append(" and t.isactive=0 ");
		}
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("name", name);
		if (query.getResultList().isEmpty()) {
			return (long) 0;
		}
		return (Long) query.getSingleResult();
	}

	public Long getIdByFullname(String fullname, String string) {
		StringBuffer sql = new StringBuffer(
				"select t.id from District t where t.fullname=:fullname ");
		if (string != null) {
			sql.append(" and t.isactive=0 ");
		}
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("fullname", fullname);
		if (query.getResultList().isEmpty()) {
			return (long) 0;
		}
		return (Long) query.getSingleResult();
	}
	
	public boolean isContainSta(Long id) {
		//查询区域是否包含站点
		StringBuffer sql = new StringBuffer();
		sql.append(" select d.id  from District d ");
		sql.append(" left join Station s on d.id=s.districtid ");
		sql.append(" where d.id = "+ id );
		sql.append(" and d.isactive=1 and s.isactive=1 ");
		
		Query query = getEntityManager().createNativeQuery(sql.toString());
		//区域是否包含站点返回true，否则返回false
		List<Object> list = query.getResultList();
		if (list.size() != 0) {
			return true;
		} else {
			return false;
		}
	}

}
