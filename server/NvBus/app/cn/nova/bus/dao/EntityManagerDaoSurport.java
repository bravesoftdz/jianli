package cn.nova.bus.dao;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;



import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.LockModeType;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceUnit;
import javax.persistence.Query;

import org.apache.commons.lang.StringUtils;

import play.db.jpa.JPA;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;
import cn.nova.utils.orm.jpa.ListUtil;


import cn.nova.bus.pack.model.Packfeetype;


public class EntityManagerDaoSurport<T> implements IDAO<T> {
	@PersistenceContext
	protected EntityManager em;
	@PersistenceUnit
	protected EntityManagerFactory emFactory;
	
	private LockModeType defaultLockModeType = LockModeType.NONE;
	/**
	 * 用于Dao层子类使用的构造函数.
	 * 通过子类的泛型定义取得对象类型Class.
	 * eg.
	 * public class UserDao extends SimpleHibernateDao<User, Long>
	 */
	
	public EntityManagerDaoSurport(){
		em = JPA.em();
	}
	
	@Override
	public EntityManager createEntityManager() {
//		return emFactory.createEntityManager();
		return JPA.newEntityManager();
	}

	@Override
	public EntityManager getEntityManager() {
		return JPA.em();
	}

	@Override
	public T get(Class<T> clz, Object id) {
		return getEntityManager().find(clz, id);
	}
		
	@Override
	public T get(LockModeType lockModeType,Class<T> clz, Object id) {
	  T t = getEntityManager().find(clz, id);
	  if(null!=t){
	    getEntityManager().lock(t, lockModeType);
	  }
		return t;
	}
	
	@Override
	public T getNoCache(Class<T> clz, Object id) {
		Object result = null;
		EntityManager em = createEntityManager();
		try {
			result = em.find(clz, id);
		} finally{
		    em.close();
		}
	    return (T) result;
	}

	@Override
	public T getNoCache(LockModeType lockModeType,Class<T> clz, Object id) {
		Object result = null;
		EntityManager em = createEntityManager();
		try {
			result = em.find(clz, id);
		} finally{
		    em.close();
		}
	    return (T) result;
	}

	@Override
	public T merge(T entity) {
		return getEntityManager().merge(entity);
	}
	
	@Override
	public boolean save(T entity){
		try{
			getEntityManager().persist(entity);
		}
		catch(Exception e){
			return false;
		}
		return true;
	}
	@Override
	public boolean update(T entity){
		try{
		   merge(entity);
		}
		catch(Exception e){
			return false;
		}
		return true;
	}
	
