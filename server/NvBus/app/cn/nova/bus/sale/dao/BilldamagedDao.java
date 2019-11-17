package cn.nova.bus.sale.dao;

import java.math.BigDecimal;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class BilldamagedDao extends EntityManagerDaoSurport {

	/**
	 * 坏票登记查询
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select t, b.name as billtypename, u.name as recordname, ")
				.append(" ti.name as ticketname, us.name as createname, use.name as updatename ")
				.append(" from Billdamaged t, Billtype b, Userinfo u, Ticketoutlets ti, Userinfo us, ")
				.append(" Userinfo use, Billinuse bi where t.billtypeid=b.id and t.recordby=u.id and ")
				.append(" t.ticketoutletsid=ti.id and t.createby=us.id and t.updateby=use.id and t.billinuseid=bi.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public boolean checkNoIsuse(String damagedstartno) {
		StringBuilder sql = new StringBuilder(" select sum(id) from ( ");
		sql.append(" select count(ts.id) as id from ticketsell ts where ts.ticketno = :damagedstartno union all ")
				.append(" select count(ts.id) as id from insurance ts where ts.insuranceno = :damagedstartno union all ")
				.append(" select count(ts.id) as id from ticketsellagent ts where ts.ticketno = :damagedstartno union all ")
				.append(" select count(ts.id) as id from departinvoices ts where ts.departinvoicesno = :damagedstartno union all ")
				.append(" select count(ts.id) as id from balance ts where ts.balanceno = :damagedstartno union all ")
				.append(" select count(ts.id) as id from packarriver ts where ts.packarriverno = :damagedstartno union all ")
				.append(" select count(ts.id) as id from pack ts where ts.packno = :damagedstartno )         ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("damagedstartno", damagedstartno);
		BigDecimal singleResult = (BigDecimal) query.getSingleResult();
		return singleResult.compareTo(BigDecimal.ZERO) > 0 ? true : false;
	}
	
}
