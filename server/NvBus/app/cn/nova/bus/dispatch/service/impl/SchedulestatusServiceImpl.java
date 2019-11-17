package cn.nova.bus.dispatch.service.impl;

import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeoutException;

import javax.persistence.Column;
import javax.persistence.LockModeType;
import javax.persistence.Query;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.apache.commons.beanutils.PropertyUtils;

import play.db.jpa.JPA;
import util.CurrentUserID;
import util.CurrentUtil;
import util.JsonUtil;
import util.RemoteApi;
import util.RpcUtil;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Vehiclebrandmodel;
import cn.nova.bus.base.model.Vehicletype;
import cn.nova.bus.dispatch.dao.SchedulestatusDao;
import cn.nova.bus.dispatch.model.SyncSchedule;
import cn.nova.bus.dispatch.model.SyncScheduleplan;
import cn.nova.bus.dispatch.model.SyncSchedulestatus;
import cn.nova.bus.dispatch.model.SyncSchedulevehiclepeopleplan;
import cn.nova.bus.dispatch.model.SyncTicketprice;
import cn.nova.bus.dispatch.service.SchedulestatusService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.log.service.OperationLogService;
import cn.nova.bus.log.service.impl.OperationLogServiceImpl;
import cn.nova.bus.netsale.service.NetTicketSellOtherService;
import cn.nova.bus.netsale.service.impl.NetTicketSellOtherServiceImpl;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Schedulevehiclepeopleplan;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.OrganizationServiceImpl;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("unchecked")
public class SchedulestatusServiceImpl implements SchedulestatusService {

	
	private SchedulestatusDao dao = new SchedulestatusDao();

	
	private OperationLogService operationLogService = new OperationLogServiceImpl();

	
	private ParameterService parameterService = new ParameterServiceImpl();

	@Override
	public boolean save(Schedulestatus schedulestatus) {
		if (schedulestatus.getId() == 0) {
			return dao.save(schedulestatus);
		} else {
			return dao.update(schedulestatus);
		}
	}

