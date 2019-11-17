/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.report.dao<br/>
 * <b>文件名：</b>VehicleReportStatusDao.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-8-29 下午01:57:12<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.dao;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import org.apache.commons.lang.StringUtils;

import cn.nova.bus.dao.EntityManagerDaoSurport;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>VehicleReportStatusDao.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-8-29 下午01:57:12<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class VehicleReportStatusDao extends EntityManagerDaoSurport {
	
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

	/**
	 * 车辆报班情况一览表
	 * 
	 * @param departdate
	 * @param orgid
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryVehicleReportStatus(Date departdate, String orgid, String reportway) {
		//报班方式 前台传值为0：自动报班；1：手动报班；2：全部。
		String reportwaycon = "";
		boolean allflag = true;//标记查询所有（包括未报班）
		if (reportway!=null && (reportway.equals("0") | reportway.equals("1")) ){
			reportwaycon = " and vr.reportway='"+reportway+"' ";
			allflag = false;//不查询未报班的
		}
		
		StringBuffer sql = new StringBuffer(
				"select sn.name, s.code, trim(st.departtime) starttime, ");
		sql.append(" v.vehicleno,(case sp.isovertime when 0 then ")
				.append(" (case st.status when '1' then '停班' when '3' then '被并' ")
				.append(" when '4' then '脱班' else '' end) else '加班' end) remark, ")
				.append(" to_char(vr.reporttime, 'yyyy-mm-dd hh24:mi:ss') reporttime, ")
				.append("  case vr.reportway when '0' then trim('自动报班') else trim('手动报班') end reportway ")
				.append(" from Schedulestatus st, Vehiclereport vr, Schedule s, Route r, Vehicle v, ")
				.append(" Scheduleplan sp, Station sn, Organization o where st.scheduleplanid=sp.id ")
				.append(" and st.scheduleid=s.id and st.scheduleplanid=vr.scheduleplanid and vr.vehicleid=v.id ")
				.append(" and vr.reportorgid=o.id and s.routeid=r.id and r.endstationid=sn.id ")
				// and st.isreported in (0,1)
				.append(" and  st.departstationid=o.stationid and st.departdate=:departdate ")
				.append(" and o.id in ")
				.append(orgid)
				.append( reportwaycon );
		if(allflag){
				sql.append(" union ")
				.append(" select sn.name, s.code, trim(st.departtime) starttime, '' vehicleno,(case sp.isovertime when 0 then ")
				.append(" (case st.status when '1' then '停班' when '3' then '被并' when '4' then '脱班' else '' end) ")
				.append(" else '加班' end) remark, '' reporttime, '' reportway from Schedulestatus st, Schedule s, Route r, ")
				.append(" Scheduleplan sp, Station sn, Organization o where st.scheduleplanid=sp.id ")
				.append(" and st.scheduleid=s.id and st.isreported=0 and s.routeid=r.id and r.endstationid=sn.id ")
				.append(" and st.departdate=:departdate and o.id in ")
				.append(orgid).append(" and st.departstationid=o.stationid");
		}		
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("departdate", departdate);
		return query.getResultList();
	}

	/**
	 * 车辆售票流量统计
	 * 
	 * @param orgid
	 * @param departstation
	 * @param departdate
	 * @param routeid
	 * @param unitid
	 * @param vehicletypeid
	 * @param stationid
	 * @param scheduleid
	 * @param enddate
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryVehicleTicketCount(String orgid,
			long departstation, Date departdate, long routeid, long unitid,
			long vehicletypeid, long stationid, String schedulecode, Date enddate,
			String sellorgid, Date selldate, Date sellenddate) {
		StringBuffer sql = new StringBuffer("");
		/*
		 * //if (unitid == 0 && vehicletypeid == 0) { sql.append("select ");
		 * sql.append(
		 * " tbl1.departdate,tbl1.departtime,tbl1.stationname,tbl1.code, tbl1.routename,tbl1.totaleprice,"
		 * ); sql.append(
		 * " tbl1.soldeatnum,tbl1.solddistance,tbl1.seatnum,tbl1.seatdistance,tbl1.soldratio,tbl1.disratio,"
		 * ); sql.append(
		 * " tbl1.unitname,tbl1.vehicletype, tbl1.balance,tbl2.stationdetail");
		 * sql.append(" from (");
		 * sql.append("select t.departdate,trim(ss.departtime) departtime, ");
		 * sql.append(
		 * " st.name stationname, s.code, r.name routename, sum(t.price) totaleprice, count(sp.soldeatnum) soldeatnum, "
		 * ) .append(" sum(t.distance) solddistance, ") .append(
		 * " case count(t.id) when 0 then 0 else sum(sp.seatnum) / count(t.id) end seatnum, "
		 * ) .append(
		 * " case count(t.id) when 0 then 0 else sum(r.distance * sp.seatnum) / count(t.id) end seatdistance, "
		 * ) .append(
		 * " round(case sum(sp.seatnum) / count(t.id) when 0 then 0 else count(t.id) / "
		 * ) .append(
		 * " (sum(sp.seatnum) / count(t.id)) end * 100, 2) || '%' soldratio, ")
		 * .append(
		 * " round(case (sum(r.distance * sp.seatnum) / count(t.id)) when 0 then 0 else sum(t.distance) / "
		 * ) .append(
		 * " (sum(r.distance * sp.seatnum) / count(t.id)) end * 100, 2) || '%' disratio, u.name as unitname, vt.name as vehicletype, "
		 * ) .append(
		 * " sum(t.price-t.stationservicefee-t.fueladditionfee-t.computefee-t.coolairfee-t.additionfee-t.moreprice-t.waterfee-t.insurefee) balance "
		 * ) .append(
		 * " ,(row_number() over(partition by t.departdate, r.name, s.code, ss.departtime, st.name order by t.departdate, r.name, s.code, ss.departtime, st.name desc)) rm"
		 * ) .append(
		 * " from ticketsell t, scheduleplan sp, schedule s, station st, route r, schedulestatus ss, organization org, vehiclereport vr, vehicle v, vehicletype  vt, unit u"
		 * ) .append(
		 * " where t.scheduleplanid=sp.id and t.scheduleid=s.id and sp.endstationid=st.id and ss.departdate=sp.departdate"
		 * ) .append(
		 * " and s.routeid=r.id and ss.scheduleplanid=sp.id and ss.isreported=0 and t.ticketstatus=0 "
		 * ) .append(
		 * " and (select count(v.id) from vehiclereport v where v.scheduleplanid=sp.id and v.isactive=1 and v.departdate between  :departdate and :enddate"
		 * )
		 * .append(" and v.reportorgid=sp.orgid)=0 and t.departdate=sp.departdate"
		 * ) .append(
		 * " and v.vehicletypeid = vt.id(+) and v.unitid = u.id(+) and vr.vehicleid = v.id(+) and vr.scheduleplanid(+) = sp.id"
		 * ) .append(
		 * "  and sp.orgid=org.id and org.stationid=ss.departstationid and t.departdate between :departdate and :enddate "
		 * ); if (selldate != null && !"".equals(selldate)) {
		 * sql.append(" and t.selltime between :selldate and :sellenddate"); }
		 * if (orgid != null && !"".equals(orgid)) {
		 * sql.append(" and sp.orgid in " + orgid); } if (sellorgid != null &&
		 * !"".equals(sellorgid)) { sql.append(" and t.orgid in " + sellorgid);
		 * } if (departstation != 0) { sql.append(" and t.departstationid=" +
		 * departstation); } if (routeid != 0) { sql.append(" and r.id=" +
		 * routeid); } if (stationid != 0) { sql.append(" and t.reachstationid="
		 * + stationid); } if (scheduleid != 0) { sql.append(" and s.id=" +
		 * scheduleid); }
		 * 
		 * if (unitid != 0) { sql.append(" and u.id=" + unitid); } if
		 * (vehicletypeid != 0) { sql.append(" and vt.id=" + vehicletypeid); }
		 * 
		 * sql.append(
		 * " group by t.departdate,r.name,s.code,ss.departtime,st.name,u.name , vt.name  "
		 * ) .append(" union "); sql.append(
		 * " select t.departdate, trim(ss.departtime) departtime, st.name stationname, "
		 * ) .append(
		 * " s.code, r.name routename, sum(t.price) totaleprice, count(sp.soldeatnum) soldeatnum, "
		 * ) .append(" sum(t.distance) solddistance, ") .append(
		 * " case count(t.id) when 0 then 0 else sum(sp.seatnum) / count(t.id) end seatnum, "
		 * ) .append(
		 * " case count(t.id) when 0 then 0 else sum(r.distance * sp.seatnum) / count(t.id) end seatdistance, "
		 * ) .append(
		 * " round(case sum(sp.seatnum) / count(t.id) when 0 then 0 else count(t.id) / "
		 * ) .append(
		 * " (sum(sp.seatnum) / count(t.id)) end * 100, 2) || '%' soldratio, ")
		 * .append(
		 * " round(case (sum(r.distance * sp.seatnum) / count(t.id)) when 0 then 0 else sum(t.distance) / "
		 * ) .append(
		 * " (sum(r.distance * sp.seatnum) / count(t.id)) end * 100, 2) || '%' disratio,  vr.unitname as unitname, vr.vehicletype as vehicletype,"
		 * ) .append(
		 * " sum(t.price-t.stationservicefee-t.fueladditionfee-t.computefee-t.coolairfee-"
		 * )
		 * .append("t.additionfee-t.moreprice-t.waterfee-t.insurefee) balance ")
		 * .append(
		 * " , (row_number() over(partition by t.departdate, r.name, s.code, ss.departtime, st.name order by t.departdate, r.name, s.code, ss.departtime, st.name desc)) rm "
		 * )
		 * .append(" from Ticketsell t, scheduleplan sp, schedule s, station st,"
		 * ) .append(
		 * " route r, schedulestatus ss, (select sum(v.seatnum) seatnum ,vr.scheduleplanid ,u.name unitname,vt.name vehicletype"
		 * ) .append(
		 * " from vehiclereport  vr, vehicle v,vehicletype vt,unit u where vr.vehicleid=v.id and vr.orgid=vr.reportorgid "
		 * ) .append(
		 * " and v.vehicletypeid = vt.id and v.unitid = u.id and vr.vehicleid = v.id "
		 * ); if (unitid != 0) { sql.append(" and u.id=" + unitid); } if
		 * (vehicletypeid != 0) { sql.append(" and vt.id=" + vehicletypeid); }
		 * sql.append(
		 * " and vr.isactive=1 group by vr.scheduleplanid,u.name,vt.name) vr where t.scheduleplanid = sp.id "
		 * ) .append(
		 * " and t.scheduleid = s.id and sp.endstationid = st.id and s.routeid = r.id "
		 * ) .append(
		 * " and ss.scheduleplanid = sp.id and t.ticketstatus = 0 and ss.departdate=sp.departdate"
		 * ) // and ss.isreported = 1 .append(
		 * " and ss.departstationid=sp.startstationid and sp.islinework=1 and t.departdate=sp.departdate"
		 * ) .append(
		 * " and vr.scheduleplanid = sp.id and t.departdate between :departdate and :enddate "
		 * ); if (selldate != null && !"".equals(selldate)) {
		 * sql.append(" and t.selltime between :selldate and :sellenddate"); }
		 * if (orgid != null && !"".equals(orgid)) {
		 * sql.append(" and sp.orgid in " + orgid); } if (sellorgid != null &&
		 * !"".equals(sellorgid)) { sql.append(" and t.orgid in " + sellorgid);
		 * } if (departstation != 0) { sql.append(" and t.departstationid=" +
		 * departstation); } if (routeid != 0) { sql.append(" and r.id=" +
		 * routeid); } if (stationid != 0) { sql.append(" and t.reachstationid="
		 * + stationid); } if (scheduleid != 0) { sql.append(" and s.id=" +
		 * scheduleid); } sql.append(
		 * " group by t.departdate, r.name, s.code, ss.departtime, st.name, vr.unitname, vr.vehicletype "
		 * )
		 * 
		 * 
		 * .append(" union "); //} // sql.setLength(0); sql.append(
		 * " select t.departdate,trim(ss.departtime) departtime, st.name stationname, s.code, r.name routename, "
		 * ) .append(
		 * " sum(t.price) totaleprice, count(sp.soldeatnum) soldeatnum,sum(t.distance) solddistance, "
		 * ) .append(
		 * " case count(t.id) when 0 then 0 else sum(sp.seatnum) / count(t.id) end seatnum, "
		 * ) .append(
		 * " case count(t.id) when 0 then 0 else sum(r.distance * sp.seatnum) / count(t.id) end seatdistance, "
		 * ) .append(
		 * " round(case sum(sp.seatnum) / count(t.id) when 0 then 0 else count(t.id) / "
		 * ) .append(
		 * " (sum(sp.seatnum) / count(t.id)) end * 100, 2) || '%' soldratio, ")
		 * .append(
		 * " round(case (sum(r.distance * sp.seatnum) / count(t.id)) when 0 then 0 else sum(t.distance) / "
		 * ) .append(
		 * " (sum(r.distance * sp.seatnum) / count(t.id)) end * 100, 2) || '%' disratio, u.name as unitname, vt.name as vehicletype, "
		 * ) .append(
		 * " sum(t.price-t.stationservicefee-t.fueladditionfee-t.computefee-t.coolairfee-t.additionfee-t.moreprice-t.waterfee-t.insurefee) balance,1 rm "
		 * ) .append(
		 * " from Ticketsell t, scheduleplan sp, schedule s, station st, route r, schedulestatus ss, "
		 * ) .append(
		 * " vehiclereport vr, vehicle v, vehicletype vt, unit u, organization org "
		 * ) .append(
		 * " where t.scheduleplanid=sp.id and t.scheduleid=s.id and sp.endstationid=st.id and vr.isactive=1 "
		 * ) .append(
		 * " and s.routeid=r.id and ss.scheduleplanid=sp.id and ss.isreported=1 and t.ticketstatus=0 "
		 * ) .append(
		 * " and sp.orgid=org.id and org.stationid=ss.departstationid and org.id=vr.reportorgid and ss.departdate=sp.departdate"
		 * ) .append(
		 * " and vr.vehicleid=v.id and v.vehicletypeid=vt.id and v.unitid=u.id and vr.scheduleplanid=sp.id "
		 * ) .append(
		 * " and ss.departstationid=sp.startstationid and sp.departdate between :departdate and :enddate"
		 * ) .append(" and vr.departdate between :departdate and :enddate")
		 * .append(
		 * " and sp.islinework = 0 and t.departdate between :departdate and :enddate "
		 * ); if (selldate != null && !"".equals(selldate)) {
		 * sql.append(" and t.selltime between :selldate and :sellenddate"); }
		 * if (orgid != null && !"".equals(orgid)) {
		 * sql.append(" and sp.orgid in " + orgid); } if (sellorgid != null &&
		 * !"".equals(sellorgid)) { sql.append(" and t.orgid in " + sellorgid);
		 * } if (departstation != 0) { sql.append(" and t.departstationid=" +
		 * departstation); } if (routeid != 0) { sql.append(" and r.id=" +
		 * routeid); } if (stationid != 0) { sql.append(" and t.reachstationid="
		 * + stationid); } if (scheduleid != 0) { sql.append(" and s.id=" +
		 * scheduleid); } if (unitid != 0) { sql.append(" and u.id=" + unitid);
		 * } if (vehicletypeid != 0) { sql.append(" and vt.id=" +
		 * vehicletypeid); } sql.append(
		 * " group by t.departdate,r.name,s.code,ss.departtime,st.name,u.name,vt.name "
		 * ); sql.append(" ) tbl1 left join");
		 * 
		 * //获取对应售票站点明细
		 * sql.append("( select a.code,listagg(a.name || ' 总 ' || ");
		 * sql.append(
		 * " a.totale || ' 全 ' || a.fullticket || ' 半 ' || a.otherticket,';') within group (order by a.departdate , a.code) as stationdetail , a.departdate "
		 * ) .append(
		 * " from (select s.code,st.name,sum(case t.tickettype when 'Q' then 1 end) fullticket, "
		 * ) .append(
		 * " sum(case t.tickettype when 'Q' then 0 else 1 end) otherticket, count(t.id) totale, t.departdate "
		 * ) .append(
		 * " from ticketsell t, station st, schedule s, route r, scheduleplan sp, schedulestatus ss "
		 * ) .append(
		 * " where t.reachstationid=st.id and t.scheduleid=s.id and s.routeid=r.id and t.ticketstatus = 0 and sp.departdate=ss.departdate"
		 * ) .append(
		 * " and ss.departstationid=sp.startstationid and t.scheduleplanid=sp.id and ss.departdate=sp.departdate"
		 * ) .append(" and sp.departdate between :departdate and :enddate")
		 * .append(
		 * " and ss.scheduleplanid=sp.id and t.departdate between :departdate and :enddate "
		 * ); if (selldate != null && !"".equals(selldate)) {
		 * sql.append(" and t.selltime between :selldate and :sellenddate"); }
		 * if (orgid != null) { sql.append(" and sp.orgid in " + orgid); } if
		 * (sellorgid != null) { sql.append(" and t.orgid in " + sellorgid); }
		 * if (departstation != 0) { sql.append(" and t.departstationid=" +
		 * departstation); } if (routeid != 0) { sql.append(" and r.id=" +
		 * routeid); } if (stationid != 0) { sql.append(" and t.reachstationid="
		 * + stationid); } if (scheduleid != 0) { sql.append(" and s.id=" +
		 * scheduleid); } sql.append(
		 * " group by t.departdate, r.name, s.code, st.name) a  group by a.departdate , a.code  ) tbl2 on tbl1.departdate=tbl2.departdate and tbl1.code=tbl2.code "
		 * );
		 * 
		 * sql.append(" where tbl1.rm=1 ");
		 */

		// sql优化更改
		sql.append("select ");
		sql.append(" tbl1.departdate,tbl1.departtime,tbl1.stationname,tbl1.code, tbl1.routename,tbl1.totaleprice,");
		sql.append(" tbl1.soldeatnum,tbl1.solddistance,tbl1.seatnum,tbl1.seatdistance,tbl1.soldratio,tbl1.disratio,");
		sql.append(" tbl1.unitname,tbl1.vehicletype, tbl1.balance,tbl2.stationdetail");
		sql.append(" from (");
		sql.append(" select t.departdate, trim(sp.starttime) departtime, st.name stationname, ");
		sql.append(" s.code, r.name routename, sum(t.price) totaleprice, count(sp.soldeatnum) soldeatnum, ");
		sql.append(" sum(t.distance) solddistance, ");
		sql.append(" case count(t.id)   when 0 then 0   else sum(sp.seatnum) / count(t.id) end seatnum, ");
		sql.append(" case count(t.id)   when 0 then 0   else sum(r.distance * sp.seatnum) / count(t.id) end seatdistance, ");
		sql.append(" trim(to_char(round(case sum(sp.seatnum) when 0 then 0  else count(t.id)/sp.seatnum end *100, 2), '99999990.99')) || '%' soldratio, ");
		sql.append(" trim(to_char(round(case (r.distance * sp.seatnum) when 0 then 0 else sum(t.distance)/(r.distance * sp.seatnum) end *100, 2), '99999990.99')) || '%' disratio, ");
		//sql.append(" /* u.name as unitname, vt.name as vehicletype,*/ ");
		sql.append(" vr.unitname,vr.vehicletype, ");
		sql.append(" sum(t.price - t.stationservicefee - t.fueladditionfee - t.computefee - t.coolairfee - t.additionfee - t.moreprice - t.waterfee - t.insurefee) balance ");
		sql.append(" from ticketsell t, ");
		sql.append(" schedule s, station st, route   r, ");
		//sql.append(" organization   org,  ");
		sql.append(" ( ");
		sql.append("   select vr.scheduleplanid,u.name unitname,  vt.name vehicletype, ");
		sql.append("   (row_number() over(partition by  vr.scheduleplanid order by vr.scheduleplanid)) rm ");
		sql.append("   from vehiclereport vr,scheduleplan sp, vehicle v, vehicletype vt, unit u ");
		sql.append("   where vr.vehicleid = v.id  and v.vehicletypeid = vt.id  and v.unitid = u.id ");
		sql.append("   and sp.departdate between :departdate and :enddate ");
		sql.append("   and sp.id=vr.scheduleplanid and vr.isactive = 1 ");
		if (orgid != null && !"".equals(orgid)) {
			sql.append(" and sp.orgid in " + orgid);
		}
		sql.append("   group by vr.scheduleplanid, u.name, vt.name ");
		sql.append(" ) vr ,scheduleplan sp");
		sql.append("   ");
		sql.append(" where t.scheduleid = s.id and sp.endstationid = st.id ");
		sql.append(" and s.routeid = r.id  ");
		sql.append(" and t.departdate = sp.departdate   ");
		//sql.append(" and sp.orgid = org.id and org.stationid = sp.startstationid ");
		sql.append(" and vr.scheduleplanid(+) = sp.id  and vr.rm(+)=1 ");
		sql.append(" and t.scheduleplanid = sp.id ");
		sql.append(" and t.ticketstatus = 0   ");
		if (orgid != null && !"".equals(orgid)) {
			sql.append(" and sp.orgid in " + orgid);
		}
		sql.append(" and t.departdate between :departdate and :enddate ");
		sql.append(" and sp.departdate between :departdate and :enddate ");
		sql.append("   ");
		if (selldate != null && !"".equals(selldate)) {
			sql.append(" and t.selltime between :selldate and :sellenddate+0.99999");
		}

		if (sellorgid != null && !"".equals(sellorgid)) {
			sql.append(" and t.orgid in " + sellorgid);
		}
		if (departstation != 0) {
			sql.append(" and t.departstationid=" + departstation);
		}
		if (routeid != 0) {
			sql.append(" and r.id=" + routeid);
		}
		if (stationid != 0) {
			sql.append(" and t.reachstationid=" + stationid);
		}
		if (schedulecode != "" && schedulecode !=null) {
			sql.append(" and s.code like '%"+schedulecode+"%'");
		}
		if (unitid != 0) {
			sql.append(" and u.id=" + unitid);
		}
		if (vehicletypeid != 0) {
			sql.append(" and vt.id=" + vehicletypeid);
		}
		sql.append(" group by t.departdate, r.name, s.code, sp.starttime, st.name, ");
		sql.append(" vr.unitname,vr.vehicletype, r.distance,sp.seatnum ");
//		sql.append(" order by t.departdate,r.name,s.code,sp.starttime,st.name, ");
//		sql.append(" vr.unitname,vr.vehicletype ");
		sql.append(" ) tbl1 ");

		// 获取对应售票站点明细
		sql.append("left join (");
		sql.append(" select code, departdate,");
		sql.append(" ltrim(max(sys_connect_by_path(stationdetail, ';')), ';') stationdetail");
		sql.append(" from (");
		sql.append("   select t.code,t.departdate,t.stationdetail ,");
		sql.append("   (row_number() over(partition by t.code,t.departdate order by t.code,t.departdate)) numid ");
		sql.append("   from (");
		sql.append("      select a.departdate,a.code, (a.name || ' 总 ' || a.totale || ' 全 ' || a.fullticket || ' 半 ' || a.otherticket)");
		sql.append("      as stationdetail");
		sql.append("      from (");
		sql.append("        select t.departdate,s.code,  st.name,r.name routename,  sum(case t.tickettype when 'Q' then  1 else 0    end) fullticket, ");
		sql.append("        sum(case t.tickettype when 'Q' then  0 else  1  end) otherticket,");
		sql.append("        count(t.id) totale");
		sql.append("        from ticketsell     t,  ");
		sql.append("        scheduleplan   sp,  schedulestatus ss,station st,  schedule s,  route   r");
		sql.append("        where t.reachstationid = st.id  and t.scheduleid = s.id  and s.routeid = r.id");
		sql.append("        and sp.departdate = ss.departdate  and ss.departstationid = sp.startstationid");
		sql.append("        and t.scheduleplanid = sp.id  and ss.departdate = sp.departdate");
		sql.append("        and ss.scheduleplanid = sp.id");
		sql.append("        and t.ticketstatus = 0 ");
		
		if (orgid != null) {
			sql.append(" and sp.orgid in " + orgid);
		}
		if (sellorgid != null) {
			sql.append(" and t.orgid in " + sellorgid);
		}
		if (departstation != 0) {
			sql.append(" and t.departstationid=" + departstation);
		}
		if (routeid != 0) {
			sql.append(" and r.id=" + routeid);
		}
		if (stationid != 0) {
			sql.append(" and t.reachstationid=" + stationid);
		}
		if (schedulecode != "" && schedulecode !=null) {
			sql.append(" and s.code like '%"+schedulecode+"%'");
		}
		if (selldate != null && !"".equals(selldate)) {
			sql.append(" and t.selltime between :selldate and :sellenddate+0.99999");
		}
		sql.append("        and t.departdate between :departdate and :enddate ");
		sql.append("        and sp.departdate between :departdate and :enddate ");
		
		sql.append("        group by t.departdate, r.name, s.code, st.name");
		sql.append("      ) a");
		sql.append("   ) t");
		sql.append(" ) ");
		sql.append(" start with numid = 1 ");
		sql.append(" connect by numid - 1 = prior numid ");
		sql.append(" and code = prior code and departdate= prior departdate");
		sql.append(" group by code,departdate");
		sql.append(" ) tbl2 ");
		sql.append(" on tbl1.departdate=tbl2.departdate and tbl1.code=tbl2.code");
		
		Query query = getEntityManager().createNativeQuery(sql.toString());
		if (selldate != null && !"".equals(selldate)) {
			query.setParameter("selldate", selldate);
			query.setParameter("sellenddate", sellenddate);
		}
		query.setParameter("departdate", departdate);
		query.setParameter("enddate", enddate);
		return query.getResultList();
	}

	/**
	 * 车辆售票流量统计-获取对应售票站点明细
	 * 
	 * @param orgid
	 * @param departstation
	 * @param departdate
	 * @param routeid
	 * @param stationid
	 * @param scheduleid
	 * @param enddate
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> getStationDetail(String orgid, long departstation,
			Date departdate, long routeid, long stationid, long scheduleid,
			Date enddate, String sellorgid, Date selldate, Date sellenddate) {
		StringBuffer sql = new StringBuffer("select a.code,a.name || ' 总 ' || ");
		sql.append(
				" a.totale || ' 全 ' || a.fullticket || ' 半 ' || a.otherticket as stationdetail, a.departdate ")
				.append(" from (select s.code,st.name,sum(case t.tickettype when 'Q' then 1 end) fullticket, ")
				.append(" sum(case t.tickettype when 'Q' then 0 else 1 end) otherticket, count(t.id) totale, t.departdate ")
				.append(" from ticketsell t, station st, schedule s, route r, scheduleplan sp, schedulestatus ss ")
				.append(" where t.reachstationid=st.id and t.scheduleid=s.id and s.routeid=r.id and t.ticketstatus = 0 and sp.departdate=ss.departdate")
				.append(" and ss.departstationid=sp.startstationid and t.scheduleplanid=sp.id and ss.departdate=sp.departdate")
				.append(" and sp.departdate between :departdate and :enddate")
				.append(" and ss.scheduleplanid=sp.id and t.departdate between :departdate and :enddate ");
		if (selldate != null && !"".equals(selldate)) {
			sql.append(" and t.selltime between :selldate and :sellenddate");
		}
		if (orgid != null) {
			sql.append(" and sp.orgid in " + orgid);
		}
		if (sellorgid != null) {
			sql.append(" and t.orgid in " + sellorgid);
		}
		if (departstation != 0) {
			sql.append(" and t.departstationid=" + departstation);
		}
		if (routeid != 0) {
			sql.append(" and r.id=" + routeid);
		}
		if (stationid != 0) {
			sql.append(" and t.reachstationid=" + stationid);
		}
		if (scheduleid != 0) {
			sql.append(" and s.id=" + scheduleid);
		}
		sql.append(" group by t.departdate, r.name, s.code, st.name) a order by a.code ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		if (selldate != null && !"".equals(selldate)) {
			query.setParameter("selldate", selldate);
			query.setParameter("sellenddate", sellenddate);
		}
		query.setParameter("departdate", departdate);
		query.setParameter("enddate", enddate);
		return query.getResultList();
	}

	/**
	 * 用来查询售票数为0的班次
	 * 
	 * @param orgid
	 * @param departstation
	 * @param departdate
	 * @param routeid
	 * @param stationid
	 * @param scheduleid
	 * @param enddate
	 * @param unitid
	 * @param vehicletypeid
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> querySellnumIsEmpty(String orgid, long departstation,
			Date departdate, long routeid, long stationid, String schedulecode,
			Date enddate, long unitid, long vehicletypeid) {
		StringBuffer sql = new StringBuffer("");
		if (unitid == 0 && vehicletypeid == 0) {
			sql.append("select sp.departdate, trim(ss.departtime) departtime, ")
					.append(" st.name stationname, s.code, r.name routename, 0 totaleprice, 0 soldeatnum, 0 solddistance, ")
					.append(" sum(sp.seatnum) seatnum, sum(r.distance * sp.seatnum) seatdistance, '0' || '%' soldratio, ")
					.append(" '0' || '%' disratio, '' unitname, '' vehicletype, '0' balance, '' stationdetail ")
					.append(" from scheduleplan sp, schedule s, station st, route r, schedulestatus ss, organization org ")
					.append(" where sp.scheduleid = s.id and sp.endstationid = st.id and s.routeid = r.id ")
					.append(" and ss.scheduleplanid = sp.id and ss.isreported = 0 and sp.soldeatnum = 0 and sp.orgid = org.id ")
					.append(" and org.stationid = ss.departstationid and ss.departdate = sp.departdate ")
					.append(" and ss.departstationid = sp.startstationid and sp.departdate between :departdate and :enddate ");
			if (orgid != null) {
				sql.append(" and sp.orgid in " + orgid);
			}
			if (departstation != 0) {
				sql.append(" and sp.startstationid=" + departstation);
			}
			if (routeid != 0) {
				sql.append(" and r.id=" + routeid);
			}
			if (stationid != 0) {
				sql.append(" and sp.endstationid=" + stationid);
			}
			if (schedulecode != "" && schedulecode !=null) {
				sql.append(" and s.code like '%"+schedulecode+"%'");
			}
			sql.append(
					" group by sp.departdate, r.name, s.code, ss.departtime, st.name ")
					.append(" union ");
		}
		sql.append(
				" select sp.departdate, trim(ss.departtime) departtime, st.name stationname, s.code, r.name routename, ")
				.append(" 0 totaleprice, 0 soldeatnum, 0 solddistance, sum(sp.seatnum) seatnum, ")
				.append(" sum(r.distance * sp.seatnum) seatdistance, '0' || '%' soldratio, '0' || '%' disratio, ")
				.append(" u.name as unitname, vt.name as vehicletype, '0' balance, '' stationdetail ")
				.append(" from scheduleplan sp, schedule s, station st, route r, schedulestatus ss, ")
				.append(" vehiclereport vr, vehicle v, vehicletype vt, unit u, organization org ")
				.append(" where sp.scheduleid = s.id and sp.endstationid = st.id and vr.isactive = 1 and s.routeid = r.id ")
				.append(" and ss.scheduleplanid = sp.id and ss.isreported = 1 and sp.soldeatnum = 0 ")
				.append(" and sp.orgid = org.id and org.stationid = ss.departstationid and org.id = vr.reportorgid ")
				.append(" and ss.departdate = sp.departdate and vr.vehicleid = v.id and v.vehicletypeid = vt.id ")
				.append(" and v.unitid = u.id and vr.scheduleplanid = sp.id and ss.departstationid = sp.startstationid ")
				.append(" and sp.departdate between :departdate and :enddate and vr.departdate between :departdate and :enddate ");
		if (orgid != null) {
			sql.append(" and sp.orgid in " + orgid);
		}
		if (departstation != 0) {
			sql.append(" and sp.startstationid=" + departstation);
		}
		if (routeid != 0) {
			sql.append(" and r.id=" + routeid);
		}
		if (stationid != 0) {
			sql.append(" and sp.endstationid=" + stationid);
		}
		if (schedulecode != "" && schedulecode !=null) {
			sql.append(" and s.code like '%"+schedulecode+"%'");
		}
		if (unitid != 0) {
			sql.append(" and u.id=" + unitid);
		}
		if (vehicletypeid != 0) {
			sql.append(" and vt.id=" + vehicletypeid);
		}
		sql.append(" group by sp.departdate, r.name, s.code, ss.departtime, st.name, u.name, vt.name ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("enddate", enddate);
		return query.getResultList();
	}
	/**
	 * 根据发车日期、时间、车牌号或获取发班信息
	 * @param date
	 * @param time
	 * @param strDriverNumbers
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public List<Object> getDriverReportInfo(Date date, Date time, String vehicleno) {
		if(vehicleno!=null){
			vehicleno = URLDecoder.decode(vehicleno);
		}
		StringBuffer sql = new StringBuffer("");
		sql.append("   select s.code shceduleCode ,vp.id repordid,")
		.append("   nvl(d1.idcard,'')||','||nvl(d2.idcard,'')||','||nvl(d3.idcard,'') from")
		.append("  vehiclereport vp")
		.append("  left join driver d1 on vp.driver1id=d1.id")
		.append("  left join driver d2 on vp.driver2id=d2.id")
		.append("  left join driver d3 on vp.driver3id=d3.id")
		.append("  left join  schedule s on vp.scheduleid=s.id")
		.append("  left join vehicle v on vp.vehicleid=v.id")
		.append("  where  vp.isactive='1' and  v.vehicleno=:vehicleno ")
		.append("  and vp.departdate=:date " );
		if(time!=null){
			sql.append(" and vp.reporttime=:time");
		}
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("date", date);
		query.setParameter("vehicleno", vehicleno);
		if(time!=null){
			query.setParameter("time", time);
		}
		return query.getResultList();
	}
	/**
	 * 根据发班日期、报班id查询车辆检票信息
	 * @param date
	 * @param repordid
	 * @return
	 */
	public List<Object> getPassengerOfNumber(Date date, String repordid) {
		StringBuffer sql = new StringBuffer("");
		sql.append("select nvl(count(ts.ticketno),0) ticketNum,nvl(sum(ts.carrychildnum),0) childNum from vehiclereport vp,ticketsell ts where vp.id=ts.vehiclereportid ")
		.append("  and ts.ticketstatus='0' and vp.id=:id and ts.ischecked='1' and vp.departdate=:date");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("date", date);
		query.setParameter("id", repordid);
		return query.getResultList();
	}
}
