package cn.nova.bus.dispatch.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.LockModeType;

import models.TestParams;

import org.apache.commons.lang.StringUtils;

import util.CurrentUtil;
import util.JsonUtil;
import util.RemoteApi;
import util.RpcUtil;
import util.SystemFactory;
import util.TransactionUtil;
import cn.nova.bus.archive.model.Customer;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Ticketoutlets;
import cn.nova.bus.dispatch.dao.ScheduleseatsDao;
import cn.nova.bus.dispatch.dao.SeatlockDao;
import cn.nova.bus.dispatch.dao.SeatreserveDao;
import cn.nova.bus.dispatch.model.Seatreserve;
import cn.nova.bus.dispatch.model.Seatreserveagent;
import cn.nova.bus.dispatch.service.ScheduleplanService;
import cn.nova.bus.dispatch.service.ScheduleseatsService;
import cn.nova.bus.dispatch.service.SchedulestatusService;
import cn.nova.bus.dispatch.service.SeatreserveService;
import cn.nova.bus.dispatch.service.TicketpriceService;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.log.service.OperationLogService;
import cn.nova.bus.log.service.impl.OperationLogServiceImpl;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.sale.model.Seatlock;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.service.OrganizationService;
import cn.nova.bus.system.service.impl.OrganizationServiceImpl;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.ParamSeatreserve;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("unchecked")
public class SeatreserveServiceImpl implements SeatreserveService {
	final private int insideInvokFalse = -67101735;
	//@Resource
	//private SessionContext context;

	private SeatreserveDao dao = new SeatreserveDao();
	
	private ScheduleseatsDao scheduleseatsdao = new ScheduleseatsDao();
	
	private SeatlockDao seatlockDao = new SeatlockDao();
	
	private ScheduleplanService scheduleplanService = new ScheduleplanServiceImpl();
	
	private ScheduleseatsService scheduleseatsService = new ScheduleseatsServiceImpl();

	private SchedulestatusService schedulestatusService = new SchedulestatusServiceImpl();

	private TicketpriceService ticketpriceService = new TicketpriceServiceImpl();

	private OperationLogService operationLogService = new OperationLogServiceImpl();

	private OrganizationService organizationService = new OrganizationServiceImpl();

	@SuppressWarnings("unused")
	private MethodResult save(Seatreserve seatreserve) {
		MethodResult res = new MethodResult();
		Scheduleplan scheduleplan = scheduleplanService.getById(seatreserve
				.getScheduleplanid());
		seatreserve.setDepartdate(scheduleplan.getDepartdate());
		seatreserve.setOrgid(scheduleplan.getOrgid());
		List<Schedulestatus> schedulestatus = schedulestatusService
				.getSchedulestatus(scheduleplan.getId());
		// 判断Scheduleplan schedulestatus是否为空、是否已发班
		// 判断Scheduleseats是否为空、是否允许留位
		if (scheduleplan == null) {
			// throw new ServiceException("0148");
			res.setResult(0);
			res.setResultMsg("不存在该班次计划！");
			return res;
		}
		if (schedulestatus.size() <= 0) {
			// throw new ServiceException("0151");
			TransactionUtil.setRollbackOnly();
			res.setResult(0);
			res.setResultMsg("留位数不足！");
			return res;
		}
		for (int i = 0; i < schedulestatus.size(); i++) {
			if (seatreserve.getDepartstationid() == schedulestatus.get(i)
					.getDepartstationid()) {
				if (schedulestatus.get(i).getIsdeparted()) {
					// throw new ServiceException("0149");
					res.setResult(0);
					res.setResultMsg("该班次已经发班！");
					return res;
				}
			}
		}
		if (seatreserve.getCustomerid() > 0) {
			Customer customer = new Customer();
			customer.setId(seatreserve.getCustomerid());
			seatreserve.setCustomer(customer);
		}
		/*
		 * Ticketsell ts=dao.findTicketByseatno(scheduleplan.getId(),seatreserve.getSeatno()); if(ts!=null){
		 * 
		 * }
		 */
		res = saveSeatreserve(seatreserve);// 座位预留时增加记录、更新班次的座位状态
		saveTicketprice(seatreserve);// 更新 ticketprice
		if (seatreserve.isIsautocancel()) {
			short s = (short) (scheduleplan.getAutocancelreserveseatnum() + 1);
			scheduleplan.setAutocancelreserveseatnum(s);// 设置计划班次的自动取消留位数(之前预留的+留位的)
		} else {
			short s = (short) (scheduleplan.getUnautocancelreserveseatnum() + 1);
			scheduleplan.setUnautocancelreserveseatnum(s);// 设置计划班次的不自动取消留位数(之前预留的+留位的)
		}
		scheduleplan
				.setCarrychildnum((short) (scheduleplan.getCarrychildnum() + seatreserve
						.getCarrychildnum()));
		scheduleplanService.save(scheduleplan);// 更新scheduleplan
		return res;
	}

