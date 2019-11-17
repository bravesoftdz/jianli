package cn.nova.bus.price.dao;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Routeroad;
import cn.nova.bus.base.model.Routestop;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Schedulestop;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Ticketdiscount;
import cn.nova.bus.common.ConstDefiniens;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Formulaitemdistance;
import cn.nova.bus.price.model.Formulaitemfixedvalue;
import cn.nova.bus.price.model.Formulaitemformula;
import cn.nova.bus.price.model.Formulaitemorggrade;
import cn.nova.bus.price.model.Formulaitemprice;
import cn.nova.bus.price.model.Formulaitemroadgrade;
import cn.nova.bus.price.model.Formulaitemroute;
import cn.nova.bus.price.model.Formulaitemschedule;
import cn.nova.bus.price.model.Formulaitemvehcile;
import cn.nova.bus.price.model.Formulaitemvehcileroadgrad;
import cn.nova.bus.price.model.Standardprice;
import cn.nova.bus.price.model.Ticketpriceformula;
import cn.nova.bus.price.model.Ticketpriceformulaitem;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class TicketpriceformulaDao extends EntityManagerDaoSurport {
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select t,us1.name as username,tt.name as ticketypename,tt.code,org.name as orgname ")
				.append(" from Ticketpriceformula t ,Tickettype tt,Userinfo us1,Organization org")
				.append(" where t.createby=us1.id and t.isactive=1 ")
				.append(" and t.tickettypeid=tt.id and t.orgid=org.id");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by org.id, t.startdate ");
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryitem(String orgids) {
		StringBuilder sql = new StringBuilder("select t ").append(
				" from Ticketpriceformulaitem t").append(
				" where t.orgid in "+orgids+" and t.isactive=1 order by t.code");
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	// 是否包含基础运价或者包含Q也行
	public boolean isExistFreight(Ticketpriceformula ticketpriceformula) {
		String formula = ticketpriceformula.getFormula();
		int pos = 0;
		int freightcount = 0;
		char item;
		while (pos < formula.length()) {
			item = formula.charAt(pos);
			if (ConstDefiniens.ITEM.indexOf(item) >= 0) {
				if (item == 'Q') {
					return false;
				}
				StringBuilder sql = new StringBuilder("select t ")
						.append(" from Ticketpriceformulaitem t")
						.append(" where t.orgid=:orgid and t.isactive=1 and t.code=:code ");
				Query query = getEntityManager().createQuery(sql.toString());
				query.setParameter("orgid", ticketpriceformula.getOrgid());
				query.setParameter("code", String.valueOf(item));
				List<Object> list = query.getResultList();
				if (list != null && list.size() > 0 && list.get(0) != null) {
					Ticketpriceformulaitem ticketpriceformulaitem = (Ticketpriceformulaitem) list
							.get(0);
					if (ticketpriceformulaitem.getIsfreight()) {
						freightcount++;
					}
				}
			}
			pos++;
		}
		if (freightcount == 1) {
			return false;
		}
		return true;
	}

	// 判断该票种该日期段是否已经存在
	@SuppressWarnings("unchecked")
	public boolean isExistformula(Ticketpriceformula ticketpriceformula) {
		StringBuilder sql = null;
		Query query = null;
		if (ticketpriceformula.getId() == 0) {
			sql = new StringBuilder("select s from Ticketpriceformula s ")
					.append(" where s.tickettypeid=:tickettypeid and s.isactive=1")
					.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
					.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
					.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
					.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
					.append(" and s.orgid=:orgid");
			query = getEntityManager().createQuery(sql.toString());
			query.setParameter("startdate", ticketpriceformula.getStartdate());
			query.setParameter("enddate", ticketpriceformula.getEnddate());
			query.setParameter("orgid", ticketpriceformula.getOrgid());
			query.setParameter("tickettypeid",
					ticketpriceformula.getTickettypeid());
			List<Object> objlist = query.getResultList();
			return objlist != null && objlist.size() > 0 ? true : false;

		} else {
			sql = new StringBuilder("select s from Ticketpriceformula s ")
					.append(" where s.tickettypeid=:tickettypeid and s.id!=:id and s.isactive=1")
					.append(" and ((s.startdate>=:startdate and startdate<=:enddate) ")
					.append(" or (s.startdate<=:startdate and s.enddate>=:enddate)")
					.append(" or (s.startdate<=:startdate and s.enddate>=:startdate)")
					.append(" or (s.startdate>=:startdate and s.enddate<=:enddate))")
					.append(" and s.orgid=:orgid");
			query = getEntityManager().createQuery(sql.toString());
			query.setParameter("id", ticketpriceformula.getId());
			query.setParameter("orgid", ticketpriceformula.getOrgid());
			query.setParameter("startdate", ticketpriceformula.getStartdate());
			query.setParameter("enddate", ticketpriceformula.getEnddate());
			query.setParameter("tickettypeid",
					ticketpriceformula.getTickettypeid());
			List<Object> objlist = query.getResultList();
			return objlist != null && objlist.size() > 0 ? true : false;
		}
	}

	@SuppressWarnings("unchecked")
	public Ticketpriceformula isExistDelFormula(
			Ticketpriceformula ticketpriceformula) {
		StringBuilder sql = new StringBuilder(
				"select s from Ticketpriceformula s where s.tickettypeid=:tickettypeid and s.isactive=0 and s.orgid=:orgid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("tickettypeid", ticketpriceformula.getTickettypeid());
		query.setParameter("orgid", ticketpriceformula.getOrgid());
		List<Object> objlist = query.getResultList();
		return objlist != null && objlist.size() > 0 ? (Ticketpriceformula) objlist
				.get(0) : null;
	}

	// 获取班次信息
	@SuppressWarnings("unchecked")
	public List<Schedule> qryOrgSchedule(Long orgid) {
		StringBuilder sql = new StringBuilder(
				"select t from Schedule t,Route r")
				.append(" where t.route.id=r.id and t.isactive=1 and r.isactive=1 and t.orgid = :orgid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		return query.getResultList();
	}

	// 获取班次循环中的车型信息
	@SuppressWarnings("unchecked")
	public List<Long> qryCycleschemesvehicle(Long scheduleid) {
		StringBuilder sql = new StringBuilder(
				"select cv.vehicletypeid from Cycleschemesvehicle cv,Cycleschemesschedule cs")
				.append(" where cs.cyclescheme=cv.cyclescheme and cs.scheduleid=:scheduleid")
				.append(" group by cv.vehicletypeid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}

	// 获取班次上车站信息
	// 获取班次停靠点信息
	@SuppressWarnings("unchecked")
	public List<Schedulestop> qryOrgSchedulestop(long scheduleid,
			boolean isdepart) {
		StringBuilder sql = new StringBuilder(
				"select t from Schedulestop t where t.schedule.id = :scheduleid")
				.append(" and t.isactive=1 and t.isdepart=:isdepart order by orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("isdepart", isdepart);
		return query.getResultList();
	}
	
	public List<Schedulestop> qryAllSchedulestop(long scheduleid) {
		StringBuilder sql = new StringBuilder(
				"select t from Schedulestop t where t.schedule.id = :scheduleid")
				.append(" and t.isactive=1  order by orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}

	// 获取线路停靠点的里程
	public long qryOrgStopDistance(long routeid, long stationid) {
		StringBuilder sql = new StringBuilder(
				"select r from Routestop r where r.route.id = :routeid")
				.append(" and r.isactive=1 and r.stationid=:stationid ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("routeid", routeid);
		query.setParameter("stationid", stationid);
		Routestop routestop = (Routestop) query.getSingleResult();
		return routestop != null? routestop.getDistance():0;
	}

	// 获取票价公式
	@SuppressWarnings("unchecked")
	public Ticketpriceformula qryFormula(Long orgid, String ticketype,
			Date departdate) {
		StringBuilder sql = new StringBuilder(
				"select tp from Tickettype t,Ticketpriceformula tp")
				.append(" where t.id=tp.tickettypeid")
				.append(" and t.code=:code and tp.startdate<=:startdate")
				.append(" and tp.enddate >= :enddate  and tp.isactive=1")
				.append(" and tp.orgid = :orgid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("code", ticketype);
		query.setParameter("startdate", departdate);
		query.setParameter("enddate", departdate);
		List<Object> objlist = query.getResultList();
		return objlist != null && objlist.size() > 0 ? (Ticketpriceformula) objlist
				.get(0) : null;
	}

	@SuppressWarnings("unchecked")
	public Ticketpriceformulaitem qryformulaitem(Long orgid, char code) {
		StringBuilder sql = new StringBuilder(
				"select t from Ticketpriceformulaitem t").append(
				" where t.code=:code and t.isactive=1").append(
				" and t.orgid = :orgid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("code", String.valueOf(code));
		List<Ticketpriceformulaitem> list=query.getResultList();
		return list!=null&&list.size()>0?list.get(0):null;
	}

	// 0 取车型相关的值
	public BigDecimal qryAboutVehicletypeValue(
			Ticketpriceformulaitem ticketpriceformulaitem, Long vehicletypeid) {
		StringBuilder sql = new StringBuilder(
				"select t from Formulaitemvehcile t").append(
				" where t.vehciletypeid=:vehicletypeid ").append(
				" and t.ticketpriceformulaitem = :ticketpriceformulaitem");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		query.setParameter("vehicletypeid", vehicletypeid);
		List list = query.getResultList();
		if (list != null && list.size() > 0) {
			Formulaitemvehcile formulaitemvehcile = (Formulaitemvehcile) list
					.get(0);
			return formulaitemvehcile.getValue();
		}
		return new BigDecimal(0);
	}

	// 1 获取线路路段等级相关对应的值
	@SuppressWarnings("unchecked")
	public BigDecimal qryAboutRoadgradeValue(
			Ticketpriceformulaitem ticketpriceformulaitem, Long routeid,
			Long departstationid, Long reachstationid) {
		StringBuilder sql = new StringBuilder();
		Query query = null;
		long distance = getFromtoEndDistance(routeid, departstationid,
				reachstationid);
		sql = new StringBuilder(
				"select r from Routeroad r where  r.route.id=:routeid order by r.orderno");
		query = getEntityManager().createQuery(sql.toString());
		query.setParameter("routeid", routeid);
		List<Routeroad> routeroadlist = query.getResultList();
		long roaddistance = 0;
		Routeroad curouteroad = null;
		for (Routeroad routeroad : routeroadlist) {
			roaddistance = roaddistance + routeroad.getDistance();
			if (roaddistance >= distance) {
				curouteroad = routeroad;
				break;
			}
		}
		sql = new StringBuilder(
				"select r from Routeroad r where  r.route.id=:routeid and orderno<=:orderno order by r.orderno");
		query = getEntityManager().createQuery(sql.toString());
		query.setParameter("routeid", routeid);
		query.setParameter("orderno", curouteroad.getOrderno());
		routeroadlist = query.getResultList();
		BigDecimal roadprice = new BigDecimal(0);
		long curroaddistance = 0;
		for (Routeroad routeroad : routeroadlist) {
			curroaddistance = curroaddistance + routeroad.getDistance();
			if (distance > curroaddistance) {
				roadprice = new BigDecimal(routeroad.getDistance())
						.multiply(qryRoadValue(ticketpriceformulaitem,
								routeroad.getRoadgrade()));
			} else {
				BigDecimal nextroadprice = qryRoadValue(ticketpriceformulaitem,
						routeroad.getRoadgrade());
				long curdistance = (distance - curroaddistance + routeroad
						.getDistance());
				roadprice = roadprice.add(nextroadprice
						.multiply(new BigDecimal(curdistance)));
			}
		}
		return roadprice;
	}

	private BigDecimal qryRoadValue(
			Ticketpriceformulaitem ticketpriceformulaitem, String roadgrade) {
		StringBuilder sql = new StringBuilder(
				"select t from Formulaitemroadgrade t").append(
				" where t.roadgrade=:roadgrade ").append(
				" and t.ticketpriceformulaitem = :ticketpriceformulaitem");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		query.setParameter("roadgrade", roadgrade);
		List list = query.getResultList();
		if (list != null && list.size() > 0) {
			Formulaitemroadgrade formulaitemroadgrade = (Formulaitemroadgrade) list
					.get(0);
			return formulaitemroadgrade.getValue();
		}
		return new BigDecimal(0);
	}

	// 2 获取车型公路等级对应的值
	@SuppressWarnings("unchecked")
	public BigDecimal qryVehicletypeRoadValue(
			Ticketpriceformulaitem ticketpriceformulaitem, Long vehicletypeid,
			Long routeid, Long departstationid, Long reachstationid) throws ServiceException{
		StringBuilder sql = new StringBuilder();
		Query query = null;
		long distance = getFromtoEndDistance(routeid, departstationid,
				reachstationid);
		sql = new StringBuilder(
				"select r from Routeroad r where  r.route.id=:routeid order by r.orderno");
		query = getEntityManager().createQuery(sql.toString());
		query.setParameter("routeid", routeid);
		List<Routeroad> routeroadlist = query.getResultList();
		long roaddistance = 0;
		Routeroad curouteroad = null;
		for (Routeroad routeroad : routeroadlist) {
			roaddistance = roaddistance + routeroad.getDistance();
			if (roaddistance >= distance) {
				curouteroad = routeroad;
				break;
			}
		}
		if(curouteroad==null){
			//改线路路段信息还未添加！
			throw new ServiceException("0289");			
		}
		sql = new StringBuilder(
				"select r from Routeroad r where  r.route.id=:routeid and orderno<=:orderno order by r.orderno");
		query = getEntityManager().createQuery(sql.toString());
		query.setParameter("routeid", routeid);
		query.setParameter("orderno", curouteroad.getOrderno());
		routeroadlist = query.getResultList();
		BigDecimal roadprice = new BigDecimal(0);
		long curroaddistance = 0;
		for (Routeroad routeroad : routeroadlist) {
			curroaddistance = curroaddistance + routeroad.getDistance();
			if (distance > curroaddistance) {
				roadprice = new BigDecimal(routeroad.getDistance())
						.multiply(qryRoadValue(ticketpriceformulaitem,
								routeroad.getRoadgrade()));
			} else {
				BigDecimal nextroadprice = qryVehicletypeRoadValue(
						ticketpriceformulaitem, vehicletypeid,
						routeroad.getRoadgrade());
				long curdistance = (distance - curroaddistance + routeroad
						.getDistance());
				roadprice = roadprice.add(nextroadprice
						.multiply(new BigDecimal(curdistance)));
			}
		}
		if (distance>0){
			return roadprice.divide((new BigDecimal(distance)),3,BigDecimal.ROUND_DOWN);	
		}
		else
		{
			return new BigDecimal(0);
		}
	}

	// 返回线路起点站到到站达站的公里数
	@SuppressWarnings("unchecked")
	private long getFromtoEndDistance(long routeid, long departstationid,
			long reachstationid) {
		Route route=(Route) this.get(Route.class,routeid);
		List<Routestop> rslist=route.getRoutestops();
		int startdistance=0;
		int enddistance=0;
		for(Routestop rs:rslist){
			if(rs.getStationid()==departstationid){
				startdistance=rs.getDistance();
			}
			if(rs.getStationid()==reachstationid){
				enddistance=rs.getDistance();
			}
		}
		return (enddistance-startdistance)>0?(enddistance-startdistance):0;
	}

	private BigDecimal qryVehicletypeRoadValue(
			Ticketpriceformulaitem ticketpriceformulaitem, Long vehicletypeid,
			String roadgrade) {
		StringBuilder sql = new StringBuilder(
				"select t from Formulaitemvehcileroadgrad t where ")
				.append(" t.roadgrade=:roadgrade and t.vehciletypeid=:vehciletypeid")
				.append(" and t.ticketpriceformulaitem = :ticketpriceformulaitem");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		query.setParameter("roadgrade", roadgrade);
		query.setParameter("vehciletypeid", vehicletypeid);
		List list = query.getResultList();
		if (list != null && list.size() > 0) {
			Formulaitemvehcileroadgrad formulaitemvehcileroadgrad = (Formulaitemvehcileroadgrad) list
					.get(0);
			return formulaitemvehcileroadgrad.getValue();
		}
		return new BigDecimal(0);
	}

	// 3获取客运等级相关的值
	@SuppressWarnings("unchecked")
	public BigDecimal qryStationgradeValue(
			Ticketpriceformulaitem ticketpriceformulaitem, Long orgid) {
		Query query = null;
		String stationgrade = "";
		StringBuilder sql = new StringBuilder(
				"select s from Station s,Organization o ")
				.append(" where (o.type='1' or o.type='2')  ")
				.append(" and o.station.id=s.id and o.id=:orgid  ");
		query = getEntityManager().createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		List<Station> stationlist = query.getResultList();
		if (stationlist != null && stationlist.size() > 0) {
			Station station = (Station) stationlist.get(0);
			stationgrade = station.getGrade();
		}
		sql = new StringBuilder("select s from Formulaitemorggrade s ").append(
				" where s.ticketpriceformulaitem=:ticketpriceformulaitem")
				.append(" and s.stationgrade=:stationgrade  ");
		query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		query.setParameter("stationgrade", stationgrade);
		List<Formulaitemorggrade> list = query.getResultList();
		if (list != null && list.size() > 0) {
			Formulaitemorggrade formulaitemorggrade = (Formulaitemorggrade) list
					.get(0);
			return formulaitemorggrade.getValue();
		}
		return new BigDecimal(0);
	}

	// 4获取 班次相关的值
	@SuppressWarnings("unchecked")
	public BigDecimal qryAboutScheduleValue(
			Ticketpriceformulaitem ticketpriceformulaitem, Long scheduleid) {
		Query query = null;
		StringBuilder sql = new StringBuilder(
				"select s from Formulaitemschedule s ").append(
				" where s.ticketpriceformulaitem=:ticketpriceformulaitem")
				.append(" and s.scheduleid=:scheduleid  ");
		query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		query.setParameter("scheduleid", scheduleid);
		List<Formulaitemschedule> list = query.getResultList();
		if (list != null && list.size() > 0) {
			Formulaitemschedule formulaitemschedule = (Formulaitemschedule) list
					.get(0);
			return formulaitemschedule.getValue();
		}
		return new BigDecimal(0);
	}

	// 5获取线路相关的值
	@SuppressWarnings("unchecked")
	public BigDecimal qryAboutRouteValue(
			Ticketpriceformulaitem ticketpriceformulaitem, Long routeid) {
		Query query = null;
		StringBuilder sql = new StringBuilder(
				"select s from Formulaitemroute s ").append(
				" where s.ticketpriceformulaitem=:ticketpriceformulaitem")
				.append(" and s.routeid=:routeid  ");
		query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		query.setParameter("routeid", routeid);
		List<Formulaitemroute> list = query.getResultList();
		if (list != null && list.size() > 0) {
			Formulaitemroute formulaitemroute = (Formulaitemroute) list.get(0);
			return formulaitemroute.getValue();
		}
		return new BigDecimal(0);
	}

	// 6获取线路停靠点相关的值
	@SuppressWarnings("unchecked")
	public BigDecimal qryAboutRoutestopValue(
			Ticketpriceformulaitem ticketpriceformulaitem, Long routeid,
			Long stationid) {
		Query query = null;
		StringBuilder sql = new StringBuilder(
				"select SUM(s.value) as value from Formulaitemroutestop s ")
				.append(" where s.ticketpriceformulaitem=:ticketpriceformulaitem")
				.append(" and s.routeid=:routeid   and s.stationid=:stationid");
		query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		query.setParameter("routeid", routeid);
		query.setParameter("stationid", stationid);
		List<Object> list = query.getResultList();
		if (list != null && list.size() > 0 && list.get(0) != null) {
			return (BigDecimal) list.get(0);
		}
		return new BigDecimal(0);
	}

	// 7获票价区间相关的值
	@SuppressWarnings("unchecked")
	public List<Formulaitemprice> qryAboutPriceValue(
			Ticketpriceformulaitem ticketpriceformulaitem) {
		StringBuilder sql = new StringBuilder(
				"select s from Formulaitemprice s ")
				.append(" where s.ticketpriceformulaitem=:ticketpriceformulaitem");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		return query.getResultList();
	}

	// 8获公里区间相关的值
	@SuppressWarnings("unchecked")
	public BigDecimal qryAboutDistanceValue(
			Ticketpriceformulaitem ticketpriceformulaitem, Long routeid,
			Long departstationid, Long reachstationid) throws ServiceException {
		Query query = null;
		long distance = getFromtoEndDistance(routeid, departstationid,
				reachstationid);
		StringBuilder sql = new StringBuilder(
				"select s from Formulaitemdistance s ")
				.append(" where s.ticketpriceformulaitem=:ticketpriceformulaitem")
				.append(" and s.fromdistance<=:fromdistance and s.enddistance>=:enddistance");
		query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		query.setParameter("fromdistance", distance);
		query.setParameter("enddistance", distance);
		List<Formulaitemdistance> list = query.getResultList();
		if (list != null && list.size() > 0) {
			Formulaitemdistance formulaitemdistance = (Formulaitemdistance) list
					.get(0);
			return formulaitemdistance.getValue();
		} else {
			throw new ServiceException(String.valueOf(distance), "0048");
		}
	}

	// 9获固定值相关的值
	@SuppressWarnings("unchecked")
	public BigDecimal qryAboutFixValue(
			Ticketpriceformulaitem ticketpriceformulaitem) {
		StringBuilder sql = new StringBuilder(
				"select s from Formulaitemfixedvalue s ")
				.append(" where s.ticketpriceformulaitem=:ticketpriceformulaitem");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		List<Formulaitemfixedvalue> list = query.getResultList();
		if (list != null && list.size() > 0) {
			Formulaitemfixedvalue formulaitemfixedvalue = (Formulaitemfixedvalue) list
					.get(0);
			return formulaitemfixedvalue.getValue();
		}
		return new BigDecimal(0);
	}

	// 10获表达式相关的值
	@SuppressWarnings("unchecked")
	public String qryAboutFormulaitemformula(
			Ticketpriceformulaitem ticketpriceformulaitem) {
		StringBuilder sql = new StringBuilder(
				"select s from Formulaitemformula s ")
				.append(" where s.ticketpriceformulaitem=:ticketpriceformulaitem");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		List<Formulaitemformula> list = query.getResultList();
		if (list != null && list.size() > 0) {
			Formulaitemformula formulaitemformula = (Formulaitemformula) list
					.get(0);
			return formulaitemformula.getItemformula();
		}
		return "";
	}

	// 删除已经存在的标准票价

	@SuppressWarnings("unchecked")
	public int delStandardprice(Long scheduleid, Long vehicletypeid,
			Long departstationid, Long reachstationid) {
		int record = 0;
		StringBuilder sql = new StringBuilder("select s from Standardprice s ")
				.append(" where s.scheduleid=:scheduleid and s.vehicletypeid=:vehicletypeid")
				.append(" and s.departstationid=:departstationid and s.reachstationid=:reachstationid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("vehicletypeid", vehicletypeid);
		query.setParameter("departstationid", departstationid);
		query.setParameter("reachstationid", reachstationid);
		List<Standardprice> standardpricelist = query.getResultList();
		for (Standardprice standardprice : standardpricelist) {
			getEntityManager().remove(standardprice);
			record++;
		}
		getEntityManager().flush();
		return record;
	}

	@SuppressWarnings("unchecked")
	public Ticketpriceformula getformula(long orgid, Date departDate,
			String code) {
		StringBuilder sql = new StringBuilder(
				"select t from Ticketpriceformula t,Tickettype tt")
				.append(" where t.orgid=:orgid and t.isactive=1 and tt.isactive=1 ")
				.append(" and t.tickettypeid=tt.id and tt.code=:code")
				.append(" and t.startdate<=:departDate and t.enddate>=:departDate");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("departDate", departDate);
		query.setParameter("code", code);
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? (Ticketpriceformula) list
				.get(0) : null;
	}
	
	@SuppressWarnings("unchecked")
	public Ticketdiscount qryTicketdiscount(BigDecimal fullprice,Date departdate, String tickettype, Schedule schedule) {
		StringBuilder sql = new StringBuilder("select t ")
				.append(" from Ticketdiscount t where t.startdate<=:departdate")
				.append(" and t.enddate>=:departdate and t.datatype=2")
				.append(" and t.tickettype=:tickettype and t.dataid=:dataid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("tickettype", tickettype);
		query.setParameter("dataid", schedule.getId());
		List<Ticketdiscount> list = query.getResultList();
		if (list != null && list.size() > 0) {
			return list.get(0);
		}
		sql = new StringBuilder("select t ")
				.append(" from Ticketdiscount t where t.startdate<=:departdate")
				.append(" and t.enddate>=:departdate and t.datatype=1")
				.append(" and t.tickettype=:tickettype and t.dataid=:dataid");
		query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("tickettype", tickettype);
		query.setParameter("dataid", schedule.getRoute().getId());
		list = query.getResultList();
		if (list != null && list.size() > 0) {
			return list.get(0);
		}
		sql = new StringBuilder("select t ")
				.append(" from Ticketdiscount t where t.startdate<=:departdate")
				.append(" and t.enddate>=:departdate and t.datatype=0")
				.append(" and t.tickettype=:tickettype and t.dataid=:dataid");
		query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("tickettype", tickettype);
		query.setParameter("dataid", schedule.getOrgid());
		list = query.getResultList();
		if (list != null && list.size() > 0) {
			return list.get(0);
		}
		return null;
	}
}
