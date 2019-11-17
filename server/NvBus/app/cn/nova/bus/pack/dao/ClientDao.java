package cn.nova.bus.pack.dao;

import java.math.BigDecimal;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.pack.model.Client;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;


@SuppressWarnings("rawtypes")
public class ClientDao extends EntityManagerDaoSurport{

	

	@SuppressWarnings("unchecked")
	public List<Object> queryClient(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select cnt,org.name as orgname,cu.name as createname,uu.name as updatename")
		.append(" from Client cnt,Organization org,Userinfo cu,Userinfo uu where org.id=cnt.orgid and cu.id=cnt.createby and uu.id=cnt.updateby");
		sql.append(PropertyFilter.toJpql(propertyFilterList,true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}	

	public boolean update(long delid){
		int resultnum = 0;
		String sql = "update Client t set t.isactive = 0,t.islocaldelete = 1 where t.id = "+delid;
		resultnum = getEntityManager().createQuery(sql).executeUpdate();
		if(resultnum>0){
			return true;
		}else{
			return false;			
		}
		
	}
	
	
	public boolean updateClientIntegrater(long id, long integrater){
		int resultnum = 0;
		String sql="update Client set integrater=integrater - :integrater where id=:id";
		Query query = getEntityManager().createQuery(sql);
		query.setParameter("id", id);
		query.setParameter("integrater", integrater);
		resultnum=query.executeUpdate();
		if(resultnum>0){
			return true;
		}else{
			return false;			
		}
	}
	public boolean updateClientIntegrater(long id, BigDecimal price){
		int resultnum = 0;
		Client client=findById(id);
		String sql="update Client set integrater=integrater + (select ROUND((integrate/price)*:price) from PackIntegrateRule where  type=0 and clienttype=:clienttype ) where  id=:id";
		Query query = getEntityManager().createQuery(sql);
		query.setParameter("id", id);
		query.setParameter("price", price);
		query.setParameter("clienttype", client.getType());
		resultnum=query.executeUpdate();
		if(resultnum>0){
			return true;
		}else{
			return false;			
		}
	}
	
	public Client findById(long id){
		Query query = getEntityManager().createQuery("select c from Client c where c.id=:id",Client.class);
		query.setParameter("id", id);
		Client client=(Client) query.getSingleResult();
		return client;
	}
	
}
