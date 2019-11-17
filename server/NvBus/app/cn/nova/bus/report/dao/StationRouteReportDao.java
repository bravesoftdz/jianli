package cn.nova.bus.report.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;

/**
 * <b>类描述：客运班线调查统计表</b><br/>
 * <b>类名称：</b>StationRouteReportDao.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b>2013-08-08上午08:53:58 <br/>
 */
@SuppressWarnings("rawtypes")
public class StationRouteReportDao  extends EntityManagerDaoSurport{

//	ceil(n) 取大于等于数值n的最小整数；
//	floor(n)取小于等于数值n的最大整数	
	
	@SuppressWarnings("unchecked")
	public List<Object> query(String scheduleorgid,Date startdate ,Date enddate) {
		int tempunm = cn.nova.utils.commons.DateUtils.getIntervalDays(startdate,enddate)+1;
		StringBuffer sql = new StringBuffer(
				"SELECT startname,endname,uintnum,s1,s2,s3,v1,v2,v3,p1,p2,p3, ")
		.append(" (case  when v1=0 then 0|| '%' else NVL2(round(p1 / v1, 2) * 100, round(p1 / v1, 2) * 100 || '%', null) end ) rate,")
		.append(" '' as remark ")
		.append(" FROM ( ")
		.append(" SELECT sr.name startname,se.name endname,")
		.append(" count(distinct v.unitid) uintnum,")
		.append(" ceil(sum( case when s.workways = '0' then 1 end)")
		.append(" /"+tempunm+") S1,")
		.append(" ceil(sum( case when s.workways = '1' then 1 end)")
		.append(" /"+tempunm+") S2,")
		.append(" ceil(sum( case when s.workways ='2' then 1 end)")
		.append(" /"+tempunm+") S3,")
		.append(" ceil(sum( case when s.workways = '0' then v.seatnum end)")
		.append(" /"+tempunm+") V1,")
		.append(" ceil(sum( case when s.workways = '1' then v.seatnum end)")
		.append(" /"+tempunm+") V2,")
		.append(" ceil(sum( case when s.workways ='2' then v.seatnum end)")
		.append(" /"+tempunm+") V3,")
		.append(" ceil(sum( case when s.workways = '0' then dv.ticketnum end)")
		.append(" /"+tempunm+") P1,")
		.append(" ceil(sum( case when s.workways = '1' then dv.ticketnum end)")
		.append(" /"+tempunm+") P2,")
		.append(" ceil(sum( case when s.workways ='2' then dv.ticketnum end)")
		.append(" /"+tempunm+") P3")
		.append(" FROM route r ,schedule s,departinvoices dv,vehicle v,station sr,station se")
		.append(" WHERE dv.status<>'1'AND dv.scheduleid=s.id")
		.append(" AND  r.id=s.routeid  AND dv.vehicleid=v.id")
		.append(" AND dv.departdate >= :startdate AND dv.departdate <= :enddate")
		.append(" AND r.startstationid=sr.id AND r.endstationid = se.id ");
		if (scheduleorgid != null){
			sql.append(" AND s.orgid in "+scheduleorgid);
		}
		sql.append(" GROUP BY sr.name,se.name) ");	
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		return query.getResultList();
	}
	
}
