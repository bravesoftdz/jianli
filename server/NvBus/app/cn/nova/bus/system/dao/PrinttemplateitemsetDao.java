package cn.nova.bus.system.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Printtemplateitemset;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")

public class PrinttemplateitemsetDao extends EntityManagerDaoSurport {
	@SuppressWarnings("unchecked")
	public List<Object> qryPrinttemplateitemset(
			List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select ps,pt.itemname,v.vehicleno,")
				.append(" u1.name as createdname,u2.name as updatedname,")
				.append(" p.name as templatename,p.id as printtemplatetypeid")
				.append(" from Printtemplateitemset  ps,")
				.append(" Printtemplatetypeitem pt,Vehicle  v,Printtemplatetype p,")
				.append(" Userinfo u1, Userinfo u2")
				.append(" where ps.printtemplatetypeitemid = pt.id and ps.vehicleid = v.id")
				.append(" and pt.printtemplatetype=p")
				.append(" and ps.createby = u1.id and ps.updateby = u2.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> qryPrinttemplateitemset(long orgid, long vehicleid,
			String templatename) {
		StringBuilder sql = new StringBuilder(
				"select pt.itemcode  from Printtemplateitemset  ps,")
				.append(" Printtemplatetypeitem pt,Printtemplatetype p")
				.append(" where ps.printtemplatetypeitemid=pt.id")
				.append(" and pt.printtemplatetypeid=p.id")
				.append(" and p.name=:templatename")
				.append(" and ps.vehicleid=:vehicleid and ps.orgid=:orgid ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("vehicleid", vehicleid);
		query.setParameter("templatename", templatename);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public boolean isExistPrinttemplateitemset(
			Printtemplateitemset printtemplateitemset) {
		if (printtemplateitemset.getId() == 0) {
			StringBuilder sql = new StringBuilder(
					"select h from Printtemplateitemset h where h.printtemplatetypeitemid=:printtemplatetypeitemid")
					.append(" and h.orgid=:orgid").append(
							" and h.vehicleid=:vehicleid ");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("printtemplatetypeitemid",
					printtemplateitemset.getPrinttemplatetypeitemid());
			query.setParameter("orgid", printtemplateitemset.getOrgid());
			query.setParameter("vehicleid", printtemplateitemset.getVehicleid());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		} else {
			StringBuilder sql = new StringBuilder(
					"select h from Printtemplateitemset h where h.printtemplatetypeitemid=:printtemplatetypeitemid")
					.append(" and h.orgid=:orgid").append(
							" and h.vehicleid=:vehicleid and h.id!=:id");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("printtemplatetypeitemid",
					printtemplateitemset.getPrinttemplatetypeitemid());
			query.setParameter("orgid", printtemplateitemset.getOrgid());
			query.setParameter("vehicleid", printtemplateitemset.getVehicleid());
			query.setParameter("id", printtemplateitemset.getId());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;

		}
	}
}
