/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.report.dao<br/>
 * <b>文件名：</b>StationDepartinvoiceDao.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2012-2-21 上午08:53:58 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;

/**
 * <b>类描述：车辆停靠点运量汇总表</b><br/>
 * <b>类名称：</b>StationDepartinvoiceDao.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-2-21 上午08:53:58 <br/>
 * <b>关键修改：机构ID修改为String 类型</b><br/>
 * <b>修改时间：2012-4-19</b><br/>
 * <b>修改人：黄浩泽</b><br/>
 */
@SuppressWarnings("rawtypes")
public class VehicleStationDepartinvoiceDao extends EntityManagerDaoSurport {
	@SuppressWarnings("unchecked")
	public List<Object> query(String orgid, Date startdate, Date enddate,
			Long vehicleid, Long routeid, Long stationid) {
		StringBuffer sql = new StringBuffer("select a.orgname,b.vehicleno, ");
		sql.append(" b.stationname,a.routename, b.dpticketnum,a.dticketnum, ")
				.append(" round(b.dpticketnum/a.dticketnum*100,2)||'%' percentnum,b.dpamount,a.damount, ")
				.append(" round(b.dpamount/a.damount*100,2)||'%' percentamount,b.dpdistance, a.dticketnum*b.distance ddistance, ")
				.append(" round(b.dpdistance/(a.dticketnum*b.distance)*100,2)||'%' percentdistance ")
				.append(" from (select o.name orgname, r.name, sn.name routename,sum(dd.ticketnum) dticketnum, ")
				.append(" sum(dd.totalamount) damount from departinvoices d,departinvoicesdetail dd, organization o, route r, ")
				.append(" schedule s, station sn where d.printorgid = o.id  and dd.departinvoicesid=d.id")//and s.workways <> '0'
				.append(" and d.scheduleid = s.id and s.routeid = r.id and d.status <> '1' and dd.reachstationid = sn.id ")
				.append(" and d.departdate>=:startdate and d.departdate<=:enddate ");
		if (vehicleid != null && !"".equals(vehicleid)) {
			 sql.append(" and r.name in (select r.name from departinvoices d, schedule s, route r ")
			           .append(" where d.scheduleid=s.id and s.routeid=r.id and d.vehicleid=:vehicleid and ")
			           .append(" d.departdate>=:startdate and d.departdate <=:enddate) ");
		}
		if (orgid != null && !"".equals(orgid)) {
			sql.append(" and o.id in ");
			sql.append(orgid);
		}
		if (routeid != null && !"".equals(routeid)) {
			sql.append(" and r.id = "+routeid);
		}
		if (stationid != null && !"".equals(stationid)) {
			sql.append(" and dd.reachstationid = "+stationid);
		}
		sql.append(
				" group by o.name, r.name,sn.name) a, (select sn.name stname, st.name stationname, v.vehicleno, ")
				.append(" sum(dp.ticketnum) dpticketnum, sum(dp.totalamount) dpamount, sum(dp.ticketnum)*")
				.append(" sum(dp.distance)/count(dp.id) dpdistance,sum(dp.distance)/count(dp.id) distance ")
				.append(" from departinvoices d, departinvoicesdetail dp,")
				.append(" station st,schedule s,route r,vehicle v,station sn where dp.departinvoicesid = d.id ")
				.append(" and dp.reachstationid = st.id and d.scheduleid=s.id and s.routeid=r.id and d.vehicleid=v.id ")
				.append(" and r.endstationid=sn.id and d.departdate>=:startdate and d.departdate<=:enddate and v.id=:vehicleid ");
		if (routeid != null && !"".equals(routeid)) {
			sql.append(" and r.id = "+routeid);
		}
		if (stationid != null && !"".equals(stationid)) {
			sql.append(" and dp.reachstationid = "+stationid);
		}
		sql.append(" group by v.vehicleno, sn.name,st.name) b where a.routename=b.stationname ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		query.setParameter("vehicleid", vehicleid);
		return query.getResultList();
	}	
}
