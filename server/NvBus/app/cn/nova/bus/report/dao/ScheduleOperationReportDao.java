/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.report.dao<br/>
 * <b>文件名：</b>ScheduleOperationReportDao.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-11-20 上午10:37:46<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>ScheduleOperationReportDao.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-11-20 上午10:37:46<br/>
 * <b>关键修改：添加线路里程，改正班次数，</b><br/>
 * <b>修改时间：2013-04-15  </b><br/>
 * <b>修改人：hhz</b><br/>
 */
@SuppressWarnings("rawtypes")
public class ScheduleOperationReportDao extends EntityManagerDaoSurport {

	/**
	 * 班线运营情况汇总表
	 * @param orgids
	 * @param startdate
	 * @param enddate
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryScheduleOperationReport(String orgids,
			Date startdate, Date enddate, Long routeid) {
		StringBuffer sql = new StringBuffer("select r.name,")
		.append("planschedule,")
		.append("nvl(stopschedule,0),")
		.append("nvl(lateschedule,0),")
		.append("nvl(departed,0),")
		.append("nvl(departed * r.distance,0) as routedistance,")
		.append("nvl(overtimedepart,0),")
		.append("nvl(ticketnum,0),")
		.append("nvl(totalamount,0),")
		.append("nvl(peopledistance,0),")
		.append("nvl(seatnum ,0),")
		.append("nvl(decode(seatnum, 0, 0, round(ticketnum / seatnum * 100, 2)),0) ratedistance,")
		.append("nvl(decode((planschedule - overtime),0,0,round((departed - overtimedepart) /")
		.append("       (planschedule - overtime) * 100,2)),0) rateschedule,")
		.append("nvl(decode(departed,0,0,round((departed - lateschedule) / departed * 100, 2)),0) ratelateschedule")
		.append(" from (")
			.append("	select a.name,a.id,")//流水班计划情况
			.append("sum(planschedule) planschedule,")
			.append("sum(seatnum) seatnum,")
			.append("0 overtime,")
			.append("0 stopschedule,")
			.append("0 lateschedule,")
			.append("sum(ticketnum) ticketnum,")
			.append("sum(departed) as departed,")
			.append("0 overtimedepart,")
			.append("sum(totalamount) totalamount,")
			.append("sum(peopledistance) peopledistance,")
			.append("sum(routedistance) routedistance")
			.append(" from (select r.name,")
					.append("r.id,")
					.append("count(vr.id) planschedule,")
					.append("sum(v.seatnum) seatnum")
					.append(" from scheduleplan  s,")
					.append("schedule      sc,")
					.append("route         r,")
					.append("organization  o,")
					.append("vehiclereport vr,")
					.append("vehicle       v")
					.append(" where s.scheduleid = sc.id")
					.append(" and sc.routeid = r.id")
					.append(" and s.orgid = o.id")
					.append(" and s.orgid in "+orgids)
					.append(" and s.islinework = 1")
					.append(" and vr.scheduleplanid = s.id")
					.append(" and vr.vehicleid = v.id ");
					//.append(" and vr.isdeparted = 1");
					if (routeid != null && !"".equals(routeid)) {
						sql.append(" and r.id="+routeid);
					}
					sql.append(" and s.departdate between :startdate and :enddate")
					.append(" group by r.name, r.id)  a left join ")
			.append(" (select r.name,")//流水班实际运量情况 
			.append(" r.id,")
			.append(" sum(d.ticketnum) ticketnum,")
			.append(" count(distinct d.reportid) as departed,")
			.append(" sum(d.totalamount) totalamount,")
			.append(" sum(de.peopledistance) peopledistance,")
			.append(" sum(r.distance) routedistance")
			.append(" from departinvoices d,")
			.append(" scheduleplan s,")
			.append(" schedule sc,")
			.append(" route r,")
			.append(" (select dt.departinvoicesid,")
			.append(" sum(dt.distance * dt.ticketnum) peopledistance")
			.append(" from departinvoicesdetail dt")
			.append(" where dt.departdate between :startdate and :enddate")
			.append(" group by dt.departinvoicesid) de")
			.append(" where d.id = de.departinvoicesid(+)")
			.append(" and d.scheduleplanid = s.id")
			.append(" and s.scheduleid = sc.id")
			.append(" and sc.routeid = r.id")
			.append(" and sc.islinework=1")
			.append(" and d.status <> '1'")
			.append(" and s.departdate = d.departdate")
			.append(" and s.orgid in "+orgids);
			if (routeid != null && !"".equals(routeid)) {
				sql.append(" and r.id="+routeid);
			}
			sql.append(" and d.departdate between :startdate and :enddate")
			.append(" group by r.name, r.id) b")
			.append(" on a.name = b.name and a.id=b.id group by a.name,a.id")
	.append(" union ")
	.append(" select a.name,a.id,")
	.append(" a.planschedule planschedule,")
	.append(" a.seatnum seatnum,")
	.append(" a.overtime overtime,")
	.append(" a.stopschedule stopschedule,")
	.append(" a.lateschedule lateschedule,")
	.append(" b.ticketnum ticketnum,")
	.append(" b.departed  departed,")
	.append(" b.overtimedepart overtimedepart,")
	.append(" b.totalamount totalamount,")
	.append(" b.peopledistance peopledistance,")
	.append(" b.routedistance routedistance")
	.append(" from (select r.name,")//非流水班计划情况 
		.append(" r.id,")
		.append(" count(s.id) planschedule,")
		.append(" sum(s.seatnum - s.fixedreserveseatnum) seatnum,")
		.append(" sum(case s.isovertime  when 1 then 1 else 0 end) overtime,")
		.append(" sum(case st.status when '1' then 1 else 0 end) stopschedule,")
		.append(" sum(case when st.status = '2' and st.isdeparted=1 then 1 else 0 end) lateschedule")
		.append(" from scheduleplan   s,")
		.append(" schedule       sc,")
		.append(" route          r,")
		.append(" organization   o,")
		.append(" schedulestatus st")
		.append(" where s.scheduleid = sc.id")
		.append(" and sc.routeid = r.id")
		.append(" and sc.orgid = o.id")
		.append(" and s.islinework = 0")
		.append(" and st.departdate between :startdate and :enddate")
		.append(" and st.scheduleplanid = s.id")
		.append(" and s.departdate =st.departdate")
		.append(" and o.id in "+orgids);
		if (routeid != null && !"".equals(routeid)) {
			sql.append(" and r.id="+routeid);
		}
		sql.append(" group by r.name, r.id) a left join")
		.append(" (select r.name,")//非流水班实际运量情况
		.append(" r.id,")
		.append(" sum(d.ticketnum) ticketnum,")
		.append(" count(distinct d.reportid) as departed,")
		.append(" count(distinct case when sc.isovertime = 1 then d.reportid end) overtimedepart,")
		.append(" sum(d.totalamount) totalamount,")
		.append(" sum(de.peopledistance) peopledistance,")
		.append(" sum(r.distance) routedistance")
		.append(" from departinvoices d,")
		.append(" scheduleplan s,")
		.append(" schedule sc,")
		.append(" route r,")
		.append(" (select dt.departinvoicesid,")
		.append(" sum(dt.distance * dt.ticketnum) peopledistance")
		.append(" from departinvoicesdetail dt")
		.append(" where dt.departdate between :startdate and :enddate")
		.append(" group by dt.departinvoicesid) de")
		.append("  where d.id = de.departinvoicesid(+)")
		.append(" and d.scheduleplanid = s.id")
		.append(" and s.scheduleid = sc.id")
		.append(" and sc.routeid = r.id")
		.append(" and d.status <> '1'")
		.append(" and sc.islinework=0")
		.append(" and s.departdate = d.departdate")
		.append(" and s.orgid in "+orgids);
		if (routeid != null && !"".equals(routeid)) {
			sql.append(" and r.id="+routeid);
		}
		sql.append(" and d.departdate between :startdate and :enddate")
		.append("  group by r.name, r.id) b on a.name=b.name and a.id=b.id ")
		.append(" ) alls,route r where r.name= alls.name and r.id = alls.id ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		return query.getResultList();
	}	
}
