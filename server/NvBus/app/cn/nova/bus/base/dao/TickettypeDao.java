package cn.nova.bus.base.dao;

import java.util.List;

import javax.persistence.Query;

import util.CurrentUtil;
import cn.nova.bus.base.model.Tickettype;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;


@SuppressWarnings("rawtypes")
public class TickettypeDao  extends EntityManagerDaoSurport {
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder("select t, ")
				.append(" u1.name as createname,u2.name as updatename")
				.append(" from Tickettype t ,Userinfo u1,Userinfo u2")
				.append(" where t.updateby=u2.id and t.createby=u1.id")
				.append("  and t.isactive=1 and t.orderno>0 ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by t.orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public boolean isExistByCode(Tickettype tickettype) {
		if(tickettype.getId()==0){ 
			StringBuilder sql = new StringBuilder(
					"select t from Tickettype t where t.code=:code and t.isactive=1 ");
//		"select t from Tickettype t where t.code=:code and t.isactive=1 and t.orgid=:orgid");
			Query query = em.createQuery(sql.toString());
			query.setParameter("code", tickettype.getCode());
//			query.setParameter("orgid", tickettype.getOrgid());
			List<Object> list = query.getResultList();
			return list!=null && list.size()>0?true:false;
	  }else
	  {
			StringBuilder sql = new StringBuilder(
			"select t from Tickettype t where t.code=:code and t.isactive=1 ")
//			"select t from Tickettype t where t.code=:code and t.isactive=1 and t.orgid=:orgid")
			.append(" and t.id!=:id");
			Query query = em.createQuery(sql.toString());
			query.setParameter("code", tickettype.getCode());
			query.setParameter("id", tickettype.getId());
//			query.setParameter("orgid", tickettype.getOrgid());
			List<Object> list = query.getResultList();
			return list!=null && list.size()>0?true:false;
	  }
	}
	@SuppressWarnings("unchecked")
	public boolean isExistByName(Tickettype tickettype) {
		if(tickettype.getId()==0){ 
				StringBuilder sql = new StringBuilder(
						"select t from Tickettype t where t.name=:name and t.isactive=1 ");
//			"select t from Tickettype t where t.name=:name and t.isactive=1 and t.orgid=:orgid");
				Query query = em.createQuery(sql.toString());
				query.setParameter("name", tickettype.getName());
//				query.setParameter("orgid", tickettype.getOrgid());
				List<Object> list = query.getResultList();
				return list!=null && list.size()>0?true:false;
		 }else
		 {
				StringBuilder sql = new StringBuilder(
				"select t from Tickettype t where t.name=:name and t.isactive=1 ")
//			"select t from Tickettype t where t.name=:name and t.isactive=1 and t.orgid=:orgid")
				.append(" and t.id!=:id");
				Query query = em.createQuery(sql.toString());
				query.setParameter("name", tickettype.getName());
				query.setParameter("id", tickettype.getId());
//				query.setParameter("orgid", tickettype.getOrgid());
				List<Object> list = query.getResultList();
				return list!=null && list.size()>0?true:false;
		  }
	}
	@SuppressWarnings("unchecked")
	public boolean isExistDelByCode(Tickettype tickettype) {
		StringBuilder sql = new StringBuilder(
				"select t from Tickettype t where t.code=:code and t.isactive=0");
//	"select t from Tickettype t where t.code=:code and t.orgid=:orgid and t.isactive=0");
		Query query = em.createQuery(sql.toString());
		query.setParameter("code", tickettype.getCode());
//		query.setParameter("orgid", tickettype.getOrgid());
		List<Object> result = query.getResultList();
		if (result!=null && result.size() == 1 && result.get(0) != null) {
			return true;
		}
		return false;
	}
	@SuppressWarnings("unchecked")
	public boolean isExistDelByName(Tickettype tickettype) {
		StringBuilder sql = new StringBuilder(
				"select t from Tickettype t where t.name=:name and t.isactive=0");
//	"select t from Tickettype t where t.name=:name and t.orgid=:orgid and t.isactive=0");
		Query query = em.createQuery(sql.toString());
		query.setParameter("name", tickettype.getName());
//		query.setParameter("orgid", tickettype.getOrgid());
		List<Object> result = query.getResultList();
		if (result!=null && result.size() == 1 && result.get(0) != null) {
			return true;
		}
		return false;
	}
	public Tickettype getTickettypeByName(Tickettype tickettype) {
		Global global = CurrentUtil.getGlobal();
		StringBuilder sql = new StringBuilder(
				"select t from Tickettype t where t.name=:name and t.isactive=0");
//	"select t from Tickettype t where t.name=:name and t.orgid=:orgid and t.isactive=0");
		sql.append("and t.orgid in "+getOrgsRight(global.getOrgIDs()));
		Query query = em.createQuery(sql.toString());
		query.setParameter("name", tickettype.getName());
//		query.setParameter("orgid", tickettype.getOrgid());		
		return  (Tickettype) query.getSingleResult();
	}
	public Tickettype getTickettypeByCode(Tickettype tickettype) {
		Global global = CurrentUtil.getGlobal();
		StringBuilder sql = new StringBuilder(
				"select t from Tickettype t where t.code=:code and t.isactive=0");
//	"select t from Tickettype t where t.code=:code and t.orgid=:orgid and t.isactive=0");
		sql.append("and t.orgid in "+getOrgsRight(global.getOrgIDs()));
		Query query = em.createQuery(sql.toString());
		query.setParameter("code", tickettype.getCode());
//		query.setParameter("orgid", tickettype.getOrgid());		
		return  (Tickettype) query.getSingleResult();
	}
	public Byte getMaxOrderno(Tickettype tickettype){
		StringBuilder sql = new StringBuilder(
		"select MAX(t.orderno) from Tickettype t ");
//	"select MAX(t.orderno) from Tickettype t where t.orgid=:orgid");
		Query query = em.createQuery(sql.toString());
//		query.setParameter("orgid", tickettype.getOrgid());
		Object obj= query.getSingleResult();
		return obj!=null?(Byte)obj:1;
		
	}
	@SuppressWarnings("unchecked")
	public Tickettype getTickettypeByOrderno(byte orderno,long orgid) {
		Global global = CurrentUtil.getGlobal();
		StringBuilder sql = new StringBuilder(
				"select t from Tickettype t where t.orderno=:orderno and t.isactive=1");
//	"select t from Tickettype t where t.orderno=:orderno and t.orgid=:orgid and t.isactive=1");
		sql.append("and t.orgid in "+getOrgsRight(global.getOrgIDs()));
		Query query = em.createQuery(sql.toString());
		query.setParameter("orderno", orderno);
//		query.setParameter("orgid", orgid);	
		List<Object> list =query.getResultList();
		return  (Tickettype) (list!=null&&list.size()>0?list.get(0):null);
	}
	
