package cn.nova.bus.base.dao;

import java.math.BigDecimal;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Insuretypedetail;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class InsuretypedetailDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select i,u.name as createname, us.name as updatename, iu.name as typename ");
		sql.append(" from Insuretypedetail i, Userinfo u,Userinfo us, Insuretype iu where ");
		sql.append(" i.createby = u.id and i.updateby=us.id and i.insuretype.id=iu.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public Long getInsuretypeid() {
		StringBuffer sql = new StringBuffer(
				"select max(t.id) from Insuretype t");
		Query query = getEntityManager().createQuery(sql.toString());
		List list = query.getResultList();
		if (list.isEmpty()) {
			return (long) 0;
		}
		return (Long) query.getSingleResult();
	}

	public Long getId(Long id) {
		StringBuffer sql = new StringBuffer(
				"select t.id from Insuretypedetail t where t.insuretype.id=");
		sql.append(id);
		Query query = getEntityManager().createQuery(sql.toString());
		List list = query.getResultList();
		if (list.isEmpty()) {
			return (long) 0;
		}
		return (Long) query.getSingleResult();
	}

	public BigDecimal getMount(Long insuretypeid) {
		StringBuffer sql = new StringBuffer(
				"select sum(t.insureamount) from Insuretypedetail t where t.insuretype.id=");
		sql.append(insuretypeid);
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return new BigDecimal(0);
		}
		return (BigDecimal) query.getSingleResult();
	}

	@SuppressWarnings("unchecked")
	public List<Insuretypedetail> getResult(Long insuretypeid) {
		StringBuffer sql = new StringBuffer(
				"select t from Insuretypedetail t where t.insuretype.id=");
		sql.append(insuretypeid);
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	public Insuretypedetail isExist(long id, String value, String key) {
		StringBuffer sql = new StringBuffer(
				"select t from Insuretypedetail t where t.insuretype.id=:id ");
		if ("code".equals(key)) {
			sql.append(" and t.code=:value");
		} else if ("name".equals(key)) {
			sql.append(" and t.name=:value");
		}
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("id", id);
		query.setParameter("value", value);
		if(query.getResultList()!=null && query.getResultList().size()>0){
			Insuretypedetail result = (Insuretypedetail) query.getResultList().get(0);
			return result;
		}else{
			return null;
		}	
	}
}
