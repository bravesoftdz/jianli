package cn.nova.bus.query.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;

@SuppressWarnings("rawtypes")
public class NetworkTicketSummaryQryDao extends EntityManagerDaoSurport {
	/**
	 * 查询有哪些售票机构
	 * 
	 * @param propertyFilterList
	 * @return
	 */
//	@SuppressWarnings("unchecked")
//	public List<Object> queryOrgs(Date startdate, Date enddate,
//			Date compStartdate, Date compEnddate, String orgids) {
//		StringBuffer sql = new StringBuffer();
//		if (compStartdate == null) {
//			sql.append(" select org.name sellorg, dorg.name schorg,sum(t.sellnum) sellnum,")
//			.append(" sum(t.totalprice) totalprice")
//			.append(" from ticketsellbysalerday t, organization org, organization dorg")
//			.append(" where t.orgid = org.id  and t.scheduleorgid = dorg.id")
//			.append(" and t.selldate between :startdate and :enddate")
//			.append(" and t.scheduleorgid in " + orgids)
//			.append(" group by org.name, dorg.name order by org.name");
//			Query query = getEntityManager().createNativeQuery(sql.toString());
//			query.setParameter("startdate", startdate);
//			query.setParameter("enddate", enddate);
//			List<Object> list = query.getResultList();
//			return list;
//		} else {
//			sql.append(" select selorg,schorg,sum(sellnum) sellnum,")
//			.append(" sum(totalprice) totalprice,sum(comsellnum) comsellnum,")
//			.append(" sum(comtotalprice) comtotalprice,decode(sum(comsellnum),")
//			.append("  0,'100%',to_char((sum(sellnum) - sum(comsellnum)) * 100 /")
//			.append(" sum(comsellnum),'999999990.99')||'%') sellnumrate,")
//			.append(" decode(sum(comtotalprice),0,'100%',to_char((sum(totalprice) - sum(comtotalprice)) * 100 /")
//			.append(" sum(comtotalprice),'999999990.99')||'%') totalpricerate")
//			.append(" from (select org.name selorg,dorg.name schorg,")
//			.append(" sum(t.sellnum) sellnum,sum(t.totalprice) totalprice,")
//			.append(" 0 comsellnum,0 comtotalprice")
//			.append(" from ticketsellbysalerday t, organization org, organization dorg")
//			.append(" where t.orgid = org.id and t.scheduleorgid = dorg.id")
//			.append("  and t.selldate between :startdate and :enddate")
//			.append("  and t.scheduleorgid in "+orgids)
//			.append("  group by org.name, dorg.name")
//			.append(" union all")
//			.append(" select org.name selorg,dorg.name schorg,0 sellnum,")
//			.append(" 0 totalprice,sum(t.sellnum) comsellnum,")
//			.append(" sum(t.totalprice) comtotalprice")
//			.append(" from ticketsellbysalerday t, organization org, organization dorg")
//			.append("  where t.orgid = org.id and t.scheduleorgid = dorg.id")
//			.append(" and t.selldate between  :compStartdate and :compEnddate")
//			.append(" and t.scheduleorgid in "+orgids)
//			.append(" group by org.name, dorg.name) group by selorg, schorg")
//			.append(" order by selorg");
//			Query query = getEntityManager().createNativeQuery(sql.toString());
//			query.setParameter("startdate", startdate);
//			query.setParameter("enddate", enddate);
//			query.setParameter("compStartdate", compStartdate);
//			query.setParameter("compEnddate", compEnddate);
//			List<Object> list = query.getResultList();
//			return list;
//		}
//	}
	@SuppressWarnings("unchecked")
	public List<Object> queryOrgs(Date startdate, Date enddate,
			Date compStartdate, Date compEnddate, String orgids, Long routeid, String ticketoutletsids) {
		StringBuffer sql = new StringBuffer();
		if (compStartdate == null) {
			sql.append(" select selorg,schorg,sum(sellnum) sellnum,")
			.append(" sum(totalprice) totalprice from ( ")
			.append(" select org.name selorg,dorg.name schorg, ")
			.append(" count(distinct(case when (t.tickettype = 'T') then (t.orderno) else to_char(t.id) end)) sellnum, ")
			.append(" sum(t.price) totalprice ")
			.append(" from ticketsell t, schedule s,organization org, organization dorg ")
			.append(" where t.scheduleid=s.id and t.orgid=org.id and s.orgid=dorg.id ")
			.append(" and t.selltime between :startdate and :enddate + 0.99999 ")
			.append(" and s.orgid in " + orgids );
			if (routeid > 0) {
				sql.append(" and s.routeid =:routeid ");
			}
			if (""!=ticketoutletsids) {
				sql.append(" and t.ticketoutletsid in " + ticketoutletsids );
			}
			sql.append(" group by org.name, dorg.name ")
			.append(" union all ")
			.append(" select org.name selorg, dorg.name schorg, ")
			.append(" count(distinct(case when (t.tickettype = 'T') then (t.orderno) else to_char(t.id) end)) sellnum, ")
			.append(" sum(t.price) totalprice ")
			.append(" from ticketsellagent t, schedule s,organization org, organization dorg ")
			.append(" where t.schedulecode=s.code and t.orgid=org.id and s.orgid=dorg.id ")
			.append(" and t.selltime between :startdate and :enddate + 0.99999 ")
			.append(" and s.orgid in " + orgids );
			if (routeid > 0) {
				sql.append(" and s.routeid =:routeid ");
			}
			if (""!=ticketoutletsids) {
				sql.append(" and t.ticketoutletsid in " + ticketoutletsids );
			}
			sql.append(" group by org.name, dorg.name) ")
			.append(" group by selorg, schorg ")
			.append(" order by selorg ");
			Query query = getEntityManager().createNativeQuery(sql.toString());
			if (routeid > 0) {
			    query.setParameter("routeid", routeid);
			}
			query.setParameter("startdate", startdate);
			query.setParameter("enddate", enddate);
			List<Object> list = query.getResultList();
			return list;
		} else {
			sql.append(" select selorg,schorg,sum(sellnum) sellnum,")
					.append(" sum(totalprice) totalprice,sum(comsellnum) comsellnum,")
					.append(" sum(comtotalprice) comtotalprice,decode(sum(comsellnum),")
					.append("  0,'100%',to_char((sum(sellnum) - sum(comsellnum)) * 100 /")
					.append(" sum(comsellnum),'999999990.99')||'%') sellnumrate,")
					.append(" decode(sum(comtotalprice),0,'100%',to_char((sum(totalprice) - sum(comtotalprice)) * 100 /")
					.append(" sum(comtotalprice),'999999990.99')||'%') totalpricerate")
					.append(" from ( ")
					.append(" select org.name selorg,dorg.name schorg, ")
					.append(" count(distinct(case when (t.tickettype = 'T') then (t.orderno) else to_char(t.id) end)) sellnum, ")
					.append(" sum(t.price) totalprice,0 comsellnum,0 comtotalprice ")
					.append(" from ticketsell t, schedule s,organization org, organization dorg ")
					.append(" where t.scheduleid=s.id and t.orgid=org.id and s.orgid=dorg.id ")
					.append(" and t.selltime between :startdate and :enddate + 0.99999 ")
					.append(" and s.orgid in " + orgids );
					if (routeid > 0) {
						sql.append(" and s.routeid =:routeid ");
					}
					if (""!=ticketoutletsids) {
						sql.append(" and t.ticketoutletsid in " + ticketoutletsids );
					}
					sql.append(" group by org.name, dorg.name ")
					.append(" union all ")
					.append(" select org.name selorg, dorg.name schorg, ")
					.append(" count(distinct(case when (t.tickettype = 'T') then (t.orderno) else to_char(t.id) end)) sellnum, ")
					.append(" sum(t.price) totalprice,0 comsellnum,0 comtotalprice ")
					.append(" from ticketsellagent t, schedule s,organization org, organization dorg ")
					.append(" where t.schedulecode=s.code and t.orgid=org.id and s.orgid=dorg.id ")
					.append(" and t.selltime between :startdate and :enddate + 0.99999 ")
					.append(" and s.orgid in " + orgids );
					if (routeid > 0) {
						sql.append(" and s.routeid =:routeid ");
					}
					if (""!=ticketoutletsids) {
						sql.append(" and t.ticketoutletsid in " + ticketoutletsids );
					}
					sql.append(" group by org.name, dorg.name ")
					.append(" union all ")
					.append(" select org.name selorg, dorg.name schorg,0 sellnum,0 totalprice, ")
					.append(" count(distinct(case when (t.tickettype = 'T') then (t.orderno) else to_char(t.id) end)) comsellnum, ")
					.append(" sum(t.price) comtotalprice ")
					.append(" from ticketsell t, schedule s,organization org, organization dorg ")
					.append(" where t.scheduleid=s.id and t.orgid=org.id and s.orgid=dorg.id ")
					.append(" and t.selltime between :compStartdate and :compEnddate + 0.99999 ")
					.append(" and s.orgid in " + orgids );
					if (routeid > 0) {
						sql.append(" and s.routeid =:routeid ");
					}
					if (""!=ticketoutletsids) {
						sql.append(" and t.ticketoutletsid in " + ticketoutletsids );
					}
					sql.append(" group by org.name, dorg.name ")
					.append(" union all ")
					.append(" select org.name selorg, dorg.name schorg,0 sellnum,0 totalprice, ")
					.append(" count(distinct(case when (t.tickettype = 'T') then (t.orderno) else to_char(t.id) end)) comsellnum, ")
					.append(" sum(t.price) comtotalprice ")
					.append(" from ticketsellagent t, schedule s,organization org, organization dorg ")
					.append(" where t.schedulecode=s.code and t.orgid=org.id and s.orgid=dorg.id ")
					.append(" and t.selltime between :compStartdate and :compEnddate + 0.99999 ")
					.append(" and s.orgid in " + orgids );
					if (routeid > 0) {
						sql.append(" and s.routeid =:routeid ");
					}
					if (""!=ticketoutletsids) {
						sql.append(" and t.ticketoutletsid in " + ticketoutletsids );
					}
					sql.append(" group by org.name, dorg.name) ")
					.append(" group by selorg, schorg ")
					.append(" order by selorg ");
			Query query = getEntityManager().createNativeQuery(sql.toString());
			if (routeid > 0) {
			    query.setParameter("routeid", routeid);
			}
			query.setParameter("startdate", startdate);
			query.setParameter("enddate", enddate);
			query.setParameter("compStartdate", compStartdate);
			query.setParameter("compEnddate", compEnddate);
			List<Object> list = query.getResultList();
			return list;
		}
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryOrgData(Date startdate, Date enddate,
			Date compStartdate, Date compEnddate, String orgids) {
		// --查询售票机构
		StringBuffer sql = new StringBuffer();

		// sql.append(" select  ");
		// sql.append(" nvl(a.orgname,b.orgname) orgname, ");
		// sql.append(" nvl(a.scorgname,b.scorgname) scorgname, ");
		// sql.append(" nvl(a.sellnum, 0) sellnum, ");
		// sql.append(" nvl(b.sellnum1, 0) sellnum1,   ");
		// sql.append(" (nvl(a.sellnum, 0) - nvl(b.sellnum1, 0)) sellnumComp,  ");
		// sql.append(" trim(to_char(case when a.sellnum - nvl(b.sellnum1, 0) = 0 then  0  ");
		// sql.append(" when nvl(a.sellnum, 0) - b.sellnum1 = 0 then  0  ");
		// sql.append(" else  nvl((nvl(a.sellnum, 0) - nvl(b.sellnum1, 0)) / nullif(b.sellnum1, 0) * 100, 100) end, '999999990.99')) || '%' sellnumPercent   ");
		// sql.append("  ");
		// sql.append(" ,nvl(a.nomaltotalnum, 0) nomaltotalnum, ");
		// sql.append(" nvl(b.nomaltotalnum1, 0) nomaltotalnum1,   ");
		// sql.append(" (nvl(a.nomaltotalnum, 0) - nvl(b.nomaltotalnum1, 0)) nomaltotalnumComp,  ");
		// sql.append(" trim(to_char(case when a.nomaltotalnum - nvl(b.nomaltotalnum1, 0) = 0 then  0  ");
		// sql.append(" when nvl(a.nomaltotalnum, 0) - b.nomaltotalnum1 = 0 then  0  ");
		// sql.append(" else  nvl((nvl(a.nomaltotalnum, 0) - nvl(b.nomaltotalnum1, 0)) / nullif(b.nomaltotalnum1, 0) * 100, 100) end, '999999990.99')) || '%' nomaltotalnumPercent   ");
		// sql.append("  ");
		// sql.append(" from ( ");
		// sql.append("       select  td.orgid,org.name as orgname,scorg.id scorgid,scorg.name as scorgname, ");
		// sql.append("       sum(td.sellnum) sellnum,sum(td.totalprice) totalprice, ");
		// sql.append("       sum(td.sellnum-td.returnnum-td.cancelnum) nomaltotalnum, ");
		// sql.append("       sum(td.totalprice-td.returnprice-td.cancelmoeny) nomaltotalprice, ");
		// sql.append("       sum(td.totalprice - td.returnprice + td.returnfee - td.cancelmoeny+td.servicefee) upmoney ");
		// sql.append("       from ticketsellbysalerday td,Organization org ,Organization scorg ");
		// sql.append("       where td.orgid = org.id and scorg.id=td.scheduleorgid ");
		// sql.append("       and td.selldate between :startdate and :enddate  ");
		// sql.append("       and td.orgid in "+orgids+"  ");
		// sql.append("       group by  td.orgid,org.name,scorg.id,scorg.name order by td.orgid desc ");
		// sql.append(" ) a ");
		// sql.append("  ");
		// sql.append(" full join( ");
		// sql.append("      select  td.orgid,org.name as orgname,scorg.id scorgid,scorg.name as scorgname, ");
		// sql.append("      sum(td.sellnum) sellnum1,sum(td.totalprice) totalprice1,  ");
		// sql.append("      sum(td.sellnum-td.returnnum-td.cancelnum) nomaltotalnum1, ");
		// sql.append("      sum(td.totalprice-td.returnprice-td.cancelmoeny) nomaltotalprice1, ");
		// sql.append("      sum(td.totalprice - td.returnprice + td.returnfee - td.cancelmoeny+td.servicefee) upmoney1 ");
		// sql.append("      from ticketsellbysalerday td,Organization org ,Organization scorg ");
		// sql.append("      where td.orgid = org.id and scorg.id=td.scheduleorgid ");
		// sql.append("      and td.selldate between :compStartdate and :compEnddate ");
		// sql.append("       and td.orgid in "+orgids+"  ");
		// sql.append("      group by  td.orgid,org.name,scorg.id,scorg.name order by td.orgid desc ");
		// sql.append(" ) b on a.orgid=b.orgid and a.scorgid=b.scorgid ");

		sql.append(" select  ");
		sql.append(" nvl(a.orgname,b.orgname) orgname, ");
		sql.append(" nvl(a.scorgname,b.scorgname) scorgname, ");
		sql.append(" nvl(a.sellnum, 0) sellnum, ");
		sql.append(" nvl(b.sellnum1, 0) sellnum1,   ");
		sql.append(" (nvl(a.sellnum, 0) - nvl(b.sellnum1, 0)) sellnumComp,  ");
		sql.append(" trim(to_char(case when a.sellnum - nvl(b.sellnum1, 0) = 0 then  0  ");
		sql.append(" when nvl(a.sellnum, 0) - b.sellnum1 = 0 then  0  ");
		sql.append(" else  nvl((nvl(a.sellnum, 0) - nvl(b.sellnum1, 0)) / nullif(b.sellnum1, 0) * 100, 100) end, '999999990.99')) || '%' sellnumPercent   ");
		sql.append("  ");
		sql.append(" ,nvl(a.nomaltotalnum, 0) nomaltotalnum, ");
		sql.append(" nvl(b.nomaltotalnum1, 0) nomaltotalnum1,   ");
		sql.append(" (nvl(a.nomaltotalnum, 0) - nvl(b.nomaltotalnum1, 0)) nomaltotalnumComp,  ");
		sql.append(" trim(to_char(case when a.nomaltotalnum - nvl(b.nomaltotalnum1, 0) = 0 then  0  ");
		sql.append(" when nvl(a.nomaltotalnum, 0) - b.nomaltotalnum1 = 0 then  0  ");
		sql.append(" else  nvl((nvl(a.nomaltotalnum, 0) - nvl(b.nomaltotalnum1, 0)) / nullif(b.nomaltotalnum1, 0) * 100, 100) end, '999999990.99')) || '%' nomaltotalnumPercent   ");
		sql.append("  ");
		sql.append(" from ( ");
		sql.append("       select  t.orgid,org.name as orgname,scorg.id scorgid,scorg.name as scorgname, ");
		sql.append("       count(t.id) sellnum,sum(t.price) nomaltotalnum ");
//		sql.append("       from ticketsell t,Station s, Organization org ,Organization scorg ");
//		sql.append("       where t.orgid = org.id and s.id=t.reachstationid and scorg.id=s.orgid ");
		sql.append("       from ticketsell t,schedule s, Organization org ,Organization scorg ");
		sql.append("       where t.orgid = org.id and s.id=t.scheduleid and scorg.id=s.orgid ");
		sql.append("       and t.ticketstatus='0' ");
		sql.append("       and t.selltime between :startdate and :enddate  ");
//		sql.append("       and t.orgid in " + orgids + "  ");
		sql.append("       and scorg.id in " + orgids + "  ");
		sql.append("       group by  t.orgid,org.name,scorg.id,scorg.name");
		sql.append("       union ");
		sql.append("       select  org.id orgid,org.name as orgname,scorg.id scorgid,scorg.name as scorgname, ");
		sql.append("       count(t.id) sellnum,sum(t.price) nomaltotalnum ");
		sql.append("       from Ticketsellagent t,Userinfo u, Organization org ,Organization scorg ");
		sql.append("       where u.id=t.sellby and u.orgid=org.id and scorg.id=t.orgid ");
		sql.append("       and t.ticketstatus='0' ");
		sql.append("       and t.selltime between :startdate and :enddate  ");
//		sql.append("       and t.orgid in " + orgids + "  ");
//		sql.append("       and scorg.id in " + orgids + "  ");
		sql.append("       group by  org.id,org.name,scorg.id,scorg.name");
		sql.append(" ) a ");
		sql.append("  ");
		sql.append(" full join( ");
		sql.append("       select  t.orgid,org.name as orgname,scorg.id scorgid,scorg.name as scorgname, ");
		sql.append("       count(t.id) sellnum1,sum(t.price) nomaltotalnum1 ");
//		sql.append("       from ticketsell t,Station s, Organization org ,Organization scorg ");
//		sql.append("       where t.orgid = org.id and s.id=t.reachstationid and scorg.id=s.orgid ");
		sql.append("       from ticketsell t,schedule s, Organization org ,Organization scorg ");
		sql.append("       where t.orgid = org.id and s.id=t.scheduleid and scorg.id=s.orgid ");
		sql.append("       and t.ticketstatus='0' ");
		sql.append("      and t.selltime between :compStartdate and :compEnddate ");
//		sql.append("       and t.orgid in " + orgids + "  ");
		sql.append("       and scorg.id in " + orgids + "  ");
		sql.append("       group by  t.orgid,org.name,scorg.id,scorg.name");
		sql.append("       union ");
		sql.append("       select  org.id orgid,org.name as orgname,scorg.id scorgid,scorg.name as scorgname, ");
		sql.append("       count(t.id) sellnum1,sum(t.price) nomaltotalnum1 ");
		sql.append("       from Ticketsellagent t,Userinfo u, Organization org ,Organization scorg ");
		sql.append("       where u.id=t.sellby and u.orgid=org.id and scorg.id=t.orgid ");
		sql.append("       and t.ticketstatus='0' ");
		sql.append("       and t.selltime between :compStartdate and :compEnddate  ");
//		sql.append("       and t.orgid in " + orgids + "  ");
//		sql.append("       and scorg.id in " + orgids + "  ");
		sql.append("       group by  org.id,org.name,scorg.id,scorg.name");
		sql.append(" ) b on a.orgid=b.orgid and a.scorgid=b.scorgid ");

		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		query.setParameter("compStartdate", compStartdate);
		query.setParameter("compEnddate", compEnddate);
		List<Object> list = query.getResultList();

		return list;
	}
	

}