	@Override
	public boolean delete(T entity) {
		if (!getEntityManager().contains(entity))
			entity = getEntityManager().merge(entity);
		getEntityManager().remove(entity);
		return true;
	}
	@Override
	public boolean del(T entity) {
		if (!getEntityManager().contains(entity))
			entity = getEntityManager().merge(entity);
		getEntityManager().remove(entity);
		return true;
	}
	@Override
	public boolean delete(Class<T> clz, Long id) {
		T entity = em.find(clz, id);
		if (entity != null) {
			em.remove(entity);
			return true;
		}
		else
			return false;
	}
	@Override
	public List<T> query(Class<T> clz, List<PropertyFilter> propertyFilters) {
		StringBuffer bf = new StringBuffer();
		bf = bf.append("select t from " + clz.getSimpleName() + " t ");
		String filtersql = PropertyFilter.toJpql(propertyFilters, false);
		if(!"".equals(filtersql.trim())){
			bf.append(" where ").append(filtersql);
		}
		Query query = getEntityManager().createQuery(bf.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		return query.getResultList();
	}
	
	@Override
	public List<Map<String, Object>> query(Object[] fileds, String sql) {
		List<Object> list = find(sql);
		return ListUtil.listToMap(fileds, list);
	}	
	
	@Override
	public List<Map<String, Object>> query(Object[] fileds, String sql,Object[] filedtypes) {
		List<Object> list = find(sql);
		return ListUtil.listToMap(fileds, list,filedtypes);
	}	
	@Override
	public int execute(String sql) {
		return execute(sql, new HashMap<String, Object>());
	}

	@Override
	public int execute(String sql, Collection paras) {
		Query query = getEntityManager().createQuery(sql);
		int parameterIndex = 0;
		if (paras != null && paras.size() > 0) {
			for (Object obj : paras) {
				query.setParameter(parameterIndex++, obj);
			}
		}
		return query.executeUpdate();
	}
	@Override
	public int execute(String sql, List<PropertyFilter> propertyFilters) {
		return getQuery(defaultLockModeType,sql,propertyFilters).executeUpdate();
	}

	@Override
	public int execute(String sql, Map<String, Object> map) {
		Query query = getEntityManager().createQuery(sql);
		if(map!=null && map.size()>0){
			for (String key : map.keySet()) {
				query.setParameter(key, map.get(key));
			}
		}
		return query.executeUpdate();
	}
	
	@Override
	public Object uniqueResult(String sql) {
		return uniqueResult(defaultLockModeType,sql);
	}

	@Override
	public Object uniqueResult(String sql, Collection paras) {
		return uniqueResult(defaultLockModeType,sql,paras);
	}

	@Override
	public Object uniqueResult(String sql, Map<String, Object> map) {
		return uniqueResult(defaultLockModeType,sql,map);
	}

	@Override
	public Object uniqueResult(String sql, List<PropertyFilter> propertyFilters) {
		return uniqueResult(defaultLockModeType,sql,propertyFilters);
	}

	@Override
	public Object uniqueResult(Class<T> clz, Collection paras) {
		return uniqueResult(defaultLockModeType,clz,paras);
	}

	@Override
	public Object uniqueResult(Class<T> clz, Map<String, Object> map) {
		return uniqueResult(defaultLockModeType,clz,map);
	}

	@Override
	public Object uniqueResult(Class<T> clz, List<PropertyFilter> propertyFilters) {
		return uniqueResult(defaultLockModeType,clz,propertyFilters);
	}

	@Override
	public List find(String sql,int firstResult, int maxResults) {
		return find(defaultLockModeType,sql,firstResult,maxResults);
	}

	@Override
	public List<T> find(Class<T> clz,int firstResult, int maxResults) {
		return find(defaultLockModeType,clz,firstResult,maxResults);
	}

	@Override
	public List<T> find(Class<T> clz,Map<String, Object> map,int firstResult, int maxResults) {
		return find(defaultLockModeType,clz,map,firstResult,maxResults);
	}

	@Override
	public List<T> find(Class<T> clz,Map<String, Object> map,String[] orderFields,int firstResult, int maxResults) {
		return find(defaultLockModeType,clz,map,orderFields,firstResult,maxResults);
	}
	
	@Override
	public List<Object> find(String sql,Map<String, Object> map,int firstResult, int maxResults) {
		return find(defaultLockModeType,sql,map,firstResult,maxResults);
	}

	@Override
	public List<Object> find(String sql,Map<String, Object> map,String[] orderFields,int firstResult, int maxResults) {
		return find(defaultLockModeType,sql,map,orderFields,firstResult,maxResults);
	}
	
	@Override
	public List<T> find(Class<T> clz, List<PropertyFilter> propertyFilters,int firstResult, int maxResults) {
		return find(defaultLockModeType,clz,propertyFilters,firstResult,maxResults);
	}

	@Override
	public List<T> find(Class<T> clz, List<PropertyFilter> propertyFilters,String[] orderFields,int firstResult, int maxResults) {
		return find(defaultLockModeType,clz,propertyFilters,orderFields,firstResult,maxResults);
	}

	@Override
	public List<Object> find(String sql, List<PropertyFilter> propertyFilters,int firstResult, int maxResults) {
		return find(defaultLockModeType,sql,propertyFilters,firstResult,maxResults);
	}

	@Override
	public List<Object> find(String sql, List<PropertyFilter> propertyFilters,String[] orderFields,int firstResult, int maxResults) {
		return find(defaultLockModeType,sql,propertyFilters,orderFields,firstResult,maxResults);
	}

	/////////////////////////////////////////
	@Override
	public List find(String sql) {
		return find(defaultLockModeType,sql);
	}

	@Override
	public List<T> find(Class<T> clz) {
		return find(defaultLockModeType,clz);
	}

	@Override
	public List<T> find(Class<T> clz,Map<String, Object> map) {
		return find(defaultLockModeType,clz,map);
	}

	@Override
	public List<T> find(Class<T> clz,Map<String, Object> map,String[] orderFields) {
		return find(defaultLockModeType,clz,map,orderFields);
	}
	
	@Override
	public List<Object> find(String sql,Map<String, Object> map) {
		return find(defaultLockModeType,sql,map);
	}

	@Override
	public List<Object> find(String sql,Map<String, Object> map,String[] orderFields) {
		return find(defaultLockModeType,sql,map,orderFields);
	}
	
	@Override
	public List<T> find(Class<T> clz, List<PropertyFilter> propertyFilters) {
		return find(defaultLockModeType,clz,propertyFilters);
	}

	@Override
	public List<T> find(Class<T> clz, List<PropertyFilter> propertyFilters,String[] orderFields) {
		return find(defaultLockModeType,clz,propertyFilters,orderFields);
	}

	@Override
	public List<Object> find(String sql, List<PropertyFilter> propertyFilters) {
		return find(defaultLockModeType,sql,propertyFilters);
	}

	@Override
	public List<Object> find(String sql, List<PropertyFilter> propertyFilters,String[] orderFields) {
		return find(defaultLockModeType,sql,propertyFilters,orderFields);
	}

	//取记录数
	public long countTotalRows(final String sql,final String countFiled) {
		String fromSql = sql;
		// select子句与order by子句会影响count查询,进行简单的排除.
		fromSql = "from " + StringUtils.substringAfter(fromSql, "from");
		fromSql = StringUtils.substringBefore(fromSql, "order by");

		String countHql = "select count("+countFiled+") " + fromSql;
		Query query = em.createQuery(countHql);
		return (Long) query.getSingleResult();
	}

	@Override
	public long countTotalRows(Class<T> clz,final String countFiled) {
		return countTotalRows(getSqlByClass(clz),new HashMap<String, Object>(),countFiled);
	}

	@Override
	public long countTotalRows(Class<T> clz,Map<String, Object> map,final String countFiled) {
		return countTotalRows(getSqlByClass(clz),map,countFiled);
	}

	@Override
	public long countTotalRows(String sql,Map<String, Object> map,final String countFiled) {
		String countSql = getCountSql(getSql(sql, map, null),countFiled);
		Query query = getEntityManager().createQuery(countSql);
		setParameterByMap(query,map);
		return (Long) query.getSingleResult();
	}

	@Override
	public long countTotalRows(Class<T> clz, List<PropertyFilter> propertyFilters,final String countFiled) {
		return countTotalRows(getSqlByClass(clz),propertyFilters,countFiled);
	}

	@Override
	public long countTotalRows(String sql, List<PropertyFilter> propertyFilters,final String countFiled) {
		String countSql = getCountSql(getSql(sql, propertyFilters, null),countFiled);
		Query query = getEntityManager().createQuery(countSql);
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		return (Long) query.getSingleResult();
	}

	protected String getSqlByClass(Class clz){
		return "from " + clz.getSimpleName() + " t ";
	}
	
	protected String getCountSql(final String sql,final String countFiled) {
		String fromSql = sql;
		// select子句与order by子句会影响count查询,进行简单的排除.
		fromSql = "from " + StringUtils.substringAfter(fromSql, "from");
		fromSql = StringUtils.substringBefore(fromSql, "order by");

		return"select count("+countFiled+") " + fromSql;
	}

	protected String getSql(String sql, List<PropertyFilter> propertyFilters,String[] orderFields) {
		StringBuilder sb = new StringBuilder(sql);
		if(sql.toLowerCase().contains(" where ")){
			sb.append(PropertyFilter.toJpql(propertyFilters, true));
		}
		else{
			if(!"".equals(PropertyFilter.toJpql(propertyFilters, false).trim())){
				sb.append(" where ").append(PropertyFilter.toJpql(propertyFilters, false));
			}
		}
		if(orderFields!=null&&orderFields.length>0){
			sb.append(" order by ");
			int j=0;
			for (String orderField : orderFields) {
				if(j==0){
					sb.append(orderField);
				}
				else{
					sb.append(",").append(orderField);
				}
				j++;
			}
		}
		return sb.toString();
	}

	protected String getSql(String sql, Map<String, Object> map,String[] orderFields) {
		StringBuilder sb = new StringBuilder(sql);
		if(sql.toLowerCase().contains(" where ")){
			sb.append(mapToSql(map,true));
		}
		else{
			if(!"".equals(mapToSql(map,false).trim())){
				sb.append(" where "+mapToSql(map,false));
			}
		}
		if(orderFields!=null&&orderFields.length>0){
			sb.append(" order by ");
			int j=0;
			for (String orderField : orderFields) {
				if(j==0){
					sb.append(orderField);
				}
				else{
					sb.append(",").append(orderField);
				}
				j++;
			}
		}
		return sb.toString();
	}

	protected Query getQuery(LockModeType lockModeType,String sql, List<PropertyFilter> propertyFilters) {
		return getQuery(lockModeType,sql,propertyFilters,null);
	}
	
	protected Query getQuery(LockModeType lockModeType,String sql, List<PropertyFilter> propertyFilters,String[] orderFields) {
		Query query = getEntityManager().createQuery(getSql(sql,propertyFilters,orderFields));
		query.setLockMode(lockModeType);
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		return query;
	}
	
	protected String mapToSql(Map<String, Object> map,boolean PrefixAnd){
		StringBuilder sb = new StringBuilder();
		if(map!=null&&map.size()>0){
			for (String key : map.keySet()) {
				if(sb.length()>0){
					sb.append(" and ");
				}
				sb.append(key).append("=:").append(key);
			}
		}
		if(PrefixAnd&&sb.length()>0){
			sb.insert(0, " and ");
		}
		return sb.toString();
	}
	
	protected Query getQuery(LockModeType lockModeType,String sql, Map<String, Object> map,String[] orderFields) {
		Query query = getEntityManager().createQuery(getSql(sql,map,orderFields));
		query.setLockMode(lockModeType);
//		for (String key : map.keySet()) {
//			query.setParameter(key, map.get(key));
//		}
		setParameterByMap(query,map);
		return query;
	}
	
	protected void setParameterByMap(Query query,Map<String, Object> map){
		if(map!=null&&map.size()>0){
			for (String key : map.keySet()) {
				query.setParameter(key, map.get(key));
			}
		}
	}

	@Override
	public Object uniqueResult(LockModeType lockModeType,String sql) {
		return uniqueResult(lockModeType,sql, new ArrayList());
	}

	@Override
	public Object uniqueResult(LockModeType lockModeType,String sql, Collection paras) {
		Query query = getEntityManager().createQuery(sql);
		if (paras != null && paras.size() > 0) {
			int parameterIndex = 0;
			for (Object obj : paras) {
				query.setParameter(parameterIndex++, obj);
			}
		}
		try {
			query.setLockMode(lockModeType);
			return query.getSingleResult();
		} catch (NoResultException e) {
			return null;
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			return null;
		}
	}

	@Override
	public Object uniqueResult(LockModeType lockModeType,String sql, Map<String, Object> map) {
		try {
			return getQuery(lockModeType,sql,map,null).getSingleResult();
		} catch (NoResultException e) {
			return null;
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			return null;
		}
	}

	@Override
	public Object uniqueResult(LockModeType lockModeType,String sql, List<PropertyFilter> propertyFilters) {
		try {
			return getQuery(lockModeType,sql,propertyFilters).getSingleResult();
		} catch (NoResultException e) {
			return null;
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			return null;
		}
	}

	@Override
	public Object uniqueResult(LockModeType lockModeType,Class<T> clz, Collection paras) {
		return uniqueResult(lockModeType,getSqlByClass(clz), paras);
	}

	@Override
	public Object uniqueResult(LockModeType lockModeType,Class<T> clz, Map<String, Object> map) {
		try {
			return getQuery(lockModeType,getSqlByClass(clz),map,null).getSingleResult();
		} catch (NoResultException e) {
			return null;
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			return null;
		}
	}

	@Override
	public Object uniqueResult(LockModeType lockModeType,Class<T> clz, List<PropertyFilter> propertyFilters) {
		try {
			return getQuery(lockModeType,getSqlByClass(clz),propertyFilters).getSingleResult();
		} catch (NoResultException e) {
			return null;
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			return null;
		}
	}

	@Override
	public List find(LockModeType lockModeType,String sql,int firstResult, int maxResults) {
		Query query = getEntityManager().createQuery(sql); 
		query.setLockMode(lockModeType);
		return  query.setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
	}

	@Override
	public List<T> find(LockModeType lockModeType,Class<T> clz,int firstResult, int maxResults) {
		return find(lockModeType,clz,new HashMap<String, Object>(),firstResult,maxResults);
	}

	@Override
	public List<T> find(LockModeType lockModeType,Class<T> clz,Map<String, Object> map,int firstResult, int maxResults) {
		return find(lockModeType,clz,map,null,firstResult,maxResults);
	}

	@Override
	public List<T> find(LockModeType lockModeType,Class<T> clz,Map<String, Object> map,String[] orderFields,int firstResult, int maxResults) {
		StringBuffer bf = new StringBuffer();
		bf = bf.append("from " + clz.getSimpleName() + " ");
		return getQuery(lockModeType,bf.toString(),map,orderFields).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
	}
	
	@Override
	public List<Object> find(LockModeType lockModeType,String sql,Map<String, Object> map,int firstResult, int maxResults) {
		return find(lockModeType,sql,map,null,firstResult,maxResults);
	}

	@Override
	public List<Object> find(LockModeType lockModeType,String sql,Map<String, Object> map,String[] orderFields,int firstResult, int maxResults) {
		return getQuery(lockModeType,sql,map,orderFields).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
	}
	
	@Override
	public List<T> find(LockModeType lockModeType,Class<T> clz, List<PropertyFilter> propertyFilters,int firstResult, int maxResults) {
		return find(lockModeType,clz,propertyFilters,null,firstResult,maxResults);
	}

	@Override
	public List<T> find(LockModeType lockModeType,Class<T> clz, List<PropertyFilter> propertyFilters,String[] orderFields,int firstResult, int maxResults) {
		return getQuery(lockModeType,getSqlByClass(clz),propertyFilters,orderFields).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
	}

	@Override
	public List<Object> find(LockModeType lockModeType,String sql, List<PropertyFilter> propertyFilters,int firstResult, int maxResults) {
		return find(lockModeType,sql,propertyFilters,null,firstResult,maxResults);
	}

	@Override
	public List<Object> find(LockModeType lockModeType,String sql, List<PropertyFilter> propertyFilters,String[] orderFields,int firstResult, int maxResults) {
		return getQuery(lockModeType,sql,propertyFilters,orderFields).setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
	}

	/////////////////////////////////////////
	@Override
	public List find(LockModeType lockModeType,String sql) {
		Query query = getEntityManager().createQuery(sql); 
		query.setLockMode(lockModeType);
		return  query.getResultList();
	}

	@Override
	public List<T> find(LockModeType lockModeType,Class<T> clz) {
		return find(lockModeType,clz,new HashMap<String, Object>());
	}

	@Override
	public List<T> find(LockModeType lockModeType,Class<T> clz,Map<String, Object> map) {
		return find(lockModeType,clz,map,null);
	}

	@Override
	public List<T> find(LockModeType lockModeType,Class<T> clz,Map<String, Object> map,String[] orderFields) {
		StringBuffer bf = new StringBuffer();
		bf = bf.append("from " + clz.getSimpleName() + " ");
		return getQuery(lockModeType,bf.toString(),map,orderFields).getResultList();
	}
	
	@Override
	public List<Object> find(LockModeType lockModeType,String sql,Map<String, Object> map) {
		return find(lockModeType,sql,map,null);
	}

	@Override
	public List<Object> find(LockModeType lockModeType,String sql,Map<String, Object> map,String[] orderFields) {
		return getQuery(lockModeType,sql,map,orderFields).getResultList();
	}
	
	@Override
	public List<T> find(LockModeType lockModeType,Class<T> clz, List<PropertyFilter> propertyFilters) {
		return find(lockModeType,clz,propertyFilters,null);
	}

	@Override
	public List<T> find(LockModeType lockModeType,Class<T> clz, List<PropertyFilter> propertyFilters,String[] orderFields) {
		return getQuery(lockModeType,getSqlByClass(clz),propertyFilters,orderFields).getResultList();
	}

	@Override
	public List<Object> find(LockModeType lockModeType,String sql, List<PropertyFilter> propertyFilters) {
		return find(lockModeType,sql,propertyFilters,null);
	}

	@Override
	public List<Object> find(LockModeType lockModeType,String sql, List<PropertyFilter> propertyFilters,String[] orderFields) {
		return getQuery(lockModeType,sql,propertyFilters,orderFields).getResultList();
	}

}
