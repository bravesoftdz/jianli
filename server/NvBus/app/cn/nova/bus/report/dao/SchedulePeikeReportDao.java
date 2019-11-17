package cn.nova.bus.report.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

public class SchedulePeikeReportDao extends EntityManagerDaoSurport{
	@SuppressWarnings("unchecked")
	public List<Object> qrySchedulePeike(
			List<PropertyFilter> propertyFilterList,Date oldstartdepartdate,String schedulecode) {
		// TODO Auto-generated method stub
		List<Object> li = this.getScheduleseatnum(oldstartdepartdate, schedulecode);
						
		StringBuffer sql = new StringBuffer();
		sql.append(" select cc.seatno,cc.reachstation,cc.oldschedulecode,cc.oldseatno,dd.seatno2,dd.reachstation2,dd.oldschedulecode2,dd.oldseatno2 from ")
		.append(" (select ee.seatno,ee.reachstation,ee.oldschedulecode,ee.oldseatno,rownum rn from ")
		.append(" (select aa.seatno,aa.reachstation,aa.oldschedulecode,aa.oldseatno,rownum rn from  ")
		.append(" (select ts.seatno as seatno,ste.name || '     ' || tos.name || '售' as reachstation, ")
		.append(" null as oldschedulecode,null as oldseatno ")
		.append("  from Ticketsell ts,Scheduleplan sp,Schedule s,Organization o,Station ste,Schedulevehiclepeopleplan svp,Tickettype tt,Ticketoutlets tos ")
		
		.append(" where ts.scheduleplanid = sp.id and o.id = ts.orgid and sp.scheduleid = s.id and ste.id = ts.reachstationid ")
		.append(" and ts.scheduleplanid = svp.scheduleplanid and svp.orderno = 0 and ts.sellway = 0 and ts.ticketstatus = 0 and tt.code = ts.tickettype ")
//		.append(" and ts.ticketoutletsid = tos.id and ts.orgid in (1031531) ")
		.append(" and ts.ticketoutletsid = tos.id ")
		.append(PropertyFilter.toJpql(propertyFilterList, true))
		
		
		.append(" union ")
		.append(" select tm.newseatno as seatno,oest.name || '     ' || tos.name || '售' as reachstation,s.code as oldschdulecode,tm.oldseatno as oldseatno  ");

				
		sql.append(" from ticketmixcheck tm left join ticketsell ots on tm.ticketsellid = ots.id left join station oest on ots.reachstationid = oest.id, organization o, ")
		.append(" schedule s, Ticketoutlets tos where tm.orgid = o.id and tm.oldscheduleid = s.id and ots.ticketoutletsid = tos.id ")
		
		.append(" and tm.olddepartdate = :oldstartdepartdate  ");
		if(schedulecode!=null && !"".equals(schedulecode)){
		    sql.append(" and s.code like '").append(schedulecode).append("' ");
	    }
		sql.append(" union ")
		.append(" select sp.seatno,'订票' || c.certificateno as reachstation,null as oldscheduleid,null as oldseatno ")
		.append(" from seatreserve sp left join customer c on sp.customerid = c.id left join schedule s on sp.scheduleid = s.id ")
		.append(" where 1 = 1 and sp.isautocancel = 0 and sp.customerid is not null ")
		.append(PropertyFilter.toJpql(propertyFilterList, true))
		
		.append(" union ")
		.append(" select sp.seatno,'留座' as reachstation,null as oldscheduleid,null as oldseatno ")
		.append(" from seatreserve sp left join schedule s on sp.scheduleid = s.id ")
		.append(" where 1 = 1 and sp.isautocancel = 0 and sp.customerid is null ")
		.append(PropertyFilter.toJpql(propertyFilterList, true))
		
		.append(" ) aa) ee where rn<=round(");
		if(li==null||li.size()==0){
			sql.append(50);
		}else{
			sql.append(li.get(0));
		}
		sql.append("/2)) cc full join  ")
		
		.append(" (select bb.seatno as seatno2,bb.reachstation as reachstation2,bb.oldschedulecode as oldschedulecode2,bb.oldseatno as oldseatno2,rownum rn from ")
		.append(" (select aa.seatno,aa.reachstation,aa.oldschedulecode,aa.oldseatno,rownum rn from ")
		.append(" (select ts.seatno as seatno,ste.name || '     ' || tos.name || '售' as reachstation,null as oldschedulecode, ")
		.append(" null as oldseatno ")
		.append(" from Ticketsell ts,Scheduleplan sp,Schedule s,Organization o,Station ste,Schedulevehiclepeopleplan svp,Tickettype  tt,Ticketoutlets tos ")
		.append(" where ts.scheduleplanid = sp.id and o.id = ts.orgid and sp.scheduleid = s.id and ste.id = ts.reachstationid ")
		.append(" and ts.scheduleplanid = svp.scheduleplanid and svp.orderno = 0 and ts.sellway = 0 and ts.ticketstatus = 0 ")
		.append(" and tt.code = ts.tickettype and ts.ticketoutletsid = tos.id  ")
		.append(PropertyFilter.toJpql(propertyFilterList, true))
		
		
		.append(" union ")
		.append(" select tm.newseatno as seatno,oest.name || '     ' || tos.name || '售' as reachstation,s.code as oldschdulecode, ")
		.append(" tm.oldseatno as oldseatno from ticketmixcheck tm ")
		.append(" left join ticketsell ots on tm.ticketsellid = ots.id ")
		.append(" left join station oest on ots.reachstationid = oest.id, organization o,schedule s, Ticketoutlets tos ")
		.append(" where tm.orgid = o.id and tm.oldscheduleid = s.id and ots.ticketoutletsid = tos.id ")
		.append(" and tm.olddepartdate = :oldstartdepartdate ");
		if(schedulecode!=null && !"".equals(schedulecode)){
		    sql.append(" and s.code like '").append(schedulecode).append("' ");
	    }
		
		sql.append(" union ")
		.append(" select sp.seatno,'订票' || c.certificateno as reachstation,null as oldscheduleid,null as oldseatno ")
		.append(" from seatreserve sp left join customer c on sp.customerid = c.id ")
		.append(" left join schedule s on sp.scheduleid = s.id ")
		.append("  where 1 = 1 and sp.isautocancel = 0 and sp.customerid is not null ")
		.append(PropertyFilter.toJpql(propertyFilterList, true))
		
		
		.append(" union ")
		.append(" select sp.seatno,'留座' as reachstation,null as oldscheduleid,null as oldseatno ")
		.append(" from seatreserve sp left join schedule s on sp.scheduleid = s.id ")
		.append(" where 1 = 1 and sp.isautocancel = 0 and sp.customerid is null ")
		.append(PropertyFilter.toJpql(propertyFilterList, true))
		
//		.append(" and sp.departdate = date '2014-10-14' and s.code like '%NZ8%' ")
		
		.append(" ) aa) bb where rn>round(");
		if(li==null||li.size()==0){
			sql.append(50);
		}else{
			sql.append(li.get(0));
		}
		
		sql.append("/2)) dd  on cc.rn=dd.rn order by cc.seatno ");
		
		
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		query.setParameter("oldstartdepartdate",oldstartdepartdate);
		
		return query.getResultList();
	}
	public List<Object> getScheduleseatnum(Date departdate,String schedulecode){
		
		StringBuffer sb = new StringBuffer();
		sb.append("select tt.seatnum from scheduleplan tt ")
		.append(" where tt.scheduleid=(select id from schedule t where 1=1 ");
		if(schedulecode!=null && !"".equals(schedulecode)){
		    sb.append(" and t.code = '").append(schedulecode).append("' ");
	    }
		sb.append(" ) and tt.departdate= :departdate ");
		Query query = getEntityManager().createNativeQuery(sb.toString());
		query.setParameter("departdate",departdate);
		return query.getResultList();
	}
	public List<Object> qryTicketoutcodeSellticket(
			List<PropertyFilter> propertyFilterList,Date oldstartdepartdate,String schedulecode) {
		StringBuffer countsql = new StringBuffer();
		countsql.append(" select ticketoutcode,sum(total) countticket from ")
		.append(" (select tos.name ticketoutcode, count(tos.name) total from Ticketsell ts,Scheduleplan sp,")
		.append(" Schedule s,Organization o,Station ste,Schedulevehiclepeopleplan svp,Tickettype tt,Ticketoutlets tos ")
		.append(" where ts.scheduleplanid = sp.id and o.id = ts.orgid and sp.scheduleid = s.id and ste.id = ts.reachstationid ")
		.append(" and ts.scheduleplanid = svp.scheduleplanid and svp.orderno = 0 and ts.sellway = 0 ")
		.append("  and ts.ticketstatus = 0 and tt.code = ts.tickettype and ts.ticketoutletsid = tos.id  ")
		.append(PropertyFilter.toJpql(propertyFilterList, true))
		.append(" group by tos.name ")
		.append(" union ")
		.append(" select tos.name ticketoutcode, count(tos.name) total from ticketmixcheck tm ")
		.append(" left join ticketsell ots on tm.ticketsellid = ots.id ")
		.append(" left join station oest on ots.reachstationid = oest.id, organization o,schedule s, Ticketoutlets tos ")
		.append(" where tm.orgid = o.id and tm.oldscheduleid = s.id and ots.ticketoutletsid = tos.id ")
		.append(" and tm.olddepartdate = :departdate  and s.code like '%").append(schedulecode).append("%' ")
		.append(" group by tos.name) group by ticketoutcode ")
		.append(" union ")
		.append(" select  '留订座' as ticketoutcode,count(sp.seatno) countticket from seatreserve sp ")
		.append(" left join customer c on sp.customerid = c.id ")
		.append(" left join schedule s on sp.scheduleid = s.id ")
		.append(" where 1 = 1 and sp.isautocancel = 0 ")
		.append(PropertyFilter.toJpql(propertyFilterList, true));
//		.append("  and sp.departdate = date '2014-11-10' and s.code like '%111%' ");
		Query query = getEntityManager().createNativeQuery(countsql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		query.setParameter("departdate",oldstartdepartdate);
		return query.getResultList();
	}
	
}
