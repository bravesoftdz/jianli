package cn.nova.bus.report.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

public class TicketTurnOverReportDao extends EntityManagerDaoSurport {
	public List queryTicketErrorReport(List<PropertyFilter> propertyFilter) {
		StringBuffer sql = new StringBuffer(" select tt.moneydate, u.code, u.name, sum(t.lost) lost")
				.append(" from ticketturnover t left join userinfo u  on t.seller = u.id left join ")
				.append(" (select distinct td.moneydate, td.ticketturnoverid from ticketturnoverdetail td where td.ticketturnoverid is not null) tt ")
				.append("  on t.id = tt.ticketturnoverid where u.id > 1 and u.code not like '%TVM%' ")
				.append(PropertyFilter.toJpql(propertyFilter, true))
				.append(" group by tt.moneydate, u.code, u.name order by tt.moneydate,u.code");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilter);
		return query.getResultList();
	}

	public List<Object> qryticketusedetail(String orgids, Date departdate, Date enddate, String tickettype,
			String ticketusetype) {
		StringBuffer sql = new StringBuffer();
		long a = new Date().getTime();
		if ("1".equals(ticketusetype) || "0".equals(ticketusetype)) { // 售出
			sql.append(
					" select  case when length(Min(ts.ticketno)) = 12 and substr(Min(ts.ticketno), 0, 4) <> '0000' then '12位车票票证'  ")
					.append(" when length(Min(ts.ticketno)) = 12 and  substr(Min(ts.ticketno), 0, 4) = '0000' then '8位车票票证'   ")
					.append(" when length(Min(ts.ticketno)) = 8 then '8位车票票证' else ''  end as tickettype ")
					.append(" , to_char(count(ts.id)) as usenum,min(ts.ticketno), max(ts.ticketno),trim('售出') as ticketusetype from  ")
					.append(" (select ts.ticketno,ts.id from ticketsell ts ")
					.append(" where  trunc(ts.selltime) between :departdate and :enddate and ts.orgid in "
							+ orgids );
			if ("1".equals(tickettype)) {
				sql.append(
						" and (length(ts.ticketno) = 8 or (length(ts.ticketno) = 12 and substr(ts.ticketno, 0, 4) = '0000')) ");
			} else if ("2".equals(tickettype)) {
				sql.append(" and (length(ts.ticketno) = 12 and substr(ts.ticketno, 0, 4) <> '0000') ");
			}else{
				sql.append(" and (length(ts.ticketno) = 12 or length(ts.ticketno) = 8) ");
			}
			sql.append(" order by ts.ticketno asc)ts group by ts.ticketno - rownum ");
		}
		if ("2".equals(ticketusetype) || "0".equals(ticketusetype)) { // 退票凭证
			if ("0".equals(ticketusetype)) {
				sql.append(" union all  ");
			}
			sql.append(
					" select  case when length(Min(ts.ticketno)) = 12 and substr(Min(ts.ticketno), 0, 4) <> '0000' then '12位车票票证'  ")
					.append(" when length(Min(ts.ticketno)) = 12 and  substr(Min(ts.ticketno), 0, 4) = '0000' then '8位车票票证'   ")
					.append(" when length(Min(ts.ticketno)) = 8 then '8位车票票证' else ''  end as tickettype ")
					.append(" , to_char(count(ts.id)) as usenum,min(ts.ticketno), max(ts.ticketno),trim('退票凭证') as ticketusetype from  ")
					.append(" (select nvl(tr.returnvoucherno,ts.ticketno) as ticketno,ts.id from ticketsell ts,ticketreturn tr ")
					.append(" where ts.ticketstatus = 1 and ts.id=tr.sellid  and trunc(ts.selltime) between :departdate and :enddate and ts.orgid in "
							+ orgids );
			if ("1".equals(tickettype)) {
				sql.append(
						" and (length(nvl(tr.returnvoucherno,ts.ticketno)) = 8 or (length(nvl(tr.returnvoucherno,ts.ticketno)) = 12 and substr(nvl(tr.returnvoucherno,ts.ticketno), 0, 4) = '0000')) ");
			} else if ("2".equals(tickettype)) {
				sql.append(" and (length(nvl(tr.returnvoucherno,ts.ticketno)) = 12 and substr(nvl(tr.returnvoucherno,ts.ticketno), 0, 4) <> '0000') ");
			}else{
				sql.append(" and (length(nvl(tr.returnvoucherno,ts.ticketno)) = 12 or length(nvl(tr.returnvoucherno,ts.ticketno)) = 8) ");
			}
			sql.append(" order by ticketno asc)ts group by ts.ticketno - rownum ");
		}
		if ("3".equals(ticketusetype) || "0".equals(ticketusetype)) { // 废票
			if("0".equals(ticketusetype)){
				sql.append(" union all  ");
			}
			sql.append(
					" select  case when length(Min(ts.ticketno)) = 12 and substr(Min(ts.ticketno), 0, 4) <> '0000' then '12位车票票证'  ")
					.append(" when length(Min(ts.ticketno)) = 12 and  substr(Min(ts.ticketno), 0, 4) = '0000' then '8位车票票证'   ")
					.append(" when length(Min(ts.ticketno)) = 8 then '8位车票票证' else ''  end as tickettype ")
					.append(" , to_char(count(ts.id)) as usenum,min(ts.ticketno), max(ts.ticketno),trim('废票') as ticketusetype from  ")
					.append(" (select ts.ticketno,ts.id from ticketsell ts ")
					.append(" where ts.ticketstatus = 2  and trunc(ts.selltime) between :departdate and :enddate and ts.orgid in "
							+ orgids );
			if ("1".equals(tickettype)) {
				sql.append(
						" and (length(ts.ticketno) = 8 or (length(ts.ticketno) = 12 and substr(ts.ticketno, 0, 4) = '0000')) ");
			} else if ("2".equals(tickettype)) {
				sql.append(" and (length(ts.ticketno) = 12 and substr(ts.ticketno, 0, 4) <> '0000') ");
			}else{
				sql.append(" and (length(ts.ticketno) = 12 or length(ts.ticketno) = 8) ");
			}
			sql.append(" order by ts.ticketno asc)ts group by ts.ticketno - rownum ");
		}
		if ("4".equals(ticketusetype) || "0".equals(ticketusetype)) { // 坏票
			if("0".equals(ticketusetype)){
				sql.append(" union all  ");
			}
			sql.append(" select  case when length(Min(ta.ticketstartno)) = 12 and substr(Min(ta.ticketstartno), 0, 4) <> '0000' then '12位车票票证'  ")
					.append(" when length(Min(ta.ticketstartno)) = 12 and  substr(Min(ta.ticketstartno), 0, 4) = '0000' then '8位车票票证'   ")
					.append(" when length(Min(ta.ticketstartno)) = 8 then '8位车票票证' else ''  end as tickettype ")
					.append(" , to_char(b.amount) as usenum,to_char(ta.ticketstartno) as ticketstartno,to_char(ta.ticketendno) as ticketendno,trim('坏票') as ticketusetype from billdamaged b ")
					.append(" ,ticketturnoverdetail ta where ta.id = b.turnoverdetailid and trunc(b.recordtime) between :departdate and :enddate ");
			if ("1".equals(tickettype)) {
				sql.append(" and (length(b.startno) = 8 or (length(b.startno) = 12 and substr(b.startno, 0, 4) = '0000')) ");
			} else if ("2".equals(tickettype)) {
				sql.append(" and (length(b.startno) = 12 and substr(b.startno, 0, 4) <> '0000') ");
			}else{
				sql.append(" and (length(b.startno) = 12 or length(b.startno) = 8) ");
			}
			sql.append(" group by b.amount ,ta.ticketstartno ,ta.ticketendno ");
		}
		if ("5".equals(ticketusetype) || "0".equals(ticketusetype)) { // 挂失
			if("0".equals(ticketusetype)){
				sql.append(" union all  ");
			}
			sql.append("  select  case when length(ts.ticketno) = 12 and substr(ts.ticketno, 0, 4) <> '0000' then '12位车票票证'  ")
				.append(" when length(ts.ticketno) = 12 and  substr(ts.ticketno, 0, 4) = '0000' then '8位车票票证'   ")
				.append(" when length(ts.ticketno) = 8 then '8位车票票证' else ''  end as tickettype ")
					.append(" , to_char(1) as usenum,ts.ticketno as ticketstartno,ts.ticketno as ticketendno,trim('挂失') as ticketusetype from ticketloss b,ticketsell ts ")
					.append(" where ts.id = b.ticketsellid and trunc(b.losstime)between :departdate and :enddate and ts.orgid in "
							+ orgids);
			if ("1".equals(tickettype)) {
				sql.append(" and (length(ts.ticketno) = 8 or (length(ts.ticketno) = 12 and substr(ts.ticketno, 0, 4) = '0000')) ");
			} else if ("2".equals(tickettype)) {
				sql.append(" and (length(ts.ticketno) = 12 and substr(ts.ticketno, 0, 4) <> '0000') ");
			}else{
				sql.append(" and (length(ts.ticketno) = 12 or length(ts.ticketno) = 8) ");
			}
		}
		Query query = getEntityManager().createNativeQuery(sql.toString());
		long b = new Date().getTime();
		query.setParameter("departdate", departdate);
		query.setParameter("enddate", enddate);
		List<Object> list = query.getResultList();
		System.out.println(a);
		System.out.println(b);
		System.out.println(b-a);
		return list;
	}
}
