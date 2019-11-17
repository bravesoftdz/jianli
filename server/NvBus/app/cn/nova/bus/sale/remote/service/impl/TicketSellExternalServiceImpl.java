/**
 * 
 */
package cn.nova.bus.sale.remote.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.persistence.LockModeType;
import javax.persistence.Query;

import util.TransactionUtil;
import cn.nova.bus.archive.model.Customer;
import cn.nova.bus.base.dao.ScheduleDao;
import cn.nova.bus.base.model.District;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Ticketoutlets;
import cn.nova.bus.base.service.TicketreturnrateService;
import cn.nova.bus.base.service.impl.TicketreturnrateServiceImpl;
import cn.nova.bus.bill.model.Billdamaged;
import cn.nova.bus.bill.model.Billinuse;
import cn.nova.bus.bill.model.Billinventory;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.BillinuseService;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BillinuseServiceImpl;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.sale.model.Ticketcancel;
import cn.nova.bus.sale.model.Ticketreturn;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.model.Ticketsellother;
import cn.nova.bus.sale.model.Ticketsign;
import cn.nova.bus.sale.model.Ticketturnoverdetail;
import cn.nova.bus.sale.remote.param.ParamAvailableTicketOut;
import cn.nova.bus.sale.remote.param.ParamBilldamageIn;
import cn.nova.bus.sale.remote.param.ParamCancelTicketIn;
import cn.nova.bus.sale.remote.param.ParamCancelTicketOut;
import cn.nova.bus.sale.remote.param.ParamCancelTicketsIn;
import cn.nova.bus.sale.remote.param.ParamCancelTicketsOut;
import cn.nova.bus.sale.remote.param.ParamDepartStationOut;
import cn.nova.bus.sale.remote.param.ParamDepartStationsOut;
import cn.nova.bus.sale.remote.param.ParamFindScheduleIn;
import cn.nova.bus.sale.remote.param.ParamFindSchedulesOut;
import cn.nova.bus.sale.remote.param.ParamLockSeatsIn;
import cn.nova.bus.sale.remote.param.ParamLockSeatsOut;
import cn.nova.bus.sale.remote.param.ParamPrintOut;
import cn.nova.bus.sale.remote.param.ParamPrintOutTemp;
import cn.nova.bus.sale.remote.param.ParamPrintOuts;
import cn.nova.bus.sale.remote.param.ParamQueryPrintTicket;
import cn.nova.bus.sale.remote.param.ParamQueryPrintTicketOut;
import cn.nova.bus.sale.remote.param.ParamQueryPrintTicketTemp;
import cn.nova.bus.sale.remote.param.ParamReturnTicketIn;
import cn.nova.bus.sale.remote.param.ParamReturnTicketOut;
import cn.nova.bus.sale.remote.param.ParamReturnTicketsIn;
import cn.nova.bus.sale.remote.param.ParamReturnTicketsOut;
import cn.nova.bus.sale.remote.param.ParamSellTicketIn;
import cn.nova.bus.sale.remote.param.ParamSellTicketsIn;
import cn.nova.bus.sale.remote.param.ParamSellTicketsOut;
import cn.nova.bus.sale.remote.param.ParamStationOut;
import cn.nova.bus.sale.remote.param.ParamStationsOut;
import cn.nova.bus.sale.remote.param.ParamTicketReturnQryOut;
import cn.nova.bus.sale.remote.param.ParamTicketReturnQrysOut;
import cn.nova.bus.sale.remote.param.ParamUnLockSeatOut;
import cn.nova.bus.sale.remote.service.TicketSellExternalService;
import cn.nova.bus.sale.service.BilldamagedService;
import cn.nova.bus.sale.service.TicketturnoverdetailService;
import cn.nova.bus.sale.service.impl.BilldamagedServiceImpl;
import cn.nova.bus.sale.service.impl.TicketturnoverdetailServiceImpl;
import cn.nova.bus.system.dao.UserinfoDao;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.service.OrganizationService;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.OrganizationServiceImpl;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;

/**
 * @author ice 该类提供给自助取票机使用\黄山、马鞍山邮政
 */
public class TicketSellExternalServiceImpl implements TicketSellExternalService {
	private static String TICKETBILLCODE = "Ticket";

	private cn.nova.bus.sale.service.TicketSellKernelService localSellService = new cn.nova.bus.sale.service.impl.TicketSellKernelServiceImpl();

	private IDAO dao = new EntityManagerDaoSurport();
	private BilldamagedService billdamagedService = new BilldamagedServiceImpl();

	private UserinfoDao userinfoDao = new UserinfoDao();

	private BilltypeService billtypeService = new BilltypeServiceImpl();

	private BillinuseService billinuseService = new BillinuseServiceImpl();

	private TicketreturnrateService ticketreturnrateService = new TicketreturnrateServiceImpl();

	private ParameterService parameterService = new ParameterServiceImpl();

	private TicketturnoverdetailService ticketturnoverdetailService = new TicketturnoverdetailServiceImpl();

	private ScheduleDao scheduleDao = new ScheduleDao();

	private OrganizationService organizationService = new OrganizationServiceImpl();

