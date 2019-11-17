package cn.nova.bus.dispatch.dao;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import play.db.jpa.JPA;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.model.UpdateScheduleSeats;
import cn.nova.bus.dispatch.model.UpdateSeatReserve;
import cn.nova.bus.dispatch.model.UpdateTicketSell;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.price.model.Ticketpriceitem;

@SuppressWarnings("rawtypes")
public class SchPlanDao extends EntityManagerDaoSurport {
	public List<UpdateTicketSell> queryTicketSell4Update(long scheduleplanid){
		StringBuilder sql = new StringBuilder()
		.append("select rownum as id, t.turnoverdetailid, t.sellby, st1.synccode as departstationsynccode, st2.synccode as reachstationsynccode, ")
		.append("sp.synccode as scheduleplansynccode, u3.name as sellbyname, t.ticketentrance, t.ticketoutletsid, t.ticketoutletsname, ")
		.append("u2.name as updatebyname, u1.name as createbyname, t.buspark, t.discountrate, t.distance, t.fullprice, t.islinework, t.paymethod, ")
		.append("t.price, t.carrychildnum, t.seatno, t.sellip, t.selltime, t.sellway, t.batchno, t.ticketno, t.orderno, t.seattype, t.ticketstatus, ")
		.append("t.tickettype, t.moreprice, t.waterfee, t.insurefee, t.otherfee, t.servicefee, t.toplimitprice, t.fueladditionfee, ")
		.append("t.stationservicefee, t.computefee, t.coolairfee, t.additionfee from Ticketsell t ")
		.append("left join Userinfo u1 on t.createby =  u1.id left join Userinfo u2 on t.updateby =  u2.id left join USerinfo u3 on t.sellby = u3.id ")
		.append("left join Scheduleplan sp on t.scheduleplanid = sp.id left join Station st1 on t.departstationid = st1.id  ")
		.append("left join Station st2 on t.reachstationid = st2.id ")
		.append("where t.scheduleplanid = :scheduleplanid");
		
		Query query = JPA.em().createNativeQuery(sql.toString(), UpdateTicketSell.class);
		query.setParameter("scheduleplanid", scheduleplanid);
		return query.getResultList();
	}
	
	public List<UpdateSeatReserve> querySeatReserve4Update(long scheduleplanid){
		StringBuilder sql = new StringBuilder()
		.append("select rownum as id, t.autocanceltime, u2.name as cancelby, t.canceltime, t.isautocancel, t.remarks, u1.name as reserveby,  ")
		.append("t.reserveip, t.reservetime, t.reserveway, t.seatno, t.sellstate, t.serviceprice, tt.name as ticketoutletsname, ")
		.append("t.tickettype, st1.synccode as departstationsynccode, st2.synccode as reachstationsynccode, sp.synccode as scheduleplansynccode ") 
		.append("from SeatReserve t left join Scheduleplan sp on t.scheduleplanid = sp.id left join ")
		.append("Station st1 on t.departstationid = st1.id left join Station st2 on t.reachstationid = st2.id ")
		.append("left join Ticketoutlets tt on t.ticketoutletsid = tt.id left join Userinfo u1 on t.reserveby = u1.id ")
		.append("left join Userinfo u2 on t.cancelby = u2.id ")
		.append("where t.scheduleplanid = :scheduleplanid");
		
		Query query = JPA.em().createNativeQuery(sql.toString(), UpdateSeatReserve.class);
		query.setParameter("scheduleplanid", scheduleplanid);
		return query.getResultList();
	}
	
	
	public List<UpdateScheduleSeats> queryScheduleSeat4Update(long scheduleplanid){
		StringBuilder sql = new StringBuilder()
		.append("select rownum as id,sp.synccode as scheduleplansynccode,ss.seattype,ss.seatno,ss.status,ss.tickettype,ss.createby,ss.updateby ")
		.append("from scheduleseats ss ")
		.append("left join scheduleplan sp on ss.scheduleplanid = sp.id ")
		.append("where ss.scheduleplanid = :scheduleplanid and ss.status != 0 and ss.status != 1 ");
		Query query = JPA.em().createNativeQuery(sql.toString(), UpdateScheduleSeats.class);
		query.setParameter("scheduleplanid", scheduleplanid);
		return query.getResultList();
	}
		
