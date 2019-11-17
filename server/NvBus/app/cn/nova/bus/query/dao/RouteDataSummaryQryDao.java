package cn.nova.bus.query.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;

/**
 * <b>类描述： 站务分公司班线数据情况汇总表</b><br/>
 * <b>类名称：</b>RouteDataSummaryQryDao.java<br/>
 * <b>创建人：</b><a href="mailto:qinzhikai@nova.net.cn">覃智开</a><br/>
 * <b>创建时间：</b>2012-4-28 <br/>
 * <b>关键修改：修改班次数不对和，除数为O 的错误</b><br/>
 * <b>修改人：hhz</b><br/>
 */
@SuppressWarnings("rawtypes")
public class RouteDataSummaryQryDao extends EntityManagerDaoSurport {
	/**
	 * 站务分公司班线数据情况汇总表
	 * 
	 * @param propertyFilterList
	 * @param isbynormal
	 * @param isbylatter
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryRouteDataSummary(
			List<PropertyFilter> propertyFilterList, boolean isbynormal,
			boolean isbylatter) {
		String reportorgids = null;
		String schorgids = null;
		Long routeid = null;
		Date startdate = null;
		Date enddate = null;
		Date compStartdate = null;
		Date compEnddate = null;
		if (propertyFilterList != null && propertyFilterList.size() > 0) {
			for (int t = 0; t < propertyFilterList.size(); t++) {
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("s!orgid")) {
					schorgids = (String) propertyFilterList.get(t).getMatchValue();
					continue;
				}
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("vr!reportorgid")) {
					reportorgids = (String) propertyFilterList.get(t).getMatchValue();
					continue;
				}
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("r!id")) {
					routeid = (Long) propertyFilterList.get(t).getMatchValue();
					continue;
				}
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("p!startdate")) {
					startdate = (Date) propertyFilterList.get(t)
							.getMatchValue();
					continue;
				}
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("p!enddate")) {
					enddate = (Date) propertyFilterList.get(t).getMatchValue();
					continue;
				}
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("c!compSdate")) {
					compStartdate = (Date) propertyFilterList.get(t)
							.getMatchValue();
					continue;
				}
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("c!compEdate")) {
					compEnddate = (Date) propertyFilterList.get(t)
							.getMatchValue();
					continue;
				}
			}
		}

		String isovertime = "0,1";
		if (isbylatter && isbynormal) {
			isovertime = "0,1";
		} else if (isbylatter) {
			// 加班
			isovertime = "1";
		} else if (isbynormal) {
			// 正班
			isovertime = "0";
		} else {
			isovertime = "0,1";
		}
		StringBuffer sql = new StringBuffer();
		/**sql.append(" select  nvl(a.orgname, b.orgname1) orgname,nvl(a.routename, b.routename) routename,(to_char(:startdate,'yyyy-MM-dd') || '至' || to_char(:enddate,'yyyy-MM-dd') ||  ' 同比 ' || to_char(:compStartdate,'yyyy-MM-dd') || '至' || to_char(:compEnddate,'yyyy-MM-dd')) departdate, ");
		sql.append(" nvl(a.schnum, 0) schnum,nvl(b.schnum1, 0) schnum1, (nvl(a.schnum, 0) - nvl(b.schnum1, 0)) schnumComp, ");
		sql.append(" trim(to_char(case when a.schnum - nvl(b.schnum1, 0) = 0 then 0 when nvl(a.schnum, 0) - b.schnum1 = 0  ");
		sql.append(" then 0 else nvl((nvl(a.schnum, 0) - nvl(b.schnum1, 0)) / nullif(b.schnum1, 0) * 100, 100) end, '999999990.99')) || '%' schnumPercent , ");
		sql.append(" nvl(a.ticketnum, 0) ticketnum, ");
		sql.append(" nvl(b.ticketnum1, 0) ticketnum1,   ");
		sql.append(" (nvl(a.ticketnum, 0) - nvl(b.ticketnum1, 0)) ticketnumComp,  ");
		sql.append(" trim(to_char(case when a.ticketnum - nvl(b.ticketnum1, 0) = 0 then  0  ");
		sql.append(" when nvl(a.ticketnum, 0) - b.ticketnum1 = 0 then  0  ");
		sql.append(" else  nvl((nvl(a.ticketnum, 0) - nvl(b.ticketnum1, 0)) / nullif(b.ticketnum1, 0) * 100, 100) end, '999999990.99')) || '%' ticketnumPercent  , ");
		sql.append("  ");
		sql.append(" nvl(a.totalamount, 0) totalamount, ");
		sql.append(" nvl(b.totalamount1, 0) totalamount1, (nvl(a.totalamount, 0) - nvl(b.totalamount1, 0)) totalamountComp,  ");
		sql.append(" trim(to_char(case when a.totalamount - nvl(b.totalamount1, 0) = 0 then  0 when nvl(a.totalamount, 0) - b.totalamount1 = 0 then  0  ");
		sql.append(" else  nvl((nvl(a.totalamount, 0) - nvl(b.totalamount1, 0)) / nullif(b.totalamount1, 0) * 100, 100) end, '999999990.99')) || '%' totalamountPercent, ");
		sql.append("  ");
		sql.append(" nvl(a.peopledistance, 0) peopledistance, ");
		sql.append(" nvl(b.peopledistance1, 0) peopledistance1, (nvl(a.peopledistance, 0) - nvl(b.peopledistance1, 0)) peopledistanceComp,  ");
		sql.append(" trim(to_char(case when nvl(a.peopledistance,0) - nvl(b.peopledistance1, 0) = 0 then  0 when nvl(a.peopledistance, 0) - b.peopledistance1 = 0 then  0  ");
		sql.append(" else  nvl((nvl(a.peopledistance, 0) - nvl(b.peopledistance1, 0)) / nullif(b.peopledistance1, 0) * 100, 100) end, '999999990.99')) || '%' peopledistancePercent, ");
		sql.append("  ");
		sql.append(" nvl(a.rate, 0) || '%' as rate,  ");
		sql.append(" nvl(b.rate1,0) || '%' rate1,(nvl(a.rate,0)-nvl(b.rate1,0)) rateComp, ");
		sql.append(" trim(to_char(case when nvl(a.rate,0)-nvl(b.rate1,0)=0 then 0 else nvl((nvl(a.rate,0)-nvl(b.rate1,0))/    b.rate1*100,100) end, '999999990.99')) || '%' ratePercent ");
		sql.append(" from (  ");
		sql.append("     select  c.orgid,c.orgname,  c.schnum, d.ticketnum, d.totalamount,   ");
		sql.append("        d.peopledistance,  ");
		sql.append("     d.rate,d.routeid,d.routename ");
		sql.append("     from (  ");
		sql.append("         select  org.id orgid,org.name as orgname ,count(distinct d.reportid) schnum ");
		sql.append("         ,r.id as routeid,r.name as routename ");
//		sql.append("         from departinvoices d, route r, schedule s, scheduleplan sp,Organization org, ");
		sql.append("         from departinvoices d, route r, schedule s, scheduleplan sp,Organization org,vehiclereport vr ");
		sql.append("         where d.scheduleid = s.id and s.routeid = r.id  ");
//		sql.append("         and vr.id=d.reportid and vr.isactive = 1 and vr.reportorgid=vr.orgid  ");
		sql.append("         and vr.id=d.reportid and vr.isactive = 1 ");
//		sql.append("        and d.printway in(0,2)  ");//打单方式
		sql.append("         and d.scheduleplanid = sp.id and d.departdate between :startdate and :enddate ");
		sql.append("         and d.status <> '1'  ");
		sql.append("         and sp.departdate = d.departdate and vr.reportorgid in "+reportorgids+"  ");
		sql.append("         and org.id=vr.reportorgid ");
		sql.append("         and s.isovertime in("+isovertime+") ");
		if(routeid!=null && routeid>0){
			sql.append("   and r.id ="+routeid);	
		}
		sql.append("         group by  org.id,org.name,r.id,r.name ");
		sql.append("    ) c ");
		sql.append("     left join (  ");
		sql.append("       select  org.id orgid,org.name as orgname ,count(distinct d.reportid) schnum, ");
		sql.append("       sum(d.ticketnum) ticketnum ,sum(d.totalamount) totalamount , ");
		sql.append("       sum(peopledistance) peopledistance , ");
		sql.append("       trim(to_char((sum(peopledistance) * 100 / sum((sp.seatnum - sp.fixedreserveseatnum) * r.distance)), '999999990.99')) rate ");
		sql.append("       ,r.id as routeid,r.name as routename ");
//		sql.append("       from departinvoices d, route r, schedule s, scheduleplan sp,Organization org, ");
		sql.append("       from departinvoices d, route r, schedule s, scheduleplan sp,Organization org,vehiclereport vr, ");
		sql.append("       ( ");
		sql.append("         select dt.departinvoicesid, sum(dt.distance * dt.ticketnum) peopledistance  ");
		sql.append("         from departinvoicesdetail dt where dt.departdate between :startdate and :enddate ");
		sql.append("         group by dt.departinvoicesid ");
		sql.append("       ) de where d.scheduleid = s.id and s.routeid = r.id and d.id = de.departinvoicesid(+)  ");
//		sql.append("         and vr.id=d.reportid and vr.isactive = 1 and vr.reportorgid=vr.orgid  ");
		sql.append("         and vr.id=d.reportid and vr.isactive = 1 ");
//		sql.append("         and d.printway in(0,2)  ");//打单方式
		sql.append("         and d.scheduleplanid = sp.id and d.departdate between :startdate and :enddate  ");
		sql.append("         and d.status <> '1'  ");
		sql.append("         and sp.departdate = d.departdate and vr.reportorgid in "+reportorgids+"  ");
		sql.append("         and org.id=vr.reportorgid ");
		sql.append("         and s.isovertime in("+isovertime+") ");
		if(routeid!=null && routeid>0){
			sql.append("   and r.id ="+routeid);	
		}
		sql.append("         group by  org.id,org.name,r.id,r.name ");
		sql.append("    ) d on c.orgid=d.orgid and c.routeid=d.routeid ");
		sql.append(" ) a  ");
		sql.append("    ");
		sql.append(" full join (  ");
		sql.append("     select  e.orgid,e.orgname1,  e.schnum1, f.ticketnum1, f.totalamount1,   ");
		sql.append("        f.peopledistance1,  ");
		sql.append("     f.rate1,f.routeid,f.routename ");
		sql.append("     from (  ");
		sql.append("       select  org.id orgid,org.name as orgname1 ,count(distinct d.reportid) schnum1, ");
		sql.append("       sum(d.ticketnum) ticketnum1 ,sum(d.totalamount) totalamount1 , ");
		sql.append("       sum(peopledistance) peopledistance1 , ");
		sql.append("       trim(to_char((sum(peopledistance) * 100 / sum((sp.seatnum - sp.fixedreserveseatnum) * r.distance)), '999999990.99')) rate1 ");
		sql.append("       ,r.id as routeid,r.name as routename ");
//		sql.append("       from departinvoices d, route r, schedule s, scheduleplan sp,Organization org, ");
		sql.append("       from departinvoices d, route r, schedule s, scheduleplan sp,Organization org,vehiclereport vr, ");
		sql.append("       ( ");
		sql.append("         select dt.departinvoicesid, sum(dt.distance * dt.ticketnum) peopledistance  ");
		sql.append("         from departinvoicesdetail dt where dt.departdate between :compStartdate and :compEnddate ");
		sql.append("         group by dt.departinvoicesid ");
		sql.append("       ) de where d.scheduleid = s.id and s.routeid = r.id and d.id = de.departinvoicesid(+)  ");
//		sql.append("         and vr.id=d.reportid and vr.isactive = 1 and vr.reportorgid=vr.orgid  ");
		sql.append("         and vr.id=d.reportid and vr.isactive = 1 ");
//		sql.append("        and d.printway in(0,2)  ");//打单方式
		sql.append("         and d.scheduleplanid = sp.id and d.departdate between :compStartdate and :compEnddate  ");
		sql.append("         and d.status <> '1'  ");
		sql.append("         and sp.departdate = d.departdate and vr.reportorgid in "+reportorgids+"  ");
		sql.append("         and org.id=vr.reportorgid ");
		sql.append("         and s.isovertime in("+isovertime+") ");
		if(routeid!=null && routeid>0){
			sql.append("   and r.id ="+routeid);	
		}
		sql.append("         group by  org.id,org.name,r.id,r.name ");
		sql.append("    ) e ");
		sql.append("     left join (  ");
		sql.append("       select  org.id orgid,org.name as orgname1 ,count(distinct d.reportid) schnum1, ");
		sql.append("       sum(d.ticketnum) ticketnum1 ,sum(d.totalamount) totalamount1 , ");
		sql.append("       sum(peopledistance) peopledistance1 , ");
		sql.append("       trim(to_char((sum(peopledistance) * 100 / sum((sp.seatnum - sp.fixedreserveseatnum) * r.distance)), '999999990.99')) rate1 ");
		sql.append("       ,r.id as routeid,r.name as routename ");
//		sql.append("       from departinvoices d, route r, schedule s, scheduleplan sp,Organization org, ");
		sql.append("       from departinvoices d, route r, schedule s, scheduleplan sp,Organization org,vehiclereport vr, ");
		sql.append("       ( ");
		sql.append("         select dt.departinvoicesid, sum(dt.distance * dt.ticketnum) peopledistance  ");
		sql.append("         from departinvoicesdetail dt where dt.departdate between :compStartdate and :compEnddate ");
		sql.append("         group by dt.departinvoicesid ");
		sql.append("       ) de where d.scheduleid = s.id and s.routeid = r.id and d.id = de.departinvoicesid(+)  ");
//		sql.append("         and vr.id=d.reportid and vr.isactive = 1 and vr.reportorgid=vr.orgid  ");
		sql.append("         and vr.id=d.reportid and vr.isactive = 1 ");
//		sql.append("        and d.printway in(0,2)  ");//打单方式
		sql.append("         and d.scheduleplanid = sp.id and d.departdate between :compStartdate and :compEnddate  ");
		sql.append("         and d.status <> '1'  ");
		sql.append("         and sp.departdate = d.departdate and vr.reportorgid in "+reportorgids+"  ");
		sql.append("         and org.id=vr.reportorgid ");
		sql.append("         and s.isovertime in("+isovertime+") ");
		if(routeid!=null && routeid>0){
			sql.append("   and r.id ="+routeid);	
		}
		sql.append("         group by  org.id,org.name,r.id,r.name ");
		sql.append("    ) f on e.orgid=f.orgid and e.routeid=f.routeid ");
		sql.append(" ) b   ");
		sql.append(" on nvl(a.orgid,b.orgid)=b.orgid and a.routeid=b.routeid ");
		sql.append(" order by nvl(a.orgname, b.orgname1) ,nvl(a.routename, b.routename) ");**/
		
