package cn.nova.bus.query.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;

@SuppressWarnings("rawtypes")
public class DrawVehSummaryQryDao extends EntityManagerDaoSurport {

	/**
	 *站务分公司进站车辆汇总表  
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> querydrawVehSummary(
			List<PropertyFilter> propertyFilterList) {

		String orgids = null;

		Date startdate = null;
		Date enddate = null;
		boolean isbyreach=false;
		Long unitid=null;
		if (propertyFilterList != null && propertyFilterList.size() > 0) {
			for (int t = 0; t < propertyFilterList.size(); t++) {
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("s!orgid")) {
					orgids = (String) propertyFilterList.get(t).getMatchValue();
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
						.equals("p!unitid")) {
					unitid = (Long) propertyFilterList.get(t).getMatchValue();
					continue;
				}
				
			}
		}
		
		StringBuffer sb = new StringBuffer();
		
		sb.append(" select  ");
		sb.append(" nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname))) orgname, ");
		sb.append(" nvl(a.unitname,nvl(b.unitname,nvl(c.unitname,d.unitname))) unitname, ");

		sb.append(" nvl(a.grade5,0) grade5,nvl(a.grade4,0) grade4,nvl(a.grade3,0) grade3,nvl(a.grade2,0) grade2, ");
		sb.append(" nvl(a.grade1,0) grade1,nvl(a.grade678,0) grade678,nvl(a.amountnum,0) amountnum, ");

		sb.append(" nvl(b.routes0,0) routes0,nvl(b.routes1,0) routes1,nvl(b.routes2,0) routes2, ");
		sb.append(" nvl(b.routes3,0) routes3,nvl(b.routes4,0) routes4,nvl(b.routesamount,0) routesamount, ");
//		sb.append(" nvl(b.distance0,0) distance0,nvl(b.distance1,0) distance1,nvl(b.distance2,0) distance2, ");
//		sb.append(" nvl(b.distance3,0) distance3,nvl(b.distance4,0) distance4,nvl(b.distanceamount,0) distanceamount, ");
		sb.append(" nvl(c.distance0,0) distance0,nvl(c.distance1,0) distance1,nvl(c.distance2,0) distance2, ");
		sb.append(" nvl(c.distance3,0) distance3,nvl(c.distance4,0) distance4,nvl(c.distanceamount,0) distanceamount, ");

		sb.append(" nvl(c.schnums0,0) schnums0,nvl(c.schnums1,0) schnums1,nvl(c.schnums2,0) schnums2, ");
		sb.append(" nvl(c.schnums3,0) schnums3,nvl(c.schnums4,0) schnums4,nvl(c.schnumsamount,0) schnumsamount, ");

		sb.append(" nvl(d.ticknums0,0) ticknums0,nvl(d.ticknums1,0) ticknums1,nvl(d.ticknums2,0) ticknums2, ");
		sb.append(" nvl(d.ticknums3,0) ticknums3,nvl(d.ticknums4,0) ticknums4,nvl(d.ticknumsamount,0) ticknumsamount, ");

//		sb.append(" nvl(d.ticknums0,0)*nvl(b.distance0,0) balancedistance0,nvl(d.ticknums1,0)*nvl(b.distance1,0) balancedistance1, ");
//		sb.append(" nvl(d.ticknums2,0)*nvl(b.distance2,0) balancedistance2,nvl(d.ticknums3,0)*nvl(b.distance3,0) balancedistance3, ");
//		sb.append(" nvl(d.ticknums4,0)*nvl(b.distance4,0) balancedistance4,nvl(d.ticknumsamount,0)*nvl(b.distanceamount,0) balancedistancesamount ");
		sb.append(" nvl(d.balancedistance0,0) balancedistance0,nvl(d.balancedistance1,0) balancedistance1, ");
		sb.append(" nvl(d.balancedistance2,0) balancedistance2,nvl(d.balancedistance3,0) balancedistance3, ");
		sb.append(" nvl(d.balancedistance4,0) balancedistance4,nvl(d.balancedistanceamount,0) balancedistancesamount ");

		sb.append(" from (    ");
		sb.append("      ");
		sb.append("     select  ");
		sb.append("     a.orgid,a.orgname,a.unitid,a.unitname, ");
		sb.append("     nvl(sum(a.grade5),0) grade5,nvl(sum(a.grade4),0) grade4,nvl(sum(a.grade3),0) grade3,nvl(sum(a.grade2),0) grade2, ");
		sb.append("     nvl(sum(a.grade1),0) grade1,nvl(sum(a.grade678),0) grade678, ");
		sb.append("     nvl(sum(a.amountnum),0) amountnum ");

		sb.append("     from ( ");
		sb.append("       select o.id orgid,o.name orgname,u.id unitid,u.name unitname,vt.grade, ");
		sb.append("       (case vt.grade when '5' then count(v.id) end) grade5,  ");
		sb.append("       (case vt.grade when '4' then count(v.id) end) grade4,  ");
		sb.append("       (case vt.grade when '3' then count(v.id) end) grade3,  ");
		sb.append("       (case vt.grade when '2' then count(v.id) end) grade2,  ");
		sb.append("       (case vt.grade when '1' then count(v.id) end) grade1, ");
		sb.append("       (case  when vt.grade>=6 then count(v.id) end) grade678, ");
		sb.append("       (case  when vt.grade>=0 then count(v.id) end) amountnum ");
		sb.append("       from vehiclereport vr,Organization o ,unit u,vehicle v,vehicletype vt ");
		sb.append("       where v.id=vr.vehicleid and vt.id=v.vehicletypeid ");
		sb.append("       and u.id=v.unitid and o.id=vr.reportorgid ");
		sb.append("       and vr.reporttime between :startdate and :enddate  ");
		sb.append("       /*and u.id in()*/ ");
		sb.append("       and vr.isactive = 1 ");
		//sb.append("       and vr.orgid=vr.reportorgid ");//班次机构=报到机构则不是配载站报到
		sb.append("       and vr.reportorgid in"+orgids+"  ");
		sb.append("       group by vt.grade,vr.orgid,o.id,o.name,u.name,u.id ");
		
