package cn.nova.bus.report.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

public class SellerTaskDao extends EntityManagerDaoSurport{
	public List<Object> query(List<PropertyFilter> propertyFilter) {
		
		StringBuffer sql = new StringBuffer("select uf.name as seller,uf.code as code,count(1) as soldnum,sum(ts.price) as soldmoney,")
		.append(" sum(case ts.ticketstatus when '1' then 1 else 0 end) as returnnum,")
		.append(" sum(case ts.ticketstatus when '1' then ts.price else 0 end)as returnmoney,")
		.append(" sum(case ts.ticketstatus when '2' then 1 else 0 end)as cancelnum,")
		.append(" sum(case ts.ticketstatus when '2' then ts.price else 0 end)as canclemoney,")
		.append(" sum(case ts.ticketstatus when '0' then 1 else 0 end) as totalnum,")
		.append(" sum(case ts.ticketstatus when '0' then ts.price else 0 end) as totalmoney ")
		.append(" from ticketsell ts left join userinfo uf on ts.sellby=uf.id  where 1=1 ");
		sql.append(PropertyFilter.toJpql(propertyFilter, true));
		sql.append(" group by uf.name,uf.code");		
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilter);
		return query.getResultList();
	}
}
