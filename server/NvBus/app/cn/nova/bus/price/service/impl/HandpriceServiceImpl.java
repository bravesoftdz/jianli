package cn.nova.bus.price.service.impl;

import java.math.BigDecimal;
import java.math.MathContext;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import util.SystemException;
import util.UserTransaction;
import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Routestop;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Schedulestop;
import cn.nova.bus.base.model.Vehiclebrandmodel;
import cn.nova.bus.base.model.Vehicletype;
import cn.nova.bus.base.service.RouteService;
import cn.nova.bus.base.service.impl.RouteServiceImpl;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.dao.HandpriceDao;
import cn.nova.bus.price.dao.TicketpriceformulaDao;
import cn.nova.bus.price.model.Handprice;
import cn.nova.bus.price.model.Handpriceitem;
import cn.nova.bus.price.model.Standardprice;
import cn.nova.bus.price.model.Standardpriceitem;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.price.model.Ticketpriceformula;
import cn.nova.bus.price.model.Ticketpriceformulaitem;
import cn.nova.bus.price.model.Ticketpriceitem;
import cn.nova.bus.price.service.HandpriceService;
import cn.nova.bus.price.service.TicketpriceformulaService;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * @author lck
 * 
 */

public class HandpriceServiceImpl implements HandpriceService {

	
	private HandpriceDao handpriceDao = new HandpriceDao();
	
	@Resource
	private UserTransaction userTransaction = new UserTransaction();
	
	private TicketpriceformulaService ticketpriceformulaService = new TicketpriceformulaServiceImpl();
	
	private TicketpriceformulaDao ticketpriceformulaDao = new TicketpriceformulaDao();

	
	private IDAO<Handprice> dao = new EntityManagerDaoSurport<Handprice>();
	
	private ParameterService parameterService = new ParameterServiceImpl();

	
	private RouteService routeserevie = new RouteServiceImpl();

	@Override
	public List<Map<String, Object>> qryScheduleVehicletype(Long scheduleid,Global global) {
		String vehicletypes = parameterService.findParamValue(ParamterConst.Param_0014, global.getOrganization().getId());
		if (vehicletypes.equals(ParamterConst.COMMON_FLAG.FALG_YES)) {
			return ListUtil.listToMap(new Object[] { Vehicletype.class },
					handpriceDao.qryAllVehicletype(),
					new Object[] { Vehicletype.class });

		} else {
			return ListUtil.listToMap(new Object[] { Vehicletype.class },
					handpriceDao.qryScheduleVehicletype(scheduleid),
					new Object[] { Vehicletype.class });
		}
	}

	@Override
	public List<Map<String, Object>> qryScheduleStop(Long scheduleid) {
		return ListUtil.listToMap(new Object[] { "stationid", "stationname" },
				handpriceDao.qryOrgAllSchedulestop(scheduleid), new Object[] {
						Long.class, String.class });
	}

	@Override
	public List<Map<String, Object>> qryScheduleStop(Long scheduleid,
			boolean isdepart) {
		return ListUtil.listToMap(new Object[] { "stationid", "stationname" },
				handpriceDao.qryOrgSchedulestop(scheduleid, isdepart),
				new Object[] { Long.class, String.class });
	}

	// 查询界面的查询
	@Override
	public List<Map<String, Object>> qryHandPrice(Long scheduleid)
			throws ServiceException {
		return ListUtil
				.listToMap(new Object[] { "id", "scheduleid", "seattype",
						"seats", "fullprice", "halfprice", "studentprice",
						"departstation", "reachstation", "vehicletype",
						"toplimitprice", "lowerlimitprice", "vehicletypeid",
						"brandname", "modelcode", "rationseatnum", "moreprice",
						"departstationid", "reachstationid", "distance" 
						, "discountprice", "roundprice", "connectprice" },
						handpriceDao.qryHandprice2(scheduleid), new Object[] {
								Long.class, Long.class, String.class,
								String.class, BigDecimal.class,
								BigDecimal.class, BigDecimal.class,
								String.class, String.class, String.class,
								BigDecimal.class, BigDecimal.class, Long.class,
								String.class, String.class, Short.class,
								BigDecimal.class, long.class, long.class,
								Integer.class 
						, BigDecimal.class, BigDecimal.class, BigDecimal.class });

	}