	public Tickettype getNearestTickettypeByOrderno(byte orderno, int direction){
		Global global = CurrentUtil.getGlobal();
		StringBuilder sql = new StringBuilder(
				"select t from Tickettype t where t.orderno=");
		if (direction < 0) {
			sql.append("(select max(t0.orderno) from Tickettype t0 where t0.orderno !=-1 and t0.orderno <"+orderno);
		} else {
			sql.append("(select min(t0.orderno) from Tickettype t0 where t0.orderno >"+orderno);
		}
		sql.append(" and t0.orgid in "+getOrgsRight(global.getOrgIDs()));
		sql.append(" and t0.isactive=1)");
		Query query = em.createQuery(sql.toString());
		List<Object> list = query.getResultList();
		
		return (Tickettype)(list!=null&&list.size()>0? list.get(0): null);
	}
	
	public String getOrgsRight(String orgids){
		StringBuilder sql = new StringBuilder(
			"select o.id from Organization o ")
			.append(" where o.isactive=1 and o.id in " + orgids);
		Query query = getEntityManager().createQuery(sql.toString());
		List<Object> objs = query.getResultList();
		StringBuilder orgIds = new StringBuilder("(");
		for(Object o: objs) {
			orgIds.append(((Long)o)+",");
		}
		return orgIds.substring(0, orgIds.length() - 1) + ")";
	}
}
