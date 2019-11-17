/**
 * <b>项目名：</b>NvBusWeb<br/>
 * <b>包名：</b>cn.nova.bus.dispatch.action<br/>
 * <b>文件名：</b>ScheduleplusAction.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2011-7-12-上午10:13:52<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.dispatch.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import util.CurrentUtil;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.dispatch.service.ScheduleplusService;
import cn.nova.bus.dispatch.service.impl.ScheduleplusServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Scheduleplanlog;
import cn.nova.bus.price.service.GenScheduleplanService;
import cn.nova.bus.price.service.impl.GenScheduleplanServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>ScheduleplusAction<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */
public class ScheduleplusAction extends BaseAction{
	private long routeid;
	private long scheduleid;
	private long mbscheduleid;// 模版班次ID
	private Date startdate;
	private Date enddate;
	private Schedule schedule;
	private Scheduleplanlog scheduleplanlog;
	private List<Map<String, Object>> scheduleplanloglist;
	private long unitid;
	private long vehicletypeid;
	private long vehicleid;
	private long vehiclebrandmodelid;
	private String stationids;
	private String ip;
	private long scheduleplanid;
	private long newscheduleplanid;
	private long balanceformulaid;
	private long balancedeductitemid;
	private int delayminute;
	private List<Map<String, Object>> otherinfo;
	private int status;
	private List<Map<String, Object>> schedulestoplist;
	private List<Map<String, Object>> scheduleplusinfo;
	private String schcode;
	private boolean issellstopstation;
	private short planseatnums;
	private boolean isreport; //加班并报班
	public boolean isIssellstopstation() {
		return issellstopstation;
	}

	public short getPlanseatnums() {
		return planseatnums;
	}

	public void setPlanseatnums(short planseatnums) {
		this.planseatnums = planseatnums;
	}

	public void setIssellstopstation(boolean issellstopstation) {
		this.issellstopstation = issellstopstation;
	}

	public String getSchcode() {
		return schcode;
	}

	public void setSchcode(String schcode) {
		this.schcode = schcode;
	}

	private ScheduleplusService scheduleplusService;
	
