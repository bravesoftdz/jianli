package cn.nova.bus.pack.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.pack.model.Packpoint;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class PackpointDao extends EntityManagerDaoSurport{
    // Packpoint p;
	@SuppressWarnings("unchecked")
	public List<Object> query() {
		StringBuilder sql = new StringBuilder("select t from Packpoint t");
		
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}	
	
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder("select t from Packpoint t");
		
		sql.append(PropertyFilter.toJpql(propertyFilterList,true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
}