	@Override
	public ParamFindSchedulesOut findSchedule(
			ParamFindScheduleIn paramFindScheduleIn) {
		ParamFindSchedulesOut result = new ParamFindSchedulesOut();
		cn.nova.bus.sale.param.ParamFindScheduleIn localParamFindScheduleIn = new cn.nova.bus.sale.param.ParamFindScheduleIn(
				paramFindScheduleIn);
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		// localParamFindScheduleIn.setCustomerId(customerId);
		if (localParamFindScheduleIn.getSellway() == null
				|| localParamFindScheduleIn.getSellway().equals("")) {
			result.setResultMsg("售票方式不允许为空");
			return result;
		}
		if (localParamFindScheduleIn.getDepartDate() == null) {
			result.setResultMsg("发车日期不允许为空");
			return result;
		}
		System.out.println("findSchedule:" + paramFindScheduleIn.toString());
		if (localParamFindScheduleIn.getDepartDistrictCode() != null
				&& !localParamFindScheduleIn.getDepartDistrictCode().equals("")) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code",
					localParamFindScheduleIn.getDepartDistrictCode()));
			District district = (District) dao.uniqueResult(District.class,
					propertyFilters);
			localParamFindScheduleIn.setDepartDistrictId(district.getId());
		} else if (localParamFindScheduleIn.getDepartStationCode() != null
				&& !localParamFindScheduleIn.getDepartStationCode().equals("")) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code",
					localParamFindScheduleIn.getDepartStationCode()));
			Station station = (Station) dao.uniqueResult(Station.class,
					propertyFilters);
			localParamFindScheduleIn.setDepartStationId(station.getId());
		}
		Organization sellorg = null;
		if (localParamFindScheduleIn.getSellerCode() != null
				&& !localParamFindScheduleIn.getSellerCode().equals("")) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code",
					localParamFindScheduleIn.getSellerCode()));
			Userinfo seller = (Userinfo) dao.uniqueResult(Userinfo.class,
					propertyFilters);
			localParamFindScheduleIn.setSellerId(seller.getId());
			if (localParamFindScheduleIn.getSellOrgCode() != null
					&& !localParamFindScheduleIn.getSellOrgCode().equals("")) {
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!code",
						localParamFindScheduleIn.getSellOrgCode()));
				sellorg = (Organization) dao.uniqueResult(Organization.class,
						propertyFilters);
				localParamFindScheduleIn.setSellOrgID(sellorg.getId());
			} else if (seller.getId() != 0) {
				// 取售票人所属的组织机构
				sellorg = (Organization) dao.get(Organization.class,
						seller.getOrgid());
				localParamFindScheduleIn.setSellOrgCode(sellorg.getCode());
				localParamFindScheduleIn.setSellOrgID(sellorg.getId());
			} else {
				result.setResultMsg("售票机构不允许为空");
				return result;
			}
		} else {
			result.setResultMsg("售票人不允许为空");
			return result;
		}
		if (localParamFindScheduleIn.getReachStationCode() != null
				&& !localParamFindScheduleIn.getReachStationCode().equals("")) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code",
					localParamFindScheduleIn.getReachStationCode()));
			Station station = (Station) dao.uniqueResult(Station.class,
					propertyFilters);
			if (station == null) {
				result.setResultMsg("到达站编码"
						+ localParamFindScheduleIn.getReachStationCode()
						+ "不存在");
				return result;
			}
			localParamFindScheduleIn.setReachStationId(station.getId());
		} else if (localParamFindScheduleIn.getScheduleCode() != null
				&& !localParamFindScheduleIn.getScheduleCode().equals("")) {
			Schedule schedule = scheduleDao.getScheduleByCode(
					localParamFindScheduleIn.getScheduleCode(),
					sellorg.getId(), paramFindScheduleIn.getDepartDate());
			if (schedule == null) {
				result.setResultMsg("班次编码"
						+ localParamFindScheduleIn.getScheduleCode() + "不存在");
				return result;
			}
			localParamFindScheduleIn.setScheduleId(schedule.getId());
		} else {
			result.setResultMsg("到达站与班次不允许同时为空");
			return result;
		}
		// if(localParamFindScheduleIn.getSellIp()==null||localParamFindScheduleIn.getSellIp().equals("")){
		// result.setResultMsg("售票IP不允许为空");
		// return result;
		// }
		if (localParamFindScheduleIn.getTicketoutletsCode() != null
				&& !localParamFindScheduleIn.getTicketoutletsCode().equals("")) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code",
					localParamFindScheduleIn.getTicketoutletsCode()));
			Ticketoutlets ticketoutlets = (Ticketoutlets) dao.uniqueResult(
					Ticketoutlets.class, propertyFilters);
			localParamFindScheduleIn.setTicketoutletsId(ticketoutlets.getId());
		} else {
			localParamFindScheduleIn.setTicketoutletsId(0L);
		}
		return localSellService.findSchedule(localParamFindScheduleIn);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * cn.nova.bus.sale.remote.service.TicketSellKernelService#lockSeat(cn.nova
	 * .bus.sale.remote.param.ParamLockSeatsIn)
	 */
	@Override
	public ParamLockSeatsOut lockSeat(ParamLockSeatsIn paramLockSeatsIn) {
		ParamLockSeatsOut result = new ParamLockSeatsOut();
		cn.nova.bus.sale.param.ParamLockSeatsIn localParamLockSeatsIn = null;
		try {
			localParamLockSeatsIn = new cn.nova.bus.sale.param.ParamLockSeatsIn(
					paramLockSeatsIn);
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();

			if (localParamLockSeatsIn.getDepartDate() == null) {
				result.setResultMsg("发车日期不允许为空");
				return result;
			}
			if (localParamLockSeatsIn.getSellway() == null
					|| localParamLockSeatsIn.getSellway().equals("")) {
				result.setResultMsg("售票方式不允许为空");
				return result;
			}
			if (localParamLockSeatsIn.getOrderno() == null
					|| localParamLockSeatsIn.getOrderno().equals("")) {
				result.setResultMsg("订单号不允许为空");
				return result;
			}
			System.out.println("lockSeat:" + paramLockSeatsIn.toString());
			if (localParamLockSeatsIn.getDepartStationCode() != null
					&& !localParamLockSeatsIn.getDepartStationCode().equals("")) {
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!code",
						localParamLockSeatsIn.getDepartStationCode()));
				Station station = (Station) dao.uniqueResult(Station.class,
						propertyFilters);
				localParamLockSeatsIn.setDepartStationId(station.getId());
			} else {
				result.setResultMsg("发车站编码不允许为空");
				return result;
			}
			if (localParamLockSeatsIn.getReachStationCode() != null
					&& !localParamLockSeatsIn.getReachStationCode().equals("")) {
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!code",
						localParamLockSeatsIn.getReachStationCode()));
				Station station = (Station) dao.uniqueResult(Station.class,
						propertyFilters);
				localParamLockSeatsIn.setReachStationId(station.getId());
			}
			Schedule schedule = null;
			if (localParamLockSeatsIn.getScheduleCode() != null
					&& !localParamLockSeatsIn.getScheduleCode().equals("")) {
				Organization org_depart = organizationService
						.getOrgByStationCode(localParamLockSeatsIn
								.getDepartStationCode());
				schedule = scheduleDao.getScheduleByCode(
						localParamLockSeatsIn.getScheduleCode(),
						org_depart.getId(), paramLockSeatsIn.getDepartDate());
			} else if (localParamLockSeatsIn.getScheduleSyncCode() != null
					&& !localParamLockSeatsIn.getScheduleSyncCode().equals("")) {
				schedule = scheduleDao
						.getScheduleBySyncCode(localParamLockSeatsIn
								.getScheduleSyncCode());
			} else {
				result.setResultMsg("班次编码与班次同步编码不允许同时为空");
				return result;
			}
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQD_t!departdate",
					localParamLockSeatsIn.getDepartDate()));
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleid", schedule
					.getId()));
			Scheduleplan scheduleplan = (Scheduleplan) dao.uniqueResult(
					Scheduleplan.class, propertyFilters);
			if (scheduleplan == null) {
				result.setResultMsg("找不到班次计划");
				return result;
			}
			localParamLockSeatsIn.setScheduleplanId(scheduleplan.getId());
			if (localParamLockSeatsIn.getSellerCode() != null
					&& !localParamLockSeatsIn.getSellerCode().equals("")) {
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!code",
						localParamLockSeatsIn.getSellerCode()));
				Userinfo seller = (Userinfo) dao.uniqueResult(Userinfo.class,
						propertyFilters);
				localParamLockSeatsIn.setSellerId(seller.getId());
				if (localParamLockSeatsIn.getSellOrgCode() != null
						&& !localParamLockSeatsIn.getSellOrgCode().equals("")) {
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQS_t!code",
							localParamLockSeatsIn.getSellOrgCode()));
					Organization sellorg = (Organization) dao.uniqueResult(
							Organization.class, propertyFilters);
					localParamLockSeatsIn.setSellOrgId(sellorg.getId());
				} else if (seller.getId() != 0) {
					// 取售票人所属的组织机构
					Organization sellorg = (Organization) dao.get(
							Organization.class, seller.getOrgid());
					localParamLockSeatsIn.setSellOrgCode(sellorg.getCode());
					localParamLockSeatsIn.setSellOrgId(sellorg.getId());
				} else {
					result.setResultMsg("售票机构不允许为空");
					return result;
				}
			} else {
				result.setResultMsg("售票人不允许为空");
				return result;
			}
			// if(localParamLockSeatsIn.getSellIp()==null||localParamLockSeatsIn.getSellIp().equals("")){
			// result.setResultMsg("售票IP不允许为空");
			// return result;
			// }
			if (localParamLockSeatsIn.getTicketoutletsCode() != null
					&& !localParamLockSeatsIn.getTicketoutletsCode().equals("")) {
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!code",
						localParamLockSeatsIn.getTicketoutletsCode()));
				Ticketoutlets ticketoutlets = (Ticketoutlets) dao.uniqueResult(
						Ticketoutlets.class, propertyFilters);
				localParamLockSeatsIn.setTicketoutletsid(ticketoutlets.getId());
			} else {
				localParamLockSeatsIn.setTicketoutletsid(0L);
			}
			if (localParamLockSeatsIn.getSelectSeatStatus() == null
					|| localParamLockSeatsIn.getSelectSeatStatus().size() == 0) {
				result.setResultMsg("可选座位状态 不允许为空");
				return result;
			}
			try {
				return localSellService.lockSeat(localParamLockSeatsIn);
			} catch (ServiceException e) {
				TransactionUtil.setRollbackOnly();
				result.setResultMsg(e.toString());
				return result;
			}
		} catch (CloneNotSupportedException e) {
			TransactionUtil.setRollbackOnly();
			result.setResultMsg(e.toString());
			return result;
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * cn.nova.bus.sale.remote.service.TicketSellKernelService#unlockSeat(java
	 * .lang.String)
	 */
	@Override
	public ParamUnLockSeatOut unlockSeat(String orderno) {
		return localSellService.unlockSeat(orderno);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * cn.nova.bus.sale.service.remote.TicketSellKernelService#sellTicket(cn
	 * .nova.bus.sale.remote.param.ParamSellTicketsIn)
	 */
	@Override
	public ParamSellTicketsOut sellTicket(ParamSellTicketsIn order) throws Exception {
		cn.nova.bus.sale.param.ParamSellTicketsIn localParamSellTicketsIn = new cn.nova.bus.sale.param.ParamSellTicketsIn(
				order);
		ParamSellTicketsOut result = new ParamSellTicketsOut();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();

		if (localParamSellTicketsIn.getSellway() == null
				|| localParamSellTicketsIn.getSellway().equals("")) {
			result.setResultMsg("售票方式不允许为空");
			return result;
		}
		if (localParamSellTicketsIn.getOrderno() == null
				|| localParamSellTicketsIn.getOrderno().equals("")) {
			result.setResultMsg("订单号不允许为空");
			return result;
		}
		if (localParamSellTicketsIn.getPaymethod() == null
				|| localParamSellTicketsIn.getPaymethod().equals("")) {
			result.setResultMsg("支付方式不允许为空");
			return result;
		}
		if (localParamSellTicketsIn.getStartTicketNO() == null
				|| localParamSellTicketsIn.getStartTicketNO().equals("")) {
			result.setResultMsg("当前票号不允许为空");
			return result;
		}
		System.out.println("sellTicket:" + order.toString());
		if (localParamSellTicketsIn.getSellerCode() != null
				&& !localParamSellTicketsIn.getSellerCode().equals("")) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code",
					localParamSellTicketsIn.getSellerCode()));
			Userinfo seller = (Userinfo) dao.uniqueResult(Userinfo.class,
					propertyFilters);
			localParamSellTicketsIn.setSellerId(seller.getId());
			if (localParamSellTicketsIn.getSellOrgCode() != null
					&& !localParamSellTicketsIn.getSellOrgCode().equals("")) {
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!code",
						localParamSellTicketsIn.getSellOrgCode()));
				Organization sellorg = (Organization) dao.uniqueResult(
						Organization.class, propertyFilters);
				localParamSellTicketsIn.setSellOrgId(sellorg.getId());
			} else if (seller.getId() != 0) {
				// 取售票人所属的组织机构
				Organization sellorg = (Organization) dao.get(
						Organization.class, seller.getOrgid());
				localParamSellTicketsIn.setSellOrgCode(sellorg.getCode());
				localParamSellTicketsIn.setSellOrgId(sellorg.getId());
			} else {
				result.setResultMsg("售票机构不允许为空");
				return result;
			}
		} else {
			result.setResultMsg("售票人不允许为空");
			return result;
		}
		// if(localParamSellTicketsIn.getSellIp()==null||localParamSellTicketsIn.getSellIp().equals("")){
		// result.setResultMsg("售票IP不允许为空");
		// return result;
		// }
		if (localParamSellTicketsIn.getTicketoutletsCode() != null
				&& !localParamSellTicketsIn.getTicketoutletsCode().equals("")) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code",
					localParamSellTicketsIn.getTicketoutletsCode()));
			Ticketoutlets ticketoutlets = (Ticketoutlets) dao.uniqueResult(
					Ticketoutlets.class, propertyFilters);
			localParamSellTicketsIn.setTicketoutletsid(ticketoutlets.getId());
		} else {
			localParamSellTicketsIn.setTicketoutletsid(0L);
		}
		for (ParamSellTicketIn _paramSellTicketIn : localParamSellTicketsIn
				.getSellseats()) {
			cn.nova.bus.sale.param.ParamSellTicketIn paramSellTicketIn = (cn.nova.bus.sale.param.ParamSellTicketIn) _paramSellTicketIn;
			if (paramSellTicketIn.getServicefee() == null) {
				paramSellTicketIn.setServicefee(new BigDecimal(0));
			}
			if (paramSellTicketIn.getDepartDate() == null) {
				result.setResultMsg("发车日期不允许为空");
				return result;
			}
			if (paramSellTicketIn.getSeattypeCode() == null
					|| paramSellTicketIn.getSeattypeCode().equals("")) {
				result.setResultMsg("座位类型不允许为空");
				return result;
			}
			if (paramSellTicketIn.getTickettypeCode() == null
					|| paramSellTicketIn.getTickettypeCode().equals("")) {
				result.setResultMsg("车票类型不允许为空");
				return result;
			}
			Station departStation = null;
			if (paramSellTicketIn.getDepartStationCode() != null
					&& !paramSellTicketIn.getDepartStationCode().equals("")) {
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!code",
						paramSellTicketIn.getDepartStationCode()));
				departStation = (Station) dao.uniqueResult(Station.class,
						propertyFilters);
			} else {
				result.setResultMsg("发车站编码不允许为空");
				return result;
			}
			Station reachStation = null;
			if (paramSellTicketIn.getReachStationCode() != null
					&& !paramSellTicketIn.getReachStationCode().equals("")) {
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!code",
						paramSellTicketIn.getReachStationCode()));
				reachStation = (Station) dao.uniqueResult(Station.class,
						propertyFilters);
			}
			Schedule schedule = null;
			if (paramSellTicketIn.getSchedulecode() != null
					&& !paramSellTicketIn.getSchedulecode().equals("")) {
				Organization org_depart = organizationService
						.getOrgByStationCode(paramSellTicketIn
								.getDepartStationCode());
				schedule = scheduleDao.getScheduleByCode(
						paramSellTicketIn.getSchedulecode(),
						org_depart.getId(), paramSellTicketIn.getDepartDate());
			} else if (paramSellTicketIn.getSchedulesynccode() != null
					&& !paramSellTicketIn.getSchedulesynccode().equals("")) {
				schedule = scheduleDao.getScheduleBySyncCode(paramSellTicketIn
						.getSchedulesynccode());
			} else {
				result.setResultMsg("班次编码与班次同步编码不允许同时为空");
				return result;
			}

			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQD_t!departdate",
					paramSellTicketIn.getDepartDate()));
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleid", schedule
					.getId()));
			propertyFilters.add(new PropertyFilter("EQL_t!departstationid",
					departStation.getId()));
			propertyFilters.add(new PropertyFilter("EQL_t!reachstationid",
					reachStation.getId()));
			propertyFilters.add(new PropertyFilter("EQS_t!seattype",
					paramSellTicketIn.getSeattypeCode()));
			Ticketprice ticketprice = (Ticketprice) dao.uniqueResult(
					Ticketprice.class, propertyFilters);
			if (ticketprice == null) {
				result.setResultMsg("找不到班次计划");
				return result;
			}
			if (paramSellTicketIn.getPrice() == null) {
				switch (paramSellTicketIn.getTickettypeCode().charAt(0)) {
				case 'Q':
					paramSellTicketIn.setPrice(ticketprice.getFullprice());
					break;
				case 'B':
					paramSellTicketIn.setPrice(ticketprice.getHalfprice());
					break;
				case 'X':
					paramSellTicketIn.setPrice(ticketprice.getStudentprice());
					break;
				default:
					result.setResultMsg("没有传入票价且车票类型未知");
					return result;
				}
			}
			paramSellTicketIn.setTicketpriceId(ticketprice.getId());
			if (paramSellTicketIn.getCertificateno() != null
					&& !paramSellTicketIn.getCertificateno().equals("")
					&& paramSellTicketIn.getCertificatetype() != null
					&& !paramSellTicketIn.getCertificatetype().equals("")) {
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!certificateno",
						paramSellTicketIn.getCertificateno()));
				propertyFilters.add(new PropertyFilter("EQS_t!certificatetype",
						paramSellTicketIn.getCertificatetype()));
				propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
				Customer customer = (Customer) dao.uniqueResult(Customer.class,
						propertyFilters);
				if (customer != null) {
					paramSellTicketIn.setCustomerid(customer.getId());
				}
			}
		}
		try {
			return localSellService.sellTicket(localParamSellTicketsIn);
		} catch (ServiceException e) {
			TransactionUtil.setRollbackOnly();
			result.setResultMsg(e.getExceptionMessage());
			return result;
		} catch (Exception e) {
			TransactionUtil.setRollbackOnly();
			result.setResultMsg(e.getMessage());
			return result;
		}
	}

	@Override
	public ParamSellTicketsOut ticketRePrintAndChangeTicketNo(
			String oldTicketno, String curTicketNo, String usercode,
			String ticketoutletscode, String ip) {
		ParamSellTicketsOut result = new ParamSellTicketsOut();
		long ticketsellid = 0;
		long userid = 0;
		long ticketoutletsid = 0;
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();

		if (oldTicketno == null || oldTicketno.trim().equals("")) {
			result.setResultMsg("原车票票号不允许为空");
			return result;
		} else {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!ticketno",
					oldTicketno));
			propertyFilters.add(new PropertyFilter("GED_t!departdate",
					DateUtils.trunc(new Date())));
			Ticketsell ticketsell = (Ticketsell) dao.uniqueResult(
					Ticketsell.class, propertyFilters);
			if (ticketsell == null) {
				result.setResultMsg("原车票票号不存在或已经被重打");
				return result;
			}
			ticketsellid = ticketsell.getId();
		}
		if (curTicketNo == null || curTicketNo.trim().equals("")) {
			result.setResultMsg("当前票号不允许为空");
			return result;
		}
		if (usercode != null && !usercode.trim().equals("")) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code", usercode));
			Userinfo seller = (Userinfo) dao.uniqueResult(Userinfo.class,
					propertyFilters);
			userid = seller.getId();
		} else {
			result.setResultMsg("售票人不允许为空");
			return result;
		}
		if (ticketoutletscode != null && !ticketoutletscode.trim().equals("")) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code",
					ticketoutletscode));
			Ticketoutlets ticketoutlets = (Ticketoutlets) dao.uniqueResult(
					Ticketoutlets.class, propertyFilters);
			ticketoutletsid = ticketoutlets.getId();
		}
		try {
			return localSellService.ticketRePrintAndChangeTicketNo(
					ticketsellid, curTicketNo, userid, ticketoutletsid, ip);
		} catch (ServiceException e) {
			TransactionUtil.setRollbackOnly();
			result.setResultMsg(e.getExceptionMessage());
			return result;
		}
	}

	private static final String GET_ALLDEPARTSTATIONS_SQL = "select station.code as stationcode," // organization.code
			+ "       organization.name as stationname,"
			+ "       district.code as city,"
			+ "       district.name as cityname,"
			+ "       district2.code as province,"
			+ "       district2.name as provincename,"
			+ "       organization.updatetime as updatetime,"
			+ "       organization.address as address"
			+ "  from organization"
			+ "       join station on station.id=organization.stationid"
			+ "  left join district"
			+ "    on station.districtid = district.id"
			+ "  left join district district2"
			+ "    on district2.code = substr(district.code, 0, 2) || '000000000'"
			+ " where organization.isactive=1 and organization.islocal=1 and organization.type=2 and"
			+ " ((organization.updatetime >= :lastUpdatetime) or (organization.createtime>=:lastUpdatetime)) ";

	@Override
	public ParamDepartStationsOut GetAllDepartStation(Date lastUpdateTime) {
		ParamDepartStationsOut result = new ParamDepartStationsOut();
		if (null != lastUpdateTime) {
			try {
				Query query = getDao().getEntityManager().createNativeQuery(
						GET_ALLDEPARTSTATIONS_SQL, ParamDepartStationOut.class);
				query.setParameter("lastUpdatetime", lastUpdateTime);
				List<ParamDepartStationOut> list = query.getResultList();
				result.setDepartstations(list);
			} catch (Exception e) {
				TransactionUtil.setRollbackOnly();
				result.setResultMsg(e.toString());
				return result;
			}
		}
		result.setResult(MethodResult.SUCCESS);
		return result;
	}

	private static final String GET_ALLSTATION_SQL = "select station.code as stationcode,"
			+ "       station.name as stationname,"
			+ "       district.code as city,"
			+ "       station.jianpin as jianpin,"
			+ "       district.name as cityname,"
			+ "       district2.code as province,"
			+ "       district2.name as provincename,"
			+ "       station.updatetime as updatetime"
			+ "  from station"
			+ "  left join district"
			+ "    on station.districtid = district.id"
			+ "  left join district district2"
			+ "    on district2.code = substr(district.code, 0, 2) || '000000000'"
			+ " where station.isactive=1 "
			+ "   and ((station.updatetime >= :lastUpdatetime ) or (station.createtime>=:lastUpdatetime )) "
			+ "   And station.Id In (Select rs.stationid From Routestop rs)"
			+ "   And station.Id not In (select t.stationid  from Organization t where t.islocal=1)";

	@Override
	public ParamStationsOut GetAllStation(Date lastUpdateTime) {
		ParamStationsOut result = new ParamStationsOut();
		if (null != lastUpdateTime) {
			try {
				Query query = getDao().getEntityManager().createNativeQuery(
						GET_ALLSTATION_SQL, ParamStationOut.class);
				query.setParameter("lastUpdatetime", lastUpdateTime);
				List<ParamStationOut> list = query.getResultList();
				result.setWsstations(list);
			} catch (Exception e) {
				TransactionUtil.setRollbackOnly();
				result.setResultMsg(e.toString());
				return result;
			}
		}
		result.setResult(MethodResult.SUCCESS);
		return result;
	}

	@Override
	public ParamAvailableTicketOut GetAvailableTicket(String usercode,
			String curTicketNo) {
		ParamAvailableTicketOut result = new ParamAvailableTicketOut();
		try {
			// 取出票据类型id及长度
			Billinuse billinuse = new Billinuse();
			Billtype billtype = getBilltypeService().findByCode(TICKETBILLCODE);
			billinuse.setBilltypeid(billtype.getId());
			Userinfo userinfo = getUserinfoDao().getByCode(usercode);
			if (userinfo == null) {
				result.setResultMsg("找不到用户:" + usercode);
				return result;
			}
			billinuse.setRecipients(userinfo.getId());
			if (curTicketNo != null && !curTicketNo.trim().equals("")) {
				billinuse.setNextno(new Long(curTicketNo));
			}
			MethodResult methodResult = billinuseService.initBillNo(billinuse);
			if (methodResult.getObject() != null) {
				billinuse = (Billinuse) methodResult.getObject();
				Billinventory billinventory = (Billinventory) dao.get(
						Billinventory.class, billinuse.getBillinventoryid());
				result.setBatchno(billinventory.getBatchno());
				result.setCurticketno(StringUtils.strPad(
						new Long(billinuse.getNextno()).toString(),
						(int) billtype.getTicketnolength(), "0"));
				result.setEndticketno(StringUtils.strPad(
						new Long(billinuse.getEndno()).toString(),
						(int) billtype.getTicketnolength(), "0"));
			} else {
				result.setResultMsg("用户:" + usercode + "没有领票记录");
				return result;
			}
		} catch (Exception e) {
			TransactionUtil.setRollbackOnly();
			result.setResultMsg(e.toString());
			return result;
		}
		result.setResult(MethodResult.SUCCESS);
		return result;
	}

	@Override
	public MethodResult billdamage(ParamBilldamageIn paramBilldamageIn) {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		MethodResult result = new MethodResult();
		if (paramBilldamageIn.getDamagednum() <= 0) {
			result.setResultMsg("坏票登记数必须大于零");
			return result;
		}
		Date now = new Date();
		try {
			Billinuse billinuse = new Billinuse();
			Userinfo recipientUser = getUserinfoDao().getByCode(
					paramBilldamageIn.getUsercode());
			if (recipientUser == null) {
				result.setResultMsg("找不到用户:" + paramBilldamageIn.getUsercode());
				return result;
			}
			billinuse.setRecipients(recipientUser.getId());
			Userinfo opUser = getUserinfoDao().getByCode(
					paramBilldamageIn.getOpusercode());
			if (opUser == null) {
				result.setResultMsg("找不到用户:"
						+ paramBilldamageIn.getOpusercode());
				return result;
			}
			if (paramBilldamageIn.getCurticketno() != null
					&& !paramBilldamageIn.getCurticketno().trim().equals("")) {
				billinuse
						.setNextno(new Long(paramBilldamageIn.getCurticketno()));
			} else {
				result.setResultMsg("当前票号不允许为空");
				return result;
			}
			// 取出票据类型id及长度
			Billtype billtype = getBilltypeService().findByCode(TICKETBILLCODE);
			billinuse.setBilltypeid(billtype.getId());
			MethodResult methodResult = getBillinuseService().initBillNo(
					billinuse);
			if (methodResult.getObject() != null) {
				billinuse = (Billinuse) methodResult.getObject();
				if (new Long(paramBilldamageIn.getCurticketno()) != billinuse
						.getNextno()) {
					result.setResultMsg("输入的当前票号错误，当前票号为："
							+ StringUtils.strPad(
									new Long(billinuse.getNextno()).toString(),
									(int) billtype.getTicketnolength(), "0"));
					return result;
				}
				if (paramBilldamageIn.getDamagednum() > billinuse.getEndno()
						- billinuse.getNextno() + 1) {
					result.setResultMsg("该票段只剩"
							+ new Long(billinuse.getEndno()
									- billinuse.getNextno() + 1)
							+ "张票，小于您要登记的张数"
							+ paramBilldamageIn.getDamagednum());
					return result;
				}
				Billdamaged billdamaged = new Billdamaged();
				billdamaged.setId(0);
				billdamaged.setAmount(paramBilldamageIn.getDamagednum());
				billdamaged.setBillinuseid(billinuse.getId());
				billdamaged.setBilltypeid(billtype.getId());
				billdamaged.setCreateby(opUser.getId());
				billdamaged.setCreatetime(now);
				billdamaged.setDamageddscribe(paramBilldamageIn.getReason());
				billdamaged.setEndno(billinuse.getNextno()
						+ paramBilldamageIn.getDamagednum() - 1);
				billdamaged.setRecordby(opUser.getId());
				if (paramBilldamageIn.getIp() == null
						|| paramBilldamageIn.getIp().equals("")) {
					billdamaged.setRecordip("127.0.0.1");
				} else {
					billdamaged.setRecordip(paramBilldamageIn.getIp());
				}
				billdamaged.setRecordtime(now);
				billdamaged.setStartno(billinuse.getNextno());
				if (paramBilldamageIn.getTicketoutletsCode() != null
						&& !paramBilldamageIn.getTicketoutletsCode().equals("")) {
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQS_t!code",
							paramBilldamageIn.getTicketoutletsCode()));
					Ticketoutlets ticketoutlets = (Ticketoutlets) dao
							.uniqueResult(Ticketoutlets.class, propertyFilters);
					billdamaged.setTicketoutletsid(ticketoutlets.getId());
				} else {
					billdamaged.setTicketoutletsid(0L);
				}
				billdamaged.setUpdateby(opUser.getId());
				billdamaged.setUpdatetime(now);
				getBilldamagedService()
						.save(billdamaged, recipientUser.getId());
			} else {
				result.setResultMsg("用户:" + paramBilldamageIn.getUsercode()
						+ "没有领票记录");
				return result;
			}
		} catch (Exception e) {
			//getContext().setRollbackOnly();
			result.setResultMsg(e.toString());
			return result;
		}
		result.setResult(MethodResult.SUCCESS);
		return result;
	}

	@Override
	//@TransactionAttribute(TransactionAttributeType.NOT_SUPPORTED)
	public ParamTicketReturnQrysOut ticketRetrunQry(String orderno,
			List<String> ticketnos) {
		ParamTicketReturnQrysOut result = new ParamTicketReturnQrysOut();
		result = ticketCancelQry(orderno, ticketnos);
		if (result.getParamTicketReturnQryOut() != null) {
			for (ParamTicketReturnQryOut paramTicketReturnQryOut : result
					.getParamTicketReturnQryOut()) {
				if (paramTicketReturnQryOut.getCharges() == null) {
					paramTicketReturnQryOut.setRate(getReturnRate(
							paramTicketReturnQryOut.getDepartdate(),
							paramTicketReturnQryOut.getDeparttime(), 0));
					paramTicketReturnQryOut.setCharges(paramTicketReturnQryOut
							.getTicketprice().multiply(
									paramTicketReturnQryOut.getRate()));
				} else {
					paramTicketReturnQryOut.setRate(paramTicketReturnQryOut
							.getCharges().divide(
									paramTicketReturnQryOut.getTicketprice()));
				}
			}
		}
		return result;
	}

	@Override
	public ParamTicketReturnQrysOut ticketCancelQry(String orderno,
			List<String> ticketnos) {
		ParamTicketReturnQrysOut result = new ParamTicketReturnQrysOut();
		if (orderno == null || orderno.equals("")) {
			result.setResultMsg("订单号不允许为空");
			return result;
		}
		if (ticketnos == null || ticketnos.size() == 0) {
			result.setResultMsg("订单号不允许为空");
			return result;
		}

		StringBuilder sql = new StringBuilder();
		sql.append("select ")
				.append(" tsl.id,tsl.departdate,trim(tsl.departtime) as departtime,tsl.fullprice,")
				.append(" tsl.ischecked,tsl.isdepartinvoices,tsl.islinework,tsl.paymethod,")
				.append(" tsl.price as ticketprice,tsl.servicefee,tsl.seatno,tsl.sellby,usell.name as sellbyname,tsl.selltime,")
				.append(" tsl.ticketno,tsl.sellway,tsl.ticketstatus,tsl.tickettype,tsl.seattype,")
				.append(" tsl.departstationid,tsl.reachstationid,tsl.carrychildnum,")
				.append(" tsg.charges, tsg.signreason,tsg.signtime,")
				.append(" sc.code as schedulecode,")
				.append(" std.name as departstationname,")
				.append(" str.name as reachstationname,ss.status,tot.code as ticketoutletscode,tot.name as ticketoutletsidname")
				.append(" ,tsl.orderno, null as rate")

				.append(" from Ticketsell tsl left join Ticketsign tsg")
				.append(" on tsl.id=tsg.sellid and tsg.isselfschedule=1")
				.append(" ,Schedule sc,Station std,Station str,Schedulestatus ss ,Userinfo usell,Ticketoutlets tot")
				.append(" where tsl.scheduleid=sc.id")
				.append(" and tsl.departstationid=std.id")
				.append(" and tsl.departdate>=:departdate_begin")
				.append(" and tsl.reachstationid=str.id")
				.append(" and tsl.departstationid=ss.departstationid")
				.append(" and tsl.scheduleplanid=ss.scheduleplanid")
				.append(" and tsl.sellby=usell.id")
				.append(" and tsl.orderno='").append(orderno).append("'")
				.append(" and tsl.ticketoutletsid=tot.id");
		sql.append(" and (");
		int i = 0;
		for (String ticketno : ticketnos) {
			if (i == 0) {
				sql.append(" tsl.ticketno='").append(ticketno).append("'");
			} else {
				sql.append(" or tsl.ticketno='").append(ticketno).append("'");
			}
			i++;
		}
		sql.append(" )");
		sql.append(" order by tsl.ticketno");

		Query query = dao.getEntityManager().createNativeQuery(sql.toString(),
				ParamTicketReturnQryOut.class);
		// 几个月后，车票号就会重复。加上发车日期条件
		query.setParameter("departdate_begin", DateUtils.add(
				DateUtils.trunc(new Date()), Calendar.DAY_OF_MONTH, -7));
		result.setParamTicketReturnQryOut(query.getResultList());
		result.setResult(MethodResult.SUCCESS);
		return result;
	}

	private BigDecimal getReturnRate(Date departdate, String departtime,
			long orgid) {
		Date departdatetime = DateUtils.mergerDateAndTime(departdate,
				departtime);
		Date now = new Date();
		/*long hoursbetweendeparttime = (departdatetime.getTime() - now.getTime()) % 1000 % 60 % 60;
		if (hoursbetweendeparttime < 0) {
			hoursbetweendeparttime--;
		}*/
		BigDecimal hoursbetweendeparttime=new BigDecimal(0);
		hoursbetweendeparttime=(new BigDecimal(departdatetime.getTime()-now.getTime())).
		divide(new BigDecimal(1000)).divide(
		new BigDecimal(60),BigDecimal.ROUND_UP).divide(
				new BigDecimal(60),BigDecimal.ROUND_UP);
		return getTicketreturnrateService().getticketreturnrate(orgid,
				hoursbetweendeparttime);
	}

	@Override
	public ParamReturnTicketsOut returnticket(
			ParamReturnTicketsIn paramReturnTicketsIn) {
		ParamReturnTicketsOut result = new ParamReturnTicketsOut();
		int printreturnnum = 0;
		BigDecimal totalreturnhandcharge = new BigDecimal(0);
		BigDecimal totalreturnmoney = new BigDecimal(0);
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		if (paramReturnTicketsIn.getReturnUserCode() == null
				|| paramReturnTicketsIn.getReturnUserCode().equals("")) {
			result.setResult(MethodResult.FAILURE);
			result.setResultMsg("退票人编码不允许为空");
			return result;
		}
		Userinfo returnuser = null;
		Organization reutrnorg = null;
		if (paramReturnTicketsIn.getReturnUserCode() != null
				&& !paramReturnTicketsIn.getReturnUserCode().equals("")) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code",
					paramReturnTicketsIn.getReturnUserCode()));
			returnuser = (Userinfo) dao.uniqueResult(Userinfo.class,
					propertyFilters);
			if (paramReturnTicketsIn.getReturnOrgCode() != null
					&& !paramReturnTicketsIn.getReturnOrgCode().equals("")) {
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!code",
						paramReturnTicketsIn.getReturnOrgCode()));
				Organization sellorg = (Organization) dao.uniqueResult(
						Organization.class, propertyFilters);
			} else if (returnuser.getId() != 0) {
				// 取售票人所属的组织机构
				reutrnorg = (Organization) dao.get(Organization.class,
						returnuser.getOrgid());
				paramReturnTicketsIn.setReturnOrgCode(reutrnorg.getCode());
			} else {
				result.setResultMsg("退票机构编码不允许为空");
				return result;
			}
		} else {
			result.setResultMsg("退票人编码不允许为空");
			return result;
		}
		Date now = new Date();
		// 插入或修改应缴款表
		Billtype billtype = null;
		Billinuse billinuse = null;
		Billinventory billinventory = null;
		Schedule schedule = null;
		Ticketturnoverdetail ticketturnoverdetail = null;
		if (!paramReturnTicketsIn.getBillCustomManage()) {
			ticketturnoverdetail = getTicketturnoverdetailService()
					.getCurTicketturnoverdetail(returnuser.getId(),
							paramReturnTicketsIn.getReturnPrintStartNo());
		}
		List<Ticketreturn> ticketreturns = new ArrayList<Ticketreturn>();
		Ticketoutlets ticketoutlets = null;
		if (paramReturnTicketsIn.getTicketoutletsCode() != null
				&& !paramReturnTicketsIn.getTicketoutletsCode().equals("")) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code",
					paramReturnTicketsIn.getTicketoutletsCode()));
			ticketoutlets = (Ticketoutlets) dao.uniqueResult(
					Ticketoutlets.class, propertyFilters);
		}
		result.setReturnTickets(new ArrayList<ParamReturnTicketOut>());
		// 退票
		long voucherno = 0;
		if (paramReturnTicketsIn.getReturnPrintStartNo() != null
				&& !"0".equals(paramReturnTicketsIn.getReturnPrintStartNo())) {
			voucherno = new Long(paramReturnTicketsIn.getReturnPrintStartNo());
		}
		for (ParamReturnTicketIn paramReturnTicketIn : paramReturnTicketsIn
				.getReturnTickets()) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("GED_t!departdate",
					DateUtils.add(DateUtils.trunc(now), -30)));
			propertyFilters.add(new PropertyFilter("EQS_t!ticketno",
					paramReturnTicketIn.getTicketno()));
			propertyFilters.add(new PropertyFilter("EQS_t!orderno",
					paramReturnTicketIn.getOrderno()));
			Ticketsell ticketsell = (Ticketsell) dao.uniqueResult(
					Ticketsell.class, propertyFilters);
			if (ticketsell == null) {
				result.setResult(MethodResult.FAILURE);
				result.setResultMsg("找不到订单号为"
						+ paramReturnTicketIn.getOrderno() + "，票号为"
						+ paramReturnTicketIn.getTicketno() + "的车票");
				return result;
			} else if ("1".equals(ticketsell.getTicketstatus())) {
				ServiceException e = new ServiceException("0176");
				result.setResult(new Integer(e.getExceptionCode()));
				result.setResultMsg(e.getExceptionMessage());
				return result;
			} else if ("2".equals(ticketsell.getTicketstatus())) {
				ServiceException e = new ServiceException("0177");
				result.setResult(new Integer(e.getExceptionCode()));
				result.setResultMsg(e.getExceptionMessage());
				return result;
			} else if (ticketsell.getIschecked()) {
				ServiceException e = new ServiceException("0178");
				result.setResult(new Integer(e.getExceptionCode()));
				result.setResultMsg(e.getExceptionMessage());
				return result;
			}

			Ticketreturn ticketreturn = new Ticketreturn();
			ticketreturn.setId(0);
			// ticketreturn.setBilltype();
			ticketreturn
					.setCharges(ticketsell.getPrice().multiply(
							getReturnRate(ticketsell.getDepartdate(),
									ticketsell.getDeparttime(),
									ticketsell.getOrgid())));
			ticketreturn.setCreateby(returnuser.getId());
			ticketreturn.setCreatetime(now);
			ticketreturn.setIsselfschedule(true);
			ticketreturn.setRemarks(null);
			ticketreturn.setReturnamount(ticketsell.getPrice().subtract(
					ticketreturn.getCharges()));
			ticketreturn.setReturnby(returnuser.getId());
			ticketreturn.setReturnip(paramReturnTicketsIn.getReturnIp());
			ticketreturn.setReturntime(now);
			// ticketreturn.setBatchno();
			// ticketreturn.setReturnvoucherno();
			ticketreturn.setReturnway("1");
			ticketreturn.setSellid(ticketsell.getId());
			if (ticketoutlets == null) {
				ticketreturn.setTicketoutletsid(0L);
			} else {
				ticketreturn.setTicketoutletsid(ticketoutlets.getId());
			}
			ticketreturn.setTicketprice(ticketsell.getPrice());
			ticketreturn.setUpdateby(returnuser.getId());
			ticketreturn.setUpdatetime(now);

			// 统计退票金额、打印退票凭证的数量
			totalreturnhandcharge = totalreturnhandcharge.add(ticketreturn
					.getCharges());
			totalreturnmoney = totalreturnmoney.add(ticketreturn
					.getReturnamount());
			if (ticketreturn.getCharges().floatValue() > 0) {
				printreturnnum++;
			}
			// 普通退票过了发车时间且没有签手续费的不允许退票
			if ("0".equals(ticketreturn.getReturnway())) {
				// 判断是否签票
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!sellid",
						ticketreturn.getSellid()));
				Ticketsign ticketsign = (Ticketsign) dao.uniqueResult(
						Ticketsign.class, propertyFilters);
				if (ticketsign == null) {
					// 判断发班状态
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter(
							"EQL_t!scheduleplan.id", ticketsell
									.getScheduleplanid()));
					propertyFilters.add(new PropertyFilter(
							"EQL_t!departstationid", ticketsell
									.getDepartstationid()));
					Schedulestatus schedulestatus = (Schedulestatus) dao
							.uniqueResult(LockModeType.PESSIMISTIC_READ,
									Schedulestatus.class, propertyFilters);
					if (schedulestatus.getIsdeparted()) {
						ServiceException e = new ServiceException("0179"); // 该车票所在的班次已经发班，不允许普通退票。请先签定手续费率或使用其它退票方式
						result.setResult(new Integer(e.getExceptionCode()));
						result.setResultMsg(e.getExceptionMessage());
						return result;
					}

					// 判断发车时间
					// 0265 该车票所在的班次已过发车时间，不允许普通退票。请先签定手续费率或使用其它退票方式
					Calendar calendar_now = Calendar.getInstance();
					Calendar calendar_departtime = Calendar.getInstance();
					calendar_departtime.setTime(schedulestatus.getDepartdate());
					calendar_departtime.set(calendar_departtime
							.get(Calendar.YEAR), calendar_departtime
							.get(Calendar.MONTH), calendar_departtime
							.get(Calendar.DAY_OF_MONTH), Integer
							.valueOf(schedulestatus.getDeparttime().substring(
									0, 2)), Integer.valueOf(schedulestatus
							.getDeparttime().substring(3)), 0);
					if (calendar_now.after(calendar_departtime)) {
						ServiceException e = new ServiceException("0265"); // //该车票所在的班次已过发车时间，不允许普通退票。请先签定手续费率或使用其它退票方式
						result.setResult(new Integer(e.getExceptionCode()));
						result.setResultMsg(e.getExceptionMessage());
						return result;
					}
				}
			}
			if (!ticketsell.getIslinework()) {
				// 检查座位状态
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id",
						ticketsell.getScheduleplanid()));
				propertyFilters.add(new PropertyFilter("EQR_t!seatno",
						ticketsell.getSeatno()));
				Scheduleseats scheduleseat = (Scheduleseats) dao.uniqueResult(
						LockModeType.PESSIMISTIC_READ, Scheduleseats.class,
						propertyFilters);
				if (scheduleseat == null) {
					// 回滚
					ServiceException e = new ServiceException("票号"
							+ ticketsell.getTicketno(), "0204", true); // 班次座位记录不存在
					result.setResult(new Integer(e.getExceptionCode()));
					result.setResultMsg(e.getExceptionMessage());
					return result;
				} else if (!"2".equals(scheduleseat.getStatus())) {
					ServiceException e = new ServiceException("票号"
							+ ticketsell.getTicketno(), "0263", true); // 座位不是售出状态
					result.setResult(new Integer(e.getExceptionCode()));
					result.setResultMsg(e.getExceptionMessage());
					return result;
				}
				scheduleseat.setStatus("0");
				scheduleseat.setUpdateby(returnuser.getId());
				scheduleseat.setUpdatetime(now);
				dao.merge(scheduleseat);
			}
			ticketsell.setTicketstatus("1"); // 退票
			ticketsell.setUpdateby(returnuser.getId());
			ticketsell.setUpdatetime(now);
			dao.merge(ticketsell);

			ticketreturn.setCreateby(returnuser.getId());
			ticketreturn.setCreatetime(now);
			ticketreturn.setUpdateby(returnuser.getId());
			ticketreturn.setUpdatetime(now);
			ticketreturn.setReturnby(returnuser.getId());
			ticketreturn.setReturntime(now);
			ticketreturn.setReturnip(paramReturnTicketsIn.getReturnIp());
			ticketreturn = (Ticketreturn) dao.merge(ticketreturn);
			ticketreturns.add(ticketreturn);

			// 锁定班次并更新剩余票数
			Scheduleplan scheduleplan = (Scheduleplan) dao.get(
					LockModeType.PESSIMISTIC_READ, Scheduleplan.class,
					ticketsell.getScheduleplanid());
			scheduleplan
					.setSoldeatnum((short) (scheduleplan.getSoldeatnum() - 1));
			scheduleplan.setCarrychildnum((short) (scheduleplan
					.getCarrychildnum() - ticketsell.getCarrychildnum()));
			scheduleplan.setUpdateby(returnuser.getId());
			scheduleplan.setUpdatetime(now);
			dao.merge(scheduleplan);

			// 票价表要更新不区分发车站到达站
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id",
					ticketsell.getScheduleplanid()));
			propertyFilters.add(new PropertyFilter("EQS_t!seattype", ticketsell
					.getSeattype()));
			List<Ticketprice> ticketprices = dao.find(
					LockModeType.PESSIMISTIC_READ, Ticketprice.class,
					propertyFilters);
			for (Ticketprice _ticketprice : ticketprices) {
				_ticketprice.setSoldeatnum((short) (_ticketprice
						.getSoldeatnum() - 1));
				_ticketprice.setUpdateby(returnuser.getId());
				_ticketprice.setUpdatetime(now);
				dao.merge(_ticketprice);
			}

			if (ticketsell.getTicketoutletsid() == 0) {
				// 异站售本站票
				// opponentorgid=ticketsell.getOrgid();
				// Organization organization = (Organization)
				// dao.get(Organization.class, opponentorgid);
				// if(!"0".equals(organization.getType())){
				// TicketReturnInfo ticketReturnInfo = new TicketReturnInfo();
				// ticketReturnInfo.setBatchno(ticketsell.getBatchno());
				// ticketReturnInfo.setTicketno(ticketsell.getTicketno());
				// ticketReturnInfo.setIsselfschedule(false);
				// ticketReturnInfo.setRemarks(ticketreturn.getRemarks());
				//
				// ticketReturnInfo.setCharges(ticketreturn.getCharges());
				// ticketReturnInfo.setReturnbatchno(ticketreturn.getBatchno());
				// ticketReturnInfo.setReturnBilltypecode(ticketreturn.getBilltype()==null?null:ticketreturn.getBilltype().getCode());
				// ticketReturnInfo.setReturnvoucherno(ticketreturn.getReturnvoucherno());
				// }
			} else {
				// 0现金、1银联卡、2贵客卡余额、3贵客卡积分
				if (ticketturnoverdetail != null
						&& "2".equals(ticketsell.getPaymethod())
						|| "3".equals(ticketsell.getPaymethod())) {
					ticketturnoverdetail
							.setNonvouchermoneypayable(ticketturnoverdetail
									.getNonvouchermoneypayable().subtract(
											ticketreturn.getReturnamount()));
				}
			}
			schedule = (Schedule) dao.get(Schedule.class,
					ticketsell.getScheduleid());
			Station departstation = (Station) dao.get(Station.class,
					ticketsell.getDepartstationid());
			Station reachstation = (Station) dao.get(Station.class,
					ticketsell.getReachstationid());
			ParamReturnTicketOut paramReturnTicketOut = new ParamReturnTicketOut();
			paramReturnTicketOut.setOrderno(ticketsell.getOrderno());
			paramReturnTicketOut.setTicketno(ticketsell.getTicketno());
			paramReturnTicketOut.setScheduleCode(schedule.getCode());
			paramReturnTicketOut.setTickettypeCode(ticketsell.getTickettype());
			paramReturnTicketOut.setDepartdate(ticketsell.getDepartdate());
			paramReturnTicketOut.setDeparttime(ticketsell.getDeparttime());
			paramReturnTicketOut.setSeatno(new Short(ticketsell.getSeatno())
					.toString());
			paramReturnTicketOut.setDepartStationCode(departstation.getCode());
			paramReturnTicketOut.setDepartStationName(departstation.getName());
			paramReturnTicketOut.setReachStationCode(reachstation.getCode());
			paramReturnTicketOut.setReachStationName(reachstation.getName());
			paramReturnTicketOut.setSelltime(ticketsell.getSelltime());
			paramReturnTicketOut.setPrice(ticketsell.getPrice());
			paramReturnTicketOut.setCharge(ticketreturn.getCharges());
			result.getReturnTickets().add(paramReturnTicketOut);

		}
		// &&"1".equals(parameterService.findParamValue("1101",
		// global.getOrganization().getId()))
		if (printreturnnum > 0) {
			if (paramReturnTicketsIn.getReturnPrintStartNo() != null
					&& !paramReturnTicketsIn.getReturnPrintStartNo().equals("")
					&& !paramReturnTicketsIn.getReturnPrintStartNo()
							.equals("0")) {
				if (!paramReturnTicketsIn.getBillCustomManage()) {
					// 判断当前票号是否正确
					String billtypecode = parameterService.findParamValue(
							"1102", schedule.getOrgid());//修改之前是1012 
					billtype = getBilltypeService().findByCode(billtypecode);
					try {
						billinuse = billinuseService.jumpBillinuse(
								returnuser.getId(), billtypecode,
								paramReturnTicketsIn.getReturnPrintStartNo(),
								printreturnnum);
					} catch (ServiceException e) {
						result.setResult(new Integer(e.getExceptionCode()));
						result.setResultMsg(e.getExceptionMessage());
						return result;
					}
					billinventory = (Billinventory) dao
							.get(Billinventory.class,
									billinuse.getBillinventoryid());
					if (ticketturnoverdetail != null
							&& billtypecode.equals("Ticket")) {
						if ("0".equals(ticketturnoverdetail.getTicketstartno())) {
							ticketturnoverdetail
									.setTicketstartno(paramReturnTicketsIn
											.getReturnPrintStartNo());
							if (billinventory != null) {
								ticketturnoverdetail.setBatchno(billinventory
										.getBatchno());
							}
							if (billinuse != null) {
								ticketturnoverdetail.setBillinuseid(billinuse
										.getId());
							}
						}
						ticketturnoverdetail.setTicketendno(StringUtils.strPad(
								new Long(new Long(paramReturnTicketsIn
										.getReturnPrintStartNo())
										+ printreturnnum - 1).toString(),
								paramReturnTicketsIn.getReturnPrintStartNo()
										.length(), "0"));
						ticketturnoverdetail
								.setReturnprintnum(ticketturnoverdetail
										.getReturnprintnum() + printreturnnum);
					}
				} else {
					// 校验传入的票号
					StringBuilder sb = new StringBuilder();
					sb.append("select bi from Billinuse bi ")
							.append(" where bi.startno<=")
							.append(new Long(paramReturnTicketsIn
									.getReturnPrintStartNo()))
							.append(" and bi.endno>=")
							.append(new Long(paramReturnTicketsIn
									.getReturnPrintStartNo()))
							.append(" and bi.recipients=")
							.append(returnuser.getId());
					List<Billinuse> bis = dao.find(sb.toString());
					if (bis == null || bis.size() == 0) {
						ServiceException e = new ServiceException("0170"); // 传入的当前票号与数据库不一致
						result.setResult(new Integer(e.getExceptionCode()));
						result.setResultMsg(e.getExceptionMessage());
						return result;
					}
					billinventory = (Billinventory) dao.get(
							Billinventory.class, bis.get(0)
									.getBillinventoryid());
				}
			} else {
				result.setResult(MethodResult.FAILURE);
				result.setResultMsg("退票凭证起始票号不允许为空");
				return result;
			}
		}

		if (ticketturnoverdetail != null) {
			ticketturnoverdetail.setMoneypayable(ticketturnoverdetail
					.getMoneypayable().subtract(totalreturnmoney));
			ticketturnoverdetail.setReturnhandcharge(ticketturnoverdetail
					.getReturnhandcharge().add(totalreturnhandcharge));
			ticketturnoverdetail.setReturnmoney(ticketturnoverdetail
					.getReturnmoney().add(totalreturnmoney));
			ticketturnoverdetail.setReturnnum(ticketturnoverdetail
					.getReturnnum() + ticketreturns.size());

			ticketturnoverdetail.setUpdateby(returnuser.getId());
			ticketturnoverdetail.setUpdatetime(now);
			ticketturnoverdetail = (Ticketturnoverdetail) dao
					.merge(ticketturnoverdetail);
		}
		for (Ticketreturn ticketreturn : ticketreturns) {
			if (ParamterConst.COMMON_FLAG.FALG_YES.equals(getParameterService().findParamValue(ParamterConst.Param_1101,
					schedule.getOrgid()))
					&& ticketreturn.getCharges().floatValue() > 0) {
				ticketreturn.setReturnvoucherno(StringUtils.strPad(new Long(
						voucherno++).toString(), paramReturnTicketsIn
						.getReturnPrintStartNo().length(), "0"));
				ticketreturn.setBilltype(billtype);
				if (billinventory != null) {
					ticketreturn.setBatchno(billinventory.getBatchno());
				} else {
					ticketreturn.setBatchno("0");
				}
			} else {
				ticketreturn.setReturnvoucherno(null);
				ticketreturn.setBilltype(null);
			}
			if (ticketturnoverdetail != null) {
				ticketreturn.setTurnoverdetailid(ticketturnoverdetail.getId());
				ticketreturn = (Ticketreturn) dao.merge(ticketreturn);
			}
		}
		result.setResult(MethodResult.SUCCESS);
		return result;
	}

	@Override
	public ParamCancelTicketsOut cancelticket(
			ParamCancelTicketsIn paramCancelTicketsIn) {
		ParamCancelTicketsOut result = new ParamCancelTicketsOut();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		if (paramCancelTicketsIn.getCancelUserCode() == null
				|| paramCancelTicketsIn.getCancelUserCode().equals("")) {
			result.setResult(MethodResult.FAILURE);
			result.setResultMsg("废票人编码不允许为空");
			return result;
		}
		Organization cancelorg = null;
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!code",
				paramCancelTicketsIn.getCancelUserCode()));
		Userinfo canceluser = (Userinfo) dao.uniqueResult(Userinfo.class,
				propertyFilters);
		if (paramCancelTicketsIn.getCancelOrgCode() != null
				&& !paramCancelTicketsIn.getCancelOrgCode().equals("")) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code",
					paramCancelTicketsIn.getCancelOrgCode()));
			Organization sellorg = (Organization) dao.uniqueResult(
					Organization.class, propertyFilters);
		} else if (canceluser.getId() != 0) {
			// 取售票人所属的组织机构
			cancelorg = (Organization) dao.get(Organization.class,
					canceluser.getOrgid());
			paramCancelTicketsIn.setCancelOrgCode(cancelorg.getCode());
		} else {
			result.setResultMsg("废票机构编码不允许为空");
			return result;
		}
		Date now = new Date();
		// 插入或修改应缴款表
		Ticketturnoverdetail ticketturnoverdetail = null;
		if (!paramCancelTicketsIn.getBillCustomManage()) {
			ticketturnoverdetail = getTicketturnoverdetailService()
					.getCurTicketturnoverdetail(canceluser.getId(), null);
		}
		List<Ticketcancel> ticketcancels = new ArrayList<Ticketcancel>();
		Ticketoutlets ticketoutlets = null;
		if (paramCancelTicketsIn.getTicketoutletsCode() != null
				&& !paramCancelTicketsIn.getTicketoutletsCode().equals("")) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code",
					paramCancelTicketsIn.getTicketoutletsCode()));
			ticketoutlets = (Ticketoutlets) dao.uniqueResult(
					Ticketoutlets.class, propertyFilters);
		}
		Long selluserid = null;
		result.setCancelTickets(new ArrayList<ParamCancelTicketOut>());
		for (ParamCancelTicketIn paramCancelTicketIn : paramCancelTicketsIn
				.getCancelTickets()) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("GED_t!departdate",
					DateUtils.add(DateUtils.trunc(now), -30)));
			propertyFilters.add(new PropertyFilter("EQS_t!ticketno",
					paramCancelTicketIn.getTicketno()));
			propertyFilters.add(new PropertyFilter("EQS_t!orderno",
					paramCancelTicketIn.getOrderno()));
			Ticketsell ticketsell = (Ticketsell) dao.uniqueResult(
					Ticketsell.class, propertyFilters);
			if (ticketsell == null) {
				result.setResult(MethodResult.FAILURE);
				result.setResultMsg("找不到订单号为"
						+ paramCancelTicketIn.getOrderno() + "，票号为"
						+ paramCancelTicketIn.getTicketno() + "的车票");
				return result;
			} else if ("1".equals(ticketsell.getTicketstatus())) {
				ServiceException e = new ServiceException("0188");
				result.setResult(new Integer(e.getExceptionCode()));
				result.setResultMsg(e.getExceptionMessage());
				return result;
			} else if ("2".equals(ticketsell.getTicketstatus())) {
				ServiceException e = new ServiceException("0189");
				result.setResult(new Integer(e.getExceptionCode()));
				result.setResultMsg(e.getExceptionMessage());
				return result;
			} else if (ticketsell.getIschecked()) {
				ServiceException e = new ServiceException("0190");
				result.setResult(new Integer(e.getExceptionCode()));
				result.setResultMsg(e.getExceptionMessage());
				return result;
			}
			if(canceluser.getId()!=ticketsell.getSellby()){
				result.setResult(MethodResult.FAILURE);
				result.setResultMsg("不允许废其他人的车票！");
				return result;
			}
			Schedule schedule = (Schedule) dao.get(Schedule.class,
					ticketsell.getScheduleid());

			Ticketcancel ticketcancel = new Ticketcancel();
			ticketcancel.setId(0);
			ticketcancel.setCancelby(canceluser.getId());
			ticketcancel.setCancelip(paramCancelTicketsIn.getCancelIp());
			ticketcancel.setCanceltime(now);
			ticketcancel.setCreateby(canceluser.getId());
			ticketcancel.setCreatetime(now);
			ticketcancel.setIsselfschedule(true);
			ticketcancel.setRemarks(null);
			ticketcancel.setCancelway("1");
			ticketcancel.setSellid(ticketsell.getId());
			if (ticketoutlets == null) {
				ticketcancel.setTicketoutletsid(0L);
			} else {
				ticketcancel.setTicketoutletsid(ticketoutlets.getId());
			}
			ticketcancel.setTicketprice(ticketsell.getPrice());
			ticketcancel.setUpdateby(canceluser.getId());
			ticketcancel.setUpdatetime(now);
			ticketcancel.setSellby(ticketsell.getSellby());
			if (selluserid == null) {
				selluserid = ticketcancel.getSellby();
			} else {
				if (selluserid != ticketcancel.getSellby()) {
					ServiceException e = new ServiceException("0192");// 废票不能同时废不同售票员售出的车票
					result.setResult(new Integer(e.getExceptionCode()));
					result.setResultMsg(e.getExceptionMessage());
					return result;
				}
			}
			ticketcancel = (Ticketcancel) dao.merge(ticketcancel);
			ticketcancels.add(ticketcancel);

			if (ticketturnoverdetail != null) {
				ticketturnoverdetail.setMoneypayable(ticketturnoverdetail
						.getMoneypayable()
						.subtract(ticketcancel.getTicketprice())
						.subtract(ticketsell.getServicefee()));
				ticketturnoverdetail.setCancelmoney(ticketturnoverdetail
						.getCancelmoney().add(ticketcancel.getTicketprice()));
				if ("6".equals(ticketsell.getSellway())) {
					ticketturnoverdetail.setBookservicefee(ticketturnoverdetail
							.getBookservicefee().subtract(
									ticketsell.getServicefee()));
				} else if ("1".equals(ticketsell.getSellway())
						|| "2".equals(ticketsell.getSellway())) {
					ticketturnoverdetail.setServicefee(ticketturnoverdetail
							.getServicefee().subtract(
									ticketsell.getServicefee()));
				}
				// 0现金、1银联卡、2贵客卡余额、3贵客卡积分
				if ("2".equals(ticketsell.getPaymethod())
						|| "3".equals(ticketsell.getPaymethod())) {
					ticketturnoverdetail
							.setNonvouchermoneypayable(ticketturnoverdetail
									.getNonvouchermoneypayable().subtract(
											ticketcancel.getTicketprice()));
				}
			}

			// 普通废票过了时间不允许废票
			if ("0".equals(ticketcancel.getCancelway())) {
				String outtimestr = parameterService.findParamValue(ParamterConst.Param_1401,
						schedule.getOrgid());
				int outtime = 10;
				try {
					outtime = new Integer(outtimestr);
				} catch (Exception e) {

				}

				Calendar cdnow = Calendar.getInstance();
				cdnow.setTime(new Date());
				Calendar cdselltime = Calendar.getInstance();
				cdselltime.setTime(ticketsell.getSelltime());
				cdselltime.add(Calendar.MINUTE, outtime);
				if (cdnow.after(cdselltime)) {
					ServiceException e = new ServiceException("0191"); // 普通废票过了时间不允许废票
					result.setResult(new Integer(e.getExceptionCode()));
					result.setResultMsg(e.getExceptionMessage());
					return result;
				}
			}
			ticketsell.setTicketstatus("2"); // 废票
			ticketsell.setUpdateby(canceluser.getId());
			ticketsell.setUpdatetime(now);
			dao.merge(ticketsell);

			if (!ticketsell.getIslinework()) {
				// 检查座位状态
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id",
						ticketsell.getScheduleplanid()));
				propertyFilters.add(new PropertyFilter("EQR_t!seatno",
						ticketsell.getSeatno()));
				Scheduleseats scheduleseat = (Scheduleseats) dao.uniqueResult(
						LockModeType.PESSIMISTIC_READ, Scheduleseats.class,
						propertyFilters);
				if (scheduleseat == null) {
					ServiceException e = new ServiceException("票号"
							+ ticketsell.getTicketno(), "0204", true); // 班次座位记录不存在
					result.setResult(new Integer(e.getExceptionCode()));
					result.setResultMsg(e.getExceptionMessage());
					return result;
				} else if (!"2".equals(scheduleseat.getStatus())) {
					ServiceException e = new ServiceException("票号"
							+ ticketsell.getTicketno(), "0263", true); // 座位不是售出状态
					result.setResult(new Integer(e.getExceptionCode()));
					result.setResultMsg(e.getExceptionMessage());
					return result;
				}
				scheduleseat.setStatus("0");
				scheduleseat.setUpdateby(canceluser.getId());
				scheduleseat.setUpdatetime(now);
				dao.merge(scheduleseat);
			}

			// 锁定班次并更新剩余票数
			Scheduleplan scheduleplan = (Scheduleplan) dao.get(
					LockModeType.PESSIMISTIC_READ, Scheduleplan.class,
					ticketsell.getScheduleplanid());
			scheduleplan
					.setSoldeatnum((short) (scheduleplan.getSoldeatnum() - 1));
			scheduleplan.setCarrychildnum((short) (scheduleplan
					.getCarrychildnum() - ticketsell.getCarrychildnum()));
			scheduleplan.setUpdateby(canceluser.getId());
			scheduleplan.setUpdatetime(now);
			dao.merge(scheduleplan);
			// 票价表要更新不区分发车站到达站
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id",
					ticketsell.getScheduleplanid()));
			propertyFilters.add(new PropertyFilter("EQS_t!seattype", ticketsell
					.getSeattype()));
			List<Ticketprice> ticketprices = dao.find(
					LockModeType.PESSIMISTIC_READ, Ticketprice.class,
					propertyFilters);
			for (Ticketprice _ticketprice : ticketprices) {
				_ticketprice.setSoldeatnum((short) (_ticketprice
						.getSoldeatnum() - 1));
				_ticketprice.setUpdateby(canceluser.getId());
				_ticketprice.setUpdatetime(now);
				dao.merge(_ticketprice);
			}
			Station departstation = (Station) dao.get(Station.class,
					ticketsell.getDepartstationid());
			Station reachstation = (Station) dao.get(Station.class,
					ticketsell.getReachstationid());
			ParamCancelTicketOut paramCancelTicketOut = new ParamCancelTicketOut();
			paramCancelTicketOut.setOrderno(ticketsell.getOrderno());
			paramCancelTicketOut.setTicketno(ticketsell.getTicketno());
			paramCancelTicketOut.setScheduleCode(schedule.getCode());
			paramCancelTicketOut.setTickettypeCode(ticketsell.getTickettype());
			paramCancelTicketOut.setDepartdate(ticketsell.getDepartdate());
			paramCancelTicketOut.setDeparttime(ticketsell.getDeparttime());
			paramCancelTicketOut.setSeatno(new Short(ticketsell.getSeatno())
					.toString());
			paramCancelTicketOut.setDepartStationCode(departstation.getCode());
			paramCancelTicketOut.setDepartStationName(departstation.getName());
			paramCancelTicketOut.setReachStationCode(reachstation.getCode());
			paramCancelTicketOut.setReachStationName(reachstation.getName());
			paramCancelTicketOut.setSelltime(ticketsell.getSelltime());
			paramCancelTicketOut.setPrice(ticketsell.getPrice());
			result.getCancelTickets().add(paramCancelTicketOut);
		}

		// 插入或修改应缴款表
		if (ticketturnoverdetail != null) {
			ticketturnoverdetail.setCancelnum(ticketturnoverdetail
					.getCancelnum()
					+ paramCancelTicketsIn.getCancelTickets().size());

			ticketturnoverdetail.setUpdateby(canceluser.getId());
			ticketturnoverdetail.setUpdatetime(now);
			ticketturnoverdetail = (Ticketturnoverdetail) dao
					.merge(ticketturnoverdetail);
			for (Ticketcancel ticketcancel : ticketcancels) {
				ticketcancel.setTurnoverdetailid(ticketturnoverdetail.getId());
				dao.merge(ticketcancel);
			}
		}
		result.setResult(MethodResult.SUCCESS);
		return result;
	}

	public IDAO getDao() {
		return dao;
	}

	public void setDao(IDAO dao) {
		this.dao = dao;
	}

	public cn.nova.bus.sale.service.TicketSellKernelService getLocalSellService() {
		return localSellService;
	}

	public void setLocalSellService(
			cn.nova.bus.sale.service.TicketSellKernelService localSellService) {
		this.localSellService = localSellService;
	}
	/*
	public SessionContext getContext() {
		return context;
	}

	public void setContext(SessionContext context) {
		this.context = context;
	}*/

	public BilldamagedService getBilldamagedService() {
		return billdamagedService;
	}

	public void setBilldamagedService(BilldamagedService billdamagedService) {
		this.billdamagedService = billdamagedService;
	}

	public UserinfoDao getUserinfoDao() {
		return userinfoDao;
	}

	public void setUserinfoDao(UserinfoDao userinfoDao) {
		this.userinfoDao = userinfoDao;
	}

	public BilltypeService getBilltypeService() {
		return billtypeService;
	}

	public void setBilltypeService(BilltypeService billtypeService) {
		this.billtypeService = billtypeService;
	}

	public BillinuseService getBillinuseService() {
		return billinuseService;
	}

	public void setBillinuseService(BillinuseService billinuseService) {
		this.billinuseService = billinuseService;
	}

	public TicketreturnrateService getTicketreturnrateService() {
		return ticketreturnrateService;
	}

	public void setTicketreturnrateService(
			TicketreturnrateService ticketreturnrateService) {
		this.ticketreturnrateService = ticketreturnrateService;
	}

	public ParameterService getParameterService() {
		return parameterService;
	}

	public void setParameterService(ParameterService parameterService) {
		this.parameterService = parameterService;
	}

	public TicketturnoverdetailService getTicketturnoverdetailService() {
		return ticketturnoverdetailService;
	}

	public void setTicketturnoverdetailService(
			TicketturnoverdetailService ticketturnoverdetailService) {
		this.ticketturnoverdetailService = ticketturnoverdetailService;
	}

	public OrganizationService getOrganizationService() {
		return organizationService;
	}

	public void setOrganizationService(OrganizationService organizationService) {
		this.organizationService = organizationService;
	}

	public ScheduleDao getScheduleDao() {
		return scheduleDao;
	}

	public void setScheduleDao(ScheduleDao scheduleDao) {
		this.scheduleDao = scheduleDao;
	}

	@Override
	public ParamQueryPrintTicketOut TicketList(String custType, String custNo,
			String custPin) {
		ParamQueryPrintTicketOut paramQueryPrintTicketOut = new ParamQueryPrintTicketOut();
		if (custType == null || custType.equals("")) {
			paramQueryPrintTicketOut.setResult(MethodResult.FAILURE);
			paramQueryPrintTicketOut.setResultMsg("取票类型不允许为空");
			return paramQueryPrintTicketOut;
		}
		if (custNo == null || custNo.equals("")) {
			paramQueryPrintTicketOut.setResult(MethodResult.FAILURE);
			paramQueryPrintTicketOut.setResultMsg("取票号码不允许为空");
			return paramQueryPrintTicketOut;
		}
		StringBuilder sql = new StringBuilder();
		if (custType.equals("1")) {
			sql = new StringBuilder(
					"select ts.id  as TicketID,tho.orderno   as OrderNo,")
					.append(" st.name       as StationName,st1.name      as NodeName,sc.code       as SchCode,")
					.append(" ts.departdate as SchDate,ts.departtime as SchTime,ts.fullprice  as Fare,")
					.append(" ts.seatno     as Seat,tho.istaked   as PrintFlag ")
					.append(" from ticketsellother tho,station         st1,schedule        sc,")
					.append(" station         st,ticketsell      ts,customer        c")
					.append("  where tho.ticketsellid = ts.id  and ts.scheduleid = sc.id and tho.istaked=0")
					.append("  and ts.departstationid = st.id and ts.reachstationid = st1.id")
					.append("  and ts.customerid = c.id  and c.certificateno ='"
							+ custNo + "'").append("  order by ts.seatno asc");
		} else if (custType.equals("2")) {
			sql = new StringBuilder("select ts.id as TicketID,");
			sql.append(" tho.orderno as OrderNo, ");
			sql.append(" st.name as StationName, st1.name as NodeName, sc.code as SchCode,");
			sql.append(" tp.departdate as SchDate,ts.departtime as SchTime,tp.fullprice as Fare,ts.seatno as Seat,tho.istaked as PrintFlag ");
			sql.append("  from ticketsellother tho, station st1,schedule sc,scheduleplan sp, station st,ticketprice tp,ticketsell ts left join customer c on ts.customerid=c.id  ");
			sql.append(" where tho.ticketsellid = ts.id ");
			sql.append("  and ts.scheduleid = sc.id");
			sql.append("  and sp.scheduleid=sc.id and tp.seattype=ts.seattype");
			sql.append("  and ts.scheduleplanid=sp.id");
			sql.append("  and tp.scheduleplanid=sp.id");
			sql.append("  and ts.departstationid=tp.departstationid and ts.reachstationid=tp.reachstationid");
			sql.append("  and tp.reachstationid=st1.id ");
			sql.append("  and tp.scheduleid=sc.id");
			sql.append("  and tp.departstationid=st.id ");
			sql.append("  and (tho.orderno='" + custNo + "' or tho.password='"
					+ custNo + "')");
			sql.append("  order by ts.seatno asc");
		}
		// } else if (custType.equals("2")) {
		// sql.append("  and (tho.orderno='" + custNo + "' or tho.password='"
		// + custPin + "')");
		// }

		Query query = dao.createEntityManager().createNativeQuery(
				sql.toString(), ParamQueryPrintTicketTemp.class);
		List<ParamQueryPrintTicketTemp> paramQueryPrintTickettemps = query
				.getResultList();
		List<ParamQueryPrintTicket> paramQueryPrintTickets = new ArrayList<ParamQueryPrintTicket>();
		for (int i = 0; i < paramQueryPrintTickettemps.size(); i++) {
			ParamQueryPrintTicketTemp temp = paramQueryPrintTickettemps.get(i);
			ParamQueryPrintTicket paramQueryPrintTicket = new ParamQueryPrintTicket();
			paramQueryPrintTicket.setFare(temp.getFare());
			paramQueryPrintTicket.setNodeName(temp.getNodeName());
			paramQueryPrintTicket.setOrderNo(temp.getOrderNo());
			paramQueryPrintTicket.setPrintFlag(temp.getPrintFlag());
			paramQueryPrintTicket.setSchCode(temp.getSchCode());
			paramQueryPrintTicket.setSchDate(temp.getSchDate());
			paramQueryPrintTicket.setSchTime(temp.getSchTime());
			paramQueryPrintTicket.setSeat(temp.getSeat());
			paramQueryPrintTicket.setStationName(temp.getStationName());
			paramQueryPrintTicket.setTicketID(temp.getTicketID());
			paramQueryPrintTickets.add(paramQueryPrintTicket);
		}

		paramQueryPrintTicketOut
				.setParamQueryPrintTickets(paramQueryPrintTickets);
		paramQueryPrintTicketOut.setResult(MethodResult.SUCCESS);
		return paramQueryPrintTicketOut;
	}

	// 自助机取票
	@Override
	public ParamPrintOuts TicketPrint(String orderNo, String ticketID,
			String cTicketNo, String userCode) {
		ParamPrintOuts printOuts = new ParamPrintOuts();
		if (orderNo == null || orderNo.equals("")) {
			printOuts.setResult(MethodResult.FAILURE);
			printOuts.setResultMsg("订单号不允许为空");
			return printOuts;
		}
		if (userCode == null || userCode.equals("")) {
			printOuts.setResult(MethodResult.FAILURE);
			printOuts.setResultMsg("用户编码不允许为空");
			return printOuts;
		}
		try {
			Userinfo userinfo = userinfoDao.getByCode(userCode);
			if (userinfo == null) {
				printOuts.setResult(MethodResult.FAILURE);
				printOuts.setResultMsg("没有该:" + userCode + "用户信息");
				return printOuts;
			}
			long salerid = userinfo.getId();
			Billinventory billinventory = null;
			Ticketturnoverdetail ticketturnoverdetail = null;
			Long ticketno = new Long(ticketID);
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			Date now = new Date();
			StringBuilder hql = new StringBuilder(
					"select rownum as id,o.code  as StationCode,");
			hql.append(" st1.name  as StationName,st.code as NodeCode,st.name as NodeName,r.code as LineCode,");
			hql.append("  r.name as LineName,decode(sc.workways,0,'直达','普通') as LineType,sc.code as SchCode,");
			hql.append(" sc.code as SchName, decode(sc.type,1,'豪华',2,'空调',3,'卧铺','普通') as SchType,tp.departdate as SchDate,ts.departtime as SchTime,");
			hql.append(" decode(ts.tickettype,'Q','全票','B','半票','X','学生票','Z','打折票') as TicketType,");
			hql.append(" ts.price as Fare,ts.fueladditionfee as BAFare,tp.toplimitprice as TopFare,ts.seatno as Seat, vp.name as BusType,");
			hql.append("  ts.buspark as BusPark, ts.ticketentrance as Wicket,ts.ticketno as TicketNo, ts.ticketno as Barcode,");
			hql.append(" tho.password as CustPin,ts.selltime as OpTime, u.code as OperCode");
			hql.append("  from ticketsell ts,ticketsellother tho,route r,scheduleplan sp, ticketprice tp,schedule sc,organization o,station st,");
			hql.append(" schedulevehiclepeopleplan svp,vehicletype vp,userinfo u,station st1");
			hql.append(" where tho.ticketsellid = ts.id and ts.scheduleplanid = sp.id and tp.scheduleplanid = sp.id");
			hql.append(" and tp.scheduleid = sc.id and sc.routeid = r.id and sc.orgid = o.id");
			hql.append(" and tp.reachstationid = st.id and svp.scheduleplanid=sp.id and svp.scheduleid=sc.id");
			hql.append(" and tp.departstationid=ts.departstationid and tp.reachstationid=ts.reachstationid");
			hql.append(" and svp.planvehicletypeid=vp.id and ts.sellby =u.id and ts.departstationid=st1.id ");
			hql.append(" and ts.seattype=tp.seattype");
			List<ParamPrintOut> paramPrintOuts = new ArrayList<ParamPrintOut>();
			if (ticketID != null && ticketID.length()>0) {
				Billinuse billinuse = billinuseService.jumpBillinuse(salerid,
						"Ticket", cTicketNo, 1);
				billinventory = (Billinventory) dao.get(Billinventory.class,
						billinuse.getBillinventoryid());

				// 插入或修改应缴款表
				ticketturnoverdetail = getTicketturnoverdetailService()
						.getCurTicketturnoverdetail(salerid, cTicketNo);
				if ("0".equals(ticketturnoverdetail.getTicketstartno())) {
					ticketturnoverdetail.setTicketstartno(cTicketNo);
				}
				// StringUtils.strPad(cTicketNo,billinuse.getNextno(), "0")
				ticketturnoverdetail.setTicketendno(cTicketNo);
				// 不能算自助机的营收,只能算换票数
				// ticketturnoverdetail.setSellnum(ticketturnoverdetail.getSellnum()
				// + 1);
				ticketturnoverdetail.setEticketnum(ticketturnoverdetail
						.getEticketnum() + 1);
				ticketturnoverdetail.setUpdateby(salerid);
				ticketturnoverdetail.setUpdatetime(now);
				ticketturnoverdetail.setBatchno(billinventory.getBatchno());
				ticketturnoverdetail.setBillinuseid(billinuse.getId());
				ticketturnoverdetail = (Ticketturnoverdetail) dao
						.merge(ticketturnoverdetail);

				// 更新ticketsell 修改票号
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!id", ticketID));
				Ticketsell ticketsell = (Ticketsell) dao.uniqueResult(
						Ticketsell.class, propertyFilters);
				// ticketturnoverdetail.setMoneypayable(ticketturnoverdetail.getMoneypayable().add(ticketsell.getPrice()));
				// ticketturnoverdetail.setSellmoney(ticketturnoverdetail.getSellmoney().add(ticketsell.getPrice()));
				if(ticketsell==null){
					TransactionUtil.setRollbackOnly();
					printOuts.setResult(MethodResult.FAILURE);
					printOuts.setResultMsg("未查到该车票信息");
					return printOuts;
				}
				ticketsell.setTicketno(cTicketNo);
				ticketsell.setUpdatetime(now);
				ticketsell.setUpdateby(salerid);
				ticketsell.setTurnoverdetailid(ticketturnoverdetail.getId());
				dao.merge(ticketsell);

				// 更新ticketsellother 取票状态
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!ticketsellid",
						ticketID));
				//增加锁控制
				Ticketsellother ticketsellother = (Ticketsellother) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,
						Ticketsellother.class, propertyFilters);
				if (ticketsellother.getIstaked()) {
					TransactionUtil.setRollbackOnly();
					printOuts.setResult(MethodResult.FAILURE);
					printOuts.setResultMsg("该车票已经打印过");
					return printOuts;
				}
				ticketsellother.setIstaked(true);
				ticketsellother.setPrintby(salerid);
				ticketsellother.setTaketime(now);
				ticketsellother.setTakeway("2");
				dao.merge(ticketsellother);
				hql.append(" and ts.id=" + ticketID);
			} else {
				List<Ticketsellother> ticketsellothers = dao
						.find(LockModeType.PESSIMISTIC_READ,"select tho from Ticketsellother tho where tho.orderno='"
								+ orderNo + "'");
				int printticketcount = ticketsellothers.size();
				Billinuse billinuse = billinuseService.jumpBillinuse(salerid,"Ticket", cTicketNo, printticketcount);
				billinventory = (Billinventory) dao.get(Billinventory.class,billinuse.getBillinventoryid());

				// 插入或修改应缴款表
				ticketturnoverdetail = getTicketturnoverdetailService()
						.getCurTicketturnoverdetail(salerid, cTicketNo);
				if ("0".equals(ticketturnoverdetail.getTicketstartno())) {
					ticketturnoverdetail.setTicketstartno(cTicketNo);
				}
				ticketturnoverdetail.setTicketendno(StringUtils.strPad(
						new Long(ticketno + printticketcount - 1).toString(),
						cTicketNo.length(), "0"));
				// ticketturnoverdetail.setSellnum(ticketturnoverdetail.getSellnum()
				// + printticketcount);
				ticketturnoverdetail.setEticketnum(ticketturnoverdetail
						.getEticketnum() + 1);
				ticketturnoverdetail.setUpdateby(salerid);
				ticketturnoverdetail.setUpdatetime(now);
				ticketturnoverdetail.setBatchno(billinventory.getBatchno());
				ticketturnoverdetail.setBillinuseid(billinuse.getId());
				ticketturnoverdetail = (Ticketturnoverdetail) dao
						.merge(ticketturnoverdetail);

				for (int i = 0; i < ticketsellothers.size(); i++) {
					Ticketsellother ticketsellother = ticketsellothers.get(i);
					if (ticketsellother.getIstaked()) {
						TransactionUtil.setRollbackOnly();
						printOuts.setResult(MethodResult.FAILURE);
						printOuts.setResultMsg("该车票已经打印过");
						return printOuts;
					}
					// 更新ticketsell 修改票号
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQL_t!id",
							ticketsellother.getTicketsellid()));
					Ticketsell ticketsell = (Ticketsell) dao.uniqueResult(
							Ticketsell.class, propertyFilters);
					// ticketturnoverdetail.setMoneypayable(ticketturnoverdetail.getMoneypayable().add(ticketsell.getPrice()));
					// ticketturnoverdetail.setSellmoney(ticketturnoverdetail.getSellmoney().add(ticketsell.getPrice()));
					ticketsell.setTicketno(cTicketNo + i);
					ticketsell.setUpdatetime(now);
					ticketsell.setUpdateby(salerid);
					ticketsell
							.setTurnoverdetailid(ticketturnoverdetail.getId());
					dao.merge(ticketsell);

					ticketsellother.setIstaked(true);
					ticketsellother.setPrintby(salerid);
					ticketsellother.setTaketime(now);
					ticketsellother.setTakeway("2");
					dao.merge(ticketsellother);
				}
				hql.append("tho.orderno='" + orderNo + "'");

			}
			hql.append("  order by ts.seatno asc ");
			// dao.merge(ticketturnoverdetail);
			// 查询打印信息
			Query querys = dao.getEntityManager().createNativeQuery(
					hql.toString(), ParamPrintOutTemp.class);
			List<ParamPrintOutTemp> outTemps = querys.getResultList();
			for (int i = 0; i < outTemps.size(); i++) {
				ParamPrintOutTemp paramPrintOutTemp = outTemps.get(i);
				ParamPrintOut paramPrintOut = new ParamPrintOut();
				paramPrintOut
						.setStationCode(paramPrintOutTemp.getStationCode());
				paramPrintOut
						.setStationName(paramPrintOutTemp.getStationName());
				paramPrintOut.setNodeCode(paramPrintOutTemp.getNodeCode());
				paramPrintOut.setNodeName(paramPrintOutTemp.getNodeName());
				paramPrintOut.setLineCode(paramPrintOutTemp.getLineCode());
				paramPrintOut.setLineName(paramPrintOutTemp.getLineName());
				paramPrintOut.setLineType(paramPrintOutTemp.getLineType());
				paramPrintOut.setSchCode(paramPrintOutTemp.getSchCode());
				paramPrintOut.setSchName(paramPrintOutTemp.getSchName());
				paramPrintOut.setSchType(paramPrintOutTemp.getSchType());
				paramPrintOut.setSchDate(paramPrintOutTemp.getSchDate());
				paramPrintOut.setSchTime(paramPrintOutTemp.getSchTime());
				paramPrintOut.setTicketType(paramPrintOutTemp.getTicketType());
				paramPrintOut.setFare(paramPrintOutTemp.getFare());
				paramPrintOut.setBAFare(paramPrintOutTemp.getBAFare());
				paramPrintOut.setTopFare(paramPrintOutTemp.getTopFare());
				paramPrintOut.setSeat(paramPrintOutTemp.getSeat());
				paramPrintOut.setBusType(paramPrintOutTemp.getBusType());
				paramPrintOut.setBusPark(paramPrintOutTemp.getBusPark());
				paramPrintOut.setWicket(paramPrintOutTemp.getWicket());
				paramPrintOut.setTicketNo(paramPrintOutTemp.getTicketNo());
				paramPrintOut.setBarcode(paramPrintOutTemp.getBarcode());
				paramPrintOut.setCustPin(paramPrintOutTemp.getCustPin());
				paramPrintOut.setOpTime(paramPrintOutTemp.getOpTime());
				paramPrintOut.setOperCode(paramPrintOutTemp.getOperCode());

				paramPrintOuts.add(paramPrintOut);
			}
			printOuts.setParamPrintOuts(paramPrintOuts);
			printOuts.setResult(MethodResult.SUCCESS);
			return printOuts;
		} catch (ServiceException e) {
			TransactionUtil.setRollbackOnly();
			printOuts.setResult(MethodResult.FAILURE);
			printOuts.setResultMsg(e.getExceptionMessage());
			System.out.println(e.getExceptionMessage());
			return printOuts;

		} catch (Exception e) {
			TransactionUtil.setRollbackOnly();
			printOuts.setResult(MethodResult.FAILURE);
			printOuts.setResultMsg(e.getMessage());
			play.Logger.error(e.getMessage(), e);
			return printOuts;
		}
	}

	@Override
	public ParamSellTicketsOut SellReceipt(ParamSellTicketsIn order) throws Exception {
		cn.nova.bus.sale.param.ParamSellTicketsIn localParamSellTicketsIn = new cn.nova.bus.sale.param.ParamSellTicketsIn(
				order);
		ParamSellTicketsOut result = new ParamSellTicketsOut();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();

		if (localParamSellTicketsIn.getSellway() == null
				|| localParamSellTicketsIn.getSellway().equals("")) {
			result.setResultMsg("售票方式不允许为空");
			return result;
		}
		if (localParamSellTicketsIn.getOrderno() == null
				|| localParamSellTicketsIn.getOrderno().equals("")) {
			result.setResultMsg("订单号不允许为空");
			return result;
		}
		if (localParamSellTicketsIn.getPaymethod() == null
				|| localParamSellTicketsIn.getPaymethod().equals("")) {
			result.setResultMsg("支付方式不允许为空");
			return result;
		}
		if (localParamSellTicketsIn.getStartTicketNO() == null
				|| localParamSellTicketsIn.getStartTicketNO().equals("")) {
			result.setResultMsg("当前票号不允许为空");
			return result;
		}
		if (localParamSellTicketsIn.getSellerCode() != null
				&& !localParamSellTicketsIn.getSellerCode().equals("")) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code",
					localParamSellTicketsIn.getSellerCode()));
			Userinfo seller = (Userinfo) dao.uniqueResult(Userinfo.class,
					propertyFilters);
			localParamSellTicketsIn.setSellerId(seller.getId());
			if (localParamSellTicketsIn.getSellOrgCode() != null
					&& !localParamSellTicketsIn.getSellOrgCode().equals("")) {
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!code",
						localParamSellTicketsIn.getSellOrgCode()));
				Organization sellorg = (Organization) dao.uniqueResult(
						Organization.class, propertyFilters);
				localParamSellTicketsIn.setSellOrgId(sellorg.getId());
			} else if (seller.getId() != 0) {
				// 取售票人所属的组织机构
				Organization sellorg = (Organization) dao.get(
						Organization.class, seller.getOrgid());
				localParamSellTicketsIn.setSellOrgCode(sellorg.getCode());
				localParamSellTicketsIn.setSellOrgId(sellorg.getId());
			} else {
				result.setResultMsg("售票机构不允许为空");
				return result;
			}
		} else {
			result.setResultMsg("售票人不允许为空");
			return result;
		}
		// if(localParamSellTicketsIn.getSellIp()==null||localParamSellTicketsIn.getSellIp().equals("")){
		// result.setResultMsg("售票IP不允许为空");
		// return result;
		// }
		if (localParamSellTicketsIn.getTicketoutletsCode() != null
				&& !localParamSellTicketsIn.getTicketoutletsCode().equals("")) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code",
					localParamSellTicketsIn.getTicketoutletsCode()));
			Ticketoutlets ticketoutlets = (Ticketoutlets) dao.uniqueResult(
					Ticketoutlets.class, propertyFilters);
			localParamSellTicketsIn.setTicketoutletsid(ticketoutlets.getId());
		} else {
			localParamSellTicketsIn.setTicketoutletsid(0L);
		}
		for (ParamSellTicketIn _paramSellTicketIn : localParamSellTicketsIn
				.getSellseats()) {
			cn.nova.bus.sale.param.ParamSellTicketIn paramSellTicketIn = (cn.nova.bus.sale.param.ParamSellTicketIn) _paramSellTicketIn;
			if (paramSellTicketIn.getServicefee() == null) {
				paramSellTicketIn.setServicefee(new BigDecimal(0));
			}
			if (paramSellTicketIn.getDepartDate() == null) {
				result.setResultMsg("发车日期不允许为空");
				return result;
			}
			if (paramSellTicketIn.getSeattypeCode() == null
					|| paramSellTicketIn.getSeattypeCode().equals("")) {
				result.setResultMsg("座位类型不允许为空");
				return result;
			}
			if (paramSellTicketIn.getTickettypeCode() == null
					|| paramSellTicketIn.getTickettypeCode().equals("")) {
				result.setResultMsg("车票类型不允许为空");
				return result;
			}
			Station departStation = null;
			if (paramSellTicketIn.getDepartStationCode() != null
					&& !paramSellTicketIn.getDepartStationCode().equals("")) {
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!code",
						paramSellTicketIn.getDepartStationCode()));
				departStation = (Station) dao.uniqueResult(Station.class,
						propertyFilters);
			} else {
				result.setResultMsg("发车站编码不允许为空");
				return result;
			}
			Station reachStation = null;
			if (paramSellTicketIn.getReachStationCode() != null
					&& !paramSellTicketIn.getReachStationCode().equals("")) {
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!code",
						paramSellTicketIn.getReachStationCode()));
				reachStation = (Station) dao.uniqueResult(Station.class,
						propertyFilters);
			}
			Schedule schedule = null;
			if (paramSellTicketIn.getSchedulecode() != null
					&& !paramSellTicketIn.getSchedulecode().equals("")) {
				Organization org_depart = organizationService
						.getOrgByStationCode(paramSellTicketIn
								.getDepartStationCode());
				schedule = scheduleDao.getScheduleByCode(
						paramSellTicketIn.getSchedulecode(),
						org_depart.getId(), paramSellTicketIn.getDepartDate());
			} else if (paramSellTicketIn.getSchedulesynccode() != null
					&& !paramSellTicketIn.getSchedulesynccode().equals("")) {
				schedule = scheduleDao.getScheduleBySyncCode(paramSellTicketIn
						.getSchedulesynccode());
			} else {
				result.setResultMsg("班次编码与班次同步编码不允许同时为空");
				return result;
			}

			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQD_t!departdate",
					paramSellTicketIn.getDepartDate()));
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleid", schedule
					.getId()));
			propertyFilters.add(new PropertyFilter("EQL_t!departstationid",
					departStation.getId()));
			propertyFilters.add(new PropertyFilter("EQL_t!reachstationid",
					reachStation.getId()));
			propertyFilters.add(new PropertyFilter("EQS_t!seattype",
					paramSellTicketIn.getSeattypeCode()));
			Ticketprice ticketprice = (Ticketprice) dao.uniqueResult(
					Ticketprice.class, propertyFilters);
			if (ticketprice == null) {
				result.setResultMsg("找不到班次计划");
				return result;
			}
			if (paramSellTicketIn.getPrice() == null) {
				switch (paramSellTicketIn.getTickettypeCode().charAt(0)) {
				case 'Q':
					paramSellTicketIn.setPrice(ticketprice.getFullprice());
					break;
				case 'B':
					paramSellTicketIn.setPrice(ticketprice.getHalfprice());
					break;
				case 'X':
					paramSellTicketIn.setPrice(ticketprice.getStudentprice());
					break;
				default:
					result.setResultMsg("没有传入票价且车票类型未知");
					return result;
				}
			}
			paramSellTicketIn.setTicketpriceId(ticketprice.getId());
			if (paramSellTicketIn.getCertificateno() != null
					&& !paramSellTicketIn.getCertificateno().equals("")
					&& paramSellTicketIn.getCertificatetype() != null
					&& !paramSellTicketIn.getCertificatetype().equals("")) {
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!certificateno",
						paramSellTicketIn.getCertificateno()));
				propertyFilters.add(new PropertyFilter("EQS_t!certificatetype",
						paramSellTicketIn.getCertificatetype()));
				propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
				Customer customer = (Customer) dao.uniqueResult(Customer.class,
						propertyFilters);
				if (customer != null) {
					paramSellTicketIn.setCustomerid(customer.getId());
				}
			}
		}
		try {
			return localSellService.SellReceipt(localParamSellTicketsIn);
		} catch (ServiceException e) {
			//getContext().setRollbackOnly();
			TransactionUtil.setRollbackOnly();
			result.setResultMsg(e.getExceptionMessage());
			return result;
		} catch (Exception e) {
			TransactionUtil.setRollbackOnly();
			result.setResultMsg(e.getMessage());
			return result;
		}
	}

}
