package cn.nova.bus.dispatch.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import cn.nova.bus.base.model.Routestop;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Schedulestop;
import cn.nova.bus.dispatch.service.GenTicketpriceByHandpriceService;
import cn.nova.bus.price.dao.GenScheduleplanServiceDao;
import cn.nova.bus.price.model.Fuelfeegradeapply;
import cn.nova.bus.price.model.Handprice;
import cn.nova.bus.price.model.Handpriceitem;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.price.model.Ticketpriceformulaitem;
import cn.nova.bus.price.model.Ticketpriceitem;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;

public class GenTicketpriceByHandpriceServiceImpl implements GenTicketpriceByHandpriceService{
	
	private GenScheduleplanServiceDao genScheduleplanServiceDao = new GenScheduleplanServiceDao();
	
	private ParameterService parameterService = new ParameterServiceImpl();
	@Override
	public List<Ticketprice> genTicketprice(List<Handprice> handpricelist, Scheduleplan scheduleplan, Global global,
			Schedule schedule, long vehicletypeid,short seatnum) {
		List<Ticketprice> ticketpricelist = new ArrayList<Ticketprice>();
		long createby =global.getUserinfo().getId();
		for (Handprice handprice : handpricelist) {
			// 保存硬调票价
			Ticketprice ticketprice = addTicketprice(handprice,
					scheduleplan, schedule,global, seatnum);
			BigDecimal moreprice = handprice.getMoreprice();
			// 生成票价分项
			List<Ticketpriceitem> ticketpriceitems = new ArrayList<Ticketpriceitem>();
			List<Handpriceitem> hpilist = handprice
					.getHandpriceitemlist();
			BigDecimal fuelfee = new BigDecimal(0);
			List<Fuelfeegradeapply> fuelist = null;
			// 是否需要把燃油费生成到票价中
			String isfuadedcut = parameterService.findParamValue("0015", global.getOrganization().getId());
			if ("1".equals(isfuadedcut)) {
				// 查询是否存在燃油费应用
				fuelist = genScheduleplanServiceDao.qryFuelfeegradeapply(
						scheduleplan.getDepartdate(), schedule.getRoute().getId(), vehicletypeid);
			}
			for (Handpriceitem hpi : hpilist) {
				if (hpi.getTickettype().equals("Q")) {
					// 只要生成全票的票价分项
					Ticketpriceitem ticketpriceitem = new Ticketpriceitem();
					ticketpriceitem.setCreateby(createby);
					ticketpriceitem.setCreatetime(new Date());
					ticketpriceitem.setDepartdate(scheduleplan.getDepartdate());
					ticketpriceitem.setIsautoadjust(hpi
							.getIsautoadjust());
					ticketpriceitem.setPrice(hpi.getPrice());
					ticketpriceitem.setScheduleid(handprice
							.getScheduleid());
					Ticketpriceformulaitem tfi = (Ticketpriceformulaitem) genScheduleplanServiceDao
							.get(Ticketpriceformulaitem.class,
									hpi.getTicketpriceformulaitemid());
					// K：为燃油费
					if (tfi.getCode().equals("K")) {
						// 获取燃油费
						if (fuelist != null
								&& fuelist.size() > 0) {
							long fuelfeegradeid = fuelist
									.get(0).getFuelfeegradeid();
							BigDecimal price = genScheduleplanServiceDao
									.qryFuelfeegradedetail(
											fuelfeegradeid,
											ticketprice
													.getDistance());
							ticketpriceitem.setPrice(price);
							fuelfee = price;
						}
					}
					ticketpriceitem.setTicketprice(ticketprice);
					ticketpriceitem
							.setTicketpriceformulaitemid(hpi
									.getTicketpriceformulaitemid());
					ticketpriceitem.setTickettype(hpi
							.getTickettype());
					ticketpriceitem.setUpdateby(createby);
					ticketpriceitem.setUpdatetime(new Date());
					ticketpriceitems.add(ticketpriceitem);
				}
			}
			ticketprice
					.setTicketpriceitemlist(ticketpriceitems);
			if (fuelist != null && fuelist.size() > 0) {
				// 重新根据票价分项计算合计
				ticketprice = calTicketprice(ticketprice);
			}
			ticketprice.setFullprice(ticketprice.getFullprice()
					.add(moreprice));
			if ("1".equals(isfuadedcut)) {
				ticketprice.setHalfprice(ticketprice
						.getHalfprice().add(moreprice)
						.add(fuelfee));
				ticketprice.setStudentprice(ticketprice
						.getStudentprice().add(moreprice)
						.add(fuelfee));
				ticketprice.setToplimitprice(ticketprice
						.getToplimitprice().add(fuelfee));
			} else {
				ticketprice.setHalfprice(ticketprice
						.getHalfprice().add(moreprice));
				ticketprice.setStudentprice(ticketprice
						.getStudentprice().add(moreprice));
				ticketprice.setToplimitprice(ticketprice
						.getToplimitprice());
			}
			ticketpricelist.add(ticketprice);
		}
		return ticketpricelist;
	}
	// 取硬调票价保存
	@SuppressWarnings("unchecked")
	private Ticketprice addTicketprice(Handprice handprice,
			Scheduleplan scheduleplan,Schedule schedule,Global global,short seatnum) {
		Ticketprice ticketprice = new Ticketprice();
		long createby =global.getUserinfo().getId();
		long orgid = global.getOrganization().getId();
		ticketprice.setCreateby(createby);
		ticketprice.setCreatetime(new Date());
		ticketprice.setDepartdate(scheduleplan.getDepartdate());
		ticketprice.setDepartstationid(handprice.getDepartstationid());
		ticketprice.setFullprice(handprice.getFullprice());
		Date departdate = scheduleplan.getDepartdate();
		
		ticketprice.setHalfprice(genScheduleplanServiceDao.actPrice(
				handprice.getFullprice(), handprice.getHalfprice(), departdate,
				"B", schedule));
		ticketprice.setStudentprice(genScheduleplanServiceDao.actPrice(
				handprice.getFullprice(), handprice.getStudentprice(),
				departdate, "X", schedule));
		if ("1".equals(parameterService.findParamValue("5001", orgid))) {
			ticketprice.setMoreprice(handprice.getMoreprice());
		} else {
			ticketprice.setMoreprice(new BigDecimal(0));
		}
		
		ticketprice.setIssellable(true);
		ticketprice.setOrgid(orgid);
		ticketprice.setReachstationid(handprice.getReachstationid());
		if (scheduleplan.getIslinework()) {
			ticketprice.setSeatnum(seatnum);
		} else {
			String seats = handprice.getSeats();
			String seatlist[] = seats.split(",");
			short curseatnum = (short) seatlist.length;
			if ("0".equals(seats) || "全部".equals(seats)) {
				ticketprice.setSeatnum(seatnum);
			} else if (seatnum < curseatnum) {
				ticketprice.setSeatnum(seatnum);
			} else {
				ticketprice.setSeatnum(curseatnum);
			}
		}
		List<Schedulestop> reachstoplist = schedule.getSchedulestop();
		for (Schedulestop schedulestop : reachstoplist) {
			if (schedulestop.getStationid() == handprice.getReachstationid()) {
				ticketprice.setRuntime(schedulestop.getRuntime());
				
				ticketprice.setIssellable(schedulestop.isIssellable());
			}

		}
		ticketprice.setScheduleid(scheduleplan.getScheduleid());
		ticketprice.setScheduleplan(scheduleplan);
		ticketprice.setSeatnos(handprice.getSeats());
		ticketprice.setSeattype(handprice.getSeattype());
		ticketprice.setSoldeatnum(scheduleplan.getSoldeatnum());
		ticketprice.setUpdateby(createby);
		ticketprice.setUpdatetime(new Date());
		int departdistance = 0;
		int reacherdistance = 0;
		List<Routestop> routestoplist = schedule.getRoute().getRoutestops();
		for (Routestop routestop : routestoplist) {
			if (routestop.getStationid() == handprice.getReachstationid()) {
				reacherdistance = routestop.getDistance();
			}
			if (routestop.getStationid() == handprice.getDepartstationid()) {
				departdistance = routestop.getDistance();
			}
		}
		ticketprice.setBalancedistance(reacherdistance - departdistance);
		ticketprice.setDistance(reacherdistance - departdistance);
		ticketprice.setToplimitprice(handprice.getToplimitprice());
		ticketprice.setLowerlimitprice(handprice.getLowerlimitprice());
		ticketprice.setAutocancelreserveseatnum(scheduleplan
				.getAutocancelreserveseatnum());
		ticketprice.setUnautocancelreserveseatnum(scheduleplan
				.getUnautocancelreserveseatnum());
		ticketprice.setFixedreserveseatnum(scheduleplan
				.getFixedreserveseatnum());
		
		ticketprice.setStationservicefee(new BigDecimal(0));
		ticketprice.setFueladditionfee(new BigDecimal(0));
		return ticketprice;
	}
	private Ticketprice calTicketprice(Ticketprice tp) {
		BigDecimal fullprice = new BigDecimal(0);
		for (Ticketpriceitem ti : tp.getTicketpriceitemlist()) {
			if (ti.getTickettype().equals("Q")) {
				fullprice = fullprice.add(ti.getPrice());
			} else if (ti.getTickettype().equals("B")) {
				// halfprice = halfprice.add(ti.getPrice());
			} else if (ti.getTickettype().equals("X")) {
				// studentprice = studentprice.add(ti.getPrice());
			} else {
				// toplimitprice = toplimitprice.add(ti.getPrice());
			}
		}
		tp.setFullprice(fullprice);
		return tp;
	}
}
