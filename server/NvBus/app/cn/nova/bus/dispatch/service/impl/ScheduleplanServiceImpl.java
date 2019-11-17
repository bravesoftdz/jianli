package cn.nova.bus.dispatch.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.persistence.EntityManager;
import javax.persistence.LockModeType;
import javax.persistence.Query;

import org.apache.commons.lang.StringUtils;

import models.RemoteTransaction;

import play.db.jpa.JPA;
import play.mvc.Http.Request;
import util.AppConstant;
import util.CurrentUtil;
import util.JsonUtil;
import util.RedisUtil;
import util.RemoteApi;
import util.RpcUtil;
import util.TransactionUtil;
import util.RedisUtil.RedisDBApp;
import util.TransactionUtil.TransactionType;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.checkticket.service.CheckticketService;
import cn.nova.bus.checkticket.service.impl.CheckticketServiceImpl;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.dao.SeatreserveDao;
import cn.nova.bus.dispatch.model.Seatreserve;
import cn.nova.bus.dispatch.service.ScheduleplanService;
import cn.nova.bus.dispatch.service.ScheduleseatsService;
import cn.nova.bus.dispatch.service.SeatreserveService;
import cn.nova.bus.dispatch.service.TicketpriceService;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.service.OrganizationService;
import cn.nova.bus.system.service.impl.OrganizationServiceImpl;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.RemoteInvokeAuxiliaryProperty;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;

@SuppressWarnings("deprecation")
public class ScheduleplanServiceImpl implements ScheduleplanService {

	
	private IDAO dao = new EntityManagerDaoSurport();
	private EntityManager em = JPA.em();

	@SuppressWarnings("unchecked")
	@Override
	public boolean save(Scheduleplan schedulestatus) {
		if (schedulestatus.getId() == 0) {
			return dao.save(schedulestatus);
		} else {
			return dao.update(schedulestatus);
		}
	}

