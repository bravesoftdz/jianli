/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.dispatch.service.impl<br/>
 * <b>文件名：</b>SchedulestatusStopServiceImpl.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2011-9-18-上午11:27:21<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.dispatch.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import util.UserTransaction;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.dispatch.dao.DispatchServiceDao;
import cn.nova.bus.dispatch.model.Schedulecancel;
import cn.nova.bus.dispatch.model.Schedulestatuslog;
import cn.nova.bus.dispatch.model.Vehiclelost;
import cn.nova.bus.dispatch.service.SchedulestatusStopService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.log.service.OperationLogService;
import cn.nova.bus.log.service.impl.OperationLogServiceImpl;
import cn.nova.bus.price.dao.GenScheduleplanServiceDao;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleplanlog;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：实现班次批量停班功能，采用bean自制事务</b><br/>
 * <b>类名称：</b>SchedulestatusStopServiceImpl<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */

public class SchedulestatusStopServiceImpl implements SchedulestatusStopService {

	
	private GenScheduleplanServiceDao genScheduleplanServiceDao = new GenScheduleplanServiceDao();

	
	private DispatchServiceDao dispatchServiceDao = new DispatchServiceDao();

	@Resource
	private UserTransaction userTransaction = new UserTransaction();

	
	private OperationLogService operationLogService = new OperationLogServiceImpl();

