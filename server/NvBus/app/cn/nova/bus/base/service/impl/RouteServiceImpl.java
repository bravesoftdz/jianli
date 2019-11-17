/**
 * 
 */
package cn.nova.bus.base.service.impl;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.RouteDao;
import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Routeroad;
import cn.nova.bus.base.model.Routestop;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Schedulestop;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.service.RouteService;
import cn.nova.bus.base.service.ScheduleService;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.dao.RoutePriceDao;
import cn.nova.bus.price.model.Routeprice;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.service.impl.RoutepriceServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * @author "ice"
 *
 */
public class RouteServiceImpl implements RouteService {

	private RouteDao routeDao = new RouteDao();

	private IDAO dao = new EntityManagerDaoSurport();
	private ScheduleService scheduleService = new ScheduleServiceImpl();

	private ParameterService parameterService = new ParameterServiceImpl();

	/*
	 * (non-Javadoc)
	 * 
	 * @see cn.nova.bus.base.service.RouteService#query()
	 */
	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Route.class,
				"startstationname", "endstationname", "orgname",
				"createbyname", "updatebyname" },
				routeDao.query(propertyFilterList), new Object[] { Route.class,
						String.class, String.class, String.class, String.class,
						String.class });
	}

	public List<Map<String, Object>> getRoutestopByRouteId(long routeid) {
		Route route = new Route();
		route.setId(routeid);
		return ListUtil.listToMap(
				new Object[] { Routestop.class, "stationname" },
				routeDao.getRoutestop(route), new Object[] { Routestop.class,
						String.class });
	}

	public List<Map<String, Object>> getRouteroadByRouteId(long routeid) {
		Route route = new Route();
		route.setId(routeid);
		List<Object> result = new ArrayList<Object>();
		result.addAll(routeDao.getRouteroad(route));
		return ListUtil.listToMap(new Object[] { Routeroad.class }, result,
				new Object[] { Routeroad.class });
	}

	@Override
	public Route addRoute(Route route, long userid) throws ServiceException {
		Userinfo user = (Userinfo) dao.get(Userinfo.class, userid);
		// route.setOrgid(user.getOrgid());

		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters
				.add(new PropertyFilter("EQL_t!orgid", route.getOrgid()));
		propertyFilters.add(new PropertyFilter("EQS_t!name", route.getName()));
		propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
		List<Route> _routes = routeDao.find(Route.class, propertyFilters);
		if (_routes != null && _routes.size() > 0) {
			throw new ServiceException("0247");
		}

		route.setUpdateby(userid);
		route.setUpdatetime(new Date());
		route.setCreateby(userid);
		route.setCreatetime(new Date());
		route.setIsactive(true);
		route.setCode(getNextRouteCode(route));
		route.setIsaudited(false);
		route.setIsauditpass(false);
		// route.setDistance(0);
		route.setPrinttemplateid(route.getPrinttemplateid());
		route.setHighdistance(0);

		List<Routestop> routestops = new ArrayList<Routestop>();
		Routestop startroutestop = new Routestop();
		startroutestop.setRoute(route);
		startroutestop.setBalancedistance(0);
		startroutestop.setCreateby(userid);
		startroutestop.setCreatetime(new Date());
		startroutestop.setDistance(0);
		startroutestop.setIsactive(true);
		startroutestop.setUpdateby(userid);
		startroutestop.setUpdatetime(new Date());
		startroutestop.setOrderno((byte) 0);
		startroutestop.setIsdepart(true);
		startroutestop.setStationid(route.getStartstationid());
		routestops.add(startroutestop);
		// routeDao.merge(startroutestop);

		Routestop endroutestop = new Routestop();
		endroutestop.setRoute(route);
		endroutestop.setCreateby(userid);
		endroutestop.setCreatetime(new Date());
		endroutestop.setDistance(route.getDistance());
		endroutestop.setBalancedistance(route.getDistance());
		endroutestop.setIsactive(true);
		endroutestop.setIsdepart(false);
		endroutestop.setUpdateby(userid);
		endroutestop.setUpdatetime(new Date());
		endroutestop.setOrderno((byte) 1);
		endroutestop.setStationid(route.getEndstationid());
		routestops.add(endroutestop);
		// routeDao.merge(endroutestop);
		route.setRoutestops(routestops);
		// return (Route) routeDao.merge(route);
		routeDao.save(route);
		return route;
	}

	public String getNextRouteCode(Route route) {
		StringBuilder routeCode = new StringBuilder();
		Station station = (Station) dao.get(Station.class,
				route.getStartstationid());
		routeCode.append(station.getCode());
		station = (Station) dao.get(Station.class, route.getEndstationid());
		routeCode.append(station.getCode());
		routeCode.append(route.getDistricttype()).append(route.getType());
		List<PropertyFilter> propertyFilterList = new ArrayList<PropertyFilter>();
		propertyFilterList.add(new PropertyFilter("LIKELS_r!code", routeCode
				.toString()));
		List<Route> routes = routeDao.queryIgnoreActive(propertyFilterList);
		Integer maxRouteCodeSN = 0;
		if (routes.size() > 0) {
			String maxRouteCode = routes.get(routes.size() - 1).getCode();
			maxRouteCodeSN = new Integer(maxRouteCode.substring(maxRouteCode
					.length() - 1));
		}
		return routeCode.append(++maxRouteCodeSN).toString();
	}

	@Override
	public Route updateRoute(Route route, long userid) throws ServiceException {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters
				.add(new PropertyFilter("EQL_t!orgid", route.getOrgid()));
		propertyFilters.add(new PropertyFilter("EQS_t!name", route.getName()));
		propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
		propertyFilters.add(new PropertyFilter("NOEQL_t!id", route.getId()));
		List<Route> _routes = routeDao.find(Route.class, propertyFilters);
		if (_routes != null && _routes.size() > 0) {
			throw new ServiceException("0247");
		}
		route.setUpdateby(userid);
		route.setUpdatetime(new Date());
		return (Route) routeDao.merge(route);
	}

	@Override
	public boolean deleteRoute(Route route, long userid)
			throws ServiceException {
		route = (Route) routeDao.get(Route.class, route.getId());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("route", route);
		map.put("isactive", true);
		List<Schedule> schedules = dao.find(Schedule.class, map);
		for(Schedule ss:schedules){
			ss.setIsactive(false);
			ss.setUpdateby(userid);
			ss.setUpdatetime(new Date());
			dao.merge(ss);
		}
		/*if (schedules != null && schedules.size() > 0) {
			throw new ServiceException("0005");
		}*/
		route.setUpdateby(userid);
		route.setUpdatetime(new Date());
		route.setIsactive(false);
		route.setIslocaldelete(true);
		return routeDao.merge(route) == null ? false : true;
	}

	@Override
	public Routestop addRoutestop(Routestop routestop, Global global)
			throws ServiceException {
		long userid = global.getUserinfo().getId();
		// 判断有没有注销的
		Routestop routestop_old = routeDao.getRoutestop(routestop.getRoute(),
				routestop.getStationid());
		if (routestop_old != null) {
			if (routestop_old.getIsactive() == true) {
				throw new ServiceException("0004");
			} else {
				routestop_old
						.setBalancedistance(routestop.getBalancedistance());
				routestop_old.setCreateby(userid);
				routestop_old.setCreatetime(new Date());
				routestop_old.setDistance(routestop.getBalancedistance());
				routestop = routestop_old;
			}
		} else {
			routestop.setCreateby(userid);
			routestop.setCreatetime(new Date());
			routestop.setOrderno(getInsertRoutestopOrderno(routestop));			
		}
		routestop.setIsactive(true);
		routestop.setUpdateby(userid);
		routestop.setUpdatetime(new Date());
		Routestop result = (Routestop) routeDao.merge(routestop);
		routeDao.getEntityManager().flush();
		Route route = (Route) routeDao.get(Route.class, routestop.getRoute()
				.getId());
		updateRouteDistance(route);

		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Date fromdate = new Date();
		Date todate = new Date();
		try {
			fromdate = sf.parse(sf.format(new Date()));
			todate = sf.parse("9999-12-12");
		} catch (ParseException e) {
			play.Logger.error(e.getMessage(), e);
		}
		Routeprice routeprice = new Routeprice();
		routeprice.setBalanceprice(new BigDecimal(0));
		routeprice.setPrice(new BigDecimal(0));
		routeprice.setCreateby(global.getUserinfo().getId());
		routeprice.setCreatetime(new Date());
		routeprice.setFromdate(fromdate);
		routeprice.setTodate(todate);
		routeprice.setRouteid(route.getId());
		routeprice.setFromstationid(route.getStartstationid());
		routeprice.setReachstationid(routestop.getStationid());
		routeprice.setIsbaseprice(true);
		routeprice.setOrgid(route.getOrgid());
		routeprice.setUpdateby(global.getUserinfo().getId());
		routeprice.setUpdatetime(new Date());
		RoutePriceDao routePriceDao = new RoutePriceDao();
		if (!routePriceDao.isExistRoutePrice(routeprice.getRouteid(),
				routeprice.getFromstationid(), routeprice.getReachstationid(),routeprice.getIsbaseprice())) {
			routePriceDao.save(routeprice);
		}
		return result;
	}

	private int getInsertRoutestopOrderno(Routestop newroutestop)
			throws ServiceException {
		Route route = (Route) dao.get(Route.class, newroutestop.getRoute()
				.getId());
		//List<Routestop> routestops = route.getRoutestops();
		int maxorderno = -1;
	//	Routestop minerroutestop = null;
		Routestop maxerroutestop = null;

        List<Routestop> routestops = routeDao.qryRoutestop(route.getId());
        boolean isfind=false;
		for (Routestop _routestop : routestops) {
			maxorderno=_routestop.getOrderno();
			maxerroutestop=_routestop;
			if(_routestop.getDistance()>newroutestop.getDistance()){
				newroutestop.setOrderno(_routestop.getOrderno());
				isfind=true;
				break;
			}			
		}
		
        /*
		// 根据里程取新序号
		for (Routestop _routestop : routestops) {
			if (_routestop.getBalancedistance() <= newroutestop
					.getBalancedistance()
					&& (minerroutestop == null || _routestop
							.getBalancedistance() >= minerroutestop
							.getBalancedistance())) {
				minerroutestop = _routestop;
			} else if (_routestop.getBalancedistance() >= newroutestop
					.getBalancedistance()
					&& (maxerroutestop == null || _routestop
							.getBalancedistance() <= maxerroutestop
							.getBalancedistance())) {
				maxerroutestop = _routestop;
			}
			if (maxorderno <= _routestop.getOrderno()) {
				maxorderno = _routestop.getOrderno();
			}
		}
		if (minerroutestop == null) {
			// 新添加的停靠点里程不能小于始发站里程
			throw new ServiceException("0329");
		}
		if ("1".equals(flag) && maxerroutestop == null) {
			// 新添加的停靠点里程不能大于始发站里程
			throw new ServiceException("0331");
		}
		byte distanceOrderno = minerroutestop.getOrderno();

		// 根据结算里程取新序号
		Routestop minerroutestop_balance = null;
		Routestop maxerroutestop_balance = null;
		// 根据里程取新序号
		for (Routestop _routestop : routestops) {
			if (_routestop.getBalancedistance() <= newroutestop
					.getBalancedistance()
					&& (minerroutestop_balance == null || _routestop
							.getBalancedistance() >= minerroutestop_balance
							.getBalancedistance())) {
				minerroutestop_balance = _routestop;
			} else if (_routestop.getBalancedistance() >= newroutestop
					.getBalancedistance()
					&& (maxerroutestop_balance == null || _routestop
							.getBalancedistance() <= maxerroutestop_balance
							.getBalancedistance())) {
				maxerroutestop_balance = _routestop;
			}
		}
		if (minerroutestop_balance == null) {
			// 新添加的停靠点里程不能小于始发站里程
			throw new ServiceException("0330");
		}
		if ("1".equals(flag) && maxerroutestop_balance == null) {
			// 新添加的停靠点里程不能大于始发站里程
			throw new ServiceException("0332");
		}
		if (!minerroutestop_balance.equals(minerroutestop)) {
			// 停靠点的里程或结算里程设置不允许大于后站里程且不能小于前站里程
			throw new ServiceException("0325");
		}*/
		if (isfind){
			// 修改后面停靠点的序号
			for (int i = routestops.size() - 1; i >= 0; i--) {
				Routestop _routestop = routestops.get(i);
				if (_routestop.getOrderno() >= newroutestop.getOrderno()) {
					_routestop.setOrderno((byte) (_routestop.getOrderno() + 1));
					routeDao.merge(_routestop);
					routeDao.getEntityManager().flush();
				}
			}
			return newroutestop.getOrderno();
		}else{
			// 新增站点是否允许超过最大里程
			/*String flag = parameterService.findParamValue("0020", route.getOrgid());
			if(!flag.equals("1")){
				// 停靠点里程不能大于始终到站里程
				throw new ServiceException("0329");
			}*/
			maxerroutestop.setOrderno((byte) (maxorderno + 1));
			routeDao.merge(maxerroutestop);
			routeDao.getEntityManager().flush();
			return maxorderno;
		}
	}

	public int getLastRoutestopOrderno(Routestop routestop) {
		int maxorderno = 0;
		Routestop maxRoutestop = null;
		List<Object> routestops = routeDao.getRoutestop(routestop.getRoute());
		for (Object obj : routestops) {
			Object[] rows;
			try {
				rows = (Object[]) obj;
			} catch (Exception e) {
				rows = new Object[] { obj };
			}
			Routestop _routestop = (Routestop) rows[0];
			if (_routestop.getOrderno() > maxorderno) {
				maxorderno = _routestop.getOrderno();
				maxRoutestop = _routestop;
			}
		}
		if (maxRoutestop != null) {
			maxRoutestop.setOrderno((byte) (maxorderno + 1));
			// maxRoutestop.setDistance(Math.max(0,maxRoutestop.getDistance()-routestop.getDistance()));
			// maxRoutestop.setBalancedistance(Math.max(0,maxRoutestop.getBalancedistance()-routestop.getBalancedistance()));
			routeDao.merge(maxRoutestop);
			routeDao.getEntityManager().flush();
		}
		return maxorderno;
	}

	@Override
	public Routestop updateRoutestop(Routestop routestop, long userid)
			throws ServiceException {
		Routestop routestop_old = routeDao.getRoutestop(routestop.getRoute(),
				routestop.getStationid());
		if (routestop_old != null) {
			if (routestop_old.getIsactive() == true
					&& routestop_old.getId() != routestop.getId()) {
				throw new ServiceException("0004");
			}
		}

		checkRoutestopDistance(routestop);
		routestop.setUpdateby(userid);
		routestop.setUpdatetime(new Date());
		Routestop result = (Routestop) routeDao.merge(routestop);
		routeDao.getEntityManager().flush();
		updateRouteDistance((Route) routeDao.get(Route.class, routestop
				.getRoute().getId()));
		return result;
	}

	/**
	 * 判断线路停靠点的里程设置是否正确
	 * 
	 * @param routestop
	 * @return
	 * @throws ServiceException
	 */
	@Override
	public boolean checkRoutestopDistance(Routestop routestop)
			throws ServiceException {
		// 检查里程是否正确
		Route route = (Route) dao
				.get(Route.class, routestop.getRoute().getId());
		if (ParamterConst.COMMON_FLAG.FALG_NO.equals(parameterService.findParamValue(ParamterConst.Param_0012, route.getOrgid()))) {
			return true;
		}
		for (Routestop _routestop : route.getRoutestops()) {
			if (!_routestop.getIsactive()) {
				continue;
			}
			if ((_routestop.getOrderno() > routestop.getOrderno() && (_routestop
					.getBalancedistance() < routestop.getBalancedistance() || _routestop
					.getBalancedistance() < routestop.getBalancedistance()))
					|| (_routestop.getOrderno() < routestop.getOrderno() && (_routestop
							.getBalancedistance() > routestop
							.getBalancedistance() || _routestop
							.getBalancedistance() > routestop
							.getBalancedistance()))) {
				// 停靠点的里程或结算里程设置不允许大于后站里程且不能小于前站里程
				throw new ServiceException("0326");
			}
		}
		return true;
	}

	public Route updateRouteDistance(Route route) {
		// int distance=0;
		// int balancedistance=0;
		// for (Routestop routestop : route.getRoutestops()) {
		// if(!routestop.getIsactive()){
		// continue;
		// }
		// distance = distance + routestop.getDistance();
		// balancedistance = balancedistance + routestop.getBalancedistance();
		// }
		// route.setDistance(distance);
		// return (Route) routeDao.merge(route);
		int maxorderno = 0;
		Routestop lasRoutestop = null;
		for (Routestop routestop : route.getRoutestops()) {
			if (!routestop.getIsactive()) {
				continue;
			}
			if (maxorderno < routestop.getOrderno()) {
				maxorderno = routestop.getOrderno();
				lasRoutestop = routestop;
			}
		}
		if (lasRoutestop != null) {
			route.setDistance(lasRoutestop.getBalancedistance());
			return (Route) routeDao.merge(route);
		} else {
			return route;
		}
	}

	public Route updateRouteHighDistance(Route route) {
		int highdistance = 0;
		for (Routeroad routeroad : route.getRouteroads()) {
			if (routeroad.getRoadgrade().equals("0")) {
				highdistance = highdistance + routeroad.getDistance();
			}
		}
		route.setHighdistance(highdistance);
		return (Route) routeDao.merge(route);
	}

	@Override
	public boolean deleteRoutestop(Routestop routestop, long userid)
			throws ServiceException {
		routestop = (Routestop) routeDao
				.get(Routestop.class, routestop.getId());
		/*
		 * StringBuilder sql = new StringBuilder(); sql.append("select st")
		 * .append
		 * (" from Schedulestop st join st.schedule sc join sc.route ro");
		 * List<PropertyFilter> propertyFilters = new
		 * ArrayList<PropertyFilter>(); propertyFilters.add(new
		 * PropertyFilter("EQL_st!stationid", routestop.getStationid()));
		 * propertyFilters.add(new PropertyFilter("EQB_st!isactive", true));
		 * propertyFilters.add(new PropertyFilter("EQO_sc!route",
		 * routestop.getRoute())); List<Schedulestop> schedulestops =
		 * dao.find(sql.toString(), propertyFilters);
		 * if(schedulestops!=null&&schedulestops.size()>0){ throw new
		 * ServiceException("0318"); //该线路停靠点已经在班次停靠点中使用 }
		 */
		routeDao.delRouteprice(routestop.getRoute().getId(),
				routestop.getStationid());
		routeDao.delSchprice(routestop.getRoute().getId(),
				routestop.getStationid());
		routestop.setUpdateby(userid);
		routestop.setUpdatetime(new Date());
		routestop.setIsactive(false);
		boolean result = routeDao.merge(routestop) == null ? false : true;
		routeDao.getEntityManager().flush();
		updateRouteDistance((Route) routeDao.get(Route.class, routestop
				.getRoute().getId()));
		return result;
	}

	@Override
	public Routeroad addRouteroad(Routeroad routeroad, long userid) {
		routeroad.setCreateby(userid);
		routeroad.setCreatetime(new Date());
		routeroad.setUpdateby(userid);
		routeroad.setUpdatetime(new Date());
		routeroad.setOrderno(routeDao.getMaxRouteroadOrderno(routeroad
				.getRoute()));
		Routeroad result = (Routeroad) routeDao.merge(routeroad);
		routeDao.getEntityManager().flush();
		updateRouteHighDistance((Route) routeDao.get(Route.class, routeroad
				.getRoute().getId()));
		return result;
	}

	@Override
	public Routeroad updateRouteroad(Routeroad routeroad, long userid) {
		routeroad.setUpdateby(userid);
		routeroad.setUpdatetime(new Date());
		Routeroad result = (Routeroad) routeDao.merge(routeroad);
		routeDao.getEntityManager().flush();
		updateRouteHighDistance((Route) routeDao.get(Route.class, routeroad
				.getRoute().getId()));
		return result;
	}

	@Override
	public boolean deleteRouteroad(Routeroad routeroad, long userid) {
		routeroad = (Routeroad) routeDao
				.get(Routeroad.class, routeroad.getId());
		Route route = routeroad.getRoute();
		boolean result = routeDao.del(routeroad);
		updateRouteHighDistance(route);
		return result;
	}

	@Override
	public boolean updateRoutestops(List<Routestop> routestops, Global global)
			throws ServiceException {
		boolean result = true;
		long userid = global.getUserinfo().getId();
		if (routestops != null && routestops.size() > 0) {
			for (Routestop routestop : routestops) {
				switch (routestop.getOpertype()) {
				case 2:
					result = deleteRoutestop(routestop, userid);
					break;
				case 4:
					if (addRoutestop(routestop, global) == null) {
						result = false;
					}
					break;
				default:
					if (updateRoutestop(routestop, userid) == null) {
						result = false;
					}
					break;
				}
			}
			updateRouteDistance((Route) routeDao.get(Route.class, routestops
					.get(0).getRoute().getId()));
		}
		return result;
	}

	@Override
	public boolean updateRouteroads(List<Routeroad> routeroads, long userid) {
		boolean result = true;
		if (routeroads != null && routeroads.size() > 0) {
			for (Routeroad routeroad : routeroads) {
				switch (routeroad.getOpertype()) {
				case 2:
					result = deleteRouteroad(routeroad, userid);
					break;
				case 4:
					if (addRouteroad(routeroad, userid) == null) {
						result = false;
					}
					break;
				default:
					if (updateRouteroad(routeroad, userid) == null) {
						result = false;
					}
					break;
				}
			}
			updateRouteHighDistance((Route) routeDao.get(Route.class,
					routeroads.get(0).getRoute().getId()));
		}
		return result;
	}

	@Override
	public boolean swapRoutestopOrderno(long id1, long id2, long userid) {
		Routestop routestop1 = (Routestop) routeDao.get(Routestop.class, id1);
		routestop1.setUpdateby(userid);
		routestop1.setUpdatetime(new Date());
		Routestop routestop2 = (Routestop) routeDao.get(Routestop.class, id2);
		routestop2.setUpdateby(userid);
		routestop2.setUpdatetime(new Date());
		int orderno1 = routestop1.getOrderno();
		int orderno2 = routestop2.getOrderno();
		routestop2.setOrderno((byte) -1);
		routeDao.merge(routestop2);
		routeDao.getEntityManager().flush();
		routestop1.setOrderno(orderno2);
		routeDao.merge(routestop1);
		routeDao.getEntityManager().flush();
		routestop2.setOrderno(orderno1);
		routeDao.merge(routestop2);
		return true;
	}

	@Override
	public boolean swapRouteroadOrderno(long id1, long id2, long userid) {
		Routeroad routeroad1 = (Routeroad) routeDao.get(Routeroad.class, id1);
		routeroad1.setUpdateby(userid);
		routeroad1.setUpdatetime(new Date());
		Routeroad routeroad2 = (Routeroad) routeDao.get(Routeroad.class, id2);
		routeroad2.setUpdateby(userid);
		routeroad2.setUpdatetime(new Date());
		int orderno1 = routeroad1.getOrderno();
		int orderno2 = routeroad2.getOrderno();
		routeroad2.setOrderno(-1);
		routeDao.merge(routeroad2);
		routeDao.getEntityManager().flush();
		routeroad1.setOrderno(orderno2);
		routeDao.merge(routeroad1);
		routeDao.getEntityManager().flush();
		routeroad2.setOrderno(orderno1);
		routeDao.merge(routeroad2);
		return true;
	}

	@Override
	public Routestop addRoutestop(Routestop routestop, Global global,
			String scheduleids) throws ServiceException {
		long userid = global.getUserinfo().getId();
		routestop = addRoutestop(routestop, global);
		if (scheduleids != null && !scheduleids.trim().equals("")) {
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			propertyFilters.add(new PropertyFilter("INS_t!id", scheduleids));
			List<Schedule> schedules = dao
					.find(Schedule.class, propertyFilters);
			for (Schedule schedule : schedules) {
				Schedulestop schedulestop = new Schedulestop();
				schedulestop.setCreateby(userid);
				schedulestop.setCreatetime(new Date());
				schedulestop.setIsactive(true);
				schedulestop.setIsdepart(false);
				schedulestop.setIssellable(true);
				schedulestop.setOrderno(routestop.getOrderno());
				schedulestop.setSchedule(schedule);
				schedulestop.setStationid(routestop.getStationid());
				schedulestop.setUpdateby(userid);
				schedulestop.setUpdatetime(schedulestop.getCreatetime());
				scheduleService.saveScheduleStop(schedulestop);
			}
		}
		return routestop;
	}

	public ScheduleService getScheduleService() {
		return scheduleService;
	}

	public void setScheduleService(ScheduleService scheduleService) {
		this.scheduleService = scheduleService;
	}

	public ParameterService getParameterService() {
		return parameterService;
	}

	public void setParameterService(ParameterService parameterService) {
		this.parameterService = parameterService;
	}

	@Override
	public boolean isRouteuse(Route route){
		route = (Route) routeDao.get(Route.class, route.getId());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("route", route);
		map.put("isactive", true);
		List<Schedule> schedules = dao.find(Schedule.class, map);
		if (schedules != null && schedules.size() > 0) {
			return true;
		}else{
			return false;
		}
	}
	@Override
	public boolean findisrealnameticket(Schedule schedule) {
		Schedule schedule_= (Schedule) routeDao.get(Schedule.class, schedule.getId());
		return schedule_.getRoute().isIsrealnameticket();
	}

	@Override
	public List<Map<String, Object>> getRouteInfo() {
		Object[] fileds = { "code", "startstationid", "endstationid", "distance", "highdistance",
				"type", "orgid"};// 初始化要查询的字段
		Object[] filedtypes = { String.class, Long.class, Long.class,Long.class,Long.class,
				String.class,Long.class};// 初始化要查询的字段
		return ListUtil.listToMap(fileds,routeDao.qryRouteInfo(), filedtypes);
	}
	
	public List<Map<String, Object>> qryDepartTemplate(String templatetypename){
		return ListUtil.listToMap(new Object[]{"id", "name"},
				routeDao.qryDepartTemplate(templatetypename), 
				new Object[]{Long.class, String.class});
	}

	@Override
	public String qryrouteprinttemplatebyid(long scheduleplanid) {
		Scheduleplan sp = (Scheduleplan) routeDao.get(Scheduleplan.class, scheduleplanid);
		return routeDao.qryrouteprinttemplatebyid(sp.getScheduleid());
	}
}
