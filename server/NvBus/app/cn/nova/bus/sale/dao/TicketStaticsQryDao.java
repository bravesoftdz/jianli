package cn.nova.bus.sale.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

public class TicketStaticsQryDao extends EntityManagerDaoSurport {

	/**
	 * 查询车票营收统计
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> query(int sellticketunit, Date beginselltime, Date endselltime) {
		StringBuffer sql = new StringBuffer();
		if (sellticketunit == 0) {// 售票点
			sql.append(" select ticketunit,sum(ticketnum) ticketnum,sum(ticketprice) ticketprice,"
					+ "sum(returnnum) returnnum,sum(returnprice) returnprice,sum(charges) charges,"
					+ "sum(changenum) changenum,sum(ticketnum) - sum(returnnum)  balanceticketnum,"
					//+ "sum(netticketprice) - sum(netreturnprice) + sum(netcharegs) netbalanceprice,"
					//+ "sum(ticketprice)-sum(returnprice)+sum(charges) balanceprice from ")
					+ "sum(netticketprice) - sum(netreturnprice) - sum(cancelprice) netbalanceprice,")//之前减退票款，加手续费，是错误的，手续费加重复
					.append("sum(ticketprice)-sum(returnprice)+sum(charges) - sum(cancelprice) balanceprice, ")
					.append("  sum(cancelnum) cancelnum, sum(cancelprice) cancelprice ")
					.append(" from ")
					.append(" (select tos.name ticketunit,count(ts.id) ticketnum,sum(ts.price) ticketprice,"
							+ "0 returnnum,0 returnprice,0 charges,0 changenum,sum(ts.price) netticketprice,"
							+ "0 netreturnprice,0 netcharegs, 0 cancelnum, 0 cancelprice from ticketsell ts,ticketoutlets tos,schedule s,"
							+ "organization org where ts.ticketoutletsid = tos.id and ts.sellway not in ( '10') ")
					.append(" and ts.selltime >= :beginselltime and ts.selltime <= :endselltime+0.99999 "
							+ " and (ts.orgid=s.orgid or (ts.orgid<>s.orgid and ts.sellway=7 )) ")
					.append(" and ts.scheduleid = s.id and tos.id>0  and ts.orgid=org.id and org.type<>'0'"
							+ " group by tos.name ")
					.append(" union all ")

					.append(" select tos.name ticketunit,0 ticketnum,0 ticketprice,count(tr.id) returnnum,"
							+ "sum(tr.ticketprice) returnprice,sum(tr.charges) charges,0 changenum,0 netticketprice,"
							+ "sum(tr.returnamount) netreturnprice,sum(tr.charges) netcharegs, 0 cancelnum, 0 cancelprice from ticketsell ts,"
							+ "ticketreturn tr,ticketoutlets tos,schedule s,organization org  where  ts.id=tr.sellid"
							+ " and tr.ticketoutletsid = tos.id  ")
					.append("  and ts.sellway not in ( '10') and tr.returntime  >= :beginselltime and tr.returntime"
							+ "  <= :endselltime+0.99999 ")
					.append("  and tos.id>0 and tos.orgid=org.id and org.type<>'0'   and ts.scheduleid=s.id"
							+ " and (ts.orgid=s.orgid or (ts.orgid<>s.orgid and ts.sellway=7 )) group by tos.name ")
					.append(" union all ")
					
					//废票
					.append(" select tos.name ticketunit, 0 ticketnum, 0 ticketprice, ")
					.append("  0 returnnum, 0 returnprice, 0 charges, 0 changenum, ")
					.append("  0 netticketprice, 0 netreturnprice, 0 netcharegs, ")
					.append("  count(tc.id) cancelnum, sum(tc.ticketprice) cancelprice ")
					.append(" from ticketsell ts, ticketcancel tc, ticketoutlets tos, schedule s, organization org ")
					.append(" where ts.id = tc.sellid and tc.ticketoutletsid = tos.id and ts.sellway not in ( '10') ")
					.append("  and tos.id > 0 and tos.orgid = org.id and org.type <> '0' and ts.scheduleid = s.id ")
					.append("  and (ts.orgid = s.orgid or (ts.orgid <> s.orgid and ts.sellway = 7 )) ")
					.append("  and tc.canceltime  >= :beginselltime and tc.canceltime <= :endselltime + 0.99999 ")
					.append(" group by tos.name ")
					.append(" union all ")

					.append(" select tos.name ticketunit,0 ticketnum,0 ticketprice,0 returnnum,0 returnprice,"
							+ "sum(ts.servicefee) charges,count(tc.id) changenum,0 netticketprice, 0 netreturnprice,"
							+ "0 netcharegs, 0 cancelnum, 0 cancelprice  from ticketsell ts,ticketchange tc,ticketoutlets tos,schedule s ,"
							+ "organization org where ts.id=tc.newticketsellid  and tc.ticketoutletsid = tos.id"
							+ " and ts.sellway not in ('10') ")
					.append(" and tc.changetime  >= :beginselltime and tc.changetime  <= :endselltime+0.99999"
							+ " and ts.scheduleid=s.id  and (ts.orgid=s.orgid or (ts.orgid<>s.orgid and ts.sellway=7 ))")
					.append("  and tos.id>0 and tos.orgid=org.id and org.type<>'0'  group by tos.name )")
					.append(" group by ticketunit ").append(" order by ticketunit ");

			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("beginselltime", beginselltime);
			query.setParameter("endselltime", endselltime);
			return query.getResultList();

		} else if (sellticketunit == 1) {// 自助机

			sql.append(" select ticketunit,sum(ticketnum) ticketnum,sum(ticketprice) ticketprice,"
					+ "sum(returnnum) returnnum,sum(returnprice) returnprice,sum(charges) charges,"
					+ "sum(changenum) changenum, sum(ticketnum) - sum(returnnum)  balanceticketnum,"
					//+ "sum(netticketprice) - sum(netreturnprice) + sum(netcharegs) netbalanceprice,"
					//+ "sum(ticketprice)-sum(returnprice)+sum(charges) balanceprice from ")
					+ "sum(netticketprice) - sum(netreturnprice) - sum(cancelprice) netbalanceprice,"
					+ "sum(ticketprice)-sum(returnprice)+sum(charges) - sum(cancelprice) balanceprice, ")
					.append(" sum(cancelnum) cancelnum, sum(cancelprice) cancelprice ")
					.append(" from ")
					.append(" (select u.name ticketunit,count(ts.id) ticketnum,sum(ts.price) ticketprice,"
							+ "0 returnnum,0 returnprice,0 charges,0 changenum,sum(ts.price) netticketprice,"
							+ "0 netreturnprice,0 netcharegs, 0 cancelnum, 0 cancelprice from ticketsell ts,userinfo u where ts.sellby = u.id "
							+ "and ts.sellway = 10 ")
					.append(" and ts.selltime >= :beginselltime and ts.selltime <= :endselltime+0.99999 ")
					.append(" group by u.name ").append(" union all ")

					.append(" select u.name ticketunit,0 ticketnum,0 ticketprice,count(tr.id) returnnum,"
							+ "sum(tr.returnamount) returnprice,sum(tr.charges) charges,0 changenum,0 netticketprice,"
							+ "sum(tr.returnamount) netreturnprice,sum(tr.charges) netcharegs, 0 cancelnum, 0 cancelprice from ticketsell ts,"
							+ "ticketreturn tr,userinfo u where ts.sellby=tr.returnby and tr.returnby = u.id "
							+ "and ts.id=tr.sellid  and ts.sellway=10 ")
					.append(" and tr.returntime  >= :beginselltime and tr.returntime  <= :endselltime+0.99999 ")
					.append(" group by u.name ").append(" union all ")
					
					//废票
					.append("select u.name ticketunit, 0 ticketnum, 0 ticketprice, ")
					.append(" 0 returnnum, 0 returnprice, 0 charges, 0 changenum, ")
					.append(" 0 netticketprice, 0 netreturnprice, 0 netcharegs, ")
					.append(" count(tc.id) cancelnum, sum(tc.ticketprice) cancelprice ")
					.append("from ticketsell ts, ticketcancel tc, userinfo u ")
					.append("where ts.sellby = tc.cancelby and tc.cancelby = u.id ")
					.append(" and ts.id = tc.sellid  and ts.sellway=10")
					.append(" and tc.canceltime  >= :beginselltime and tc.canceltime  <= :endselltime+0.99999 ")
					.append(" group by u.name ").append(" union all ")

					.append(" select u.name ticketunit,0 ticketnum,0 ticketprice,0 returnnum,0 returnprice,"
							+ "0 charges,count(ts.id) changenum,0 netticketprice, 0 netreturnprice,0 netcharegs, 0 cancelnum, 0 cancelprice "
							+ " from ticketsell ts,ticketchange tc,userinfo u where  ts.sellby=tc.changeby "
							+ "and tc.changeby=u.id and ts.id=tc.newticketsellid and ts.sellway=10  ")
					.append(" and tc.changetime  >= :beginselltime and tc.changetime  <= :endselltime+0.99999 ")
					.append(" group by u.name )").append(" group by ticketunit ").append(" order by ticketunit ");

			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("beginselltime", beginselltime);
			query.setParameter("endselltime", endselltime);
			return query.getResultList();

		} else if (sellticketunit == 2) {// 联网按机构

			sql.append(" select ticketunit,sum(ticketnum) ticketnum,sum(ticketprice) ticketprice,"
					+ "sum(returnnum) returnnum,sum(returnprice) returnprice,sum(charges) charges,"
					+ "sum(changenum) changenum,sum(ticketnum) - sum(returnnum)  balanceticketnum,"
					//+ "sum(netticketprice) - sum(netreturnprice) + sum(netcharegs) netbalanceprice,"
					//+ "sum(ticketprice)-sum(returnprice)+sum(charges) balanceprice from ")
					+ "sum(netticketprice) - sum(netreturnprice) - sum(cancelprice) netbalanceprice, ")
					.append(" sum(ticketprice) - sum(returnprice) + sum(charges) balanceprice, ")
					.append(" sum(cancelnum) cancelnum, sum(cancelprice) cancelprice ")
					.append(" from")
					.append(" (select org.name ticketunit,count(ts.id) ticketnum,sum(ts.price) ticketprice,"
							+ "0 returnnum,0 returnprice,0 charges,0 changenum,sum(ts.price) netticketprice,"
							+ "0 netreturnprice,0 netcharegs, 0 cancelnum, 0 cancelprice from ticketsell ts,organization org where ")
					.append(" ts.orgid = org.id  and org.isonline=1 and ts.sellway<>'10'")
					.append(" and ts.selltime >= :beginselltime and ts.selltime <= :endselltime+0.99999 ")
					.append(" group by org.name ").append(" union all ")

					.append(" select org.name ticketunit,0 ticketnum,0 ticketprice,count(tr.id) returnnum,"
							+ "sum(tr.returnamount) returnprice,sum(tr.charges) charges,0 changenum,0 netticketprice,"
							+ "sum(tr.returnamount) netreturnprice,sum(tr.charges) netcharegs, 0 cancelnum, 0 cancelprice from ticketsell ts,"
							+ "ticketreturn tr,organization org where  ts.id=tr.sellid ")
					.append(" and ts.orgid = org.id  and org.isonline=1 and tr.returnby = 0 and ts.sellway<>'10'")
					.append(" and tr.returntime >= :beginselltime and tr.returntime <= :endselltime+0.99999 ")
					.append(" group by org.name ").append(" union all ")

					//废票
					.append("select org.name ticketunit, 0 ticketnum, 0 ticketprice, ")
					.append(" 0 returnnum, 0 returnprice, 0 charges, 0 changenum, ")
					.append(" 0 netticketprice, 0 netreturnprice, 0 netcharegs, ")
					.append(" count(tc.id) cancelnum, sum(tc.ticketprice) cancelprice ")
					.append("from ticketsell ts, ticketcancel tc, organization org ")
					.append("where ts.id = tc.sellid  ")
					.append(" and ts.orgid = org.id and org.isonline = 1 ")
					.append(" and tc.cancelby = 0 and ts.sellway <> '10' ")
					.append(" and tc.canceltime >= :beginselltime and tc.canceltime <= :endselltime + 0.99999 ")
					.append(" group by org.name ").append(" union all ")
					
					.append(" select org.name ticketunit,0 ticketnum,0 ticketprice,0 returnnum,0 returnprice,"
							+ "0 charges,count(ts.id) changenum,0 netticketprice, 0 netreturnprice,0 netcharegs, 0 cancelnum, 0 cancelprice "
							+ "from ticketsell ts,ticketchange tc,organization org where ts.id=tc.newticketsellid ")
					.append(" and ts.orgid = org.id  and org.isonline=1 and ts.sellway<>'10'")
					.append(" and tc.changetime >= :beginselltime and tc.changetime <= :endselltime+0.99999 ")
					.append(" group by org.name) ").append(" group by ticketunit ").append(" order by ticketunit ");

			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("beginselltime", beginselltime);
			query.setParameter("endselltime", endselltime);
			return query.getResultList();

		} else {
			// 售票点
			StringBuffer sql4 = new StringBuffer();
			List<Object> list = new ArrayList<Object>();

			sql4.append(" select ticketunit,sum(ticketnum) ticketnum,sum(ticketprice) ticketprice,"
					+ "sum(returnnum) returnnum,sum(returnprice) returnprice,sum(charges) charges,"
					+ "sum(changenum) changenum,sum(ticketnum) - sum(returnnum)  balanceticketnum,"
					//+ " sum(netticketprice) - sum(netreturnprice) + sum(netcharegs) netbalanceprice,"
					//+ "sum(ticketprice)-sum(returnprice)+sum(charges) balanceprice from ")
					+ " sum(netticketprice) - sum(netreturnprice) - sum(cancelprice) netbalanceprice,")
					.append(" sum(ticketprice)-sum(returnprice)+sum(charges) - sum(cancelprice) balanceprice, ")
					.append(" sum(cancelnum) cancelnum, sum(cancelprice) cancelprice ")
					.append(" from ")
					.append(" (select tos.name ticketunit,count(ts.id) ticketnum,sum(ts.price) ticketprice,"
							+ "0 returnnum,0 returnprice,0 charges,0 changenum,sum(ts.price) netticketprice,"
							+ "0 netreturnprice,0 netcharegs, 0 cancelnum, 0 cancelprice from ticketsell ts,ticketoutlets tos,schedule s,"
							+ "organization org where ts.ticketoutletsid = tos.id and ts.sellway not in ( '10') ")
					.append(" and ts.selltime >= :beginselltime and ts.selltime <= :endselltime+0.99999"
							+ " and (ts.orgid=s.orgid or (ts.orgid<>s.orgid and ts.sellway=7 )) ")
					.append("  and ts.scheduleid = s.id and tos.id>0  and ts.orgid=org.id and org.type<>'0' "
							+ " group by tos.name ")
					.append(" union all ")

					.append(" select tos.name ticketunit,0 ticketnum,0 ticketprice,count(tr.id) returnnum,"
							+ "sum(tr.ticketprice) returnprice,sum(tr.charges) charges,0 changenum,0 netticketprice,"
							+ "sum(tr.returnamount) netreturnprice,sum(tr.charges) netcharegs, 0 cancelnum, 0 cancelprice from ticketsell ts,"
							+ "ticketreturn tr,ticketoutlets tos,schedule s,organization org  where  ts.id=tr.sellid"
							+ " and tr.ticketoutletsid = tos.id  ")
					.append("  and ts.sellway not in ( '10') and tr.returntime  >= :beginselltime "
							+ "and tr.returntime <= :endselltime+0.99999 ")
					.append("  and tos.id>0 and tos.orgid=org.id and org.type<>'0'   and ts.scheduleid=s.id"
							+ " and (ts.orgid=s.orgid or (ts.orgid<>s.orgid and ts.sellway=7 )) group by tos.name ")
					.append(" union all ")
					
					//废票
					.append(" select tos.name ticketunit, 0 ticketnum, 0 ticketprice, ")
					.append("  0 returnnum, 0 returnprice, 0 charges, 0 changenum, ")
					.append("  0 netticketprice, 0 netreturnprice, 0 netcharegs, ")
					.append("  count(tc.id) cancelnum, sum(tc.ticketprice) cancelprice ")
					.append(" from ticketsell ts, ticketcancel tc, ticketoutlets tos, schedule s, organization org ")
					.append(" where ts.id = tc.sellid and tc.ticketoutletsid = tos.id and ts.sellway not in ( '10') ")
					.append("  and tos.id > 0 and tos.orgid = org.id and org.type <> '0' and ts.scheduleid = s.id ")
					.append("  and (ts.orgid = s.orgid or (ts.orgid <> s.orgid and ts.sellway = 7 )) ")
					.append("  and tc.canceltime  >= :beginselltime and tc.canceltime <= :endselltime + 0.99999 ")
					.append(" group by tos.name ")
					.append(" union all ")

					.append(" select tos.name ticketunit,0 ticketnum,0 ticketprice,0 returnnum,0 returnprice,"
							+ "sum(ts.servicefee) charges,count(tc.id) changenum,0 netticketprice,"
							+ " 0 netreturnprice,0 netcharegs, 0 cancelnum, 0 cancelprice from ticketsell ts,ticketchange tc,ticketoutlets tos,"
							+ "schedule s ,organization org where ts.id=tc.newticketsellid  "
							+ "and tc.ticketoutletsid = tos.id and ts.sellway not in ('10') ")
					.append(" and tc.changetime  >= :beginselltime and tc.changetime  <= :endselltime+0.99999"
							+ " and ts.scheduleid=s.id  and (ts.orgid=s.orgid or (ts.orgid<>s.orgid and ts.sellway=7 ))")
					.append("  and tos.id>0 and tos.orgid=org.id and org.type<>'0'  group by tos.name )")
					.append(" group by ticketunit ").append(" order by ticketunit ");

			Query query = getEntityManager().createNativeQuery(sql4.toString());
			query.setParameter("beginselltime", beginselltime);
			query.setParameter("endselltime", endselltime);

			list = query.getResultList();
			// 自助机
			StringBuffer sql2 = new StringBuffer();

			sql2.append(" select ticketunit,sum(ticketnum) ticketnum,sum(ticketprice) ticketprice,"
					+ "sum(returnnum) returnnum,sum(returnprice) returnprice,sum(charges) charges,"
					+ "sum(changenum) changenum, sum(ticketnum) - sum(returnnum)  balanceticketnum,"
					//+ " sum(netticketprice) - sum(netreturnprice) + sum(netcharegs) netbalanceprice,"
					//+ "sum(ticketprice)-sum(returnprice)+sum(charges) balanceprice from ")
					+ " sum(netticketprice) - sum(netreturnprice) - sum(cancelprice) netbalanceprice,")
					.append("sum(ticketprice)-sum(returnprice)+sum(charges) - sum(cancelprice) balanceprice, ")
					.append(" sum(cancelnum) cancelnum, sum(cancelprice) cancelprice ")
					.append(" from ")
					.append(" (select u.name ticketunit,count(ts.id) ticketnum,sum(ts.price) ticketprice,"
							+ "0 returnnum,0 returnprice,0 charges,0 changenum,sum(ts.price) netticketprice,"
							+ "0 netreturnprice,0 netcharegs, 0 cancelnum, 0 cancelprice from ticketsell ts,userinfo u where ts.sellby = u.id "
							+ "and ts.sellway = 10 ")
					.append(" and ts.selltime >= :beginselltime and ts.selltime <= :endselltime+0.99999 ")
					.append(" group by u.name ").append(" union all ")

					.append(" select u.name ticketunit,0 ticketnum,0 ticketprice,count(tr.id) returnnum,"
							+ "sum(tr.returnamount) returnprice,sum(tr.charges) charges,0 changenum,0 netticketprice,"
							+ "sum(tr.returnamount) netreturnprice,sum(tr.charges) netcharegs, 0 cancelnum, 0 cancelprice from ticketsell ts,"
							+ "ticketreturn tr,userinfo u where ts.sellby=tr.returnby and tr.returnby = u.id "
							+ "and ts.id=tr.sellid  and ts.sellway=10 ")
					.append(" and tr.returntime  >= :beginselltime and tr.returntime  <= :endselltime+0.99999 ")
					.append(" group by u.name ").append(" union all ")
					//废票
					.append("select u.name ticketunit, 0 ticketnum, 0 ticketprice, ")
					.append(" 0 returnnum, 0 returnprice, 0 charges, 0 changenum, ")
					.append(" 0 netticketprice, 0 netreturnprice, 0 netcharegs, ")
					.append(" count(tc.id) cancelnum, sum(tc.ticketprice) cancelprice ")
					.append("from ticketsell ts, ticketcancel tc, userinfo u ")
					.append("where ts.sellby = tc.cancelby and tc.cancelby = u.id ")
					.append(" and ts.id = tc.sellid  and ts.sellway=10")
					.append(" and tc.canceltime  >= :beginselltime and tc.canceltime  <= :endselltime+0.99999 ")
					.append(" group by u.name ").append(" union all ")

					.append(" select u.name ticketunit,0 ticketnum,0 ticketprice,0 returnnum,0 returnprice,"
							+ "0 charges,count(ts.id) changenum,0 netticketprice, 0 netreturnprice,0 netcharegs, 0 cancelnum, 0 cancelprice"
							+ " from ticketsell ts,ticketchange tc,userinfo u where ts.sellby=tc.changeby "
							+ "and tc.changeby=u.id and ts.id=tc.newticketsellid and ts.sellway=10  ")
					.append(" and tc.changetime  >= :beginselltime and tc.changetime  <= :endselltime+0.99999 ")
					.append(" group by u.name )").append(" group by ticketunit ").append(" order by ticketunit ");

			Query query2 = getEntityManager().createNativeQuery(sql2.toString());
			query2.setParameter("beginselltime", beginselltime);
			query2.setParameter("endselltime", endselltime);

			list.addAll(query2.getResultList());
			// 联网票
			StringBuffer sql3 = new StringBuffer();

			sql3.append(" select ticketunit,sum(ticketnum) ticketnum,sum(ticketprice) ticketprice,"
					+ "sum(returnnum) returnnum,sum(returnprice) returnprice,sum(charges) charges,"
					+ "sum(changenum) changenum,sum(ticketnum) - sum(returnnum)  balanceticketnum,"
					//+ " sum(netticketprice) - sum(netreturnprice) + sum(netcharegs) netbalanceprice,"
					//+ "sum(ticketprice)-sum(returnprice)+sum(charges) balanceprice from ")
					+ " sum(netticketprice) - sum(netreturnprice) - sum(cancelprice) netbalanceprice,")
					.append("sum(ticketprice)-sum(returnprice)+sum(charges) - sum(cancelprice) balanceprice, ")
					.append(" sum(cancelnum) cancelnum, sum(cancelprice) cancelprice ")
					.append("from")
					.append(" (select org.name ticketunit,count(ts.id) ticketnum,sum(ts.price) ticketprice,"
							+ "0 returnnum,0 returnprice,0 charges,0 changenum,sum(ts.price) netticketprice,"
							+ "0 netreturnprice,0 netcharegs, 0 cancelnum, 0 cancelprice from ticketsell ts,organization org where ")
					.append(" ts.orgid = org.id  and org.isonline=1 and ts.sellway<>'10' ")
					.append(" and ts.selltime >= :beginselltime and ts.selltime <= :endselltime+0.99999 ")
					.append(" group by org.name ").append(" union all ")

					.append(" select org.name ticketunit,0 ticketnum,0 ticketprice,count(tr.id) returnnum,"
							+ "sum(tr.returnamount) returnprice,sum(tr.charges) charges,0 changenum,0 netticketprice,"
							+ "sum(tr.returnamount) netreturnprice,sum(tr.charges) netcharegs, 0 cancelnum, 0 cancelprice from ticketsell ts,"
							+ "ticketreturn tr,organization org where  ts.id=tr.sellid ")
					.append(" and ts.orgid = org.id  and org.isonline=1 and tr.returnby = 0 and ts.sellway<>'10'")
					.append(" and tr.returntime >= :beginselltime and tr.returntime <= :endselltime+0.99999 ")
					.append(" group by org.name ").append(" union all ")

					//废票
					.append("select org.name ticketunit, 0 ticketnum, 0 ticketprice, ")
					.append(" 0 returnnum, 0 returnprice, 0 charges, 0 changenum, ")
					.append(" 0 netticketprice, 0 netreturnprice, 0 netcharegs, ")
					.append(" count(tc.id) cancelnum, sum(tc.ticketprice) cancelprice ")
					.append("from ticketsell ts, ticketcancel tc, organization org ")
					.append("where ts.id = tc.sellid  ")
					.append(" and ts.orgid = org.id and org.isonline = 1 ")
					.append(" and tc.cancelby = 0 and ts.sellway <> '10' ")
					.append(" and tc.canceltime >= :beginselltime and tc.canceltime <= :endselltime + 0.99999 ")
					.append(" group by org.name ").append(" union all ")
					
					.append(" select org.name ticketunit,0 ticketnum,0 ticketprice,0 returnnum,0 returnprice,"
							+ "0 charges,count(ts.id) changenum,0 netticketprice, 0 netreturnprice,0 netcharegs, 0 cancelnum, 0 cancelprice "
							+ "from ticketsell ts,ticketchange tc,organization org where ts.id=tc.newticketsellid ")
					.append(" and ts.orgid = org.id  and org.isonline=1 and ts.sellway<>'10'")
					.append(" and tc.changetime >= :beginselltime and tc.changetime <= :endselltime+0.99999 ")
					.append(" group by org.name) ").append(" group by ticketunit ").append(" order by ticketunit ");

			Query query3 = getEntityManager().createNativeQuery(sql3.toString());
			query3.setParameter("beginselltime", beginselltime);
			query3.setParameter("endselltime", endselltime);

			list.addAll(query3.getResultList());

			return list;
		}
	}
}
