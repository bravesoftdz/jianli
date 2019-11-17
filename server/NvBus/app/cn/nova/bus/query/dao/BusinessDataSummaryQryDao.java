package cn.nova.bus.query.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;

@SuppressWarnings("rawtypes")
public class BusinessDataSummaryQryDao extends EntityManagerDaoSurport {
	/**
	 * 站务分公司站场业务数据情况汇总表
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryBusinessSummary(
			List<PropertyFilter> propertyFilterList) {
		String orgids = null;
		Long routeid = null;
		Date startdate = null;
		Date enddate = null;
		Date compStartdate = null;
		Date compEnddate = null;
		
		if (propertyFilterList != null && propertyFilterList.size() > 0) {
			for (int t = 0; t < propertyFilterList.size(); t++) {
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("s!orgid")) {
					orgids = (String) propertyFilterList.get(t).getMatchValue();
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
  
		StringBuffer sql = new StringBuffer();
		/**
		sql.append(" select  nvl(a.orgname, nvl(b.orgname1,nvl(c.orgname,d.orgname))) orgname,");
//		sql.append(" select  nvl(a.orgname, b.orgname1) orgname,");
		sql.append(" (to_char(:startdate,'yyyy-MM-dd') || '至' || to_char(:enddate,'yyyy-MM-dd') ||  ' 同比 ' || to_char(:compStartdate,'yyyy-MM-dd') || '至' || to_char(:compEnddate,'yyyy-MM-dd')) departdate, ");
		sql.append("   ");
		sql.append(" nvl(a.schnum, 0) schnum,nvl(b.schnum1, 0) schnum1, (nvl(a.schnum, 0) - nvl(b.schnum1, 0)) schnumComp, ");
		sql.append(" trim(to_char(case when a.schnum - nvl(b.schnum1, 0) = 0 then 0 when nvl(a.schnum, 0) - b.schnum1 = 0  ");
		sql.append(" then 0 else nvl((nvl(a.schnum, 0) - nvl(b.schnum1, 0)) / nullif(b.schnum1, 0) * 100, 100) end, '999999990.99')) || '%' schnumPercent , ");
		sql.append("   ");
		sql.append(" nvl(a.ticketnum, 0) ticketnum, ");
		sql.append(" nvl(b.ticketnum1, 0) ticketnum1,   ");
		sql.append(" (nvl(a.ticketnum, 0) - nvl(b.ticketnum1, 0)) ticketnumComp,  ");
		sql.append(" trim(to_char(case when a.ticketnum - nvl(b.ticketnum1, 0) = 0 then  0  ");
		sql.append(" when nvl(a.ticketnum, 0) - b.ticketnum1 = 0 then  0  ");
		sql.append(" else  nvl((nvl(a.ticketnum, 0) - nvl(b.ticketnum1, 0)) / nullif(b.ticketnum1, 0) * 100, 100) end, '999999990.99')) || '%' ticketnumPercent  , ");
		sql.append("   ");
		sql.append(" nvl(a.totalamount, 0) totalamount, ");
		sql.append(" nvl(b.totalamount1, 0) totalamount1, (nvl(a.totalamount, 0) - nvl(b.totalamount1, 0)) totalamountComp,  ");
		sql.append(" trim(to_char(case when a.totalamount - nvl(b.totalamount1, 0) = 0 then  0 when nvl(a.totalamount, 0) - b.totalamount1 = 0 then  0  ");
		sql.append(" else  nvl((nvl(a.totalamount, 0) - nvl(b.totalamount1, 0)) / nullif(b.totalamount1, 0) * 100, 100) end, '999999990.99')) || '%' totalamountPercent, ");
		sql.append("  ");
		//
//		sql.append(" nvl(a.peopledistance, 0) peopledistance, ");
//		sql.append(" nvl(b.peopledistance1, 0) peopledistance1, (nvl(a.peopledistance, 0) - nvl(b.peopledistance1, 0)) peopledistanceComp,  ");
//		sql.append(" trim(to_char(case when a.peopledistance - nvl(b.peopledistance1, 0) = 0 then  0 when nvl(a.peopledistance, 0) - b.peopledistance1 = 0 then  0  ");
//		sql.append(" else  nvl((nvl(a.peopledistance, 0) - nvl(b.peopledistance1, 0)) / nullif(b.peopledistance1, 0) * 100, 100) end, '999999990.99')) || '%' peopledistancePercent, ");
//		sql.append("  ");
//		sql.append(" nvl(a.rate, 0) || '%' as rate,  ");
//		sql.append(" nvl(b.rate1,0) || '%' rate1,(nvl(a.rate,0)-nvl(b.rate1,0)) rateComp, ");
//		sql.append(" trim(to_char(nvl((nvl(a.rate,0)-nvl(b.rate1,0))/    b.rate1*100,100), '999999990.99')) || '%' ratePercent, ");
		//
		sql.append(" nvl(a.peopledistance, 0) peopledistance, ");
		sql.append(" nvl(b.peopledistance1, 0) peopledistance1, (nvl(a.peopledistance, 0) - nvl(b.peopledistance1, 0)) peopledistanceComp,  ");
		sql.append(" trim(to_char(case when nvl(a.peopledistance,0) - nvl(b.peopledistance1, 0) = 0 then  0 when nvl(a.peopledistance, 0) - b.peopledistance1 = 0 then  0  ");
		sql.append(" else  nvl((nvl(a.peopledistance, 0) - nvl(b.peopledistance1, 0)) / nullif(b.peopledistance1, 0) * 100, 100) end, '999999990.99')) || '%' peopledistancePercent, ");
		sql.append("  ");
		sql.append(" nvl(a.rate, 0) || '%' as rate,  ");
		sql.append(" nvl(b.rate1,0) || '%' rate1,(nvl(a.rate,0)-nvl(b.rate1,0)) rateComp, ");
		sql.append(" trim(to_char(case when nvl(a.rate,0)-nvl(b.rate1,0)=0 then 0 else nvl((nvl(a.rate,0)-nvl(b.rate1,0))/    b.rate1*100,100) end, '999999990.99')) || '%' ratePercent, ");
		sql.append("  ");
		sql.append(" nvl(c.sellincome, 0) sellincome,nvl(d.sellincome1, 0) sellincome1, ");
		sql.append(" (nvl(c.sellincome, 0) - nvl(d.sellincome1, 0)) sellincomeComp, ");
		sql.append(" trim(to_char(case when c.sellincome - nvl(d.sellincome1, 0) = 0 then  0 when nvl(c.sellincome, 0) - d.sellincome1 = 0 then  0  ");
		sql.append(" else  nvl((nvl(c.sellincome, 0) - nvl(d.sellincome1, 0)) / nullif(d.sellincome1, 0) * 100, 100) end, '999999990.99')) || '%' sellincomePercent ");
		
//		sql.append(" nvl(a.sellincome, 0) sellincome,nvl(b.sellincome1, 0) sellincome1, ");
//		sql.append(" (nvl(a.sellincome, 0) - nvl(b.sellincome1, 0)) sellincomeComp, ");
//		sql.append(" trim(to_char(case when a.sellincome - nvl(b.sellincome1, 0) = 0 then  0 when nvl(a.sellincome, 0) - b.sellincome1 = 0 then  0  ");
//		sql.append(" else  nvl((nvl(a.sellincome, 0) - nvl(b.sellincome1, 0)) / nullif(b.sellincome1, 0) * 100, 100) end, '999999990.99')) || '%' sellincomePercent ");
	
		
		sql.append("   ");
		sql.append(" from (  ");
		sql.append("     select  c.orgid,c.orgname,  c.schnum, d.ticketnum, d.totalamount,   ");
		sql.append("     d.peopledistance,d.rate,d.sellincome  ");
		sql.append("     from (  ");
		sql.append("        select  org.id orgid,org.name as orgname ,count(distinct d.reportid) schnum ");
//		sql.append("        from departinvoices d,schedule s, scheduleplan sp,Organization org, ");
		sql.append("        from departinvoices d, schedule s, scheduleplan sp,Organization org,vehiclereport vr ");
		sql.append("        where d.scheduleid = s.id ");
//		sql.append("         and vr.id=d.reportid and vr.isactive = 1 and vr.reportorgid=vr.orgid  ");
		sql.append("         and vr.id=d.reportid and vr.isactive = 1 ");
		sql.append("        and d.scheduleplanid = sp.id and d.departdate between :startdate and :enddate  ");
		sql.append("        and d.status <> '1'  ");
//		sql.append("        and d.printway in(0,2)  ");//打单方式
		sql.append("        and sp.departdate = d.departdate and vr.reportorgid in "+orgids+"  ");
		sql.append("        and org.id=vr.reportorgid ");
		sql.append("        group by  org.id,org.name ");
		sql.append("    ) c ");
		sql.append("    left join (  ");
		sql.append("       select  org.id orgid,org.name as orgname ,count(distinct d.reportid) schnum, ");
		sql.append("       sum(d.ticketnum) ticketnum ,sum(d.totalamount) totalamount , ");
		sql.append("       sum(peopledistance) peopledistance , ");
//		sql.append("       trim(to_char((sum(peopledistance) * 100 / sum((sp.seatnum - sp.fixedreserveseatnum) * r.distance)), '999999990.99')) rate ");
		sql.append("       trim(to_char((case  sum(r.distance * (case sp.islinework  when 0 then(sp.seatnum - sp.fixedreserveseatnum) else v.seatnum   end)) when 0 then '0' else(to_char(sum(peopledistance) * 100 / sum(r.distance * (case sp.islinework  when 0 then(sp.seatnum - sp.fixedreserveseatnum) else v.seatnum   end)), '990.99')) end), '999999990.99')) rate ");
		
//		.append(" sum(case sp.islinework  when 0 then(sp.seatnum - sp.fixedreserveseatnum) else v.seatnum   end) seats,")
		
		sql.append("       ,sum(d.balanceamount) sellincome");
//		sql.append("       from departinvoices d, route r, schedule s, scheduleplan sp,Organization org, ");
		sql.append("       from departinvoices d, route r, schedule s, scheduleplan sp,Organization org,vehiclereport vr,vehicle v,  ");
		sql.append("       ( ");
		sql.append("         select dt.departinvoicesid, sum(dt.distance * dt.ticketnum) peopledistance  ");
		sql.append("         from departinvoicesdetail dt where dt.departdate between :startdate and :enddate  ");
		sql.append("         group by dt.departinvoicesid ");
		sql.append("       ) de where d.scheduleid = s.id and s.routeid = r.id and d.id = de.departinvoicesid(+)  ");
//		sql.append("         and vr.id=d.reportid and vr.isactive = 1 and vr.reportorgid=vr.orgid  ");
		sql.append("         and vr.id=d.reportid and vr.isactive = 1 ");
		sql.append("         and d.scheduleplanid = sp.id and d.departdate between :startdate and :enddate ");
		sql.append("         and d.status <> '1' and v.id=vr.vehicleid  ");
//		sql.append("        and d.printway in(0,2)  ");//打单方式
		sql.append("         and sp.departdate = d.departdate and vr.reportorgid in "+orgids+"  ");
		sql.append("         and org.id=vr.reportorgid ");
		sql.append("         group by  org.id,org.name ");
		sql.append("    ) d on c.orgid=d.orgid");
		sql.append(" ) a  ");
		sql.append("  ");
		sql.append(" full join( ");
		sql.append("      select t.orgid,org.name orgname, ");
		sql.append("      sum(t.price) sellincome ");
		sql.append("      from Ticketsell t,Organization org where org.id=t.orgid ");
		sql.append("      and t.selltime between :startdate and :enddate+1 ");
		sql.append("      and t.ticketstatus='0' and t.orgid in"+orgids+" ");
		sql.append("      group by t.orgid,org.name  ");
		sql.append(" ) c on a.orgid=c.orgid ");
		sql.append(" full join (  ");
		sql.append("     select  e.orgid,e.orgname1,  e.schnum1, f.ticketnum1, f.totalamount1,   ");
		sql.append("     f.peopledistance1,f.rate1,f.sellincome1  ");
		sql.append("     from (  ");
		sql.append("       select  org.id orgid,org.name as orgname1 ,count(distinct d.reportid) schnum1");
//		sql.append("       sum(peopledistance) peopledistance1 , ");
//		sql.append("       trim(to_char((sum(peopledistance) * 100 / sum((sp.seatnum - sp.fixedreserveseatnum) * r.distance)), '999999990.99')) rate1 ");
//		sql.append("       ,sum(d.balanceamount) sellincome1");
////		sql.append("       from departinvoices d, schedule s, scheduleplan sp,Organization org, ");
//		sql.append("       from departinvoices d, schedule s, scheduleplan sp,Organization org,vehiclereport vr, ");
//		sql.append("       ( ");
//		sql.append("         select dt.departinvoicesid, sum(dt.distance * dt.ticketnum) peopledistance  ");
//		sql.append("         from departinvoicesdetail dt where dt.departdate between :compStartdate and :compEnddate  ");
//		sql.append("         group by dt.departinvoicesid ");
//		sql.append("       ) de where d.scheduleid = s.id and d.id = de.departinvoicesid(+)  ");
//		
//		sql.append("        from departinvoices d, schedule s, scheduleplan sp,Organization org ");
		sql.append("        from departinvoices d, schedule s, scheduleplan sp,Organization org,vehiclereport vr ");
		sql.append("        where d.scheduleid = s.id");
//		sql.append("         and vr.id=d.reportid and vr.isactive = 1 and vr.reportorgid=vr.orgid  ");
		sql.append("         and vr.id=d.reportid and vr.isactive = 1 ");
		sql.append("        and d.scheduleplanid = sp.id and d.departdate between :compStartdate and :compEnddate  ");
		sql.append("        and d.status <> '1'  ");
//		sql.append("        and d.printway in(0,2)  ");//打单方式
		sql.append("        and sp.departdate = d.departdate and vr.reportorgid in "+orgids+"  ");
		sql.append("        and org.id=vr.reportorgid ");
		sql.append("        group by  org.id,org.name ");
		sql.append("    ) e ");
		sql.append("    left join (  ");
		sql.append("       select  org.id orgid,org.name as orgname1 ,count(distinct d.reportid) schnum1, ");
		sql.append("       sum(d.ticketnum) ticketnum1 ,sum(d.totalamount) totalamount1 , ");
		sql.append("       sum(peopledistance) peopledistance1 , ");
		//sql.append("       trim(to_char((sum(peopledistance) * 100 / sum((sp.seatnum - sp.fixedreserveseatnum) * r.distance)), '999999990.99')) rate1 ");
		sql.append("       trim(to_char((case  sum(r.distance * (case sp.islinework  when 0 then(sp.seatnum - sp.fixedreserveseatnum) else v.seatnum   end)) when 0 then '0' else(to_char(sum(peopledistance) * 100 / sum(r.distance * (case sp.islinework  when 0 then(sp.seatnum - sp.fixedreserveseatnum) else v.seatnum   end)), '990.99')) end), '999999990.99')) rate1 ");
		sql.append("       ,sum(d.balanceamount) sellincome1");
//		sql.append("       from departinvoices d, route r, schedule s, scheduleplan sp,Organization org, ");
		sql.append("       from departinvoices d, route r, schedule s, scheduleplan sp,Organization org,vehiclereport vr,vehicle v,  ");
		sql.append("       ( ");
		sql.append("         select dt.departinvoicesid, sum(dt.distance * dt.ticketnum) peopledistance  ");
		sql.append("         from departinvoicesdetail dt where dt.departdate between :compStartdate and :compEnddate  ");
		sql.append("         group by dt.departinvoicesid ");
		sql.append("       ) de where d.scheduleid = s.id and s.routeid = r.id and d.id = de.departinvoicesid(+)  ");

//		.append("         (select dd.departinvoicesid,sum(dd.ticketnum * dd.distance) peopledistance")
//		.append("                 from departinvoicesdetail dd")
//		.append("           where dd.departdate between :startdate and :enddate")
//		.append("          group by dd.departinvoicesid) dd")
		
//		sql.append("         and vr.id=d.reportid and vr.isactive = 1 and vr.reportorgid=vr.orgid  ");
		sql.append("         and vr.id=d.reportid and vr.isactive = 1 ");
		sql.append("         and d.scheduleplanid = sp.id and d.departdate between :compStartdate and :compEnddate  ");
		sql.append("         and d.status <> '1' and v.id=vr.vehicleid   ");
//		sql.append("         and d.printway in(0,2)  ");//打单方式
		sql.append("         and sp.departdate = d.departdate and vr.reportorgid in "+orgids+"  ");
		sql.append("         and org.id=vr.reportorgid ");
		sql.append("         group by  org.id,org.name ");
		sql.append("    ) f on e.orgid=f.orgid");
		sql.append(" ) b   ");
//		sql.append(" on nvl(a.orgid,c.orgid)=b.orgid   ");
		sql.append(" on a.orgid=b.orgid   ");
		sql.append("  ");
		sql.append(" full join( ");
		sql.append("      select t.orgid,org.name orgname, ");
		sql.append("      sum(t.price) sellincome1 ");
		sql.append("      from Ticketsell t,Organization org where org.id=t.orgid ");
		sql.append("      and t.selltime between :compStartdate and :compEnddate+1 ");
		sql.append("      and t.ticketstatus='0' and t.orgid in"+orgids+" ");
		sql.append("      group by t.orgid,org.name  ");
		sql.append(" ) d on nvl(a.orgid,nvl(b.orgid,c.orgid))=d.orgid ");
		**/

