package cn.nova.bus.pack.dao;

import java.math.BigDecimal;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.pack.model.PackIntegrateRule;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

public class PackIntegrateRuleDao extends EntityManagerDaoSurport {
	public List<Object> integraterToMoney(long integrater, String clienttype,
			long orgid) {
		String sql = "select ROUND((price/integrate)*:integrater,2) as money from packintegraterule where type=1 and clienttype=:clienttype and orgid=:orgid";
		Query query = getEntityManager().createNativeQuery(sql);
		query.setParameter("integrater", integrater);
		query.setParameter("clienttype", clienttype);
		query.setParameter("orgid", orgid);
		List<Object> result = query.getResultList();
		return result;
	}

	public List<Object> moneyToIntegrater(BigDecimal money, long clienttype,
			long orgid) {
		String sql = "select ROUND((integrate/price)*:money) as integrater from packintegraterule where type=0 and clienttype=:clienttype and orgid=:orgid";
		Query query = getEntityManager().createQuery(sql);
		query.setParameter("money", money);
		query.setParameter("clienttype", clienttype);
		query.setParameter("orgid", orgid);
		List<Object> result = query.getResultList();
		return result;
	}

	public List<Object> queryPercent(String clienttype, long orgid) {
		String sql = "select price/integrate as percent from packintegraterule where type=1 and clienttype=:clienttype and orgid=:orgid";
		Query query = getEntityManager().createNativeQuery(sql);
		query.setParameter("clienttype", clienttype);
		query.setParameter("orgid", orgid);
		List<Object> result = query.getResultList();
		return result;
	}

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select p,org.name as orgname,cu.name as createname,uu.name as updatename from PackIntegrateRule p,Organization org,Userinfo cu,Userinfo uu   where 1=1  and p.orgid=org.id  and cu.id=p.createby and uu.id=p.updateby");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public List<Object> query(String clienttype, long orgid, int type) {
		String sql = "select p from PackIntegrateRule p where p.orgid=:orgid and p.type=:type and p.clienttype=:clienttype";
		Query query = getEntityManager().createQuery(sql);
		query.setParameter("clienttype", clienttype);
		query.setParameter("orgid", orgid);
		query.setParameter("type", type);
		return query.getResultList();
	}
}
