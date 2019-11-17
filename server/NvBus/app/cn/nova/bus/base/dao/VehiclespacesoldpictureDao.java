package cn.nova.bus.base.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Vehiclespacesoldpicture;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class VehiclespacesoldpictureDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select t,u.name as createname, us.name as updatename, vs.name as spacename, tt.name as typename,tt.code as tickettypecode ");
		sql.append(" from Vehiclespacesoldpicture t, Userinfo u, Userinfo us, Vehiclespace vs, Tickettype tt where ");
		sql.append(" t.createby = u.id and t.updateby=us.id and t.vehiclespaceid=vs.id and t.ticktypeid=tt.id and t.isactive=1");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public List getList(Long vehiclespaceid, Long ticktypeid) {
		StringBuffer sql = new StringBuffer(
				"select t from Vehiclespacesoldpicture t where t.vehiclespaceid=");
		sql.append(vehiclespaceid);
		sql.append(" and t.ticktypeid=");
		sql.append(ticktypeid);
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	public Vehiclespacesoldpicture getVehiclespace(Long vehiclespaceid,
			Long ticktypeid) {
		StringBuffer sql = new StringBuffer(
				"select t from Vehiclespacesoldpicture t where t.vehiclespaceid=");
		sql.append(vehiclespaceid);
		sql.append(" and t.ticktypeid=");
		sql.append(ticktypeid);
		Query query = getEntityManager().createQuery(sql.toString());
		return (Vehiclespacesoldpicture) query.getSingleResult();
	}

}
