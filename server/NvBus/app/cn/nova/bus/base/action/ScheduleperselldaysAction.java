package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.base.model.Scheduleperselldays;
import cn.nova.bus.base.service.ScheduleperselldaysService;
import cn.nova.bus.base.service.impl.ScheduleperselldaysServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;
//import org.apache.struts2.json.annotations.JSON;

/**
 * 班次预售天数控制
 * @author Administrator
 *
 */
public class ScheduleperselldaysAction extends BaseAction{

	private ScheduleperselldaysService scheduleperselldaysService;

	private Scheduleperselldays scheduleperselldays;
	// 返回结果
	private List<Map<String, Object>> perselldayslist;
	private List<Map<String, Object>> scheduleRouteInfo;
	private String typeids;
	private long id;
	private long routeid;
	
	private long orgid;
	private String type;
	private boolean isupdate;

	public String saveperselldays() {
		type="";
		try {
			scheduleperselldaysService = new ScheduleperselldaysServiceImpl();
			Global global = CurrentUtil.getGlobal();
			if(isupdate){
				scheduleperselldays.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				scheduleperselldays.setUpdateby(global.getUserinfo().getId());
				scheduleperselldays=
					scheduleperselldaysService.updateScheduleperselldays(scheduleperselldays, typeids);
			}else{
				scheduleperselldays.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				scheduleperselldays.setUpdateby(global.getUserinfo().getId());
				scheduleperselldays.setCreatetime(new Timestamp(System.currentTimeMillis()));
				scheduleperselldays.setCreateby(global.getUserinfo().getId());
				scheduleperselldays=
					scheduleperselldaysService.saveScheduleperselldays(
							scheduleperselldays, typeids);
			}
		
		if (scheduleperselldays!=null) {
			if(isupdate){
				msg="修改成功!";
			}else{
				msg = "添加成功！";
			}		
			id = scheduleperselldays.getId();
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
			scheduleperselldays=null;
			msg = se.getExceptionMessage();
			markFail();
			id=-1;
		} catch (Exception ex) {
			scheduleperselldays=null;
			id=-1;
			play.Logger.error(ex.getMessage(), ex);
			setMsg("保存失败！");
			markFail();
		}
		return "json";
	}

	public String findScheduleperselldays() {
		scheduleperselldaysService = new ScheduleperselldaysServiceImpl();
		setPerselldayslist(scheduleperselldaysService.findScheduleperselldays(
				ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}
	
	public String delpersellday() {
		scheduleperselldaysService = new ScheduleperselldaysServiceImpl();
		boolean result = scheduleperselldaysService.delschedule(id);
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
		scheduleperselldaysService = new ScheduleperselldaysServiceImpl();
		scheduleRouteInfo = scheduleperselldaysService
				.findscheduleOrRoute(orgid,type,isupdate,id,routeid);
		return "json";
	}

	public Scheduleperselldays getScheduleperselldays() {
		return scheduleperselldays;
	}

	public void setScheduleperselldays(Scheduleperselldays scheduleperselldays) {
		this.scheduleperselldays = scheduleperselldays;
	}

	public List<Map<String, Object>> getPerselldayslist() {
		return perselldayslist;
	}

	public void setPerselldayslist(List<Map<String, Object>> perselldayslist) {
		this.perselldayslist = perselldayslist;
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
	
}
