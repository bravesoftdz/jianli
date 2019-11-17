package cn.nova.bus.query.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;

@SuppressWarnings("rawtypes")
public class DayBookingsQryDao extends EntityManagerDaoSurport {

	/**
	 * 预售票日报表
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryDayBookings(
			List<PropertyFilter> propertyFilterList) {

		String orgids = null;

		Date startdate = null;
		Date enddate = null;
		Date compStartdate = null;
		Date compEnddate = null;
		Long routeid=null;
		Long ticketoutletsid=null;
		String ticketoutletstype=null;

		if (propertyFilterList != null && propertyFilterList.size() > 0) {
			for (int t = 0; t < propertyFilterList.size(); t++) {
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("s!orgid")) {
					orgids = (String) propertyFilterList.get(t).getMatchValue();
					continue;
				}
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("r!routeid")) {
					routeid = (Long) propertyFilterList.get(t).getMatchValue();
					continue;
				}
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("t!ticketoutletsid")) {
					ticketoutletsid = (Long) propertyFilterList.get(t).getMatchValue();
					continue;
				}
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("t!ticketoutletstype")) {
					ticketoutletstype = (String) propertyFilterList.get(t).getMatchValue();
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
		StringBuffer sb = new StringBuffer();
		 
		sb.append(" select nvl(a.orgname,nvl(b.orgname,c.orgname)),nvl(a.selltime,nvl(b.selltime,c.selltime)), ");
		sb.append(" nvl(a.routename,nvl(b.routename,c.routename)) routename,nvl(a.ticketoutletsname,nvl(b.ticketoutletsname,c.ticketoutletsname)) ticketoutletsname,");
		sb.append(" nvl(a.ticketoutletstype,nvl(b.ticketoutletstype,c.ticketoutletstype)) ticketoutletstype,");
		sb.append(" nvl(a.samedaynum,0) samedaynum,nvl(a.samedayprice,0) samedayprice,nvl(b.backtennum,0) backtennum,nvl(b.backtenprice,0) backtenprice, ");
		sb.append(" trim(to_char(case when nvl(a.samedaynum,0)=0 then 100 when nvl(b.backtennum,0)=0 then 0  ");
		sb.append(" else b.backtennum/(a.samedaynum+b.backtennum)*100 end,'999999990.99')) || '%' numPercent, ");
		sb.append(" trim(to_char(case when nvl(a.samedayprice,0)=0 then 100 when nvl(b.backtenprice,0)=0 then 0  ");
		sb.append(" else b.backtenprice/(a.samedayprice+b.backtenprice)*100 end,'999999990.99')) || '%' pricePercent, ");
		sb.append(" nvl(c.samedaynum1,0),nvl(c.samedaynum2,0),nvl(c.samedaynum3,0),nvl(c.samedaynum4,0),nvl(c.samedaynum5,0),nvl(c.samedaynum6,0), ");
		sb.append(" nvl(c.samedaynum7,0),nvl(c.samedaynum8,0),nvl(c.samedaynum9,0),nvl(c.samedaynum10,0) ");
		sb.append(" from (  ");
//		sb.append(" --当日运量，当日金额 ");
		sb.append("     select t.orgid orgid,o.name as orgname,r.id routeid,r.name routename,tos.id ticketoutletsid,tos.name ticketoutletsname,tos.type ticketoutletstype,to_char(t.selltime,'yyyy-MM-dd') selltime,to_char(t.departdate,'yyyy-MM-dd') departdate, ");
		sb.append("     count(t.id) samedaynum,sum(t.price) samedayprice ");
		sb.append("     from Ticketsell t ,Schedule sh,Route r,Ticketoutlets tos, Organization o  ");
		sb.append("     where t.orgid = o.id and sh.id=t.scheduleid and r.id=sh.routeid and tos.id=t.ticketoutletsid ");
		sb.append("     and t.ticketstatus ='0' ");
		sb.append("     and t.orgid in"+orgids+" ");
		sb.append("     and t.selltime between :startdate and :enddate ");
		sb.append("     and t.departdate between :startdate and :startdate ");
		if(routeid!=null){
			sb.append(" and r.id="+routeid+"");
		}

		if(ticketoutletsid!=null){
			sb.append(" and tos.id="+ticketoutletsid+"");
		}
		
		if(ticketoutletstype!=null){
			sb.append(" and tos.type = '"+ticketoutletstype+"'");
		}
		sb.append("     group by t.orgid,o.name,r.id,r.name,tos.id,tos.name,tos.type,to_char(t.selltime,'yyyy-MM-dd'),to_char(t.departdate,'yyyy-MM-dd') ");
		sb.append(" ) a ");
		sb.append(" full join ( ");
//		sb.append(" --后10天运量 运量金额 ");
		sb.append("   select t.orgid orgid,o.name as orgname,r.id routeid,r.name routename,tos.id ticketoutletsid,tos.name ticketoutletsname,tos.type ticketoutletstype,to_char(t.selltime,'yyyy-MM-dd') selltime, ");
		sb.append("   count(t.id) backtennum,sum(t.price) backtenprice ");
		sb.append("   from Ticketsell t ,Schedule sh,Route r,Ticketoutlets tos, Organization o  ");
		sb.append("   where t.orgid = o.id and sh.id=t.scheduleid and r.id=sh.routeid and tos.id=t.ticketoutletsid ");
		sb.append("   and t.ticketstatus ='0' ");
		sb.append("   and t.orgid in"+orgids+" ");
		sb.append("   and t.selltime between :startdate and :enddate ");
		sb.append("   and t.departdate between :compSdate and :compEdate ");
		if(routeid!=null){
			sb.append(" and r.id="+routeid+"");
		}

		if(ticketoutletsid!=null){
			sb.append(" and tos.id="+ticketoutletsid+"");
		}
		
		if(ticketoutletstype!=null){
			sb.append(" and tos.type = '"+ticketoutletstype+"'");
		}
		sb.append("   group by t.orgid,o.name,r.id,r.name,tos.id,tos.name,tos.type,to_char(t.selltime,'yyyy-MM-dd') ");
		sb.append(" ) b on a.orgid=b.orgid and a.selltime=b.selltime and a.routeid=b.routeid and a.ticketoutletsid=b.ticketoutletsid and a.ticketoutletstype=b.ticketoutletstype");
//		sb.append(" --后10天预售票数 ");
		sb.append(" full join( ");
		sb.append("    select orgid,orgname,selltime,routeid,routename,ticketoutletsid,ticketoutletsname,ticketoutletstype, ");
		sb.append("     sum(samedaynum1) samedaynum1,sum(samedaynum2) samedaynum2,sum(samedaynum3) samedaynum3, ");
		sb.append("     sum(samedaynum4) samedaynum4,sum(samedaynum5) samedaynum5,sum(samedaynum6) samedaynum6, ");
		sb.append("     sum(samedaynum7) samedaynum7,sum(samedaynum8) samedaynum8,sum(samedaynum9) samedaynum9, ");
		sb.append("     sum(samedaynum10) samedaynum10 ");
		sb.append("     from( ");
		sb.append("       select t.orgid orgid,o.name as orgname,r.id routeid,r.name routename,tos.id ticketoutletsid,tos.name ticketoutletsname,tos.type ticketoutletstype,to_char(t.selltime,'yyyy-MM-dd') selltime, ");
		sb.append("       (case when trunc(:compEdate)-trunc(t.departdate)=10 then nvl(count(t.id),0) else 0 end) samedaynum1, ");
		sb.append("       (case when trunc(:compEdate)-trunc(t.departdate)=9 then nvl(count(t.id),0) else 0 end) samedaynum2, ");
		sb.append("       (case when trunc(:compEdate)-trunc(t.departdate)=8 then nvl(count(t.id),0) else 0 end) samedaynum3, ");
		sb.append("       (case when trunc(:compEdate)-trunc(t.departdate)=7 then nvl(count(t.id),0) else 0 end) samedaynum4, ");
		sb.append("       (case when trunc(:compEdate)-trunc(t.departdate)=6 then nvl(count(t.id),0) else 0 end) samedaynum5, ");
		sb.append("       (case when trunc(:compEdate)-trunc(t.departdate)=5 then nvl(count(t.id),0) else 0 end) samedaynum6, ");
		sb.append("       (case when trunc(:compEdate)-trunc(t.departdate)=4 then nvl(count(t.id),0) else 0 end) samedaynum7, ");
		sb.append("       (case when trunc(:compEdate)-trunc(t.departdate)=3 then nvl(count(t.id),0) else 0 end) samedaynum8, ");
		sb.append("       (case when trunc(:compEdate)-trunc(t.departdate)=2 then nvl(count(t.id),0) else 0 end) samedaynum9, ");
		sb.append("       (case when trunc(:compEdate)-trunc(t.departdate)=1 then nvl(count(t.id),0) else 0 end) samedaynum10 ");
		sb.append("        ");
		sb.append("       from Ticketsell t ,Schedule sh,Route r,Ticketoutlets tos, Organization o  ");
		sb.append("       where t.orgid = o.id and sh.id=t.scheduleid and r.id=sh.routeid and tos.id=t.ticketoutletsid ");
		sb.append("       and t.ticketstatus ='0' ");
		sb.append("       and t.orgid in"+orgids+" ");
		sb.append("       and t.selltime between :startdate and :enddate ");
		sb.append("       and t.departdate between :compSdate and :compEdate ");
		if(routeid!=null){
			sb.append(" and r.id="+routeid+"");
		}

		if(ticketoutletsid!=null){
			sb.append(" and tos.id="+ticketoutletsid+"");
		}
		
		if(ticketoutletstype!=null){
			sb.append(" and tos.type = '"+ticketoutletstype+"'");
		}
		sb.append("       group by t.orgid,o.name,r.id,r.name,tos.id,tos.name,tos.type,to_char(t.selltime,'yyyy-MM-dd'),t.departdate ");
		sb.append("     ) c group by c.orgid,c.orgname,c.routeid,c.routename,c.ticketoutletsid,c.ticketoutletsname,c.ticketoutletstype,c.selltime ");
		sb.append(" ) c on nvl(a.orgid,b.orgid)=c.orgid and nvl(a.selltime,b.selltime)=c.selltime and nvl(a.routeid,b.routeid)=c.routeid and nvl(a.ticketoutletstype,b.ticketoutletstype)=c.ticketoutletstype");
		sb.append(" and nvl(a.ticketoutletsid,b.ticketoutletsid)=c.ticketoutletsid");
		sb.append(" where 1=1 ");
		

		//sb = new StringBuffer("select floor(trunc(:compEdate)-trunc(t.departdate))   from Ticketsell t   where  t.ticketstatus ='1' and t.selltime between to_date('2012-10-05','yyyy-MM-dd') and to_date('2012-10-06','yyyy-MM-dd') and t.departdate between to_date('2012-10-06','yyyy-MM-dd') and to_date('2012-10-16','yyyy-MM-dd')");
		Query query = getEntityManager().createNativeQuery(sb.toString());

		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		query.setParameter("compSdate", compStartdate);
		query.setParameter("compEdate", compEnddate);

		List<Object> list = query.getResultList();

		return list;
	}
}
