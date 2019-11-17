package cn.nova.bus.price.service.impl;

/**
 * @author lck
 * 
 */
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import util.TransactionUtil;
import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Vehiclebrandmodel;
import cn.nova.bus.base.model.Vehicletype;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.dao.HandHolidaypriceDao;
import cn.nova.bus.price.model.Handholidayprice;
import cn.nova.bus.price.model.Handholidaypriceitem;
import cn.nova.bus.price.model.Handprice;
import cn.nova.bus.price.model.Handpriceitem;
import cn.nova.bus.price.model.Holiday;
import cn.nova.bus.price.service.HandHolidaypriceService;
import cn.nova.bus.price.service.RoutepriceService;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;


public class HandHolidaypriceServiceImpl implements HandHolidaypriceService {

	private ParameterService parameterService = new ParameterServiceImpl();
	
	private RoutepriceService routepriceService = new RoutepriceServiceImpl();
	
	private HandHolidaypriceDao handHolidaypriceDao = new HandHolidaypriceDao();
	
	private IDAO<Handholidayprice> dao = new EntityManagerDaoSurport<Handholidayprice>();

	@Override
	public List<Map<String, Object>> qryScheduleVehicletype(Long scheduleid) {
		return ListUtil.listToMap(new Object[] { Vehicletype.class },
				handHolidaypriceDao.qryScheduleVehicletype(scheduleid),
				new Object[] { Vehicletype.class });
	}

	// 编辑界面的查询
	@Override
	public List<Map<String, Object>> qryHandHolidayPrice(Holiday holiday,
			Long scheduleid, String vehicletypeids) {
		Global global = CurrentUtil.getGlobal();
		//参数0017在生成硬调票价、线路票价、节日票价、公式票价的半票票价对应于全票票价的比例，值在0-1之间
		String halfpricetype = parameterService.findParamValue(
				ParamterConst.Param_0017,global.getOrganization().getId());
		String halfpriceway = parameterService.findParamValue(
				ParamterConst.Param_1042,global.getOrganization().getId());
		
		List<Object> handholidaypricelist = handHolidaypriceDao
				.qryHandholidayprice(holiday, scheduleid, vehicletypeids);
		if (handholidaypricelist == null || handholidaypricelist.size() == 0) {
			List<Object> handpricelist = handHolidaypriceDao.qryHandprice(
					scheduleid, vehicletypeids);
			Handprice handprice = null;
			for (Object obj : handpricelist) {
				handprice = (Handprice) obj;
				Handholidayprice handholidayprice = new Handholidayprice();
				handholidayprice.setId(0);
				handholidayprice.setScheduleid(scheduleid);
				handholidayprice.setDepartstationid(handprice
						.getDepartstationid());
				handholidayprice.setReachstationid(handprice
						.getReachstationid());
				handholidayprice.setVehicletypeid(handprice.getVehicletypeid());
				handholidayprice.setSeattype(handprice.getSeattype());
				handholidayprice.setSeats(handprice.getSeats());
				handholidayprice.setVehiclebrandmodel(handprice
						.getVehiclebrandmodel());
				handholidayprice.setFullprice(handprice.getFullprice());
				
				//根据1058参数计算半票票价
				BigDecimal halfprice =handprice.getFullprice().multiply(new BigDecimal(halfpricetype));
				
				//根据参数1042计算半票票价小数位
				handholidayprice.setHalfprice(routepriceService.mathPriceByRule(halfpriceway,halfprice));
				
				handholidayprice.setStudentprice(handprice.getStudentprice());
				handholidayprice.setHolidayid(holiday.getId());
				handholidayprice.setStartdate(holiday.getStartdate());
				handholidayprice.setEnddate(holiday.getEnddate());
				handholidayprice.setLowerlimitprice(handprice
						.getLowerlimitprice());
				handholidayprice.setMoreprice(handprice.getMoreprice());
				handholidayprice.setToplimitprice(handprice.getToplimitprice());
				handholidayprice.setIsselect(true);
				handholidayprice.setDiscountprice(handprice.getDiscountprice());
				handholidayprice.setRoundprice(handprice.getRoundprice());
				handholidayprice.setConnectprice(handprice.getConnectprice());
				handholidaypricelist.add(handholidayprice);
			}
		}else{
			List<Handprice> hplist=handHolidaypriceDao.qryHandprices(scheduleid,vehicletypeids);
			Handholidayprice hpp=null;
			for(Handprice hp:hplist){
				boolean isexist=false;	
				for (Object obj : handholidaypricelist) {
					hpp = (Handholidayprice) obj;
					if (hp.getDepartstationid() == hpp.getDepartstationid()
							&& hp.getReachstationid() == hpp.getReachstationid()
							&& hp.getVehicletypeid() == hpp.getVehicletypeid()) {
						isexist = true;
						break;
					} 
				}
				if(!isexist){
					Handholidayprice handholidayprice = new Handholidayprice();
					handholidayprice.setId(0);
					handholidayprice.setScheduleid(scheduleid);
					handholidayprice.setDepartstationid(hp
							.getDepartstationid());
					handholidayprice.setReachstationid(hp
							.getReachstationid());
					handholidayprice.setVehicletypeid(hp.getVehicletypeid());
					handholidayprice.setSeattype(hp.getSeattype());
					handholidayprice.setSeats(hp.getSeats());
					handholidayprice.setVehiclebrandmodel(hpp
							.getVehiclebrandmodel());
					handholidayprice.setFullprice(hp.getFullprice());
					handholidayprice.setHalfprice(hp.getFullprice().multiply(new BigDecimal(halfpricetype)));
					//根据1058参数计算半票票价
					BigDecimal halfprice =hp.getFullprice().multiply(new BigDecimal(halfpricetype));
					
					//根据参数1042计算半票票价小数位
					handholidayprice.setHalfprice(routepriceService.mathPriceByRule(halfpriceway,halfprice));
					handholidayprice.setStudentprice(hp.getStudentprice());
					handholidayprice.setHolidayid(holiday.getId());
					handholidayprice.setStartdate(holiday.getStartdate());
					handholidayprice.setEnddate(holiday.getEnddate());
					handholidayprice.setLowerlimitprice(hp
							.getLowerlimitprice());
					handholidayprice.setMoreprice(hp.getMoreprice());
					handholidayprice.setToplimitprice(hp.getToplimitprice());
					handholidayprice.setIsselect(false);
					handholidayprice.setDiscountprice(hp.getDiscountprice());
					handholidayprice.setRoundprice(hp.getRoundprice());
					handholidayprice.setConnectprice(hp.getConnectprice());
					handholidaypricelist.add(handholidayprice);
				}
			}
		}
		return ListUtil.listToMap(new Object[] { "isselect","id", "holidayid",
				"startdate", "enddate", "scheduleid", "vehicletypeid",
				"vehiclebrandmodelid", "departstationid", "reachstationid",
				"seattype", "seats", "fullprice", "halfprice", "studentprice",
				"lowerlimitprice", "toplimitprice", "createtime", "createby" 
						,"discountprice", "roundprice", "connectprice" },
				handholidaypricelist, new Object[] { boolean.class, Long.class, Long.class,
						Date.class, Date.class, Long.class, Long.class,
						Long.class, Long.class, Long.class, String.class,
						String.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						Timestamp.class, Long.class 
						,BigDecimal.class, BigDecimal.class, BigDecimal.class });
	}

