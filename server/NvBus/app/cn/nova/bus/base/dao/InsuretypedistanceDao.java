package cn.nova.bus.base.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Insurancetypefares;
import cn.nova.bus.base.model.Insuretypedistance;
import cn.nova.bus.base.model.Insuretypeticketprice;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class InsuretypedistanceDao extends EntityManagerDaoSurport {
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select t.id,t.orgid,o.name orgname,t.insuretypeid,")
				.append("t.fromdistance,t.enddistance,t.createtime,t.createby,t.updatetime,")
				.append("t.updateby,s.name insuretypename,u1.name createname,u2.name updatename,s.code as insuretypecode,s.premium")
				.append(" from Insuretypedistance t, Userinfo u1, Userinfo u2, Insuretype s,Organization o")
				.append(" where t.createby = u1.id  and t.updateby = u2.id  and t.insuretypeid = s.id and t.orgid = o.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by t.updatetime desc");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		List<Object> list = query.getResultList();
		return list;
	}
	@SuppressWarnings("unchecked")
	public List<Object> qryInsuranceTypeFares(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select t.id as id, t.orgid as orgid,o.name as orgname,t.insuretypeid as insuretypeid, " )
				.append("s.name as insuretypename,t.fromprice  as fromprice,t.endprice as endprice,t.createtime as createtime,u.name as createby ,t.updatetime as updatetime,uu.name as updateby ")
				.append(" from insuranceTypeFares t ")
				.append(" left join Insuretype s on  t.insuretypeid = s.id ")
				.append(" left join organization o on o.id=t.orgid")
				.append(" left join userinfo u on u.id=t.createby ")
				.append(" left join userinfo uu on uu.id=t.updateby  where 1 = 1 ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by o.name,t.fromprice ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		List<Object> list = query.getResultList();
		return list;
	}

	@SuppressWarnings("unchecked")
	public boolean isexist(Insuretypedistance insuretypedistance) {
		StringBuilder sql = null;
		if (insuretypedistance.getId() == 0) {
			sql = new StringBuilder(
					"select s from Insuretypedistance s where s.orgid=:orgid")
					.append(" and ((s.fromdistance>=:fromdistance and s.fromdistance<=:enddistance) ")
					.append(" or (s.fromdistance<=:fromdistance and s.enddistance>=:enddistance)")
					.append(" or (s.fromdistance<=:fromdistance and s.enddistance>=:fromdistance)")
					.append(" or (s.fromdistance>=:fromdistance and s.enddistance<=:enddistance))");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("orgid", insuretypedistance.getOrgid());
			query.setParameter("fromdistance",
					insuretypedistance.getFromdistance());
			query.setParameter("enddistance",
					insuretypedistance.getEnddistance());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;

		} else {
			sql = new StringBuilder(
					"select s from Insuretypedistance s where s.orgid=:orgid and s.id!=:id")
					.append(" and ((s.fromdistance>=:fromdistance and s.fromdistance<=:enddistance) ")
					.append(" or (s.fromdistance<=:fromdistance and s.enddistance>=:enddistance)")
					.append(" or (s.fromdistance<=:fromdistance and s.enddistance>=:fromdistance)")
					.append(" or (s.fromdistance>=:fromdistance and s.enddistance<=:enddistance))");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("orgid", insuretypedistance.getOrgid());
			query.setParameter("id", insuretypedistance.getId());
			query.setParameter("fromdistance",insuretypedistance.getFromdistance());
			query.setParameter("enddistance",
					insuretypedistance.getEnddistance());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		}

	}
	
	@SuppressWarnings("unchecked")
	public boolean isexistinsuretypeFares(Insurancetypefares insurancetypefares) {
		StringBuilder sql = null;
		if (insurancetypefares.getId() == 0) {
			sql = new StringBuilder(
					"select s from Insurancetypefares s where s.orgid=:orgid")
					.append(" and ((s.fromprice>=:fromdistance and s.fromprice<=:enddistance) ")
					.append(" or (s.fromprice<=:fromdistance and s.endprice>=:enddistance)")
					.append(" or (s.fromprice<=:fromdistance and s.endprice>=:fromdistance)")
					.append(" or (s.fromprice>=:fromdistance and s.endprice<=:enddistance))");
//					.append("  and s.insuretypeid = :insuretypeid");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("orgid", insurancetypefares.getOrgid());
			query.setParameter("fromdistance",
					insurancetypefares.getFromprice());
			query.setParameter("enddistance",
					insurancetypefares.getEndprice());
//			query.setParameter("insuretypeid", insurancetypefares.getInsuretypeid());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;

		} else {
			sql = new StringBuilder(
					"select s from Insurancetypefares s where s.orgid=:orgid and s.id!=:id")
					.append(" and ((s.fromprice>=:fromdistance and s.fromprice<=:enddistance) ")
					.append(" or (s.fromprice<=:fromdistance and s.endprice>=:enddistance)")
					.append(" or (s.fromprice<=:fromdistance and s.endprice>=:fromdistance)")
					.append(" or (s.fromprice>=:fromdistance and s.endprice<=:enddistance))");
//					.append(" and s.insuretypeid = :insuretypeid");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("orgid", insurancetypefares.getOrgid());
			query.setParameter("id", insurancetypefares.getId());
			query.setParameter("fromdistance",
					insurancetypefares.getFromprice());
			query.setParameter("enddistance",
					insurancetypefares.getEndprice());
//			query.setParameter("insuretypeid", insurancetypefares.getInsuretypeid());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		}

	}

	public List<Object> qryinsuretypeprice(
			List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder();
		sql.append(
				" select t.id, t.orgid,o.name orgname,t.insuretypeid, t.fromprice , t.endprice , t.createtime, ")
				.append(" t.createby, t.updatetime, t.updateby, s.name insuretypename, u1.name createname, ")
				.append(" u2.name updatename, s.code as insuretypecode, s.premium ")
				.append(" from insuretypeticketprice t, Userinfo u1, Userinfo u2, Insuretype s, Organization o ")
				.append(" where t.createby = u1.id and t.updateby = u2.id and t.insuretypeid = s.id and t.orgid = o.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by t.updatetime desc");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		List<Object> list = query.getResultList();
		return list;
	}

	public boolean ispriceexist(Insuretypeticketprice insuretypeticketprice) {
		StringBuilder sql = null;
		if (insuretypeticketprice.getId() == 0) {
			sql = new StringBuilder(
					"select s from Insuretypeticketprice s where s.orgid=:orgid")
					.append(" and ((s.fromprice>=:fromprice and s.fromprice<=:endprice) ")
					.append(" or (s.fromprice<=:fromprice and s.endprice>=:endprice)")
					.append(" or (s.fromprice<=:fromprice and s.endprice>=:fromprice)")
					.append(" or (s.fromprice>=:fromprice and s.endprice<=:endprice))");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("orgid", insuretypeticketprice.getOrgid());
			query.setParameter("fromprice",
					insuretypeticketprice.getFromprice());
			query.setParameter("endprice",
					insuretypeticketprice.getEndprice());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;

		} else {
			sql = new StringBuilder(
					"select s from Insuretypeticketprice s where s.orgid=:orgid and s.id!=:id")
			.append(" and ((s.fromprice>=:fromprice and s.fromprice<=:endprice) ")
			.append(" or (s.fromprice<=:fromprice and s.endprice>=:endprice)")
			.append(" or (s.fromprice<=:fromprice and s.endprice>=:fromprice)")
			.append(" or (s.fromprice>=:fromprice and s.endprice<=:endprice))");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("orgid", insuretypeticketprice.getOrgid());
			query.setParameter("id", insuretypeticketprice.getId());
			query.setParameter("fromprice",
					insuretypeticketprice.getFromprice());
			query.setParameter("endprice",
					insuretypeticketprice.getEndprice());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		}
	}

}
