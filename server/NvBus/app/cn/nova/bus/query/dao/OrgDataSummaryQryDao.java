package cn.nova.bus.query.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;

@SuppressWarnings("rawtypes")
public class OrgDataSummaryQryDao extends EntityManagerDaoSurport {

	/**
	 * 站务作业统计报表 
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> query(String orgids,Date startdate,Date enddate,Date compStartdate,Date compEnddate,
			Date accstartdate,Date accenddate,Date acccompStartdate,Date acccompEnddate) {

		StringBuffer sb = new StringBuffer();

		//按运量指标表统计班次、客运量、周转量  售票营收
		sb.append(" select  ");
		sb.append(" 0 sort ,decode(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname))),NULL,'0',1) sort2, ");
		sb.append(" '班次(班)' rowname, ");
		sb.append(" decode(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname))),NULL,'合计',nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname)))) orgname, ");
		sb.append(" nvl(sum(a.schnum),0) schnum,nvl(sum(b.schnum1),0) schnum1, ");
		sb.append(" nvl(sum(a.schnum),0)-nvl(sum(b.schnum1),0) schnumComp, ");
		sb.append(" trim(to_char(case when nvl(sum(a.schnum),0)-nvl(sum(b.schnum1),0)=0 then 0  ");
		sb.append("     else nvl((nvl(sum(a.schnum),0)-nvl(sum(b.schnum1),0))/ ");
		sb.append("     sum(b.schnum1)*100,100) end, '999999990.99')) || '%' schnumPercent, ");
		sb.append("      ");
		sb.append(" nvl(sum(c.accschnum),0) accschnum,nvl(sum(d.accschnum1),0) accschnum1, ");
		sb.append(" nvl(sum(c.accschnum),0)-nvl(sum(d.accschnum1),0) accschnumComp, ");
		sb.append(" trim(to_char(case when nvl(sum(c.accschnum),0)-nvl(sum(d.accschnum1),0)=0 then 0  ");
		sb.append("     else nvl((nvl(sum(c.accschnum),0)-nvl(sum(d.accschnum1),0))/ ");
		sb.append("     sum(d.accschnum1)*100,100) end, '999999990.99')) || '%' accschnumPercent ");

		sb.append(" from (  ");
		
//		sb.append("      select d.orgid,o.name orgname,sum(d.actschnum) schnum ");
//		sb.append("      from invoicesidx d ,Organization o ");
//		sb.append("      where o.id=d.orgid ");
//		sb.append("      and d.departdate between :startdate and :enddate ");
//		sb.append("      and d.orgid in" + orgids + " ");
//		sb.append("      group by d.orgid,o.name ");
		
		sb.append("      select org.id orgid,org.name orgname, ");     
		sb.append("      count(distinct vr.id) schnum ");
		sb.append("      from scheduleplan sp,route r, schedule s, vehiclereport vr, organization org ");
		sb.append("      where sp.id = vr.scheduleplanid ");
		sb.append("      and s.id=sp.scheduleid and r.id=s.routeid and vr.isactive = 1 ");
		sb.append("      and vr.reportorgid = org.id ");
		sb.append("      and org.id in" + orgids + " ");
		sb.append("      and sp.departdate between :startdate and :enddate  ");
		sb.append("      group by org.id ,org.name ");
		
		sb.append(" ) a ");
		sb.append(" full join( ");
		
//		sb.append("      select d.orgid,o.name orgname,sum(d.actschnum) schnum1 ");
//		sb.append("      from invoicesidx d ,Organization o ");
//		sb.append("      where o.id=d.orgid ");
//		sb.append("      and d.departdate between :compStartdate and :compEnddate ");
//		sb.append("      and d.orgid in" + orgids + " ");
//		sb.append("      group by d.orgid,o.name ");
		
		
		sb.append("      select org.id orgid,org.name orgname, ");     
		sb.append("      count(distinct vr.id) schnum1 ");
		sb.append("      from scheduleplan sp,route r, schedule s, vehiclereport vr, organization org ");
		sb.append("      where sp.id = vr.scheduleplanid ");
		sb.append("      and s.id=sp.scheduleid and r.id=s.routeid and vr.isactive = 1 ");
		sb.append("      and vr.reportorgid = org.id ");
		sb.append("      and org.id in" + orgids + " ");
		sb.append("      and sp.departdate between :compStartdate and :compEnddate  ");
		sb.append("      group by org.id ,org.name ");
		
		sb.append(" ) b on a.orgid=b.orgid ");

		sb.append(" full join(  ");
		
//		sb.append("      select d.orgid,o.name orgname,sum(d.actschnum) accschnum ");
//		sb.append("      from invoicesidx d ,Organization o ");
//		sb.append("      where o.id=d.orgid ");
//		sb.append("      and d.departdate between :accstartdate and :accenddate ");
//		sb.append("      and d.orgid in" + orgids + " ");
//		sb.append("      group by d.orgid,o.name ");
		
		sb.append("      select org.id orgid,org.name orgname, ");     
		sb.append("      count(distinct vr.id) accschnum ");
		sb.append("      from scheduleplan sp,route r, schedule s, vehiclereport vr, organization org ");
		sb.append("      where sp.id = vr.scheduleplanid ");
		sb.append("      and s.id=sp.scheduleid and r.id=s.routeid and vr.isactive = 1 ");
		sb.append("      and vr.reportorgid = org.id ");
		sb.append("      and org.id in" + orgids + " ");
		sb.append("      and sp.departdate between :accstartdate and :accenddate  ");
		sb.append("      group by org.id ,org.name ");
		
		sb.append(" ) c on nvl(a.orgid,b.orgid)=c.orgid ");
		sb.append(" full join( ");
		
//		sb.append("      select d.orgid,o.name orgname,sum(d.actschnum) accschnum1 ");
//		sb.append("      from invoicesidx d ,Organization o ");
//		sb.append("      where o.id=d.orgid ");
//		sb.append("      and d.departdate between :acccompStartdate and :acccompEnddate ");
//		sb.append("      and d.orgid in" + orgids + " ");
//		sb.append("      group by d.orgid,o.name ");
		
		sb.append("      select org.id orgid,org.name orgname, ");     
		sb.append("      count(distinct vr.id) accschnum1 ");
		sb.append("      from scheduleplan sp,route r, schedule s, vehiclereport vr, organization org ");
		sb.append("      where sp.id = vr.scheduleplanid ");
		sb.append("      and s.id=sp.scheduleid and r.id=s.routeid and vr.isactive = 1 ");
		sb.append("      and vr.reportorgid = org.id ");
		sb.append("      and org.id in" + orgids + " ");
		sb.append("      and sp.departdate between :acccompStartdate and :acccompEnddate  ");
		sb.append("      group by org.id ,org.name ");
		
		sb.append(" ) d on nvl(a.orgid,nvl(b.orgid,c.orgid))=d.orgid ");
		sb.append(" group by rollup(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname)))) ");

		sb.append(" union ");

		// sb.append(" --客运量(人次) ");
		sb.append(" select 1 sort,decode(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname))),NULL,'0',1) sort2, ");
		sb.append(" '客运量(人次)' rowname, ");
		sb.append(" decode(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname))),NULL,'合计',nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname)))) orgname, ");

		sb.append(" nvl(sum(a.ticketnum),0) ticketnum,nvl(sum(b.ticketnum1),0) ticketnum1, ");
		sb.append(" nvl(sum(a.ticketnum),0)-nvl(sum(b.ticketnum1),0) schnumComp, ");
		sb.append(" trim(to_char(case when nvl(sum(a.ticketnum),0)-nvl(sum(b.ticketnum1),0)=0 then 0  ");
		sb.append("      else nvl((nvl(sum(a.ticketnum),0)-nvl(sum(b.ticketnum1),0))/ ");
		sb.append("     sum(b.ticketnum1)*100,100) end, '999999990.99')) || '%' ticketnumPercent, ");

		sb.append(" nvl(sum(c.accticketnum),0) accticketnum,nvl(sum(d.accticketnum1),0) accticketnum1, ");
		sb.append(" nvl(sum(c.accticketnum),0)-nvl(sum(d.accticketnum1),0) accschnumComp, ");
		sb.append(" trim(to_char(case when nvl(sum(c.accticketnum),0)-nvl(sum(d.accticketnum1),0)=0 then 0  ");
		sb.append("      else nvl((nvl(sum(c.accticketnum),0)-nvl(sum(d.accticketnum1),0))/ ");
		sb.append("     sum(d.accticketnum1)*100,100) end, '999999990.99')) || '%' accticketnumPercent ");
		sb.append(" from (  ");
		sb.append("      select d.orgid,o.name orgname,sum(ticketnum) ticketnum  ");
		sb.append("      from invoicesidx d,Organization o ");
		sb.append("      where o.id=d.orgid ");

		sb.append("      and d.departdate between :startdate and :enddate ");
		sb.append("      and d.orgid in" + orgids + " ");
		sb.append("      group by d.orgid,o.name ");
		sb.append(" ) a ");
		sb.append(" full join( ");
		sb.append("      select d.orgid,o.name orgname,sum(ticketnum) ticketnum1  ");
		sb.append("      from invoicesidx d,Organization o ");
		sb.append("      where o.id=d.orgid ");
		sb.append("      and d.departdate between :compStartdate and :compEnddate ");
		sb.append("      and d.orgid in" + orgids + " ");
		sb.append("      group by d.orgid,o.name ");
		sb.append(" ) b on a.orgid=b.orgid ");
		sb.append(" full join(  ");
		sb.append("      select d.orgid,o.name orgname,sum(ticketnum) accticketnum  ");
		sb.append("      from invoicesidx d,Organization o ");
		sb.append("      where o.id=d.orgid ");
		sb.append("      and d.departdate between :accstartdate and :accenddate ");
		sb.append("      and d.orgid in" + orgids + " ");
		sb.append("      group by d.orgid,o.name ");
		sb.append(" ) c on nvl(a.orgid,b.orgid)=c.orgid ");
		sb.append(" full join( ");
		sb.append("      select d.orgid,o.name orgname,sum(ticketnum) accticketnum1  ");
		sb.append("      from invoicesidx d,Organization o ");
		sb.append("      where o.id=d.orgid ");
		sb.append("      and d.departdate between :acccompStartdate and :acccompEnddate ");
		sb.append("      and d.orgid in" + orgids + " ");
		sb.append("      group by d.orgid,o.name ");
		sb.append(" ) d on nvl(a.orgid,nvl(b.orgid,c.orgid))=d.orgid ");
		sb.append(" group by rollup(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname)))) ");

		sb.append(" union ");

		// sb.append(" --旅客周转量（人公里） ");
		sb.append(" select 2 sort,decode(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname))),NULL,'0',1) sort2, ");
		sb.append(" '旅客周转量(人公里)' rowname, ");
		sb.append(" decode(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname))),NULL,'合计',nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname)))) orgname, ");

		sb.append(" nvl(sum(a.peopledistance),0) peopledistance,nvl(sum(b.peopledistance1),0) peopledistance1, ");
		sb.append(" nvl(sum(a.peopledistance),0)-nvl(sum(b.peopledistance1),0) schnumComp, ");
		sb.append(" trim(to_char(case when nvl(sum(a.peopledistance),0)-nvl(sum(b.peopledistance1),0)=0 then 0  ");
		sb.append("     else nvl((nvl(sum(a.peopledistance),0)-nvl(sum(b.peopledistance1),0))/ ");
		sb.append("     sum(b.peopledistance1)*100,100) end, '999999990.99')) || '%' peopledistancePercent, ");
		sb.append("      ");
		sb.append(" nvl(sum(c.accpeopledistance),0) accpeopledistance,nvl(sum(d.accpeopledistance1),0) accpeopledistance1, ");
		sb.append(" nvl(sum(c.accpeopledistance),0)-nvl(sum(d.accpeopledistance1),0) accpeopledistanceComp, ");
		sb.append(" trim(to_char(case when nvl(sum(c.accpeopledistance),0)-nvl(sum(d.accpeopledistance1),0)=0 then 0  ");
		sb.append("     else nvl((nvl(sum(c.accpeopledistance),0)-nvl(sum(d.accpeopledistance1),0))/ ");
		sb.append("     sum(d.accpeopledistance1)*100,100) end, '999999990.99')) || '%' accpeopledistancePercent ");
		sb.append("      ");
		sb.append(" from( ");
		sb.append("       select d.orgid,o.name orgname,sum(d.peopledistance) peopledistance  ");
		sb.append("      from invoicesidx d,Organization o ");
		sb.append("      where o.id=d.orgid ");
		sb.append("      and d.departdate between :startdate and :enddate ");
		sb.append("      and d.orgid in" + orgids + " ");
		sb.append("      group by d.orgid,o.name ");
		sb.append(" ) a ");
		sb.append(" full join( ");
		sb.append("      select d.orgid,o.name orgname,sum(d.peopledistance) peopledistance1  ");
		sb.append("      from invoicesidx d,Organization o ");
		sb.append("      where o.id=d.orgid ");
		sb.append("      and d.departdate between :compStartdate and :compEnddate ");
		sb.append("      and d.orgid in" + orgids + " ");
		sb.append("      group by d.orgid,o.name ");
		sb.append(" )b on a.orgid=b.orgid ");
		sb.append(" full join( ");
		sb.append("       select d.orgid,o.name orgname,sum(d.peopledistance) accpeopledistance  ");
		sb.append("      from invoicesidx d,Organization o ");
		sb.append("      where o.id=d.orgid ");
		sb.append("      and d.departdate between :accstartdate and :accenddate ");
		sb.append("      and d.orgid in" + orgids + " ");
		sb.append("      group by d.orgid,o.name ");
		sb.append(" ) c on nvl(a.orgid,b.orgid)=c.orgid ");
		sb.append(" full join( ");
		sb.append("      select d.orgid,o.name orgname,sum(d.peopledistance) accpeopledistance1  ");
		sb.append("      from invoicesidx d,Organization o ");
		sb.append("      where o.id=d.orgid ");
		sb.append("      and d.departdate between :acccompStartdate and :acccompEnddate ");
		sb.append("      and d.orgid in" + orgids + " ");
		sb.append("      group by d.orgid,o.name ");
		sb.append(" ) d on nvl(a.orgid,nvl(b.orgid,c.orgid))=d.orgid ");
		sb.append(" group by rollup(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname)))) ");

		sb.append(" union ");

		// sb.append(" --售票营收 ");
		sb.append(" select 3 sort,decode(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname))),NULL,'0',1) sort2, ");
		sb.append(" '售票营收(元)' rowname, ");
		sb.append(" decode(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname))),NULL,'合计',nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname)))) orgname, ");

		sb.append(" nvl(sum(a.balanceamount),0) balanceamount,nvl(sum(b.balanceamount1),0) balanceamount1, ");
		sb.append(" nvl(sum(a.balanceamount),0)-nvl(sum(b.balanceamount1),0) balanceamountComp, ");
		sb.append(" trim(to_char(case when nvl(sum(a.balanceamount),0)-nvl(sum(b.balanceamount1),0)=0 then 0  ");
		sb.append("      else nvl((nvl(sum(a.balanceamount),0)-nvl(sum(b.balanceamount1),0))/ ");
		sb.append("     sum(b.balanceamount1)*100,100) end, '999999990.99')) || '%' balanceamountPercent, ");

		sb.append(" nvl(sum(c.accbalanceamount),0) accbalanceamount,nvl(sum(d.accbalanceamount1),0) accbalanceamount1, ");
		sb.append(" nvl(sum(c.accbalanceamount),0)-nvl(sum(d.accbalanceamount1),0) accbalanceamountComp, ");
		sb.append(" trim(to_char(case when nvl(sum(c.accbalanceamount),0)-nvl(sum(d.accbalanceamount1),0)=0 then 0  ");
		sb.append("      else nvl((nvl(sum(c.accbalanceamount),0)-nvl(sum(d.accbalanceamount1),0))/ ");
		sb.append("     sum(d.accbalanceamount1)*100,100) end, '999999990.99')) || '%' accbalanceamountPercent ");
		sb.append(" from (  ");
		sb.append("      select d.orgid,o.name orgname,sum(d.totalamount) balanceamount  ");
		sb.append("      from invoicesidx d,Organization o ");
		sb.append("      where o.id=d.orgid ");
		sb.append("      and d.departdate between :startdate and :enddate ");
		sb.append("      and d.orgid in" + orgids + " ");
		sb.append("      group by d.orgid,o.name ");
		sb.append(" ) a ");
		sb.append(" full join( ");
		sb.append("      select d.orgid,o.name orgname,sum(d.totalamount) balanceamount1 ");
		sb.append("      from invoicesidx d,Organization o ");
		sb.append("      where o.id=d.orgid ");
		sb.append("      and d.departdate between :compStartdate and :compEnddate ");
		sb.append("      and d.orgid in" + orgids + " ");
		sb.append("      group by d.orgid,o.name ");
		sb.append(" ) b on a.orgid=b.orgid ");
		sb.append(" full join(  ");
		sb.append("      select d.orgid,o.name orgname,sum(d.totalamount) accbalanceamount  ");
		sb.append("      from invoicesidx d,Organization o ");
		sb.append("      where o.id=d.orgid ");
		sb.append("      and d.departdate between :accstartdate and :accenddate ");
		sb.append("      and d.orgid in" + orgids + " ");
		sb.append("      group by d.orgid,o.name ");
		sb.append(" ) c on nvl(a.orgid,b.orgid)=c.orgid ");
		sb.append(" full join( ");
		sb.append("      select d.orgid,o.name orgname,sum(d.totalamount) accbalanceamount1 ");
		sb.append("      from invoicesidx d,Organization o ");
		sb.append("      where o.id=d.orgid ");
		sb.append("      and d.departdate between :acccompStartdate and :acccompEnddate ");
		sb.append("      and d.orgid in" + orgids + " ");
		sb.append("      group by d.orgid,o.name ");
		sb.append(" ) d on nvl(a.orgid,nvl(b.orgid,c.orgid))=d.orgid ");
		sb.append(" group by rollup(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname)))) ");

		sb.append(" union ");

		// sb.append(" --进站车辆数 ");
		sb.append(" select 4 sort,decode(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname))),NULL,'0',1) sort2, ");
		sb.append(" '进站车辆数(辆)' rowname, ");
		sb.append(" decode(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname))),NULL,'合计',nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname)))) orgname, ");

		sb.append(" nvl(sum(a.velnum),0) velnum,nvl(sum(b.velnum1),0) velnum1, ");
		sb.append(" nvl(sum(a.velnum),0)-nvl(sum(b.velnum1),0) velnumComp, ");
		sb.append(" trim(to_char(case when nvl(sum(a.velnum),0)-nvl(sum(b.velnum1),0)=0 then 0  ");
		sb.append("      else nvl((nvl(sum(a.velnum),0)-nvl(sum(b.velnum1),0))/ ");
		sb.append("     sum(b.velnum1)*100,100) end, '999999990.99')) || '%' velnumPercent, ");
		sb.append("      ");
		sb.append(" nvl(sum(c.accvelnum),0) accvelnum,nvl(sum(d.accvelnum1),0) accvelnum1, ");
		sb.append(" nvl(sum(c.accvelnum),0)-nvl(sum(d.accvelnum1),0) accvelnumComp, ");
		sb.append(" trim(to_char(case when nvl(sum(c.accvelnum),0)-nvl(sum(d.accvelnum1),0)=0 then 0  ");
		sb.append("      else nvl((nvl(sum(c.accvelnum),0)-nvl(sum(d.accvelnum1),0))/ ");
		sb.append("     sum(d.accvelnum1)*100,100) end, '999999990.99')) || '%' accvelnumPercent ");
		sb.append(" from ( ");
		sb.append("       select o.id orgid,o.name orgname,count(vp.reportorgid) velnum ");
		sb.append("       from vehiclereport vp,Organization o ");
		sb.append("       where vp.reportorgid = o.id ");
		sb.append("       and vp.reporttime between :startdate and :enddate+1 ");
		sb.append("       and vp.isactive = 1 ");
		sb.append("       and o.id in" + orgids + " ");
		sb.append("       group by o.id,o.name ");
		sb.append(" ) a ");
		sb.append(" full join( ");
		sb.append("       select o.id orgid,o.name orgname,count(vp.reportorgid) velnum1 ");
		sb.append("       from vehiclereport vp,Organization o ");
		sb.append("       where vp.reportorgid = o.id ");
		sb.append("       and vp.reporttime between :compStartdate and :compEnddate+1 ");
		sb.append("       and vp.isactive = 1 ");
		sb.append("       and o.id in" + orgids + " ");
		sb.append("       group by o.id,o.name ");
		sb.append(" ) b on a.orgid=b.orgid ");
		sb.append(" full join( ");
		sb.append("       select o.id orgid,o.name orgname,count(vp.reportorgid) accvelnum ");
		sb.append("       from vehiclereport vp,Organization o ");
		sb.append("       where vp.reportorgid = o.id ");
		sb.append("       and vp.reporttime between :accstartdate and :accenddate+1 ");
		sb.append("       and vp.isactive = 1 ");
		sb.append("       and o.id in" + orgids + " ");
		sb.append("       group by o.id,o.name ");
		sb.append(" ) c on nvl(a.orgid,b.orgid)=c.orgid ");
		sb.append(" full join( ");
		sb.append("       select o.id orgid,o.name orgname,count(vp.reportorgid) accvelnum1 ");
		sb.append("       from vehiclereport vp,Organization o ");
		sb.append("       where vp.reportorgid = o.id ");
		sb.append("       and vp.reporttime between :acccompStartdate and :acccompEnddate+1 ");
		sb.append("       and vp.isactive = 1 ");
		sb.append("       and o.id in" + orgids + " ");
		sb.append("       group by o.id,o.name ");
		sb.append(" )d on nvl(a.orgid,nvl(b.orgid,c.orgid))=d.orgid ");
		sb.append(" group by rollup(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname)))) ");

		sb.append(" union ");

		// sb.append(" --安全例检车辆数（辆） ");
		sb.append(" select 5 sort,decode(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname))),NULL,'0',1) sort2, ");
		sb.append(" '安全例检车辆数（辆)' rowname, ");
		sb.append(" decode(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname))),NULL,'合计',nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname)))) orgname, ");

		sb.append(" nvl(sum(a.checkvelnum),0) checkvelnum,nvl(sum(b.checkvelnum1),0) checkvelnum1, ");
		sb.append(" nvl(sum(a.checkvelnum),0)-nvl(sum(b.checkvelnum1),0) checkvelnumComp, ");
		sb.append(" trim(to_char(case when nvl(sum(a.checkvelnum),0)-nvl(sum(b.checkvelnum1),0)=0 then 0  ");
		sb.append("      else nvl((nvl(sum(a.checkvelnum),0)-nvl(sum(b.checkvelnum1),0))/ ");
		sb.append("     sum(b.checkvelnum1)*100,100) end, '999999990.99')) || '%' checkvelnumPercent, ");

		sb.append(" nvl(sum(c.acccheckvelnum),0) acccheckvelnum,nvl(sum(d.acccheckvelnum1),0) acccheckvelnum1, ");
		sb.append(" nvl(sum(c.acccheckvelnum),0)-nvl(sum(d.acccheckvelnum1),0) acccheckvelnumComp, ");
		sb.append(" trim(to_char(case when nvl(sum(c.acccheckvelnum),0)-nvl(sum(d.acccheckvelnum1),0)=0 then 0  ");
		sb.append("      else nvl((nvl(sum(c.acccheckvelnum),0)-nvl(sum(d.acccheckvelnum1),0))/ ");
		sb.append("     sum(d.acccheckvelnum1)*100,100) end, '999999990.99')) || '%' acccheckvelnumPercent ");
		sb.append(" from ( ");
		sb.append("       select o.id orgid,o.name orgname,count(sc.vehicleid) checkvelnum ");
		sb.append("       from securitycheck sc,Organization o ");
		sb.append("       where sc.orgid = o.id ");
		sb.append("       and sc.checktime between :startdate and :enddate+1 ");
		sb.append("       and o.id in" + orgids + " ");
		sb.append("       group by o.id,o.name ");
		sb.append(" ) a ");
		sb.append(" full join( ");
		sb.append("       select o.id orgid,o.name orgname,count(sc.vehicleid) checkvelnum1 ");
		sb.append("       from securitycheck sc,Organization o ");
		sb.append("       where sc.orgid = o.id ");
		sb.append("       and sc.checktime between :compStartdate and :compEnddate+1 ");
		sb.append("       and o.id in" + orgids + " ");
		sb.append("       group by o.id,o.name ");
		sb.append(" ) b on a.orgid=b.orgid ");
		sb.append(" full join( ");
		sb.append("       select o.id orgid,o.name orgname,count(sc.vehicleid) acccheckvelnum ");
		sb.append("       from securitycheck sc,Organization o ");
		sb.append("       where sc.orgid = o.id ");
		sb.append("       and sc.checktime between :accstartdate and :accenddate+1 ");
		sb.append("       and o.id in" + orgids + " ");
		sb.append("       group by o.id,o.name ");
		sb.append(" ) c on nvl(a.orgid,b.orgid)=c.orgid ");
		sb.append(" full join( ");
		sb.append("      select o.id orgid,o.name orgname,count(sc.vehicleid) acccheckvelnum1 ");
		sb.append("       from securitycheck sc,Organization o ");
		sb.append("       where sc.orgid = o.id ");
		sb.append("       and sc.checktime between :acccompStartdate and :acccompEnddate+1 ");
		sb.append("       and o.id in" + orgids + " ");
		sb.append("       group by o.id,o.name ");
		sb.append(" ) d on nvl(a.orgid,nvl(b.orgid,c.orgid))=d.orgid ");
		sb.append(" group by rollup(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname)))) ");
		sb.append("      ");
		sb.append(" order by sort,sort2 desc ");

		Query query = getEntityManager().createNativeQuery(sb.toString());

		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		query.setParameter("compStartdate", compStartdate);
		query.setParameter("compEnddate", compEnddate);
		query.setParameter("accstartdate", accstartdate);
		query.setParameter("accenddate", accenddate);
		query.setParameter("acccompStartdate", acccompStartdate);
		query.setParameter("acccompEnddate", acccompEnddate);
		List<Object> list = query.getResultList();

		return list;
	}

	/**
	 * 站务作业统计报表 
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> querydepices(String orgids,Date startdate,Date enddate,Date compStartdate,Date compEnddate,
			Date accstartdate,Date accenddate,Date acccompStartdate,Date acccompEnddate) {

		
		//
		StringBuffer sb = new StringBuffer();

		//按运量单统计班次、客运量、周转量  售票营收

//		sb.append(" --班次统计 ");
		sb.append(" select 0 sort ,decode(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname))),NULL,'0',1) sort2, ");
		sb.append(" '班次(班)' rowname, ");
		sb.append(" decode(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname))),NULL,'合计',nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname)))) orgname, ");
		sb.append(" nvl(sum(a.schnum),0) schnum,nvl(sum(b.schnum1),0) schnum1, ");
		sb.append(" nvl(sum(a.schnum),0)-nvl(sum(b.schnum1),0) schnumComp, ");
		sb.append(" trim(to_char(case when nvl(sum(a.schnum),0)-nvl(sum(b.schnum1),0)=0 then 0  ");
		sb.append("     else nvl((nvl(sum(a.schnum),0)-nvl(sum(b.schnum1),0))/ ");
		sb.append("     sum(b.schnum1)*100,100) end, '999999990.99')) || '%' schnumPercent, ");
		sb.append(" nvl(sum(c.accschnum),0) accschnum,nvl(sum(d.accschnum1),0) accschnum1, ");
		sb.append(" nvl(sum(c.accschnum),0)-nvl(sum(d.accschnum1),0) accschnumComp, ");
		sb.append(" trim(to_char(case when nvl(sum(c.accschnum),0)-nvl(sum(d.accschnum1),0)=0 then 0  ");
		sb.append("     else nvl((nvl(sum(c.accschnum),0)-nvl(sum(d.accschnum1),0))/ ");
		sb.append("     sum(d.accschnum1)*100,100) end, '999999990.99')) || '%' accschnumPercent ");
		sb.append(" from (  ");
		sb.append("      select s.orgid,o.name orgname,count(distinct d.reportid) schnum  ");
		sb.append("      from schedule s,Organization o, departinvoices d ");
		sb.append("      where s.id=d.scheduleid and o.id=s.orgid and d.status<>1 ");
		sb.append("      and d.departdate between :startdate and :enddate ");
		sb.append("      and s.orgid in" + orgids + " ");
		sb.append("      group by s.orgid,o.name ");
//		
//		sb.append("        select  s.orgid,org.name as orgname ,count(distinct d.reportid) schnum ");
////		sb.append("        from departinvoices d, route r, schedule s, scheduleplan sp,Organization org, ");
//		sb.append("        from departinvoices d, route r, schedule s, scheduleplan sp,Organization org,vehiclereport vr ");
//		sb.append("        where d.scheduleid = s.id and s.routeid = r.id  ");
//		sb.append("        and vr.id=d.reportid and vr.isactive = 1 and vr.reportorgid=vr.orgid  ");
//		sb.append("        and d.scheduleplanid = sp.id and d.departdate between :compStartdate and :compEnddate  ");
//		sb.append("        and d.status <> '1'  ");
//		sql.append("        and d.printway in(0,2)  ");//打单方式
//		sb.append("        and sp.departdate = d.departdate and s.orgid in "+orgids+"  ");
//		sb.append("        and org.id=s.orgid ");
//		sb.append("        group by  s.orgid,org.name ");
		
		
		sb.append(" ) a ");
		sb.append(" full join( ");
		sb.append("      select s.orgid,o.name orgname,count(distinct d.reportid) schnum1  ");
		sb.append("      from schedule s,Organization o, departinvoices d ");
		sb.append("      where s.id=d.scheduleid and o.id=s.orgid and d.status<>1 ");
		sb.append("      and d.departdate between :compStartdate and :compEnddate ");
		sb.append("      and s.orgid in" + orgids + " ");
		sb.append("      group by s.orgid,o.name ");
		sb.append(" ) b on a.orgid=b.orgid ");

		sb.append(" full join(  ");
		sb.append("     select s.orgid,o.name orgname,count(distinct d.reportid) accschnum  ");
		sb.append("      from schedule s,Organization o, departinvoices d ");
		sb.append("      where s.id=d.scheduleid and o.id=s.orgid and d.status<>1 ");
		sb.append("      and d.departdate between :accstartdate and :accenddate ");
		sb.append("      and s.orgid in" + orgids + " ");
		sb.append("      group by s.orgid,o.name ");
		sb.append(" ) c on nvl(a.orgid,b.orgid)=c.orgid ");
		sb.append(" full join( ");
		sb.append("      select s.orgid,o.name orgname,count(distinct d.reportid) accschnum1  ");
		sb.append("      from schedule s,Organization o, departinvoices d ");
		sb.append("      where s.id=d.scheduleid and o.id=s.orgid and d.status<>1 ");
		sb.append("      and d.departdate between :acccompStartdate and :acccompEnddate ");
		sb.append("      and s.orgid in" + orgids + " ");
		sb.append("      group by s.orgid,o.name ");
		sb.append(" ) d on nvl(a.orgid,nvl(b.orgid,c.orgid))=d.orgid ");
		sb.append(" group by rollup(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname)))) ");

		sb.append(" union ");

//		sb.append(" --客运量(人次) ");
		sb.append(" select 1 sort,decode(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname))),NULL,'0',1) sort2, ");
		sb.append(" '客运量(人次)' rowname, ");
		sb.append(" decode(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname))),NULL,'合计',nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname)))) orgname, ");
		sb.append(" nvl(sum(a.ticketnum),0) ticketnum,nvl(sum(b.ticketnum1),0) ticketnum1, ");
		sb.append(" nvl(sum(a.ticketnum),0)-nvl(sum(b.ticketnum1),0) schnumComp, ");
		sb.append(" trim(to_char(case when nvl(sum(a.ticketnum),0)-nvl(sum(b.ticketnum1),0)=0 then 0  ");
		sb.append("      else nvl((nvl(sum(a.ticketnum),0)-nvl(sum(b.ticketnum1),0))/ ");
		sb.append("     sum(b.ticketnum1)*100,100) end, '999999990.99')) || '%' ticketnumPercent, ");

		sb.append(" nvl(sum(c.accticketnum),0) accticketnum,nvl(sum(d.accticketnum1),0) accticketnum1, ");
		sb.append(" nvl(sum(c.accticketnum),0)-nvl(sum(d.accticketnum1),0) accschnumComp, ");
		sb.append(" trim(to_char(case when nvl(sum(c.accticketnum),0)-nvl(sum(d.accticketnum1),0)=0 then 0  ");
		sb.append("      else nvl((nvl(sum(c.accticketnum),0)-nvl(sum(d.accticketnum1),0))/ ");
		sb.append("     sum(d.accticketnum1)*100,100) end, '999999990.99')) || '%' accticketnumPercent ");
		sb.append(" from (  ");
		sb.append("      select s.orgid,o.name orgname,sum(ticketnum) ticketnum  ");
		sb.append("      from schedule s,Organization o, departinvoices d ");
		sb.append("      where s.id=d.scheduleid and o.id=s.orgid and d.status<>'1' ");
		sb.append("      and d.departdate between :startdate and :enddate ");
		sb.append("      and s.orgid in" + orgids + " ");
		sb.append("      group by s.orgid,o.name ");
		sb.append(" ) a ");
		sb.append(" full join( ");
		sb.append("      select s.orgid,o.name orgname,sum(ticketnum) ticketnum1  ");
		sb.append("      from schedule s,Organization o, departinvoices d ");
		sb.append("      where s.id=d.scheduleid and o.id=s.orgid and d.status<>'1' ");
		sb.append("      and d.departdate between :compStartdate and :compEnddate ");
		sb.append("      and s.orgid in" + orgids + " ");
		sb.append("      group by s.orgid,o.name ");
		sb.append(" ) b on a.orgid=b.orgid ");
		sb.append(" full join(  ");
		sb.append("      select s.orgid,o.name orgname,sum(ticketnum) accticketnum  ");
		sb.append("      from schedule s,Organization o, departinvoices d ");
		sb.append("      where s.id=d.scheduleid and o.id=s.orgid and d.status<>'1' ");
		sb.append("      and d.departdate between :accstartdate and :accenddate ");
		sb.append("      and s.orgid in" + orgids + " ");
		sb.append("      group by s.orgid,o.name ");
		sb.append(" ) c on nvl(a.orgid,b.orgid)=c.orgid ");
		sb.append(" full join( ");
		sb.append("      select s.orgid,o.name orgname,sum(ticketnum) accticketnum1  ");
		sb.append("      from schedule s,Organization o, departinvoices d ");
		sb.append("      where s.id=d.scheduleid and o.id=s.orgid and d.status<>'1' ");
		sb.append("      and d.departdate between :acccompStartdate and :acccompEnddate ");
		sb.append("      and s.orgid in" + orgids + " ");
		sb.append("      group by s.orgid,o.name ");
		sb.append(" ) d on nvl(a.orgid,nvl(b.orgid,c.orgid))=d.orgid ");
		sb.append(" group by rollup(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname)))) ");
		sb.append(" union ");

//		sb.append(" --旅客周转量（人公里） ");
		sb.append(" select 2 sort,decode(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname))),NULL,'0',1) sort2, ");
		sb.append(" '旅客周转量(人公里)' rowname, ");
		sb.append(" decode(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname))),NULL,'合计',nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname)))) orgname, ");
		sb.append(" nvl(sum(a.peopledistance),0) peopledistance,nvl(sum(b.peopledistance1),0) peopledistance1, ");
		sb.append(" nvl(sum(a.peopledistance),0)-nvl(sum(b.peopledistance1),0) schnumComp, ");
		sb.append(" trim(to_char(case when nvl(sum(a.peopledistance),0)-nvl(sum(b.peopledistance1),0)=0 then 0  ");
		sb.append("     else nvl((nvl(sum(a.peopledistance),0)-nvl(sum(b.peopledistance1),0))/ ");
		sb.append("     sum(b.peopledistance1)*100,100) end, '999999990.99')) || '%' peopledistancePercent, ");
		
		sb.append(" nvl(sum(c.accpeopledistance),0) accpeopledistance,nvl(sum(d.accpeopledistance1),0) accpeopledistance1, ");
		sb.append(" nvl(sum(c.accpeopledistance),0)-nvl(sum(d.accpeopledistance1),0) accpeopledistanceComp, ");
		sb.append(" trim(to_char(case when nvl(sum(c.accpeopledistance),0)-nvl(sum(d.accpeopledistance1),0)=0 then 0  ");
		sb.append("     else nvl((nvl(sum(c.accpeopledistance),0)-nvl(sum(d.accpeopledistance1),0))/ ");
		sb.append("     sum(d.accpeopledistance1)*100,100) end, '999999990.99')) || '%' accpeopledistancePercent ");
	 
		sb.append(" from( ");
		sb.append("      select  s.orgid,org.name as orgname,   ");
		sb.append("      sum(peopledistance) peopledistance ");
		sb.append("      from departinvoices d,schedule s,Organization org, ( ");
		sb.append("      select dt.departinvoicesid, sum(dt.distance * dt.ticketnum) peopledistance  ");
		sb.append("      from departinvoicesdetail dt  ");
		sb.append("      where dt.departdate between :startdate and :enddate   ");
		sb.append("      group by dt.departinvoicesid ");
		sb.append("      ) de where d.scheduleid = s.id and d.id = de.departinvoicesid(+)  ");
		sb.append("      and d.departdate between :startdate and :enddate  ");
		sb.append("      and org.id=s.orgid and d.status <> '1'  ");
		sb.append("      and s.orgid in" + orgids + " ");
		sb.append("      group by s.orgid,org.name ");
		sb.append(" ) a ");
		sb.append(" full join( ");
		sb.append("      select  s.orgid,org.name as orgname,   ");
		sb.append("      sum(peopledistance) peopledistance1 ");
		sb.append("      from departinvoices d,schedule s,Organization org, ( ");
		sb.append("            select dt.departinvoicesid, sum(dt.distance * dt.ticketnum) peopledistance  ");
		sb.append("            from departinvoicesdetail dt  ");
		sb.append("            where dt.departdate between :compStartdate and :compEnddate   ");
		sb.append("            group by dt.departinvoicesid ");
		sb.append("      ) de where d.scheduleid = s.id and d.id = de.departinvoicesid(+)  ");
		sb.append("      and d.departdate between :compStartdate and :compEnddate  ");
		sb.append("      and org.id=s.orgid and d.status <> '1'  ");
		sb.append("      and s.orgid in" + orgids + " ");
		sb.append("      group by s.orgid,org.name ");
		sb.append(" )b on a.orgid=b.orgid ");
		sb.append(" full join( ");
		sb.append("      select  s.orgid,org.name as orgname,   ");
		sb.append("      sum(peopledistance) accpeopledistance ");
		sb.append("      from departinvoices d,schedule s,Organization org, ( ");
		sb.append("            select dt.departinvoicesid, sum(dt.distance * dt.ticketnum) peopledistance  ");
		sb.append("            from departinvoicesdetail dt  ");
		sb.append("            where dt.departdate between :accstartdate and :accenddate   ");
		sb.append("            group by dt.departinvoicesid ");
		sb.append("      ) de where d.scheduleid = s.id and d.id = de.departinvoicesid(+)  ");
		sb.append("      and d.departdate between :accstartdate and :accenddate  ");
		sb.append("      and org.id=s.orgid and d.status <> '1'  ");
		sb.append("      and s.orgid in" + orgids + " ");
		sb.append("      group by s.orgid,org.name ");
		sb.append(" ) c on nvl(a.orgid,b.orgid)=c.orgid ");
		sb.append(" full join( ");
		sb.append("      select  s.orgid,org.name as orgname,   ");
		sb.append("      sum(peopledistance) accpeopledistance1 ");
		sb.append("      from departinvoices d,schedule s,Organization org, ( ");
		sb.append("             select dt.departinvoicesid, sum(dt.distance * dt.ticketnum) peopledistance  ");
		sb.append("             from departinvoicesdetail dt  ");
		sb.append("             where dt.departdate between :acccompStartdate and :acccompEnddate   ");
		sb.append("             group by dt.departinvoicesid ");
		sb.append("      ) de where d.scheduleid = s.id and d.id = de.departinvoicesid(+)  ");
		sb.append("      and d.departdate between :acccompStartdate and :acccompEnddate  ");
		sb.append("      and org.id=s.orgid and d.status <> '1'  ");
		sb.append("      and s.orgid in" + orgids + " ");
		sb.append("      group by s.orgid,org.name ");
		sb.append(" ) d on nvl(a.orgid,nvl(b.orgid,c.orgid))=d.orgid ");
		sb.append(" group by rollup(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname)))) ");

		sb.append(" union ");

//		sb.append(" --售票营收 ");
		sb.append(" select 3 sort,decode(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname))),NULL,'0',1) sort2, ");
		sb.append(" '售票营收(元)' rowname, ");
		sb.append(" decode(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname))),NULL,'合计',nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname)))) orgname, ");

		sb.append(" nvl(sum(a.balanceamount),0) balanceamount,nvl(sum(b.balanceamount1),0) balanceamount1, ");
		sb.append(" nvl(sum(a.balanceamount),0)-nvl(sum(b.balanceamount1),0) balanceamountComp, ");
		sb.append(" trim(to_char(case when nvl(sum(a.balanceamount),0)-nvl(sum(b.balanceamount1),0)=0 then 0  ");
		sb.append("      else nvl((nvl(sum(a.balanceamount),0)-nvl(sum(b.balanceamount1),0))/ ");
		sb.append("     sum(b.balanceamount1)*100,100) end, '999999990.99')) || '%' balanceamountPercent, ");

		sb.append(" nvl(sum(c.accbalanceamount),0) accbalanceamount,nvl(sum(d.accbalanceamount1),0) accbalanceamount1, ");
		sb.append(" nvl(sum(c.accbalanceamount),0)-nvl(sum(d.accbalanceamount1),0) accbalanceamountComp, ");
		sb.append(" trim(to_char(case when nvl(sum(c.accbalanceamount),0)-nvl(sum(d.accbalanceamount1),0)=0 then 0  ");
		sb.append("      else nvl((nvl(sum(c.accbalanceamount),0)-nvl(sum(d.accbalanceamount1),0))/ ");
		sb.append("     sum(d.accbalanceamount1)*100,100) end, '999999990.99')) || '%' accbalanceamountPercent ");
		sb.append(" from (  ");
		sb.append("       select s.orgid,o.name orgname,sum(balanceamount) balanceamount  ");
		sb.append("      from departinvoices d,schedule s,Organization o ");
		sb.append("      where s.id=d.scheduleid and o.id=s.orgid and d.status<>'1' ");
		sb.append("      and d.departdate between :startdate and :enddate ");
		sb.append("      and s.orgid in" + orgids + " ");
		sb.append("      group by s.orgid,o.name ");
		sb.append(" ) a ");
		sb.append(" full join( ");
		sb.append("       select s.orgid,o.name orgname,sum(balanceamount) balanceamount1  ");
		sb.append("      from departinvoices d,schedule s,Organization o ");
		sb.append("      where s.id=d.scheduleid and o.id=s.orgid and d.status<>'1' ");
		sb.append("      and d.departdate between :compStartdate and :compEnddate ");
		sb.append("      and s.orgid in" + orgids + " ");
		sb.append("      group by s.orgid,o.name ");
		sb.append(" ) b on a.orgid=b.orgid ");
		sb.append(" full join(  ");
		sb.append("     select s.orgid,o.name orgname,sum(balanceamount) accbalanceamount  ");
		sb.append("      from departinvoices d,schedule s,Organization o ");
		sb.append("      where s.id=d.scheduleid and o.id=s.orgid and d.status<>'1' ");
		sb.append("      and d.departdate between :accstartdate and :accenddate ");
		sb.append("      and s.orgid in" + orgids + " ");
		sb.append("      group by s.orgid,o.name ");
		sb.append(" ) c on nvl(a.orgid,b.orgid)=c.orgid ");
		sb.append(" full join( ");
		sb.append("     select s.orgid,o.name orgname,sum(balanceamount) accbalanceamount1  ");
		sb.append("      from departinvoices d,schedule s,Organization o ");
		sb.append("      where s.id=d.scheduleid and o.id=s.orgid and d.status<>'1' ");
		sb.append("      and d.departdate between :acccompStartdate and :acccompEnddate ");
		sb.append("      and s.orgid in" + orgids + " ");
		sb.append("      group by s.orgid,o.name ");
		sb.append(" ) d on nvl(a.orgid,nvl(b.orgid,c.orgid))=d.orgid ");
		sb.append(" group by rollup(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname)))) ");

		sb.append(" union ");

//		sb.append(" --进站车辆数 ");
		sb.append(" select 4 sort,decode(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname))),NULL,'0',1) sort2, ");
		sb.append(" '进站车辆数(辆)' rowname, ");
		sb.append(" decode(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname))),NULL,'合计',nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname)))) orgname, ");
		sb.append(" nvl(sum(a.velnum),0) velnum,nvl(sum(b.velnum1),0) velnum1, ");
		sb.append(" nvl(sum(a.velnum),0)-nvl(sum(b.velnum1),0) velnumComp, ");
		sb.append(" trim(to_char(case when nvl(sum(a.velnum),0)-nvl(sum(b.velnum1),0)=0 then 0  ");
		sb.append("    else nvl((nvl(sum(a.velnum),0)-nvl(sum(b.velnum1),0))/ ");
		sb.append("   sum(b.velnum1)*100,100) end, '999999990.99')) || '%' velnumPercent, ");
	 
		sb.append(" nvl(sum(c.accvelnum),0) accvelnum,nvl(sum(d.accvelnum1),0) accvelnum1, ");
		sb.append(" nvl(sum(c.accvelnum),0)-nvl(sum(d.accvelnum1),0) accvelnumComp, ");
		sb.append(" trim(to_char(case when nvl(sum(c.accvelnum),0)-nvl(sum(d.accvelnum1),0)=0 then 0  ");
		sb.append("    else nvl((nvl(sum(c.accvelnum),0)-nvl(sum(d.accvelnum1),0))/ ");
		sb.append("   sum(d.accvelnum1)*100,100) end, '999999990.99')) || '%' accvelnumPercent ");
		sb.append(" from ( ");
		sb.append("     select o.id orgid,o.name orgname,count(vp.reportorgid) velnum ");
		sb.append("     from vehiclereport vp,Organization o ");
		sb.append("     where vp.reportorgid = o.id ");
		sb.append("     and vp.reporttime between :startdate and :enddate ");
		sb.append("     and vp.orgid=vp.reportorgid ");
		sb.append("     and o.id in" + orgids + " ");
		sb.append("     group by o.id,o.name ");
		sb.append(" ) a ");
		sb.append(" full join( ");
		sb.append("     select o.id orgid,o.name orgname,count(vp.reportorgid) velnum1 ");
		sb.append("     from vehiclereport vp,Organization o ");
		sb.append("     where vp.reportorgid = o.id ");
		sb.append("     and vp.reporttime between :compStartdate and :compEnddate ");
		sb.append("     and vp.orgid=vp.reportorgid ");
		sb.append("     and o.id in" + orgids + " ");
		sb.append("     group by o.id,o.name ");
		sb.append(" ) b on a.orgid=b.orgid ");
		sb.append(" full join( ");
		sb.append("     select o.id orgid,o.name orgname,count(vp.reportorgid) accvelnum ");
		sb.append("     from vehiclereport vp,Organization o ");
		sb.append("     where vp.reportorgid = o.id ");
		sb.append("     and vp.reporttime between :accstartdate and :accenddate ");
		sb.append("     and vp.orgid=vp.reportorgid ");
		sb.append("     and o.id in" + orgids + " ");
		sb.append("     group by o.id,o.name ");
		sb.append(" ) c on nvl(a.orgid,b.orgid)=c.orgid ");
		sb.append(" full join( ");
		sb.append("     select o.id orgid,o.name orgname,count(vp.reportorgid) accvelnum1 ");
		sb.append("     from vehiclereport vp,Organization o ");
		sb.append("     where vp.reportorgid = o.id ");
		sb.append("     and vp.reporttime between :acccompStartdate and :acccompEnddate ");
		sb.append("     and vp.orgid=vp.reportorgid ");
		sb.append("     and o.id in" + orgids + " ");
		sb.append("     group by o.id,o.name ");
		sb.append(" )d on nvl(a.orgid,nvl(b.orgid,c.orgid))=d.orgid ");
		sb.append(" group by rollup(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname)))) ");

		sb.append(" union ");

//		sb.append(" --安全例检车辆数（辆） ");
		sb.append(" select 5 sort,decode(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname))),NULL,'0',1) sort2, ");
		sb.append(" '安全例检车辆数（辆)' rowname, ");
		sb.append(" decode(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname))),NULL,'合计',nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname)))) orgname, ");

		sb.append(" nvl(sum(a.checkvelnum),0) checkvelnum,nvl(sum(b.checkvelnum1),0) checkvelnum1, ");
		sb.append(" nvl(sum(a.checkvelnum),0)-nvl(sum(b.checkvelnum1),0) checkvelnumComp, ");
		sb.append(" trim(to_char(case when nvl(sum(a.checkvelnum),0)-nvl(sum(b.checkvelnum1),0)=0 then 0  ");
		sb.append("    else nvl((nvl(sum(a.checkvelnum),0)-nvl(sum(b.checkvelnum1),0))/ ");
		sb.append("   sum(b.checkvelnum1)*100,100) end, '999999990.99')) || '%' checkvelnumPercent, ");

		sb.append(" nvl(sum(c.acccheckvelnum),0) acccheckvelnum,nvl(sum(d.acccheckvelnum1),0) acccheckvelnum1, ");
		sb.append(" nvl(sum(c.acccheckvelnum),0)-nvl(sum(d.acccheckvelnum1),0) acccheckvelnumComp, ");
		sb.append(" trim(to_char(case when nvl(sum(c.acccheckvelnum),0)-nvl(sum(d.acccheckvelnum1),0)=0 then 0  ");
		sb.append("    else nvl((nvl(sum(c.acccheckvelnum),0)-nvl(sum(d.acccheckvelnum1),0))/ ");
		sb.append("   sum(d.acccheckvelnum1)*100,100) end, '999999990.99')) || '%' acccheckvelnumPercent ");
		sb.append(" from ( ");
		sb.append("     select o.id orgid,o.name orgname,count(sc.vehicleid) checkvelnum ");
		sb.append("     from securitycheck sc,Organization o ");
		sb.append("     where sc.orgid = o.id ");
		sb.append("     and sc.checktime between :startdate and :enddate ");
		sb.append("     and o.id in" + orgids + " ");
		sb.append("     group by o.id,o.name ");
		sb.append(" ) a ");
		sb.append(" full join( ");
		sb.append("     select o.id orgid,o.name orgname,count(sc.vehicleid) checkvelnum1 ");
		sb.append("     from securitycheck sc,Organization o ");
		sb.append("     where sc.orgid = o.id ");
		sb.append("     and sc.checktime between :compStartdate and :compEnddate ");
		sb.append("     and o.id in" + orgids + " ");
		sb.append("     group by o.id,o.name ");
		sb.append(" ) b on a.orgid=b.orgid ");
		sb.append(" full join( ");
		sb.append("     select o.id orgid,o.name orgname,count(sc.vehicleid) acccheckvelnum ");
		sb.append("     from securitycheck sc,Organization o ");
		sb.append("     where sc.orgid = o.id ");
		sb.append("     and sc.checktime between :accstartdate and :accenddate ");
		sb.append("     and o.id in" + orgids + " ");
		sb.append("     group by o.id,o.name ");
		sb.append(" ) c on nvl(a.orgid,b.orgid)=c.orgid ");
		sb.append(" full join( ");
		sb.append("    select o.id orgid,o.name orgname,count(sc.vehicleid) acccheckvelnum1 ");
		sb.append("     from securitycheck sc,Organization o ");
		sb.append("     where sc.orgid = o.id ");
		sb.append("     and sc.checktime between :acccompStartdate and :acccompEnddate ");
		sb.append("     and o.id in" + orgids + " ");
		sb.append("     group by o.id,o.name ");
		sb.append(" ) d on nvl(a.orgid,nvl(b.orgid,c.orgid))=d.orgid ");
		sb.append(" group by rollup(nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname)))) ");
		 
		sb.append(" order by sort,sort2 desc ");

		Query query = getEntityManager().createNativeQuery(sb.toString());

		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		query.setParameter("compStartdate", compStartdate);
		query.setParameter("compEnddate", compEnddate);
		query.setParameter("accstartdate", accstartdate);
		query.setParameter("accenddate", accenddate);
		query.setParameter("acccompStartdate", acccompStartdate);
		query.setParameter("acccompEnddate", acccompEnddate);
		List<Object> list = query.getResultList();

		return list;
	}


}