	@Override
	public List<Map<String, Object>> save(
			List<Handholidayprice> handholidayprices, Holiday holiday,
			Long userid, boolean savesameroute) throws Exception {
		List<Object> saveobj = new ArrayList<Object>();
		// 刨去不要的节日票价 如果存在记录就删掉
		Iterator<Handholidayprice> iterator = handholidayprices.iterator();
		while (iterator.hasNext()) {
			Handholidayprice del = iterator.next();
			if (!del.isIsselect()) {
				if (del.getId() != 0) {
					List<Handholidaypriceitem> handholidaypriceitemlist = handHolidaypriceDao.findHandholidaypriceitemlist(del.getId());
					if (handholidaypriceitemlist != null && handholidaypriceitemlist.size()>0) {
//						del.getHandholidaypriceitemlist().clear();
						for (Handholidaypriceitem h : handholidaypriceitemlist) {
							handHolidaypriceDao.del(h);
						}
					}
					handHolidaypriceDao.del(del);
				}
				iterator.remove();
			}
		}
		saveobj = saveHandholidayprice(handholidayprices, holiday, userid);
		if (savesameroute) {
			long scheduleid = handholidayprices.get(0).getScheduleid();
			List<Schedule> schedules = handHolidaypriceDao
					.qryOtherSchedules(scheduleid);

			for (Schedule schedule : schedules) {
				handHolidaypriceDao.delOtherSchedulesPrice(schedule.getId(),
						handholidayprices.get(0));
				handHolidaypriceDao.getEntityManager().flush();
				List<Handholidayprice> otherhp = new ArrayList<Handholidayprice>();
				List<Vehicletype> vts = handHolidaypriceDao
						.qrySchVehicletype(schedule.getId());
				for (Vehicletype vt : vts) {
					List<Handholidayprice> hps = getHandholidayprice(
							handholidayprices, vt.getId());
					for (Handholidayprice hp : hps) {
						if (handHolidaypriceDao.isExistHandprice(
								schedule.getId(), hp.getDepartstationid(),
								hp.getReachstationid())) {
							Handholidayprice ohp = new Handholidayprice();
							ohp.setCreateby(hp.getCreateby());
							ohp.setCreatetime(new Date());
							ohp.setDepartstationid(hp.getDepartstationid());
							ohp.setEnddate(hp.getEnddate());
							ohp.setFullprice(hp.getFullprice());
							ohp.setHalfprice(hp.getHalfprice());
							ohp.setHolidayid(hp.getHolidayid());
							ohp.setLowerlimitprice(hp.getLowerlimitprice());
							ohp.setReachstationid(hp.getReachstationid());
							ohp.setScheduleid(schedule.getId());
							ohp.setSeats(hp.getSeats());
							ohp.setSeattype(hp.getSeattype());
							ohp.setStartdate(hp.getStartdate());
							ohp.setStudentprice(hp.getStudentprice());
							ohp.setToplimitprice(hp.getToplimitprice());
							ohp.setUpdateby(hp.getUpdateby());
							ohp.setUpdatetime(new Date());
							ohp.setVehiclebrandmodel(hp.getVehiclebrandmodel());
							ohp.setVehiclebrandmodelid(hp
									.getVehiclebrandmodelid());
							ohp.setMoreprice(hp.getMoreprice());
							ohp.setVehicletypeid(vt.getId());
							ohp.setDiscountprice(hp.getDiscountprice());
							ohp.setRoundprice(hp.getRoundprice());
							ohp.setConnectprice(hp.getConnectprice());
							otherhp.add(ohp);

						} else {
							Handholidayprice ohp = new Handholidayprice();
							ohp.setCreateby(hp.getCreateby());
							ohp.setCreatetime(new Date());
							ohp.setDepartstationid(hp.getDepartstationid());
							ohp.setEnddate(hp.getEnddate());
							ohp.setFullprice(hp.getFullprice());
							ohp.setHalfprice(hp.getHalfprice());
							ohp.setHolidayid(hp.getHolidayid());
							ohp.setLowerlimitprice(hp.getLowerlimitprice());
							ohp.setReachstationid(hp.getReachstationid());
							ohp.setScheduleid(schedule.getId());
							ohp.setSeats(hp.getSeats());
							ohp.setSeattype(hp.getSeattype());
							ohp.setStartdate(hp.getStartdate());
							ohp.setStudentprice(hp.getStudentprice());
							ohp.setToplimitprice(hp.getToplimitprice());
							ohp.setUpdateby(hp.getUpdateby());
							ohp.setUpdatetime(new Date());
							ohp.setVehiclebrandmodel(hp.getVehiclebrandmodel());
							ohp.setVehiclebrandmodelid(hp
									.getVehiclebrandmodelid());
							ohp.setMoreprice(hp.getMoreprice());
							ohp.setVehicletypeid(vt.getId());
							ohp.setDiscountprice(hp.getDiscountprice());
							ohp.setRoundprice(hp.getRoundprice());
							ohp.setConnectprice(hp.getConnectprice());
							otherhp.add(ohp);
						}
					}
				}
				if (otherhp != null && otherhp.size() > 0) {
					saveHandholidayprice(otherhp, holiday, userid);
				}

			}
		}

		return ListUtil.listToMap(new Object[] { Handholidayprice.class },
				saveobj, new Object[] { Handholidayprice.class });
	}

