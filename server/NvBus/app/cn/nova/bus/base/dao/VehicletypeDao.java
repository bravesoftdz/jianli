package cn.nova.bus.base.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class VehicletypeDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select t,u.name as createname, us.name as updatename from Vehicletype t ,Userinfo u");
		sql.append(", Userinfo us where t.createby=u.id and t.updateby=us.id and t.isactive=1");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by t.code");
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public boolean checkname(String code, String name) {
		String sql = "select t from Vehicletype t where ";
		if (code == null || "".equals(code)) {
			sql = sql + " t.name='" + name + "'";
		} else if (name == null || "".equals(name)) {
			sql = sql + " t.code='" + code + "'";
		} else {
			sql = sql + " t.name='" + name + "' or t.code='" + code + "'";
		}
		Query query = getEntityManager().createQuery(sql);
		List list = query.getResultList();
		if (list.isEmpty()) {
			return false;
		}
		return true;
	}

	public String getValue(Long id, String value) {
		String sql = "";
		if (value.equals("name")) {
			sql = sql + "select t.name from Vehicletype t where t.id=" + id;
		} else if (value.equals("code")) {
			sql = sql + "select t.code from Vehicletype t where t.id=" + id;
		} else if (value.equals("type")) {
			sql = sql + "select t.type from Vehicletype t where t.id=" + id;
		} else if (value.equals("grade")) {
			sql = sql + "select t.grade from Vehicletype t where t.id=" + id;
		}
		Query query = getEntityManager().createQuery(sql);
		return (String) query.getSingleResult();
	}

	public Long findId(String code) {
		String sql = "select t.id from Vehicletype t where t.isactive=0 and t.code='"
				+ code + "'";
		Query query = getEntityManager().createQuery(sql);
		List list = query.getResultList();
		if (list.isEmpty()) {
			return (long) 0;
		}
		return (Long) query.getSingleResult();
	}

	public boolean isExist(String type, String grade) {
		String sql = "select t from Vehicletype t where ";
		if (type == null || "".equals(type)) {
			sql = sql + " t.grade='" + grade + "'";
		} else if (grade == null || "".equals(grade)) {
			sql = sql + " t.type='" + type + "'";
		} else {
			sql = sql + " t.grade='" + grade + "' and t.type='" + type + "'";
		}
		Query query = getEntityManager().createQuery(sql);
		List list = query.getResultList();
		if (list.isEmpty()) {
			return false;
		}
		return true;
	}

	public Long getIdByName(String name, String value) {
		StringBuffer sql = new StringBuffer("select t.id from Vehicletype t ");
		sql.append(" where t.name=:name");
		if (value != null) {
			sql.append(" and t.isactive=0 ");
		}
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("name", name);
		if (query.getResultList().isEmpty()) {
			return (long) 0;
		}
		return (Long) query.getSingleResult();
	}

	public List getVehicle(long id) {
		StringBuffer sql = new StringBuffer("select t from Vehicle t ");
		sql.append(" where t.vehicletypeid=:id and t.isactive=1 ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("id", id);
		return query.getResultList();
	}

	public Long getIdByCode(String code, String value) {
		StringBuffer sql = new StringBuffer("select t.id from Vehicletype t ");
		sql.append(" where t.code=:code ");
		if (value != null) {
			sql.append(" and t.isactive=0 ");
		}
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("code", code);
		if (query.getResultList().isEmpty()) {
			return (long) 0;
		}
		return (Long) query.getSingleResult();
	}

	public Long getIdByType(String type, String grade, String value, short num) {
		StringBuffer sql = new StringBuffer("select t.id from Vehicletype t ");
		sql.append(" where t.type=:type and t.grade=:grade and t.rationseatnum=:num ");
		if (value != null) {
			sql.append(" and t.isactive=0 ");
		}
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("type", type);
		query.setParameter("grade", grade);
		query.setParameter("num", num);
		if (query.getResultList().isEmpty()) {
			return (long) 0;
		}
		return (Long) query.getSingleResult();
	}

	public List getBrandmodel(long id) {
		StringBuffer sql = new StringBuffer("select t from Vehiclebrandmodel t ");
		sql.append(" where t.vehicletypeid=:id and t.isactive=1 ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("id", id);
		return query.getResultList();
	}

}
