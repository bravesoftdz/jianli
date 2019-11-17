package cn.nova.bus.log.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")

public class OperationlogDao extends EntityManagerDaoSurport {

	public IDAO<Ticketsell> dao;
	
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder("select o ,u.name as username ")
		.append(" from Operationlog o,Userinfo u where o.userid = u.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList,true));
		sql.append(" order by o.operatetime desc ");
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
}
