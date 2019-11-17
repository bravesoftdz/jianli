package cn.nova.bus.dispatch.dao;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import play.Logger;
import util.Appvar;
import util.CurrentUtil;
import util.JsonUtil;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.plugin.PluginFunction;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.security.Global;
import cn.nova.bus.util.PluginFunctionUtil;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;
import models.ActionNode;

@SuppressWarnings("rawtypes")
public class SchedulestatusDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList, long curstationid, Date fromdate, Date enddate, boolean isfullseat) throws ServiceException {
		/*
		 * StringBuffer sql = new StringBuffer(
		 * "select t.autocancelreserveseatnum, ") .append(
		 * " t.unautocancelreserveseatnum, trim(ss.departtime), ") .append(
		 * " t.id,t.departdate,t.scheduleid,t.seatnum,t.fixedreserveseatnum,t.soldeatnum,t.issellable,"
		 * ) .append(
		 * " dig.value as workwaysname,t.districttype,t.scheduletype,t.isproprietary,t.isovertime,"
		 * ) .append(
		 * " so.name as departname, sc.code as schedulename, un.name as unitname, "
		 * ) .append(
		 * " sn.name as startroutename, si.name as endroutename, ss.isbegincheck as begincheck,  v.vehicleno as vehicleno, vc.vehicleno as reportvehicleno, "
		 * ) .append(
		 * " dic.value as vcstatus, ss.ticketentrance as ticketentrance, ss.buspark as buspark, "
		 * ) .append(
		 * " sc.viastation as viastation, d1.name as driver1, d2.name as driver2, "
		 * ) .append(
		 * " d3.name as driver3, d4.name as driver4, s1.name as steward1, s2.name as steward2, "
		 * ) .append(
		 * " vt.name as vtname, r.name as routename, svp.id as schedulevehiclepeopleplanid, "
		 * ) .append(" ss.id as schedulestatusid, vt.id as ") .append(
		 * " vehicletypeid, svp.planvehiclebrandmodelid as vehiclebrandmodelid,"
		 * ) .append(
		 * " sc.id as scheduleid, sc.orgid as orgid, svp.planvehicleid as planvehicleid, "
		 * ) .append(
		 * " d1.id as d1id, d2.id as d2id, d3.id as d3id, d4.id as d4id, s1.id as s1id, s2.id as s2id, "
		 * ) .append(" sc.islinework, r.id as routeid, ") .append(
		 * " (t.seatnum-t.fixedreserveseatnum-t.soldeatnum-t.autocancelreserveseatnum-t.unautocancelreserveseatnum) as reservenum, "
		 * ) .append(
		 * " ss.isdeparted,ss.status,t.issaleafterreport,t.runtime,t.worktype,dig.value as workways,t.scheduletype,"
		 * ) .append(
		 * " t.isoriginator,t.issellreturnticket,t.iscanmixcheck,vm.brandname as brandmodelname, "
		 * ) .append(" o.name orgname,vp.reporttime ") .append(
		 * " from Scheduleplan t left join vehiclereport vp ") .append(
		 * " left join vehicle vc on vc.id = vp.vehicleid ") .append(
		 * " left join organization o on o.id=vp.reportorgid on t.id = vp.scheduleplanid "
		 * ) .append(" and vp.isactive=1,Schedulestatus ss,") .append(
		 * " schedule sc, station sn , station si, route r, station so ," )
		 * .append(" schedulevehiclepeopleplan svp ") .append(
		 * " left join vehicle v on svp.planvehicleid=v.id ") .append(
		 * " left join driver d1 on svp.plandriver1id=d1.id ") .append(
		 * " left join driver d2 on svp.plandriver2id=d2.id ") .append(
		 * " left join driver d3 on svp.plandriver3id=d3.id ") .append(
		 * " left join driver d4 on svp.plandriver4id=d4.id ") .append(
		 * " left join steward s1 on svp.plansteward1id=s1.id ") .append(
		 * " left join steward s2 on svp.plansteward2id=s2.id ") .append(
		 * " left join unit un on svp.planunitid=un.id ") .append(
		 * " left join  vehiclebrandmodel vm on svp.planvehiclebrandmodelid=vm.id ,"
		 * ) .append(
		 * " vehicletype vt, digitaldictionarydetail dic, digitaldictionarydetail dig, "
		 * ) .append(" digitaldictionary digital, digitaldictionary dictionary "
		 * ) .append(" where ss.scheduleplanid=t.id ") .append(
		 * " and svp.orderno = 0 ") .append(
		 * " and (vp.orderno=(select max(orderno) from vehiclereport tt " )
		 * .append(
		 * " where tt.isactive=1 and tt.scheduleplanid=vp.scheduleplanid) or vp.id is null )"
		 * ) .append(" and t.scheduleid=sc.id and svp.scheduleplanid=t.id ")
		 * .append (
		 * " and svp.planvehicletypeid=vt.id and t.startstationid=sn.id ")
		 * .append(
		 * " and t.endstationid = si.id  and sc.routeid=r.id and ss.departstationid= so.id "
		 * ) .append(
		 * " and digital.tablename='schedulestatus' and digital.columnname='schedulestatus' "
		 * ) .append(
		 * " and dictionary.tablename='schedule' and dictionary.columnname='workways' "
		 * ) .append(
		 * " and dic.digitaldictionaryid=digital.id and dic.code=ss.status " )
		 * .append(
		 * " and dig.digitaldictionaryid=dictionary.id and dig.code=t.workways "
		 * ) .append(PropertyFilter.toJpql(propertyFilterList, true));
		 */
		/*
		 * // 修改后 Global global = CurrentUtil.getGlobal(); StringBuilder sql =
		 * new StringBuilder(
		 * "select decode(ss.departstationid,sp.startstationid,'始发班','串点班') schtype,"
		 * ) .append(
		 * " sp.autocancelreserveseatnum, sp.unautocancelreserveseatnum, ")
		 * .append(
		 * " trim(ss.departtime) as departtime,sp.id, sp.departdate,sp.seatnum, "
		 * ) .append(
		 * "  sp.fixedreserveseatnum, nvl(dep.ticketnum,sp.soldeatnum), sp.issellable, sp.workways, "
		 * )//修改已售票数，如果一个班次开了多个结算单，综合调度查询已售数每次都是所有数 .append(
		 * "  sp.districttype, sp.scheduletype, sp.isproprietary,sp.isovertime, "
		 * ) .append(
		 * "  s1.name as departname,s.code as schedulename,vrr.reportunit as unitname,s3.name as startroutename, "
		 * ) .append(
		 * "  s2.name as endroutename, ss.isbegincheck as begincheck,v.vehicleno as vehicleno, vrr.vehicleno as reportvehicleno, "
		 * ) .append(
		 * "  ss.status, ss.ticketentrance, ss.buspark,s.viastation as viastation, "
		 * ) .append(
		 * "  d1.name as driver1,d2.name as driver2,d3.name as driver3,s1.name as steward1,"
		 * ) .append(
		 * "  s2.name as steward2,vt.name as vtname,r.name as routename,sv.id as schedulevehiclepeopleplanid, "
		 * ) .append(
		 * "  ss.id as schedulestatusid,vt.id as vehicletypeid, sv.planvehiclebrandmodelid as vehiclebrandmodelid,s.id as scheduleid,"
		 * ) .append(
		 * "  s.orgid as orgid,sv.planvehicleid as planvehicleid,d1.id as d1id,d2.id as d2id,"
		 * ) .append(
		 * "  d3.id as d3id,s1.id as s1id,s2.id as s2id,sp.islinework,")
		 * .append(
		 * "  r.id as routeid,(sp.seatnum - sp.fixedreserveseatnum - sp.soldeatnum -sp.autocancelreserveseatnum - sp.unautocancelreserveseatnum) as reservenum,"
		 * ) .append(
		 * "  ss.isdeparted,sp.issaleafterreport,sp.runtime,sp.worktype,")
		 * .append(
		 * "  sp.isoriginator,sp.issellreturnticket,sp.iscanmixcheck,vm.brandname as brandmodelname,"
		 * ) .append(
		 * "  vrr.reportorg as orgname, vrr.reporttime,ss.departstationid,u1.name planunit,sp.remarks,sp.carrychildnum,trim(dep.departtime),"
		 * )//新增发班时间sp.starttime .append("   dep.departinvoicesno,") //.append(
		 * " (select dep.departinvoicesno from Departinvoices dep where dep.scheduleplanid = sp.id) departinvoicesno,"
		 * )//dep.departinvoicesno,新增结算单号， .append(
		 * "  sv.planunitid,(case when dep.departinvoicesno is null then(select count(*) from  ticketsell t where t.scheduleplanid=sp.id "
		 * ) //and t.departstationid="+curstationid .append("     and t.orgid="
		 * +global.getOrganization().getId()+" and t.ticketstatus='0') else " )
		 * .append(
		 * "   (select count(*) from  ticketsell t,departinvoices d where t.scheduleplanid=sp.id   and t.departinvoicesid=d.id  and d.departinvoicesno=dep.departinvoicesno "
		 * )// and t.departstationid="+curstationid .append("     and t.orgid="
		 * +global.getOrganization().getId()+" and t.ticketstatus='0')")
		 * .append( " end) localsell,")//修改显示的已售票数 // .append(
		 * "  (case when dep.departinvoicesno is null then (select count(*) from  ticketsell t where t.scheduleplanid=sp.id and t.departstationid<>"
		 * +curstationid) // .append("     and t.ticketstatus='0') else" ) //
		 * .append(
		 * "  (select count(*) from  ticketsell t,departinvoices d where t.scheduleplanid=sp.id   and t.departinvoicesid=d.id  and d.departinvoicesno=dep.departinvoicesno and t.departstationid<>"
		 * +curstationid) // .append("   and t.ticketstatus='0')") // .append(
		 * " end) othersell") //修改配载班次售票 本站查不到 暂时规则 用已售合计数- 本站已售的 = 其他站已售
		 * 
		 * .append(" nvl(dep.ticketnum, sp.soldeatnum) - (case ") .append(
		 * "  when dep.departinvoicesno is null then ") .append(
		 * "  (select count(*) from ticketsell t ") .append(
		 * " where t.scheduleplanid = sp.id ") .append(
		 * "    and t.ticketstatus = '0' and t.orgid="
		 * +global.getOrganization().getId()+" ) ") .append(
		 * " else  (select count(*) from ticketsell t, departinvoices d ")
		 * .append(
		 * " where t.scheduleplanid = sp.id and t.departinvoicesid = d.id ")
		 * .append("  and d.departinvoicesno = dep.departinvoicesno  ") .append(
		 * "  and t.orgid="+global.getOrganization().getId()+
		 * "  and t.ticketstatus = '0') end) as othersell ") .append(
		 * " ,sp.synccode  from Scheduleplan sp,") .append(
		 * "       (select vr.id,vr.orderno,") .append("               uf.name,"
		 * ) .append("               vr.vehicleid,") .append(
		 * "               vh.vehicleno,") .append(
		 * "               vr.reportorgid,") .append(
		 * "                vr.reporttime,") .append(
		 * "               vr.scheduleplanid,") .append(
		 * "               org.name reportorg,") .append(
		 * "           un.name reportunit,vh.unitid") .append(
		 * "   from Vehiclereport     vr,") .append(
		 * "        userinfo          uf,") .append(
		 * "        vehicle           vh,") .append(
		 * "        organization      org,") .append(
		 * "        unit              un") .append("  where vr.createby = uf.id"
		 * ) .append("    and vh.unitid = un.id") .append(
		 * "    and vr.vehicleid = vh.id") .append("    and org.stationid =" +
		 * curstationid+" and vr.departdate between :fromdate  and :enddate")
		 * .append("    and vr.reportorgid = org.id") .append(
		 * "    and vr.isactive = 1) vrr,") .append("    schedulestatus ss, ")
		 * .append(
		 * "  (select dep.scheduleplanid,dep.departinvoicesno,dep.ticketnum,trim(dep.departtime) departtime"
		 * ) .append(
		 * "   from Departinvoices dep where dep.status<>'1' and dep.departstationid = "
		 * +curstationid) .append(
		 * "   and dep.departdate between  :fromdate  and :enddate ) dep,")
		 * .append(
		 * "   schedulevehiclepeopleplan sv,schedule s,route r,station s1,")
		 * .append(
		 * "   station s2, vehicletype vt,vehicle v,unit u1,driver d1,driver d2,driver d3,steward st1,"
		 * ) .append(
		 * "   steward st2,station s3,vehiclebrandmodel vm where sp.id = ss.scheduleplanid"
		 * ) .append(" and sv.planvehiclebrandmodelid=vm.id") .append(
		 * " and sp.id = sv.scheduleplanid  and sp.id = vrr.scheduleplanid(+) and sv.orderno = 0"
		 * ) .append(
		 * " and sv.planunitid = u1.id(+)  and sv.planvehicleid = v.id(+) and sp.scheduleid = s.id"
		 * ) .append(
		 * " and vt.id = sv.planvehicletypeid  and ss.departstationid = s1.id and sp.endstationid = s2.id"
		 * ) .append(
		 * " and sp.startstationid = s3.id and s.routeid = r.id  and sv.plandriver1id = d1.id(+)"
		 * ) .append(
		 * " and sv.plandriver2id = d2.id(+)  and sv.plandriver3id = d3.id(+)  and sv.plansteward1id = st1.id(+)"
		 * ) .append(" and sv.plansteward2id = st2.id(+) ") .append(
		 * " and sp.id = dep.scheduleplanid (+) ")//新增 .append(
		 * " and (sp.islinework=0 or (sp.islinework=1 and sv.orderno=0))")
		 * .append(
		 * " and (vrr.orderno=(select max(orderno) from vehiclereport tt ")
		 * .append(
		 * " where tt.isactive=1 and tt.scheduleplanid=vrr.scheduleplanid) or vrr.id is null) "
		 * ) .append(" and (ss.departstationid ="+curstationid+
		 * " or (s.worktype='2' or s.worktype='3')) "); if(isfullseat){
		 * sql.append(
		 * "  and sp.seatnum=sp.soldeatnum+sp.autocancelreserveseatnum +sp.unautocancelreserveseatnum +sp.fixedreserveseatnum  "
		 * ); } sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		 * sql.append(" order by ss.departdate, r.id,ss.departtime");
		 * Logger.info("sql:---------->"+sql); Query query =
		 * em.createNativeQuery(sql.toString()); query.setParameter("fromdate",
		 * fromdate); query.setParameter("enddate", enddate);
		 * JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		 * Logger.info("propertyFilterList:---->"+propertyFilterList);
		 * Logger.info("size:--------->"+query.getResultList().size()); return
		 * query.getResultList();
		 */