	@Override
	public MethodResult save(List<Seatreserve> seatreserves) {
		MethodResult res = new MethodResult();
		for (Seatreserve seatreserve : seatreserves) {
			Schedulestatus schedulestatus = dao.querySchedulestatusByScheduleplanid(seatreserve.getScheduleplanid(), seatreserve.getDepartstationid());
			if("1".equals(schedulestatus.getStatus())) {
				throw new BusinessException("该班次已停班,不允许订票或留位!");
			}
			if("3".equals(schedulestatus.getStatus())) {
				throw new BusinessException("该班次已被并,不允许订票或留位!");
			}
			if("4".equals(schedulestatus.getStatus())) {
				throw new BusinessException("该班次已脱班,不允许订票或留位!");
			}

			if (seatreserve.getDepartstationid() > 0) {
				Station station = new Station();
				station.setId(seatreserve.getDepartstationid());
				seatreserve.setDepartstation(station);
			}
			if (seatreserve.getReachstationid() > 0) {
				Station station = new Station();
				station.setId(seatreserve.getReachstationid());
				seatreserve.setReachstation(station);
			}
			if (seatreserve.getCustomerid() > 0) {
				Customer customer = new Customer();
				customer.setId(seatreserve.getCustomerid());
				seatreserve.setCustomer(customer);
			}
			//
			res = save(seatreserve);
			if (res.getResult() != 1) {
				TransactionUtil.setRollbackOnly();
				return res;
			}
		}
		res.setResultMsg("留位成功！");
		return res;
	}

//	private NetSeatreserveService getCentreInterface(MethodResult methodResult,
//			Organization localorg) {
//		Organization centreOrg = organizationService
//				.getDirectlyParentOrg(localorg);
//		if (centreOrg == null) {
//			methodResult.setResult(insideInvokFalse);
//			methodResult.setResultMsg("无法连接中心服务器:找不到" + localorg.getName()
//					+ "的上级机构");
//			return null;
//		}
//		try {
//			return (NetSeatreserveService) EJBFactory.getRemoteEJB(
//					NetSeatreserveService.class, centreOrg.getId());
//		} catch (NamingException e) {
//			methodResult.setResult(insideInvokFalse);
//			methodResult.setResultMsg("无法连接中心服务器:" + e.getMessage());
//			return null;
//		}
//	}

	// 综合调度的留位
	public MethodResult save(Seatreserve seatreserve, String seatnos) throws Exception {
		return save(null, seatreserve, seatnos);
	}
	
