package cn.nova.bus.base.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Routestop;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Schedulelongstop;
import cn.nova.bus.base.model.Schedulestop;
import cn.nova.bus.base.model.Ticketentrance;
import cn.nova.bus.base.model.Vehiclepark;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.price.model.Handprice;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class ScheduleDao extends EntityManagerDaoSurport {
	public List<Object> selfcheckSchedule(Date departdate, long departstationid,long vehicleid,long reportorgid) {
		StringBuilder sql = new StringBuilder();
		sql.append(" select vp.id, s.code name, cast(ss.departtime as varchar2(5)) departdate,vp.isdeparted,p.islinework  ")
		.append(" from Scheduleplan p, Schedulestatus ss, Schedule s, Vehiclereport vp,schedulevehiclepeopleplan svp ")
		.append(" where p.scheduleid = s.id  and ss.scheduleid = s.id  and p.id=svp.scheduleplanid ")
		.append(" and vp.orderno=svp.orderno  and ss.scheduleplanid = p.id")
		.append(" and vp.scheduleplanid = p.id  and vp.scheduleid = s.id")
		.append(" and ss.isreported = 1  and vp.departdate = p.departdate  and vp.isactive =1")
		.append(" and vp.departdate =:departdate")
		.append(" and vp.vehicleid = :vehicleid")
		.append(" and vp.reportorgid = :reportorgid")
		.append(" and ss.departstationid = :departstationid")
		.append(" order by vp.isdeparted ,vp.reporttime desc  ");
		 Query query = getEntityManager().createNativeQuery(sql.toString());
		 query.setParameter("departdate", departdate);
		 query.setParameter("vehicleid", vehicleid);
		 query.setParameter("reportorgid", reportorgid);
		 query.setParameter("departstationid", departstationid);
		return query.getResultList();
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList,String schedulestatus,String flag) {
		StringBuilder sql = new StringBuilder("select s.id, s.routeid,")
				.append(" s.orgid,s.code,s.worktype,s.workways,s.districttype,")
				.append(" s.type,trim(s.starttime),s.runtime,s.isproprietary,")
				.append(" s.isovertime,s.issellreturnticket,s.islinework,")
				.append(" s.isoriginator,s.issaleafterreport,s.iscanmixcheck,")
				.append(" s.planseatnum,s.viastation,s.printinfo,s.remarks,")
				.append(" s.isaudited,s.isauditpass,s.isactive,s.createtime,")
				.append(" s.createby,s.updatetime,s.updateby,trim(s.endtime),s.spacinginterval,")
				.append(" s.synccode, ")
				.append(" o.name as orgname,r.name as routename,us1.name as username,t.name as ticketentrance,")
				.append(" v.name as vehcilepark,r.startstationid ,r.endstationid,r.id as routeid,")
				.append(" t.id as entranceid,v.id as parkid,1 as islongstop,s.isfixseat,s.isneedfinger,s.driverfingernum,s.endstation,s.startstationprice")
				.append("  ,s.isautoreport as isautoreport from Schedule s ,Route r,Userinfo us1,Organization o,Schedulestop ss ")
				.append(" LEFT JOIN  ticketentrance t on ss.ticketentranceid=t.id  ")
				.append(" LEFT JOIN  vehiclepark v on v.id=ss.vehcileparkid ")
				.append(" where s.orgid=o.id and r.startstationid=ss.stationid and s.id=ss.scheduleid")
				.append(" and isdepart=1 and s.routeid=r.id and r.isactive=1")
				.append(" and s.createby=us1.id  ");//加班班次只按isdelete判断是否删除，正常班次使用isdelete和isactive共同控制
				if("isovertime".equals(flag)){
					sql.append(" and ((s.isactive=1 and s.isdelete=0) or (s.isovertime=1 and s.isdelete=0)) ");
				}else{
					sql.append(" and s.isactive=1 and s.isovertime=0 ");
				}
//				.append(" and s.isovertime = 0") //.append(" and s.isovertime = 0") //新增节日票价管理，只对普通班次进行设置liyi修改//但是这里本
													//来是加班班次管理，会影响基础功能，所以注释yzw修改
				sql.append(" and exists (select 1 from Schedulelongstop ss")
				.append(" where ss.startdate<=:curdate and ss.enddate+0.99999>=:curdate and s.id=ss.scheduleid)");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by r.name,s.starttime,s.code ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("curdate", new Date());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		List<Object> list = query.getResultList();
		sql = new StringBuilder("select s.id, s.routeid,")
				.append(" s.orgid,s.code,s.worktype,s.workways,s.districttype,")
				.append(" s.type,trim(s.starttime),s.runtime,s.isproprietary,")
				.append(" s.isovertime,s.issellreturnticket,s.islinework,")
				.append(" s.isoriginator,s.issaleafterreport,s.iscanmixcheck,")
				.append(" s.planseatnum,s.viastation,s.printinfo,s.remarks,")
				.append(" s.isaudited,s.isauditpass,s.isactive,s.createtime,")
				.append(" s.createby,s.updatetime,s.updateby,trim(s.endtime),s.spacinginterval,")
				.append(" s.synccode, ")
				.append(" o.name as orgname,r.name as routename,us1.name as username,t.name as ticketentrance,")
				.append(" v.name as vehcilepark,r.startstationid ,r.endstationid,r.id as routeid,")
				.append(" t.id as entranceid,v.id as parkid,0 as islongstop,s.isfixseat,s.isneedfinger,s.driverfingernum,s.endstation,s.startstationprice")
				.append("  ,s.isautoreport as isautoreport from Schedule s ,Route r,Userinfo us1,Organization o,Schedulestop ss ")
				.append(" LEFT JOIN  ticketentrance t on ss.ticketentranceid=t.id  ")
				.append(" LEFT JOIN  vehiclepark v on v.id=ss.vehcileparkid ")
				.append(" where s.orgid=o.id and r.startstationid=ss.stationid and s.id=ss.scheduleid")
				.append(" and isdepart=1 and s.routeid=r.id and r.isactive=1")
				.append(" and s.createby=us1.id  ");
				//班次加班菜单，显示加班班次，其他菜单暂时不显示加班班次
				if("isovertime".equals(flag)){//加班班次只按isdelete判断是否删除，正常班次使用isdelete和isactive共同控制
					sql.append(" and ((s.isactive=1 and s.isdelete=0) or (s.isovertime=1 and s.isdelete=0)) ");
				}else{
					sql.append(" and s.isactive=1 and s.isovertime=0 ");
				}
				//添加循环班次号去掉s.isactive=1
//				.append(" and s.createby=us1.id  ")
		//.append(" and s.isovertime = 0") //新增节日票价管理，只对普通班次进行设置liyi修改//但是这里本
													//来是加班班次管理，会影响基础功能，所以注释yzw修改
				sql.append(" and not exists (select 1 from Schedulelongstop ss")
				.append(" where ss.startdate<=:curdate and ss.enddate+0.99999>=:curdate and s.id=ss.scheduleid)");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by r.name,s.starttime,s.code ");
		query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("curdate", new Date());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		if("1".equals(schedulestatus)){
//			list.addAll(query.getResultList());	
			return query.getResultList();
		}else if ("2".equals(schedulestatus)){
//			list.addAll(query.getResultList());
			return list;
		}else{
			list.addAll(query.getResultList());
			return list;
		}
//		return list;
	}

	@SuppressWarnings("unchecked")
	public Route getRoute(long id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		List<Route> routes = find(Route.class, map);
		return routes != null && routes.size() > 0 ? routes.get(0) : null;
	}
	
	/**
	 * 根据线路ID 获得同线路的其他班次
	 * @param routeid
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Schedule> getScheuleByRoute(long routeid) {
		StringBuilder sql = new StringBuilder("select s")
				.append(" from Route r,Schedule s")
				.append(" where r.id= s.route.id and r.id = :routeid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("routeid", routeid);
		List<Schedule> schedulelist = query.getResultList();
		return schedulelist;
	}

	@SuppressWarnings("unchecked")
	public Schedulestop isExistSchedulestop(Schedule schedule, Long stationid,
			boolean isactive) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("schedule", schedule);
		map.put("stationid", stationid);
		map.put("isactive", isactive);
		List<Schedulestop> schedulestops = find(Schedulestop.class, map);
		return schedulestops != null && schedulestops.size() > 0 ? schedulestops
				.get(0) : null;
	}


	// 判断是否存在该班次号
	@SuppressWarnings("unchecked")
	public boolean isExistSchedulehelpCode(String code, long orgid) {

		StringBuilder sql = new StringBuilder(
				"select s from Schedule s where s.isactive=1 and s.code=:code and s.orgid=:orgid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("code", code);
		List<Object> result = query.getResultList();
		return result != null && result.size() > 0 ? true : false;
	}

	//count班次数量
	public String queryScheduleOvertimeCount(long routeid, long orgid,Date startdate,Date enddate) {

		StringBuilder sql = new StringBuilder();
//				"select s from Schedule s where s.isactive=1 and s.code=:code and s.orgid=:orgid");
		sql.append("select max(distinct s.code) from scheduleplan sp , schedule s where sp.scheduleid = s.id and s.isovertime = 1 ")
		 .append("  and sp.departdate>=:startdate and sp.departdate<=:enddate  and s.orgid=:orgid and s.routeid=:routeid");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("routeid", routeid);
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		List<Object> result = query.getResultList();
		return result.get(0).toString();
	}
	
	@SuppressWarnings("unchecked")
	public Ticketentrance getTicketentrance(long id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		List<Ticketentrance> ticketentrances = find(Ticketentrance.class, map);
		return ticketentrances != null && ticketentrances.size() > 0 ? ticketentrances
				.get(0) : null;
	}

	@SuppressWarnings("unchecked")
	public Vehiclepark getVehiclepark(long id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		List<Vehiclepark> vehicleparks = find(Vehiclepark.class, map);
		return vehicleparks != null && vehicleparks.size() > 0 ? vehicleparks
				.get(0) : null;
	}

	@SuppressWarnings("unchecked")
	public List<Object> getSchedulestop(long scheduleid) {
		StringBuilder sql = new StringBuilder(
				"select s,st.name as stationname,t.name as ticketentrance,")
				.append(" v.name as vehiclepark")
				.append(" from Schedulestop s LEFT JOIN s.ticketentrance t LEFT JOIN s.vehiclepark v ,Station st ")
				.append(" where s.isactive=1 and s.schedule.id=:scheduleid")
				.append(" and s.stationid=st.id order by s.orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}

	public Schedulestop getScheduleStartstop(Schedule schedule) {
		StringBuilder sql = new StringBuilder(
				"select s from Schedulestop s,Route r ")
				.append(" where s.isactive=1 and s.schedule=:schedule and s.schedule.route=r")
				.append(" and s.stationid=r.startstationid order by s.orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("schedule", schedule);
		return (Schedulestop) query.getSingleResult();
	}

	public byte getMaxSchedulestop(Schedule schedule) {
		StringBuilder sql = new StringBuilder(
				"select MAX(s.orderno) as orderno from Schedulestop s ")
				.append(" where s.schedule=:schedule ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("schedule", schedule);
		Byte maxOrderno = (Byte) query.getSingleResult();
		return (byte) (maxOrderno != null ? maxOrderno : 2);
	}

	public Schedulestop getMaxSchedulestop(Schedule schedule, Byte orderno) {
		StringBuilder sql = new StringBuilder("select s from Schedulestop s ")
				.append(" where s.schedule=:schedule and s.orderno=:orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("schedule", schedule);
		query.setParameter("orderno", orderno);
		return (Schedulestop) query.getSingleResult();
	}

	@SuppressWarnings("unchecked")
	public List<Object> getRoutestop(Route route) {
		StringBuilder sql = new StringBuilder("select st.id,st.name,st.code ")
				.append(" from Routestop rs,Station st ")
				.append(" where rs.isactive=1 and rs.route=:route")
				.append(" and rs.stationid=st.id order by rs.orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("route", route);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> createDistrictTree(String orgids) {
		StringBuilder sql = null;
		sql = new StringBuilder("select st.id,st.name,st.code ")
				.append(" from Routestop rs,Station st ")
				.append(" where rs.isactive=1 and rs.route=:route")
				.append(" and rs.stationid=st.id order by rs.orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	public boolean checkLongDate(Schedulelongstop sl) {
		StringBuilder sql = null;
		if (sl.getId() > 0) {
			sql = new StringBuilder(
					"select s from Schedulelongstop s where s.startdate<=:fromdate and ")
					.append(" s.enddate>=:enddate and s.schedule=:schedule and s.id!=:id");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("id", sl.getId());
			query.setParameter("schedule", sl.getSchedule());
			query.setParameter("fromdate", sl.getStartdate());
			query.setParameter("enddate", sl.getEnddate());
			return query.getResultList().size() > 0;

		} else {
			sql = new StringBuilder(
					"select s from Schedulelongstop s where s.startdate<=:fromdate and")
					.append(" s.enddate>=:enddate and s.schedule=:schedule");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("schedule", sl.getSchedule());
			query.setParameter("fromdate", sl.getStartdate());
			query.setParameter("enddate", sl.getEnddate());
			return query.getResultList().size() > 0;
		}

	}

	@SuppressWarnings("unchecked")
	public List<Object> getSchedulelongstop(Schedule schedule) {
		StringBuilder sql = new StringBuilder(
				"select ss,u1.name as approvename,u2.name as createdname,s.code,")
				.append(" s.route.name as routename")
				.append(" from Schedulelongstop ss,Userinfo u1,Userinfo u2,Schedule s ")
				.append(" where  ss.schedule=:schedule and ss.schedule=s and ")
				.append(" u1.id=ss.approveby and u2.id=ss.createby order by ss.startdate");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("schedule", schedule);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public boolean isRouteEndstation(Schedulestop schedulestop) {
		StringBuilder sql = new StringBuilder(
				"select r  from Route r,Schedule s").append(
				" where r=s.route and r.endstationid=:endstationid").append(
				" and s=:schedule ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("schedule", schedulestop.getSchedule());
		query.setParameter("endstationid", schedulestop.getStationid());
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? true : false;
	}

	@SuppressWarnings("unchecked")
	public Routestop getRoutestop(long scheduleid, long stationid) {
		StringBuilder sql = new StringBuilder("select rs")
				.append(" from Routestop rs,Schedule s ")
				.append(" where rs.route=s.route and s.id=:scheduleid")
				.append(" and rs.stationid=:stationid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("stationid", stationid);
		List<Object> list = query.getResultList();
		return (Routestop) (list != null && list.size() > 0 ? list.get(0)
				: null);
	}
	@SuppressWarnings("unchecked")
	public List<Routestop> getRoutestop(long scheduleid ) {
		StringBuilder sql = new StringBuilder("select rs")
				.append(" from Routestop rs,Schedule s ")
				.append(" where rs.route=s.route and s.id=:scheduleid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return  query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public List<Schedulestop> getScheulestop(long scheduleid, byte orderno) {
		StringBuilder sql = new StringBuilder("select ss")
				.append(" from Schedulestop ss ")
				.append(" where ss.schedule.id=:scheduleid and ss.orderno>=:orderno")
				.append(" order by ss.orderno desc");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("orderno", orderno);
		List<Schedulestop> list = query.getResultList();
		return list;
	}

	public Schedulestop getSchedulestop(long scheduleid, long stationid) {
		StringBuilder sql = new StringBuilder("select ss")
				.append(" from Schedulestop ss ")
				.append(" where ss.schedule.id=:scheduleid")
				.append(" and ss.stationid=:stationid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("stationid", stationid);
		List<Object> list = query.getResultList();
		return (Schedulestop) (list != null && list.size() > 0 ? list.get(0)
				: null);
	}
	@SuppressWarnings("unchecked")
	public Schedulestop getSchedulestopbyno(long scheduleid, byte orderno) {
		StringBuilder sql = new StringBuilder("select ss").append(
				" from Schedulestop ss ").append(
				" where ss.schedule.id=:scheduleid and ss.orderno=:orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("orderno", orderno);
		List<Schedulestop> list = query.getResultList();
		return (Schedulestop) (list != null && list.size() > 0 ? list.get(0)
				: null);
	}
	@SuppressWarnings("unchecked")
	public boolean isExistOrderno(long scheduleid, byte orderno) {
		StringBuilder sql = new StringBuilder("select ss").append(
				" from Schedulestop ss ").append(
				" where ss.schedule.id=:scheduleid and ss.orderno=:orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("orderno", orderno);
		List<Schedulestop> list = query.getResultList();
		return list != null && list.size() > 0 ? true : false;
	}

	@SuppressWarnings("unchecked")
	public Schedulestop getMaxSchedulestop(long scheduleid, long routeid) {
		StringBuilder sql = new StringBuilder("select ss")
				.append(" from Schedulestop ss,Route r ")
				.append(" where ss.schedule.id=:scheduleid ")
				.append(" and ss.stationid=r.endstationid and r.id=:routeid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("routeid", routeid);
		List<Schedulestop> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}
	@SuppressWarnings("unchecked")
	public long getMaxSchedulestoporderno(long scheduleid) {
		StringBuilder sql = new StringBuilder("select max(ss.orderno)")
				.append(" from Schedulestop ss ")
				.append(" where ss.schedule.id=:scheduleid ");				
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		List<Object> list = query.getResultList();
		return (Long) (list != null && list.size() > 0 ? list.get(0) : null);
	}
	
	@SuppressWarnings("unchecked")
	public List<Schedulestop> qrySchedulestop(long scheduleid) {
		StringBuilder sql = new StringBuilder("select ss")
				.append(" from Schedulestop ss ")
				.append(" where ss.schedule.id=:scheduleid ");				
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();		
	}

	@SuppressWarnings("unchecked")
	public boolean isExistScheduleplan(long scheduleid, Date startdate,
			Date enddate) {

		StringBuilder sql = new StringBuilder(
				"select s from Scheduleplan s where s.scheduleid=:scheduleid")
				.append(" and s.departdate>=:startdate and s.departdate<=:enddate");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		List<Object> result = query.getResultList();
		return result != null && result.size() > 0 ? true : false;
	}
	public List<Scheduleplan> qryScheduleplan(long scheduleid, Date startdate,
			Date enddate) {

		StringBuilder sql = new StringBuilder(
				"select s from Scheduleplan s where s.scheduleid=:scheduleid")
				.append(" and s.departdate>=:startdate and s.departdate<=:enddate");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public boolean isExistScheduleplan(long scheduleid, Date departdate) {

		StringBuilder sql = new StringBuilder(
				"select s from Scheduleplan s where s.scheduleid=:scheduleid")
				.append(" and s.departdate>=:departdate");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("departdate", departdate);
		List<Object> result = query.getResultList();
		return result != null && result.size() > 0 ? true : false;
	}

	@SuppressWarnings("unchecked")
	public boolean isExistSchedulecycle(long scheduleid) {

		StringBuilder sql = new StringBuilder(
				"select s from Cycleschemesschedule s where s.scheduleid=:scheduleid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		List<Object> result = query.getResultList();
		return result != null && result.size() > 0 ? true : false;
	}

	@SuppressWarnings("unchecked")
	public Handprice qryHandPrice(long scheduleid) {
		StringBuilder sql = new StringBuilder(
				"select s from Handprice s where s.scheduleid=:scheduleid ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		List<Object> list = query.getResultList();
		return (Handprice) (list != null && list.size() > 0 ? list.get(0)
				: null);
	}

	// 获取班次上车站信息
	// 获取班次停靠点信息
	@SuppressWarnings("unchecked")
	public List<Schedulestop> qrySchedulestop(long scheduleid, boolean isdepart) {
		StringBuilder sql = new StringBuilder("select t from Schedulestop t")
				.append(" where t.schedule.id = :scheduleid")
				.append(" and t.isactive=1 and t.isdepart=:isdepart order by orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("isdepart", isdepart);
		return query.getResultList();
	}

	public Schedule getScheduleBySyncCode(String synccode){
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!synccode", synccode));
		return (Schedule) super.uniqueResult(Schedule.class, propertyFilters);
	}
	
	/**
	 * 根据班次代码和发车机构ID获取班次（只要是该班次停靠传入机构所在的站点，即返回）：<br/>
	 * @param code 班次代码
	 * @param orgid 发车站机构ID
	 * @return 
	 */
	public Schedule getScheduleByCode(String code,Long orgid,Date departdate){
		StringBuilder sb = new StringBuilder();
		sb.append("select distinct sc from Schedule sc,Ticketprice scs,Organization o")
		.append(" where sc.id=scs.scheduleid")
		.append(" and scs.departstationid=o.station.id")
		;
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_o!id", orgid));
		
		propertyFilters.add(new PropertyFilter("EQS_sc!code", code));
//		propertyFilters.add(new PropertyFilter("EQB_sc!isactive", true));
		
		propertyFilters.add(new PropertyFilter("EQD_scs!departdate", departdate));
		propertyFilters.add(new PropertyFilter("EQB_scs!issellable", true));
		
		return (Schedule) super.uniqueResult(sb.toString(), propertyFilters);
	}

	/**
	 * 批量修改班次信息需要的停靠点
	 * @param scheduleid
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> getSchedulestopTwo(long scheduleid) {
		StringBuilder sql = new StringBuilder(
				"select s.id,s.stationid,s.issellable,s.isdepart,s.remark1,s.remark2,st.name as stationname,t.name as ticketentrance,")
				.append(" v.name as vehiclepark")
				.append(" from Schedulestop s LEFT JOIN s.ticketentrance t LEFT JOIN s.vehiclepark v ,Station st ")
				.append(" where s.isactive=1 and s.schedule.id=:scheduleid")
				.append(" and s.stationid=st.id order by s.orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}
	public boolean isDepart(Long stationid){
		StringBuilder sql = new StringBuilder(
		"select t from Organization t where t.station.id=:stationid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("stationid", stationid);
		List<Object> list=query.getResultList();
		return list!=null&&list.size()>0?true:false;
	}
	
	public List<Object> findrouteid(long scheduleid){
		StringBuilder sql = new StringBuilder(" select s from Schedule s where s.id=:scheduleid ");
		Query query = getEntityManager().createQuery(sql.toString(),Schedule.class);
		query.setParameter("scheduleid", scheduleid);
		List<Schedule> list = query.getResultList();
		List<Object> lobject = new ArrayList<Object>();
		if(list!=null && list.size()>0){			
			long routeid = list.get(0).getRoute().getId();
			lobject.add(0, routeid);
			return lobject;
		}
		return null;
		
	}
	
	public void updateScheduleIsactive(String code,long orgid){
		StringBuilder sql = new StringBuilder(" update Schedule s set s.isactive=0 where s.code=:code and s.orgid=:orgid ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("code", code);
		query.setParameter("orgid", orgid);
		query.executeUpdate();
		
	}
	
	// 判断该班次号在加班日期内是否有营运计划
	@SuppressWarnings("unchecked")
	public boolean isExistScheduleplanByCode(String code, long orgid,Date startdate, Date enddate) {

		StringBuilder sql = new StringBuilder(
				"select sp from Scheduleplan sp,Schedule s  where sp.scheduleid = s.id and s.code=:code and s.orgid=:orgid ");
		sql.append(" and sp.departdate>=:startdate and sp.departdate<=:enddate ");
		Query query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("code", code);
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		List<Object> result = query.getResultList();
		return result != null && result.size() > 0 ? true : false;
	}
	
	@SuppressWarnings("unchecked")
	public Schedule findScheduleByAddCode(String code, long orgid,long routeid) {

		StringBuilder sql = new StringBuilder(
				"select s from Schedule s  where s.code=:code and s.orgid=:orgid and s.isovertime=1 ");
		sql.append(" and s.route.id =:routeid order by s.createtime desc ");
		Query query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("code", code);
		query.setParameter("routeid", routeid);
		List<Object> result = query.getResultList();
		return result.size() > 0 ? (Schedule)result.get(0) : null;
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> querySchedule(List<PropertyFilter> propertyFilterList,String schedulestatus) {
		StringBuilder sql = new StringBuilder("select s.id, s.routeid,")
				.append(" s.orgid,s.code,s.worktype,s.workways,s.districttype,")
				.append(" s.type,trim(s.starttime),s.runtime,s.isproprietary,")
				.append(" s.isovertime,s.issellreturnticket,s.islinework,")
				.append(" s.isoriginator,s.issaleafterreport,s.iscanmixcheck,")
				.append(" s.planseatnum,s.viastation,s.printinfo,s.remarks,")
				.append(" s.isaudited,s.isauditpass,s.isactive,s.createtime,")
				.append(" s.createby,s.updatetime,s.updateby,trim(s.endtime),s.spacinginterval,")
				.append(" s.synccode, ")
				.append(" o.name as orgname,r.name as routename,us1.name as username,t.name as ticketentrance,")
				.append(" v.name as vehcilepark,r.startstationid ,r.endstationid,r.id as routeid,")
				.append(" t.id as entranceid,v.id as parkid,1 as islongstop,s.isfixseat,s.isneedfinger,s.driverfingernum,s.endstation,s.startstationprice")
				.append("  ,s.isautoreport as isautoreport from Schedule s ,Route r,Userinfo us1,Organization o,Schedulestop ss ")
				.append(" LEFT JOIN  ticketentrance t on ss.ticketentranceid=t.id  ")
				.append(" LEFT JOIN  vehiclepark v on v.id=ss.vehcileparkid ")
				.append(" where s.orgid=o.id and r.startstationid=ss.stationid and s.id=ss.scheduleid")
				.append(" and isdepart=1 and s.routeid=r.id and r.isactive=1")
				.append(" and s.createby=us1.id  ")
				//加班班次只按isdelete判断是否删除，正常班次使用isdelete和isactive共同控制
				.append(" and ((s.isactive=1 and s.isdelete=0) or (s.isovertime=1 and s.isdelete=0)) ")
				.append(" and exists (select 1 from Schedulelongstop ss")
				.append(" where ss.startdate<=:curdate and ss.enddate+0.99999>=:curdate and s.id=ss.scheduleid)");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by r.name,s.starttime,s.code ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("curdate", new Date());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		List<Object> list = query.getResultList();
		sql = new StringBuilder("select s.id, s.routeid,")
				.append(" s.orgid,s.code,s.worktype,s.workways,s.districttype,")
				.append(" s.type,trim(s.starttime),s.runtime,s.isproprietary,")
				.append(" s.isovertime,s.issellreturnticket,s.islinework,")
				.append(" s.isoriginator,s.issaleafterreport,s.iscanmixcheck,")
				.append(" s.planseatnum,s.viastation,s.printinfo,s.remarks,")
				.append(" s.isaudited,s.isauditpass,s.isactive,s.createtime,")
				.append(" s.createby,s.updatetime,s.updateby,trim(s.endtime),s.spacinginterval,")
				.append(" s.synccode, ")
				.append(" o.name as orgname,r.name as routename,us1.name as username,t.name as ticketentrance,")
				.append(" v.name as vehcilepark,r.startstationid ,r.endstationid,r.id as routeid,")
				.append(" t.id as entranceid,v.id as parkid,0 as islongstop,s.isfixseat,s.isneedfinger,s.driverfingernum,s.endstation,s.startstationprice")
				.append("  ,s.isautoreport as isautoreport from Schedule s ,Route r,Userinfo us1,Organization o,Schedulestop ss ")
				.append(" LEFT JOIN  ticketentrance t on ss.ticketentranceid=t.id  ")
				.append(" LEFT JOIN  vehiclepark v on v.id=ss.vehcileparkid ")
				.append(" where s.orgid=o.id and r.startstationid=ss.stationid and s.id=ss.scheduleid")
				.append(" and isdepart=1 and s.routeid=r.id and r.isactive=1")
				.append(" and s.createby=us1.id  ")
				//班次加班菜单，显示加班班次，其他菜单暂时不显示加班班次
				.append(" and ((s.isactive=1 and s.isdelete=0) or (s.isovertime=1 and s.isdelete=0)) ")
				.append(" and not exists (select 1 from Schedulelongstop ss")
				.append(" where ss.startdate<=:curdate and ss.enddate+0.99999>=:curdate and s.id=ss.scheduleid)");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by r.name,s.starttime,s.code ");
		query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("curdate", new Date());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		if("1".equals(schedulestatus)){
//			list.addAll(query.getResultList());	
			return query.getResultList();
		}else if ("2".equals(schedulestatus)){
//			list.addAll(query.getResultList());
			return list;
		}else{
			list.addAll(query.getResultList());
			return list;
		}
//		return list;
	}
}
