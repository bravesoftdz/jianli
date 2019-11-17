package cn.nova.bus.dispatch.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.LockModeType;

import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.dao.TicketpriceDao;
import cn.nova.bus.dispatch.service.ScheduleplanService;
import cn.nova.bus.dispatch.service.TicketpriceService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.price.model.Ticketpriceitem;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("unchecked")
public class TicketpriceServiceImpl implements TicketpriceService {

	
	private TicketpriceDao ticketpriceDao = new TicketpriceDao();
	
	
	private IDAO dao = new EntityManagerDaoSurport();
	
	private ScheduleplanService planService = new ScheduleplanServiceImpl();

	@Override
	public boolean save(Ticketprice schedulestatus) {
		if (schedulestatus.getId() == 0) {
			return dao.save(schedulestatus);
		} else {
			return dao.update(schedulestatus);
		}
	}

	@Override
	public boolean savePlanprice(List<Ticketprice> dispatchprice,
			String routescheduleid, Long day, Date departdate, long updateby,
			String ip, Long scheduleid) throws ServiceException {// 调整票价
		Date curdepartdate = departdate;
		for (int i = 0; i < day; i++) {
			if ("".equals(routescheduleid) || null == routescheduleid) {
				Scheduleplan plan = planService.getByScheduleid(scheduleid,
						curdepartdate);
				if (plan == null) {
					Schedule schedule = (Schedule) dao.get(Schedule.class,
							scheduleid);
					throw new ServiceException(schedule.getCode() + "班次 "
							+ String.format("%tF", curdepartdate) + "日期,",
							"0314");
				}
				for (Ticketprice ticketprice : dispatchprice) {
					Ticketprice ticket = ticketpriceDao.getBySeattype(plan.getId(),
							ticketprice.getDepartstationid(),
							ticketprice.getReachstationid(),
							ticketprice.getSeattype());
					if (ticket == null) {
						Schedule schedule = (Schedule) dao.get(Schedule.class,
								ticketprice.getScheduleid());
						throw new ServiceException(schedule.getCode() + "班次 "
								+ String.format("%tF", curdepartdate) + "日期,",
								"0314");
					}
					Ticketprice price = (Ticketprice) dao.get(
							LockModeType.PESSIMISTIC_READ, Ticketprice.class,
							ticket.getId());
					savePriceChangeLog(price,ticketprice, updateby,ip);
					
					price.setIssellable(ticketprice.getIssellable());
					price.setFullprice(ticketprice.getFullprice());
					price.setStudentprice(ticketprice.getStudentprice());
					price.setHalfprice(ticketprice.getHalfprice());
					price.setToplimitprice(ticketprice.getToplimitprice());
					price.setMoreprice(ticketprice.getMoreprice());
					price.setUpdatetime(new Date());
					dao.merge(price);
					updatepriceitem(updateby, price);// 修改基础运费
				}
			} else {
				String[] scid = routescheduleid.split(",");
				for (int j = 0; j < scid.length; j++) {
					Scheduleplan plan = planService.getByScheduleid(
							Long.parseLong(scid[j]), curdepartdate);
					if (plan == null) {
						Schedule schedule = (Schedule) dao.get(Schedule.class,
								Long.parseLong(scid[j]));
						throw new ServiceException(schedule.getCode() + "班次 "
								+ String.format("%tF", curdepartdate) + "日期,",
								"0314");
					}
					for (Ticketprice ticketprice : dispatchprice) {
						Ticketprice price = ticketpriceDao.getBySeattype(plan.getId(),
								ticketprice.getDepartstationid(),
								ticketprice.getReachstationid(),
								ticketprice.getSeattype());
						savePriceChangeLog(price,ticketprice, updateby,ip);
						
						price.setIssellable(ticketprice.getIssellable());
						price.setFullprice(ticketprice.getFullprice());
						price.setStudentprice(ticketprice.getStudentprice());
						price.setHalfprice(ticketprice.getHalfprice());
						price.setToplimitprice(ticketprice.getToplimitprice());
						price.setMoreprice(ticketprice.getMoreprice());
						price.setUpdateby(updateby);
						price.setUpdatetime(new Date());
						dao.merge(price);
						updatepriceitem(updateby, price);// 修改基础运费
					}
				}
			}
			curdepartdate = DateUtils.add(curdepartdate, 1);
		}
		return true;
	}
	
