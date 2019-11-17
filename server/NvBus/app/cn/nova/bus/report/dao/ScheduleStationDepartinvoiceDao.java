/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.report.dao<br/>
 * <b>文件名：</b>ScheduleStationDepartinvoice.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2012-2-29 下午01:09:28 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;

/**
 * <b>类描述：班线和停靠点运量汇总表</b><br/>
 * <b>类名称：</b>ScheduleStationDepartinvoice.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-2-29 下午01:09:28 <br/>
 * <b>关键修改：添加查询条件；线路</b><br/>
 * <b>修改时间：2012-06-28</b><br/>
 * <b>修改人：hhz</b><br/>
 */
@SuppressWarnings("rawtypes")
public class ScheduleStationDepartinvoiceDao extends EntityManagerDaoSurport {
	
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
	
	@SuppressWarnings("unchecked")
	public List<Object> query(String orgid, Date startdate, Date enddate,
			Long routeid, String schedulecode) {
		/*
		 * StringBuffer sql = new StringBuffer(
		 * "select a.orgname,nvl(nvl2(nullif(a.rname, '小计'), rt.name, a.rname), '合计') routename,a.unitname,"
		 * ) .append(
		 * "a.reachname,a.ticketnum,nullif((round(a.ticketnum * 100 / b.tnum, 2) || '%'),'%') rate1,"
		 * ) .append(
		 * "a.totalamount,nullif((round(a.totalamount * 100 / b.alltotalamount, 2) || '%'),'%') rate2,"
		 * ) .append(
		 * "a.peopledistance,nullif((round(a.peopledistance * 100 / b.allpeopledistance, 2) || '%'),'%') rate3"
		 * ) .append(
		 * " from (select grouping(s.routeid) + s.routeid + grouping(str.name)+grouping(u.id) id,"
		 * ) .append(
		 * " decode(grouping(str.name) + grouping(s.routeid)+grouping(u.id),")
		 * .append(" 1,'小计',2,'合计',s.routeid) as rname,") .append(
		 * " decode(grouping(str.name) + grouping(s.routeid)+grouping(u.id),")
		 * .append(
		 * " 1,1,2,2,s.routeid) as rid , u.name unitname,str.name reachname,s.routeid as cccc,"
		 * ) .append(" o.name orgname,sum(div.ticketnum) as ticketnum,")
		 * .append(" sum(div.totalamount) as totalamount,")
		 * .append(" sum(div.ticketnum * div.distance) peopledistance")
		 * .append(" from departinvoices dv,departinvoicesdetail div,schedule s,"
		 * ) .append(" station str,route r,organization o,vehicle v,unit  u")
		 * .append(" where dv.id = div.departinvoicesid")
		 * .append(" and dv.status <> '1'") .append(" and r.id = s.routeid")
		 * .append
		 * (" and o.id = r.orgid and dv.vehicleid=v.id and v.unitid=u.id")
		 * .append(" and dv.scheduleid = s.id")
		 * .append(" and dv.scheduleid = div.scheduleid")
		 * .append(" and div.reachstationid = str.id")
		 * .append(" and dv.scheduleid = s.id")
		 * .append(" and dv.departdate >= :startdate and dv.departdate <= :enddate"
		 * ) .append(" and o.id in "+orgid); if(routeid != null && routeid !=
		 * 0){ sql.append(" and s.routeid = "+routeid); } if(scheduleid != null
		 * && scheduleid != 0){ sql.append(" and s.id = "+scheduleid); }
		 * sql.append
		 * (" group by o.name,u.id, Rollup(s.routeid, str.name,u.name)")
		 * .append(" order by 1, s.routeid, 2) a  ") .append(" LEFT JOIN")
		 * .append
		 * (" (select s.routeid,0 as rtid,sum(div.totalamount) as alltotalamount,"
		 * ) .append(
		 * " sum(div.ticketnum) as tnum,sum(div.ticketnum * div.distance) allpeopledistance"
		 * )
		 * .append(" from departinvoices dv,departinvoicesdetail div,schedule s,"
		 * ) .append(" station str, route r,organization o")
		 * .append(" where dv.id = div.departinvoicesid")
		 * .append(" and dv.status <> '1'") .append(" and r.id = s.routeid")
		 * .append(" and o.id = r.orgid") .append(" and dv.scheduleid = s.id")
		 * .append(" and dv.scheduleid = div.scheduleid")
		 * .append(" and div.reachstationid = str.id")
		 * .append(" and dv.scheduleid = s.id")
		 * .append(" and dv.departdate >= :startdate and dv.departdate <= :enddate"
		 * ) .append(" and o.id in "+orgid); if(routeid != null && routeid !=
		 * 0){ sql.append(" and s.routeid = "+routeid); } if(scheduleid != null
		 * && scheduleid != 0){ sql.append(" and s.id = "+scheduleid); }
		 * sql.append
		 * ("  group by s.routeid order by 1, s.routeid, 2 ) b ON a.rid = b.routeid"
		 * ) .append(
		 * " LEFT JOIN route rt on rt.id = a.rid order by a.id,a.cccc,a.rid ");
		 * Query query = getEntityManager().createNativeQuery(sql.toString());
		 * query.setParameter("startdate", startdate);
		 * query.setParameter("enddate", enddate); return query.getResultList();
		 */
		StringBuffer sql = new StringBuffer(
				"select nvl(a.rname,'合计'),unitname,reachname,")
				.append(" a.ticketnum,nullif((to_char(round(a.ticketnum * 100 / b.tnum, 2),'990.99') || '%'), '%') rate1,")
				.append(" a.totalamount,nullif((to_char(round(a.totalamount * 100 / b.alltotalamount, 2),'990.99') || '%'),")
				.append(" '%') rate2,a.peopledistance,nullif((to_char(round(a.peopledistance * 100 / b.allpeopledistance, 2),'990.99') || '%'),")
				.append(" '%') rate3")
				.append(" from (select decode(grouping(r.name), 1, '', r.name) rname,")
				.append("  decode(grouping(r.name) + grouping(u.name), 1, '', u.name) unitname,")
				.append(" decode(grouping(str.name) + grouping(r.name),1,'小计',str.name) reachname,")
				.append(" sum(div.ticketnum) as ticketnum,")
				.append(" sum(div.totalamount) as totalamount,sum(div.ticketnum * div.distance) peopledistance")
				.append("  from departinvoices       dv, departinvoicesdetail div,")
				.append(" schedule s,station str,route r,organization o,")
				.append(" vehicle v,unit u")
				.append(" where dv.id = div.departinvoicesid and dv.status <> '1'")
				.append(" and r.id = s.routeid and o.id = r.orgid and dv.vehicleid = v.id")
				.append(" and v.unitid = u.id and dv.scheduleid = s.id and dv.scheduleid = div.scheduleid")
				.append(" and div.reachstationid = str.id and dv.scheduleid = s.id")
				.append(" and dv.departdate >= :startdate and dv.departdate <= :enddate")
				.append(" and o.id in " + orgid);
		if (routeid != null && routeid != 0) {
			sql.append(" and s.routeid = " + routeid);
		}
		if (schedulecode != null && schedulecode != "") {
			sql.append(" and s.code  like '%" + schedulecode + "%'");
		}
		sql.append(" group by Rollup(r.name, str.name, u.name)")
				.append("  ) a")
				.append(" LEFT JOIN (select s.routeid,r.name rname,")
				.append("  sum(div.totalamount) as alltotalamount,")
				.append("   sum(div.ticketnum) as tnum,")
				.append(" sum(div.ticketnum * div.distance) allpeopledistance")
				.append("   from departinvoices       dv,departinvoicesdetail div,")
				.append("  schedule             s,station              str,")
				.append("  route                r,organization         o")
				.append("  where dv.id = div.departinvoicesid and dv.status <> '1'")
				.append("  and r.id = s.routeid and o.id = r.orgid")
				.append(" and dv.scheduleid = s.id and dv.scheduleid = div.scheduleid")
				.append(" and div.reachstationid = str.id and dv.scheduleid = s.id")
				.append(" and dv.departdate >= :startdate and dv.departdate <= :enddate")
				.append(" and o.id in " + orgid);
		if (routeid != null && routeid != 0) {
			sql.append(" and s.routeid = " + routeid);
		}
		if (schedulecode != null && schedulecode != "") {
			sql.append(" and s.code  like '%" + schedulecode + "%'");
		}
		sql.append(" group by s.routeid, r.name")
				.append(" ) b ON a.rname = b.rname")
				.append(" order by a.rname,decode(a.reachname,'1','2','小计') desc, a.unitname");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		return query.getResultList();

	}
}
