package cn.nova.bus.dispatch.dao;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.LockModeType;
import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.price.model.Ticketpriceitem;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("rawtypes")
public class TicketpriceDao extends EntityManagerDaoSurport<Ticketprice> {

	@SuppressWarnings("unchecked")
	public List<Ticketprice> getByScheduleplanid(Long scheduleplanid) {
		return getByScheduleplanid(LockModeType.NONE, scheduleplanid);
	}

	public List<Ticketprice> getByScheduleplanid(LockModeType lockModeType,Long scheduleplanid) {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", scheduleplanid));
		return super.find(lockModeType,Ticketprice.class,propertyFilters);
	}

	public List<Ticketprice> getByScheduleplanSeattype(long scheduleplanid, String seattype) {
		return getByScheduleplanSeattype(LockModeType.NONE, scheduleplanid, seattype);
	}

	public List<Ticketprice> getByScheduleplanSeattype(LockModeType lockModeType,long scheduleplanid, String seattype) {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", scheduleplanid));
		propertyFilters.add(new PropertyFilter("EQS_t!seattype", seattype));
		return super.find(lockModeType,Ticketprice.class,propertyFilters);
	}

	public List<Map<String, Object>> findSchedulestops(
			List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer();
		sql.append(
				"select distinct std.name as departstationname,str.name as reachstationname, ")
				.append(" t.runtime,t.distance,so.orderno,t.fullprice,t.halfprice,t.studentprice,t.seattype")
				.append(" from Ticketprice t,Station std,Station str,Schedulestop so")
				.append(" where t.departstationid=std.id")
				.append("   and t.reachstationid=str.id")
				.append("   and t.reachstationid=so.stationid")
				.append("   and t.scheduleid=so.schedule.id");
		propertyFilterList.add(new PropertyFilter("EQB_t!issellable", true));
		sql.append(PropertyFilter.toJpql(propertyFilterList, true)).append(
				" order by so.orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		// Query query =
		// super.getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		List<Object> result = query.getResultList();
		return ListUtil.listToMap(new Object[] { "departstationname",
												"reachstationname", "runtime", "distance", "orderno"
												,"fullprice","halfprice","studentprice","seattype"
												}
								, result
								, new Object[] { String.class, String.class,
												BigDecimal.class, Integer.class, Integer.class
												,BigDecimal.class,BigDecimal.class,BigDecimal.class,String.class
												}
								);
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryStopstation(long scheduleplanid) {
		StringBuffer sql = new StringBuffer(
				"select t.reachstationid, t.departstationid, ");
		sql.append(" t.scheduleplan.id as scheduleplanid, t.issellable ");
		sql.append(" from Ticketprice t where t.scheduleplan.id=:scheduleplanid ");
		sql.append(" group by t.departstationid, t.reachstationid, t.scheduleplan.id, t.issellable ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryRouteschedule(
			List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer("select t, 0 as checked ");
		sql.append(" from Route r, Schedule t where t.route.id=r.id and  (t.isactive=1 or (t.isactive=0 and t.isovertime=1 and t.updatetime >= sysdate -30)) and t.isdelete = 0 ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Ticketprice> getByTicket(long scheduleplanid, Long reachstationid) {
		StringBuffer sql = new StringBuffer("select t from Ticketprice t");
		sql.append(" where t.scheduleplan.id=:scheduleplanid and t.reachstationid=:reachstationid")
		.append(" and t.departstationid=:departstationid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("reachstationid", reachstationid);
		//query.setParameter("departstationid", departstationid);		
		if (query.getResultList().size() == 0) {
			return null;
		}
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public List<Ticketprice> qryTicketprices(Date departdate, long scheduleid) {
		StringBuffer sql = new StringBuffer("select t from Ticketprice t");
		sql.append(" where t.departdate=:departdate and t.scheduleid=:scheduleid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Ticketprice> getByscheduleid(long scheduleid, Date departdate) {
		StringBuffer sql = new StringBuffer("select t from Ticketprice t");
		sql.append(" where t.scheduleid=:scheduleid and t.departdate=:departdate");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("departdate", departdate);
		if (query.getResultList().size() < 1) {
			return null;
		}
		return query.getResultList();
	}
	
	public Ticketpriceitem findPriceitem(long priceid, String tickettype) {
		StringBuffer sql = new StringBuffer("select t from Ticketpriceitem t, ");
		sql.append(" Ticketpriceformulaitem tf where t.ticketprice.id=:priceid and t.tickettype=:tickettype ");
		sql.append(" and t.ticketpriceformulaitemid=tf.id and tf.isfreight='1'");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("priceid", priceid);
		query.setParameter("tickettype", tickettype);
		if (query.getResultList().size() < 1) {
			return null;
		}
		return (Ticketpriceitem) query.getSingleResult();
	}

	public BigDecimal getIsfreight(long priceid, String tickettype) {
		StringBuffer sql = new StringBuffer(
				"select sum(t.price) from Ticketpriceitem t, ");
		sql.append(" Ticketpriceformulaitem tf where t.ticketpriceid=:priceid and t.tickettype=:tickettype ");
		sql.append(" and t.ticketpriceformulaitemid=tf.id and tf.isfreight='0'");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("priceid", priceid);
		query.setParameter("tickettype", tickettype);
		if (query.getResultList().size() < 1) {
			return new BigDecimal(0);
		}
		return (BigDecimal) query.getSingleResult();
	}
	
	@SuppressWarnings("unchecked")
	public Ticketprice getBySeattype(long scheduleplanid,long departstationid,
			Long reachstationid, String seattype) {
		StringBuffer sql = new StringBuffer("select t from Ticketprice t");
		sql.append(" where t.scheduleplan.id=:scheduleplanid and t.reachstationid=:stationid ");
		sql.append(" and t.seattype=:seattype and t.departstationid=:departstationid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("departstationid", departstationid);
		query.setParameter("stationid", reachstationid);
		query.setParameter("seattype", seattype);
		List<Ticketprice> list=query.getResultList();
		return  list!=null&&list.size()>0?list.get(0):null;
	}
	
}