		sql.append(" select  nvl(a.orgname, nvl(b.orgname1,nvl(c.orgname,d.orgname))) orgname,");
//		sql.append(" select  nvl(a.orgname, b.orgname1) orgname,");
		sql.append(" (to_char(:startdate,'yyyy-MM-dd') || '至' || to_char(:enddate,'yyyy-MM-dd') ||  ' 同比 ' || to_char(:compStartdate,'yyyy-MM-dd') || '至' || to_char(:compEnddate,'yyyy-MM-dd')) departdate, ");
		sql.append("   ");
		sql.append(" nvl(a.schnum, 0) schnum,nvl(b.schnum1, 0) schnum1, (nvl(a.schnum, 0) - nvl(b.schnum1, 0)) schnumComp, ");
		sql.append(" trim(to_char(case when a.schnum - nvl(b.schnum1, 0) = 0 then 0 when nvl(a.schnum, 0) - b.schnum1 = 0  ");
		sql.append(" then 0 else nvl((nvl(a.schnum, 0) - nvl(b.schnum1, 0)) / nullif(b.schnum1, 0) * 100, 100) end, '999999990.99')) || '%' schnumPercent , ");
		sql.append("   ");
		sql.append(" nvl(a.ticketnum, 0) ticketnum, ");
		sql.append(" nvl(b.ticketnum1, 0) ticketnum1,   ");
		sql.append(" (nvl(a.ticketnum, 0) - nvl(b.ticketnum1, 0)) ticketnumComp,  ");
		sql.append(" trim(to_char(case when a.ticketnum - nvl(b.ticketnum1, 0) = 0 then  0  ");
		sql.append(" when nvl(a.ticketnum, 0) - b.ticketnum1 = 0 then  0  ");
		sql.append(" else  nvl((nvl(a.ticketnum, 0) - nvl(b.ticketnum1, 0)) / nullif(b.ticketnum1, 0) * 100, 100) end, '999999990.99')) || '%' ticketnumPercent  , ");
		sql.append("   ");
		sql.append(" nvl(a.totalamount, 0) totalamount, ");
		sql.append(" nvl(b.totalamount1, 0) totalamount1, (nvl(a.totalamount, 0) - nvl(b.totalamount1, 0)) totalamountComp,  ");
		sql.append(" trim(to_char(case when a.totalamount - nvl(b.totalamount1, 0) = 0 then  0 when nvl(a.totalamount, 0) - b.totalamount1 = 0 then  0  ");
		sql.append(" else  nvl((nvl(a.totalamount, 0) - nvl(b.totalamount1, 0)) / nullif(b.totalamount1, 0) * 100, 100) end, '999999990.99')) || '%' totalamountPercent, ");
		sql.append("  ");
		sql.append(" nvl(a.peopledistance, 0) peopledistance, ");
		sql.append(" nvl(b.peopledistance1, 0) peopledistance1, (nvl(a.peopledistance, 0) - nvl(b.peopledistance1, 0)) peopledistanceComp,  ");
		sql.append(" trim(to_char(case when a.peopledistance - nvl(b.peopledistance1, 0) = 0 then  0 when nvl(a.peopledistance, 0) - b.peopledistance1 = 0 then  0  ");
		sql.append(" else  nvl((nvl(a.peopledistance, 0) - nvl(b.peopledistance1, 0)) / nullif(b.peopledistance1, 0) * 100, 100) end, '999999990.99')) || '%' peopledistancePercent, ");
		sql.append("  ");
		sql.append(" nvl(a.rate, 0) || '%' as rate,  ");
		sql.append(" nvl(b.rate1,0) || '%' rate1,(nvl(a.rate,0)-nvl(b.rate1,0)) rateComp, ");
		sql.append(" trim(to_char(case when nvl(a.rate,0)-nvl(b.rate1,0)=0 then 0 else nvl((nvl(a.rate,0)-nvl(b.rate1,0))/    b.rate1*100,100) end, '999999990.99')) || '%' ratePercent, ");
		sql.append("  ");
		sql.append(" nvl(c.sellincome, 0) sellincome,nvl(d.sellincome1, 0) sellincome1, ");
		sql.append(" (nvl(c.sellincome, 0) - nvl(d.sellincome1, 0)) sellincomeComp, ");
		sql.append(" trim(to_char(case when c.sellincome - nvl(d.sellincome1, 0) = 0 then  0 when nvl(c.sellincome, 0) - d.sellincome1 = 0 then  0  ");
		sql.append(" else  nvl((nvl(c.sellincome, 0) - nvl(d.sellincome1, 0)) / nullif(d.sellincome1, 0) * 100, 100) end, '999999990.99')) || '%' sellincomePercent ");
		
//		sql.append(" nvl(a.sellincome, 0) sellincome,nvl(b.sellincome1, 0) sellincome1, ");
//		sql.append(" (nvl(a.sellincome, 0) - nvl(b.sellincome1, 0)) sellincomeComp, ");
//		sql.append(" trim(to_char(case when a.sellincome - nvl(b.sellincome1, 0) = 0 then  0 when nvl(a.sellincome, 0) - b.sellincome1 = 0 then  0  ");
//		sql.append(" else  nvl((nvl(a.sellincome, 0) - nvl(b.sellincome1, 0)) / nullif(b.sellincome1, 0) * 100, 100) end, '999999990.99')) || '%' sellincomePercent ");
	
		
		sql.append("   ");
		sql.append(" from (  ");
		sql.append("     select  c.orgid,c.orgname,  c.schnum, c.ticketnum, c.totalamount,   ");
		sql.append("     c.peopledistance,c.rate,c.sellincome  ");
		sql.append("     from (  ");
		sql.append("              select  ");
		sql.append("              orgid,orgname, ");
		sql.append("              sum(schnum) schnum,sum(seats) seats,sum(ticketnum)ticketnum, ");
		sql.append("              sum(totalamount) totalamount,sum(distance) distance, ");
		sql.append("              sum(distance * seats) as routedistance, ");
		sql.append("              sum(peopledistance) peopledistance, ");
		sql.append("              (case  sum(distance * seats) when 0 then '0' else(trim(to_char(sum(peopledistance) * 100 / sum(distance * seats), '999990.99'))) end) as rate, ");
		//sql.append("              (case  sum(distance) *sum(seats) when 0 then '0' else(to_char(sum(peopledistance) * 100 / (sum(distance) * sum(seats)), '9999990.99')) end) || '%' as rate2 ");
		sql.append("              sum(balanceamount) sellincome ");
		sql.append("              from ( ");
		sql.append("                  select org.id orgid,org.name orgname,r.name,r.distance,count(vr.id) schnum, ");
		sql.append("                      sum(sp.seatnum),sum(sp.fixedreserveseatnum), ");
		sql.append("                  sum(case sp.islinework  when 0 then(sp.seatnum - sp.fixedreserveseatnum) else v.seatnum   end) seats, ");
		sql.append("                  0 ticketnum,0 totalamount, ");
		sql.append("                  0 peopledistance ");
		sql.append("                  ,0 balanceamount ");
		sql.append("                  from vehiclereport vr,route         r,vehicle       v,  schedule      s, scheduleplan  sp,Organization org ");
		sql.append("                 where vr.scheduleplanid = sp.id ");
		sql.append("                 and s.orgid in "+orgids+" ");
		sql.append("                 and vr.reportorgid in"+orgids+" ");
		sql.append("                 and org.id=vr.reportorgid ");
		sql.append("                 and s.routeid = r.id and sp.scheduleid = s.id ");
		sql.append("                 and sp.departdate between :startdate and :enddate ");
		sql.append("                 and vr.departdate between :startdate and :enddate and vr.isdeparted=1 ");
		sql.append("                 and sp.departdate = vr.departdate and vr.vehicleid = v.id and vr.isactive = 1 ");
		sql.append("                 and vr.reportorgid = sp.orgid  group by org.id,org.name,r.id,r.name, r.distance ");
		sql.append("                 union all ");
		sql.append("                 select org.id orgid,org.name orgname,r.name,0 distance,0 schnum, ");
		sql.append("                     0,0,0 SEATS,sum(d.ticketnum) ticketnum,sum(d.totalamount) totalamount, ");
		sql.append("                 sum(nvl (dd.peopledistance,0)) peopledistance           ");
		sql.append("                 ,sum(d.balanceamount) balanceamount ");
		sql.append("                 from departinvoices d,schedule s, route r,vehicle v,organization org, ");
		sql.append("                 ( ");
		sql.append("                        select dd.departinvoicesid,sum(dd.ticketnum * dd.distance) peopledistance ");
		sql.append("                        from departinvoicesdetail dd ");
		sql.append("                        where dd.departdate between :startdate and :enddate ");
		sql.append("                        group by dd.departinvoicesid ");
		sql.append("                 ) dd ");
		sql.append("                 where d.scheduleid = s.id and s.routeid = r.id and d.status <> '1' ");
		sql.append("                 and d.vehicleid=v.id and d.id=dd.departinvoicesid(+)             ");
		sql.append("                 and s.orgid in "+orgids+" ");
		sql.append("                 and d.printorgid in"+orgids+" ");
		sql.append("                 and org.id=d.printorgid ");
		sql.append("                 and d.departdate between :startdate and :enddate ");
		sql.append("                group by org.id,org.name,r.name, r.distance ");
		sql.append("              )  ");
		sql.append("              group by orgid,orgname  order by orgname ");
		sql.append("     ) c ");
		sql.append(" ) a  ");
		sql.append("  ");
		sql.append(" full join( ");
		sql.append("      select t.orgid,org.name orgname, ");
		sql.append("      sum(t.price) sellincome ");
		sql.append("      from Ticketsell t,Organization org where org.id=t.orgid ");
		sql.append("      and t.selltime between :startdate and :enddate+1 ");
		sql.append("      and t.ticketstatus='0' and t.orgid in"+orgids+" ");
		sql.append("      group by t.orgid,org.name  ");
		sql.append(" ) c on a.orgid=c.orgid ");
		sql.append(" full join (  ");
		sql.append("     select  e.orgid,e.orgname1, e.schnum1, e.ticketnum1, e.totalamount1,   ");
		sql.append("     e.peopledistance1,e.rate1,e.sellincome1  ");
		sql.append("     from (  ");
		sql.append("              select  ");
		sql.append("              orgid,orgname1, ");
		sql.append("              sum(schnum) schnum1,sum(seats) seats1,sum(ticketnum) ticketnum1, ");
		sql.append("              sum(totalamount) totalamount1,sum(distance) distance1, ");
		sql.append("              sum(distance * seats) as routedistance1, ");
		sql.append("              sum(peopledistance) peopledistance1, ");
		sql.append("              (case  sum(distance * seats) when 0 then '0' else(trim(to_char(sum(peopledistance) * 100 / sum(distance * seats), '999990.99'))) end) as rate1, ");
		//sql.append("              (case  sum(distance) *sum(seats) when 0 then '0' else(to_char(sum(peopledistance) * 100 / (sum(distance) * sum(seats)), '9999990.99')) end) || '%' as rate2 ");
		sql.append("              sum(balanceamount) sellincome1 ");
		sql.append("              from ( ");
		sql.append("                  select org.id orgid,org.name orgname1,r.name,r.distance,count(vr.id) schnum, ");
		sql.append("                      sum(sp.seatnum),sum(sp.fixedreserveseatnum), ");
		sql.append("                  sum(case sp.islinework  when 0 then(sp.seatnum - sp.fixedreserveseatnum) else v.seatnum   end) seats, ");
		sql.append("                  0 ticketnum,0 totalamount, ");
		sql.append("                  0 peopledistance ");
		sql.append("                  ,0 balanceamount ");
		sql.append("                  from vehiclereport vr,route         r,vehicle       v,  schedule      s, scheduleplan  sp,Organization org ");
		sql.append("                 where vr.scheduleplanid = sp.id ");
		sql.append("                 and s.orgid in "+orgids+" ");
		sql.append("                 and vr.reportorgid in"+orgids+" ");
		sql.append("                 and org.id=vr.reportorgid ");
		sql.append("                 and s.routeid = r.id and sp.scheduleid = s.id ");
		sql.append("                 and sp.departdate between :compStartdate and :compEnddate ");
		sql.append("                 and vr.departdate between :compStartdate and :compEnddate and vr.isdeparted=1 ");
		sql.append("                 and sp.departdate = vr.departdate and vr.vehicleid = v.id and vr.isactive = 1 ");
		sql.append("                 and vr.reportorgid = sp.orgid  group by org.id,org.name,r.id,r.name, r.distance ");
		sql.append("                 union all ");
		sql.append("                 select org.id orgid,org.name orgname,r.name,0 distance,0 schnum, ");
		sql.append("                     0,0,0 SEATS,sum(d.ticketnum) ticketnum,sum(d.totalamount) totalamount, ");
		sql.append("                 sum(nvl (dd.peopledistance,0)) peopledistance           ");
		sql.append("                 ,sum(d.balanceamount) balanceamount ");
		sql.append("                 from departinvoices d,schedule s, route r,vehicle v,organization org, ");
		sql.append("                 ( ");
		sql.append("                        select dd.departinvoicesid,sum(dd.ticketnum * dd.distance) peopledistance ");
		sql.append("                        from departinvoicesdetail dd ");
		sql.append("                        where dd.departdate between :compStartdate and :compEnddate ");
		sql.append("                        group by dd.departinvoicesid ");
		sql.append("                 ) dd ");
		sql.append("                 where d.scheduleid = s.id and s.routeid = r.id and d.status <> '1' ");
		sql.append("                 and d.vehicleid=v.id and d.id=dd.departinvoicesid(+)             ");
		sql.append("                 and s.orgid in "+orgids+" ");
		sql.append("                 and d.printorgid in"+orgids+" ");
		sql.append("                 and org.id=d.printorgid ");
		sql.append("                 and d.departdate between :compStartdate and :compEnddate ");
		sql.append("                group by org.id,org.name,r.name, r.distance ");
		sql.append("              )  ");
		sql.append("              group by orgid,orgname1  order by orgname1 ");
		sql.append("     ) e  ");
		sql.append(" ) b   ");
//		sql.append(" on nvl(a.orgid,c.orgid)=b.orgid   ");
		sql.append(" on a.orgid=b.orgid   ");
		sql.append("  ");
		sql.append(" full join( ");
		sql.append("      select t.orgid,org.name orgname, ");
		sql.append("      sum(t.price) sellincome1 ");
		sql.append("      from Ticketsell t,Organization org where org.id=t.orgid ");
		sql.append("      and t.selltime between :compStartdate and :compEnddate+1 ");
		sql.append("      and t.ticketstatus='0' and t.orgid in"+orgids+" ");
		sql.append("      group by t.orgid,org.name  ");
		sql.append(" ) d on nvl(a.orgid,nvl(b.orgid,c.orgid))=d.orgid ");
		
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		query.setParameter("compStartdate", compStartdate);
		query.setParameter("compEnddate", compEnddate);

		List<Object> list = query.getResultList();
		return list;
	}
}
