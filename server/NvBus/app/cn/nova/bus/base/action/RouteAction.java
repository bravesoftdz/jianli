/**
 * 
 */
package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import util.CurrentUtil;
import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Routeroad;
import cn.nova.bus.base.model.Routestop;
import cn.nova.bus.base.service.RouteService;
import cn.nova.bus.base.service.impl.RouteServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * @author "ice"
 *
 */
public class RouteAction extends BaseAction{
	private RouteService routeService;
	private List<Map<String,Object>> routeList; //查询结果
	private List<Map<String,Object>> routestopList; //查询结果
	private List<Map<String,Object>> routeroadList; //查询结果
	private List<Route> updateroutes; //需要批量更新的线路
	private List<Routestop> updateroutestops; //需要批量更新的线路停靠点
	private List<Routeroad> updaterouteroads; //需要批量更新的线路路段
	private Route route;  //添加、修改、删除route用
	private Routeroad routeroad;//添加、修改、删除routeroad用
	private Routestop routestop;//添加、修改、删除routestop用
	private String scheduleids; //添加线路停靠点时，同步添加班次停靠点
	private long routeid;  //查询子表及添加修改线路结果回传
	private long routestopid;
	private long routeroadid;
	private String used;//0:1
	private long scheduleplanid;
	private String templatename;


	private long swapid1;
	private long swapid2;
	
	private String templatetypename;//模板类型名称
	private List<Map<String,Object>> templateList;//模板名称
	