		sb.append("     ) a ");
		sb.append("     group by a.orgid,a.orgname,a.unitid,a.unitname ");
		sb.append(" ) a ");
		sb.append(" full join ( ");
		sb.append("      ");//班线数据 总班线里程数
		sb.append("     select b.orgid,b.orgname,b.unitid,b.unitname, ");
		sb.append("     nvl(sum(b.routes0),0) routes0,nvl(sum(b.routes1),0) routes1,nvl(sum(b.routes2),0) routes2, ");
		sb.append("     nvl(sum(b.routes3),0) routes3,nvl(sum(b.routes4),0) routes4,nvl(sum(b.routesamount),0) routesamount, ");
		sb.append("     nvl(sum(b.distance0),0) distance0,nvl(sum(b.distance1),0) distance1,nvl(sum(b.distance2),0) distance2, ");
		sb.append("     nvl(sum(b.distance3),0) distance3,nvl(sum(b.distance4),0) distance4,nvl(sum(b.distanceamount),0) distanceamount ");
		sb.append("     from ( ");
		sb.append("       select org.id orgid,org.name orgname ,u.id unitid,u.name unitname,r.id,r.name,s.districttype, ");
		sb.append("       (case s.districttype when '0' then count(distinct s.routeid) end) routes0,  ");
		sb.append("       (case s.districttype when '1' then count(distinct s.routeid) end) routes1,  ");
		sb.append("       (case s.districttype when '2' then count(distinct s.routeid) end) routes2,  ");
		sb.append("       (case s.districttype when '3' then count(distinct s.routeid) end) routes3,  ");
		sb.append("       (case s.districttype when '4' then count(distinct s.routeid) end) routes4,  ");
		sb.append("       (case  when s.districttype>=0 then count(distinct s.routeid) end) routesamount, ");
		sb.append("       (case s.districttype when '0' then count(distinct s.routeid)*max(r.distance) end) distance0,  ");
		sb.append("       (case s.districttype when '1' then count(distinct s.routeid)*max(r.distance) end) distance1,  ");
		sb.append("       (case s.districttype when '2' then count(distinct s.routeid)*max(r.distance) end) distance2,  ");
		sb.append("       (case s.districttype when '3' then count(distinct s.routeid)*max(r.distance) end) distance3,  ");
		sb.append("       (case s.districttype when '4' then count(distinct s.routeid)*max(r.distance) end) distance4,  ");
		sb.append("       (case  when s.districttype>=0 then count(distinct s.routeid)*max(r.distance) end) distanceamount ");
		sb.append("       from vehiclereport vr,organization org,scheduleplan sp,schedule s,unit u,vehicle v,route r ");
		sb.append("       where org.id=vr.reportorgid and sp.scheduleid=s.id and sp.id=vr.scheduleplanid ");
		sb.append("       and r.id=s.routeid and u.id=v.unitid and v.id=vr.vehicleid ");
		sb.append("       /*and u.id in()*/ ");
		sb.append("       and vr.isactive = 1 ");
		//sb.append("       and vr.orgid=vr.reportorgid ");//班次机构=报到机构则不是配载站报到
		sb.append("       and vr.reportorgid in"+orgids+"  ");
		sb.append("       and vr.reporttime between :startdate and :enddate  ");
		sb.append("       group by org.id,org.name,s.districttype,r.id,r.name,u.id,u.name ");
		sb.append("     ) b  ");
		sb.append("     group by b.orgid,b.orgname,b.unitid,b.unitname ");
		sb.append(" ) b on b.orgid=a.orgid and b.unitid=a.unitid ");
		sb.append(" full join( ");
		sb.append("      ");//总班次数 总班线里程数
		sb.append("     select c.orgid,c.orgname,c.unitid,c.unitname, ");
		sb.append("     nvl(sum(c.schnums0),0) schnums0,nvl(sum(c.schnums1),0) schnums1,nvl(sum(c.schnums2),0) schnums2, ");
		sb.append("     nvl(sum(c.schnums3),0) schnums3,nvl(sum(c.schnums4),0) schnums4,nvl(sum(c.schnumsamount),0) schnumsamount, ");
		sb.append("     nvl(sum(c.distance0),0) distance0,nvl(sum(c.distance1),0) distance1,nvl(sum(c.distance2),0) distance2,  ");
		sb.append("     nvl(sum(c.distance3),0) distance3,nvl(sum(c.distance4),0) distance4,  ");
		sb.append("     nvl(sum(c.distance0+c.distance1+c.distance2+c.distance3+c.distance4),0) distanceamount  ");
		
