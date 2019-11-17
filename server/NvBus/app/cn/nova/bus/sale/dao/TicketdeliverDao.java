package cn.nova.bus.sale.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class TicketdeliverDao extends EntityManagerDaoSurport {

	/**
	 * 送票记录查询
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select t, o.name as orgname, us.name as createname, ui.name as updatename ");
		sql.append(" from Ticketdeliver t, Organization o, Userinfo us, Userinfo ui ");
		sql.append("  where t.orgid=o.id and t.createby=us.id and t.updateby=ui.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	/**
	 * 送票记录明细查询
	 * @param id
	 * @return
	 */
	public boolean hasRecord(Long id) {
		StringBuffer sql = new StringBuffer(
				"select t from Ticketdeliverdetail t where t.deliverid=");
		sql.append(id);
		Query query = getEntityManager().createQuery(sql.toString());
		List list = query.getResultList();
		if (list.isEmpty()) {
			return false;
		}
		return true;
	}

}