		// 注掉之前的查询，去掉之前的查询中的结算单号字段，且已售数不再与结算单相关联。参考新疆北郊版本
		Global global = CurrentUtil.getGlobal();
		StringBuilder sql = new StringBuilder();
				/*"select decode(ss.departstationid,sp.startstationid,'始发班','串点班') schtype,")
						.append(" sp.autocancelreserveseatnum, sp.unautocancelreserveseatnum, ")
						.append(" trim(ss.departtime) as departtime,sp.id, sp.departdate,sp.seatnum, ")
						.append("  sp.fixedreserveseatnum, nvl(sp.soldeatnum, 0), sp.issellable, sp.workways, ")
						.append("  sp.districttype, sp.scheduletype, sp.isproprietary,sp.isovertime, ")
						.append("  s1.name as departname,s.code as schedulename,vrr.reportunit as unitname,s3.name as startroutename, ")
						.append("  s2.name as endroutename, ss.isbegincheck as begincheck,v.vehicleno as vehicleno, vrr.vehicleno as reportvehicleno, ")
						.append("  ss.status, ss.ticketentrance, ss.buspark,s.viastation as viastation, ")
						.append("  d1.name as driver1,d2.name as driver2,d3.name as driver3,s1.name as steward1,")
						.append("  s2.name as steward2,vt.name as vtname,r.name as routename,sv.id as schedulevehiclepeopleplanid, ")
						.append("  ss.id as schedulestatusid,vt.id as vehicletypeid, sv.planvehiclebrandmodelid as vehiclebrandmodelid,s.id as scheduleid,")
						.append("  s.orgid as orgid,sv.planvehicleid as planvehicleid,d1.id as d1id,d2.id as d2id,")
						.append("  d3.id as d3id,s1.id as s1id,s2.id as s2id,sp.islinework,")
						.append("  r.id as routeid,(sp.seatnum - sp.fixedreserveseatnum - sp.soldeatnum -sp.autocancelreserveseatnum - sp.unautocancelreserveseatnum) as reservenum,")
						.append("  ss.isdeparted,sp.issaleafterreport,sp.runtime,sp.worktype,")
						.append("  sp.isoriginator,sp.issellreturnticket,sp.iscanmixcheck,vm.brandname as brandmodelname,")
						.append("  vrr.reportorg as orgname, vrr.reporttime,ss.departstationid,u1.name planunit,sp.remarks,sp.carrychildnum,")

						.append("  trim(dep.departtime), ")// 发班时间
						.append("  dep.departinvoicesno, ")// 运量单号
						.append("  sv.planunitid,").append("  tt.localsell, ")// 已售-本站售票数
						.append("  tt.othersell ")// 已售-其他站售票数

						.append(" ,sp.synccode  from Scheduleplan sp,")
						// ----------------,tp.fullprice
						// fullprice-------------------------
						.append("       (select vr.id,vr.orderno,").append("               uf.name,")
						.append("               vr.vehicleid,").append("               vh.vehicleno,")
						.append("               vr.reportorgid,").append("                vr.reporttime,")
						.append("               vr.scheduleplanid,").append("               org.name reportorg,")
						.append("           un.name reportunit,vh.unitid").append("   from Vehiclereport     vr,")
						.append("        userinfo          uf,").append("        vehicle           vh,")
						.append("        organization      org,").append("        unit              un")
						.append("  where vr.createby = uf.id").append("    and vh.unitid = un.id")
						.append("    and vr.vehicleid = vh.id").append("    and org.stationid = ").append(curstationid)
						.append(" and vr.departdate between :fromdate  and :enddate")
						.append("    and vr.reportorgid = org.id").append("    and vr.isactive = 1) vrr,")
						.append("    schedulestatus ss, ")

						.append("  (select t.scheduleplanid, ").append("          sum(case when t.orgid = ")
						.append(global.getOrganization().getId()).append(" then 1 else 0 end) as localsell, ")
						.append("          sum(case when t.orgid = ").append(global.getOrganization().getId())
						.append(" then 0 else 1 end) as othersell ")
						.append("   from Ticketsell t where t.ticketstatus = '0'")
						.append("      and t.departdate between :fromdate  and :enddate ")
						.append("   group by t.scheduleplanid) tt, ")// 售票数据

						.append("  (select max(dep.scheduleplanid) as scheduleplanid, '' as departinvoicesno, max(trim(dep.departtime)) as departtime ")
						.append("   from Departinvoices dep where dep.status <> '1' and dep.departstationid = ")
						.append(curstationid).append("   and dep.departdate between  :fromdate  and :enddate ")
						.append("   group by dep.scheduleplanid ").append("  ) dep,") // 不再取运量单号

						.append("   schedulevehiclepeopleplan sv,schedule s,route r,station s1,")
						.append("   station s2, vehicletype vt,vehicle v,unit u1,driver d1,driver d2,driver d3,steward st1,")
						.append("   steward st2,station s3,vehiclebrandmodel vm where sp.id = ss.scheduleplanid  ")
						.append(" and sv.planvehiclebrandmodelid=vm.id")
						.append(" and sp.id = sv.scheduleplanid  and sp.id = vrr.scheduleplanid(+) and sv.orderno = 0")
						.append(" and sv.planunitid = u1.id(+)  and sv.planvehicleid = v.id(+) and sp.scheduleid = s.id")
						.append(" and vt.id = sv.planvehicletypeid  and ss.departstationid = s1.id and sp.endstationid = s2.id")
						.append(" and sp.startstationid = s3.id and s.routeid = r.id  and sv.plandriver1id = d1.id(+)")
						.append(" and sv.plandriver2id = d2.id(+)  and sv.plandriver3id = d3.id(+)  and sv.plansteward1id = st1.id(+)")
						.append(" and sv.plansteward2id = st2.id(+) ").append(" and sp.id = dep.scheduleplanid (+) ")
						.append(" and (sp.islinework=0 or (sp.islinework=1 and sv.orderno=0))")
						.append(" and (vrr.orderno=(select max(orderno) from vehiclereport tt ")
						.append(" where tt.isactive=1 and tt.scheduleplanid=vrr.scheduleplanid) or vrr.id is null) ")
						.append(" and (ss.departstationid = ").append(curstationid)
						.append(" or (s.worktype='2' or s.worktype='3')) ");*/
		
