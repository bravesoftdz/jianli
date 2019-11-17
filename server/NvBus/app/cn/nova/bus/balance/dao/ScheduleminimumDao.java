package cn.nova.bus.balance.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.balance.model.Scheduleminimum;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class ScheduleminimumDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select t,u.name as createname, us.name as updatename, v.vehicleno as vehicleno, ");
		sql.append(" s.code as schedulename from Scheduleminimum t, Userinfo u, Userinfo us, Vehicle v, ");
		sql.append(" Schedule s where t.createby = u.id and t.updateby=us.id and ");
		sql.append(" t.scheduleid=s.id and t.vehicleid = v.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public List getScheduleminimum(Long scheduleid, Long vehicleid, Long num) {
		StringBuffer sql = new StringBuffer(
				"select t from Scheduleminimum t where t.scheduleid=");
		sql.append(scheduleid);
		sql.append(" and t.vehicleid=");
		sql.append(vehicleid);
		sql.append(" and t.num=");
		sql.append(num);
		Query query = getEntityManager().createQuery(sql.toString());
		List list = query.getResultList();
		return list;
	}

	public Short getVehicleNum(Long vehicleid) {
		StringBuffer sql = new StringBuffer(
				"select t.seatnum from Vehicle t where t.id=:vehicleid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("vehicleid", vehicleid);
		return (Short) query.getSingleResult();
	}

	public Scheduleminimum getScheduleminimum(long scheduleid, long vehicleid){
		StringBuffer sql = new StringBuffer("select t from Scheduleminimum t ")
		.append(" where t.scheduleid=:scheduleid")
		.append(" and t.vehicleid=:vehicleid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("vehicleid", vehicleid);
		List list = query.getResultList();
		return (Scheduleminimum) (list!=null&&list.size()>0?list.get(0):null);
	}

}
