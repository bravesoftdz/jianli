package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Scheduleselltickettype;
import cn.nova.bus.base.service.ScheduleselltickettypeService;
import cn.nova.bus.base.service.impl.ScheduleselltickettypeServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：班线可售票种设置</b><br/>
 * <b>类名称：</b>ScheduleselltickettypeAction.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class ScheduleselltickettypeAction extends BaseAction{
	private ScheduleselltickettypeService scheduleselltickettypeservice;

	private Scheduleselltickettype selltickettype;
	// 返回结果
	private List<Map<String, Object>> selltickettypelist;
	private String typeids;
	private long id;
	private long routeid;
	
	private List<Map<String, Object>> scheduleRouteInfo;
	
	private long orgid;
	private String type;
	private boolean isupdate;
	private String tickettypes;

	/**
	 * 添加或者修改班线可售票种
	 * @return
	 */
	public String saveselltickettype() {
		scheduleselltickettypeservice = new ScheduleselltickettypeServiceImpl();
		try {
			Scheduleselltickettype s=null;
			if(isupdate){
				s = scheduleselltickettypeservice.updateScheduleselltickettype
				(selltickettype, typeids, tickettypes);
			}else{
				s = scheduleselltickettypeservice.saveScheduleselltickettype
				(selltickettype,typeids,tickettypes);
			}
			if (s!=null) {
				if(isupdate){
					msg="修改成功!";
				}else{
					msg = "添加成功！";
				}					
				id = s.getId();
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
			msg = se.getExceptionMessage();
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("保存失败！");
			markFail();
		}
		return "json";
	}

	public String findselltickettype() {
		scheduleselltickettypeservice = new ScheduleselltickettypeServiceImpl();
		setSelltickettypelist(scheduleselltickettypeservice.findselltickettype(
				ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}
	
	private long scheduleid;
	
	public String findCanSaleTicketType(){
		scheduleselltickettypeservice = new ScheduleselltickettypeServiceImpl();
		setSelltickettypelist(scheduleselltickettypeservice.findCanSaleTicketType(scheduleid));
		return "json";
	}
	
	public String delselltickettype() {
		scheduleselltickettypeservice = new ScheduleselltickettypeServiceImpl();
		boolean result = scheduleselltickettypeservice.delscheduleselltickettype(id);
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
		scheduleselltickettypeservice = new ScheduleselltickettypeServiceImpl();
		setScheduleRouteInfo(scheduleselltickettypeservice
				.findscheduleOrRoute(orgid,type,isupdate,id,routeid));
		return "json";
	}

	public Scheduleselltickettype getSelltickettype() {
		return selltickettype;
	}

	public void setSelltickettype(Scheduleselltickettype selltickettype) {
		this.selltickettype = selltickettype;
	}

	public List<Map<String, Object>> getSelltickettypelist() {
		return selltickettypelist;
	}

	public void setSelltickettypelist(List<Map<String, Object>> selltickettypelist) {
		this.selltickettypelist = selltickettypelist;
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

	public List<Map<String, Object>> getScheduleRouteInfo() {
		return scheduleRouteInfo;
	}

	public void setScheduleRouteInfo(List<Map<String, Object>> scheduleRouteInfo) {
		this.scheduleRouteInfo = scheduleRouteInfo;
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

	public long getRouteid() {
		return routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}

	public String getTickettypes() {
		return tickettypes;
	}

	public void setTickettypes(String tickettypes) {
		this.tickettypes = tickettypes;
	}

	public long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}
	
}