	/*
	 * stop方法：实现停班过程<br/> <br/>
	 * 
	 * @param scheduleplanlog
	 * 
	 * @return
	 * 
	 * @throws ServiceException
	 * 
	 * @see
	 * cn.nova.bus.dispatch.service.SchedulestatusStopService#stop(cn.nova.bus
	 * .price.model.Scheduleplanlog)
	 * 
	 * @exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> stopSchedule(Scheduleplanlog scheduleplanlog,Vehiclelost vehiclelost,Schedulecancel schedulecancel)
			throws ServiceException {
		List<Object> results = new ArrayList<Object>();
		Date startdate = scheduleplanlog.getStartdate();
		Date enddate = scheduleplanlog.getEnddate();
		long createby = scheduleplanlog.getCreateby();
		int days = DateUtils.getIntervalDays(startdate, enddate);
		Date departdate = new Date();
		List<Schedule> schedulelist = null;
		// 循环天数
		for (int i = 0; i <= days; i++) {
			departdate = DateUtils.add(startdate, i);
			if ("2".equals(scheduleplanlog.getType())) {
				// 按选中班次生成,scheduleplanlog.getScheduleids()=="(12,13)"
				schedulelist = genScheduleplanServiceDao
						.qrySchedule(scheduleplanlog.getScheduleids());

			} else if ("1".equals(scheduleplanlog.getType())) {
				schedulelist = genScheduleplanServiceDao
						.qryScheduleByroute(scheduleplanlog.getTypeid(),departdate);
			} else {
				schedulelist = genScheduleplanServiceDao.qryScheduleByOrg(
						scheduleplanlog.getTypeid(), departdate);
			}
			// 循环班次
			for (Schedule schedule : schedulelist) {
				String result = "";
				try {
					userTransaction.begin();
					try {
						String departdatestr = StringUtils
								.dateToStr(departdate);
						Scheduleplan scheduleplan = dispatchServiceDao
								.qryScheduleplan(schedule.getId(), departdate);
						if (scheduleplan != null) {
							Station station = (Station) dispatchServiceDao.get(
									Station.class,
									scheduleplan.getEndstationid());
							result = "发车日期：" + departdatestr + "，到站："
									+ station.getName() + ",班次号："
									+ schedule.getCode();
							if(stopScheduleplan(scheduleplanlog.getOrgid(),
									scheduleplanlog.getDepartstationid(),
									scheduleplan, createby,schedulecancel,scheduleplanlog,departdate,vehiclelost.getReason())){
								result = result + "停班处理成功！";
								if (scheduleplan.getSoldeatnum() > 0) {
									result = result + "但该班次已售票:"
											+ scheduleplan.getSoldeatnum() + "张";
								}
								result = result + "停班处理成功！";
								if (scheduleplan.getSoldeatnum() > 0) {
									result = result + "但该班次已售票:"
											+ scheduleplan.getSoldeatnum() + "张";
								}
								Vehiclelost vl=new Vehiclelost();
								vl.setCreateby(scheduleplanlog.getCreateby());
								vl.setCreatetime(new Date());
								vl.setDepartdate(departdate);
								vl.setForfeit(new BigDecimal(0));
								vl.setIsautolost(false);
								vl.setIspunish(false);
								vl.setOrgid(scheduleplan.getOrgid());
								vl.setReason(vehiclelost.getReason());
								vl.setReportname(vehiclelost.getReportname());
								vl.setLoststatus(vehiclelost.getLoststatus());
								vl.setStatus("1");//报停
								vl.setScheduleid(scheduleplan.getScheduleid());
								vl.setScheduleplanid(scheduleplan.getId());
								if (vehiclelost.getVehicle()!=null){
									Vehicle v=(Vehicle) dispatchServiceDao.get(Vehicle.class, vehiclelost.getVehicle().getId());
									vl.setVehicle(v);
									vl.setUnitid(v.getUnitid());								
								}else{
									vl.setUnitid(vehiclelost.getUnitid());
									vl.setVehicle(vehiclelost.getVehicle());
								}
								dispatchServiceDao.merge(vl);
					
							}else{
								result = result + "停班处理失败，原因是该班次已经停班或发班！";
								
							}
							// 保存操作日志
							Operationlog operationLog = new Operationlog();
							operationLog.setIp(scheduleplanlog.getIp());
							operationLog.setContent(result);
							operationLog.setModule("综合调度->停班");
							operationLog.setOperatetime(new Date());
							operationLog.setOperation("停班");
							operationLog.setSessionid("无session");
							operationLog.setUserid(scheduleplanlog
									.getCreateby());
							operationLogService.savelog(operationLog);			
						}else{
							result=result+"发车日期："+departdatestr+"，停班处理失败，没有班次信息！";
						}
						userTransaction.commit();  
					} catch (Exception ex) {
						userTransaction.rollback();
						play.Logger.error(ex.getMessage(), ex);
						result = result + "停班处理失败！";
					}
				} catch (Exception ex) {
					result = result + "停班处理失败！";
					play.Logger.error(ex.getMessage(), ex);
				}
				results.add(result);
			}// 循环班次
		}// 循环天数
		if (results.size() == 0) {
			results.add("没有可报停班次！");
		}
		return ListUtil.listToMap(new Object[] { "result" }, results,
				new Object[] { String.class });
	}

	@SuppressWarnings("unchecked")
	private boolean stopScheduleplan(long orgid, long departstationid,
			Scheduleplan scheduleplan, long createby,Schedulecancel schedulecancel, Scheduleplanlog scheduleplanlog,
			Date departdate,String remarks) throws ServiceException {
		List<Schedulestatus> schedulestatuslist = scheduleplan
				.getSchedulestatuslist();
		// 始发站停班
		if (scheduleplan.getStartstationid() == departstationid) {
			for (Schedulestatus schedulestatus : schedulestatuslist) {
				if(schedulestatus.getStatus().equals("1") || schedulestatus.getIsdeparted()){
					return false;
				}
				String beforestatus = schedulestatus.getStatus();
				// 正常、晚点
				if (beforestatus.equals("0") || beforestatus.equals("2")) {
					String afterstatus = "1";// 报停
					schedulestatus.setUpdateby(createby);
					schedulestatus.setStatus(afterstatus);
					schedulestatus.setUpdatetime(new Date());
					Schedulestatus ss = (Schedulestatus)dispatchServiceDao.merge(schedulestatus);
					//---------------------班次停班新增表--------------------------	
					Schedulecancel sc = new Schedulecancel();
					sc.setCreateby(scheduleplanlog.getCreateby());
					sc.setCreatetime(new Date());
					sc.setUpdateby(scheduleplanlog.getCreateby());
					sc.setUpdatetime(new Date());
					sc.setDepartdate(departdate);
					if(remarks!=null&&!remarks.equals("")){
						sc.setRemarks(remarks);
					}
					sc.setReturnallpriceflag(schedulecancel.getReturnallpriceflag());
					sc.setDepartstationid(scheduleplan.getStartstationid());
					sc.setScheduleid(scheduleplan.getScheduleid());
					sc.setSchedulestatusid(ss.getId());
					sc.setReason(schedulecancel.getReason());
					dispatchServiceDao.merge(sc);
					//-----------------------------------------------
					
					// 记录日志操作
					Schedulestatuslog schedulestatuslog = new Schedulestatuslog();
					schedulestatuslog.setAfterstatus(afterstatus);
					schedulestatuslog.setBeforestatus(beforestatus);
					schedulestatuslog.setCreateby(createby);
					schedulestatuslog.setCreatetime(new Date());
					schedulestatuslog.setDepartdate(scheduleplan
							.getDepartdate());
					schedulestatuslog.setOperationtype("0");// 报停 操作
					schedulestatuslog.setOrgid(orgid);// 登录站的机构ID
					schedulestatuslog.setScheduleid(scheduleplan
							.getScheduleid());
					dispatchServiceDao.merge(schedulestatuslog);
				}
			}
			//不需要修改票价表的是否可售状态
			/*List<Ticketprice> tps = scheduleplan.getTicketpricelist();
			for (Ticketprice tp : tps) {
				tp.setIssellable(false);
				tp.setUpdateby(createby);
				tp.setUpdatetime(new Date());
				dispatchServiceDao.merge(tp);
			}*/
			scheduleplan.setIssellable(false);
			scheduleplan.setUpdateby(createby);
			scheduleplan.setUpdatetime(new Date());
			dispatchServiceDao.merge(scheduleplan);
		} else {
			// 若是配客站点报停班次
			for (Schedulestatus schedulestatus : schedulestatuslist) {
				if (scheduleplan.getStartstationid() != departstationid) {
					if(schedulestatus.getStatus().equals("1") || schedulestatus.getIsdeparted()){
						return false;
					}
					String beforestatus = schedulestatus.getStatus();
					// 正常、晚点
					if (beforestatus.equals("0") || beforestatus.equals("2")) {
						String afterstatus = "1";// 报停
						schedulestatus.setUpdateby(createby);
						schedulestatus.setStatus(afterstatus);
						schedulestatus.setUpdatetime(new Date());
						Schedulestatus ss = (Schedulestatus)dispatchServiceDao.merge(schedulestatus);
						//---------------------班次停班新增表--------------------------
						Schedulecancel sc = new Schedulecancel();
						sc.setCreateby(scheduleplanlog.getCreateby());
						sc.setCreatetime(new Date());
						sc.setUpdateby(scheduleplanlog.getCreateby());
						sc.setUpdatetime(new Date());
						sc.setDepartdate(departdate);
						sc.setReturnallpriceflag(schedulecancel.getReturnallpriceflag());
						sc.setDepartstationid(scheduleplan.getStartstationid());
						sc.setScheduleid(scheduleplan.getScheduleid());
						sc.setReason(schedulecancel.getReason());
						sc.setSchedulestatusid(ss.getId());
						if(remarks!=null&&!remarks.equals("")){
							sc.setRemarks(remarks);
						}
						dispatchServiceDao.merge(sc);
						//-----------------------------------------------
						// 记录日志操作
						Schedulestatuslog schedulestatuslog = new Schedulestatuslog();
						schedulestatuslog.setAfterstatus(afterstatus);
						schedulestatuslog.setBeforestatus(beforestatus);
						schedulestatuslog.setCreateby(createby);
						schedulestatuslog.setCreatetime(new Date());
						schedulestatuslog.setDepartdate(scheduleplan
								.getDepartdate());
						schedulestatuslog.setOperationtype("0");// 报停 操作
						schedulestatuslog.setOrgid(orgid);// 登录站的机构ID
						schedulestatuslog.setScheduleid(scheduleplan
								.getScheduleid());
						dispatchServiceDao.merge(schedulestatuslog);
					}
				}
			}
		}
		return true;
	}

	@Override
	public List<Map<String, Object>> updateSchedulestatus(
			Scheduleplanlog scheduleplanlog,Vehiclelost vehiclelost,Schedulecancel schedulecancl) throws ServiceException {
		if("S".equals(scheduleplanlog.getOperationtype())){
			return stopSchedule(scheduleplanlog,vehiclelost,schedulecancl);
		}
		else
		{
			return saleTickets(scheduleplanlog);	
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> saleTickets(Scheduleplanlog scheduleplanlog)
			throws ServiceException {
		List<Object> results = new ArrayList<Object>();
		Date startdate = scheduleplanlog.getStartdate();
		Date enddate = scheduleplanlog.getEnddate();
		long createby = scheduleplanlog.getCreateby();
		int days = DateUtils.getIntervalDays(startdate, enddate);
		Date departdate = new Date();
		List<Schedule> schedulelist = null;
		// 循环天数
		for (int i = 0; i <= days; i++) {
			departdate = DateUtils.add(startdate, i);
			if ("2".equals(scheduleplanlog.getType())) {
				// 按选中班次生成,scheduleplanlog.getScheduleids()=="(12,13)"
				schedulelist = genScheduleplanServiceDao
						.qrySchedule(scheduleplanlog.getScheduleids());

			} else if ("1".equals(scheduleplanlog.getType())) {
				schedulelist = genScheduleplanServiceDao
						.qryScheduleByroute(scheduleplanlog.getTypeid(),departdate);
			} else {
				schedulelist = genScheduleplanServiceDao.qryScheduleByOrg(
						scheduleplanlog.getTypeid(), departdate);
			}
			// 循环班次
			for (Schedule schedule : schedulelist) {
				String result = "";
				try {
					userTransaction.begin();
					try {
						String departdatestr = StringUtils
								.dateToStr(departdate);
						Scheduleplan scheduleplan = dispatchServiceDao
								.qryScheduleplan(schedule.getId(), departdate);
						
						Schedulecancel schedulecancel = dispatchServiceDao.qrySchedulecancel(schedule.getId(), departdate);
						
						if (scheduleplan != null) {
							Station station = (Station) dispatchServiceDao.get(
									Station.class,
									scheduleplan.getEndstationid());
							result = "发车日期：" + departdatestr + "，到站："
									+ station.getName() + ",班次号："
									+ schedule.getCode();
							saleScheduleplan(scheduleplanlog.getOrgid(),
									scheduleplanlog.getDepartstationid(),
									scheduleplan, createby);
							
							Vehiclelost vlost=dispatchServiceDao.qryVehiclelost(scheduleplan.getId());
							if (vlost!=null){
								dispatchServiceDao.getEntityManager().remove(vlost);
							}
							
							if(schedulecancel!=null){
								//只要全额退款为1就提示不允许复班；
								if(schedulecancel.getReturnallpriceflag()){
									result = result + "复班失败，原因：该班次允许全额退款！" ;
									userTransaction.rollback();
								}
								//提醒为1；全额退款为0，删除记录
								if(!schedulecancel.getReturnallpriceflag()){
									result = result + "复班处理成功！";
									dispatchServiceDao.delete(schedulecancel);
								}
							}else{
								result = result + "复班处理成功！";
							}
//							
//							result = result + "复班处理成功！";
							// 保存操作日志
							Operationlog operationLog = new Operationlog();
							operationLog.setIp(scheduleplanlog.getIp());
							operationLog.setContent(result);
							operationLog.setModule("综合调度->复班");
							operationLog.setOperatetime(new Date());
							operationLog.setOperation("复班");
							operationLog.setSessionid("无session");
							operationLog.setUserid(scheduleplanlog
									.getCreateby());
							operationLogService.savelog(operationLog);
						}
						userTransaction.commit();  
					} catch (Exception ex) {
						userTransaction.rollback();
						play.Logger.error(ex.getMessage(), ex);
						result = result + "复班处理失败！";
					}
				} catch (Exception ex) {
					result = result + "复班处理失败！";
					play.Logger.error(ex.getMessage(), ex);
				}
				results.add(result);
			}// 循环班次
		}// 循环天数
		if (results.size() == 0) {
			results.add("没有可报复班班次！");
		}
		return ListUtil.listToMap(new Object[] { "result" }, results,
				new Object[] { String.class });
	}

	@SuppressWarnings("unchecked")
	private void saleScheduleplan(long orgid, long departstationid,
			Scheduleplan scheduleplan, long createby) throws ServiceException {
		List<Schedulestatus> schedulestatuslist = scheduleplan
				.getSchedulestatuslist();
		// 始发站停班
		if (scheduleplan.getStartstationid() == departstationid) {
			for (Schedulestatus schedulestatus : schedulestatuslist) {
				String beforestatus = schedulestatus.getStatus();
				// 报停
				if (beforestatus.equals("1")) {
					String afterstatus = "0";// 正常
					schedulestatus.setUpdateby(createby);
					schedulestatus.setStatus(afterstatus);
					schedulestatus.setUpdatetime(new Date());
					dispatchServiceDao.merge(schedulestatus);
					// 记录日志操作
					Schedulestatuslog schedulestatuslog = new Schedulestatuslog();
					schedulestatuslog.setAfterstatus(afterstatus);
					schedulestatuslog.setBeforestatus(beforestatus);
					schedulestatuslog.setCreateby(createby);
					schedulestatuslog.setCreatetime(new Date());
					schedulestatuslog.setDepartdate(scheduleplan
							.getDepartdate());
					schedulestatuslog.setOperationtype("1");// 恢复 操作
					schedulestatuslog.setOrgid(orgid);// 登录站的机构ID
					schedulestatuslog.setScheduleid(scheduleplan
							.getScheduleid());
					dispatchServiceDao.merge(schedulestatuslog);
				}
			}
			//不修改票价表
			/*List<Ticketprice> tps = scheduleplan.getTicketpricelist();
			for (Ticketprice tp : tps) {
				tp.setIssellable(true);
				tp.setUpdateby(createby);
				tp.setUpdatetime(new Date());
				dispatchServiceDao.merge(tp);
			}*/
			scheduleplan.setIssellable(true);
			scheduleplan.setUpdateby(createby);
			scheduleplan.setUpdatetime(new Date());

			dispatchServiceDao.merge(scheduleplan);
		} else {
			// 若是配客站点报停班次
			for (Schedulestatus schedulestatus : schedulestatuslist) {
				if (scheduleplan.getStartstationid() != departstationid) {
					String beforestatus = schedulestatus.getStatus();
					// 报停
					if (beforestatus.equals("1")) {
						String afterstatus = "0";//正常、晚点
						schedulestatus.setUpdateby(createby);
						schedulestatus.setStatus(afterstatus);
						schedulestatus.setUpdatetime(new Date());
						dispatchServiceDao.merge(schedulestatus);
						// 记录日志操作
						Schedulestatuslog schedulestatuslog = new Schedulestatuslog();
						schedulestatuslog.setAfterstatus(afterstatus);
						schedulestatuslog.setBeforestatus(beforestatus);
						schedulestatuslog.setCreateby(createby);
						schedulestatuslog.setCreatetime(new Date());
						schedulestatuslog.setDepartdate(scheduleplan
								.getDepartdate());
						schedulestatuslog.setOperationtype("1");// 恢复报停 操作
						schedulestatuslog.setOrgid(orgid);// 登录站的机构ID
						schedulestatuslog.setScheduleid(scheduleplan
								.getScheduleid());
						dispatchServiceDao.merge(schedulestatuslog);
					}
				}
			}
		}
	}
	
	/**
	 * 证件过期，自动停班
	 *  select scheduleplanid, min(orgid),min(departstationid), min(scheduleid), departdate, min(vehicleid), ")
		.append(" min(yyz), min(xsz), min(ewyxq), min(jqx), min(cyrx), min(dszzrx) ")
	 */
	public void autoStopScheduleplan() {
		List scheduleplans = dispatchServiceDao.qryAutoStopScheduleplans();//查询证件过期的班次计划
		Date createtime = new Date();
		for (Object object : scheduleplans) {
			Object[] array = (Object[]) object;
			Scheduleplanlog scheduleplanlog = new Scheduleplanlog();
			scheduleplanlog.setCreateby(0L);
			scheduleplanlog.setCreatetime(createtime);
			scheduleplanlog.setStartdate((Date) array[4]);
			scheduleplanlog.setEnddate((Date) array[4]);
			scheduleplanlog.setIp("localhost");
			scheduleplanlog.setOperationtype("S");//停班
			scheduleplanlog.setOrgid(((BigDecimal) array[1]).longValue());
			scheduleplanlog.setResult(null);
			scheduleplanlog.setType("2");//类型：班次
			scheduleplanlog.setTypeid(0L);
			scheduleplanlog.setUserid(0L);
			scheduleplanlog.setScheduleids("(" + ((BigDecimal)array[3]).longValue() +")");
			scheduleplanlog.setDepartstationid(((BigDecimal) array[2]).longValue());
			scheduleplanlog.setIsautogen(false);
			
			Vehiclelost vehiclelost = new Vehiclelost();
			vehiclelost.setBalanceid(0L);
			vehiclelost.setCreateby(0L);
			vehiclelost.setCreatetime(createtime);
			vehiclelost.setDepartdate((Date) array[4]);
			vehiclelost.setForfeit(null);
			vehiclelost.setIsautolost(true);//自动停班
			vehiclelost.setReason("车辆证件过期，自动停班");
			vehiclelost.setScheduleid(((BigDecimal)array[3]).longValue());
			vehiclelost.setScheduleplanid(((BigDecimal) array[0]).longValue());
			vehiclelost.setUnitid(0L);
			vehiclelost.setReportname("系统自动停班");
			vehiclelost.setStatus("1");//1 报停
			vehiclelost.setIspunish(false);//
//			vehiclelost.setVehicle((Vehicle) array[5]);
			vehiclelost.setOrgid(((BigDecimal) array[1]).longValue());
			
			//证件过期自动停班的班次在schedulecancel表中将
			Schedulecancel schedulecancel = new Schedulecancel();
			schedulecancel.setReturnallpriceflag(false);
			schedulecancel.setReason("车辆证件过期，自动停班");
			
			try {
				stopSchedule(scheduleplanlog, vehiclelost,schedulecancel);
			} catch (ServiceException e) {
				play.Logger.error("车辆证件过期自动停班失败：" + e.getMessage());
			}
		}
	}
	
}
