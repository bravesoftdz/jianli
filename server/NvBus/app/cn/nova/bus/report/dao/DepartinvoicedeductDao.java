/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.report.dao<br/>
 * <b>文件名：</b>DepartinvoicedeductDao.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b> 2012-4-25 下午04:55:55 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>DepartinvoicedeductDao.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-4-25 下午04:55:55 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class DepartinvoicedeductDao extends EntityManagerDaoSurport {

	/**
	 * 查询固定扣费项目
	 * 
	 * @param startdate
	 * @param enddate
	 * @param orgids
	 * @param printorgid
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryDeduct(Date startdate, Date enddate,
			String orgids, Long printorgid) {
		StringBuffer sql = new StringBuffer("select a.rname, ")
				.append(" sum(case when a.bname='站务费' then a.deductmoney else 0 end) stationfee, ")
				.append(" sum(case when a.bname='扣费1' then a.deductmoney else 0 end) computefee, ")
				.append(" sum(case when a.bname='附加费' then a.deductmoney else 0 end) additionfee, ")
				.append(" sum(case when a.bname='空调费' then a.deductmoney else 0 end) collairfee, ")
				.append(" sum(case when a.bname='配水费' then a.deductmoney else 0 end) waterfee, ")
				.append(" sum(case when a.bname='保险费' then a.deductmoney else 0 end) insurefee, ")
				.append(" sum(case when a.bname='其它' then a.deductmoney else 0 end) otherfee ")
				.append(" from (select r.name rname, ")
				.append(" case de.parentbalanceitemid when 0 then bd.name  else ")
				.append(" (select ba.name from balancedeductitem ba where de.parentbalanceitemid = ba.id) ")
				.append(" end as bname, de.deductmoney as deductmoney ")
				.append(" from departinvoicesdeductdetail de, departinvoices d, route r, ")
				.append(" balancedeductapply b, balancedeductitem  bd, schedule s ")
				.append(" where de.departinvoicesid = d.id and de.balanceapplyid = b.id ")
				.append(" and de.balanceitemid = bd.id and d.scheduleid = s.id and s.orgid in ")
				.append(orgids)
				.append(" and d.departdate between :startdate and :enddate ");
		if (printorgid != null && !"".equals(printorgid)) {
			sql.append(" and d.printorgid=").append(printorgid);
		}
		sql.append(" and s.routeid = r.id and d.status!=1 order by r.name) a ")
				.append(" group by a.rname");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		return query.getResultList();
	}

	/**
	 * 车辆结算汇总查询
	 * 
	 * @param buildFromHttpRequest
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryVehicleDepartinvoices(
			List<PropertyFilter> buildFromHttpRequest,String orgid) {
		StringBuffer sql = new StringBuffer("select t.*,v.contactperson from ( select decode(grouping(u1.name), ");
		sql.append(" 1, '', u1.name) unitname, decode(grouping(v.vehicleno) + ")
				.append(" grouping(u1.name),1, '小计',2,'合计', v.vehicleno) vehicleno, ")
				.append(" sum(dv.ticketnum) as ticketnum, sum(dv.totalamount) as totalamount, ")
				.append(" sum(dv.stationservicefee) as stationservicefee, sum(dv.balanceamount) balanceamount, ")
				.append(" sum(dv.agentfee) agentfee, sum(nvl((select sum(dd.deductmoney) ")
				.append(" from departinvoicesdeductdetail dd, balancedeductitem a ")
				.append(" where dd.departinvoicesid = dv.id and dd.balanceitemid = a.id ")
				.append(" and dd.status <> '1' and (a.name like '%扣费1%' or a.name like '%微机费%') ), 0)) computefee, ")
				.append(" sum(nvl((select sum(dd.deductmoney) ")
				.append(" from departinvoicesdeductdetail dd, balancedeductitem a ")
				.append(" where dd.departinvoicesid = dv.id and dd.balanceitemid = a.id ")
				.append(" and dd.status <> '1' and a.name like '%空调费%'), 0)) coolairfee, ")
				.append(" sum(nvl((select sum(dd.deductmoney) ")
				.append(" from departinvoicesdeductdetail dd, balancedeductitem a ")
				.append(" where dd.departinvoicesid = dv.id and dd.balanceitemid = a.id ")
				.append(" and dd.status <> '1' and a.name like '%附加费%'), 0)) additionfee, ")
				.append(" sum(nvl((select sum(dd.deductmoney) ")
				.append(" from departinvoicesdeductdetail dd, balancedeductitem a ")
				.append(" where dd.departinvoicesid = dv.id and dd.balanceitemid = a.id ")
				.append(" and dd.status <> '1' and a.name like '%燃油费%'), 0)) fuelfee, ")
				.append(" sum(nvl((select sum(dd.deductmoney) ")
				.append(" from departinvoicesdeductdetail dd, balancedeductitem a ")
				.append(" where dd.departinvoicesid = dv.id and dd.balanceitemid = a.id ")
				.append(" and dd.status <> '1' and a.name like '%保险费%'), 0)) insurefee, ")
				.append(" sum(nvl((select sum(dd.deductmoney) ")
				.append(" from departinvoicesdeductdetail dd, balancedeductitem a ")
				.append(" where dd.departinvoicesid = dv.id and dd.balanceitemid = a.id ")
				.append(" and dd.status <> '1' and a.name like '%配水费%'), 0)) waterfee, ")
				.append(" sum(nvl((select sum(dd.deductmoney) ")
				.append(" from departinvoicesdeductdetail dd, balancedeductitem a ")
				.append(" where dd.departinvoicesid = dv.id and dd.balanceitemid = a.id ")
				.append(" and dd.status <> '1' and a.name like '%其它%'), 0)) otherfee ,")
				.append(" sum(nvl((select sum(dd.deductmoney)")
				.append(" from departinvoicesdeductdetail dd, balancedeductitem a")
                .append(" where dd.departinvoicesid = dv.id")
                .append("   and dd.balanceitemid = a.id and dd.status <> '1'")
                .append("   and (a.name like '%扣费1%' or a.name like '%微机费%' or a.name like '%空调费%' ")
                .append("        or a.name like '%附加费%' or a.name like '%燃油费%' or a.name like '%保险费%'")
                .append("         or a.name like '%配水费%' or a.name like '%其它%')),")
                .append(" 0))+sum(dv.agentfee)+sum(dv.stationservicefee) allsum,trim('微机单') balancetype,  count(dv.id) schedulenum")
				.append(" from Departinvoices dv, route r, schedule s, ")
				.append(" vehicle v, unit u1 where dv.scheduleid = s.id ")
				.append(" and s.routeid = r.id and dv.vehicleid = v.id and ")
				.append(" v.unitid = u1.id and dv.status <> '1' ");
		if(orgid!=null&&!orgid.equals("")){
			sql.append(" and dv.printorgid in "+orgid);
		}
		sql.append(PropertyFilter.toJpql(buildFromHttpRequest, true));
		sql.append(" group by rollup(u1.name, v.vehicleno) order by u1.name, v.vehicleno ");
		sql.append(") t  left join vehicle v on t.vehicleno=v.vehicleno "); 
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, buildFromHttpRequest);
		return query.getResultList();
	}
	
	/**
	 * 车辆结算汇总查询(手工单)
	 * 
	 * @param buildFromHttpRequest
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryHandVehicleDepartinvoices(
			List<PropertyFilter> buildFromHttpRequest,String orgid) {
		StringBuffer sql = new StringBuffer("select t.*,v.contactperson from  (select decode(grouping(u1.name), ");
		sql.append(" 1, '', u1.name) unitname, decode(grouping(v.vehicleno) + ")
				.append(" grouping(u1.name),1, '小计',2,'合计', v.vehicleno) vehicleno, ")
				.append(" sum(dd.ticketnum) as ticketnum, sum(dd.totalamount) as totalamount, ")
				.append(" sum(dd.stationservicefee) as stationservicefee, sum(dd.balanceamount) balanceamount, ")
				.append(" sum(dd.agentfee) agentfee, 0 computefee,0 coolairfee,0 additionfee,0 fuelfee, ")
				.append(" 0 insurefee,0 waterfee,sum(dd.othterfee) otherfee, ")
				.append(" sum(dd.agentfee) + sum(dd.stationservicefee)+sum(dd.othterfee) allsum,trim('手工单') balancetype,count(dv.id) as schedulenum")
				.append(" from departinvoicesother dv,departinvoicesotherdetail dd , route r, schedule s, ")
				.append(" vehicle v, unit u1 where dv.scheduleid = s.id and dv.id=dd.departinvoicesotherid")
				.append(" and s.routeid = r.id and dv.vehicleid = v.id  and")
				.append(" v.unitid = u1.id and dv.status <> '1' ");
		if(orgid!=null&&!orgid.equals("")){
			sql.append(" and dv.orgid in "+orgid);
		}
		sql.append(PropertyFilter.toJpql(buildFromHttpRequest, true));
		sql.append(" group by rollup(u1.name, v.vehicleno) order by u1.name, v.vehicleno ");
		sql.append(" ) t  left join vehicle v on t.vehicleno=v.vehicleno ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, buildFromHttpRequest);
		return query.getResultList();
	}

	/**
	 * 线路结算汇总查询
	 * 
	 * @param buildFromHttpRequest
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> routebalancereport(
			List<PropertyFilter> buildFromHttpRequest) {		
		
		
		StringBuffer sql = new StringBuffer(
				"select a.name,b.ticketnum,b.totalamount,b.agentfee,b.stationservicefee, ");
		sql.append("a.fuelfee,a.computerfee,a.coolairfee,a.additionfee,a.waterfee,")
		.append("a.insurefee,a.overtimefee,a.otherfee,a.allsum,b.balanceamount ")
		.append("from ( select r.name name,   ")
		.append("sum(case")
		.append(" when a.code='K' ")//like '%燃油费%' 
		.append(" then dd.deductmoney")
		.append(" else 0")
		.append("end) as fuelfee,")
		.append(" sum(case")
		.append(" when a.code='E' ")// like '%扣费1%'
		.append(" then dd.deductmoney")
		.append(" else 0")
		.append("  end) as computerfee,")
		.append("  sum(case")
		.append("    when a.code='G' ")//like '%空调费%' 
		.append("   then dd.deductmoney")
		.append("  else 0")
		.append("end) as coolairfee,")
		.append("sum(case")
		.append("  when a.code='D' ")//like '%附加费%' 
		.append("  then dd.deductmoney")
		.append("  else 0")
		.append(" end) as additionfee,")
		.append(" sum(case")
		.append("  when a.code='H' ")//like '%配水费%' 
		.append("  then dd.deductmoney")
		.append("  else 0")
		.append(" end) as waterfee,")
		.append(" sum(case")
		.append(" when a.code='I' ")//like '%保险费%' 
		.append(" then dd.deductmoney")
		.append(" else 0")
		.append(" end) as insurefee,")
		.append(" sum(case")
		.append("  when a.name like '%加班%' ")
		.append("  then dd.deductmoney")
		.append("  else 0")
		.append(" end) as overtimefee,")
		.append(" sum(case")
		.append("   when a.code='J' ")//like '%其它%' 
		.append("  then dd.deductmoney")
		.append("  else 0")
		.append("end) as otherfee,")
		.append("  sum(case")
		//.append("    when a.name like '%扣费1%' or a.name like '%空调费%' ")
		//.append("    or a.name like '%附加费%' or a.name like '%燃油费%' or a.name like '%保险费%'  ")
		//.append("    or a.name like '%配水费%' or a.name like '%其它%'  or a.name like '%加班%' ")
		.append("    when a.code='E' or a.code='G'  ")
		.append("    or a.code='D' or a.code='K' or a.code='I'  ")
		.append("    or a.code='H' or a.code='J'  or a.name like '%加班%' ")		
		.append("  then dd.deductmoney")
		.append("  else 0")
		.append(" end) +sum(dv.agentfee)+sum(dv.stationservicefee) allsum ")
		.append("from departinvoicesdeductdetail dd")
		.append(" inner join Departinvoices dv on dd.departinvoicesid = dv.id")
		.append(" left outer join balancedeductitem a on dd.balanceitemid = a.id")
		.append(" left outer join schedule s on s.id = dv.scheduleid")
		.append(" left outer join route r on r.id = s.routeid ")
		.append(" where dv.status <> '1' ")
		.append(PropertyFilter.toJpql(buildFromHttpRequest, true))
		.append(" group by r.name ) a ")

		.append(" inner join ")

		.append("(select r.name name,sum(dv.balanceamount) balanceamount,   ")
		.append("   sum(dv.ticketnum) ticketnum,")
		.append("sum(dv.totalamount) totalamount,")
		.append("sum(dv.agentfee) agentfee,")
		.append(" sum(dv.stationservicefee) stationservicefee")
		.append(" from  Departinvoices dv ")
		.append(" left outer join schedule s on s.id = dv.scheduleid ")
		.append(" left outer join route r on r.id = s.routeid ")
		.append(" where dv.status <> '1' ")
		.append(PropertyFilter.toJpql(buildFromHttpRequest, true))
		.append(" group by r.name ) b on a.name=b.name");

			
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, buildFromHttpRequest);
		return query.getResultList();
	}
	/**
	 * 客运结算统计表
	 * @param orgids
	 * @param routeid
	 * @param vehicleid
	 * @param startdate
	 * @param enddate
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryDepartinvoices(String orgids, Long routeid,
			Long vehicleid, Date startdate, Date enddate) {
		StringBuffer sql = new StringBuffer(
				"select st.name, d.departdate, de.tickettype, ");
		sql.append(
				" count(de.id), sum(de.price), sum(de.distance), sum(r.distance) ")
				.append(" from Departinvoices d, Route r, Schedule s, ")
				.append(" Departinvoicesdetail de, Station st ")
				.append(" where d.scheduleid = s.id and s.routeid = r.id ")
				.append(" and de.departinvoicesid = d.id and r.endstationid = st.id ")
				.append(" and de.tickettype in ('Q','B') and d.departdate between ")
				.append(" date'2012-4-5' and date'2012-5-4' and s.orgid in (4480)");// :startdate and :enddate  :orgids
			if (routeid != null) {
				sql.append(" and r.id="+routeid);
			}
			if (vehicleid != null) {
				sql.append(" and d.vehicleid="+vehicleid);
			}
		sql.append(" group by st.name, d.departdate, de.tickettype  ")
			.append(" order by st.name, d.departdate, de.tickettype ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		//query.setParameter("orgids", orgids);
		//query.setParameter("startdate", startdate);
		//query.setParameter("enddate", enddate);
		return query.getResultList();
	}

}
