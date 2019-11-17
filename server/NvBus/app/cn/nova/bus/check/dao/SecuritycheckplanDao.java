package cn.nova.bus.check.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.check.model.Securitycheckplan;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class SecuritycheckplanDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select t,v.vehicleno as vehicleno, un.name as unitname, ");
		sql.append(" ve.brandname as modelid, un.id as unitid, (t.startdate + t.period) as nextcheckdate");
		sql.append(" from Securitycheckplan t , Userinfo u, Unit un, Vehicle v, Vehiclebrandmodel ve ");
		sql.append(" where t.createby=u.id and t.vehicleid=v.id and v.unitid=un.id ");
		sql.append(" and v.vehiclebrandmodelid=ve.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public Long getByVehicleid(long vehicleid) {
		StringBuilder sql = new StringBuilder(
				"select s.vehicleid from Securitycheckplan s where s.vehicleid=:vehicleid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("vehicleid", vehicleid);
		if (query.getResultList().size() > 0) {
			return (Long) query.getSingleResult();
		}
		return (long) 0;
	}

	public Securitycheckplan getcheckplan(Long vehicleid) {
		String sql = "select t from Securitycheckplan t where t.vehicleid="
				+ vehicleid;
		Query query = getEntityManager().createQuery(sql);
		if (query.getResultList().size() < 1) {
			return null;
		}
		return (Securitycheckplan) query.getSingleResult();
	}

	public List getcheckplanList(Long vehicleid) {
		String sql = "select t from Securitycheckplan t where t.vehicleid="
				+ vehicleid;
		Query query = getEntityManager().createQuery(sql);
		if (query.getResultList().size() < 1) {
			return null;
		}
		return  query.getResultList();
	}
	
	public boolean isExist(long vehicleid, Date startdate, Date enddate, String type) {
		StringBuffer sql = new StringBuffer(
				"select t from Securitycheckplan t ");
		sql.append(" where t.startdate<=:enddate and t.enddate>=:startdate and t.vehicleid=:vehicleid ");
		if ("0".equals(type)) {
			sql.append(" and t.periodtype=0");
		} else {
			sql.append(" and t.periodtype not in (0) ");
		}
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		query.setParameter("vehicleid", vehicleid);
		if (query.getResultList().isEmpty()) {
			return false;
		}
		return true;
	}

}