	// 编辑界面的查询
	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> qryHandPrice(Handprice handprice)
			throws ServiceException {
		Schedule scheudle = (Schedule) handpriceDao.get(Schedule.class,
				handprice.getScheduleid());
		List<Handprice> hps = handpriceDao.qryHandprice(handprice);
		if (hps == null || hps.size() == 0) {

			List<Standardprice> sps = handpriceDao.qryStandardPrice(
					handprice.getScheduleid(), handprice.getVehicletypeid());
			for (Standardprice ss : sps) {
				List<Standardpriceitem> spsi = ss.getStandardpriceitemlist();
				for (Standardpriceitem sp : spsi) {
					handpriceDao.getEntityManager().remove(sp);
				}
				handpriceDao.getEntityManager().remove(ss);
			}
			handpriceDao.getEntityManager().flush();
			ticketpriceformulaService.genPrice(scheudle.getOrgid(), scheudle
					.getRoute().getId(), scheudle.getId(), handprice
					.getVehicletypeid(), handprice.getCreateby());
			handpriceDao.getEntityManager().flush();

			return ListUtil.listToMap(new Object[] { "id", "scheduleid",
					"departstationid", "reachstationid", "vehicletypeid",
					"vehiclebrandmodelid", "brandname", "seattype",
					"fullprice", "halfprice", "studentprice", "toplimitprice",
					"lowerlimitprice", "createby", "vehicletype",
					"departstation", "reachstation", "moreprice", "distance" 
							, "discountprice", "roundprice", "connectprice" },
					handpriceDao.qryStandardprice(handprice), new Object[] {
							Long.class, Long.class, Long.class, Long.class,
							Long.class, Long.class, String.class, String.class,
							BigDecimal.class, BigDecimal.class,
							BigDecimal.class, BigDecimal.class,
							BigDecimal.class, Long.class, String.class,
							String.class, String.class, BigDecimal.class,
							Integer.class 
							, BigDecimal.class, BigDecimal.class, BigDecimal.class });

		} else {
			Schedule schedule = (Schedule) handpriceDao.get(Schedule.class,
					handprice.getScheduleid());
			List<Handprice> hplist = handpriceDao.qryHandprice(handprice);
			List<Schedulestop> departlist = handpriceDao.qrySchedulestop(
					handprice.getScheduleid(), true);
			List<Schedulestop> reacherlist = handpriceDao.qrySchedulestop(
					handprice.getScheduleid(), false);
			boolean isexist = false;
			long orgid = schedule.getOrgid();
			Date departdate = new Date();
			// 全票票价公式
			Ticketpriceformula fullpriceformula = ticketpriceformulaDao
					.qryFormula(orgid, "Q", departdate);
			if (fullpriceformula == null) {
				throw new ServiceException("0044");
			}
			// 半票票价公式
			Ticketpriceformula halfpriceformula = ticketpriceformulaDao
					.qryFormula(orgid, "B", departdate);
			if (halfpriceformula == null) {
				throw new ServiceException("0045");
			}
			List<Ticketpriceformulaitem> ticketpriceformulaitemlist = new ArrayList<Ticketpriceformulaitem>();
			// 多点配客班次
			if (schedule.getWorktype().equals("2")
					|| schedule.getWorktype().equals("3")) {
				long endstationid=schedule.getRoute().getEndstationid();
				List<Schedulestop> ststops = handpriceDao
						.qryAllSchedulestop(schedule.getId());
				List<Schedulestop> rtstops = handpriceDao
						.qryAllSchedulestop(schedule.getId());
				for (Schedulestop ds : ststops) {
					if (ds.getIsdepart() && endstationid!=ds.getStationid()) {
						Routestop dsstop = handpriceDao.qryRoutestop(schedule
								.getRoute().getId(), ds.getStationid());
						for (Schedulestop rs : rtstops) {
							if (ds.getOrderno() < rs.getOrderno()) {
								isexist = false;
								for (Handprice hp : hplist) {
									if (hp.getDepartstationid() == ds
											.getStationid()
											&& hp.getReachstationid() == rs
													.getStationid()) {
										isexist = true;
									}
								}
								if (!isexist) {
									Handprice obj = new Handprice();
									obj.setLowerlimitprice(new BigDecimal(0));
									obj.setReachstationid(rs.getStationid());
									obj.setScheduleid(handprice.getScheduleid());
									obj.setSeats("0");
									obj.setSeattype(hplist.get(0).getSeattype());
									obj.setUpdateby(handprice.getCreateby());
									obj.setUpdatetime(new Date());
									obj.setVehiclebrandmodel(hplist.get(0)
											.getVehiclebrandmodel());
									obj.setVehicletypeid(hplist.get(0)
											.getVehicletypeid());
									obj.setCreateby(handprice.getCreateby());
									obj.setCreatetime(new Date());
									obj.setDepartstationid(ds.getStationid());
									obj.setMoreprice(new BigDecimal(0));
									Routestop rsstop = handpriceDao
											.qryRoutestop(schedule.getRoute()
													.getId(), rs.getStationid());
									int distance = rsstop.getDistance()
											- dsstop.getDistance();
									ticketpriceformulaitemlist.clear();
									BigDecimal fullprice = ticketpriceformulaService
											.executeFormula(
													orgid,
													handprice
															.getVehicletypeid(),
													schedule.getRoute().getId(),
													schedule.getId(), ds
															.getStationid(), rs
															.getStationid(),
													distance, fullpriceformula
															.getFormula(),
													ticketpriceformulaitemlist);
									obj.setFullprice(fullprice);
									obj.setStudentprice(fullprice);
									obj.setToplimitprice(fullprice);
									obj.setConnectprice(fullprice);
									obj.setRoundprice(fullprice);
									obj.setDiscountprice(fullprice);
									// 保存票价分项
									List<Handpriceitem> curhpilist = new ArrayList<Handpriceitem>();
									// 保存全票票价分项
									curhpilist.addAll(genHandpriceitem2(obj,
											ticketpriceformulaitemlist,
											fullprice, "Q"));
									// 保存学生票票价分项
									curhpilist.addAll(genHandpriceitem2(obj,
											ticketpriceformulaitemlist,
											fullprice, "X"));
									// 保存上限票票价分项
									curhpilist.addAll(genHandpriceitem2(obj,
											ticketpriceformulaitemlist,
											fullprice, "S"));
// 保存优惠票票价分项
									curhpilist
											.addAll(genHandpriceitem2(obj, ticketpriceformulaitemlist, fullprice, "Y"));
									// 保存往返票票价分项
									curhpilist
											.addAll(genHandpriceitem2(obj, ticketpriceformulaitemlist, fullprice, "W"));
									// 保存联程票票价分项
									curhpilist
											.addAll(genHandpriceitem2(obj, ticketpriceformulaitemlist, fullprice, "L"));

									// 保存半票票价分项
									ticketpriceformulaitemlist.clear();
									BigDecimal halfprice = ticketpriceformulaService
											.executeFormula(
													orgid,
													handprice
															.getVehicletypeid(),
													schedule.getRoute().getId(),
													schedule.getId(), ds
															.getStationid(), rs
															.getStationid(),
													distance, halfpriceformula
															.getFormula(),
													ticketpriceformulaitemlist);

									curhpilist.addAll(genHandpriceitem2(obj,
											ticketpriceformulaitemlist,
											halfprice, "B"));

									obj.setHalfprice(fullprice);
									obj.setHandpriceitemlist(curhpilist);
									handpriceDao.getEntityManager().merge(obj);
									handpriceDao.getEntityManager().flush();
								}

							}
						}
					}
				}

			} else {

				for (Schedulestop ds : departlist) {
					Routestop dsstop = handpriceDao.qryRoutestop(schedule
							.getRoute().getId(), ds.getStationid());
					for (Schedulestop rs : reacherlist) {
						isexist = false;
						for (Handprice hp : hplist) {
							if (hp.getDepartstationid() == ds.getStationid()
									&& hp.getReachstationid() == rs
											.getStationid()) {
								isexist = true;
							}
						}
						if (!isexist) {
							Handprice obj = new Handprice();
							obj.setLowerlimitprice(new BigDecimal(0));
							obj.setReachstationid(rs.getStationid());
							obj.setScheduleid(handprice.getScheduleid());
							obj.setSeats("0");
							obj.setSeattype(hplist.get(0).getSeattype());
							obj.setUpdateby(handprice.getCreateby());
							obj.setUpdatetime(new Date());
							obj.setVehiclebrandmodel(hplist.get(0)
									.getVehiclebrandmodel());
							obj.setVehicletypeid(hplist.get(0)
									.getVehicletypeid());
							obj.setCreateby(handprice.getCreateby());
							obj.setCreatetime(new Date());
							obj.setDepartstationid(ds.getStationid());
							obj.setMoreprice(new BigDecimal(0));
							Routestop rsstop = handpriceDao.qryRoutestop(
									schedule.getRoute().getId(),
									rs.getStationid());
							int distance = rsstop.getDistance()
									- dsstop.getDistance();
							ticketpriceformulaitemlist.clear();
							BigDecimal fullprice = ticketpriceformulaService
									.executeFormula(orgid,
											handprice.getVehicletypeid(),
											schedule.getRoute().getId(),
											schedule.getId(),
											ds.getStationid(),
											rs.getStationid(), distance,
											fullpriceformula.getFormula(),
											ticketpriceformulaitemlist);
							obj.setFullprice(fullprice);
							obj.setStudentprice(fullprice);
							obj.setToplimitprice(fullprice);
							obj.setConnectprice(fullprice);
							obj.setRoundprice(fullprice);
							obj.setDiscountprice(fullprice);
							// 保存票价分项
							List<Handpriceitem> curhpilist = new ArrayList<Handpriceitem>();
							// 保存全票票价分项
							curhpilist
									.addAll(genHandpriceitem2(obj,
											ticketpriceformulaitemlist,
											fullprice, "Q"));
							// 保存学生票票价分项
							curhpilist
									.addAll(genHandpriceitem2(obj,
											ticketpriceformulaitemlist,
											fullprice, "X"));
							// 保存上限票票价分项
							curhpilist
									.addAll(genHandpriceitem2(obj,
											ticketpriceformulaitemlist,
											fullprice, "S"));

							// 保存优惠票票价分项
							curhpilist.addAll(genHandpriceitem2(obj, ticketpriceformulaitemlist, fullprice, "Y"));
							// 保存往返票票价分项
							curhpilist.addAll(genHandpriceitem2(obj, ticketpriceformulaitemlist, fullprice, "W"));
							// 保存联程票票价分项
							curhpilist.addAll(genHandpriceitem2(obj, ticketpriceformulaitemlist, fullprice, "L"));
							// 保存半票票价分项
							ticketpriceformulaitemlist.clear();
							BigDecimal halfprice = ticketpriceformulaService
									.executeFormula(orgid,
											handprice.getVehicletypeid(),
											schedule.getRoute().getId(),
											schedule.getId(),
											ds.getStationid(),
											rs.getStationid(), distance,
											halfpriceformula.getFormula(),
											ticketpriceformulaitemlist);

							curhpilist
									.addAll(genHandpriceitem2(obj,
											ticketpriceformulaitemlist,
											halfprice, "B"));

							obj.setHalfprice(fullprice);
							obj.setHandpriceitemlist(curhpilist);
							handpriceDao.getEntityManager().merge(obj);
							handpriceDao.getEntityManager().flush();
						}
					}
				}
			}
			return ListUtil.listToMap(new Object[] { "id", "scheduleid",
					"departstationid", "reachstationid", "vehicletypeid",
					"vehiclebrandmodelid", "brandname", "seattype",
					"fullprice", "halfprice", "studentprice", "toplimitprice",
					"lowerlimitprice", "createby", "vehicletype",
					"departstation", "reachstation", "moreprice", "distance" 
							, "discountprice", "roundprice", "connectprice" },
					handpriceDao.qryHandprice1(handprice), new Object[] {
							Long.class, Long.class, Long.class, Long.class,
							Long.class, Long.class, String.class, String.class,
							BigDecimal.class, BigDecimal.class,
							BigDecimal.class, BigDecimal.class,
							BigDecimal.class, Long.class, String.class,
							String.class, String.class, BigDecimal.class,
							Integer.class 
							, BigDecimal.class, BigDecimal.class, BigDecimal.class });
		}
	}

