package cn.nova.bus.report.dao;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;


@SuppressWarnings("rawtypes")
public class BillinuseBalanceReportDao extends EntityManagerDaoSurport {
	public List<Object> reportBillinuseBalance(String orgids, Date startdate,
			Date enddate, Long salerid, boolean check) {
		StringBuilder sql = new StringBuilder();
	 sql.append("select u.name as salername,")
	 	.append("trim(case when bi.createtime between :startdate and :enddate then '本期领用' else '上期结余' end) as billsource")
		.append(",coalesce((                                                               ")
		.append("     select min(ttd.ticketstartno) From ticketturnoverdetail ttd          ")
		.append("     where ttd.moneydate between :startdate and :enddate                  ")
		.append("     and ttd.ticketendno between bi.startno and bi.endno                  ")
		.append("     and ttd.seller=bi.recipients                                         ")
		.append("   ),(select to_char(max(ttd.ticketendno)+1) From ticketturnoverdetail ttd")   
        .append(" where ttd.moneydate < :startdate and ttd.ticketendno between bi.startno  ")                     
        .append(" and bi.endno and ttd.seller=bi.recipients ),to_char(bi.startno)) as laststartno ")
		.append(" ,bi.endno as lastendno                                                   ")
		.append(" ,bi.endno-coalesce((                                                     ")
		.append("     select min(ttd.ticketstartno) From ticketturnoverdetail ttd          ")
		.append("     where ttd.moneydate between :startdate and :enddate                  ")
		.append("     and ttd.ticketendno between bi.startno and bi.endno                  ")
		.append("     and ttd.seller=bi.recipients                                         ")
		.append("   ),(select to_char(max(ttd.ticketendno)+1) From ticketturnoverdetail ttd 		   ")            
		.append(" where ttd.moneydate<:startdate and ttd.ticketendno between bi.startno	   ")
		.append(" and bi.endno and ttd.seller=bi.recipients),to_char(bi.startno))+1 as lastticketnum          ")
		.append("   ,coalesce((                                                            ")
		.append("     select sum(ttd.sellnum-ttd.cancelnum) From ticketturnoverdetail ttd  ")
		.append("     where ttd.moneydate between :startdate and :enddate                  ")
		.append("     and ttd.ticketendno between bi.startno and bi.endno                  ")
		.append("     and ttd.seller=bi.recipients                                         ")
		.append("   ),0) as sellnum                                                        ")
		.append("   ,coalesce((                                                            ")
		.append("     select sum(ttd.cancelnum) From ticketturnoverdetail ttd              ")
		.append("     where ttd.moneydate between :startdate and :enddate                  ")
		.append("     and ttd.ticketendno between bi.startno and bi.endno                  ")
		.append("     and ttd.seller=bi.recipients                                         ")
		.append("   ),0) as cancelnum                                                      ")
		.append("   ,coalesce((                                                            ")
		.append("     select sum(ttd.eticketnum) From ticketturnoverdetail ttd             ")
		.append("     where ttd.moneydate between :startdate and :enddate                  ")
		.append("     and ttd.ticketendno between bi.startno and bi.endno                  ")
		.append("     and ttd.seller=bi.recipients                                         ")
		.append("   ),0) as eticketnum                                                     ")
		.append(",(select count(*) from ticketreturn tr                                    ")
		.append("  where tr.returnby=bi.recipients                                         ")
		.append("    and tr.returnvoucherno is not null                                    ")
		.append("    and to_number(tr.returnvoucherno) between bi.startno and bi.endno     ")
		.append("    and tr.returntime between :startdate and :enddate) as returnnum       ")
		.append(",coalesce((select sum(amount) from billdamaged bd                         ")
		.append("  where bd.billinuseid=bi.id                                              ")
		.append("    and bd.startno between bi.startno and bi.endno                        ")
		.append("    and bd.endno between bi.startno and bi.endno                          ")
		.append("    and bd.recordtime between :startdate and :enddate),0) as damagednum   ")
		.append(",coalesce((                                                               ")
		.append("     select to_char(max(ttd.ticketendno)+1) From ticketturnoverdetail ttd ")
		.append("     where ttd.moneydate between :startdate and :enddate                  ")
		.append("     and ttd.ticketendno between bi.startno and bi.endno                  ")
		.append("     and ttd.seller=bi.recipients                                         ")
		.append("   ),to_char(bi.startno)) as balancestartno                               ")
		.append(" ,bi.endno as balanceendno                                                ")
		.append(" ,bi.endno-coalesce((                                                     ")
		.append("     select to_char(max(ttd.ticketendno)+1) From ticketturnoverdetail ttd ")
		.append("     where ttd.moneydate between :startdate and :enddate                  ")
		.append("     and ttd.ticketendno between bi.startno and bi.endno                  ")
		.append("     and ttd.seller=bi.recipients                                         ")
		.append("   ),(select to_char(max(ttd.ticketendno)+1) From ticketturnoverdetail ttd 		   ")            
		.append(" where ttd.moneydate<:startdate and ttd.ticketendno between bi.startno	   ")
		.append(" and bi.endno and ttd.seller=bi.recipients),to_char(bi.startno))+1 as balanceticketnum                           ")
		.append(" from Billinuse bi,Userinfo u,Billtype bt                                 ")
		.append(" where bi.createtime < :enddate                                           ")
		.append(" and bi.recipients=u.id")
		.append(" and bi.billtypeid=bt.id")
		.append(" and bt.code='Ticket'")
		.append(" and bi.orgid in ").append(orgids);
	 
		if (check) {//用于只查消耗票证的信息
			sql.append(" and (exists (                                                             ")
					.append("         select 'A' From ticketturnoverdetail ttd                         ")
					.append("         where ttd.moneydate between :startdate and :enddate              ")
					.append("         and ttd.ticketendno between bi.startno and bi.endno              ")
					.append("         and ttd.seller=bi.recipients                                     ")
					.append("       )                                                                  ")
					.append(") ");
		}
		if(salerid!=null&&salerid!=0){
	 		sql.append(" and bi.recipients=").append(salerid);
	 	}
	 	sql.append(" order by u.name,bi.startno");
	 	Query query = super.getEntityManager().createNativeQuery(sql.toString());
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(startdate);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		startdate = calendar.getTime();
	 	query.setParameter("startdate", startdate);
		calendar.setTime(enddate);
		calendar.set(Calendar.HOUR_OF_DAY, 23);
		calendar.set(Calendar.MINUTE, 59);
		calendar.set(Calendar.SECOND, 59);
		calendar.set(Calendar.MILLISECOND, 999);
		enddate = calendar.getTime();
	 	query.setParameter("enddate", enddate);
		return query.getResultList();
	}                                                                                                                                 
}                                                                                                                                     
