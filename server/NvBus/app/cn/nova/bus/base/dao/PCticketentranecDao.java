package cn.nova.bus.base.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.base.model.Pcticketentrance;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class PCticketentranecDao extends EntityManagerDaoSurport {

	
	 
	public IDAO<Pcticketentrance> dao = new EntityManagerDaoSurport<Pcticketentrance>();
	
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(" select p.ip ,p.orgid,o.name as orgname "+
					" from Pcticketentrance p, Organization o where p.orgid = o.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" group by p.ip,p.orgid,o.name ");
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> findPCEntranceName(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select t.id,t.name as entrancename,p.createtime," +
				"u.name as createname,up.name as updatename,p.updatetime " +
				" from Pcticketentrance p, Ticketentrance t,Userinfo u,Userinfo up" +
				" where t.isactive = 1 and p.ticketentranceid = t.id " +
				" and u.id = p.createby and p.updateby = up.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList,true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public List<Object> findTicketentrancename(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(" select t.id,t.name from  Ticketentrance t ,Organization o where o.id =  t.orgid and t.isactive  = 1 ");
		sql.append(PropertyFilter.toJpql(propertyFilterList,true));
		//sql.append(" order by t.createtime ");
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public List<Pcticketentrance> findPCentrance(String ip,long orgid,long entranceid) {
		Map<String,Object> where = new HashMap<String, Object>();
		if(ip!=null){
			where.put("ip", ip);			
		}
		if(orgid!=0){
			where.put("orgid", orgid);
		}
		if(entranceid!=0){
			where.put("ticketentranceid", entranceid);
		}
		List<Pcticketentrance> list  = dao.find(Pcticketentrance.class, where);
		return list;
		
	}
	
	public Boolean delpcticketentrance(long orgid,String ip,long ticketentranceid) {
		String sql="delete from Pcticketentrance p where 1 = 1";
		if(orgid != 0){
			sql =  sql +" and p.orgid = "+orgid;
		}
		if(ip != null){
			sql =  sql +" and p.ip = '"+ip+"'";
		}
		if(ticketentranceid != 0){
			sql =  sql +" and p.ticketentranceid = "+ticketentranceid;
		}
		int result = dao.execute(sql);
		if(result>0){
			return true;
		}else{
			return false;
		}
	}
	
	public Boolean savepcticketentrance(Pcticketentrance pcticketentrance) {
		if(pcticketentrance.getId()!=0){
			return dao.update(pcticketentrance);
		}else{
			return dao.save(pcticketentrance);
		}
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> qryTicketentrance(String ip,Long orgid){
		StringBuilder sql = new StringBuilder();
		sql.append("select t.id,t.name,t.printname as code from Ticketentrance t,Pcticketentrance pc")
		.append(" where t.id=pc.ticketentranceid and t.orgid=:orgid")
		.append(" and t.isactive=1 and pc.ip=:ip   order by t.name");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("ip", ip);
		query.setParameter("orgid", orgid);
		return query.getResultList();			
		
	}
	@SuppressWarnings("unchecked")
	public List<Object> qryTicketentrance(String orgids){
		StringBuilder sql = new StringBuilder();
		sql.append("select t.id,t.name,t.printname as code from Ticketentrance t")
		.append(" where  t.orgid in "+orgids)
		.append(" and t.isactive=1  order by t.name");
		Query query = em.createNativeQuery(sql.toString());
		return query.getResultList();			
		
	}
}
