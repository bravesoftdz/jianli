package cn.nova.bus.dispatch.dao;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.persistence.LockModeType;
import javax.persistence.Query;

import util.DateUtils;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.model.Seatreserve;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class SeatreserveDao extends EntityManagerDaoSurport {

	public List getlist(short seatno, String sellstate) {
		StringBuffer sql = new StringBuffer(
				"select t from Seatreserve t where t.setatno=");
		sql.append(seatno);
		if (sellstate.equals("R")) {
			sql.append(" and (t.sellstate='R' or t.sellstate='S'");
		}
		if (sellstate.equals("C")) {
			sql.append(" and t.sellstate='C'");
		}
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	public Seatreserve getSeatreserve(Long scheduleplanid, Date departdate,
			short seatno) {
		StringBuffer sql = new StringBuffer(
				"select t from Seatreserve t where t.scheduleplanid=:scheduleplanid");
		if (departdate != null) {
			sql.append(" and t.departdate=:departdate ");
		}
		sql.append(" and t.sellstate='R' and t.seatno=:seatno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		if (departdate != null) {
			query.setParameter("departdate", departdate);
		}
		query.setParameter("seatno", seatno);
		if (query.getResultList().isEmpty()) {
			return null;
		}
		return (Seatreserve) query.getSingleResult();
	}

	public Long getId(Long scheduleplanid, short seatno) {
		StringBuffer sql = new StringBuffer(
				"select t.id from Seatreserve t where t.scheduleplanid=");
		sql.append(scheduleplanid);
		sql.append(" and t.seatno=");
		sql.append(seatno);
		Query query = getEntityManager().createQuery(sql.toString());
		return (Long) query.getSingleResult();
	}

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select t.id, t.departdate, trim(t.departtime), ")
				.append("   t.fullprice, ")
				.append(" t.seatno, t.serviceprice, t.reservetime,t.sellstate,")
				.append(" t.createtime, t.updatetime, sc.code as schedulecode, o.name as orgname, t.sellstate,")
				.append(" st.name as departstationname, sn.name as reachstationname, ti.name as ticketoutletname, ")
				.append(" u.name as reservename, us.name as createname, ui.name as updatename, r.name as routename, ")
				.append(" tt.name as tickettypename, c.name as customername, c.certificatetype, c.certificateno, c.familyphone,")
				.append(" c.mobilephone, t.customerid, t.autocanceltime, t.scheduleplanid, t.canceltime, t.isautocancel ")
				.append(" from seatreserve t left join station st on ")
				.append(" t.departstationid=st.id left join station sn on t.reachstationid=sn.id ")
				.append(" left join tickettype tt on t.tickettype=tt.code left join customer c on t.customerid=c.id, ")
				.append(" schedule sc, organization o, ticketoutlets ti, ")
				.append(" userinfo u, userinfo us, userinfo ui, route r ")
				.append(" where t.scheduleid=sc.id and t.orgid=o.id and t.ticketoutletsid=ti.id ")
				.append("and t.reserveby=u.id and  t.createby=us.id and t.updateby=ui.id and ")
				.append("sc.routeid=r.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		
		sql.append(" union all ");
		
		sql.append("select t.id, t.departdate, trim(t.departtime), t.fullprice, t.seatno, ")
			.append(" t.serviceprice, t.reservetime, t.sellstate, t.createtime, t.updatetime, ")
			.append(" t.schedulecode as schedulecode, o.name as orgname, t.sellstate, ")
			.append(" st.name as departstationname, sn.name as reachstationname, ")
			.append(" ti.name as ticketoutletname, u.name as reservename, ")
			.append(" us.name as createname, ui.name as updatename, t.routename as routename, ")
			.append(" tt.name as tickettypename, c.name as customername, c.certificatetype, ")
			.append(" c.certificateno, c.familyphone, c.mobilephone, t.customerid, ")
			.append(" t.autocanceltime, t.scheduleplanid, t.canceltime, t.isautocancel ")
			.append("from seatreserveagent t  ")
			.append(" left join station st on t.departstationid = st.id ")
			.append(" left join station sn on t.reachstationid = sn.id ")
			.append(" left join tickettype tt on t.tickettype = tt.code ")
			.append(" left join customer c on t.customerid = c.id ")
			.append(" left join scheduleplan sp on t.scheduleplanid = sp.id ")
			.append(" left join schedule sc on sp.scheduleid = sc.id, ")
			.append(" organization o, ticketoutlets ti, userinfo u, userinfo us, userinfo ui ")
			.append(" where t.orgid = o.id and t.ticketoutletsid = ti.id ")
			.append(" and t.reserveby = u.id and t.createby = us.id ")
			.append(" and t.updateby = ui.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Seatreserve> querySeatreserve(Date date) {
		StringBuffer sql = new StringBuffer(
				"select t from Seatreserve t where t.sellstate='R' ");
		sql.append(" and t.isautocancel='1' and t.autocanceltime<=:date");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("date", date);
		query.setLockMode(LockModeType.PESSIMISTIC_READ);
		return query.getResultList();
	}
	
	public int querybookunsellcount(long customerid) {
		StringBuffer sql = new StringBuffer("select count(*) from seatreserve t");
		sql.append("  where ( (t.sellstate<>'S' and t.departdate=trunc(sysdate)) ")
			.append("   	  or (t.sellstate='C' and t.departdate=trunc(sysdate)))")
			.append("   and (t.cancelby is null or t.cancelby=0)")
			.append("   and t.reservetime>sysdate-365")
			.append("   and t.customerid=").append(customerid);
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return Integer.parseInt(query.getSingleResult().toString());
	}
	
	@SuppressWarnings("unchecked")
	public Ticketsell findTicketByseatno(Long scheduleplanid, short seatno) {
		StringBuffer sql = new StringBuffer(
				"select t from Ticketsell t where t.scheduleplanid=:scheduleplanid");
		sql.append(" and t.seatno=:seatno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("seatno", seatno);
		query.setLockMode(LockModeType.PESSIMISTIC_READ);
		List<Ticketsell> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	//通过班次计划ID查询留位记录
	public List getreservelist(Long scheduleplanid) {
		
		StringBuffer sql = new StringBuffer("select t from Seatreserve t ");
		sql.append(" where (t.sellstate='R' or t.sellstate='S') "); 
		sql.append(" and t.scheduleplanid= :scheduleplanid ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		
		return query.getResultList();
	}

	public Schedulestatus querySchedulestatusByScheduleplanid(Long scheduleplanid, long departstationid) {
		StringBuffer sql = new StringBuffer("select t from Schedulestatus t ");
		sql.append(" where t.scheduleplan.id = :scheduleplanid and t.departstationid = :departstationid ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("departstationid", departstationid);
		List resultList = query.getResultList();
		return (Schedulestatus) (!resultList.isEmpty()? resultList.get(0) : null);
	}
	/**
	 * 查询发班超过addReport分钟的班次计划id
	 * @param addReport
	 * @return
	 */
	public List<Object> queryDepartSchedule(String addReport) {
		List<String> rList = new ArrayList<String>(); 
		Date currenttime = new Date();
		StringBuffer sql = new StringBuffer(" select tt.scheduleplanid, least(rationseatnum - seatnum, seatnum - ticketnum) ");
		sql.append("   from (select dp.scheduleplanid,max(v.rationseatnum) rationseatnum,max(sp.seatnum) seatnum, ")
		.append(" sum(dp.ticketnum) ticketnum from   departinvoices dp ")
		.append(" left join schedule s on dp.scheduleid=s.id ")
		.append(" left join scheduleplan sp on dp.scheduleplanid=sp.id ")
		.append(" left join vehicle v on dp.vehicleid = v.id ")
		.append(" where s.islinework='0' and dp.status='0' and dp.departdate=:departdate and sp.worktype<>'3'  ")
		.append(" and sp.seatnum=sp.soldeatnum and to_date(dp.departtime,'HH24:MI')<to_date(:departtime,'HH24:MI') group by dp.scheduleplanid) tt ")
		.append(" union ")
		.append(" select ts.scheduleplanid, ")
		.append(" least(max(tt.rationseatnum) - max(seatnum), count(ts.id) - max(ticketnum)) ")
		.append(" from (select dp.scheduleplanid, ")
		.append("                max(v.rationseatnum) rationseatnum, ")
		.append("                max(sp.seatnum) seatnum, ")
		.append("                sum(dp.ticketnum) ticketnum ")
		.append("           from departinvoices dp ")
		.append("           left join schedule s ")
		.append("             on dp.scheduleid = s.id ")
		.append("           left join scheduleplan sp ")
		.append("             on dp.scheduleplanid = sp.id ")
		.append("           left join vehicle v ")
		.append("             on dp.vehicleid = v.id ")
		.append("          where  ")
		.append("          s.islinework = '0' ")
		.append("            and dp.status = '0' ")
		.append("            and dp.departdate =:departdate  ")
		.append("            and sp.worktype='3' and to_date(dp.departtime,'HH24:MI')<to_date(:departtime,'HH24:MI') ")
		.append("          group by dp.scheduleplanid)tt ")
		.append(" left join ticketsell ts on tt.scheduleplanid=ts.scheduleplanid   ")
		.append(" where ts.departdate=:departdate and ts.ticketstatus='0' ")
		.append(" group by ts.scheduleplanid ");
		
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("departdate", DateUtils.mergerDateAndTime(currenttime, "00:00"));
		SimpleDateFormat sf = new SimpleDateFormat("HH:mm");
		currenttime = DateUtils.add(currenttime, Calendar.MINUTE, 0-Integer.valueOf(addReport));
		String time = sf.format(currenttime);
		query.setParameter("departtime", time);
		List<Object> list = query.getResultList();
		return list;
	}
}
