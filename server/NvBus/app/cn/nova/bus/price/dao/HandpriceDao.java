package cn.nova.bus.price.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Cycleschemesvehicle;
import cn.nova.bus.base.model.Routestop;
import cn.nova.bus.base.model.Schedulestop;
import cn.nova.bus.base.model.Vehicleseatplandetail;
import cn.nova.bus.base.model.Vehicletype;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Handprice;
import cn.nova.bus.price.model.Standardprice;
import cn.nova.bus.price.model.Standardpriceitem;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.price.model.Ticketpriceitem;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class HandpriceDao extends EntityManagerDaoSurport {
	@SuppressWarnings("unchecked")
	public List<Object> qryScheduleVehicletype(Long scheduleid) {
		StringBuilder sql = new StringBuilder("select DISTINCT vt")
				.append(" from Cycleschemes s,Cycleschemesschedule c,Cycleschemesvehicle v,Vehicletype vt")
				.append(" where s=c.cyclescheme and c.scheduleid=:scheduleid")
				.append(" and v.cyclescheme=s and v.vehicletypeid=vt.id");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public List<Object> qryAllVehicletype() {
		StringBuilder sql = new StringBuilder("select vt")
				.append(" from Vehicletype vt")
				.append(" where vt.isactive=1 order by vt.name");
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public Cycleschemesvehicle qryScheduleBrandmode(Long scheduleid,
			Long vehicletypeid) {
		StringBuilder sql = new StringBuilder("select v")
				.append(" from Cycleschemesschedule c,Cycleschemesvehicle v")
				.append(" where v.cyclescheme=c.cyclescheme and c.scheduleid=:scheduleid")
				.append("  and v.vehicletypeid=:vehicletypeid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("vehicletypeid", vehicletypeid);
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? (Cycleschemesvehicle) list
				.get(0) : null;
	}

	@SuppressWarnings("unchecked")
	public String qryScheduleSeats(Long vehiclebrandmodelid, String seattype) {
		String seats = "";
		StringBuilder sql = new StringBuilder(
				"select v  from Vehicleseatplandetail v, Vehiclespace vs")
				.append(" where v.vehiclespaceid = vs.id and v.vehicleseatplan.vehiclebrandmodelid = :vehiclebrandmodelid")
				.append(" and vs.seattype = :seattype and vs.ispassengerseat=1 and vs.isactive=1")
				.append(" order by v.seatno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("vehiclebrandmodelid", vehiclebrandmodelid);
		query.setParameter("seattype", seattype);
		List<Vehicleseatplandetail> list = query.getResultList();
		for (Vehicleseatplandetail vehicleseatplandetail : list) {
			seats = seats + "," + vehicleseatplandetail.getSeatno();
		}
		if (seats.length() > 0) {
			seats = seats.substring(1);
		}
		if ("".equals(seats)) {
			seats = "全部";
		}
		return seats;
	}	
	// 查询界面的查询fdsafsadfasdf
	@SuppressWarnings("unchecked")
	public List<Object> qryHandprice2(Long scheduleid) {
		StringBuilder sql = new StringBuilder(
				"select hp.id,hp.scheduleid,hp.seattype,")
				.append("  case when hp.seats = '0' then '全部'")
				.append(" else hp.seats end as seats,")
				.append(" hp.fullprice,hp.halfprice,")
				.append(" hp.studentprice,")
				.append(" s1.name as departstation,s2.name as reachstation,v.name as vehicletype, ")
				.append(" hp.toplimitprice,hp.lowerlimitprice,hp.vehicletypeid,vd.brandname,vd.modelcode,")
				.append(" vd.rationseatnum,hp.moreprice,hp.departstationid,hp.reachstationid,")
				.append(" rs.distance")
				.append(" ,hp.discountprice,hp.roundprice,hp.connectprice")
				.append(" from Station s1,Station s2,Vehicletype v,Schedulestop ss,Handprice hp")
				.append(" left join Vehiclebrandmodel vd on vd.id=hp.vehiclebrandmodelid,")
				.append(" Schedulestop ss2,Schedule s,Routestop rs")
				.append(" where hp.scheduleid=:scheduleid  ")
				.append(" and hp.departstationid=s1.id  and hp.reachstationid=s2.id ")
				.append(" and hp.vehicletypeid=v.id and hp.reachstationid=ss.stationid")
				.append(" and hp.scheduleid=ss.scheduleid and ss.isactive=1 and (s.isactive = 1 or s.isactive = 0 and s.isovertime = 1 and s.updatetime >= sysdate -30)")
				.append(" and hp.scheduleid=s.id and s.routeid=rs.routeid  and hp.reachstationid=rs.stationid")						
				.append(" and hp.departstationid=ss2.stationid and ss2.scheduleid=hp.scheduleid and ss2.isactive=1");
		sql.append(" order by hp.vehicletypeid,ss2.orderno,ss.orderno");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}

	// 编辑界面的查询查询硬调票价
	@SuppressWarnings("unchecked")
	public List<Object> qryHandprice1(Handprice handprice) {
		if (handprice.getVehiclebrandmodelid() != null) {
			StringBuilder sql = new StringBuilder(
					"select hp.id,hp.scheduleid,hp.departstationid,")
					.append(" hp.reachstationid,hp.vehicletypeid,hp.vehiclebrandmodelid,")
					.append(" vb.brandname,")
					.append(" hp.seattype,hp.fullprice,hp.halfprice,")
					.append(" hp.studentprice,hp.toplimitprice,hp.lowerlimitprice,")
					.append(" hp.createby,")
					.append(" vt.name as vehicletype,s1.name as departstation,")
					.append(" s2.name as reachstation,nvl(hp.moreprice,0) as moreprice,rs.distance")
					.append(" ,hp.discountprice,hp.roundprice,hp.connectprice")
					.append(" from Handprice hp,")
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
			query.setParameter("scheduleid", handprice.getScheduleid());
			query.setParameter("vehicletypeid", handprice.getVehicletypeid());
			query.setParameter("vehiclebrandmodelid",
					handprice.getVehiclebrandmodelid());
			return query.getResultList();
		} else {
			StringBuilder sql = new StringBuilder(
					"select hp.id,hp.scheduleid,hp.departstationid,")
					.append(" hp.reachstationid,hp.vehicletypeid,hp.vehiclebrandmodelid,")
					.append(" vb.brandname,")
					.append(" hp.seattype,hp.fullprice,hp.halfprice,")
					.append(" hp.studentprice,hp.toplimitprice,hp.lowerlimitprice,")
					.append(" hp.createby,")
					.append(" vt.name as vehicletype,s1.name as departstation,")
					.append(" s2.name as reachstation,hp.moreprice,rs.distance")
					.append(" ,hp.discountprice,hp.roundprice,hp.connectprice")
					.append(" from Handprice hp")
					.append(" left join vehiclebrandmodel vb")
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
			query.setParameter("scheduleid", handprice.getScheduleid());
			query.setParameter("vehicletypeid", handprice.getVehicletypeid());
			return query.getResultList();
		}
	}	

	// 编辑界面的查询,没有硬调票价时查询公式票价
	@SuppressWarnings("unchecked")
	public List<Object> qryStandardprice(Handprice handprice) {
		
		if (handprice.getVehiclebrandmodelid() != null) {
			StringBuilder sql = new StringBuilder(
					"select 0 as id,sp.scheduleid,")
					.append(" sp.departstationid,sp.reachstationid,sp.vehicletypeid,")
					.append(" vsp.vehiclebrandmodelid,vsp.brandname,coalesce(vsp.seattype,'0') as seattype,")
					.append(" sp.fullprice,sp.halfprice,sp.studentprice,sp.toplimitprice,")
					.append(" sp.lowerlimitprice,sp.createby, ")
					.append(" vt.name as vehicletype,s1.name as departstation,")
					.append(" s2.name as reachstation,0 as moreprice,ss.distance")
					.append(" ,sp.discountprice,sp.roundprice,sp.connectprice ")
					.append("  from Standardprice sp   left join  ")
					.append("(select cy.scheduleid, vp.vehiclebrandmodelid,vb.brandname, vs.seattype")
					.append(" from vehicleseatplandetail vp,vehiclebrandmodel vb,vehiclespace vs,")
					.append(" cycleschemesschedule  cy,cycleschemesvehicle   cv")
					.append(" where vp.vehiclespaceid = vs.id and vs.ispassengerseat = 1")
					.append(" and vp.vehiclebrandmodelid = cv.vehiclebrandmodelid")
					.append(" and cy.cycleschemesid = cv.cycleschemesid")
					.append(" and cy.scheduleid=:scheduleid and vb.id=:vehiclebrandmodelid")
					.append(" and vp.vehiclebrandmodelid=vb.id  and vs.isactive=1")
					.append(" group by cy.scheduleid, vp.vehiclebrandmodelid,vb.brandname, vs.seattype) vsp")
					.append(" on  sp.scheduleid = vsp.scheduleid , ")
					.append(" vehicletype vt,station s1,station s2,Schedule s,Routestop ss")
					.append(" where sp.vehicletypeid =:vehicletypeid")
					.append(" and s.id=sp.scheduleid and s.routeid=ss.routeid and sp.reachstationid=ss.stationid")
					.append(" and sp.vehicletypeid=vt.id")
					.append(" and sp.departstationid=s1.id")
					.append(" and sp.reachstationid=s2.id")
					.append(" and sp.scheduleid =:scheduleid order by ")
					.append(" sp.vehicletypeid,vsp.vehiclebrandmodelid,")
					.append(" sp.departstationid, ss.orderno");
			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("scheduleid", handprice.getScheduleid());
			query.setParameter("vehicletypeid", handprice.getVehicletypeid());
			query.setParameter("vehiclebrandmodelid",
					handprice.getVehiclebrandmodelid());
			List<Object> list = query.getResultList();
			return list;

		} else {
			StringBuilder sql = new StringBuilder(
					"select 0 as id,sp.scheduleid,")
					.append(" sp.departstationid,sp.reachstationid,sp.vehicletypeid,")
					.append(" null as vehiclebrandmodelid,'' as brandname,'0' as seattype,")
					.append(" sp.fullprice,sp.halfprice,sp.studentprice,sp.toplimitprice,")
					.append(" sp.lowerlimitprice,sp.createby, ")
					.append(" vt.name as vehicletype,s1.name as departstation,")
					.append(" s2.name as reachstation,0 as moreprice,ss.distance")
					.append(" ,sp.discountprice,sp.roundprice,sp.connectprice ")
					.append("  from Standardprice sp , ")
					.append(" vehicletype vt,station s1,station s2,Schedule s,Routestop ss,Routestop ss2")
					.append(" where sp.vehicletypeid =:vehicletypeid")
					.append(" and s.id=sp.scheduleid and s.routeid=ss.routeid and sp.reachstationid=ss.stationid")
					.append(" and sp.vehicletypeid=vt.id")
					.append(" and sp.departstationid=s1.id and s1.id=ss2.stationid and s.routeid=ss2.routeid")
					.append(" and sp.reachstationid=s2.id")
					.append(" and sp.scheduleid =:scheduleid order by ")
					.append(" sp.vehicletypeid,")
					.append(" ss2.orderno,ss.orderno");
			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("scheduleid", handprice.getScheduleid());
			query.setParameter("vehicletypeid", handprice.getVehicletypeid());
			List<Object> list = query.getResultList();
			return list;
		}
	}

	@SuppressWarnings("unchecked")
	public List<Handprice> qryHandprice(Handprice handprice) {
		if (handprice.getVehiclebrandmodelid() != null) {
			StringBuilder sql = new StringBuilder("select h from Handprice h")
					.append(" where h.scheduleid=:scheduleid and h.vehicletypeid=:vehicletypeid ")
					.append(" and h.vehiclebrandmodel.id=:brandid");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("scheduleid", handprice.getScheduleid());
			query.setParameter("vehicletypeid", handprice.getVehicletypeid());
			query.setParameter("brandid", handprice.getVehiclebrandmodelid());
			return query.getResultList();
		} else {
			StringBuilder sql = new StringBuilder("select h from Handprice h")
					.append(" where h.scheduleid=:scheduleid and h.vehicletypeid=:vehicletypeid ");
			Query query = getEntityManager().createQuery(sql.toString());
			query.setParameter("scheduleid", handprice.getScheduleid());
			query.setParameter("vehicletypeid", handprice.getVehicletypeid());
			return query.getResultList();
		}

	}

	@SuppressWarnings("unchecked")
	public boolean isExistHandPrice(long scheduleid, long vehicletypeid) {
		StringBuilder sql = new StringBuilder(
				"select s from Handprice s where s.scheduleid=:scheduleid ")
				.append(" and s.vehicletypeid=:vehicletypeid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("vehicletypeid", vehicletypeid);
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? true : false;
	}

	@SuppressWarnings("unchecked")
	public List<Standardprice> qryStandardPrice(long scheduleid,
			long vehicletypeid) {
		StringBuilder sql = new StringBuilder(
				"select s from Standardprice s,Schedulestop st where s.scheduleid=:scheduleid")
				.append(" and s.vehicletypeid=:vehicletypeid and st.isactive=1")
				.append(" and st.stationid=s.reachstationid and st.schedule.id=:scheduleid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("vehicletypeid", vehicletypeid);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Standardpriceitem> qryStandardPriceitem(long scheduleid,
			long vehicletypeid, String tickettype, long departstationid,
			long reachstationid) {
		StringBuilder sql = new StringBuilder(
				"select sp from Standardprice s,Schedulestop st,Standardpriceitem sp")
				.append(" where s.scheduleid=:scheduleid and s=sp.standardprice")
				.append(" and s.vehicletypeid=:vehicletypeid and st.isactive=1")
				.append(" and st.stationid=s.reachstationid and st.schedule.id=:scheduleid")
				.append(" and sp.tickettype=:tickettype and s.departstationid=:departstationid")
				.append(" and s.reachstationid=:reachstationid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("vehicletypeid", vehicletypeid);
		query.setParameter("tickettype", tickettype);
		query.setParameter("departstationid", departstationid);
		query.setParameter("reachstationid", reachstationid);
		return query.getResultList();
	}

	// 查询公式票价中的车型
	@SuppressWarnings("unchecked")
	public List<Vehicletype> qryStandardPriceVehicletype(long scheduleid) {
		StringBuilder sql = new StringBuilder(
				"select v from Standardprice s,Vehicletype v where s.scheduleid=:scheduleid ")
				.append(" and s.vehicletypeid=v.id");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}

	// 查询该班次循环
	@SuppressWarnings("unchecked")
	public List<Vehicletype> qryCycleschemesVehicletype(long scheduleid) {
		StringBuilder sql = new StringBuilder("select distinct ty")
				.append(" from Cycleschemesschedule c,Cycleschemesvehicle v,Vehicletype ty")
				.append(" where v.cyclescheme=c.cyclescheme and c.scheduleid=:scheduleid")
				.append(" and ty.id=v.vehicletypeid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}

	// 获取班次上车站信息
	// 获取班次停靠点信息
	@SuppressWarnings("unchecked")
	public List<Object> qryOrgSchedulestop(long scheduleid, boolean isdepart) {
		StringBuilder sql = new StringBuilder(
				"select t.stationid,s.name as stationname from Schedulestop t,Station s")
				.append(" where t.schedule.id = :scheduleid")
				.append(" and t.isactive=1 and t.isdepart=:isdepart and t.stationid=s.id order by orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("isdepart", isdepart);
		return query.getResultList();
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

	// 获取班次上车站信息
	// 获取班次停靠点信息
	@SuppressWarnings("unchecked")
	public List<Object> qryOrgAllSchedulestop(long scheduleid) {
		StringBuilder sql = new StringBuilder(
				"select t.stationid,s.name as stationname from Schedulestop t,Station s")
				.append(" where t.schedule.id = :scheduleid")
				.append(" and t.isactive=1 and t.stationid=s.id order by orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}

	// 获取班次停靠点信息
	@SuppressWarnings("unchecked")
	public List<Schedulestop> qryAllSchedulestop(long scheduleid) {
		StringBuilder sql = new StringBuilder(
				"select t from Schedulestop t,Station s")
				.append(" where t.schedule.id = :scheduleid")
				.append(" and t.isactive=1 and t.stationid=s.id order by orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}
	
	public boolean delHandPrice(List<PropertyFilter> propertyFilterList)
			throws ServiceException {// 删除硬调票价
		StringBuilder sql = new StringBuilder(
				"delete Handprice ha where ha.id in ");
		sql.append(
				"(select h.id from Handprice h,Schedule s,Route r,Organization o where ")
				.append(" h.scheduleid=s.id and s.route.id=r.id and r.orgid=o.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true)).append(")");
		Query query = super.getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		query.executeUpdate();
		return true;
	}

	public boolean delHandPriceitem(List<PropertyFilter> propertyFilterList)
			throws ServiceException {// 删除硬调票价子表
		StringBuilder sql = new StringBuilder(
				"delete Handpriceitem ha where ha.handprice.id in ");
		sql.append(
				"(select h.id from Handprice h,Schedule s,Route r,Organization o where ")
				.append(" h.scheduleid=s.id and s.route.id=r.id and r.orgid=o.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true)).append(")");
		Query query = super.getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		query.executeUpdate();
		return true;
	}

	@SuppressWarnings("unchecked")
	public List<Routestop> qryRoutestop(long routeid) {
		StringBuilder sql = new StringBuilder("select r from Routestop r")
				.append(" where r.route.id = :routeid").append(
						" and t.isactive=1");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("routeid", routeid);
		return query.getResultList();
	}

	// 获取班次停靠点信息
	@SuppressWarnings("unchecked")
	public List<Schedulestop> qrySchedulestop(long scheduleid) {
		StringBuilder sql = new StringBuilder("select t from Schedulestop t")
				.append(" where t.schedule.id = :scheduleid").append(
						" and t.isactive=1 ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}

	// 查询同线路的所有班次
	@SuppressWarnings("unchecked")
	public List<Object> qrySchedules(long routeid, long scheduleid) {
		StringBuilder sql = new StringBuilder(
				"select 1 as isselect,s.id,s.code ,s.starttime ")
				.append(" from Schedule s")
				.append(" where s.route.id=:routeid and  (s.isactive = 1 or s.isactive = 0 and s.isovertime = 1 and s.updatetime >= sysdate -30) ")
				.append(" and s.id!=:scheduleid and s.isdelete=0 order by s.starttime");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("routeid", routeid);
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}

	// 删除硬调
	public int delHandprice(long scheduleid, String vehicletypeids,
			String stationids) {
		StringBuilder sql = new StringBuilder(
				"delete from Handprice s where s.scheduleid=:scheduleid ")
				.append(" and s.vehicletypeid in " + vehicletypeids).append(
						" and s.reachstationid in " + stationids);
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.executeUpdate();
	}

	// 查询硬调票价
	@SuppressWarnings("unchecked")
	public List<Handprice> qryHandprice(long scheduleid, String vehicletypeids,
			String stationids) {
		StringBuilder sql = new StringBuilder(
				"select s from Handprice s where s.scheduleid=:scheduleid ")
				.append(" and s.vehicletypeid in " + vehicletypeids).append(
						" and s.reachstationid in " + stationids);
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}

	// 查询车型
	@SuppressWarnings("unchecked")
	public List<Object> qrySchedulevehicletype(long scheduleid) {
		StringBuilder sql = new StringBuilder(
				"select distinct 1 as isselect,vt.id,vt.name,vt.rationseatnum from Handprice s,Vehicletype vt ")
				.append(" where s.scheduleid=:scheduleid and s.vehicletypeid=vt.id ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}

	// 查询停靠站点
	@SuppressWarnings("unchecked")
	public List<Object> qrySchedulestation(long scheduleid) {
		StringBuilder sql = new StringBuilder(
				"select distinct 1 as isselect,s.id,s.name,s.helpcode from Handprice h,Station s ")
				.append(" where h.scheduleid=:scheduleid and h.reachstationid=s.id ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}

	// 查询硬调票价分项信息
	@SuppressWarnings("unchecked")
	public List<Object> qryHandpriceitemitem(long handpriceid, String tickettype) {
		StringBuilder sql = new StringBuilder(
				"select tp.code,tp.name,t.price,t.id,t.tickettype,t.isautoadjust,t.handpriceid,t.ticketpriceformulaitemid from")
				.append(" Handpriceitem t,Ticketpriceformulaitem tp where ")
				.append(" t.ticketpriceformulaitemid=tp.id and t.handpriceid=:handpriceid")
				.append(" and t.tickettype=:tickettype");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("handpriceid", handpriceid);
		query.setParameter("tickettype", tickettype);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Handprice> qryHandprice(long scheduleid, long vehicletypeid) {
		StringBuilder sql = new StringBuilder("select t from")
				.append(" Handprice t where ")
				.append(" t.scheduleid=:scheduleid")
				.append(" and t.vehicletypeid!=:vehicletypeid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("vehicletypeid", vehicletypeid);
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();

	}

	@SuppressWarnings("unchecked")
	public Routestop qryRoutestop(long routeid, long stationid) {
		StringBuilder sql = new StringBuilder("select r from Routestop r")
				.append(" where r.route.id = :routeid").append(
						" and r.isactive=1 and r.stationid=:stationid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("routeid", routeid);
		query.setParameter("stationid", stationid);
		List<Routestop> rst = query.getResultList();
		return rst != null && rst.size() > 0 ? rst.get(0) : null;
	}

	@SuppressWarnings("unchecked")
	public List<Handprice> qryHandprice(long routeid, long vehicletypeid,
			long departstationid, long reachstationid) {
		StringBuilder sql = new StringBuilder(
				"select r from Handprice r,Schedule s")
				.append(" where r.vehicletypeid = :vehicletypeid and r.scheduleid=s.id and s.route.id=:routeid")
				.append(" and r.departstationid=:departstationid and r.reachstationid=:reachstationid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("vehicletypeid", vehicletypeid);
		query.setParameter("routeid", routeid);
		query.setParameter("departstationid", departstationid);
		query.setParameter("reachstationid", reachstationid);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> qryHandprice(long handpriceid) {
		StringBuilder sql = new StringBuilder("select r from Handprice r")
				.append(" where r.id = :handpriceid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("handpriceid", handpriceid);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Handprice> qryStartHandprice(long scheduleid) {
		StringBuilder sql = new StringBuilder(
				"select r from Handprice r,Schedulestop ss")
				.append(" where r.departstationid = ss.stationid and r.scheduleid = ss.schedule.id")
				.append(" and r.scheduleid = :scheduleid and  ss.orderno = 0");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Handprice> qryReachHandprice(long scheduleid) {
		StringBuilder sql = new StringBuilder(
				"select r from Handprice r,Schedulestop ss")
				.append(" where r.departstationid = ss.stationid and r.scheduleid = ss.schedule.id")
				.append(" and r.scheduleid = :scheduleid and  ss.orderno > 0");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Schedulestop> qryReachSchedulestop(long scheduleid) {
		StringBuilder sql = new StringBuilder("select ss from Schedulestop ss")
				.append(" where ss.schedule.id = :scheduleid and ss.orderno > 0 and ss.isdepart='1'");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public Ticketprice qryTicketpriceById(long ticketpriceid) {
		StringBuilder sql = new StringBuilder("select r from Ticketprice r")
				.append(" where r.id = :ticketpriceid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceid", ticketpriceid);
		List<Ticketprice> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	@SuppressWarnings("unchecked")
	public List<Ticketpriceitem> qryTicketpriceitem(long ticketpriceid) {
		StringBuilder sql = new StringBuilder("select r from Ticketpriceitem r")
				.append(" where r.ticketprice.id = :ticketpriceid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceid", ticketpriceid);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Ticketprice> qryTicketprice(Date departdate, long routeid,
			long scheduleid, long departstationid, long reachstationid) {
		StringBuilder sql = new StringBuilder(
				"select r from Ticketprice r,Schedule s")
				.append(" where r.departdate = :departdate and r.scheduleid=s.id")
				.append(" and s.route.id=:routeid")
				.append(" and r.departstationid=:departstationid and r.reachstationid=:reachstationid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("routeid", routeid);
		query.setParameter("departstationid", departstationid);
		query.setParameter("reachstationid", reachstationid);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Ticketprice> qryTicketpriceByDate(Date fromdate, Date enddate, long routeid, long scheduleid, long departstationid,
			long reachstationid) {
		StringBuilder sql = new StringBuilder("select r from Ticketprice r,Schedule s")
				.append(" where r.departdate between :departdate and :enddate and r.scheduleid=s.id ") 
				.append(" and s.route.id=:routeid and r.departstationid=:departstationid and r.reachstationid=:reachstationid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departdate", fromdate);
		query.setParameter("enddate", enddate);
		query.setParameter("routeid", routeid);
		query.setParameter("departstationid", departstationid);
		query.setParameter("reachstationid", reachstationid);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Ticketprice> qryTicketpriceByDate(Date fromdate, Date enddate, long scheduleid, long departstationid,
			long reachstationid) {
		StringBuilder sql = new StringBuilder("select r from Ticketprice r,Schedule s")
				.append(" where r.departdate between :departdate and :enddate and r.scheduleid=s.id and s.id = :scheduleid") 
				.append(" and r.departstationid=:departstationid and r.reachstationid=:reachstationid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departdate", fromdate);
		query.setParameter("enddate", enddate);
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("departstationid", departstationid);
		query.setParameter("reachstationid", reachstationid);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> qryTicketprice(long ticketpriceid) {
		StringBuilder sql = new StringBuilder("select r from Ticketprice r")
				.append(" where r.id = :ticketpriceid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketpriceid", ticketpriceid);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Handprice> qryHandprices(long departstationid,
			long reachstationid, String schids) {
		StringBuilder sql = new StringBuilder("select r from Handprice r")
				.append(" where r.departstationid = :departstationid").append(
						" and r.reachstationid=:reachstationid and r.scheduleid in "
								+ schids);
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departstationid", departstationid);
		query.setParameter("reachstationid", reachstationid);
		return query.getResultList();
	}

	//综合调度-站点票价 查询相同站点班次票价信息
	@SuppressWarnings("unchecked")
	public List<Object> qrySameStations(String departstationids,
			long reachstationid) {
		StringBuilder sql = new StringBuilder(
				"select s.id,1 as isselect,s.code,trim(s.starttime),r.fullprice,")
				.append("r.halfprice,r.studentprice,r.toplimitprice,r.moreprice")
				.append(" ,r.discountprice,r.roundprice,r.connectprice")
				.append(" from Handprice r,Schedule s")
				.append(" where r.scheduleid=s.id and ")
				.append(" r.reachstationid=:reachstationid and r.departstationid in "
						+ departstationids)
				.append(" and (s.isactive = 1 or s.isactive = 0 and s.isovertime = 1 and s.updatetime >= sysdate -30) and s.isdelete = 0 order by trim(s.starttime)");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("reachstationid", reachstationid);
		return query.getResultList();
	}
}
