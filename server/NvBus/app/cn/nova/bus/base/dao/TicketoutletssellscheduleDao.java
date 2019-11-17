package cn.nova.bus.base.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class TicketoutletssellscheduleDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList,
			String type) {
		StringBuffer sql = new StringBuffer("select t.createtime, t.updatetime, t.enddate, ");
		sql.append(" t.startdate, t.id, ti.name as ticketname, ");
		sql.append(" us.name as createname, use.name as updatename, dic.value , ");
		sql.append(" case t.type when '0' then ('全部班次') ");
		sql.append(" when '1' then (select r.name from Route r where t.typeid=r.id ) ");
		sql.append(" when '2' then (select s.code from Schedule s where t.typeid=s.id) end as typename ");
		sql.append(" from Ticketoutletssellschedule t, Ticketoutlets ti, ");
		sql.append(" Userinfo us, Userinfo use, Digitaldictionary dig, Digitaldictionarydetail dic ");
		sql.append(" where t.ticketoutletsid=ti.id and t.createby=us.id and t.updateby=use.id ");
		sql.append(" and dig.tablename='sellschedule' and dig.columnname='type' ");
		sql.append(" and dic.digitaldictionaryid=dig.id and dic.code=t.type ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();

	}

	public boolean isExist(Long ticketoutletid, String type, Long typeid) {
		StringBuffer sql = new StringBuffer(
				"select t from Ticketoutletssellschedule t ");
		if (type.equals("0")) {
			sql.append(" where t.type=0 and t.typeid=0");
		} else if (type.equals("1")) {
			sql.append(", Route r where t.type=1 and t.typeid=r.id and r.id=");
			sql.append(typeid);
		} else if (type.equals("2")) {
			sql.append(", Schedule s where t.type=2 and t.typeid=s.id and s.id=");
			sql.append(typeid);
		}
		sql.append(" and t.ticketoutletsid=");
		sql.append(ticketoutletid);
		Query query = getEntityManager().createQuery(sql.toString());
		List list = query.getResultList();
		if (list.isEmpty()) {
			return false;
		}
		return true;
	}

	public String getValue(Long ticketoutletid, String type, Long typeid) {
		StringBuffer sql = new StringBuffer(
				"select t from Ticketoutletssellschedule t ");
		if (type.equals("0")) {
			sql.append(" where t.type=0 and t.typeid=0");
		} else if (type.equals("1")) {
			sql.append(", Route r where t.type=1 and t.typeid=r.id and r.id=");
			sql.append(typeid);
		} else if (type.equals("2")) {
			sql.append(", Schedule s where t.type=2 and t.typeid=s.id and s.id=");
			sql.append(typeid);
		}
		sql.append(" and t.ticketoutletsid=");
		sql.append(ticketoutletid);
		Query query = getEntityManager().createQuery(sql.toString());
		return (String) query.getSingleResult();
	}

}