	private void savePriceChangeLog(Ticketprice price,Ticketprice ticketprice, long updateby,String ip){
		Schedule schedule = (Schedule) dao.get(Schedule.class,
				price.getScheduleid());
		Station departstation = (Station) dao.get(Station.class, price.getDepartstationid());
		Station reachstation = (Station) dao.get(Station.class, price.getReachstationid());
		StringBuilder result = new StringBuilder();
		result.append("调整票价,班次号：").append(schedule.getCode())
		.append(",发车日期:").append(DateUtils.formatDate(price.getDepartdate()))
		.append(",发车站").append(departstation.getName())
		.append(",到达站").append(reachstation.getName());
		boolean pricehaschang = false;;
		if(price.getFullprice().compareTo(ticketprice.getFullprice())!=0){
			result.append(" 全票价由").append(price.getFullprice()).append("调整为：").append(ticketprice.getFullprice());
			pricehaschang = true;
		}
		if(price.getStudentprice().compareTo(ticketprice.getStudentprice())!=0){
			result.append(" 学生票价由").append(price.getStudentprice()).append("调整为：").append(ticketprice.getStudentprice());
			pricehaschang = true;
		}
		if(price.getHalfprice().compareTo(ticketprice.getHalfprice())!=0){
			result.append(" 半票价由").append(price.getHalfprice()).append("调整为：").append(ticketprice.getHalfprice());
			pricehaschang = true;
		}
		if(price.getToplimitprice().compareTo(ticketprice.getToplimitprice())!=0){
			result.append(" 上限票价由").append(price.getToplimitprice()).append("调整为：").append(ticketprice.getToplimitprice());
			pricehaschang = true;
		}		
		if(price.getMoreprice().compareTo(ticketprice.getMoreprice())!=0){
			result.append(" 票价差由").append(price.getMoreprice()).append("调整为：").append(ticketprice.getMoreprice());
			pricehaschang = true;
		}
		if(pricehaschang){
			Operationlog operationLog = new Operationlog();
			operationLog.setIp(ip);
			operationLog.setContent(result.toString());
			operationLog.setModule("综合调度->营运计划调整");
			operationLog.setOperatetime(new Date());
			operationLog.setOperation("调整票价");
			operationLog.setSessionid("无session");
			operationLog.setUserid(updateby);
			dao.merge(operationLog);
		}
	}

	@Override
	public boolean stopstation(String reachstationid, String routescheduleid,
			Long day, Date departdate, long updateby, String ip, Long scheduleid)
			throws ServiceException {// 调整停靠点
		Date curdepartdate = departdate;
		for (int i = 0; i < day; i++) {
			if ("".equals(routescheduleid) || null == routescheduleid) {
				saveChangeStoplog(updateby, ip, scheduleid,	curdepartdate, reachstationid);// 保存操作日志
				if (reachstationid != null) {
					Scheduleplan plan = updatestopstation(scheduleid,
							curdepartdate, updateby, ip); // 判断该计划是否生成
					String[] stationid = reachstationid.split(",");
					for (int j = 0; j < stationid.length; j++) {
						List<Ticketprice> ticketlist = ticketpriceDao.getByTicket(
								plan.getId(), Long.parseLong(stationid[j]));
						if (ticketlist == null) {
							throw new ServiceException("该班次"
									+ String.format("%tF", curdepartdate)
									+ "日期,", "0314");
						}
						for (int k = 0; k < ticketlist.size(); k++) {
							Ticketprice price = (Ticketprice) dao.get(
									LockModeType.PESSIMISTIC_READ,
									Ticketprice.class, ticketlist.get(k)
											.getId());
							price.setIssellable(true);
							price.setUpdateby(updateby);
							price.setUpdatetime(new Date());
							dao.merge(price);
						}
					}
				} else {
					updatestopstation(scheduleid, curdepartdate, updateby, ip);// 将停靠站点改为false
				}
			} else {
				String[] scid = routescheduleid.split(",");
				for (int j = 0; j < scid.length; j++) {
					saveChangeStoplog(updateby, ip, Long.parseLong(scid[j]),curdepartdate, reachstationid);// 保存操作日志
					if (reachstationid != null) {
						Scheduleplan plan = updatestopstation(
								Long.parseLong(scid[j]), curdepartdate,
								updateby, ip);
						String[] stationid = reachstationid.split(",");
						for (int n = 0; n < stationid.length; n++) {
							List<Ticketprice> ticketlist = ticketpriceDao.getByTicket(
									plan.getId(), Long.parseLong(stationid[n]));
							if (ticketlist == null) {
								throw new ServiceException("该班次"
										+ String.format("%tF", curdepartdate)
										+ "日期,", "0314");
							}
							for (int k = 0; k < ticketlist.size(); k++) {
								Ticketprice price = (Ticketprice) dao.get(
										LockModeType.PESSIMISTIC_READ,
										Ticketprice.class, ticketlist.get(k)
												.getId());
								price.setIssellable(true);
								price.setUpdateby(updateby);
								price.setUpdatetime(new Date());
								dao.merge(price);
							}
						}
					} else {
						if (routescheduleid != null) {
							String[] stationid = routescheduleid.split(",");
							for (int k = 0; k < stationid.length; k++) {
								updatestopstation(Long.parseLong(stationid[k]),
										curdepartdate, updateby, ip);// 将停靠站点改为false
							}
						} else {
							updatestopstation(scheduleid, curdepartdate,
									updateby, ip);// 将停靠站点改为false
						}
					}
				}
			}
			curdepartdate = DateUtils.add(curdepartdate, 1);
		}
		return true;
	}