	@SuppressWarnings("unused")
	private List<Handholidayprice>  getHandholidayprice(List<Handholidayprice> hplist,
			long vehicletypeid) {
		List<Handholidayprice> hps=new ArrayList<Handholidayprice>();
		Handholidayprice hdp = null;
		if (hplist != null && hplist.size() > 0) {
			for (Handholidayprice hp : hplist) {
				if (hp.getVehicletypeid() == vehicletypeid) {
					hps.add(hp);
				}
			}
			if (hps.size() == 0) {
				vehicletypeid=hplist.get(0).getVehicletypeid();
				for (Handholidayprice hp : hplist) {
					if (hp.getVehicletypeid() == vehicletypeid) {
						hps.add(hp);
					}
				}
			}
		}
		return hps;
	}

	private List<Object> saveHandholidayprice(
			List<Handholidayprice> Handholidayprices, Holiday holiday,
			Long userid) throws Exception {
		Handholidayprice hh = Handholidayprices.get(0);
		hh.setStartdate(holiday.getStartdate());
		hh.setEnddate(holiday.getEnddate());
		/*
		 * if (handHolidaypriceDao.isExistHandholidayprice(hh)) { throw new
		 * ServiceException("0063"); }
		 */
		List<Object> saveobj = new ArrayList<Object>();
		for (Handholidayprice handholidayprice : Handholidayprices) {
			handholidayprice.setStartdate(holiday.getStartdate());
			handholidayprice.setEnddate(holiday.getEnddate());
			if (handholidayprice.getId() == 0) {
				//如果在该时间段内，有假日票价，则不能添加
				if(handHolidaypriceDao.isExistHandpriceInTimes(handholidayprice)){
					TransactionUtil.setRollbackOnly();
					throw new Exception("该时间段中已经存在节日票价");
				}
				
				// 进行保存
				handholidayprice.setCreateby(userid);
				handholidayprice.setCreatetime(new Date());
				handholidayprice.setUpdateby(userid);
				handholidayprice.setUpdatetime(new Date());
				if (handholidayprice.getVehiclebrandmodelid() != null) {
					Vehiclebrandmodel vehiclebrandmodel = new Vehiclebrandmodel();
					vehiclebrandmodel.setId(handholidayprice
							.getVehiclebrandmodelid());
					handholidayprice.setVehiclebrandmodel(vehiclebrandmodel);
				}
				// 保存分项
				
				handholidayprice
						.setHandholidaypriceitemlist(addHandholidayprice(handholidayprice));
				
				
				saveobj.add(dao.merge(handholidayprice));
				
			} else {
				Handholidayprice entity = dao.get(Handholidayprice.class,
						handholidayprice.getId());
				entity.setStartdate(holiday.getStartdate());
				entity.setEnddate(holiday.getEnddate());
				List<Handholidaypriceitem> hpilist = entity
						.getHandholidaypriceitemlist();
				if (handholidayprice.getSeattype() != null) {
					entity.setSeattype(handholidayprice.getSeattype());
				}
				if (handholidayprice.getFullprice() != null) {
					entity.setFullprice(handholidayprice.getFullprice());
					BigDecimal notbaseprice = new BigDecimal(0);
					for (Handholidaypriceitem sp : hpilist) {
						if (sp.getTickettype().equals("Q") && !sp.getIsautoadjust()) {
							notbaseprice = notbaseprice.add(sp.getPrice());
						}
					}
					for (Handholidaypriceitem sp : hpilist) {
						if (sp.getTickettype().equals("Q")  && sp.getIsautoadjust()) {
							sp.setPrice(handholidayprice.getFullprice()
									.subtract(notbaseprice));
							sp.setUpdateby(handholidayprice.getUpdateby());
							sp.setUpdatetime(new Date());
						}
					}
				}
				if (handholidayprice.getHalfprice() != null) {
					entity.setHalfprice(handholidayprice.getHalfprice());
					BigDecimal notbaseprice = new BigDecimal(0);
					for (Handholidaypriceitem sp : hpilist) {
						if (sp.getTickettype().equals("B") && !sp.getIsautoadjust()) {
							notbaseprice = notbaseprice.add(sp.getPrice());
						}
					}
					for (Handholidaypriceitem sp : hpilist) {
						if (sp.getTickettype().equals("B") && sp.getIsautoadjust()) {
							sp.setPrice(handholidayprice.getHalfprice()
									.subtract(notbaseprice));
							sp.setUpdateby(handholidayprice.getUpdateby());
							sp.setUpdatetime(new Date());
						}
					}
				}
				if (handholidayprice.getStudentprice() != null) {
					entity.setStudentprice(handholidayprice.getStudentprice());
					BigDecimal notbaseprice = new BigDecimal(0);
					for (Handholidaypriceitem sp : hpilist) {
						if (sp.getTickettype().equals("X") && !sp.getIsautoadjust()) {
							notbaseprice = notbaseprice.add(sp.getPrice());
						}
					}
					for (Handholidaypriceitem sp : hpilist) {
						if (sp.getTickettype().equals("X") && sp.getIsautoadjust()) {
							sp.setPrice(handholidayprice.getStudentprice()
									.subtract(notbaseprice));
							sp.setUpdateby(handholidayprice.getUpdateby());
							sp.setUpdatetime(new Date());
						}
					}
				}
				if (handholidayprice.getToplimitprice() != null) {
					entity.setToplimitprice(handholidayprice.getToplimitprice());
					BigDecimal notbaseprice = new BigDecimal(0);
					for (Handholidaypriceitem sp : hpilist) {
						if (sp.getTickettype().equals("S") && !sp.getIsautoadjust()) {
							notbaseprice = notbaseprice.add(sp.getPrice());
						}
					}
					for (Handholidaypriceitem sp : hpilist) {
						if (sp.getTickettype().equals("S") && sp.getIsautoadjust()) {
							sp.setPrice(handholidayprice.getToplimitprice()
									.subtract(notbaseprice));
							sp.setUpdateby(handholidayprice.getUpdateby());
							sp.setUpdatetime(new Date());
						}
					}
				}
				if (handholidayprice.getDiscountprice() != null) {
					entity.setDiscountprice(handholidayprice.getDiscountprice());
					BigDecimal notbaseprice = new BigDecimal(0);
					for (Handholidaypriceitem sp : hpilist) {
						if (sp.getTickettype().equals("Y") && !sp.getIsautoadjust()) {
							notbaseprice = notbaseprice.add(sp.getPrice());
						}
					}
					for (Handholidaypriceitem sp : hpilist) {
						if (sp.getTickettype().equals("Y") && sp.getIsautoadjust()) {
							sp.setPrice(handholidayprice.getDiscountprice()
									.subtract(notbaseprice));
							sp.setUpdateby(handholidayprice.getUpdateby());
							sp.setUpdatetime(new Date());
						}
					}
				}
				if (handholidayprice.getRoundprice() != null) {
					entity.setRoundprice(handholidayprice.getRoundprice());
					BigDecimal notbaseprice = new BigDecimal(0);
					for (Handholidaypriceitem sp : hpilist) {
						if (sp.getTickettype().equals("W") && !sp.getIsautoadjust()) {
							notbaseprice = notbaseprice.add(sp.getPrice());
						}
					}
					for (Handholidaypriceitem sp : hpilist) {
						if (sp.getTickettype().equals("W") && sp.getIsautoadjust()) {
							sp.setPrice(handholidayprice.getRoundprice()
									.subtract(notbaseprice));
							sp.setUpdateby(handholidayprice.getUpdateby());
							sp.setUpdatetime(new Date());
						}
					}
				}
				if (handholidayprice.getConnectprice() != null) {
					entity.setConnectprice(handholidayprice.getConnectprice());
					BigDecimal notbaseprice = new BigDecimal(0);
					for (Handholidaypriceitem sp : hpilist) {
						if (sp.getTickettype().equals("L") && !sp.getIsautoadjust()) {
							notbaseprice = notbaseprice.add(sp.getPrice());
						}
					}
					for (Handholidaypriceitem sp : hpilist) {
						if (sp.getTickettype().equals("L") && sp.getIsautoadjust()) {
							sp.setPrice(handholidayprice.getConnectprice()
									.subtract(notbaseprice));
							sp.setUpdateby(handholidayprice.getUpdateby());
							sp.setUpdatetime(new Date());
						}
					}
				}
				if (handholidayprice.getLowerlimitprice() != null) {
					entity.setLowerlimitprice(handholidayprice
							.getLowerlimitprice());
				}
				if (handholidayprice.getMoreprice() != null) {
					entity.setMoreprice(handholidayprice.getMoreprice());
				}
				entity.setUpdateby(userid);
				entity.setUpdatetime(new Date());
				saveobj.add(dao.merge(entity));
			}
		}
		return saveobj;
	}

