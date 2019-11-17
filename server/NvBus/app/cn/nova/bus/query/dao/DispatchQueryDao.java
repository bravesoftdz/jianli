package cn.nova.bus.query.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.report.param.Reportparam;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 *<b>类描述：调度查询</b><br/>
 * <b>类名称：</b>DispatchQueryDao<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn"></a><br/>
 * <b>修改内容：班次停班 </b><br/> 
 * <b>修改时间：2013-03-26</b><br/>
 * <b>修改人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * 
 */
@SuppressWarnings("rawtypes")
public class DispatchQueryDao extends EntityManagerDaoSurport {
	
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
	 * 客运班线发车时刻表
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryScheduleDepartTime(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select wm_concat(distinct r.name) as routename,sts.departdate,sp.distance,sp.runtime ,stend.name as endstationname," +
				"wm_concat(distinct st.name ) as reachstationname,wm_concat(distinct sts.departtime ) as starttime")
		.append(" from schedule s,route r,scheduleplan sp,ticketprice tp,station st,schedulestatus sts,station stend")
		.append(" where tp.scheduleplanid=sp.id and st.id = tp.reachstationid  and sp.endstationid = stend.id")
		.append(" and tp.scheduleplanid = sts.scheduleplanid and sts.scheduleplanid= sp.id ")  //--同一班次计划
		.append(" and tp.scheduleid= sts.scheduleid and sp.scheduleid = s.id ")
		.append(" and tp.scheduleid = s.id and sts.status =0  and sts.orgid= sp.orgid " +   // --同一班次
				" and s.orgid= sts.orgid and tp.orgid = sts.orgid and s.routeid = r.id " +  //--同一客运站
				" and sp.departdate = sts.departdate and tp.departdate= sts.departdate ");   // --同一发车日期
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" group by sts.departdate ,stend.name ,sp.distance,sp.runtime");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	/**
	 * 客运班次运营情况查询
	 * (该模块直接应用综合调度的代码：SchedulestatusDao--query)
	 * @param propertyFilterList
	 * @return
	 * sp.workways
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryScheduleRunSituation(
			List<PropertyFilter> propertyFilterList,long curstationid, Date departdate,String sellorgid) {	
		StringBuilder sql = new StringBuilder(
		"select decode(ss.departstationid,sp.startstationid,'始发班','配载班') schtype,")
		.append(" sp.autocancelreserveseatnum, sp.unautocancelreserveseatnum, ")
		.append(" trim(ss.departtime) as departtime,sp.id as scheduleplanid, sp.departdate,sp.seatnum, ")
		.append("  sp.fixedreserveseatnum,sp.soldeatnum,  sp.issellable, dt.value as workways, ")
		.append("  sp.districttype, sp.scheduletype, sp.isproprietary,sp.isovertime, ")
		.append("  s1.name as departname,s.code as schedulename,vrr.reportunit as unitname,s3.name as startroutename, ")
		.append("  s2.name as endroutename, ss.isbegincheck as begincheck,v.vehicleno as vehicleno, vrr.vehicleno as reportvehicleno, ")
		.append("  ss.status, ss.ticketentrance, ss.buspark,s.viastation as viastation, ")
		.append(" decode(d11.id,null,d1.name,d11.name) as driver1, decode(d22.id,null,d2.name,d22.name) as driver2, ")
		.append(" decode(d33.id,null,d3.name,d33.name) as driver3, ")
		.append("  s1.name as steward1,")
		.append("  s2.name as steward2,vt.name as vtname,r.name as routename,sv.id as schedulevehiclepeopleplanid, ")
		.append("  ss.id as schedulestatusid,vt.id as vehicletypeid, sv.planvehiclebrandmodelid as vehiclebrandmodelid,s.id as scheduleid,")
		.append("  s.orgid as orgid,sv.planvehicleid as planvehicleid,d1.id as d1id,d2.id as d2id,")
		.append("  d3.id as d3id,s1.id as s1id,s2.id as s2id,sp.islinework,")
		.append("  r.id as routeid,(sp.seatnum - sp.fixedreserveseatnum - sp.soldeatnum -sp.autocancelreserveseatnum - sp.unautocancelreserveseatnum) as reservenum,")
		.append("  ss.isdeparted,sp.issaleafterreport,sp.runtime,sp.worktype,")
		.append("  sp.isoriginator,sp.issellreturnticket,sp.iscanmixcheck,vm.brandname as brandmodelname,")
		.append("  vrr.reportorg as orgname, vrr.reporttime,ss.departstationid,u1.name planunit,sp.remarks,sp.carrychildnum, ")
		
//原来的		.append("  sv.planunitid,(select count(*) from  ticketsell t where t.scheduleplanid=sp.id and t.departstationid="+curstationid)
		
		
		.append("  sv.planunitid,(select count(*) from  ticketsell t,ticketoutlets tos where t.scheduleplanid=sp.id and t.ticketoutletsid = tos.id ");
		if("".equals(sellorgid)||sellorgid==null){
			sql.append(" and t.departstationid="+curstationid);
		}else{
			sql.append(" and tos.orgid in").append(sellorgid).append(" and t.departstationid="+curstationid);
		}
		
		
		sql.append("     and t.ticketstatus='0') localsell,")
		
//原来的		.append("  (select count(*) from  ticketsell t where t.scheduleplanid=sp.id and t.departstationid<>"+curstationid)
		
		.append("  (select count(*) from  ticketsell t,ticketoutlets tos where t.scheduleplanid=sp.id and t.ticketoutletsid = tos.id ");
		if("".equals(sellorgid)||sellorgid==null){
			sql.append(" and t.departstationid<>"+curstationid);
		}else{
			sql.append(" and tos.orgid in").append(sellorgid).append(" and t.departstationid<>"+curstationid);
		}
		
		sql.append("     and t.ticketstatus='0') othersell")
		.append(" ,nvl(sp.endtime,sp.starttime) as endtime ")
		.append("   from Scheduleplan sp,")
		.append("       (select vr.id,vr.orderno,")
		.append("               uf.name,")
		.append("               vr.vehicleid,")
		.append("               vh.vehicleno,")
		.append("               vr.reportorgid,")
		.append("               vr.driver1id,")
		.append("               vr.driver2id,")
		.append("               vr.driver3id,")
		.append("                vr.reporttime,")
		.append("               vr.scheduleplanid,")
		.append("               org.name reportorg,")
		.append("           un.name reportunit,vh.unitid")
		.append("   from Vehiclereport     vr,")
		.append("       userinfo          uf,")
		.append("        vehicle           vh,")
		.append("         organization      org,")
		.append("         unit              un")
		.append("    where vr.createby = uf.id")
		.append("    and vh.unitid = un.id")
		.append("     and vr.vehicleid = vh.id")
		.append("    and org.stationid =" + curstationid+" and vr.departdate = :departdate ")
		.append("    and vr.reportorgid = org.id")
		.append("    and vr.isactive = 1) vrr,")
		.append("  schedulestatus ss, schedulevehiclepeopleplan sv,schedule s,route r,station s1,")
		.append("   station s2, vehicletype vt,vehicle v,unit u1,driver d1,driver d2,driver d3,driver d11,driver d22,driver d33,steward st1,")
		.append("   steward st2,station s3,vehiclebrandmodel vm,digitaldictionarydetail dt ")
		.append(" where sp.id = ss.scheduleplanid ")
		.append(" and dt.digitaldictionaryid=15 and sp.workways = dt.code")
		.append(" and sv.planvehiclebrandmodelid=vm.id")
		.append(" and sp.id = sv.scheduleplanid  and sp.id = vrr.scheduleplanid(+) and sv.orderno = 0")
		.append(" and sv.planunitid = u1.id(+)  and sv.planvehicleid = v.id(+) and sp.scheduleid = s.id")
		.append(" and vt.id = sv.planvehicletypeid  and ss.departstationid = s1.id and sp.endstationid = s2.id")
		.append(" and vrr.driver1id = d11.id(+) and vrr.driver2id = d22.id(+) and vrr.driver3id = d33.id(+) ")
		 
	   
	   
		.append(" and sp.startstationid = s3.id and s.routeid = r.id  and sv.plandriver1id = d1.id(+)")
		.append(" and sv.plandriver2id = d2.id(+)  and sv.plandriver3id = d3.id(+)  and sv.plansteward1id = st1.id(+)")
		.append(" and sv.plansteward2id = st2.id(+) ")
		.append(" and (sp.islinework=0 or (sp.islinework=1 and sv.orderno=0))")
		.append(" and (vrr.orderno=(select max(orderno) from vehiclereport tt ")
		.append(" where tt.isactive=1 and tt.scheduleplanid=vrr.scheduleplanid) or vrr.id is null) ")
		.append(" and (ss.departstationid ="+curstationid+" or (s.worktype='2' or s.worktype='3')) ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by ss.departdate, r.id,ss.departtime");
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		query.setParameter("departdate", departdate);
		return query.getResultList();
	}

	/**
	 * 客运班次运营情况--班次售票明细汇总表
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> querySoldSituation(int scheduleplanid,int scheduleid) {
		StringBuilder sql = new StringBuilder(
				"select tol.name as ticketoutletsname,st.name as dapartname,et.name as endname," +
				"tp.name as tickettypename,sum(ts.price) allprice,count(ts.id) ticketnum,"+
				"sum(ts.price)/count(ts.id) price "+
				" from ticketsell ts,station st,station et,ticketoutlets tol," +
				" tickettype tp where ts.departstationid=st.id and ts.ticketoutletsid = tol.id " +
				" and ts.reachstationid= et.id" +
				" and ts.ticketstatus='0'"+
				" and ts.tickettype= tp.code"+
				" and ts.scheduleplanid = "+scheduleplanid +
				" and ts.scheduleid = "+scheduleid);  		
		sql.append(" group by st.name,et.name,tp.name,tol.name ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}
	
	/**
	 * 晚点班次情况查询
	 * @param propertyFilterList
	 * @param notbalance //未结算 查询条件
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryVehicleLate(List<PropertyFilter> propertyFilterList,String notbalance) {
		StringBuilder sql = new StringBuilder(
				"select o.name as orgname,vl.departdate,r.name as routename,s.code as schedulecode,"+
				"u.name as unitname,v.vehicleno as repotvehicle," +
				"vr.reporttime,vl.reason,vl.forfeit,(case when vl.balanceid > 0 then 1 else 0 end) as isbalance," +
				"ss.status,trim(ss.departtime),"+
				" trunc((vr.reporttime -to_date(to_char(ss.departdate, 'yyyy-mm-dd') || ss.departtime,'yyyy-mm-dd hh24:mi')) * 24 * 60) + 10 latermin")
		.append(" from Vehiclelate vl,Vehiclereport vr,Scheduleplan sp,Organization o,Route r," +
				" Schedule s,"+
				" Vehicle v,Schedulestatus ss,Unit u ")
		.append(" where vl.reportid = vr.id and vr.scheduleplanid = sp.id and vr.orgid = o.id " +
				" and vl.scheduleid = s.id and s.routeid = r.id  " +
				" and vl.vehicleid = v.id and vr.scheduleplanid = ss.scheduleplanid" +
				" and v.unitid = u.id and vl.vehicleid = v.id and ss.status='2' "); 
		if( !notbalance.equals("")){
			sql.append(" and vl.balanceid "+notbalance+" ");
		}
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();				
		
	}	
	
	/**
	 *脱班班次情况查询
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryVehicleLost(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select distinct o.name as orgname,r.name as routename,vl.departdate,")
		.append("s.code as schdulecode,u.name as unitname,")
		.append("v.vehicleno as vehicleno,dd.value as schedulestatus,")
		.append("trim(sp.starttime) starttime,vl.createtime,vl.reason,")
		.append("vl.forfeit,vl.balanceid as isbalance,vl.reportname,c.name as createname")
		.append(" from Vehiclelost vl  ")
		.append("   left join schedule s on s.id = vl.scheduleid ")
		.append(" left join scheduleplan sp on sp.id = vl.scheduleplanid ")
		.append(" left join vehiclereport vr on vr.scheduleplanid = sp.id ")
		.append(" left join vehicle v on v.id = vr.vehicleid ")
		.append(" left join unit u on u.id = v.unitid ")
		.append(" left join schedulestatus ss on ss.scheduleplanid = sp.id ")
		.append(" left join digitaldictionarydetail dd on dd.code = ss.status and dd.digitaldictionaryid = 48 ")
		.append(" left join organization o on o.id = v.orgid ")
		.append(" left join route r on r.id = s.routeid ")
		.append(" left join userinfo c on c.id = vl.createby where 1=1 ");  
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by vl.createtime desc ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	/**
	 *班次报停情况查询
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryVehicleStop(List<PropertyFilter> propertyFilterList,String vehicleno,String loststatus) {
		StringBuilder sql = new StringBuilder(" select allsc.stationame ,")
			.append("allsc.routename,")	   
		    .append("allsc.departdate,")    
		    .append("allsc.code,")
		    .append("lostsc.vehicleno,")
		    .append("allsc.value,")
		    .append("Trim(allsc.departtime),")
		    .append("allsc.updatetime,")
		    .append("lostsc.reason,")
		    .append("lostsc.reportname, ")
		    .append("allsc.updateby")
	    .append(" from (")
	    	.append(" select st.name stationame,")
	    	.append("r.name routename,")
	    	.append("s.code,")
	    	.append("ss.departdate,")
	    	.append("ss.departtime,")
	    	.append("dd.value,")
	    	.append("ss.updatetime,")
	    	.append("upb.name updateby")
	  .append(" from schedulestatus          ss,")
	       .append(" scheduleplan            sp,")
	       .append(" schedule                s,")
	       .append(" route                   r,")
	       .append(" organization            departorg,")
	       .append(" station                 st,")
	       .append(" Digitaldictionary       d,")
	       .append(" Digitaldictionarydetail dd,")
	       .append(" userinfo                upb")
	 .append(" where ss.scheduleplanid = sp.id")
	   .append(" and ss.scheduleid = s.id ")
	   .append(" and ss.status = '1'")
	   .append(" and r.id = s.routeid")
	   .append(" and departorg.stationid = ss.departstationid")
	   .append(" and ss.departstationid = st.id")
	   .append(" and ss.departdate = sp.departdate")
	   .append(" and d.tablename = 'schedulestatus'")
	   .append(" and d.columnname = 'schedulestatus'")
	   .append(" and d.id = dd.digitaldictionaryid")
	   .append(" and ss.status = dd.code ");
	   sql.append(PropertyFilter.toJpql(propertyFilterList, true));
	   sql.append(" and ss.updateby = upb.id ) allsc")
	.append(" left join ")
	.append(" (select st.name stationame,")
	       .append(" r.name routename,")
	       .append(" s.code,")
	       .append(" ss.departdate,")
	       .append(" ss.departtime, ")
	       .append(" ss.updatetime,")
	       .append(" v.vehicleno,")
	       .append(" vl.reason,")
	       .append(" upb.name updateby,")
	       .append(" vl.reportname,")
	       .append(" vl.loststatus ")
	  .append(" from vehiclelost vl")
	  .append(" left join vehicle v on vl.vehicleid = v.id, route r, schedule s,")
	 .append(" schedulestatus ss, userinfo upb, station st")
	 .append(" where ss.scheduleplanid = vl.scheduleplanid")
	   .append(" and vl.scheduleid = s.id")
	   .append(" and s.routeid = r.id  ")
	   .append(" and vl.createby = upb.id");
	   sql.append(" and ss.departstationid = st.id ");
	   sql.append(PropertyFilter.toJpql(propertyFilterList, true));
	   sql.append(" ) lostsc")
	   .append(" on allsc.stationame= lostsc.stationame and  lostsc.routename=lostsc.routename")
	   .append(" and allsc.departdate = lostsc.departdate and allsc.code=lostsc.code and allsc.departtime=lostsc.departtime")
	    .append(" where  1=1 ");
	   
	   if(loststatus!=null&&!"".equals(loststatus)){
		   sql.append(" and lostsc.loststatus = "+loststatus);
	   }
	   if(!"".equals(vehicleno)){
		   sql.append(" and lostsc.vehicleno = '"+vehicleno+"'");
	   }
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();		
	}
	
	/**
	 *  班次并班情况查询
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryschedulemerge(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select sm.id,os.code as oldschedulecode,ns.code as newschedulecode,osp.departdate as olddepartdate," +
				"nsp.departdate as newdepartdate,osp.seatnum as oldseatnum,nsp.seatnum as newseatnum," +
				"r.name as oldroutename,nr.name as newroutename,sm.reason," +
				"u.name as createname,sm.iscancel,o.name as orgname ")
		.append(" from Schedulemerge sm,Schedule os,Schedule ns,Scheduleplan osp," +
				" Scheduleplan nsp,Route r,Route nr,Userinfo u,Organization o")
		.append(" where sm.oldscheduleid=os.id and sm.newscheduleid=ns.id " +
				" and sm.scheduleplanid = nsp.id and sm.oldscheduleplanid=osp.id" +
				" and os.route.id = r.id and ns.route.id=nr.id" +
				" and sm.userid = u.id and sm.orgid = o.id");  		
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	/**
	 *  班次并班车票明细情况查询
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryschedulemergeDetail(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select smd.oldseatno,smd.newseatno,ts.ticketno,o.name as orgname,ts.carrychildnum,"+
				"sta.name as departstaioname ,ste.name as reachestationname ,tp.name as ticketype,ts.price," +
				"ts.ticketentrance,ts.buspark,tos.name as ticketoutletsname,ts.selltime," +
				"ct.name as customername,ck.name as checkbyname,ts.ticketstatus,ts.seattype" +
				" from Schedulemergedetail smd,Ticketsell ts left join ts.customer ct " +
				"left join ts.checkedby ck,Organization o,Station sta," +
				"Station ste,Tickettype tp,Ticketoutlets tos" +
				" where smd.ticketsellid = ts.id and ts.orgid=o.id and ts.departstationid =sta.id" +
				" and ts.reachstationid = ste.id and ts.tickettype= tp.code and ts.ticketoutletsid = tos.id ");  		
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	/**
	 * 客运站加班情况查询
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryOverTimeSchedule(
			List<PropertyFilter> propertyFilterList,long curstationid) {
//		
		StringBuilder sql = new StringBuilder(
		"select sp.autocancelreserveseatnum, sp.unautocancelreserveseatnum, ")
		.append(" trim(ss.departtime) as departtime,sp.id as scheduleplanid, sp.departdate,sp.seatnum, ")
		.append("  sp.fixedreserveseatnum,sp.soldeatnum,  sp.issellable, sp.workways, ")
		.append("  sp.districttype, sp.scheduletype, sp.isproprietary,sp.isovertime, ")
		.append("  s1.name as departname,s.code as schedulename,vrr.reportunit as unitname,s3.name as startroutename, ")
		.append("  s2.name as endroutename, ss.isbegincheck as begincheck,v.vehicleno as vehicleno, vrr.vehicleno as reportvehicleno, ")
		.append("  dic.value as status, ss.ticketentrance, ss.buspark,s.viastation as viastation, ")
		.append("  d1.name as driver1,d2.name as driver2,d3.name as driver3,s1.name as steward1,")
		.append("  s2.name as steward2,vt.name as vtname,r.name as routename,sv.id as schedulevehiclepeopleplanid, ")
		.append("  ss.id as schedulestatusid,vt.id as vehicletypeid, sv.planvehiclebrandmodelid as vehiclebrandmodelid,s.id as scheduleid,")
		.append("  s.orgid as orgid,sv.planvehicleid as planvehicleid,d1.id as d1id,d2.id as d2id,")
		.append("  d3.id as d3id,s1.id as s1id,s2.id as s2id,sp.islinework,")
		.append("  r.id as routeid,(sp.seatnum - sp.fixedreserveseatnum - sp.soldeatnum -sp.autocancelreserveseatnum - sp.unautocancelreserveseatnum) as reservenum,")
		.append("  ss.isdeparted,sp.issaleafterreport,sp.runtime,sp.worktype,")
		.append("  sp.isoriginator,sp.issellreturnticket,sp.iscanmixcheck,vrr.brandname as brandmodelname,")
		.append("  vrr.reportorg as orgname, vrr.reporttime,ss.departstationid,vrr.balanceid,vrr.balanceunitname,")
		.append(" nvl((select sum(ts.price) from ticketsell ts where ts.scheduleplanid = sp.id and ts.ticketstatus='0'),0) sellprice ")
		.append("   from Scheduleplan sp,")
		.append("       (select vr.id,vr.orderno,")
		.append("               uf.name,")
		.append("               vr.vehicleid,")
		.append("               vh.vehicleno,")
		.append("               vr.reportorgid,")
		.append("                vr.reporttime,")
		.append("               vr.scheduleplanid,")
		.append("               org.name reportorg,")
		.append("           un.name reportunit,")
		.append("          vm.brandname,bu.id as balanceid,bu.name balanceunitname ")
		.append("   from Vehiclereport vr,")
		.append("   vehiclebrandmodel vm, userinfo uf,")
		.append("   unit un, unit bu, vehicle  vh,organization  org")
		.append("    where vr.createby = uf.id")
		.append("    and vh.unitid = un.id and vh.balanceunitid= bu.id ")
		.append("     and vr.vehicleid = vh.id")
		.append("    and org.stationid =" + curstationid)
		.append("    and vr.reportorgid = org.id")
		.append("    and vm.id = vh.vehiclebrandmodelid")
		.append("    and vr.isactive = 1) vrr,")
		.append("   Digitaldictionarydetail dic,")
		.append("    Digitaldictionary digital, ")
		.append("  schedulestatus ss, schedulevehiclepeopleplan sv,schedule s,route r,station s1,")
		.append("   station s2, vehicletype vt,vehicle v,unit u1,driver d1,driver d2,driver d3,steward st1,")
		.append("   steward st2,station s3 where sp.id = ss.scheduleplanid")
		.append(" and sp.id = sv.scheduleplanid  and sp.id = vrr.scheduleplanid(+) and sv.orderno = 0")
		.append(" and sv.planunitid = u1.id(+)  and sv.planvehicleid = v.id(+) and sp.scheduleid = s.id")
		.append(" and vt.id = sv.planvehicletypeid  and ss.departstationid = s1.id and sp.endstationid = s2.id")
		.append(" and sp.startstationid = s3.id and s.routeid = r.id  and sv.plandriver1id = d1.id(+)")
		.append(" and sv.plandriver2id = d2.id(+)  and sv.plandriver3id = d3.id(+)  and sv.plansteward1id = st1.id(+)")
		.append(" and sv.plansteward2id = st2.id(+) ")
		.append(" and (sp.islinework=0 or (sp.islinework=1 and sv.orderno=0))")
		.append(" and (vrr.orderno=(select max(orderno) from vehiclereport tt ")
		.append(" where tt.isactive=1 and tt.scheduleplanid=vrr.scheduleplanid) or vrr.id is null) ")
		.append(" and sp.isovertime=1 and digital.tablename = 'schedulestatus' ")
		.append(" and dic.digitaldictionaryid = digital.id and dic.code = ss.status ")
		.append(" and digital.columnname = 'schedulestatus' and ss.departstationid =" + curstationid);
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by ss.departdate, r.id,ss.departtime");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	/**
	 * 满座班次查询
	 * * @param propertyFilterList,
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryFullSeatSchedule(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				" select r.name as routename," +
				" s.code," +
				" ss.departdate," +
				" trim(ss.departtime)," +
				" t.seatnum," +
				" t.soldeatnum," +
				" t.autocancelreserveseatnum," +
				" t.unautocancelreserveseatnum," +
				" t.fixedreserveseatnum," +
				" t.isovertime," +
				" dic.value as status," +
				" ss.isdeparted," +
				" t.issaleafterreport" +
				" from Schedule s," +
					" Schedulestatus ss," +
					" Scheduleplan t," +
				 	" Route r," +
					" Digitaldictionarydetail dic," +
				    " Digitaldictionary digital" +
				" where t.scheduleid = s.id" +
				" and s.routeid = r.id" +
				" and ss.scheduleplanid = t.id" +
				" and ss.scheduleid = s.id" +
				" and digital.tablename = 'schedulestatus'" +
				" and digital.columnname = 'schedulestatus'" +
				" and dic.digitaldictionaryid = digital.id" +
				" and dic.code = ss.status" +
				" and t.seatnum= t.soldeatnum "+
				" and s.islinework = 0 ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by r.name, trim(ss.departtime) ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	/**
	 *车辆应班登记表
	 * * 
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryVehicleLicense(Reportparam rp) {
//		StringBuilder sql = new StringBuilder("select o.name as orgname,v.vehicleno,vr.departdate,u.name as unitname,")
//		.append(" trim(case s.isovertime when 0 then '正班' when 1 then '加班' end) as scheduletype,")
//		.append(" dr1.name,dr1.drivinglicense,dr1.qualification,v.driverlicense,v.workno,")
//		.append(" r.name as roadno,v.seatnum,(case when v.maintainvaliddate > sysdate then 1 else 0")
//		.append(" end) ismaintain,'' as signature")
//		.append(" from Vehiclereport vr left join Driver dr1 on vr.driver1id = dr1.id ")
//		.append(" left join Organization o on o.id=vr.reportorgid, ")
//		.append(" Vehicle v left join  unit u on u.id=v.unitid,schedule s,route r")
//		.append(" where vr.vehicleid = v.id and vr.reportorgid in "+rp.getOrgids())
//		.append(" and vr.departdate between :startdate and :enddate+0.99999")
//		.append(" and vr.scheduleid=s.id and vr.isactive='1' and s.routeid=r.id");
		StringBuilder sql=new StringBuilder("select rownum  orderno,v.vehicleno,")
		.append(" vp.reporttime  departtime1,vp.drivername name,")
		.append(" decode(vp.dqualificationres, '合格', '√', '×') qualification,")
		.append(" decode(vp.ddrivinglicenseres, '合格', '√', '×') drivinglicense,")
		.append(" decode(vp.vdriverlicenseres,'合格','√','×') driverlicense,")
		.append(" decode(vp.vworknores, '合格', '√', '×') workno, decode(vp.vroadnores, '合格', '√', '×') rodeno,")
		.append(" decode(vp.dworknores, '合格', '√', '×') workno1,decode(vp.vnotenum, '合格', '√', '×') notenum,")
		.append(" vp.rationseatnum seatnum,vp.acttickets actpersons,vp.driversign,vp.classmember,vp.dispatcher")
		.append(" from vehicledriverreport vp, schedule s,vehicle v,vehiclereport vr  ")
		.append(" where vp.scheduleid = s.id and vp.vehicleno=v.vehicleno   and vp.vehiclereportid = vr.id and vr.isdeparted = 1 ")
		.append(" and vp.departdate between :startdate and :enddate+0.99999"); // 取车辆报到表中 是否报道和是否发班条件.
		if(rp.getUnitid()>0){
			sql.append(" and v.unitid="+rp.getUnitid());
		}
		if(rp.getRouteid()>0){
			sql.append(" and s.routeid="+rp.getRouteid());
		}
		if(rp.getSchtype()>0){
			if(rp.getSchtype()==1){
				sql.append(" and s.isovertime=0");
			}else
			{
				sql.append(" and s.isovertime=1");
			}
		}
		if(rp.getVehicleid()>0){
			sql.append(" and v.id="+rp.getVehicleid());
		}
//		sql.append(" order by vr.reportorgid,r.name ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", rp.getStartdate());
		query.setParameter("enddate", rp.getEnddate());
		return query.getResultList();
	}
	
	/**
	 *运量单的车票明细
	 * * 
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryTicketInfo(long departinvoicesid) {
		StringBuilder sql = new StringBuilder(
				"select ts.sellip,ts.selltime,ts.buspark,")
		.append(" ts.ticketentrance,ts.price,ts.fueladditionfee,")
		.append(" ts.stationservicefee,")
		.append(" ts.discountrate,")
		.append(" ts.fullprice,")
		.append(" ts.distance,")
		.append(" ts.carrychildnum,")
		.append(" ts.departdate,")
		.append(" trim(ts.departtime) as departtime,")
		.append(" ts.seatno,")
		.append(" ts.ticketno,")
		.append(" ts.sellway,")
		.append(" ts.ticketstatus,")
		.append(" ts.paymethod,")
		.append(" o.name as orgname,")
		.append(" s.code as schedulecode,")
		.append(" stt.name as dpartname,")
		.append(" ste.name as reachname,")
		.append(" u.name as sellname,")
		.append(" vt.name as vehicletypename,")
		.append(" tt.name as tickettypename,")
		.append(" ts.islinework,")
		.append(" tos.name as ticketoutletname,")
		.append(" cc.name as customername,")
		.append(" th.name as hticketoutlesname,")
		.append(" th.address as houtletsaddress,")
		.append(" ck.name as checkedname,")
		.append(" cks.name as checkstationname,")
		.append(" du.name as departinvoicesbyname,")
		.append(" ts.servicefee,")
		.append(" vbm.brandname as vehiclebrandmodelname,")
		.append(" ts.checktime,")
		.append(" ts.computefee,")
		.append(" ts.coolairfee,")
		.append(" ts.additionfee,")
		.append(" sp.isovertime,")
		.append(" r.name as routename,")
		.append(" ts.moreprice,")
		.append(" ts.otherfee,")
		.append(" ts.insurefee,")
		.append(" ts.waterfee,")
		.append(" 0 serviceprice,")
		.append(" (ts.coolairfee + ts.additionfee + ts.fueladditionfee + ts.waterfee +")
		.append(" ts.insurefee + ts.otherfee + ts.stationservicefee + ts.computefee) subtotal")
		.append(" from Ticketsell ts")
		.append(" LEFT JOIN customer cc on ts.customerid = cc.id")
		.append(" LEFT JOIN ticketoutlets th on ts.handticketoutletsid = th.id")
		.append(" LEFT JOIN userinfo du on ts.departinvoicesby = du.id")
		.append(" left join ticketsellother tso on ts.id = tso.ticketsellid")
		.append(" ,Scheduleplan sp,departinvoices dv,")
		.append(" Schedule s, Organization o, Station stt,")
		.append(" Station ste, Route r, Userinfo u,  Vehicletype vt,")
		.append(" Tickettype tt, Ticketoutlets tos,vehicle v,")
		.append(" Vehiclebrandmodel vbm,userinfo ck ,station cks")
		.append(" where ts.scheduleplanid = sp.id")
		.append(" and o.id = ts.orgid")
		.append(" and dv.id=ts.departinvoicesid")
		.append(" and dv.vehicleid=v.id")
		.append(" and sp.scheduleid = s.id")
		.append(" and v.vehiclebrandmodelid  = vbm.id")
		.append(" and stt.id = ts.departstationid")
		.append(" and ste.id = ts.reachstationid")
		.append(" and u.id = ts.sellby")
		.append(" and v.vehicletypeid = vt.id")
		.append(" and tt.code = ts.tickettype")
		.append(" and ts.ticketoutletsid = tos.id")
		.append(" and s.routeid = r.id")
		.append(" and ts.checkedby = ck.id")
		.append(" and ts.departinvoicesid = " + departinvoicesid)
		.append(" and ts.checkstationid = cks.id ")
		//updateby by tianhb--begin 二〇一七年四月二十八日  综合查询+班次结算情况查询+结算单明细情况加一个票号 (支持 任务 7704)
		.append(" UNION ALL ")
		.append(" SELECT ts.sellip,ts.selltime,ts.buspark,")
		.append(" ts.ticketentrance,ts.price,ts.fueladditionfee,")
		.append(" ts.stationservicefee,")
		.append(" ts.discountrate,")
		.append(" ts.fullprice,")
		.append(" ts.distance,")
		.append(" ts.carrychildnum,")
		.append(" ts.departdate,")
		.append(" trim(ts.departtime) as departtime,")
		.append(" ts.seatno,")
		.append(" ts.ticketno,")
		.append(" ts.sellway,")
		.append(" ts.ticketstatus,")
		.append(" ts.paymethod,")
		.append(" o.name as orgname,")
		.append(" s.code as schedulecode,")
		.append(" stt.name as dpartname,")
		.append(" ste.name as reachname,")
		.append(" u.name as sellname,")
		.append(" vt.name as vehicletypename,")
		.append(" tt.name as tickettypename,")
		.append(" ts.islinework,")
		.append(" tos.name as ticketoutletname,")
		.append(" cc.name as customername,")
		.append(" th.name as hticketoutlesname,")
		.append(" th.address as houtletsaddress,")
		.append(" ck.name as checkedname,")
		.append(" cks.name as checkstationname,")
		.append(" du.name as departinvoicesbyname,")
		.append(" ts.servicefee,")
		.append(" vbm.brandname as vehiclebrandmodelname,")
		.append(" ts.checktime,")
		.append(" ts.computefee,")
		.append(" ts.coolairfee,")
		.append(" ts.additionfee,")
		.append(" sp.isovertime,")
		.append(" r.name as routename,")
		.append(" ts.moreprice,")
		.append(" ts.otherfee,")
		.append(" ts.insurefee,")
		.append(" ts.waterfee,")
		.append(" 0 serviceprice,")
		.append(" (ts.coolairfee + ts.additionfee + ts.fueladditionfee + ts.waterfee +")
		.append(" ts.insurefee + ts.otherfee + ts.stationservicefee + ts.computefee) subtotal")
		.append(" from Ticketsell ts")
		.append(" LEFT JOIN customer cc on ts.customerid = cc.id")
		.append(" LEFT JOIN ticketoutlets th on ts.handticketoutletsid = th.id")
		.append(" LEFT JOIN userinfo du on ts.departinvoicesby = du.id")
		.append(" left join ticketsellother tso on ts.id = tso.ticketsellid")
		.append(" LEFT JOIN userinfo ck on ts.checkedby = ck.id")
		.append(" LEFT JOIN station cks on ts.checkstationid = cks.id")
		.append(" ,Scheduleplan sp,departinvoicesother dv,")
		.append(" Schedule s, Organization o, Station stt,")
		.append(" Station ste, Route r, Userinfo u,  Vehicletype vt,")
		.append(" Tickettype tt, Ticketoutlets tos,vehicle v,")
		.append(" Vehiclebrandmodel vbm")
		.append(" WHERE ts.scheduleplanid = sp.id")
		.append(" and o.id = ts.orgid")
		.append(" and dv.id=ts.departinvoicesid")
		.append(" and dv.vehicleid=v.id")
		.append(" and sp.scheduleid = s.id")
		.append(" and v.vehiclebrandmodelid  = vbm.id")
		.append(" and stt.id = ts.departstationid")
		.append(" and ste.id = ts.reachstationid")
		.append(" and u.id = ts.sellby")
		.append(" and v.vehicletypeid = vt.id")
		.append(" and tt.code = ts.tickettype")
		.append(" and ts.ticketoutletsid = tos.id")
		.append(" and s.routeid = r.id")
		.append(" and ts.departinvoicesid = " + departinvoicesid);
		//updateby by tianhb--end 二〇一七年四月二十八日  综合查询+班次结算情况查询+结算单明细情况加一个票号 (支持 任务 7704)
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}


	public List<Object> queryDepartinvoicesOtherDetail(long departinvoicesid) {
		StringBuffer sql = new StringBuffer();
		
		sql.append(" select dv.recordip sellip,");
	    sql.append("   '' selltime,");
	    sql.append("   '' buspark,");
	    sql.append("   '' ticketentrance,");
	    sql.append("   dtd.price,");
	    sql.append("   0 fueladditionfee,");
	    sql.append("   dtd.stationservicefee stationservicefee,");
	    sql.append("   0 discountrate,");
	    sql.append("   dtd.price fullprice,");
	    sql.append("   '' distance,");
	    sql.append("   '' carrychildnum,");
	    sql.append("   dtd.departdate,");
	    sql.append("   trim(dtd.departtime) as departtime,");
	    sql.append("   '' seatno,");
	    sql.append("   '' ticketno,");
	    sql.append("   '' sellway,");
	    sql.append("   '' ticketstatus,");
	    sql.append("   '' paymethod,");
	    sql.append("   o.name as orgname,");
	    sql.append("   s.code as schedulecode,");
	    sql.append("   stt.name as dpartname,");
	    sql.append("   ste.name as reachname,");
	    sql.append("   u.name as sellname,");
	    sql.append("   vt.name as vehicletypename,");
	    sql.append("   tt.name as tickettypename,");
	    sql.append("   s.islinework islinework,");
	    sql.append("   '' as ticketoutletname,");
	    sql.append("   '' as customername,");
	    sql.append("   '' as hticketoutlesname,");
	    sql.append("   '' as houtletsaddress,");
	    sql.append("   '' as checkedname,");
	    sql.append("   '' as checkstationname,");
	    sql.append("   du.name departinvoicesbyname,");
	    sql.append("   0 servicefee,");
	    sql.append("   vbm.brandname as vehiclebrandmodelname,");
	    sql.append("   dtd.createtime checktime,");
	    sql.append("   0 computefee,");
	    sql.append("   0 coolairfee,");
	    sql.append("   0 additionfee,");
	    sql.append("   s.isovertime,");
	    sql.append("   r.name as routename,");
	    sql.append("   0 moreprice,");
	    sql.append("   dtd.othterfee otherfee,");
	    sql.append("   0 insurefee,");
	    sql.append("   0 waterfee,");
	    sql.append("   0 serviceprice,");
	    sql.append("   (dtd.stationservicefee + dtd.othterfee) subtotal "); 
	    sql.append("  from departinvoicesother dv ");
	    sql.append("  left join departinvoicesotherdetail dtd on dv.id = dtd.departinvoicesotherid ");
	    sql.append("  LEFT JOIN userinfo du on dv.createby = du.id ,Schedule s,Organization o,  ");
	    sql.append(" Station stt, Station ste,Route r,Userinfo u,Vehicletype vt, Tickettype tt, vehicle v, Vehiclebrandmodel vbm ");
	    sql.append(" WHERE dv.orgid = o.id ");
	    sql.append("   and dv.vehicleid = v.id ");
	    sql.append("   and dv.scheduleid = s.id ");
	    sql.append("   and dv.createby = u.id ");
	    sql.append("   and v.vehiclebrandmodelid = vbm.id ");
	    sql.append("   and stt.id = dtd.fromstationid ");
	    sql.append("   and ste.id = dtd.reachstationid ");
	    sql.append("   and v.vehicletypeid = vt.id ");
	    sql.append("   and tt.id = dtd.tickettypeid ");
	    sql.append("   and  s.routeid = r.id ");
	    sql.append("   and dv.id = " + departinvoicesid);
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}
}