		sb.append("     from ( ");
		sb.append("       select org.id orgid,org.name orgname ,u.id unitid,u.name unitname,s.id schid,s.code schname,s.districttype, ");
		sb.append("       (case s.districttype when '0' then count(s.id) end) schnums0,  ");
		sb.append("       (case s.districttype when '1' then count(s.id) end) schnums1,  ");
		sb.append("       (case s.districttype when '2' then count(s.id) end) schnums2,  ");
		sb.append("       (case s.districttype when '3' then count(s.id) end) schnums3,  ");
		sb.append("       (case s.districttype when '4' then count(s.id) end) schnums4,  ");
		sb.append("       (case  when s.districttype>=0 then count(s.id) end) schnumsamount, ");
		sb.append("       nvl(case s.districttype when '0' then sum((case s.islinework when 0 then (v.seatnum - sp.fixedreserveseatnum) else v.seatnum end)*r.distance) end,0) distance0,  ");
		sb.append("       nvl(case s.districttype when '1' then sum((case s.islinework when 0 then (v.seatnum - sp.fixedreserveseatnum) else v.seatnum end)*r.distance) end,0) distance1,  ");
		sb.append("       nvl(case s.districttype when '2' then sum((case s.islinework when 0 then (v.seatnum - sp.fixedreserveseatnum) else v.seatnum end)*r.distance) end,0) distance2,  ");
		sb.append("       nvl(case s.districttype when '3' then sum((case s.islinework when 0 then (v.seatnum - sp.fixedreserveseatnum) else v.seatnum end)*r.distance) end,0) distance3,  ");
		sb.append("       nvl(case s.districttype when '4' then sum((case s.islinework when 0 then (v.seatnum - sp.fixedreserveseatnum) else v.seatnum end)*r.distance) end,0) distance4  ");

