package cn.nova.bus.price.dao;

import java.math.BigDecimal;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Ticketoutletsprice;
import cn.nova.bus.price.model.Ticketoutletsrouteprice;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：售票点票价差额管理</b><br/>
 * <b>类名称：</b>TicketoutletspriceDao.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b>2013-11-01 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class TicketoutletspriceDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
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
				.append(" t.id as entranceid,v.id as parkid,1 as islongstop,s.isfixseat,tp.name as outletsname,tp.id as ticketoutletsid")
				.append(" from Schedule s LEFT JOIN Ticketoutlets tp on tp.isactive =1 and tp.id>0,")
				.append(" Route r,Userinfo us1,Organization o,Schedulestop ss ")
				.append(" LEFT JOIN  ticketentrance t on ss.ticketentranceid=t.id  ")
				.append(" LEFT JOIN  vehiclepark v on v.id=ss.vehcileparkid ")
				.append(" where s.orgid=o.id and r.startstationid=ss.stationid and s.id=ss.scheduleid")
				.append(" and isdepart=1 and s.routeid=r.id and r.isactive=1")
				.append(" and s.createby=us1.id and s.isactive=1 ")
				.append(" and exists (select 1 from Schedulelongstop ss")
				.append(" where ss.startdate<=:curdate and ss.enddate>=:curdate and s.id=ss.scheduleid)");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by tp.name,r.name,s.starttime,s.code ");
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
				.append(" t.id as entranceid,v.id as parkid,0 as islongstop,s.isfixseat,tp.name as outletsname,tp.id as ticketoutletsid")
				.append(" from Schedule s LEFT JOIN Ticketoutlets tp on s.orgid= tp.orgid and tp.isactive =1 and tp.id>0,")
				.append(" Route r,Userinfo us1,Organization o,Schedulestop ss ")
				.append(" LEFT JOIN  ticketentrance t on ss.ticketentranceid=t.id  ")
				.append(" LEFT JOIN  vehiclepark v on v.id=ss.vehcileparkid ")
				.append(" where s.orgid=o.id and r.startstationid=ss.stationid and s.id=ss.scheduleid")
				.append(" and isdepart=1 and s.routeid=r.id and r.isactive=1")
				.append(" and s.createby=us1.id and (s.isactive = 1) ") // or (s.isactive = 0 and s.isovertime = 1 and s.updatetime>=sysdate-2 ))
				.append(" and  not exists (select 1 from Schedulelongstop ss")
				.append(" where ss.startdate<=:curdate and ss.enddate>=:curdate and s.id=ss.scheduleid)");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by tp.name,r.name,s.starttime,s.code ");
		query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("curdate", new Date());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		list.addAll(query.getResultList());
		return list;
	}

	// 查询界面的子查询
	@SuppressWarnings("unchecked")
	public List<Object> qryTicketoutletsprice(Long scheduleid,
			Long ticketoutletsid) {
		StringBuilder sql = new StringBuilder(
				"select hp.id,hp.scheduleid,hp.seattype,")
				.append("  case when hp.seats = '0' then '全部'")
				.append(" else hp.seats end as seats,")
				.append(" hp.fullprice,hp.halfprice,")
				.append(" hp.studentprice,")
				.append(" s1.name as departstation,s2.name as reachstation,v.name as vehicletype, ")
				.append(" hp.toplimitprice,hp.lowerlimitprice,hp.vehicletypeid,vd.brandname,vd.modelcode,")
				.append(" vd.rationseatnum,hp.moreprice,hp.departstationid,hp.reachstationid,")
				.append(" rs.distance,(case when tp.difprice is null then 0 else tp.difprice end) difprice,")
				.append(" (case when tp.id is null then 0 else tp.id end) ticketoutletspriceid,")
				.append(" tp.starttime as starttime,tp.endtime as endtime")
				.append(" from Station s1,Station s2,Vehicletype v,Schedulestop ss,")
				.append(" Handprice hp LEFT JOIN Ticketoutletsprice tp on ")
				.append(" hp.scheduleid = tp.scheduleid and hp.departstationid=tp.departstationid")
				.append(" and hp.reachstationid=tp.reachstationid and hp.vehicletypeid= tp.vehicletypeid");
		if (ticketoutletsid > 0) {
			sql.append(" and tp.ticketoutletsid = " + ticketoutletsid);
		}
		sql.append(" and hp.seattype=tp.seattype")
				.append(" left join Vehiclebrandmodel vd on vd.id=hp.vehiclebrandmodelid,")
				.append(" Schedulestop ss2,Schedule s,Routestop rs")
				.append(" where hp.scheduleid=:scheduleid  ")
				.append(" and hp.departstationid=s1.id  and hp.reachstationid=s2.id ")
				.append(" and hp.vehicletypeid=v.id and hp.reachstationid=ss.stationid")
				.append(" and hp.scheduleid=ss.scheduleid  and ss.isactive=1 and s.isactive=1 ") //or (s.isactive=0 and s.updatetime>sysdate-3)
				.append(" and hp.scheduleid=s.id and s.routeid=rs.routeid  and hp.reachstationid=rs.stationid")
				.append(" and hp.departstationid=ss2.stationid and ss2.scheduleid=hp.scheduleid and ss2.isactive=1");
		sql.append(" order by hp.vehicletypeid,ss2.orderno,ss.orderno");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		// query.setParameter("ticketoutletsid", ticketoutletsid);
		return query.getResultList();
	}

	// 编辑界面的查询
	@SuppressWarnings("unchecked")
	public List<Object> qryEdtTicketoutletsprice(
			Ticketoutletsprice ticketoutletsprice) {
		if (ticketoutletsprice.getVehiclebrandmodelid() != null) {
			StringBuilder sql = new StringBuilder(
					"select tp.id,hp.scheduleid,hp.departstationid,")
					.append(" hp.reachstationid,hp.vehicletypeid,hp.vehiclebrandmodelid,")
					.append(" vb.brandname,")
					.append(" hp.seattype,hp.fullprice,hp.halfprice,")
					.append(" hp.studentprice,hp.toplimitprice,hp.lowerlimitprice,")
					.append(" hp.createby,")
					.append(" vt.name as vehicletype,s1.name as departstation,")
					.append(" s2.name as reachstation,nvl(hp.moreprice,0) as moreprice,rs.distance,")
					.append(" (case when tp.difprice is null then 0 else tp.difprice end) difprice")
					.append(" ,tp.starttime as starttime,tp.endtime as endtime ")
					.append(" from Ticketoutletsprice tp LEFT JOIN Handprice hp  on ")
					.append(" hp.scheduleid = tp.scheduleid and hp.departstationid=tp.departstationid")
					//.append(" and tp.starttime is null")
					.append(" and hp.reachstationid=tp.reachstationid and hp.vehicletypeid= tp.vehicletypeid");
			
			sql.append(
					" and hp.vehiclebrandmodelid = tp.vehiclebrandmodelid and hp.seattype=tp.seattype ,")
					.append(" vehiclebrandmodel vb,Schedulestop ss,")
					.append(" vehicletype vt,station s1,station s2,")
					.append(" Schedulestop ss2,Schedule s,Routestop rs")
					.append(" where hp.vehiclebrandmodelid=vb.id and hp.vehicletypeid=:vehicletypeid")
					.append(" and hp.departstationid=s1.id and hp.reachstationid=s2.id")
					.append(" and hp.vehicletypeid=vt.id and hp.scheduleid=:scheduleid")
					.append(" and hp.vehiclebrandmodelid=:vehiclebrandmodelid")
					.append(" and hp.reachstationid=ss.stationid")
					.append(" and hp.scheduleid=s.id and s.routeid=rs.routeid  and hp.reachstationid=rs.stationid")
					.append(" and hp.scheduleid=ss.scheduleid and ss.isactive=1")
					.append(" and hp.departstationid=ss2.stationid and ss2.scheduleid=hp.scheduleid and ss2.isactive=1");
					if (ticketoutletsprice.getTicketoutletsid() > 0) {
						sql.append(" and tp.ticketoutletsid = "
								+ ticketoutletsprice.getTicketoutletsid());
					}
					sql.append(" order by hp.vehicletypeid,hp.vehiclebrandmodelid,")
					.append(" ss2.orderno,ss.orderno");
			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("scheduleid", ticketoutletsprice.getScheduleid());
			query.setParameter("vehicletypeid",
					ticketoutletsprice.getVehicletypeid());
			query.setParameter("vehiclebrandmodelid",
					ticketoutletsprice.getVehiclebrandmodelid());
			return query.getResultList();
		} else {
			StringBuilder sql = new StringBuilder(
					"select tp.id,hp.scheduleid,hp.departstationid,")
					.append(" hp.reachstationid,hp.vehicletypeid,hp.vehiclebrandmodelid,")
					.append(" vb.brandname,")
					.append(" hp.seattype,hp.fullprice,hp.halfprice,")
					.append(" hp.studentprice,hp.toplimitprice,hp.lowerlimitprice,")
					.append(" hp.createby,")
					.append(" vt.name as vehicletype,s1.name as departstation,")
					.append(" s2.name as reachstation,hp.moreprice,rs.distance,")
					.append(" (case when tp.difprice is null then 0 else tp.difprice end) difprice")
					.append(" ,tp.starttime as starttime,tp.endtime as endtime ")
					.append(" from Ticketoutletsprice tp  LEFT JOIN Handprice hp on ")
					.append(" hp.scheduleid = tp.scheduleid and hp.departstationid=tp.departstationid")
					.append(" and hp.reachstationid=tp.reachstationid and hp.vehicletypeid= tp.vehicletypeid")
					//.append(" and tp.starttime is null ")
					.append(" and hp.seattype=tp.seattype");
			sql.append(" left join vehiclebrandmodel vb")
					.append(" on hp.vehiclebrandmodelid=vb.id,")
					.append(" vehicletype vt,station s1,station s2,Schedulestop ss,")
					.append(" Schedulestop ss2,Schedule s,Routestop rs")
					.append(" where hp.departstationid=s1.id and hp.reachstationid=s2.id")
					.append(" and hp.vehicletypeid=vt.id and hp.vehicletypeid=:vehicletypeid")
					.append(" and hp.scheduleid=:scheduleid")
					.append(" and hp.scheduleid=s.id and s.routeid=rs.routeid  and hp.reachstationid=rs.stationid")
					.append(" and hp.reachstationid=ss.stationid")
					.append(" and hp.scheduleid=ss.scheduleid and ss.isactive=1")
					.append(" and hp.departstationid=ss2.stationid and ss2.scheduleid=hp.scheduleid and ss2.isactive=1");
					if (ticketoutletsprice.getTicketoutletsid() > 0) {
						sql.append(" and tp.ticketoutletsid = "
								+ ticketoutletsprice.getTicketoutletsid());
					}
					sql.append(" order by hp.vehicletypeid,hp.vehiclebrandmodelid,")
					.append(" ss2.orderno, ss.orderno");
			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("scheduleid", ticketoutletsprice.getScheduleid());
			query.setParameter("vehicletypeid",
					ticketoutletsprice.getVehicletypeid());
			return query.getResultList();
		}
	}
	
	// 编辑界面的查询（新增时）
	@SuppressWarnings("unchecked")
	public List<Object> qryEdtTicketoutletspricesave(
			Ticketoutletsprice ticketoutletsprice) {
		if (ticketoutletsprice.getVehiclebrandmodelid() != null) {
			StringBuilder sql = new StringBuilder(
					"select 0 as id,hp.scheduleid,hp.departstationid,")
					.append(" hp.reachstationid,hp.vehicletypeid,hp.vehiclebrandmodelid,")
					.append(" vb.brandname,")
					.append(" hp.seattype,hp.fullprice,hp.halfprice,")
					.append(" hp.studentprice,hp.toplimitprice,hp.lowerlimitprice,")
					.append(" hp.createby,")
					.append(" vt.name as vehicletype,s1.name as departstation,")
					.append(" s2.name as reachstation,nvl(hp.moreprice,0) as moreprice,rs.distance,")
					.append(" 0 as difprice")
					.append(" from Handprice hp, ")
					.append(" vehiclebrandmodel vb,Schedulestop ss,")
					.append(" vehicletype vt,station s1,station s2,")
					.append(" Schedulestop ss2,Schedule s,Routestop rs")
					.append(" where hp.vehiclebrandmodelid=vb.id and hp.vehicletypeid=:vehicletypeid")
					.append(" and hp.departstationid=s1.id and hp.reachstationid=s2.id")
					.append(" and hp.vehicletypeid=vt.id and hp.scheduleid=:scheduleid")
					.append(" and hp.vehiclebrandmodelid=:vehiclebrandmodelid")
					.append(" and hp.reachstationid=ss.stationid")
					.append(" and hp.scheduleid=s.id and s.routeid=rs.routeid  and hp.reachstationid=rs.stationid")
					.append(" and hp.scheduleid=ss.scheduleid and ss.isactive=1")
					.append(" and hp.departstationid=ss2.stationid and ss2.scheduleid=hp.scheduleid and ss2.isactive=1")
					.append(" order by hp.vehicletypeid,hp.vehiclebrandmodelid,")
					.append(" ss2.orderno,ss.orderno");
			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("scheduleid", ticketoutletsprice.getScheduleid());
			query.setParameter("vehicletypeid",
					ticketoutletsprice.getVehicletypeid());
			query.setParameter("vehiclebrandmodelid",
					ticketoutletsprice.getVehiclebrandmodelid());
			return query.getResultList();
		} else {
			StringBuilder sql = new StringBuilder(
					"select  0 as id,hp.scheduleid,hp.departstationid,")
					.append(" hp.reachstationid,hp.vehicletypeid,hp.vehiclebrandmodelid,")
					.append(" vb.brandname,")
					.append(" hp.seattype,hp.fullprice,hp.halfprice,")
					.append(" hp.studentprice,hp.toplimitprice,hp.lowerlimitprice,")
					.append(" hp.createby,")
					.append(" vt.name as vehicletype,s1.name as departstation,")
					.append(" s2.name as reachstation,hp.moreprice,rs.distance,")
					.append(" 0 as difprice")
					.append(" from Handprice hp  ");
			sql.append(" left join vehiclebrandmodel vb")
					.append(" on hp.vehiclebrandmodelid=vb.id,")
					.append(" vehicletype vt,station s1,station s2,Schedulestop ss,")
					.append(" Schedulestop ss2,Schedule s,Routestop rs")
					.append(" where hp.departstationid=s1.id and hp.reachstationid=s2.id")
					.append(" and hp.vehicletypeid=vt.id and hp.vehicletypeid=:vehicletypeid")
					.append(" and hp.scheduleid=:scheduleid")
					.append(" and hp.scheduleid=s.id and s.routeid=rs.routeid  and hp.reachstationid=rs.stationid")
					.append(" and hp.reachstationid=ss.stationid")
					.append(" and hp.scheduleid=ss.scheduleid and ss.isactive=1")
					.append(" and hp.departstationid=ss2.stationid and ss2.scheduleid=hp.scheduleid and ss2.isactive=1")
					.append(" order by hp.vehicletypeid,hp.vehiclebrandmodelid,")
					.append(" ss2.orderno, ss.orderno");
			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("scheduleid", ticketoutletsprice.getScheduleid());
			query.setParameter("vehicletypeid",
					ticketoutletsprice.getVehicletypeid());
			return query.getResultList();
		}
	}
	@SuppressWarnings("unchecked")
	public List<Ticketoutletsprice> qryTicketoutletsprice(long scheduleid,
			long vehicletypeid) {
		StringBuilder sql = new StringBuilder("select t from")
				.append(" Ticketoutletsprice t where ")
				.append(" t.scheduleid=:scheduleid")
				.append(" and t.vehicletypeid!=:vehicletypeid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("vehicletypeid", vehicletypeid);
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}

	// 删除售票点票价差额
	public boolean delTicketoutletsprice(List<PropertyFilter> propertyFilterList)
			throws ServiceException {
		StringBuilder sql = new StringBuilder(
				"delete Ticketoutletsprice tp where tp.id in ");
		sql.append(
				"(select h.id from Ticketoutletsprice h,Schedule s,Route r,Organization o where ")
				.append(" h.scheduleid=s.id and s.route.id=r.id and r.orgid=o.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true)).append(")");
		Query query = super.getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		query.executeUpdate();
		return true;
	}

	// 查询该记录的所有时间段的票价信息
	public List<Ticketoutletsprice> isExistTicketoutletsprice(
			Ticketoutletsprice currticketoutlets) throws ServiceException {
		StringBuilder sql = new StringBuilder(
				"select tp from  Ticketoutletsprice tp ");
		sql.append("where tp.scheduleid=:scheduleid ")
				.append(" and tp.ticketoutletsid=:ticketoutletsid")
				.append(" and tp.vehicletypeid=:vehicletypeid ");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleid", currticketoutlets.getScheduleid());
		query.setParameter("ticketoutletsid",
				currticketoutlets.getTicketoutletsid());
		query.setParameter("vehicletypeid",
				currticketoutlets.getVehicletypeid());

		return query.getResultList();
	}

// 查询要修改的差额数据记录
	public Ticketoutletsprice qryTicketoutletspriceByTime(
			Ticketoutletsprice currticketoutlets,Ticketoutletsprice ticketoutletsprice) throws ServiceException {
		StringBuilder sql = new StringBuilder(
				"select tp from  Ticketoutletsprice tp ");
		sql.append("where tp.scheduleid=:scheduleid ")
				.append(" and  trunc(tp.starttime)=trunc(:starttime) ")
				.append(" and  trunc(tp.endtime)=trunc(:endtime) ")
				.append(" and tp.ticketoutletsid=:ticketoutletsid")
				.append(" and tp.reachstationid=:reachstationid")
				.append(" and tp.departstationid=:departstationid")
				.append(" and tp.vehicletypeid=:vehicletypeid ");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleid", currticketoutlets.getScheduleid());
		query.setParameter("ticketoutletsid",currticketoutlets.getTicketoutletsid());
		query.setParameter("vehicletypeid",currticketoutlets.getVehicletypeid());
		query.setParameter("starttime",currticketoutlets.getStarttime());
		query.setParameter("endtime",currticketoutlets.getEndtime());
		query.setParameter("reachstationid",ticketoutletsprice.getReachstationid());
		query.setParameter("departstationid",ticketoutletsprice.getDepartstationid());
		return   query.getResultList().size()>0?(Ticketoutletsprice)query.getResultList().get(0):null;
	}
	
	/**
	 * 查询线路信息(线路售票点票价差额)
	 * @param propertyFilter 
	 */
	public List<Object> queryRouteinfo(List<PropertyFilter> propertyFilterList) throws ServiceException {
		Iterator<PropertyFilter> iterator = propertyFilterList.iterator();
		String districttype = null;
		while (iterator.hasNext()) {
			PropertyFilter propertyFilter = iterator.next();
			if ("r!districttype".equals(propertyFilter.getPropertyFullName())) {
				districttype = (String)propertyFilter.getMatchValue();
				iterator.remove();
				break;
			}
		}
		if (districttype != null) {
			districttype = districttype.substring(1, districttype.length()-1);
			String[] split = districttype.split(",");
			districttype = "";
			for (int i = 0; i < split.length; i++) {
				if (i == 0) {
					districttype += "('" + split[i] + "'";
				} else {
					districttype += ",'" + split[i] + "'";
				}
			}
			districttype += ")";
		}
		StringBuilder sql = new StringBuilder();
		sql.append(" select distinct r.id, ")
		.append(" o.name as orgname, ")
		.append(" r.name as routename, ")
		.append(" s1.name as startstation, ")
		.append(" s2.name as endstation, ")
		.append(" r.distance, ")
		.append(" r.highdistance, ")
		.append(" dd2.value as districttype,")//--区域类别 
		.append(" dd4.value as routetype, ")// 线路类型
		.append(" dd3.value as grade, ")//--线路等级
		.append(" dd1.value as direction, ") //线路方向
		.append(" r.returntripvaliddays, ")
		.append(" r.reportinterval ")
		.append(" from route r  ")
		.append(" left join organization o on o.id = r.orgid ")
		.append(" left join routestop rs on rs.routeid = r.id ")
		.append(" left join station s on s.id = rs.stationid ")
		.append(" left join station s1 on s1.id = r.startstationid ")
		.append(" left join station s2 on s2.id = r.endstationid ")
		.append(" left join digitaldictionary d1 on d1.tablename = 'route' and d1.columnname = 'direction' ")
		.append(" left join digitaldictionary d2 on d2.tablename = 'route' and d2.columnname = 'districttype' ")
		.append(" left join digitaldictionary d3 on d3.tablename = 'route' and d3.columnname = 'grade' ")
		.append(" left join digitaldictionary d4 on d4.tablename = 'route' and d4.columnname = 'type' ")
		.append(" left join digitaldictionarydetail dd1 on dd1.digitaldictionaryid = d1.id and dd1.code = r.direction ")
		.append(" left join digitaldictionarydetail dd2 on dd2.digitaldictionaryid = d2.id and dd2.code = r.districttype ")
		.append(" left join digitaldictionarydetail dd3 on dd3.digitaldictionaryid = d3.id and dd3.code = r.grade ")
		.append(" left join digitaldictionarydetail dd4 on dd4.digitaldictionaryid = d4.id and dd4.code = r.type where r.isactive =1 and rs.isactive = 1 ");
		if (districttype != null) {
			sql.append(" and r.districttype in " + districttype);
		}
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public List<Object> queryTicketoutletsRoutePriceinfo(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder();
		sql.append(" select ttl.id as ticketoutletsid , ttl.name as ticketoutletsname,s.name as startstation,s1.name as tostation,t.price,t.startdate,t.enddate from ticketoutletsrouteprice t ")
			.append(" left join route r on r.id = t.routeid ") 
			.append(" left join ticketoutlets ttl on ttl.id = t.ticketoutletsid ")
			.append(" left join station s on s.id = r.startstationid ")
			.append(" left join station s1 on s1.id = t.routestopid where r.isactive =1   ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public List<Object> queryRouteStopinfo(List<PropertyFilter> propertyFilterList, Date startdate, Date enddate,Long ticketoutletsid) {
		StringBuilder sql = new StringBuilder();
		sql.append(" select s1.name as startstation,s2.name as tostation,nvl(tt.price,0) as price,rs.stationid,nvl(tt.id,0) as id  from route r  ")
			.append(" left join routestop rs on rs.routeid = r.id ")
			.append(" left join station s1 on s1.id = r.startstationid ")
			.append(" left join station s2 on s2.id = rs.stationid ")
			.append(" left join (select t.routestopid,t.price,t.id from ticketoutletsrouteprice t where t.ticketoutletsid = :ticketoutletsid and  t.startdate = :startdate and t.enddate = :enddate ) tt on tt.routestopid = rs.stationid")
			.append(" where r.startstationid <> rs.stationid and r.isactive =1 and rs.isactive = 1 ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by s2.name ");
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		query.setParameter("ticketoutletsid", ticketoutletsid);
		return query.getResultList();
	}

	public boolean ticketoutletsroutepriceDateCompare(Date startdate, Date enddate, long routeid, Long ticketoutletsid,
			long stationid) {
		StringBuilder sql = new StringBuilder();
		sql.append(" select count(t.id) from ticketoutletsrouteprice t ")
		.append(" where t.routeid = :routeid  and t.ticketoutletsid = :ticketoutletsid ")
		.append(" and (t.startdate between :startdate and :enddate or t.enddate between :startdate and :enddate )  ");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		query.setParameter("routeid", routeid);
		query.setParameter("ticketoutletsid", ticketoutletsid);
		List list = query.getResultList();
		BigDecimal o = (BigDecimal) list.get(0);
		return o.compareTo(BigDecimal.ZERO)>0?true:false;
	}

	public List<Ticketoutletsrouteprice> findticketoutletsrouteprice(long routeid, Date startdate, Date enddate,
			Long ticketoutletsid) {
		StringBuilder sql = new StringBuilder();
		sql.append(" select t from  Ticketoutletsrouteprice t where t.routeid = :routeid and t.ticketoutletsid = :ticketoutletsid and t.startdate = :startdate and t.enddate = :enddate ");
		Query query = em.createQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		query.setParameter("routeid", routeid);
		query.setParameter("ticketoutletsid", ticketoutletsid);
		return query.getResultList();
	}
	
	
}
