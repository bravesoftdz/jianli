package cn.nova.bus.price.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.price.model.Formulaitemdistance;
import cn.nova.bus.price.model.Formulaitemorggrade;
import cn.nova.bus.price.model.Formulaitemprice;
import cn.nova.bus.price.model.Formulaitemroadgrade;
import cn.nova.bus.price.model.Formulaitemroute;
import cn.nova.bus.price.model.Formulaitemroutestop;
import cn.nova.bus.price.model.Formulaitemschedule;
import cn.nova.bus.price.model.Formulaitemvehcile;
import cn.nova.bus.price.model.Formulaitemvehcileroadgrad;
import cn.nova.bus.price.model.Ticketpriceformulaitem;

@SuppressWarnings("rawtypes")
public class FormulaitemAboutDao extends EntityManagerDaoSurport {
	@SuppressWarnings("unchecked")
	public List<Object> queryFormulaitemvehcile(
			Ticketpriceformulaitem ticketpriceformulaitem) {
		StringBuilder sql = new StringBuilder("select t,v.name as vehiclename ")
				.append(" from Formulaitemvehcile t,Vehicletype v")
				.append(" where t.vehciletypeid=v.id and t.ticketpriceformulaitem=:ticketpriceformulaitem");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryFormulaitemroute(
			Ticketpriceformulaitem ticketpriceformulaitem) {
		StringBuilder sql = new StringBuilder("select t,r.name as routename")
				.append(" from Formulaitemroute t,Route r")
				.append(" where t.routeid=r.id and t.ticketpriceformulaitem=:ticketpriceformulaitem");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryFormulaitemroutestop(
			Ticketpriceformulaitem ticketpriceformulaitem) {
		StringBuilder sql = new StringBuilder(
				"select t,r.name as routename,s.name as stationname")
				.append(" from Formulaitemroutestop t,Route r,Station s")
				.append(" where t.routeid=r.id and t.stationid=s.id and t.ticketpriceformulaitem=:ticketpriceformulaitem");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryFormulaitemdistance(
			Ticketpriceformulaitem ticketpriceformulaitem) {
		StringBuilder sql = new StringBuilder("select t").append(
				" from Formulaitemdistance t").append(
				" where t.ticketpriceformulaitem=:ticketpriceformulaitem");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryFormulaitemfixed(
			Ticketpriceformulaitem ticketpriceformulaitem) {
		StringBuilder sql = new StringBuilder("select t").append(
				" from Formulaitemfixedvalue t").append(
				" where t.ticketpriceformulaitem=:ticketpriceformulaitem");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public List<Object> queryFormulaitemformula(
			Ticketpriceformulaitem ticketpriceformulaitem) {
		StringBuilder sql = new StringBuilder("select t").append(
				" from Formulaitemformula t").append(
				" where t.ticketpriceformulaitem=:ticketpriceformulaitem");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public List<Object> queryFormulaitemPrice(
			Ticketpriceformulaitem ticketpriceformulaitem) {
		StringBuilder sql = new StringBuilder("select t").append(
				" from Formulaitemprice t").append(
				" where t.ticketpriceformulaitem=:ticketpriceformulaitem");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryFormulaitemStationgrade(
			Ticketpriceformulaitem ticketpriceformulaitem) {
		StringBuilder sql = new StringBuilder(
				"select t,de.value as stationgradename")
				.append(" from Formulaitemorggrade t,Digitaldictionary d,Digitaldictionarydetail de")
				.append(" where t.ticketpriceformulaitem=:ticketpriceformulaitem")
				.append(" and d.id=de.digitaldictionary.id and t.stationgrade=de.code")
				.append(" and d.tablename='station' and d.columnname='level' ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryFormulaitemRoadgrade(
			Ticketpriceformulaitem ticketpriceformulaitem) {
		StringBuilder sql = new StringBuilder(
				"select t,de.value as roadgradename")
				.append(" from Formulaitemroadgrade t,Digitaldictionary d,Digitaldictionarydetail de")
				.append(" where t.ticketpriceformulaitem=:ticketpriceformulaitem")
				.append(" and d.id=de.digitaldictionary.id and t.roadgrade=de.code")
				.append(" and d.tablename='routeroad' and d.columnname='roadgrade' ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryFormulaitemSchedule(
			Ticketpriceformulaitem ticketpriceformulaitem) {
		StringBuilder sql = new StringBuilder("select t,r.name as routename,s.code,s.starttime ")
				.append(" from Formulaitemschedule t,Schedule s,Route r")
				.append(" where t.scheduleid=s.id and s.route.id=r.id and ")
				.append(" t.ticketpriceformulaitem=:ticketpriceformulaitem");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public List<Object> queryFormulaitemVehRoadgrade(
			Ticketpriceformulaitem ticketpriceformulaitem) {
		StringBuilder sql = new StringBuilder(
				"select t,de.value as roadgradename,v.name as vehiclename")
				.append(" from Formulaitemvehcileroadgrad t,Digitaldictionary d,Digitaldictionarydetail de,")
				.append(" Vehicletype v ")
				.append(" where t.ticketpriceformulaitem=:ticketpriceformulaitem")
				.append(" and t.vehciletypeid=v.id ")
				.append(" and d.id=de.digitaldictionary.id and t.roadgrade=de.code")
				.append(" and d.tablename='routeroad' and d.columnname='roadgrade' ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		return query.getResultList();
	} 
	
	@SuppressWarnings("unchecked")
	public List<Object> queryFormulaitemScheduleUnit(
			Ticketpriceformulaitem ticketpriceformulaitem) {
		StringBuilder sql = new StringBuilder(
				"select t,u.name as unitname,r.name as routename,s.code,s.starttime")
				.append(" from Formulaitemscheduleunit t,Unit u,Schedule s,Route r")
				.append(" where t.ticketpriceformulaitem=:ticketpriceformulaitem")
				.append(" and t.scheduleid=s.id ")
				.append(" and t.unitid=u.id and s.route.id=r.id ")
				.append(" order by u.name,s.starttime ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		return query.getResultList();
	}	
	
	@SuppressWarnings("unchecked")
	public boolean isExistformulaitemvehcile(
			Formulaitemvehcile formulaitemvehcile) {
		if (formulaitemvehcile.getId() == 0) {
			StringBuilder sql = new StringBuilder(
					"select s from Formulaitemvehcile s ").append(
					" where s.ticketpriceformulaitem=:ticketpriceformulaitem")
					.append(" and s.vehciletypeid=:vehciletypeid");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("ticketpriceformulaitem",
					formulaitemvehcile.getTicketpriceformulaitem());
			query.setParameter("vehciletypeid", formulaitemvehcile.getVehciletypeid());
			List<Object> objlist = query.getResultList();
			return objlist != null && objlist.size() > 0 ? true : false;
		} else {
			StringBuilder sql = new StringBuilder(
					"select s from Formulaitemvehcile s ")
					.append(" where  s.id!=:id and s.ticketpriceformulaitem=:ticketpriceformulaitem")
					.append(" and s.vehciletypeid=:vehciletypeid");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("id", formulaitemvehcile.getId());
			query.setParameter("ticketpriceformulaitem",
					formulaitemvehcile.getTicketpriceformulaitem());
			query.setParameter("vehciletypeid", formulaitemvehcile.getVehciletypeid());
			List<Object> objlist = query.getResultList();
			return objlist != null && objlist.size() > 0 ? true : false;
		}
	}

	@SuppressWarnings("unchecked")
	public Formulaitemroute queryFormulaitemroute(
			Ticketpriceformulaitem ticketpriceformulaitem, Long routeid) {
		StringBuilder sql = new StringBuilder(
				"select t from Formulaitemroute t").append(
				" where t.ticketpriceformulaitem=:ticketpriceformulaitem")
				.append(" and t.routeid=:routeid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceformulaitem", ticketpriceformulaitem);
		query.setParameter("routeid", routeid);
		List<Object> objlist = query.getResultList();
		return objlist != null && objlist.size() > 0 ? (Formulaitemroute) objlist
				.get(0) : null;
	}

	@SuppressWarnings("unchecked")
	public boolean isExistformulaitemroute(Formulaitemroute formulaitemroute) {
		if (formulaitemroute.getId() == 0) {
			StringBuilder sql = new StringBuilder(
					"select s from Formulaitemroute s ").append(
					" where s.ticketpriceformulaitem=:ticketpriceformulaitem")
					.append(" and s.routeid=:routeid");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("ticketpriceformulaitem",
					formulaitemroute.getTicketpriceformulaitem());
			query.setParameter("routeid", formulaitemroute.getRouteid());
			List<Object> objlist = query.getResultList();
			return objlist != null && objlist.size() > 0 ? true : false;
		} else {
			StringBuilder sql = new StringBuilder(
					"select s from Formulaitemroute s ")
					.append(" where  s.id!=:id and s.ticketpriceformulaitem=:ticketpriceformulaitem")
					.append(" and s.routeid=:routeid");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("id", formulaitemroute.getId());
			query.setParameter("ticketpriceformulaitem",
					formulaitemroute.getTicketpriceformulaitem());
			query.setParameter("routeid", formulaitemroute.getRouteid());
			List<Object> objlist = query.getResultList();
			return objlist != null && objlist.size() > 0 ? true : false;
		}
	}

	@SuppressWarnings("unchecked")
	public boolean isExistformulaitemRouteStop(
			Formulaitemroutestop formulaitemroutestop) {
		if (formulaitemroutestop.getId() == 0) {
			StringBuilder sql = new StringBuilder(
					"select s from Formulaitemroutestop s ")
					.append(" where s.ticketpriceformulaitem=:ticketpriceformulaitem")
					.append(" and s.routeid=:routeid and s.stationid=:stationid");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("ticketpriceformulaitem",
					formulaitemroutestop.getTicketpriceformulaitem());
			query.setParameter("routeid", formulaitemroutestop.getRouteid());
			query.setParameter("stationid", formulaitemroutestop.getStationid());
			List<Object> objlist = query.getResultList();
			return objlist != null && objlist.size() > 0 ? true : false;
		} else {
			StringBuilder sql = new StringBuilder(
					"select s from Formulaitemroutestop s ")
					.append(" where  s.id!=:id and s.ticketpriceformulaitem=:ticketpriceformulaitem")
					.append(" and s.routeid=:routeid and s.stationid=:stationid");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("id", formulaitemroutestop.getId());
			query.setParameter("ticketpriceformulaitem",
					formulaitemroutestop.getTicketpriceformulaitem());
			query.setParameter("routeid", formulaitemroutestop.getRouteid());
			query.setParameter("stationid", formulaitemroutestop.getStationid());
			List<Object> objlist = query.getResultList();
			return objlist != null && objlist.size() > 0 ? true : false;
		}
	}

	@SuppressWarnings("unchecked")
	public boolean isExistformulaitemDistance(
			Formulaitemdistance formulaitemdistance) {
		if (formulaitemdistance.getId() == 0) {
			StringBuilder sql = new StringBuilder(
					"select s from Formulaitemdistance s ")
					.append(" where s.ticketpriceformulaitem=:ticketpriceformulaitem")
					.append(" and ((s.fromdistance>=:fromdistance and fromdistance<=:enddistance) ")
					.append(" or (s.fromdistance<=:fromdistance and s.enddistance>=:enddistance)")
					.append(" or (s.fromdistance<=:fromdistance and s.enddistance>=:fromdistance)")
					.append(" or (s.fromdistance>=:fromdistance and s.enddistance<=:enddistance))");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("ticketpriceformulaitem",
					formulaitemdistance.getTicketpriceformulaitem());
			query.setParameter("fromdistance",
					formulaitemdistance.getFromdistance());
			query.setParameter("enddistance",
					formulaitemdistance.getEnddistance());
			List<Object> objlist = query.getResultList();
			return objlist != null && objlist.size() > 0 ? true : false;
		} else {
			StringBuilder sql = new StringBuilder(
					"select s from Formulaitemdistance s ")
					.append(" where  s.id!=:id and s.ticketpriceformulaitem=:ticketpriceformulaitem")
					.append(" and ((s.fromdistance>=:fromdistance and s.fromdistance<=:enddistance) ")
					.append(" or (s.fromdistance<=:fromdistance and s.enddistance>=:enddistance)")
					.append(" or (s.fromdistance<=:fromdistance and s.enddistance>=:fromdistance)")
					.append(" or (s.fromdistance>=:fromdistance and s.enddistance<=:enddistance))");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("id", formulaitemdistance.getId());
			query.setParameter("ticketpriceformulaitem",
					formulaitemdistance.getTicketpriceformulaitem());
			query.setParameter("fromdistance",
					formulaitemdistance.getFromdistance());
			query.setParameter("enddistance",
					formulaitemdistance.getEnddistance());
			List<Object> objlist = query.getResultList();
			return objlist != null && objlist.size() > 0 ? true : false;
		}
	}

	@SuppressWarnings("unchecked")
	public boolean isExistformulaitemPrice(Formulaitemprice formulaitemprice) {
		if (formulaitemprice.getId() == 0) {
			StringBuilder sql = new StringBuilder(
					"select s from Formulaitemprice s ")
					.append(" where s.ticketpriceformulaitem=:ticketpriceformulaitem")
					.append(" and ((s.fromprice>=:fromprice and s.fromprice<=:endprice) ")
					.append(" or (s.fromprice<=:fromprice and s.endprice>=:endprice)")
					.append(" or (s.fromprice<=:fromprice and s.endprice>=:fromprice)")
					.append(" or (s.fromprice>=:fromprice and s.endprice<=:endprice))");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("ticketpriceformulaitem",
					formulaitemprice.getTicketpriceformulaitem());
			query.setParameter("fromprice", formulaitemprice.getFromprice());
			query.setParameter("endprice", formulaitemprice.getEndprice());
			List<Object> objlist = query.getResultList();
			return objlist != null && objlist.size() > 0 ? true : false;
		} else {
			StringBuilder sql = new StringBuilder(
					"select s from Formulaitemprice s ")
					.append(" where  s.id!=:id and s.ticketpriceformulaitem=:ticketpriceformulaitem")
					.append(" and ((s.fromprice>=:fromprice and s.fromprice<=:endprice) ")
					.append(" or (s.fromprice<=:fromprice and s.endprice>=:endprice)")
					.append(" or (s.fromprice<=:fromprice and s.endprice>=:fromprice)")
					.append(" or (s.fromprice>=:fromprice and s.endprice<=:endprice))");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("id", formulaitemprice.getId());
			query.setParameter("ticketpriceformulaitem",
					formulaitemprice.getTicketpriceformulaitem());
			query.setParameter("fromprice", formulaitemprice.getFromprice());
			query.setParameter("endprice", formulaitemprice.getEndprice());
			List<Object> objlist = query.getResultList();
			return objlist != null && objlist.size() > 0 ? true : false;
		}
	}

	@SuppressWarnings("unchecked")
	public boolean isExistformulaitemStationGrade(
			Formulaitemorggrade formulaitemorggrade) {
		if (formulaitemorggrade.getId() == 0) {
			StringBuilder sql = new StringBuilder(
					"select s from Formulaitemorggrade s ").append(
					" where s.ticketpriceformulaitem=:ticketpriceformulaitem")
					.append(" and s.stationgrade=:stationgrade");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("ticketpriceformulaitem",
					formulaitemorggrade.getTicketpriceformulaitem());
			query.setParameter("stationgrade",
					formulaitemorggrade.getStationgrade());
			List<Object> objlist = query.getResultList();
			return objlist != null && objlist.size() > 0 ? true : false;
		} else {
			StringBuilder sql = new StringBuilder(
					"select s from Formulaitemorggrade s ")
					.append(" where  s.id!=:id and s.ticketpriceformulaitem=:ticketpriceformulaitem")
					.append(" and s.stationgrade=:stationgrade");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("id", formulaitemorggrade.getId());
			query.setParameter("ticketpriceformulaitem",
					formulaitemorggrade.getTicketpriceformulaitem());
			query.setParameter("stationgrade",
					formulaitemorggrade.getStationgrade());
			List<Object> objlist = query.getResultList();
			return objlist != null && objlist.size() > 0 ? true : false;
		}
	}
	@SuppressWarnings("unchecked")
	public boolean isExistformulaitemRoadGrade(
			Formulaitemroadgrade formulaitemroadgrade) {
		if (formulaitemroadgrade.getId() == 0) {
			StringBuilder sql = new StringBuilder(
					"select s from Formulaitemroadgrade s ").append(
					" where s.ticketpriceformulaitem=:ticketpriceformulaitem")
					.append(" and s.roadgrade=:roadgrade");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("ticketpriceformulaitem",
					formulaitemroadgrade.getTicketpriceformulaitem());
			query.setParameter("roadgrade", formulaitemroadgrade.getRoadgrade());
			List<Object> objlist = query.getResultList();
			return objlist != null && objlist.size() > 0 ? true : false;
		} else {
			StringBuilder sql = new StringBuilder(
					"select s from Formulaitemroadgrade s ")
					.append(" where  s.id!=:id and s.ticketpriceformulaitem=:ticketpriceformulaitem")
					.append(" and s.roadgrade=:roadgrade");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("id", formulaitemroadgrade.getId());
			query.setParameter("ticketpriceformulaitem",
					formulaitemroadgrade.getTicketpriceformulaitem());
			query.setParameter("roadgrade", formulaitemroadgrade.getRoadgrade());
			List<Object> objlist = query.getResultList();
			return objlist != null && objlist.size() > 0 ? true : false;
		}
	}
	@SuppressWarnings("unchecked")
	public boolean isExistformulaitemVchRoadGrade(
			Formulaitemvehcileroadgrad formulaitemvehcileroadgrad) {
		if (formulaitemvehcileroadgrad.getId() == 0) {
			StringBuilder sql = new StringBuilder(
					"select s from Formulaitemvehcileroadgrad s ").append(
					" where s.ticketpriceformulaitem=:ticketpriceformulaitem")
					.append(" and s.roadgrade=:roadgrade and s.vehciletypeid=:vehciletypeid");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("ticketpriceformulaitem",
					formulaitemvehcileroadgrad.getTicketpriceformulaitem());
			query.setParameter("roadgrade", formulaitemvehcileroadgrad.getRoadgrade());
			query.setParameter("vehciletypeid", formulaitemvehcileroadgrad.getVehciletypeid());			
			List<Object> objlist = query.getResultList();
			return objlist != null && objlist.size() > 0 ? true : false;
		} else {
			StringBuilder sql = new StringBuilder(
					"select s from Formulaitemvehcileroadgrad s ")
					.append(" where  s.id!=:id and s.ticketpriceformulaitem=:ticketpriceformulaitem")
					.append(" and s.roadgrade=:roadgrade and s.vehciletypeid=:vehciletypeid");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("id", formulaitemvehcileroadgrad.getId());
			query.setParameter("ticketpriceformulaitem",
					formulaitemvehcileroadgrad.getTicketpriceformulaitem());
			query.setParameter("roadgrade", formulaitemvehcileroadgrad.getRoadgrade());
			query.setParameter("vehciletypeid", formulaitemvehcileroadgrad.getVehciletypeid());					
			List<Object> objlist = query.getResultList();
			return objlist != null && objlist.size() > 0 ? true : false;
		}
	}
	@SuppressWarnings("unchecked")
	public boolean isExistformulaitemSchedule(
			Formulaitemschedule formulaitemschedule) {
		if (formulaitemschedule.getId() == 0) {
			StringBuilder sql = new StringBuilder(
					"select s from Formulaitemschedule s ").append(
					" where s.ticketpriceformulaitem=:ticketpriceformulaitem")
					.append(" and s.scheduleid=:scheduleid");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("ticketpriceformulaitem",
					formulaitemschedule.getTicketpriceformulaitem());
			query.setParameter("scheduleid", formulaitemschedule.getScheduleid());
			List<Object> objlist = query.getResultList();
			return objlist != null && objlist.size() > 0 ? true : false;
		} else {
			StringBuilder sql = new StringBuilder(
					"select s from Formulaitemschedule s ")
					.append(" where  s.id!=:id and s.ticketpriceformulaitem=:ticketpriceformulaitem")
					.append(" and s.scheduleid=:scheduleid");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("id", formulaitemschedule.getId());
			query.setParameter("ticketpriceformulaitem",
					formulaitemschedule.getTicketpriceformulaitem());
			query.setParameter("scheduleid", formulaitemschedule.getScheduleid());
			List<Object> objlist = query.getResultList();
			return objlist != null && objlist.size() > 0 ? true : false;
		}
	}		
	
}
