/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.dispatch.dao<br/>
 * <b>文件名：</b>ScheduleplusDao.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2011-7-11-下午02:28:14<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.dispatch.dao;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Cycleschemes;
import cn.nova.bus.base.model.Cycleschemesdriver;
import cn.nova.bus.base.model.Cycleschemesschedule;
import cn.nova.bus.base.model.Cycleschemessteward;
import cn.nova.bus.base.model.Cycleschemesvehicle;
import cn.nova.bus.base.model.Routestop;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Schedulestop;
import cn.nova.bus.base.model.Ticketdiscount;
import cn.nova.bus.base.model.Vehiclebrandmodel;
import cn.nova.bus.base.model.Vehiclespace;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.price.model.Handholidayprice;
import cn.nova.bus.price.model.Handprice;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Standardprice;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>ScheduleplusDao<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */
@SuppressWarnings("rawtypes")

public class ScheduleplusDao extends EntityManagerDaoSurport {

	

	@SuppressWarnings("unchecked")
	public List<Object> qryOtherSchedule(long routeid) {
		StringBuilder sql = new StringBuilder(
				"select s.id,s.worktype,s.workways,")
		.append(" s.districttype,s.type,s.runtime,s.isproprietary,")
		.append(" s.issellreturnticket,s.isoriginator,s.issaleafterreport,")
		.append(" s.iscanmixcheck,s.printinfo,ss.ticketentranceid,")
		.append(" ss.vehcileparkid")
		.append("  from schedule s,schedulestop ss,route r")
		.append(" where s.id = (select min(s.id)")
		.append(" from Schedule s where s.isactive = 1")
		.append(" and s.routeid =:routeid)")
		.append(" and s.id = ss.scheduleid and ss.stationid=r.startstationid")
		.append(" and s.routeid=r.id");
		Query query = em.createNativeQuery(sql.toString());		
		query.setParameter("routeid",routeid);
		return query.getResultList();
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Handprice> qryHandprice(long scheduleid,long vehicletypeid) {
		StringBuilder sql = new StringBuilder(
				"select hp")
		.append(" from Handprice hp")
		.append(" where hp.scheduleid =:scheduleid")
		.append(" and hp.vehicletypeid =:vehicletypeid");
		Query query = em.createQuery(sql.toString());		
		query.setParameter("scheduleid",scheduleid);
		query.setParameter("vehicletypeid",vehicletypeid);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Handholidayprice> qryHandHolidayprice(long scheduleid,long vehicletypeid,Date departdate) {
		StringBuilder sql = new StringBuilder(
				"select hp")
		.append(" from Handholidayprice hp")
		.append(" where hp.enddate>=:departdate and hp.startdate<=:departdate")
		.append(" and hp.scheduleid=:scheduleid and hp.vehicletypeid=:vehicletypeid");
		Query query = em.createQuery(sql.toString());		
		query.setParameter("scheduleid",scheduleid);
		query.setParameter("vehicletypeid",vehicletypeid);
		query.setParameter("departdate",departdate);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Standardprice> qryStandardprice(long scheduleid,long vehicletypeid) {
		StringBuilder sql = new StringBuilder(
				"select sp")
		.append("  from Standardprice sp")
		.append(" where sp.scheduleid = :scheduleid")
		.append(" and sp.vehicletypeid =:vehicletypeid)");		
		Query query = em.createQuery(sql.toString());		
		query.setParameter("scheduleid",scheduleid);
		query.setParameter("vehicletypeid",vehicletypeid);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> qryScheduleCycle(long scheduleid) {
		StringBuilder sql = new StringBuilder(
				"select cv.unitid, cv.vehicletypeid,")
				.append(" u.name as unitname,vc.name as vehicletypename,cv.vehiclebrandmodelid")
				.append(" from  cycleschemesschedule css, ")
				.append(" Cycleschemesvehicle cv left join unit u on cv.unitid=u.id,vehicletype vc")
				.append(" where  css.cycleschemesid = cv.cycleschemesid")
				.append(" and css.scheduleid =:scheduleid")
				.append(" and vc.id=cv.vehicletypeid");		
		Query query = em.createNativeQuery(sql.toString());		
		query.setParameter("scheduleid",scheduleid);
		return  query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> getSchedulestop(long scheduleid) {
		StringBuilder sql = new StringBuilder(
				"select s,s.isactive as isselect,st.name as stationname,st.helpcode")
				.append(" from Schedulestop s ,Station st ")
				.append(" where s.schedule.id=:scheduleid")
				.append(" and s.stationid=st.id and s.isdepart=0 order by s.orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Schedulestop> qrySchedulestop(long scheduleid) {
		StringBuilder sql = new StringBuilder(
				"select s")
				.append(" from Schedulestop s ")
				.append(" where s.schedule.id=:scheduleid")
				.append("  and s.isdepart=0 order by s.orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
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
	public List<Schedulestatus> qrySchedulestatus(long scheduleplanid) {
		StringBuilder sql = new StringBuilder("select s from Schedulestatus s, Schedulestop ss")
		.append(" where s.scheduleid = ss.schedule.id  and s.scheduleplan.id=:scheduleplanid")
		.append(" and s.departstationid=ss.stationid and ss.isdepart=1")
		.append(" order by ss.orderno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		return query.getResultList();
	}	
	
	@SuppressWarnings("unchecked")
	public List<Handprice> qryHandprice(long scheduleid) {
		StringBuilder sql = new StringBuilder(
				"select hp")
		.append(" from Handprice hp")
		.append(" where hp.scheduleid =:scheduleid")
		.append(" and hp.vehicletypeid =(select max(h.vehicletypeid) from Handprice h where h.scheduleid =:scheduleid))");
		Query query = em.createQuery(sql.toString());		
		query.setParameter("scheduleid",scheduleid);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Cycleschemes> qrySchedulecycle(long orgid,Date departdate) {
		StringBuilder sql = new StringBuilder(
				" select distinct cs from Cycleschemes cs, " +
				" Cycleschemesschedule css,Schedule s" +
				" where cs = css.cyclescheme and cs.enddate<:departdate" +
				" and css.scheduleid = s.id and s.isovertime = 1 and s.orgid=:orgid");
		Query query = em.createQuery(sql.toString());		
		query.setParameter("orgid",orgid);
		query.setParameter("departdate",departdate);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Cycleschemesschedule> qryCycleschemesschedule(Cycleschemes cycleschemes) {
		StringBuilder sql = new StringBuilder(
				" select css from  " +
				" Cycleschemesschedule css" +
				" where css.cyclescheme=:cyclescheme");
		Query query = em.createQuery(sql.toString());		
		query.setParameter("cyclescheme",cycleschemes);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Cycleschemesdriver> qryCycleschemesdriver(Cycleschemes cycleschemes) {
		StringBuilder sql = new StringBuilder(
				" select css from  " +
				" Cycleschemesdriver css" +
				" where css.cyclescheme=:cyclescheme");
		Query query = em.createQuery(sql.toString());		
		query.setParameter("cyclescheme",cycleschemes);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Cycleschemessteward> qryCycleschemessteward(Cycleschemes cycleschemes) {
		StringBuilder sql = new StringBuilder(
				" select css from  " +
				" Cycleschemessteward css" +
				" where css.cyclescheme=:cyclescheme");
		Query query = em.createQuery(sql.toString());		
		query.setParameter("cyclescheme",cycleschemes);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Cycleschemesvehicle> qryCycleschemesvehicle(Cycleschemes cycleschemes) {
		StringBuilder sql = new StringBuilder(
				" select css from  " +
				" Cycleschemesvehicle css" +
				" where css.cyclescheme=:cyclescheme");
		Query query = em.createQuery(sql.toString());		
		query.setParameter("cyclescheme",cycleschemes);
		return query.getResultList();
	}
	
	// 根据厂牌查询座位类型
	@SuppressWarnings("unchecked")
	public Vehiclespace qryVehiclespace(Vehiclebrandmodel vehiclebrandmodel,
			short seatno) {
		StringBuilder sql = new StringBuilder(
				"select vs from Vehiclespace vs,Vehicleseatplandetail vp,Vehicleseatplan v")
				.append(" where vs.id = vp.vehiclespaceid and vp.vehicleseatplan=v")
				.append(" and vs.isactive='1' and vp.seatno=:seatno and v.vehiclebrandmodelid=:vehiclebrandmodelid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("vehiclebrandmodelid", vehiclebrandmodel.getId());
		query.setParameter("seatno", seatno);
		List<Vehiclespace> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;

	}
	@SuppressWarnings("unchecked")
	public  BigDecimal qryRuntime(long routeid) {
		StringBuilder sql = new StringBuilder(
				" select  max(ss.runtime) from Schedule s,Schedulestop ss")
		.append(" where s.id=ss.schedule.id and s.route.id=:routeid and s.isactive=1");
		Query query = em.createQuery(sql.toString());		
		query.setParameter("routeid",routeid);
		List<Object> list=query.getResultList();
		return (BigDecimal) (list!=null&&list.size()>0?list.get(0):new BigDecimal(0));
	}
	/**
	 * 新增方法用来查询handprice记录
	 */
	public List<Handprice> qryHandprice(long scheduleid,Vehiclebrandmodel vehiclebrandmodel)
	{
		StringBuilder sql = new StringBuilder(" select hp from Handprice hp,Schedule s ");
		sql.append(" where  hp.scheduleid = s.id and hp.scheduleid =:scheduleid");
		sql.append(" and (hp.vehiclebrandmodel.id =:vehiclebrandmodelid or hp.vehiclebrandmodel.id is null) ");
		sql.append(" and  hp.vehicletypeid =:vehicletypeid ");
		sql.append(" and s.isovertime ='0' ");
//		sql.append(" and ((hp.vehiclebrandmodel.id =:vehiclebrandmodelid and  hp.vehicletypeid =:vehicletypeid )");
//		sql.append(" or (hp.vehiclebrandmodel.id is null and hp.vehicletypeid = 0)");
//		sql.append("  or (hp.vehicletypeid=:vehicletypeid and hp.vehiclebrandmodel.id is null) )");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleid",scheduleid);
		query.setParameter("vehiclebrandmodelid",vehiclebrandmodel.getId());
		query.setParameter("vehicletypeid",vehiclebrandmodel.getVehicletypeid());
		List<Handprice> list=query.getResultList();
		return list;
	}
	//查询线路停靠点的list
	public List<Routestop> getroutestoplist(long routeid)
	{
		String sql = "select t from Routestop t where t.route.id=:routeid";
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("routeid", routeid);
		return query.getResultList();
	}
	
	//用来查询当前加班报到的车辆的硬调票价，来准备更新执行票价
	public List<Handprice> qryHandprice1(long scheduleid,long vehicletypeid,long vehiclebrandmodelid)
	{
		StringBuffer sb = new StringBuffer("");
		sb.append("select h from Handprice h,Schedule s");
		sb.append(" where h.scheduleid=s.id and h.scheduleid =:scheduleid");
		sb.append(" and h.vehicletypeid=:vehicletypeid ");
		sb.append(" and ((h.vehiclebrandmodel.id is not null and h.vehiclebrandmodel.id=:vehiclebrandmodelid) or h.vehiclebrandmodel.id is null)");
		Query query = em.createQuery(sb.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("vehicletypeid", vehicletypeid);
		query.setParameter("vehiclebrandmodelid", vehiclebrandmodelid);
		List<Handprice> list = query.getResultList();

		
		return list;
		
	}
	public BigDecimal actPrice(BigDecimal fullprice, BigDecimal price,
			Date departdate, String tickettype, Schedule schedule) {
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
			Ticketdiscount td = list.get(0);
			return fullprice.multiply(td.getDefaultdiscountrate()).setScale(0,
					BigDecimal.ROUND_HALF_UP);
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
			Ticketdiscount td = list.get(0);
			return fullprice.multiply(td.getDefaultdiscountrate()).setScale(0,
					BigDecimal.ROUND_HALF_UP);
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
			Ticketdiscount td = list.get(0);
			return fullprice.multiply(td.getDefaultdiscountrate()).setScale(0,
					BigDecimal.ROUND_HALF_UP);
		}
		return price;
	}
}
