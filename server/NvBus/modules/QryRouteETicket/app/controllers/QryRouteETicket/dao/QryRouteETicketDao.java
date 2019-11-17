package controllers.QryRouteETicket.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

public class QryRouteETicketDao extends EntityManagerDaoSurport {

	/**
	 * 
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryRouteETicket(
			List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select org.name as orgname,r.name as routename, t.departdate as departdate,st.name as departname,count(*) as tickets, sum(t.price) as totalprice  ")
				.append(" from Ticketsell t, ")
				.append(" ticketsellother tt, ")
				.append(" route           r, ")
				.append(" organization    org, ")
				.append(" schedule        s, ")
				.append(" station         st ")
				.append(" where t.id = tt.ticketsellid ")
				.append("  and t.iseticketsell = 1 ")
				.append("  and t.iseticketsell = 1 ")
				.append("  and t.scheduleid=s.id  ")
				.append(" and t.departstationid = st.id ")
				.append(" and s.routeid = r.id and t.orgid = org.id and tt.istaked = 0 and t.ticketstatus = '0' ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
	sql.append(" group by org.name, r.name, t.departdate, st.name ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	
}
