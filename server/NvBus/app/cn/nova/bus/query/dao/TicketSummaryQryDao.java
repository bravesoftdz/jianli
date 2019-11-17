package cn.nova.bus.query.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;

/**
 * 
 * <b>类描述：业务报表下的DAO</b><br/>
 * <b>类名称：</b>TicketSummaryQryDao<br/>
 * <b>创建人：</b><a href="mailto:qinzhikai@nova.net.cn">覃智开</a><br/>
 * <b>主要模块：站务分公司网点售票情况汇总表:queryTicketSummary
 * <b>1修改内容：修改sql语句，改查询结转表</b><br/> 
 * <b>修改时间： 2014-03-24</b><br/>
 * <b>修改人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * 
 */
@SuppressWarnings("rawtypes")
public class TicketSummaryQryDao extends EntityManagerDaoSurport {

	/**
	 * 站务分公司网点售票情况汇总表
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryTicketSummary(
			List<PropertyFilter> propertyFilterList) {

		String orgids = null;

		Date startdate = null;
		Date enddate = null;
		Date compStartdate = null;
		Date compEnddate = null;

		boolean isbyseller = false;// 是否按售票员分组
		Long sellby = null;

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
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("u!id")) {
					sellby = (Long) propertyFilterList.get(t).getMatchValue();
					continue;
				}
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("u!issellby")) {
					// 是否根据售票员分组
					isbyseller = true;
					continue;
				}
			}
		}
		//
		StringBuffer sb = new StringBuffer();
//		sb.append(" select ");
//		sb.append("   nvl(a.orgname,b.orgname) orgname, ");
//		if (isbyseller == true) {
//			sb.append("   nvl(a.sellbyname,b.sellbyname) sellbyname,");
//
//		} else {
//			sb.append("   '' sellbyname,  ");
//		}
//		sb.append("   (to_char(:startdate,'yyyy-MM-dd') || '至' || to_char(:enddate-1,'yyyy-MM-dd') ||  ' 同比 ' || to_char(:compStartdate,'yyyy-MM-dd') || '至' || to_char(:compEnddate-1,'yyyy-MM-dd')) departdate,  ");
//		sb.append("   nvl(a.sellnum,0) sellnum,nvl(a.sellmoney,0) sellmoney, ");
//		sb.append("   nvl(a.returnnum,0) returnnum,nvl(a.returnmoney,0) returnmoney, ");
//		sb.append("   nvl(a.cancelnum,0) cancelnum,nvl(a.cancelmoney,0) cancelmoney, ");
//		sb.append("   nvl(b.sellnum1,0) sellnum1,nvl(b.sellmoney1,0) sellmoney1, ");
//		sb.append("   nvl(b.returnnum1,0) returnnum1,nvl(b.returnmoney1,0) returnmoney1, ");
//		sb.append("   nvl(b.cancelnum1,0) cancelnum1,nvl(b.cancelmoney1,0) cancelmoney1, ");
//		sb.append("   nvl(a.returntcknum,0) returntcknum,nvl(a.returntcamount,0) returntcamount, ");
//		sb.append("   nvl(b.returntcknum1,0) returntcknum1,nvl(b.returntcamount1,0) returntcamount1, ");
//		sb.append("   (nvl(a.sellnum, 0) - nvl(b.sellnum1, 0)) sellnumComp, ");
//		sb.append("   trim(to_char(case when a.sellnum - nvl(b.sellnum1, 0) = 0 then 0 when nvl(a.sellnum, 0) - b.sellnum1 = 0  ");
//		sb.append("   then 0 else nvl((nvl(a.sellnum, 0) - nvl(b.sellnum1, 0)) / nullif(b.sellnum1, 0) * 100, 100)  ");
//		sb.append("   end, '9999999990.99')) || '%' sellnumPercent, ");
//		sb.append("   (nvl(a.sellmoney, 0) - nvl(b.sellmoney1, 0)) sellmoneyComp, ");
//		sb.append("   trim(to_char(case when nvl(a.sellmoney,0) - nvl(b.sellmoney1, 0) = 0 then 0 when nvl(a.sellmoney, 0) - b.sellmoney1 = 0  ");
//		sb.append("   then 0 else nvl((nvl(a.sellmoney, 0) - nvl(b.sellmoney1, 0)) / nullif(b.sellmoney1, 0) * 100, 100)  ");
//		sb.append("   end, '9999999990.99')) || '%' sellmoneyPercent, ");
//		sb.append("    ");
//		sb.append("   (nvl(a.returnnum, 0) - nvl(b.returnnum1, 0)) returnnumComp, ");
//		sb.append("   trim(to_char(case when nvl(a.returnnum,0) - nvl(b.returnnum1, 0) = 0 then 0 when nvl(a.returnnum, 0) - b.returnnum1 = 0  ");
//		sb.append("   then 0 else nvl((nvl(a.returnnum, 0) - nvl(b.returnnum1, 0)) / nullif(b.returnnum1, 0) * 100, 100)  ");
//		sb.append("   end, '9999999990.99')) || '%' returnnumPercent, ");
//		sb.append("   (nvl(a.returnmoney, 0) - nvl(b.returnmoney1, 0)) returnmoneyComp, ");
//		sb.append("   trim(to_char(case when nvl(a.returnmoney,0) - nvl(b.returnmoney1, 0) = 0 then 0 when nvl(a.returnmoney, 0) - b.returnmoney1 = 0  ");
//		sb.append("   then 0 else nvl((nvl(a.returnmoney, 0) - nvl(b.returnmoney1, 0)) / nullif(b.returnmoney1, 0) * 100, 100)  ");
//		sb.append("   end, '9999999990.99')) || '%' returnmoneyPercent, ");
//		sb.append("    ");
//		sb.append("   (nvl(a.cancelnum, 0) - nvl(b.cancelnum1, 0)) cancelnumComp, ");
//		sb.append("   trim(to_char(case when nvl(a.cancelnum,0) - nvl(b.cancelnum1, 0) = 0 then 0 when nvl(a.cancelnum, 0) - b.cancelnum1 = 0  ");
//		sb.append("   then 0 else nvl((nvl(a.cancelnum, 0) - nvl(b.cancelnum1, 0)) / nullif(b.cancelnum1, 0) * 100, 100)  ");
//		sb.append("   end, '9999999990.99')) || '%' cancelnumPercent ");
//		sb.append("   ,(nvl(a.cancelmoney, 0) - nvl(b.cancelmoney1, 0)) cancelmoneyComp, ");
//		sb.append("   trim(to_char(case when nvl(a.cancelmoney,0) - nvl(b.cancelmoney1, 0) = 0 then 0 when nvl(a.cancelmoney, 0) - b.cancelmoney1 = 0  ");
//		sb.append("   then 0 else nvl((nvl(a.cancelmoney, 0) - nvl(b.cancelmoney1, 0)) / nullif(b.cancelmoney1, 0) * 100, 100)  ");
//		sb.append("   end, '9999999990.99')) || '%' cancelmoneyPercent ");
//		sb.append("    ");
//		sb.append("   ,(nvl(a.returntcknum, 0) - nvl(b.returntcknum1, 0)) returntcknumComp, ");
//		sb.append("   trim(to_char(case when nvl(a.returntcknum,0) - nvl(b.returntcknum1, 0) = 0 then 0 when nvl(a.returntcknum, 0) - b.returntcknum1 = 0  ");
//		sb.append("   then 0 else nvl((nvl(a.returntcknum, 0) - nvl(b.returntcknum1, 0)) / nullif(b.returntcknum1, 0) * 100, 100)  ");
//		sb.append("   end, '9999999990.99')) || '%' returntcknumPercent ");
//		sb.append("    ");
//		sb.append("   ,(nvl(a.returntcamount, 0) - nvl(b.returntcamount1, 0)) returntcamountComp, ");
//		sb.append("    trim(to_char(case when nvl(a.returntcamount,0) - nvl(b.returntcamount1, 0) = 0 then 0 when nvl(a.returntcamount, 0) - b.returntcamount1 = 0  ");
//		sb.append("    then 0 else nvl((nvl(a.returntcamount, 0) - nvl(b.returntcamount1, 0)) / nullif(b.returntcamount1, 0) * 100, 100)  ");
//		sb.append("    end, '9999999990.99')) || '%' returntcamountPercent ");
//		sb.append(" from ( ");
//		sb.append("   select  nvl(z.orgid,nvl(x.orgid,nvl(c.orgid,v.orgid))) orgid,nvl(z.orgname, nvl(x.orgname,nvl(c.orgname,v.orgname))) orgname, ");
//		if (isbyseller == true) {
//			sb.append("   nvl(z.sellbyid, nvl(x.sellbyid,nvl(c.sellbyid,v.sellbyid))) sellbyid, ");
//			sb.append("   nvl(z.sellbyname, nvl(x.sellbyname,nvl(c.sellbyname,v.sellbyname))) sellbyname, ");
//		}
//		sb.append("   z.sellnum,z.sellmoney,x.returnnum,x.returnmoney,c.cancelnum,c.cancelmoney, ");
//		sb.append("   v.returntcknum,v.returntcamount ");
//		sb.append("   from ( ");
//		// sb.append("     -- 售票张数、售票金额 ");
//		
//		sb.append("     select h.orgname,h.orgid, ");
//
//		if (isbyseller == true) {
//			sb.append("     h.sellbyid,h.sellbyname, ");
//		} else {
//			sb.append("     '' sellbyid,'' sellbyname,  ");
//		}
//		sb.append("     count(h.sellnum) sellnum,sum(h.sellmoney) sellmoney ");
//		sb.append("     from ( ");
//		sb.append("         select o.name orgname,o.id orgid, ");
//		sb.append("         u.id sellbyid,u.name sellbyname, ");
//		sb.append("         t.id sellnum,t.price sellmoney ");
//		sb.append("          ");
//		sb.append("         from Ticketsell t ,Organization o, Userinfo u where u.id=t.sellby ");
//		sb.append("         and o.id=u.orgid and t.ticketstatus='0' ");
//		sb.append("         and t.selltime between :startdate and :enddate ");
//		sb.append("         and t.orgid in" + orgids + " ");
//		sb.append("         union ");
//		sb.append("         select o.name orgname,o.id orgid, ");
//		sb.append("         u.id sellbyid,u.name sellbyname, ");
//		sb.append("         t.id sellnum,t.price sellmoney ");
//		sb.append("         from Ticketsellagent t ,Organization o, Userinfo u where u.id=t.sellby ");
//		sb.append("         and o.id=u.orgid and t.ticketstatus='0' ");
//		sb.append("         and t.selltime between :startdate and :enddate ");
//		sb.append("         and u.orgid in" + orgids + " ");
//		sb.append("     ) h ");
//		sb.append("     group by h.orgname,h.orgid  ");
//		if (isbyseller == true) {
//			sb.append("     ,h.sellbyid,h.sellbyname  ");
//		}
//		sb.append("   ) z ");
//		sb.append("   full join ( ");
//		// sb.append("     --退票张数、退票金额 ");
//		sb.append("     select o.id as orgid,o.name as orgname ,");
//		if (isbyseller == true) {
//			sb.append("     u.id sellbyid,u.name sellbyname, ");
//		} else {
//			sb.append("     '' sellbyid,'' sellbyname,  ");
//		}
//		sb.append("     count(tr.id) returnnum,sum(tr.returnamount) returnmoney ");
//		sb.append("     from Ticketreturn tr,Ticketsell tl ,Organization o, Userinfo u where u.id=tr.returnby ");
//		sb.append("     and o.id=u.orgid and tl.id=tr.sellid ");
//		sb.append("     and tr.returntime between :startdate and :enddate ");
//		sb.append("     and u.orgid in" + orgids + " ");
//		sb.append("     group by o.name,o.id  ");
//		if (isbyseller == true) {
//			sb.append("     ,u.id,u.name  ");
//		}
//		sb.append("   ) x on z.orgid=x.orgid ");
//		if (isbyseller == true) {
//			sb.append("   and z.sellbyid=x.sellbyid");
//		}
//		sb.append("   full join ( ");
//		// sb.append("     --废票张数、废票金额 ");
//		sb.append("     select o.id as orgid,o.name as orgname ,");
//		if (isbyseller == true) {
//			sb.append("     u.id sellbyid,u.name sellbyname, ");
//		} else {
//			sb.append("     '' sellbyid,'' sellbyname,  ");
//		}
//		sb.append("     count(tc.id) cancelnum,sum(tc.ticketprice) cancelmoney ");
//		sb.append("     from Ticketcancel tc,Ticketsell tl ,Organization o, Userinfo u where u.id=tc.cancelby ");
//		sb.append("     and o.id=u.orgid and tl.id=tc.sellid ");
//		sb.append("     and tc.canceltime between :startdate and :enddate ");
//		sb.append("     and u.orgid in" + orgids + " ");
//		sb.append("     group by o.name,o.id  ");
//		if (isbyseller == true) {
//			sb.append("     ,u.id,u.name  ");
//		}
//		sb.append("   ) c on nvl(z.orgid,x.orgid)=c.orgid ");
//		if (isbyseller == true) {
//			sb.append("   and nvl(z.sellbyid,x.sellbyid)=c.sellbyid");
//		}
//		sb.append("   full join ( ");
//		// sb.append("     --全款退票数 、退票金额");
//		sb.append("     select o.name orgname,o.id orgid, ");
//		if (isbyseller == true) {
//			sb.append("     u.id sellbyid,u.name sellbyname, ");
//		} else {
//			sb.append("     '' sellbyid,'' sellbyname,  ");
//		}
//		sb.append("     count(rt.id) returntcknum,sum(rt.returnamount) returntcamount from Ticketreturn rt ,Ticketsell tl ,Organization o, Userinfo u where u.id=rt.returnby ");
//		sb.append("     and o.id=u.orgid and tl.id=rt.sellid and rt.ticketprice=rt.returnamount ");
//		sb.append("     and rt.returntime between :startdate and :enddate ");
//		sb.append("     and u.orgid in" + orgids + " ");
//		sb.append("     group by o.name,o.id ");
//		if (isbyseller == true) {
//			sb.append("     ,u.id,u.name  ");
//		}
//		sb.append("   ) v on nvl(z.orgid,nvl(x.orgid,c.orgid))=v.orgid ");
//		if (isbyseller == true) {
//			sb.append("   and nvl(z.sellbyid,nvl(x.sellbyid,c.sellbyid))=v.sellbyid");
//		}
//		sb.append(" ) a  ");
//		// sb.append(" --同比 ");
//		sb.append(" full join (  ");
//		sb.append("   select nvl(z.orgid,nvl(x.orgid,nvl(c.orgid,v.orgid))) orgid,nvl(z.orgname, nvl(x.orgname,nvl(c.orgname,v.orgname))) orgname, ");
//		if (isbyseller == true) {
//			sb.append("   nvl(z.sellbyid, nvl(x.sellbyid,nvl(c.sellbyid,v.sellbyid))) sellbyid, ");
//			sb.append("   nvl(z.sellbyname, nvl(x.sellbyname,nvl(c.sellbyname,v.sellbyname))) sellbyname, ");
//		}
//		sb.append("   z.sellnum1,z.sellmoney1,x.returnnum1,x.returnmoney1,c.cancelnum1,c.cancelmoney1, ");
//		sb.append("   v.returntcknum1,v.returntcamount1 ");
//
//		sb.append("   from ( ");
//		// sb.append("     -- 售票张数、售票金额 ");
//		sb.append("     select j.orgname,j.orgid, ");
//
//		if (isbyseller == true) {
//			sb.append("     j.sellbyid,j.sellbyname, ");
//		} else {
//			sb.append("     '' sellbyid,'' sellbyname,  ");
//		}
//		sb.append("     count(j.sellnum) sellnum1,sum(j.sellmoney) sellmoney1 ");
//		sb.append("     from ( ");
//		sb.append("         select o.name orgname,o.id orgid, ");
//		sb.append("         u.id sellbyid,u.name sellbyname, ");
//		sb.append("         t.id sellnum,t.price sellmoney ");
//		sb.append("          ");
//		sb.append("         from Ticketsell t ,Organization o, Userinfo u where u.id=t.sellby ");
//		sb.append("         and o.id=u.orgid and t.ticketstatus='0' ");
//		sb.append("         and t.selltime between :compStartdate and :compEnddate ");
//		sb.append("         and t.orgid in" + orgids + " ");
//		sb.append("         union ");
//		sb.append("         select o.name orgname,o.id orgid, ");
//		sb.append("         u.id sellbyid,u.name sellbyname, ");
//		sb.append("         t.id sellnum,t.price sellmoney ");
//		sb.append("         ");
//		sb.append("         from Ticketsellagent t ,Organization o, Userinfo u where u.id=t.sellby ");
//		sb.append("         and o.id=u.orgid and t.ticketstatus='0' ");
//		sb.append("         and t.selltime between :compStartdate and :compEnddate ");
//		sb.append("         and u.orgid in" + orgids + " ");
//		sb.append("     ) j ");
//		sb.append("     group by j.orgname,j.orgid  ");
//		if (isbyseller == true) {
//			sb.append("     ,j.sellbyid,j.sellbyname  ");
//		}
//		sb.append("   ) z ");
//		sb.append("   full join ( ");
//		// sb.append("     --退票张数、退票金额 ");
//		sb.append("     select o.id as orgid,o.name as orgname ,");
//		if (isbyseller == true) {
//			sb.append("     u.id sellbyid,u.name sellbyname, ");
//		} else {
//			sb.append("     '' sellbyid,'' sellbyname,  ");
//		}
//		sb.append("     count(tr.id) returnnum1,sum(tr.returnamount) returnmoney1 ");
//		sb.append("     from Ticketreturn tr,Ticketsell tl ,Organization o, Userinfo u where u.id=tr.returnby ");
//		sb.append("     and o.id=u.orgid and tl.id=tr.sellid ");
//		sb.append("     and tr.returntime between :compStartdate and :compEnddate ");
//		sb.append("     and u.orgid in" + orgids + " ");
//		sb.append("     group by o.name,o.id  ");
//		if (isbyseller == true) {
//			sb.append("     ,u.id,u.name  ");
//		}
//		sb.append("   ) x on z.orgid=x.orgid ");
//		if (isbyseller == true) {
//			sb.append("   and z.sellbyid=x.sellbyid");
//		}
//		sb.append("   full join ( ");
//		// sb.append("     --废票张数、废票金额 ");
//		sb.append("     select o.id as orgid,o.name as orgname ,");
//		if (isbyseller == true) {
//			sb.append("     u.id sellbyid,u.name sellbyname, ");
//		} else {
//			sb.append("     '' sellbyid,'' sellbyname,  ");
//		}
//		sb.append("     count(tc.id) cancelnum1,sum(tc.ticketprice) cancelmoney1 ");
//		sb.append("     from Ticketcancel tc,Ticketsell tl ,Organization o, Userinfo u where u.id=tc.cancelby ");
//		sb.append("     and o.id=u.orgid and tl.id=tc.sellid ");
//		sb.append("     and tc.canceltime between :compStartdate and :compEnddate ");
//		sb.append("     and u.orgid in" + orgids + " ");
//		sb.append("     group by o.name,o.id  ");
//		if (isbyseller == true) {
//			sb.append("     ,u.id,u.name  ");
//		}
//		sb.append("   ) c on nvl(z.orgid,x.orgid)=c.orgid ");
//		if (isbyseller == true) {
//			sb.append("   and nvl(z.sellbyid,x.sellbyid)=c.sellbyid");
//		}
//		sb.append("   full join ( ");
//		// sb.append("     --全款退票数、退票金额 ");
//		sb.append("     select o.name orgname,o.id orgid, ");
//		if (isbyseller == true) {
//			sb.append("     u.id sellbyid,u.name sellbyname, ");
//		} else {
//			sb.append("     '' sellbyid,'' sellbyname,  ");
//		}
//		sb.append("     count(rt.id) returntcknum1,sum(rt.returnamount) returntcamount1 from Ticketreturn rt ,Ticketsell tl ,Organization o, Userinfo u where u.id=rt.returnby ");
//		sb.append("     and o.id=u.orgid  and tl.id=rt.sellid and rt.ticketprice=rt.returnamount ");
//		sb.append("     and rt.returntime between :compStartdate and :compEnddate ");
//		sb.append("     and u.orgid in" + orgids + " ");
//		sb.append("     group by o.name,o.id ");
//		if (isbyseller == true) {
//			sb.append("     ,u.id,u.name  ");
//		}
//		sb.append("   ) v on nvl(z.orgid,nvl(x.orgid,c.orgid))=v.orgid  ");
//		if (isbyseller == true) {
//			sb.append("   and nvl(z.sellbyid,nvl(x.sellbyid,c.sellbyid))=v.sellbyid");
//		}
//		sb.append(" ) b  on a.orgid=b.orgid   ");
//		if (isbyseller == true) {
//			sb.append("   and a.sellbyid=b.sellbyid");
//			if (sellby != null) {
//				sb.append("   where nvl(a.sellbyid,b.sellbyid)=" + sellby);
//			}
//		}
//		sb.append(" order by a.orgname  ");
		sb.append(" select  a.orgname,");
		if (isbyseller == true) {
			sb.append("   a.sellbyname sellbyname,");
		} else {
			sb.append("   '' sellbyname,  ");
		}
	 sb.append(" (to_char(:startdate,'yyyy-MM-dd') || '至' || to_char(:enddate-1,'yyyy-MM-dd') ||  ' 同比 ' || to_char(:compStartdate,'yyyy-MM-dd') || '至' || to_char(:compEnddate-1,'yyyy-MM-dd')) departdate,")
       .append("sum(nvl(a.sellnum,0)) sellnum,sum(nvl(a.sellmoney,0)) sellmoney, ")
       .append(" sum(nvl(a.returnnum,0)) returnnum,sum(nvl(a.returnmoney,0)) returnmoney,")
       .append(" sum(nvl(a.cancelnum,0)) cancelnum,sum(nvl(a.cancelmoney,0)) cancelmoney,")
       .append(" sum(nvl(a.sellnum1,0)) sellnum1,sum(nvl(a.sellmoney1,0)) sellmoney1,")
       .append(" sum(nvl(a.returnnum1,0)) returnnum1,sum(nvl(a.returnmoney1,0)) returnmoney1,")
       .append(" sum(nvl(a.cancelnum1,0)) cancelnum1,sum(nvl(a.cancelmoney1,0)) cancelmoney1,")
       .append(" sum(nvl(a.returntcknum,0)) returntcknum,sum(nvl(a.returntcamount,0)) returntcamount,")
       .append(" sum(nvl(a.returntcknum1,0)) returntcknum1,sum(nvl(a.returntcamount1,0)) returntcamount1,")
       .append(" sum((nvl(a.sellnum, 0) - nvl(a.sellnum1, 0))) sellnumComp,")
       .append(" trim(to_char(case when sum(a.sellnum - nvl(a.sellnum1, 0)) = 0 then 0 when sum(nvl(a.sellnum, 0)) - sum(a.sellnum1) = 0")
       .append(" then 0 else nvl((nvl(sum(a.sellnum), 0) - nvl(sum(a.sellnum1), 0)) / nullif(sum(a.sellnum1), 0) * 100, 100)")
       .append(" end, '9999999990.99')) || '%' sellnumPercent,")
       .append(" sum((nvl(a.sellmoney, 0) - nvl(a.sellmoney1, 0))) sellmoneyComp,")
       .append(" trim(to_char(case when sum(nvl(a.sellmoney,0) - nvl(a.sellmoney1, 0)) = 0 then 0 when sum(nvl(a.sellmoney, 0)) - sum(a.sellmoney1) = 0")
       .append(" then 0 else nvl((nvl(sum(a.sellmoney), 0) - nvl(sum(a.sellmoney1), 0)) / nullif(sum(a.sellmoney1), 0) * 100, 100)")
       .append(" end, '9999999990.99')) || '%' sellmoneyPercent,")
       .append(" sum((nvl(a.returnnum, 0) - nvl(a.returnnum1, 0))) returnnumComp,")
       .append(" trim(to_char(case when sum(nvl(a.returnnum,0) - nvl(a.returnnum1, 0)) = 0 then 0 when sum(nvl(a.returnnum, 0) - a.returnnum1) = 0")
       .append(" then 0 else nvl((nvl(sum(a.returnnum), 0) - nvl(sum(a.returnnum1), 0)) / nullif(sum(a.returnnum1), 0) * 100, 100)")
       .append(" end, '9999999990.99')) || '%' returnnumPercent,")
       .append(" sum((nvl(a.returnmoney, 0) - nvl(a.returnmoney1, 0))) returnmoneyComp,")
       .append(" trim(to_char(case when sum(nvl(a.returnmoney,0) - nvl(a.returnmoney1, 0)) = 0 then 0 when sum(nvl(a.returnmoney, 0) - a.returnmoney1) = 0")
       .append(" then 0 else nvl((nvl(sum(a.returnmoney), 0) - nvl(sum(a.returnmoney1), 0)) / nullif(sum(a.returnmoney1), 0) * 100, 100)")
       .append(" end, '9999999990.99')) || '%' returnmoneyPercent,")
       .append(" sum((nvl(a.cancelnum, 0) - nvl(a.cancelnum1, 0))) cancelnumComp,")
       .append(" trim(to_char(case when sum(nvl(a.cancelnum,0) - nvl(a.cancelnum1, 0)) = 0 then 0 when sum(nvl(a.cancelnum, 0) - a.cancelnum1) = 0")
       .append(" then 0 else nvl((nvl(sum(a.cancelnum), 0) - nvl(sum(a.cancelnum1), 0)) / nullif(sum(a.cancelnum1), 0) * 100, 100)")
       .append(" end, '9999999990.99')) || '%' cancelnumPercent")
       .append(" ,sum((nvl(a.cancelmoney, 0) - nvl(a.cancelmoney1, 0))) cancelmoneyComp,")
       .append(" trim(to_char(case when sum(nvl(a.cancelmoney,0) - nvl(a.cancelmoney1, 0)) = 0 then 0 when sum(nvl(a.cancelmoney, 0) - a.cancelmoney1) = 0")
       .append(" then 0 else nvl((nvl(sum(a.cancelmoney), 0) - nvl(sum(a.cancelmoney1), 0)) / nullif(sum(a.cancelmoney1), 0) * 100, 100)")
       .append(" end, '9999999990.99')) || '%' cancelmoneyPercent")
       .append(" ,sum((nvl(a.returntcknum, 0) - nvl(a.returntcknum1, 0))) returntcknumComp,")
       .append(" trim(to_char(case when sum(nvl(a.returntcknum,0) - nvl(a.returntcknum1, 0)) = 0 then 0 when sum(nvl(a.returntcknum, 0) - a.returntcknum1) = 0")
       .append(" then 0 else nvl((nvl(sum(a.returntcknum), 0) - nvl(sum(a.returntcknum1), 0)) / nullif(sum(a.returntcknum1), 0) * 100, 100)")
       .append(" end, '9999999990.99')) || '%' returntcknumPercent")
       .append(" ,sum((nvl(a.returntcamount, 0) - nvl(a.returntcamount1, 0))) returntcamountComp,")
       .append(" trim(to_char(case when sum(nvl(a.returntcamount,0) - nvl(a.returntcamount1, 0)) = 0 then 0 when sum(nvl(a.returntcamount, 0) - a.returntcamount1) = 0")
       .append(" then 0 else nvl((nvl(sum(a.returntcamount), 0) - nvl(sum(a.returntcamount1), 0)) / nullif(sum(a.returntcamount1), 0) * 100, 100)")
       .append(" end, '9999999990.99')) || '%' returntcamountPercent")
       .append(" from (")
       		.append(" select sellorg.name orgname, ");
	 		if (isbyseller == true) {
	 			sb.append(" u.name sellbyname,");
	 		}	 			
       		sb.append(" sum(tsd.sellnum - tsd.returnnum - tsd.cancelnum) as sellnum,")
       		.append(" sum(tsd.returnnum) returnnum,")
       		.append(" sum(tsd.cancelnum) cancelnum,")
       		.append(" sum(tsd.totalprice) sellmoney,")
       		.append(" sum(tsd.returnprice) as returnmoney,")
       		.append(" sum(tsd.cancelmoeny) cancelmoney,")
       		.append(" 0 sellnum1,")
       		.append(" 0 returnnum1,")
       		.append(" 0 cancelnum1,")
       		.append(" 0 sellmoney1,")
       		.append(" 0 returnmoney1,")
       		.append(" 0 cancelmoney1,")
       		.append(" 0 returntcknum,")
       		.append(" 0 returntcamount,")
       		.append(" 0 returntcknum1,")
       		.append(" 0 returntcamount1")
       		.append(" from ticketsellbysalerday tsd, organization sellorg, userinfo u")
       		.append(" where tsd.sellby = u.id")
       		.append(" and tsd.orgid = sellorg.id")
       		.append(" and u.orgid = sellorg.id")
       		.append(" and tsd.selldate between :startdate and :enddate-1")
       		.append(" and sellorg.id in " + orgids );
       		if (isbyseller == true) {
       			if(sellby !=null){
       				sb.append(" and u.id ="+sellby);
       			}
	       		sb.append(" group by sellorg.name ,u.name")
	       		.append(" union all")
	       		.append(" select sellorg.name orgname, u.name sellbyname,");
       		}else{
	       		sb.append(" group by sellorg.name ")
	       		.append(" union all")
	       		.append(" select sellorg.name orgname,");       			
       		}
       		sb.append(" 0 sellnum,")
       		.append(" 0 returnnum,")
       		.append(" 0 cancelnum,")
       		.append(" 0 sellmoney,")
       		.append(" 0 returnmoney,")
       		.append(" 0 cancelmoney,")
       		.append(" sum(tsd.sellnum - tsd.returnnum - tsd.cancelnum) as sellnum1,")
       		.append(" sum(tsd.returnnum) as returnnum1,")
       		.append(" sum(tsd.cancelnum) as cancelnum1,")
       		.append(" sum(tsd.totalprice) sellmoney,")
       		.append(" sum(tsd.returnprice) as returnmoney1,")
       		.append(" sum(tsd.cancelmoeny) cancelmoney1,")
       		.append(" 0 returntcknum,")
       		.append(" 0 returntcamount,")
       		.append(" 0 returntcknum1,")
       		.append(" 0 returntcamount1")
       		.append(" from ticketsellbysalerday tsd, organization sellorg, userinfo u")
       		.append(" where tsd.sellby = u.id")
       		.append(" and tsd.orgid = sellorg.id")
       		.append(" and u.orgid = sellorg.id")
       		.append(" and tsd.selldate between :compStartdate and :compEnddate-1")
       		.append(" and sellorg.id in " + orgids );
       		if (isbyseller == true) {
       			if(sellby !=null){
       				sb.append(" and u.id ="+sellby);
       			}
       			sb.append(" group by sellorg.name ,u.name")
           		.append(" union all")
           		.append(" select o.name orgname, u.name sellbyname,");
       		}else{
       			sb.append(" group by sellorg.name ")
           		.append(" union all")
           		.append(" select o.name orgname,");
       		}
       		sb.append(" 0 sellnum,")
       		.append(" 0 returnnum,")
       		.append(" 0 cancelnum,")
       		.append(" 0 sellmoney,")
       		.append(" 0 returnmoney,")
       		.append(" 0 cancelmoney,")
       		.append(" 0 sellnum1,")
       		.append(" 0 returnnum1,")
       		.append(" 0 cancelnum1,")
       		.append(" 0 sellmoney1,")
       		.append(" 0 returnmoney1,")
       		.append(" 0 cancelmoney1,")
       		.append(" count(rt.id) returntcknum,")
       		.append(" sum(rt.returnamount) returntcamount,")
       		.append(" 0 returntcknum1,")
       		.append(" 0 returntcamount1")
       		.append(" from Ticketreturn rt, Ticketsell tl, Organization o, Userinfo u")
       		.append(" where u.id = rt.returnby")
       		.append(" and o.id = u.orgid")
       		.append(" and tl.id = rt.sellid")
       		.append(" and rt.ticketprice = rt.returnamount")
       		.append(" and rt.returntime between :startdate and :enddate-1")
       		.append(" and u.orgid in " + orgids );
       		if (isbyseller == true) {
       			if(sellby !=null){
       				sb.append(" and u.id ="+sellby);
       			}
       			sb.append(" group by o.name ,u.name")
           		.append(" union all")
           		.append(" select o.name orgname, u.name sellbyname,");
       			
       		}else{
       			sb.append(" group by o.name ")
           		.append(" union all")
           		.append(" select o.name orgname,");
       		}
       		sb.append(" 0 sellnum,")
       		.append(" 0 returnnum,")
       		.append(" 0 cancelnum,")
       		.append(" 0 sellmoney,")
       		.append(" 0 returnmoney,")
       		.append(" 0 cancelmoney,")
       		.append(" 0 sellnum1,")
       		.append(" 0 returnnum1,")
       		.append(" 0 cancelnum1,")
       		.append(" 0 sellmoney1,")
       		.append(" 0 returnmoney1,")
       		.append(" 0 cancelmoney1,")
       		.append(" 0 returntcknum,")
       		.append(" 0 returntcamount,")
       		.append(" count(rt.id) returntcknum1,")
       		.append(" sum(rt.returnamount) returntcamount1")
       		.append(" from Ticketreturn rt, Ticketsell tl, Organization o, Userinfo u")
       		.append(" where u.id = rt.returnby")
       		.append(" and o.id = u.orgid")
       		.append(" and tl.id = rt.sellid")
       		.append(" and rt.ticketprice = rt.returnamount")
       		.append(" and rt.returntime between :compStartdate and :compEnddate-1")
       		.append(" and u.orgid in " + orgids );
       		if (isbyseller == true) {
       			if(sellby !=null){
       				sb.append(" and u.id ="+sellby);
       			}
       			sb.append(" group by o.name ,u.name")
       			.append(" ) a group by  a.orgname,a.sellbyname ");
       		}else{
       			sb.append(" group by o.name ")
       			.append(" ) a group by  a.orgname ");
       		}


		Query query = getEntityManager().createNativeQuery(sb.toString());

		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		query.setParameter("compStartdate", compStartdate);
		query.setParameter("compEnddate", compEnddate);

		List<Object> list = query.getResultList();

		return list;
	}
}
