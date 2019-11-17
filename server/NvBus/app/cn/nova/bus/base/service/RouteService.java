/**
 * 
 */
package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Routeroad;
import cn.nova.bus.base.model.Routestop;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;

/**
 * @author "ice"
 *
 */
public interface RouteService {
	
	public List<Map<String,Object>> query(List<PropertyFilter> propertyFilterList);
	public List<Map<String, Object>> getRoutestopByRouteId(long routeid);
	public List<Map<String, Object>> getRouteroadByRouteId(long routeid);
	public Route addRoute(Route route,long userid) throws ServiceException;
	public Route updateRoute(Route route,long userid) throws ServiceException;
	public boolean deleteRoute(Route route,long userid) throws ServiceException;
	public Routestop addRoutestop(Routestop routestop,Global global) throws ServiceException;
	public Routestop addRoutestop(Routestop routestop,Global global,String scheduleids) throws ServiceException;
	public Routestop updateRoutestop(Routestop routestop,long userid) throws ServiceException;
	public boolean updateRoutestops(List<Routestop> routestops,Global global) throws ServiceException;
	public boolean deleteRoutestop(Routestop routestop,long userid) throws ServiceException ;
	public boolean swapRoutestopOrderno(long id1,long id2,long userid);
	public Routeroad addRouteroad(Routeroad routeroad,long userid);
	public Routeroad updateRouteroad(Routeroad routeroad,long userid);
	public boolean updateRouteroads(List<Routeroad> routeroads,long userid);
	public boolean deleteRouteroad(Routeroad routeroad,long userid);
	public boolean swapRouteroadOrderno(long id1,long id2,long userid);
	/**
	 * 判断线路停靠点的里程是否正确
	 * @param routestop
	 * @return
	 * @throws ServiceException
	 */
	boolean checkRoutestopDistance(Routestop routestop) throws ServiceException;
	
	public boolean isRouteuse(Route route);
	public boolean findisrealnameticket(Schedule schedule);
	public List<Map<String, Object>> getRouteInfo();
	
	public List<Map<String, Object>> qryDepartTemplate(String templatetypename);
	public String qryrouteprinttemplatebyid(long scheduleplanid);
}