		sb.append("       from vehiclereport vr,organization org,scheduleplan sp,schedule s,vehicle v,unit u,route r ");
		sb.append("       where org.id=vr.reportorgid and sp.scheduleid=s.id and sp.id=vr.scheduleplanid ");
		sb.append("       and v.id=vr.vehicleid and u.id=v.unitid ");
		sb.append("       /*and u.id in()*/ ");
		sb.append("       and vr.isactive = 1 and r.id=s.routeid ");
		//sb.append("       and vr.orgid=vr.reportorgid ");//班次机构=报到机构则不是配载站报到
		sb.append("       and vr.reportorgid in"+orgids+"  ");
		sb.append("       and vr.reporttime between :startdate and :enddate  ");
		sb.append("       group by org.id,org.name,s.districttype,s.id,s.code,u.id,u.name,r.id,r.name ");
		sb.append("     ) c  ");
		sb.append("     group by c.orgid,c.orgname,c.unitid,c.unitname ");
		sb.append(" ) c on c.orgid=nvl(a.orgid,b.orgid) and c.unitid=nvl(a.unitid,b.unitid) ");
		sb.append(" full join( ");
		sb.append("      ");//总班次售票座位数 周转量
		sb.append("     select d.orgid,d.orgname,d.unitid,d.unitname, ");
		sb.append("     nvl(sum(d.ticknums0),0) ticknums0,nvl(sum(d.ticknums1),0) ticknums1,nvl(sum(d.ticknums2),0) ticknums2, ");
		sb.append("     nvl(sum(d.ticknums3),0) ticknums3,nvl(sum(d.ticknums4),0) ticknums4,nvl(sum(d.ticknumsamount),0) ticknumsamount, ");
		sb.append("     nvl(sum(d.balancedistance0),0) balancedistance0,nvl(sum(d.balancedistance1),0) balancedistance1,nvl(sum(d.balancedistance2),0) balancedistance2,  ");
		sb.append("     nvl(sum(d.balancedistance3),0) balancedistance3,nvl(sum(d.balancedistance4),0) balancedistance4, ");
		sb.append("     nvl(sum(d.balancedistance0+d.balancedistance1+d.balancedistance2+d.balancedistance3+d.balancedistance4),0) balancedistanceamount ");
		sb.append("     from ( ");
		sb.append("       select org.id orgid,org.name orgname ,u.id unitid,u.name unitname,r.name routename,r.id routeid,  ");
		sb.append("       (case s.districttype when '0' then count(distinct t.id) end) ticknums0,  ");
		sb.append("       (case s.districttype when '1' then count(distinct t.id) end) ticknums1,  ");
		sb.append("       (case s.districttype when '2' then count(distinct t.id) end) ticknums2,  ");
		sb.append("       (case s.districttype when '3' then count(distinct t.id) end) ticknums3,  ");
		sb.append("       (case s.districttype when '4' then count(distinct t.id) end) ticknums4,  ");
		sb.append("       (case  when s.districttype>=0 then count(distinct t.id) end) ticknumsamount, ");
//		sb.append("       nvl(case s.districttype when '0' then count(distinct t.id)*max(r.distance) end,0) balancedistance0,  ");
//		sb.append("       nvl(case s.districttype when '1' then count(distinct t.id)*max(r.distance) end,0) balancedistance1,  ");
//		sb.append("       nvl(case s.districttype when '2' then count(distinct t.id)*max(r.distance) end,0) balancedistance2,  ");
//		sb.append("       nvl(case s.districttype when '3' then count(distinct t.id)*max(r.distance) end,0) balancedistance3,  ");
//		sb.append("       nvl(case s.districttype when '4' then count(distinct t.id)*max(r.distance) end,0) balancedistance4  ");
		sb.append("       nvl(case s.districttype when '0' then max(d.ticketnum)*max(r.distance) end,0) balancedistance0,  ");
		sb.append("       nvl(case s.districttype when '1' then max(d.ticketnum)*max(r.distance) end,0) balancedistance1,  ");
		sb.append("       nvl(case s.districttype when '2' then max(d.ticketnum)*max(r.distance) end,0) balancedistance2,  ");
		sb.append("       nvl(case s.districttype when '3' then max(d.ticketnum)*max(r.distance) end,0) balancedistance3,  ");
		sb.append("       nvl(case s.districttype when '4' then max(d.ticketnum)*max(r.distance) end,0) balancedistance4  ");
		
		sb.append("       from ticketsell t ,organization org,vehiclereport vr left join departinvoices d on d.reportid=vr.id,schedule s,vehicle v,unit u,route r ");
		sb.append("       where org.id=t.orgid ");
		sb.append("       and vr.scheduleplanid=t.scheduleplanid ");
		sb.append("       and vr.isactive = 1 ");
		sb.append("       and v.id=vr.vehicleid and u.id=v.unitid and r.id=s.routeid and t.ticketstatus=0 ");
		sb.append("       and s.id=t.scheduleid ");
		sb.append("       /*and u.id in()*/ ");
		sb.append("       and t.orgid in"+orgids+"  ");
		sb.append("       and t.selltime between :startdate and :enddate  ");
		sb.append("       group by org.id,org.name,s.districttype,u.id,u.name,r.id,r.name ");
		sb.append("     ) d ");
		sb.append("     group by d.orgid,d.orgname,d.unitid,d.unitname ");
		sb.append(" ) d on d.orgid=nvl(a.orgid,nvl(b.orgid,c.orgid)) and d.unitid=nvl(a.unitid,nvl(b.unitid,c.unitid)) ");
		
		
		if(unitid!=null){
			sb.append(" where nvl(a.unitid,nvl(b.unitid,nvl(c.unitid,d.unitid)))="+unitid);
		}
		sb.append(" order by nvl(a.orgname,nvl(b.orgname,nvl(c.orgname,d.orgname)))");

		Query query = getEntityManager().createNativeQuery(sb.toString());

		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);

		List<Object> list = query.getResultList();

		return list;
	}
}
