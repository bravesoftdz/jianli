package cn.nova.bus.report.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;

/**
 * <b>类描述：车辆营运配载统计表</b><br/>
 * <b>类名称：</b>VehicleStowageReportDao.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-4-28 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class VehicleStowageReportDao extends EntityManagerDaoSurport {

	/**
	 * 车辆营运配载统计表
	 * 
	 * @param startdate
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryVehicleStowage(Date startdate, Date enddate,
			String orgid, Long routeid, String isovertime) {
		StringBuffer sql = new StringBuffer(
				"select a.orgname, a.departdate, a.schnum, a.ticketnum, ")
				.append(" a.peopledistance, a.balanceamount, b.schedulenum from ")
				.append(" (select orgname, departdate,sum(schnum) schnum,")
				.append(" sum(ticketnum) ticketnum,sum(peopledistance) peopledistance, ")
				.append(" sum(balanceamount) balanceamount from ")
				.append(" (select o.name orgname,dv.departdate, ")
				.append(" count(distinct dv.reportid) schnum, sum(dv.ticketnum) ticketnum,")
				.append(" sum(de.peopledistance) peopledistance,sum(dv.balanceamount) balanceamount")
				.append(" from Departinvoices dv,organization o,schedule s,route r,schedulestatus st,")
				.append(" (select dt.departinvoicesid,sum(dt.distance * dt.ticketnum) peopledistance")
				.append(" from departinvoicesdetail dt")
				.append(" where dt.departdate between :startdate and :enddate ")
				.append(" group by dt.departinvoicesid) de")
				.append(" where dv.id = de.departinvoicesid(+) and o.id=dv.printorgid ")
				.append(" and dv.scheduleid = s.id and s.routeid = r.id ")
				.append(" and dv.scheduleplanid=st.scheduleplanid ")
				.append(" and dv.departdate between :startdate and :enddate ")
				.append(" and st.departdate between :startdate and :enddate and st.isdeparted=1 ")
				.append(" and dv.status <> '1' and dv.printorgid in " + orgid);
		if (routeid != null && routeid != 0) {
			sql.append(" and r.id = " + routeid);
		}
		if (isovertime != null && !isovertime.equals("")) {
			sql.append(" and s.isovertime = " + isovertime);
		}
		sql.append(" group by o.name,dv.departdate ");
		
		sql.append(" union select o.name orgname,dv.departdate,")
		.append("count(distinct dv.reportid) schnum, sum(dv.ticketnum) ticketnum,")
		.append("sum(de.peopledistance) peopledistance,sum(dv.balanceamount) balanceamount")
		.append(" from Departinvoices dv,organization o,schedule s,route r,")
		.append(" (select dt.departinvoicesid,sum(dt.distance * dt.ticketnum) peopledistance")
		.append(" from departinvoicesdetail dt")
		.append(" where dt.departdate between :startdate and :enddate ")
		.append(" group by dt.departinvoicesid) de")
		.append(" where dv.id = de.departinvoicesid(+) and o.id=dv.printorgid ")
		.append(" and dv.scheduleid = s.id and s.routeid = r.id ")
		.append(" and dv.departdate between :startdate and :enddate and s.islinework=1 ")
		.append(" and dv.status <> '1' and dv.printorgid in " + orgid);
		if (routeid != null && routeid != 0) {
			sql.append(" and r.id = " + routeid);
		}
		if (isovertime != null && !isovertime.equals("")) {
			sql.append(" and s.isovertime = " + isovertime);
		}
		sql.append(" group by o.name,dv.departdate) group by orgname,departdate)  a, ");
		
		sql.append(" (select name,departdate,sum(schedulenum) schedulenum from ")
		.append(" (select o.name, s.departdate, count(svp.id) schedulenum ")
		.append(" from schedulestatus s,organization o, scheduleplan sc, route r, schedule sh,vehiclereport svp")
		.append("  where s.departstationid=o.stationid and s.scheduleplanid=sc.id and svp.scheduleplanid=s.scheduleplanid")
		.append(" and s.scheduleid=sh.id and sh.routeid=r.id and svp.orgid=svp.reportorgid and o.id in " + orgid)
		.append(" and sc.islinework=1 and svp.isactive = 1 and s.departdate between :startdate and :enddate ");
		if (routeid != null && routeid != 0) {
			sql.append(" and r.id = " + routeid);
		}
		if (isovertime != null && !isovertime.equals("")) {
			sql.append(" and sc.isovertime = " + isovertime);
		}
		sql.append(" group by o.name,s.departdate ")
		.append(" union select o.name, s.departdate, count(sc.id) schedulenum ")
		.append(" from schedulestatus s,organization o, scheduleplan sc, route r, schedule sh ")
		.append(" where s.departstationid=o.stationid and s.scheduleplanid=sc.id and sc.islinework=0 ")
		.append(" and s.scheduleid=sh.id and sh.routeid=r.id and o.id in " + orgid)
		.append(" and s.departdate between :startdate and :enddate ");
		if (routeid != null && routeid != 0) {
			sql.append(" and r.id = " + routeid);
		}
		if (isovertime != null && !isovertime.equals("")) {
			sql.append(" and sc.isovertime = " + isovertime);
		}
		sql.append(" group by o.name,s.departdate  ");
		sql.append(") group by name,departdate) b where a.orgname = b.name ")
		.append(" and a.departdate = b.departdate ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		return query.getResultList();
	}
}