		//江西插件 综合调度是否按照发车机构来区分已售票
		//取消报班后证件审查更改status=0（未报班）扩展点----十堰插件
		ActionNode actionNode = Appvar.routes.get("JXUSEDEPORGEXPORT");// 由插件名,获得插件
		//查询是否使用了certificatecheck证件审核插件；从Appvar.routes中获取扩张点插件名、插件类、插件方法
		Boolean isusedeporg = false;
		if(actionNode!=null){
			isusedeporg = true;
		}
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
		String  begin=df.format(fromdate);
		String  end=df.format(enddate);
		sql.append(" select decode(ss.departstationid, sp.startstationid, '始发班', '串点班') schtype,")
				.append(" sp.autocancelreserveseatnum, sp.unautocancelreserveseatnum,")
				.append(" trim(ss.departtime) as departtime, sp.id,  sp.departdate,")
				.append(" sp.seatnum,sp.fixedreserveseatnum,nvl(sp.soldeatnum, 0),sp.issellable,")
				.append(" sp.workways,sp.districttype,sp.scheduletype,sp.isproprietary,sp.isovertime,")
				.append(" s1.name as departname,s.code as schedulename,vrr.reportunit as unitname, ")
				.append(" s3.name as startroutename,s2.name as endroutename,ss.isbegincheck as begincheck,   ")
				.append(" v.vehicleno as vehicleno, vrr.vehicleno as reportvehicleno,ss.status,    ")
				.append(" ss.ticketentrance,ss.buspark,s.viastation as viastation, ")
				.append(" d1.name as driver1,d2.name as driver2,d3.name as driver3,s1.name as steward1,   ")
				.append(" s2.name as steward2,vt.name as vtname,r.name as routename,  ")
				.append(" sv.id as schedulevehiclepeopleplanid,ss.id as schedulestatusid, ")
				.append(" vt.id as vehicletypeid,sv.planvehiclebrandmodelid as vehiclebrandmodelid, ")
				.append(" s.id as scheduleid,s.orgid as orgid,sv.planvehicleid as planvehicleid, ")
				.append(" d1.id as d1id,d2.id as d2id,d3.id as d3id,s1.id as s1id,s2.id as s2id,sp.islinework,r.id as routeid,  ")
				.append(" (sp.seatnum - sp.fixedreserveseatnum - sp.soldeatnum -sp.autocancelreserveseatnum - sp.unautocancelreserveseatnum) as reservenum,")
				.append(" ss.isdeparted,sp.issaleafterreport,sp.runtime,sp.worktype,sp.isoriginator,sp.issellreturnticket,")
				.append(" sp.iscanmixcheck,vm.brandname as brandmodelname,vrr.reportorg as orgname,vrr.reporttime,ss.departstationid, ")
				.append(" u1.name planunit,sp.remarks,sp.carrychildnum,                                                               ")
				.append(" trim(dep.departtime),")
				.append(" dep.departinvoicesno,")
				.append(" sv.planunitid,  ")
				.append(" tt.localsell,tt.othersell,sp.synccode,tpi.fullprice,sp.distance, ")
				.append(" decode(vrr.id,null,ss.isreported,1) as isreport,vrr.id as reportid,vrr.vehicleid as reportvehicleid,vrr.reportorgid,nvl(sc.returnallpriceflag, 0) returnallpriceflag ")
				.append(" from Scheduleplan sp left join  ")
				.append(" (select vr.id,vr.orderno,uf.name,vr.vehicleid,vh.vehicleno,vr.reportorgid,vr.reporttime, ")
				.append(" vr.scheduleplanid,org.name reportorg,un.name reportunit,vh.unitid from Vehiclereport vr, ")
				.append(" userinfo  uf,vehicle  vh,organization  org,unit  un  ")
				.append(" where vr.createby = uf.id and vh.unitid = un.id and vr.vehicleid = vh.id and org.stationid = "+curstationid )
//				.append(" and vr.departdate between :fromdate  and :enddate  and vr.reportorgid = org.id  ")
				.append(" and vr.reportorgid="+global.getOrganization().getId())
				.append(" and vr.departdate between to_date('"+begin+"','yyyymmdd')  and to_date('"+end+"','yyyymmdd') ")
				.append(" and vr.isactive = 1) vrr on sp.id = vrr.scheduleplanid ")
				.append(" left join  schedulestatus ss on sp.id = ss.scheduleplanid  ")
				.append(" left join schedulecancel sc on ss.id = sc.schedulestatusid ")//雪天停运新增schedulecancel表
				.append(" left join (select t.scheduleplanid,  ");
		
