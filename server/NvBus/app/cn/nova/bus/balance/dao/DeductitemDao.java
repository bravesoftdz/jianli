package cn.nova.bus.balance.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.balance.model.Deductitem;
import cn.nova.bus.balance.model.Deductroutestop;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Printtemplatetype;
import cn.nova.bus.system.model.Printtemplatetypeitem;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class DeductitemDao extends EntityManagerDaoSurport {
	//
	@SuppressWarnings("unchecked")
	public List<Object> qryDeductitems(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = null;
		sql = new StringBuilder(
				"select b,u1.name as createname,u2.name as updatename,o.name as orgname")
				.append(" from Deductitem b,Userinfo u1,Userinfo u2,Organization o")
				.append(" where b.createby=u1.id and b.updateby=u2.id")
				.append(" and b.orgid=o.id and b.isactive=1");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by b.orderno");
		Query query = em.createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Deductitem> qryDeductitem(List<PropertyFilter> propertyFilters) {
		StringBuilder sql = new StringBuilder(
				"select d from Deductitem d where d.isactive=1 ");
		sql.append(PropertyFilter.toJpql(propertyFilters, true));
		Query query = em.createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Deductitem> qryDeductitem(long orgid) {
		StringBuilder sql = new StringBuilder(
				"select d from Deductitem d where d.isactive=1 and d.orgid=:orgid order by orderno");
		Query query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public boolean qryDeductitemByCode(long orgid,String code) {
		StringBuilder sql = new StringBuilder(
				"select d from Deductitem d where d.isactive=1 and d.orgid=:orgid")
		.append(" and d.code like '%:code%'");
		Query query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("code", code);		
		List<Object> list=query.getResultList();
		return list!=null&&list.size()>0?true:false;
	}
	
	@SuppressWarnings("unchecked")
	public Deductitem qryDeductitem(long orgid,String name) {
		StringBuilder sql = new StringBuilder(
				"select d from Deductitem d where d.isactive=1 ")
		.append(" and d.orgid=:orgid and d.name=:name");
		Query query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("name", name);		
		List<Deductitem> list=query.getResultList();
		return list!=null&&list.size()>0?list.get(0):null;
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> qryDeducts(long routeid) {
		StringBuilder sql = new StringBuilder(
				"selecT dt.stationid, dt.deductitemid, dt.deductmoney")
		.append(" from Deductroutestop dt, Deductitem d")
		.append(" where dt.deductitemid = d.id and d.isactive = 1")
		.append(" and dt.routeid = :routeid");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("routeid", routeid);
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public List<Object> qryStationStop(long routeid) {
		StringBuilder sql = new StringBuilder(
				"selecT rs.stationid,s.name")
		.append(" from Routestop rs ,Station s ")
		.append(" where rs.stationid=s.id and rs.orderno > 0  and rs.routeid = :routeid")
		.append("  order by rs.distance");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("routeid", routeid);
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public List<Deductroutestop> qryDeducts(List<PropertyFilter> propertyFilters) {
		StringBuilder sql = new StringBuilder(
				"selecT dt")
		.append(" from Deductroutestop dt")
		.append(" where 1 = 1");
		sql.append(PropertyFilter.toJpql(propertyFilters, true));
		Query query = em.createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public Printtemplatetype qryPrinttemplatetype(String name) {
		StringBuilder sql = new StringBuilder(
				"selecT t")
		.append(" from Printtemplatetype t")
		.append(" where name=:name");
		Query query = em.createQuery(sql.toString());
		query.setParameter("name", name);
		List<Printtemplatetype> plist=query.getResultList();
		return plist!=null&&plist.size()>0?plist.get(0):null;
	}
	@SuppressWarnings("unchecked")
	public boolean qryPrinttemplatetypeitem(long typeid,String name,String code) {
		StringBuilder sql = new StringBuilder(
				"selecT t")
		.append(" from Printtemplatetypeitem t")
		.append(" where t.printtemplatetype.id=:typeid and (itemname=:name or")
		.append(" t.itemcode=:code) and t.islist=0");
		Query query = em.createQuery(sql.toString());
		query.setParameter("typeid", typeid);
		query.setParameter("name", name);
		query.setParameter("code", code);		
		List<Printtemplatetypeitem> plist=query.getResultList();
		return plist!=null&&plist.size()>0?true:false;
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Object> qryDeductroutestop(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = null;
		sql = new StringBuilder(
				"select dt.id, dt.routeid,r.name routename,s.name stationname,")
		.append(" b.name itemname,dt.deductmoney,u1.name as createname,")
		.append(" dt.createtime,u2.name as updatename,")
		.append(" dt.updatetime")
		.append(" from Deductitem b,Userinfo u1,Userinfo u2,")
		.append(" Deductroutestop dt,Route r,Station s")
		.append(" where dt.createby = u1.id and dt.routeid = r.id")
		.append(" and dt.stationid = s.id and dt.updateby = u2.id")
		.append(" and b.id = dt.deductitemid and b.isactive = 1");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by dt.routeid,b.orderno");
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
}