	/**
	 * 保存或修改 班次 的不同停靠点 的 票价，里程和票价差
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> save(List<Handprice> handpricelist,
			boolean iscopyvehicletype, Long userid, Handprice pHandprice ) throws ServiceException {
		List<Object> saveobj = new ArrayList<Object>();
		long curvehicletypeid = handpricelist.get(0).getVehicletypeid();
		long curscheduleid = handpricelist.get(0).getScheduleid();
		Schedule schedule = (Schedule) handpriceDao.get(Schedule.class,
				curscheduleid);
		Route route = (Route) handpriceDao.get(Route.class, schedule.getRoute()
				.getId());
		for (Handprice handprice : handpricelist) {
			if (handprice.getId() == 0) {
				// 进行保存
				long _vehiclebrandmodelid = 0;
				if (pHandprice != null && pHandprice.getVehiclebrandmodelid() != null) {
					_vehiclebrandmodelid = pHandprice.getVehiclebrandmodelid();
					handprice.setVehiclebrandmodelid(_vehiclebrandmodelid);	 //设置品牌型号id
				}
				handprice.setCreateby(userid);
				handprice.setCreatetime(new Date());
				handprice.setUpdateby(userid);
				handprice.setUpdatetime(new Date());
				if (handprice.getVehiclebrandmodelid() == null) {
					handprice.setSeats("0");
				} else {
					String seats = handpriceDao.qryScheduleSeats(
							handprice.getVehiclebrandmodelid(),
							handprice.getSeattype());
					handprice.setSeats(seats);
					Vehiclebrandmodel vehiclebrandmodel = new Vehiclebrandmodel();
					vehiclebrandmodel.setId(handprice.getVehiclebrandmodelid());
					handprice.setVehiclebrandmodel(vehiclebrandmodel);
				}
				if (handprice.getMoreprice() == null) {
					handprice.setMoreprice(new BigDecimal(0));
				}
				handprice.setHandpriceitemlist(addHandpriceitem(handprice));
				Routestop rs = handpriceDao.qryRoutestop(schedule.getRoute()
						.getId(), handprice.getReachstationid());
				if (handprice.getDepartstationid() == route.getStartstationid()) {
					if (handprice.getDistance() != 0) {
						rs.setDistance(handprice.getDistance());
						rs.setBalancedistance(handprice.getDistance());
						rs.setUpdateby(userid);
						rs.setUpdatetime(new Date());
						handpriceDao.merge(rs);
						if (handprice.getReachstationid() == route
								.getEndstationid()) {
							route.setDistance(handprice.getDistance());
							route.setUpdatetime(new Date());
							route.setUpdateby(userid);
							handpriceDao.merge(route);
						}
					}
				}
				// 判断线路停靠点的里程设置是否正确:如果参数有开启，（将修改后的数据进行判断）
				// 且里程设置不正确则抛出：停靠点的里程或结算里程设置不允许大于后站里程且不能小于前站里程
				routeserevie.checkRoutestopDistance(rs);//李电志 2016年1月6日 16:41:12 add  
				//---2016-03-28,为满足0012参数，routeserevie.checkRoutestopDistance(rs);注释掉
				saveobj.add(dao.merge(handprice));
			} else {
				// 进行修改操作
				Handprice entity = dao.get(Handprice.class, handprice.getId());
				List<Handpriceitem> hpilist = entity.getHandpriceitemlist();
				if (hpilist == null || hpilist.size() == 0) {
					entity.setHandpriceitemlist(addHandpriceitem(entity));
					dao.merge(entity);
					dao.getEntityManager().flush();
					entity = dao.get(Handprice.class, handprice.getId());
					hpilist = entity.getHandpriceitemlist();
				}
				if (handprice.getSeattype() != null) {
					entity.setSeattype(handprice.getSeattype());
				}
				if (handprice.getFullprice() != null) {
					entity.setFullprice(handprice.getFullprice());
					BigDecimal notbaseprice = new BigDecimal(0);
					for (Handpriceitem sp : hpilist) {
						if (sp.getTickettype().equals("Q") && !sp.getIsautoadjust()) {
							notbaseprice = notbaseprice.add(sp.getPrice());
						}
					}
					for (Handpriceitem sp : hpilist) {
						if (sp.getTickettype().equals("Q") && sp.getIsautoadjust()) {
							sp.setPrice(handprice.getFullprice().subtract(notbaseprice));
							sp.setUpdateby(handprice.getUpdateby());
							sp.setUpdatetime(new Date());
						}
					}
				}
				// 优惠===============================================
				if (handprice.getDiscountprice() != null) {
					entity.setDiscountprice(handprice.getDiscountprice());
					BigDecimal notbaseprice = new BigDecimal(0);
					for (Handpriceitem sp : hpilist) {
						if (sp.getTickettype().equals("Y") && !sp.getIsautoadjust()) {
							notbaseprice = notbaseprice.add(sp.getPrice());
						}
					}
					for (Handpriceitem sp : hpilist) {
						if (sp.getTickettype().equals("Y") && sp.getIsautoadjust()) {
							sp.setPrice(handprice.getDiscountprice().subtract(notbaseprice));
							sp.setUpdateby(handprice.getUpdateby());
							sp.setUpdatetime(new Date());
						}
					}
				}
				// 往返===============================================
				if (handprice.getRoundprice() != null) {
					entity.setRoundprice(handprice.getRoundprice());
					BigDecimal notbaseprice = new BigDecimal(0);
					for (Handpriceitem sp : hpilist) {
						if (sp.getTickettype().equals("W") && !sp.getIsautoadjust()) {
							notbaseprice = notbaseprice.add(sp.getPrice());
						}
					}
					for (Handpriceitem sp : hpilist) {
						if (sp.getTickettype().equals("W") && sp.getIsautoadjust()) {
							sp.setPrice(handprice.getRoundprice().subtract(notbaseprice));
							sp.setUpdateby(handprice.getUpdateby());
							sp.setUpdatetime(new Date());
						}
					}
				}
				// 联程===============================================
				if (handprice.getConnectprice() != null) {
					entity.setConnectprice(handprice.getConnectprice());
					BigDecimal notbaseprice = new BigDecimal(0);
					for (Handpriceitem sp : hpilist) {
						if (sp.getTickettype().equals("L") && !sp.getIsautoadjust()) {
							notbaseprice = notbaseprice.add(sp.getPrice());
						}
					}
					for (Handpriceitem sp : hpilist) {
						if (sp.getTickettype().equals("L") && sp.getIsautoadjust()) {
							sp.setPrice(handprice.getConnectprice().subtract(notbaseprice));
							sp.setUpdateby(handprice.getUpdateby());
							sp.setUpdatetime(new Date());
						}
					}
				}
				// 半价===============================================
				if (handprice.getHalfprice() != null) {
					entity.setHalfprice(handprice.getHalfprice());
					BigDecimal notbaseprice = new BigDecimal(0);
					for (Handpriceitem sp : hpilist) {
						if (sp.getTickettype().equals("B") && !sp.getIsautoadjust()) {
							notbaseprice = notbaseprice.add(sp.getPrice());
						}
					}
					for (Handpriceitem sp : hpilist) {
						if (sp.getTickettype().equals("B") && sp.getIsautoadjust()) {
							sp.setPrice(handprice.getHalfprice().subtract(
									notbaseprice));
							sp.setUpdateby(handprice.getUpdateby());
							sp.setUpdatetime(new Date());
						}
					}
				}
				if (handprice.getStudentprice() != null) {
					entity.setStudentprice(handprice.getStudentprice());
					BigDecimal notbaseprice = new BigDecimal(0);
					for (Handpriceitem sp : hpilist) {
						if (sp.getTickettype().equals("X") && !sp.getIsautoadjust()) {
							notbaseprice = notbaseprice.add(sp.getPrice());
						}
					}
					for (Handpriceitem sp : hpilist) {
						if (sp.getTickettype().equals("X") && sp.getIsautoadjust()) {
							sp.setPrice(handprice.getStudentprice().subtract(notbaseprice));
							sp.setUpdateby(handprice.getUpdateby());
							sp.setUpdatetime(new Date());
						}
					}
				}
				if (handprice.getToplimitprice() != null) {
					entity.setToplimitprice(handprice.getToplimitprice());
					BigDecimal notbaseprice = new BigDecimal(0);
					for (Handpriceitem sp : hpilist) {
						if (sp.getTickettype().equals("S") && !sp.getIsautoadjust()) {
							notbaseprice = notbaseprice.add(sp.getPrice());
						}
					}
					for (Handpriceitem sp : hpilist) {
						if (sp.getTickettype().equals("S") && sp.getIsautoadjust()) {
							sp.setPrice(handprice.getToplimitprice().subtract(notbaseprice));
							sp.setUpdateby(handprice.getUpdateby());
							sp.setUpdatetime(new Date());
						}
					}
				}
				if (handprice.getSeats() != null) {
					entity.setSeats(handprice.getSeats());
				}
				if (handprice.getLowerlimitprice() != null) {
					entity.setLowerlimitprice(handprice.getLowerlimitprice());
				}
				if (handprice.getMoreprice() != null) {
					if (ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService
							.findParamValue("5001", null))) {
						entity.setMoreprice(handprice.getMoreprice());
					} else {
						entity.setMoreprice(new BigDecimal(0));
					}
				}
				entity.setUpdateby(userid);
				entity.setUpdatetime(new Date());
				Routestop rs = handpriceDao.qryRoutestop(schedule.getRoute()
						.getId(), entity.getReachstationid());
				if (handprice.getDepartstationid() == route.getStartstationid()) {
					if (handprice.getDistance() != 0) {
						rs.setDistance(handprice.getDistance());
						rs.setBalancedistance(handprice.getDistance());
						rs.setUpdateby(userid);
						rs.setUpdatetime(new Date());
						handpriceDao.merge(rs);
						if (handprice.getReachstationid() == route
								.getEndstationid()) {
							route.setDistance(handprice.getDistance());
							route.setUpdatetime(new Date());
							route.setUpdateby(userid);
							handpriceDao.merge(route);
						}
					}
				}
				// 判断线路停靠点的里程设置是否正确:如果参数有开启，（将修改后的数据进行判断）
				// 且里程设置不正确则抛出：停靠点的里程或结算里程设置不允许大于后站里程且不能小于前站里程
			//	routeserevie.checkRoutestopDistance(rs);
				saveobj.add(dao.merge(entity));
			}
		}
		if (iscopyvehicletype) {
			List<Handprice> hplist = handpriceDao.qryHandprice(curscheduleid,
					curvehicletypeid);
			for (Handprice hp : hplist) {
				handpriceDao.getEntityManager().remove(hp);
			}
			handpriceDao.getEntityManager().flush();
			List<Vehicletype> vtlist = handpriceDao
					.qryCycleschemesVehicletype(curscheduleid);
			for (Vehicletype vt : vtlist) {
				if (vt.getId() != curvehicletypeid) {
					// 保存硬调票价
					for (Handprice hp : handpricelist) {
						if (hp.getId() > 0) {
							hp = dao.get(Handprice.class, hp.getId());
						}
						Handprice entity = new Handprice();
						entity.setVehiclebrandmodelid(hp
								.getVehiclebrandmodelid());
						entity.setCreateby(hp.getCreateby());
						entity.setCreatetime(new Date());
						entity.setDepartstationid(hp.getDepartstationid());
						entity.setFullprice(hp.getFullprice());
						entity.setHalfprice(hp.getHalfprice());
						entity.setReachstationid(hp.getReachstationid());
						entity.setScheduleid(hp.getScheduleid());
						entity.setUpdateby(hp.getCreateby());
						entity.setUpdatetime(new Date());
						entity.setSeattype(hp.getSeattype());
						entity.setSeats(hp.getSeats());
						entity.setStudentprice(hp.getStudentprice());
						entity.setVehicletypeid(vt.getId());
						entity.setLowerlimitprice(hp.getLowerlimitprice());
						entity.setToplimitprice(hp.getToplimitprice());
						entity.setMoreprice(hp.getMoreprice());
						entity.setDiscountprice(hp.getDiscountprice());
						entity.setRoundprice(hp.getRoundprice());
						entity.setConnectprice(hp.getConnectprice());
						List<Handpriceitem> curhpilist = new ArrayList<Handpriceitem>();
						List<Handpriceitem> hpilist = hp.getHandpriceitemlist();
						// 保存票价分项
						for (Handpriceitem hpi : hpilist) {
							Handpriceitem curhi = new Handpriceitem();
							curhi.setCreateby(userid);
							curhi.setCreatetime(new Date());
							curhi.setHandprice(entity);
							curhi.setIsautoadjust(hpi.getIsautoadjust());
							curhi.setPrice(hpi.getPrice());
							curhi.setTicketpriceformulaitemid(hpi
									.getTicketpriceformulaitemid());
							curhi.setTickettype(hpi.getTickettype());
							curhi.setUpdateby(userid);
							curhi.setUpdatetime(new Date());
							curhpilist.add(curhi);
						}
						entity.setHandpriceitemlist(curhpilist);
						Routestop rs = handpriceDao
								.qryRoutestop(schedule.getRoute().getId(),
										entity.getReachstationid());
						if (hp.getDepartstationid() == route
								.getStartstationid()) {
							if (hp.getDistance() != 0) {
								rs.setDistance(hp.getDistance());
								rs.setBalancedistance(hp.getDistance());
								rs.setUpdateby(userid);
								rs.setUpdatetime(new Date());
								handpriceDao.merge(rs);
								if (hp.getReachstationid() == route
										.getEndstationid()) {
									route.setDistance(hp.getDistance());
									route.setUpdatetime(new Date());
									route.setUpdateby(userid);
									handpriceDao.merge(route);
								}
							}
						}

						handpriceDao.getEntityManager().merge(entity);
					}
				}
			}

		}
		return ListUtil.listToMap(new Object[] { Handprice.class }, saveobj,
				new Object[] { Handprice.class });
	}

	private List<Handpriceitem> addHandpriceitem(Handprice handprice) {
		// 保存票价分项
		List<Handpriceitem> hpilist = new ArrayList<Handpriceitem>();
		// 保存全票票价分项
		List<Standardpriceitem> spilist = handpriceDao.qryStandardPriceitem(handprice.getScheduleid(),
				handprice.getVehicletypeid(), "Q", handprice.getDepartstationid(), handprice.getReachstationid());
		hpilist.addAll(genHandpriceitem(handprice, spilist, handprice.getFullprice()));
		// 保存优惠票价分项============================================================================
		spilist.clear();
		spilist = handpriceDao.qryStandardPriceitem(handprice.getScheduleid(), handprice.getVehicletypeid(), "Y",
				handprice.getDepartstationid(), handprice.getReachstationid());
		hpilist.addAll(genHandpriceitem(handprice, spilist, handprice.getDiscountprice()));

		// 保存往返票价分项============================================================================
		spilist.clear();
		spilist = handpriceDao.qryStandardPriceitem(handprice.getScheduleid(), handprice.getVehicletypeid(), "W",
				handprice.getDepartstationid(), handprice.getReachstationid());
		hpilist.addAll(genHandpriceitem(handprice, spilist,	handprice.getFullprice()));
		//hpilist.addAll(genHandpriceitem(handprice, spilist, handprice.getRoundprice()));
		// 保存联程票价分项============================================================================
		spilist.clear();
		spilist = handpriceDao.qryStandardPriceitem(handprice.getScheduleid(), handprice.getVehicletypeid(), "L",
				handprice.getDepartstationid(), handprice.getReachstationid());
		hpilist.addAll(genHandpriceitem(handprice, spilist, handprice.getConnectprice()));
		// 保存学生票票价分项
		spilist.clear();
		spilist = handpriceDao.qryStandardPriceitem(handprice.getScheduleid(),
				handprice.getVehicletypeid(), "X",
				handprice.getDepartstationid(), handprice.getReachstationid());
		hpilist.addAll(genHandpriceitem(handprice, spilist,
				handprice.getStudentprice()));
		// 保存半票票价分项
		spilist.clear();
		spilist = handpriceDao.qryStandardPriceitem(handprice.getScheduleid(),
				handprice.getVehicletypeid(), "B",
				handprice.getDepartstationid(), handprice.getReachstationid());
		hpilist.addAll(genHandpriceitem(handprice, spilist,
				handprice.getHalfprice()));
		// 保存上限票票价分项
		spilist.clear();
		spilist = handpriceDao.qryStandardPriceitem(handprice.getScheduleid(),
				handprice.getVehicletypeid(), "S",
				handprice.getDepartstationid(), handprice.getReachstationid());
		hpilist.addAll(genHandpriceitem(handprice, spilist,
				handprice.getToplimitprice()));

		return hpilist;
	}

	// 直接生成票价分项
	private List<Handpriceitem> genHandpriceitem2(Handprice handprice,
			List<Ticketpriceformulaitem> spilist, BigDecimal price,
			String ticketype) {
		List<Handpriceitem> hpilist = new ArrayList<Handpriceitem>();
		BigDecimal notbaseprice = new BigDecimal(0);
		for (Ticketpriceformulaitem sp : spilist) {
			if (!sp.getIsautoadjust()) {
				Handpriceitem hpi = new Handpriceitem();
				hpi.setCreateby(handprice.getCreateby());
				hpi.setCreatetime(new Date());
				hpi.setIsautoadjust(sp.getIsautoadjust());
				hpi.setPrice(sp.getValue());
				notbaseprice = notbaseprice.add(sp.getValue());
				hpi.setTicketpriceformulaitemid(sp.getId());
				hpi.setTickettype(ticketype);
				hpi.setUpdateby(handprice.getCreateby());
				hpi.setUpdatetime(new Date());
				hpi.setHandprice(handprice);
				hpilist.add(hpi);
			}
		}
		for (Ticketpriceformulaitem sp : spilist) {
			if (sp.getIsautoadjust()) {
				Handpriceitem hpi = new Handpriceitem();
				hpi.setCreateby(handprice.getCreateby());
				hpi.setCreatetime(new Date());
				hpi.setIsautoadjust(sp.getIsautoadjust());
				hpi.setPrice(price.subtract(notbaseprice));
				hpi.setTicketpriceformulaitemid(sp.getId());
				hpi.setTickettype(ticketype);
				hpi.setUpdateby(handprice.getCreateby());
				hpi.setUpdatetime(new Date());
				hpi.setHandprice(handprice);
				hpilist.add(hpi);
			}
		}
		return hpilist;
	}

	// 根据公式票价生成票价分项
	private List<Handpriceitem> genHandpriceitem(Handprice handprice,
			List<Standardpriceitem> spilist, BigDecimal price) {
		List<Handpriceitem> hpilist = new ArrayList<Handpriceitem>();
		BigDecimal notbaseprice = new BigDecimal(0);
		for (Standardpriceitem sp : spilist) {
			if (!sp.getIsautoadjust()) {
				Handpriceitem hpi = new Handpriceitem();
				hpi.setCreateby(handprice.getCreateby());
				hpi.setCreatetime(new Date());
				hpi.setIsautoadjust(sp.getIsautoadjust());
				hpi.setPrice(sp.getPrice());
				notbaseprice = notbaseprice.add(sp.getPrice());
				hpi.setTicketpriceformulaitemid(sp
						.getTicketpriceformulaitemid());
				hpi.setTickettype(sp.getTickettype());
				hpi.setUpdateby(handprice.getCreateby());
				hpi.setUpdatetime(new Date());
				hpi.setHandprice(handprice);
				hpilist.add(hpi);
			}
		}
		for (Standardpriceitem sp : spilist) {
			if (sp.getIsautoadjust()) {
				Handpriceitem hpi = new Handpriceitem();
				hpi.setCreateby(handprice.getCreateby());
				hpi.setCreatetime(new Date());
				hpi.setIsautoadjust(sp.getIsautoadjust());
				hpi.setPrice(price.subtract(notbaseprice));
				hpi.setTicketpriceformulaitemid(sp
						.getTicketpriceformulaitemid());
				hpi.setTickettype(sp.getTickettype());
				hpi.setUpdateby(handprice.getCreateby());
				hpi.setUpdatetime(new Date());
				hpi.setHandprice(handprice);
				hpilist.add(hpi);
			}
		}
		return hpilist;
	}

	@Override
	public String qryScheduleSeats(Long vehiclebrandmodelid, String seattype) {
		return handpriceDao.qryScheduleSeats(vehiclebrandmodelid, seattype);
	}

	@Override
	public boolean delHandPrice(List<PropertyFilter> propertyFilterList)
			throws ServiceException {
		boolean isdelHandprice = handpriceDao
				.delHandPriceitem(propertyFilterList);// 删除硬调票价子表
		if (isdelHandprice) {
			return handpriceDao.delHandPrice(propertyFilterList);// 删除硬调票价表
		}
		return false;
	}

	@Override
	public boolean adjustHandprice(String adjusttype) throws ServiceException {
		return false;
	}

	// scheduleids 要复制的目的班次
	@Override
	public boolean copyHandprice(long scheduleid, String vehicletypeids,
			String stationids, String scheduleids, long createby)
			throws ServiceException {
		List<Handprice> hps = handpriceDao.qryHandprice(scheduleid,
				vehicletypeids, stationids);
		String[] schedulelist = scheduleids.split(",");
		for (int i = 0; i < schedulelist.length; i++) {
			long curscheduleid = new Long(schedulelist[i]);
			// 删除原来票价,同时删除了票价分项
			List<Handprice> cursds = handpriceDao.qryHandprice(curscheduleid,
					vehicletypeids, stationids);
			for (Handprice sd : cursds) {
				handpriceDao.getEntityManager().remove(sd);
			}
			handpriceDao.getEntityManager().flush();
			// 复制票价
			for (Handprice hp : hps) {
				Handprice curhp = new Handprice();
				curhp.setCreateby(createby);
				curhp.setCreatetime(new Date());
				curhp.setDepartstationid(hp.getDepartstationid());
				curhp.setFullprice(hp.getFullprice());
				curhp.setHalfprice(hp.getHalfprice());
				curhp.setLowerlimitprice(hp.getLowerlimitprice());
				curhp.setReachstationid(hp.getReachstationid());
				curhp.setScheduleid(curscheduleid);
				curhp.setSeats(hp.getSeats());
				curhp.setSeattype(hp.getSeattype());
				curhp.setStudentprice(hp.getStudentprice());
				curhp.setToplimitprice(hp.getToplimitprice());
				curhp.setUpdateby(createby);
				curhp.setUpdatetime(new Date());
				curhp.setVehiclebrandmodel(hp.getVehiclebrandmodel());
				curhp.setVehicletypeid(hp.getVehicletypeid());
				curhp.setMoreprice(hp.getMoreprice());
				curhp.setDiscountprice(hp.getDiscountprice());
				curhp.setRoundprice(hp.getRoundprice());
				curhp.setConnectprice(hp.getConnectprice());
				List<Handpriceitem> curhpilist = new ArrayList<Handpriceitem>();
				List<Handpriceitem> hpilist = hp.getHandpriceitemlist();
				// 复制票价分项
				for (Handpriceitem hpi : hpilist) {
					Handpriceitem curhi = new Handpriceitem();
					curhi.setCreateby(createby);
					curhi.setCreatetime(new Date());
					curhi.setHandprice(curhp);
					curhi.setIsautoadjust(hpi.getIsautoadjust());
					curhi.setPrice(hpi.getPrice());
					curhi.setTicketpriceformulaitemid(hpi
							.getTicketpriceformulaitemid());
					curhi.setTickettype(hpi.getTickettype());
					curhi.setUpdateby(createby);
					curhi.setUpdatetime(new Date());
					curhpilist.add(curhi);
				}
				curhp.setHandpriceitemlist(curhpilist);
				handpriceDao.getEntityManager().merge(curhp);
			}
		}

		return true;
	}

	// 查询同线路的所有班次
	@Override
	public List<Map<String, Object>> qrySchedules(long routeid, long scheduleid) {
		return ListUtil.listToMap(new Object[] { "isselect", "id", "code",
				"starttime" }, handpriceDao.qrySchedules(routeid, scheduleid),
				new Object[] { boolean.class, Long.class, String.class,
						String.class });
	}

	@Override
	public List<Map<String, Object>> qrySchedulevehicletype(long scheduleid) {
		return ListUtil.listToMap(new Object[] { "isselect", "id", "name",
				"rationseatnum" },
				handpriceDao.qrySchedulevehicletype(scheduleid), new Object[] {
						boolean.class, Long.class, String.class, Short.class });
	}

	@Override
	public List<Map<String, Object>> qrySchedulestation(long scheduleid) {
		return ListUtil.listToMap(new Object[] { "isselect", "id", "name",
				"helpcode" }, handpriceDao.qrySchedulestation(scheduleid),
				new Object[] { boolean.class, Long.class, String.class,
						String.class });
	}

	/*
	 * qryHandpriceitem方法：<br/> <br/>
	 * 
	 * @param handpriceid
	 * 
	 * @param tickettype
	 * 
	 * @return
	 * 
	 * @see cn.nova.bus.price.service.HandpriceService#qryHandpriceitem(long, char)
	 * 
	 * @exception
	 */
	@Override
	public List<Map<String, Object>> qryHandpriceitem(long handpriceid,
			String tickettype) {
		return ListUtil.listToMap(new Object[] { "code", "name", "price", "id",
				"tickettype", "isautoadjust", "handpriceid",
				"ticketpriceformulaitemid" },
				handpriceDao.qryHandpriceitemitem(handpriceid, tickettype),
				new Object[] { String.class, String.class, BigDecimal.class,
						long.class, String.class, boolean.class, long.class,
						long.class });
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> saveHandpriceitem(
			List<Handpriceitem> handpriceitemlist, long userid,
			boolean iscopyothersch) throws ServiceException {
		long handpriceid = 0;
		try {
			if (handpriceitemlist != null && handpriceitemlist.size() > 0) {
				handpriceid = handpriceitemlist.get(0).getHandpriceid();
				Handprice handprice = (Handprice) handpriceDao.get(
						Handprice.class, handpriceid);
				userTransaction.begin();
				if (iscopyothersch) {
					Schedule schedule = (Schedule) handpriceDao.get(
							Schedule.class, handprice.getScheduleid());
					List<Handprice> hplist = handpriceDao.qryHandprice(schedule
							.getRoute().getId(), handprice.getVehicletypeid(),
							handprice.getDepartstationid(), handprice
									.getReachstationid());

					for (Handprice hp : hplist) {
						// 同时保存全票、半票、学生票、上限票价的票价分项值
						saveHandpriceItem(hp, handpriceitemlist, "Q", userid);
						saveHandpriceItem(hp, handpriceitemlist, "B", userid);
						saveHandpriceItem(hp, handpriceitemlist, "X", userid);
						saveHandpriceItem(hp, handpriceitemlist, "S", userid);
						saveHandpriceItem(hp, handpriceitemlist, "W", userid);
						saveHandpriceItem(hp, handpriceitemlist, "Y", userid);
						saveHandpriceItem(hp, handpriceitemlist, "L", userid);
					}
				} else {
					// 同时保存全票、半票、学生票、上限票价的票价分项值
					saveHandpriceItem(handprice, handpriceitemlist, "Q", userid);
					saveHandpriceItem(handprice, handpriceitemlist, "B", userid);
					saveHandpriceItem(handprice, handpriceitemlist, "X", userid);
					saveHandpriceItem(handprice, handpriceitemlist, "S", userid);
					saveHandpriceItem(handprice, handpriceitemlist, "W", userid);
					saveHandpriceItem(handprice, handpriceitemlist, "Y", userid);
					saveHandpriceItem(handprice, handpriceitemlist, "L", userid);
				}
				userTransaction.commit();
			}
		} catch (ServiceException e) {
			throw new ServiceException("0467");		
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
		}
		return ListUtil.listToMap(new Object[] { Handprice.class },
				handpriceDao.qryHandprice(handpriceid),
				new Object[] { Handprice.class });
	}

	private BigDecimal getPrice(long ticketpriceformulaitemid,
			List<Handpriceitem> handpriceitemlist) {
		for (Handpriceitem obj : handpriceitemlist) {
			if (ticketpriceformulaitemid == obj.getTicketpriceformulaitemid()) {
				return obj.getPrice();
			}
		}
		return new BigDecimal(0);
	}

	@SuppressWarnings("unchecked")
	private void saveHandpriceItem(Handprice handprice,
			List<Handpriceitem> handpriceitemlist, String tickettype, long userid) throws ServiceException{
		List<Handpriceitem> hpilist = handprice.getHandpriceitemlist();
		long handpriceitemid = 0;
		BigDecimal unisfreight = new BigDecimal(0);
		for (Handpriceitem hi : hpilist) {
			if (hi.getTickettype().equals(tickettype)) {
				if (hi.getIsautoadjust()) {
					handpriceitemid = hi.getId();
				} else {
					hi.setPrice(getPrice(hi.getTicketpriceformulaitemid(),
							handpriceitemlist));
					unisfreight = unisfreight.add(hi.getPrice());
					hi.setUpdateby(userid);
					hi.setUpdatetime(new Date());
					handpriceDao.getEntityManager().merge(hi);
				}
			}
		}
		Handpriceitem basefreight = (Handpriceitem) handpriceDao.get(Handpriceitem.class, handpriceitemid);
		/*
		if(null == basefreight){
			play.Logger.info("HandpriceServiceImpl.saveHandpriceItem-basefreight is NULL !");
			return;
		}
		*/
		Schedule schedule = (Schedule) handpriceDao.get(Schedule.class, handprice.getScheduleid());
		try{
			if (tickettype.equals("Q")) {
				BigDecimal baseprice = handprice.getFullprice().subtract(unisfreight);
				if(baseprice.intValue()<0){
					//基本运价不允许为负数！
					  try {
						userTransaction.rollback();
					} catch (SystemException e) {
						// TODO Auto-generated catch block
						play.Logger.error(e.getMessage(), e);
					}
					throw new ServiceException("0467");								
				}else{
					basefreight.setPrice(baseprice);
				}
			} else if (tickettype.equals("B")) {
					basefreight.setPrice(handprice.getHalfprice().subtract(unisfreight));
			} else if (tickettype.equals("X")) {
				basefreight.setPrice(handprice.getStudentprice().subtract(unisfreight));
			} else if (tickettype.equals("S")) {
				basefreight.setPrice(handprice.getToplimitprice().subtract(unisfreight));
			} else if (tickettype.equals("W")) {
				basefreight.setPrice(handprice.getRoundprice().subtract(unisfreight));
			} else if (tickettype.equals("Y")) {
				basefreight.setPrice(handprice.getDiscountprice().subtract(unisfreight));
			} else if (tickettype.equals("L")) {
				basefreight.setPrice(handprice.getConnectprice().subtract(unisfreight));
			}
		}catch (Exception e) {
			throw new BusinessException("班次号:"+schedule.getCode()+"票种:"+tickettype+" 的硬调票价组成项未设置请检查!");
		}
		basefreight.setUpdateby(userid);
		basefreight.setUpdatetime(new Date());
		handpriceDao.getEntityManager().merge(basefreight);

	}

	// 复制始发站票价到配客站点上
	@Override
	public boolean copyHandpricetoStatioin(long scheduleid, long updateby)
			throws ServiceException {
		List<Handprice> starthps = handpriceDao.qryStartHandprice(scheduleid);

		List<Handprice> reachhps = handpriceDao.qryReachHandprice(scheduleid);
		if (reachhps != null && reachhps.size() > 0) {
			for (Handprice rhp : reachhps) {
				handpriceDao.getEntityManager().remove(rhp);
			}
			handpriceDao.getEntityManager().flush();
		}
		List<Schedulestop> ssts = handpriceDao.qryReachSchedulestop(scheduleid);
		for (Schedulestop sst : ssts) {
			for (Handprice shp : starthps) {
				Handprice rhp = new Handprice();
				rhp.setCreateby(updateby);
				rhp.setCreatetime(new Date());
				rhp.setDepartstationid(sst.getStationid());
				rhp.setFullprice(shp.getFullprice());
				rhp.setHalfprice(shp.getHalfprice());
				rhp.setStudentprice(shp.getStudentprice());
				rhp.setToplimitprice(shp.getToplimitprice());
				rhp.setLowerlimitprice(shp.getLowerlimitprice());
				rhp.setMoreprice(shp.getMoreprice());
				rhp.setReachstationid(shp.getReachstationid());
				rhp.setScheduleid(shp.getScheduleid());
				rhp.setSeats(shp.getSeats());
				rhp.setSeattype(shp.getSeattype());
				rhp.setVehiclebrandmodel(shp.getVehiclebrandmodel());
				rhp.setVehicletypeid(shp.getVehicletypeid());
				rhp.setUpdateby(updateby);
				rhp.setUpdatetime(new Date());
				rhp.setDiscountprice(shp.getDiscountprice());
				rhp.setRoundprice(shp.getRoundprice());
				rhp.setConnectprice(shp.getConnectprice());
				List<Handpriceitem> shpis = shp.getHandpriceitemlist();
				List<Handpriceitem> rshps = new ArrayList<Handpriceitem>();
				for (Handpriceitem hpi : shpis) {
					Handpriceitem obj = new Handpriceitem();
					obj.setCode(hpi.getCode());
					obj.setCreateby(updateby);
					obj.setCreatetime(new Date());
					obj.setHandprice(rhp);
					obj.setIsautoadjust(hpi.getIsautoadjust());
					obj.setName(hpi.getName());
					obj.setPrice(hpi.getPrice());
					obj.setTicketpriceformulaitemid(hpi
							.getTicketpriceformulaitemid());
					obj.setTickettype(hpi.getTickettype());
					obj.setUpdateby(updateby);
					obj.setUpdatetime(new Date());
					rshps.add(obj);
				}
				rhp.setHandpriceitemlist(rshps);
				handpriceDao.getEntityManager().merge(rhp);
			}
		}

		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> saveTicketpriceItem(List<Ticketpriceitem> ticketpriceitemlist, long userid,
			boolean iscopyothersch, Date fromdate, Date enddate) throws ServiceException {
		long ticketpriceid = 0;
		try {
			if (ticketpriceitemlist != null && ticketpriceitemlist.size() > 0) {

				// char tickettype = ticketpriceitemlist.get(0).getTickettype();
				ticketpriceid = ticketpriceitemlist.get(0).getTicketpriceid();
				Ticketprice ticketprice = handpriceDao.qryTicketpriceById(ticketpriceid);
				userTransaction.begin();
				if (iscopyothersch) {
					Schedule schedule = (Schedule) handpriceDao.get(Schedule.class, ticketprice.getScheduleid());
//					List<Ticketprice> tplist = handpriceDao.qryTicketprice(ticketprice.getDepartdate(),
//							schedule.getRoute().getId(), ticketprice.getScheduleid(), ticketprice.getDepartstationid(),
//							ticketprice.getReachstationid());
					List<Ticketprice> tplist = handpriceDao.qryTicketpriceByDate(fromdate, enddate,
							schedule.getRoute().getId(), ticketprice.getScheduleid(), ticketprice.getDepartstationid(),
							ticketprice.getReachstationid());
					for (Ticketprice tp : tplist) {
						// 同时保存全票、半票、学生票、上限票价的票价分项值
						saveTicketpriceItem(tp, ticketpriceitemlist, "Q", userid);
						// saveTicketpriceItem(tp, ticketpriceitemlist, "X",
						// userid);
						// saveTicketpriceItem(tp, ticketpriceitemlist, "B",
						// userid);
						// saveTicketpriceItem(tp, ticketpriceitemlist, "S",
						// userid);
					}
				} else {
					List<Ticketprice> tplist = handpriceDao.qryTicketpriceByDate(fromdate, enddate,
							ticketprice.getScheduleid(), ticketprice.getDepartstationid(),
							ticketprice.getReachstationid());
					for (Ticketprice tp : tplist) {
						// 同时保存全票、半票、学生票、上限票价的票价分项值
						saveTicketpriceItem(tp, ticketpriceitemlist, "Q", userid);
					}
					/*
					 * saveTicketpriceItem(ticketprice, ticketpriceitemlist,
					 * "X", userid); saveTicketpriceItem(ticketprice,
					 * ticketpriceitemlist, "B", userid);
					 * saveTicketpriceItem(ticketprice, ticketpriceitemlist,
					 * "S", userid);
					 */
				}
				userTransaction.commit();
			}
		} catch (ServiceException e) {
			throw new ServiceException("0467");
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
		}
		return ListUtil.listToMap(new Object[] { Ticketprice.class }, handpriceDao.qryTicketprice(ticketpriceid),
				new Object[] { Ticketprice.class });
	}

	private BigDecimal getPrice(Ticketpriceitem hi,
			List<Ticketpriceitem> tpriceitemlist) {
		for (Ticketpriceitem obj : tpriceitemlist) {
			if (hi.getTicketpriceformulaitemid() == obj
					.getTicketpriceformulaitemid()) {
				return obj.getPrice();
			}

		}
		return new BigDecimal(0);
	}

	@SuppressWarnings("unchecked")
	private void saveTicketpriceItem(Ticketprice ticketprice,
			List<Ticketpriceitem> ticketpriceitemlist, String tickettype,
			long userid)  throws ServiceException{
		List<Ticketpriceitem> tpilist = ticketprice.getTicketpriceitemlist();
		long ticketpriceitemid = 0;
		BigDecimal unisfreight = new BigDecimal(0);
		for (Ticketpriceitem ti : tpilist) {
			if (ti.getTickettype().equals(tickettype)) {
				if (ti.isIsautoadjust()) {
					ticketpriceitemid = ti.getId();
				} else {
					ti.setPrice(getPrice(ti, ticketpriceitemlist));
					unisfreight = unisfreight.add(ti.getPrice());
					ti.setUpdateby(userid);
					ti.setUpdatetime(new Date());
					handpriceDao.getEntityManager().merge(ti);
				}
			}
		}
		Ticketpriceitem basefreight = (Ticketpriceitem) handpriceDao.get(
				Ticketpriceitem.class, ticketpriceitemid);
		if (tickettype == "Q") {
			BigDecimal baseprice=ticketprice.getFullprice().subtract(
					unisfreight);
			if(baseprice.intValue()<0){
				//基本运价不允许为负数！
				  try {
						userTransaction.rollback();
					} catch (SystemException e) {
						// TODO Auto-generated catch block
						play.Logger.error(e.getMessage(), e);
					}
					throw new ServiceException("0467");								
			}else{
				basefreight.setPrice(baseprice);
			}
		}
		/*
		 * else if (tickettype == "B") {
			basefreight.setPrice(ticketprice.getHalfprice().subtract(
					unisfreight));
		} else if (tickettype == "X") {
			basefreight.setPrice(ticketprice.getStudentprice().subtract(
					unisfreight));
		} else if (tickettype == "S") {
			basefreight.setPrice(ticketprice.getToplimitprice().subtract(
					unisfreight));
		}*/
		basefreight.setUpdateby(userid);
		basefreight.setUpdatetime(new Date());
		handpriceDao.getEntityManager().merge(basefreight);

	}
	//综合调度-站点票价
	@SuppressWarnings("unchecked")
	@Override
	public boolean saveStationPrice(String adjusttype, String departstationids,
			String scheduleids, Handprice handprice) throws ServiceException {
		String departstationidsay[] = departstationids.split(",");
		for (String id : departstationidsay) {
			long departstationid = new Long(id);
			List<Handprice> hplist = handpriceDao
					.qryHandprices(departstationid,
							handprice.getReachstationid(), scheduleids);
			for (Handprice hp : hplist) {
				if (adjusttype.equals("0")) {
					hp.setFullprice(handprice.getFullprice());
					hp.setHalfprice(handprice.getHalfprice());
					hp.setStudentprice(handprice.getStudentprice());
					hp.setMoreprice(handprice.getMoreprice());
					hp.setToplimitprice(handprice.getToplimitprice());

				} else if (adjusttype.equals("1")) {
					hp.setFullprice(hp.getFullprice().add(
							handprice.getFullprice()));
					hp.setHalfprice(hp.getHalfprice().add(
							handprice.getHalfprice()));
					hp.setStudentprice(hp.getStudentprice().add(
							handprice.getStudentprice()));
					hp.setMoreprice(hp.getMoreprice().add(
							handprice.getMoreprice()));
					hp.setToplimitprice(hp.getToplimitprice().add(handprice.getToplimitprice()));
					hp.setDiscountprice(hp.getDiscountprice().add(handprice.getDiscountprice()));
					hp.setRoundprice(hp.getRoundprice().add(handprice.getRoundprice()));
					hp.setConnectprice(hp.getConnectprice().add(handprice.getConnectprice()));

				} else {
					hp.setFullprice(hp.getFullprice().multiply(
							handprice.getFullprice().add(new BigDecimal(1)),
							MathContext.UNLIMITED));
					hp.setHalfprice(hp.getHalfprice().multiply(
							handprice.getHalfprice().add(new BigDecimal(1)),
							MathContext.UNLIMITED));
					hp.setStudentprice(hp.getStudentprice().multiply(
							handprice.getStudentprice().add(new BigDecimal(1)),
							MathContext.UNLIMITED));
					hp.setMoreprice(hp.getMoreprice().multiply(
							handprice.getMoreprice().add(new BigDecimal(1)),
							MathContext.UNLIMITED));
					hp.setToplimitprice(hp.getToplimitprice()
							.multiply(handprice.getToplimitprice().add(new BigDecimal(1)), MathContext.UNLIMITED));
					hp.setDiscountprice(hp.getDiscountprice()
							.multiply(handprice.getDiscountprice().add(new BigDecimal(1)), MathContext.UNLIMITED));
					hp.setRoundprice(hp.getRoundprice().multiply(handprice.getRoundprice().add(new BigDecimal(1)),
							MathContext.UNLIMITED));
					hp.setConnectprice(hp.getConnectprice().multiply(handprice.getConnectprice().add(new BigDecimal(1)),
							MathContext.UNLIMITED));
				}
				hp.setUpdateby(handprice.getUpdateby());
				hp.setUpdatetime(new Date());
				saveHandpriceItem(hp, hp.getHandpriceitemlist(), "Q",
						hp.getUpdateby());
				saveHandpriceItem(hp, hp.getHandpriceitemlist(), "B",
						hp.getUpdateby());
				saveHandpriceItem(hp, hp.getHandpriceitemlist(), "X",
						hp.getUpdateby());
				saveHandpriceItem(hp, hp.getHandpriceitemlist(), "S", hp.getUpdateby());
				saveHandpriceItem(hp, hp.getHandpriceitemlist(), "W", hp.getUpdateby());
				saveHandpriceItem(hp, hp.getHandpriceitemlist(), "L", hp.getUpdateby());
				saveHandpriceItem(hp, hp.getHandpriceitemlist(), "Y", hp.getUpdateby());
				handpriceDao.merge(hp);
			}
		}
		return true;
	}
	//综合调度-站点票价 查询相同站点班次票价信息
	@Override
	public List<Map<String, Object>> qrySameStations(String departstationids,
			long reachstationid) throws ServiceException {
		return ListUtil.listToMap(new Object[] { 
				"id", "isselect", "code",
				"starttime", "fullprice", "halfprice", "studentprice",
				"toplimitprice", "moreprice" 
				, "discountprice", "roundprice", "connectprice" },
				handpriceDao.qrySameStations(departstationids, reachstationid),
				new Object[] { long.class, boolean.class, String.class,
						String.class, BigDecimal.class, BigDecimal.class,BigDecimal.class
						, BigDecimal.class, BigDecimal.class 
						, BigDecimal.class,BigDecimal.class, BigDecimal.class});
	}
}
