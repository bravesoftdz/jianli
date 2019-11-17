/**
 * 
 */
package cn.nova.bus.base.dao;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.base.model.Ticketreturnrate;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * @author ice
 *
 */
public class TicketreturnrateDao extends
		EntityManagerDaoSurport<Ticketreturnrate> {

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters) {
		StringBuilder sb = new StringBuilder();
		sb.append("select ttr,ttr.prerate*100 as prerate100,uc.name as createbyname,uu.name as updatebyname,o.name as orgname")
		.append(" from Ticketreturnrate ttr,Userinfo uc,Userinfo uu,Organization o")
		.append(" where ttr.createby=uc.id")
		.append("   and ttr.updateby=uu.id")
		.append("   and ttr.orgid=o.id");
		sb.append(PropertyFilter.toJpql(propertyFilters,true));
		sb.append(" order by ttr.orgid,ttr.timepoint desc");
		Query query = super.getEntityManager().createQuery(sb.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		List<Object> result = query.getResultList();
		return ListUtil.listToMap(new Object[]{Ticketreturnrate.class,"prerate100","createbyname","updatebyname","orgname"}, 
				result,
				new Object[]{Ticketreturnrate.class,BigDecimal.class,String.class,String.class,String.class});
	}
	
}
