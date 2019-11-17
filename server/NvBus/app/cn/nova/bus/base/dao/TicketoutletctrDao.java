package cn.nova.bus.base.dao;

import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.base.service.TicketoutletctrService;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class TicketoutletctrDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> queryTicketoutletsctr(
			List<PropertyFilter> buildFromHttpRequest) {
		StringBuffer sql = new StringBuffer("select tc.id id,tc.ticketoutletsid ticketoutletsid, t.name ticketoutletsname,")
				.append(" tc.carrychildrate carrychildrate,")
				.append(" tc.maxsellmoney maxsellmoney,")
				.append(" uc.name createname,")
				.append(" tc.createtime createtime,")
				.append(" uu.name updatename,")
				.append(" tc.updatetime updatetime")
				.append(" from ticketoutletsctr tc")
				.append(" left join ticketoutlets t on tc.ticketoutletsid = t.id")
				.append(" left join userinfo uc on uc.id = tc.createby")
				.append(" left join userinfo uu on uu.id = tc.updateby")
				.append(" where 1=1")
				.append(PropertyFilter.toJpql(buildFromHttpRequest, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, buildFromHttpRequest);
		return query.getResultList();
	}
}
