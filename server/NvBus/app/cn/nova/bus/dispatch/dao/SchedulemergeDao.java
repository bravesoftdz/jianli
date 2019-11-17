package cn.nova.bus.dispatch.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.model.Schedulemerge;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.price.model.Ticketpriceitem;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：班次并班</b><br/>
 * <b>类名称：</b>SchedulemergeDao<br/>
 * <b>创建人：</b>ljh</a><br/>
 * <b>关键修改：</b>添加查询条件：被并班次发车日期，和查询结果，被并班次发车日期<br/>
 * <b>修改时间：</b>hhz<br/>
 * <b>修改人：</b>20130606<br/>
 * 
 */
@SuppressWarnings("rawtypes")

public class SchedulemergeDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select t,o.name as orgname, sc.code as olecode, se.code as newcode, u.name as createname, ")
				.append("us.name as username, sd.code as plancode,ols.departdate as olddepartdate ")
				.append(" from Schedulemerge t, Organization o,")
				.append(" 	Scheduleplan s, Schedule sc, Schedule sd, Schedule se, Userinfo u, Userinfo us,Scheduleplan ols ")
				.append(" where t.scheduleplanid=s.id and t.orgid=o.id and s.scheduleid=sd.id and t.oldscheduleid=sc.id ")
				.append(" 	and t.newscheduleid=se.id and t.createby=u.id and t.userid=us.id and t.oldscheduleplanid=ols.id ")
				.append(" and t.iscancel = '0' ")// 李电志  2015年6月30日 19:17:39 add  是否取消，0：否，1：是。
				.append(" and t.isactive = '1' ");//姜蓥瑞 2015年8月3日14:45:16 是否激活 0：否，1：是
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public Schedulemerge getByplanid(Long scheduleplanid) {
		StringBuffer sql = new StringBuffer(
				"select t from Schedulemerge t where t.scheduleplanid=");
		sql.append(scheduleplanid);
		Query query = getEntityManager().createQuery(sql.toString());
		return (Schedulemerge) query.getSingleResult();
	}

	public Long getrouteid(Long schedleid) {
		StringBuffer sql = new StringBuffer(
				"select t.route.id from Schedule t where t.id=");
		sql.append(schedleid);
		Query query = getEntityManager().createQuery(sql.toString());
		return (Long) query.getSingleResult();
	}

	@SuppressWarnings("unchecked")
	public List<Ticketprice> getTicketprice(Long scheduleplanid, Long scheduleid) {
		StringBuffer sql = new StringBuffer(
				"select t from Ticketprice t where t.scheduleplan.id=");
		sql.append(scheduleplanid).append(" and t.scheduleid=")
				.append(scheduleid);
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	public short getSeatnum(Long scheduleid, Date departdate) {
		StringBuffer sql = new StringBuffer(
				"select (t.seatnum-t.soldeatnum) as seatnum from Scheduleplan t where t.scheduleid=");
		sql.append(scheduleid).append(" and t.departdate=:departdate");
		Query query = getEntityManager().createQuery(sql.toString())
				.setParameter("departdate", departdate);
		return (Short) query.getSingleResult();
	}

	public short getSoldeatnum(Long scheduleid, Date departdate) {
		StringBuffer sql = new StringBuffer(
				"select t.soldeatnum from Scheduleplan t where t.scheduleid=");
		sql.append(scheduleid).append(" and t.departdate=:departdate");
		Query query = getEntityManager().createQuery(sql.toString())
				.setParameter("departdate", departdate);
		return (Short) query.getSingleResult();
	}

	public boolean isdeparted(Long scheduleplanid) {
		StringBuffer sql = new StringBuffer(
				"select t.isdeparted from Schedulestatus t where t.scheduleplan.id=");
		sql.append(scheduleplanid);
		Query query = getEntityManager().createQuery(sql.toString());
		return (Boolean) query.getSingleResult();
	}

	public boolean isbegincheck(Long scheduleplanid) {
		StringBuffer sql = new StringBuffer(
				"select t.isbegincheck from Schedulestatus t where t.scheduleplan.id=");
		sql.append(scheduleplanid);
		Query query = getEntityManager().createQuery(sql.toString());
		return (Boolean) query.getSingleResult();
	}

	public String getdeparttime(Long scheduleplanid, Date departdate) {
		StringBuffer sql = new StringBuffer(
				"select min(t.departtime) from Schedulestatus t where t.scheduleplan.id=");
		sql.append(scheduleplanid).append(" and t.departdate=:departdate");
		Query query = getEntityManager().createQuery(sql.toString())
				.setParameter("departdate", departdate);
		return (String) query.getSingleResult();
	}

	public List getSchedulestatuslog(Long scheduleid, Date departdate) {
		StringBuffer sql = new StringBuffer(
				"select t.departtime from Schedulestatuslog t where t.scheduleid=");
		sql.append(scheduleid).append(" and t.departdate=:departdate");
		Query query = getEntityManager().createQuery(sql.toString())
				.setParameter("departdate", departdate);
		return query.getResultList();
	}

	public Ticketsell getTicketsell(Long scheduleplanid, short seatno) {
		StringBuffer sql = new StringBuffer("select t from Ticketsell t ");
		sql.append(" where t.scheduleplanid=:scheduleplanid and ");
		sql.append(" t.seatno=:seatno and t.ticketstatus='0'");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("seatno", seatno);
		if (query.getResultList().size() < 1) {
			return null;
		}
		return (Ticketsell) query.getSingleResult();
	}

	public Long getId() {
		StringBuffer sql = new StringBuffer(
				"select max(t.id) from Schedulemerge t");
		Query query = getEntityManager().createQuery(sql.toString());
		return (Long) query.getSingleResult();
	}

	@SuppressWarnings("unchecked")
	public List<Object> querySchedule(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select t,r.name as routename, ss.departtime as departtime, r.id as routeid, ")
				.append(" tp.fullprice from Scheduleplan t, Schedule s, Route r, ")
				.append(" Schedulestatus ss, Ticketprice tp where t.scheduleid=s.id and ")
				.append(" s.route.id=r.id and ss.scheduleplan.id=t.id and tp.scheduleplan.id=t.id ")
				.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public boolean isMerge(Long oldscheduleid, Long oldscheduleplanid) {
		StringBuffer sql = new StringBuffer("select t from Schedulestatus t ");
		sql.append(" where t.scheduleplan.id=:oldscheduleplanid and t.scheduleid=:oldscheduleid and ");
		sql.append(" t.status=3");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("oldscheduleplanid", oldscheduleplanid);
		query.setParameter("oldscheduleid", oldscheduleid);
		if (query.getResultList().isEmpty()) {
			return false;
		}
		return true;
	}

	public List getScheduleseats(Long scheduleplanid) {
		StringBuffer sql = new StringBuffer("select t from Scheduleseats t ");
		sql.append(" where t.scheduleplan.id=");
		sql.append(scheduleplanid);
		return find(sql.toString());
	}

	public Ticketpriceitem getTicketpriceitem(long ticketpriceid, String code) {
		StringBuffer sql = new StringBuffer(
				"select t from Ticketpriceitem t,Ticketpriceformulaitem tp ");
		sql.append(
				" where t.ticketpriceformulaitemid=tp.id and t.ticketprice.id="
						+ ticketpriceid)
				.append(" and t.tickettype='Q' and tp.code='" + code + "'");
		List<Ticketpriceitem> list = find(sql.toString());
		if (list != null && list.size() > 0) {
			return list.get(0);
		} else {
			return null;
		}
	}
}
