package cn.nova.bus.price.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Insuretypeticketprice;
import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Vehiclebrandmodel;
import cn.nova.bus.base.model.Vehicletype;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.dao.HandpriceDao;
import cn.nova.bus.price.dao.TicketoutletspriceDao;
import cn.nova.bus.price.model.Ticketoutletsprice;
import cn.nova.bus.price.model.Ticketoutletsrouteprice;
import cn.nova.bus.price.service.TicketoutletspriceService;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;
import util.CurrentUtil;

/**
 * <b>类描述：售票点票价差额管理</b><br/>
 * <b>类名称：</b>TicketoutletspriceService.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b>2013-11-01 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */

public class TicketoutletspriceServiceImpl implements TicketoutletspriceService {

	private TicketoutletspriceDao ticketoutletspriceDao = new TicketoutletspriceDao();

	private HandpriceDao handpriceDao = new HandpriceDao();

	private IDAO<Ticketoutletsprice> dao = new EntityManagerDaoSurport<Ticketoutletsprice>();

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "id", "routeid", "orgid",
				"code", "worktype", "workways", "districttype", "type",
				"starttime", "runtime", "isproprietary", "isovertime",
				"issellreturnticket", "islinework", "isoriginator",
				"issaleafterreport", "iscanmixcheck", "planseatnum",
				"viastation", "printinfo", "remarks", "isaudited",
				"isauditpass", "isactive", "createtime", "createby",
				"updatetime", "updateby", "endtime", "spacinginterval",
				"synccode", "orgname", "routename", "username",
				"ticketentrance", "vehcilepark", "startstationid",
				"endstationid", "routeid", "entranceid", "parkid",
				"islongstop", "isfixseat", "outletsname", "ticketoutletsid" },
				ticketoutletspriceDao.query(propertyFilterList), new Object[] {
						Long.class, Long.class, Long.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, BigDecimal.class, boolean.class,
						boolean.class, boolean.class, boolean.class,
						boolean.class, boolean.class, boolean.class,
						short.class, String.class, String.class, String.class,
						boolean.class, boolean.class, boolean.class,
						Timestamp.class, Long.class, Timestamp.class,
						Long.class, String.class, short.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Boolean.class, Boolean.class,
						String.class, Long.class });
	}

	// 子列表查询：查询出不同的站点车型，对应的售票点差额
	@Override
	public List<Map<String, Object>> qryTicketoutletsprice(Long scheduleid,
			Long ticketoutletsid) {
		return ListUtil.listToMap(new Object[] { "id", "scheduleid",
				"seattype", "seats", "fullprice", "halfprice", "studentprice",
				"departstation", "reachstation", "vehicletype",
				"toplimitprice", "lowerlimitprice", "vehicletypeid",
				"brandname", "modelcode", "rationseatnum", "moreprice",
				"departstationid", "reachstationid", "distance", "difprice",
				"ticketoutletspriceid", "starttime", "endtime" },
				ticketoutletspriceDao.qryTicketoutletsprice(scheduleid,
						ticketoutletsid), new Object[] { Long.class,
						Long.class, String.class, String.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						String.class, String.class, String.class,
						BigDecimal.class, BigDecimal.class, Long.class,
						String.class, String.class, Short.class,
						BigDecimal.class, long.class, long.class,
						Integer.class, BigDecimal.class, long.class,
						Date.class, Date.class });

	}

	// 编辑界面的查询
	@Override
	public List<Map<String, Object>> qryEdtTicketoutletPrice(
			Ticketoutletsprice ticketoutletsprice,String saveorupdateflag) throws ServiceException {
		List<Object> list = null;
		if("1".equals(saveorupdateflag)){//添加时查询硬调票价的设置
			list = ticketoutletspriceDao.qryEdtTicketoutletspricesave(ticketoutletsprice);
		}else{//修改时，查询票价差额的数据
			list = ticketoutletspriceDao.qryEdtTicketoutletsprice(ticketoutletsprice);
		}
		return ListUtil.listToMap(new Object[] { "id", "scheduleid",
				"departstationid", "reachstationid", "vehicletypeid",
				"vehiclebrandmodelid", "brandname", "seattype", "fullprice",
				"halfprice", "studentprice", "toplimitprice",
				"lowerlimitprice", "createby", "vehicletype", "departstation",
				"reachstation", "moreprice", "distance", "difprice","starttime","endtime",
				"ticketoutletspriceid" }, list, new Object[] {
				Long.class, Long.class, Long.class, Long.class, Long.class,
				Long.class, String.class, String.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, Long.class, String.class, String.class,
				String.class, BigDecimal.class, Integer.class,
				BigDecimal.class,Date.class,Date.class, Long.class });
	}

	/**
	 * 保存或修改 班次 的不同停靠点 票价差
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> save(
			List<Ticketoutletsprice> ticketoutletspricelist,
			boolean iscopyvehicletype, Long userid,
			Ticketoutletsprice currticketoutlets, String getDateTime)
			throws ServiceException {
		
		List<Object> saveobj = new ArrayList<Object>();
		Userinfo user = (Userinfo) ticketoutletspriceDao.get(Userinfo.class,
				userid);
		for (Ticketoutletsprice ticketoutletsprice : ticketoutletspricelist) {
			// 进行保存
			if (ticketoutletsprice.getId() == 0) {
				//查询已存在的票价差额
				List<Ticketoutletsprice> list = ticketoutletspriceDao.isExistTicketoutletsprice(currticketoutlets);
				//定义变量判断是否进行插入
				boolean isneedsave = true;
				if (list != null && list.size() > 0) {
					for (Ticketoutletsprice oldTicketoutletsprice : list) {
						// 遍历已有的设置日期
						if(oldTicketoutletsprice.getStarttime()!=null)
						{
							SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
							String oldStarttime = dateFormat.format(oldTicketoutletsprice.getStarttime());
							String oldEndtime = dateFormat.format(oldTicketoutletsprice.getEndtime());
							String newStarttime = dateFormat.format(currticketoutlets.getStarttime());
							String newEndtime = dateFormat.format(currticketoutlets.getEndtime());
							if ((oldStarttime.equals(newStarttime))
									&& (oldEndtime.equals(newEndtime))) {// 存在同日期段的记录 直接修改票价
								// 只修改票价
								Ticketoutletsprice oldticketoutletsprice = ticketoutletspriceDao
										.qryTicketoutletspriceByTime(currticketoutlets,ticketoutletsprice);
								if(oldticketoutletsprice!=null){
									oldticketoutletsprice.setUpdateby(userid);
									oldticketoutletsprice
											.setUpdatetime(new Date());
									oldticketoutletsprice
											.setDifprice(ticketoutletsprice
													.getDifprice());
									saveobj.add(ticketoutletspriceDao
											.merge(oldticketoutletsprice));
									isneedsave=false;//如果存在记录，修改即可 不用重新创建
									break;
								}
							}
							//交叉的直接插入，取最新的差额
//							 else if (!(  currticketoutlets.getEndtime().before(oldTicketoutletsprice.getStarttime()) || 
//									(currticketoutlets.getStarttime().after(oldTicketoutletsprice.getEndtime())) )) {// 判断日期是否交叉
//									throw new ServiceException("0757");
//							 }
						}
					}
				}
				//如果没有重复的记录，则保存
				if(isneedsave){
					ticketoutletsprice.setOrgid(user.getOrgid());
					ticketoutletsprice.setCreateby(userid);
					ticketoutletsprice.setCreatetime(new Date());
					ticketoutletsprice.setUpdateby(userid);
					ticketoutletsprice.setUpdatetime(new Date());
					if (currticketoutlets != null && getDateTime.equals("0")) {
						ticketoutletsprice.setStarttime(currticketoutlets
								.getStarttime());
						ticketoutletsprice.setEndtime(currticketoutlets
								.getEndtime());
					}
					ticketoutletsprice.setTicketoutletsid(currticketoutlets
							.getTicketoutletsid());
					if (ticketoutletsprice.getVehiclebrandmodelid() == null) {
						ticketoutletsprice.setSeats("0");
					} else {
						String seats = handpriceDao.qryScheduleSeats(
								ticketoutletsprice.getVehiclebrandmodelid(),
								ticketoutletsprice.getSeattype());
						ticketoutletsprice.setSeats(seats);
						Vehiclebrandmodel vehiclebrandmodel = new Vehiclebrandmodel();
						vehiclebrandmodel.setId(ticketoutletsprice
								.getVehiclebrandmodelid());
						ticketoutletsprice.setVehiclebrandmodel(vehiclebrandmodel);
					}
					saveobj.add(dao.merge(ticketoutletsprice));
				}
			} 
//			else {// 修改
//				ticketoutletsprice.setStarttime(currticketoutlets.getStarttime());
//				ticketoutletsprice.setEndtime(currticketoutlets.getEndtime());
//				if (getDateTime.equals("0")) {// 设置日期--执行插入 选择日期  
//					// 修改日期
//					List<Ticketoutletsprice> list = ticketoutletspriceDao
//							.isExistTicketoutletsprice(currticketoutlets);
//					if (list != null && list.size() > 0) {
//						for (Ticketoutletsprice oldTicketoutletsprice : list) {
//							// 遍历已有的设置日期
//								if(oldTicketoutletsprice.getStarttime()!=null)
//								{
//								SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//								String oldStarttime = dateFormat.format(oldTicketoutletsprice.getStarttime());
//								String oldEndtime = dateFormat.format(oldTicketoutletsprice.getEndtime());
//								String newStarttime = dateFormat.format(currticketoutlets.getStarttime());
//								String newEndtime = dateFormat.format(currticketoutlets.getEndtime());
//								if ((oldStarttime.equals(newStarttime))
//										&& (oldEndtime.equals(newEndtime))) {// 判断修改时是否修改日期
//									// 只修改票价
//									Ticketoutletsprice oldticketoutletsprice = ticketoutletspriceDao
//											.qryTicketoutletspriceByTime(currticketoutlets,ticketoutletsprice);
//									oldticketoutletsprice.setUpdateby(userid);
//									oldticketoutletsprice
//											.setUpdatetime(new Date());
//									oldticketoutletsprice
//											.setDifprice(ticketoutletsprice
//													.getDifprice());
//									saveobj.add(ticketoutletspriceDao
//											.merge(oldticketoutletsprice));
//									break;
//								}
////								 else if (!(  currticketoutlets.getEndtime().before(oldTicketoutletsprice.getStarttime()) || 
////										(currticketoutlets.getStarttime().after(oldTicketoutletsprice.getEndtime())) )) {// 判断日期是否交叉
////										throw new ServiceException("0757");
////								 }
//								}  
//									if(IspessionInsert(currticketoutlets,list)){// 日期未交叉--执行插入新记录
//										ticketoutletsprice.setOrgid(user.getOrgid());
//										Ticketoutletsprice newTicketoutletsprice = new Ticketoutletsprice();
//										newTicketoutletsprice.setDepartstationid(ticketoutletsprice.getDepartstationid());										newTicketoutletsprice.setCreateby(userid);
//										newTicketoutletsprice.setReachstationid(ticketoutletsprice.getReachstationid());										newTicketoutletsprice.setCreateby(userid);
//										newTicketoutletsprice.setDifprice(ticketoutletsprice.getDifprice());										newTicketoutletsprice.setCreateby(userid);
//										newTicketoutletsprice.setCreatetime(new Date());
//										newTicketoutletsprice.setUpdateby(userid);
//										newTicketoutletsprice.setUpdatetime(new Date());
//										newTicketoutletsprice.setSeattype("0");
//										newTicketoutletsprice.setScheduleid(currticketoutlets.getScheduleid());
//										newTicketoutletsprice.setVehicletypeid(currticketoutlets.getVehicletypeid());
//										newTicketoutletsprice.setStarttime(currticketoutlets.getStarttime());
//										newTicketoutletsprice.setEndtime(currticketoutlets.getEndtime());
//										newTicketoutletsprice.setTicketoutletsid(currticketoutlets.getTicketoutletsid());
//										if (ticketoutletsprice
//												.getVehiclebrandmodelid() == null) {
//											newTicketoutletsprice.setSeats("0");
//										} else {
//											String seats = handpriceDao
//													.qryScheduleSeats(
//															ticketoutletsprice.getVehiclebrandmodelid(),
//															ticketoutletsprice.getSeattype());
//											newTicketoutletsprice
//													.setSeats(seats);
//											Vehiclebrandmodel vehiclebrandmodel = new Vehiclebrandmodel();
//											vehiclebrandmodel
//													.setId(ticketoutletsprice.getVehiclebrandmodelid());
//											newTicketoutletsprice
//													.setVehiclebrandmodel(vehiclebrandmodel);
//										}
//										saveobj.add(ticketoutletspriceDao
//												.merge(newTicketoutletsprice));
//										break;
//							} else {// 原记录未设置日期
//								if (getDateTime.equals("1")) {// 只修改票价
//									// 只修改票价
//									Ticketoutletsprice oldticketoutletsprice = ticketoutletspriceDao
//									.qryTicketoutletspriceByTime(currticketoutlets,ticketoutletsprice);
//									oldticketoutletsprice.setUpdateby(userid);
//									oldticketoutletsprice
//											.setUpdatetime(new Date());
//									oldticketoutletsprice
//											.setDifprice(ticketoutletsprice
//													.getDifprice());
//									saveobj.add(ticketoutletspriceDao
//											.merge(oldticketoutletsprice));
//								} else if(getDateTime.equals("0")&&IspessionInsert(currticketoutlets,list)){// 设置日期--执行插入
////									if (!((currticketoutlets.getEndtime()
////											.before(oldTicketoutletsprice
////													.getStarttime()) || (currticketoutlets
////											.getStarttime()
////											.after(oldTicketoutletsprice
////													.getEndtime()))))) {// 判断日期是否交叉
////										throw new ServiceException(
////												"0757");
////										}
//									ticketoutletsprice.setOrgid(user.getOrgid());
//									Ticketoutletsprice newTicketoutletsprice = new Ticketoutletsprice();
//									newTicketoutletsprice.setDepartstationid(ticketoutletsprice.getDepartstationid());										newTicketoutletsprice.setCreateby(userid);
//									newTicketoutletsprice.setReachstationid(ticketoutletsprice.getReachstationid());										newTicketoutletsprice.setCreateby(userid);
//									newTicketoutletsprice.setDifprice(ticketoutletsprice.getDifprice());	
//									newTicketoutletsprice.setCreatetime(new Date());
//									newTicketoutletsprice.setUpdateby(userid);
//									newTicketoutletsprice.setUpdatetime(new Date());
//									newTicketoutletsprice.setSeattype("0");
//									newTicketoutletsprice.setScheduleid(currticketoutlets.getScheduleid());
//									newTicketoutletsprice.setVehicletypeid(currticketoutlets.getVehicletypeid());
//									newTicketoutletsprice.setStarttime(currticketoutlets.getStarttime());
//									newTicketoutletsprice.setEndtime(currticketoutlets.getEndtime());
//									newTicketoutletsprice.setTicketoutletsid(currticketoutlets.getTicketoutletsid());
//									if (ticketoutletsprice
//											.getVehiclebrandmodelid() == null) {
//										newTicketoutletsprice.setSeats("0");
//									} else {
//										String seats = handpriceDao
//												.qryScheduleSeats(
//														ticketoutletsprice
//																.getVehiclebrandmodelid(),
//														ticketoutletsprice
//																.getSeattype());
//										newTicketoutletsprice.setSeats(seats);
//										Vehiclebrandmodel vehiclebrandmodel = new Vehiclebrandmodel();
//										vehiclebrandmodel
//												.setId(ticketoutletsprice
//														.getVehiclebrandmodelid());
//										newTicketoutletsprice
//												.setVehiclebrandmodel(vehiclebrandmodel);
//									}
//									saveobj.add(ticketoutletspriceDao
//											.merge(newTicketoutletsprice));
//									break;
//								}
//							}
//						}
//					}
//				} 
//				
//				
//				
			else {// 只修该票价--执行更新
				Ticketoutletsprice oldticketoutletsprice = dao.get(
						Ticketoutletsprice.class,
						ticketoutletsprice.getId());
				oldticketoutletsprice.setUpdateby(userid);
				oldticketoutletsprice.setUpdatetime(new Date());
				oldticketoutletsprice.setDifprice(ticketoutletsprice
						.getDifprice());
				oldticketoutletsprice.setStarttime(ticketoutletsprice.getStarttime());
				oldticketoutletsprice.setEndtime(ticketoutletsprice.getEndtime());
				saveobj.add(ticketoutletspriceDao
						.merge(oldticketoutletsprice));
			}
		}

		if (iscopyvehicletype) {
			List<Ticketoutletsprice> tplist = ticketoutletspriceDao
					.qryTicketoutletsprice(currticketoutlets.getScheduleid(),
							currticketoutlets.getVehicletypeid());
			for (Ticketoutletsprice tp : tplist) {
				ticketoutletspriceDao.getEntityManager().remove(tp);
			}
			ticketoutletspriceDao.getEntityManager().flush();
			List<Vehicletype> vtlist = handpriceDao
					.qryCycleschemesVehicletype(currticketoutlets
							.getScheduleid());
			for (Vehicletype vt : vtlist) {
				if (vt.getId() != currticketoutlets.getVehicletypeid()) {
					for (Ticketoutletsprice hp : ticketoutletspricelist) {
						if (hp.getId() > 0) {
							hp = dao.get(Ticketoutletsprice.class, hp.getId());
						}
						Ticketoutletsprice entity = new Ticketoutletsprice();
						entity.setVehiclebrandmodelid(hp
								.getVehiclebrandmodelid());
						entity.setCreateby(hp.getCreateby());
						entity.setCreatetime(new Date());
						entity.setDepartstationid(hp.getDepartstationid());
						entity.setReachstationid(hp.getReachstationid());
						entity.setScheduleid(hp.getScheduleid());
						entity.setUpdateby(hp.getCreateby());
						entity.setUpdatetime(new Date());
						entity.setSeattype(hp.getSeattype());
						entity.setSeats(hp.getSeats());
						entity.setVehicletypeid(vt.getId());
						entity.setDifprice(hp.getDifprice());
						entity.setTicketoutletsid(hp.getTicketoutletsid());
						ticketoutletspriceDao.getEntityManager().merge(entity);
					}
				}
			}
		}
		return ListUtil.listToMap(new Object[] { Ticketoutletsprice.class },
				saveobj, new Object[] { Ticketoutletsprice.class });

	

	}

	// 删除售票点票价差 设置 删除班次 或线路或机构
	@Override
	public boolean delTicketoutletsprice(List<PropertyFilter> propertyFilterList)
			throws ServiceException {
		return ticketoutletspriceDao.delTicketoutletsprice(propertyFilterList);

	}
	public boolean IspessionInsert(Ticketoutletsprice tolp,List<Ticketoutletsprice> list)
	{	
		boolean result = false;
		try {
			list = ticketoutletspriceDao.isExistTicketoutletsprice(tolp);
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			if (list!=null&&list.size()>0) {
				for(Ticketoutletsprice oldTicketoutletsprice:list){
					if (tolp.getStarttime() != null) {// 判断原记录是否设置日期
						if(oldTicketoutletsprice.getStarttime()==null)
							{
								result = true;
								continue;
							}
					String oldStarttime = dateFormat.format(oldTicketoutletsprice.getStarttime());
					String oldEndtime = dateFormat.format(oldTicketoutletsprice.getEndtime());
					String newStarttime = dateFormat.format(tolp.getStarttime());
					String newEndtime = dateFormat.format(tolp.getEndtime());
					if(oldStarttime.equals(newStarttime)&&oldEndtime.equals(newEndtime)){//相等
						result = false;
					}
					else if(!((tolp.getEndtime().before(oldTicketoutletsprice.getStarttime()) || 
							(tolp.getStarttime().after(oldTicketoutletsprice.getEndtime()))))){
						result = false;
					}
					else{
						result = true;
					}
				} 
			}
		}
	}
			catch (ServiceException e) {
				result = false;
			e.printStackTrace();
		}
		return true;
	}

	@Override
	public List<Map<String, Object>> queryRouteinfo(List<PropertyFilter> propertyFilter) throws ServiceException {
		return ListUtil.listToMap(
				new Object[] { "id", "orgname", "routename", "startstation", "endstation",
						"distance", "highdistance", "districttype", "routetype", "grade", "direction",
						"returntripvaliddays", "reportinterval" },
				ticketoutletspriceDao.queryRouteinfo(propertyFilter),
				new Object[] { Long.class, String.class, String.class, String.class, String.class,
						Integer.class, Integer.class, String.class, String.class, String.class, String.class,
						Integer.class, Integer.class });
	}
	
	@Override
	public List<Map<String, Object>> queryTicketoutletsRoutePriceinfo(List<PropertyFilter> propertyFilter) {
		return ListUtil.listToMap(new Object[] { "ticketoutletsid","ticketoutletsname","startstation", "tostation", "price", "startdate", "enddate" },
				ticketoutletspriceDao.queryTicketoutletsRoutePriceinfo(propertyFilter),
				new Object[] { long.class,String.class,String.class, String.class, BigDecimal.class, Date.class, Date.class });
	}
	
	@Override
	public List<Map<String, Object>> queryRouteStopinfo(List<PropertyFilter> propertyFilter, Date startdate, Date enddate,Long ticketoutletsid) {
		return ListUtil.listToMap(new Object[] { "startstation", "tostation", "price","stationid","id" },
				ticketoutletspriceDao.queryRouteStopinfo(propertyFilter,startdate,enddate,ticketoutletsid),
				new Object[] { String.class, String.class, BigDecimal.class,long.class,long.class });
	}
	
	@Override
	public boolean saveTicketoutletsRoutePrice(long routeid, Date startdate, Date enddate, String station_price,
			Long ticketoutletsid, String ticketoutletsidstr) {
		Ticketoutletsrouteprice ticketoutletsrouteprice = null;
		String ticketoutletsids = "";
		Global global = CurrentUtil.getGlobal();
		Date now = new Date();
		Route route = (Route) ticketoutletspriceDao.get(Route.class, routeid);
		for (String _string : station_price.split(",")) {
			String[] string = _string.split("-");
			long ticketoutletsroutepriceid = Long.parseLong(string[0]);
			long stationid = Long.parseLong(string[1]);
			BigDecimal price = BigDecimal.valueOf(Long.parseLong(string[2]));
			// 如果有 ID 则为修改
			if (ticketoutletsroutepriceid != 0) {
				ticketoutletsrouteprice = (Ticketoutletsrouteprice) ticketoutletspriceDao
						.get(Ticketoutletsrouteprice.class, ticketoutletsroutepriceid);
				ticketoutletsrouteprice.setUpdateby(global.getUserinfo().getId());
				ticketoutletsrouteprice.setUpdatetime(now);
				ticketoutletsrouteprice.setEnddate(enddate);
				ticketoutletsrouteprice.setStartdate(startdate);
				ticketoutletsrouteprice.setRoutestopid(stationid);
				ticketoutletsrouteprice.setPrice(price);
				ticketoutletspriceDao.merge(ticketoutletsrouteprice);
			} else {
				ticketoutletsids = ticketoutletsidstr.substring(1, ticketoutletsidstr.length() - 1);
				String[] split = ticketoutletsids.split(",");
				for (String str : split) {
					ticketoutletsid = Long.valueOf(str);
					// 判断是否有交叉
					if (ticketoutletspriceDao.ticketoutletsroutepriceDateCompare(startdate, enddate, routeid,
							ticketoutletsid, stationid)) {
						return false;
					}
					ticketoutletsrouteprice = new Ticketoutletsrouteprice();
					ticketoutletsrouteprice.setCreateby(global.getUserinfo().getId());
					ticketoutletsrouteprice.setCreatetime(now);
					ticketoutletsrouteprice.setOrgid(route.getOrgid());
					ticketoutletsrouteprice.setRouteid(routeid);
					ticketoutletsrouteprice.setTicketoutletsid(ticketoutletsid);
					ticketoutletsrouteprice.setUpdateby(global.getUserinfo().getId());
					ticketoutletsrouteprice.setUpdatetime(now);
					ticketoutletsrouteprice.setEnddate(enddate);
					ticketoutletsrouteprice.setStartdate(startdate);
					ticketoutletsrouteprice.setRoutestopid(stationid);
					ticketoutletsrouteprice.setPrice(price);
					ticketoutletspriceDao.merge(ticketoutletsrouteprice);
				}
			}
		}
		return true;
	}
	
	
	@Override
	public boolean delTicketoutletsRoutePrice(long routeid, Date startdate, Date enddate, Long ticketoutletsid) {
		
		List<Ticketoutletsrouteprice> resultlist = ticketoutletspriceDao.findticketoutletsrouteprice(routeid,startdate,enddate,ticketoutletsid);
		for (Ticketoutletsrouteprice ticketoutletsrouteprice : resultlist) {
			ticketoutletspriceDao.del(ticketoutletsrouteprice);
		}
		return true;
	}

}
