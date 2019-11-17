package cn.nova.bus.dispatch.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.dispatch.model.Schedulemerge;
import cn.nova.bus.dispatch.model.Schedulestatuslog;
import cn.nova.bus.dispatch.service.SchedulemergeService;
import cn.nova.bus.dispatch.service.impl.SchedulemergeServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class SchedulemergeAction extends BaseAction{
	private Schedulemerge schedulemerge;
	private Schedulestatuslog schedulestatuslog;
	private List<Map<String, Object>> mergemap;
	private List<Map<String, Object>> scheduleplanmap;
	private String oldseats;
	private String newseats;
	private Long id;
	
	private SchedulemergeService schedulemergeService;

	/**
	 * 查询并班的班次信息
	 * @return
	 */
	public String query() {
		try {
			schedulemergeService = new SchedulemergeServiceImpl();
			setMergemap(schedulemergeService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			System.out.println(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 获取营运计划的信息
	 * @return
	 */
	public String querySchedule(){
		try {
			schedulemergeService = new SchedulemergeServiceImpl();
			setScheduleplanmap(schedulemergeService.queryScheduleplan(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			System.out.println(e.getMessage());
		}
		return "json";
	}
	
	/**
	 * 班次并班 * @return	 */
	public String save() {
		Global global = CurrentUtil.getGlobal();
		try {
			schedulemergeService = new SchedulemergeServiceImpl();
			if (schedulemerge != null && global!=null) {
				if (schedulemerge.getId() == 0) {
					schedulemerge.setUserid(global.getUserinfo().getId());
					schedulemerge.setCreateby(global.getUserinfo().getId());
					schedulemerge.setCreatetime(new Date());
					schedulemerge.setIscancel(false);
					schedulemerge.setOrgid(global.getOrganization().getId());
					setMsg("并班成功！");
					markSuccess();
				} else {
					schedulemerge.setUserid(global.getUserinfo().getId());
					schedulemerge.setIscancel(true);
					setMsg("并班取消成功！");
					markSuccess();
				}
				schedulestatuslog.setOrgid(global.getOrganization().getId());
				schedulestatuslog.setCreateby(global.getUserinfo().getId());
				schedulestatuslog.setCreatetime(new Date());
				schedulemerge = schedulemergeService.save(schedulemerge, schedulestatuslog,oldseats,newseats);
				setId(schedulemerge.getId());
			}
		} catch (ServiceException se) {
			setMsg(se.getMessage());
			markFail();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg(e.getMessage());
			markFail();
		}
		return "json";
	}

	public Schedulemerge getSchedulemerge() {
		return schedulemerge;
	}

	public void setSchedulemerge(Schedulemerge schedulemerge) {
		this.schedulemerge = schedulemerge;
	}

	public List<Map<String, Object>> getMergemap() {
		return mergemap;
	}

	public void setMergemap(List<Map<String, Object>> mergemap) {
		this.mergemap = mergemap;
	}

	public void setSchedulestatuslog(Schedulestatuslog schedulestatuslog) {
		this.schedulestatuslog = schedulestatuslog;
	}

	public Schedulestatuslog getSchedulestatuslog() {
		return schedulestatuslog;
	}

	public List<Map<String, Object>> getScheduleplanmap() {
		return scheduleplanmap;
	}

	public void setScheduleplanmap(List<Map<String, Object>> scheduleplanmap) {
		this.scheduleplanmap = scheduleplanmap;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	public String getOldseats() {
		return oldseats;
	}

	public void setOldseats(String oldseats) {
		this.oldseats = oldseats;
	}

	public String getNewseats() {
		return newseats;
	}

	public void setNewseats(String newseats) {
		this.newseats = newseats;
	}

}