	public String listRoute(){
		try {
			routeService = new RouteServiceImpl();
			setRouteList(routeService.query(ServletPropertyFilterUtil.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String listRoutestop(){
		try {
			routeService = new RouteServiceImpl();
			setRoutestopList(routeService.getRoutestopByRouteId(getRouteid()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String listRouteroad(){
		try {
			routeService = new RouteServiceImpl();
			setRouteroadList(routeService.getRouteroadByRouteId(getRouteid()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * @return
	 */
	public String saveRoute(){
		Global global = CurrentUtil.getGlobal();
		String op = "";
		try {
			routeService = new RouteServiceImpl();
			if(route.getId()<=0){
				op = "添加线路";
				route = routeService.addRoute(route, global.getUserinfo().getId());
				setMsg("添加线路成功");
				setRouteid(route.getId());
			}
			else{
				op = "修改线路";
				route = routeService.updateRoute(route, global.getUserinfo().getId());
				setMsg("修改线路成功");
				setRouteid(route.getId());
			}
			markSuccess();
		} catch (ServiceException e) {
			setMsg(op+"失败，"+e.getExceptionMessage());
			markFail();
		}
		return "json";
	}

	public String deleteRoute(){
		Global global = CurrentUtil.getGlobal();
		try {
			routeService = new RouteServiceImpl();
			routeService.deleteRoute(route, global.getUserinfo().getId());
			setMsg("删除线路成功");
			markSuccess();
		} catch (ServiceException e) {
			setMsg("删除线路失败，"+e.getExceptionMessage());
			markFail();
		}
		return "json";
	}
	
	public String qryRouteuse(){
		//Global global = CurrentUtil.getGlobal();
		routeService = new RouteServiceImpl();
		if (routeService.isRouteuse(route)){
			used="1";
		}else{
			used="0";
		}
		markSuccess();
		return "json";
	}
	

	public String getUsed() {
		return used;
	}

	public void setUsed(String used) {
		this.used = used;
	}

	/**
	 * @return
	 */
	public String saveRoutestop(){
		Global global = CurrentUtil.getGlobal();
		routeService = new RouteServiceImpl();
		if(getUpdateroutestops()!=null){
			if(getUpdateroutestops().size()==1&&getUpdateroutestops().get(0).getOpertype()==2){
				try {
					routeService.deleteRoutestop(getUpdateroutestops().get(0), global.getUserinfo().getId());
					setMsg("删除线路停靠点成功");
					markSuccess();
				} catch (ServiceException e) {
					setMsg("删除线路停靠点失败，"+e.getExceptionMessage());
					markFail();
				}
			}
			else{
				try {
					routeService.updateRoutestops(getUpdateroutestops(),global);
					setMsg("保存成功");
					markSuccess();
				} catch (ServiceException e) {
					setMsg("保存失败，"+e.getExceptionMessage());
					markFail();
				}
			}
		}
		else{
			if(routestop.getId()<=0){
				try {
					routestop = routeService.addRoutestop(routestop, global,scheduleids);
					setMsg("添加线路停靠点成功");
					setRoutestopid(routestop.getId());
					markSuccess();
				} catch (ServiceException e) {
					setMsg("添加失败，"+e.getExceptionMessage());
					markFail();
				}
			}
			else{
				try {
					routestop = routeService.updateRoutestop(routestop, global.getUserinfo().getId());
					setMsg("修改线路停靠点成功");
					setRoutestopid(routestop.getId());
					markSuccess();
				} catch (ServiceException e) {
					setMsg("修改失败，"+e.getExceptionMessage());
					markFail();
				}
			}
		}
		return "json";
	}

	public String deleteRoutestop(){
		Global global = CurrentUtil.getGlobal();
		try {
			routeService = new RouteServiceImpl();
			routeService.deleteRoutestop(routestop, global.getUserinfo().getId());
			setMsg("删除线路停靠点成功");
			markSuccess();
		} catch (ServiceException e) {
			setMsg("删除线路停靠点失败，"+e.getExceptionMessage());
			markFail();
		}
		return "json";
	}
	
	/**
	 * @return
	 */
	public String saveRouteroad(){
		Global global = CurrentUtil.getGlobal();
		routeService = new RouteServiceImpl();
		if(getUpdaterouteroads()!=null){
			if(getUpdaterouteroads().size()==1&&getUpdaterouteroads().get(0).getOpertype()==2){
				routeService.deleteRouteroad(getUpdaterouteroads().get(0), global.getUserinfo().getId());
				setMsg("删除线路路段成功");
			}
			else{
				routeService.updateRouteroads(getUpdaterouteroads(),global.getUserinfo().getId());
				setMsg("保存成功");
			}
			markSuccess();
		}
		else{
			if(routeroad.getId()<=0){
				routeroad = routeService.addRouteroad(routeroad, global.getUserinfo().getId());
				setMsg("添加线路路段成功");
				setRouteroadid(routeroad.getId());
			}
			else{
				routeroad = routeService.updateRouteroad(routeroad, global.getUserinfo().getId());
				setMsg("修改线路路段成功");
				setRouteroadid(routeroad.getId());
			}
			markSuccess();
		}
		return "json";
	}

	public String deleteRouteroad(){
		Global global = CurrentUtil.getGlobal();
		routeService = new RouteServiceImpl();
		routeService.deleteRouteroad(routeroad, global.getUserinfo().getId());
		setMsg("删除线路路段成功");
		markSuccess();
		return "json";
	}
	
	public String swapRoutestopOrderno(){
		Global global = CurrentUtil.getGlobal();
		routeService = new RouteServiceImpl();
		routeService.swapRoutestopOrderno(getSwapid1(), getSwapid2(), global.getUserinfo().getId());
		setMsg("修改序号成功");
		markSuccess();
		return "json";
	}
	
	public String swapRouteroadOrderno(){
		Global global = CurrentUtil.getGlobal();
		routeService = new RouteServiceImpl();
		routeService.swapRouteroadOrderno(getSwapid1(), getSwapid2(), global.getUserinfo().getId());
		setMsg("修改序号成功");
		markSuccess();
		return "json";
	}
	
	/**
	 * 查询线路打印模版（通过班次计划ID）
	 * @return
	 */
	public String qryrouteprinttemplatebyid(){
		try {
			routeService = new RouteServiceImpl();
			templatename = routeService.qryrouteprinttemplatebyid(scheduleplanid);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 查询结算单模板名称
	 * @return
	 */
	public String qryDepartTemplate(){
		try {
			routeService = new RouteServiceImpl();
			setTemplateList(routeService.qryDepartTemplate(templatetypename));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public void setRouteList(List<Map<String,Object>> routeList) {
		this.routeList = routeList;
	}

	public List<Map<String,Object>> getRouteList() {
		return routeList;
	}

	public void setRoutestopList(List<Map<String,Object>> routestopList) {
		this.routestopList = routestopList;
	}

	public List<Map<String,Object>> getRoutestopList() {
		return routestopList;
	}

	public void setRouteroadList(List<Map<String,Object>> routeroadList) {
		this.routeroadList = routeroadList;
	}

	public List<Map<String,Object>> getRouteroadList() {
		return routeroadList;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}

	public long getRouteid() {
		return routeid;
	}
	
	@Transient
	public Route getRoute() {
		return route;
	}

	public void setRoute(Route route) {
		this.route = route;
	}

	@Transient
	public Routeroad getRouteroad() {
		return routeroad;
	}

	public void setRouteroad(Routeroad routeroad) {
		this.routeroad = routeroad;
	}

	@Transient
	public Routestop getRoutestop() {
		return routestop;
	}

	public void setRoutestop(Routestop routestop) {
		this.routestop = routestop;
	}

	public void setRouteroadid(long routeroadid) {
		this.routeroadid = routeroadid;
	}

	public long getRouteroadid() {
		return routeroadid;
	}

	public void setRoutestopid(long routestopid) {
		this.routestopid = routestopid;
	}

	public long getRoutestopid() {
		return routestopid;
	}

	public void setUpdateroutes(List<Route> updateroutes) {
		this.updateroutes = updateroutes;
	}

	@Transient
	public List<Route> getUpdateroutes() {
		return updateroutes;
	}

	public void setUpdateroutestops(List<Routestop> updateroutestops) {
		this.updateroutestops = updateroutestops;
	}

	@Transient
	public List<Routestop> getUpdateroutestops() {
		return updateroutestops;
	}

	public void setUpdaterouteroads(List<Routeroad> updaterouteroads) {
		this.updaterouteroads = updaterouteroads;
	}

	@Transient
	public List<Routeroad> getUpdaterouteroads() {
		return updaterouteroads;
	}

	public void setSwapid2(long swapid2) {
		this.swapid2 = swapid2;
	}

	@Transient
	public long getSwapid2() {
		return swapid2;
	}

	public void setSwapid1(long swapid1) {
		this.swapid1 = swapid1;
	}

	@Transient
	public long getSwapid1() {
		return swapid1;
	}

	public String getScheduleids() {
		return scheduleids;
	}

	public void setScheduleids(String scheduleids) {
		this.scheduleids = scheduleids;
	}

	public String getTemplatetypename() {
		return templatetypename;
	}

	public void setTemplatetypename(String templatetypename) {
		this.templatetypename = templatetypename;
	}

	public List<Map<String, Object>> getTemplateList() {
		return templateList;
	}

	public void setTemplateList(List<Map<String, Object>> templateList) {
		this.templateList = templateList;
	}

	public long getScheduleplanid() {
		return scheduleplanid;
	}

	public void setScheduleplanid(long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	public String getTemplatename() {
		return templatename;
	}

	public void setTemplatename(String templatename) {
		this.templatename = templatename;
	}

}
