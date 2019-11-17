package cn.nova.bus.price.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.price.model.Fuelfeegrade;
import cn.nova.bus.price.model.Fuelfeegradeapply;
import cn.nova.bus.price.model.Fuelfeegradedetail;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class FuelfeegradeDao extends EntityManagerDaoSurport {
	@SuppressWarnings("unchecked")
	public List<Fuelfeegrade> qryFuelfeegrade(
			List<PropertyFilter> propertyFilters) {
		StringBuilder sql = new StringBuilder("select t ")
				.append(" from Fuelfeegrade t where 1=1");
		sql.append(PropertyFilter.toJpql(propertyFilters, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> qryFuelfeegrades(String orgids) {
		StringBuilder sql = new StringBuilder("select t,u1.name as createname,")
				.append(" u2.name as updatename,o.name as orgname")
				.append(" from Fuelfeegrade t,Userinfo u1,Userinfo u2, ")
				.append(" Organization o where t.orgid in " + orgids)
				.append(" and t.createby=u1.id and t.updateby=u2.id ")
				.append(" and t.orgid=o.id");
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> qryFuelfeegrades(long orgid) {
		StringBuilder sql = new StringBuilder("select t").append(
				" from Fuelfeegrade t ").append(" where t.orgid=:orgid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Fuelfeegradeapply> qryFuelfeegradeapply(
			List<PropertyFilter> propertyFilters) {
		StringBuilder sql = new StringBuilder("select t ")
				.append(" from Fuelfeegradeapply t where 1=1");
		sql.append(PropertyFilter.toJpql(propertyFilters, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Fuelfeegradedetail> qryFuelfeegradedetail(
			List<PropertyFilter> propertyFilters) {
		StringBuilder sql = new StringBuilder("select t ")
				.append(" from Fuelfeegradedetail t where 1=1");
		sql.append(PropertyFilter.toJpql(propertyFilters, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> qryFuelfeegradedetail(long fuelfeegradeid) {
		StringBuilder sql = new StringBuilder("select t,u1.name as createname,")
				.append(" u2.name as updatename")
				.append(" from Fuelfeegradedetail t,Userinfo u1,Userinfo u2")
				.append(" where t.fuelfeegradeid=:fuelfeegradeid")
				.append(" and t.createby=u1.id and t.updateby=u2.id ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("fuelfeegradeid", fuelfeegradeid);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> qryFuelfeegradeapplys(
			List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder("select t.id,t.fuelfeegradeid,t.fromdate,t.todate,t.routeid,")
				.append(" t.createby,t.createtime,t.updateby,t.updatetime,u1.name as createname,")
				.append(" u2.name as updatename,r.name as routename,f.grade,vt.name as vehicletypename,vt.id as vehicletypeid")
				.append(" from Fuelfeegradeapply t LEFT JOIN Vehicletype vt on t.vehicletypeid=vt.id,Userinfo u1,Userinfo u2, ")
				.append(" Route r,Fuelfeegrade f where ")
				.append(" t.createby=u1.id and t.updateby=u2.id ")
				.append(" and t.routeid=r.id and t.fuelfeegradeid=f.id");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public boolean isExistFuelfeegradedetail(
			Fuelfeegradedetail fuelfeegradedetail) {
		StringBuilder sql = new StringBuilder("select t ")
				.append(" from Fuelfeegradedetail t where t.fuelfeegradeid=:fuelfeegradeid")
				.append(" and ((t.fromdistance>=:fromdistance and t.fromdistance<=:todistance)")
				.append(" or (t.fromdistance<=:fromdistance and t.todistance>=:todistance)")
				.append(" or (t.todistance>=:fromdistance and t.todistance<=:todistance)")
				.append(" or (t.fromdistance>=:fromdistance and t.todistance<=:todistance))");
		if (fuelfeegradedetail.getId() > 0) {
			sql.append(" and t.id!=" + fuelfeegradedetail.getId());
		}
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("fuelfeegradeid",
				fuelfeegradedetail.getFuelfeegradeid());
		query.setParameter("fromdistance", fuelfeegradedetail.getFromdistance());
		query.setParameter("todistance", fuelfeegradedetail.getTodistance());

		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 && list.get(0) != null ? true
				: false;
	}

	@SuppressWarnings("unchecked")
	public boolean isExistFuelfeegradeapply(Fuelfeegradeapply fuelfeegradeapply) {
		StringBuilder sql = null;
		if (fuelfeegradeapply.getVehicletype() == null) {
			sql = new StringBuilder("select t ")
					.append(" from Fuelfeegradeapply t where t.routeid=:routeid")
					.append(" and ((t.fromdate>=:fromdate and t.fromdate<=:todate)")
					.append(" or (t.fromdate<=:fromdate and t.todate>=:todate)")
					.append(" or (t.todate>=:fromdate and t.todate<=:todate)")
					.append(" or (t.fromdate>=:fromdate and t.todate<=:todate))");
			if (fuelfeegradeapply.getId() > 0) {
				sql.append(" and t.id!=" + fuelfeegradeapply.getId());
			}
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("fromdate", fuelfeegradeapply.getFromdate());
			query.setParameter("todate", fuelfeegradeapply.getTodate());
			query.setParameter("routeid", fuelfeegradeapply.getRouteid());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 && list.get(0) != null ? true
					: false;			
		} else {
			sql = new StringBuilder("select t ")
					.append(" from Fuelfeegradeapply t where t.routeid=:routeid")
					.append(" and ((t.fromdate>=:fromdate and t.fromdate<=:todate)")
					.append(" or (t.fromdate<=:fromdate and t.todate>=:todate)")
					.append(" or (t.todate>=:fromdate and t.todate<=:todate)")
					.append(" or (t.fromdate>=:fromdate and t.todate<=:todate))")
					.append(" and t.vehicletype.id=:vehicletypeid");
			if (fuelfeegradeapply.getId() > 0) {
				sql.append(" and t.id!=" + fuelfeegradeapply.getId());
			}
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("fromdate", fuelfeegradeapply.getFromdate());
			query.setParameter("todate", fuelfeegradeapply.getTodate());
			query.setParameter("routeid", fuelfeegradeapply.getRouteid());
			query.setParameter("vehicletypeid", fuelfeegradeapply.getVehicletype().getId());			
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 && list.get(0) != null ? true
					: false;			
		}

	}

	@SuppressWarnings("unchecked")
	public List<Object> qryRoutes(long orgid) {
		StringBuilder sql = new StringBuilder(
				"select 1 as selected,t.id,t.name,t.jianpin")
				.append(" from Route t ")
				.append(" where t.orgid=:orgid and t.isactive=1 ")
				.append(" order by t.name");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		return query.getResultList();
	}
}