	@Override
	public boolean delete(Schedulestatus schedulestatus) {
		return dao.delete(schedulestatus);
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Schedulestatus.class, id);
	}

	@Override
	public List<Schedulestatus> query() {
		return dao.query(Schedulestatus.class, null);
	}

	@Override
	public Schedulestatus getById(Long id) {
		return (Schedulestatus) dao.get(Schedulestatus.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList, long curstationid,
			Date fromdate, Date enddate, boolean isfullseat) throws ServiceException {
		if(propertyFilterList!=null && propertyFilterList.size() >0){
			for(int i=propertyFilterList.size()-1;i>=0;i--){	
			PropertyFilter propertyFilter=propertyFilterList.get(i);
			if("s!id".equals(propertyFilter.getPropertyFullName())){
				long id= (Long) propertyFilter.getMatchValue();
				if(id>0){
					String schedulecode=dao.queryScheduleCode(id);
					PropertyFilter propertyFilter_new =new PropertyFilter("LIKES_s!code",schedulecode);
					propertyFilterList.remove(propertyFilter);
					propertyFilterList.add(propertyFilter_new);			
				}
			}
		}
		}
		List<Map<String, Object>> result = ListUtil.listToMap(
				new Object[] { "schtype", "autocancelreserveseatnum",
						"unautocancelreserveseatnum", "departtime",
						"id", "departdate", "seatnum",
						"fixedreserveseatnum", "soldeatnum",
						"issellable", "workways", "districttype",
						"scheduletype", "isproprietary", "isovertime",
						"departname", "schedulename", "unitname",
						"startroutename", "endroutename", "begincheck",
						"vehicleno", "reportvehicleno", "status",
						"ticketentrance", "buspark", "viastation",
						"driver1", "driver2", "driver3", "steward1",
						"steward2", "vtname", "routename",
						"schedulevehiclepeopleplanid",
						"schedulestatusid", "vehicletypeid",
						"vehiclebrandmodelid", "scheduleid", "orgid",
						"planvehicleid", "d1id", "d2id", "d3id",
						"s1id", "s2id", "islinework", "routeid",
						"reservenum", "isdeparted",
						"issaleafterreport", "runtime", "worktype",
						"isoriginator", "issellreturnticket",
						"iscanmixcheck", "brandmodelname", "orgname",
						"reporttime", "departstationid", "planunit",
						"remarks", "carrychildnum","starttime","departinvoicesno","planunitid",
						"localsell", "othersell" ,"synccode","fullprice","distance",
						"isreport","reportid","reportvehicleid","reportorgid","returnallpriceflag"
				}, dao.query(propertyFilterList, curstationid, fromdate,
						enddate, isfullseat), new Object[] {
						String.class, Short.class, Short.class,
						String.class, Long.class, Date.class,
						Short.class, Short.class, Short.class,
						Boolean.class, String.class, String.class,
						String.class, Boolean.class, Boolean.class,
						String.class, String.class, String.class,
						String.class, String.class, Boolean.class,
						String.class, String.class, String.class,
						String.class, String.class, String.class,
						String.class, String.class, String.class,
						String.class, String.class, String.class,
						String.class, Long.class, Long.class,
						Long.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Boolean.class,
						Long.class, short.class, Boolean.class,
						Boolean.class, BigDecimal.class, String.class,
						Boolean.class, Boolean.class, Boolean.class,
						String.class, String.class, Timestamp.class,
						Long.class, String.class, String.class,
						Short.class, String.class,String.class,Long.class, Integer.class,
						Integer.class,String.class ,BigDecimal.class,Integer.class,
						Boolean.class,Long.class,Long.class,Long.class,Boolean.class});
		List<Map<String,Object>> splist = new ArrayList<Map<String,Object>>();
		for (Map<String, Object> m  : result) {
			if("3".equals(m.get("worktype").toString())){
				Map<String,Object> map = new HashMap<String, Object>();
				map.put("scheduleplanid",m.get("id").toString());
				map.put("synccode", m.get("synccode").toString());
				splist.add(map);
			}
		}
		Global global = CurrentUtil.getGlobal();
		NetTicketSellOtherService ns = new NetTicketSellOtherServiceImpl();
		try {
			if(splist.size()>0){
				List<Map<String, Object>> netsplist = ns.findNetSoldnum(splist, global);
				for (Map<String, Object> map  : result) {
					if("3".equals(map.get("worktype").toString())){
						for (Map<String, Object> netmap : netsplist) {
							if((netmap.get("scheduleplanid").toString()).equals(map.get("id").toString())){
								short soldnum = Short.parseShort(netmap.get("soldnum").toString());
								short soldselfnum = Short.parseShort(netmap.get("soldselfnum").toString());
								short autocancelreserveseatnum = Short.parseShort(netmap.get("autocancelreserveseatnum").toString());
								short unautocancelreserveseatnum = Short.parseShort(netmap.get("unautocancelreserveseatnum").toString());
								short fixedreserveseatnum = Short.parseShort(map.get("fixedreserveseatnum").toString());
								short seatnum = Short.parseShort(map.get("seatnum").toString());
								map.put("soldeatnum",soldnum);
								map.put("localsell", soldselfnum);
								map.put("othersell", soldnum-soldselfnum);
								map.put("autocancelreserveseatnum", autocancelreserveseatnum);
								map.put("unautocancelreserveseatnum", unautocancelreserveseatnum);
								map.put("reservenum",seatnum-soldnum-fixedreserveseatnum-autocancelreserveseatnum-unautocancelreserveseatnum);
								break;
							}
						}
					}
					
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return  result;
	}

	@Override
	public List<Schedulestatus> getSchedulestatus(Long scheduleplanid) {
		return dao.getSchedulestatus(scheduleplanid);
	}

	@Override
	public List<Map<String, Object>> queryTicketprice(
			List<PropertyFilter> buildFromHttpRequest) {
		return ListUtil.listToMap(new Object[] { Ticketprice.class,
				"departstationname", "reachstationname", "scheduleplanid",
				"schedulecode" }, dao.queryTicketprice(buildFromHttpRequest),
				new Object[] { Ticketprice.class, String.class, String.class,
						Long.class, String.class });
	}

	@Override
	public boolean saveStarttime(Schedulestatus schedulestatus, Long day,
			String ip) throws ServiceException {
		Schedulestatus status = null;
		Date curdepartdate = schedulestatus.getDepartdate();
		for (int i = 0; i < day; i++) {
			Schedulestatus schedule = dao.getByScheduleid(
					schedulestatus.getScheduleid(), curdepartdate,
					schedulestatus.getDepartstationid());
			if (schedule == null) {
				Schedule sc = (Schedule) dao.get(Schedule.class,
						schedulestatus.getScheduleid());
				throw new ServiceException(sc.getCode() + "班次 "
						+ String.format("%tF", curdepartdate) + "日期,", "0314");
			}
			status = (Schedulestatus) dao.get(LockModeType.PESSIMISTIC_READ,
					Schedulestatus.class, schedule.getId());

			Operationlog operationLog = new Operationlog();
			Schedule sch = (Schedule) dao.get(Schedule.class,
					status.getScheduleid());
			String result = "调整发车时间,班次号：" + sch.getCode() + " 发车日期："
					+ DateUtils.formatDate(status.getDepartdate())
					+ "调整发车时间,发车时间由" + status.getDeparttime() + "改为"
					+ schedulestatus.getDeparttime();
			operationLog.setIp(ip);
			operationLog.setContent(result);
			operationLog.setModule("综合调度->营运计划调整");
			operationLog.setOperatetime(new Date());
			operationLog.setOperation("调整发车时间");
			operationLog.setSessionid("无session");
			operationLog.setUserid(schedulestatus.getUpdateby());
			dao.merge(operationLog);

			status.setDeparttime(schedulestatus.getDeparttime());
			status.setUpdateby(schedulestatus.getUpdateby());
			status.setUpdatetime(new Timestamp(System.currentTimeMillis()));
			dao.merge(status);

			curdepartdate = DateUtils.add(curdepartdate, 1);
		}
		return true;
	}

	@Override
	public boolean updateIssaleafterreport(long scheduleplanid, Global global)
			throws ServiceException {
		Scheduleplan scheduleplan = (Scheduleplan) dao.get(Scheduleplan.class,
				scheduleplanid);
		if (scheduleplan.getIssaleafterreport()) {
			scheduleplan.setIssaleafterreport(false);
		} else {
			scheduleplan.setIssaleafterreport(true);
		}
		scheduleplan.setUpdateby(global.getUserinfo().getId());
		scheduleplan.setUpdatetime(new Date());
		dao.getEntityManager().merge(scheduleplan);

		Operationlog operationLog = new Operationlog();
		Schedule schedule = (Schedule) dao.get(Schedule.class,
				scheduleplan.getScheduleid());
		String result = "调整报到后售票,班次号：" + schedule.getCode() + " 发车日期:"
				+ DateUtils.formatDate(scheduleplan.getDepartdate());
		if (scheduleplan.getIssaleafterreport()) {
			result = result + " 由正常售票调整为报到后售票";
		} else {
			result = result + " 由报到后售票调整为正常售票";
		}
		operationLog.setIp(global.getIpAddress());
		operationLog.setContent(result);
		operationLog.setModule("综合调度->营运计划调整");
		operationLog.setOperatetime(new Date());
		operationLog.setOperation("调整车辆");
		operationLog.setSessionid(global.getSessionID());
		operationLog.setUserid(global.getUserinfo().getId());
		dao.merge(operationLog);
		return true;
	}

	@Override
	public boolean updateTicketentrancepark(long departstationid,
			Date startdate, Date enddate, String scheduleids, String buspark,
			String ticketentrance, String ip, long updateby)
			throws ServiceException {
		int days = DateUtils.getIntervalDays(startdate, enddate);
		Date departdate = new Date();
		String result = "批量修改:";
		result = result + "开始日期:" + DateUtils.formatDate(startdate) + ",结束日期："
				+ DateUtils.formatDate(enddate) + ",班次号:";
		String[] scheduleidarray = scheduleids.split(",");
		for (String scheduleid : scheduleidarray) {
			long curscheduleid = new Long(scheduleid);
			Schedule schedule = (Schedule) dao.get(Schedule.class,
					curscheduleid);
			result = result + schedule.getCode() + ",";
			// 循环天数
			for (int i = 0; i <= days; i++) {
				departdate = DateUtils.add(startdate, i);
				Schedulestatus ss = dao.qrySchedulestatus(departdate,
						curscheduleid, departstationid);
				if (ss == null) {
					continue;
				}
				ss.setBuspark(buspark);
				ss.setTicketentrance(ticketentrance);
				ss.setUpdateby(updateby);
				ss.setUpdatetime(new Date());
				dao.getEntityManager().merge(ss);
			}

		}
		result = result + "的检票口为->" + ticketentrance + ",乘车库为->" + buspark;
		// 保存操作日志
		Operationlog operationLog = new Operationlog();
		operationLog.setIp(ip);
		operationLog.setContent(result);
		operationLog.setModule("综合调度->修改车库检票口");
		operationLog.setOperatetime(new Date());
		operationLog.setOperation("修改车库检票口");
		operationLog.setSessionid("无session");
		operationLog.setUserid(updateby);
		operationLogService.savelog(operationLog);
		return true;
	}

	@Override
	public Date getAutoCanelSeatTime(long departstationid, long scheduleplanid)
			throws ServiceException {
		// 自动取消留位能留的最大小时数
		long cancelhour = new Long(parameterService.findParamByStation("1303",
				departstationid));
		Date maxcanceltime = new Date(System.currentTimeMillis() + cancelhour
				* 60 * 60 * 1000);
		Date lastcanceltime = new Date();
		long lastcancelminute = 0;
		Scheduleplan sp = (Scheduleplan) dao.get(Scheduleplan.class,
				scheduleplanid);
		List<Schedulestatus> sslist = sp.getSchedulestatuslist();
		for (Schedulestatus ss : sslist) {
			if (ss.getDepartstationid() == departstationid) {
				int schdistrict = new Integer(sp.getDistricttype());
				// 省内班次发车前N分钟自动取消留位
				if (schdistrict < 3) {
					lastcancelminute = new Long(
							parameterService.findParamByStation("1304",
									departstationid));
				} else {
					// 省外班次发车前N分钟自动取消留位
					lastcancelminute = new Long(
							parameterService.findParamByStation("1305",
									departstationid));
				}
				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				Date departdatetime = new Date();
				try {
					departdatetime = sf.parse(sf.format(ss.getDepartdate())
							.substring(0, 10) + " " + ss.getDeparttime());
				} catch (ParseException e) {
					play.Logger.error(e.getMessage(), e);
				}
				lastcanceltime = new Date(departdatetime.getTime()
						- lastcancelminute * 60 * 1000);
				if (maxcanceltime.compareTo(departdatetime) > 0) {
					if (lastcanceltime.compareTo(departdatetime) > 0) {
						return departdatetime;
					} else {
						return lastcanceltime;
					}
				} else {
					if (maxcanceltime.compareTo(lastcanceltime) > 0) {
						return lastcanceltime;
					} else {
						return maxcanceltime;
					}
				}

			}
		}
		return maxcanceltime;
	}

	@Override
	public boolean isStowageSch(long scheduleplanid) throws ServiceException {
		Scheduleplan sp = (Scheduleplan) dao.get(Scheduleplan.class,
				scheduleplanid);
		return sp.getSchedulestatuslist().size() > 1 ? true : false;
	}

	@Override
	public List<Map<String, Object>> qryTicketentrance(long departstationid,
			long scheduleid) throws ServiceException {
		List<Object> list = new ArrayList<Object>();
		Schedule schedule = (Schedule) dao.get(Schedule.class, scheduleid);
		StringBuilder sql = new StringBuilder("");
		if (schedule.getWorktype().equals("2")
				|| schedule.getWorktype().equals("3")) {
			sql.append(
					"select t.id,t.name,t.printname as code from Ticketentrance t,Organization o")
					.append(" where t.isactive=1 and t.orgid=o.id and o.id="
							+ schedule.getOrgid());

		} else {
			sql.append(
					"select t.id,t.name,t.printname as code from Ticketentrance t,Organization o")
					.append(" where t.isactive=1 and t.orgid=o.id and o.station.id="
							+ departstationid);
		}
		list = dao.find(sql.toString());
		return ListUtil.listToMap(new Object[] { "id", "name", "code" }, list,
				new Object[] { Long.class, String.class, String.class });
	}

	@Override
	public List<Map<String, Object>> qryVehiclepark(long departstationid,
			long scheduleid) throws ServiceException {
		List<Object> list = new ArrayList<Object>();
		Schedule schedule = (Schedule) dao.get(Schedule.class, scheduleid);
		StringBuilder sql = new StringBuilder("");
		if (schedule.getWorktype().equals("2")
				|| schedule.getWorktype().equals("3")) {
			sql.append(
					"select t.id,t.name,t.printname as code from Vehiclepark t,Organization o")
					.append(" where t.isactive=1 and t.orgid=o.id and o.id="
							+ schedule.getOrgid());

		} else {
			sql.append(
					"select t.id,t.name,t.printname as code from Vehiclepark t,Organization o")
					.append(" where t.isactive=1 and t.orgid=o.id and o.station.id="
							+ departstationid);
		}
		list = dao.find(sql.toString());
		return ListUtil.listToMap(new Object[] { "id", "name", "code" }, list,
				new Object[] { Long.class, String.class, String.class });
	}

	@Override
	public int updateScheduleStatus() {
		// TODO Auto-generated method stub
				
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String strdate = sf.format(new Date());		
		Date departdate = new Date();		
		try {
			departdate = sf.parse(strdate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			play.Logger.error(e.getMessage(), e);
		}
				
		List<Schedulestatus> sslist = dao.findCurSchedueStatus(departdate);
		Schedulestatus schedulestatus = new Schedulestatus();
		if(sslist != null && sslist.size() > 0){
			
		    for(int i=0;i<sslist.size();i++){
		    	schedulestatus = sslist.get(i);
		    	if (!schedulestatus.getIsbegincheck()){
		    		
		    		long orgid = 0;
		    		orgid = CurrentUserID.getOrgid();
		    		String param = "0"; 
		    	   if (orgid != 0 ){
		    		    param = parameterService.findParamValue("3018", orgid); //获取发车前n分钟停止检票
		    	   }
		    		
		    		
		    		 
		    		sf = new SimpleDateFormat("HH:mm");		    		
		    		String datetime = sf.format(new Date());		    		
		    		String[] str = datetime.split(":");						    		
		    		int a = Integer.parseInt(str[0])*60+Integer.parseInt(str[1])+Integer.parseInt(param);  //当前时间转换成分钟再加上系统参数3018		    		
		    		int b = a/60; //取小时		    		
		    		int c = a % 60;  //取分钟
		    		
		    		String curtime = String.valueOf(b)+":"+String.valueOf(c);
		    		
		    		dao.updateScheduleStatus(departdate, curtime);
		    	}
		    }
			
		}
		
		
		return 1;
	}

	@Override
	public List<Map<String,Object>> qryscheduleplan(Date departdate, long scheduleid) {	
		String sql="select ss from Scheduleplan sp, Schedule s,Schedulestatus ss "
				+ "where sp.scheduleid=s.id and sp.id=ss.scheduleplan.id and s.id=:scheduleid and  sp.departdate=:departdate";
		Query query=JPA.em().createQuery(sql);
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("departdate", departdate);
		List ss=query.getResultList();
		return ListUtil.listToMap(new Object[]{Schedulestatus.class},ss,new Object[]{Schedulestatus.class} );
	}
	
	public List<Map<String, Object>> checkticketstatus(Date departdate, String schedulecode) {
		String sql="SELECT t FROM Ticketsell t , Schedule s  where  s.id = t.scheduleid and s.code = :schedulecode  and t.departdate = :departdate";
		Query query=JPA.em().createQuery(sql);
		query.setParameter("schedulecode", schedulecode);
		query.setParameter("departdate", departdate);
		return ListUtil.listToMap(new Object[]{Ticketsell.class},query.getResultList(),new Object[]{Ticketsell.class} );
	}
	
	/**
	 * 综合调度同步班次功能：调用中心保存班次表、班次计划表、票价表、班次状态表、车辆人员计划表信息
	 */
	public MethodResult syncScheduleplan(Long scheduleplanid){
		//上传的数据均为List
		List<SyncSchedule> syncScheduleList = new ArrayList<SyncSchedule>();//班次表
		List<SyncScheduleplan> syncscheduleplanList = new ArrayList<SyncScheduleplan>();//班次计划表：除班次计划表外，还包含 票价表、班次状态表、车辆人员计划表
		
		Scheduleplan scheduleplan = dao.getEntityManager().find(Scheduleplan.class, scheduleplanid);//获取班次计划
		Schedule schedule = dao.getEntityManager().find(Schedule.class, scheduleplan.getScheduleid());//获取班次
		List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
		filters.clear();
		filters.add(new PropertyFilter("EQL_t!scheduleplan.id", scheduleplan.getId()));
		Schedulestatus schedulestatus = (Schedulestatus) dao.find(Schedulestatus.class, filters).get(0);//获取班次状态
		List<Schedulevehiclepeopleplan> schedulevehiclepeopleplanList = dao.find(Schedulevehiclepeopleplan.class, filters);//获取车辆人员计划
		List<Ticketprice> ticketprices = dao.find(Ticketprice.class, filters);//获取票价
		
		//构造班次同步表
		SyncSchedule syncSchedule = new SyncSchedule();
		try {
			PropertyUtils.copyProperties(syncSchedule, schedule);
		} catch (Exception e) {
			play.Logger.error("班次同步信息SyncSchedule复制对象属性报错", e);
		}
		syncSchedule.routesynccode = schedule.getRoute().getSynccode();
		syncSchedule.routecode = schedule.getRoute().getCode();
		Organization routeOrg = dao.getEntityManager().find(Organization.class, schedule.getRoute().getOrgid());
		syncSchedule.routeorgcode = routeOrg.getCode();
		Organization scheduleOrg = dao.getEntityManager().find(Organization.class, schedule.getOrgid());
		syncSchedule.orgcode = scheduleOrg.getCode();
		
		//构造班次状态同步表
		List<SyncSchedulestatus> schedulestatuslist = new ArrayList<SyncSchedulestatus>();
		SyncSchedulestatus syncSchedulestatus = new SyncSchedulestatus();
		try {
			PropertyUtils.copyProperties(syncSchedulestatus, schedulestatus);
		} catch (Exception e) {
			play.Logger.error("班次状态信息SyncSchedulestatus复制对象属性报错", e);
		}
		syncSchedulestatus.schedulesynccode = schedule.getSynccode();
		syncSchedulestatus.setSchedulecode(schedule.getCode());
		syncSchedulestatus.setScheduleorgname(scheduleOrg.getName());
		syncSchedulestatus.scheduleorgcode = scheduleOrg.getCode();
		Organization schedulestatusOrg = dao.getEntityManager().find(Organization.class, schedulestatus.getOrgid());
		syncSchedulestatus.setOrgname(schedulestatusOrg.getName());
		syncSchedulestatus.orgcode = schedulestatusOrg.getCode();
		Station ssDepartstation = dao.getEntityManager().find(Station.class, schedulestatus.getDepartstationid());
		syncSchedulestatus.setDepartstationname(ssDepartstation.getName());
		schedulestatuslist.add(syncSchedulestatus);
		
		//构造票价同步表
		List<SyncTicketprice> ticketpricelist = new ArrayList<SyncTicketprice>();
		for (Ticketprice ticketprice : ticketprices) {
			SyncTicketprice syncTicketprice = new SyncTicketprice();
			try {
				PropertyUtils.copyProperties(syncTicketprice, ticketprice);
			} catch (Exception e) {
				play.Logger.error("班次票价信息SyncTicketprice复制对象属性报错", e);
			}
			syncTicketprice.schedulesynccode = schedule.getSynccode();
			Station tpDepartstation = dao.getEntityManager().find(Station.class, ticketprice.getDepartstationid());
			syncTicketprice.setDepartstationname(tpDepartstation.getName());
			Station tpReachstation = dao.getEntityManager().find(Station.class, ticketprice.getReachstationid());
			syncTicketprice.setReachstationname(tpReachstation.getName());
			Organization tpOrg = dao.getEntityManager().find(Organization.class, ticketprice.getOrgid());
			syncTicketprice.setOrgname(tpOrg.getName());
			syncTicketprice.orgcode = tpOrg.getCode();
			syncTicketprice.setSchedulecode(schedule.getCode());
			
			ticketpricelist.add(syncTicketprice);
		}
		
		//构造班次车辆驾乘人员运行计划同步表
		List<SyncSchedulevehiclepeopleplan> schedulevehiclepeopleplanlist = new ArrayList<SyncSchedulevehiclepeopleplan>();
		for (Schedulevehiclepeopleplan schedulevehiclepeopleplan : schedulevehiclepeopleplanList) {
			SyncSchedulevehiclepeopleplan syncSchedulevehiclepeopleplan = new SyncSchedulevehiclepeopleplan();
			try {
				PropertyUtils.copyProperties(syncSchedulevehiclepeopleplan, schedulevehiclepeopleplan);
			} catch (Exception e) {
				play.Logger.error("班次车辆驾乘人员运行计划信息SyncSchedulevehiclepeopleplan复制对象属性报错", e);
			}
			syncSchedulevehiclepeopleplan.schedulesynccode = schedule.getSynccode();
			if(schedulevehiclepeopleplan.getPlandriver1() != null){
				syncSchedulevehiclepeopleplan.setPlandriver1idcard(schedulevehiclepeopleplan.getPlandriver1().getCode());//中心同步代码对此字段做了处理，取code字段的值
			}
			if(schedulevehiclepeopleplan.getPlandriver2() != null){
				syncSchedulevehiclepeopleplan.setPlandriver2idcard(schedulevehiclepeopleplan.getPlandriver2().getCode());
			}
			if(schedulevehiclepeopleplan.getPlandriver3() != null){
				syncSchedulevehiclepeopleplan.setPlandriver3idcard(schedulevehiclepeopleplan.getPlandriver3().getCode());
			}
			if(schedulevehiclepeopleplan.getPlandriver4() != null){
				syncSchedulevehiclepeopleplan.setPlandriver4idcard(schedulevehiclepeopleplan.getPlandriver4().getCode());
			}
			if(schedulevehiclepeopleplan.getPlansteward1() != null){
				syncSchedulevehiclepeopleplan.setPlansteward1idcard(schedulevehiclepeopleplan.getPlansteward1().getCode());
			}
			if(schedulevehiclepeopleplan.getPlansteward2() != null){
				syncSchedulevehiclepeopleplan.setPlansteward2idcard(schedulevehiclepeopleplan.getPlansteward2().getCode());
			}
			if(schedulevehiclepeopleplan.getPlanunit() != null){
				syncSchedulevehiclepeopleplan.setPlanunitname(schedulevehiclepeopleplan.getPlanunit().getName());
			}
			Vehiclebrandmodel vehiclebrandmodel = dao.getEntityManager().find(Vehiclebrandmodel.class, schedulevehiclepeopleplan.getPlanvehiclebrandmodelid());
			syncSchedulevehiclepeopleplan.setPlanvehiclebrandmodelname(vehiclebrandmodel.getBrandname());
			syncSchedulevehiclepeopleplan.setPlanvehiclebrandmodelcode(vehiclebrandmodel.getModelcode());
			if(schedulevehiclepeopleplan.getPlanvehicle() != null){
				syncSchedulevehiclepeopleplan.setPlanvehiclenno(schedulevehiclepeopleplan.getPlanvehicle().getVehicleno());
			}
			Vehicletype vehicletype = dao.getEntityManager().find(Vehicletype.class, schedulevehiclepeopleplan.getPlanvehicletypeid());
			syncSchedulevehiclepeopleplan.setPlanvehicletypename(vehicletype.getName());
			syncSchedulevehiclepeopleplan.setSchedulecode(schedule.getCode());
			syncSchedulevehiclepeopleplan.setOrgname(schedulestatusOrg.getName());//取班次状态的机构
			syncSchedulevehiclepeopleplan.orgcode = schedulestatusOrg.getCode();//取班次状态的机构
			schedulevehiclepeopleplanlist.add(syncSchedulevehiclepeopleplan);
		}
		
		//构造班次计划同步表：包含 票班次状态表、价表、车辆人员计划表
		SyncScheduleplan syncScheduleplan = new SyncScheduleplan();
		try {
			PropertyUtils.copyProperties(syncScheduleplan, scheduleplan);
		} catch (Exception e) {
			play.Logger.error("班次计划同步表SyncScheduleplan复制对象属性报错", e);
		}
		syncScheduleplan.schedulesynccode = schedule.getSynccode();
		syncScheduleplan.setOrgcode(scheduleOrg.getCode());//取班次机构
		syncScheduleplan.setSchedulecode(schedule.getCode());
		Station startstation = dao.getEntityManager().find(Station.class, scheduleplan.getStartstationid());//始发站
		syncScheduleplan.setStartstationname(startstation.getName());
		Station endstation = dao.getEntityManager().find(Station.class, scheduleplan.getEndstationid());//始发站
		syncScheduleplan.setEndstationname(endstation.getName());
		
		syncScheduleplan.setSchedulestatuslist(schedulestatuslist);//班次状态表
		syncScheduleplan.setTicketpricelist(ticketpricelist);//票价表
		syncScheduleplan.setSchedulevehiclepeopleplanlist(schedulevehiclepeopleplanlist);//车辆人员计划表
		
		
		//上传的数据均为List
		syncScheduleList.add(syncSchedule);//班次表
		syncscheduleplanList.add(syncScheduleplan);//班次计划同步表：包含 票班次状态表、价表、车辆人员计划表
		
		MethodResult methodResult = new MethodResult();
		try {
			Map<String, String> requestMap = new HashMap<String, String>();
			requestMap.put("scheduleList", JsonUtil.toFormatString(syncScheduleList));
			requestMap.put("scheduleplanList", JsonUtil.toFormatString(syncscheduleplanList));
			Organization centreOrg = new OrganizationServiceImpl().getDirectlyParentOrg(schedulestatusOrg);////取班次状态的机构记录的父机构
			if(centreOrg != null){
				methodResult = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.SYNC_SCHEDULEPLAN, requestMap);
			}else{
				methodResult.setResult(MethodResult.FAILURE);
				methodResult.setResultMsg("未设置上级机构，不允许同步班次计划信息！");
			}
		}catch(TimeoutException e){
			play.Logger.error("向NvCenter同步班次计划信息请求超时！" + org.apache.commons.lang.exception.ExceptionUtils.getFullStackTrace(e));
			methodResult.setResult(MethodResult.FAILURE);
			methodResult.setResultMsg("同步班次计划信息失败，请求超时！");
		} catch (Exception e) {
			play.Logger.error("同步班次计划信息失败：" + org.apache.commons.lang.exception.ExceptionUtils.getFullStackTrace(e));
			methodResult.setResult(MethodResult.FAILURE);
			if(methodResult.getResultMsg().isEmpty()){
				methodResult.setResultMsg("同步班次计划信息失败，请确认中心工程NvCenter是否正常运行！");
			}else{
				methodResult.setResultMsg("同步班次计划信息失败！");
			}
		}
		
		if(methodResult.getResult() == MethodResult.SUCCESS){
			methodResult.setResultMsg("同步班次：" + schedule.getCode() + "，发车日期：" + DateUtils.formatDate(scheduleplan.getDepartdate()) + "计划信息成功！");
		}
		return methodResult;
	}
}
