package cn.nova.bus.dispatch.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.dispatch.model.Schedulecancel;
import cn.nova.bus.dispatch.model.Seatreserve;
import cn.nova.bus.dispatch.model.Vehiclelost;
import cn.nova.bus.dispatch.service.ScheduleplanService;
import cn.nova.bus.dispatch.service.ScheduleseatsService;
import cn.nova.bus.dispatch.service.SchedulestatusService;
import cn.nova.bus.dispatch.service.SchedulestatusStopService;
import cn.nova.bus.dispatch.service.SchedulevehiclepeopleplanService;
import cn.nova.bus.dispatch.service.TicketpriceService;
import cn.nova.bus.dispatch.service.impl.ScheduleplanServiceImpl;
import cn.nova.bus.dispatch.service.impl.ScheduleseatsServiceImpl;
import cn.nova.bus.dispatch.service.impl.SchedulestatusServiceImpl;
import cn.nova.bus.dispatch.service.impl.SchedulestatusStopServiceImpl;
import cn.nova.bus.dispatch.service.impl.SchedulevehiclepeopleplanServiceImpl;
import cn.nova.bus.dispatch.service.impl.TicketpriceServiceImpl;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleplanlog;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Schedulevehiclepeopleplan;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class SchedulestatusAction extends BaseAction{
	private Schedulestatus schedulestatus;
	private Scheduleplan plan;
	private Schedulevehiclepeopleplan peopleplan;
	private Ticketprice price;
	private Seatreserve seatreserve;
	private List<Map<String, Object>> statusmap;
	private List<Map<String, Object>> seatsmap;
	private List<Map<String, Object>> pricemap;
	private List<Map<String, Object>> schedulemap;
	private List<Map<String, Object>> stopstationmap;
	private List<Map<String,Object>> sslist;
	private List<Ticketprice> dispatchticketprice;// 批量调票价
	private Long day;
	private String routescheduleid;
	private String reachstationid;
	private Date departdate;
	private long scheduleplanid;
	private long scheduleid;
	private Scheduleplanlog scheduleplanlog;
	private String buspark;
	private Vehiclelost vehiclelost;
	private long departstationid;
	private Date fromdate;
	private Date enddate;
	private Date maxcanceltime;
	private String ticketentrance;
	private boolean stowage;
	private boolean isfullseat;
	private Schedulecancel schedulecancl;
	
	private SchedulestatusService schedulestatusService;
	private SchedulevehiclepeopleplanService peopleplanService;
	private TicketpriceService priceService;
	private String schedulecode;
	
	
	public String checkticketstatus(){
		try {
			schedulestatusService = new SchedulestatusServiceImpl();
			statusmap = schedulestatusService.checkticketstatus(departdate,schedulecode);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String query() {
		try {
			schedulestatusService = new SchedulestatusServiceImpl();
			setStatusmap(schedulestatusService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest(),
					departstationid,fromdate,enddate,isfullseat));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String qryscheduleplan(){
		try {
			schedulestatusService=new SchedulestatusServiceImpl();
			setSslist(schedulestatusService.qryscheduleplan(departdate,scheduleid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String qryTicketentrance() {
		try {
			schedulestatusService = new SchedulestatusServiceImpl();
			setStatusmap(schedulestatusService.qryTicketentrance(departstationid,scheduleid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String qryVehiclepark() {
		try {
			schedulestatusService = new SchedulestatusServiceImpl();
			schedulemap=schedulestatusService.qryVehiclepark(departstationid,scheduleid);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String queryScheduleseats() {// 查询班次的座位状态
		try {
			ScheduleseatsService scheduleseatsService = new ScheduleseatsServiceImpl();
			setSeatsmap(scheduleseatsService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			System.out.println(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String queryTicketprice() {// 查询营运计划对应的票价
		schedulestatusService = new SchedulestatusServiceImpl();
		setPricemap(schedulestatusService
				.queryTicketprice(ServletPropertyFilterUtil
						.buildFromHttpRequest()));
		return "json";
	}

	public String queryRouteschedule() {// 查询线路所对应的班次信息
		priceService = new TicketpriceServiceImpl();
		setSchedulemap(priceService
				.queryRouteschedule(ServletPropertyFilterUtil
						.buildFromHttpRequest()));
		return "json";
	}

	public String queryStopstation() {// 查询票价对应的停靠点
		priceService = new TicketpriceServiceImpl();
		setStopstationmap(priceService.queryStopstation(scheduleplanid));
		return "json";
	}

	public String save() {
		Global global = CurrentUtil.getGlobal();
		schedulestatusService = new SchedulestatusServiceImpl();
		if (schedulestatus != null) {
			if (schedulestatus.getId() > 0) {
				msg = "修改成功！";
				markSuccess();
			} else {
				schedulestatus.setIsreported(true);
				schedulestatus.setIsdeparted(true);
				schedulestatus.setIsbegincheck(false);
				schedulestatus.setOrgid(global.getUserinfo().getId());
				schedulestatus.setCreateby(global.getUserinfo().getId());
				schedulestatus.setUpdateby(global.getUserinfo().getId());
				schedulestatus.setCreatetime(new Timestamp(System
						.currentTimeMillis()));
				schedulestatus.setUpdatetime(new Timestamp(System
						.currentTimeMillis()));
			}
			if (!schedulestatusService.save(schedulestatus)) {
				msg = "操作失败！";
				markFail();
			}
		}
		return "json";
	}

	public String starttime() {// 调整发车时间
		Global global = CurrentUtil.getGlobal();
		schedulestatusService = new SchedulestatusServiceImpl();
		if (schedulestatus != null) {
			try {
				if (schedulestatus.getId() > 0) {
					schedulestatus.setUpdateby(global.getUserinfo().getId());
					msg = "发车时间调整成功！";
					markSuccess();
				}
				if (!schedulestatusService.saveStarttime(schedulestatus, day,
						global.getIpAddress())) {
					msg = "发车时间调整失败！";
					markFail();
				}
			} catch (ServiceException ex) {
				setMsg(ex.getMessage());
				markSuccess();
			} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
				msg = "发车时间调整失败！";
				markFail();
			}
		}
		return "json";
	}

	public String planvehicle() {// 计划车辆调整
		peopleplanService = new SchedulevehiclepeopleplanServiceImpl();
		Global global = CurrentUtil.getGlobal();
		if (peopleplan != null) {
			try {
				if (peopleplan.getId() > 0) {
					peopleplan.setUpdateby(global.getUserinfo().getId());
					peopleplan.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					msg = "计划车辆调整成功！";
					markSuccess();
				}
				if (!peopleplanService.savePlanvehicle(peopleplan,
						global.getIpAddress())) {
					msg = "计划车辆调整失败！";
					markFail();
				}
			} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
				msg = "计划车辆调整失败！";
				markFail();
			}
		}
		return "json";
	}

	public String plandriver() {// 计划司机调整
		Global global = CurrentUtil.getGlobal();
		if (peopleplan != null) {
			peopleplanService = new SchedulevehiclepeopleplanServiceImpl();
			try {
				if (peopleplan.getId() > 0) {
					peopleplan.setUpdateby(global.getUserinfo().getId());
					peopleplan.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					msg = "计划司机调整成功！";
					markSuccess();
				}
				if (!peopleplanService.savePlandriver(peopleplan)) {
					msg = "计划司机调整失败！";
					markFail();
				}
			} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
				msg = "计划司机调整失败！";
				markFail();
			}
		}
		return "json";
	}

	public String plansetward() {// 计划乘务员调整
		Global global = CurrentUtil.getGlobal();
		if (peopleplan != null) {
			peopleplanService = new SchedulevehiclepeopleplanServiceImpl();
			try {
				if (peopleplan.getId() > 0) {
					peopleplan.setUpdateby(global.getUserinfo().getId());
					peopleplan.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					msg = "计划乘务员调整成功！";
					markSuccess();
				}
				if (!peopleplanService.savePlansteward(peopleplan)) {
					msg = "计划乘务员调整失败！";
					markFail();
				}
			} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
				msg = "计划乘务员调整失败！";
				markFail();
			}
		}
		return "json";
	}

	public String ticketprice() {// 票价调整
		Global global = CurrentUtil.getGlobal();
		if (price != null) {
			try {
				priceService = new TicketpriceServiceImpl();
				if (price.getId() > 0) {
					price.setUpdateby(global.getUserinfo().getId());
					price.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					msg = "票价调整成功！";
					markSuccess();
				}
				if (!priceService.savePlanprice(dispatchticketprice,
						routescheduleid, day, departdate, global.getUserinfo()
								.getId(), global.getIpAddress(), scheduleid)) {
					msg = "票价调整失败！";
					markFail();
				}
			} catch (ServiceException ex) {
				setMsg(ex.getMessage());
				markSuccess();
			} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
				msg = "票价调整失败！";
				markFail();
			}
		}
		return "json";
	}

	public String stopstation() {// 停靠点调整
		Global global = CurrentUtil.getGlobal();
		if (day != null) {
			try {
				priceService = new TicketpriceServiceImpl();
				if (!priceService.stopstation(reachstationid, routescheduleid,
						day, departdate, global.getUserinfo().getId(),
						global.getIpAddress(), scheduleid)) {
					msg = "停靠站点调整失败！";
					markFail();
				}
				msg = "停靠站点调整成功！";
				markSuccess();
			} catch (ServiceException ex) {
				setMsg(ex.getMessage());
				markFail();
			} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
				msg = "停靠站点调整失败！";
				markFail();
			}
		}
		return "json";
	}

	public String seatnum() {// 总座位数调整
		Global global = CurrentUtil.getGlobal();
		if (plan != null) {
			try {
				ScheduleplanService planService = new ScheduleplanServiceImpl(); 
				if (plan.getId() > 0) {
					plan.setUpdateby(global.getUserinfo().getId());
					plan.setUpdatetime(new Timestamp(System.currentTimeMillis()));
					msg = "总座位数调整成功！";
					markSuccess();
				}
				if (!planService.saveseatnum(plan, day, global.getIpAddress(),null)) {
					msg = "总座位数操作失败！";
					markFail();
				}
			} catch (ServiceException ex) {
				setMsg(ex.getMessage());
				markFail();
			} catch (BusinessException ex) {
				setMsg(ex.getMessage());
				markFail();
			} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
				msg = "总座位数调整失败！";
				markFail();
			}
		}
		return "json";
	}

	public String vehicletype() {// 计划车型调整
		Global global = CurrentUtil.getGlobal();
		if (peopleplan != null) {
			peopleplanService = new SchedulevehiclepeopleplanServiceImpl();
			try {
				if (peopleplan.getId() > 0) {
					peopleplan.setUpdateby(global.getUserinfo().getId());
					peopleplan.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					msg = "计划车型调整成功！";
					markSuccess();
				}
				if (!peopleplanService.savePlanvehicletype(peopleplan,
						global.getIpAddress())) {
					msg = "计划车型调整失败！";
					markFail();
				}
			} catch (ServiceException e) {
				msg = e.getMessage();
				markFail();
			}
		}
		return "json";
	}

	// 班次停班/恢复班次处理
	public String schedulestatusStop() {
		markSuccess();
		Global global = CurrentUtil.getGlobal();
		if (global != null) {
			try {
				SchedulestatusStopService schedulestatusStopService = new SchedulestatusStopServiceImpl();
				statusmap = schedulestatusStopService.updateSchedulestatus(
						scheduleplanlog, vehiclelost,schedulecancl);
			} catch (Exception ex) {
				markFail();
				play.Logger.error(ex.getMessage(), ex);
			}
		}
		return "json";
	}

	// 更新报到售票为正常售票
	public String updateIssaleafterreport() {
		markSuccess();
		schedulestatusService = new SchedulestatusServiceImpl();
		Global global = CurrentUtil.getGlobal();
		if (global != null) {
			try {
				schedulestatusService.updateIssaleafterreport(scheduleplanid,
						global);
				msg = "操作成功！";
			} catch (Exception ex) {
				markFail();
				msg = "更新失败," + ex.getMessage();
				play.Logger.error(ex.getMessage(), ex);
			}
		}
		return "json";
	}

	// 班次停班/恢复班次处理
	public String updateTicketentrancepark() {
		markSuccess();
		Global global = CurrentUtil.getGlobal();
		schedulestatusService = new SchedulestatusServiceImpl();
		if (global != null) {
			try {
				schedulestatusService.updateTicketentrancepark(
						scheduleplanlog.getDepartstationid(),
						scheduleplanlog.getStartdate(),
						scheduleplanlog.getEnddate(),
						scheduleplanlog.getScheduleids(), buspark,
						ticketentrance, scheduleplanlog.getIp(),
						scheduleplanlog.getCreateby());
				msg = "操作成功！";
			} catch (Exception ex) {
				markFail();
				msg = "更新失败," + ex.getMessage();
				play.Logger.error(ex.getMessage(), ex);
			}
		}
		return "json";
	}
	
	public String qryAutoCanelSeatTime() {
		try {
			schedulestatusService = new SchedulestatusServiceImpl();
			maxcanceltime=schedulestatusService.getAutoCanelSeatTime(departstationid,scheduleplanid);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String schIsStowage() {// 判断是否为配客班次
		stowage=false;
		try {
			schedulestatusService = new SchedulestatusServiceImpl();
			stowage=schedulestatusService.isStowageSch(scheduleplanid);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 *综合调度-同步班次计划 :
	 *		中心不存在的记录也可同步到中心
	 */
	public String syncScheduleplan(){
		try {
			schedulestatusService = new SchedulestatusServiceImpl();
			MethodResult methodResult = schedulestatusService.syncScheduleplan(scheduleplanid);
			if(methodResult.getResult() == MethodResult.SUCCESS){
				markSuccess();
			}else{
				markFail();
			}
			msg = methodResult.getResultMsg();
		} catch (Exception ex) {
			markFail();
			msg = "同步班次计划失败！" ;
			play.Logger.error(ex.getMessage(), ex);
		}
		return "json";
	}
	
	public String delete() {

		return "json";
	}

	public Schedulestatus getSchedulestatus() {
		return schedulestatus;
	}

	public void setSchedulestatus(Schedulestatus schedulestatus) {
		this.schedulestatus = schedulestatus;
	}

	public List<Map<String, Object>> getStatusmap() {
		return statusmap;
	}

	public void setStatusmap(List<Map<String, Object>> statusmap) {
		this.statusmap = statusmap;
	}

	public Scheduleplan getPlan() {
		return plan;
	}

	public void setPlan(Scheduleplan plan) {
		this.plan = plan;
	}

	public Schedulevehiclepeopleplan getPeopleplan() {
		return peopleplan;
	}

	public void setPeopleplan(Schedulevehiclepeopleplan peopleplan) {
		this.peopleplan = peopleplan;
	}

	public Ticketprice getPrice() {
		return price;
	}

	public void setPrice(Ticketprice price) {
		this.price = price;
	}

	public Seatreserve getSeatreserve() {
		return seatreserve;
	}

	public void setSeatreserve(Seatreserve seatreserve) {
		this.seatreserve = seatreserve;
	}

	public List<Map<String, Object>> getSeatsmap() {
		return seatsmap;
	}

	public void setSeatsmap(List<Map<String, Object>> seatsmap) {
		this.seatsmap = seatsmap;
	}

	public List<Map<String, Object>> getPricemap() {
		return pricemap;
	}

	public void setPricemap(List<Map<String, Object>> pricemap) {
		this.pricemap = pricemap;
	}

	public Long getDay() {
		return day;
	}

	public void setDay(Long day) {
		this.day = day;
	}

	public List<Map<String, Object>> getSchedulemap() {
		return schedulemap;
	}

	public void setSchedulemap(List<Map<String, Object>> schedulemap) {
		this.schedulemap = schedulemap;
	}

	public List<Map<String, Object>> getStopstationmap() {
		return stopstationmap;
	}

	public void setStopstationmap(List<Map<String, Object>> stopstationmap) {
		this.stopstationmap = stopstationmap;
	}

	public String getRoutescheduleid() {
		return routescheduleid;
	}

	public void setRoutescheduleid(String routescheduleid) {
		this.routescheduleid = routescheduleid;
	}

	public List<Ticketprice> getDispatchticketprice() {
		return dispatchticketprice;
	}

	public void setDispatchticketprice(List<Ticketprice> dispatchticketprice) {
		this.dispatchticketprice = dispatchticketprice;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public Scheduleplanlog getScheduleplanlog() {
		return scheduleplanlog;
	}

	public void setScheduleplanlog(Scheduleplanlog scheduleplanlog) {
		this.scheduleplanlog = scheduleplanlog;
	}

	public void setScheduleplanid(Long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	public Long getScheduleplanid() {
		return scheduleplanid;
	}

	public void setReachstationid(String reachstationid) {
		this.reachstationid = reachstationid;
	}

	public String getReachstationid() {
		return reachstationid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public long getScheduleid() {
		return scheduleid;
	}

	public String getBuspark() {
		return buspark;
	}

	public void setBuspark(String buspark) {
		this.buspark = buspark;
	}

	public String getTicketentrance() {
		return ticketentrance;
	}

	public void setTicketentrance(String ticketentrance) {
		this.ticketentrance = ticketentrance;
	}

	public Vehiclelost getVehiclelost() {
		return vehiclelost;
	}

	public void setVehiclelost(Vehiclelost vehiclelost) {
		this.vehiclelost = vehiclelost;
	}

	public long getDepartstationid() {
		return departstationid;
	}

	public void setDepartstationid(long departstationid) {
		this.departstationid = departstationid;
	}
	
	public Date getMaxcanceltime() {
		return maxcanceltime;
	}

	public void setMaxcanceltime(Date maxcanceltime) {
		this.maxcanceltime = maxcanceltime;
	}
	
	public Date getFromdate() {
		return fromdate;
	}

	public void setFromdate(Date fromdate) {
		this.fromdate = fromdate;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}
	public boolean getStowage() {
		return stowage;
	}

	public void setStowage(boolean stowage) {
		this.stowage = stowage;
	}	
	public boolean isIsfullseat() {
		return isfullseat;
	}

	public void setIsfullseat(boolean isfullseat) {
		this.isfullseat = isfullseat;
	}

	public List<Map<String, Object>> getSslist() {
		return sslist;
	}

	public void setSslist(List<Map<String, Object>> sslist) {
		this.sslist = sslist;
	}

	public String getSchedulecode() {
		return schedulecode;
	}

	public void setSchedulecode(String schedulecode) {
		this.schedulecode = schedulecode;
	}

	public Schedulecancel getSchedulecancl() {
		return schedulecancl;
	}

	public void setSchedulecancl(Schedulecancel schedulecancl) {
		this.schedulecancl = schedulecancl;
	}	
	
	
}