	private List<Handholidaypriceitem> addHandholidayprice(
			Handholidayprice handholidayprice) {
		// 保存票价分项
		List<Handholidaypriceitem> hpilist = new ArrayList<Handholidaypriceitem>();
		// 保存全票票价分项
		List<Handpriceitem> spilist = handHolidaypriceDao.qryHandpriceitem(
				handholidayprice.getScheduleid(),
				handholidayprice.getVehicletypeid(), "Q",
				handholidayprice.getDepartstationid(),
				handholidayprice.getReachstationid(),
				handholidayprice.getSeattype());
		hpilist.addAll(genHandholidaypriceitem(handholidayprice, spilist,
				handholidayprice.getFullprice()));
		// 保存学生票票价分项
		spilist.clear();
		spilist = handHolidaypriceDao.qryHandpriceitem(
				handholidayprice.getScheduleid(),
				handholidayprice.getVehicletypeid(), "X",
				handholidayprice.getDepartstationid(),
				handholidayprice.getReachstationid(),
				handholidayprice.getSeattype());
		hpilist.addAll(genHandholidaypriceitem(handholidayprice, spilist,
				handholidayprice.getStudentprice()));
		
		// 保存半票票价分项
		spilist.clear();
		spilist = handHolidaypriceDao.qryHandpriceitem(
				handholidayprice.getScheduleid(),
				handholidayprice.getVehicletypeid(), "B",
				handholidayprice.getDepartstationid(),
				handholidayprice.getReachstationid(),
				handholidayprice.getSeattype());
		hpilist.addAll(genHandholidaypriceitem(handholidayprice, spilist,
				handholidayprice.getHalfprice()));
		// 保存上限票票价分项
		spilist.clear();
		spilist = handHolidaypriceDao.qryHandpriceitem(
				handholidayprice.getScheduleid(),
				handholidayprice.getVehicletypeid(), "S",
				handholidayprice.getDepartstationid(),
				handholidayprice.getReachstationid(),
				handholidayprice.getSeattype());
		hpilist.addAll(genHandholidaypriceitem(handholidayprice, spilist,
				handholidayprice.getToplimitprice()));
		// 保存优惠票票价分项
		spilist.clear();
		spilist = handHolidaypriceDao.qryHandpriceitem(
				handholidayprice.getScheduleid(),
				handholidayprice.getVehicletypeid(), "Y",
				handholidayprice.getDepartstationid(),
				handholidayprice.getReachstationid(),
				handholidayprice.getSeattype());
		hpilist.addAll(genHandholidaypriceitem(handholidayprice, spilist,
				handholidayprice.getDiscountprice()));
		// 保存往返票票价分项
		spilist.clear();
		spilist = handHolidaypriceDao.qryHandpriceitem(
				handholidayprice.getScheduleid(),
				handholidayprice.getVehicletypeid(), "W",
				handholidayprice.getDepartstationid(),
				handholidayprice.getReachstationid(),
				handholidayprice.getSeattype());
		hpilist.addAll(genHandholidaypriceitem(handholidayprice, spilist,
				handholidayprice.getRoundprice()));
		// 保存联程票票价分项
		spilist.clear();
		spilist = handHolidaypriceDao.qryHandpriceitem(
				handholidayprice.getScheduleid(),
				handholidayprice.getVehicletypeid(), "L",
				handholidayprice.getDepartstationid(),
				handholidayprice.getReachstationid(),
				handholidayprice.getSeattype());
		hpilist.addAll(genHandholidaypriceitem(handholidayprice, spilist,
				handholidayprice.getConnectprice()));

		return hpilist;
	}

