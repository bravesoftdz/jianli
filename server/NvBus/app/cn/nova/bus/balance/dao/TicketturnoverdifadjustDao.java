package cn.nova.bus.balance.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

public class TicketturnoverdifadjustDao extends EntityManagerDaoSurport{
	public List<Object> find(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select t.id,t.moneydate,t.seller,t.difmoney,t.orgid,t.remark,")
		.append(" t.createtime,t.createby,t.updatetime,t.updateby,u.name sellername,")
		.append("u1.name createbyname,u2.name updatebyname")
		.append(" from ticketturnoverdifadjust t, userinfo u, userinfo u1, userinfo u2")
		.append(" where t.seller = u.id and t.createby = u1.id and t.updateby = u2.id ")
		.append(PropertyFilter.toJpql(propertyFilterList,true));
		sql.append(" order by t.updatetime desc ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
}