	// 添加停靠点票价
	@SuppressWarnings("unchecked")
	public List<Object> queryTicketprice(long scheduleplanid) {
		StringBuffer sql = new StringBuffer(
				"selecT  tp.id,tp.scheduleplanid,tp.scheduleid,tp.departstationid,")
				.append(" tp.reachstationid,tp.seattype,tp.fullprice,tp.halfprice,")
				.append(" tp.studentprice,tp.issellable,tp.toplimitprice,tp.moreprice,")
				.append(" s1.name departstationname,s2.name reachstationname")
				.append(" ,tp.discountprice,tp.roundprice,tp.connectprice ")
				.append(" from ticketprice tp, station s1, station s2")
				.append(" where tp.departstationid = s1.id and tp.reachstationid = s2.id")
				.append("  and tp.scheduleplanid = :scheduleplanid");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		return query.getResultList();
	}
	
	public boolean hasSelledTicket(long scheduleplanid) {
		StringBuffer sql = new StringBuffer("select t from Ticketsell t where t.scheduleplanid = :scheduleplanid and t.ticketstatus = 0 ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		return query.getResultList() != null && query.getResultList().size() > 0;	
	}

	@SuppressWarnings("unchecked")
	public Ticketpriceitem findPriceitem(long priceid, String tickettype,Date departdate) {
		StringBuffer sql = new StringBuffer("select t from Ticketpriceitem t, ");
		sql.append(" Ticketpriceformulaitem tf where t.ticketprice.id=:priceid and t.tickettype=:tickettype ");
		sql.append(" and t.ticketpriceformulaitemid=tf.id and tf.isfreight='1'")
		.append(" and t.departdate=:departdate");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("priceid", priceid);
		query.setParameter("tickettype", tickettype);
		query.setParameter("departdate", departdate);
		List<Ticketpriceitem> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
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
	public List<Ticketprice> qryTicketprices(Date departdate, long scheduleid) {
		StringBuffer sql = new StringBuffer("select  tp")
				.append(" from Ticketprice tp")
				.append(" where tp.departdate=:departdate")
				.append("  and tp.scheduleid = :scheduleid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Ticketpriceitem> qryTicketpriceitems(Date departdate, long ticketpriceid) {
		StringBuffer sql = new StringBuffer("select  tp")
				.append(" from Ticketpriceitem tp,Ticketpriceformulaitem tf ")
				.append(" where tp.departdate=:departdate and tp.ticketpriceformulaitemid=tf.id ")
				.append("  and tp.ticketprice.id=:ticketpriceid and tp.tickettype='Q'");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("ticketpriceid", ticketpriceid);
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public List<Ticketpriceitem> qrySchTicketpriceitems(Date departdate,long scheduleid) {
		StringBuffer sql = new StringBuffer("select  tp")
				.append(" from Ticketpriceitem tp,Ticketprice t")
				.append(" where tp.departdate=:departdate and t.departdate=:departdate")
				.append("  and tp.ticketprice.id=t.id and t.scheduleid=:scheduleid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public Schedulestatus qrySchedulestatus(Date departdate, long scheduleid,
			long departstationid) {
		StringBuffer sql = new StringBuffer("select t from Schedulestatus t"
				+ " where t.departstationid=:departstationid"
				+ " and t.scheduleid=:scheduleid and t.departdate=:departdate");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departstationid", departstationid);
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("departdate", departdate);
		List<Schedulestatus> sslist = query.getResultList();
		return sslist != null && sslist.size() > 0 ? sslist.get(0) : null;
	}

	/*
	 * public int updateSchedulestatus(Date startdate, Date endate,
	 * Schedulestatus ss) { StringBuffer sql = new
	 * StringBuffer("update Schedulestatus t")
	 * .append(" set t.departtime=:departtime,t.ticketentrance=:ticketentrance,"
	 * ) .append(" t.updateby=:updateby,t.updatetime=:updatetime,")
	 * .append(" t.buspark=:buspark where t.departstationid=:departstationid")
	 * .append(" and t.scheduleid=:scheduleid and ")
	 * .append(" t.departdate  between :startdate and :endate"); Query query =
	 * getEntityManager().createQuery(sql.toString());
	 * query.setParameter("departtime", ss.getDepartdate());
	 * query.setParameter("ticketentrance", ss.getTicketentrance());
	 * query.setParameter("buspark", ss.getBuspark());
	 * query.setParameter("startdate", startdate); query.setParameter("endate",
	 * endate); query.setParameter("updateby", ss.getUpdateby());
	 * query.setParameter("updatetime", new Date()); return
	 * query.executeUpdate(); }
	 * 
	 * public int updateSchedulevehiclepeopleplan(Date startdate, Date endate,
	 * Schedulevehiclepeopleplan svp) { StringBuffer sql = new StringBuffer(
	 * "update Schedulevehiclepeopleplan t") .append(
	 * " set t.planvehicle=:planvehicle,t.planvehicletypeid=:planvehicletypeid,"
	 * ) .append(" t.updateby=:updateby,t.updatetime=:updatetime,") .append(
	 * " t.planvehiclebrandmodelid=:planvehiclebrandmodelid where t.scheduleplan.id=:scheduleplanid"
	 * ) .append(" t.departdate  between :startdate and :endate"); Query query =
	 * getEntityManager().createQuery(sql.toString());
	 * query.setParameter("planvehicle", svp.getPlanvehicle());
	 * query.setParameter("planvehicletypeid", svp.getPlanvehicletypeid());
	 * query.setParameter("planvehiclebrandmodelid",
	 * svp.getPlanvehiclebrandmodelid()); query.setParameter("startdate",
	 * startdate); query.setParameter("endate", endate);
	 * query.setParameter("updateby", svp.getUpdateby());
	 * query.setParameter("updatetime", new Date()); return
	 * query.executeUpdate(); }
	 */
	// 查询同线路的班次信息
	@SuppressWarnings("unchecked")
	public List<Object> qrySameRouteSch(Date departdate, long routeid,
			long departstationid,long scheduleplanid) {
//		StringBuffer sql = new StringBuffer(
//				"select s.id,trim(t.departtime),s.code,0 as checked from Schedulestatus t,Schedule s")
//				.append(" where t.scheduleid=s.id and t.departstationid=:departstationid")
//				.append(" and t.departdate=:departdate and s.route.id=:routeid")
//				.append(" order by t.departtime");
//		Query query = getEntityManager().createQuery(sql.toString());
//		query.setParameter("departstationid", departstationid);
//		query.setParameter("routeid", routeid);
//		query.setParameter("departdate", departdate);
//		return query.getResultList();
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
		String  begin=df.format(departdate);
		//20160323王远媛修改--实现修改页面对应记录勾选
		StringBuffer sql = new StringBuffer(
		"select s.id,trim(t.departtime),s.code,decode(t.scheduleplanid,:scheduleplanid,1,0) as checked ")
		.append(" from Schedulestatus t,Schedule s ")
		.append(" where t.scheduleid=s.id and t.departstationid=:departstationid")
		.append(" and t.departdate=:departdate and s.routeid=:routeid")
		.append(" and t.departdate=to_date('"+begin+"','yyyymmdd') ")
		.append(" order by t.departtime");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("departstationid", departstationid);
		query.setParameter("routeid", routeid);
		query.setParameter("departdate", departdate);
		query.setParameter("scheduleplanid", scheduleplanid);
		return query.getResultList();
	}

	// 查询站点票价
	@SuppressWarnings("unchecked")
	public List<Object> qryStationprice(long departstationid,
			long reachstationid) {
		Date departdate = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			departdate = sf.parse(sf.format(new Date()));
		} catch (ParseException e) {
			play.Logger.error(e.getMessage(), e);
		}
		StringBuffer sql = new StringBuffer(
				"select fullprice,halfprice,studentprice,toplimitprice,moreprice,distance,discountprice,roundprice,connectprice from Ticketprice t")
				.append(" where t.departstationid=:departstationid and rownum<=1")
				.append(" and t.departdate=:departdate and t.reachstationid=:reachstationid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departstationid", departstationid);
		query.setParameter("reachstationid", reachstationid);
		query.setParameter("departdate", departdate);
		List<Object> list = query.getResultList();
		if (list == null || list.size() == 0) {
			sql = new StringBuffer(
					"select fullprice,halfprice,studentprice,toplimitprice,moreprice ,distance,discountprice,roundprice,connectprice from Handprice t,")
					.append("  Routestop r, Schedule s")
					.append(" where t.departstationid=:departstationid and r.routeid=s.routeid")
					.append(" and r.isactive=1 and t.reachstationid=r.stationid")
					.append(" and t.reachstationid=:reachstationid and rownum <= 1");
			query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("departstationid", departstationid);
			query.setParameter("reachstationid", reachstationid);
			list = query.getResultList();
		}
		return list;
	}
	
	public int updateTicketprice(Date fromdate,Date  enddate,
			long scheduleid,long departstationid,long reachstationid,
			String seattype,BigDecimal fullprice,BigDecimal halfprice,
			BigDecimal studentprice,BigDecimal moreprice,BigDecimal toplimitprice,
			long updateby) {
		StringBuffer sql = new StringBuffer(
				"update Ticketprice t set t.fullprice=:fullprice,")
		.append(" t.halfprice=:halfprice,t.studentprice=:studentprice,")
		.append(" t.moreprice=:moreprice,t.toplimitprice=:toplimitprice,")
		.append(" t.updateby=:updateby,t.updatetime=:updatetime")
		.append(" where t.departdate between :fromdate and :enddate")
		.append(" and t.scheduleid=:scheduleid and t.departstationid=:departstationid")
		.append(" and t.reachstationid=:reachstationid and t.seattype=:seattype");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("fromdate", fromdate);
		query.setParameter("enddate", enddate);
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("departstationid", departstationid);
		query.setParameter("reachstationid", reachstationid);
		query.setParameter("seattype", seattype);
		query.setParameter("fullprice", fullprice);
		query.setParameter("halfprice", halfprice);
		query.setParameter("studentprice", studentprice);		
		query.setParameter("moreprice", moreprice);
		query.setParameter("toplimitprice", toplimitprice);
		query.setParameter("updateby", updateby);
		query.setParameter("updatetime", new Date());		
		return query.executeUpdate();
		
	}
	
	public int upateBasePriceitem(Date fromdate,Date  enddate,long scheduleid,
			BigDecimal price,String tickettype,long departstationid,long reachstationid,
			String seattype ) {
		StringBuffer sql = new StringBuffer("update ticketpriceitem t")
		.append("  set t.price =:price - (select sum(a.price)")
		.append("   from ticketpriceitem a  where a.isautoadjust = 0")
		.append("  and a.scheduleid =:scheduleid  and a.departdate between :fromdate")
		.append("  and :enddate and a.tickettype =:tickettype")
		.append("  and t.ticketpriceid = a.ticketpriceid)")
		.append(" where t.isautoadjust = 1 and t.scheduleid =:scheduleid")
		.append("   and t.departdate between :fromdate and :enddate")
		.append("   and t.tickettype =:tickettype")
		.append("   and t.ticketpriceid in ")
		.append("   (select tp.id from ticketprice tp")
		.append("  where tp.departdate  between :fromdate and :enddate")
		.append("   and tp.departstationid=:departstationid")
		.append("   and tp.reachstationid=:reachstationid")
		.append("   and tp.scheduleid=:scheduleid  and tp.seattype=:seattype)");		
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("fromdate", fromdate);
		query.setParameter("enddate", enddate);
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("price", price);
		query.setParameter("tickettype", tickettype);			
		query.setParameter("departstationid", departstationid);
		query.setParameter("reachstationid", reachstationid);
		query.setParameter("seattype", seattype);
		return  query.executeUpdate();
	}
	
	public List<Object> qryDepartTime(long scheduleplanid,
			long departstationid,Date departdate) {
		StringBuffer sql = new StringBuffer(
				"select t.id,trim(t.departtime),s.code,st.name as stationname,t.scheduleid,t.departstationid")
				.append(" from Schedulestatus t,Schedule s,Station st")
				.append(" where t.scheduleid=s.id and t.departstationid!=:departstationid")
				.append(" and t.departdate=:departdate ")
				.append(" and t.departstationid=st.id and t.scheduleplan.id=:scheduleplanid")
				.append(" order by t.departtime");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("departstationid", departstationid);
		query.setParameter("departdate", departdate);		
		return query.getResultList();
	}
	public List<Schedulestatus> qrySchedulestatus(long scheduleid,long departstationid,
			Date fromdate,Date enddate) {
		StringBuffer sql = new StringBuffer(
				"select t")
				.append(" from Schedulestatus t")
				.append(" where t.scheduleid=:scheduleid and t.departstationid!=:departstationid")
				.append(" and t.departdate between :fromdate and :enddate ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("fromdate", fromdate);
		query.setParameter("enddate", enddate);		
		query.setParameter("departstationid", departstationid);		
		return query.getResultList();
	}

	public List<Object> qryChildNum(long scheduleplanid) {
		StringBuffer sql = new StringBuffer(
				"select t.carrychildnum")
				.append(" from Scheduleplan t")
				.append(" where t.id = :scheduleplanid ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		return query.getResultList();
	}
}
