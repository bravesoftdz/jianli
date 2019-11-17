package cn.nova.bus.dispatch.dao;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.LockModeType;
import javax.persistence.Query;

import models.ActionNode;
import util.Appvar;
import util.CommonUtil;
import util.CurrentUtil;
import cn.nova.bus.balance.model.Vehicleviolation;
import cn.nova.bus.base.model.Cardissue;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.check.model.Securitycheck;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.model.Schedulecancel;
import cn.nova.bus.dispatch.model.Schedulemerge;
import cn.nova.bus.dispatch.model.Seatreserve;
import cn.nova.bus.dispatch.model.Vehiclelate;
import cn.nova.bus.dispatch.model.Vehiclelost;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.price.model.Handprice;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Schedulevehiclepeopleplan;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class DispatchServiceDao extends EntityManagerDaoSurport {

	private ParameterService parameterService = new ParameterServiceImpl();
	
	@SuppressWarnings("unchecked")
	public List<Object> qryRouteTree(long orgid) {
		//
		List<Object> list = new ArrayList<Object>();
		StringBuilder sql = new StringBuilder(
				"select DISTINCT d.name,SUBSTRING(d.code,1,2) as code,1 as arealevel,'0' as pcode")
				.append(" from Route r,Station s,District d")
				.append(" where r.endstationid=s.id and s.districtid=d.id and r.isactive=1")
				.append(" and r.orgid=:orgid and SUBSTRING(d.code,3,4)='0000'");
		Query query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		list = query.getResultList();

		sql = new StringBuilder(
				"select DISTINCT d.name,SUBSTRING(d.code,1,4) as code,2 as arealevel,SUBSTRING(d.code,1,2) as pcode")
				.append(" from Route r,Station s,District d")
				.append(" where r.endstationid=s.id and s.districtid=d.id")
				.append(" and r.orgid=:orgid and r.isactive=1")
				.append(" and SUBSTRING(d.code,5,2)='00' and SUBSTRING(d.code,3,4)!='0000'");
		query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		list.addAll(query.getResultList());

		sql = new StringBuilder(
				"select s.name,r.code,3 as arealevel,SUBSTRING(d.code,1,4) as pcode ")
				.append(" from Route r,Station s,District d")
				.append(" where r.endstationid=s.id and s.districtid=d.id")
				.append(" and r.orgid=:orgid and r.isactive=1");
		query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		list.addAll(query.getResultList());
		return list;
	}

	@SuppressWarnings("unchecked")
	public List<Object> qryStation(String orgids) {
		StringBuilder sql = new StringBuilder(
				"select s,o.id as orgid from Organization o,Station s").append(
				" where (o.type='1' or o.type='2') and o.isactive=1").append(
				" and o.station.id=s.id and o.id in " + orgids);
		Query query = em.createQuery(sql.toString());
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> qryCurOrg(String orgids) {
		StringBuilder sql = new StringBuilder("select o from Organization o")
				.append(" where (o.type='1' or o.type='2') and o.isactive=1")
				.append(" and o.islocal=1 and o.id in " + orgids);
		Query query = em.createQuery(sql.toString());
		return query.getResultList();
	}

	/**
	 * 查询本站该班次除某条报到记录外的报到记录，且按报到时间倒序
	 * @param scheduleplanid
	 * @param reportorgid
	 * @param reportId：报到id,若查该班次全部报到记录,reportId传0即可
	 */
	@SuppressWarnings("unchecked")
	public List<Vehiclereport> qryVehiclereport(long scheduleplanid, long reportorgid, long reportId) {
		StringBuilder sql = new StringBuilder("select vr ");
		sql.append(" from Vehiclereport vr");
		sql.append(" where vr.isactive = 1 ");
		sql.append("  and vr.scheduleplanid = :scheduleplanid ");
		sql.append("  and vr.reportorgid = :reportorgid ");
		sql.append("  and vr.id != :reportId ");
		sql.append(" order by vr.reporttime desc");
		
		Query query = em.createQuery(sql.toString(), Vehiclereport.class);
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("reportorgid", reportorgid);
		query.setParameter("reportId", reportId);
		
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> qryScheduleplan(
			List<PropertyFilter> propertyFilterList, String code) {
		/*
		 * StringBuilder sql = new StringBuilder(
		 * "select vr.id as reportid,sp.id,sp.orgid,sp.departdate,sp.scheduleid,s.code,sp.seatnum," ) .append(
		 * " sp.autocancelreserveseatnum,sp.unautocancelreserveseatnum,sp.fixedreserveseatnum," )
		 * .append(" sp.soldeatnum,sp.issellable,sp.startstationid,sp.endstationid," )
		 * .append(" sp.runtime,sp.distance,sp.highdistance,sp.worktype,") .append
		 * (" sp.workways,sp.districttype,sp.scheduletype,sp.isproprietary,") .append
		 * (" sp.isovertime,sp.issellreturnticket,sp.islinework,sp.endtime,") .append(
		 * " sp.spacinginterval,sp.isoriginator,sp.issaleafterreport,sp.iscanmixcheck," ) .append(
		 * " ss.departstationid,s1.name as departstation,s2.name as endstation," ) .append(
		 * " trim(ss.departtime) as departtime,ss.ticketentrance,ss.buspark,ss.isreported," )
		 * .append(" ss.isbegincheck,ss.isdeparted,ss.status,") .append(" vr.reporttime,vr.vehicleid,vh.vehicleno,")
		 * .append(" sv.planvehicleid,v.vehicleno as planvehicle, ") .append(
		 * " sv.planvehicletypeid,vt.name as planvehicletype,sv.planvehiclebrandmodelid," )
		 * .append(" sv.planunitid,u.name as planunit,") .append(" sv.plandriver1id,d1.name as plandriver1,")
		 * .append(" sv.plandriver2id,d2.name as plandriver2,") .append(" sv.plandriver3id,d3.name as plandriver3,")
		 * .append(" sv.plandriver4id,d4.name as plandriver4,") .append(" sv.plansteward1id,st1.name as plansteward1,")
		 * .append(" sv.plansteward2id,st2.name as plansteward2,sp.createtime,") .append(" r.name as routename,")
		 * .append(
		 * " (sp.seatnum-sp.autocancelreserveseatnum-sp.unautocancelreserveseatnum-sp.fixedreserveseatnum-sp.soldeatnum) as leaveseat,"
		 * ) .append(" ss.isemptyvehicle,ut.name as reportunit,")
		 * .append(" d11.name as reporddriver1,d12.name as reporddriver2,")
		 * .append(" d13.name as reporddriver3,d14.name as reporddriver4,")
		 * .append(" st11.name as reportsteward,uf.name as reportname")
		 * .append(" from Scheduleplan sp left join Vehiclereport vr ")
		 * .append(" left join userinfo uf on uf.id = vr.createby")
		 * .append(" left join vehicle vh on vh.id = vr.vehicleid") .append(" left join unit ut on ut.id=vh.unitid")
		 * .append(" left join driver d11 on vr.driver1id=d11.id")
		 * .append(" left join driver d12 on vr.driver2id=d12.id")
		 * .append(" left join driver d13 on vr.driver3id=d13.id")
		 * .append(" left join driver d14 on vr.driver4id=d14.id")
		 * .append(" left join steward st11 on vr.steward1id=st11.id") .append(
		 * " on sp.id = vr.scheduleplanid and vr.isactive=1,schedulestatus ss,") .append(
		 * " schedulevehiclepeopleplan sv left join vehicle v on sv.planvehicleid=v.id" )
		 * .append(" left join driver d1 on sv.plandriver1id=d1.id")
		 * .append(" left join driver d2 on sv.plandriver2id=d2.id")
		 * .append(" left join driver d3 on sv.plandriver3id=d3.id")
		 * .append(" left join driver d4 on sv.plandriver4id=d4.id")
		 * .append(" left join unit u on sv.planunitid = u.id")
		 * .append(" left join steward st1 on sv.plansteward1id=st1.id")
		 * .append(" left join steward st2 on sv.plansteward2id=st2.id,") .append(" organization o,schedule s,route r,")
		 * .append(" station s1,station s2,vehicletype vt")
		 * .append(" where sp.id = ss.scheduleplanid and sp.id = sv.scheduleplanid" ) .append(
		 * " and sv.orderno = 0 and sp.scheduleid=s.id and vt.id=sv.planvehicletypeid" )
		 * .append(" and ss.departstationid=s1.id and sp.endstationid=s2.id") .
		 * append(" and (vr.orderno=(select max(orderno) from vehiclereport tt " ) .append(
		 * " where tt.isactive=1 and tt.scheduleplanid=vr.scheduleplanid) or vr.id is null )" )
		 * .append(" and s1.id = o.stationid and o.stationid = ss.departstationid " ) .append(" and s.routeid=r.id");
		 */
		StringBuilder sql = new StringBuilder("");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		/*
		 * if (code != null && code.length() == 2) { sql.append(" and substr(s2.code,1,2)='" + code + "'"); } else if
		 * (code != null && code.length() == 4) { sql.append(" and substr(s2.code,1,4)='" + code + "'"); } else if (code
		 * != null) { sql.append(" and r.code='" + code + "'"); }
		 */

		sql.append(" order by ss.departtime,r.id");
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	// 修改后
	@SuppressWarnings("unchecked")
	public List<Object> qryScheduleplan2(
			List<PropertyFilter> propertyFilterList, long curstationid,
			Date departdate,long qrycurstationid) {
		String qrynum =parameterService.findParamByStation(ParamterConst.Param_2035, curstationid);
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
		String  begin=df.format(departdate);
		StringBuilder sql = new StringBuilder(
				"select decode(ss.departstationid,sp.startstationid,'始发班','配载班') schtype, vrr.reportorgid,vrr.id as reportid,")
				.append(" sp.id,sp.orgid,sp.departdate,sp.scheduleid,s.code,")
				.append(" sp.seatnum,sp.autocancelreserveseatnum,sp.unautocancelreserveseatnum,")
				.append(" sp.fixedreserveseatnum,sp.soldeatnum,sp.issellable,sp.startstationid,")
				.append(" sp.endstationid,sp.runtime,sp.distance,sp.highdistance,sp.worktype,")
				.append(" sp.workways,sp.districttype,sp.scheduletype,sp.isproprietary,sp.isovertime,")
				.append(" sp.issellreturnticket,sp.islinework,sp.endtime,sp.spacinginterval,")
				.append(" sp.isoriginator,sp.issaleafterreport,sp.iscanmixcheck,ss.departstationid,")
				.append(" s1.name as departstation,s2.name as endstation,trim(ss.departtime) as departtime,")
				.append(" ss.ticketentrance,ss.buspark,decode(vrr.id,null,ss.isreported,1),ss.isbegincheck,nvl(vrr.isdeparted,ss.isdeparted),")
				.append(" ss.status,vrr.reporttime,vrr.vehicleid,vrr.vehicleno,sv.planvehicleid,")
				.append(" v.vehicleno as planvehicle,sv.planvehicletypeid,vt.name as planvehicletype,")
				.append(" sv.planvehiclebrandmodelid,sv.planunitid,r.name as routename,")
				.append(" (sp.seatnum - sp.autocancelreserveseatnum -sp.unautocancelreserveseatnum - sp.fixedreserveseatnum -")
				.append(" sp.soldeatnum) as leaveseat,ss.isemptyvehicle,vrr.reportunit,vrr.reportname,")
				.append(" u1.name as planunit,")
				.append(" sv.plandriver1id,d1.name as plandriver1,sv.plandriver2id,d2.name as plandriver2,")
				.append(" sv.plandriver3id,d3.name as plandriver3,sv.plandriver4id,d4.name as plandriver4,sv.plansteward1id,st1.name as plansteward1,")
				.append(" sv.plansteward2id,st2.name as plansteward2,sp.remarks,ss.id as schedulestatusid,")
				.append(" vrr.reporddriver1,vrr.reporddriver2 ,vrr.reporddriver3,vrr.reporddriver4,vrr.rationseatnum,nvl(vrr.isreplace,0) isreplace, ")
				.append(" case when s.isneedfinger=1 then s.driverfingernum else 0 end,v.balanceunitid as balanceunitid,u2.name as balanceunitname, ")
				.append(" v.contractenddate,v.liabilityinsureenddate,v.compulsoryinsureenddate,v.licenseenddate,v.workenddate,v.roadno,vrr.stewardname")
				//增加驾驶员id、乘务员id
				.append(" , vrr.reporddriver1id, vrr.reporddriver2id, vrr.reporddriver3id, vrr.reporddriver4id, vrr.stewardid,vrr.driverquanpin ")  //驾驶员全拼  vrr.driverquanpin
				.append(" from Scheduleplan sp,(select vr.id,uf.name as reportname,vr.vehicleid,")
				.append(" vh.vehicleno,vr.reportorgid,vr.reporttime,vr.scheduleplanid,org.name ,")
				//增加驾驶员id、乘务员id
				.append(" vr.driver1id as reporddriver1id, vr.driver2id as reporddriver2id, vr.driver3id as reporddriver3id, vr.driver4id as reporddriver4id, vr.steward1id as stewardid, ")
				.append(" d1.name as reporddriver1,d2.name as reporddriver2,")
				.append(" d3.name as reporddriver3,d4.name as reporddriver4,vh.rationseatnum as rationseatnum,")
				.append(" un.name reportunit,vr.isdeparted,vr.isreplace,ste.name stewardname,d1.quanpin as driverquanpin from Vehiclereport vr, userinfo      uf,")  //驾驶员1全拼  d1.quanpin as driverquanpin
				.append(" vehicle  vh,organization  org,unit un,driver d1,driver d2,driver d3,driver d4,steward ste")
				.append(" where vr.createby = uf.id and vh.unitid = un.id and vr.vehicleid = vh.id")
				.append("  and org.stationid =" + curstationid);
//				+ " and vr.departdate=:departdate");
				sql.append(" and vr.departdate=to_date('"+begin+"','yyyymmdd') ");
			     if (qrynum.equals("1")) {
				  	sql.append("  and vr.orderno =(select max(orderno) from Vehiclereport t where t.scheduleplanid = vr.scheduleplanid) ");
			  	}
			    sql.append("  and vr.reportorgid = org.id and vr.isactive=1 and vr.driver1id=d1.id(+)")
//				sql.append("  and (vr.reportorgid = org.id or vr.orgid = org.id) and vr.isactive=1 and vr.driver1id=d1.id(+)")
				.append(" and vr.driver2id=d2.id(+) and vr.driver3id=d3.id(+) and vr.driver4id=d4.id(+) and vr.steward1id = ste.id(+)) vrr,")
				.append(" schedulestatus ss,schedulevehiclepeopleplan sv,")
				.append(" Schedule s,route r,station s1,station s2,vehicletype vt,")
				.append(" vehicle v,unit u1,driver d1,driver d2,driver d3,driver d4,steward st1,steward st2, unit u2")
				.append(" where sp.id = ss.scheduleplanid")
				.append(" and sp.id = sv.scheduleplanid")
				.append(" and sp.id = vrr.scheduleplanid(+)")
				.append(" and sv.orderno = 0 and sv.planunitid=u1.id(+)")
				.append("  and sv.planvehicleid = v.id(+)")
				.append("  and sp.scheduleid = s.id")
				.append(" and vt.id = sv.planvehicletypeid")
				.append(" and ss.departstationid = s1.id")
				.append(" and sp.endstationid = s2.id")
				.append(" and s.routeid = r.id")
				.append(" and sv.plandriver1id=d1.id(+) and sv.plandriver2id=d2.id(+)")
				.append(" and sv.plandriver3id=d3.id(+) and  sv.plandriver4id=d4.id(+)")
				.append("  and sv.plansteward1id=st1.id(+) and sv.plansteward2id=st2.id(+)")
				.append(" and v.balanceunitid = u2.id(+) ")
				.append(" and (ss.departstationid ="
						+ curstationid
						+ " or ((s.worktype='2' or s.worktype='3') and r.startstationid=ss.departstationid)) ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" and sp.departdate=to_date('"+begin+"','yyyymmdd') ");
		sql.append(" order by ss.departtime,r.id");
		Query query = em.createNativeQuery(sql.toString());
//		query.setParameter("departdate", departdate);
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> qryDriver(Long driverid) {
		StringBuilder sql = new StringBuilder(
		"select d.id,d.picture,d.drivinglicenseenddate,d.qualificationenddate,d.workenddate from Driver d")
		.append(" where d.id=:id and d.isactive=1");
		Query query = em.createQuery(sql.toString());
		query.setParameter("id", driverid);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> qryDriverbycardno(String cardno) {
		StringBuilder sql = new StringBuilder(
				"select d.id,d.name as drivername from Driver d ")
				.append(" LEFT JOIN Cardissue cd ON cd.type =1 and cd.typeid=d.id and status =0 ")
				.append(" where d.isactive=1 ");
		if (cardno != null) {
			sql.append(" and cd.cardno =" + cardno);
		}
		Query query = em.createNativeQuery(sql.toString());
		return query.getResultList();
	}

	// 根据站点ID获取对应的机构
	@SuppressWarnings("unchecked")
	public Organization getOrgInfo(long stationid) {
		StringBuilder sql = new StringBuilder("select d from Organization d")
				.append(" where d.station.id=:stationid and d.isactive=1");
		Query query = em.createQuery(sql.toString());
		query.setParameter("stationid", stationid);
		List<Organization> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	@SuppressWarnings("unchecked")
	public Schedulestatus getSchedulestatus(Long scheduleplanid,
			Long departstationid) {
		StringBuilder sql = new StringBuilder("select s from Schedulestatus s")
				.append(" where s.scheduleplan.id=:scheduleplanid and s.departstationid=:departstationid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("departstationid", departstationid);
		query.setLockMode(LockModeType.PESSIMISTIC_READ);
		List<Object> list = query.getResultList();
		return (list != null && list.size() > 0 ? (Schedulestatus) list.get(0)
				: null);
	}

	@SuppressWarnings("unchecked")
	public boolean isReproted(Long scheduleplanid, Long departstationid) {
		StringBuilder sql = new StringBuilder("select s from Schedulestatus s")
				.append(" where s.scheduleplan.id=:scheduleplanid and s.departstationid=:departstationid ")
				.append(" and s.isreported=1");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("departstationid", departstationid);
		query.setLockMode(LockModeType.PESSIMISTIC_READ);
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? true : false;
	}

	@SuppressWarnings("unchecked")
	public short getMaxOrderno(Vehiclereport vehiclereport) {
		StringBuilder sql = new StringBuilder(
				"select NVL(MAX(s.orderno),-1) from Vehiclereport s")
				.append(" where s.scheduleplanid=:scheduleplanid and s.reportorgid=:reportorgid and s.isactive=1");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", vehiclereport.getScheduleplanid());
		query.setParameter("reportorgid", vehiclereport.getReportorgid());
		List<Object> list = query.getResultList();
		return (Short) (list != null & list.size() > 0 ? list.get(0) : 0);
	}

	@SuppressWarnings("unchecked")
	public List<Schedulestatus> qrySchedulestatus(Long scheduleplanid,
			Long departstationid) {
		StringBuilder sql = new StringBuilder("select s from Schedulestatus s")
				.append(" where s.scheduleplan.id=:scheduleplanid and s.departstationid!=:departstationid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("departstationid", departstationid);
		query.setLockMode(LockModeType.PESSIMISTIC_READ);
		return query.getResultList();
	}

	public Organization getOrganization(long stationid) {
		StringBuilder sql = new StringBuilder("select o from Organization o")
				.append(" where (o.type='1' or o.type='2') and o.isactive=1")
				.append(" and o.station.id=:stationid ");
		Query query = em.createQuery(sql.toString());
		query.setParameter("stationid", stationid);
		List<Organization> orgs = query.getResultList();
		return orgs != null && orgs.size() > 0 ? orgs.get(0) : null;
	}

	@SuppressWarnings("unchecked")
	public Scheduleplan getScheduleplan(long orgid, Date departdate,
			long scheduleid) {
		StringBuilder sql = new StringBuilder("select s from Scheduleplan s")
				.append(" where s.orgid=:orgid and s.scheduleid=:scheduleid")
				.append(" and s.departdate=:departdate");
		Query query = em.createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("departdate", departdate);
		List<Scheduleplan> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	// 使用IC卡报班时取出最近的报到班次
	@SuppressWarnings("unchecked")
	public Scheduleplan getNewScheduleplan(long departstationid,
			Date departdate, long vehicleid) {
		StringBuilder sql = new StringBuilder("select s")
				.append("  from Scheduleplan s,Schedulevehiclepeopleplan sv, Schedulestatus ss")
				.append(" where s= sv.scheduleplan and s.departdate =:departdate")
				.append(" and s = ss.scheduleplan and sv.planvehicle.id =:planvehicleid")
				.append(" and ss.isreported =0 and ss.departstationid =:departstationid")
				.append(" order by ss.departtime");
		Query query = em.createQuery(sql.toString());
		query.setParameter("departstationid", departstationid);
		query.setParameter("planvehicleid", vehicleid);
		query.setParameter("departdate", departdate);
		List<Scheduleplan> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	@SuppressWarnings("unchecked")
	public List<Object> qrySchedulevehiclepeopleplan(Long scheduleid,
			Long departstationid, Date departdate) {
		StringBuilder sql = new StringBuilder(
				"select sp.id,sv.plandriver1id,sv.plandriver2id,sv.plandriver3id,")
				.append(" sv.plandriver4id,sv.plansteward1id,sp.islinework,sp.seatnum,sp.soldeatnum, ")
				.append(" sp.autocancelreserveseatnum,sp.unautocancelreserveseatnum,sp.fixedreserveseatnum,")
				.append(" (sp.seatnum-sp.autocancelreserveseatnum-sp.unautocancelreserveseatnum-sp.fixedreserveseatnum-sp.soldeatnum) as leaveseat,")
				.append(" trim(ss.departtime) as departtime,")
				.append(" sv.planvehicletypeid,sv.planvehicleid,sv.orderno,")
				.append(" v.vehicleno,vt.name as vehicletypename,u.name as unitname,")
				.append(" s.code,d1.name as driver1,d2.name as driver2, ")
				.append(" d3.name as driver3,d4.name as driver4,sw1.name as stwname1, ")
				.append(" v.seatnum as vehicleseatnum,st.name as endstation,r.name as routename,")
				.append(" sv.planunitid,case when s.isneedfinger=1 then s.driverfingernum else 0 end")
				.append(" from Scheduleplan sp,Schedulestatus ss,Schedulevehiclepeopleplan sv ")
				.append(" LEFT JOIN vehicle v on sv.planvehicleid=v.id")
				.append(" LEFT JOIN driver d1 on sv.plandriver1id=d1.id")
				.append(" LEFT JOIN driver d2 on sv.plandriver2id=d2.id")
				.append(" LEFT JOIN driver d3 on sv.plandriver3id=d3.id")
				.append(" LEFT JOIN unit   u  on sv.planunitid = u.id")
				.append(" LEFT JOIN driver d4 on sv.plandriver4id=d4.id")
				.append(" LEFT JOIN steward sw1 on sv.plansteward1id=sw1.id,")
				.append(" Vehicletype vt,Schedule s,Route r,Station st")
				.append(" where sp.id=ss.scheduleplanid and sp.scheduleid=ss.scheduleid")
				.append(" and ss.scheduleplanid=sv.scheduleplanid and ss.scheduleid=sv.scheduleid")
				.append(" and sv.scheduleid=s.id and sv.planvehicletypeid=vt.id")
				.append(" and sv.scheduleid=s.id and sv.orderno not in (select orderno from vehiclereport vr where vr.scheduleplanid=sp.id  and vr.isactive=1)")
				.append(" and s.routeid=r.id and r.endstationid=st.id")
				.append(" and r.isactive=1  and sp.departdate=:departdate")
				.append(" and ss.departstationid=:departstationid and sv.scheduleid=:scheduleid")
				.append(" and sv.departdate=:departdate order by sv.orderno");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("departstationid", departstationid);
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("departdate", departdate);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> qryVehiclereport(Vehiclereport vehiclereport) {
		StringBuilder sql = new StringBuilder("select vr,v.vehicleno,")
				.append("  s.code,d1.name as driver1,d2.name as driver2, ")
				.append("  d3.name as driver3,d4.name as driver4,sw1.name as stwname1, ")
				.append("  v.seatnum from ")
				.append(" Vehiclereport vr LEFT JOIN vr.driver1 d1 LEFT JOIN vr.driver2 d2")
				.append(" LEFT JOIN vr.driver3 d3 LEFT JOIN vr.driver4 d4")
				.append(" LEFT JOIN vr.steward1 sw1 ,")
				.append(" Vehicle v,Schedule s")
				.append(" where vr.vehicleid=v.id and vr.scheduleid=s.id")
				.append(" and vr.isactive=1")
				.append(" and vr.reportorgid=:reportorgid and vr.scheduleid=:scheduleid")
				.append(" and vr.departdate=:departdate order by vr.orderno");
		Query query = em.createQuery(sql.toString());
		query.setParameter("reportorgid", vehiclereport.getReportorgid());
		query.setParameter("scheduleid", vehiclereport.getScheduleid());
		query.setParameter("departdate", vehiclereport.getDepartdate());
		return query.getResultList();
	}

	// 查询已经报到但未发班的报到记录
	@SuppressWarnings("unchecked")
	public List<Vehiclereport> getVehiclereport(Scheduleplan scheduleplan,
			long reportorgid, long vehiclereportid) {
		StringBuilder sql = new StringBuilder("select vr")
				.append(" from Vehiclereport vr")
				.append(" where vr.isactive=1 and vr.isdeparted=0 ")
				.append(" and vr.scheduleplanid=:scheduleplanid ")
				.append(" and vr.reportorgid=:reportorgid")
				.append(" and vr.id!=:vehiclereportid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplan.getId());
		query.setParameter("reportorgid", reportorgid);
		query.setParameter("vehiclereportid", vehiclereportid);
		List<Vehiclereport> list = query.getResultList();
		return list;
	}

	// 查询当前车站是否已有该班次报到记录,
	@SuppressWarnings("unchecked")
	public boolean isVehiclereport(long scheduleplanid, long reportorgid,
			long vehiclereportid) {
		StringBuilder sql = new StringBuilder("select vr")
				.append(" from Vehiclereport vr")
				.append(" where vr.isactive=1 ")
				.append(" and vr.scheduleplanid=:scheduleplanid ")
				.append(" and vr.reportorgid=:reportorgid")
				.append(" and vr.id!=:vehiclereportid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("reportorgid", reportorgid);
		query.setParameter("vehiclereportid", vehiclereportid);
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? true : false;
	}

	// 查询当前车站已经报到的最大序号,
	@SuppressWarnings("unchecked")
	public short qryVehiclereport(long scheduleplanid, long reportorgid) {
		StringBuilder sql = new StringBuilder("select max(vr.orderno)")
				.append(" from Vehiclereport vr")
				.append(" where vr.isactive=1 ")
				.append(" and vr.scheduleplanid=:scheduleplanid ")
				.append(" and vr.reportorgid=:reportorgid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("reportorgid", reportorgid);
		List<Object> list = query.getResultList();
		return (Short) (list != null && list.size() > 0 ? list.get(0) : -1);
	}

	public Schedulestatus getSchedulestatus(Long departstationid,
			Long scheduleid, Date departDate) {
		StringBuilder sql = new StringBuilder("select s from Schedulestatus s")
				.append(" where s.scheduleid=:scheduleid and s.departstationid=:departstationid")
				.append(" and s.departdate=:departDate");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("departstationid", departstationid);
		query.setParameter("departDate", departDate);
		return (Schedulestatus) query.getSingleResult();
	}

	public Vehiclereport getVehiclereport(Long vehiclereportid) {
		StringBuilder sql = new StringBuilder("select s from Vehiclereport s")
				.append(" where s.id=:id");
		Query query = em.createQuery(sql.toString());
		query.setParameter("id", vehiclereportid);
		query.setLockMode(LockModeType.PESSIMISTIC_READ);
		return (Vehiclereport) query.getSingleResult();
	}

	// 判断流水班的报到车辆是否发班

	/*
	 * public boolean isDepartSchedule(Long vehiclereportid) { StringBuilder sql = new
	 * StringBuilder("select s from Departinvoice s") .append(" where s.reportid=:reportid and s.status='0'"); Query
	 * query = em.createQuery(sql.toString()); query.setParameter("reportid", vehiclereportid); List<Object> list =
	 * query.getResultList(); return list != null && list.size() > 0 ? true : false; }
	 */
	// 判断该班次是否已经有已检车票
	@SuppressWarnings("unchecked")
	public boolean isCheckTicket(Long vehiclereportid, long scheduleplanid) {
		StringBuilder sql = new StringBuilder("select s from Ticketsell s")
				.append(" where s.vehiclereport.id=:vehiclereportid and s.ischecked=1")
				.append(" and s.scheduleplanid=:scheduleplanid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("vehiclereportid", vehiclereportid);
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? true : false;
	}

	@SuppressWarnings("unchecked")
	public Vehiclelate getVehiclelate(Long reportid) {
		StringBuilder sql = new StringBuilder("select s from Vehiclelate s")
				.append(" where s.reportid=:reportid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("reportid", reportid);
		List<Object> list = query.getResultList();
		return (Vehiclelate) (list != null && list.size() > 0 ? list.get(0)
				: null);
	}

	@SuppressWarnings("unchecked")
	public Vehiclelost getVehiclelost(Long scheduleplanid, Long orgid) {
		StringBuilder sql = new StringBuilder("select s from Vehiclelost s")
				.append(" where s.scheduleplanid=:scheduleplanid and s.orgid=:orgid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("orgid", orgid);
		List<Object> list = query.getResultList();
		return (Vehiclelost) (list != null && list.size() > 0 ? list.get(0)
				: null);
	}

	@SuppressWarnings("unchecked")
	public long getTicketsellCount(Long scheduleplanid, Long departstationid) {
		StringBuilder sql = new StringBuilder(
				"select count(s) from Ticketsell s")
				.append(" where s.scheduleplanid=:scheduleplanid and s.departstationid=:departstationid")
				.append(" and s.ticketstatus='0'");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("departstationid", departstationid);
		List<Object> list = query.getResultList();
		return (Long) (list != null && list.size() > 0 ? list.get(0) : 0);
	}

	public Vehicle getVehicle(String cardno) {
		StringBuilder sql = new StringBuilder("select v ").append(
				" from Vehicle v").append(
				" where v.cardno=:cardno and v.isactive=1");
		Query query = em.createQuery(sql.toString());
		query.setParameter("cardno", cardno);
		List list = query.getResultList();
		return (Vehicle) (list != null && list.size() > 0 ? list.get(0) : null);
	}

	public Cardissue getCardissue(String cardno) {
		StringBuilder sql = new StringBuilder(
				"select c from Cardissue c where c.cardno=:cardno and c.type=0");
		Query query = em.createQuery(sql.toString());
		query.setParameter("cardno", cardno);
		List list = query.getResultList();
		return (Cardissue) (list != null && list.size() > 0 ? list.get(0)
				: null);
	}

	@SuppressWarnings("unchecked")
	public List<Object> qryVehicle(String cardno) {
		StringBuilder sql = new StringBuilder("select v.id,")
				.append(" v.vehicleno,v.seatnum,v.unitid,u.name as unitname,v.balanceunitid as balanceunitid,u1.name as balanceunitname,")
				.append(" v.vehicletypeid,vt.name as vehicletypename,v.isneedfinger, ")
				.append(" to_char(v.licenseenddate,'yyyy-MM-dd'),to_char(v.liabilityinsureenddate,'yyyy-MM-dd'),")
				.append(" to_char(v.workenddate,'yyyy-MM-dd'),v.roadno,to_char(v.compulsoryinsureenddate,'yyyy-MM-dd'),")
				.append(" to_char(v.contractenddate,'yyyy-MM-dd')")
				.append(" from Vehicle v, Unit u,Unit u1, Vehicletype vt")
				.append(" where v.unitid = u.id and v.vehicletypeid = vt.id")
				.append(" and v.balanceunitid=u1.id ")
				.append(" and v.cardno =:cardno and v.isactive=1 and v.status='0'");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("cardno", cardno);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> qryVehicleByCard(String cardno, String serialnumber) {
		//查询未报班的计划车辆所在班次
		StringBuilder sql = new StringBuilder(
				"select v.id,s.routeid,v.vehicleno,v.seatnum,v.isneedfinger,s.id scheduleid ")
				.append(" from Schedulevehiclepeopleplan svp,schedule s,")
				.append(" Vehicle v,schedulestatus ss")
				.append(" where s.id = svp.scheduleid and v.id = svp.planvehicleid")
				.append(" and svp.scheduleplanid = ss.scheduleplanid")   //s.islinework = 0流水班也可以被选择报班
				.append(" and ss.isreported = 0 and v.cardno =:cardno and v.isactive = 1")
				.append(" and v.status = '0' and svp.departdate = trunc(sysdate)  order by trim(ss.departtime)");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("cardno", cardno);
		//query.setParameter("serialnumber", serialnumber);
		List<Object> list = query.getResultList();
		if (list == null || list.size() == 0) {
			sql = new StringBuilder(
					"select v.id,v.routeid,v.vehicleno,v.seatnum,v.isneedfinger,0 as scheduleid ")
					.append(" from Vehicle v")
					.append(" where v.cardno =:cardno and v.isactive=1 and v.status='0'");
			query = em.createNativeQuery(sql.toString());
			query.setParameter("cardno", cardno);
			list = query.getResultList();
		}
		return list;
	}

	@SuppressWarnings("unchecked")
	public List<Object> qryVehicleById(long vehicleid) {
		//查询未报班的计划车辆所在班次 
		StringBuilder sql = new StringBuilder(
				"select v.id,s.routeid,v.vehicleno,v.seatnum,v.isneedfinger,s.id scheduleid ")
				.append(" from Schedulevehiclepeopleplan svp,schedule s,")
				.append(" Vehicle v,schedulestatus ss")
				.append(" where s.id = svp.scheduleid and v.id = svp.planvehicleid")
				.append(" and svp.scheduleplanid = ss.scheduleplanid")//and s.islinework = 0 
				.append(" and ss.isreported = 0 and v.id =:vehicleid and v.isactive = 1")
				.append(" and v.status = '0' and svp.departdate = trunc(sysdate)  order by trim(ss.departtime)");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("vehicleid", vehicleid);
		List<Object> list = query.getResultList();
		if (list == null || list.size() == 0) {
			sql = new StringBuilder(
					"select v.id,v.routeid,v.vehicleno,v.seatnum,v.isneedfinger,0 as scheduleid ").append(
					" from Vehicle v").append(
					" where v.id =:vehicleid and v.isactive=1");
			query = em.createNativeQuery(sql.toString());
			query.setParameter("vehicleid", vehicleid);
			list = query.getResultList();
		}
		return list;
		
	}

	@SuppressWarnings("unchecked")
	public boolean isExistScheduleplan(Date departdate, long departstationid,
			String cardno) {
		StringBuilder sql = new StringBuilder("select count(p)")
				.append(" from Scheduleplan p,Schedulestatus ss,")
				.append(" Schedule s,Route r,Vehicle v")
				.append(" where p.scheduleid=s.id and s.route.id=r.id")
				.append(" and p.id=ss.scheduleplan.id and ss.isreported=0")
				.append(" and p.departdate=:departdate and ss.status in ('0','2')")
				.append(" and v.route.id=r.id and v.cardno=:cardno")
				.append(" and ss.departstationid=:departstationid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("departstationid", departstationid);
		query.setParameter("cardno", cardno);
		List<Object> list = query.getResultList();
		long record = (Long) list.get(0);
		return record > 0 ? true : false;
	}

	// IC卡报到时查询运行计划信息
	@SuppressWarnings("unchecked")
	public List<Object> qryScheduleplan(List<PropertyFilter> propertyFilterList,long vehicleid,boolean isautodispatch) {
		StringBuilder sql = new StringBuilder()
				.append(" select   id,endstationid,endstationname,code,departtime,seatnum, soldeatnum,scheduleid,departdate,distance,")
				.append(" driverfingernum, plandriver1id,plandriver2id,plansteward1id,unitname,vehicleseat from ( ")
				.append(" select distinct p.id,")
				.append(" r.endstationid,st.name as endstationname,")
				.append(" s.code,trim(ss.departtime) as departtime,p.seatnum,")
				.append(" p.soldeatnum,p.scheduleid,p.departdate,r.distance,s.driverfingernum, ")
				.append(" svp.plandriver1id,svp.plandriver2id,svp.plansteward1id,u.name unitname,v.seatnum vehicleseat")
				.append(" from Scheduleplan p,Schedulestatus ss,")
				.append(" Schedule s,Route r, Station st,Schedulevehiclepeopleplan svp,unit u,vehicle v")
				.append(" where p.scheduleid=s.id and s.routeid=r.id and u.id=v.unitid and v.id=svp.planvehicleid")
				.append(" and p.id=ss.scheduleplanid and  ((p.islinework=0 and ss.isreported = 0) or (p.islinework=1))")
				.append(" and ss.status in ('0','2','5') ")
				.append(" and p.id=svp.scheduleplanid")
				.append(" and r.endstationid = st.id  and svp.planvehicleid="+vehicleid);
		//按未报到班次的时间排序，取第一个
//				.append(" and ss.departtime>to_char(sysdate,'hh24:mi') ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(") order by departtime");
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		
		List<Object> list = query.getResultList();
		//如果是自动报班，只取按时间排序未报到的第一个，否则 走原逻辑
		if(isautodispatch&&list!=null&&list.size()>1){
			Object o = list.get(0);
			list.clear();
			list.add(o);
		}
		return list;
	}
	//车辆可营运线路\班次
	@SuppressWarnings("unchecked")
	public List<Object> qryScheduleplanWithRouteconctrl(List<PropertyFilter> propertyFilterList,Long id,boolean isautodispatch) {
		
		if (propertyFilterList != null && propertyFilterList.size() > 0) {
			for (int t = 0; t < propertyFilterList.size(); t++) {
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("r!id")) {
					propertyFilterList.remove(t);
			  }
		  }
	   }
		
		StringBuilder sql = new StringBuilder("select p.id,")
				.append(" r.endstationid,st.name as endstationname,")
				.append(" s.code,trim(ss.departtime) as departtime,p.seatnum,")
				.append(" p.soldeatnum,p.scheduleid,p.departdate,r.distance,s.driverfingernum, ")
				.append(" svp.plandriver1id,svp.plandriver2id,svp.plansteward1id,u.name unitname,v.seatnum vehicleseat")
				.append(" from Scheduleplan p,Schedulestatus ss,")
				.append(" Schedule s,Route r, Station st,Schedulevehiclepeopleplan svp")
				.append(" ,Vehiclerouteconctrl      vrc,unit u,vehicle v ")
				.append(" where p.scheduleid=s.id and s.routeid=r.id")
				.append(" and p.id=ss.scheduleplanid and  ((p.islinework=0 and ss.isreported = 0) or (p.islinework=1 and svp.orderno=0))")
				.append(" and ss.status in ('0','2','5')")
				.append(" and p.id=svp.scheduleplanid")
				.append(" and r.endstationid = st.id and vrc.vehicleid=v.id and u.id=v.unitid")
				.append("  and vrc.routeid = s.routeid ")
				.append("  and vrc.vehicleid = "+id);
		if(isautodispatch){
			sql.append(" and ss.departtime>to_char(sysdate,'hh24:mi') ");
		}
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by ss.departtime");
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		List<Object> list = query.getResultList();
		//如果是自动报班 只取最近未报班的第一条数据，进行自动报班，否则原逻辑
		if(isautodispatch&&list!=null&&list.size()>1){
			Object o = list.get(0);
			list.clear();
			list.add(o);
		}
		return list;
	}
	/**
	 * 车辆管理中的车辆营运线路
	 * @param propertyFilterList
	 * @param id
	 * @return
	 */
	public List<Object> qryScheduleplanWithPlanvehicle(List<PropertyFilter> propertyFilterList,Long id,boolean isautodispatch) {
		
		boolean flag = true;//是否输入终点查询
		if (propertyFilterList != null && propertyFilterList.size() > 0) {
			for (int t = 0; t < propertyFilterList.size(); t++) {
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("r!id")) {
					propertyFilterList.remove(t);
			    }
				if (propertyFilterList.get(t).getPropertyFullName()
						.equals("r!endstationid")) {
					flag = false;
			    }
		  }
	   }		
		StringBuilder sql = new StringBuilder("select p.id,")
				.append(" r.endstationid,st.name as endstationname,")
				.append(" s.code,trim(ss.departtime) as departtime,p.seatnum,")
				.append(" p.soldeatnum,p.scheduleid,p.departdate,r.distance,s.driverfingernum, ")
				.append(" svp.plandriver1id,svp.plandriver2id,svp.plansteward1id,u.name unitname,v.seatnum vehicleseat")
				.append(" from Scheduleplan p,Schedulestatus ss,")
				.append(" Schedule s,Route r, Station st,Schedulevehiclepeopleplan svp, vehicle v,unit u")
				.append(" where p.scheduleid=s.id and s.routeid=r.id")
				.append(" and p.id=ss.scheduleplanid and  ((p.islinework=0 and ss.isreported = 0) or (p.islinework=1 and svp.orderno=0))")
				.append(" and ss.status in ('0','2','5')")
				.append(" and p.id=svp.scheduleplanid and u.id=v.unitid")
				.append(" and r.endstationid = st.id")
				.append("  and v.id= "+id );
		if(flag){//如果有终点，则去掉此条件
			sql.append(" and r.id=v.routeid ");
		}
		if(isautodispatch){
			sql.append(" and ss.departtime>to_char(sysdate,'hh24:mi') ");
		}
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by ss.departtime");
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		//只取最近未报班的第一条数据，进行自动报班
		List<Object> list = query.getResultList();
		if(isautodispatch&&list!=null&&list.size()>1){
			Object o = list.get(0);
			list.clear();
			list.add(o);
		}
		if(!isautodispatch&&list.size()==0){
			 sql = new StringBuilder("select p.id,")
				.append(" r.endstationid,st.name as endstationname,")
				.append(" s.code,trim(ss.departtime) as departtime,p.seatnum,")
				.append(" p.soldeatnum,p.scheduleid,p.departdate,r.distance,s.driverfingernum, ")
				.append(" svp.plandriver1id,svp.plandriver2id,svp.plansteward1id,'' as unitname,0 as vehicleseat")
				.append(" from Scheduleplan p,Schedulestatus ss,")
				.append(" Schedule s,Route r, Station st,Schedulevehiclepeopleplan svp")
				.append(" where p.scheduleid=s.id and s.routeid=r.id")
				.append(" and p.id=ss.scheduleplanid and  ((p.islinework=0 and ss.isreported = 0) or (p.islinework=1 and svp.orderno=0))")
				.append(" and ss.status in ('0','2','5')")
				.append(" and p.id=svp.scheduleplanid ")
				.append(" and r.endstationid = st.id ")
				.append(" and p.departdate=svp.departdate");
				sql.append(PropertyFilter.toJpql(propertyFilterList, true));
			    query = em.createNativeQuery(sql.toString());
				JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
				list = query.getResultList();
		}
		
		return list;
	}
	
	@SuppressWarnings("unchecked")
	public Scheduleplan qryScheduleplan(long scheduleid, Date departdate) {
		StringBuilder sql = new StringBuilder("select s from Scheduleplan s")
				.append(" where s.scheduleid=:scheduleid and s.departdate=:departdate");
//		Query query = em.createQuery(sql.toString());
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("departdate", departdate);
		List<Scheduleplan> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	@SuppressWarnings("unchecked")
	public Vehiclelost qryVehiclelost(long scheduleplanid) {
		StringBuilder sql = new StringBuilder("select s from Vehiclelost s")
				.append(" where s.scheduleplanid=:scheduleplanid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		List<Vehiclelost> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	@SuppressWarnings("unchecked")
	public List<Vehiclereport> qryVehiclereport(long scheduleplanid) {
		StringBuilder sql = new StringBuilder("select s from Vehiclereport s")
				.append(" where s.scheduleplanid=:scheduleplanid").append(
						" and s.isdeparted=0 and s.isactive=1");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		List<Vehiclereport> list = query.getResultList();
		return list;
	}
	@SuppressWarnings("unchecked")
	public boolean isExistScheduleseats(long scheduleplanid,short seatno) {
		StringBuilder sql = new StringBuilder("select s from Scheduleseats s")
				.append(" where s.scheduleplan.id=:scheduleplanid").append(
						" and s.seatno=:seatno");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("seatno", seatno);		
		List<Scheduleseats> list = query.getResultList();
		return list!=null&&list.size()>0?true:false;
	}
	/**
	 * 车辆运行计划查询
	 * 
	 * @param vehicleid
	 * @param departdate
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> qryVehicleRunplan(Long vehicleid, Date departdate) {
		/*
		 * StringBuffer sql = new StringBuffer( "select to_char(v.departdate, 'DD') day,")
		 * .append(" trim(to_char(wm_concat(st.name || sp.departtime))) result " ) .append(
		 * " from vehiclereport v, schedulestatus sp, schedule sc, route r, station st " ) .append(
		 * " where v.scheduleplanid=sp.scheduleplanid and sp.scheduleid=sc.id and " ) .append(
		 * " sc.routeid=r.id and r.endstationid=st.id and v.vehicleid=:vehicleid " )
		 * .append(" and v.departdate between TRUNC(:departdate, 'MONTH') and ")
		 * .append(" LAST_DAY(Trunc(:departdate, 'MONTH')) + 1 - 1 / 86400 ") .append(" group by v.departdate "); Query
		 * query = getEntityManager().createNativeQuery(sql.toString()); query.setParameter("vehicleid", vehicleid);
		 * query.setParameter("departdate", departdate); List<Object> list = query.getResultList();
		 */

		StringBuffer sql = new StringBuffer(
				"select to_char(sp.departdate, 'DD') day, sp.name||sp.departtime name")
				.append(" from (select sp.departdate, st.name, sp.departtime")
				.append(" from vehiclereport  v,schedulestatus sp,schedule sc,")
				.append("  route          r,station        st")
				.append(" where v.scheduleplanid = sp.scheduleplanid and sp.scheduleid = sc.id")
				.append("  and sc.routeid = r.id and v.isactive = 1 and r.endstationid = st.id")
				.append(" and v.vehicleid = :vehicleid and v.departdate between TRUNC(:departdate, 'MONTH') and")
				.append(" LAST_DAY(Trunc(:departdate, 'MONTH')) + 1 - 1 / 86400")
				.append(" union all")
				.append(" select sp.departdate, st.name, sp.departtime")
				.append(" from schedulevehiclepeopleplan v,schedulestatus sp,")
				.append(" schedule sc,route  r,station st")
				.append(" where v.scheduleplanid = sp.scheduleplanid and sp.scheduleid = sc.id")
				.append(" and sc.routeid = r.id  and r.endstationid = st.id")
				.append(" and v.planvehicleid = :vehicleid and sp.isreported = 0")
				.append(" and v.departdate between TRUNC(:departdate, 'MONTH') and")
				.append(" LAST_DAY(Trunc(:departdate, 'MONTH')) + 1 - 1 / 86400) sp")
				.append(" order by sp.departdate, sp.departtime ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("vehicleid", vehicleid);
		query.setParameter("departdate", departdate);
		List<Object> list = query.getResultList();
		return list;
	}
	//IC卡报班同线路间隔时间限制判断
	public List<Object> qryRouteReportInterval(long scheduleid) {
		StringBuffer sql = new StringBuffer();
		sql.append(" select max(v.reporttime) ")
		.append(" from vehiclereport v ")
		.append(" left join schedule s on s.id=v.scheduleid ")
		.append(" inner join route r on r.id=s.routeid ")
		.append(" where v.isactive='1' ")
		.append(" and r.id in ( ")
		.append(" select r.id from schedule s ")
		.append(" left join route r on s.routeid=r.id ")
		.append(" where s.id= :scheduleid) ");
		//System.out.println("IC卡报班同线路间隔时间限制判断  sql  -->  "+sql.toString());
		//查询
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		List<Object> list =  query.getResultList();
		return list;
	}
	//IC卡报班同线路间隔时间限制判断获取线路报班时间间隔reportinterval
	public List<Object> qryRouteReportIntervalValue(long driverid) {
		StringBuffer sql =  new StringBuffer();
		sql.append(" select r.reportinterval from schedule s ")
		.append(" inner join route r on s.routeid=r.id ")
		.append(" where s.id= :scheduleid ");
		//查询
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("scheduleid", driverid);
		List<Object> list = query.getResultList();
		return list;
	}
	//IC卡报班同驾驶员间隔时间限制判断
	public List<Object> qryDriverReportInterval(long driverid) {
		StringBuffer sql = new StringBuffer();
		sql.append(" select max(t.reporttime) ")
		.append(" from Vehiclereport t, Driver d ")
		.append(" where (t.driver1id=d.id or t.driver2id=d.id or t.driver3id=d.id or t.driver4id=d.id) ")
		.append(" and trunc(t.reporttime)= to_date(to_char(sysdate,'yyyy-mm-dd'),'yyyy-mm-dd' ) ")
		.append(" and d.id=:driverid ")
		.append(" and t.isactive=1");//在已报到的条件下计算最近报班时间
		//System.out.println("IC卡报班同驾驶员间隔时间限制判断  sql  -->  "+sql.toString());
		//查询
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("driverid", driverid);
		List<Object> list =  query.getResultList();
		return list;
	}

	/**
	 * 查询被并班次座位信息  李电志 2015年6月17日 17:26:18
	 * @param oldSchulePlanId
	 * @param oldSeat
	 * @return
	 */
	public List<Scheduleseats> qryScheduleseats(long oldSchulePlanId,
			String oldSeat) {
		StringBuffer sql = new StringBuffer()
				.append("select ss from Scheduleseats ss ")
				.append(" where ss.scheduleplan.id = :oldSchulePlanId ")
				.append(" and ss.seatno in ("+oldSeat+")")
				.append(" and ss.seatno not in")
				.append(" (select t.seatno")
				.append(" from Ticketsell t")
				.append(" where t.ticketstatus in ('0', '4')")
				.append(" and t.scheduleplanid = :oldSchulePlanId)")
				.append(" union all")
				.append(" select t.seatno")
				.append(" from Remoteticketsell t")
				.append(" where t.ticketstatus in ('0', '4')")
				.append(" and t.scheduleplanid = :oldSchulePlanId")
				.append(" union all")
				.append(" select t.seatno")
				.append(" from Seatreserve t")
				.append(" where t.sellstate = 'R'")
				.append(" and t.scheduleplanid = :oldSchulePlanId")
				.append(" order by  ss.seatno ")
				;
		Query query = em.createQuery(sql.toString());
		query.setParameter("oldSchulePlanId", oldSchulePlanId);
//		query.setParameter("oldSeat", oldSeat);
		List<Scheduleseats> list = query.getResultList();
		return list;
	}

	/**
	 * 查询并入班次的座位信息(被并班次中并入过来的座位) 李电志  2015年6月17日 19:54:58
	 * @param newSchuleId
	 * @param newSeat
	 * @return
	 */
	public List<Scheduleseats> qryScheduleseatsIn(long newSchuleId,
			String newSeat) {
		StringBuffer sql = new StringBuffer();
		sql.append("select ss ")
		.append(" from Scheduleseats ss ")
		.append(" where ss.scheduleplan.id = :newSchuleId ")
		.append(" and ss.seatno in ("+newSeat+") ");
		
		Query query = em.createQuery(sql.toString());
		query.setParameter("newSchuleId", newSchuleId);
		List<Scheduleseats> list = query.getResultList();
		return list;
	}

	/**
	 * 查询车票信息   李电志   2015年6月18日 20:47:13
	 * @param oldscheduleplanid  班次计划id
	 * @param Seats 座位号
	 * @return
	 */
	public List<Ticketsell> getTicketsells(Long oldscheduleplanid, String Seats) {
		//select * from ticketsell ts where ts.scheduleplanid = 4833;
		String sql = "select ts from Ticketsell ts where ts.scheduleplanid =" + oldscheduleplanid + " and ts.seatno in ("+Seats+") and ts.ticketstatus = '0' ";
		Query query = em.createQuery(sql);
		List<Ticketsell> list = query.getResultList();
		return list;
	}

	/**
	 * 查询被并班次的所有被并信息  李电志  2015年6月19日 16:37:45
	 * @param oldscheduleplanid 被并班次计划id
	 * @return
	 */
	public List<Schedulemerge> qryLastSchedulemergeNewAll(long oldscheduleplanid) {
		String sql = "select s from Schedulemerge s where s.oldscheduleplanid = :oldscheduleplanid and s.iscancel = 0  and s.isactive = 1 order by s.createtime desc ";
		Query query = em.createQuery(sql.toString());
		query.setParameter("oldscheduleplanid", oldscheduleplanid);
		List<Schedulemerge> list = query.getResultList();
		return list;
	}

	public List<Long> getScheduleStatus(long oldSchulePlanId) {
		String sql = "select ss.id from Schedulestatus ss where ss.scheduleplan.id = " + oldSchulePlanId;
		Query query = getEntityManager().createQuery(sql.toString());
		List<Long> list = query.getResultList();
		return list;
	}

	public Securitycheck querySecuritycheck(long vehicleid, Date departdate) {
		java.text.SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.text.SimpleDateFormat sf2=new SimpleDateFormat("yyyy-MM-dd");		
		Date fromdate=departdate;
		Date enddate=departdate;		
		try {
			fromdate=sf.parse(sf2.format(departdate)+" 00:00:00");
			enddate=sf.parse(sf2.format(departdate)+" 23:59:59");			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		StringBuilder sql = new StringBuilder(
				"select t from Securitycheck t where t.checktime between :fromdate ")
		.append(" and :enddate and  t.result<>'1' and t.vehicleid=:vehicleid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("vehicleid", vehicleid);
		query.setParameter("fromdate", fromdate);	
		query.setParameter("enddate", enddate);			
		List<Securitycheck> list=query.getResultList();
		return list!=null && list.size()>0?list.get(0):null;
	}

	/**
	 * 获取车辆座位图明细表信息 李电志 2015年7月29日 03:12:38
	 * @param vehiclebrandmodelid
	 * @return
	 *//*
	public List<Vehicleseatplandetail> getVehicleseatplandetailInfo(
			Long vehiclebrandmodelid) {
		StringBuffer sql = new StringBuffer("select vp from Vehicleseatplandetail vp where vp.vehicleseatplan.vehiclebrandmodelid = :vehiclebrandmodelid");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("vehiclebrandmodelid", vehiclebrandmodelid);
		List<Vehicleseatplandetail> list = query.getResultList();
		return list;
	}

	*/
	/**
	 * 获取执行票价表ticketprice的信息  李电志 2015年7月29日 05:51:37
	 * @param schedulePlanceId
	 * @return
	 */
	public List<Ticketprice> getSchTicketPriceList(Long schedulePlanceId) {
		StringBuffer sql = new StringBuffer("select tp from Ticketprice tp ");
		sql.append(" where tp.scheduleplan.id = :schedulePlanceId ");
//		sql.append(" and tp.issellable = '1'");
		sql.append(" order by seatnos");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("schedulePlanceId", schedulePlanceId);
		List<Ticketprice> list = query.getResultList();
		return list;
	}
	
	/**
	 * 报班时由班次循环的设置自动显示正副驾驶员
	 * 优先顺序：1
	 * 取班次循环
	 * @param departdate
	 * @param scheduleid
	 * @return
	 */
	public List qryVehicleDriverCycle(Date departdate, long scheduleid){
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String departdatestr = sf.format(departdate);
		StringBuffer sql = new StringBuffer();
		sql.append(" select d1.name drivername, ")
		.append(" d1.id driverid, ")
		.append(" '' vehicleno, ")
		.append(" 0 vehicleid, ")
		.append(" d1.drivinglicensefirstdate firstdate, ")
		.append(" d2.name drivercopilot1name, ")
		.append(" d2.id drivercopilot1id, ")
		.append(" '' vehiclecopilot1no, ")
		.append(" 0 vehiclecopilot1id, ")
		.append(" d2.drivinglicensefirstdate first1date, ")
		.append(" d3.name drivercopilot2name,")
		.append(" d3.id drivercopilot2id,")
		.append(" d4.name drivercopilot3name,")
		.append(" d4.id drivercopilot3id")
		.append(" from schedulevehiclepeopleplan sv, schedule s, driver d1, driver d2,driver d3,driver d4 ")
		.append(" where sv.scheduleid = s.id ")
		.append(" and sv.plandriver1id = d1.id ")
		.append(" and sv.plandriver2id = d2.id(+) ")
		.append(" and sv.plandriver3id = d3.id(+) ")
		.append(" and sv.plandriver4id = d4.id(+) ")
		.append(" and s.islinework = '0' ")
		.append(" and sv.departdate = date'"+departdatestr+"' ")
		.append(" and s.id ='"+scheduleid+"' ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		//System.out.println("报班车牌号显示驾驶员1 sql--> "+sql.toString());
		List list=query.getResultList();
		return list;
	}
	
	/**
	 * 报班时由车牌号自动显示正副驾驶员
	 * 优先顺序：2
	 * 取驾驶员驾驶车辆设置
	 * @param vehicleid
	 * @return
	 */
	public List qryVehicleDriverSet(long vehicleid){
		StringBuffer sql = new StringBuffer();
		sql.append(" select drivername, ")
	       .append(" driverid, ")
	       .append(" vehicleno, ")
	       .append(" vehicleid, ")
	       .append(" firstdate, ")
	       .append(" drivercopilot1name, ")
	       .append(" drivercopilot1id, ")
	       .append(" vehiclecopilot1no, ")
	       .append(" vehiclecopilot1id, ")
	       .append(" first1date ")
	       .append(" from (select d.name drivername, ")
	               .append(" d.id driverid, ")
	               .append(" v.vehicleno vehicleno, ")
	               .append(" v.id vehicleid, ")
	               .append(" d.drivinglicensefirstdate firstdate, ")
	               .append(" lead(d.name, 1, '') over(partition by v.id order by d.drivinglicensefirstdate) drivercopilot1name, ")
	               .append(" lead(d.id, 1, 0) over(partition by v.id order by d.drivinglicensefirstdate) drivercopilot1id, ")
	               .append(" lead(v.vehicleno, 1, '') over(partition by v.id order by d.drivinglicensefirstdate) vehiclecopilot1no, ")
	               .append(" lead(v.id, 1, 0) over(partition by v.id order by d.drivinglicensefirstdate) vehiclecopilot1id, ")
	               .append(" lead(d.drivinglicensefirstdate, 1, null) over(partition by v.id order by d.drivinglicensefirstdate) first1date ")
	          .append(" from Setdrivervehicle s, Vehicle v, Driver d ")
	         .append(" where s.vehicleid = v.id ")
	         .append(" and s.driverid = d.id ")
	           .append(" and v.isactive='1' and d.isactive='1' ")
	           .append(" and  s.vehicleid = :vehicleid ")
	         .append(" order by d.drivinglicensefirstdate asc) tmp ")
	 .append(" where rownum <= 1 ")
	 .append(" order by tmp.firstdate ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("vehicleid", vehicleid);
		//System.out.println("报班车牌号显示驾驶员2 sql--> "+sql.toString()+"  参数"+vehicleid);
		List list=query.getResultList();
		return list;
	}
	
	/**
	 * 报班时由车牌号自动显示正副驾驶员
	 * 优先顺序：3
	 * 取驾驶员建制车牌
	 */
	public List qryVehicleDriver(long vehicleid) { 
		//Global global = CurrentUtil.getGlobal();
		StringBuffer sql = new StringBuffer();
		sql.append(" select drivername, ")
	       .append(" driverid, ")
	       .append(" vehicleno, ")
	       .append(" vehicleid, ")
	       .append(" firstdate, ")
	       .append(" drivercopilot1name, ")
	       .append(" drivercopilot1id, ")
	       .append(" vehiclecopilot1no, ")
	       .append(" vehiclecopilot1id, ")
	       .append(" first1date ")
	 .append(" from (select d.name drivername, ")
	               .append(" d.id driverid, ")
	               .append(" v.vehicleno vehicleno, ")
	               .append(" v.id vehicleid, ")
	               .append(" d.drivinglicensefirstdate firstdate, ")
	               .append(" lead(d.name, 1, '') over(partition by v.id order by d.drivinglicensefirstdate) drivercopilot1name, ")
	               .append(" lead(d.id, 1, 0) over(partition by v.id order by d.drivinglicensefirstdate) drivercopilot1id, ")
	               .append(" lead(v.vehicleno, 1, '') over(partition by v.id order by d.drivinglicensefirstdate) vehiclecopilot1no, ")
	               .append(" lead(v.id, 1, 0) over(partition by v.id order by d.drivinglicensefirstdate) vehiclecopilot1id, ")
	               .append(" lead(d.drivinglicensefirstdate, 1, null) over(partition by v.id order by d.drivinglicensefirstdate) first1date ")
	          .append(" from driver d, vehicle v ")
	         .append(" where d.vehicleid = v.id ")
	           .append(" and v.isactive='1' and d.isactive='1' ")
	           .append(" and v.id = :vehicleid ")
	         .append(" order by d.drivinglicensefirstdate asc) tmp ")
	 .append(" where rownum <= 1 ")
	 .append(" order by tmp.firstdate ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("vehicleid", vehicleid);
		//System.out.println("报班车牌号显示驾驶员3 sql--> "+sql.toString()+"  参数"+vehicleid);
		List list=query.getResultList();
		return list;
	}
	/**十堰特殊情况报班时由车牌号自动显示正副驾驶员*/
	public List qryVehicleDriverAudit(long vehicleid) {
		StringBuffer sql = new StringBuffer();
		
	    sql.append(" select drivername, driverid, ")
	    .append(" vehicleno,vehicleid,firstdate, ")
        .append("drivercopilot1name,drivercopilot1id, ")
        .append("vehiclecopilot1no,vehiclecopilot1id,first1date  ")
        .append("from ( ")
        .append("select  ck.id, first_value(ck.id) over( order by ck.checkdate desc,ck.checktime desc) owner, ")
        .append("d1.name drivername, d1.id driverid, ")
        .append("v.vehicleno vehicleno, v.id vehicleid, d1.drivinglicensefirstdate firstdate,  ")
        .append("d2.name drivercopilot1name, d2.id drivercopilot1id, ")
        .append("v.vehicleno vehiclecopilot1no, v.id vehiclecopilot1id, d2.drivinglicensefirstdate first1date ") 
        .append("from certificatecheck ck  ")
        .append("left join driver d1 on ck.driver1id=d1.id ")
        .append("left join driver d2 on ck.driver2id=d2.id ")
        .append("left join driver d3 on ck.driver3id=d3.id, ")
        .append("vehicle v ")
        .append("where ck.vehicleid=v.id and ck.checkrsult = 1 ")
        .append("and v.id= :vehicleid ")
        .append("order by ck.checkdate desc, ck.checktime desc ) ")
        .append("where id=owner ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("vehicleid", vehicleid);
		//System.out.println("十堰的报班车牌号显示驾驶员 sql--> "+sql.toString()+"  参数"+vehicleid);
		List list=query.getResultList();
		return list;
	}
	//根据报到车辆得到报到车辆的座位类型，车型，硬调票价 姜蓥瑞2015年9月14日21:03:13
	public List<Handprice> findvehicleprice(Vehicle vehicle,Schedule schedule) {
		StringBuffer sql = new StringBuffer();
		sql.append("select h")
				.append(" from Handprice h,Vehicletype vt, Vehicle v")
				.append(" where h.vehicletypeid = vt.id and v.vehicletypeid = vt.id")
				.append("  and h.scheduleid = :scheduleid ")
				.append("  and v.id = :vehicleid ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", schedule.getId());
		query.setParameter("vehicleid", vehicle.getId());
		return query.getResultList();
	}
	
	public Schedulevehiclepeopleplan
	getSchedulevehiclepeopleplanList(Long schedulePlanId) {
		StringBuffer sql = new StringBuffer("select sp from Schedulevehiclepeopleplan sp where sp.scheduleplan.id = :schedulePlanId");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("schedulePlanId", schedulePlanId);
		List<Schedulevehiclepeopleplan> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}
	@SuppressWarnings("unchecked")
	public List<Object> qryvehiclerouteset(List<PropertyFilter> buildFromHttpRequest) {
		StringBuilder sql = new StringBuilder(
				" select vr.id,v.vehicleno,r.name as routename,u.name as createby,vr.createtime ,uf.name as updateby,vr.updatetime,o.name as orgname ,vr.routeid,vr.vehicleid")
				.append(" from vehiclerouteconctrl vr ")
				.append(" left join route r on vr.routeid = r.id ")
				.append(" left join vehicle v on vr.vehicleid = v.id ")
				.append("  left join userinfo u on vr.createby = u.id")
				.append(" left join userinfo uf on vr.updateby = uf.id")
				.append("  left join organization o on vr.orgid = o.id ")
				.append(" where 1=1");
		sql.append(PropertyFilter.toJpql(buildFromHttpRequest, true));
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, buildFromHttpRequest);
		List<Object> list = query.getResultList();
		return list;
	}
	@SuppressWarnings("unchecked")
	public List<Object> qryroutebyvid(Long vehicleid) {
		StringBuilder sql = new StringBuilder(
				"select  t ,0 as isselect from Route t where t.isactive = 1 and t.islocaldelete = 0 ")
				.append(" and  not exists(select vr.routeid from Vehiclerouteconctrl vr where vr.routeid = t.id")
				.append(" and  vr.vehicleid= :vehicleid) ");
		Query query = em.createQuery(sql.toString());
		query.setParameter("vehicleid", vehicleid);
		List<Object> list = query.getResultList();
		return list;
	}
	public boolean existsVehicleroute(Long vehicleid,String routeid,long id) {
		StringBuffer sql = new StringBuffer();
		sql.append(" select t from Vehiclerouteconctrl t  ")
		   .append(" where t.routeid =:routeid and t.vehicleid = :vehicleid ")
		   .append(" and id <> :id");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("vehicleid", vehicleid);
		query.setParameter("routeid", Long.parseLong(routeid));
		query.setParameter("id", id);
		List<Object> list = query.getResultList();
		return  list!=null && list.size()>0?true:false;

	}	
	
	/**
	 * 自动报班获取具体信息
	 * @param propertyFilterList
	 * @return
	 */
	public List<Object> qryAutoReport(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" select v.id vehicleid, v.vehicleno, u.id unitid, u.name unitname, v.cardno from Vehicle v, Unit u ")
			.append(" where v.unitid=u.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();	
	}
	 // 6010:安检有效时间类型：0当日有效，1:24小时有效
	public List<Object> qryGps(Date checkdate, long vehicleid, String type) {
		if (type.equals("0")) {
			StringBuffer sql = new StringBuffer();
			sql.append(" select t.id,t.checkdate from Gpscheck t ")
					//.append(" where t.vehicleid= :vehicleid and t.checkresult='1' and t.isactive=1 and t.checkdate>=trim(:checkdate)");
					.append(" where t.vehicleid= :vehicleid and t.checkresult='1' and t.isactive=1 and t.checkdate>= trunc(:checkdate)");
			// 查询
			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("vehicleid", vehicleid);
			query.setParameter("checkdate", checkdate);
			return query.getResultList();
		} else {
			StringBuffer sql = new StringBuffer();
			sql.append(" select t.id,t.checkdate from Gpscheck t ")
					.append(" where t.vehicleid= :vehicleid and t.checkresult='1' and t.isactive=1 and t.checkdate>=sysdate-1 ");
			// 查询
			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("vehicleid", vehicleid);
		//	query.setParameter("checkdate", checkdate);
			return query.getResultList();
		}
	}
	
	public String findArriveStationCheck(long vehicleid,Date departdate,long orgid,long driver1id,long driver2id,long scheduleid) throws Exception{
		
		//校验是否有两个驾驶员
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		boolean driver2flag =false; //是否有副驾驶
		StringBuilder sql = new StringBuilder(
			    "select distance from scheduleplan sp where sp.scheduleid="+scheduleid+" and sp.departdate=to_date('"+df.format(departdate)+"','yyyy-mm-dd')");            //sql中 b 为表的别名
		Query query = getEntityManager().createNativeQuery(sql.toString());
		int distance = ((BigDecimal) query.getSingleResult()).intValue();
		int p_2030 = Integer.valueOf(parameterService.findParamValue("2023", CurrentUtil.getGlobal().getOrganization().getId()));
		if (distance>=p_2030){
			driver2flag=true;
		}
		//判断是否安装进站检查插件
		String returnstr="";
		String starttime = df.format(departdate)+" 00:00:01";
		String endtime =  df.format(departdate)+" 23:59:59";
		df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		departdate = df.parse(starttime);
		Date enddate  =df.parse(endtime);
		String arriveStationNodeName = "/CHECK/QUERYSAFESTUDY";
		ActionNode actionNode = Appvar.routes.get(arriveStationNodeName);
		if(actionNode!=null){//安装进站检查插件和安全学习，验证，否则不验证直接通过
			//进站检查不再校验
//			StringBuffer sql = new StringBuffer();
//			sql.append(" select a.checkdriver1id,a.checkdriver2id from ArriveStationCheck a where a.orgid=:orgid  and a.vehicleid=:vehicleid ");
//			if(driver1id>0){
//				sql.append("  and a.checkdriver1id =:driver1id  ");
//			}
//			if(driver2id>0){
//				sql.append("  and a.checkdriver2id =:driver2id  ");
//			}
//			sql.append("and a.arrivetime>=:departdate and a.arrivetime<=:enddate" );
//			sql.append(" order by a.arrivetime desc");
//			Query query = getEntityManager().createNativeQuery(sql.toString());
//			query.setParameter("orgid", orgid);
//			query.setParameter("vehicleid", vehicleid);
//			if(driver1id>0){
//				query.setParameter("driver1id", driver1id);
//			}
//			if(driver2id>0){
//				query.setParameter("driver2id", driver2id);
//			}
//			query.setParameter("departdate", departdate);
//			query.setParameter("enddate", enddate);
//			List<Object> list = query.getResultList();
//			if(list.size()>0){
//				Object[] obj = (Object[]) list.get(0);
//				if(Long.valueOf(obj[1].toString())>0){
//					driver2flag=true;
//					if(driver2id!=Long.valueOf(obj[1].toString())){
//						returnstr +="进站检查,";
//					}
//				}
//			}else{
//				returnstr +="进站检查,";
//			}
			
			/** 外司车辆不需要进行安全学习  */
			StringBuilder sb = new StringBuilder();
			sb.append("select u.type from vehicle t left join unit u on t.unitid=u.id where t.id=:vehicleid");
			query = getEntityManager().createNativeQuery(sb.toString());
			query.setParameter("vehicleid", vehicleid);
			String type = (String)query.getSingleResult();
			if ("2".equals(type)) {
				return returnstr;
			}
			
			//校验安全学习结果
			sql = new StringBuilder();
			sql.append("select interval from (select s.interval from safestudy s where s.orgid=:orgid  and s.vehicleid=:vehicleid ");
			sql.append(" and s.driverid=:driver1id and s.startstudytime>=:departdate and s.startstudytime<=:enddate and s.interval is not null" );
			sql.append(" order by s.startstudytime desc)   where  rownum=1 ");
			if(driver2flag){
				sql.append(" union select interval from (select s.interval from safestudy s where s.orgid=:orgid2  and s.vehicleid=:vehicleid2 ");
				sql.append(" and s.driverid=:driver2id and s.startstudytime>=:departdate2 and s.startstudytime<=:enddate2 and s.interval is not null " );
				sql.append(" order by s.startstudytime desc) where  rownum=1 ");
			}
			query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("orgid", orgid);
			query.setParameter("vehicleid", vehicleid);
			query.setParameter("driver1id", driver1id);
			query.setParameter("departdate", departdate);
			query.setParameter("enddate", enddate);
			if(driver2flag){
				query.setParameter("orgid2", orgid);
				query.setParameter("vehicleid2", vehicleid);
				query.setParameter("driver2id", driver2id);
				query.setParameter("departdate2", departdate);
				query.setParameter("enddate2", enddate);
			}
			List<Object> safelist = query.getResultList();//有多条学习记录的 取最新的 
			if(safelist!=null && safelist.size()>0){
				String[] safeobjs = safelist.get(0).toString().split("分");  //根据安全学习插件，此处显示的是   XX分XX秒
				String safeobj = safeobjs[0];  //取分钟
				if(safeobj==null || Long.valueOf(safeobj)<5 || Long.valueOf(safeobj)>30){
					returnstr +="安全学习,";
				}
				if(driver2flag){
					if(safelist.size()>1){
						String safeobj2 = safelist.get(1).toString();
						if(safeobj2==null || Long.valueOf(safeobj2)<5 || Long.valueOf(safeobj)>30){
							returnstr +="安全学习,";
						}
					}else{
						returnstr +="安全学习,";
					}
				}
			}else{
				returnstr +="安全学习,";
			}
		}
		return returnstr;
	}
	
	public String findcertificate(long vehicleid,Date departdate,long orgid) throws Exception{
		StringBuffer sql = new StringBuffer();
		String returnstr="";
		String arriveStationNodeName = "/CHECK/QRYCERTIFYINFO";
		ActionNode actionNode = Appvar.routes.get(arriveStationNodeName);
		if(actionNode!=null){//安装证件核查，验证，否则不验证直接通过
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			String starttime = df.format(departdate)+" 00:00:01";
			String endtime =  df.format(departdate)+" 23:59:59";
			df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			departdate = df.parse(starttime);
			Date enddate  =df.parse(endtime);
			sql.append(" select e.checkresult from examinecertificate e where e.orgid=:orgid  and e.vehicleid=:vehicleid ");
			sql.append(" and  e.checktime>=:departdate and e.checktime<=:enddate" );
			sql.append(" order by e.checktime desc");
			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("orgid", orgid);
			query.setParameter("vehicleid", vehicleid);
			query.setParameter("departdate", departdate);
			query.setParameter("enddate", enddate);
			List<Object> list = query.getResultList();
			if(list!=null&&list.size()>0){
				BigDecimal checkresult= (BigDecimal) list.get(0);
				if(checkresult==null||checkresult.intValue()==0){
					returnstr +="证件核查,";
				}
			}else{
				returnstr +="证件核查,";
			}
		}
		return returnstr;
		
	}


	public boolean checkIsCanCancel(long id) {
		StringBuffer sql = new StringBuffer();
		sql.append("select count(t.id) from vehiclereport t where t.scheduleplanid = :id and t.isactive =1 ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("id", id);
		List list = query.getResultList();
		if(list!=null&&list.size()>0){
			BigDecimal result= (BigDecimal) list.get(0);
			return result.compareTo(BigDecimal.ONE)<=0?false:true;
		}
		return false;
	}
	
	/*
	 * 查询证件过期的班次计划
	 */
	public List<Object> qryAutoStopScheduleplans(){
		StringBuffer sql = new StringBuffer();
		sql.append(" select scheduleplanid, ")
		.append(" min(orgid), ")
		.append(" min(departstationid), ")
		.append(" min(scheduleid), ")
		.append(" departdate, ")
		.append(" min(vehicleid), ")
		.append(" min(yyz), ")
		.append(" min(xsz), ")
		.append(" min(ewyxq), ")
		.append(" min(jqx), ")
		.append(" min(cyrx), ")
		.append(" min(dszzrx) ")
		.append(" from (select sp.id as scheduleplanid, ")
		.append(" sp.orgid as orgid, ")
		.append(" o.stationid as departstationid, ")
		.append(" sp.scheduleid as scheduleid, ")
		.append(" sp.departdate as departdate, ")
		.append(" v.id as vehicleid, ")
		.append(" v.workenddate as yyz, ")// --营运证
		.append(" null as xsz, ")
		.append(" null as ewyxq, ")
		.append(" null as jqx, ")
		.append(" null as cyrx, ")
		.append(" null as dszzrx ")
		.append(" from scheduleplan sp, ")
		.append(" organization o, ")
		.append(" schedulevehiclepeopleplan svp, ")
		.append(" vehicle v ")
		.append(" where sp.orgid = o.id ")
		.append(" and o.isactive = 1 ")
		.append(" and sp.id = svp.scheduleplanid ")
		.append(" and svp.planvehicleid = v.id ")
		.append(" and sp.departdate >= trunc(sysdate) ")
		.append(" and sp.departdate > v.workenddate ")
		.append(" union all ")
		.append(" select sp.id as scheduleplanid, ")
		.append(" sp.orgid as orgid, ")
		.append(" o.stationid as departstationid, ")
		.append(" sp.scheduleid as scheduleid, ")
		.append(" sp.departdate as departdate, ")
		.append(" v.id as vehicleid, ")
		.append(" null as yyz, ")
		.append(" v.licenseenddate as xsz, ")//--行驶证 
		.append(" null as ewyxq, ")
		.append(" null as jqx, ")
		.append(" null as cyrx, ")
		.append(" null as dszzrx ")
		.append(" from scheduleplan sp, ")
		.append(" organization o, ")
		.append(" schedulevehiclepeopleplan svp, ")
		.append(" vehicle v ")
		.append(" where sp.orgid = o.id ")
		.append(" and o.isactive = 1 ")
		.append(" and sp.id = svp.scheduleplanid ")
		.append(" and svp.planvehicleid = v.id ")
		.append(" and sp.departdate >= trunc(sysdate) ")
		.append(" and sp.departdate > v.licenseenddate ")
		.append(" union all ")
		.append(" select sp.id as scheduleplanid, ")
		.append(" sp.orgid as orgid, ")
		.append(" o.stationid as departstationid, ")
		.append(" sp.scheduleid as scheduleid, ")
		.append(" sp.departdate as departdate, ")
		.append(" v.id as vehicleid, ")
		.append(" null as yyz, ")
		.append(" null as xsz, ")
		.append(" v.maintainvaliddate as ewyxq, ")// --二维有效期证
		.append(" null as jqx, ")
		.append(" null as cyrx, ")
		.append(" null as dszzrx ")
		.append(" from scheduleplan sp, ")
		.append(" organization o, ")
		.append(" schedulevehiclepeopleplan svp, ")
		.append(" vehicle v ")
		.append(" where sp.orgid = o.id ")
		.append(" and o.isactive = 1 ")
		.append(" and sp.id = svp.scheduleplanid ")
		.append(" and svp.planvehicleid = v.id ")
		.append(" and sp.departdate >= trunc(sysdate) ")
		.append(" and sp.departdate > v.maintainvaliddate ")
		.append(" union all ")
		.append(" select sp.id as scheduleplanid, ")
		.append(" sp.orgid as orgid, ")
		.append(" o.stationid as departstationid, ")
		.append(" sp.scheduleid as scheduleid, ")
		.append(" sp.departdate as departdate, ")
		.append(" v.id as vehicleid, ")
		.append(" null as yyz, ")
		.append(" null as xsz, ")
		.append(" null as ewyxq, ")
		.append(" v.compulsoryinsureenddate as jqx, ")//--交强险 
		.append(" null as cyrx, ")
		.append(" null as dszzrx ")
		.append(" from scheduleplan sp, ")
		.append(" organization o, ")
		.append(" schedulevehiclepeopleplan svp, ")
		.append(" vehicle v ")
		.append(" where sp.orgid = o.id ")
		.append(" and o.isactive = 1 ")
		.append(" and sp.id = svp.scheduleplanid ")
		.append(" and svp.planvehicleid = v.id ")
		.append(" and sp.departdate >= trunc(sysdate) ")
		.append(" and sp.departdate > v.compulsoryinsureenddate ")
		.append(" union all ")
		.append(" select sp.id as scheduleplanid, ")
		.append(" sp.orgid as orgid, ")
		.append(" o.stationid as departstationid, ")
		.append(" sp.scheduleid as scheduleid, ")
		.append(" sp.departdate as departdate, ")
		.append(" v.id as vehicleid, ")
		.append(" null as yyz, ")
		.append(" null as xsz, ")
		.append(" null as ewyxq, ")
		.append(" null as jqx, ")
		.append(" v.liabilityinsureenddate as cyrx, ")// --承运人险
		.append(" null as dszzrx ")
		.append(" from scheduleplan sp, ")
		.append(" organization o, ")
		.append(" schedulevehiclepeopleplan svp, ")
		.append(" vehicle v ")
		.append(" where sp.orgid = o.id ")
		.append(" and o.isactive = 1 ")
		.append(" and sp.id = svp.scheduleplanid ")
		.append(" and svp.planvehicleid = v.id ")
		.append(" and sp.departdate >= trunc(sysdate) ")
		.append(" and sp.departdate > v.liabilityinsureenddate ")
		.append(" union all ")
		.append(" select sp.id as scheduleplanid, ")
		.append(" sp.orgid as orgid, ")
		.append(" o.stationid as departstationid, ")
		.append(" sp.scheduleid as scheduleid, ")
		.append(" sp.departdate as departdate, ")
		.append(" v.id as vehicleid, ")
		.append(" null as yyz, ")
		.append(" null as xsz, ")
		.append(" null as ewyxq, ")
		.append(" null as jqx, ")
		.append(" null as cyrx, ")
		.append(" v.contractenddate as dszzrx ")//--第三者责任险
		.append(" from scheduleplan sp, ")
		.append(" organization o, ")
		.append(" schedulevehiclepeopleplan svp, ")
		.append(" vehicle v ")
		.append(" where sp.orgid = o.id ")
		.append(" and o.isactive = 1 ")
		.append(" and sp.id = svp.scheduleplanid ")
		.append(" and svp.planvehicleid = v.id ")
		.append(" and sp.departdate >= trunc(sysdate) ")
		.append(" and sp.departdate > v.contractenddate) t ")
		.append("  group by t.scheduleplanid, departdate ");

		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}
		/**
	 * 本司车辆
	 * @param vehicleid
	 * @return 
	 */
	public int findOwnUnitPermission(Long vehicleid) {
		StringBuffer sql = new StringBuffer();
		sql.append("select count(*) from vehicle v,unit u where v.unitid=u.id and u.type=0 and v.id=:vehicleid ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("vehicleid", vehicleid);
		return ((BigDecimal) query.getSingleResult()).intValue();
	}
	/**
	 * 外司车辆
	 * @param vehicleid
	 * @return
	 */
	public int findOutUnitPermission(Long vehicleid) {
		StringBuffer sql = new StringBuffer();
		sql.append("select count(*) from vehicle v,unit u where v.unitid=u.id and u.type>0 and v.id=:vehicleid ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("vehicleid", vehicleid);
		return ((BigDecimal) query.getSingleResult()).intValue();
	}

	//根据报到车辆得到报到车辆的座位类型，车型，硬调票价 姜蓥瑞2015年9月14日21:03:13
	public List findvehicleprice(Schedule schedule,Vehiclereport vehiclereport) {
		StringBuffer sql = new StringBuffer();
		sql.append(" select h.reachstationid as reachstationid, v.id as id,v.vehicletypeid as vehicletypeid,")
		.append(" h.fullprice as fullprice, h.halfprice as halfprice,  h.studentprice as studentprice, ")
		.append(" h.seattype,h.seats,v.seatnum ")//,h.seatnos
		.append(" from  vehicle v, schedule s, handprice h ")
		.append("  where h.scheduleid = s.id  ")
		.append("  and h.vehiclebrandmodelid = v.vehiclebrandmodelid ")
		.append("  and h.vehicletypeid = v.vehicletypeid ")
		//.append("  and ((h.vehiclebrandmodelid is not null and h.vehiclebrandmodelid = v.vehiclebrandmodelid) or (h.vehiclebrandmodelid is  null))")
		.append(" and s.id=:scheduleid")
		.append("  and v.id= :vehicleid")
		.append(" order by h.reachstationid,h.seats");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("scheduleid", schedule.getId());
		query.setParameter("vehicleid", vehiclereport.getVehicleid());
		List list=query.getResultList();
		if(list==null||list.size()==0){
			sql = new StringBuffer();
			sql.append(" select h.reachstationid as reachstationid, v.id as id,v.vehicletypeid as vehicletypeid,")
			.append(" h.fullprice as fullprice, h.halfprice as halfprice,  h.studentprice as studentprice, ")
			.append(" h.seattype,h.seats,v.seatnum ")//,h.seatnos
			.append(" from  vehicle v, schedule s, handprice h ")
			.append("  where h.scheduleid = s.id  ")
			.append("  and h.vehicletypeid = v.vehicletypeid ")
			.append("  and h.vehiclebrandmodelid is  null")
			.append("  and s.id=:scheduleid")
			.append("  and v.id= :vehicleid")
			.append(" order by h.reachstationid,h.seats");
			query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("scheduleid", schedule.getId());
			query.setParameter("vehicleid", vehiclereport.getVehicleid());
			list=query.getResultList();
		}
		List result = CommonUtil.list2Map(list, new String[]
				{"reachstationid", "id", "vehicletypeid", "fullprice", "halfprice", "studentprice","seattype","seats","seatnum"});
		return result;
	}

	//通过scheduleplanid获取班次座位信息，并删除，通过新获取的座位类型及座位号新建班次座位对象
	public Scheduleplan findScheduleseats(long scheduleplanid)
	{
//		boolean result = false;
//		StringBuffer sql = new StringBuffer("select s from Scheduleplan s where s.id=:scheduleplanid");
////		sql.append(vehiclereport.getScheduleplanid());
//		Query query = getEntityManager().createQuery(sql.toString());
//		query.setParameter("scheduleplanid", scheduleplanid);
//		query.setLockMode(LockModeType.READ);
//		List<Scheduleplan> list = query.getResultList();
//		return list!=null?list.get(0):null;
		return (Scheduleplan) get(LockModeType.PESSIMISTIC_READ,
				Scheduleplan.class, scheduleplanid);
	}

	/**
	 * 查询唯一要更新的ticketsell记录，由于计划售票时候的座位类型和报到时候座位类型不一致，要更新座位号
	 */
	public Ticketsell getTicketsell(long scheduleplanid,short seatno)
	{
		StringBuffer sql = new StringBuffer(" select ts from Ticketsell ts ");
		sql.append(" where ts.scheduleplanid=:scheduleplanid");
		sql.append(" and ts.seatno = :seatno");
		sql.append(" and ts.ticketstatus='0' ");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("seatno", seatno);
		List<Ticketsell> list=query.getResultList();
		if(list.size()>0)
			return list.get(0);
		else
			return null;
	}

	/**
	 * @author Liyi
	 * 用来查询计划座位类型以及对应的已售座位数
	 */
	public List<Map<String,Object>> qryPlanseattypeAndSoldnum(Long scheduleplanid)
	{
		StringBuffer sql = new StringBuffer("select distinct tp.seattype ,(tp.soldeatnum) ");
		sql.append(" from ticketprice tp where tp.scheduleplanid =:scheduleplanid  ");
		sql.append(" and tp.issellable ='1' ");
//		sql.append(" group by tp.seattype ");
		
		Query query = em.getEntityManagerFactory().createEntityManager().createNativeQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		List<Map<String,Object>> list = query.getResultList();
		List result = CommonUtil.list2Map(list, new String[]
				{"seattype", "soldnum"});
//		List result = ListUtil.listToMap(new Object[]{"seattype","soldnum"},
//				list,new Object[]{String.class,String.class});
		return result;
		
	}

	/**
	 * @author liyi
	 * 用来查询报到车型每种座位类型对应的座位数
	 */
	public List<Map<String,Object>> qryreportseattypeAndnums(Vehiclereport vehiclereport)
	{
		StringBuffer sql = new StringBuffer("select distinct h.seattype,h.seats from handprice h,vehicle v ");
		sql.append(" where  v.vehicletypeid= h.vehicletypeid ");
		sql.append("  and ((h.vehiclebrandmodelid is not null and h.vehiclebrandmodelid = v.vehiclebrandmodelid) or (h.vehiclebrandmodelid is  null))");
		sql.append(" and v.id = :vehicleid");
		sql.append(" and h.scheduleid = :scheduleid");
		
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("vehicleid", vehiclereport.getVehicleid());
		query.setParameter("scheduleid", vehiclereport.getScheduleid());
		List list = query.getResultList();
		List result = CommonUtil.list2Map(list, new String[]
				{"seattype", "seats"});
		return result;
		
	}

	//删除ticketprice
	public boolean deleteTicketprice(Long id)
	{
		try
		{
			StringBuilder sql = new StringBuilder();
			sql.append(" DELETE from ticketprice tp where tp.id="+id);
			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.executeUpdate();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return true;			
	}
	//删除ticketprice
	public boolean deleteTicketprices(long scheduleplanid)
	{
		try
		{
			StringBuilder sql = new StringBuilder();
			sql.append(" DELETE from ticketprice tp where tp.scheduleplanid="+scheduleplanid);
			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.executeUpdate();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return true;			
	}
	
	/**
	 * 查询ticketsell记录
	 */
	public List<Ticketsell> findTicketsells(long scheduleplanid)
	{
		StringBuffer sql = new StringBuffer(" select ts from Ticketsell ts ");
		sql.append(" where ts.scheduleplanid=:scheduleplanid");
		sql.append(" and ts.ticketstatus='0' order by ts.seatno ");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		List<Ticketsell> list=query.getResultList();
		return list;
	}
	/**
	 * 查询固定留位的最大座位号
	 */
	public int findScheduleseatreserver(long scheduleplanid)
	{
		StringBuffer sql = new StringBuffer(" select nvl(max(ss.seatno),0) from scheduleseats ss ");
		sql.append(" where ss.scheduleplanid=:scheduleplanid");
		sql.append(" and ss.status='3' ");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		int maxseatno = ((BigDecimal) query.getSingleResult()).intValue();
		return maxseatno;
//		List<Object> list=query.getResultList();
//		if(list.size()>0){
//			BigDecimal maxseatno = (BigDecimal) list.get(0);
//			return maxseatno.intValue();
//		}else{
//			return 0;
//		}
	}
	
	/**
	 * 查询Seatreserve记录
	 */
	public List<Seatreserve> findSeatreserves(long scheduleplanid)
	{
		StringBuffer sql = new StringBuffer(" select sr from Seatreserve sr ");
		sql.append(" where sr.scheduleplanid=:scheduleplanid");
		sql.append(" and sr.sellstate='R' order by sr.seatno ");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleplanid", scheduleplanid);
		List<Seatreserve> list=query.getResultList();
		return list;
	}
	/**
	 * 查询Handprice记录
	 */
	public List<Handprice> findHandprices(Schedule schedule,Vehicle vehicle)
	{
		StringBuffer sql = new StringBuffer(" select h from Handprice h ");
		sql.append(" where h.scheduleid=:scheduleid");
		sql.append(" and h.vehicletypeid=:vehicletypeid ");
		sql.append(" and h.vehiclebrandmodel.id=:vehiclebrandmodelid ");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleid", schedule.getId());
		query.setParameter("vehicletypeid", vehicle.getVehicletypeid());
		query.setParameter("vehiclebrandmodelid", vehicle.getVehiclebrandmodelid());
		List<Handprice> list=query.getResultList();
		if(list==null||list.size()==0){
			sql = new StringBuffer(" select h from Handprice h ");
			sql.append(" where h.scheduleid=:scheduleid");
			sql.append(" and h.vehicletypeid=:vehicletypeid ");
			sql.append(" and h.vehiclebrandmodel is null ");
			query = em.createQuery(sql.toString());
			query.setParameter("scheduleid", schedule.getId());
			query.setParameter("vehicletypeid", vehicle.getVehicletypeid());
			list=query.getResultList();
		}
		return list;
	}
	
	public List<Seatreserve> getSeatreserves(Long scheduleplanid, Date departdate,
			short seatno) {
		StringBuffer sql = new StringBuffer(
				"select t from Seatreserve t where t.scheduleplanid=:scheduleplanid");
		if (departdate != null) {
			sql.append(" and t.departdate=:departdate ");
		}
		sql.append(" and t.sellstate='R' and t.seatno >:seatno");
		Query query = getEntityManager().createQuery(sql.toString(),Seatreserve.class);
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("departdate", departdate);
		query.setParameter("seatno", seatno);
		List<Seatreserve> srlist =query.getResultList();
//		if (srlist.isEmpty()) {
//			return null;
//		}
		return srlist;
	}
	
	/**
	 * 统计车载人数
	 * #11356：车载人数=实载人数（未发班则统计截止打印路单时的已售数，已发班则统计检票数）+报到驾驶员人数+报到乘务员人数
	 * @param stationid
	 * @param scheduleplanid
	 * @return
	 */
	public BigDecimal coutVehicleLoadNum(Date printtime, Long departstationid, Long scheduleplanid, Long vehiclereportid){
		StringBuilder sql = new StringBuilder();
		sql.append("select case");
		sql.append("         when vr.isdeparted = 0 then"); //未发班
		sql.append("          nvl(t.tsnum, 0) + case when vr.driver1id is null then 0 else 1 end + case when vr.driver2id is null then 0 else 1 end");
		sql.append("           + case when vr.driver3id is null then 0 else 1 end + case when vr.driver4id is null then 0 else 1 end");
		sql.append("           + case when vr.steward1id is null then 0 else 1 end + case when vr.steward2id is null then 0 else 1 end");
		sql.append("        else"); //已发班
		sql.append("          nvl(t.tknum, 0) + case when vr.driver1id is null then 0 else 1 end + case when vr.driver2id is null then 0 else 1 end");
		sql.append("           + case when vr.driver3id is null then 0 else 1 end + case when vr.driver4id is null then 0 else 1 end");
		sql.append("           + case when vr.steward1id is null then 0 else 1 end + case when vr.steward2id is null then 0 else 1 end");
		sql.append("       end");
		sql.append("  from scheduleplan sp");
		sql.append("  left join schedulestatus ss on sp.id = ss.scheduleplanid");
		sql.append("  left join vehiclereport vr on sp.id = vr.scheduleplanid");
		sql.append("  left join (select sum(tsnum) as tsnum, spid, sum(tknum) as tknum from( ");
		sql.append("                select case when vrr.isdeparted = 0 then count(1) else 0 end as tsnum, sdp.id as spid ");
		sql.append("                    , case when vrr.isdeparted = 1 and ts.ischecked = 1 then count(1) else 0 end as tknum ");
		sql.append("                    from scheduleplan sdp, ticketsell ts, vehiclereport vrr ");
		sql.append("                    where sdp.id = ts.scheduleplanid");
		sql.append("                        and sdp.departdate = ts.departdate ");
		sql.append("                        and sdp.departdate = vrr.departdate ");
		sql.append("                        and sdp.id = vrr.scheduleplanid ");
		sql.append("                        and vrr.id = :vehiclereportid ");
		sql.append("                        and sdp.id = :scheduleplanid ");
		sql.append("                        and ts.ticketstatus = '0' and ts.selltime <= :printtime ");
		sql.append("                  group by sdp.id, vrr.isdeparted, ts.ischecked) ");
		sql.append("               group by spid) t on sp.id = t.spid");
		sql.append(" where vr.isactive = 1 ");
		sql.append("   and ss.departstationid = :departstationid ");
		sql.append("   and sp.id = :scheduleplanid ");
		sql.append("   and vr.id = :vehiclereportid ");
		
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("printtime", printtime);
		query.setParameter("departstationid", departstationid);
		query.setParameter("scheduleplanid", scheduleplanid);
		query.setParameter("vehiclereportid", vehiclereportid);
		return (BigDecimal) query.getResultList().get(0);
	}

	public int countCheckednum(Scheduleplan sp) {
		StringBuilder sql = new StringBuilder();
		sql.append("select count(t.id) from ticketsell t where t.scheduleplanid = :scheduleplanid and t.ticketstatus = '0' and t.ischecked = 1 and t.departdate = :departdate ");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("scheduleplanid", sp.getId());
		query.setParameter("departdate", sp.getDepartdate());
		BigDecimal result = (BigDecimal) query.getResultList().get(0);
		return result.intValue();
	}

	public BigDecimal querySequence() {
		StringBuilder sql = new StringBuilder();
		sql.append(" select SEQ_ROADBILLPRINT.nextval from dual ");
		Query query = em.createNativeQuery(sql.toString());
		return (BigDecimal)query.getSingleResult();
	}

	public List<Object> qryLicenseByCode(String codes) {
		StringBuilder sql = new StringBuilder("");
		String codelist = "";
		List<Object> list = new ArrayList<Object>();
		while (codes.length() > 0) {
			if (codes.length() > 2000) {
				codelist = codes.substring(0, 1980);
				codelist = codelist.substring(0, codelist.lastIndexOf(","));
				codes = codes.substring(codelist.length() + 1,
						codes.length());
			} else {
				codelist = codes;
				codes = "";
			}
			sql.append(" select lc.id,lc.licensetype,lc.licensetypeid,lc.code,lc.orgid,v.vehicleno,d.name, ")
			.append(" decode(lc.licensetype,'0',d.workenddate,'1',d.qualificationenddate,'2',  ")
			.append(" v.licenseenddate,'3',v.workenddate,sysdate) as enddate, ")  //证件截止之日
			.append(" decode(lc.licensetype,'0',d.workno,'1',d.qualification,'2',v.driverlicense,'3',v.workno) as credentialsno, ")  //证件号
            .append(" case when  decode(lc.licensetype,'0',d.workenddate,'1',d.qualificationenddate, ")
            .append(" '2', v.licenseenddate,'3',v.workenddate,sysdate)-sysdate>0 then '合格' else '证件已过期' end as resultmsg ")
			.append(" from licensecode lc ")
			.append(" left join vehicle v on v.id=lc.licensetypeid ")
			.append(" left join driver d on d.id=lc.licensetypeid ")
			.append(" where lc.code in (" + codelist + ")" );
			Query query = em.createNativeQuery(sql.toString());
			//query.setParameter("codelist", codelist);
			//query.setLockMode(LockModeType.PESSIMISTIC_READ);
			list.addAll(query.getResultList());
		}
		return list;
	}

	/**
	 * 查询当天已经报班的驾驶员
	 * @param driverids
	 * @param departdate
	 * @return
	 */
	public List<Object[]> qryDriverReport(String driverids, Date departdate) {
		StringBuilder sql = new StringBuilder();
		sql.append(" select vr.id,d1.name as driver1,d2.name as driver2,d3.name as driver3,d4.name as driver4 ")
		.append("  from vehiclereport vr  ")
		.append("  left join driver d1 on vr.driver1id=d1.id ")
		.append("  left join driver d2 on vr.driver2id=d2.id ")
		.append("  left join driver d3 on vr.driver3id=d3.id ")
		.append("  left join driver d4 on vr.driver4id=d4.id ")
		.append(" where vr.departdate=:departdate and (vr.driver1id in ("+ driverids +") or vr.driver2id in ("+ driverids +")")
		.append(" or vr.driver3id in ("+ driverids + ") or vr.driver4id in ("+ driverids +"))");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("departdate", departdate);
		List list = query.getResultList();
		return list != null && list.size() > 0 ? list : null;
	}

	/**
	 * 查询司机
	 * @param driverids
	 */
	public List<String> qryDriver(String driverids) {
		StringBuilder sql = new StringBuilder();
		sql.append(" select d.name from driver d where d.id in (" + driverids +")");
		Query query = em.createNativeQuery(sql.toString());
		List list = query.getResultList();
		return list;
		
	}
	
	public Schedulecancel qrySchedulecancel(long scheduleid, Date departdate) {
		StringBuilder sql = new StringBuilder("select s from Schedulecancel s")
				.append(" where s.scheduleid=:scheduleid and s.departdate=:departdate");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("departdate", departdate);
		List<Schedulecancel> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}
}