				if(!isusedeporg){
					sql.append(" sum(case when t.orgid = "+global.getOrganization().getId()+" then 1 else  0 end) as localsell,  ")
					.append(" sum(case when t.orgid = "+global.getOrganization().getId()+" then 0 else  1 end) as othersell ")
					.append(" from Ticketsell t where t.ticketstatus = '0'  ")//and t.departdate between :fromdate  and :enddate
					.append(" and t.departdate between to_date('"+begin+"','yyyymmdd')  and to_date('"+end+"','yyyymmdd') ");
				}else{
					sql.append(" sum(case when org.id = "+global.getOrganization().getId()+" then 1 else  0 end) as localsell,  ")
					.append(" sum(case when org.id = "+global.getOrganization().getId()+" then 0 else  1 end) as othersell ")
					.append(" from Ticketsell t,organization org where t.ticketstatus = '0' and org.stationid= t.departstationid   "); 
				}
				sql.append(" and t.departdate between to_date('"+begin+"','yyyymmdd')  and to_date('"+end+"','yyyymmdd') ")
				.append(" group by t.scheduleplanid) tt on sp.id = tt.scheduleplanid  ")
				.append(" left join  (select max(dep.scheduleplanid) as scheduleplanid, ")
				.append(" '' as departinvoicesno,max(to_char(dep.printtime,'hh24:mi')) as departtime from Departinvoices dep ")
				.append(" where dep.status <> '1' and dep.departstationid = "+curstationid)
				.append(" and dep.departdate between to_date('"+begin+"','yyyymmdd')  and to_date('"+end+"','yyyymmdd') ")
//				.append(" and dep.departdate between  :fromdate  and :enddate   ")
				.append(" group by dep.scheduleplanid) dep on sp.id = dep.scheduleplanid  ")
				.append(" left join  schedulevehiclepeopleplan sv on sp.id = sv.scheduleplanid and sv.orderno = 0  ")
				.append(" left join  schedule s on sp.scheduleid = s.id   ")
				.append(" left join  route r on s.routeid = r.id  ")
				.append(" left join vehicle v on sv.planvehicleid = v.id  ")
				.append(" left join  ticketprice tpi on tpi.scheduleplanid=sp.id and tpi.departstationid = r.startstationid and   tpi.reachstationid=r.endstationid and tpi.seattype=nvl(v.seattype,'0')")
				.append(" left join unit u1 on sv.planunitid = u1.id         ")
				.append(" left join  driver d1 on sv.plandriver1id = d1.id   ")
				.append(" left join  driver d2 on sv.plandriver2id = d2.id   ")
				.append(" left join  driver d3 on sv.plandriver3id = d3.id  ")
				.append(" left join  steward st1 on sv.plansteward1id = st1.id ")
				.append(" left join  steward st2 on sv.plansteward2id = st2.id,")
				.append(" station s1,station s2,vehicletype vt,station s3,vehiclebrandmodel vm  ")
				.append(" where sv.planvehiclebrandmodelid = vm.id  ")
				.append(" and vt.id = sv.planvehicletypeid and ss.departstationid = s1.id ")
				.append(" and sp.endstationid = s2.id and sp.startstationid = s3.id  ")
				.append(" and (sp.islinework = 0 or (sp.islinework = 1 and sv.orderno = 0)) ")
				.append(" and (vrr.orderno = (select max(orderno) from vehiclereport tt where tt.isactive = 1   ")
				.append(" and tt.scheduleplanid = vrr.scheduleplanid) or vrr.id is null) ")
				.append(" and (ss.departstationid = "+curstationid+" or (s.worktype = '2' or s.worktype = '3')) ");

