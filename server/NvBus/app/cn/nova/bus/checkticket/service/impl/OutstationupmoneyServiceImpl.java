package cn.nova.bus.checkticket.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.checkticket.dao.OutstationupmoneyDao;
import cn.nova.bus.checkticket.model.Departinvoices;
import cn.nova.bus.checkticket.model.Outstationcheck;
import cn.nova.bus.checkticket.model.Outstationupmoney;
import cn.nova.bus.checkticket.service.OutstationupmoneyService;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;
import cn.nova.utils.orm.jpa.ListUtil;



public class OutstationupmoneyServiceImpl implements OutstationupmoneyService {


	private OutstationupmoneyDao outstationupmoneyDao = new OutstationupmoneyDao();
	
	private ParameterService parameterService = new ParameterServiceImpl();

	@Override
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters) {
		// TODO Auto-generated method stub
		return ListUtil.listToMap(new Object[] { "id", "departmonth",
				"price", "agentfee", "waterfee", "stopfee",
				"violationfee", "otherfee1", "otherfee2", "balancemoney",
				"operatorid", "orgid", "createtime", "createby", "updatetime",
				"updateby", "routename", "orgname", "operatorname",
				"departmonthdate" },
				outstationupmoneyDao.query(propertyFilters), new Object[] {
						Long.class, String.class, 
						BigDecimal.class,BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,BigDecimal.class, 
						Long.class, Long.class,Timestamp.class, Long.class, Timestamp.class,
						Long.class,String.class, String.class, String.class,
						Timestamp.class });
	}

	@SuppressWarnings("unchecked")
	@Override
	public Outstationupmoney saveOutstationupmoney(
			Outstationupmoney outstationupmoney) throws ServiceException {
		if (outstationupmoney.getId() == 0) {
			outstationupmoneyDao.save(outstationupmoney);
		} else {
			outstationupmoneyDao.getEntityManager().merge(outstationupmoney);
		}
		return outstationupmoney;
	}

	@Override
	public List<Map<String, Object>> queryDepartinvoices(Date departdate,
			long vehicleid, String cardno, Global global) {
		// TODO Auto-generated method stub
		StringBuilder sql = null;
		List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
		if ((cardno != null && cardno.length() > 0) || vehicleid == 0) {
			filters.clear();
			filters.add(new PropertyFilter("EQS_t!cardno", cardno));
			filters.add(new PropertyFilter("EQS_t!isative", true));
			List<Vehicle> vlist = outstationupmoneyDao.find(Vehicle.class,
					filters);
			if (vlist != null && vlist.size() > 0) {
				vehicleid = vlist.get(0).getId();
			}
		}
		sql = new StringBuilder("select t from Departinvoices t where 1=1 ");
		filters.clear();
		filters.add(new PropertyFilter("EQD_t!departdate", departdate));
		filters.add(new PropertyFilter("EQL_t!vehicleid", vehicleid));
		filters.add(new PropertyFilter("EQS_t!status", "0"));
		sql.append(PropertyFilter.toJpql(filters, true));
		sql.append(" order by createtime desc");
		Query query = outstationupmoneyDao.getEntityManager().createQuery(
				sql.toString(), Departinvoices.class);
		JPAPropertyFilterUtil.setParameter(query, filters);
		List<Departinvoices> dps = query.getResultList();
		List<Object> list = null;
		if (dps == null || dps.size() == 0) {
			// 若没有开单，则取最新报到记录
			sql = new StringBuilder("select t from Vehiclereport t where 1=1 ");
			filters.clear();
			filters.add(new PropertyFilter("EQD_t!departdate", departdate));
			filters.add(new PropertyFilter("EQL_t!vehicleid", vehicleid));
			filters.add(new PropertyFilter("EQL_t!reportorgid", global
					.getOrganization().getId()));
			filters.add(new PropertyFilter("EQB_t!isactive", true));
			sql.append(PropertyFilter.toJpql(filters, true));
			sql.append(" order by createtime desc");
			query = outstationupmoneyDao.getEntityManager().createQuery(
					sql.toString(), Vehiclereport.class);
			JPAPropertyFilterUtil.setParameter(query, filters);
			List<Vehiclereport> vlist = query.getResultList();
			if (vlist != null && vlist.size() > 0) {
				long lv_reportid = vlist.get(0).getId();
				sql = new StringBuilder();
				sql.append(
						"select vr.id,vr.reporttime,vr.scheduleplanid,s.id scheduleid,")
						.append(" trim(ss.departtime),v.seatnum,u.name unitname,(select sum(d.ticketnum) ticketnum")
						.append(" from departinvoices d where d.status <> '1'")
						.append(" and d.reportid =:lv_reportid) ticketnum,")
						.append(" st.name || ' ' || s.code || ' [' || ss.departtime || ']' schinfo,")
						.append(" FN_ISvalidate(v.workenddate) runnochk,")
						.append(" FN_ISvalidate(v.licenseenddate) driverlicensechk,")
						.append(" '0' checkresult,")
						.append(" FN_ISvalidate(v.maintainvaliddate) maintainchk,")
						.append(" 0 roadnochk,vr.driver1id,vr.driver2id,d1.name driver1name,")
						//添加查询乘务员字段
						.append(" vr.steward1id,")
						//
						.append(" FN_ISvalidate(d1.drivinglicenseenddate) drivinglicense1chk,")
						.append(" FN_ISvalidate(d1.qualificationenddate) qualification1chk,")
						.append(" FN_ISvalidate(d1.workenddate) workno1chk,")
						.append(" d2.name driver2name,")
						.append(" FN_ISvalidate(d2.drivinglicenseenddate) drivinglicense2chk,")
						.append(" FN_ISvalidate(d2.qualificationenddate) qualification2chk,")
						.append(" FN_ISvalidate(d2.workenddate) workno2chk,")
						.append(" sp.carrychildnum")
						.append(" from vehiclereport  vr,vehicle v,driver d1,")
						.append("  driver d2,unit u, schedulestatus ss,")
						.append(" scheduleplan   sp,organization   org,schedule s,")
						.append("  route    r,station   st")
						.append(" where v.unitid = u.id and vr.scheduleid = s.id")
						.append("   and s.routeid = r.id  and r.endstationid = st.id")
						.append("   and vr.scheduleplanid = ss.scheduleplanid")
						.append("   and sp.id = ss.scheduleplanid  and vr.reportorgid = org.id")
						.append("   and org.stationid = ss.departstationid and v.id = vr.vehicleid")
						.append("   and vr.id =:lv_reportid  and vr.driver1id = d1.id(+)")
						.append("   and vr.driver2id = d2.id(+) and vr.vehicleid =:vehicleid")
						.append("   and vr.departdate =:departdate");
				query = outstationupmoneyDao.getEntityManager()
						.createNativeQuery(sql.toString());
				query.setParameter("lv_reportid", lv_reportid);
				query.setParameter("vehicleid", vehicleid);
				query.setParameter("departdate", departdate);
				list = query.getResultList();
			}
		} else {
			// 若当天有开过结算单
			Departinvoices dp = dps.get(0);
			filters.clear();
			filters.add(new PropertyFilter("EQL_t!scheduleplanid", dp
					.getScheduleplanid()));
			filters.add(new PropertyFilter("EQL_t!orgid", global
					.getOrganization().getId()));
			List<Outstationcheck> slist = outstationupmoneyDao.find(
					Outstationcheck.class, filters);
			if (slist == null || slist.size() == 0) {
				// 若本次结算单未出站过，
				sql = new StringBuilder();
				long lv_reportid = dp.getReportid();
				sql.append(
						"select vr.id,vr.reporttime,vr.scheduleplanid,s.id scheduleid,")
						.append(" trim(ss.departtime),v.seatnum,u.name unitname,(select sum(d.ticketnum) ticketnum")
						.append(" from departinvoices d where d.status <> '1'")
						.append(" and d.reportid =:lv_reportid) ticketnum,")
						.append(" st.name || ' ' || s.code || ' [' || ss.departtime || ']' schinfo,")
						.append(" FN_ISvalidate(v.workenddate) runnochk,")
						.append(" FN_ISvalidate(v.licenseenddate) driverlicensechk,")
						.append(" '0' checkresult,")
						.append(" FN_ISvalidate(v.maintainvaliddate) maintainchk,")
						.append(" 0 roadnochk,vr.driver1id,vr.driver2id,d1.name driver1name,")
						//添加查询乘务员字段
						.append(" vr.steward1id,")
						//
						.append(" FN_ISvalidate(d1.drivinglicenseenddate) drivinglicense1chk,")
						.append(" FN_ISvalidate(d1.qualificationenddate) qualification1chk,")
						.append(" FN_ISvalidate(d1.workenddate) workno1chk,")
						.append(" d2.name driver2name,")
						.append(" FN_ISvalidate(d2.drivinglicenseenddate) drivinglicense2chk,")
						.append(" FN_ISvalidate(d2.qualificationenddate) qualification2chk,")
						.append(" FN_ISvalidate(d2.workenddate) workno2chk,")
						.append(" sp.carrychildnum")
						.append(" from vehiclereport  vr,vehicle v,driver d1,")
						.append("  driver d2,unit u, schedulestatus ss,")
						.append(" scheduleplan   sp,organization   org,schedule s,")
						.append("  route    r,station   st")
						.append(" where v.unitid = u.id and vr.scheduleid = s.id")
						.append("   and s.routeid = r.id  and r.endstationid = st.id")
						.append("   and vr.scheduleplanid = ss.scheduleplanid")
						.append("   and sp.id = ss.scheduleplanid  and vr.reportorgid = org.id")
						.append("   and org.stationid = ss.departstationid and v.id = vr.vehicleid")
						.append("   and vr.id =:lv_reportid  and vr.driver1id = d1.id(+)")
						.append("   and vr.driver2id = d2.id(+) and vr.vehicleid =:vehicleid")
						.append("   and vr.departdate =:departdate");
				query = outstationupmoneyDao.getEntityManager()
						.createNativeQuery(sql.toString());
				query.setParameter("lv_reportid", lv_reportid);
				query.setParameter("vehicleid", vehicleid);
				query.setParameter("departdate", departdate);
				list = query.getResultList();

			} else {
				// 若本次结算单已经出站过，则取最新报到记录
				sql = new StringBuilder(
						"select t from Vehiclereport t where 1=1 ");
				filters.clear();
				filters.add(new PropertyFilter("EQD_t!departdate", departdate));
				filters.add(new PropertyFilter("EQL_t!vehicleid", vehicleid));
				filters.add(new PropertyFilter("EQL_t!reportorgid", global
						.getOrganization().getId()));
				filters.add(new PropertyFilter("EQB_t!isactive", true));
				sql.append(PropertyFilter.toJpql(filters, true));
				sql.append(" order by createtime desc");
				query = outstationupmoneyDao.getEntityManager().createQuery(
						sql.toString(), Vehiclereport.class);
				JPAPropertyFilterUtil.setParameter(query, filters);
				List<Vehiclereport> vlist = query.getResultList();
				long lv_reportid = vlist.get(0).getId();
				sql = new StringBuilder();
				sql.append(
						"select vr.id,vr.reporttime,vr.scheduleplanid,s.id scheduleid,")
						.append(" trim(ss.departtime),v.seatnum,u.name unitname,(select sum(d.ticketnum) ticketnum")
						.append(" from departinvoices d where d.status <> '1'")
						.append(" and d.reportid =:lv_reportid) ticketnum,")
						.append(" st.name || ' ' || s.code || ' [' || ss.departtime || ']' schinfo,")
						.append(" FN_ISvalidate(v.workenddate) runnochk,")
						.append(" FN_ISvalidate(v.licenseenddate) driverlicensechk,")
						.append(" '0' checkresult,")
						.append(" FN_ISvalidate(v.maintainvaliddate) maintainchk,")
						.append(" 0 roadnochk,vr.driver1id,vr.driver2id,d1.name driver1name,")
						//添加查询乘务员字段
						.append(" vr.steward1id,")
						//
						.append(" FN_ISvalidate(d1.drivinglicenseenddate) drivinglicense1chk,")
						.append(" FN_ISvalidate(d1.qualificationenddate) qualification1chk,")
						.append(" FN_ISvalidate(d1.workenddate) workno1chk,")
						.append(" d2.name driver2name,")
						.append(" FN_ISvalidate(d2.drivinglicenseenddate) drivinglicense2chk,")
						.append(" FN_ISvalidate(d2.qualificationenddate) qualification2chk,")
						.append(" FN_ISvalidate(d2.workenddate) workno2chk,")
						.append(" sp.carrychildnum")
						.append(" from vehiclereport  vr,vehicle v,driver d1,")
						.append("  driver d2,unit u, schedulestatus ss,")
						.append(" scheduleplan   sp,organization   org,schedule s,")
						.append("  route    r,station   st")
						.append(" where v.unitid = u.id and vr.scheduleid = s.id")
						.append("   and s.routeid = r.id  and r.endstationid = st.id")
						.append("   and vr.scheduleplanid = ss.scheduleplanid")
						.append("   and sp.id = ss.scheduleplanid  and vr.reportorgid = org.id")
						.append("   and org.stationid = ss.departstationid and v.id = vr.vehicleid")
						.append("   and vr.id =:lv_reportid  and vr.driver1id = d1.id(+)")
						.append("   and vr.driver2id = d2.id(+) and vr.vehicleid =:vehicleid")
						.append("   and vr.departdate =:departdate");
				query = outstationupmoneyDao.getEntityManager()
						.createNativeQuery(sql.toString());
				query.setParameter("lv_reportid", lv_reportid);
				query.setParameter("vehicleid", vehicleid);
				query.setParameter("departdate", departdate);
				list = query.getResultList();
			}

		}
		return ListUtil.listToMap(new Object[] { "id","reporttime",
				"scheduleplanid", "scheduleid", "departtime", "seatnum",
				"unitname", "ticketnum", "schinfo", "runnochk",
				"driverlicensechk", "checkresult", "maintainchk", "roadnochk",
				"driver1id", "driver2id", "driver1name","steward1id", "drivinglicense1chk",
				"qualification1chk", "workno1chk", "driver2name",
				"drivinglicense2chk", "qualification2chk", "workno2chk",
				"carrychildnum" }, list, new Object[] { Long.class,Timestamp.class,
				Long.class, Long.class, String.class, Long.class, String.class,
				Long.class, String.class, String.class, String.class,
				String.class, String.class, String.class, Long.class,
				Long.class, String.class,Long.class, String.class, String.class,
				String.class, String.class, String.class, String.class,
				String.class, Long.class });
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public boolean deleteOutstationupmoney(Outstationupmoney outstationupmoney)
			throws ServiceException {
		// TODO Auto-generated method stub
		outstationupmoneyDao.del(outstationupmoney);
		return true;
	}

	@Override
	public List<Map<String, Object>> queryOutstationcheck(
			List<PropertyFilter> propertyFilters) {
		// TODO Auto-generated method stub
		StringBuilder sql = new StringBuilder("select st.id, st.departdate,")
				.append(" s.code,st.departtime||'',r.name routename,")
				.append(" v.vehicleno,u.name unitname,st.reporttime,")
				.append(" st.outtime,st.seatnums,st.carrypeople,st.factpeople,")
				.append(" st.fillpeople, st.runnochk,st.driverlicensechk,")
				.append(" st.buscheckchk, st.maintainchk,st.roadnochk,")
				.append(" st.driver1,st.drivinglicense1chk, st.qualification1chk,")
				.append(" st.workno1chk, st.driver2, st.drivinglicense2chk,")
				.append(" st.qualification2chk, st.workno2chk,uf.name checker,st.createtime,")
				.append(" st.isoverload ,st.iscomplete,st.isseatbelts,st.childnum,st.steward1")
				.append(" from outstationcheck st, vehicle v, unit u, userinfo uf, schedule s,route r")
				.append(" where st.vehicleid = v.id and s.routeid=r.id(+)")
				.append(" and st.checker = uf.id and st.scheduleid = s.id(+) and v.unitid = u.id");
		sql.append(PropertyFilter.toJpql(propertyFilters, true));
		Query query = outstationupmoneyDao.createEntityManager()
				.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		List<Object> list = query.getResultList();
		return ListUtil.listToMap(new Object[] { "id", "departdate", "code",
				"departtime", "routename", "vehicleno", "unitname",
				"reporttime", "outtime", "seatnums", "carrypeople",
				"factpeople", "fillpeople", "runnochk", "driverlicensechk",
				"buscheckchk", "maintainchk", "roadnochk", "driver1",
				"drivinglicense1chk", "qualification1chk", "workno1chk",
				"driver2", "drivinglicense2chk", "qualification2chk",
				"workno2chk", "checker", "createtime", "isoverload",
				"iscomplete", "isseatbelts", "childnum","steward1"}, list, new Object[] {
				Long.class, Date.class, String.class, String.class,
				String.class, String.class, String.class, Timestamp.class,
				Timestamp.class, Long.class, Long.class, Long.class,
				Long.class, String.class, String.class, String.class,
				String.class, String.class, String.class, String.class,
				String.class, String.class, String.class, String.class,
				String.class, String.class, String.class, Timestamp.class,
				boolean.class, boolean.class, boolean.class, Long.class,String.class});
	}

	@Override
	public Outstationcheck saveOutstationcheck(Outstationcheck ost)
			throws ServiceException {
		// TODO Auto-generated method stub
		List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
		filters.clear();
		filters.add(new PropertyFilter("EQL_t!scheduleplanid", ost.getScheduleplanid()));
		filters.add(new PropertyFilter("EQL_t!orgid", ost.getOrgid()));
		List<Outstationcheck> vlist = outstationupmoneyDao.find(Outstationcheck.class, filters);
		Scheduleplan sp=(Scheduleplan) outstationupmoneyDao.get(Scheduleplan.class, ost.getScheduleplanid());
		ost.setOuttime(new Date());
		if(vlist!=null && vlist.size()>0){
			if(sp!=null && sp.getIslinework()){
				// 2029出站例检中,流水班是否只报到一次
				String allowmoresave = parameterService.findParamValue(ParamterConst.Param_2029,
						ost.getOrgid());
				if (allowmoresave.equals(ParamterConst.COMMON_FLAG.FALG_NO)) {
					// 该车辆出站信息已保存
					throw new ServiceException("0464");
				}
			}else{
				// 该车辆出站信息已保存
				throw new ServiceException("0464");
			}
		}
		ost=(Outstationcheck) outstationupmoneyDao.merge(ost);
		return ost;
	}

	@Override
	public boolean delOutstationcheck(long id) throws ServiceException {
		// TODO Auto-generated method stub
		Outstationcheck ot=(Outstationcheck) outstationupmoneyDao.get(Outstationcheck.class, id);
		outstationupmoneyDao.del(ot);
		return true;
	}

	@Override
	public List<Map<String, Object>> qryVehicledriverreport(Date departdate,
			long vehiclereportid) {
		return ListUtil.listToMap(new Object[] {"driverid", "drivername",
				"ddrivinglicenseres", "dqualificationres", "vdriverlicenseres",
				"vworknores", "vroadnores", "dworknores", "vnotenum",
				"driversign", "classmember", "dispatcher","stewardname" },
				outstationupmoneyDao.qryVehicledriverreport(departdate,
						vehiclereportid), new Object[] {long.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class, String.class });
	}

	@Override
	public List<Map<String, Object>> qryArriveStationCheck(Date departdate,long vehicleid) {
		return ListUtil.listToMap(new Object[]{"checkdriver1id","checkdriver2id","checkstewardid"},
				outstationupmoneyDao.qryArriveStationCheck(departdate, vehicleid),
				new Object[]{long.class,long.class,long.class});
	}

}
