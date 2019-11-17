package cn.nova.bus.price.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Vehicletype;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.price.model.Handholidayprice;
import cn.nova.bus.price.model.Handholidaypriceitem;
import cn.nova.bus.price.model.Handprice;
import cn.nova.bus.price.model.Handpriceitem;
import cn.nova.bus.price.model.Holiday;
import cn.nova.bus.price.model.Standardprice;

@SuppressWarnings("rawtypes")
public class HandHolidaypriceDao extends EntityManagerDaoSurport {
	@SuppressWarnings("unchecked")
	public List<Object> qryScheduleVehicletype(Long scheduleid) {
		StringBuilder sql = new StringBuilder("select DISTINCT vt").append(
				" from Handprice h,Vehicletype vt").append(
				" where h.vehicletypeid=vt.id and h.scheduleid=:scheduleid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}

	/*
	 * @SuppressWarnings("unchecked") public List<Object>
	 * qryHandHolidayprice(long scheduleid,long holidayid,long vehicletypeid) {
	 * StringBuilder sql = new StringBuilder("select DISTINCT vt")
	 * .append(" from Handholidayprice h,Vehicletype vt")
	 * .append(" where h.vehicletypeid=vt.id and h.scheduleid=:scheduleid");
	 * Query query = getEntityManager().createQuery(sql.toString());
	 * query.setParameter("scheduleid", scheduleid); return
	 * query.getResultList(); }
	 */
	@SuppressWarnings("unchecked")
	public List<Object> qryHandHolidayprice(Handholidayprice handholidayprice) {
		StringBuilder sql = new StringBuilder(
				"select hp,s1.name as departstation,s2.name as reachstation,v.name as vehicletype ")
				.append(",hp.toplimitprice,hp.lowerlimitprice,h.fullname,r.name as routename,s.code as schedulecode,s.viastation,s.planseatnum ")
				.append(" from Station s1,Station s2,Vehicletype v,Schedulestop ss ,Handholidayprice hp,")
				.append(" Schedule s,Route r,Holiday h")
				.append(" where hp.scheduleid=:scheduleid and hp.holidayid=h.id ")
				.append(" and hp.departstationid=s1.id  and hp.reachstationid=s2.id")
				.append(" and hp.vehicletypeid=v.id ")//and h.isactive=1
				.append(" and s.id = hp.scheduleid")
				.append(" and r.id = s.route.id")
				.append(" and hp.reachstationid=ss.stationid")
				.append(" and hp.scheduleid=ss.schedule.id and ss.isactive=1");
		if (handholidayprice.getStartdate() == null) {
			if (handholidayprice.getHolidayid() > 0) {
				sql.append(" and hp.holidayid=:holidayid ");
				sql.append(" order by hp.holidayid,hp.startdate, hp.departstationid,hp.reachstationid");
				Query query = getEntityManager().createQuery(sql.toString());
				query.setParameter("scheduleid",
						handholidayprice.getScheduleid());
				query.setParameter("holidayid", handholidayprice.getHolidayid());
				return query.getResultList();
			} else {
				sql.append(" order by hp.holidayid,hp.startdate, hp.departstationid,hp.reachstationid");
				Query query = getEntityManager().createQuery(sql.toString());
				query.setParameter("scheduleid",
						handholidayprice.getScheduleid());
				return query.getResultList();
			}
		} else {
			if (handholidayprice.getHolidayid() > 0) {
				sql.append(" and hp.startdate>=:startdate and hp.holidayid=:holidayid");
				sql.append(" order by hp.holidayid,hp.startdate, hp.departstationid,hp.reachstationid");
				Query query = getEntityManager().createQuery(sql.toString());
				query.setParameter("scheduleid",
						handholidayprice.getScheduleid());
				query.setParameter("startdate", handholidayprice.getStartdate());
				query.setParameter("holidayid", handholidayprice.getHolidayid());
				return query.getResultList();
			} else {
				sql.append(" and hp.startdate>=:startdate");
				sql.append(" order by hp.holidayid,hp.startdate, hp.departstationid,hp.reachstationid");
				Query query = getEntityManager().createQuery(sql.toString());
				query.setParameter("scheduleid",
						handholidayprice.getScheduleid());
				query.setParameter("startdate", handholidayprice.getStartdate());
				return query.getResultList();
			}

		}
	}

	// 编辑界面应调票价查询
	@SuppressWarnings("unchecked")
	public List<Object> qryHandprice(long scheduleid, String vehicletypeids) {
		StringBuilder sql = new StringBuilder(
				"select h from Handprice h,Schedulestop ss, Schedulestop st")
				.append(" where h.scheduleid=:scheduleid  and h.reachstationid=ss.stationid")
				.append(" and h.scheduleid=ss.schedule.id and ss.isactive=1")
				.append(" and h.scheduleid = st.schedule.id and h.departstationid = st.stationid")
				.append(" and st.isdepart = 1  and st.isactive = 1 ");
		if (!("").equals(vehicletypeids)) {
			sql.append(" and h.vehicletypeid in" + vehicletypeids);
		}
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}
	// 编辑界面应调票价查询
	@SuppressWarnings("unchecked")
	public List<Handprice> qryHandprices(long scheduleid, String vehicletypeids) {
		StringBuilder sql = new StringBuilder(
				"select h from Handprice h,Schedulestop ss, Schedulestop st")
				.append(" where h.scheduleid=:scheduleid  and h.reachstationid=ss.stationid")
				.append(" and h.scheduleid=ss.schedule.id and ss.isactive=1")
				.append(" and h.scheduleid = st.schedule.id and h.departstationid = st.stationid")
				.append(" and st.isdepart = 1  and st.isactive = 1 ");
		if (!("").equals(vehicletypeids)) {
			sql.append(" and h.vehicletypeid in" + vehicletypeids);
		}
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}

	// 查询该班次的循环车型
	@SuppressWarnings("unchecked")
	public List<Vehicletype> qrySchVehicletype(long scheduleid) {
		StringBuilder sql = new StringBuilder(
				"select distinct v from Handprice h,Vehicletype v")
				.append(" where h.scheduleid=:scheduleid  and h.vehicletypeid=v.id");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}
	
	// 编辑界面的查询
	@SuppressWarnings("unchecked")
	public List<Object> qryHandholidayprice(Holiday holiday, long scheduleid,
			String vehicletypeids) {
		StringBuilder sql = new StringBuilder(
				"select h from Handholidayprice h,Schedulestop ss, Schedulestop st")
				.append(" where h.scheduleid=:scheduleid and h.holidayid=:holidayid ")
				.append(" and h.reachstationid=ss.stationid and st.isdepart=1 and st.isactive=1")
				.append(" and h.scheduleid=ss.schedule.id and ss.isactive=1")
				.append(" and h.scheduleid=st.schedule.id and h.departstationid=st.stationid")
				.append(" and h.startdate=:startdate and h.enddate=:enddate");
		if (!("").equals(vehicletypeids)) {
			sql.append(" and h.vehicletypeid in" + vehicletypeids);
		}
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("holidayid", holiday.getId());
		query.setParameter("startdate", holiday.getStartdate());
		query.setParameter("enddate", holiday.getEnddate());
		return query.getResultList();
	}

	public Standardprice getStandardprice(Handprice handprice) {
		StringBuilder sql = new StringBuilder("select s from Standardprice s")
				.append(" where s.scheduleid=:scheduleid and s.vehicletypeid=:vehicletypeid")
				.append(" and s.departstationid=:departstationid and s.reachstationid=:reachstationid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", handprice.getScheduleid());
		query.setParameter("vehicletypeid", handprice.getVehicletypeid());
		query.setParameter("departstationid", handprice.getDepartstationid());
		query.setParameter("reachstationid", handprice.getReachstationid());
		return (Standardprice) query.getSingleResult();
	}

	public Standardprice getStandardprice(Handholidayprice handholidayprice) {
		StringBuilder sql = new StringBuilder("select s from Standardprice s")
				.append(" where s.scheduleid=:scheduleid and s.vehicletypeid=:vehicletypeid")
				.append(" and s.departstationid=:departstationid and s.reachstationid=:reachstationid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", handholidayprice.getScheduleid());
		query.setParameter("vehicletypeid", handholidayprice.getVehicletypeid());
		query.setParameter("departstationid",
				handholidayprice.getDepartstationid());
		query.setParameter("reachstationid",
				handholidayprice.getReachstationid());
		return (Standardprice) query.getSingleResult();
	}

	@SuppressWarnings("unchecked")
	public boolean isExistHandholidayprice(Handholidayprice handholidayprice) {
		if (handholidayprice.getId() == 0) {
			StringBuilder sql = new StringBuilder(
					"select h from Handholidayprice h")
					.append(" where h.scheduleid=:scheduleid and h.holidayid=:holidayid ")
					.append(" and ((h.startdate>=:startdate and startdate<=:enddate) ")
					.append(" or (h.startdate<=:startdate and h.enddate>=:enddate)")
					.append(" or (h.startdate<=:startdate and h.enddate>=:startdate)")
					.append(" or (h.startdate>=:startdate and h.enddate<=:enddate))")
					.append(" and h.vehicletypeid=:vehicletypeid");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("scheduleid", handholidayprice.getScheduleid());
			query.setParameter("holidayid", handholidayprice.getHolidayid());
			query.setParameter("startdate", handholidayprice.getStartdate());
			query.setParameter("enddate", handholidayprice.getEnddate());
			query.setParameter("vehicletypeid", handholidayprice.getVehicletypeid());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		} else {
			StringBuilder sql = new StringBuilder(
					"select h from Handholidayprice h")
					.append(" where h.scheduleid=:scheduleid and h.holidayid=:holidayid ")
					.append(" and ((h.startdate>=:startdate and startdate<=:enddate) ")
					.append(" or (h.startdate<=:startdate and h.enddate>=:enddate)")
					.append(" or (h.startdate<=:startdate and h.enddate>=:startdate)")
					.append(" or (h.startdate>=:startdate and h.enddate<=:enddate))")
					.append(" and h.startdate!=:startdate and h.enddate!=:enddate")
					.append(" and h.vehicletypeid=:vehicletypeid");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("scheduleid", handholidayprice.getScheduleid());
			query.setParameter("holidayid", handholidayprice.getHolidayid());
			query.setParameter("startdate", handholidayprice.getStartdate());
			query.setParameter("enddate", handholidayprice.getEnddate());
			query.setParameter("vehicletypeid", handholidayprice.getVehicletypeid());
			List<Object> list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		}
	}

	public boolean delHandholidayprice(Handholidayprice handholidayprice) {
		try {
			StringBuilder sql = new StringBuilder(
					"DELETE from Handholidayprice h")
					.append(" where h.scheduleid=:scheduleid and h.holidayid=:holidayid ")
					.append(" and h.startdate=:startdate and h.enddate=:enddate")
					.append(" and h.vehicletypeid=:vehicletypeid");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("scheduleid", handholidayprice.getScheduleid());
			query.setParameter("holidayid", handholidayprice.getHolidayid());
			query.setParameter("vehicletypeid",handholidayprice.getVehicletypeid());
			query.setParameter("startdate", handholidayprice.getStartdate());
			query.setParameter("enddate", handholidayprice.getEnddate());
			query.executeUpdate();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			return false;
		}
		return true;
	}

	// 查询硬调票价分项信息
	@SuppressWarnings("unchecked")
	public List<Handpriceitem> qryHandpriceitem(long scheduleid,
			long vehicletypeid, String tickettype, long departstationid,
			long reachstationid,String seattype) {
		StringBuilder sql = new StringBuilder("select t from")
				.append(" Handprice hp ,Handpriceitem t,Schedulestop s ")
				.append(" where hp=t.handprice and hp.scheduleid=:scheduleid")
				.append(" and hp.vehicletypeid=:vehicletypeid ")
				.append(" and hp.reachstationid=s.stationid and s.isactive=1")
				.append(" and hp.departstationid=:departstationid")
				.append(" and hp.reachstationid=:reachstationid")
				.append(" and t.tickettype=:tickettype and hp.scheduleid=s.schedule.id")
				.append(" and hp.seattype=:seattype");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("vehicletypeid", vehicletypeid);
		query.setParameter("tickettype", tickettype);
		query.setParameter("seattype", seattype);
		query.setParameter("departstationid", departstationid);
		query.setParameter("reachstationid", reachstationid);
		return query.getResultList();
	}

	// 查询节日票价分项信息
	@SuppressWarnings("unchecked")
	public List<Object> qryHandholidaypriceitem(long handholidaypriceid,
			String tickettype) {
		StringBuilder sql = new StringBuilder(
				"select tp.code,tp.name,t.price,t.id,t.tickettype,t.isautoadjust,t.handholidaypriceid,t.ticketpriceformulaitemid from")
				.append(" Handholidaypriceitem t,Ticketpriceformulaitem tp where ")
				.append(" t.ticketpriceformulaitemid=tp.id and t.handholidaypriceid=:handholidaypriceid")
				.append(" and t.tickettype=:tickettype");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("handholidaypriceid", handholidaypriceid);
		query.setParameter("tickettype", tickettype);
		return query.getResultList();
	}

	// 查询同线路其他班次信息
	@SuppressWarnings("unchecked")
	public List<Schedule> qryOtherSchedules(long scheduleid) {
		StringBuilder sql = new StringBuilder("select s from")
				.append(" Schedule s where ")
				.append(" s.route in (select route from Schedule a where a.id=:scheduleid)")
				.append(" and s.id!=:scheduleid and s.isactive=1");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}

	// 删除同线路其他班次交叉日期段的节日票价信息
	public int delOtherSchedulesPrice(long scheduleid,
			Handholidayprice handholidayprice) {
		StringBuilder sql = new StringBuilder("delete from Handholidaypriceitem h")
				.append(" where h.handholidayprice.id = :handholidaypriceid ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("handholidaypriceid", handholidayprice.getId());
		query.executeUpdate();
		
		StringBuilder sql1 = new StringBuilder("delete from Handholidayprice h")
				.append(" where ((h.startdate>=:startdate and startdate<=:enddate) ")
				.append(" or (h.startdate<=:startdate and h.enddate>=:enddate)")
				.append(" or (h.startdate<=:startdate and h.enddate>=:startdate)")
				.append(" or (h.startdate>=:startdate and h.enddate<=:enddate))")
				.append(" and h.scheduleid=:scheduleid");
		Query query1 = getEntityManager().createQuery(sql1.toString());
		query1.setParameter("scheduleid", scheduleid);
		query1.setParameter("startdate", handholidayprice.getStartdate());
		query1.setParameter("enddate", handholidayprice.getEnddate());
		return query1.executeUpdate();
	}

	@SuppressWarnings("unchecked")
	public List<Handholidayprice> qryHandholidayprice(long routeid,
			long vehicletypeid, long departstationid, long reachstationid) {
		StringBuilder sql = new StringBuilder(
				"select r from Handholidayprice r,Schedule s")
				.append(" where r.vehicletypeid = :vehicletypeid and r.scheduleid=s.id and s.route.id=:routeid")
				.append(" and r.departstationid=:departstationid and r.reachstationid=:reachstationid and s.isactive=1");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("vehicletypeid", vehicletypeid);
		query.setParameter("routeid", routeid);
		query.setParameter("departstationid", departstationid);
		query.setParameter("reachstationid", reachstationid);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> qryHandholidayprice(long handholidaypriceid) {
		StringBuilder sql = new StringBuilder(
				"select r from Handholidayprice r")
				.append(" where r.id = :handholidaypriceid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("handholidaypriceid", handholidaypriceid);
		return query.getResultList();
	}
	
	public boolean isExistHandpriceInTimes(Handholidayprice handholidayprice){
		StringBuilder sql = new StringBuilder(
				"select h from Handholidayprice h")
				.append(" where h.scheduleid=:scheduleid and h.vehicletypeid=:vehicletypeid and h.reachstationid = :reachstationid  ")
				.append(" and ((h.startdate>=:startdate and startdate<=:enddate) ")
				.append(" or (h.startdate<=:startdate and h.enddate>=:enddate)")
				.append(" or (h.startdate<=:startdate and h.enddate>=:enddate)")
				.append(" or (h.startdate>=:startdate and h.enddate<=:enddate))");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", handholidayprice.getScheduleid());
		query.setParameter("vehicletypeid", handholidayprice.getVehicletypeid());
		query.setParameter("startdate", handholidayprice.getStartdate());
		query.setParameter("enddate", handholidayprice.getEnddate());
		query.setParameter("reachstationid", handholidayprice.getReachstationid());
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? true : false;
	}
	
	@SuppressWarnings("unchecked")
	public boolean isExistHandprice(long scheduleid,long departstationid,long reachstationid) {
		StringBuilder sql = new StringBuilder(
				"select r from Handprice r,Schedulestop sp")
				.append(" where r.scheduleid = :scheduleid and r.departstationid=:departstationid")
				.append(" and r.reachstationid=:reachstationid")
				.append(" and r.scheduleid=sp.schedule.id and r.reachstationid=sp.stationid and sp.isactive=1");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("departstationid", departstationid);
		query.setParameter("reachstationid", reachstationid);
		List<Object> list= query.getResultList();
		return list!=null&&list.size()>0?true:false;
	}

	public Route qryRoute(long scheduleid) {
		StringBuffer sql=new StringBuffer("select r.* from Route r left join Schedule s on s.routeid=r.id where s.id=:scheduleid");
		Query query=getEntityManager().createNativeQuery(sql.toString(),Route.class);
		query.setParameter("scheduleid",scheduleid);
		Route route=(Route)query.getSingleResult();
		return route;
	}

	public List<Handholidaypriceitem> findHandholidaypriceitemlist(long id) {
		StringBuffer sql=new StringBuffer("select t from Handholidaypriceitem t where t.handholidayprice.id = :id ");
		Query query=getEntityManager().createQuery(sql.toString());
		query.setParameter("id", id);
		return query.getResultList();
	}
}
