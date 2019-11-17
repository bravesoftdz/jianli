package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;
import javax.servlet.http.HttpServletRequest;

import util.CurrentUtil;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Schedulelongstop;
import cn.nova.bus.base.model.Schedulestop;
import cn.nova.bus.base.service.ScheduleService;
import cn.nova.bus.base.service.impl.ScheduleServiceImpl;
import cn.nova.bus.base.vo.SchedulestopVo;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Digitaldictionarydetail;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * 
 * <p>
 * Title: 班次信息
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2011
 * </p>
 * <p>
 * Company: nova
 * </p>
 * 
 * @author lanckun
 * @version 0.1
 */
public class ScheduleAction extends BaseAction{
	public HttpServletRequest httpServletRequest;
	public Schedule schedule;
	public Schedulestop scheduleStop;
	public Schedulelongstop schedulelongstop;
	public Digitaldictionarydetail digitaldictionarydetail;
	private Long scheduleid;
	private long routeid;
	// 返回结果
	private List<SchedulestopVo> stationlist;
	private String stationids;
	private String scheduleids;

	private List<Map<String, Object>> routeidlist;
	private List<Map<String, Object>> schedulelist;
	private List<Map<String, Object>> schedulestoplist;
	private List<Map<String, Object>> etallschedulestoplist;
	private List<Map<String, Object>> schedulelongstoplist;	
	private List<Map<String, Object>> routestoplist;

	private ScheduleService scheduleService;
	private String schedulestatus;
	
	public String getSchedulestatus() {
		return schedulestatus;
	}

