package cn.nova.bus.sale.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class TicketdeliverdetailDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select t, s.code as schedulecode, st.name as reachname, ts.departdate, ts.departtime, ts.seatno, ");
		sql.append(" u.name as createname, td.area, td.address from Ticketdeliverdetail t, Ticketsell ts, Schedule s, ");
		sql.append(" Station st, Userinfo u, Ticketdeliver td where t.ticketno =ts.ticketno and ");
		sql.append(" ts.scheduleid=s.id and ts.reachstationid=st.id and t.createby=u.id and t.deliverid=td.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public List getResult(Long deliverid, String ticketno) {
		StringBuffer sql = new StringBuffer(
				"select t from Ticketdeliverdetail t where t.deliverid=");
		sql.append(deliverid);
		sql.append(" and t.ticketno='");
		sql.append(ticketno);
		sql.append("'");
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	public List getResultByTicketno(String tablename, String ticketno) {
		StringBuffer sql = new StringBuffer("select t from ");
		sql.append(tablename);
		sql.append(" t where t.ticketno='");
		sql.append(ticketno);
		sql.append("'");
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	public boolean isDeparted(String ticketno) {
		StringBuffer sql = new StringBuffer(
				"select t.isdeparted from Schedulestatus t where t.id=");
		sql.append(" (select max(s.id) from Schedulestatus s, Ticketsell ti ");
		sql.append(" where s.scheduleplan.id=ti.scheduleplanid and ti.ticketno=:ticketno)");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketno", ticketno);
		return (Boolean) query.getSingleResult();
	}

}
