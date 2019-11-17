package cn.nova.bus.balance.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

public class TicketTurnOverOtherDao extends EntityManagerDaoSurport {
	public List<Object> qryTicketTurnOverOther(
			List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select o.name as orgname,tto.tickettime as tickettime, ")
				.append(" tto.money as money,u1.name  as seller,tto.remarks as remarks, ")
				.append("  tto.createtime as createtime,u2.name as updateby, ")
				.append(" tto.updatetime as updatetime from ticketturnoverother tto ")
				.append(" left join organization o on o.id = tto.orgid ")
				.append(" left join userinfo u1 on u1.id = tto.seller ")
				.append(" left join userinfo u2 on u2.id = tto.updateby ")
				.append(" where 1=1  ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
}