	public String qryScheduleplusinfo() {
		try {
			scheduleplusService = new ScheduleplusServiceImpl();
			scheduleplusinfo = scheduleplusService
					.qryScheduleplus(ServletPropertyFilterUtil
							.buildFromHttpRequest());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qryOtherScheduleinfo() {
		try {
			scheduleplusService = new ScheduleplusServiceImpl();
			otherinfo = scheduleplusService.qryOtherSchedule(routeid);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qryScheduleCycle() {
		try {
			scheduleplusService = new ScheduleplusServiceImpl();
			otherinfo = scheduleplusService.qryScheduleCycle(scheduleid);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 班次加班 - 加班
	public String scheduleplus() {
		Global global = CurrentUtil.getGlobal();
		try {
			scheduleplusService = new ScheduleplusServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				scheduleid = scheduleplusService.Scheduleplus(mbscheduleid,
						startdate, enddate, schedule, unitid, vehicletypeid,
						vehicleid, vehiclebrandmodelid, ip);
				markSuccess();
				setMsg("加班成功！");
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			markFail();
			setMsg("加班失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}


	// 按线路进行加班
	public String routeplus() {
		Global global = CurrentUtil.getGlobal();
		try {
			scheduleplusService = new ScheduleplusServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				scheduleid = scheduleplusService.ScheduleRouteplus(routeid,startdate, enddate, 
						schedule,vehiclebrandmodelid, ip,planseatnums);
				schedule=null;
				markSuccess();
				setMsg("加班成功！");
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			markFail();
			setMsg("加班失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	
	// 综合调度-按照班次计划班次加班
	public String scheduleplanplus() {
		Global global = CurrentUtil.getGlobal();
		try {
			scheduleplusService = new ScheduleplusServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				newscheduleplanid = scheduleplusService.Scheduleplus(
						scheduleplanid, startdate, enddate, schedule,
						vehiclebrandmodelid,unitid, vehicleid, ip, balanceformulaid,
						delayminute,status,issellstopstation,
						balancedeductitemid,isreport,planseatnums);
				markSuccess();
				setMsg("加班成功！");
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			markFail();
			setMsg("加班失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String genOvertimeplan() {
		try {
			GenScheduleplanService genScheduleplanService = new GenScheduleplanServiceImpl();
			setScheduleplanloglist(genScheduleplanService
					.generateOvertimeplan(scheduleplanlog));
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String genSchCode() {
		try {
			scheduleplusService = new ScheduleplusServiceImpl();
			schcode=scheduleplusService.genSchCode(routeid,startdate,enddate);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	// 修改停靠站
	public String updateSchedulestop() {
		Global global = CurrentUtil.getGlobal();
		try {
			scheduleplusService = new ScheduleplusServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				scheduleplusService.updateSchedulestop(scheduleid, stationids,
						global.getUserinfo().getId());
				markSuccess();
				setMsg("保存成功！");
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
		} catch (Exception e) {
			markFail();
			setMsg("保存失败！");
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String QryStationstop() {
		try {
			scheduleplusService = new ScheduleplusServiceImpl();
			schedulestoplist = scheduleplusService
					.qrySchedulestation(scheduleid);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public List<Map<String, Object>> getScheduleplanloglist() {
		return scheduleplanloglist;
	}

	public void setScheduleplanloglist(
			List<Map<String, Object>> scheduleplanloglist) {
		this.scheduleplanloglist = scheduleplanloglist;
	}

	public Scheduleplanlog getScheduleplanlog() {
		return scheduleplanlog;
	}

	public void setScheduleplanlog(Scheduleplanlog scheduleplanlog) {
		this.scheduleplanlog = scheduleplanlog;
	}

	

	public List<Map<String, Object>> getOtherinfo() {
		return otherinfo;
	}

	public void setOtherinfo(List<Map<String, Object>> otherinfo) {
		this.otherinfo = otherinfo;
	}

	public List<Map<String, Object>> getScheduleplusinfo() {
		return scheduleplusinfo;
	}

	public void setScheduleplusinfo(List<Map<String, Object>> scheduleplusinfo) {
		this.scheduleplusinfo = scheduleplusinfo;
	}


	public List<Map<String, Object>> getSchedulestoplist() {
		return schedulestoplist;
	}

	public void setSchedulestoplist(List<Map<String, Object>> schedulestoplist) {
		this.schedulestoplist = schedulestoplist;
	}

	public String getStationids() {
		return stationids;
	}

	public void setStationids(String stationids) {
		this.stationids = stationids;
	}

	public long getRouteid() {
		return routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}

	public long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public Schedule getSchedule() {
		return schedule;
	}

	public void setSchedule(Schedule schedule) {
		this.schedule = schedule;
	}

	public long getUnitid() {
		return unitid;
	}

	public void setUnitid(long unitid) {
		this.unitid = unitid;
	}

	public long getVehicletypeid() {
		return vehicletypeid;
	}

	public void setVehicletypeid(long vehicletypeid) {
		this.vehicletypeid = vehicletypeid;
	}

	public long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public long getVehiclebrandmodelid() {
		return vehiclebrandmodelid;
	}

	public void setVehiclebrandmodelid(long vehiclebrandmodelid) {
		this.vehiclebrandmodelid = vehiclebrandmodelid;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public long getScheduleplanid() {
		return scheduleplanid;
	}

	public void setScheduleplanid(long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	public long getNewscheduleplanid() {
		return newscheduleplanid;
	}

	public void setNewscheduleplanid(long newscheduleplanid) {
		this.newscheduleplanid = newscheduleplanid;
	}

	public long getBalanceformulaid() {
		return balanceformulaid;
	}

	public void setBalanceformulaid(long balanceformulaid) {
		this.balanceformulaid = balanceformulaid;
	}
	public int getDelayminute() {
		return delayminute;
	}

	public void setDelayminute(int delayminute) {
		this.delayminute = delayminute;
	}	
	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}	
	public long getBalancedeductitemid() {
		return balancedeductitemid;
	}

	public void setBalancedeductitemid(long balancedeductitemid) {
		this.balancedeductitemid = balancedeductitemid;
	}

	public long getMbscheduleid() {
		return mbscheduleid;
	}

	public void setMbscheduleid(long mbscheduleid) {
		this.mbscheduleid = mbscheduleid;
	}

	public boolean isIsreport() {
		return isreport;
	}

	public void setIsreport(boolean isreport) {
		this.isreport = isreport;
	}
	
}