	@Override
	public MethodResult save(String remoteTransactionId, Seatreserve seatreserve, String seatnos) throws Exception {
		MethodResult res = new MethodResult();
		if (seatreserve.getId() == 0) {
			List<Seatreserve> seatreserves = new ArrayList<Seatreserve>();
			String no[] = seatnos.split(",");
			Seatreserve reserve = null;
			Schedule schedule = (Schedule) dao.get(Schedule.class,
					seatreserve.getScheduleid());
			Scheduleplan sp = (Scheduleplan) dao.get(Scheduleplan.class,
					seatreserve.getScheduleplanid());
			Station departstation = (Station) dao.get(Station.class,
					seatreserve.getDepartstationid());
			Station reachstation = (Station) dao.get(Station.class,
					schedule.getRoute().getEndstationid());
			Userinfo userinfo = (Userinfo) dao.get(Userinfo.class,
					seatreserve.getReserveby());
			Ticketoutlets ts = (Ticketoutlets) dao.get(Ticketoutlets.class,
					seatreserve.getTicketoutletsid());
			
			if (sp.getWorktype().equals("3")) {
				Organization organization = (Organization) dao.get(
						Organization.class, seatreserve.getOrgid());
//				NetSeatreserveService netSeatreserveService = getCentreInterface(
//						res, organization);
//				if (netSeatreserveService == null) {
//					return res;
//				}
				if(TestParams.getNewest().reserveSeat == 1){
					SystemFactory.markRtException();
				}
				ParamSeatreserve psr = new ParamSeatreserve();
				psr.setAutocanceltime(seatreserve.getAutocanceltime());
				psr.setCarrychildnum(seatreserve.getCarrychildnum());
				psr.setDepartdate(sp.getDepartdate());
				psr.setDepartstationcode(departstation.getCode());
				psr.setDeparttime(seatreserve.getDeparttime());
				psr.setFullprice(seatreserve.getFullprice());
				psr.setIsautocancel(seatreserve.isIsautocancel());
				psr.setOrgcode(organization.getCode());
				psr.setPlansynccode(sp.getSynccode());
				psr.setReachstationcode(reachstation.getCode());
				psr.setRemarks(seatreserve.getRemarks());
				psr.setReserveby(userinfo.getName());
				psr.setTicketoutletsname(ts.getName());
				psr.setReserveip(seatreserve.getReserveip());
				psr.setReservetime(seatreserve.getReservetime());
				psr.setReserveway(seatreserve.getReserveway());
				psr.setSchedulesynccode(schedule.getSynccode());
				psr.setIsautocancel(seatreserve.isIsautocancel());
				psr.setSeatnos(seatnos);
				psr.setSellstate(seatreserve.getSellstate());
				psr.setServiceprice(seatreserve.getServiceprice());
				psr.setTickettype(seatreserve.getTickettype());
				
				Map<String, String> requestMap = new HashMap<String, String>();
				requestMap.put("psr", JsonUtil.toFormatString(psr));
				requestMap.put("transactionid", remoteTransactionId);

				Organization centreOrg = organizationService.getDirectlyParentOrg(organization);
				CurrentUtil.setFlash("remoteurl", centreOrg.getServersaddress());
				CurrentUtil.setFlash("transactionid", remoteTransactionId);
				if(TestParams.getNewest().reserveSeat == 2){
					SystemFactory.markRtException();
				}
				res = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.SEAT_RESERVE, requestMap);		
				
//				res = netSeatreserveService.seatReserve(psr);
				if (res.getResult() != 1) {
					TransactionUtil.setRollbackOnly();
					if (res.getResultMsg()==null || "".equals(res.getResultMsg())){
						res.setResultMsg("远程留位失败!");
					}
					return res;
				}
			}
			for (int i = 0; i < no.length; i++) {
				reserve = new Seatreserve();
				reserve.setAutocanceltime(seatreserve.getAutocanceltime());
				reserve.setCancel(seatreserve.getCancel());
				reserve.setCanceltime(seatreserve.getCanceltime());
				reserve.setCarrychildnum(seatreserve.getCarrychildnum());
				reserve.setCreateby(seatreserve.getCreateby());
				reserve.setCreatetime(seatreserve.getCreatetime());
				reserve.setCustomer(seatreserve.getCustomer());
				reserve.setCustomerid(seatreserve.getCustomerid());
				reserve.setDepartdate(seatreserve.getDepartdate());
				reserve.setDepartstationid(seatreserve.getDepartstationid());
				reserve.setDepartstation(seatreserve.getDepartstation());
				reserve.setDeparttime(seatreserve.getDeparttime());
				reserve.setFullprice(seatreserve.getFullprice());
				reserve.setId(seatreserve.getId());
				reserve.setIsautocancel(seatreserve.isIsautocancel());
				reserve.setOrgid(seatreserve.getOrgid());
				reserve.setPassword(seatreserve.getPassword());
				reserve.setReachstation(reachstation);
				reserve.setRemarks(seatreserve.getRemarks());
				reserve.setReserveby(seatreserve.getReserveby());
				reserve.setReserveip(seatreserve.getReserveip());
				reserve.setReservetime(seatreserve.getReservetime());
				reserve.setReserveway(seatreserve.getReserveway());
				reserve.setScheduleid(seatreserve.getScheduleid());
				reserve.setScheduleplanid(seatreserve.getScheduleplanid());
				reserve.setSellstate(seatreserve.getSellstate());
				reserve.setServiceprice(seatreserve.getServiceprice());
				reserve.setTicketoutletsid(seatreserve.getTicketoutletsid());
				reserve.setTickettype(seatreserve.getTickettype());
				reserve.setTurnoverdetail(seatreserve.getTurnoverdetail());
				reserve.setUpdateby(seatreserve.getUpdateby());
				reserve.setUpdatetime(seatreserve.getUpdatetime());
				reserve.setSeatno(Short.parseShort(no[i]));
				seatreserves.add(reserve);
			}
			res = save(seatreserves);
		} else {
			dao.update(seatreserve);
			res.setResult(1);
			res.setResultMsg("留位售出成功！");
		}
		if(TestParams.getNewest().reserveSeat == 3){
			SystemFactory.markRtException();
		}
		return res;
	}

	private void saveTicketprice(Seatreserve seatreserve) {
		Scheduleseats scheduleseats = scheduleseatsService.findBySeatno(
				seatreserve.getScheduleplanid(), seatreserve.getSeatno());
		List<Ticketprice> list = ticketpriceService.getByScheduleplanSeattype(
				LockModeType.PESSIMISTIC_READ, seatreserve.getScheduleplanid(),
				scheduleseats.getSeattype());
		for (Ticketprice ticketprice : list) {
			// 不能改所有票价记录，只能改座位号对应的座位类型票价
			if (ticketprice.getSeatnos() != null
					&& !ticketprice.getSeatnos().trim().equals("")
					&& !ticketprice.getSeatnos().trim().equals("0")
					&& !ticketprice.getSeatnos().trim().equals("全部")) {
				String seattypeSeatnos = "," + ticketprice.getSeatnos().trim()
						+ ",";
				if (!seattypeSeatnos.contains("," + seatreserve.getSeatno()
						+ ",")) {
					continue;
				}
			}
			if (seatreserve.isIsautocancel()) {
				short num = (short) (ticketprice.getAutocancelreserveseatnum() + 1);
				ticketprice.setAutocancelreserveseatnum(num);
			} else {
				short num = (short) (ticketprice
						.getUnautocancelreserveseatnum() + 1);
				ticketprice.setUnautocancelreserveseatnum(num);
			}
			ticketprice.setUpdateby(seatreserve.getUpdateby());
			// 暂时不更新修改时间
			// ticketprice.setUpdatetime(seatreserve.getUpdatetime());
			ticketpriceService.save(ticketprice);
		}
	}

	private MethodResult saveSeatreserve(Seatreserve seatreserve) {
		MethodResult res = new MethodResult();
		Scheduleseats scheduleseats = scheduleseatsService.findBySeatno(
				seatreserve.getScheduleplanid(), seatreserve.getSeatno());
		seatreserve.setSeatno(seatreserve.getSeatno());
		if ("1".equals(scheduleseats.getStatus())) {
			Seatlock seatlock = seatlockDao.getSeatlock(
					seatreserve.getScheduleplanid(), seatreserve.getSeatno());
			if (seatlock != null) {
				if (seatreserve.getCreateby() == seatlock.getLockby()) {
					seatlockDao.delete(seatlock);// 如果是自己锁的位子可以留位，并将锁位表的这个座位号删除
				} else {
					TransactionUtil.setRollbackOnly();
					res.setResult(0);
					res.setResultMsg("座位号：" + seatreserve.getSeatno()
							+ "已经发生变化");
					return res;
					// throw new ServiceException(
					// "座位号：" + seatreserve.getSeatno(), "0159");// 在异常前面加上座位号
				}
			}
		} else if (!"0".equals(scheduleseats.getStatus())) {
			// throw new ServiceException("座位号：" + scheduleseats.getSeatno(),
			// "0150");
			res.setResult(0);
			res.setResultMsg("座位号：" + seatreserve.getSeatno() + "已经发生变化");
			return res;
		}
		if (seatreserve.isIsautocancel()) {
			scheduleseats.setStatus("4");
		} else {
			scheduleseats.setStatus("5");
		}

		scheduleseats.setUpdateby(seatreserve.getUpdateby());
		scheduleseats.setUpdatetime(seatreserve.getUpdatetime());
		dao.merge(seatreserve);// 座位预留时增加记录
		scheduleseatsdao.save(scheduleseats);// 更新班次的座位状态
		res.setResult(1);
		return res;
	}

	@Override
	public MethodResult cancelReserve(Seatreserve seatreserve, String seatnos) throws Exception {// 取消留位
		MethodResult res = new MethodResult();
		Scheduleplan scheduleplan = (Scheduleplan) dao.get(
				LockModeType.PESSIMISTIC_READ, Scheduleplan.class,
				seatreserve.getScheduleplanid());
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		List<Ticketprice> ticketprices = ticketpriceService
				.getByScheduleplanid(LockModeType.PESSIMISTIC_READ,
						seatreserve.getScheduleplanid());
		Schedule schedule = (Schedule) dao.get(Schedule.class,
				scheduleplan.getScheduleid());
		String[] no = new String[]{};
		if(StringUtils.isNotEmpty(seatnos)){
			no = seatnos.split(",");
		}
		

		if(TestParams.getNewest().cancelSeat == 1){
			SystemFactory.markRtException();
		}
		
		if (scheduleplan.getWorktype().equals("3")) {
			for (int i = 0; i < no.length; i++) {
				Seatreserve seats = dao.getSeatreserve(seatreserve.getScheduleplanid(), seatreserve.getDepartdate(), Short.parseShort(no[i]));
				if(seats == null){
					throw new Exception("非本站留位不能取消留位！");
				}
			}
			if(scheduleplan.getWorktype().equals("3") && StringUtils.isEmpty(seatnos)){
				throw new Exception("跨区配载班次留位只能在综合调度中取消！");
			}
			Organization organization = (Organization) dao.get(
					Organization.class, seatreserve.getOrgid());
//			NetSeatreserveService netSeatreserveService = getCentreInterface(
//					res, organization);
//			if (netSeatreserveService == null) {
//				return res;
//			}
			Station departstation = (Station) dao.get(Station.class,
					seatreserve.getDepartstationid());
			Station reachstation = (Station) dao.get(Station.class, schedule
					.getRoute().getEndstationid());
			Userinfo userinfo = (Userinfo) dao.get(Userinfo.class,
					seatreserve.getCancel().getId());
			Ticketoutlets ts = (Ticketoutlets) dao.get(Ticketoutlets.class,
					seatreserve.getTicketoutletsid());
			ParamSeatreserve psr = new ParamSeatreserve();
			psr.setAutocanceltime(seatreserve.getAutocanceltime());
			psr.setCarrychildnum(seatreserve.getCarrychildnum());
			psr.setDepartdate(scheduleplan.getDepartdate());
			psr.setDepartstationcode(departstation.getCode());
			psr.setDeparttime(seatreserve.getDeparttime());
			psr.setFullprice(seatreserve.getFullprice());
			psr.setIsautocancel(seatreserve.isIsautocancel());
			psr.setOrgcode(organization.getCode());
			psr.setPlansynccode(scheduleplan.getSynccode());
			psr.setReachstationcode(reachstation.getCode());
			psr.setRemarks(seatreserve.getRemarks());
			psr.setCancelby(userinfo.getName());
			psr.setTicketoutletsname(ts.getName());
			psr.setReserveip(seatreserve.getReserveip());
			psr.setReservetime(seatreserve.getReservetime());
			psr.setReserveway(seatreserve.getReserveway());
			psr.setSchedulesynccode(schedule.getSynccode());
			psr.setSeatnos(seatnos);
			psr.setSellstate(seatreserve.getSellstate());
			psr.setServiceprice(seatreserve.getServiceprice());
			psr.setTickettype(seatreserve.getTickettype());
			
			Map<String, String> requestMap = new HashMap<String, String>();
			requestMap.put("psr", JsonUtil.toFormatString(psr));

			Organization centreOrg = organizationService.getDirectlyParentOrg(organization);
			try{
				if(TestParams.getNewest().cancelSeat == 2){
					SystemFactory.markRtException();
				}
				res = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.CANCEL_RESERVE, requestMap);		
				
				if (res.getResult() != 1) {
					TransactionUtil.setRollbackOnly();
					return res;
				}
			}catch(Exception e){
				TransactionUtil.addCancelSeatRedo(requestMap, centreOrg.getServersaddress());
			}
		}

		// 保存操作日志
		Operationlog operationLog = new Operationlog();
		operationLog.setIp("127.0.0.1");
		operationLog.setModule("留座取消");
		operationLog.setOperatetime(new Date());
		operationLog.setOperation("留座取消");
		operationLog.setSessionid("....");
		operationLog.setUserid(seatreserve.getUpdateby());
		StringBuilder logcontent = new StringBuilder();
		logcontent.append("取消留座：发车日期：")
				.append(DateUtils.formatDate(scheduleplan.getDepartdate()))
				.append(";班次：").append(schedule.getCode());

		if (seatreserve.getId() == 0) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id",
					scheduleplan.getId()));
			List<Scheduleseats> scheduleseatss = dao.find(
					LockModeType.PESSIMISTIC_READ, Scheduleseats.class,
					propertyFilters);
			for (int i = 0; i < no.length; i++) {
				Seatreserve reserve = null;
				Scheduleseats _scheduleseat = null;
				for (Scheduleseats scheduleseat : scheduleseatss) {
					if (scheduleseat.getSeatno() == Short.parseShort(no[i])) {
						_scheduleseat = scheduleseat;
						break;
					}
				}
				if (!(_scheduleseat.getStatus().equals("3")
						|| _scheduleseat.getStatus().equals("4") || _scheduleseat
						.getStatus().equals("5"))) {
					TransactionUtil.setRollbackOnly();
					return res;
				}
				if ("3".equals(_scheduleseat.getStatus())) {
					// 固定留位取消只记录日志
					scheduleplan.setFixedreserveseatnum((short) (scheduleplan
							.getFixedreserveseatnum() - 1));
				} else {
					reserve = getSeatreserve(seatreserve.getScheduleplanid(),
							null, Short.parseShort(no[i]));
					if ("4".equals(_scheduleseat.getStatus())) {
						scheduleplan
								.setAutocancelreserveseatnum((short) (scheduleplan
										.getAutocancelreserveseatnum() - 1));
						scheduleplan.setCarrychildnum((short) (scheduleplan
								.getCarrychildnum() - reserve
								.getCarrychildnum()));
					} else if ("5".equals(_scheduleseat.getStatus())) {
						scheduleplan
								.setUnautocancelreserveseatnum((short) (scheduleplan
										.getUnautocancelreserveseatnum() - 1));
						scheduleplan.setCarrychildnum((short) (scheduleplan
								.getCarrychildnum() - reserve
								.getCarrychildnum()));
					}
					reserve.setSellstate("C");
					reserve.setCancel(seatreserve.getCancel());

					reserve.setCanceltime(seatreserve.getCanceltime());
					reserve.setUpdateby(seatreserve.getUpdateby());
					reserve.setUpdatetime(seatreserve.getUpdatetime());

					seatreserve.setSeatno(Short.parseShort(no[i]));
					dao.merge(reserve);
				}

				for (Ticketprice ticketprice : ticketprices) {
					if (_scheduleseat.getSeattype().equals(
							ticketprice.getSeattype())) {
						if ("3".equals(_scheduleseat.getStatus())) {
							ticketprice
									.setFixedreserveseatnum((short) (ticketprice
											.getFixedreserveseatnum() - 1));
						} else if ("4".equals(_scheduleseat.getStatus())) {
							 ticketprice
								.setAutocancelreserveseatnum((short) (ticketprice
										.getAutocancelreserveseatnum() - 1));
							if (ticketprice.getAutocancelreserveseatnum()<0){
								ticketprice.setAutocancelreserveseatnum((short) 0);	
							}
						} else if ("5".equals(_scheduleseat.getStatus())) {
							  ticketprice
								.setUnautocancelreserveseatnum((short) (ticketprice
										.getUnautocancelreserveseatnum() - 1));
							if(ticketprice.getUnautocancelreserveseatnum()<0){
								ticketprice.setUnautocancelreserveseatnum((short) 0);
							}
						}
						ticketprice.setUpdateby(seatreserve.getUpdateby());
						ticketprice.setUpdatetime(seatreserve.getUpdatetime());
						dao.merge(ticketprice);
					}
				}
				_scheduleseat.setStatus("0");
				_scheduleseat.setUpdateby(seatreserve.getUpdateby());
				_scheduleseat.setUpdatetime(seatreserve.getUpdatetime());
				dao.merge(_scheduleseat);// 更新班次的座位状态

			}
			res.setResult(1);
			logcontent.append("座位号：").append(seatnos);
			operationLog.setContent(logcontent.toString());
			operationLogService.savelog(operationLog);
			scheduleplanService.save(scheduleplan);
			if(TestParams.getNewest().cancelSeat == 3){
				SystemFactory.markRtException();
			}
			return res;
		} else {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id",
					scheduleplan.getId()));
			propertyFilters.add(new PropertyFilter("EQR_t!seatno", seatreserve
					.getSeatno()));
			Scheduleseats scheduleseats = (Scheduleseats) dao.uniqueResult(
					LockModeType.PESSIMISTIC_READ, Scheduleseats.class,
					propertyFilters);
			if (!(scheduleseats.getStatus().equals("3")
					|| scheduleseats.getStatus().equals("4") || scheduleseats
					.getStatus().equals("5"))) {
				TransactionUtil.setRollbackOnly();
				return res;
			}

			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplanid",
					scheduleplan.getId()));
			propertyFilters.add(new PropertyFilter("EQR_t!seatno", seatreserve
					.getSeatno()));
			propertyFilters.add(new PropertyFilter("EQS_t!sellstate", "R"));
			Seatreserve reserve = (Seatreserve) dao.uniqueResult(
					LockModeType.PESSIMISTIC_READ, Seatreserve.class,
					propertyFilters);
			reserve.setSellstate("C");
			reserve.setCancel(seatreserve.getCancel());
			reserve.setCanceltime(seatreserve.getCanceltime());
			reserve.setAutocanceltime(null);
			reserve.setUpdateby(seatreserve.getUpdateby());
			reserve.setUpdatetime(seatreserve.getUpdatetime());

			dao.merge(reserve);// 座位预留时增加记录

			for (Ticketprice ticketprice : ticketprices) {
				if (scheduleseats.getSeattype().equals(
						ticketprice.getSeattype())) {
					if ("3".equals(scheduleseats.getStatus())) {
						ticketprice.setFixedreserveseatnum((short) (ticketprice
								.getFixedreserveseatnum() - 1));
					} else if ("4".equals(scheduleseats.getStatus())) {
						 ticketprice
							.setAutocancelreserveseatnum((short) (ticketprice
									.getAutocancelreserveseatnum() - 1));
						if (ticketprice.getAutocancelreserveseatnum()<0){
							ticketprice.setAutocancelreserveseatnum((short) 0);	
						}
				   } else if ("5".equals(scheduleseats.getStatus())) {
						  ticketprice
							.setUnautocancelreserveseatnum((short) (ticketprice
									.getUnautocancelreserveseatnum() - 1));
						if(ticketprice.getUnautocancelreserveseatnum()<0){
							ticketprice.setUnautocancelreserveseatnum((short) 0);
						}
					}
					ticketprice.setUpdateby(seatreserve.getUpdateby());
					ticketprice.setUpdatetime(seatreserve.getUpdatetime());
					dao.merge(ticketprice);
				}
			}

			if ("3".equals(scheduleseats.getStatus())) {
				scheduleplan.setFixedreserveseatnum((short) (scheduleplan
						.getFixedreserveseatnum() - 1));
			} else if ("4".equals(scheduleseats.getStatus())) {
				scheduleplan.setAutocancelreserveseatnum((short) (scheduleplan
						.getAutocancelreserveseatnum() - 1));
				scheduleplan.setCarrychildnum((short) (scheduleplan
						.getCarrychildnum() - reserve.getCarrychildnum()));
			} else if ("5".equals(scheduleseats.getStatus())) {
				scheduleplan
						.setUnautocancelreserveseatnum((short) (scheduleplan
								.getUnautocancelreserveseatnum() - 1));
				scheduleplan.setCarrychildnum((short) (scheduleplan
						.getCarrychildnum() - reserve.getCarrychildnum()));
			}
			scheduleseats.setStatus("0");
			scheduleseats.setUpdateby(seatreserve.getUpdateby());
			scheduleseats.setUpdatetime(seatreserve.getUpdatetime());
			scheduleseatsdao.save(scheduleseats);// 更新班次的座位状态

			logcontent.append("座位号：").append(seatreserve.getSeatno());
			operationLog.setContent(logcontent.toString());
			operationLogService.savelog(operationLog);
			dao.save(scheduleplan);
			res.setResult(1);
			if(TestParams.getNewest().cancelSeat == 3){
				SystemFactory.markRtException();
			}
			return res;
		}
	}

	@Override
	public boolean delete(Seatreserve schedulestatus) {
		return dao.delete(schedulestatus);
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Seatreserve.class, id);
	}

	@Override
	public List<Object> querySingleTable(List<PropertyFilter> propertyFilterList) {
		return dao.query(Seatreserve.class, propertyFilterList);
	}

	@Override
	public Seatreserve getById(Long id) {
		return (Seatreserve) dao.get(Seatreserve.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		
		Object[] field = new Object[] { "id", "departdate",
				"departtime", "fullprice", "seatno", "serviceprice",
				"reservetime", "sellstate", "createtime", "updatetime",
				"schedulecode", "orgname", "sellstate", "departstationname",
				"reachstationname", "ticketoutletname", "reservename",
				"createname", "updatename", "routename", "tickettypename",
				"customername", "certificatetype", "certificateno",
				"familyphone", "mobilephone", "customerid", "autocanceltime",
				"scheduleplanid", "canceltime", "isautocancel" };
		Object[] date = new Object[] { Long.class,
				Timestamp.class, String.class, BigDecimal.class,
				String.class, BigDecimal.class, Timestamp.class,
				String.class, Timestamp.class, Timestamp.class,
				String.class, String.class, String.class, String.class,
				String.class, String.class, String.class, String.class,
				String.class, String.class, String.class, String.class,
				String.class, String.class, String.class, String.class,
				Long.class, Timestamp.class, Long.class,
				Timestamp.class, Boolean.class };
		List<Object> returndate = dao.query(propertyFilterList);
		List<Map<String, Object>> list = ListUtil.listToMap(field,
				returndate,date );
		 return list; 
	}

	@SuppressWarnings("rawtypes")
	@Override
	public boolean isUniqu(short seatno, String sellstate) {
		List list = dao.getlist(seatno, sellstate);
		if (list.isEmpty()) {
			return false;
		}
		return true;
	}

	@Override
	public Seatreserve getSeatreserve(Long scheduleplanid, Date departdate,
			short seatno) {
		return dao.getSeatreserve(scheduleplanid, departdate, seatno);
	}

	@Override
	public Long getId(Long scheduleplanid, short seatno) {
		Long id = dao.getId(scheduleplanid, seatno);
		if (id == null) {
			return (long) 0;
		} else {
			return id;
		}
	}

	@Override
	public List<Seatreserve> getSeatreserveno(Date date) {
		return dao.querySeatreserve(date);
	}

	@Override
	public Seatreserve saveReserve(Seatreserve reserve) {
		return (Seatreserve) dao.merge(reserve);
	}


	@Override
	public int querybookunsellcount(long customerid) {
		return dao.querybookunsellcount(customerid);
	}

	@Override
	public Seatreserveagent getAgentById(Long id) {
		return (Seatreserveagent) dao.get(Seatreserveagent.class, id);
	}

}