	public MethodResult isCanmodifyNetScheduleSeatnum(Schedule schedule,Scheduleplan plan){
		MethodResult methodResult = new MethodResult();
		OrganizationService organizationService = new OrganizationServiceImpl();
		Map<String, String> requestMap = new HashMap<String, String>();
		requestMap.put("schedulesynccode", schedule.getSynccode());
		requestMap.put("scheduleplan", JsonUtil.toFormatString(plan));
		Organization centreOrg = organizationService.getDirectlyParentOrg(CurrentUtil.getGlobal().getOrganization());
		try {
			methodResult = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.CHECK_SEATNUM_MODIFY, requestMap);
		} catch (Exception e) {
			methodResult.setResult(1);
			methodResult.setResultMsg("远程调用失败！");
		}	
		return methodResult;
	}
	
	@SuppressWarnings({ "unchecked" })
	@Override
	public boolean saveseatnum(Scheduleplan plan, Long day, String ip,String seatstatus)
			throws ServiceException {
		ScheduleseatsService seatsService = new ScheduleseatsServiceImpl();
		SeatreserveService seatreserveService = new SeatreserveServiceImpl();
		Date curdepartdate = plan.getDepartdate();
		Schedule schedule = (Schedule) dao.get(Schedule.class,
				plan.getScheduleid());
		
		/*
		//注掉此处代码，原因：在综合调度页面增加了"同步班次"按钮，实现了同步到中心的功能；避免了此处中心不存在scheduleplan/schedulestatus记录则无法修改座位数的问题。
		//跨区配载修改座位数时，先远程修改中心的座位数
		if("3".equals(schedule.getWorktype())){
			MethodResult result = updateSeatnum(schedule, plan, day, CurrentUtil.getGlobal());
			if(result.getResult() != MethodResult.SUCCESS){
				play.Logger.error("NvCenter报错：" + result.getResultMsg());
				throw new BusinessException("综合调度-修改座位数失败！");
			}
		}
		*/
		
		for (int i = 0; i < day; i++) {
			Scheduleplan scplan = getByScheduleid(plan.getScheduleid(),
					curdepartdate);
			
			if (scplan == null) {
				throw new ServiceException(schedule.getCode() + "班次"
						+ String.format("%tF", curdepartdate) + "日期，", "0314");
			}
			long totalnum = scplan.getAutocancelreserveseatnum()
					+ scplan.getUnautocancelreserveseatnum()
					+ scplan.getFixedreserveseatnum() + scplan.getSoldeatnum();
			if ((plan.getSeatnum() - totalnum) < 0) {
				throw new ServiceException("0323");
			}
			Scheduleplan scheduleplan = null;
			if (schedule.getIslinework()) {
				scheduleplan = updateTicketpriceSeatnum(plan,
						scplan);// 修改票价表座位数
			} else {
			List<Scheduleseats> seatsList = seatsService.getScheduleList(scplan.getId());
			//调用中心，校验是否能修改坐位,只有调小时，才进行校验，看中心多余的坐位是否有售票和留位记录
			if("3".equals(scplan.getWorktype())&&plan.getSeatnum() < seatsList.size()){
				plan.setDepartdate(curdepartdate);
				MethodResult result = isCanmodifyNetScheduleSeatnum(schedule,plan);
				if(result.getResult()==0){
					throw new ServiceException("0818");
				}
			}
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			propertyFilters.add(new PropertyFilter("EQL_t!departstationid", CurrentUtil.getGlobal().getStationID()));
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", scplan.getId()));
			Schedulestatus schedulestatus = (cn.nova.bus.price.model.Schedulestatus) dao.uniqueResult(Schedulestatus.class, propertyFilters);
			if (schedulestatus!=null && schedulestatus.getIsreported()) {
				throw new BusinessException("该班次已经报班，不准许修改座位数!");
			}
			
			scheduleplan = updateTicketpriceSeatnum(plan, scplan);
			
			List<Scheduleseats> updatelist=new ArrayList<Scheduleseats>();//记录已更改数据
			if (plan.getSeatnum() < seatsList.size()) {// 如果是座位数是调小，则删除多出来的座位数
				Short num = seatsService.getSeatno(scheduleplan.getId());
				for (int j = 0; j < seatsList.size() - plan.getSeatnum(); j++) {
					Scheduleseats seats = seatsService.findBySeatno(
							scheduleplan.getId(), num);
					updatelist.add(seats);//新增已更改数据
					if ("0".equals(seats.getStatus())) {
						dao.delete(Scheduleseats.class, seats.getId());
					} else {
						List<Scheduleseats> scheduleseat = seatsService
								.getSchedulelist(scheduleplan.getId(), "0");
						//排除座位为空，但座位数大于修改后座位数的
						for(Scheduleseats s :scheduleseat){
							if(s.getSeatno()>plan.getSeatnum()){
								updatelist.add(s);
							}
						}
						scheduleseat.removeAll(updatelist);//排除已更改数据
						Scheduleseats sseats = (Scheduleseats) dao.get(
								LockModeType.PESSIMISTIC_READ,
								Scheduleseats.class, scheduleseat.get(0)
										.getId());
						updatelist.add(scheduleseat.get(0));//新增已更改数据
						
						sseats.setStatus(seats.getStatus());
						sseats.setSeattype(seats.getSeattype());
						sseats.setTickettype(seats.getTickettype());
						sseats.setUpdateby(plan.getUpdateby());
						sseats.setUpdatetime(plan.getUpdatetime());
						dao.merge(sseats);

						if ("2".equals(sseats.getStatus())) {
							Ticketsell ticketsell = getTicketsell(
									scheduleplan.getId(), num);
							if (ticketsell != null) {
								ticketsell.setSeatno(sseats.getSeatno());
								ticketsell.setUpdateby(sseats.getUpdateby());
								ticketsell
										.setUpdatetime(sseats.getUpdatetime());
								dao.merge(ticketsell);
								// 保存更新后的座位预留表
							}
						} else if ("3".equals(sseats.getStatus())
								|| "4".equals(sseats.getStatus())
								|| "5".equals(sseats.getStatus())) {
							Seatreserve seatreserve = seatreserveService
									.getSeatreserve(scheduleplan.getId(),
											scheduleplan.getDepartdate(), num);
							if (seatreserve != null) {
								seatreserve.setSeatno(sseats.getSeatno());
								seatreserve.setUpdateby(sseats.getUpdateby());
								seatreserve.setUpdatetime(sseats
										.getUpdatetime());
								dao.merge(seatreserve);
							}
						}

						dao.delete(Scheduleseats.class, seats.getId());
					}
					num--;
				}
			} else if (plan.getSeatnum() > seatsList.size()) {// 座位数是调大
				Short num = (short) (seatsService.getSeatno(scheduleplan
						.getId()) + 1);// 用来对后来的座位给予座位号
				for (int j = 0; j < plan.getSeatnum() - seatsList.size(); j++) {// 增加当前座位数比之前座位数多的座位
															
					if(seatsList.size()>0){
						Scheduleseats seats = seatsService.getById(seatsList.get(0)
								.getId());
						Scheduleseats scheduleseats = new Scheduleseats();
						scheduleseats.setCreateby(plan.getUpdateby());
						scheduleseats.setCreatetime(plan.getUpdatetime());
						scheduleseats.setDepartdate(seats.getDepartdate());
						scheduleseats.setOrgid(seats.getOrgid());
						scheduleseats.setScheduleid(seats.getScheduleid());
						scheduleseats.setScheduleplan(scheduleplan);
						scheduleseats.setSeatno(num);
						scheduleseats.setSeattype(seats.getSeattype());
						if(StringUtils.isNotEmpty(seatstatus)){
							scheduleseats.setStatus(seatstatus);
						}else{
							scheduleseats.setStatus("0");
						}
						scheduleseats.setTickettype(seats.getTickettype());
						scheduleseats.setUpdateby(plan.getUpdateby());
						scheduleseats.setUpdatetime(plan.getUpdatetime());
						dao.merge(scheduleseats);
					}else{						
						Scheduleseats scheduleseats = new Scheduleseats();
						scheduleseats.setCreateby(plan.getUpdateby());
						scheduleseats.setCreatetime(plan.getUpdatetime());
						scheduleseats.setDepartdate(plan.getDepartdate());
						scheduleseats.setOrgid(plan.getOrgid());
						scheduleseats.setScheduleid(plan.getScheduleid());
						scheduleseats.setScheduleplan(scheduleplan);
						scheduleseats.setSeatno(num);
						scheduleseats.setSeattype("0");
						if(StringUtils.isNotEmpty(seatstatus)){
							scheduleseats.setStatus(seatstatus);
						}else{
							scheduleseats.setStatus("0");
						}
						scheduleseats.setTickettype(null);
						scheduleseats.setUpdateby(plan.getUpdateby());
						scheduleseats.setUpdatetime(plan.getUpdatetime());
						dao.merge(scheduleseats);
					}															
					num++;
				}
			}
			}
			String result = "调整总座位数,班次号：" + schedule.getCode() + " 发车日期："
					+ DateUtils.formatDate(scheduleplan.getDepartdate()) + "总座位数由"
					+ scheduleplan.getSeatnum() + "调整为：" + plan.getSeatnum();
			Operationlog operationLog = new Operationlog();
			operationLog.setIp(ip);
			operationLog.setContent(result);
			operationLog.setModule("综合调度->营运计划调整");
			operationLog.setOperatetime(new Date());
			operationLog.setOperation("调整总座位数");
			operationLog.setSessionid("无session");
			operationLog.setUserid(plan.getUpdateby());
			dao.merge(operationLog);
			
			scheduleplan.setSeatnum(plan.getSeatnum());
			scheduleplan.setUpdateby(plan.getUpdateby());
			scheduleplan.setUpdatetime(new Date());
			dao.merge(scheduleplan);

			curdepartdate = DateUtils.add(curdepartdate, 1);
		}
		return true;
	}
	
	//综合调度：远程到中心修改座位数
	private MethodResult updateSeatnum(Schedule schedule, Scheduleplan plan, Long day, Global global){
		MethodResult methodResult = new MethodResult();
		
		RemoteTransaction remoteTransaction = new RemoteTransaction();
		remoteTransaction.id = UUID.randomUUID().toString();
		remoteTransaction.formip = Request.current().host;
		remoteTransaction.type = TransactionType.SELL_TICKET.ordinal();
		remoteTransaction.createDate = new Date();
		Map<String, String> requestMap = new HashMap<String, String>();
		requestMap.put("schedule", JsonUtil.toFormatString(schedule));
		requestMap.put("plan", JsonUtil.toFormatString(plan));
		requestMap.put("day", JsonUtil.toFormatString(day));
		remoteTransaction.requestjson = JsonUtil.toSimpleString(requestMap);
		remoteTransaction.save();
		
		RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty = new RemoteInvokeAuxiliaryProperty();
		remoteInvokeAuxiliaryProperty.setClientIp(global.getOrganization()
				.getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setClientOrgcode(global
				.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgcode(global
				.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgIp(global
				.getOrganization().getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setOperateTicketoutletsName(global
				.getTicketoutlets().getName());
		remoteInvokeAuxiliaryProperty.setOperateUserName(global
				.getUserinfo().getName());
		
		//调用远程
		OrganizationService organizationService = new OrganizationServiceImpl();
		Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
		if(centreOrg == null){
			methodResult.setResult(MethodResult.FAILURE);
			methodResult.setResultMsg("无法连接中心服务器:找不到" +  global.getOrganization() + "的上级机构");
			play.Logger.info(methodResult.getResultMsg());
			return methodResult;
		}
		try {
			Map<String, String> requestParam = new HashMap<String, String>();
			requestParam.put("schedule", JsonUtil.toFormatString(schedule));
			requestParam.put("plan", JsonUtil.toFormatString(plan));
			requestParam.put("day", JsonUtil.toFormatString(day));
			requestParam.put("remoteInvokeAuxiliaryProperty", JsonUtil.toFormatString(remoteInvokeAuxiliaryProperty));
			requestParam.put("transactionid", remoteTransaction.id);
			play.Logger.info("综合调度修改座位数，请求中心参数：" + JsonUtil.toFormatString(requestParam));
//			methodResult = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.NET_SEAT_RESERVE, requestParam);
			methodResult = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.UPDATE_SEATNUMS, requestParam);
			
			if(methodResult.getResult() != MethodResult.SUCCESS){
				TransactionUtil.setRollbackOnly();
				return methodResult;
			}
		} catch (Exception e) {
			methodResult.setResult(MethodResult.FAILURE);
			methodResult.setResultMsg(e.getMessage());
			play.Logger.error("综合调度修改座位数调用中心出错" + e.getMessage());
			return methodResult;
		}
		
		remoteTransaction.status = AppConstant.REMOTE_TRANSACTION_SUCCESS;
		remoteTransaction.save();
		
		return methodResult;
	}

	@SuppressWarnings("unchecked")
	private Scheduleplan updateTicketpriceSeatnum(Scheduleplan plan,
			Scheduleplan scplan) {
		//TODO 要区分座位类型来修改座位
		TicketpriceService priceService = new TicketpriceServiceImpl();
		Scheduleplan scheduleplan = getById(scplan.getId());// 用来锁住该营运计划
		List<Ticketprice> ticketprice = priceService
				.getByScheduleplanid(scheduleplan.getId());
		for (int j = 0; j < ticketprice.size(); j++) {// 修改执行票价的座位数
			Ticketprice price = priceService
					.getById(ticketprice.get(j).getId());
			price.setUpdateby(plan.getUpdateby());
			price.setUpdatetime(plan.getUpdatetime());
			price.setSeatnum(plan.getSeatnum());
			dao.merge(price);
		}
		return scheduleplan;
	}

	@SuppressWarnings("unchecked")
	private Ticketsell getTicketsell(long id, Short num) {
		StringBuffer sql = new StringBuffer("select t from Ticketsell t ");
		sql.append(" where t.scheduleplanid=:id and t.seatno=:num and t.ticketstatus=0");
		Query query = em.createQuery(sql.toString());
		query.setParameter("id", id);
		query.setParameter("num", num);
		List<Object> list=query.getResultList();
		if (list==null || list.size() <= 0) {
			return null;
		}
		return (Ticketsell) query.getResultList().get(0);
	}

	@Override
	public Scheduleplan getByScheduleid(long scheduleid, Date date) {
		StringBuffer sql = new StringBuffer("select t from Scheduleplan t ");
		sql.append(" where t.scheduleid=:scheduleid and t.departdate=:date");
		Query query = em.createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("date", date);
		if (query.getResultList().size() < 1) {
			return null;
		}
		return (Scheduleplan) query.getSingleResult();
	}

	@Override
	public boolean delete(Scheduleplan schedulestatus) {
		return dao.delete(schedulestatus);
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Scheduleplan.class, id);
	}

	@Override
	public List<Scheduleplan> query() {
		return dao.query(Scheduleplan.class, null);
	}

	@Override
	public Scheduleplan getById(Long id) {
		return (Scheduleplan) dao.get(LockModeType.PESSIMISTIC_READ,
				Scheduleplan.class, id);
	}
	/**
	 * 发班后根据3019参数自动添加座位
	 * @throws ServiceException 
	 */
	public void autoAddSeatAfterReport(String addReport) throws ServiceException{
		String key = "app_addseat"+util.DateUtils.formatDate(new Date());
		SeatreserveDao seatDao = new SeatreserveDao();
		CheckticketService checkticketService = new CheckticketServiceImpl();
		String centIp = "";
		/*Global global = CurrentUtil.getGlobal();
		Organization o = global.getOrganization();
		OrganizationService orgservice = new OrganizationServiceImpl();
		Organization parOrg = orgservice.getDirectlyParentOrg(o);
		if(parOrg!=null){
			centIp = parOrg.getServersaddress();
		}*/
		centIp = "192.168.2.207:3700";
		List<Object> vrList = seatDao.queryDepartSchedule(addReport);
		List<String> existVRList = RedisUtil.getList(RedisDBApp.global,key );
		Date currenttime = new Date();
		for (Object obj : vrList) {
			Object[] spArray = (Object[]) obj;
			String schedulePlanId = ((BigDecimal) spArray[0]).toString();
			Integer seatNum =  ((BigDecimal) spArray[1]).intValue();
			if(existVRList.contains(schedulePlanId)){//已经处理过的发班
				continue;
			}else{
				Scheduleplan sp = (Scheduleplan) dao.get(Scheduleplan.class, new Long(schedulePlanId));
				if(sp!=null && seatNum>0){
					play.Logger.info("sp.id="+sp.getId()+",seatNum="+seatNum);
					Scheduleplan scheduleplan = new Scheduleplan();
					scheduleplan.setScheduleid(sp.getScheduleid());
					scheduleplan.setDepartdate(sp.getDepartdate());
					scheduleplan.setSeatnum((short)(sp.getSeatnum()+seatNum));
					scheduleplan.setUpdateby(0L);
					scheduleplan.setUpdatetime(currenttime);
					Schedule schedule = (Schedule) dao.get(Schedule.class, sp.getScheduleid());
					if(schedule!=null && "3".equals(schedule.getWorktype())){//联网班次
						if(StringUtils.isNotEmpty(centIp)){
							String url = "http://"+centIp+"/remote/scheduleplan/addseatnums";
							Map<String,String> param = new HashMap<String,String>();
							param.put("schedulesynccode",schedule.getSynccode());
							param.put("departdate",util.DateUtils.formatDate(new Date()));
							param.put("addnum",new Integer(sp.getSeatnum()+seatNum).toString());
							try {
								String responseStr = RpcUtil.httpPostByLink(url , param,"UTF-8");
								play.Logger.info("url:跨区配置请求中心班次加座情况:"+responseStr);
								Map<String,Object> resultMap = cn.nova.openapi.util.JsonUtil.paseJson2Map(responseStr);
								String flag = (String) resultMap.get("flag");
								String isStatrtStation = (String) resultMap.get("isStatrtStation");
								if("1".equals(flag)){
									if("1".equals(isStatrtStation)){//跨区配载始发站班次
										saveseatnum(scheduleplan, 1L, "127.0.0.1","3");
									}else{//跨区配载站班次，查询中心座位图
										checkticketService.seatnums(sp.getId());
									}
									RedisUtil.rPush(RedisDBApp.global, key, schedulePlanId);
								}
							} catch (Exception e) {
								play.Logger.error("跨区配置请求中心班次加座情况失败sp.id="+sp.getId()+e.getMessage(), e);
							}
						}
					}else{//本地班次
						saveseatnum(scheduleplan, 1L, "127.0.0.1","3");
						RedisUtil.rPush(RedisDBApp.global, key, schedulePlanId);
					}
				}
			}
		}
	}

}