	public void setSchedulestatus(String schedulestatus) {
		this.schedulestatus = schedulestatus;
	}
	/**
	 * 硬调票价、节日票价等模块用查询
	 * @return
	 */
	public String query() {
		try {
			scheduleService = new ScheduleServiceImpl();
			setSchedulelist(scheduleService.query(ServletPropertyFilterUtil.buildFromHttpRequest(),schedulestatus));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	/**
	 * 班次管理用查询
	 * @return
	 */
	public String querySchedule() {
		try {
			scheduleService = new ScheduleServiceImpl();
			setSchedulelist(scheduleService.querySchedule(ServletPropertyFilterUtil.buildFromHttpRequest(),schedulestatus));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	

	public String qryschedulestop() {
		try {
			scheduleService = new ScheduleServiceImpl();
			setSchedulestoplist(scheduleService.qryScheduleStop(schedule
					.getId()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	private Long stationid;
	public String qrytheschedulestop() {
		try {
			scheduleService = new ScheduleServiceImpl();
			setSchedulestoplist(scheduleService.qryScheduleStop(scheduleid,getStationid()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String qryroutestop() {
		try {
			scheduleService = new ScheduleServiceImpl();
			setRoutestoplist(scheduleService.qryRouteStop(schedule));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}	
	public String saveschedule() {
		Global global = CurrentUtil.getGlobal();
		try {
			scheduleService = new ScheduleServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (schedule != null) {
					if (schedule.getId() != 0) {
						schedule.setUpdateby(global.getUserinfo().getId());
						setMsg("修改成功！");
						markSuccess();
					} else {
						schedule.setUpdateby(global.getUserinfo().getId());
						schedule.setCreateby(global.getUserinfo().getId());
						setMsg("添加成功！");
						markSuccess();
					}   
					schedule=scheduleService.save(schedule);//,isEditOtherSchedule);
					scheduleid=schedule.getId();
				}
			}
		} catch (ServiceException ex) {
			msg = ex.getMessage();
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			msg = "操作失败！";
			markFail();
		}
		return "json";
	}

	public String delschedule() {
		Global global = CurrentUtil.getGlobal();
		try {
			scheduleService = new ScheduleServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (scheduleService.delSchedule(schedule.getId(),
						global.getUserinfo().getId())) {
					setMsg("删除成功！");
					markSuccess();
				}
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}

	public String saveScheduleStop() {
		Global global = CurrentUtil.getGlobal();
		try {
			scheduleService = new ScheduleServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (scheduleStop != null) {
					if (scheduleStop.getId() != 0) {
						scheduleStop.setUpdateby(global.getUserinfo().getId());
						setMsg("修改成功！");
						markSuccess();
					} else {
						scheduleStop.setCreateby(global.getUserinfo().getId());
						scheduleStop.setUpdateby(global.getUserinfo().getId());
						setMsg("添加成功！");
						markSuccess();
					}
					scheduleService.saveScheduleStop(scheduleStop);
				}
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}
	public String delschedulestop() {
		Global global = CurrentUtil.getGlobal();
		try {
			scheduleService = new ScheduleServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (scheduleService.delScheduleStop(scheduleStop.getId(),
						global.getUserinfo().getId())) {
					setMsg("删除成功！");
					markSuccess();
				}
			}
		} catch (ServiceException ex) {
			msg = ex.getMessage();
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}
	//班次长停部分
	public String saveSchedulelongstop() {
		Global global = CurrentUtil.getGlobal();
		try {
			scheduleService = new ScheduleServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (schedulelongstop != null) {
					if (schedulelongstop.getId() != 0) {
						schedulelongstop.setUpdateby(global.getUserinfo().getId());
						setMsg("修改成功！");
						markSuccess();
					} else {
						schedulelongstop.setCreateby(global.getUserinfo().getId());
						schedulelongstop.setUpdateby(global.getUserinfo().getId());
						setMsg("添加成功！");
						markSuccess();
					}
					scheduleService.saveScheduleLong(schedulelongstop,digitaldictionarydetail);
				}
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}	
	
	public String qryschedulelongstop() {
		try {
			scheduleService = new ScheduleServiceImpl();
			setSchedulelongstoplist(scheduleService.qrySchedulelongstop(schedule));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}		
	private List<Map<String, Object>> helpmap;
	
	public List<Map<String, Object>> getHelpmap() {
		return helpmap;
	}

	public void setHelpmap(List<Map<String, Object>> helpmap) {
		this.helpmap = helpmap;
	}
	private Date departdate;
	
	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}
	private long vehicleid;
	private long reportorgid;
	
	public long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public long getReportorgid() {
		return reportorgid;
	}

	public void setReportorgid(long reportorgid) {
		this.reportorgid = reportorgid;
	}

	//自助打单-检票打单:配载班次只查本站
	public String selfcheckSchedule() {
			scheduleService = new ScheduleServiceImpl(); 
			Global global = CurrentUtil.getGlobal();
			try {
				if (global != null && global.getUserinfo()!=null){
						helpmap = scheduleService.selfcheckSchedule(departdate,global.getOrganization().getStation().getId(),vehicleid,reportorgid);
				}
			} catch (Exception ex) {
				play.Logger.error(ex.getMessage(), ex);
			}
			return "json";
	}
	public String delschedulelongstop() {
		Global global = CurrentUtil.getGlobal();
		try {
			scheduleService = new ScheduleServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (scheduleService.delSchedulelongstop(schedulelongstop)) {
					setMsg("删除成功！");
					markSuccess();
				}
			}
		} catch (ServiceException ex) {
			msg = ex.getMessage();
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}
	
	public String qryschedulestopTwo() {
		try {
			scheduleService = new ScheduleServiceImpl();
			setEtallschedulestoplist(scheduleService.qryScheduleStopTwo(schedule
					.getId()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String updateScheduleAll() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				
				schedule.setUpdateby(global.getUserinfo().getId());
				setMsg("修改成功！");
				markSuccess();
				scheduleService = new ScheduleServiceImpl();
				boolean flas=scheduleService.updateScheduleAll(schedule,scheduleids,stationids,stationlist);//,isEditOtherSchedule);
				if (flas=false){
					msg = "操作失败！";
					markFail();
				}
			}
		} catch (ServiceException ex) {
			msg = ex.getMessage();
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			msg = "操作失败！";
			markFail();
		}
		return "json";
	}
	
	public String findrouteidByScheduleid(){
		
		scheduleService = new ScheduleServiceImpl(); 				
		setRouteidlist(scheduleService.findrouteid(scheduleid));
		return "json";
	}
	
	public String createDistrictTree() {

		return "json";
	}	

	@Transient
	public Schedule getSchedule() {
		return schedule;
	}

	public void setSchedule(Schedule schedule) {
		this.schedule = schedule;
	}

	public List<Map<String, Object>> getSchedulelist() {
		return schedulelist;
	}

	public void setSchedulelist(List<Map<String, Object>> schedulelist) {
		this.schedulelist = schedulelist;
	}
	public Schedulestop getScheduleStop() {
		return scheduleStop;
	}

	public void setScheduleStop(Schedulestop scheduleStop) {
		this.scheduleStop = scheduleStop;
	}
	public Schedulelongstop getSchedulelongstop() {
		return schedulelongstop;
	}

	public void setSchedulelongstop(Schedulelongstop schedulelongstop) {
		this.schedulelongstop = schedulelongstop;
	}
	public List<Map<String, Object>> getRoutestoplist() {
		return routestoplist;
	}

	public void setRoutestoplist(List<Map<String, Object>> routestoplist) {
		this.routestoplist = routestoplist;
	}

	public List<Map<String, Object>> getSchedulestoplist() {
		return schedulestoplist;
	}

	public void setSchedulestoplist(List<Map<String, Object>> schedulestoplist) {
		this.schedulestoplist = schedulestoplist;
	}
	public List<Map<String, Object>> getSchedulelongstoplist() {
		return schedulelongstoplist;
	}

	public void setSchedulelongstoplist(
			List<Map<String, Object>> schedulelongstoplist) {
		this.schedulelongstoplist = schedulelongstoplist;
	}
	
	public Long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(Long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public Long getStationid() {
		return stationid;
	}

	public void setStationid(Long stationid) {
		this.stationid = stationid;
	}

	public List<SchedulestopVo> getStationlist() {
		return stationlist;
	}

	public void setStationlist(List<SchedulestopVo> stationlist) {
		this.stationlist = stationlist;
	}

	public String getStationids() {
		return stationids;
	}

	public void setStationids(String stationids) {
		this.stationids = stationids;
	}

	public String getScheduleids() {
		return scheduleids;
	}

	public void setScheduleids(String scheduleids) {
		this.scheduleids = scheduleids;
	}

	public List<Map<String, Object>> getEtallschedulestoplist() {
		return etallschedulestoplist;
	}

	public void setEtallschedulestoplist(
			List<Map<String, Object>> etallschedulestoplist) {
		this.etallschedulestoplist = etallschedulestoplist;
	}

	public Digitaldictionarydetail getDigitaldictionarydetail() {
		return digitaldictionarydetail;
	}

	public void setDigitaldictionarydetail(
			Digitaldictionarydetail digitaldictionarydetail) {
		this.digitaldictionarydetail = digitaldictionarydetail;
	}

	public long getRouteid() {
		return routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}

	public List<Map<String, Object>> getRouteidlist() {
		return routeidlist;
	}

	public void setRouteidlist(List<Map<String, Object>> routeidlist) {
		this.routeidlist = routeidlist;
	}
	
	
	
}