	private void saveChangeStoplog(long updateby, String ip, Long scheduleid,
			Date curdepartdate, String reachstationids) {
		Scheduleplan plan = planService.getByScheduleid(scheduleid,curdepartdate);
		Schedule schedule = (Schedule) dao.get(Schedule.class, scheduleid);
		List<Ticketprice> ticketprices = plan.getTicketpricelist();
		reachstationids = ","+reachstationids+",";
		Station station = null;
		for (Ticketprice ticketprice : ticketprices) {
			String result = null;
			if(ticketprice.getIssellable()&&reachstationids.indexOf(","+ticketprice.getReachstationid()+",")==-1){
				//由可售变为不可售
				station = (Station) dao.get(Station.class,ticketprice.getReachstationid());
				result = "调整停靠站点：班次号：" + schedule.getCode() + ",发车日期："
						+ DateUtils.formatDate(curdepartdate) + ", 站点：" + station.getName() + "由可售改为不可售。";
			}
			else if(!ticketprice.getIssellable()&&reachstationids.indexOf(","+ticketprice.getReachstationid()+",")!=-1){
				//由不可售变为可售
				station = (Station) dao.get(Station.class,ticketprice.getReachstationid());
				result = "调整停靠站点：班次号：" + schedule.getCode() + ",发车日期："
						+ DateUtils.formatDate(curdepartdate) + ", 站点：" + station.getName() + "由不可售改为可售。";
			} 
			if(result!=null){
				Operationlog operationLog = new Operationlog();
				operationLog.setIp(ip);
				operationLog.setContent(result);
				operationLog.setModule("综合调度->营运计划调整");
				operationLog.setOperatetime(new Date());
				operationLog.setOperation("调整停靠站点");
				operationLog.setSessionid("无session");
				operationLog.setUserid(updateby);
				dao.merge(operationLog);
			}
		}
	}

	private Scheduleplan updatestopstation(Long scheduleid, Date curdepartdate,
			Long updateby, String ip) throws ServiceException { // 判断计划是否生成，将所有停靠点改为false
		Scheduleplan plan = planService.getByScheduleid(scheduleid,
				curdepartdate);
		if (plan == null) {
			Schedule schedule = (Schedule) dao.get(Schedule.class, scheduleid);
			throw new ServiceException(schedule.getCode() + "班次 "
					+ String.format("%tF", curdepartdate) + "日期,", "0314");
		}
		List<Ticketprice> ticketpricelist = ticketpriceDao.getByScheduleplanid(plan
				.getId());
		for (int m = 0; m < ticketpricelist.size(); m++) {
			Ticketprice ticketprice = (Ticketprice) dao.get(
					LockModeType.PESSIMISTIC_READ, Ticketprice.class,
					ticketpricelist.get(m).getId());
			ticketprice.setIssellable(false);
			ticketprice.setUpdateby(updateby);
			ticketprice.setUpdatetime(new Date());
			dao.merge(ticketprice);
		}
		return plan;
	}