	private List<Handholidaypriceitem> genHandholidaypriceitem(
			Handholidayprice handholidayprice, List<Handpriceitem> spilist,
			BigDecimal price) {
		List<Handholidaypriceitem> hpilist = new ArrayList<Handholidaypriceitem>();
		BigDecimal notbaseprice = new BigDecimal(0);
		for (Handpriceitem sp : spilist) {
			if (!sp.getIsautoadjust()) {
				Handholidaypriceitem hpi = new Handholidaypriceitem();
				hpi.setCreateby(handholidayprice.getCreateby());
				hpi.setCreatetime(new Date());
				hpi.setIsautoadjust(sp.getIsautoadjust());
				hpi.setPrice(sp.getPrice());
				notbaseprice = notbaseprice.add(sp.getPrice());
				hpi.setTicketpriceformulaitemid(sp
						.getTicketpriceformulaitemid());
				hpi.setTickettype(sp.getTickettype());
				hpi.setUpdateby(handholidayprice.getCreateby());
				hpi.setUpdatetime(new Date());
				hpi.setHandholidayprice(handholidayprice);
				hpi.setHandholidaypriceid(handholidayprice.getId());
				//
				hpilist.add(hpi);
				Collections.reverse(hpilist);
				
				Iterator<Handholidaypriceitem> iterator = hpilist.iterator();
				
				iterator.next();
				while(iterator.hasNext()) {
					Handholidaypriceitem temp = iterator.next();
					if(hpi.getTickettype().equals(temp.getTickettype()) &&  hpi.getTicketpriceformulaitemid()==temp.getTicketpriceformulaitemid()){
						iterator.remove();
						break;
					}
				}
				Collections.reverse(hpilist);
				//hpilist.add(hpi);
				//System.out.println("HANDHOLIDAYPRICEID"+hpi.getHandholidaypriceid()+"TICKETPRICEFORMULAITEMID"+hpi.getTicketpriceformulaitemid()+"TICKETTYPE"+hpi.getTickettype());
			}
		}
		for (Handpriceitem sp : spilist) {
			if (sp.getIsautoadjust()) {
				Handholidaypriceitem hpi = new Handholidaypriceitem();
				hpi.setCreateby(handholidayprice.getCreateby());
				hpi.setCreatetime(new Date());
				hpi.setIsautoadjust(sp.getIsautoadjust());
				hpi.setPrice(price.subtract(notbaseprice));
				hpi.setTicketpriceformulaitemid(sp
						.getTicketpriceformulaitemid());
				hpi.setTickettype(sp.getTickettype());
				hpi.setUpdateby(handholidayprice.getCreateby());
				hpi.setUpdatetime(new Date());
				hpi.setHandholidayprice(handholidayprice);
				hpi.setHandholidaypriceid(handholidayprice.getId());
				//
				hpilist.add(hpi);
				Collections.reverse(hpilist);
				Iterator<Handholidaypriceitem> iterator = hpilist.iterator();
				iterator.next();
				while(iterator.hasNext()) {
					Handholidaypriceitem temp = iterator.next();
					if(hpi.getTickettype().equals(temp.getTickettype()) &&  hpi.getTicketpriceformulaitemid()==temp.getTicketpriceformulaitemid()){
						iterator.remove();
						break;
					}
				}
				Collections.reverse(hpilist);
				//hpilist.add(hpi);
				//System.out.println("HANDHOLIDAYPRICEID"+hpi.getHandholidaypriceid()+"TICKETPRICEFORMULAITEMID"+hpi.getTicketpriceformulaitemid()+"TICKETTYPE"+hpi.getTickettype());
				}
		}
		return hpilist;
	}