		if (isfullseat) {
			sql.append(
					"  and sp.seatnum=sp.soldeatnum+sp.autocancelreserveseatnum +sp.unautocancelreserveseatnum +sp.fixedreserveseatnum  ");
		}
//		sql.append("  and sp.id = tt.scheduleplanid (+) ");// 关连售票数据tt
		sql.append(" and sp.departdate between to_date('"+begin+"','yyyymmdd')  and to_date('"+end+"','yyyymmdd') ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by ss.departdate, r.id,ss.departtime");

		Logger.info("综合调度查询 sql:---------->" + sql.toString());
		Query query = em.createNativeQuery(sql.toString());
//		query.setParameter("fromdate", fromdate);
//		query.setParameter("enddate", enddate);
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		Logger.info("综合调度查询 propertyFilterList:---->" + JsonUtil.parseObject(propertyFilterList));

		List list = query.getResultList();
		Logger.info("综合调度查询size:--------->" + list.size());
		return list;
	}

	public List isUnique(Long orgid, Date departdate, Long scheduleid, Long departstationid) {
		StringBuffer sql = new StringBuffer("select t from Schedulestatus t where t.orgid=");
		sql.append(orgid);
		sql.append(" and t.departdate=");
		sql.append(departdate);
		sql.append(" and t.schedule.id=");
		sql.append(scheduleid);
		sql.append(" and t.departstationid=");
		sql.append(departstationid);
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	public List isExist(Long scheduleplanid, Long departstationid) {
		StringBuffer sql = new StringBuffer("select t from Schedulestatus t where t.scheduleplan.id=");
		sql.append(scheduleplanid);
		sql.append(" and t.departstationid=");
		sql.append(departstationid);
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Schedulestatus> getSchedulestatus(Long scheduleplanid) {
		StringBuffer sql = new StringBuffer("select t from Schedulestatus t where t.scheduleplan.id=");
		sql.append(scheduleplanid);
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryTicketprice(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer("select t,st.name as departstationname,");
		sql.append(" sn.name as reachstationname, ");
		sql.append(" t.scheduleplan.id as scheduleplanid, s.code as schedulecode ");
		sql.append(" from Ticketprice t, Station st, Station sn, Schedule s ");
		sql.append(" where t.scheduleid=s.id and ");
		sql.append(" t.departstationid=st.id and t.reachstationid=sn.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public Schedulestatus getByScheduleid(long scheduleid, Date departdate, long departstationid) {
		StringBuffer sql = new StringBuffer("select t from Schedulestatus t where t.scheduleid=:scheduleid ");
		sql.append(" and t.departdate=:departdate and t.departstationid=:departstationid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("departdate", departdate);
		query.setParameter("departstationid", departstationid);
		List<Schedulestatus> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	public Schedulestatus getSchedulestatus(long scheduleplanid, long departstationid) {
		StringBuffer sql = new StringBuffer("select t from Schedulestatus t").append(" where t.scheduleplan.id=")
				.append(scheduleplanid).append(" and t.departstationid=").append(departstationid);
		return (Schedulestatus) super.uniqueResult(sql.toString());
	}

	//
	@SuppressWarnings("unchecked")
	public Schedulestatus qrySchedulestatus(Date departdate, long scheduleid, long departstationid) {
		StringBuffer sql = new StringBuffer(
				"select t from Schedulestatus t" + " where t.departstationid=:departstationid"
						+ " and t.scheduleid=:scheduleid and t.departdate=:departdate");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departstationid", departstationid);
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("departdate", departdate);
		List<Schedulestatus> sslist = query.getResultList();
		return sslist != null && sslist.size() > 0 ? sslist.get(0) : null;
	}

	public List<Schedulestatus> findCurSchedueStatus(Date departdate) {

		StringBuffer sql = new StringBuffer(
				" select t from Schedulestatus t where t.isreported=1 and t.isbegincheck=0 and t.departdate =:departdate ");

		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departdate", departdate);

		List<Schedulestatus> sslist = query.getResultList();
		return sslist;

	}

	public int updateScheduleStatus(Date departdate, String curtime) {

		StringBuffer sql = new StringBuffer(
				" update Schedulestatus t set t.isbegincheck=1 where t.isreported=1 and t.departdate = :departdate ")
						.append(" and t.departtime> :curtime ");

		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("curtime", curtime);

		return query.executeUpdate();
	}

	/**
	 * 根据发班id查询发班code
	 * 
	 * @param Scheduleid
	 * @return
	 */

	@SuppressWarnings("unchecked")
	public String queryScheduleCode(Long Scheduleid) {
		StringBuilder sql = new StringBuilder(" select t.code from Schedule t  where t.id= :id");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("id", Scheduleid);
		return (String) query.getSingleResult();
	}

}