	private void updatepriceitem(long updateby, Ticketprice price)
			throws ServiceException {

		Ticketpriceitem fullpriceitem = ticketpriceDao.findPriceitem(price.getId(), "Q");
		if (fullpriceitem != null) {
			BigDecimal fullprice = ticketpriceDao.getIsfreight(price.getId(), "Q");
			if (price.getFullprice().compareTo(fullprice) <= 0) {
				throw new ServiceException("全票票价分项总和为：" + fullprice, "0324");
			}
			fullpriceitem.setPrice(price.getFullprice().subtract(fullprice));
			fullpriceitem.setUpdateby(updateby);
			fullpriceitem.setUpdatetime(new Date());
			dao.merge(fullpriceitem);
		}

		Ticketpriceitem studentpriceitem = ticketpriceDao
				.findPriceitem(price.getId(), "X");
		if (studentpriceitem != null) {
			BigDecimal studentprice = ticketpriceDao.getIsfreight(price.getId(), "X");
			if (price.getStudentprice().compareTo(studentprice) <= 0) {
				throw new ServiceException("学生票票价分项总和为：" + studentprice, "0324");
			}
			studentpriceitem.setPrice(price.getStudentprice().subtract(
					studentprice));
			studentpriceitem.setUpdateby(updateby);
			studentpriceitem.setUpdatetime(new Date());
			dao.merge(studentpriceitem);
		}

		Ticketpriceitem halfpriceitem = ticketpriceDao.findPriceitem(price.getId(), "B");
		if (halfpriceitem != null) {
			BigDecimal halfprice = ticketpriceDao.getIsfreight(price.getId(), "B");
			if (price.getHalfprice().compareTo(halfprice) <= 0) {
				throw new ServiceException("半票票价分项总和为：" + halfprice, "0324");
			}
			halfpriceitem.setPrice(price.getHalfprice().subtract(halfprice));
			halfpriceitem.setUpdateby(updateby);
			halfpriceitem.setUpdatetime(new Date());
			dao.merge(halfpriceitem);
		}

		Ticketpriceitem toplimitpriceitem = ticketpriceDao.findPriceitem(price.getId(),
				"S");
		if (toplimitpriceitem != null) {
			BigDecimal toplimitprice = ticketpriceDao.getIsfreight(price.getId(), "S");
			if (price.getHalfprice().compareTo(toplimitprice) <= 0) {
				throw new ServiceException("上限价分项总和为：" + toplimitprice, "0324");
			}
			toplimitpriceitem.setPrice(price.getToplimitprice().subtract(
					toplimitprice));
			toplimitpriceitem.setUpdateby(updateby);
			toplimitpriceitem.setUpdatetime(new Date());
			dao.merge(toplimitpriceitem);
		}
	}

	@Override
	public boolean delete(Ticketprice schedulestatus) {
		return dao.delete(schedulestatus);
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Ticketprice.class, id);
	}

	@Override
	public List<Ticketprice> query() {
		return dao.query(Ticketprice.class, null);
	}

	@Override
	public Ticketprice getById(Long id) {
		return (Ticketprice) dao.get(LockModeType.PESSIMISTIC_READ,
				Ticketprice.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return null;
	}

	@Override
	public List<Ticketprice> getByScheduleplanid(Long scheduleplanid) {
		if (ticketpriceDao.getByScheduleplanid(scheduleplanid).size() > 0) {
			return ticketpriceDao.getByScheduleplanid(scheduleplanid);
		}
		return null;
	}

	@Override
	public List<Map<String, Object>> findSchedulestops(
			List<PropertyFilter> propertyFilterList) {
		return ticketpriceDao.findSchedulestops(propertyFilterList);
	}

	@Override
	public List<Map<String, Object>> queryStopstation(long scheduleplanid) {
		return ListUtil.listToMap(new Object[] { "reachstationid",
				"departstationid", "scheduleplanid", "issellable" },
				ticketpriceDao.queryStopstation(scheduleplanid), new Object[] {
						Long.class, Long.class, Long.class, Boolean.class });
	}

	@Override
	public List<Map<String, Object>> queryRouteschedule(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Schedule.class, "checked" },
				ticketpriceDao.queryRouteschedule(propertyFilterList), new Object[] {
						Schedule.class, Boolean.class });
	}

	@Override
	public List<Ticketprice> getByScheduleplanid(LockModeType lockModeType,
			Long scheduleplanid) {
		return ticketpriceDao.getByScheduleplanid(lockModeType, scheduleplanid);
	}

	@Override
	public List<Ticketprice> getByScheduleplanSeattype(Long scheduleplanid,
			String seattype) {
		return ticketpriceDao.getByScheduleplanSeattype(scheduleplanid, seattype);
	}

	@Override
	public List<Ticketprice> getByScheduleplanSeattype(LockModeType lockModeType,
			Long scheduleplanid, String seattype) {
		return ticketpriceDao.getByScheduleplanSeattype(lockModeType,scheduleplanid, seattype);
	}

	public TicketpriceDao getTicketpriceDao() {
		return ticketpriceDao;
	}

	public void setTicketpriceDao(TicketpriceDao ticketpriceDao) {
		this.ticketpriceDao = ticketpriceDao;
	}

	public IDAO getDao() {
		return dao;
	}

	public void setDao(IDAO dao) {
		this.dao = dao;
	}

}