	// 查询界面的查询
	@Override
	public List<Map<String, Object>> qryHandHolidayPrice(
			Handholidayprice handholidayprice) {
		return ListUtil.listToMap(new Object[] { Handholidayprice.class,
				"departstation", "reachstation", "vehicletype",
				"toplimitprice", "lowerlimitprice", "fullname","routename","schedulecode","viastation","planseatnum" },
				handHolidaypriceDao.qryHandHolidayprice(handholidayprice),
				new Object[] { Handholidayprice.class, String.class,
						String.class, String.class, BigDecimal.class,
						BigDecimal.class, String.class, String.class, String.class, String.class, String.class,String.class });
	}

	@Override
	public boolean delHandHolidayPrice(Handholidayprice handholidayprice) {
		List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
		filters.clear();
		filters.add(new PropertyFilter("EQL_t!scheduleid", handholidayprice.getScheduleid()));
		filters.add(new PropertyFilter("EQL_t!holidayid", handholidayprice.getHolidayid()));
		filters.add(new PropertyFilter("EQL_t!vehicletypeid", handholidayprice.getVehicletypeid()));
		filters.add(new PropertyFilter("EQD_t!startdate", handholidayprice.getStartdate()));
		filters.add(new PropertyFilter("EQD_t!enddate", handholidayprice.getEnddate()));	
		List<Handholidayprice> lists = handHolidaypriceDao.query(Handholidayprice.class,filters);
		Iterator<Handholidayprice> its=lists.iterator();
		while(its.hasNext()){
			Handholidayprice hp=its.next();
			List<Handholidaypriceitem>  hlist=hp.getHandholidaypriceitemlist();
			for(Handholidaypriceitem h:hlist){
				handHolidaypriceDao.del(h);
			}
			handHolidaypriceDao.del(hp);
		}
		return true;
	}

