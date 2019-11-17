package cn.nova.bus.checkticket.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.checkticket.model.Routechecktime;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class RoutechecktimeDao extends EntityManagerDaoSurport {
	
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList){
		StringBuilder sql = new StringBuilder("select rt, r.name as routename, o.name as orgname, uc.name as createname, uu.name as updatename ");
		sql.append("from Routechecktime rt, Route r, Organization o, Userinfo uc, Userinfo uu ");
		sql.append("where rt.routeid = r.id and rt.orgid = o.id and rt.createby = uc.id and rt.updateby = uu.id and r.isactive=1 and o.isactive=1 ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	public Long getRoutechecktimeId(Long orgid, Long routeid){
		StringBuilder sql = new StringBuilder("select r.id from Routechecktime r ");
		sql.append("where r.orgid = :orgid and r.routeid = :routeid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("routeid", routeid);
		if(query.getResultList().isEmpty()){
			return new Long(0);
		}
		return (Long) query.getSingleResult();
	}
	public long qryRoutechecktime(long routeid){
		StringBuilder sql = new StringBuilder("select r from Routechecktime r ");
		sql.append("where r.routeid = :routeid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("routeid", routeid);
		List<Routechecktime> rs=query.getResultList();
		if(rs==null || rs.size()==0){
			return 0;
		}else{
			return rs.get(0).getStarttime();
		}
		
	}
}
