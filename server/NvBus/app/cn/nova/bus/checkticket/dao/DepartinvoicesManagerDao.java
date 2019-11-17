package cn.nova.bus.checkticket.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.balance.model.Vehicleviolation;
import cn.nova.bus.base.model.Ticketoutlets;
import cn.nova.bus.checkticket.model.Departinvoices;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;
import util.CommonUtil;

@SuppressWarnings("rawtypes")
public class DepartinvoicesManagerDao extends EntityManagerDaoSurport {

////查询结算单信息 
	public List<Object> qryReportSchs(Date departdate,
			long vehicleid, long orgid) {
		StringBuilder sql = new StringBuilder(
				"select s.code,decode(s.islinework,1,to_char(vr.reporttime, 'hh24:mi'),")
		.append(" ss.departtime) departtime,vr.id,ss.scheduleplanid")
		.append(" from vehiclereport vr, schedule s, schedulestatus ss, organization org")
		.append(" where vr.scheduleplanid = ss.scheduleplanid and vr.scheduleid = s.id")
		.append(" and vr.reportorgid = org.id  and vr.isactive = 1")
		.append(" and org.stationid = ss.departstationid ")
		.append(" and org.id=:orgid and vr.vehicleid =:vehicleid and vr.departdate =:departdate")
		.append(" order by decode(s.islinework,1,to_char(vr.reporttime, 'hh24:mi'),ss.departtime)");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("vehicleid", vehicleid);
		query.setParameter("orgid", orgid);
		return query.getResultList();
	}
////查询结算单信息 
	public List<Object> qryDepartinvoices(Date departdate,
			long vehicleid, long printorgid,Date departdateend) {
		StringBuilder sql = new StringBuilder(
				"select d.scheduleplanid,d.reportid,d.departdate,r.name,s.code,")
		.append(" trim(decode(s.islinework,1,d.departtime,ss.departtime)) departtime,")
		.append(" v.vehicleno,d.departinvoicesno,t.tickets,d.ticketnum,d.balanceamount,")
		.append(" d.reportid , d.scheduleplanid , st.name stationname,")
		.append(" case d.status when '0' then '正常' when '1' then '注销' else '已结算' end ")
		.append(" from departinvoices d  ")
		.append("left join  vehiclereport vp on d.reportid = vp.id  left join schedulevehiclepeopleplan svp on ")
        .append(" svp.scheduleplanid = vp.scheduleplanid and svp.departdate = vp.departdate  and vp.orderno = svp.orderno, ")
		.append( " schedule s,route r,schedulestatus ss, ")
		.append(" vehicle v,(select t.vehiclereportid, count(t.id) tickets from ticketsell t")
		.append("  where t.ischecked = 1 and t.departdate >=:departdate")
		.append(" and t.departdate <=:departdateend")
		.append("  and t.ticketstatus = '0' group by t.vehiclereportid) t")
		.append("	,station st, organization o where d.scheduleid = s.id and d.vehicleid = v.id")
		.append("  and d.reportid = t.vehiclereportid  and d.scheduleplanid = ss.scheduleplanid")
		.append("  and d.printorgid = ss.orgid  and s.routeid = r.id and st.id = r.endstationid")
		.append("  and v.id =:vehicleid  and d.departdate >=:departdate and  d.departdate <=:departdateend and d.printorgid=:printorgid")
		.append(" and d.status <> 1")	//排除注销的结算单  0正常  1注销  2已结算  3待结算
		.append(" and ss.departstationid = o.stationid  and o.id=d.printorgid ") //schedulestatus关联organization,对应上车站打单
		.append(" order by d.departdate desc ");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("departdateend", departdateend);
		query.setParameter("vehicleid", vehicleid);
		query.setParameter("printorgid", printorgid);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
//		StringBuilder sql = new StringBuilder(
//				"select t, sc.code as schedulename, st.name as departstationname, dic.value as statusname, ")
//				.append(" v.vehicleno as vehiclename, ve.vehicleno as reportname, o.name as orgname, ")
//				.append(" u.name as printname, us.name as balancename, use.name as createname, ui.name as updatename, ")
//				.append(" bs.name as balancestationname, ca.name as cancelname, cs.name as cancelstationname, ")
//				.append(" sc.route.name as routename, son.name as endstationname,sp.seatnum,unit.name as unitname, ")
//				.append(" (t.packbalanceprice+t.balanceamount) as totalbalancemoney ,bt.name as balanceunitname")
//				.append(" from Departinvoices t left join t.balanceby us left join t.balance ba left join ")
//				.append(" t.balancestation bs left join t.cancel ca left join t.cancelstation cs left join t.balanceunit bt, Scheduleplan sp, ")
//				.append(" Schedule sc, Station st, Vehicle v, Vehiclereport vr, Organization o, Userinfo u,Unit unit, ")
//				.append(" Userinfo use, Userinfo ui, Vehicle ve, Digitaldictionary dig, Digitaldictionarydetail dic, ")
//				.append(" Station son where t.scheduleplanid=sp.id and t.scheduleid=sc.id and t.departstationid=st.id and ")
//				.append(" t.vehicleid=v.id and t.reportid=vr.id and vr.vehicleid=ve.id and t.printorgid=o.id and ")
//				.append(" t.printby=u.id and t.createby=use.id and t.updateby=ui.id and dig.tablename='departinvoices'")
//				.append(" and dig.columnname='status' and dic.digitaldictionary.id=dig.id and dic.code=t.status")
//				.append(" and sp.endstationid=son.id and v.unitid=unit.id");
		StringBuilder sql = new StringBuilder();
		sql.append("select t.id,t.departinvoicesno, t.scheduleplanid,  t.departdate,  t.scheduleid,")
		.append("t.departtime, t.departstationid,   t.vehicleid ,  t.reportid,    t.ticketnum,")
		.append("t.totalamount, t.stationservicefee,  t.fueladditionfee,  t.othterfee ,t.agentfee,")
		.append("t.balanceamount, t.printorgid, t.printip , t.printby, t.printtime,")
		.append("t.cancelstationid,  t.cancelby,  t.canceltime, t.status, t.balanceid, ")
		.append("t.balancestationid,   t.balanceby,   t.balancedate,  t.supplyticketnum,   t.supplyamount ,")
		.append("t.supplybalanceamount, t.createtime,   t.createby,  t.updatetime, t.updateby, ")
		.append("t.printway,  t.balanceunitid,    t.moreprice,   t.iscomputeno, t.isreplace,")
		.append("t.driver1id, t.driver2id, t.steward1id, t.ticketoutletsid, t.seller,   ")
		.append("t.packes, t.packbalanceprice, t.departinvoicesid,")
		.append("   sc.code as schedulename,  ")
		.append("   st.name as departstationname, ")
		.append("   dic.value as statusname,  ")
		.append("   v.vehicleno as vehiclename,   ")
		.append("   ve.vehicleno as reportname,   ")
		.append("   o.name as orgname,    ")
		.append("   u.name as printname,      ")
		.append("   us.name as balancename,   ")
		.append("   use.name as createname,   ")
		.append("   ui.name as updatename,    ")
		.append("   bs.name as balancestationname,    ")
		.append("   ca.name as cancelname,    ")
		.append("   cs.name as cancelstationname, ")
		.append("   r.name as routename,    ")
		.append("   son.name as endstationname,   ")
		.append("   sp.seatnum,       ")
		.append("   unit.name as unitname,    ")
		.append("   (t.packbalanceprice + t.balanceamount) as totalbalancemoney,    ")
		.append("   bt.name as balanceunitname ,trim(t.departtime) as departtimes,   ")
		.append("   ba.BALANCENO, t.totalamount - t.stationservicefee as checkmoney, ")
		.append("  t.nopaperticketnum as nopaperticketnum , t.paperticketnum as paperticketnum ,t.ticketnum-t.paperticketnum - t.nopaperticketnum as handtickets,t.isapproved as isapproved")
		.append("  from Departinvoices t      ")
		.append("  left join userinfo us on t.balanceby = us.id         ")
		.append("  left join balance ba on t.balanceid = ba.id          ")
		.append("  left join Station bs on t.balancestationid = bs.id       ")
		.append("  left join userinfo ca on t.cancelby = ca.id          ")
		.append("  left join station cs on t.cancelstationid = cs.id        ")
		.append("  left join unit bt on t.balanceunitid = bt.id, Scheduleplan sp, Schedule sc   ")
		.append("  left join route r on sc.routeid = r.id, Station st, Vehicle v,   ")
		.append(" Vehiclereport vr, Organization o, Userinfo u, Unit unit,      ")
		.append(" Userinfo use, Userinfo ui, Vehicle ve,  ")
		.append(" Digitaldictionary dig, Digitaldictionarydetail dic,       ")
		.append(" Station son,Ticketoutlets tol      ")
		.append(" where t.scheduleplanid = sp.id  ")
		.append("   and t.scheduleid = sc.id      ")
		.append("   and t.departstationid = st.id     ")
		.append("   and t.vehicleid = v.id    ")
		.append("   and t.reportid = vr.id    ")
		.append("   and vr.vehicleid = ve.id      ")
		.append("   and t.printorgid = o.id   ")
		.append("   and t.printby = u.id      ")
		.append("   and t.createby = use.id   ")
		.append("   and t.updateby = ui.id    ")
		.append("   and dig.tablename = 'departinvoices'  ")
		.append("   and dig.columnname = 'status'     ")
		.append("   and dic.digitaldictionaryid = dig.id  ")
		.append("   and dic.code = t.status   ")
		.append("   and sp.endstationid = son.id  ")
		.append("   and v.unitid = unit.id    ")
		.append("   and tol.id = t.ticketoutletsid ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	

	@SuppressWarnings("unchecked")
	public List<Object> queryResult(String isDepartinvoices,
			Long scheduleplanid, Long departinvoicesid, long vehiclereportid) {		
		StringBuilder sql = new StringBuilder("select use.name as checkedname,")
		.append(" s.departdate,trim(ss.departtime),s.seatnum,s.soldeatnum,t.ticketentrance,")
		.append(" t.buspark,")
		.append(" (select count(ti.id) from Ticketsell ti")
		.append("  where ti.scheduleplanid = s.id and ti.ischecked = '1'")
		.append(" and ti.vehiclereportid = vr.id and ti.ticketstatus not in ('1', '2')")
		.append(" and ti.isdepartinvoices = 1) +")
		.append(" (select count(ti.id) from RemoteTicketsell ti where ti.scheduleplanid = s.id")
	    .append("       and ti.ischecked = 1 and ti.vehiclereportid = vr.id")
	    .append("       and ti.ticketstatus = '0' and ti.isdepartinvoices = 1) as yeschecked,")
		.append(" (select count(ti.id)")
		.append("     from Ticketsell ti where ti.scheduleplanid = s.id")
		.append("       and ti.ischecked =1 and ti.vehiclereportid = vr.id")
		.append("       and ti.ticketstatus not in ('1', '2')  and ti.isdepartinvoices = '0') +")
	    .append(" (select count(ti.id) from RemoteTicketsell ti where ti.scheduleplanid = s.id")
	    .append("       and ti.ischecked = 1 and ti.vehiclereportid = vr.id")
	    .append("       and ti.ticketstatus = '0' and ti.isdepartinvoices = 0) as nochecked,")
	    .append("  sc.code,st.name as startname,sn.name as endname,vt.name as typename,")
	    .append("  d1.name as d1name, d2.name as d2name,d3.name as d3name,")
	    .append("  d4.name as d4name,s1.name as s1name,s2.name as s2name,")
	    .append("  v.vehicleno,vbm.brandname as brandname,u.name as unitname,")
	    .append(" r.name as routename,r.distance as distance,un.name as balanceunitname")
	    .append("   from Ticketsell        t,Scheduleplan      s,Schedulestatus    ss,")
	    .append("        Organization      org,Schedule          sc,Route r,")
	    .append("        Station           st,Station           sn,Vehicle           v,")
	    .append("       Vehiclebrandmodel vbm,Unit              un,Userinfo          use,")
	    .append("        Vehicletype       vt, Unit              u,Vehiclereport     vr")
	    .append("   left join driver d1 on vr.driver1id = d1.id left join driver d2 on vr.driver2id = d2.id")
	    .append("   left join driver d3 on vr.driver3id = d3.id left join driver d4 on vr.driver4id = d4.id")
	    .append("   left join steward s1 on vr.steward1id = s1.id left join steward s2 on vr.steward1id = s2.id")
	    .append("  where t.scheduleplanid = s.id  and t.vehiclereportid = vr.id")
	    .append("    and s.id = ss.scheduleplanid  and sc.routeid = r.id")
	    .append("    and (ss.departstationid = org.stationid or ((sc.worktype = '2' or sc.worktype = '3') and")
	    .append("     r.startstationid = ss.departstationid and s.orgid = org.id))")
	    .append("    and org.id = vr.reportorgid and v.id = vr.vehicleid")
	    .append("    and s.scheduleid = sc.id and ss.departstationid = st.id")
	    .append("    and s.endstationid = sn.id  and vt.id = v.vehicletypeid")
	    .append("    and v.unitid = u.id  and v.vehiclebrandmodelid = vbm.id")
	    .append("    and v.balanceunitid = un.id  and (select tl.checkedby")
	    .append("          from Ticketsell tl   where tl.id = (select min(ts.id)")
	    .append("             from Ticketsell ts   where ts.ischecked = '1'")
	    .append("               and ts.scheduleplanid =:scheduleplanid      and ts.vehiclereportid = vr.id)) = use.id")
	    .append("    and t.id = (select min(ts.id)  from Ticketsell ts")
	    .append("           where ts.ischecked = '1'   and ts.scheduleplanid =:scheduleplanid")
	    .append("             and ts.vehiclereportid = vr.id) and vr.id =:vehiclereportid");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("vehiclereportid", vehiclereportid);
		return query.getResultList();
	}

	public boolean isDepartinvoices(long scheduleplanid) {
		StringBuffer sql = new StringBuffer("select d from Departinvoices d");
		sql.append(" where d.status='2' and d.scheduleplanid=:scheduleplanid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		if (query.getResultList().size() > 0) {
			return true;
		}
		return false;
	}

	// 查询结算单信息
	@SuppressWarnings("unchecked")
	public List<Departinvoices> qryDepartinvoices(long scheduleplanid,
			long reportid) {
		StringBuilder sql = new StringBuilder("select t from Departinvoices t")
				.append(" where t.reportid=:reportid and t.scheduleplanid=:scheduleplanid")
				.append(" and t.status!='1'");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("reportid", reportid);
		return query.getResultList();
	}

	// 更新已开结算单的车票信息
	public int updateDepartTickets(long departinvoicesid) {
		StringBuilder sql = new StringBuilder("update Ticketsell t")
				.append(" set t.departinvoicesid=null,t.departinvoicesby=null,")
				.append(" t.departinvoicestime=null,t.isdepartinvoices=0")
				.append(" where t.departinvoicesid=:departinvoicesid")
				.append(" and t.ticketstatus='0'");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("departinvoicesid", departinvoicesid);
		return query.executeUpdate();
	}
	// 更新已开结算单的远检车票信息
	public int updateDepartRemoteTickets(long departinvoicesid) {
		StringBuilder sql = new StringBuilder("update RemoteTicketsell t")
				.append(" set t.departinvoicesid=null,t.departinvoicesby=null,")
				.append(" t.departinvoicestime=null,t.isdepartinvoices=0")
				.append(" where t.departinvoicesid=:departinvoicesid")
				.append(" and t.ticketstatus='0'");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("departinvoicesid", departinvoicesid);
		return query.executeUpdate();
	}
	@SuppressWarnings("unchecked")
	public boolean isOtherDeprartinvoices(Date departdate,long scheduleplanid,long invoicesid){
		StringBuffer sql = new StringBuffer("select d from Departinvoices d ");
		sql.append(" where d.scheduleplanid=:scheduleplanid")
		.append(" and d.departdate=:departdate and d.id!=:invoicesid and d.status<>'1'");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("invoicesid", invoicesid);		
		List<Object> list =query.getResultList();
		return list.size()>0&&list.get(0)!=null?true:false;
	}
	
	// 未检的车票
	public List<Object> qryunchecktickets(Date departdate,long vehicleid,String batchno,String ticketno,String schedulecode,String departtime) {
		if (CommonUtil.isNotEmptyString(schedulecode)) {
			StringBuilder sql = new StringBuilder(
					"select 0 as isselect, t.id,t.departdate,trim(t.departtime),sc.code,s.name as stationname,")
			.append(" t.ticketno,t.seatno,v.vehicleno,t.price,t.selltime, u.name sellbyname,vp.id  as reportid,vp.scheduleplanid, ")
			.append(" r.name as routename,tlo.id as sellotherid,tlo.istaked ")
			.append(" from Ticketsell    t")
			.append(" left join Ticketsellother tlo on tlo.ticketsellid = t.id ")
			.append(" ,Station       s,Scheduleplan  sp,")
			.append(" Vehiclereport vp,Schedule  sc,vehicle  v,userinfo u,route r")
			.append(" where t.reachstationid = s.id and t.ticketstatus = '0' and sp.scheduleid=sc.id")
			.append(" and vp.vehicleid =:vehicleid and sp.id = vp.scheduleplanid and vp.vehicleid=v.id")
			.append(" and vp.isactive = 1 and t.scheduleplanid = sp.id and t.sellby=u.id")
			.append(" and sp.departdate =:departdate ")//and t.vehiclereportid=vp.id  不能加这个条件，手持机售出后有可能换车报班了
			.append(" and t.isdepartinvoices = 0 and t.departdate=:departdate")
			.append(" and sc.routeid=r.id and t.sellway='13' ");  //只查询手持机售票
			//addby dongy 1852 十堰中心站+补开结算单 1.添加查询条件 票号，2.增加查询列座位号  3.班次号根据时间和班次号分组进行查询
			if (CommonUtil.isNotEmptyString(schedulecode)) {
				sql.append(" and sc.code =:schedulecode ");
			}
			if (CommonUtil.isNotEmptyString(ticketno)) {
				sql.append(" and t.ticketno =:ticketno ");
			}
			if (CommonUtil.isNotEmptyString(departtime)) {
				sql.append(" and sc.starttime =:departtime ");
			}
			Query query = em.createNativeQuery(sql.toString());
			query.setParameter("departdate", departdate);
			query.setParameter("vehicleid", vehicleid);
			if (CommonUtil.isNotEmptyString(schedulecode)) {
				query.setParameter("schedulecode", schedulecode);
			}
			if (CommonUtil.isNotEmptyString(ticketno)) {
				query.setParameter("ticketno", ticketno);
			}
			if (CommonUtil.isNotEmptyString(departtime)) {
				query.setParameter("departtime", departtime);
			}
			List list = query.getResultList();
			if(list.size()==0){
				play.Logger.info("vehicleid="+vehicleid+",schedulecode="+schedulecode+",departdate="+departdate);
				play.Logger.info("sql.toString()="+sql.toString());
			}
			return list;
		} else {
			StringBuilder sql = new StringBuilder(
					"select 0 as isselect, t.id,t.departdate,trim(t.departtime),sc.code,s.name as stationname, ")
			.append(" t.ticketno,t.seatno,'' as vehicleno,t.price,t.selltime, u.name sellbyname,''  as reportid,sp.id as scheduleplanid, ")
			.append(" r.name as routename,tlo.id as sellotherid,tlo.istaked ")
			.append(" from Ticketsell t ")
			.append(" left join scheduleplan sp on t.scheduleplanid=sp.id ")
			.append(" left join Ticketsellother tlo on tlo.ticketsellid = t.id ")
			//.append(" left join vehiclereport vp on vp.scheduleplanid=sp.id ")
			.append(" left join schedule sc on sp.scheduleid=sc.id ")
			.append(" left join station s on t.reachstationid=s.id ")
			.append(" left join route r on sc.routeid=r.id ")
			.append(" left join userinfo u on t.sellby=u.id ")                    //手持机售票
			.append(" where t.ticketstatus = '0' and t.isdepartinvoices = 0 and t.sellway='13' and t.vehicleid is null ") 
			.append(" and t.departdate=:departdate and t.batchno=:batchno ");
			Query query = em.createNativeQuery(sql.toString());
			query.setParameter("departdate", departdate);
			query.setParameter("batchno", batchno);
			List list = query.getResultList();
			if(list.size()==0){
				play.Logger.info("vehicleid="+vehicleid+",batchno="+batchno+",departdate="+departdate);
				play.Logger.info("sql.toString()="+sql.toString());
			}
			return list;
		}
	}
	
	// 未检的车票
	@SuppressWarnings("unchecked")
	public List<Ticketsell> qryunchecktickets(Date departdate,String ticketids) {
		StringBuilder sql = new StringBuilder(
				"select t from Ticketsell t where t.departdate=:departdate and t.id in ("+ticketids+")");
		Query query = em.createQuery(sql.toString());
		query.setParameter("departdate", departdate);
		return query.getResultList();
	}
	
	public Ticketoutlets qryTicketoutlet(long orgid) {
		StringBuilder sql = new StringBuilder(
				"select t from Ticketoutlets t where t.orgid=:orgid and t.type=0");
		Query query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		return (Ticketoutlets) query.getSingleResult();
	}
	
	/**
	 * 根据发班id查询发班code
	 * @param Scheduleid
	 * @return
	 */
	
	@SuppressWarnings("unchecked")
	public String queryScheduleCode(Long Scheduleid) {
		StringBuilder sql = new StringBuilder(
				" select t.code from Schedule t  where t.id= :id");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("id", Scheduleid);
		return (String) query.getSingleResult();
	}


	/**
	 * 将此结算单关联的车辆违规信息查出来
	 * @param departinvoicesid
	 * @return
	 */
	public List<Vehicleviolation> queryVehicleviolation(long departinvoicesid) {
		StringBuffer sql = new StringBuffer();
		sql.append(" select v from Vehicleviolation v where departinvoicesid = :departinvoicesid ");
		Query query = em.createQuery(sql.toString());
		query.setParameter("departinvoicesid",departinvoicesid );
		return query.getResultList();
	}


	/**
	 * 根据车辆id,查询车辆的报到记录
	 * @param vehicleid
	 * @param departdate
	 * @return
	 */
	public List<Object> qryVehicleReport(long vehicleid, Date departdate, long scheduleplanid) {
		StringBuffer sql = new StringBuffer();
		sql.append(" select v from Vehiclereport v ")
		.append(" where v.vehicleid =:vehicleid and v.departdate =:departdate  ")
		.append(" and v.scheduleplanid=:scheduleplanid and v.isactive=1 ");
		Query query = em.createQuery(sql.toString());
		query.setParameter("vehicleid",vehicleid );
		query.setParameter("departdate",departdate );
		query.setParameter("scheduleplanid",scheduleplanid );
		sql.append(" order by v.createtime desc ");
		return query.getResultList();
	}
	
	public List<Object> qryNonomalSchadd(Global global) {
		StringBuilder sql = new StringBuilder();
		sql.append(" select r.name routename, s.code schedulecode, ss.departdate , ss.departtime,sp.soldeatnum ,vk.name vehicleparkname")
		.append(" from scheduleplan sp, schedule s ")
		.append(" left join schedulestop ssp on ssp.scheduleid = s.id  ")
		.append("  left join vehiclepark vk on ssp.vehcileparkid = vk.id, route r, schedulestatus ss")
		.append("  where sp.scheduleid = s.id ")
		.append("  and s.routeid = r.id and sp.id = ss.scheduleplanid and ss.scheduleid = s.id")
		.append("  and sp.isovertime = 1 and s.isactive = 1 and s.isovertime = 1  and sp.departdate = trunc(sysdate)")
		.append(" and ssp.stationid = "+global.getOrganization().getStation().getId())
		.append("  and ss.departstationid ="+global.getOrganization().getStation().getId());
		
		Query query = em.createNativeQuery(sql.toString());
//		query.setParameter("stationid", stationid);
		return query.getResultList();
	}
	
	
	public List<Object> qryNonomalSch(long stationid) {
		StringBuilder sql = new StringBuilder(
				"select sp.departdate,r.name,sc.code,trim(ss.departtime) departtime,")
		.append(" sp.soldeatnum,dd.value statusname, case when vl.reason is not null then vl.reason when va.reason is not null then va.reason else  sm.reason end")
		.append(" from scheduleplan sp, schedule sc, schedulestatus ss")
		.append(" left join Vehiclelost vl on ss.scheduleplanid = vl.scheduleplanid left join Vehiclelate va on  ss.scheduleid = va.scheduleid  and va.departdate = ss.departdate")
		.append(" left join schedulemerge sm on sm.oldscheduleplanid =ss.scheduleplanid ")
		.append(" , route r, digitaldictionary d, digitaldictionarydetail dd")
		.append(" where sp.id = ss.scheduleplanid  and sp.scheduleid = sc.id")
		.append("  and d.tablename = 'schedulestatus' and d.columnname = 'schedulestatus'")
		.append("  and d.id = dd.digitaldictionaryid  and ss.status = dd.code")
		.append("  and ss.departstationid=:stationid  and sc.routeid = r.id")
		.append("  and ss.status in ('1', '2', '3', '4') and sp.departdate = trim(sysdate)")
		.append("  order by ss.departtime");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("stationid", stationid);
		return query.getResultList();
	}
	
	
////查询售票明细
	public List<Object> qryTicketsellsByVehicle(Date departdate,
			long vehiclereportid, long scheduleplanid,String departinvoicesno) {
		StringBuilder sql = new StringBuilder(
				"select ts.departdate,r.name,");
//		if(departinvoicesno == null) {
//		sql.append(" substr(ts.ticketno, 0, length(ts.ticketno) - 6) ||'***' || substr(ts.ticketno,")
//		.append("   length(ts.ticketno) - 2,length(ts.ticketno)) ticketno,");
//		}else{
//			sql.append(" ts.ticketno ticketno,");
//		}	
		sql.append(" substr(ts.ticketno, 0, length(ts.ticketno) - 6) ||'***' || substr(ts.ticketno,   length(ts.ticketno) - 2,length(ts.ticketno)) ticketno,")
		.append(" s.code,trim(ts.departtime),st.name reachname,ts.seatno,tt.name tickettypename,")
		.append(" ts.price,decode(ts.isdepartinvoices,1,'已打单',")
		.append(" decode(ts.ischecked, 1, '已检票', '未检')) dticketstatus")
//		.append(" dp.departinvoicesno ")
		.append("  from ticketsell ts  left join departinvoices dp on dp.id = ts.departinvoicesid,schedule   s,route      r,station    st,")
		.append("  tickettype tt")
		.append("  where ts.scheduleid = s.id  and ts.tickettype = tt.code")
		.append("    and s.routeid = r.id and ts.ticketstatus = '0'")
		.append("  and ts.reachstationid = st.id")
		.append(" and ((s.islinework = 1 and ts.vehiclereportid =:vehiclereportid) or")
		.append("  (s.islinework = 0 and ts.scheduleplanid =:scheduleplanid))")
		.append("   and ts.departdate = :departdate");
		if (departinvoicesno != null ){
		sql.append(" and dp.departinvoicesno = "+departinvoicesno);}
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("vehiclereportid", vehiclereportid);
		query.setParameter("scheduleplanid", scheduleplanid);
		return query.getResultList();
	}
}