	/*
	 * qryHandholidaypriceitem方法：<br/> <br/>
	 * 
	 * @param handholidaypriceid
	 * 
	 * @param tickettype
	 * 
	 * @return
	 * 
	 * @see
	 * cn.nova.bus.price.service.HandHolidaypriceService#qryHandholidaypriceitem
	 * (long, char)
	 * 
	 * @exception
	 */
	@Override
	public List<Map<String, Object>> qryHandholidaypriceitem(
			long handholidaypriceid, String tickettype) {
		return ListUtil.listToMap(new Object[] { "code", "name", "price", "id",
				"tickettype", "isautoadjust", "handholidaypriceid",
				"ticketpriceformulaitemid" }, handHolidaypriceDao
				.qryHandholidaypriceitem(handholidaypriceid, tickettype),
				new Object[] { String.class, String.class, BigDecimal.class,
						long.class, String.class, boolean.class, long.class,
						long.class });
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> saveHandholidaypriceitem(
			List<Handholidaypriceitem> handholidaypriceitemlist, long userid,boolean iscopyothersch)
			throws ServiceException {
		long handholidaypriceid = 0;
		if (handholidaypriceitemlist != null
				&& handholidaypriceitemlist.size() > 0) {
			handholidaypriceid = handholidaypriceitemlist.get(0)
					.getHandholidaypriceid();
			Handholidayprice handholidayprice = (Handholidayprice) handHolidaypriceDao
					.get(Handholidayprice.class, handholidaypriceid);
			if(iscopyothersch){
				//同一线路的其他班次
				Route route=handHolidaypriceDao.qryRoute(handholidayprice.getScheduleid());
				List<Handholidayprice> hhpList=handHolidaypriceDao.qryHandholidayprice(route.getId(),handholidayprice.getVehicletypeid(),  
						                        handholidayprice.getDepartstationid(), handholidayprice.getReachstationid());
				for(Handholidayprice hhp:hhpList){
					saveHandholidaypriceitem(hhp, handholidaypriceitemlist, "Q", userid);
					saveHandholidaypriceitem(hhp, handholidaypriceitemlist, "B", userid);
					saveHandholidaypriceitem(hhp, handholidaypriceitemlist, "X", userid);
					saveHandholidaypriceitem(hhp, handholidaypriceitemlist, "S", userid);
					saveHandholidaypriceitem(hhp, handholidaypriceitemlist, "Y", userid);
					saveHandholidaypriceitem(hhp, handholidaypriceitemlist, "W", userid);
					saveHandholidaypriceitem(hhp, handholidaypriceitemlist, "L", userid);
				} 
			}else{
				saveHandholidaypriceitem(handholidayprice, handholidaypriceitemlist, "Q", userid);
				saveHandholidaypriceitem(handholidayprice, handholidaypriceitemlist, "B", userid);
				saveHandholidaypriceitem(handholidayprice, handholidaypriceitemlist, "X", userid);
				saveHandholidaypriceitem(handholidayprice, handholidaypriceitemlist, "S", userid);
				saveHandholidaypriceitem(handholidayprice, handholidaypriceitemlist, "Y", userid);
				saveHandholidaypriceitem(handholidayprice, handholidaypriceitemlist, "W", userid);
				saveHandholidaypriceitem(handholidayprice, handholidaypriceitemlist, "L", userid);
			}
		}
		return ListUtil.listToMap(new Object[] { Handholidayprice.class },
				handHolidaypriceDao.qryHandholidayprice(handholidaypriceid),
				new Object[] { Handholidayprice.class });
	}
	private BigDecimal getPrice(long ticketpriceformulaitemid,
			List<Handholidaypriceitem> handholidaypricelist) {
		for (Handholidaypriceitem obj : handholidaypricelist) {
			if (ticketpriceformulaitemid == obj.getTicketpriceformulaitemid()) {
				return obj.getPrice();
			}
		}
		return new BigDecimal(0);
	}
	@SuppressWarnings("unchecked")
	private void saveHandholidaypriceitem(Handholidayprice handholidayprice,
			List<Handholidaypriceitem> handholidaypricelist, String tickettype, long userid) {
		List<Handholidaypriceitem> hpilist = handholidayprice.getHandholidaypriceitemlist();
		long handpriceitemid = 0;
		BigDecimal unisfreight = new BigDecimal(0);
		for (Handholidaypriceitem hi : hpilist) {
			if (hi.getTickettype().equals(tickettype)) {
				if (hi.getIsautoadjust()) {
					handpriceitemid = hi.getId();
				} else {
					hi.setPrice(getPrice(hi.getTicketpriceformulaitemid(),
							handholidaypricelist));
					unisfreight = unisfreight.add(hi.getPrice());
					hi.setUpdateby(userid);
					hi.setUpdatetime(new Date());
					handHolidaypriceDao.getEntityManager().merge(hi);
				}
			}
		}
		Handholidaypriceitem basefreight = (Handholidaypriceitem) handHolidaypriceDao.get(
				Handholidaypriceitem.class, handpriceitemid);
		if(null == basefreight){
			play.Logger.info("Handholidaypriceitem-basefreight is null,don't save !");
			return;
		}
		if (tickettype == "Q") {
			basefreight.setPrice(handholidayprice.getFullprice().subtract(unisfreight));
		} else if (tickettype == "B") {
			basefreight.setPrice(handholidayprice.getHalfprice().subtract(unisfreight));
		} else if (tickettype == "X") {
			basefreight.setPrice(handholidayprice.getStudentprice().subtract(
					unisfreight));
		} else if (tickettype == "S") {
			basefreight.setPrice(handholidayprice.getToplimitprice().subtract(
					unisfreight));
		} else if (tickettype == "Y") {
			basefreight.setPrice(handholidayprice.getDiscountprice().subtract(
					unisfreight));
		} else if (tickettype == "W") {
			basefreight.setPrice(handholidayprice.getRoundprice().subtract(
					unisfreight));
		} else if (tickettype == "L") {
			basefreight.setPrice(handholidayprice.getConnectprice().subtract(
					unisfreight));
		}
		basefreight.setUpdateby(userid);
		basefreight.setUpdatetime(new Date());
		handHolidaypriceDao.getEntityManager().merge(basefreight);

	}

}
