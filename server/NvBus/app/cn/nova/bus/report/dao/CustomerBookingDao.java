package cn.nova.bus.report.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class CustomerBookingDao extends EntityManagerDaoSurport{

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
	 * 订票统计查询
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> QueryCustomerBooking(String orgid,Date startdate,Date enddate) {
		StringBuilder sql = new StringBuilder();
		/*sql.append(" select o.name orgname,cu.name cusname,cu.sex,cu.mobilephone,count(se.id) bookingnum, ");
		sql.append(" nvl((case se.sellstate when 'R' then count(se.id) end),0) R, ");
		sql.append(" nvl((case se.sellstate when 'S' then count(se.id) end),0) S, ");
		sql.append(" nvl((case se.sellstate when 'C' then count(se.id) end),0) C, ");
		sql.append(" cu.certificatetype,cu.certificateno,cu.email ");
		  
		sql.append(" from seatreserve se,customer cu,userinfo u,organization o  ");
		sql.append(" where u.id=se.reserveby and o.id=u.orgid ");
		sql.append(" and u.orgid in"+orgid+" ");
		sql.append(" and cu.id=se.customerid and se.reserveway in(1,2) ");
		sql.append(" and se.createtime between :startdate and :enddate ");
		sql.append(" group by o.id,o.name,se.sellstate,cu.id,cu.name,cu.sex,cu.mobilephone,cu.certificatetype,cu.certificateno,cu.email ");*/
		
		sql.append(" select a.orgname,a.cusname,a.sex,a.mobilephone,sum(a.bookingnum) bookingnum,  ");
		sql.append("      sum(R) R, sum(S) S,sum(C) C, ");
		sql.append("      a.certificatetype,a.certificateno,a.email  ");
		sql.append(" from(      ");
		sql.append("      select o.id orgid,o.name orgname,cu.id cuid,se.sellstate,cu.name cusname,cu.sex,cu.mobilephone,count(se.id) bookingnum,  ");
		sql.append("      nvl((case se.sellstate when 'R' then count(se.id) end),0) R,  ");
		sql.append("      nvl((case se.sellstate when 'S' then count(se.id) end),0) S,  ");
		sql.append("      nvl((case se.sellstate when 'C' then count(se.id) end),0) C,  ");
		sql.append("      cu.certificatetype,cu.certificateno,cu.email  ");
		sql.append("        ");
		sql.append("      from seatreserve se,customer cu,userinfo u,organization o   ");
		sql.append("      where u.id=se.reserveby and o.id=u.orgid  ");
		sql.append("      and u.orgid in"+orgid+"  ");
		sql.append("      and cu.id=se.customerid and se.reserveway in(1,2)  ");
		sql.append("      and se.createtime between :startdate and :enddate    ");
		sql.append("      group by o.id,o.name,cu.id,cu.name,se.sellstate,cu.sex,cu.mobilephone,cu.certificatetype,cu.certificateno,cu.email  ");
		sql.append(" ) a ");
		sql.append(" group by a.orgname,a.orgid,a.cusname,a.sex,a.mobilephone,a.certificatetype,a.certificateno,a.email ");
		
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		return query.getResultList();
	}
	
	
	/**
	 * 班次预售情况查询
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> QueryPersellSum(
			List<PropertyFilter> propertyFilterList) {
		/*
		 * 
	select ve.routename,
       ve.departdate,
       trim(ve.departtime),
       ve.isovertime,
       sum(ve.sellnum),
       sum(ve.sellprice),
       ve.code,
       sum(ve.ticreturnnum),
       sum(ve.totalreturnmoney),
       sum(ve.cancelticketnum),
       sum(ve.cancelservicefee),
       sum(ve.sellprice)-sum(ve.totalreturnmoney)-sum(ve.cancelservicefee) as actualamount
  from (select r.name routename,
               ts.departdate,
               trim(ts.departtime) departtime,
               s.isovertime,
               count(ts.id) sellnum,
               sum(ts.price) sellprice,
               s.code,
               0 ticreturnnum,
               0 totalreturnmoney,
               0 cancelticketnum,
               0 cancelservicefee
          from Ticketsell   ts,
               Scheduleplan sp,
               Schedule     s,
               route        r,
               Organization o
         where ts.scheduleplanid = sp.id
           and o.id = ts.orgid
           and s.routeid = r.id
           and ts.ticketstatus = '0'
           and sp.scheduleid = s.id
           and to_date(ts.selltime) < ts.departdate
           and sp.departdate >= date '2015-12-01'
           and sp.departdate <= date '2015-12-31'
           and s.orgid in (1158012)
         group by r.name,
                  ts.departdate,
                  trim(ts.departtime),
                  s.isovertime,
                  s.code
        union all
        select r.name routename,
               ts.departdate,
               trim(ts.departtime) departtime,
               s.isovertime,
               0 sellnum,
               0 sellprice,
               s.code,
               count(tr.id) as ticreturnnum,
               sum(tr.returnamount) as totalreturnmoney,
               0 cancelticketnum,
               0 cancelservicefee
          from ticketreturn tr
          left join ticketsell ts on tr.sellid = ts.id
          left join scheduleplan sp on ts.scheduleplanid = sp.id
          left join Schedule s on sp.scheduleid = s.id
          left join route r on s.routeid = r.id
          left join Organization o on ts.orgid = o.id
         where tr.isselfschedule = 1
           and tr.RETURNTIME >= date '2015-12-01'
           and tr.RETURNTIME < date '2015-12-31'
         group by r.name,
                  ts.departdate,
                  trim(ts.departtime),
                  s.isovertime,
                  s.code
        union all
        select r.name routename,
               ts.departdate,
               trim(ts.departtime) departtime,
               s.isovertime,
               0 sellnum,
               0 sellprice,
               s.code,
               0 ticreturnnum,
               0 totalreturnmoney,
               count(tc.id) as cancelticketnum,
               sum(ts.servicefee) as cancelservicefee
          from ticketcancel tc
          left join ticketsell ts on tc.sellid = ts.id
          left join scheduleplan sp on ts.scheduleplanid = sp.id
          left join Schedule s on sp.scheduleid = s.id
          left join route r on s.routeid = r.id
          left join Organization o on ts.orgid = o.id
         where tc.isselfschedule = 1
           and tc.canceltime >= date '2015-12-01'
           and tc.canceltime <= date '2015-12-31'
         group by r.name,
                  ts.departdate,
                  trim(ts.departtime),
                  s.isovertime,
                  s.code
        ) ve
 group by ve.routename,
          ve.departdate,
          trim(ve.departtime),
          ve.isovertime,
          ve.code
		 */
		StringBuilder sql = new StringBuilder();
//		sql.append(" select r.name routename,") 李电志 2015年12月25日 10:32:35 注释
//		.append(" ts.departdate,")
//		.append(" trim(ts.departtime),")
//		.append(" s.isovertime,")
//		.append(" count(ts.id) sellnum,")
//		.append(" sum(ts.price) sellprice")
//		.append(" from Ticketsell ts, Scheduleplan sp, Schedule s, route r, Organization o")
//		.append(" where ts.scheduleplanid = sp.id")
//		.append(" and o.id = ts.orgid")
//		.append(" and s.routeid = r.id")
//		.append(" and ts.ticketstatus = '0'")
//		.append(" and sp.scheduleid = s.id")
//		.append(" and to_date(ts.selltime) < ts.departdate ");李电志 2015年12月25日 10:32:35 注释
		
//		.append(" union all") //代售异站票
//		.append(" select std.name || '-' || str.name routename,")
//		.append(" ts.departdate,")
//		.append(" trim(ts.departtime),")
//		.append(" 0 isovertime,")
//		.append(" count(ts.id) sellnum,")
//		.append(" sum(ts.price)")
//		.append(" from Ticketsellagent ts, Station std, Station str")
//		.append(" where ts.departstationid = std.id")
//		.append(" and ts.reachstationid = str.id")
//		.append(" and ts.departdate >= to_date('20140316', 'yyyymmdd')")
//		.append(" and to_date(ts.selltime) < ts.departdate")
//		.append(" group by ts.departdate, ts.departtime, std.name, str.name ");
		
		//李电志 2015年12月25日 10:33:02 
		sql.append(" select ve.routename as routename,")
		   .append(" ve.departdate as departdate, ")
		   .append(" trim(ve.departtime) as departtime, ")
		   .append(" ve.isovertime as isovertime, ")
		   .append(" sum(ve.sellnum) as sellnum, ")
		   .append(" sum(ve.sellprice) as sellprice, ")
		   .append(" ve.code as code, ")
		   .append(" sum(ve.ticreturnnum) as ticreturnnum, ")
		   .append(" sum(ve.totalreturnmoney) as totalreturnmoney, ")
		   .append(" sum(ve.cancelticketnum) as cancelticketnum, ")
		   .append(" sum(ve.cancelservicefee) as cancelservicefee, ")
		   .append(" sum(ve.sellprice)-sum(ve.totalreturnmoney)-sum(ve.cancelservicefee) as actualamount ")
	  .append(" from (select r.name routename, ")
				   .append(" ts.departdate, ")
				   .append(" trim(ts.departtime) departtime, ")
				   .append(" s.isovertime, ")
				   .append(" count(ts.id) sellnum, ")
				   .append(" sum(ts.price) sellprice, ")
				   .append(" s.code, ")
				   .append(" 0 ticreturnnum, ")
				   .append(" 0 totalreturnmoney, ")
				   .append(" 0 cancelticketnum, ")
				   .append(" 0 cancelservicefee ")
				   .append(" from Ticketsell   ts, ")
				   .append(" Scheduleplan sp, ")
				   .append(" Schedule     s, ")
				   .append(" route        r, ")
				   .append(" Organization o ")
				   .append(" where ts.scheduleplanid = sp.id ")
				   .append(" and o.id = ts.orgid ")
				   .append(" and s.routeid = r.id ")
				   .append(" and ts.ticketstatus = '0' ")
				   .append(" and sp.scheduleid = s.id ")
				   .append(" and to_date(ts.selltime) < ts.departdate ") ;
				   sql.append(PropertyFilter.toJpql(propertyFilterList, true));
//				   .append(" and sp.departdate >= date '2015-12-01' ")
//				   .append(" and sp.departdate <= date '2015-12-31' ")
//				   .append(" and s.orgid in (1158012) ")
				   sql.append(" group by r.name, ")
				   .append(" ts.departdate, ")
				   .append(" trim(ts.departtime), ")
				   .append(" s.isovertime, ")
				   .append(" s.code ")
				   .append(" union all ")
				   .append(" select r.name routename, ")
				   .append(" ts.departdate, ")
				   .append(" trim(ts.departtime) departtime, ")
				   .append(" s.isovertime, ")
				   .append(" 0 sellnum, ")
				   .append(" 0 sellprice, ")
				   .append(" s.code, ")
				   .append(" count(tr.id) as ticreturnnum, ")
				   .append(" sum(tr.returnamount) as totalreturnmoney, ")
				   .append(" 0 cancelticketnum, ")
				   .append(" 0 cancelservicefee ")
				   .append(" from ticketreturn tr, ")
				   .append(" ticketsell ts,  ")
				   .append(" scheduleplan sp, ")
				   .append(" Schedule s, ")
				   .append(" route r, ")
				   .append(" Organization o  ")
				   .append(" where tr.isselfschedule = 1 ")
				   .append(" and tr.sellid = ts.id ")
				   .append(" and ts.scheduleplanid = sp.id ")
				   .append(" and sp.scheduleid = s.id ")
				   .append(" and s.routeid = r.id ")
				   .append(" and ts.orgid = o.id ")
				   .append("  and to_date(ts.selltime) < ts.departdate ")
				   .append(PropertyFilter.toJpql(propertyFilterList, true))
//				   .append(" and tr.RETURNTIME >= :startdate ")
//				   .append(" and tr.RETURNTIME <= :enddate ")
				   .append(" group by r.name, ")
				   .append(" ts.departdate, ")
				   .append(" trim(ts.departtime), ")
				   .append(" s.isovertime, ")
				   .append(" s.code ")
				   .append(" union all ")
				   .append(" select r.name routename, ")
				   .append(" ts.departdate, ")
				   .append(" trim(ts.departtime) departtime, ")
				   .append(" s.isovertime, ")
				   .append(" 0 sellnum, ")
				   .append(" 0 sellprice, ")
				   .append(" s.code, ")
				   .append(" 0 ticreturnnum, ")
				   .append(" 0 totalreturnmoney, ")
				   .append(" count(tc.id) as cancelticketnum, ")
				   .append(" sum(ts.servicefee) as cancelservicefee ")
				   .append(" from ticketcancel tc, ")
				   .append(" ticketsell ts,  ")
				   .append(" scheduleplan sp,")
				   .append(" Schedule s,  ")
				   .append(" route r,  ")
				   .append(" Organization o ")
				   .append(" where tc.isselfschedule = 1 ")
				   .append(" and ts.scheduleplanid = sp.id ")
				   .append(" and  sp.scheduleid = s.id ")
				   .append(" and  ts.orgid = o.id ")
				   .append(" and s.routeid = r.id ")
				   .append(" and tc.sellid = ts.id ")
				   .append("  and to_date(ts.selltime) < ts.departdate ")
//				   .append(" and tc.canceltime >= :startdate ")
//				   .append(" and tc.canceltime <= :enddate ")
				   .append(PropertyFilter.toJpql(propertyFilterList, true))
				   .append(" group by r.name, ")
				   .append(" ts.departdate, ")
				   .append(" trim(ts.departtime), ")
				   .append(" s.isovertime, ")
				   .append("  s.code ")
				   .append(" ) ve ") 
	    .append(" group by ve.routename, ve.departdate, trim(ve.departtime), ve.isovertime, ve.code ") ;
//				  Object ob = propertyFilterList.get(0).getMatchValue();
//				  Object ob1 = propertyFilterList.get(2).getMatchValue();
//		sql.append(" group by r.name, ts.departdate, trim(ts.departtime), s.isovertime ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
//		query.setParameter("startdate", ob);
//		query.setParameter("enddate", ob1);
		return query.getResultList();
	}
}