		sql.append("select nvl(a.sorgname, b.sorgname1) orgname,");
		if(reportorgids!=null){
			sql.append(" nvl(a.rporgname, b.rporgname1) rporgname,");
		}else{
			sql.append(" '' rporgname,");
		}				
		sql.append(" nvl(a.routename, b.routename) routename,")
		.append(" (to_char(:startdate, 'yyyy-MM-dd') || '至' ||")
		.append(" to_char(:enddate, 'yyyy-MM-dd') || ' 同比 ' ||")
		.append(" to_char(:compStartdate, 'yyyy-MM-dd') || '至' ||")
		.append(" to_char(:compEnddate, 'yyyy-MM-dd')) departdate,")
		.append(" nvl(a.schnum, 0) schnum,")
		.append(" nvl(b.schnum1, 0) schnum1,")
		.append(" (nvl(a.schnum, 0) - nvl(b.schnum1, 0)) schnumComp,")
		.append(" trim(to_char(case")
		.append(" when a.schnum - nvl(b.schnum1, 0) = 0 then 0")
		.append(" when nvl(a.schnum, 0) - b.schnum1 = 0 then 0")
		.append(" else decode(b.schnum1,0,0,nvl((nvl(a.schnum, 0) - nvl(b.schnum1, 0)) / b.schnum1 * 100,")
		.append(" 100)) end, '999999990.99')) || '%' schnumPercent,")
		.append(" nvl(a.ticketnum, 0) ticketnum,")
		.append(" nvl(b.ticketnum1, 0) ticketnum1,")
		.append(" (nvl(a.ticketnum, 0) - nvl(b.ticketnum1, 0)) ticketnumComp,")
		.append(" trim(to_char(case")
		.append(" when a.ticketnum - nvl(b.ticketnum1, 0) = 0 then 0")
		.append(" when nvl(a.ticketnum, 0) - b.ticketnum1 = 0 then 0")
		.append(" else decode(b.ticketnum1,0,0,nvl((nvl(a.ticketnum, 0) - nvl(b.ticketnum1, 0)) / b.ticketnum1 * 100, 100))")
		.append(" end, '999999990.99')) || '%' ticketnumPercent,")
		.append(" nvl(a.totalamount, 0) totalamount,")
		.append(" nvl(b.totalamount1, 0) totalamount1,")
		.append(" (nvl(a.totalamount, 0) - nvl(b.totalamount1, 0)) totalamountComp,")
		.append(" trim(to_char(case")
		.append(" when a.totalamount - nvl(b.totalamount1, 0) = 0 then 0")
		.append(" when nvl(a.totalamount, 0) - b.totalamount1 = 0 then 0")
		.append(" else decode(b.totalamount1,0,0,nvl((nvl(a.totalamount, 0) - nvl(b.totalamount1, 0)) / b.totalamount1 * 100, 100)) end,")
		.append(" '999999990.99')) || '%' totalamountPercent,")
		.append(" nvl(a.peopledistance, 0) peopledistance,")
		.append(" nvl(b.peopledistance1, 0) peopledistance1,")
		.append(" (nvl(a.peopledistance, 0) - nvl(b.peopledistance1, 0)) peopledistanceComp,")
		.append(" trim(to_char(case")
		.append("  when nvl(a.peopledistance, 0) - nvl(b.peopledistance1, 0) = 0 then 0")
		.append(" when nvl(a.peopledistance, 0) - b.peopledistance1 = 0 then 0")
		.append(" else decode(b.peopledistance1,0,0,nvl((nvl(a.peopledistance, 0) - nvl(b.peopledistance1, 0)) / b.peopledistance1 * 100, 100))")
		.append(" end, '999999990.99')) || '%' peopledistancePercent,")
		.append(" nvl(a.rate, 0) || '%' as rate,")
		.append(" nvl(b.rate1, 0) || '%' rate1,")
		.append(" nvl(a.rate, 0) - nvl(b.rate1, 0) rateComp,")
		.append(" trim(to_char(case")
		.append(" when nvl(a.rate, 0) - nvl(b.rate1, 0) = 0 then 0")
		.append(" else decode(b.rate1,0,0,nvl((nvl(a.rate, 0) - nvl(b.rate1, 0)) / b.rate1 * 100, 100)) end, '999999990.99')) || '%' ratePercent")
		.append(" from (  ")
				.append(" select sorgname,routename,");
		        if (reportorgids!=null){
		        	sql.append("rporgname,");
		        }
				sql.append(" sum(schnum) schnum,")
				.append(" sum(seats) seats,")
				.append(" sum(ticketnum) ticketnum,")
				.append(" sum(totalamount) totalamount,")
				.append(" sum(peopledistance) peopledistance,")
				.append(" (case sum(distance * seats)")
				.append(" when 0 then '0'")
				.append(" else (to_char(sum(peopledistance) * 100 / sum(distance * seats),")
				.append(" '990.99')) end)  as rate")
				.append(" from (select so.name sorgname,r.name routename,");
						 if (reportorgids!=null){
							sql.append("rporg.name rporgname,"); 
						 }
						sql.append(" r.distance,")
						.append(" count(vr.id) schnum,")
						.append(" sum(case sp.islinework")
						.append(" when 0 then")
						.append(" (sp.seatnum - sp.fixedreserveseatnum)")
						.append(" else v.seatnum end) seats,")
						.append(" 0 ticketnum,")
						.append(" 0 totalamount,")
						.append(" 0 peopledistance")
						.append(" from vehiclereport vr,")
						.append(" route r,")
						.append(" vehicle v,")
						.append(" schedule s,")
						.append(" organization so,")
						.append(" organization rporg,")
						.append(" scheduleplan sp,")
						.append(" (select d.reportid from departinvoices d")
						.append(" where d.status <> '1'")
						.append(" group by d.reportid) d")
						.append(" where vr.scheduleplanid = sp.id")
						.append(" and vr.id = d.reportid")
						.append(" and vr.reportorgid=rporg.id")
						.append(" and s.orgid in "+schorgids);
						if (reportorgids!=null){
							sql.append(" and vr.reportorgid in "+reportorgids);
							
						}
						if(routeid!=null && routeid>0){
							sql.append(" and r.id ="+routeid);	
						}
						sql.append(" and s.isovertime in("+isovertime+") ")
						.append(" and s.orgid=so.id")
						.append(" and s.routeid = r.id")
						.append(" and sp.scheduleid = s.id")
						.append(" and sp.departdate between :startdate  and :enddate")
						.append(" and vr.isdeparted = 1")
						.append(" and sp.departdate = vr.departdate")
						.append(" and vr.vehicleid = v.id")
						.append(" and vr.isactive = 1")
						.append(" and vr.reportorgid = sp.orgid")
						.append(" group by so.name,r.name, r.distance");
						if (reportorgids!=null){
							sql.append(",rporg.name");
						}
						sql.append(" union all")
						.append(" select so.name sorgname,r.name routename,");
						if (reportorgids!=null){
							sql.append("rporg.name rporgname,");
						}
						sql.append(" r.distance,")
						.append(" 0 schnum,")
						.append(" 0 SEATS,")
						.append(" sum(d.ticketnum) ticketnum,")
						.append(" sum(d.totalamount) totalamount,")
						.append(" sum(nvl(dd.peopledistance, 0)) peopledistance")
						.append(" from departinvoices d,")
						.append(" schedule s,")
						.append(" organization so,")
						.append(" organization rporg,")
						.append(" vehiclereport vr,")
						.append(" route r,")
						.append(" vehicle v,")
						.append(" (select dd.departinvoicesid,")
						.append(" sum(dd.ticketnum * dd.distance) peopledistance")
						.append(" from departinvoicesdetail dd")
						.append(" where dd.departdate between :startdate  and :enddate")
						.append(" group by dd.departinvoicesid) dd")
						.append(" where d.scheduleid = s.id")
						.append(" and s.routeid = r.id")
						.append(" and d.status <> '1'")
						.append(" and d.vehicleid = v.id")
						.append(" and d.id = dd.departinvoicesid(+)")
						.append(" and s.orgid in "+schorgids)
						.append(" and s.isovertime in("+isovertime+") ")
						.append(" and s.orgid=so.id")
						.append(" and d.reportid=vr.id")
						.append(" and rporg.id=vr.reportorgid");
						if (reportorgids!=null){
							sql.append(" and vr.reportorgid in "+reportorgids);
							
						}
						if(routeid!=null && routeid>0){
							sql.append(" and r.id ="+routeid);	
						}
						sql.append(" and d.departdate between :startdate  and :enddate");
						if (reportorgids!=null){
							sql.append(" group by so.name,rporg.name,r.name, r.distance)")
							.append(" group by sorgname,rporgname,routename")
							.append(" order by sorgname,rporgname,routename )a")
							.append(" full join (")
							.append(" select sorgname1,rporgname1,routename,");
						}else{
							sql.append(" group by so.name,r.name, r.distance)")
							.append(" group by sorgname,routename")
							.append(" order by sorgname,routename )a")
							.append(" full join (")
							.append(" select sorgname1,routename,");
						}
						sql.append(" sum(schnum) schnum1,")
						.append(" sum(seats) seats,")
						.append(" sum(ticketnum) ticketnum1,")
						.append(" sum(totalamount) totalamount1,")
						.append(" sum(peopledistance) peopledistance1,")
						.append(" (case sum(distance * seats)")
						.append(" when 0 then '0' else")
						.append(" (to_char(sum(peopledistance) * 100 / sum(distance * seats),")
						.append(" '990.99'))")
						.append(" end) as rate1")
						.append(" from (select so.name sorgname1,r.name routename,");
						if (reportorgids!=null){
							sql.append("rporg.name rporgname1,");
						}
						sql.append(" r.distance,")
						.append(" count(vr.id) schnum,")
						.append(" sum(case sp.islinework")
						.append(" when 0 then")
						.append(" (sp.seatnum - sp.fixedreserveseatnum)")
						.append(" else v.seatnum end) seats,")
						.append(" 0 ticketnum,")
						.append(" 0 totalamount,")
						.append(" 0 peopledistance")
						.append(" from vehiclereport vr,")
						.append(" route r,")
						.append(" vehicle v,")
						.append(" schedule s,")
						.append(" organization so,")
						.append(" organization rporg,")
						.append(" scheduleplan sp,")
						.append(" (select d.reportid")
						.append(" from departinvoices d")
						.append(" where d.status <> '1'")
						.append(" group by d.reportid) d")
						.append(" where vr.scheduleplanid = sp.id")
						.append(" and vr.id = d.reportid")
						.append(" and vr.reportorgid=rporg.id")
						.append(" and s.orgid in "+schorgids)
						.append(" and s.isovertime in ("+isovertime+") ");
						if (reportorgids!=null){
							sql.append(" and vr.reportorgid in "+reportorgids);
							
						}
						if(routeid!=null && routeid>0){
							sql.append(" and r.id ="+routeid);	
						}
						sql.append(" and s.orgid=so.id")
						.append(" and s.routeid = r.id")
						.append(" and sp.scheduleid = s.id")
						.append(" and sp.departdate between :compStartdate  and :compEnddate")
						.append(" and vr.isdeparted = 1")
						.append(" and sp.departdate = vr.departdate")
						.append(" and vr.vehicleid = v.id")
						.append(" and vr.isactive = 1")
						.append(" and vr.reportorgid = sp.orgid")
						.append(" group by so.name,r.name, r.distance");
						if (reportorgids!=null){
							sql.append(",rporg.name")
							   .append(" union all")
							   .append(" select so.name sorgname,r.name routename,rporg.name rporgname,");
						}else{
							sql.append(" union all")
							   .append(" select so.name sorgname,r.name routename,");							
						}
						sql.append(" r.distance,")
						.append(" 0 schnum,")
						.append(" 0 SEATS,")
						.append(" sum(d.ticketnum) ticketnum,")
						.append(" sum(d.totalamount) totalamount,")
						.append(" sum(nvl(dd.peopledistance, 0)) peopledistance")
						.append(" from departinvoices d,")
						.append(" schedule s,")
						.append(" organization so,")
						.append(" organization rporg,")
						.append(" vehiclereport vr,")
						.append(" route r,")
						.append(" vehicle v,")
						.append(" (select dd.departinvoicesid,")
						.append(" sum(dd.ticketnum * dd.distance) peopledistance")
						.append("  from departinvoicesdetail dd")
						.append(" where dd.departdate between :compStartdate and :compEnddate")
						.append(" group by dd.departinvoicesid) dd")
						.append(" where d.scheduleid = s.id")
						.append(" and s.routeid = r.id")
						.append(" and d.status <> '1'")
						.append(" and d.vehicleid = v.id")
						.append(" and d.id = dd.departinvoicesid(+)")
						.append(" and s.orgid in "+schorgids)
						.append(" and s.isovertime in("+isovertime+") ")
						.append(" and s.orgid=so.id")
						.append(" and d.reportid=vr.id")
						.append(" and rporg.id=vr.reportorgid");
						if (reportorgids!=null){
							sql.append(" and vr.reportorgid in "+reportorgids);							
						}
						if(routeid!=null && routeid>0){
							sql.append(" and r.id ="+routeid);	
						}
						sql.append(" and d.departdate between :compStartdate  and :compEnddate");
						if (reportorgids!=null){
							sql.append(" group by so.name,rporg.name,r.name, r.distance)")
							.append(" group by sorgname1,rporgname1,routename")
							.append(" order by sorgname1,rporgname1,routename )b")
							.append(" on a.sorgname=b.sorgname1 and a.rporgname=b.rporgname1 and a.routename=b.routename");
						}else{
							sql.append(" group by so.name,r.name, r.distance)")
							.append(" group by sorgname1,routename")
							.append(" order by sorgname1,routename )b")
							.append(" on a.sorgname=b.sorgname1 and a.routename=b.routename");
						}
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		query.setParameter("compStartdate", compStartdate);
		query.setParameter("compEnddate", compEnddate);
		List<Object> list = query.getResultList();
		return list;
	}
}
