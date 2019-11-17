package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Pcsellschedule;
import cn.nova.bus.base.model.Pcticketentrance;
import cn.nova.bus.base.service.PCSellscheduleService;
import cn.nova.bus.base.service.impl.PCSellscheduleServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * 售票机器控制
 * 
 * @author hhz
 * 
 */
public class PCSellscheduleAction extends BaseAction{

	private PCSellscheduleService sellscheduleService;

	private Pcsellschedule pcsellschedule;
	private Pcticketentrance pcticketentrance;
	// 返回结果
	private List<Map<String, Object>> controlmap;
	private List<Map<String, Object>> typeIpnames;
	private List<Map<String, Object>> scheduleOrRouteInfo;
	private long routeid;
	private Boolean isupdate;

	// 参数
	private String typeids;

	public String savePCschedule() {
		try {
			sellscheduleService = new PCSellscheduleServiceImpl();
			boolean result;
			if (isupdate){
				result = sellscheduleService.updatePcsellschedule(pcsellschedule, typeids);
			}else{
				result = sellscheduleService.savePcsellschedule(pcsellschedule, typeids);
			}
			if(result){
				msg = "保存成功！";
				markSuccess();
			}else{
				msg = "保存失败";
				markFail();
			}
			
		}
		catch(ServiceException se){
			msg = se.getExceptionMessage();
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("保存失败！");
			markFail();
		}
		return "json";
	}

	public String findPCschedule() {
		sellscheduleService = new PCSellscheduleServiceImpl();
		controlmap = sellscheduleService
				.findsellschedule(ServletPropertyFilterUtil
						.buildFromHttpRequest());
		return "json";
	}

	public String findTypeIdName() {
		sellscheduleService = new PCSellscheduleServiceImpl();
		typeIpnames = sellscheduleService.findschedulesname(pcsellschedule);
		return "json";
	}

	public String findscheduleOrRoute() {
		sellscheduleService = new PCSellscheduleServiceImpl();
		scheduleOrRouteInfo = sellscheduleService
				.findscheduleOrRoute(pcsellschedule,routeid,isupdate);
		return "json";
	}

	public String delsellschedulewhere() {
		sellscheduleService = new PCSellscheduleServiceImpl();
		boolean result = sellscheduleService.delschedule(pcsellschedule);
		if (result) {
			msg = "删除成功！";
			markSuccess();
		} else {
			msg = "删除失败！";
			markFail();
		}
		return "json";
	}

	public Pcsellschedule getPcsellschedule() {
		return pcsellschedule;
	}

	public void setPcsellschedule(Pcsellschedule pcsellschedule) {
		this.pcsellschedule = pcsellschedule;
	}

	public Pcticketentrance getPcticketentrance() {
		return pcticketentrance;
	}

	public void setPcticketentrance(Pcticketentrance pcticketentrance) {
		this.pcticketentrance = pcticketentrance;
	}

	public List<Map<String, Object>> getControlmap() {
		return controlmap;
	}

	public void setControlmap(List<Map<String, Object>> controlmap) {
		this.controlmap = controlmap;
	}

	public List<Map<String, Object>> getTypeIpnames() {
		return typeIpnames;
	}

	public void setTypeIpnames(List<Map<String, Object>> typeIpnames) {
		this.typeIpnames = typeIpnames;
	}

	public List<Map<String, Object>> getScheduleOrRouteInfo() {
		return scheduleOrRouteInfo;
	}

	public void setScheduleOrRouteInfo(
			List<Map<String, Object>> scheduleOrRouteInfo) {
		this.scheduleOrRouteInfo = scheduleOrRouteInfo;
	}
	
	public String getTypeids() {
		return typeids;
	}

	public void setTypeids(String typeids) {
		this.typeids = typeids;
	}

	public long getRouteid() {
		return routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}

	public Boolean isIsupdate() {
		return isupdate;
	}

	public void setIsupdate(Boolean isupdate) {
		this.isupdate = isupdate;
	}
	
}
