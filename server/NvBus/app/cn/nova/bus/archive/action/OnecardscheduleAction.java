package cn.nova.bus.archive.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.archive.model.Onecardschedule;
import cn.nova.bus.archive.service.OnecardscheduleService;
import cn.nova.bus.archive.service.impl.OnecardscheduleServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class OnecardscheduleAction extends BaseAction{
	private OnecardscheduleService onecardscheduleService;

	private Onecardschedule onecardschedule;
	// 返回结果
	private List<Map<String, Object>> onecardschedulelist;
	private List<Map<String, Object>> scheduleRouteInfo;
	private String typeids;
	private long id;
	private long routeid;
	
	private long orgid;
	private String type;
	private boolean isupdate;
	private Date startdate;
	private Date enddate;

	public String saveOnecardschedule() {
		onecardscheduleService = new OnecardscheduleServiceImpl();
		type="";
		try {
			Global global = CurrentUtil.getGlobal();
			onecardschedule.setIsactive(true);
			if(isupdate){
				onecardschedule.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				onecardschedule.setUpdateby(global.getUserinfo().getId());
				onecardschedule=
					onecardscheduleService.updateOnecardschedule(onecardschedule, typeids);
			}else{
				onecardschedule.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				onecardschedule.setUpdateby(global.getUserinfo().getId());
				onecardschedule.setCreatetime(new Timestamp(System.currentTimeMillis()));
				onecardschedule.setCreateby(global.getUserinfo().getId());
				onecardschedule=
					onecardscheduleService.saveOnecardschedule(
							onecardschedule, typeids);
			}
		
		if (onecardschedule!=null) {
			if(isupdate){
				msg="修改成功!";
			}else{
				msg = "添加成功！";
			}		
			id = onecardschedule.getId();
			markSuccess();
		}else{
			if(isupdate){
				msg = "修改失败";
			}else{
				msg = "添加失败";
			}					
			markFail();
		}
		}
		catch(ServiceException se){
			onecardschedule=null;
			msg = se.getExceptionMessage();
			markFail();
			id=-1;
		} catch (Exception ex) {
			onecardschedule=null;
			id=-1;
			play.Logger.error(ex.getMessage(), ex);
			msg="保存失败！";
			markFail();
		}
		return "json";
	}

	public String findOnecardschedule() {
		onecardscheduleService = new OnecardscheduleServiceImpl();
		setOnecardschedulelist(onecardscheduleService.findOnecardschedule(
				ServletPropertyFilterUtil.buildFromHttpRequest(), 
				startdate, enddate));
		return "json";
	}
	
	public String delOnecardschedule() {
		onecardscheduleService = new OnecardscheduleServiceImpl();
		boolean result = onecardscheduleService.delschedule(id);
		if (result) {
			msg = "删除成功！";
			markSuccess();
		} else {
			msg = "删除失败！";
			markFail();
		}
		return "json";
	}

	public String findscheduleRouteinfo(){
		onecardscheduleService = new OnecardscheduleServiceImpl();
		scheduleRouteInfo = onecardscheduleService
				.findscheduleOrRoute(orgid,type,isupdate,id,routeid);
		return "json";
	}

	public Onecardschedule getOnecardschedule() {
		return onecardschedule;
	}

	public void setOnecardschedule(Onecardschedule onecardschedule) {
		this.onecardschedule = onecardschedule;
	}

	public List<Map<String, Object>> getOnecardschedulelist() {
		return onecardschedulelist;
	}

	public void setOnecardschedulelist(List<Map<String, Object>> onecardschedulelist) {
		this.onecardschedulelist = onecardschedulelist;
	}

	public List<Map<String, Object>> getScheduleRouteInfo() {
		return scheduleRouteInfo;
	}

	public void setScheduleRouteInfo(List<Map<String, Object>> scheduleRouteInfo) {
		this.scheduleRouteInfo = scheduleRouteInfo;
	}

	public String getTypeids() {
		return typeids;
	}

	public void setTypeids(String typeids) {
		this.typeids = typeids;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getRouteid() {
		return routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}

	public long getOrgid() {
		return orgid;
	}

	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public boolean isIsupdate() {
		return isupdate;
	}

	public void setIsupdate(boolean isupdate) {
		this.isupdate = isupdate;
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
	
}
