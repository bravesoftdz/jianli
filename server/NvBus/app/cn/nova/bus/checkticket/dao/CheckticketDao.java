package cn.nova.bus.checkticket.dao;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.LockModeType;
import javax.persistence.Query;

import cn.nova.bus.base.model.Pcticketentrance;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.checkticket.model.ScheduleStartCheck;
import cn.nova.bus.checkticket.model.Ticketmixcheck;
import cn.nova.bus.common.ConstDefiniens;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.model.Seatreserve;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Organization;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * @author lck
 * 
 */
@SuppressWarnings("rawtypes")
public class CheckticketDao extends EntityManagerDaoSurport {
	
	private BilltypeServiceImpl billtypeService = new BilltypeServiceImpl();
	
	
	/**
	 * 通过报道ID,票号,日期 查询该票是否是这个班次上的票 count结果如果不等于0 说明是. 否则不是
	 * @param vehiclereportid
	 * @param ticketno
	 * @param departdate
	 * @return
	 */
	public boolean checkisschedule(long vehiclereportid, String ticketno, Date departdate) {
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(t.id) from  ticketsell t left join vehiclereport vr on vr.scheduleplanid = t.scheduleplanid ")
				.append(" where vr.id = "+vehiclereportid+" and t.ticketno = '"+ticketno+"' and t.departdate = :departdate  ");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("departdate", departdate);
		BigDecimal result = (BigDecimal) query.getResultList().get(0);
		return result.compareTo(BigDecimal.ZERO) == 0 ? false:true;
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> qryScheduleplan(
			List<PropertyFilter> propertyFilterList, Date departdate,
			long reportorgid,String status,long departstationid) {
		String departid="";
		String vehicleid = "";
		for (PropertyFilter propertyFilter : propertyFilterList) {
			if("ss!departstationid".equals(propertyFilter.getPropertyFullName()))
				departid = propertyFilter.getMatchValue().toString();
			
			if("vr!vehicleid".equals(propertyFilter.getPropertyFullName())){
				vehicleid = propertyFilter.getMatchValue().toString();
			}
		}
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
		String  begin=df.format(departdate);
		//0013         本系统是否支持会员卡（贵宾卡），0不支持，1支持，默认为0
		String p0013= (String) em.createNativeQuery("select p.value from parameter p where p.code = '0013'").getResultList().get(0);
		StringBuilder sql = new StringBuilder(
				"select 0 as ischecked, sp.id,ss.departstationid as departstationid,sp.endstationid as endstationid,r.id as routeid,st2.name as departstation,st1.name endstation,")
				.append(" trim(ss.departtime) as departtime,vh.vehicleno,sp.isovertime,sp.seatnum,")
				.append(" sp.soldeatnum,sp.departdate,s.code,vt.name as vehicletypename,")
				.append(" ss.ticketentrance,ss.buspark,ss.status,nvl(vh.vehiclebrandmodelid,sv.planvehiclebrandmodelid) planvehiclebrandmodelid,")
				.append(" pb.brandname,pb.modelcode,sp.islinework,ss.isreported,ss.isdeparted,")
				.append(" vr.id as vehiclereportid,r.name as routename,")
				.append(" r.distance,vr.vehicleid,r.jianpin,sp.carrychildnum");
				if(p0013.equals("1")){
					sql.append(",decode((select count(*) from ONECARDSCHEDULE os		  ")
					.append("          where os.startdate <= sp.departdate            ")
					.append("  			 and os.enddate >= sp.departdate              ")
					.append("  			 and os.orgid=sp.orgid and os.isactive=1      ")
					.append("  			 and (os.type='0'                             ")
					.append("       		  or os.type='1' and os.typeid=s.routeid  ")
					.append("       		  or os.type='2' and os.typeid=s.id       ")
					.append("                )                                        ")
					.append("       ),0,0,1) as canonecard,                           ");
				}else{
					sql.append(" ,0 as canonecard,");
				}
//				.append(" (select count(*) from Ticketsell ts where ts.scheduleplanid=sp.id")
//				.append("      and ts.ischecked=1) as checkeds,sp.worktype,")
				sql.append(" nvl(ts.checkeds,0) checkeds,sp.worktype, ")
				.append(" trim(decode(ss.departstationid,sp.startstationid,'始发班','串点班')) schtype,s.id scheduleid ,ss.isbegincheck isbegincheck, r.isrealnameticket isrouterealname")
				.append(" from Scheduleplan sp left join (select count(*) checkeds, ts.scheduleplanid from Ticketsell ts where ts.ischecked = 1 and ts.departdate = to_date('"+begin+"','yyyymmdd') ")
				.append(" group by ts.scheduleplanid) ts on ts.scheduleplanid = sp.id ")
				.append("  left join Vehiclereport vr left join vehicle vh on vh.id = vr.vehicleid on sp.id = vr.scheduleplanid")
				.append(" and vr.isactive = 1 ") //and vr.departdate = :departdate
				.append(" and sp.departdate=to_date('"+begin+"','yyyymmdd') ")
				.append(" and vr.reportorgid = :reportorgid, ")
//				.append(" left join securitycheck st on st.vehicleid = vr.vehicleid  and sp.departdate = trunc(st.checktime),")//新增关联安检表
				/*.append(" left join (select st1.vehicleid,st1.result,st1.checktime  from securitycheck st1 ")
				.append(" inner join ( ") 
				.append(" select st2.vehicleid as vehicleid , max(st2.checktime) as checktime from securitycheck st2 ")
				.append("  where trunc(st2.checktime)=:departdate group by st2.vehicleid ) st3")
				.append("  on st1.vehicleid=st3.vehicleid and st1.checktime=st3.checktime ")
				.append("  where trunc(st1.checktime)=:departdate ) st ")
				.append("  on st.vehicleid = vr.vehicleid ")
				.append("  and sp.departdate = trunc(st.checktime) , ")
				*/
				.append(" schedulestatus ss, schedule s, station st1, station st2,route r,")
				.append(" vehicletype vt,Schedulevehiclepeopleplan sv")
				.append(" left join vehiclebrandmodel pb on sv.planvehiclebrandmodelid = pb.id,Ticketentrance ta,organization org")
				.append(" where sp.scheduleid = s.id and sp.id = ss.scheduleplanid")
				.append(" and ss.departstationid = st2.id and sp.endstationid = st1.id")//
				.append(" and sp.id = sv.scheduleplanid and sv.orderno = 0 and ss.ticketentrance=ta.name and ta.orgid=org.id")
				.append(" and sv.planvehicletypeid = vt.id and s.routeid=r.id ")//and ss.departstationid=org.stationid
				.append(" and (vr.orderno=(select max(orderno) from vehiclereport tt ");
				if("".equals(vehicleid)){
					sql.append(" where tt.isactive=1 and tt.scheduleplanid=sp.id and tt.reportorgid=:reportorgid) or vr.id is null )");
				}else{
					//如果该流水班报了多个车辆，输入不是最后报到的车辆的车牌号进行查询时，不能直接取该班次报到表中最大的orderno
					sql.append(" where tt.isactive=1 and tt.scheduleplanid=sp.id and tt.reportorgid=:reportorgid ")
						.append(" and tt.vehicleid = ").append(vehicleid).append(" ) or vr.id is null )");
				}
				sql.append(" and ((ss.departstationid in "+departid+" and ss.departstationid=org.stationid) ")
				.append(" or ((s.worktype='2' or s.worktype='3')))")// and r.startstationid=ss.departstationid and s.orgid=org.id
				.append("  and ss.status in "+status);//and ss.departdate = :departdate and sp.departdate =:departdate
				sql.append(" and sp.departdate=to_date('"+begin+"','yyyymmdd') ");
				sql.append(" and ss.departdate=to_date('"+begin+"','yyyymmdd') ");
				sql.append("  and ta.orgid=:reportorgid  ");//限制检票口所属机构为当前检票机构
		// and ss.departstationid = 103/
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by ss.departtime, st1.name");
		Query query = em.createNativeQuery(sql.toString());
//		query.setParameter("departdate", departdate);
		query.setParameter("reportorgid", reportorgid);
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	public List<Object> qryScheduleplanbyself(
			List<PropertyFilter> propertyFilterList, Date departdate,
			long reportorgid,String status,long departstationid,Global global) {
		StringBuilder sql = new StringBuilder(
				"select sp.id,st2.name as departstation,st1.name endstation,")
				.append(" trim(ss.departtime) as departtime,vh.vehicleno,sp.isovertime,sp.seatnum,")
				.append(" sp.soldeatnum,nvl(tt.localsell,0),nvl(tt.localchecked,0) localchecked,nvl((tt.localsell - tt.localchecked),0) localnonecheck,")
				.append(" sp.departdate,s.code,vt.name as vehicletypename,ss.ticketentrance,ss.buspark,ss.status,sv.planvehiclebrandmodelid,")
				.append(" pb.brandname,pb.modelcode,sp.islinework,ss.isreported,vr.isdeparted,")
				.append(" vr.id as vehiclereportid,r.name as routename,")
				.append(" r.distance,vr.vehicleid,r.jianpin,sp.carrychildnum")
				.append(",decode((select count(*) from ONECARDSCHEDULE os		  ")
				.append("          where os.startdate <= sp.departdate            ")
				.append("  			 and os.enddate >= sp.departdate              ")
				.append("  			 and os.orgid=sp.orgid and os.isactive=1      ")
				.append("  			 and (os.type='0'                             ")
				.append("       		  or os.type='1' and os.typeid=s.routeid  ")
				.append("       		  or os.type='2' and os.typeid=s.id       ")
				.append("                )                                        ")
				.append("       ),0,0,1) as canonecard,                           ")
				.append(" (select count(*) from Ticketsell ts where ts.scheduleplanid=sp.id and ts.vehiclereportid=vr.id ")
				.append("      and ts.ischecked=1) as checkeds,sp.worktype,")
				.append(" decode(ss.departstationid,sp.startstationid,'始发班','串点班') schtype,vr.reporttime")
				.append(" ,u.name driver1,u1.name driver2, ")
				.append(" sp.soldeatnum-(select count(*) from Ticketsell ts where ts.scheduleplanid=sp.id and ts.vehiclereportid=vr.id and ts.ischecked=1) as uncheckeds,vh.cardno as cardno ")
				.append(" from Scheduleplan sp left join Vehiclereport vr ")
				.append(" left join driver u on u.id = vr.driver1id left join driver u1 on u1.id = vr.driver2id ")
				.append(" left join vehicle vh on vh.id = vr.vehicleid on sp.id = vr.scheduleplanid")
				.append(" and vr.isactive = 1 and vr.departdate = :departdate")
				.append(" and vr.reportorgid = :reportorgid")
				.append(" left join (select t.scheduleplanid,sum(case when t.departstationid = "+global.getStationID()+" then 1 else 0 end) as localsell,sum(case when (t.departstationid = "+global.getStationID()+") and (t.ischecked = 1) then 1 else 0 end) as localchecked ")
                .append(" from Ticketsell t where t.ticketstatus = '0' and t.tickettype <> 'E' and t.departdate = :departdate group by t.scheduleplanid ) tt on tt.scheduleplanid = sp.id ,")
				.append(" schedulestatus ss, schedule s, station st1, station st2,route r,")
				.append(" vehicletype vt,Schedulevehiclepeopleplan sv")
				.append(" left join vehiclebrandmodel pb on sv.planvehiclebrandmodelid = pb.id,Ticketentrance ta,organization org")
				.append(" where sp.scheduleid = s.id and sp.id = ss.scheduleplanid")
				.append(" and ss.departstationid = st2.id and sp.endstationid = st1.id")
				.append(" and sp.id = sv.scheduleplanid and sv.orderno = 0 and ss.ticketentrance=ta.name and ta.orgid=org.id")
				.append(" and sv.planvehicletypeid = vt.id and s.routeid=r.id ")//and ss.departstationid=org.stationid
				//.append(" and (vr.orderno=(select max(orderno) from vehiclereport tt ")
				//.append(" where tt.isactive=1 and tt.scheduleplanid=sp.id and tt.reportorgid=:reportorgid) or vr.id is null )")
				.append(" and ((ss.departstationid = "+departstationid+" and ss.departstationid=org.stationid) ")
				.append(" or ((s.worktype='2' or s.worktype='3') and r.startstationid=ss.departstationid and s.orgid=org.id))")
				.append(" and ss.departdate = :departdate and sp.departdate =:departdate and ss.status in "+status);
		// and ss.departstationid = 103/
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by ss.departtime, st1.name");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("reportorgid", reportorgid);
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	// 获取班次座位信息
	@SuppressWarnings("unchecked")
	public List<Object> qryScheduleseats(Scheduleplan scheduleplan) {
		StringBuilder sql = new StringBuilder(
				"select c from Scheduleseats c where c.scheduleplan=:scheduleplan");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplan", scheduleplan);
		return query.getResultList();
	}
	// 获取班次票价信息
	@SuppressWarnings("unchecked")
	public List<Ticketprice> qryTicketprices(Scheduleplan scheduleplan) {
		StringBuilder sql = new StringBuilder(
				"select c from Ticketprice c where c.scheduleplan=:scheduleplan");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplan", scheduleplan);
		return query.getResultList();
	}
	public Organization getOrganization(long stationid) {
		StringBuilder sql = new StringBuilder("select o from Organization o")
				.append(" where (o.type='1' or o.type='2') and o.isactive=1")
				.append(" and o.station.id=:stationid ");
		Query query = em.createQuery(sql.toString());
		query.setParameter("stationid", stationid);
		return (Organization) query.getSingleResult();
	}

	// 检票界面查询流水班次的报到信息
	@SuppressWarnings("unchecked")
	public List<Object> getVehiclereport(long scheduleplanid,boolean isdeparted,long reportorgid,Date departdate) {
		StringBuilder sql = new StringBuilder(
				"select vr.id,vr.scheduleplanid,v.vehicleno,v.seatnum,vr.reporttime,")
				.append(" vt.name as vehicletype,vbm.brandname,vr.vehicleid,vr.isdeparted,nvl(ts.tickets,0)")
				.append(" from Vehiclereport vr ")
				.append("   left join (select count(*) tickets, ts.vehiclereportid")
				.append("   from ticketsell ts where ts.departdate = trunc(:departdate) and ts.ischecked = 1")
				.append(" group by ts.vehiclereportid) ts on vr.id = ts.vehiclereportid,")
				.append(" Vehicle v,Vehiclebrandmodel vbm")
				.append(" ,Vehicletype vt")
				.append(" where vr.vehicleid=v.id and v.vehicletypeid=vt.id ")
				.append(" and vr.isactive=1  and vr.reportorgid=:reportorgid")
				.append(" and v.vehiclebrandmodelid=vbm.id")
				.append(" and vr.scheduleplanid=:scheduleplanid ")
				.append(" and vr.isdeparted=:isdeparted and vr.departdate= trunc(:departdate) order by vr.reporttime ");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("reportorgid", reportorgid);
		query.setParameter("isdeparted", isdeparted);
		query.setParameter("departdate", departdate);		
		return query.getResultList();
	}

	// 检票界面查询流水班次的报到信息
	@SuppressWarnings("unchecked")
	public List<Object> getVehiclereport(long scheduleplanid,long reportorgid) {
		StringBuilder sql = new StringBuilder(
				"select vr.id,vr.scheduleplanid,v.vehicleno,v.seatnum,vr.reporttime")
				.append(" from Vehiclereport vr,Vehicle v")
				.append(" where vr.vehicleid=v.id and vr.reportorgid=:reportorgid")
				.append(" and vr.isactive=1  and vr.scheduleplanid=:scheduleplanid ");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("reportorgid", reportorgid);
		return query.getResultList();
	}
	/**
	 * 查询流水班次的报到记录
	 */
	public Vehiclereport getLineVehiclereport(Scheduleplan scheduleplan,
			long reportorgid) {
		StringBuilder sql = new StringBuilder("select vr")
				.append(" from Vehiclereport vr")
				.append(" where vr.isactive=1 ")
				.append(" and vr.scheduleplanid=:scheduleplanid and vr.reportorgid=:reportorgid and vr.isdeparted=0 order by id");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplan.getId());
		query.setParameter("reportorgid", reportorgid);
		List<Object> list = query.getResultList();
		return (Vehiclereport) (list != null && list.size() > 0 ? list.get(0)
				: null);
	}

	
	@SuppressWarnings("unchecked")
	public List<Vehiclereport> qryVehiclereport(Scheduleplan scheduleplan,long reportorgid,Date departdate) {
		StringBuilder sql = new StringBuilder("select vr")
				.append(" from Vehiclereport vr")
				.append(" where vr.isactive=1 and vr.isdeparted=0 ")
				.append(" and vr.scheduleplanid=:scheduleplanid and vr.reportorgid=:reportorgid")
				.append(" and vr.departdate=:departdate")
				.append(" order by vr.orderno");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplan.getId());
		query.setParameter("reportorgid", reportorgid);	
		query.setParameter("departdate", departdate);	
		List<Vehiclereport> list = query.getResultList();
		return list;
	}

	// 查询正班的报到记录
	@SuppressWarnings("unchecked")
	public Vehiclereport getVehiclereport(Scheduleplan scheduleplan,
			long reportorgid) {
		StringBuilder sql = new StringBuilder("select vr")
				.append(" from Vehiclereport vr")
				.append(" where vr.isactive=1 ")
				.append(" and vr.scheduleplanid=:scheduleplanid and vr.reportorgid=:reportorgid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplan.getId());
		query.setParameter("reportorgid", reportorgid);
		List<Object> list = query.getResultList();
		return (Vehiclereport) (list != null && list.size() > 0 ? list.get(0)
				: null);
	}

	// 检票界面查询已检或者未检未发班的车票
	@SuppressWarnings("unchecked")
	public List<Object> queryChecktickets(long scheduleplanid , boolean ischecked) {
		StringBuilder sql = new StringBuilder(
				"select t.scheduleplanid,s.name as stationname,t.ticketno,t.fullprice,t.ticketstatus ")
				.append(" from Ticketsell t,Station s ")
				.append(" where t.reachstationid=s.id and t.ticketstatus='0' and t.ischecked=:ischecked")
				.append(" and t.scheduleplanid=:scheduleplanid and t.isdepartinvoices=0");
		sql.append(" and t.tickettype <> 'E' ");//排除儿童票
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("ischecked", ischecked);
		return query.getResultList();
	}

	// 检票界面查询流水班报到车辆的检票数
	@SuppressWarnings("unchecked")
	public long queryChecktickets(long scheduleplanid, long vehiclereportid,Date departdate) {
		StringBuilder sql = new StringBuilder("select count(t.id) ")
				.append(" from Ticketsell t")
				.append(" where t.ticketstatus='0' and t.ischecked=1")
				.append(" and t.scheduleplanid=:scheduleplanid and t.vehiclereport.id=:vehiclereportid ")
				.append("and t.departdate = :departdate");
		sql.append(" and t.tickettype <> 'E' ");//排除儿童票
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("vehiclereportid", vehiclereportid);
		query.setParameter("departdate", departdate);
		List<Object> list = query.getResultList();
		return (Long) (list != null && list.size() > 0 && list.get(0) != null ? list
				.get(0) : (new Long(0)));
	}
	// 检票界面查询流水班报到车辆的检票数
	@SuppressWarnings("unchecked")
	public long qryUnCheckTickets(long scheduleplanid,Date departdate) {
		StringBuilder sql = new StringBuilder("select count(t.id) ")
				.append(" from Ticketsell t")
				.append(" where t.ticketstatus='0' and t.ischecked=0")
				.append(" and t.scheduleplanid=:scheduleplanid")
				.append(" and t.departdate = :departdate ");
		sql.append(" and t.tickettype <> 'E' ");//排除儿童票
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("departdate",departdate);
		List<Object> list = query.getResultList();
		return (Long) (list != null && list.size() > 0 && list.get(0) != null ? list
				.get(0) : (new Long(0)));
	}
	// 检票界面查询流水班报到车辆的检票数(一卡通刷卡上车人数)
	@SuppressWarnings("unchecked")
	public long queryOneCardChecktickets(long scheduleplanid, long vehiclereportid,Date departdate) {
		StringBuilder sql = new StringBuilder("select count(t.id) ")
				.append(" from Ticketsell t")
				.append(" where t.ticketstatus='0' and t.ischecked=1 and t.sellway='12'")
				.append(" and t.scheduleplanid=:scheduleplanid and t.vehiclereport.id=:vehiclereportid")
				.append(" and t.departdate = :departdate ");
		sql.append(" and t.tickettype <> 'E' ");//排除儿童票
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("vehiclereportid", vehiclereportid);
		query.setParameter("departdate",departdate);
		List<Object> list = query.getResultList();
		return (Long) (list != null && list.size() > 0 && list.get(0) != null ? list
				.get(0) : (new Long(0)));
	}

	@SuppressWarnings("unchecked")
	public List<Object> querySeatstatus(Scheduleplan sp ,long checkstationid) {
		StringBuilder sql = null;
		Query query=null;
		List<Object> list=null;
		long scheduleplanid=sp.getId();
		java.text.SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String depart=sf.format(sp.getDepartdate());
		play.Logger.info("querySeatstatus begin--------------");
		if (sp.getWorktype().equals("3")) {
			//空座、锁座、固定留位
			sql = new StringBuilder(
					"select ss.scheduleplanid,ss.seatno,0 as ischecked,")
					.append(" '0' as ticketno,dd.value as hint,dd.value as seatinfo,0 as departstationid,0 as isdepartinvoices,0 as colortype,")
					.append(" ss.status,ss.tickettype,ss.seattype")
					.append(" from Scheduleseats ss,Digitaldictionary d,Digitaldictionarydetail dd")
					.append(" where ss.status=dd.code and d.id=dd.digitaldictionaryid")
					.append(" and d.tablename='scheduleseats' and d.columnname='status'")
					.append(" and ss.scheduleplanid =:scheduleplanid ")
					.append(" and ss.departdate=to_date('"+depart+"', 'yyyy-mm-dd') ")
					//.append(" and (ss.status='0' or ss.status='1' or ss.status='3' or ss.status='2') ")
					.append(" and not exists")
					.append(" (select t.seatno from Ticketsell t")
					.append(" where t.ticketstatus in ('0','4') and t.scheduleplanid = :scheduleplanid and ss.seatno=t.seatno and t.departdate=to_date('"+depart+"', 'yyyy-mm-dd') ")
					.append(" union all select t.seatno  from Remoteticketsell t")
					.append(" where t.ticketstatus in ('0','4') and t.scheduleplanid =:scheduleplanid and ss.seatno=t.seatno and t.departdate=to_date('"+depart+"', 'yyyy-mm-dd') ")
					.append(" union all select t.seatno  from Seatreserve t")
					.append(" where t.sellstate = 'R' and ss.status <> 2 and t.scheduleplanid =:scheduleplanid and ss.seatno=t.seatno and t.departdate=to_date('"+depart+"', 'yyyy-mm-dd') )");
			play.Logger.info("sp.getWorktype().equals(3)");			 
			query = em.createNativeQuery(sql.toString());
			query.setParameter("scheduleplanid", scheduleplanid);
			list = query.getResultList();

		}
		else
		{
			//空座、锁座、固定留位
			sql = new StringBuilder(
					"select ss.scheduleplanid,ss.seatno,0 as ischecked,")
					.append(" '0' as ticketno,dd.value as hint,dd.value as seatinfo,0 as departstationid,0 as isdepartinvoices,0 as colortype,")
					.append(" ss.status,ss.tickettype,ss.seattype")
					.append(" from Scheduleseats ss,Digitaldictionary d,Digitaldictionarydetail dd")
					.append(" where ss.status=dd.code and d.id=dd.digitaldictionaryid")
					.append(" and d.tablename='scheduleseats' and d.columnname='status'")
					.append(" and ss.scheduleplanid =:scheduleplanid ")
					.append(" and ss.departdate=to_date('"+depart+"', 'yyyy-mm-dd') ")
					.append(" and ss.status in ('0','1','3') ")
					.append(" and not exists")
					.append(" (select t.seatno from Ticketsell t")
					.append(" where t.ticketstatus in ('0','4') and t.scheduleplanid = :scheduleplanid  and ss.seatno=t.seatno and t.departdate=to_date('"+depart+"', 'yyyy-mm-dd') ")
					.append(" union all select t.seatno  from Remoteticketsell t")
					.append(" where t.ticketstatus in ('0','4') and t.scheduleplanid =:scheduleplanid  and ss.seatno=t.seatno and t.departdate=to_date('"+depart+"', 'yyyy-mm-dd') ")
					.append(" union all select t.seatno  from Seatreserve t")
					.append(" where t.sellstate = 'R'  and t.scheduleplanid =:scheduleplanid  and ss.seatno=t.seatno and t.departdate=to_date('"+depart+"', 'yyyy-mm-dd') )");
					
			play.Logger.info("空座、锁座、固定留位 begin");			
			query = em.createNativeQuery(sql.toString());
			query.setParameter("scheduleplanid", scheduleplanid);
			list = query.getResultList();
			play.Logger.info("空座、锁座、固定留位 end");	
		}
        //已售、已检、已开运量
		//modify by 姜蓥瑞  2015‎年‎6‎月‎16‎日  鼠标移至座位图 显示时增加 携童数 xx
		sql = new StringBuilder(
				"select t.scheduleplanid,t.seatno,t.ischecked,t.ticketno,")
				.append("  concat(concat(concat(concat(concat(concat(concat(concat(concat(concat(concat(s.name,t.seatno),'号座由'),tt.name),u.name),':'),'于'),to_char(t.selltime,'yyyy-mm-dd hh24:mi:ss')),'售出'),' 携童数：'), t.carrychildnum),case when t.ticketstatus='4' then '已挂失' else '' end) as hint")
				.append(" ,concat(s.name,(case t.tickettype when 'Q' then '(全)' when 'B' then '(半)' when 'X' then '(学)'  else '(折)' end)) as seatinfo,")
				.append(" t.departstationid,t.isdepartinvoices, ")
				
				
//				.append(" case when nvl(tso.id,0)>0 and tso.istaked = 0  then  5 else")
//				.append(" decode(t.ischecked,0,case when t.departstationid=:checkstationid then (case when t.sellway = '13' then 4 else 0 end) else 3 end,")
//				.append(" case when t.departstationid=:checkstationid then case when nvl(tk.id,0)>0 then 2 else (case when t.sellway = '13' then 4 else 1 end) end else 3 end) end as colortype,")
				.append(" decode(t.sellway, '13',  4,")
				.append(" case when nvl(tso.id, 0) > 0 and tso.istaked = 0 then 5 else ")
				.append(" decode(t.ischecked, 0, case when t.departstationid = :checkstationid then 0 else 3 end,")
				.append(" case  when t.departstationid = :checkstationid then  case when nvl(tk.id, 0) > 0 then 2")
				.append("   else  1 end else 3 end) end) as colortype,")
				
				.append(" case when t.isdepartinvoices = 1 then '8' when t.ischecked = 1 then '7'  else  '2' end status,")
				.append(" t.tickettype,t.seattype")
				.append(" from Ticketsell t  left join ticketmixcheck tk on t.id = tk.ticketsellid and tk.isactive=1")
				.append("  left join ticketsellother tso on tso.ticketsellid = t.id ,")
				.append(" Ticketoutlets tt,Userinfo u,Station s")
				.append(" where t.ticketstatus in ('0','4') ")
				.append(" and t.sellby = u.id and t.ticketoutletsid = tt.id")
				.append(" and t.scheduleplanid=:scheduleplanid and t.departdate = to_date('"+depart+"', 'yyyy-mm-dd') and t.reachstationid=s.id");
		sql.append(" and t.tickettype <> 'E' ");//排除儿童票
		play.Logger.info("已售、已检、已开运量 begin");
		query = em.createNativeQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("checkstationid", checkstationid);
		list.addAll(query.getResultList());
		play.Logger.info("已售、已检、已开运量 end");	
        //远程检票
		//modify by 姜蓥瑞  2015‎年‎6‎月‎16‎日  鼠标移至座位图 显示时增加 携童数 xx
		sql = new StringBuilder(
				"select t.scheduleplanid,t.seatno,1 as ischecked,t.ticketno,")
				.append(" concat(concat(concat(concat(concat(concat(concat(concat(concat(concat(s.name,t.seatno),'号座由'),t.ticketoutletsname),t.sellby),':'),'于'),to_char(t.selltime,'yyyy-mm-dd hh24:mi:ss')),'售出'),' 携童数：'), t.carrychildnum) as hint")
				.append(" ,concat(s.name,(case t.tickettype when 'Q' then '(全)' when 'B' then '(半)' when 'X' then '(学)'  else '(折)' end)) as seatinfo,")
				.append(" t.departstationid,t.isdepartinvoices,0 as colortype,")
				.append(" case when t.isdepartinvoices = 1 then '8' when t.ischecked = 1 then '7' else '2' end status,")
				.append(" t.tickettype,t.seattype")
				.append(" from Remoteticketsell t,Station s")
				.append(" where t.ticketstatus in ('0','4') ")
				.append(" and t.scheduleplanid=:scheduleplanid and t.departdate = to_date('"+depart+"', 'yyyy-mm-dd') and t.reachstationid=s.id");
		play.Logger.info("远程检票 begin");
		query = em.createNativeQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		list.addAll(query.getResultList());
		play.Logger.info("远程检票 end");	
        //留位
		sql = new StringBuilder(
				"select t.scheduleplanid,t.seatno,0 as ischecked,'0' as ticketno,")
				.append(" concat(concat(concat(concat(concat(concat(concat(concat(concat(concat(t.seatno,'号座由'),tt.name),u.name),':'),'于'),")
				.append(" to_char(t.reservetime,'yyyy-mm-dd hh24:mi:ss')),'预留,类型：'),case t.isautocancel when 1 then '自动取消' else '非自动取消' end),")
				.append(" case when cm.name is null then '' else concat(',订票人:',cm.name) end),case when t.remarks is null then '' else concat(',原因:',t.remarks) end ) as hint")
				.append(" ,'留位' as seatinfo,0 as departstationid,0 as isdepartinvoices,0 as colortype,")
				.append(" case when t.isautocancel = 1 then '4' else '5' end status,")
				.append(" t.tickettype,'0' as seattype")
				.append(" from Scheduleplan sp, Seatreserve t left join Customer cm on t.customerid=cm.id,")
				.append(" Ticketoutlets tt,Userinfo u")
				.append(" where t.sellstate='R' and sp.id = t.scheduleplanid and t.departdate = to_date('"+depart+"', 'yyyy-mm-dd') and sp.seatnum >= t.seatno")
				.append(" and t.reserveby = u.id and t.ticketoutletsid = tt.id")
				.append(" and t.scheduleplanid=:scheduleplanid ");
		play.Logger.info("留位 begin");
		query = em.createNativeQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		list.addAll(query.getResultList());
		play.Logger.info("留位 end");
		return list;
	}

	// 查询车票信息，用于混检，加上远检
	@SuppressWarnings("unchecked")
	public List<Object> queryTicket(int days,String ticketno,String certificateno) {
		/*StringBuilder sql = new StringBuilder(
				"select t.id,t.departdate,s.code,trim(t.departtime) as departtime,vt.name as vehicletype,")
				.append(" s1.name as departstation,s2.name as reachstation,")
				.append(" t.seatno,t.price,t.tickettype,t.ticketentrance,")
				.append(" t.buspark,sp.remarks,sp.islinework,t.ticketstatus,t.ischecked,u.name as sellbyname,t.selltime")
				.append(" from Ticketsell t,Schedulevehiclepeopleplan sv,Userinfo u,")
				.append(" Scheduleplan sp,Station s1,Station s2,")
				.append(" Schedule s,Vehicletype vt")
				.append(" where t.scheduleid = s.id and t.scheduleplanid = sp.id")
				.append(" and t.scheduleplanid = sv.scheduleplan.id")
				.append(" and sv.orderno = 0 and sv.planvehicletypeid = vt.id")
				.append(" and t.departstationid = s1.id and t.reachstationid = s2.id")
				.append(" and t.sellby=u.id ")
				.append(" and t.ticketno =:ticketno");
		Query query = em.createQuery(sql.toString());
		query.setParameter("ticketno", ticketno);
		List<Object> objlist = query.getResultList();*/
		
		java.text.SimpleDateFormat sf = new SimpleDateFormat(
				"yyyy-MM-dd");
		Date departdate = new Date();
		try {
			departdate = sf.parse(sf.format(new Date()));
			departdate=DateUtils.add(departdate, -days);					
		} catch (ParseException e) {
			play.Logger.error(e.getMessage(), e);
		}	
		//certificateno 不为空，则校验证件号
		StringBuilder sql = new StringBuilder();
		//使用票号查询
		sql.append("select t.id,t.departdate,s.code,trim(t.departtime) as departtime,vt.name as vehicletype,")
			.append(" s1.name as departstation,s2.name as reachstation,")
			.append(" t.seatno,t.price,t.tickettype,t.ticketentrance,")
			.append(" t.buspark,sp.remarks,sp.islinework,t.ticketstatus,t.ischecked,u.name as sellbyname,t.selltime")
			.append(" from Ticketsell t left join Schedulevehiclepeopleplan sv on t.scheduleplanid = sv.scheduleplanid and sv.orderno = 0 ")
			.append(" left join Scheduleplan sp on t.scheduleplanid = sp.id ")
			.append(" left join Schedule s on t.scheduleid = s.id  left join Userinfo u on t.sellby = u.id ")
			.append(" left join Station s1 on t.departstationid = s1.id left join Station s2 on t.reachstationid = s2.id ")
			.append(" left join Vehicletype vt on sv.planvehicletypeid = vt.id ")
			.append("  where t.ticketstatus='0' and t.departdate>=:departdate and t.ticketno = :ticketno ")
			.append(" and sv.departdate>=:departdate and sp.departdate>=:departdate ");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("ticketno", ticketno);
		query.setParameter("departdate", departdate);
		List<Object> objlist= query.getResultList();
		if (objlist != null && objlist.size() > 0){
			return objlist;
		}else{
			Billtype bt = billtypeService.findByCode("Ticket");
			String cuticketno = ticketno;
			if (ticketno.length() > bt.getTicketnolength()) {
				int pos = (int) (ticketno.length() - bt.getTicketnolength());
				cuticketno = ticketno.substring(pos, ticketno.length());
			} else if (ticketno.length() < bt.getTicketnolength()) {
				cuticketno = StringUtils.strPad(ticketno,
						(int) bt.getTicketnolength(), "0");
			}				
			query = em.createNativeQuery(sql.toString());
			query.setParameter("ticketno", cuticketno);
			query.setParameter("departdate", departdate);	
			List<Object> list = query.getResultList();
			if(list==null||list.size()<=0){
				query = em.createNativeQuery(sql.toString());
				query.setParameter("ticketno", ticketno+"01");
				query.setParameter("departdate", departdate);	
				list = query.getResultList();
			}
			if(list!=null&&list.size()>0){
				return list;	
			}else{
				sql = new StringBuilder(
						"select t.id,t.departdate,s.code,trim(t.departtime) as departtime,vt.name as vehicletype,")
						.append(" s1.name as departstation,s2.name as reachstation,")
						.append(" t.seatno,t.price,t.tickettype,t.ticketentrance,")
						.append(" t.buspark,sp.remarks,sp.islinework,t.ticketstatus,t.ischecked,u.name as sellbyname,t.selltime")
						.append(" from Ticketsell t,Schedulevehiclepeopleplan sv,Userinfo u,")
						.append(" Scheduleplan sp,Station s1,Station s2,")
						.append(" Schedule s,Vehicletype vt")
						.append(" where t.scheduleid = s.id and t.scheduleplanid = sp.id")
						.append(" and t.scheduleplanid = sv.scheduleplan.id and t.sellby=u.id")
						.append(" and sv.orderno = 0 and sv.planvehicletypeid = vt.id ")
						.append(" and t.departstationid = s1.id and t.reachstationid = s2.id")
						.append(" and t.eticketno =:ticketno and t.departdate>=:departdate");
				query = em.createQuery(sql.toString());
				query.setParameter("ticketno", ticketno);
				query.setParameter("departdate", departdate);
				list  = query.getResultList();
				if(list!=null&&list.size()>0){
					return list;	
				}else{
				return queryRemoteCheck(days,ticketno);
				}
			}			
		}	
//		}else{//使用证件号查询时 ,暂时不实现，
//			sql.append("select t.id,t.departdate,s.code,trim(t.departtime) as departtime,vt.name as vehicletype,")
//			.append(" s1.name as departstation,s2.name as reachstation,")
//			.append(" t.seatno,t.price,t.tickettype,t.ticketentrance,")
//			.append(" t.buspark,sp.remarks,sp.islinework,t.ticketstatus,t.ischecked,u.name as sellbyname,t.selltime")
//			.append(" from Ticketsell t left join Schedulevehiclepeopleplan sv on t.scheduleplanid = sv.scheduleplanid and sv.orderno = 0 ")
//			.append(" left join Scheduleplan sp on t.scheduleplanid = sp.id ")
//			.append(" left join Schedule s on t.scheduleid = s.id  left join Userinfo u on t.sellby = u.id ")
//			.append(" left join Station s1 on t.departstationid = s1.id left join Station s2 on t.reachstationid = s2.id ")
//			.append(" left join Vehicletype vt on sv.planvehicletypeid = vt.id left join customer c on t.customerid=c.id ")
//			.append(" where t.ticketstatus='0' and t.departdate>=:departdate  and c.certificateno=:certificateno ");
//			Query query = em.createNativeQuery(sql.toString());
//			query.setParameter("certificateno", certificateno);
//			query.setParameter("departdate", departdate);
//			List<Object> objlist= query.getResultList();
//			return objlist;
//		}


	}
	
	//用于远检
	public List<Object> queryRemoteCheck(int days, String ticketno){
		java.text.SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Date departdate = new Date();
		try {
			departdate = sf.parse(sf.format(new Date()));
			departdate=DateUtils.add(departdate, -days);					
		} catch (ParseException e) {
			play.Logger.error(e.getMessage(), e);
		}
		StringBuilder sql = new StringBuilder("select t.id,t.departdate,t.schedulecode,trim(t.departtime) as departtime,")
				 .append(" vt.name as vehicletype, s1.name as departstation,s2.name as reachstation,")
				 .append(" t.seatno,t.price,t.tickettype,t.ticketentrance, t.buspark,sp.remarks,")
				 .append(" sp.islinework,t.ticketstatus,t.ischecked,'异站' as sellbyname,t.selltime")
				 .append(" from RemoteTicketsell t,Schedulevehiclepeopleplan sv,")
				 .append(" Scheduleplan sp,Station s1,Station s2,Vehicletype vt")
				 .append(" where t.scheduleplanid = sp.id and t.scheduleplanid = sv.scheduleplan.id") 
				 .append(" and sv.orderno = 0 and sv.planvehicletypeid = vt.id and t.ticketstatus='0'") 
				 .append(" and t.departstationid = s1.id and t.reachstationid = s2.id")
				 .append(" and t.ticketno =:ticketno and t.departdate>=:departdate");
		Query query = em.createQuery(sql.toString());
		query.setParameter("ticketno", ticketno);
		query.setParameter("departdate", departdate);
		return query.getResultList();
	}

	// 查询已检的车票信息,检票明细界面
	@SuppressWarnings("unchecked")
	public List<Object> queryCheckedticket(
			List<PropertyFilter> propertyFilterList) {
		
//		StringBuilder sql = new StringBuilder("select decode(t.ischecked,1,0,1) as selected,t.id,t.ticketno,t.departdate,")
		StringBuilder sql = new StringBuilder("select decode(t.ischecked,1,0,1) as selected,t.id,case when (u1.code = '"+ConstDefiniens.HJ_USERINFO+"' and trp.id is null) then substr(t.ticketno,0,length(t.ticketno)-2) else t.ticketno end ticketno,t.departdate,")
				.append(" trim(t.departtime) as departtime,")
				.append(" s1.name as departstation,s2.name as reachstation,")
				.append(" t.seatno,t.price,t.tickettype,t.ischecked,u.code as usercode,t.carrychildnum,")
				.append(" t.ticketoutletsname,t.isdepartinvoices,d2.value as ticketstatus,to_char(t.selltime,'yyyy-mm-dd hh24:mi:ss') selltime ")
				.append(" ,t.customername as customername, ")
				.append(" trim(decode(t.isdepartinvoices ,1,'已打单','未打单')),")
				.append(" trim(decode(t.tickettype ,'Q','全票','半票'))")
				.append(" ,decode(t.ischecked, 1, '已检票', '未检') dticketstatus")
				.append(" from Ticketsell t")
				//#8763 取票后新票号重打之后，票号substr方法 会导致票号错误, 解决方案：新票号重打后取新票号不截取，未新票号重打截取后两位
				.append(" left join ticketreprint trp on trp.sellid = t.id and trp.newticketno = t.ticketno and trp.newticketno <> trp.oldticketno ")
				.append(" left join Userinfo u1 on t.sellby = u1.id ")
				.append(" left join Userinfo u on t.checkedby = u.id ")
				.append(" ,digitaldictionary d1,digitaldictionarydetail d2,")
				.append(" Scheduleplan sp,Station  s1,")
				.append(" Station s2,Schedule s")
				.append(" where t.scheduleid = s.id and t.scheduleplanid = sp.id")
				.append(" and t.departstationid = s1.id ")
				.append(" and t.reachstationid = s2.id ")
				.append(" and d1.id=d2.digitaldictionaryid and d1.tablename='ticketsell'") 
				.append(" and d1.columnname='ticketstatus' and t.ticketstatus=d2.code")
				.append(" and t.ticketstatus in ('0','4') ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
				sql.append(" ORDER BY t.ischecked ASC,t.seatno ASC ");
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		List<Object> list= query.getResultList();
//		 sql = new StringBuilder("select 0 as selected,t.id,t.ticketno,t.departdate,")
//		.append(" trim(t.departtime) as departtime,")
//		.append(" s1.name as departstation,s2.name as reachstation,")
//		.append(" t.seatno,t.price,t.tickettype,1 as ischecked,t.checkby as usercode,t.carrychildnum,")
//		.append(" t.ticketoutletsname as ticketoutletname,t.isdepartinvoices,d2.value  as ticketstatus,to_char(t.selltime,'yyyy-mm-dd hh24:mi:ss') selltime")
//		.append(" ,'' as customername from remoteticketsell t,digitaldictionary d1,digitaldictionarydetail d2,")
//		.append(" Scheduleplan sp,Station  s1,Station s2")
//		.append(" where t.scheduleplanid = sp.id")
//		.append(" and t.departstationid = s1.id ")
//		.append(" and d1.id=d2.digitaldictionaryid and d1.tablename='ticketsell'") 
//		.append(" and d1.columnname='ticketstatus' and t.ticketstatus=d2.code")
//		.append(" and t.reachstationid = s2.id ");
//    	sql.append(PropertyFilter.toJpql(propertyFilterList, true));
//		query = em.createNativeQuery(sql.toString());
//		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
//		list.addAll(query.getResultList());
		return list;
	}
	@SuppressWarnings("unchecked")
	public List<Ticketmixcheck> qryTicketmixchecks(long ticketsellid) {
		StringBuilder sql = new StringBuilder("select s from Ticketmixcheck s ")
				.append(" where s.ticketsellid=:ticketsellid and s.isactive=1 order by s.createtime");
		Query query = em.createQuery(sql.toString());
		query.setParameter("ticketsellid", ticketsellid);
		query.setLockMode(LockModeType.PESSIMISTIC_READ);
		return query.getResultList();

	}
	@SuppressWarnings("unchecked")
	public Scheduleseats getScheduleseats(long scheduleplanid, short seatno) {
		StringBuilder sql = new StringBuilder("select s from Scheduleseats s ")
				.append(" where s.scheduleplan.id=:scheduleplanid and s.seatno=:seatno");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("seatno", seatno);
		query.setLockMode(LockModeType.PESSIMISTIC_READ);
		List<Scheduleseats> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;

	}
	@SuppressWarnings("unchecked")
	public Scheduleseats getScheduleseats(long scheduleplanid) {
		//混检也可以检到留位座位上
		StringBuilder sql = new StringBuilder("select s from Scheduleseats s ")
				.append(" where s.scheduleplan.id=:scheduleplanid and s.status in ('0','4','5') order by s.status , s.seatno");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setLockMode(LockModeType.PESSIMISTIC_READ);
		List<Scheduleseats> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;

	}
	@SuppressWarnings("unchecked")
	public Scheduleseats getScheduleseat(long scheduleplanid) {
		//混检不可以检到留位座位上
		StringBuilder sql = new StringBuilder("select s from Scheduleseats s ")
				.append(" where s.scheduleplan.id=:scheduleplanid and s.status='0' order by  s.seatno");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setLockMode(LockModeType.PESSIMISTIC_READ);
		List<Scheduleseats> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;

	}
	@SuppressWarnings("unchecked")
	public long getCarrychildnum(long scheduleplanid) {
		StringBuilder sql = new StringBuilder(
				"select sum(carrychildnum) from Ticketsell s ")
				.append(" where s.scheduleplanid=:scheduleplanid and s.ticketstatus='0'");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		List<Object> list = query.getResultList();
		return  (list != null && list.size() > 0&&list.get(0)!=null ? new Long(list.get(0).toString()) : new Long(0));
	}
	@SuppressWarnings("unchecked")
	public long getCarrychildnum(long scheduleplanid,long reportid) {
		StringBuilder sql = new StringBuilder(
				"select sum(carrychildnum) from Ticketsell s ")
				.append(" where s.scheduleplanid=:scheduleplanid and s.ticketstatus='0'")
				.append(" and s.vehiclereportid=:reportid");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("reportid", reportid);		
		List<Object> list = query.getResultList();
		return  (list != null && list.size() > 0&&list.get(0)!=null ? new Long(list.get(0).toString()) : new Long(0));
	}
	
	
	@SuppressWarnings("unchecked")
	public short getMaxseatno(long scheduleplanid) {
		StringBuilder sql = new StringBuilder(
				"select max(seatno) from Ticketsell s ")
				.append(" where s.scheduleplanid=:scheduleplanid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		List<Object> list = query.getResultList();
		if (list != null && list.size() > 0 && list.get(0)!=null){
			Object  ob=list.get(0);
			return (Short)ob;
		}else
		 return  0;
	}
	//全检时获取车票信息并锁住
	@SuppressWarnings("unchecked")
	public List<Ticketsell> queryTickets(List<PropertyFilter> propertyFilterList,long scheduleplanid, boolean ischecked) {
		StringBuilder sql = new StringBuilder("select t from Ticketsell t ")
				.append(" where t.ticketstatus='0' and t.ischecked=:ischecked")
				.append(" and t.scheduleplanid=:scheduleplanid ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = em.createQuery(sql.toString());
		query.setLockMode(LockModeType.PESSIMISTIC_READ);	
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("ischecked", ischecked);
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	//查询已检的车票，用于整车退检
	@SuppressWarnings("unchecked")
	public List<Ticketsell> queryTickets(List<PropertyFilter> propertyFilterList,long scheduleplanid,long vehiclereportid, boolean ischecked) {
		StringBuilder sql = new StringBuilder("select t from Ticketsell t ")
				.append(" where t.ticketstatus='0' and t.ischecked=:ischecked")
				.append(" and t.scheduleplanid=:scheduleplanid and t.vehiclereport.id=:vehiclereportid");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("vehiclereportid", vehiclereportid);
		query.setParameter("ischecked", ischecked);
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	// 班次的已检车票数
	@SuppressWarnings("unchecked")
	public long getCheckedcount(long vehiclereportid,long scheduleplanid) {
		StringBuilder sql = new StringBuilder(
				"select count(t) from Ticketsell t ").append(
				" where t.ticketstatus='0' and t.ischecked=1").append(
				" and t.vehiclereport.id=:vehiclereportid and t.scheduleplanid=:scheduleplanid");
		sql.append(" and t.tickettype <> 'E' ");//排除儿童票
		Query query = em.createQuery(sql.toString());
		query.setParameter("vehiclereportid", vehiclereportid);
		query.setParameter("scheduleplanid", scheduleplanid);
		List<Object> list = query.getResultList();
		return (Long) (list != null && list.size() > 0 ? list.get(0) : 0);
	}

	// 查询车票对应的班次状态信息
	@SuppressWarnings("unchecked")
	public Schedulestatus getSchedulestatus(long scheduleplanid,
			long departstationid) {
		StringBuilder sql = new StringBuilder("select s from Schedulestatus s ")
				.append(" where s.scheduleplan.id=:scheduleplanid").append(
						" and s.departstationid=:departstationid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("departstationid", departstationid);
		List<Schedulestatus> list = query.getResultList();
		return (Schedulestatus) (list != null && list.size() > 0 ? list.get(0)
				: null);
	}

	// 查询车票信息，用于混检
	@SuppressWarnings("unchecked")
	public List<Object> queryTicket(long scheduleplanid, short seatno) {
		StringBuilder sql = new StringBuilder("select t")
				.append(" from Ticketmixcheck t")
				.append(" where t.oldscheduleplanid=:oldscheduleplanid")
				.append(" and t.oldseatno =:oldseatno");
		Query query = em.createQuery(sql.toString());
		query.setParameter("oldscheduleplanid", scheduleplanid);
		query.setParameter("oldseatno", seatno);
		List<Object> tlist = query.getResultList();
		sql = new StringBuilder(
				"select ts")
				.append(" from Ticketsell ts")
				.append(" where ts.scheduleplanid =:scheduleplanid and ts.seatno =:seatno")
				.append(" and ts.ischecked=0 and ts.ticketstatus='0' ");//过滤非正常票，排除退票后又售票，查询的还是第一个退票记录
		query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("seatno", seatno);
		List<Object> tickets = query.getResultList();
		
		if (tlist != null && tlist.size() > 0
			&& tickets==null	) {
			sql = new StringBuilder(
					"select t.ticketsellid, t.ticketno,sp.departdate,")
					.append(" s.code,trim(t.olddeparttime),s1.name as departstation,")
					.append(" s2.name as reachstation,t.oldseatno,ts.price,")
					.append(" ts.tickettype,ts.ticketentrance,ts.buspark,sp.remarks,")
					.append(" sp.islinework,ts.ischecked,ts.ticketstatus,t.oldscheduleplanid,u.name as sellbyname,ts.selltime")
					.append(" from Ticketsell ts,ticketmixcheck t,scheduleplan sp,")
					.append(" station s1,schedule s,station s2,Userinfo u")
					.append(" where t.oldscheduleplanid = sp.id and sp.startstationid = s1.id")
					.append(" and sp.endstationid = s2.id and sp.scheduleid = s.id and u.id=ts.sellby")
					.append(" and ts.id = t.ticketsellid and t.oldscheduleplanid =:oldscheduleplanid")
					.append(" and t.oldseatno =:oldseatno and ts.ticketstatus='0' order by t.createtime");
			query = em.createNativeQuery(sql.toString());
			query.setParameter("oldscheduleplanid", scheduleplanid);
			query.setParameter("oldseatno", seatno);
			return query.getResultList();

		} else {
			sql = new StringBuilder(
					"select t.id,t.ticketno, t.departdate,s.code,trim(t.departtime) as departtime,")
					.append(" s1.name as departstation,s2.name as reachstation,")
					.append(" t.seatno,t.price,t.tickettype,t.ticketentrance,")
					.append(" t.buspark,sp.remarks,sp.islinework,t.ischecked, t.ticketstatus,sp.id as oldscheduleplanid,u.name as sellbyname,t.selltime")
					.append(" from Ticketsell t,Schedulevehiclepeopleplan sv,")
					.append(" Scheduleplan sp,Station s1,Station s2,")
					.append(" Schedule s,Vehicletype vt,Userinfo u")
					.append(" where t.scheduleid = s.id and t.scheduleplanid = sp.id")
					.append(" and t.scheduleplanid = sv.scheduleplan.id and u.id=t.sellby")
					.append(" and sv.orderno = 0 and sv.planvehicletypeid = vt.id")
					.append(" and t.departstationid = s1.id and t.reachstationid = s2.id")
					.append(" and t.scheduleplanid=:scheduleplanid ")
					.append(" and t.seatno =:seatno and t.ticketstatus='0' ");
			query = em.createQuery(sql.toString());
			query.setParameter("scheduleplanid", scheduleplanid);
			query.setParameter("seatno", seatno);
			return query.getResultList();
		}
	}
	// 根据营运计划ID以及座位号的车票
	@SuppressWarnings("unchecked")
	public Ticketsell getTicket(long scheduleplanid, short seatno) {
		StringBuilder sql = new StringBuilder("select t from Ticketsell t")
				.append(" where  t.ticketstatus='0'  and t.seatno=:seatno")
				.append(" and t.scheduleplanid=:scheduleplanid");
		Query query = em.createQuery(sql.toString());
		query.setLockMode(LockModeType.PESSIMISTIC_READ);			
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("seatno", seatno);
		List<Ticketsell> tickets = query.getResultList();
		return tickets != null && tickets.size() > 0 ? tickets.get(0) : null;
	}
	// 查询车票提示信息
	@SuppressWarnings("unchecked")
	public String qryTicketHint(long ticketsellid) {
		StringBuilder sql = new StringBuilder("select ")
				.append(" concat(concat(concat(concat(concat(concat(concat(concat(s.name,t.seatno),'号座由'),tt.name),u.name),':'),'于'),to_char(t.selltime,'yyyy-mm-dd hh24:mi:ss')),'售出') as hint")
				.append(" from Ticketsell t ,")
				.append(" Ticketoutlets tt,Userinfo u,Station s")
				.append(" where t.id=:ticketsellid")
				.append(" and t.sellby = u.id and t.ticketoutletsid = tt.id")
				.append(" and t.reachstationid=s.id");
		Query query = em.createQuery(sql.toString());		
		query.setParameter("ticketsellid", ticketsellid);
		List<Object> hints = query.getResultList();
		return hints != null && hints.size() > 0 ? hints.get(0).toString() :"";
	}
	
	// 根据营运计划ID以及座位号的车票
	@SuppressWarnings("unchecked")
	public String queryMixInfo(long ticketid) {
		String mixinfo="没有该车票的检票信息！";
		StringBuilder sql = new StringBuilder("select ts")
		.append(" from Ticketsell ts")
		.append(" where ts.id=:id and ts.ischecked=1");
		Query query = em.createQuery(sql.toString());
		query.setParameter("id", ticketid);
		List<Ticketsell> tickets = query.getResultList();
		if(tickets!=null&&tickets.size()>0){
			Ticketsell ts=tickets.get(0);
			Schedule schedule=(Schedule) this.get(Schedule.class,ts.getScheduleid());
			if(ts.getVehiclereport()!=null){
				Vehicle vehicle=(Vehicle) this.get(Vehicle.class, ts.getVehiclereport().getVehicleid());
				SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
				String departdate=sf.format(ts.getDepartdate());
				mixinfo="该车票已经检到:"+departdate+"的"+schedule.getCode()+"班次," +vehicle.getVehicleno()+"车的"+ts.getSeatno() +"座位上";
			}else{
				mixinfo="该班次还未报到！";
			}
			
		}
		return mixinfo;
	}
	
	@SuppressWarnings("unchecked")
	public List<Pcticketentrance> qryPcticketentrance(String ip,String ticketentrance) {
		StringBuilder sql = new StringBuilder("select pc")
				.append(" from Pcticketentrance pc,Ticketentrance t")
				.append(" where pc.ticketentranceid=t.id ")
				.append(" and pc.ip=:ip and t.name=:ticketentrance");
		Query query = em.createQuery(sql.toString());
		query.setParameter("ip", ip);
		query.setParameter("ticketentrance", ticketentrance);
		return query.getResultList();
	}	
		
	// 检票界面双击班次获取 到站和票数信息
	@SuppressWarnings("unchecked")
	public List<Object> sumTickets(long scheduleplanid ) {
		StringBuilder sql = new StringBuilder(
				"select ds.name startstationname,s.name as reachstationname,count(t.id) as ticketnum")
		.append(" from Ticketsell t,Station s, Station ds ")
		.append(" where t.reachstationid=s.id and t.ticketstatus='0'")
		.append(" and t.scheduleplanid=:scheduleplanid and t.departstationid = ds.id")
		//.append(" and t.scheduleid= :scheduleid")
		.append(" group by ds.name, s.name ");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		//query.setParameter("scheduleid", scheduleid);
		return query.getResultList();
	}
	
	// 报班是否开检
	@SuppressWarnings("unchecked")
	public List<Schedulestatus> findScheduleIsChecked(String cardno,Date departdate){
//		StringBuilder sql = new StringBuilder(" select ss.isreported, ss.isbegincheck, ss.isdeparted from schedulestatus ss, schedule s")
		StringBuilder sql = new StringBuilder(" select ss.id,ss.scheduleplanid,ss.orgid,ss.departdate,ss.scheduleid,ss.departstationid,ss.departtime,ss.ticketentrance,ss.buspark,ss.isreported,ss.isbegincheck, ss.isdeparted,ss.status,ss.createtime,ss.createby,ss.updatetime,ss.updateby,ss.isemptyvehicle,ss.synccode from Schedulestatus ss, schedule s")
		.append(" where ss.scheduleid = s.id and ss.scheduleplanid in (select vr.scheduleplanid")
		.append(" from vehiclereport vr where vr.vehicleid = (select v.id from vehicle v where v.cardno = '").append(cardno).append("') ")
		.append(" and vr.departdate = :departdate  and vr.isactive=1)");
		
		Query query = em.createNativeQuery(sql.toString(),Schedulestatus.class);
		query.setParameter("departdate", departdate);
		return query.getResultList();
		
	}
	// 刷卡开检
	@SuppressWarnings("unchecked")
	public int updateScheduleStatus(String cardno,Date departdate){
		StringBuilder sql = new StringBuilder(" update  schedulestatus ss set ss.isbegincheck=1 ")
		.append(" where  ss.scheduleplanid in (select vr.scheduleplanid from vehiclereport vr ")
		.append("  where vr.vehicleid =(select v.id from vehicle v where v.cardno = '").append(cardno).append("') ")
		.append(" and vr.departdate = :departdate )");
		
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("departdate", departdate);
		
		if(query.executeUpdate()>0){
			return 1;
		}else{
			return 0;
		}
		
	}

	public String checkticketno(String ticketno,String certificateno,Date departdate) {
		StringBuffer sql=new StringBuffer();
		sql.append("select t.scheduleplanid from ticketsell t  ");
		if(!"".equals(certificateno)&&certificateno!=null){
			sql.append(" left join customer c on t.customerid=c.id ");
		}
		sql.append(" where t.ticketno =:ticketno and t.departdate>= trunc(:departdate) and t.ticketstatus = '0' ");
		if(!"".equals(certificateno)&&certificateno!=null){
			sql.append(" and c.certificateno=:certificateno ");
		}
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("ticketno", ticketno);
		query.setParameter("departdate", departdate);		
		if(!"".equals(certificateno)&&certificateno!=null){
			query.setParameter("certificateno", certificateno);
		}
		List list=query.getResultList();
		if((list==null||list.size()<=0)){
			query = em.createNativeQuery(sql.toString());
			Billtype bt = billtypeService.findByCode("Ticket");
			String cuticketno = ticketno;
			if (ticketno.length() > bt.getTicketnolength()) {
				int pos = (int) (ticketno.length() - bt.getTicketnolength());
				cuticketno = ticketno.substring(pos, ticketno.length());
			} else if (ticketno.length() < bt.getTicketnolength()) {
				cuticketno = StringUtils.strPad(ticketno,
						(int) bt.getTicketnolength(), "0");
			}
			query.setParameter("departdate", departdate);
			query.setParameter("ticketno", cuticketno);
			list=query.getResultList();
			if((list==null||list.size()<=0)){
				query = em.createNativeQuery(sql.toString());
				query.setParameter("departdate", departdate);
				query.setParameter("ticketno", cuticketno+"01");
				list=query.getResultList();
				if(list==null||list.size()<=0){
					sql=new StringBuffer();
					sql.append("select t.scheduleplanid from ticketsell t  ");
					sql.append(" where t.eticketno =:ticketno and t.departdate>= trunc(:departdate) and t.ticketstatus = '0' ");
					 query = em.createNativeQuery(sql.toString());
					query.setParameter("ticketno", ticketno);
					query.setParameter("departdate", departdate);		
					list=query.getResultList();
				}
			}
		}
		
		String id=null;
		if(list.size()>0 && list!=null){
			id=list.get(0).toString();
		}
		return id;
	}
	

	public List<Object> qrySeatstatusdetail(List<PropertyFilter> propertyFilterList) {
		List<Object> list = null;
		StringBuilder sql = null;
		 sql = new StringBuilder(
		"select ss.seatno as seatno,")
		.append("  coalesce(tol.name,tols.name) as orgname,")
		.append(" concat(coalesce(st.name,st1.name),decode(t.tickettype,'Q','(全)','B','(半)','S','(学)','Z','(折)') )as tostationname,")
		.append(" case  when ss.status = '2'  then trim('已售') when ss.status = '7'  then trim('已检') when ss.status = '8'  then trim('已运') when ss.status in(3,4,5) then trim('留位') when ss.status in(0) then trim('空位') end as status ,")
		.append(" case when (u.code = '"+ConstDefiniens.HJ_USERINFO+"' and trp.id is null) then substr(t.ticketno,0,length(t.ticketno)-2) else t.ticketno end ticketno ,d.value sellway ")
		.append(" from scheduleseats ss ")
		.append(" left join seatreserve s  on ss.seatno=s.seatno and ss.scheduleplanid=s.scheduleplanid AND S.Sellstate='R' ")
		.append(" left join station st on s.reachstationid=st.id ")
		.append(" left join ticketoutlets tol on s.ticketoutletsid=tol.id ")
		.append(" left join ticketsell t on ss.seatno=t.seatno and ss.scheduleplanid=t.scheduleplanid and t.ticketstatus = '0' ")
		.append(" left join digitaldictionarydetail d on t.sellway = d.code and d.digitaldictionaryid = 51 ")
		.append(" left join station st1 on t.reachstationid=st1.id ")
		.append(" left join ticketoutlets tols on t.ticketoutletsid=tols.id ")
		.append(" left join schedule sc on ss.scheduleid=sc.id ")
//		#8763 取票后新票号重打之后，票号substr方法 会导致票号错误
		.append(" left join ticketreprint trp on trp.sellid = t.id and trp.newticketno = t.ticketno and trp.newticketno <> trp.oldticketno ")
		.append(" left join userinfo u on t.sellby = u.id  where 1=1 ");
		
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" ORDER BY ss.seatno ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		 list = query.getResultList();	
		return list;
	}

	public boolean deleteseate(long id, Object netcountSeats) {
		StringBuilder sql = new StringBuilder();
		sql.append(" DELETE from scheduleseats a where a.scheduleplanid=:scheduleplanid  and  a.seatno = :seatno");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("scheduleplanid", id);
		query.setParameter("seatno", netcountSeats);
		query.executeUpdate();
		return true;
	}
	
	@SuppressWarnings("unchecked")
	  public Ticketsell getTicketByDepartstationids(List<PropertyFilter> propertyFilterList,String ticketno,Date departdate) {
		StringBuilder sql = new StringBuilder(
		"select  t from Ticketsell t where t.ticketno=:ticketno")
		.append(" and t.departdate>=:departdate ");
	    sql.append(PropertyFilter.toJpql(propertyFilterList, true));
	    sql.append(" order by t.departdate desc");
	    Query query = em.createQuery(sql.toString());
	    query.setLockMode(LockModeType.PESSIMISTIC_READ);		
		query.setParameter("ticketno", ticketno);
		query.setParameter("departdate", departdate);
	    JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
	    List<Ticketsell> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	  }
	
	//根据身份证查询车票信息
	public List<Object> qryTicketinfoByIDcard(List<PropertyFilter> propertyFilterList) {
		
		List<Object> list = null;
		StringBuilder sql = new StringBuilder("select ts.id,ts.ticketno from ticketsell ts,customer c ")
		.append(" where ts.customerid=c.id and ts.ticketstatus='0' ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		list = query.getResultList();	
		return list;
		
	}

	public List<Object> qryReportdriver(
			List<PropertyFilter> buildFromHttpRequest, long orgid) {
		// TODO Auto-generated method st
		List<Object> list = null;
		StringBuilder sql = new StringBuilder("  select d.id,rownum code,d.name drivername,d.drivinglicense ")
				.append(" from driver d ")
    .append(" left join vehiclereport vr on vr.driver1id = d.id ")
    .append(" or vr.driver2id = d.id ")
                               .append(" or vr.driver3id = d.id ")
                               .append(" or vr.driver4id = d.id ")
                               .append(" where vr.isactive=1 and vr.orgid=:orgid");
		sql.append(PropertyFilter.toJpql(buildFromHttpRequest, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("orgid", orgid);
		JPAPropertyFilterUtil.setParameter(query, buildFromHttpRequest);
		list = query.getResultList();	
		return list;
	}

	public boolean queryschedulestartcheck(
			ScheduleStartCheck schedulestartcheck, long orgid) {
		// TODO Auto-generated method stub
		boolean flag = false;
		List<Object> list = null;
		StringBuilder sql = new StringBuilder(" select s.id from ScheduleStartCheck s where s.orgid=:orgid and ")
		.append(" s.vehicleid=:vehicleid and s.scheduleid=:scheduleid and s.departdate=trunc(:departdate)");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("vehicleid", schedulestartcheck.getVehicleid());
		query.setParameter("scheduleid", schedulestartcheck.getScheduleid());
		query.setParameter("departdate",schedulestartcheck.getDepartdate());
		query.setParameter("orgid", orgid);
		list = query.getResultList();
		if (list!=null &&list.size()>0){
			flag=true;
		}
		return flag;
	}

	public String getvehiclenobycardno(String cardno) {
		StringBuilder sql = new StringBuilder("select v.vehicleno from Vehicle v where v.cardno = :cardno ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("cardno", cardno);
		List resultList = query.getResultList();
		return (String) (resultList != null || resultList.size() > 0 ? resultList.get(0) : "");
	}
	
	// 获取主票所在班次的团体票
	public List<Ticketsell> getTuanTickets(String ticketno, Date departdate, boolean ischecked, long scheduleplanid) {
		StringBuilder sql = new StringBuilder(
				"select  t from Ticketsell t,Scheduleplan sp where t.scheduleplanid = sp.id and t.ticketno like :ticketno and t.tickettype='T'")
				.append(" and t.departdate>=:departdate and t.ticketstatus = '0' and t.ischecked = :ischecked and sp.id = :scheduleplanid ");
		Query query = em.createQuery(sql.toString());
		query.setLockMode(LockModeType.PESSIMISTIC_READ);	
		Billtype billtype = billtypeService.findByCode("Ticket");
		//如果是团体票的子号，则取母号 ---- 用于点击检团体票时，子号退检后，母号不能退检，如有影响其他方法，可以隐藏
		if((billtype.getTicketnolength()+1)==ticketno.length()){//小于十人情况的团体票票号处理
			ticketno=ticketno.substring(0, ticketno.length()-1);
		}else if((billtype.getTicketnolength()+2)==ticketno.length()){//大于10人小于100人团体票
			ticketno=ticketno.substring(0, ticketno.length()-2);
		}
		query.setParameter("ticketno",ticketno+"%");
		query.setParameter("departdate", departdate);
		query.setParameter("ischecked", ischecked);
		query.setParameter("scheduleplanid", scheduleplanid);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public Scheduleseats getScheduleseatEmpAndRes(long scheduleplanid, String lastno) {
		//混检也可以检到留位座位上
		String lastnostr = "0".equals(lastno)?"":" and s.seatno > '"+lastno+"' ";
		StringBuilder sql = new StringBuilder("select s from Scheduleseats s ")
				.append(" where s.scheduleplan.id=:scheduleplanid and s.status in ('0','4','5') "+lastnostr+" order by s.status , s.seatno");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setLockMode(LockModeType.PESSIMISTIC_READ);
		List<Scheduleseats> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;

	}
	@SuppressWarnings("unchecked")
	public Scheduleseats getScheduleseat(long scheduleplanid, String lastno) {
		//混检不可以检到留位座位上
		String lastnostr = "0".equals(lastno)?"":" and s.seatno > '"+lastno+"' ";
		StringBuilder sql = new StringBuilder("select s from Scheduleseats s ")
				.append(" where s.scheduleplan.id=:scheduleplanid and s.status = '0' "+lastnostr+" order by  s.seatno");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setLockMode(LockModeType.PESSIMISTIC_READ);
		List<Scheduleseats> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;

	}
	
	// 获取指定座位
	public Scheduleseats getScheduleseats(long scheduleplanid, short seatno, Date departdate) {
		StringBuilder sql = new StringBuilder("select s from Scheduleseats s ")
				.append(" where s.scheduleplan.id=:scheduleplanid and s.seatno=:seatno")
				.append(" and s.departdate=:departdate");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("seatno", seatno);
		query.setParameter("departdate", departdate);
		query.setLockMode(LockModeType.PESSIMISTIC_READ);
		List<Scheduleseats> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;

	}
	
	//查询座位预留信息
	public Seatreserve getSeatreserve(long scheduleplanid, short newseatno) {
		StringBuilder sql = new StringBuilder("select s from Seatreserve s ")
				.append(" where s.scheduleplanid=:scheduleplanid and s.seatno=:newseatno and s.sellstate = 'R' ");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("newseatno", newseatno);
		query.setLockMode(LockModeType.PESSIMISTIC_READ);
		List<Seatreserve> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}
}
