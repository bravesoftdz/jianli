package cn.nova.bus.checkticket.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.persistence.LockModeType;
import javax.persistence.Query;

import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.checkticket.dao.CheckticketDao;
import cn.nova.bus.checkticket.model.Checkticketlog;
import cn.nova.bus.checkticket.model.Departinvoices;
import cn.nova.bus.checkticket.model.Entryticket;
import cn.nova.bus.checkticket.model.Ledcontent;
import cn.nova.bus.checkticket.model.Musiccontent;
import cn.nova.bus.checkticket.model.ScheduleStartCheck;
import cn.nova.bus.checkticket.model.Ticketmixcheck;
import cn.nova.bus.checkticket.service.CheckticketService;
import cn.nova.bus.checkticket.socket.Message;
import cn.nova.bus.common.ConstDefiniens;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dispatch.model.Seatreserve;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.dispatch.plugin.PluginFunction;
import cn.nova.bus.encrypt.AuthcodeEncode;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.price.model.Ticketpriceformulaitem;
import cn.nova.bus.price.model.Ticketpriceitem;
import cn.nova.bus.sale.dao.TicketDao;
import cn.nova.bus.sale.model.CarryChild;
import cn.nova.bus.sale.model.RemoteTicketsell;
import cn.nova.bus.sale.model.TicketMixChange;
import cn.nova.bus.sale.model.Ticketreturn;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.model.Ticketturnoverdetail;
import cn.nova.bus.sale.service.TicketService;
import cn.nova.bus.sale.service.TicketpriceReturnService;
import cn.nova.bus.sale.service.TicketreturnService;
import cn.nova.bus.sale.service.TicketturnoverdetailService;
import cn.nova.bus.sale.service.impl.TicketServiceImpl;
import cn.nova.bus.sale.service.impl.TicketpriceReturnServiceImpl;
import cn.nova.bus.sale.service.impl.TicketreturnServiceImpl;
import cn.nova.bus.sale.service.impl.TicketturnoverdetailServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.service.OrganizationService;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.OrganizationServiceImpl;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.MixCheckParam;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;
import models.ActionNode;
import models.TestParams;
import util.AppConstant;
import util.Appvar;
import util.CommonUtil;
import util.CurrentUtil;
import util.JsonUtil;
import util.RemoteApi;
import util.RpcUtil;
import util.SystemFactory;
import util.TransactionUtil;
import utils.bus365.security.RSAUtil;

/**
 * @author lck
 * @param <V>
 * 
 */

public class CheckticketServiceImpl<V> implements CheckticketService {
	final private int insideInvokFalse = -67101735;
	private static final String eStationSellTicketPrivateKey = AppConstant.getValue("estationsellticket.privateKey");
	private OrganizationService organizationService = new OrganizationServiceImpl();
	
	private CheckticketDao checkticketDao = new CheckticketDao();
	
	private TicketDao ticketDao = new TicketDao();
	
	private TicketService ticketService = new TicketServiceImpl();
	
	private ParameterService parameterService = new ParameterServiceImpl();
	
	private BilltypeService billtypeService = new BilltypeServiceImpl();
	
	private TicketturnoverdetailService ticketturnoverdetailService = new TicketturnoverdetailServiceImpl();
	
	private TicketreturnService ticketreturnService = new TicketreturnServiceImpl();
	
	//原路退款Service
	private TicketpriceReturnService ticketpriceReturnService;
	
	@Override
	public List<Map<String, Object>> qryScheduleplan(
			List<PropertyFilter> propertyFilterList, Date departdate,
			Long reportorgid, long departstationid) {
		String status = "0,2";// 正常、晚点
		// 停班
		String schstatus = parameterService.findParamValue(ParamterConst.Param_3021, reportorgid);
		if (schstatus.equals(ParamterConst.COMMON_FLAG.FALG_YES)) {
			status = status + ",1";
		}
		// 被并
		schstatus = parameterService.findParamValue(ParamterConst.Param_3022, reportorgid);
		if (schstatus.equals(ParamterConst.COMMON_FLAG.FALG_YES)) {
			status = status + ",3";
		}
		// 脱班
		schstatus = parameterService.findParamValue(ParamterConst.Param_3023, reportorgid);
		if (schstatus.equals(ParamterConst.COMMON_FLAG.FALG_YES)) {
			status = status + ",4";
		}
		schstatus = parameterService.findParamValue(ParamterConst.Param_3024, reportorgid);
		if (schstatus.equals(ParamterConst.COMMON_FLAG.FALG_YES)) {
			status = status + ",5";
		}
		status = "(" + status + ")";
		return ListUtil.listToMap(new Object[] {"ischecked", "id", "departstationid","endstationid","routeid","departstation",
				"endstation", "departtime", "vehicleno", "isovertime",
				"seatnum", "soldeatnum", "departdate", "code",
				"vehicletypename", "ticketentrance", "buspark", "status",
				"planvehiclebrandmodelid", "brandname", "modelcode",
				"islinework", "isreported", "isdeparted", "vehiclereportid",
				"routename", "distance", "vehicleid", "jianpin",
				"carrychildnum", "canonecard", "checkeds", "worktype","schtype","scheduleid","isbegincheck","isrouterealname" },
				checkticketDao.qryScheduleplan(propertyFilterList, departdate,
						reportorgid, status, departstationid), new Object[] {
			
						Boolean.class,Long.class,Long.class,Long.class,Long.class, String.class, String.class, String.class,
						String.class, boolean.class, Integer.class,
						Integer.class, Date.class, String.class, String.class,
						String.class, String.class, String.class, Long.class,
						String.class, String.class, boolean.class,
						boolean.class, boolean.class, Long.class, String.class,
						Integer.class, Long.class, String.class, short.class,
						boolean.class, Integer.class, String.class, String.class,Long.class,boolean.class,boolean.class });
	}
	
	@Override
	public List<Map<String, Object>> qryScheduleplanbyself(
			List<PropertyFilter> propertyFilterList, Date departdate,
			Long reportorgid, long departstationid,Global global) {
		String status = "0,2";// 正常、晚点
		// 停班
		String schstatus = parameterService.findParamValue(ParamterConst.Param_3021, reportorgid);
		if (schstatus.equals(ParamterConst.COMMON_FLAG.FALG_YES)) {
			status = status + ",1";
		}
		// 被并
		schstatus = parameterService.findParamValue(ParamterConst.Param_3022, reportorgid);
		if (schstatus.equals(ParamterConst.COMMON_FLAG.FALG_YES)) {
			status = status + ",3";
		}
		// 脱班
		schstatus = parameterService.findParamValue(ParamterConst.Param_3023, reportorgid);
		if (schstatus.equals(ParamterConst.COMMON_FLAG.FALG_YES)) {
			status = status + ",4";
		}
		schstatus = parameterService.findParamValue(ParamterConst.Param_3024, reportorgid);
		if (schstatus.equals(ParamterConst.COMMON_FLAG.FALG_YES)) {
			status = status + ",5";
		}
		status = "(" + status + ")";
		return ListUtil.listToMap(new Object[] { "id", "departstation",
				"endstation", "departtime", "vehicleno", "isovertime",
				"seatnum", "soldeatnum", "localsell", "localchecked","localnonecheck","departdate", "code",
				"vehicletypename", "ticketentrance", "buspark", "status",
				"planvehiclebrandmodelid", "brandname", "modelcode",
				"islinework", "isreported", "isdeparted", "vehiclereportid",
				"routename", "distance", "vehicleid", "jianpin",
				"carrychildnum", "canonecard", "checkeds", "worktype","schtype","reporttime","driver1","driver2","uncheckeds","cardno"},
				checkticketDao.qryScheduleplanbyself(propertyFilterList, departdate,
						reportorgid, status, departstationid,global), new Object[] {
						Long.class, String.class, String.class, String.class,
						String.class, boolean.class, Integer.class,
						Integer.class,Integer.class,Integer.class,Integer.class, Date.class, String.class, String.class,
						String.class, String.class, String.class, Long.class,
						String.class, String.class, boolean.class,
						boolean.class, boolean.class, Long.class, String.class,
						Integer.class, Long.class, String.class, short.class,
						boolean.class, Integer.class, String.class, String.class,Timestamp.class,String.class,String.class,Integer.class,String.class});
	}
	@Override
	public Ticketsell checkByticketno(long checkstationid,
			long vehiclereportid, String ticketno, Global global,
			boolean islazycheck, String ip, String ticketentrance)
			throws ServiceException {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		Organization org = checkticketDao.getOrganization(checkstationid);
		//long checkedby=global.getUserinfo().getId();
		// 重打/补开/注销 结算单天数
		String opendays = parameterService.findParamValue(ParamterConst.Param_3041, org.getId());	//补开 3019改3041
		int days = new Integer(opendays);
		Date departdate;
		if (days > 0) {
			departdate = DateUtils.add(new Date(), -days);
		} else {
			departdate = new Date();
		}
		// 获取车票并锁住
		// 如果取不到车票，提示“该车票不存在，或过了补开天数”
		Ticketsell ticket = ticketService.getTicket(ticketno, departdate);
		// 混检退票操作 进行退票操作的网售车票进行检票
		if((ticket.getSellway().equals("7")||ticket.getSellway().equals("10"))&&ticket.getTicketstatus().equals("1")){
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!oldticketno", ticket.getTicketno()));
			TicketMixChange tmc = (TicketMixChange) checkticketDao.uniqueResult(TicketMixChange.class, propertyFilters);
			if(tmc!=null){
				ticket = ticketService.getTicket(ticketno+"01", departdate);
			}
		}
		
		//(1)若输入的是主票儿童票要一起检；(2)输入儿童票成人票也要一起检
		TicketDao ticketDao = new TicketDao();
		Ticketsell childTicket = null;//儿童票售票记录
		if("E".equals(ticket.getTickettype())){
			childTicket = ticket;//给儿童票售票记录赋值
			Ticketsell qticket = ticketDao.findQticketBychild(ticket.getId());//查询到全票记录
			if(qticket == null){
				play.Logger.error("未找到此儿童票对应的主票记录，儿童票票号为：" + childTicket.getTicketno());
				throw new BusinessException("未找到此儿童票对应的主票记录，儿童票票号为：" + childTicket.getTicketno());
			}else{
				ticket = qticket;//将主票赋值给将要执行检票的对象
				play.Logger.info("检票，主票号=" + ticket.getTicketno() + "，儿童票票号=" + childTicket.getTicketno());
			}
		}else{
			//主票，查询出对应的儿童票(可能不存在儿童票)
			childTicket = ticketDao.findChildByQticket(ticket.getId());
		}
		
		//站外售票点是否能检其他售票点售的票，0：不能检，1：可以检
		String checkticketother = parameterService.findParamValue(ParamterConst.Param_3032, org.getId());
		if(checkticketother.equals(ParamterConst.COMMON_FLAG.FALG_NO)){
			if(!global.getTicketoutlets().getType().equals("0")&&
					ticket.getTicketoutletsid()!=global.getTicketoutlets().getId()){
				//该车票不允许在该售票点检票！
				throw new ServiceException("0466");
			}
		}
		Billtype bt = billtypeService.findByCode("Ticket");
		int ticketlength=(int) bt.getTicketnolength();
		// 团体票 并且是主票
		if (ticket.getTickettype().equals("T") && ticket.getTicketno().length() == ticketlength ) {
			List<Ticketsell> tss = checkticketDao.getTuanTickets(ticket.getTicketno(),//ticketno,修改当团体票12位票号只输入8位票号时检票提示成功但实际没有成功 将前台传入的8位票号变为上面查询出来的票号
					departdate,false,ticket.getScheduleplanid());
			for (Ticketsell ts : tss) {
				Ticketsell _ticket = checkticket(checkstationid,
						vehiclereportid, ts, global, islazycheck, ip,
						ticketentrance, false,"0");
				if (ticket.getTicketno().equals(_ticket.getTicketno())) {
					ticket = _ticket;
				}
			}
		} else {
			ticket = checkticket(checkstationid, vehiclereportid, ticket,
					global, islazycheck, ip, ticketentrance, false,"0");
		}
		
		//主票检票成功后，执行儿童票检票
		if(childTicket != null){
			childTicket.setCheckstation(ticket.getCheckstation());
			childTicket.setCheckedby(ticket.getCheckedby());
			childTicket.setChecktime(ticket.getChecktime());
			childTicket.setUpdateby(ticket.getUpdateby());
			childTicket.setUpdatetime(ticket.getUpdatetime());
			childTicket.setIschecked(true);
			childTicket.setVehiclereport(ticket.getVehiclereport());
			ticketDao.merge(childTicket);
			
			CarryChild carryChild = ticketDao.findCarryChildByChildid(childTicket.getId());
			carryChild.setUpdateby(childTicket.getUpdateby());
			carryChild.setUpdatetime(childTicket.getUpdatetime());
 			carryChild.setRemark(carryChild.getRemark() + ",检票" + util.DateUtils.formatDatetime(childTicket.getUpdatetime()));
 			ticketDao.merge(carryChild);
		}
		
		return ticket;
	}
//
	@SuppressWarnings("unchecked")
	@Override
	public Ticketsell checkticket(long checkstationid, long vehiclereportid,
			Ticketsell ticket, Global global, boolean islazycheck, String ip,
			String ticketentrance, boolean isauthcheck,String checktype) throws ServiceException {
		//(1)若输入的是主票儿童票要一起检；(2)输入儿童票成人票也要一起检
		TicketDao ticketDao = new TicketDao();
		Ticketsell childTicket = null;//儿童票售票记录
		if("E".equals(ticket.getTickettype())){
			childTicket = ticket;//给儿童票售票记录赋值
			Ticketsell qticket = ticketDao.findQticketBychild(ticket.getId());//查询到全票记录
			if(qticket == null){
				play.Logger.error("未找到此儿童票对应的主票记录，儿童票票号为：" + childTicket.getTicketno());
				throw new BusinessException("未找到此儿童票对应的主票记录，儿童票票号为：" + childTicket.getTicketno());
			}else{
				//如果 儿童票的主票已经检票. 当前票为儿童票时.  return
				if(!qticket.getIschecked()){
					ticket = qticket;//将主票赋值给将要执行检票的对象
				}else{
					if(childTicket != null){
						childTicket.setCheckstation(ticket.getCheckstation());
						childTicket.setCheckedby(ticket.getCheckedby());
						childTicket.setChecktime(ticket.getChecktime());
						childTicket.setUpdateby(ticket.getUpdateby());
						childTicket.setUpdatetime(ticket.getUpdatetime());
						childTicket.setIschecked(true);
						childTicket.setVehiclereport(ticket.getVehiclereport());
						ticketDao.merge(childTicket);
						
						CarryChild carryChild = ticketDao.findCarryChildByChildid(childTicket.getId());
						carryChild.setUpdateby(childTicket.getUpdateby());
						carryChild.setUpdatetime(childTicket.getUpdatetime());
			 			carryChild.setRemark(carryChild.getRemark() + ",检票" + util.DateUtils.formatDatetime(childTicket.getUpdatetime()));
			 			ticketDao.merge(carryChild);
					}
					return ticket;
				}
				play.Logger.info("检票，主票号=" + ticket.getTicketno() + "，儿童票票号=" + childTicket.getTicketno());
			}
		}else{
			//主票，查询出对应的儿童票(可能不存在儿童票)
			childTicket = ticketDao.findChildByQticket(ticket.getId());
		}
		
		long checkedby=global.getUserinfo().getId();
		if (ticket.getIschecked()) {
			//如果是团体票，则跳出继续下个
			if("T".equals(ticket.getTickettype())){
				return ticket;
			}
			// 该车票已检！
			Schedule schedule = (Schedule) checkticketDao.get(Schedule.class,
					ticket.getScheduleid());
			String info = "班次号:" + schedule.getCode();
			if(ticket.getVehiclereport()!=null) {
				Vehiclereport vr = (Vehiclereport) checkticketDao.get(
						Vehiclereport.class, ticket.getVehiclereport().getId());
				Vehicle vehicle = (Vehicle) checkticketDao.get(Vehicle.class,
						vr.getVehicleid());
				info = info + "车号:" + vehicle.getVehicleno();
			}
			System.out.println("该车票已检ticketno=" + ticket.getTicketno()
					+ ",ischecked=" + ticket.getIschecked());
			throw new ServiceException(info, "0117");
		}
		//判断该车票是否已经原路退款、已退款的提示：该车票已经原路退款，不允许检票！ add by tianhb 2018.06.14 BEGIN
		if(null == ticketpriceReturnService){
			ticketpriceReturnService = new TicketpriceReturnServiceImpl();
		}
		Date today = util.DateUtils.strToDate(util.DateUtils.DateToStr(new Date()));
		String msg = "";
		if(ticket.getDepartdate().before(today) && ticketpriceReturnService.isExistTicketpriceReturn(ticket.getId())){
			msg = "该车票已经原路退款，不允许检票-票号:" + ticket.getTicketno() + "，座位号:" + ticket.getSeatno();
			play.Logger.info(msg);
			throw new BusinessException(msg);
		}
		//判断该车票是否已经原路退款、已退款的提示：该车票已经原路退款，不允许检票！ add by tianhb 2018.06.14 END
		Organization org = checkticketDao.getOrganization(checkstationid);

		// 连检、全检、流水号检票、无票根检票时,需要验证车票是否过了“重打/补开/注销 结算单天数”
		String opendays = parameterService.findParamValue(ParamterConst.Param_3041, org.getId());	//补开 3019改3041
		int days = new Integer(opendays);
		Date departdate;
		if (days > 0) {
			departdate = DateUtils.add(new Date(), -days);
		} else {
			departdate = new Date();
		}
		// 此处再去获取一次车票，如果获取不到，提示“该车票不存在，或过了补开天数”
		ticketService.getTicket(ticket.getTicketno(), departdate);

		String isallowcheckother = parameterService.findParamValue(ParamterConst.Param_3020,
				org.getId());
		if (isallowcheckother.equals(ParamterConst.COMMON_FLAG.FALG_NO)) {
			if (ticket.getDepartstationid() != checkstationid) {
				// 该车票不在本站检票！
				throw new ServiceException("0369");
			}
		}
		Date curdate = new Date();
		if (DateUtils.compare(ticket.getDepartdate(), curdate) > 0) {
			// 该车票非本日发车！
			throw new ServiceException("0290");
		}
		String ticketstatus = ticket.getTicketstatus();
		// 正常、退票、废票
		if ("1".equals(ticketstatus)) {
			// 该车票已退
			throw new ServiceException(ticket.getTicketno(),"0121");
		} else if ("2".equals(ticketstatus)) {
			// 该车票已废
			throw new ServiceException(ticket.getTicketno(), "0122");
		} else if ("4".equals(ticketstatus)) {
			// 该车票挂失
			throw new ServiceException(ticket.getTicketno(), "0471");
		}

		String isctrol = parameterService.findParamValue(ParamterConst.Param_3011, org.getId());
		if (!isauthcheck && ParamterConst.COMMON_FLAG.FALG_YES.equals(isctrol)) {
			String[] curticketentrances = ticketentrance.split(";");
			if (curticketentrances == null) {
				// 该车票不在此检票！
				throw new ServiceException("0341");
			}
			boolean isthisticketentrance = false;
			for (String te : curticketentrances) {
				if (te.trim().equals(ticket.getTicketentrance())) {
					isthisticketentrance = true;
				}
			}
			if (!isthisticketentrance) {
				// 该车票不在此检票！
				throw new ServiceException("0341");
			}
		}
		//
		Scheduleplan scheduleplan = (Scheduleplan) checkticketDao.get(
				Scheduleplan.class, ticket.getScheduleplanid());

		// 若是流水班并且是补检，则不允许
		/*
		 * if ((scheduleplan.getIslinework()) && (islazycheck)) { // 流水班 检票时 应不允许补检 throw new ServiceException("0354");
		 * }
		 */

		Vehiclereport vehiclereport = null;
		if (scheduleplan.getIslinework()) {
			if (vehiclereportid > 0) {
				vehiclereport = (Vehiclereport) checkticketDao.get(
						Vehiclereport.class, vehiclereportid);
				if (vehiclereport == null) {
					// // 该班次还未报到，请稍等
					throw new ServiceException("0118");
				}
				// 选中的不是该车票的检票班次
				if (vehiclereport.getScheduleplanid() != scheduleplan.getId()) {
					List<Vehiclereport> vlist = checkticketDao
							.qryVehiclereport(scheduleplan, org.getId(),
									scheduleplan.getDepartdate());
					if (vlist != null && vlist.size() > 0) {
						vehiclereport = vlist.get(0);
					} else {
						// // 该班次还未报到，请稍等
						throw new ServiceException("0118");
					}
				}

			} else {
				// 若是流水班并且没有选中报到车辆，则取最早报到的车辆进行检票

				List<Vehiclereport> vehiclereportlist = checkticketDao
						.qryVehiclereport(scheduleplan, org.getId(),
								scheduleplan.getDepartdate());
				if (vehiclereportlist != null && vehiclereportlist.size() > 0) {
					vehiclereport = vehiclereportlist.get(0);
				} else {
					// // 该班次还未报到，请稍等
					throw new ServiceException("0118");
				}
				System.out.println("linework schedule checked vrplanid"
						+ vehiclereport.getScheduleplanid() + ",scheudleplanid"
						+ scheduleplan.getId());
			}
			Vehicle vehicle = (Vehicle) checkticketDao.get(Vehicle.class,
					vehiclereport.getVehicleid());
			if (vehicle.getSeatnum() <= checkticketDao.getCheckedcount(
					vehiclereport.getId(), scheduleplan.getId())) {
				// 该班次已检满！
				throw new ServiceException("0194");
			}
			long childnum = checkticketDao.getCarrychildnum(
					scheduleplan.getId(), vehiclereport.getId());
			// 班次最多免票带儿童占班次座位数的百分比
			long max =0;
			if("1".equals(parameterService.findParamValue(ParamterConst.Param_1012,
					org.getId()))){//是比例
				long rates = new Long(parameterService.findParamValue(ParamterConst.Param_1061,
						org.getId()));
				 max = vehicle.getSeatnum() * rates / 100;
				
			}else{//固定个数
				 max = new Long(parameterService.findParamValue(ParamterConst.Param_1061,
						org.getId()));
			}
			if (childnum + ticket.getCarrychildnum() > max) {
				// 免费带儿童数已经超出该班次限定的人数！
				throw new ServiceException("0142");
			}
		} else {

			vehiclereport = checkticketDao.getVehiclereport(scheduleplan,
					org.getId());
			if (vehiclereport == null) {
				System.out.println("249 --vehiclereport==null");
				// // 该班次还未报到，请稍等
				throw new ServiceException("0118");
			}
			if (vehiclereport.getScheduleplanid() != scheduleplan.getId()) {
				System.out
						.println(vehiclereport.getScheduleplanid()
								+ "vehiclereport.getScheduleplanid() != scheduleplan.getId()");
				// // 该班次还未报到，请稍等
				throw new ServiceException("0118");
			}
			if (scheduleplan.getSeatnum() <= checkticketDao.getCheckedcount(
					vehiclereport.getId(), scheduleplan.getId())) {
				// 该班次已检满！
				throw new ServiceException("0194");
			}
			List<Scheduleseats> scheduleseatslist = scheduleplan
					.getScheduleseatslist();
			for (Scheduleseats seat : scheduleseatslist) {
				if (ticket.getSeatno() == seat.getSeatno()) {
					seat.setStatus("7");// 已检
					seat.setTickettype(ticket.getTickettype());
					seat.setUpdateby(checkedby);
					seat.setUpdatetime(new Date());
					checkticketDao.getEntityManager().merge(seat);
					break;
				}
			}
		}

		List<Schedulestatus> schedulestatuslist = scheduleplan
				.getSchedulestatuslist();
		for (Schedulestatus schedulestatus : schedulestatuslist) {
			if (schedulestatus.getDepartstationid() == checkstationid) {
				if (!scheduleplan.getIslinework()) {
					if (!schedulestatus.getIsreported()) {
						// 该班次还未报到，请稍等
						throw new ServiceException("0118");
					} else if (!schedulestatus.getIsbegincheck()) {
						// 该班次还未开始检票，请稍等
						throw new ServiceException("0119");
					}
				}

				// 若是不是补检并且非流水班
				if (!islazycheck && !scheduleplan.getIslinework()) {
					if (schedulestatus.getIsdeparted()) {
						Vehicle vehicle = (Vehicle) checkticketDao.get(
								Vehicle.class, vehiclereport.getVehicleid());
						Schedule schedule = (Schedule) checkticketDao.get(
								Schedule.class, vehiclereport.getScheduleid());
						String result = vehicle.getVehicleno() + ","
								+ schedule.getCode() + "("
								+ schedulestatus.getDeparttime() + ")";
						// 该班次已发班，请使用补检功能进行检票
						throw new ServiceException(result, "0195");
					}
					// 暂时去掉时间限制，只有发班才需要补检
					/*
					 * long nomalchecktime = new Long( parameterService.findParamValue(ParamterConst.Param_3018, org.getId())); long
					 * timemargin = timeintevl( formatDatetime(schedulestatus.getDepartdate(),
					 * schedulestatus.getDeparttime()), new Date()); if (nomalchecktime > timemargin) { //
					 * 该车票已过检票时间，请使用补检功能进行检票 throw new ServiceException("0279"); }
					 */

				} else {
					// 若是补检只能允许在 发车后n分钟内补检
					long lastchecktime = new Long(
							parameterService.findParamValue(ParamterConst.Param_3017, org.getId()));
					long timemargin = timeintevl(
							new Date(),
							formatDatetime(schedulestatus.getDepartdate(),
									schedulestatus.getDeparttime()));
					if (timemargin > lastchecktime) {
						// 超过系统规定的补检时间
						throw new ServiceException(lastchecktime + "分钟",
								"0362", true);
					}
				}
				if ((!scheduleplan.getIslinework()) && (!isauthcheck)) {
					// (sp.seatnum - sp.autocancelreserveseatnum -sp.unautocancelreserveseatnum - sp.fixedreserveseatnum
					// -")
					// .append(" sp.soldeatnum) as leaveseat
					int leaveseat = scheduleplan.getSeatnum()
							- scheduleplan.getAutocancelreserveseatnum()
							- scheduleplan.getUnautocancelreserveseatnum()
							- scheduleplan.getFixedreserveseatnum()
							- scheduleplan.getSoldeatnum();// 余坐数
					if (leaveseat != 0) {
						// 该班次票未全部售完！

						// 发车前n分钟开始检票
						long beginchecktime = new Long(
								parameterService.findParamValue(ParamterConst.Param_3001,
										org.getId()));
						long timemargin = timeintevl(
								formatDatetime(schedulestatus.getDepartdate(),
										schedulestatus.getDeparttime()),
								new Date());
						if (beginchecktime > 0 && timemargin > beginchecktime) {
							// 该班次还未到检票时间，请稍等！
							throw new ServiceException("0120");
						}
					} else {

					}
				}
			}
		}
		Station checkstation = new Station();
		checkstation.setId(checkstationid);
		ticket.setCheckstation(checkstation);
		Userinfo userinfo = new Userinfo();
		userinfo.setId(checkedby);
		ticket.setCheckedby(userinfo);
		ticket.setChecktime(new Date());
		ticket.setUpdateby(checkedby);
		ticket.setUpdatetime(new Date());
		ticket.setIschecked(true);
		ticket.setVehiclereport(vehiclereport);
		
		savechecklog(ticket, checktype, "0", global);
		// checkticketDao.getEntityManager().flush();
//		return checkticketDao.getEntityManager().merge(ticket);
		
		ticket = checkticketDao.getEntityManager().merge(ticket);
		//主票检票成功后，执行儿童票检票
		if(childTicket != null){
			childTicket.setCheckstation(ticket.getCheckstation());
			childTicket.setCheckedby(ticket.getCheckedby());
			childTicket.setChecktime(ticket.getChecktime());
			childTicket.setUpdateby(ticket.getUpdateby());
			childTicket.setUpdatetime(ticket.getUpdatetime());
			childTicket.setIschecked(true);
			childTicket.setVehiclereport(ticket.getVehiclereport());
			ticketDao.merge(childTicket);
			
			CarryChild carryChild = ticketDao.findCarryChildByChildid(childTicket.getId());
			carryChild.setUpdateby(childTicket.getUpdateby());
			carryChild.setUpdatetime(childTicket.getUpdatetime());
 			carryChild.setRemark(carryChild.getRemark() + ",检票" + util.DateUtils.formatDatetime(childTicket.getUpdatetime()));
 			ticketDao.merge(carryChild);
		}
		return ticket;
	}
	//
//	private NetSeatreserveService getCentreInterface(MethodResult methodResult,
//			Organization localorg) {
//		Organization centreOrg = organizationService
//				.getDirectlyParentOrg(localorg);
//		if (centreOrg == null) {
//			methodResult.setResult(insideInvokFalse);
//			methodResult.setResultMsg("无法连接中心服务器:找不到" + localorg.getName()
//					+ "的上级机构");
//			return null;
//		}
//		try {
//			return (NetSeatreserveService) EJBFactory.getRemoteEJB(
//					NetSeatreserveService.class, centreOrg.getId());
//		} catch (NamingException e) {
//			methodResult.setResult(insideInvokFalse);
//			methodResult.setResultMsg("无法连接中心服务器:" + e.getMessage());
//			return null;
//		}
//	}
	public List<Map<String, Object>> qrySeatstatusdetailform(List<PropertyFilter> propertyFilterList) {
		return null;
		
	}
	@Override
	public List<Map<String, Object>> qrySeatstatusdetail(List<PropertyFilter> propertyFilterList) {
		// TODO Auto-generated method stub
		List<Object> list = new ArrayList<Object>();
		long scheduleplanid = 0;
		for (PropertyFilter propertyFilter : propertyFilterList) {
			if("ss!scheduleplanid".equals(propertyFilter.getPropertyFullName())){
				scheduleplanid  = Long.valueOf(propertyFilter.getMatchValue().toString());
			}
		}
		Scheduleplan sp = (Scheduleplan) checkticketDao.get(Scheduleplan.class, scheduleplanid);
		if ((!sp.getIslinework()) && ("3".equals(sp.getWorktype()))) {//跨区配载 非流水班
			Schedule schedule = (Schedule) checkticketDao.get(Schedule.class, sp.getScheduleid());
			Map<String, String> requestMap = new HashMap<String, String>();
			requestMap.put("departdate", CommonUtil.dateToFullString(sp.getDepartdate()));
			requestMap.put("schedulesynccode", schedule.getSynccode());
			Global global = CurrentUtil.getGlobal();
			Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
			MethodResult methodResult = new MethodResult();
			try {
				methodResult = RpcUtil.remoteMethodCall(RpcUtil.getRemoteIp(centreOrg.getId()),
						RemoteApi.FIND_SECTION_STATION_CENTER_SEATSINFO, requestMap);//查询中心座位信息
			} catch (Exception e1) {
				play.Logger.error(schedule.getCode() + "跨区配载班次远程中心查询座位信息失败", e1);
			}
			if(methodResult.getResult()== MethodResult.SUCCESS){
				//远程中心成功，更新本地(模拟)座位
				List<Object> centerSeats = (List<Object>) methodResult.getObject();
				play.Logger.info(schedule.getCode() + "该班次查询中心座位信息, 返回非空座位个数=" + centerSeats.size());
				if (centerSeats!=null && centerSeats.size()>0) {
					list.clear();
					for (Object centerSeat : centerSeats) {
						Object[] centerSeatInfo = JsonUtil.parseArray(centerSeat, Object.class).toArray();
						list.add(centerSeatInfo);
					}
					List<Object> oldlist = checkticketDao.qrySeatstatusdetail(propertyFilterList);
					for(int i=0;i<list.size();i++){
						Object[] newobj = (Object[]) list.get(i);
						Object[] oldobj = (Object[]) oldlist.get(i);
							if(!newobj[3].equals("空位")&&newobj[1]==null){
								list.remove(i);
								list.add(i, oldobj);
						}
					}
					
				}
			}else{
				play.Logger.error(schedule.getCode() + "该班次远程中心查询座位信息失败" + methodResult.getResultMsg());
				list=checkticketDao.qrySeatstatusdetail(propertyFilterList);
			}
			
			
		}
		else{
			// 不是跨区配载的查询本地
			list=checkticketDao.qrySeatstatusdetail(propertyFilterList);
		}
		
		return ListUtil.listToMap(new Object[] { "seatno","orgname","tostationname","status","ticketno","sellway" },
				list,
				new Object[] { long.class,String.class,String.class,String.class,String.class,String.class});	
		
		
		
		
	/**	List<Object> list=checkticketDao.qrySeatstatusdetail(propertyFilterList);
		Long scheduleplanid = null;
		for (PropertyFilter propertyFilter : propertyFilterList) {
			if("ss!scheduleplanid".equals(propertyFilter.getPropertyFullName())){
				scheduleplanid  = Long.valueOf(propertyFilter.getMatchValue().toString());
			}
		}
		if (scheduleplanid!=null && scheduleplanid>0) {
			Scheduleplan sp = (Scheduleplan) checkticketDao.get(Scheduleplan.class, scheduleplanid);
//			Ticketprice ticketprice = sp.getTicketpricelist().get(0);
			if ((!sp.getIslinework()) && ("3".equals(sp.getWorktype()))) {//跨区配载 非流水班
				Schedule schedule = (Schedule) checkticketDao.get(Schedule.class, sp.getScheduleid());
				Map<String, String> requestMap = new HashMap<String, String>();
				requestMap.put("departdate", CommonUtil.dateToFullString(sp.getDepartdate()));
				requestMap.put("schedulesynccode", schedule.getSynccode());
				Global global = CurrentUtil.getGlobal();
				Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
				MethodResult methodResult = new MethodResult();
				try {
					methodResult = RpcUtil.remoteMethodCall(RpcUtil.getRemoteIp(centreOrg.getId()),
							RemoteApi.FIND_SECTION_STATION_CENTER_SEATSINFO, requestMap);//查询中心座位信息
				} catch (Exception e1) {
					play.Logger.error(schedule.getCode() + "跨区配载班次远程中心查询座位信息失败", e1);
				}
				if(methodResult.getResult()== MethodResult.SUCCESS){
					//远程中心成功，更新本地(模拟)座位
					List<Object> centerSeats = (List<Object>) methodResult.getObject();
					play.Logger.info(schedule.getCode() + "该班次查询中心座位信息, 返回非空座位个数=" + centerSeats.size());
					if (centerSeats!=null && centerSeats.size()>0) {
						list.clear();
						for (Object centerSeat : centerSeats) {
							Object[] centerSeatInfo = JsonUtil.parseArray(centerSeat, Object.class).toArray();
							list.add(centerSeatInfo);
						}
					}
				}else{
					play.Logger.error(schedule.getCode() + "该班次远程中心查询座位信息失败" + methodResult.getResultMsg());
				}
			}
		}
		return ListUtil.listToMap(new Object[] { "seatno","orgname","tostationname","status","ticketno","sellway" },
				list,
				new Object[] { long.class,String.class,String.class,String.class,String.class,String.class});*/
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> qrySeatstatus(long scheduleplanid,
			long checkstationid) {
		Scheduleplan sp = (Scheduleplan) checkticketDao.get(Scheduleplan.class, scheduleplanid);
//		//Object[] objs=new Object[4];
//		if (sp.getWorktype().equals("3")) {
//			try {
//				MethodResult res = new MethodResult();
//				Organization organization = (Organization) checkticketDao.get(Organization.class, sp.getOrgid());
//				Schedule schedule = (Schedule) checkticketDao.get(Schedule.class, sp.getScheduleid());
//				Route route = (Route) checkticketDao.get(Route.class, schedule.getRoute().getId());
//				Station departstation = (Station) checkticketDao.get(Station.class, route.getStartstationid());
//				Station reachstation = (Station) checkticketDao.get(Station.class, route.getEndstationid());
//				
//				
////				NetSeatreserveService netSeatreserveService = getCentreInterface(res, organization);
////				if (netSeatreserveService != null) {
////				res = netSeatreserveService.findSeatInfo(sp.getDepartdate(),
////						schedule.getSynccode(), departstation.getCode(),
////						reachstation.getCode());
//
//				Organization centreOrg = organizationService.getDirectlyParentOrg(organization);
//				if (centreOrg == null) {
//					res.setResult(insideInvokFalse);
//					res.setResultMsg("无法连接中心服务器:找不到" + organization.getName()+ "的上级机构");
//				}
//				Map<String, String> requestMap = new HashMap<String, String>();
//					requestMap.put("departdate", CommonUtil.dateToFullString(sp.getDepartdate()));
//					requestMap.put("schedulesynccode", schedule.getSynccode());
//					requestMap.put("departstationcode", departstation.getCode());
//					requestMap.put("reachstationcode", reachstation.getCode());
//	
//					String resultstr = RpcUtil.remoteCall(RpcUtil.getRemoteIp(centreOrg.getId()), RemoteApi.FIND_SEAT_INFO, requestMap);		
//					res = JsonUtil.parseObject(resultstr, MethodResult.class);
//				
//					List<Object> lists = (List<Object>) res.getObject();
//					List<Object> schedulseats = checkticketDao
//							.qryScheduleseats(sp);
//					if (schedulseats != null && schedulseats.size() > 0) {
//						short autocancelreserveseatnum = 0;
//						short fixedreserveseatnum = 0;
//						short unautocancelreserveseatnum = 0;
//						short soldeatnum=0;
//						
//						HashMap<Short, Object[]> netUsedSeatMap = new HashMap<Short, Object[]>();
//						for (Object robj : lists) {
//							Object[] seats = JsonUtil.toObjctArray(robj);
//							short seatno = new Short(seats[0].toString());
//							netUsedSeatMap.put(seatno, seats);
//						}
//						
//						for (Object obj : schedulseats) {
//							Scheduleseats ss = (Scheduleseats) obj;
//							Object[] netSeats = netUsedSeatMap.get(ss.getSeatno());
//							if(netSeats == null){ //擦除本地
//								ss.setTickettype(null);
//								ss.setSeattype("0");
//								ss.setStatus("0");
//								checkticketDao.merge(ss);	
//							}else{
//								String ticketype = netSeats[1].toString();
//								String status = netSeats[3].toString();
//								String seattype = netSeats[4].toString();
//								
//								//此处if实际上已废除,待用以防万一
//								if (ss.getStatus().equals("0")) {
//									ss.setTickettype(ticketype);
//									ss.setSeattype(seattype);
//									ss.setStatus(status);
//									checkticketDao.merge(ss);
//								}
//								if (status.equals("2")) {
//									soldeatnum=(short) (soldeatnum+1);
//								} else if (status.equals("3")) {
//									fixedreserveseatnum = (short) (fixedreserveseatnum + 1);
//								} else if (status.equals("4")) {
//									autocancelreserveseatnum = (short) (autocancelreserveseatnum + 1);
//								} else if (status.equals("5")) {
//									unautocancelreserveseatnum = (short) (unautocancelreserveseatnum + 1);
//								}								
//							}
//						}
//						
//						List<Ticketprice> tplist = checkticketDao.qryTicketprices(sp);
//						sp.setAutocancelreserveseatnum(autocancelreserveseatnum);
//						sp.setFixedreserveseatnum(fixedreserveseatnum);
//						sp.setUnautocancelreserveseatnum(unautocancelreserveseatnum);
//						sp.setSoldeatnum(soldeatnum);
//						for (Ticketprice tp : tplist) {
//							tp.setAutocancelreserveseatnum(autocancelreserveseatnum);
//							tp.setFixedreserveseatnum(fixedreserveseatnum);
//							tp.setUnautocancelreserveseatnum(unautocancelreserveseatnum);
//							tp.setSoldeatnum(soldeatnum);
//							checkticketDao.merge(tp);
//						}
//						checkticketDao.merge(sp);
//						checkticketDao.getEntityManager().flush();
//					}
//					
//					//处理班次同步
//					//班次状态各自控制,中心站信息中心要求20150210
//					/*
//					String mapjson = res.getResultMsg();
//					if(org.apache.commons.lang.StringUtils.isNotEmpty(mapjson)){
//						HashMap map = JsonUtil.parseObject(mapjson, HashMap.class);
//						String departTime = (String) map.get("departTime");
//						String status = (String) map.get("schduleStatus");
//						Schedulestatus schedulestatus = new SchedulestatusDao().getSchedulestatus(sp.getId(), departstation.getId());
//						boolean hasChanged = false;
//						if(org.apache.commons.lang.StringUtils.isNotEmpty(departTime) && !departTime.equals(schedulestatus.getDeparttime())){
//							hasChanged = true;
//							schedulestatus.setStatus(departTime);
//						}
//						if(org.apache.commons.lang.StringUtils.isNotEmpty(status) && !status.equals(schedulestatus.getStatus())){
//							hasChanged = true;
//							schedulestatus.setStatus(status);
//						}
//						
//						if(hasChanged){
//							schedulestatus.setUpdatetime(new Date());
//							checkticketDao.update(schedulestatus);
//						}
//						
//					}*/
////				} //if (netSeatreserveService != null)
//			} catch (Exception e) {
//				return ListUtil.listToMap(new Object[] { "scheduleplanid", "seatno",
//						"ischecked", "ticketno", "hint", "seatinfo", "departstationid",
//						"isdepartinvoices", "colortype", "status", "tickettype",
//						"seattype" },
//						checkticketDao.querySeatstatus(sp, checkstationid),
//						new Object[] { long.class, Short.class, boolean.class,
//								String.class, String.class, String.class, long.class,
//								boolean.class, String.class, String.class,
//								String.class, String.class });
//			}
//		}
		List<Object> list=checkticketDao.querySeatstatus(sp, checkstationid);
		return ListUtil.listToMap(new Object[] { "scheduleplanid", "seatno",
				"ischecked", "ticketno", "hint", "seatinfo", "departstationid",
				"isdepartinvoices", "colortype", "status", "tickettype",
				"seattype" },
				list,
				new Object[] { long.class, Short.class, boolean.class,
						String.class, String.class, String.class, long.class,
						boolean.class, String.class, String.class,
						String.class, String.class });
	}

	public boolean seatnums(long scheduleplanid) {//若中心scheduleplan 的seatnum 改变则 将本地的 scheduleplan，ticketprice 和scheduleseats的座位改变
		Scheduleplan sp = (Scheduleplan) checkticketDao.get(Scheduleplan.class,
				scheduleplanid);
		if (sp.getWorktype().equals("3")) {
			try {
				MethodResult res = new MethodResult();
				MethodResult rescount = new MethodResult();
				Organization organization = (Organization) checkticketDao.get(
						Organization.class, sp.getOrgid());
				Schedule schedule = (Schedule) checkticketDao.get(
						Schedule.class, sp.getScheduleid());
				Route route = (Route) checkticketDao.get(Route.class, schedule
						.getRoute().getId());
				Station departstation = (Station) checkticketDao.get(
						Station.class, route.getStartstationid());
				Station reachstation = (Station) checkticketDao.get(
						Station.class, route.getEndstationid());
				Organization centreOrg = organizationService
						.getDirectlyParentOrg(organization);
//				Schedulestatus schedulestatuslist = (Schedulestatus) checkticketDao.getSchedulestatus(scheduleplanid, sp.getStartstationid());
				List<Schedulestatus> schedulestatuslist = sp
				.getSchedulestatuslist();
				if (centreOrg == null) {
					res.setResult(insideInvokFalse);
					res.setResultMsg("无法连接中心服务器:找不到" + organization.getName()
							+ "的上级机构");
				}
				Map<String, String> requestMap = new HashMap<String, String>();
				requestMap.put("departdate",
						CommonUtil.dateToFullString(sp.getDepartdate()));
				requestMap.put("schedulesynccode", schedule.getSynccode());
				requestMap.put("departstationcode", departstation.getCode());
				requestMap.put("reachstationcode", reachstation.getCode());
				
				String resultcount = RpcUtil.remoteCall(RpcUtil.getRemoteIp(centreOrg.getId()),RemoteApi.FIND_SEAT_COUNT, requestMap);
				rescount = JsonUtil.parseObject(resultcount, MethodResult.class);
				List<Object> list = (List<Object>) rescount.getObject();
				if (list != null && list.size() > 0 ) {  //list  由中心的 startstation标识0  配载站   1: 始发站
				Object[] strArray = JsonUtil.toObjctArray(list.get(0));
					int numseat = (Integer) strArray[0]; //得到座位数
					String numseatstatus = (String) strArray[1]; //班次状态
					int childnum =(Integer) strArray[2];//携带儿童数\
					String isstartstation =strArray[3].toString();//
					//去中心获取坐位状态
					String resultstr = RpcUtil.remoteCall(
							RpcUtil.getRemoteIp(centreOrg.getId()),
							RemoteApi.FIND_SEAT_INFO, requestMap);// 查非空座位
					res = JsonUtil.parseObject(resultstr,
							MethodResult.class);
					List<Object> lists = (List<Object>) res.getObject();
					
					short autocancelreserveseatnum = 0;
					short fixedreserveseatnum = 0;
					short unautocancelreserveseatnum = 0;
					short soldeatnum = 0;
					HashMap<Short, Object[]> netUsedSeatMap = new HashMap<Short, Object[]>();
					List<Object> schedulseats = checkticketDao.qryScheduleseats(sp);
					
					if ("0".equals(isstartstation)) {  //startstation标识0  配载站   更改坐位图
						List<Scheduleseats> sst = sp.getScheduleseatslist();
						if (schedulseats != null && schedulseats.size() > 0) {
							if ((short) numseat > sst.size()) {// 中心座位多于车站
																// 将空位赋给车站
								for (int i = sst.size(); i < numseat; i++) {// 将车站插入中心比车站多的座位
									Scheduleseats scheduleseats = new Scheduleseats();
									scheduleseats.setOrgid(sp.getOrgid());
									scheduleseats.setDepartdate(sp
											.getDepartdate());
									scheduleseats.setScheduleid(sp
											.getScheduleid());
									scheduleseats.setTickettype(null);
									scheduleseats.setSeattype("0");
									scheduleseats.setStatus("0");
									short seatno = (short) (i + 1);
									scheduleseats.setSeatno(seatno);
									scheduleseats.setScheduleplan(sp);
									scheduleseats.setCreatetime(new Date());
									scheduleseats.setUpdatetime(new Date());
									scheduleseats.setCreateby(Long.valueOf(0));
									scheduleseats.setUpdateby(Long.valueOf(0));
									checkticketDao.merge(scheduleseats);
								}
								sp.setSeatnum((short) numseat);// 更改scheduleplan
																// Seatnum
								sp.setCarrychildnum((short) childnum);
								checkticketDao.merge(sp);
								List<Ticketprice> tplist = checkticketDao
										.qryTicketprices(sp);
								for (Ticketprice tp : tplist) {// 更改Ticketprice
																// Seatnum
									tp.setSeatnum((short) numseat);
									checkticketDao.merge(tp);
								}
							}

							if (sst.size() > numseat) {
								boolean isExit = false;// 判断多于中心部分的座位是否都为空座
								System.out.println("bendi" + sst.size()
										+ ";  zhongxin:0" + numseat);
								for (int i = numseat; i < sst.size(); i++) {
									if (!"0".equals(sst.get(i).getStatus())) {// 座位为非空座
										isExit = true;
									}
								}
								if (!isExit) {
									// delete; numseat+1
									for (int j = numseat + 1; j <= sst.size(); j++) {
										checkticketDao.deleteseate(sp.getId(),
												j);
									}
									sp.setSeatnum((short) numseat);// 更改scheduleplan// Seatnum
									sp.setCarrychildnum((short) childnum);
									checkticketDao.merge(sp);
									List<Ticketprice> tplist = checkticketDao
											.qryTicketprices(sp);
									for (Ticketprice tp : tplist) {// 更改Ticketprice
																	// Seatnum
										tp.setSeatnum((short) numseat);
										checkticketDao.merge(tp);
									}
								}
							}
						}
					} else {
						// 是始发站，不更改坐位图，只更新已售、留位等。
					}
					for (Object robj : lists) {
						Object[] seats = JsonUtil.toObjctArray(robj);
						short seatno = new Short(seats[0].toString());
						netUsedSeatMap.put(seatno, seats);
					}
					for (Object obj : schedulseats) {
						Scheduleseats ss = (Scheduleseats) obj;
						Object[] netSeats = netUsedSeatMap.get(ss
								.getSeatno());
						if (netSeats == null) { // 擦除本地
							ss.setTickettype(null);
							ss.setSeattype("0");
							ss.setStatus("0");
							checkticketDao.merge(ss);
						} else {
							String ticketype = netSeats[1].toString();
							String status = netSeats[3].toString();
							String seattype = netSeats[4].toString();

							// 此处if实际上已废除,待用以防万一
							if (ss.getStatus().equals("0")) {
								ss.setTickettype(ticketype);
								ss.setSeattype(seattype);
								ss.setStatus(status);
								checkticketDao.merge(ss);
							}
							if (status.equals("2")) {
								soldeatnum = (short) (soldeatnum + 1);
							} else if (status.equals("3")) {
								fixedreserveseatnum = (short) (fixedreserveseatnum + 1);
							} else if (status.equals("4")) {
								autocancelreserveseatnum = (short) (autocancelreserveseatnum + 1);
							} else if (status.equals("5")) {
								unautocancelreserveseatnum = (short) (unautocancelreserveseatnum + 1);
							}
						}
					}

					List<Ticketprice> tplist = checkticketDao
							.qryTicketprices(sp);
					sp.setAutocancelreserveseatnum(autocancelreserveseatnum);
					sp.setFixedreserveseatnum(fixedreserveseatnum);
					sp.setUnautocancelreserveseatnum(unautocancelreserveseatnum);
					sp.setSoldeatnum(soldeatnum);
					for (Ticketprice tp : tplist) {
						tp.setAutocancelreserveseatnum(autocancelreserveseatnum);
						tp.setFixedreserveseatnum(fixedreserveseatnum);
						tp.setUnautocancelreserveseatnum(unautocancelreserveseatnum);
						tp.setSoldeatnum(soldeatnum);
						checkticketDao.merge(tp);
					}
					checkticketDao.merge(sp);
					checkticketDao.getEntityManager().flush();
				}else{
					//若在中心未做关联或者中心返回空值，则不需要更新本站班次座位信息
					/*play.Logger.info("中心提示： "+rescount.getResultMsg());
					
					String resultstr = RpcUtil.remoteCall(RpcUtil.getRemoteIp(centreOrg.getId()), RemoteApi.FIND_SEAT_INFO, requestMap);		
					res = JsonUtil.parseObject(resultstr, MethodResult.class);
					List<Object> lists = (List<Object>) res.getObject();
					List<Object> schedulseats = checkticketDao
							.qryScheduleseats(sp);
					if (schedulseats != null && schedulseats.size() > 0) {
						short autocancelreserveseatnum = 0;
						short fixedreserveseatnum = 0;
						short unautocancelreserveseatnum = 0;
						short soldeatnum=0;
						HashMap<Short, Object[]> netUsedSeatMap = new HashMap<Short, Object[]>();
						for (Object robj : lists) {
							Object[] seats = JsonUtil.toObjctArray(robj);
							short seatno = new Short(seats[0].toString());
							netUsedSeatMap.put(seatno, seats);
						}
						for (Object obj : schedulseats) {
							Scheduleseats ss = (Scheduleseats) obj;
							Object[] netSeats = netUsedSeatMap.get(ss.getSeatno());
							if(netSeats == null){ //擦除本地
								ss.setTickettype(null);
								ss.setSeattype("0");
								ss.setStatus("0");
								checkticketDao.merge(ss);	
							}else{
								String ticketype = netSeats[1].toString();
								String status = netSeats[3].toString();
								String seattype = netSeats[4].toString();
								
								//此处if实际上已废除,待用以防万一
								if (ss.getStatus().equals("0")) {
									ss.setTickettype(ticketype);
									ss.setSeattype(seattype);
									ss.setStatus(status);
									checkticketDao.merge(ss);
								}
								if (status.equals("2")) {
									soldeatnum=(short) (soldeatnum+1);
								} else if (status.equals("3")) {
									fixedreserveseatnum = (short) (fixedreserveseatnum + 1);
								} else if (status.equals("4")) {
									autocancelreserveseatnum = (short) (autocancelreserveseatnum + 1);
								} else if (status.equals("5")) {
									unautocancelreserveseatnum = (short) (unautocancelreserveseatnum + 1);
								}								
							}
						}
						List<Ticketprice> tplist = checkticketDao.qryTicketprices(sp);
						sp.setAutocancelreserveseatnum(autocancelreserveseatnum);
						sp.setFixedreserveseatnum(fixedreserveseatnum);
						sp.setUnautocancelreserveseatnum(unautocancelreserveseatnum);
						sp.setSoldeatnum(soldeatnum);
						for (Ticketprice tp : tplist) {
							tp.setAutocancelreserveseatnum(autocancelreserveseatnum);
							tp.setFixedreserveseatnum(fixedreserveseatnum);
							tp.setUnautocancelreserveseatnum(unautocancelreserveseatnum);
							tp.setSoldeatnum(soldeatnum);
							checkticketDao.merge(tp);
						}
						checkticketDao.merge(sp);
						checkticketDao.getEntityManager().flush();
					}*/
				}
			}
			catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
			}
		}
		return true;
	}
	// 取消检票
	@Override
	public Ticketsell cancelCheckticket(long checkstationid, String ticketno,
			Global global, int iscancelold) throws Exception {
		Organization org = checkticketDao.getOrganization(checkstationid);
		String opendays = parameterService.findParamValue(ParamterConst.Param_3041, org.getId());	//补开 3019改3041
		//第三方代售票混检时，0：按原逻辑混检到新班次处理，1：混检按改签流程处理，默认为0
		String p3091 = parameterService.findParamValue(ParamterConst.Param_3091, org.getId());	
		int days = new Integer(opendays);
		Date departdate = DateUtils.add(new Date(), -days);
		
		//(1)若输入的是主票儿童票要一起退检；(2)输入儿童票成人票也要一起退检
		TicketDao ticketDao = new TicketDao();
		Ticketsell childTicket = null;//儿童票售票记录
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!ticketno", ticketno));
		propertyFilters.add(new PropertyFilter("GED_t!departdate", departdate));
		Ticketsell ticket = (Ticketsell) checkticketDao.uniqueResult(Ticketsell.class, propertyFilters);
		if(ticket == null){
			Billtype bt = billtypeService.findByCode("Ticket");
			String cuticketno = ticketno;
			if (ticketno.length() > bt.getTicketnolength()) {
				int pos = (int) (ticketno.length() - bt.getTicketnolength());
				cuticketno = ticketno.substring(pos, ticketno.length());
			} else if (ticketno.length() < bt.getTicketnolength()) {
				cuticketno = StringUtils.strPad(ticketno,
						(int) bt.getTicketnolength(), "0");
			}
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!ticketno", cuticketno));
			propertyFilters.add(new PropertyFilter("GED_t!departdate", departdate));
			ticket = (Ticketsell) checkticketDao.uniqueResult(Ticketsell.class, propertyFilters);
			if(ticket == null){
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!eticketno", ticketno));
				propertyFilters.add(new PropertyFilter("GED_t!departdate", departdate));
			    ticket = (Ticketsell) checkticketDao.uniqueResult(Ticketsell.class, propertyFilters);
			}
			if(ticket==null) {
				throw new BusinessException("未查到该票号：" + ticketno);
			}
		}else{
			if(p3091.equals("1")&&ticket.getTicketstatus().equals("1")){
				if((ticket.getSellway().equals("7")||ticket.getSellway().equals("10"))&&ticket.getTicketstatus().equals("1")){
					String oldticketno = isMixChange(ticket.getTicketno());
					if(oldticketno!=null){
						propertyFilters.clear();
						propertyFilters.add(new PropertyFilter("EQS_t!ticketno", ticketno+"01"));
						propertyFilters.add(new PropertyFilter("GED_t!departdate", departdate));
						ticket = (Ticketsell) checkticketDao.uniqueResult(Ticketsell.class, propertyFilters);
					}
				}
			}
		}
		if("E".equals(ticket.getTickettype())){
			childTicket = ticket;//给儿童票售票记录赋值
			Ticketsell qticket = ticketDao.findQticketBychild(ticket.getId());//查询到全票记录
			if(qticket == null){
				play.Logger.error("未找到此儿童票对应的主票记录，儿童票票号为：" + childTicket.getTicketno());
				throw new BusinessException("未找到此儿童票对应的主票记录，儿童票票号为：" + childTicket.getTicketno());
			}else{
				ticket = qticket;//将主票赋值给将要执行检票的对象
				play.Logger.info("退检，主票号=" + ticket.getTicketno() + "，儿童票票号=" + childTicket.getTicketno());
			}
		}else{
			//主票，查询出对应的儿童票(可能不存在儿童票)
			childTicket = ticketDao.findChildByQticket(ticket.getId());
		}
		
		ticket = ticketService.getTicket(ticket.getTicketno(), departdate);
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!ticketno", ticket.getTicketno()));
		TicketMixChange tmc = (TicketMixChange) checkticketDao.uniqueResult(TicketMixChange.class, propertyFilters);
		if(p3091.equals("1")&&iscancelold == 1){
			if(tmc!=null){
				throw new BusinessException("第三方代售票混检，不允许进行原班次退检 ：" + ticket.getTicketno());
			}
		}else{
			if(p3091.equals("0")&&tmc!=null&&iscancelold == 1){
				throw new BusinessException("第三方代售票混检，不允许进行原班次退检 ：" + ticket.getTicketno());
			}
		}
		//增加扩展点，退检调用初检单插件，判断是否已经开过初检单
		ActionNode actionNode = Appvar.routes.get("CANCELTICKETSELLFIRSTCHECK");// 由插件名,获得插件
		if(actionNode != null){
			Map map = new HashMap();
			map.put("ticketsellid", ticket.getId());
			PluginFunction.DoPlugin(map, CurrentUtil.getGlobal(), actionNode);
		}
//		Ticketsell ticket = ticketService.getTicket(ticketno, departdate);
		Billtype bt = billtypeService.findByCode("Ticket");
		int ticketlength=(int) bt.getTicketnolength();
		// 团体票 并且是主票 (已检)
		if (ticket.getTickettype().equals("T") && ticket.getTicketno().length() == ticketlength ) {
			List<Ticketsell> tss = checkticketDao.getTuanTickets(ticket.getTicketno(),//ticketno,修改当团体票12位票号只输入8位票号时退检提示成功但实际没有成功 将前台传入的8位票号变为上面查询出来的票号
					departdate,true,ticket.getScheduleplanid());
			for (Ticketsell ts : tss) {
//				//如果不是当前班次的票则跳过
//				if(ts.getScheduleplanid() != oldscheduleplanid){
//					continue;
//				}
				Ticketsell _ticket = cancelCheckticket(checkstationid, ts,
						global, iscancelold);
				if (ticket.getTicketno().equals(_ticket.getTicketno())) {
					ticket = _ticket;
				}
			}
		} else {
			ticket = cancelCheckticket(checkstationid, ticket, global,
					iscancelold);
		}
		
		//主票检票成功后，执行儿童票检票
		if(childTicket != null){
			childTicket.setSeatno(ticket.getSeatno());
			childTicket.setDeparttime(ticket.getDeparttime());
			childTicket.setScheduleplanid(ticket.getScheduleplanid());
			childTicket.setScheduleid(ticket.getScheduleid());
			childTicket.setDepartdate(ticket.getDepartdate());
			childTicket.setCheckstation(ticket.getCheckstation());
			childTicket.setCheckedby(ticket.getCheckedby());
			childTicket.setChecktime(ticket.getChecktime());
			childTicket.setUpdateby(ticket.getUpdateby());
			childTicket.setUpdatetime(ticket.getUpdatetime());
			childTicket.setIschecked(ticket.getIschecked());
			childTicket.setVehiclereport(ticket.getVehiclereport());
			ticketDao.merge(childTicket);
			
			CarryChild carryChild = ticketDao.findCarryChildByChildid(childTicket.getId());
			carryChild.setUpdateby(childTicket.getUpdateby());
			carryChild.setUpdatetime(childTicket.getUpdatetime());
 			carryChild.setRemark(carryChild.getRemark() + ",退检" + util.DateUtils.formatDatetime(childTicket.getUpdatetime()));
 			ticketDao.merge(carryChild);
		}
		
		return ticket;
	}

	@SuppressWarnings("unchecked")
	private Ticketsell cancelCheckticket(long checkstationid,
			Ticketsell ticket, Global global, int iscancelold)
			throws Exception {
		// 该车票已经打结算单，不能取消检票
		if (ticket.getIsdepartinvoices()) {
			throw new ServiceException("0125");
		}
		if (ticket.getCheckstation() == null ) {
			if("T".equals(ticket.getTickettype())){
				return ticket;
			}else{
				throw new ServiceException("0132");
			}
		}
		long checkedstationid = ticket.getCheckstation().getId();
		if (checkedstationid != checkstationid) {
			throw new ServiceException("0126");
		}
		// Schedulestatus schedulestatus = checkticketDao.getSchedulestatus(
		// ticket.getScheduleplanid(), checkedstationid);
		/*
		 * if (schedulestatus.getIsdeparted()) { // 该已经发班，不允许退检！ throw new ServiceException("0295"); }
		 */
		Scheduleplan scheduleplan = (Scheduleplan) checkticketDao.get(
				Scheduleplan.class, ticket.getScheduleplanid());
		if(TestParams.getNewest().cancelCheck == 1){
			SystemFactory.markRtException();
		}
		if (iscancelold == 1) {
			//退检到原班次
			String sql = "select t from Ticketmixcheck t where t.ticketsellid="
					+ ticket.getId() + " order by t.createtime ";
			List<Ticketmixcheck> tslist = checkticketDao.find(sql);
			Ticketmixcheck mixtick = tslist.get(0);
			for(Ticketmixcheck t:tslist){
				t.setIsactive(false);
				t.setUpdateby(global.getUserinfo().getId());
				t.setUpdatetime(new Date());
				checkticketDao.merge(t);
			}
			Scheduleplan oldscheduleplan = (Scheduleplan) checkticketDao.get(
					Scheduleplan.class, mixtick.getOldscheduleplanid());
			if (scheduleplan.getWorktype().equals("3") || 
					oldscheduleplan.getWorktype().equals("3") ){
				//MethodResult res = new MethodResult();
				Organization organization = (Organization) checkticketDao
						.get(Organization.class, scheduleplan.getOrgid());
				Station departstation = (Station) checkticketDao
						.get(Station.class, ticket.getDepartstationid());
				Station reachstation = (Station) checkticketDao.get(
						Station.class, ticket.getReachstationid());
				MixCheckParam mp=new MixCheckParam();
				mp.setDepartstationcode(departstation.getCode());
				mp.setNewdepartdate(scheduleplan.getDepartdate());
				mp.setNewspsynccode(scheduleplan.getSynccode());
				mp.setNewseatno(ticket.getSeatno());
				mp.setCreateby(global.getUserinfo().getName());
				mp.setOlddepartdate(oldscheduleplan.getDepartdate());
				mp.setOldseatno(mixtick.getOldseatno());
				mp.setOldticketno(mixtick.getOldticketno());
				mp.setOldspsynccode(oldscheduleplan.getSynccode());
				mp.setTickettype(ticket.getTickettype());
				mp.setOrgcode(global.getOrganization().getCode());
				mp.setReachstationcode(reachstation.getCode());
				mp.setTicketno(ticket.getTicketno());
				mp.setDeparttime(ticket.getDeparttime());
//					CenterCheckTicketService checkTicketService = getCenterCheckTicketService(res, organization);
//					if (checkTicketService != null) {
//						mp=checkTicketService.cancleCheckTicket(mp);
//						if(mp.getResult()!=1){
//							throw new ServiceException("中心提示:"+mp.getResultMsg()+".","0449");
//						}
//					}
				
				Organization centreOrg = organizationService.getDirectlyParentOrg(organization);
				if (centreOrg == null) {
					mp.setResult(insideInvokFalse);
					mp.setResultMsg("无法连接中心服务器:找不到" + organization.getName()+ "的上级机构");
				}
				
				Map<String, String> requestMap = new HashMap<String, String>();
				requestMap.put("mixCheckParam", JsonUtil.toFormatString(mp));

				try{
					if(TestParams.getNewest().cancelCheck == 2){
						SystemFactory.markRtException();
					}
					String resultstr = RpcUtil.remoteCall(RpcUtil.getRemoteIp(centreOrg.getId()), RemoteApi.CANEL_CHECK_TICKET, requestMap);		
					mp = JsonUtil.parseObject(resultstr, MixCheckParam.class);
				}catch(Exception e){
					TransactionUtil.addCancelScheduleCheckRedo(requestMap, centreOrg.getServersaddress());
				}
				//暂时注释，提交事务
				/*if(mp.getResult() != MethodResult.SUCCESS){
					TransactionUtil.setRollbackOnly(); 
				}*/
			}
			
			
			boolean isfind = false;
			if (!scheduleplan.getIslinework()) {
				List<Scheduleseats> sslist = scheduleplan
						.getScheduleseatslist();
				for (Scheduleseats seat : sslist) {
					if (ticket.getSeatno() == seat.getSeatno()) {
						seat.setStatus("0");//
						seat.setTickettype(null);
						seat.setUpdateby(global.getUserinfo().getId());
						seat.setUpdatetime(new Date());
						checkticketDao.getEntityManager().merge(seat);
						break;
					}
				}
			}
			if (!oldscheduleplan.getIslinework()) {
				List<Scheduleseats> scheduleseatslist = oldscheduleplan
						.getScheduleseatslist();
				for (Scheduleseats seat : scheduleseatslist) {
					if (mixtick.getOldseatno() == seat.getSeatno()
							&& (seat.getStatus().equals("0"))) {
						seat.setStatus("2");// 已售
						seat.setTickettype(ticket.getTickettype());
						ticket.setSeatno(seat.getSeatno());
						seat.setUpdateby(global.getUserinfo().getId());
						seat.setUpdatetime(new Date());
						checkticketDao.getEntityManager().merge(seat);
						isfind = true;
						break;
					}
				}
				if (!isfind) {
					for (Scheduleseats seat : scheduleseatslist) {
						if ((seat.getStatus().equals("0"))) {
							seat.setStatus("2");// 已售
							seat.setTickettype(ticket.getTickettype());
							seat.setUpdateby(global.getUserinfo().getId());
							seat.setUpdatetime(new Date());
							checkticketDao.getEntityManager().merge(seat);
							ticket.setSeatno(seat.getSeatno());
							isfind = true;
							break;
						}
					}
				}
				if (!isfind) {
					throw new ServiceException("0449");
				}

			}
			ticket.setDeparttime(mixtick.getOlddeparttime());
			ticket.setScheduleplanid(oldscheduleplan.getId());
			ticket.setScheduleid(oldscheduleplan.getScheduleid());
			ticket.setDepartdate(oldscheduleplan.getDepartdate());
			if(ticket.getOlddepartdate()==null){
				ticket.setOlddepartdate(oldscheduleplan.getDepartdate());	
			}
			List<Ticketprice> oldtps = oldscheduleplan.getTicketpricelist();
			for (Ticketprice tp : oldtps) {
				tp.setSoldeatnum((short) (tp.getSoldeatnum() + 1));
				tp.setUpdateby(global.getUserinfo().getId());
				tp.setUpdatetime(new Date());
			}
			
			if(ticket.getCarrychildnum()>0){
				oldscheduleplan.setCarrychildnum((short) (oldscheduleplan.getCarrychildnum()+1));
				scheduleplan.setCarrychildnum((short) (scheduleplan.getCarrychildnum()-1));
			}
			
			oldscheduleplan.setSoldeatnum((short) (oldscheduleplan
					.getSoldeatnum() + 1));
			oldscheduleplan.setUpdateby(global.getUserinfo().getId());
			oldscheduleplan.setUpdatetime(new Date());
			checkticketDao.getEntityManager().merge(oldscheduleplan);

			List<Ticketprice> tps = scheduleplan.getTicketpricelist();
			for (Ticketprice tp : tps) {
				tp.setSoldeatnum((short) (tp.getSoldeatnum() - 1));
				tp.setUpdateby(global.getUserinfo().getId());
				tp.setUpdatetime(new Date());
			}
			scheduleplan
					.setSoldeatnum((short) (scheduleplan.getSoldeatnum() - 1));
			scheduleplan.setUpdateby(global.getUserinfo().getId());
			scheduleplan.setUpdatetime(new Date());
			checkticketDao.getEntityManager().merge(scheduleplan);

		} else {
			if (!scheduleplan.getIslinework()) {
				List<Scheduleseats> scheduleseatslist = scheduleplan
						.getScheduleseatslist();
				for (Scheduleseats seat : scheduleseatslist) {
					if (ticket.getSeatno() == seat.getSeatno()) {
						seat.setStatus("2");// 已售
						seat.setUpdateby(global.getUserinfo().getId());
						seat.setUpdatetime(new Date());
						checkticketDao.getEntityManager().merge(seat);
						break;
					}
				}
			}
		}
		ticket.setCheckstation(null);
		ticket.setCheckedby(null);
		ticket.setChecktime(null);
		ticket.setUpdateby(global.getUserinfo().getId());
		ticket.setUpdatetime(new Date());
		ticket.setIschecked(false);
		ticket.setVehiclereport(null);
		Operationlog operationLog = new Operationlog();

		String result = "退检的票号：" + ticket.getTicketno() + " 发车日期:"
				+ DateUtils.formatDate(ticket.getDepartdate()) + "座位号："
				+ ticket.getSeatno();
		operationLog.setIp(global.getIpAddress());
		operationLog.setContent(result);
		operationLog.setModule("综合检票->退检");
		operationLog.setOperatetime(new Date());
		operationLog.setOperation("车票退检");
		operationLog.setSessionid(global.getSessionID());
		operationLog.setUserid(global.getUserinfo().getId());
		checkticketDao.merge(operationLog);
		checkticketDao.getEntityManager().flush();
		if(TestParams.getNewest().cancelCheck == 3){
			SystemFactory.markRtException();
		}
		savechecklog(ticket, "0", "1", global);
		return checkticketDao.getEntityManager().merge(ticket);
	}

	@Override
	public List<Map<String, Object>> qryReportvehicle(long scheduleplanid,
			boolean isdeparted, long reportorgid, Date departdate) {
		return ListUtil.listToMap(new Object[] { "id", "scheduleplanid",
				"vehicleno", "seatnum", "reporttime", "vehicletype",
				"brandname", "vehicleid", "isdeparted","tickets" }, checkticketDao
				.getVehiclereport(scheduleplanid, isdeparted, reportorgid,
						departdate), new Object[] { Long.class, Long.class,
				String.class, Short.class, Timestamp.class, String.class,
				String.class, Long.class, boolean.class,int.class });
	}

	@Override
	public List<Map<String, Object>> qryTicketsell(long scheduleplanid,
			boolean ischecked) {
		return ListUtil.listToMap(new Object[] { "scheduleplanid",
				"stationname", "ticketno", "fullprice", "ticketstatus",
				"ischecked" },
				checkticketDao.queryChecktickets(scheduleplanid, ischecked),
				new Object[] { long.class, String.class, String.class,
						BigDecimal.class, String.class, boolean.class });
	}

	// 实现按票号连续检票过程
	@Override
	public int checkByticketno(List<PropertyFilter> propertyFilterList,long checkstationid, long vehiclereportid,
			String startTicketno, String endTicketno, Global global,
			boolean islazycheck, String ip, String ticketentrance)
			throws ServiceException {
		System.out.println("连检操作：开始票号=" + startTicketno + ",结束票号="
				+ endTicketno);
		//Billtype billtype = billtypeService.findByCode("Ticket");
		// 重打/补开/注销 结算单天数
		String opendays = parameterService.findParamValue(ParamterConst.Param_3041, global.getOrganization().getId());	//补开 3019改3041
		int days = new Integer(opendays);
		Date departdate;
		if (days > 0) {
			departdate = DateUtils.add(new Date(), -days);
		} else {
			departdate = new Date();
		}
		//int slength = (int) billtype.getTicketnolength();
		long startno = Long.valueOf(startTicketno);
		long endtno = Long.valueOf(endTicketno);
		int count = 0;
		long tickets=(endtno-startno+1);
		Vehiclereport vp=(Vehiclereport) checkticketDao.get(Vehiclereport.class, vehiclereportid);
		Vehicle vehicle = (Vehicle) checkticketDao.get(Vehicle.class,
				vp.getVehicleid());
		long checkedtickets=checkticketDao.getCheckedcount(vehiclereportid, vp.getScheduleplanid());
		tickets=tickets+checkedtickets;
		if (vehicle.getSeatnum() < tickets) {
			// 该班次已检满！
			throw new ServiceException("0756");
		}
		//billtypeService = new BilltypeServiceImpl();
		//Billtype bt = billtypeService.findByCode("Ticket");
		//int ticketlength=(int) bt.getTicketnolength();
		
		int recycle = 0;//标识循环次数，用来判断第一张票是否是儿童票
		int childnums = 0;
		
		for (long i = startno; i <= endtno; i++) {
			String ticketno = Long.valueOf(i).toString();
			//ticketno = StringUtils.strPad(ticketno,ticketlength , "0");
			Ticketsell ticket = ticketService.getTicket(ticketno, departdate);
			
			//处理儿童票
			Ticketsell pTicket = ticketDao.findQticketBychild(ticket.getId());//查询 主票-儿童票关联表 查找该(儿童票)票对应的主票
			if((pTicket) != null ){
				if((Long.parseLong(pTicket.getTicketno()) < startno) && (recycle == 0)){
					//第一张票为儿童票，则主票票号 < startno，则输入的连续票段不包含此儿童票的主票号，需要检主票
//					ticketno = StringUtils.strPad(pTicket.getTicketno(), slength, "0");
					ticketno = StringUtils.strPad(pTicket.getTicketno(), 
							(int)billtypeService.findByCode("Ticket").getTicketnolength(), "0");
					if(!pTicket.getIschecked()){
						ticket = ticketService.getTicket(ticketno, departdate);
					}
					i--;
					recycle++;
				}else{
					//若主票票号 >= startno，则输入的连续票段包含了此儿童票的主票号，即主票已检
					
				}
			}else{
				//该票为非儿童票，则不需要处理，在程序最后处理最后一张票看是否存在对应的儿童票
			}
			
			//ticket = null;
			//多车站情况下，有可能把其他站的票给检票，但暂时先注释
			//ticket = (Ticketsell)checkticketDao.getTicketByDepartstationids(propertyFilterList, ticketno, departdate);
			if(ticket==null){
				continue;
			}
			Billtype bt = billtypeService.findByCode("Ticket");
			int ticketlength=(int) bt.getTicketnolength();
			// 团体票 并且是主票
			if (ticket.getTickettype().equals("T") && ticket.getTicketno().length() == ticketlength ) {
				List<Ticketsell> tss = checkticketDao.getTuanTickets(ticket.getTicketno(),//ticketno,
						ticket.getDepartdate(),false,ticket.getScheduleplanid());
				if (vehicle.getSeatnum() < (tss.size()+checkedtickets)) {
					// 该班次已检满！
					throw new ServiceException("0");
				}
				for (Ticketsell ts : tss) {
					Ticketsell _ticket = checkticket(checkstationid,
							vehiclereportid, ts, global, islazycheck, ip,
							ticketentrance, false,"4");
					if (ticket.getTicketno().equals(_ticket.getTicketno())) {
						ticket = _ticket;
					}
				}
			} else {
				/*
				 * Schedulestatus schedulestatus = checkticketDao.getSchedulestatus( ticket.getScheduleplanid(),
				 * checkstationid); if (!schedulestatus.getIsreported()) { // 该班次还未报到，请稍等！ throw new
				 * ServiceException("0118"); } if (schedulestatus.getIsdeparted()) { // 该班次已发班，请使用补检功能进行检票 throw new
				 * ServiceException("0195"); }
				 */
				checkticket(checkstationid, vehiclereportid, ticket, global,
						islazycheck, ip, ticketentrance, false,"4");
			}
			
			//若为最后一张票
			if(endtno == Long.parseLong(ticket.getTicketno())){
				Ticketsell childTicket = ticketDao.findChildByQticket(ticket.getId());//通过主票sellid查到儿童票记录
				if(childTicket != null){
					//若最后一张票存在儿童票，则要检儿童票
					ticket = checkticket(checkstationid, vehiclereportid, childTicket, global,
							islazycheck, ip, ticketentrance, false, "4");//4：连检
					count++;
				}
			}
			
			if("E".equals(ticket.getTickettype())){
//				if(recycle != 1){
//					count--;//若是儿童票，则不统计到检票数中
//				}
				childnums ++;
				
				//若是儿童票，则更新CarryChild记录
				CarryChild child = ticketDao.findCarryChildByChildid(ticket.getId());
				child.setUpdateby(ticket.getUpdateby());
				child.setUpdatetime(ticket.getUpdatetime());
				child.setRemark(child.getRemark() + ",连检" + util.DateUtils.formatDatetime(ticket.getUpdatetime()));
				ticketDao.merge(child);
			}
			
			count++;
		}
		
		count = count - childnums;
		
		return count;
	}

	// 查询车票信息，用于混检
	@Override
	public List<Map<String, Object>> qryTicket(Global global, String ticketno,String certificateno) {
		String opendays = parameterService.findParamValue(ParamterConst.Param_3041, global.getOrganization().getId());//补开 3019改3041
		int day = new Integer(opendays);
		return ListUtil.listToMap(new Object[] { "id", "departdate", "code",
				"departtime", "vehicletype", "departstation", "reachstation",
				"seatno", "price", "tickettype", "ticketentrance", "buspark",
				"remarks", "islinework", "ticketstatus", "ischecked",
				"sellbyname", "selltime" },
				checkticketDao.queryTicket(day,ticketno,certificateno), new Object[] {
						long.class, Date.class, String.class, String.class,
						String.class, String.class, String.class, Short.class,
						BigDecimal.class, String.class, String.class,
						String.class, String.class, boolean.class,
						String.class, boolean.class, String.class,
						Timestamp.class });
	}

//	private CenterCheckTicketService getCenterCheckTicketService(MethodResult methodResult,
//			Organization localorg) {
//		Organization centreOrg = organizationService
//				.getDirectlyParentOrg(localorg);
//		if (centreOrg == null) {
//			methodResult.setResult(insideInvokFalse);
//			methodResult.setResultMsg("无法连接中心服务器:找不到" + localorg.getName()
//					+ "的上级机构");
//			return null;
//		}
//		try {
//			return (CenterCheckTicketService) EJBFactory.getRemoteEJB(
//					CenterCheckTicketService.class, centreOrg.getId());
//		} catch (NamingException e) {
//			methodResult.setResult(insideInvokFalse);
//			methodResult.setResultMsg("无法连接中心服务器:" + e.getMessage());
//			return null;
//		}
//	}
	// 混检操作
	@SuppressWarnings("unchecked")
	@Override
	public Ticketsell mixCheckticket(long checkstationid, long scheduleplanid,
			long vehiclereportid, long ticketid,Global global, short newseatno
			,String ticketentrance,boolean isauthcheck)
			throws Exception {
		Ticketsell ticket = (Ticketsell) checkticketDao.get(
				LockModeType.PESSIMISTIC_READ, Ticketsell.class, ticketid);
		long checkedby=global.getUserinfo().getId();
		if (ticket == null) {
			// 该车票不存在！
			throw new ServiceException("0116");
		}
		//判断该车票是否已经原路退款、已退款的提示：该车票已经原路退款，不允许检票！ add by tianhb 2018.06.14 BEGIN
		if(null == ticketpriceReturnService){
			ticketpriceReturnService = new TicketpriceReturnServiceImpl();
		}
		Date today = util.DateUtils.strToDate(util.DateUtils.DateToStr(new Date()));
		String msg = "";
		if(ticket.getDepartdate().before(today) && ticketpriceReturnService.isExistTicketpriceReturn(ticket.getId())){
			msg = "该车票已经原路退款，不允许检票-票号:" + ticket.getTicketno();
			play.Logger.info(msg);
			throw new BusinessException(msg);
		}
		//判断该车票是否已经原路退款、已退款的提示：该车票已经原路退款，不允许检票！ add by tianhb 2018.06.14 END
		//校验售票记录的密文是否正确
		if(!ticketService.checkTicketByTicket(ticket)){
			throw new ServiceException("0500");
		}
		
		if (ticket.getScheduleplanid() == scheduleplanid) {
			// 同班次的座位号不允许混检！
			// throw new ServiceException("0336");
			return checkByticketno(checkstationid, vehiclereportid,
					ticket.getTicketno(), global, true, global.getIpAddress(), ticketentrance);
		}
		
		if("E".equals(ticket.getTickettype())){
			//免携儿童票不允许混检
			throw new ServiceException("6230");
		}
		//(1)若输入的是主票儿童票要一起检；(2)输入儿童票成人票也要一起检
		TicketDao ticketDao = new TicketDao();
		Ticketsell childTicket = null;//儿童票售票记录
		if("E".equals(ticket.getTickettype())){
			childTicket = ticket;//给儿童票售票记录赋值
			Ticketsell qticket = ticketDao.findQticketBychild(ticket.getId());//查询到全票记录
			if(qticket == null){
				play.Logger.error("未找到此儿童票对应的主票记录，儿童票票号为：" + childTicket.getTicketno());
				throw new BusinessException("未找到此儿童票对应的主票记录，儿童票票号为：" + childTicket.getTicketno());
			}else{
				ticket = qticket;//将主票赋值给将要执行检票的对象
				play.Logger.info("检票，主票号=" + ticket.getTicketno() + "，儿童票票号=" + childTicket.getTicketno());
			}
		}else{
			//主票，查询出对应的儿童票(可能不存在儿童票)
			childTicket = ticketDao.findChildByQticket(ticket.getId());
		}
		
	/*	if (ticket.getTickettype().equals("T")) {
			// 团体票不允许混检！
			throw new ServiceException("0459");
		}*/
		Organization org = checkticketDao.getOrganization(checkstationid);
		//检票时扫描的票号所属班次跟当前选中班次不一致时，是否允许检票，0否，1是
//		String isCheckotherSch = parameterService.findParamValue(ParamterConst.Param_3036, org.getId());
//		if(isCheckotherSch!=null && isCheckotherSch.equals("0")){
//			throw new ServiceException("0617");
//		}
		//站外售票点是否能检其他售票点售的票，0：不能检，1：可以检
		String checkticketother = parameterService.findParamValue(ParamterConst.Param_3032, org.getId());
		if(checkticketother.equals(ParamterConst.COMMON_FLAG.FALG_NO)){
			if(!global.getTicketoutlets().getType().equals("0")&&
					ticket.getTicketoutletsid()!=global.getTicketoutlets().getId()){
				//该车票不允许在该售票点检票！
				throw new ServiceException("0466");
			}
		}
		String isallowcheckother = parameterService.findParamValue(ParamterConst.Param_3020,
				org.getId());
		if (isallowcheckother.equals(ParamterConst.COMMON_FLAG.FALG_NO)) {
			if (ticket.getDepartstationid() != checkstationid) {
				// 该车票不在本站检票！
				throw new ServiceException("0369");
			}
		}

		if (ticket.getIschecked()) {
			// 该车票已检！
			throw new ServiceException("0117");
		}
		String ticketstatus = ticket.getTicketstatus();
		// 正常、退票、废票
		if ("1".equals(ticketstatus)) {
			// 该车票已退
			throw new ServiceException("0121");
		} else if ("2".equals(ticketstatus)) {
			// 该车票已废
			throw new ServiceException("0122");
		}else if ("4".equals(ticketstatus)) {
			// 该车票挂失
			throw new ServiceException(ticket.getTicketno(), "0471");
		}
		String isctrol = parameterService.findParamValue(ParamterConst.Param_3011, org.getId());
		if (!isauthcheck && ParamterConst.COMMON_FLAG.FALG_YES.equals(isctrol)) {
			String[] curticketentrances = ticketentrance.split(";");
			if (curticketentrances == null) {
				// 该车票不在此检票！
				throw new ServiceException("0341");
			}
			boolean isthisticketentrance = false;
			for (String te : curticketentrances) {
				if (te.trim().equals(ticket.getTicketentrance())) {
					isthisticketentrance = true;
				}
			}
			if (!isthisticketentrance) {
				// 该车票不在此检票！
				throw new ServiceException("0341");
			}
		}
		// 隔天的车票是否允许混检
		String isvalidate = parameterService
				.findParamValue(ParamterConst.Param_3016, org.getId());
		if (ParamterConst.COMMON_FLAG.FALG_NO.equals(isvalidate)) {
//			Date departdate = DateUtils.mergerDateAndTime(ticket.getDepartdate(), ticket.getDeparttime());
			// 控制，即昨天的车票不可混检
			if (DateUtils.compare(ticket.getDepartdate(), new Date(), "yyyy-MM-dd") == -1) {
				// 该车票已过期，不允许混检！
				throw new ServiceException("0133");
			}
		}
		// 预售的车票是否允许混检
		isvalidate = parameterService
				.findParamValue(ParamterConst.Param_3033, org.getId());
		if (ParamterConst.COMMON_FLAG.FALG_NO.equals(isvalidate)) {
			Date departdate = ticket.getDepartdate();
			if (DateUtils.compare(departdate, new Date(), "yyyy-MM-dd") > 0) {
				// 该车票是预售票，不允许混检！
				throw new ServiceException("0475");
			}
		}

		String olddeparttime = ticket.getDeparttime();
		short oldseatno = ticket.getSeatno();

		Scheduleplan oldscheduleplan = (Scheduleplan) checkticketDao.get(LockModeType.PESSIMISTIC_READ,
				Scheduleplan.class, ticket.getScheduleplanid());
		Scheduleplan newscheduleplan = (Scheduleplan) checkticketDao.get(LockModeType.PESSIMISTIC_READ,
				Scheduleplan.class, scheduleplanid);

		// 3026:隔天车票，是否只能混检到车票当天的班次
		String ischecktlast = parameterService.findParamValue(ParamterConst.Param_3026,
				org.getId());
		// 车票的发车日期和新班次的发车日期比较,如果不是同一天，即不为0
		if (ParamterConst.COMMON_FLAG.FALG_YES.equals(ischecktlast)
				&& DateUtils.compare(ticket.getDepartdate(),
						newscheduleplan.getDepartdate(), "yyyy-MM-dd") != 0) {
			// 该隔天车票，只能混检到车票当天！
			throw new ServiceException("0434");
		}

		// 重打结算单天数
		String checkday = parameterService.findParamValue(ParamterConst.Param_3041, org.getId());    //3019改3041
		int days = new Integer(checkday);
		Date departdate = DateUtils.add(newscheduleplan.getDepartdate(), days);
		if (DateUtils.compare(departdate, new Date()) == -1) {
			// 已超过补开结算单天数！
			throw new ServiceException("0367");
		}

		if (!newscheduleplan.getIscanmixcheck()) {
			// 检入班次不允许混检！
			throw new ServiceException("0136");
		}

		// 满座是否允许混检
		String ismixcheckbyfull = parameterService.findParamValue(ParamterConst.Param_3015,
				org.getId());
		if (ParamterConst.COMMON_FLAG.FALG_NO.equals(ismixcheckbyfull)) {
			if (newscheduleplan.getSeatnum() == newscheduleplan.getSoldeatnum()
					|| (newscheduleplan.getSeatnum()
							- newscheduleplan.getSoldeatnum()
							- newscheduleplan.getAutocancelreserveseatnum() - newscheduleplan
							.getFixedreserveseatnum()) <= 0) {
				// 该班次已没有空位，不允许混检！
				throw new ServiceException("0356");
			}
		}
		List<Schedulestatus> newschedulestatuslist = newscheduleplan
				.getSchedulestatuslist();
		Schedulestatus newschedulestatus = null;
		for (Schedulestatus schedulestatus : newschedulestatuslist) {
			if (schedulestatus.getDepartstationid() == checkstationid) {
				newschedulestatus = schedulestatus;
				/*
				 * if (!schedulestatus.getIsbegincheck()) { // 该班次还未开始检票，请稍等 throw new ServiceException("0119"); }
				 */
				if (!newscheduleplan.getIslinework()) {
					// 发车前n分钟开始检票
					long beginchecktime = new Long(
							parameterService.findParamValue(ParamterConst.Param_3001, org.getId()));
					long timemargin = timeintevl(
							formatDatetime(schedulestatus.getDepartdate(),
									schedulestatus.getDeparttime()), new Date());
					if (beginchecktime > 0 && timemargin > beginchecktime) {
						// 该班次还未到检票时间，请稍等！7
						throw new ServiceException("0120");
					}
					// 已过发车时间是否允许混检
					String ismixcheck = parameterService.findParamValue(ParamterConst.Param_3012,
							org.getId());
					// 为0不允许
					if (ParamterConst.COMMON_FLAG.FALG_NO.equals(ismixcheck)) {
						if (checktime(schedulestatus.getDepartdate(),
								schedulestatus.getDeparttime())) {
							// 已过发车时间，不允许混检！
							throw new ServiceException("0338");
						}
					}
				}
				break;
			}
		}
		if (newschedulestatus == null) {
			for (Schedulestatus schedulestatus : newschedulestatuslist) {
				if (schedulestatus.getDepartstationid() == ticket
						.getDepartstationid()) {
					newschedulestatus = schedulestatus;
					break;
				}
			}
		}
		String issyncroute = parameterService.findParamValue(ParamterConst.Param_3003,
				org.getId());
		if (ParamterConst.COMMON_FLAG.FALG_NO.equals(issyncroute)) {
			// 不同线路的班次是否允许混检,0：不允许，1：允许
			Schedule s1 = (Schedule) checkticketDao.get(Schedule.class,
					ticket.getScheduleid());
			Schedule s2 = (Schedule) checkticketDao.get(Schedule.class,
					newscheduleplan.getScheduleid());
			if (s1.getRoute().getId() != s2.getRoute().getId()) {
				// 不同线路的班次不允许混检
				throw new ServiceException("0134");
			}
		}
		if (ParamterConst.COMMON_FLAG.FALG_NO.equals(parameterService.findParamValue(ParamterConst.Param_3004, org.getId()))) {
			if (oldscheduleplan.getIslinework()
					&& newscheduleplan.getIslinework()) {
				// 流水班次不允许检可混检到流水班次！
				throw new ServiceException("0139");
			}
		}
		if (ParamterConst.COMMON_FLAG.FALG_NO.equals(parameterService.findParamValue(ParamterConst.Param_3005, org.getId()))) {
			if (oldscheduleplan.getIslinework()
					&& (!newscheduleplan.getIslinework())) {
				// 流水班次不允许检可混检到非流水班次！
				throw new ServiceException("0140");
			}
		}
		if (ParamterConst.COMMON_FLAG.FALG_NO.equals(parameterService.findParamValue(ParamterConst.Param_3006, org.getId()))) {
			if ((!oldscheduleplan.getIslinework())
					&& newscheduleplan.getIslinework()) {
				// 非流水班次不允许检可混检到流水班次！
				throw new ServiceException("0141");
			}
		}

		// List<Ticketprice> newticketpricelist = newscheduleplan
		// .getTicketpricelist();
		List<Ticketprice> oldticketprice = oldscheduleplan.getTicketpricelist();
		List<Ticketprice> newticketprice = newscheduleplan.getTicketpricelist();
		//校验两种类型的混检，暂时不实现，不予许两种以上坐位类型的班次混检
		boolean oldseattype = false;
		for (Ticketprice tp : oldticketprice) {
			if(!(oldticketprice.get(0).getSeattype()).equals(tp.getSeattype())){
				oldseattype=true;
				break;
			}
		}
		if(oldseattype){//多种座位类型的班次不允许混检
			throw new ServiceException("0560");
		}
		boolean newseattype = false;
		for (Ticketprice tp : newticketprice) {
			if(!(newticketprice.get(0).getSeattype()).equals(tp.getSeattype())){
				newseattype=true;
				break;
			}
		}
		if(newseattype){//多种座位类型的班次不允许混检
			throw new ServiceException("0560");
		}
		boolean isstop = false;
		// 混检是否允许检不存在站点的检入，0：不允许，1：允许！
		String almix = parameterService.findParamValue(ParamterConst.Param_3027, org.getId());
		for (Ticketprice tp : newticketprice) {
			if (tp.getReachstationid() == ticket.getReachstationid()) {
				isstop = true;
				break;
			}
		}
		if (!isstop) {
			if (almix.equals(ParamterConst.COMMON_FLAG.FALG_YES)) {
				Ticketprice tp = newTicketprice(newscheduleplan,
						oldticketprice, ticket, checkedby);
				if (tp != null) {
					newticketprice.add(tp);
				} else {
					// 检入班次没有该车票的停靠站点！
					throw new ServiceException("0135");
				}
			} else {
				// 检入班次没有该车票的停靠站点！
				throw new ServiceException("0135");
			}
		}

		if (ticket.getCarrychildnum() > 0 && (!newscheduleplan.getIslinework())) {
			long childnum = checkticketDao.getCarrychildnum(newscheduleplan
					.getId());
			String flag = parameterService.findParamValue(ParamterConst.Param_1012,org.getId());
			long max =0;
			//班次最多免票带儿童占班次座位数的方式：0表示按固定座位数 1表示按百份比，与1061参数配合使用
			if(flag.equals("0")){
				max= new Long(parameterService.findParamValue(ParamterConst.Param_1061,
						org.getId()));
			}else{
				// 班次最多免票带儿童占班次座位数的百分比
				long rates = new Long(parameterService.findParamValue(ParamterConst.Param_1061,
						org.getId()));
				max = newscheduleplan.getSeatnum() * rates / 100;
			}
			if (childnum + ticket.getCarrychildnum() > max) {
				// 免费带儿童数已经超出该班次限定的人数！
				throw new ServiceException("0142");
			}
		}
		Vehiclereport vehiclereport = null;
		if (newscheduleplan.getIslinework()) {
			if (vehiclereportid > 0) {
				vehiclereport = (Vehiclereport) checkticketDao.get(
						Vehiclereport.class, vehiclereportid);
			} else {
				// 若是流水班并且没有选中报到车辆，则取最早报到的车辆进行检票
				List<Vehiclereport> vehiclereportlist = checkticketDao
						.qryVehiclereport(newscheduleplan, org.getId(),
								newscheduleplan.getDepartdate());
				vehiclereport = vehiclereportlist.get(0);
				for (Vehiclereport obj : vehiclereportlist) {
					if (obj.getOrderno() < vehiclereport.getOrderno()) {
						vehiclereport = obj;
					}
				}
			}
			long childnum = checkticketDao.getCarrychildnum(
					newscheduleplan.getId(), vehiclereport.getId());
			// 班次最多免票带儿童占班次座位数的百分比
				Vehicle vehilce = (Vehicle) checkticketDao.get(Vehicle.class,
						vehiclereport.getVehicleid());
				long max =0;
				if("1".equals(parameterService.findParamValue(ParamterConst.Param_1012,
						org.getId()))){//是比例
					long rates = new Long(parameterService.findParamValue(ParamterConst.Param_1061,
							org.getId()));
					 max = vehilce.getSeatnum() * rates / 100;
					
				}else{//固定个数
					 max = new Long(parameterService.findParamValue(ParamterConst.Param_1061,
							org.getId()));
				}
			if (childnum + ticket.getCarrychildnum() > max) {
				// 免费带儿童数已经超出该班次限定的人数！
				throw new ServiceException("0142");
			}

		} else {
			vehiclereport = checkticketDao.getVehiclereport(newscheduleplan,
					org.getId());
		}
		if (vehiclereport == null) {
			// 检入的班次未报到，不能混检
			throw new ServiceException("0441");
		}

		
		// short newseatno = 0;被交换的座位号
		boolean isaddseatno = false;
		//3010参数 0 换座混检, 1 加座混检. 
		String P3010 = parameterService.findParamValue(ParamterConst.Param_3010, org.getId());
		if (newscheduleplan.getIslinework()) {
			short nextseatno = checkticketDao.getMaxseatno(newscheduleplan
					.getId());
			newseatno = (short) (nextseatno + 1);
		} else {
			// 混检是否见到留位
			String mixtores = parameterService.findParamValue(ParamterConst.Param_3067, org.getId());
			// 如果没有选择座位
			String lastno = "0";
			if (newseatno == 0) {
				Scheduleseats newScheduleseats = null;
				while (newseatno == 0) {
					// 允许检到留位上
					if (mixtores.equals(ParamterConst.COMMON_FLAG.FALG_YES)) {
						// 查询空位 以及留位
						newScheduleseats = checkticketDao.getScheduleseatEmpAndRes(newscheduleplan.getId(), lastno);
					} else {
						// 查询空座
						newScheduleseats = checkticketDao.getScheduleseat(newscheduleplan.getId(), lastno);
					}
					if (newScheduleseats == null) {
						if (P3010.equals(ParamterConst.COMMON_FLAG.FALG_YES)
								&& ismixcheckbyfull.equals(ParamterConst.COMMON_FLAG.FALG_YES)) {
							// 不选择座位号，而且又没有空座，则进行加座位
							newseatno = (short) (newscheduleplan.getSeatnum() + 1);
							isaddseatno = true;
						} else {
							// 该班次已满座不允许混检
							throw new BusinessException("该班次已满座不允许混检！");
						}
					} else {
						if ("0".equals(newScheduleseats.getStatus())) {
							newseatno = newScheduleseats.getSeatno();
							isaddseatno = false;
						} else if ("4".equals(newScheduleseats.getStatus())
								|| "5".equals(newScheduleseats.getStatus())) {
							if (mixtores.equals(ParamterConst.COMMON_FLAG.FALG_YES)) {
								newseatno = newScheduleseats.getSeatno();
								isaddseatno = false;
							}
						} else {
							lastno = newScheduleseats.getSeatno() + "";
						}
					}
				}
			} else {// 如果选择了座位
				Scheduleseats newScheduleseats = checkticketDao.getScheduleseats(newscheduleplan.getId(), newseatno,
						newscheduleplan.getDepartdate());
				if (newScheduleseats != null) {
					// 如果选择的座位是留位
					if (newScheduleseats.getStatus().equals("5") || newScheduleseats.getStatus().equals("4")) {
						// 判断是否允许检到留位上
						if (mixtores.equals(ParamterConst.COMMON_FLAG.FALG_YES)) {
							newseatno = newScheduleseats.getSeatno();
						} else {
							// 查询空座
							newScheduleseats = checkticketDao.getScheduleseat(newscheduleplan.getId(), lastno);
						}
						// 如果选择的是已售的座位
					} else if (newScheduleseats.getStatus().equals("2")) {
						// 是否允许换座
						if ("0".equals(P3010)) {
							isaddseatno = false;
						} else {
							// 该班次已满座不允许混检
							throw new BusinessException("该座位已售,不允许换座混检！");
						}
					} else if (newScheduleseats.getStatus().equals("7")) {
						throw new BusinessException("该座位已检不允许混检！");
					}
					// 满座
				} else {
					// 如果不允许满座混检
					if (ParamterConst.COMMON_FLAG.FALG_NO.equals(ismixcheckbyfull)) {
						if (newscheduleplan.getSeatnum() == newscheduleplan.getSoldeatnum()
								|| (newscheduleplan.getSeatnum() - newscheduleplan.getSoldeatnum()
										- newscheduleplan.getAutocancelreserveseatnum()
										- newscheduleplan.getFixedreserveseatnum()) <= 0) {
							// 该班次已没有空位，不允许混检！
							throw new ServiceException("0356");
						}
					} else {
						if (ParamterConst.COMMON_FLAG.FALG_YES.equals(P3010)) {
							newseatno = (short) (newscheduleplan.getSeatnum() + 1);
							isaddseatno = true;
						} else {
							throw new ServiceException("0356");
						}
					}
				}
			}
		}
		Userinfo userinfo =(Userinfo) checkticketDao.get(Userinfo.class, checkedby);
		// 以下开始更新
		// 重新查询并锁住旧的座位信息
		Scheduleseats oldscheduleseats = checkticketDao.getScheduleseats(
				ticket.getScheduleplanid(), ticket.getSeatno());
		Scheduleseats newscheduleseats = null;
		Ticketsell oldTicketsell = null;

		// 不是加座，才查询座位表
		if (!newscheduleplan.getIslinework() &&  !isaddseatno) {
			// 重新查询并锁住新的座位信息
			newscheduleseats = checkticketDao.getScheduleseats(
					newscheduleplan.getId(), newseatno);
			//查询该座位的预留信息并锁住
			Seatreserve seatreserve = checkticketDao.getSeatreserve(newscheduleplan.getId(),newseatno);
			if(seatreserve!= null){
				seatreserve.setSellstate("C");
				checkticketDao.merge(seatreserve);
			}
			
			//新座位已检
			if ("7".equals(newscheduleseats.getStatus())) {
				// 检入班次的座位已检
				throw new ServiceException("0335");
			}
			// 座位状态：0空位、1锁定、2已售、3固定留位、4自动取消留位、5不自动取消留位
			if ((!newscheduleplan.getIslinework())
					&& ("2".equals(newscheduleseats.getStatus()))) {
				oldTicketsell = checkticketDao.getTicket(
						newscheduleplan.getId(), newseatno);
				//新座位已检
				if (oldTicketsell.getIschecked()) {
					// 检入班次的座位已检
					throw new ServiceException("0335");
				}

				isstop = false;
				List<Ticketprice> oldticketpricelist = oldscheduleplan
						.getTicketpricelist();
				for (Ticketprice otp : oldticketpricelist) {
					if (oldTicketsell.getReachstationid() == otp
							.getReachstationid()) {
						isstop = true;
						break;
					}
				}
				if (!isstop && almix.equals(ParamterConst.COMMON_FLAG.FALG_YES)) {
					if (almix.equals(ParamterConst.COMMON_FLAG.FALG_YES)) {
						Ticketprice tp = newTicketprice(newscheduleplan,
								oldticketprice, ticket, checkedby);
						if (tp != null) {
							newticketprice.add(tp);
						} else {
							// 检入班次没有该车票的停靠站点！
							throw new ServiceException("0135");
						}
					} else {
						// 检入班次没有该车票的停靠站点！
						throw new ServiceException("0135");
					}
				}

//				oldTicketsell.setSeatno((short) (newscheduleplan.getSeatnum() + 1));
//				checkticketDao.merge(oldTicketsell);
//				checkticketDao.getEntityManager().flush();
			}
		}else{
			//加座或者是流水班
			oldTicketsell = checkticketDao.getTicket(newscheduleplan.getId(), newseatno);
			newscheduleseats = checkticketDao.getScheduleseats(newscheduleplan.getId(), newseatno);
		}
		if(TestParams.getNewest().mixCheck == 1){
			SystemFactory.markRtException();
		}
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		if (oldscheduleplan.getWorktype().equals("3") || 
				newscheduleplan.getWorktype().equals("3") ){
			//联网配载班次不允许混检
			//throw new ServiceException("0462");
			//MethodResult res = new MethodResult();
			Organization organization = (Organization) checkticketDao
					.get(Organization.class, newscheduleplan.getOrgid());
			Station departstation = (Station) checkticketDao
					.get(Station.class, ticket.getDepartstationid());
			Station reachstation = (Station) checkticketDao.get(
					Station.class, ticket.getReachstationid());
			MixCheckParam mp=new MixCheckParam();
			mp.setDepartstationcode(departstation.getCode());
			mp.setNewdepartdate(newscheduleplan.getDepartdate());
			mp.setNewspsynccode(newscheduleplan.getSynccode());
			mp.setNewseatno(newseatno);
			mp.setCreateby(userinfo.getName());
			mp.setOlddepartdate(oldscheduleplan.getDepartdate());
			mp.setOldseatno(oldseatno);
			mp.setOldspsynccode(oldscheduleplan.getSynccode());
			if(oldTicketsell!=null){
				mp.setOldticketno(oldTicketsell.getTicketno());
			}
			String remark=checkticketDao.qryTicketHint(ticket.getId());
			mp.setRemark(remark);
			mp.setTickettype(ticket.getTickettype());
			mp.setOrgcode(org.getCode());
			mp.setReachstationcode(reachstation.getCode());
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!oldticketno", ticket.getTicketno()));
			TicketMixChange tmc = (TicketMixChange) checkticketDao.uniqueResult(TicketMixChange.class, propertyFilters);
			//若存在网售票混检记录，则需要先转成新票票号
			if(tmc!=null){
				mp.setTicketno(tmc.getTicketno());
			}else{
				mp.setTicketno(ticket.getTicketno());
			}

			mp.setDeparttime(newschedulestatus.getDeparttime());
			
//				
//				CenterCheckTicketService checkTicketService = getCenterCheckTicketService(res, organization);
//				if (checkTicketService != null) {
//					mp=checkTicketService.mixCheckTicket(mp);
//					if(mp.getResult()!=1){
//						// 该班次已没有空位，不允许混检！
//						throw new ServiceException("中心提示:"+mp.getResultMsg()+".","0356");
//					}
//				}
	
			Organization centreOrg = organizationService.getDirectlyParentOrg(organization);
			if (centreOrg == null) {
				mp.setResult(insideInvokFalse);
				mp.setResultMsg("无法连接中心服务器:找不到" + organization.getName()+ "的上级机构");
			}
			
			Map<String, String> requestMap = new HashMap<String, String>();
			requestMap.put("mixCheckParam", JsonUtil.toFormatString(mp));
			requestMap.put("transactionid", CurrentUtil.getFlash("transactionid"));

			CurrentUtil.setFlash("remoteurl",centreOrg.getServersaddress());
			if(TestParams.getNewest().mixCheck == 2){
				SystemFactory.markRtException();
			}
			String resultstr = RpcUtil.remoteCall(centreOrg.getServersaddress(), RemoteApi.MIX_CHECK_TICKET, requestMap);		
			mp = JsonUtil.parseObject(resultstr, MixCheckParam.class);
			if(mp.getResult() != mp.SUCCESS){
				throw new Exception(mp.getResultMsg());
			}
		}
		System.out.println("票号="+ticket.getTicketno()+"进行了混检操作---");
		ticket.setBuspark(newschedulestatus.getBuspark());
		Station checkstation = new Station();
		checkstation.setId(checkstationid);
		ticket.setCheckstation(checkstation);
		//Userinfo userinfo = new Userinfo();
		//userinfo.setId(checkedby);
		ticket.setCheckedby(userinfo);
		ticket.setChecktime(new Date());
		ticket.setDepartdate(newschedulestatus.getDepartdate());
		ticket.setDeparttime(newschedulestatus.getDeparttime());
		ticket.setIschecked(true);
		// 混检后发车站变为检票站
		// ticket.setDepartstationid(checkstationid);
		ticket.setSeatno(newseatno);
		ticket.setScheduleid(newschedulestatus.getScheduleid());
		ticket.setScheduleplanid(newscheduleplan.getId());
		ticket.setTicketentrance(newschedulestatus.getTicketentrance());
		ticket.setUpdateby(checkedby);
		ticket.setUpdatetime(new Date());
		ticket.setVehiclereport(vehiclereport);
		if(ticket.getOlddepartdate()==null){
			ticket.setOlddepartdate(oldscheduleplan.getDepartdate());	
		}
		
		Ticketmixcheck mixticket = new Ticketmixcheck();
		mixticket.setOldscheduleplanid(oldscheduleplan.getId());
		mixticket.setOlddepartdate(oldscheduleplan.getDepartdate());
		mixticket.setOlddeparttime(olddeparttime);
		mixticket.setOldscheduleid(oldscheduleplan.getScheduleid());
		mixticket.setOldseatno(oldseatno);
		//更新原来的混检信息
		List<Ticketmixcheck> mlist=checkticketDao.qryTicketmixchecks(ticket.getId());
		if(mlist!=null){
			for(Ticketmixcheck t:mlist){
				t.setIsactive(false);
				t.setUpdateby(checkedby);
				t.setUpdatetime(new Date());
				checkticketDao.merge(t);
			}
			if(mlist.size()>0){
				Ticketmixcheck tk=mlist.get(0);
				mixticket.setOldscheduleplanid(tk.getOldscheduleplanid());
				mixticket.setOlddepartdate(tk.getOlddepartdate());
				mixticket.setOlddeparttime(tk.getOlddeparttime());
				mixticket.setOldscheduleid(tk.getOldscheduleid());
				mixticket.setOldseatno(tk.getOldseatno());
				
			}
		}
		mixticket.setOrgid(org.getId());
		mixticket.setCreateby(checkedby);
		mixticket.setCreatetime(new Date());
		mixticket.setScheduleplanid(newscheduleplan.getId());
		mixticket.setTicketno(ticket.getTicketno());
		mixticket.setNewdepartdate(newscheduleplan.getDepartdate());
		mixticket.setNewdeparttime(newschedulestatus.getDeparttime());
		mixticket.setNewscheduleid(newscheduleplan.getScheduleid());
		mixticket.setNewseatno(newseatno);
		mixticket.setIsactive(true);
		mixticket.setUpdateby(checkedby);
		mixticket.setUpdatetime(new Date());
		if (oldTicketsell != null) {
			mixticket.setOldticketno(oldTicketsell.getTicketno());// 原非空位票号
		}
		mixticket.setTicketsellid(ticket.getId());

		// 流水班->流水班
		if (oldscheduleplan.getIslinework() && newscheduleplan.getIslinework()) {

			for (Ticketprice ticketprice : oldticketprice) {
				if (ticketprice.getSeattype().equals(ticket.getSeattype())) {
					ticketprice.setSoldeatnum((short) (ticketprice
							.getSoldeatnum() - 1));
					if (ticketprice.getSoldeatnum() < 0) {
						ticketprice.setSoldeatnum((short) 0);
					}
				}
			}

			ticket.setIslinework(true);
			oldscheduleplan.setSoldeatnum((short) (oldscheduleplan
					.getSoldeatnum() - 1));
			if (oldscheduleplan.getSoldeatnum() < 0) {
				oldscheduleplan.setSoldeatnum((short) 0);
			}
			oldscheduleplan.setUpdateby(checkedby);
			oldscheduleplan.setUpdatetime(new Date());
			newscheduleplan.setSoldeatnum((short) (newscheduleplan
					.getSoldeatnum() + 1));
			if(newscheduleplan.getSoldeatnum()>newscheduleplan.getSeatnum()){
				newscheduleplan.setSeatnum(newscheduleplan.getSoldeatnum());
			}
			//已售数暂时改为跟计划表一致
			for (Ticketprice ticketprice : newticketprice) {
				if (ticketprice.getSeattype().equals(ticket.getSeattype())) {
					ticketprice.setSeatnum(newscheduleplan.getSeatnum());
					ticketprice.setSoldeatnum(newscheduleplan.getSoldeatnum());
				}
			}
			oldscheduleplan.setCarrychildnum((short) (oldscheduleplan.getCarrychildnum()-ticket.getCarrychildnum()));
			newscheduleplan.setCarrychildnum((short) (newscheduleplan.getCarrychildnum()+ticket.getCarrychildnum()));
			newscheduleplan.setUpdateby(checkedby);
			newscheduleplan.setUpdatetime(new Date());
			Vehicle vehicle = (Vehicle) checkticketDao.get(Vehicle.class,
					vehiclereport.getVehicleid());
			mixticket.setActualvehicleseatnum(vehicle.getSeatnum());
			// 非流水班混检(0混检到空位 1加座混检 2混检到非空位)，3流水班混检
			mixticket.setType("3");
			checkticketDao.merge(mixticket);
			checkticketDao.merge(oldscheduleplan);
			checkticketDao.merge(newscheduleplan);
			checkticketDao.merge(ticket);
			if(TestParams.getNewest().mixCheck == 3){
				SystemFactory.markRtException();
			}
			
			//主票检票成功后，执行儿童票检票
			if(childTicket != null){
				childTicket.setSeatno(ticket.getSeatno());
				childTicket.setScheduleid(ticket.getScheduleid());
				childTicket.setScheduleplanid(ticket.getScheduleplanid());
				childTicket.setDepartdate(ticket.getDepartdate());
				childTicket.setCheckstation(ticket.getCheckstation());
				childTicket.setCheckedby(ticket.getCheckedby());
				childTicket.setChecktime(ticket.getChecktime());
				childTicket.setUpdateby(ticket.getUpdateby());
				childTicket.setUpdatetime(ticket.getUpdatetime());
				childTicket.setIschecked(true);
				childTicket.setVehiclereport(ticket.getVehiclereport());
				ticketDao.merge(childTicket);
				
				CarryChild carryChild = ticketDao.findCarryChildByChildid(childTicket.getId());
				carryChild.setUpdateby(childTicket.getUpdateby());
				carryChild.setUpdatetime(childTicket.getUpdatetime());
	 			carryChild.setRemark(carryChild.getRemark() + ",混检" + util.DateUtils.formatDatetime(childTicket.getUpdatetime()));
	 			ticketDao.merge(carryChild);
			}
			
			return ticket;
		}
		// 非流水班->流水班
		if ((!oldscheduleplan.getIslinework())
				&& newscheduleplan.getIslinework()) {
			for (Ticketprice ticketprice : oldticketprice) {
				if (ticketprice.getSeattype().equals(ticket.getSeattype())) {
					if(oldscheduleseats.getStatus().equals("2")){
						ticketprice.setSoldeatnum((short) (ticketprice
								.getSoldeatnum() - 1));					
					}else if(oldscheduleseats.getStatus().equals("3")){
						ticketprice.setFixedreserveseatnum((short) (ticketprice.getFixedreserveseatnum()- 1));								
					}else if(oldscheduleseats.getStatus().equals("4")){
						ticketprice.setAutocancelreserveseatnum((short) (ticketprice.getAutocancelreserveseatnum()- 1));
					}else if(oldscheduleseats.getStatus().equals("5")){
						ticketprice.setUnautocancelreserveseatnum((short)(ticketprice.getUnautocancelreserveseatnum()-1));
					}
					if (ticketprice.getSoldeatnum() < 0) {
						ticketprice.setSoldeatnum((short) 0);
					}
				}
			}

			//3固定留位、4自动取消留位、5不自动取消留位
			if(oldscheduleseats.getStatus().equals("2")){
				oldscheduleplan.setSoldeatnum((short) (oldscheduleplan
						.getSoldeatnum() - 1));					
			}else if(oldscheduleseats.getStatus().equals("3")){
				oldscheduleplan.setFixedreserveseatnum((short) (oldscheduleplan.getFixedreserveseatnum()- 1));								
			}else if(oldscheduleseats.getStatus().equals("4")){
				oldscheduleplan.setAutocancelreserveseatnum((short) (oldscheduleplan.getAutocancelreserveseatnum()- 1));
			}else if(oldscheduleseats.getStatus().equals("5")){
				oldscheduleplan.setUnautocancelreserveseatnum((short)(oldscheduleplan.getUnautocancelreserveseatnum()-1));
			}

			oldscheduleseats.setStatus("0");// 空座
			oldscheduleseats.setTickettype("0");
			oldscheduleseats.setUpdateby(checkedby);
			oldscheduleseats.setUpdatetime(new Date());
			ticket.setIslinework(true);
			if (oldscheduleplan.getSoldeatnum() < 0) {
				oldscheduleplan.setSoldeatnum((short) 0);
			}
			oldscheduleplan.setCarrychildnum((short) (oldscheduleplan.getCarrychildnum()-ticket.getCarrychildnum()));
			newscheduleplan.setCarrychildnum((short) (newscheduleplan.getCarrychildnum()+ticket.getCarrychildnum()));
			oldscheduleplan.setUpdateby(checkedby);
			oldscheduleplan.setUpdatetime(new Date());
			newscheduleplan.setSoldeatnum((short) (newscheduleplan
					.getSoldeatnum() + 1));
			if(newscheduleplan.getSoldeatnum()>newscheduleplan.getSeatnum()){
				newscheduleplan.setSeatnum(newscheduleplan.getSoldeatnum());
			}
			for (Ticketprice ticketprice : newticketprice) {
				if (ticketprice.getSeattype().equals(ticket.getSeattype())) {
					ticketprice.setSeatnum(newscheduleplan.getSeatnum());
					ticketprice.setSoldeatnum(newscheduleplan.getSoldeatnum());
				}
			}
			newscheduleplan.setUpdateby(checkedby);
			newscheduleplan.setUpdatetime(new Date());
			Vehicle vehicle = (Vehicle) checkticketDao.get(Vehicle.class,
					vehiclereport.getVehicleid());
			mixticket.setActualvehicleseatnum(vehicle.getSeatnum());
			// 非流水班混检(0混检到空位 1加座混检 2混检到非空位)，3流水班混检
			mixticket.setType("0");
			checkticketDao.merge(mixticket);
			checkticketDao.merge(oldscheduleseats);
			checkticketDao.merge(oldscheduleplan);
			checkticketDao.merge(newscheduleplan);
			checkticketDao.merge(ticket);
			if(TestParams.getNewest().mixCheck == 3){
				SystemFactory.markRtException();
			}
			
			//主票检票成功后，执行儿童票检票
			if(childTicket != null){
				childTicket.setSeatno(ticket.getSeatno());
				childTicket.setScheduleid(ticket.getScheduleid());
				childTicket.setScheduleplanid(ticket.getScheduleplanid());
				childTicket.setDepartdate(ticket.getDepartdate());
				childTicket.setCheckstation(ticket.getCheckstation());
				childTicket.setCheckedby(ticket.getCheckedby());
				childTicket.setChecktime(ticket.getChecktime());
				childTicket.setUpdateby(ticket.getUpdateby());
				childTicket.setUpdatetime(ticket.getUpdatetime());
				childTicket.setIschecked(true);
				childTicket.setVehiclereport(ticket.getVehiclereport());
				ticketDao.merge(childTicket);
				
				CarryChild carryChild = ticketDao.findCarryChildByChildid(childTicket.getId());
				carryChild.setUpdateby(childTicket.getUpdateby());
				carryChild.setUpdatetime(childTicket.getUpdatetime());
	 			carryChild.setRemark(carryChild.getRemark() + ",混检" + util.DateUtils.formatDatetime(childTicket.getUpdatetime()));
	 			ticketDao.merge(carryChild);
			}
			
			return ticket;
		}
		/*
		 * if (!newscheduleseats.getStatus().equals("0")) { // 检入班次的座位信息已经发生变化，请重新检入！ throw new
		 * ServiceException("0138"); }
		 */
		// 流水班->非流水班
		if (oldscheduleplan.getIslinework()
				&& (!newscheduleplan.getIslinework())) {
			// 加座位
			if (isaddseatno) {
				for (Ticketprice ticketprice : oldticketprice) {
					if (ticketprice.getSeattype().equals(ticket.getSeattype())) {
						ticketprice.setSoldeatnum((short) (ticketprice
								.getSoldeatnum() - 1));
						if (ticketprice.getSoldeatnum() < 0) {
							ticketprice.setSoldeatnum((short) 0);
						}
					}
				}/*
				for (Ticketprice ticketprice : newticketprice) {
					if (ticketprice.getSeattype().equals(ticket.getSeattype())) {
						ticketprice.setSoldeatnum((short) (ticketprice
								.getSoldeatnum() + 1));
					}
				}*/
				Scheduleseats addScheduleseats = new Scheduleseats();
				addScheduleseats.setCreateby(checkedby);
				addScheduleseats.setCreatetime(new Date());
				addScheduleseats.setDepartdate(newscheduleplan.getDepartdate());
				addScheduleseats.setOrgid(newscheduleplan.getOrgid());
				addScheduleseats.setScheduleid(newscheduleplan.getScheduleid());
				addScheduleseats.setSeatno(newseatno);
				addScheduleseats.setSeattype(ticket.getSeattype());
				addScheduleseats.setStatus("7");// 已检
				addScheduleseats.setTickettype(ticket.getTickettype());
				addScheduleseats.setUpdateby(checkedby);
				addScheduleseats.setUpdatetime(new Date());
				addScheduleseats.setScheduleplan(newscheduleplan);
				oldscheduleplan.setSoldeatnum((short) (oldscheduleplan
						.getSoldeatnum() - 1));
				if (oldscheduleplan.getSoldeatnum() < 0) {
					oldscheduleplan.setSoldeatnum((short) 0);
				}
				oldscheduleplan.setUpdateby(checkedby);
				oldscheduleplan.setUpdatetime(new Date());
				newscheduleplan.setSeatnum((short) (newscheduleplan.getSeatnum()+1));
				newscheduleplan.setSoldeatnum((short) (newscheduleplan
						.getSoldeatnum() + 1));
				//已售数暂时改为跟计划表一致
				for (Ticketprice ticketprice : newticketprice) {
					ticketprice.setSeatnum((short) (ticketprice.getSeatnum()+1));
					if (ticketprice.getSeattype().equals(ticket.getSeattype())) {
						ticketprice.setSoldeatnum(newscheduleplan.getSoldeatnum());
					}
				}
				oldscheduleplan.setCarrychildnum((short) (oldscheduleplan.getCarrychildnum()-ticket.getCarrychildnum()));
				newscheduleplan.setCarrychildnum((short) (newscheduleplan.getCarrychildnum()+ticket.getCarrychildnum()));
				newscheduleplan.setUpdateby(checkedby);
				newscheduleplan.setUpdatetime(new Date());
				// 非流水班混检(0混检到空位 1加座混检 2混检到非空位)，3流水班混检
				mixticket.setType("1");
				checkticketDao.merge(addScheduleseats);
				checkticketDao.merge(mixticket); // checkticketDao.merge(newscheduleseats);
				checkticketDao.merge(oldscheduleplan);
				checkticketDao.merge(newscheduleplan);
				checkticketDao.merge(ticket);
				if(TestParams.getNewest().mixCheck == 3){
					SystemFactory.markRtException();
				}
				
				//主票检票成功后，执行儿童票检票
				if(childTicket != null){
					childTicket.setSeatno(ticket.getSeatno());
					childTicket.setScheduleid(ticket.getScheduleid());
					childTicket.setScheduleplanid(ticket.getScheduleplanid());
					childTicket.setDepartdate(ticket.getDepartdate());
					childTicket.setCheckstation(ticket.getCheckstation());
					childTicket.setCheckedby(ticket.getCheckedby());
					childTicket.setChecktime(ticket.getChecktime());
					childTicket.setUpdateby(ticket.getUpdateby());
					childTicket.setUpdatetime(ticket.getUpdatetime());
					childTicket.setIschecked(true);
					childTicket.setVehiclereport(ticket.getVehiclereport());
					ticketDao.merge(childTicket);
					
					CarryChild carryChild = ticketDao.findCarryChildByChildid(childTicket.getId());
					carryChild.setUpdateby(childTicket.getUpdateby());
					carryChild.setUpdatetime(childTicket.getUpdatetime());
		 			carryChild.setRemark(carryChild.getRemark() + ",混检" + util.DateUtils.formatDatetime(childTicket.getUpdatetime()));
		 			ticketDao.merge(carryChild);
				}
				
				return ticket;
			}
			// 若是检到空位上
			else if (oldTicketsell == null) {
				for (Ticketprice ticketprice : oldticketprice) {
					if (ticketprice.getSeattype().equals(ticket.getSeattype())) {
						ticketprice.setSoldeatnum((short) (ticketprice
								.getSoldeatnum() - 1));
						if (ticketprice.getSoldeatnum() < 0) {
							ticketprice.setSoldeatnum((short) 0);
						}
					}
				}
				for (Ticketprice ticketprice : newticketprice) {
					if(newscheduleseats.getStatus().equals("3")){
						ticketprice.setFixedreserveseatnum((short) (ticketprice.getFixedreserveseatnum()- 1));								
					}else if(newscheduleseats.getStatus().equals("4")){
						ticketprice.setAutocancelreserveseatnum((short) (ticketprice.getAutocancelreserveseatnum()- 1));
					}else if(newscheduleseats.getStatus().equals("5")){
						ticketprice.setUnautocancelreserveseatnum((short)(ticketprice.getUnautocancelreserveseatnum()-1));
					}
					/*if (ticketprice.getSeattype().equals(ticket.getSeattype())) {
						ticketprice.setSoldeatnum((short) (ticketprice
								.getSoldeatnum() + 1));
					}*/
				}
				if(newscheduleseats.getStatus().equals("3")){
					newscheduleplan.setFixedreserveseatnum((short) (newscheduleplan.getFixedreserveseatnum()- 1));								
				}else if(newscheduleseats.getStatus().equals("4")){
					newscheduleplan.setAutocancelreserveseatnum((short) (newscheduleplan.getAutocancelreserveseatnum()- 1));
				}else if(newscheduleseats.getStatus().equals("5")){
					newscheduleplan.setUnautocancelreserveseatnum((short)(newscheduleplan.getUnautocancelreserveseatnum()-1));
				}
				newscheduleseats.setStatus("7");// 已检
				newscheduleseats.setTickettype(ticket.getTickettype());
				newscheduleseats.setUpdateby(checkedby);
				newscheduleseats.setUpdatetime(new Date());
				oldscheduleplan.setSoldeatnum((short) (oldscheduleplan
						.getSoldeatnum() - 1));
				if (oldscheduleplan.getSoldeatnum() < 0) {
					oldscheduleplan.setSoldeatnum((short) 0);
				}
				oldscheduleplan.setUpdateby(checkedby);
				oldscheduleplan.setUpdatetime(new Date());
				newscheduleplan.setSoldeatnum((short) (newscheduleplan
						.getSoldeatnum() + 1));
				//已售数暂时改为跟计划表一致
				for (Ticketprice ticketprice : newticketprice) {
					if (ticketprice.getSeattype().equals(ticket.getSeattype())) {
						ticketprice.setSoldeatnum(newscheduleplan.getSoldeatnum());
					}
				}
				oldscheduleplan.setCarrychildnum((short) (oldscheduleplan.getCarrychildnum()-ticket.getCarrychildnum()));
				newscheduleplan.setCarrychildnum((short) (newscheduleplan.getCarrychildnum()+ticket.getCarrychildnum()));
				newscheduleplan.setUpdateby(checkedby);
				newscheduleplan.setUpdatetime(new Date());
				// 非流水班混检(0混检到空位 1加座混检 2混检到非空位)，3流水班混检
				mixticket.setType("3");
				checkticketDao.merge(mixticket);
				checkticketDao.merge(oldscheduleplan);
				checkticketDao.merge(newscheduleseats);
				checkticketDao.merge(newscheduleplan);
				checkticketDao.merge(ticket);
				if(TestParams.getNewest().mixCheck == 3){
					SystemFactory.markRtException();
				}
				
				//主票检票成功后，执行儿童票检票
				if(childTicket != null){
					childTicket.setSeatno(ticket.getSeatno());
					childTicket.setScheduleid(ticket.getScheduleid());
					childTicket.setScheduleplanid(ticket.getScheduleplanid());
					childTicket.setDepartdate(ticket.getDepartdate());
					childTicket.setCheckstation(ticket.getCheckstation());
					childTicket.setCheckedby(ticket.getCheckedby());
					childTicket.setChecktime(ticket.getChecktime());
					childTicket.setUpdateby(ticket.getUpdateby());
					childTicket.setUpdatetime(ticket.getUpdatetime());
					childTicket.setIschecked(true);
					childTicket.setVehiclereport(ticket.getVehiclereport());
					ticketDao.merge(childTicket);
					
					CarryChild carryChild = ticketDao.findCarryChildByChildid(childTicket.getId());
					carryChild.setUpdateby(childTicket.getUpdateby());
					carryChild.setUpdatetime(childTicket.getUpdatetime());
		 			carryChild.setRemark(carryChild.getRemark() + ",混检" + util.DateUtils.formatDatetime(childTicket.getUpdatetime()));
		 			ticketDao.merge(carryChild);
				}
				
				return ticket;
			}
		}
		// 非流水班->非流水班
		if ((!oldscheduleplan.getIslinework())
				&& (!newscheduleplan.getIslinework())) {
			ticket.setIslinework(false);
			// 加座位
			if (isaddseatno) {
				if(P3010.equals("0")){
					//该班次已满座不允许混检
					throw new BusinessException("该班次已检满,不允许换座混检！");
				}
				for (Ticketprice ticketprice : newticketprice) {
					if (ticketprice.getSeattype().equals(ticket.getSeattype())) {
						ticketprice.setSeatnum((short) (ticketprice
								.getSeatnum() + 1));
						/*ticketprice.setSoldeatnum((short) (ticketprice
								.getSoldeatnum() + 1));*/
					}
				}
				// 票价分项以新的为准
				changeTicketFee(newticketprice, ticket);
				//3固定留位、4自动取消留位、5不自动取消留位
				if(oldscheduleseats.getStatus().equals("2")){
					oldscheduleplan.setSoldeatnum((short) (oldscheduleplan
							.getSoldeatnum() - 1));					
				}else if(oldscheduleseats.getStatus().equals("3")){
					oldscheduleplan.setFixedreserveseatnum((short) (oldscheduleplan.getFixedreserveseatnum()- 1));								
				}else if(oldscheduleseats.getStatus().equals("4")){
					oldscheduleplan.setAutocancelreserveseatnum((short) (oldscheduleplan.getAutocancelreserveseatnum()- 1));
				}else if(oldscheduleseats.getStatus().equals("5")){
					oldscheduleplan.setUnautocancelreserveseatnum((short)(oldscheduleplan.getUnautocancelreserveseatnum()-1));
				}
				for (Ticketprice ticketprice : oldticketprice) {
					if (ticketprice.getSeattype().equals(ticket.getSeattype())) {	
						ticketprice.setSoldeatnum(oldscheduleplan.getSoldeatnum());
						if (ticketprice.getSoldeatnum() < 0) {
							ticketprice.setSoldeatnum((short) 0);
						}
					}
				}
				Scheduleseats addScheduleseats = new Scheduleseats();
				addScheduleseats.setCreateby(checkedby);
				addScheduleseats.setCreatetime(new Date());
				addScheduleseats.setDepartdate(newscheduleplan.getDepartdate());
				addScheduleseats.setOrgid(newscheduleplan.getOrgid());
				addScheduleseats.setScheduleid(newscheduleplan.getScheduleid());
				addScheduleseats.setSeatno(newseatno);
				addScheduleseats.setSeattype(ticket.getSeattype());
				addScheduleseats.setStatus("7");// 已检
				addScheduleseats.setTickettype(ticket.getTickettype());
				addScheduleseats.setUpdateby(checkedby);
				addScheduleseats.setUpdatetime(new Date());
				addScheduleseats.setScheduleplan(newscheduleplan);
				oldscheduleseats.setStatus("0");// 空座
				oldscheduleseats.setTickettype(null);
				oldscheduleseats.setUpdateby(checkedby);
				oldscheduleseats.setUpdatetime(new Date());

				if (oldscheduleplan.getSoldeatnum() < 0) {
					oldscheduleplan.setSoldeatnum((short) 0);
				}
				oldscheduleplan.setUpdateby(checkedby);
				oldscheduleplan.setUpdatetime(new Date());
				newscheduleplan.setSeatnum((short) (newscheduleplan
						.getSeatnum() + 1));
				newscheduleplan.setSoldeatnum((short) (newscheduleplan
						.getSoldeatnum() + 1));
				//已售数暂时改为跟计划表一致
				for (Ticketprice ticketprice : newticketprice) {
					ticketprice.setSeatnum(newscheduleplan.getSeatnum());
					if (ticketprice.getSeattype().equals(ticket.getSeattype())) {
						ticketprice.setSoldeatnum(newscheduleplan.getSoldeatnum());
					}
				}				
				oldscheduleplan.setCarrychildnum((short) (oldscheduleplan.getCarrychildnum()-ticket.getCarrychildnum()));
				newscheduleplan.setCarrychildnum((short) (newscheduleplan.getCarrychildnum()+ticket.getCarrychildnum()));
				newscheduleplan.setUpdateby(checkedby);
				newscheduleplan.setUpdatetime(new Date());
				// mixticket.setScheduleplanid(newscheduleplan.getId());
				// 非流水班混检(0混检到空位 1加座混检 2混检到非空位)，3流水班混检
				mixticket.setType("1");
				mixticket.setActualvehicleseatnum(newscheduleplan.getSeatnum());				
				//newscheduleplan.getScheduleseatslist().add(addScheduleseats);
				checkticketDao.merge(addScheduleseats);
				//checkticketDao.merge(newscheduleplan);				
				checkticketDao.merge(mixticket);
				checkticketDao.merge(oldscheduleseats);
				checkticketDao.merge(oldscheduleplan);
				ticket=(Ticketsell) checkticketDao.merge(ticket);
				if(TestParams.getNewest().mixCheck == 3){
					SystemFactory.markRtException();
				}
				
				//主票检票成功后，执行儿童票检票
				if(childTicket != null){
					childTicket.setSeatno(ticket.getSeatno());
					childTicket.setScheduleid(ticket.getScheduleid());
					childTicket.setScheduleplanid(ticket.getScheduleplanid());
					childTicket.setDepartdate(ticket.getDepartdate());
					childTicket.setCheckstation(ticket.getCheckstation());
					childTicket.setCheckedby(ticket.getCheckedby());
					childTicket.setChecktime(ticket.getChecktime());
					childTicket.setUpdateby(ticket.getUpdateby());
					childTicket.setUpdatetime(ticket.getUpdatetime());
					childTicket.setIschecked(true);
					childTicket.setVehiclereport(ticket.getVehiclereport());
					ticketDao.merge(childTicket);
					
					CarryChild carryChild = ticketDao.findCarryChildByChildid(childTicket.getId());
					carryChild.setUpdateby(childTicket.getUpdateby());
					carryChild.setUpdatetime(childTicket.getUpdatetime());
		 			carryChild.setRemark(carryChild.getRemark() + ",混检" + util.DateUtils.formatDatetime(childTicket.getUpdatetime()));
		 			ticketDao.merge(carryChild);
				}
				
				return ticket;
			}
			// 若是检到空位、留位上
			else if (oldTicketsell == null) {
				for (Ticketprice ticketprice : oldticketprice) {
					if (ticketprice.getSeattype().equals(ticket.getSeattype())) {
						ticketprice.setSoldeatnum((short) (ticketprice
								.getSoldeatnum() - 1));
						if (ticketprice.getSoldeatnum() < 0) {
							ticketprice.setSoldeatnum((short) 0);
						}
					}
				}
				for (Ticketprice ticketprice : newticketprice) {
					if(newscheduleseats.getStatus().equals("3")){
						ticketprice.setFixedreserveseatnum((short) (ticketprice.getFixedreserveseatnum()- 1));								
					}else if(newscheduleseats.getStatus().equals("4")){
						ticketprice.setAutocancelreserveseatnum((short) (ticketprice.getAutocancelreserveseatnum()- 1));
					}else if(newscheduleseats.getStatus().equals("5")){
						ticketprice.setUnautocancelreserveseatnum((short)(ticketprice.getUnautocancelreserveseatnum()-1));
					}
					/*if (ticketprice.getSeattype().equals(ticket.getSeattype())) {
						ticketprice.setSoldeatnum((short) (ticketprice
								.getSoldeatnum() + 1));
					}*/
				}
				if(newscheduleseats.getStatus().equals("3")){
					newscheduleplan.setFixedreserveseatnum((short) (newscheduleplan.getFixedreserveseatnum()- 1));								
				}else if(newscheduleseats.getStatus().equals("4")){
					newscheduleplan.setAutocancelreserveseatnum((short) (newscheduleplan.getAutocancelreserveseatnum()- 1));
				}else if(newscheduleseats.getStatus().equals("5")){
					newscheduleplan.setUnautocancelreserveseatnum((short)(newscheduleplan.getUnautocancelreserveseatnum()-1));
				}
				changeTicketFee(newticketprice, ticket);
				newscheduleseats.setStatus("7");// 已售
				newscheduleseats
						.setTickettype(oldscheduleseats.getTickettype());
				newscheduleseats.setUpdateby(checkedby);
				newscheduleseats.setUpdatetime(new Date());
				oldscheduleseats.setStatus("0");// 空座
				oldscheduleseats.setTickettype(null);
				oldscheduleseats.setUpdateby(checkedby);
				oldscheduleseats.setUpdatetime(new Date());
				oldscheduleplan.setSoldeatnum((short) (oldscheduleplan
						.getSoldeatnum() - 1));
				if (oldscheduleplan.getSoldeatnum() < 0) {
					oldscheduleplan.setSoldeatnum((short) 0);
				}
				oldscheduleplan.setUpdateby(checkedby);
				oldscheduleplan.setUpdatetime(new Date());
				newscheduleplan.setSoldeatnum((short) (newscheduleplan
						.getSoldeatnum() + 1));
				//已售数暂时改为跟计划表一致
				for (Ticketprice ticketprice : newticketprice) {
					if (ticketprice.getSeattype().equals(ticket.getSeattype())) {
						ticketprice.setSoldeatnum(newscheduleplan.getSoldeatnum());
					}
				}
				oldscheduleplan.setCarrychildnum((short) (oldscheduleplan.getCarrychildnum()-ticket.getCarrychildnum()));
				newscheduleplan.setCarrychildnum((short) (newscheduleplan.getCarrychildnum()+ticket.getCarrychildnum()));
				newscheduleplan.setUpdateby(checkedby);
				newscheduleplan.setUpdatetime(new Date());
				// 非流水班混检(0混检到空位 1加座混检 2混检到非空位)，3流水班混检
				mixticket.setType("0");
				checkticketDao.merge(mixticket);
				checkticketDao.merge(oldscheduleseats);
				checkticketDao.merge(oldscheduleplan);
				checkticketDao.merge(newscheduleseats);
				checkticketDao.merge(newscheduleplan);
				checkticketDao.merge(ticket);
				if(TestParams.getNewest().mixCheck == 3){
					SystemFactory.markRtException();
				}
				
				//主票检票成功后，执行儿童票检票
				if(childTicket != null){
					childTicket.setSeatno(ticket.getSeatno());
					childTicket.setScheduleid(ticket.getScheduleid());
					childTicket.setScheduleplanid(ticket.getScheduleplanid());
					childTicket.setDepartdate(ticket.getDepartdate());
					childTicket.setCheckstation(ticket.getCheckstation());
					childTicket.setCheckedby(ticket.getCheckedby());
					childTicket.setChecktime(ticket.getChecktime());
					childTicket.setUpdateby(ticket.getUpdateby());
					childTicket.setUpdatetime(ticket.getUpdatetime());
					childTicket.setIschecked(true);
					childTicket.setVehiclereport(ticket.getVehiclereport());
					ticketDao.merge(childTicket);
					
					CarryChild carryChild = ticketDao.findCarryChildByChildid(childTicket.getId());
					carryChild.setUpdateby(childTicket.getUpdateby());
					carryChild.setUpdatetime(childTicket.getUpdatetime());
		 			carryChild.setRemark(carryChild.getRemark() + ",混检" + util.DateUtils.formatDatetime(childTicket.getUpdatetime()));
		 			ticketDao.merge(carryChild);
				}
				
				return ticket;
			} else {
				oldscheduleplan.setCarrychildnum((short) (oldscheduleplan.getCarrychildnum()-ticket.getCarrychildnum()));
				newscheduleplan.setCarrychildnum((short) (newscheduleplan.getCarrychildnum()+ticket.getCarrychildnum()));
				// 交换座位
				changeTicketFee(oldticketprice, oldTicketsell);
				changeTicketFee(newticketprice, ticket);
				for (Schedulestatus ss : oldscheduleplan
						.getSchedulestatuslist()) {
					if (ss.getDepartstationid() == checkstationid) {
						newscheduleseats.setTickettype(oldscheduleseats
								.getTickettype());
						newscheduleseats.setStatus("7");// 已检
						newscheduleseats.setUpdateby(checkedby);
						newscheduleseats.setUpdatetime(new Date());
						oldscheduleseats.setTickettype(newscheduleseats
								.getTickettype());
						oldscheduleseats.setUpdateby(checkedby);
						oldscheduleseats.setUpdatetime(new Date());
						// 非流水班混检(0混检到空位 1加座混检 2混检到非空位)，3流水班混检
						mixticket.setType("2");
						checkticketDao.merge(mixticket);
						checkticketDao.merge(oldscheduleseats);
						checkticketDao.merge(newscheduleseats);
						checkticketDao.merge(ticket);
						oldTicketsell.setScheduleplanid(ss.getScheduleplan()
								.getId());
						oldTicketsell.setBuspark(ss.getBuspark());
						oldTicketsell.setScheduleid(ss.getScheduleid());
						oldTicketsell.setDepartdate(ss.getDepartdate());
						oldTicketsell.setDeparttime(ss.getDeparttime());
						oldTicketsell.setSeatno(oldseatno);
						oldTicketsell.setUpdateby(checkedby);
						oldTicketsell.setUpdatetime(new Date());
						checkticketDao.merge(oldTicketsell);
						if(TestParams.getNewest().mixCheck == 3){
							SystemFactory.markRtException();
						}
						
						//主票检票成功后，执行儿童票检票
						if(childTicket != null){
							childTicket.setSeatno(ticket.getSeatno());
							childTicket.setScheduleid(ticket.getScheduleid());
							childTicket.setScheduleplanid(ticket.getScheduleplanid());
							childTicket.setDepartdate(ticket.getDepartdate());
							childTicket.setCheckstation(ticket.getCheckstation());
							childTicket.setCheckedby(ticket.getCheckedby());
							childTicket.setChecktime(ticket.getChecktime());
							childTicket.setUpdateby(ticket.getUpdateby());
							childTicket.setUpdatetime(ticket.getUpdatetime());
							childTicket.setIschecked(true);
							childTicket.setVehiclereport(ticket.getVehiclereport());
							ticketDao.merge(childTicket);
							
							CarryChild carryChild = ticketDao.findCarryChildByChildid(childTicket.getId());
							carryChild.setUpdateby(childTicket.getUpdateby());
							carryChild.setUpdatetime(childTicket.getUpdatetime());
				 			carryChild.setRemark(carryChild.getRemark() + ",混检" + util.DateUtils.formatDatetime(childTicket.getUpdatetime()));
				 			ticketDao.merge(carryChild);
						}
						
						return ticket;
					}
				}

			}
		}
		if(TestParams.getNewest().mixCheck == 3){
			SystemFactory.markRtException();
		}
		return ticket;
	}

	private Ticketprice newTicketprice(Scheduleplan newscheduelplan,
			List<Ticketprice> oldticketprices, Ticketsell ts, long updateby) {
		Date now = new Date();
		Ticketprice tp = new Ticketprice();
		for (Ticketprice otp : oldticketprices) {
			if (otp.getDepartstationid() == ts.getDepartstationid()
					&& otp.getReachstationid() == ts.getReachstationid()
					&& otp.getSeattype().equals(ts.getSeattype())) {
				tp.setAutocancelreserveseatnum(newscheduelplan
						.getAutocancelreserveseatnum());
				tp.setUnautocancelreserveseatnum(newscheduelplan.getUnautocancelreserveseatnum());
				tp.setFixedreserveseatnum(newscheduelplan.getFixedreserveseatnum());
				tp.setBalancedistance(ts.getDistance().intValue());
				tp.setCreateby(updateby);
				tp.setCreatetime(now);
				tp.setDepartdate(newscheduelplan.getDepartdate());
				tp.setDepartstationid(ts.getDepartstationid());
				tp.setDistance(ts.getDistance().intValue());
				tp.setFixedreserveseatnum(newscheduelplan
						.getFixedreserveseatnum());
				tp.setFueladditionfee(ts.getFueladditionfee());
				tp.setFullprice(ts.getFullprice());
				tp.setHalfprice(otp.getHalfprice());
				tp.setIssellable(false);
				tp.setLowerlimitprice(otp.getLowerlimitprice());
				tp.setMoreprice(otp.getMoreprice());
				tp.setOrgid(otp.getOrgid());
				tp.setReachstationid(otp.getReachstationid());
				tp.setRuntime(otp.getRuntime());
				tp.setScheduleid(newscheduelplan.getScheduleid());
				tp.setScheduleplan(newscheduelplan);
				tp.setSeatnos("0");
				tp.setSeatnum(newscheduelplan.getSeatnum());
				tp.setSeattype(otp.getSeattype());
				tp.setSoldeatnum(newscheduelplan.getSoldeatnum());
				tp.setStationservicefee(otp.getStationservicefee());
				tp.setStudentprice(otp.getStudentprice());
				tp.setUpdateby(updateby);
				tp.setUpdatetime(now);
				List<Ticketpriceitem> tpits = otp.getTicketpriceitemlist();
				List<Ticketpriceitem> newticketitems = new ArrayList<Ticketpriceitem>();
				for (Ticketpriceitem ti : tpits) {
					Ticketpriceitem nti = new Ticketpriceitem();
					nti.setCode(ti.getCode());
					nti.setCreateby(updateby);
					nti.setCreatetime(now);
					nti.setDepartdate(newscheduelplan.getDepartdate());
					nti.setIsautoadjust(ti.isIsautoadjust());
					nti.setName(ti.getName());
					nti.setPrice(ti.getPrice());
					nti.setScheduleid(newscheduelplan.getScheduleid());
					nti.setTicketprice(tp);
					nti.setTicketpriceformulaitemid(ti
							.getTicketpriceformulaitemid());
					nti.setTickettype(ti.getTickettype());
					nti.setUpdateby(updateby);
					nti.setUpdatetime(now);
					newticketitems.add(nti);
				}
				tp.setToplimitprice(otp.getToplimitprice());
				tp.setTicketpriceitemlist(newticketitems);
				// dao.merge(tp);
				// dao.getEntityManager().flush();
				// newticketprices.add(tp);
				return tp;
				// break;
			}
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	private void changeTicketFee(List<Ticketprice> ticketpricelist,
			Ticketsell ticket) {
		play.Logger.info("混检操作-----票号："+ticket.getTicketno()+"---开始修改站务费");
		// 票价分项以新的为准
		for (Ticketprice ticketprice : ticketpricelist) {
			if (ticketprice.getSeattype().equals(ticket.getSeattype())
					&& ticketprice.getDepartstationid() == ticket
							.getDepartstationid()
					&& ticketprice.getReachstationid() == ticket
							.getReachstationid()) {
				List<Ticketpriceitem> lists = ticketprice
						.getTicketpriceitemlist();
				for (Ticketpriceitem it : lists) {
					if (it.getTickettype().equals("Q")) {
						Ticketpriceformulaitem ti = (Ticketpriceformulaitem) checkticketDao
								.get(Ticketpriceformulaitem.class,
										it.getTicketpriceformulaitemid());
						if (ti.getCode().equals("C")) {
							ticket.setStationservicefee(it.getPrice());
							play.Logger.info("混检操作-----票号："+ticket.getTicketno()+"---修改站务费为："+it.getPrice());
						} else if (ti.getCode().equals("D")) {
							ticket.setAdditionfee(it.getPrice());
						} else if (ti.getCode().equals("E")) {
							ticket.setComputefee(it.getPrice());
						} else if (ti.getCode().equals("G")) {
							ticket.setCoolairfee(it.getPrice());
						} else if (ti.getCode().equals("K")) {
							ticket.setFueladditionfee(it.getPrice());
						} else if (ti.getCode().equals("H")) {
							ticket.setWaterfee(it.getPrice());
						} else if (ti.getCode().equals("I")) {
							ticket.setInsurefee(it.getPrice());
						} else if (ti.getCode().equals("J")) {
							ticket.setOtherfee(it.getPrice());
						}
					}
				}
				break;
			}
		}
		play.Logger.info("混检操作-----票号："+ticket.getTicketno()+"---修改站务费结束");
	}

	// 已过发车时间不允许混检
	private boolean checktime(Date departdate, String departtime) {
		try {
			// long checktime = (new Date()).getTime();
			String departDatestr = StringUtils.dateToStr(departdate);
			String departTimes = departDatestr + ' ' + departtime;
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			Date departDate;
			departDate = format.parse(departTimes);
			long s1 = departDate.getTime();
			long s2 = System.currentTimeMillis();
			return s2 > s1;
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			return false;
		}
	}

	private Date formatDatetime(Date departdate, String departtime) {
		try {
			String departDatestr = StringUtils.dateToStr(departdate);
			String departTimes = departDatestr + ' ' + departtime;
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			Date departDate;
			departDate = format.parse(departTimes);
			return departDate;
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			return new Date();
		}
	}

	// 求2个时间的差，返回分钟
	private long timeintevl(Date startdatetime, Date enddatetime) {
		try {
			long s1 = startdatetime.getTime();
			long s2 = enddatetime.getTime();
			return (s1 - s2) / 1000 / 60;
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			return 0;
		}
	}

	// 实现全检
	@Override
	public int checkAlltickets(List<PropertyFilter> propertyFilterList,long checkstationid, long scheduleplanid,
			long vehiclereportid, Global global, boolean islazycheck,
			String ip, String ticketentrance) throws ServiceException {
		int count = 0;
		List<Ticketsell> tickets = checkticketDao.queryTickets(propertyFilterList,scheduleplanid,
				false);
		for (Ticketsell ticket : tickets) {
			//儿童票
			if("E".equals(ticket.getTickettype())){
				CarryChild carryChild = ticketDao.findCarryChildByChildid(ticket.getId());
				carryChild.setUpdateby(ticket.getUpdateby());
				carryChild.setUpdatetime(ticket.getUpdatetime());
				carryChild.setRemark(carryChild.getRemark() + ",全检" + util.DateUtils.formatDatetime(ticket.getUpdatetime()));
				ticketDao.merge(carryChild);
				continue;
			}
			
			checkticket(checkstationid, vehiclereportid, ticket,global,
					islazycheck, ip, ticketentrance, false,"1");
			count++;
		}
		return count;
	}

	@Override
	public long qryReportVechiletickets(long scheduleplanid,
			long vehiclereportid,Date departdate) {
		return checkticketDao
				.queryChecktickets(scheduleplanid, vehiclereportid,departdate);
	}

	// 查询报到车辆的检票数(一卡通刷卡上车人数)
	public long qryOneCardReportVechiletickets(long scheduleplanid,
			long vehiclereportid,Date departdate) {
		
		return checkticketDao.queryOneCardChecktickets(scheduleplanid,
				vehiclereportid,departdate);
	}

	// 查询已检的车票信息
	@Override
	public List<Map<String, Object>> queryCheckedticket(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil
				.listToMap(new Object[] { "selected", "id", "ticketno",
						"departdate", "departtime", "departstation",
						"reachstation", "seatno", "price", "tickettype",
						"ischecked", "usercode", "carrychildnum",
						"ticketoutletname","isdepartinvoices","ticketstatus","selltime"
						,"customername","printstatus","tickettypename","dticketstatus" },
						checkticketDao.queryCheckedticket(propertyFilterList),
						new Object[] { boolean.class, String.class, String.class,
								Date.class, String.class, String.class,
								String.class, Short.class, BigDecimal.class,
								String.class, boolean.class, String.class,
								Short.class, String.class, boolean.class, String.class, String.class
								,String.class,String.class, String.class, String.class });
	}

	@Override
	public List<Map<String, Object>> qryTicket(long scheduleplanid, short seatno)
			throws ServiceException {
		return ListUtil.listToMap(new Object[] { "id", "ticketno",
				"departdate", "code", "departtime", "departstation",
				"reachstation", "seatno", "price", "tickettype",
				"ticketentrance", "buspark", "remarks", "islinework",
				"ischecked", "ticketstatus", "oldscheduleplanid", "sellbyname",
				"selltime" },
				checkticketDao.queryTicket(scheduleplanid, seatno),
				new Object[] { long.class, String.class, Date.class,
						String.class, String.class, String.class, String.class,
						Short.class, BigDecimal.class, String.class,
						String.class, String.class, String.class,
						boolean.class, boolean.class, String.class, long.class,
						String.class, Timestamp.class });
	}

	@Override
	public String queryMixInfo(long ticketid) {
		return checkticketDao.queryMixInfo(ticketid);
	}

	@Override
	public Ticketsell checkBySeatno(long checkstationid, long vehiclereportid,
			long scheduleplanid, short seatno,  Global global,
			boolean islazycheck, String ip, String ticketentrance)
			throws ServiceException {
		Ticketsell ticket = checkticketDao.getTicket(scheduleplanid, seatno);
		if (ticket == null) {
			throw new ServiceException("0340");
		}

		return checkticket(checkstationid, vehiclereportid, ticket, global,
				islazycheck, ip, ticketentrance, false,"0");
		// return checkByticketno(checkstationid, vehiclereportid,
		// ticket.getTicketno(), checkedby, islazycheck,ip,ticketentrance);
	}

	// 整车退检
	@Override
	public boolean cancelAllCheckticket(List<PropertyFilter> propertyFilterList,long checkstationid,
			long scheduleplanid, long vehiclereportid, Global global)
			throws Exception {
		List<Ticketsell> tslist = checkticketDao.queryTickets(propertyFilterList,scheduleplanid,
				vehiclereportid, true);
		for (Ticketsell ts : tslist) {
			cancelCheckticket(checkstationid, ts, global, 0);
			
			if("E".equals(ts.getTickettype())){
				//儿童票
				CarryChild carryChild = ticketDao.findCarryChildByChildid(ts.getId());
				carryChild.setUpdateby(ts.getUpdateby());
				carryChild.setUpdatetime(ts.getUpdatetime());
				carryChild.setRemark(carryChild.getRemark() + ",整车退检" + util.DateUtils.formatDatetime(ts.getUpdatetime()));
				ticketDao.merge(carryChild);
			}
		}
		return true;
	}

	// 实现按座位号(流水号)退检票过程
	@Override
	public Ticketsell cancelCheckBySeatno(long checkstationid,
			long scheduleplanid, short seatno, Global global, int iscancelold)
			throws Exception {
		Ticketsell ticket = checkticketDao.getTicket(scheduleplanid, seatno);
		if (ticket == null) {
			throw new ServiceException("0340");
		}
		return cancelCheckticket(checkstationid, ticket, global, iscancelold);
	}

	// 实现特检
	@Override
	public Ticketsell checkAuthBySeatno(long checkstationid,
			long vehiclereportid, long scheduleplanid, short seatno,
			Global global, boolean islazycheck, String ip,
			String ticketentrance) throws ServiceException {
		Ticketsell ticket = checkticketDao.getTicket(scheduleplanid, seatno);
		if (ticket == null) {
			throw new ServiceException("0340");
		}
		return checkticket(checkstationid, vehiclereportid, ticket, global,
				islazycheck, ip, ticketentrance, true,"7");
	}

	@Override
	public void addMusicContent(Ledcontent lc) throws ServiceException {
		Musiccontent mc = new Musiccontent();
		mc.setOrgname(lc.getOrgname());
		mc.setContent(lc.getMccontent());
		mc.setDeparttime(new Date());
		lc.setCreatetime(new Date());
		checkticketDao.getEntityManager().merge(mc);
		checkticketDao.getEntityManager().merge(lc);
	}

	/**
	 * 闸机检票：条码/身份证
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Message checkByticketno(Message msg) throws BusinessException {
		//192.168.10.100|9898|aa|bb|00000448|END
		//闸机是否控制本系统外的票号，0：不控制，1：控制
		play.Logger.info("方法开始：" + new Date());
		play.Logger.info("检票口闸机接收到的报文：" + JsonUtil.parseObject(msg));
		//检查配置文件，并获得检票机构orgid
		long checkstationid = msg.getCheckstationid(); //检票车站id, CheckStationid
//		play.Logger.info("查询1开始：" + new Date());
		Organization org = checkticketDao.getOrganization(checkstationid);//供查参数等使用
//		play.Logger.info("查询1结束：" + new Date());
		if(null == org){
			play.Logger.error("检票车站id没有对应的机构，请检查 NvBus/conf/SocketService.properties 配置文件中 CheckStationid 配置项的值是否与organization表中的stationid字段对应");
			throw new BusinessException("777", "NvBus闸机配置文件配置错误");
		}		
		StringBuffer sql = new StringBuffer();
		List list = null;
		Query query = null;		
		msg.setErrcode("0");// 0 检票成功
		if(!"".equals(msg.getTicketno()) && msg.getTicketno() != null){
			// 判断是否工作人员，是则通过
//			play.Logger.info("查询2开始：" + new Date());
			sql.append(" select u from Userinfo u where u.cardno = :cardno and u.isactive = 1 ");
			query = checkticketDao.getEntityManager().createQuery(sql.toString());
			query.setParameter("cardno", msg.getTicketno());
			list = query.getResultList();
//			play.Logger.info("查询2结束：" + new Date());
			if (list != null && list.size() > 0) {
				// SU|班次|票种|座位号|闸机设备号|通过人数|备用0|END
				msg.setSchcode("GZRY");
				// 票种：0 全票，1童票，2军残票，3优惠票
				// q-全票,b-半票,x-学生票,z-打折票......G工作人员
				msg.setTicketype("Q");
				msg.setSeatno("10");
				msg.setPeoples(1);
				return msg;
			}else{
				String usersql=" select u.* from Userinfo u,Cardissue c where u.id = c.typeid and c.type='4' and u.isactive = 1 and c.status='0' and c.serialnumber=:serialnumber";
				Query userquery = checkticketDao.getEntityManager().createNativeQuery(usersql,Userinfo.class);
				userquery.setParameter("serialnumber", msg.getTicketno());
				list = userquery.getResultList();
				if (list != null && list.size() > 0) {
					// SU|班次|票种|座位号|闸机设备号|通过人数|备用0|END
					msg.setSchcode("GZRY");
					// 票种：0 全票，1童票，2军残票，3优惠票
					// q-全票,b-半票,x-学生票,z-打折票......G工作人员
					msg.setTicketype("Q");
					msg.setSeatno("10");
					msg.setPeoples(1);
					return msg;
				}
			}
		}
		/**
		 * 闸机报文格式:
		 * 主机IP|主机端口|闸机设备号|验票设备|车票号码|END
		 * 新闸机报文格式:主机IP|主机端口|闸机设备号|验票设备|检票条件1|检票条件2|检票条件3|校验值|END
		 * 192.168.10.100|9898|aa|bb|00000448|END
		*/
		
		List tickets = null;
		//补全票号
		billtypeService = new BilltypeServiceImpl();
		Billtype bt = billtypeService.findByCode("Ticket");
		Ticketsell ticket = null;
		String ticketno = null;
		//闸机是否进行检票操作，0：不检票，1：检票
		String isallowcheck = parameterService.findParamValue(ParamterConst.Param_3102,
				org.getId());
		if(!"".equals(msg.getTicketno()) && msg.getTicketno() != null){
			tickets=completeticketno(msg,bt);
			//***********对站内车票进行校验********//
			if ( tickets == null || tickets.size() == 0) {
				//该车票不存在，或过了补开天数
				throw new BusinessException("1", msg.getTicketno() + "：系统内车票不存在或过了补开天数");
			}else{
				//车票存在
				ticket = (Ticketsell) tickets.get(0);
				ticketno = ticket.getTicketno();
				//3038是否实名制检票，0不实名制，1实名制
				String p3038 = parameterService.findParamValue(ParamterConst.Param_3038,org.getId());
				//9393是否实名制售票：0否，1全局实名制，2固定线路实名制
				String p9393 = parameterService.findParamValue(ParamterConst.Param_9393,org.getId());
				if("1".equals(p3038)&&"1".equals(p9393)&&"居民身份证".equals(ticket.getCertificatetypename())){
					msg.setCertificateno(ticket.getCertificateno());
					throw new BusinessException("25", ticketno + ":该车票需身份证核验");	
				}else if("1".equals(p3038)&&"2".equals(p9393)&&"居民身份证".equals(ticket.getCertificatetypename())){
					String sql1 = "select count(1) from ticketsell ts join schedule sc on  ts.scheduleid=sc.id "
					+"join route ro on ro.id=sc.routeid where ro.isrealnameticket='1' and ts.ticketno = :ticketno ";
					Query query1 = checkticketDao.getEntityManager().createNativeQuery(sql1);
					query1.setParameter("ticketno", ticketno);
					if(query1.getResultList().size()>0){
						msg.setCertificateno(ticket.getCertificateno());
						throw new BusinessException("25", ticketno + "该车票需身份证核验");
					}
				}			
			}
			//闸机是否控制本系统外的票号，0：不控制，1：控制
			String isallow = parameterService.findParamValue(ParamterConst.Param_3103,org.getId());
			if(isallow.equals(ParamterConst.COMMON_FLAG.FALG_NO)){
				//此部分作用为判断系统内外车票是否已检,如果没有检票则检一下，系统外票只检一次
				//String ticketno=msg.getTicketno();
				sql = new StringBuffer("select t from Entryticket t ");
				sql.append(" where t.ticketno=:ticketno");
				query = checkticketDao.getEntityManager().createQuery(sql.toString());
				query.setParameter("ticketno", ticketno);
				list=query.getResultList();
				//ticketsell为空，为本库中不存在的票号，则认为是系统外票号，记录到Entryticket后返回即可;不为空，则为系统内票号，需要进行各种校验
				if(null == tickets || tickets.size() == 0){
					//站外票
					if(list==null || (list!=null && list.size()==0) ){
						
						Entryticket en=new Entryticket();
						en.setTicketno(ticketno);
						en.setCreatetime(new Date());
						checkticketDao.getEntityManager().merge(en);
						// SU|班次|票种|座位号|闸机设备号|通过人数|备用0|END
						msg.setSchcode("0001");
						// 票种：0 全票，1童票，2军残票，3优惠票
						// q-全票,b-半票,x-学生票,z-打折票......
						msg.setTicketype("0");
						msg.setSeatno("1");
						msg.setPeoples(1);
						msg.setEquipment("0");
						play.Logger.info("系统外车票通过闸机，票号为：" + ticketno);
						return msg;
					}else{
						throw new BusinessException("8", ticketno + ":该车票为系统外车票，且已在闸机使用过!");
					}
				}
			}
		}else{
			//身份证
			if(isallowcheck.equals(ParamterConst.COMMON_FLAG.FALG_NO)){//不检票
				ticket=queryticketnoBycertificateno(msg,0);
			}else{
				ticket=queryticketnoBycertificateno(msg,1);
			}
		}
//		String ticketno = msg.getTicketno();
//		play.Logger.info("处理前的ticketno="+ticketno);
//		if (msg.getTicketno().length() > bt.getTicketnolength()) {
//			int pos = (int) (msg.getTicketno().length() - bt
//					.getTicketnolength());
//			ticketno = ticketno.substring(pos, msg.getTicketno().length());
//		} else if (msg.getTicketno().length() < bt.getTicketnolength()) {
//			ticketno = StringUtils.strPad(ticketno,
//					(int) bt.getTicketnolength(), "0");
//		}
//		play.Logger.info("处理后的ticketno="+ticketno);
		
		String ticketentrance = msg.getGatesno();
		play.Logger.info("ticketno="+ticketno);
		
		//车票允许通过闸机次数
		if(ticket != null){
			// SU|班次|票种|座位号|闸机设备号|通过人数|备用0|END
			//检票闸机允许重复刷票进行检票的最大次数
			int checkcount  = Integer.parseInt( parameterService.findParamValue(ParamterConst.Param_3105,org.getId()) );
			play.Logger.info("最大允许通过闸机次数是checkcount="+checkcount);
			String ticketnodata = ticket.getTicketno();
			sql = new StringBuffer("select t from Entryticket t ");
			sql.append(" where t.ticketno=:ticketno");
			query = checkticketDao.getEntityManager().createQuery(sql.toString());
			query.setParameter("ticketno", ticketnodata);
			list=query.getResultList();
			play.Logger.info("查出记录次数是count="+list.size());
			if(list == null || list.size() < checkcount){
				//未超过最大允许通过次数
				Entryticket en = new Entryticket();
				en.setTicketno(ticketnodata);
				en.setCreatetime(new Date());
				checkticketDao.getEntityManager().merge(en);//记录车票通过闸机
				msg.setErrcode("0");//Errcode : 0-SU  其他-FL
			}
			else{
				throw new BusinessException("10", ticketnodata + ": 该车票已超过最大允许通过闸机次数");
			}
		}
		
		long checkedby = msg.getCheckby();
		//重打\补开\注销结算单的天数
//		String opendays = parameterService.findParamValue(ParamterConst.Param_3041, org.getId());	//补开 3019改3041
//		int days = new Integer(opendays);
//		Date departdate = DateUtils.add(new Date(), -days);
//		try {
//			sql = new StringBuffer("select  t from Ticketsell t where t.ticketno=:ticketno")
//			.append(" and t.departdate>=:departdate order by t.departdate desc");
//			 query = JPA.em().createQuery(sql.toString());
//			//query.setLockMode(LockModeType.PESSIMISTIC_READ);		
//			query.setParameter("ticketno", ticketno);
//			query.setParameter("departdate", departdate);
//			List lists = query.getResultList();
//			if ( lists!=null && lists.size() == 0 || lists == null ) {
//				sql = new StringBuffer("select  t from Ticketsell t where t.ticketno=:ticketno")
//				.append(" and t.departdate>=:departdate order by t.departdate desc");
//				query = JPA.em().createQuery(sql.toString());
//				//query.setLockMode(LockModeType.PESSIMISTIC_READ);		
//				query.setParameter("ticketno", ticketno);
//				query.setParameter("departdate", departdate);
//				lists = query.getResultList();			
//				if ( lists!=null && lists.size() == 0 || lists == null ) {
//					//该车票不存在，或过了补开天数
//					throw new ServiceException("0440");
//				}
//			}
//			if(lists != null && lists.size() > 0 ){
//				//车票存在
//				ticket = (Ticketsell) lists.get(0);
//			}
//		} catch (ServiceException e) {
//				e.printStackTrace();
//				throw new BusinessException("15", "系统内车票不存在或过了补开天数");
//		}
//		if(ticket==null){
//			play.Logger.info("系统内车票不存在或过了补开天数", ticketno);
//			throw new BusinessException("15", "系统内车票不存在或过了补开天数");
//		}
		
		//3069参数：检票闸机是否允许预售票通过，0不允许，1允许，默认为0
//		String isAllowPresale = parameterService.findParamValue(ParamterConst.Param_3069, org.getId());
//		if(ParamterConst.COMMON_FLAG.FALG_NO.equals(isAllowPresale)){
//			//0：只允许本日车票通过
//			if (DateUtils.compare(ticket.getDepartdate(), new Date()) != 0) {
//				throw new BusinessException("3", ticket.getTicketno()+ ":非本日车票");// 该车票非本日发车
//			}
//		}else{
//			//1:不允许过期票通过
//			if (DateUtils.compare(ticket.getDepartdate(), new Date()) < 0) {
//				throw new BusinessException("3", ticket.getTicketno()+ ":过期车票，不允许通过");// 过期车票
//			}
//		}
		
		//校验售票记录的密文是否正确
		if(!ticketService.checkTicketByTicket(ticket)){
			throw new BusinessException("26", "售票记录密文不正确！");
		}
		//集中式环境中是否允许途径配载班次在异站检票  0 不允许   1允许
		String isallowcheckother = parameterService.findParamValue(ParamterConst.Param_3020,
				org.getId());
		if (isallowcheckother.equals(ParamterConst.COMMON_FLAG.FALG_NO)) {
			if (ticket.getDepartstationid() != checkstationid) {
				// 该车票不在本站检票！
				throw new BusinessException("9", ticket.getTicketno()+ ": 集中式环境中,不允许途径配载班次在异站检票");
			}
		}
		play.Logger.info("ticket.getTicketstatus()=================");
		Date curdate = new Date();
		//3069参数为0，不允许预售票通过
//		if(ParamterConst.COMMON_FLAG.FALG_NO.equals(isAllowPresale)){
//			if (DateUtils.compare(ticket.getDepartdate(), curdate) > 0) {
//				// 该车票非本日发车！
//				throw new BusinessException("3", "非本日车票");
//			}
//		}
		//是否为本日车票
		if (DateUtils.compare(ticket.getDepartdate(), curdate) != 0) {
			// 该车票非本日发车！
			throw new BusinessException("3", ticket.getTicketno()+ ":非本日车票");
		}
		String ticketstatus = ticket.getTicketstatus();
		// 正常、退票、废票
		if ("1".equals(ticketstatus)) {
			// 该车票已退
			throw new BusinessException("15", "车票已退");
		} else if ("2".equals(ticketstatus)) {
			// 该车票已废
			throw new BusinessException("16", "车票已废");
		}else if ("4".equals(ticketstatus)) {
			// 该车票挂失
			throw new BusinessException("18","车票已挂失");
		}
		if(org.getCode().equals("JJKYZ")){//九江客运的
			// TODO 暂时写死01检票机对应01和02检票口 02检票机对应03和04检票口
			if ("1".equals(ticketentrance)) {
				if (!"01".equals(ticket.getTicketentrance())
						&& !"02".equals(ticket.getTicketentrance())) {
					throw new BusinessException("19", "不允许在本闸机检票");
				}
			} else if ("2".equals(ticketentrance)) {
				if (!"03".equals(ticket.getTicketentrance())
						&& !"04".equals(ticket.getTicketentrance())) {
					throw new BusinessException("19", "不允许在本闸机检票");
				}
			} else {
				throw new BusinessException("20", "未知闸机");
			}
		}
		if(org.getCode().equals("YCDZ")){
			if (!ticket.getTicketentrance().equals(msg.getEquipment())) {
				System.out.println(ticket.getTicketentrance()+"不允许在本闸机检票"+msg.getEquipment());
				throw new BusinessException("19", "不允许在本闸机检票");
			}
		}
		Scheduleplan scheduleplan = (Scheduleplan) checkticketDao.get(
				Scheduleplan.class, ticket.getScheduleplanid());
		Vehiclereport vehiclereport = null;
		//闸机是否进行检票操作，0：不检票，1：检票
		if(isallowcheck.equals(ParamterConst.COMMON_FLAG.FALG_NO)){
			//不检票
//			String ticketstatus = ticket.getTicketstatus();
			// 正常、退票、废票
			if ("1".equals(ticketstatus)) {
				// 该车票已退
				throw new BusinessException("15", "车票已退");
			} else if ("2".equals(ticketstatus)) {
				// 该车票已废
				throw new BusinessException("16", "车票已废");
			}else if ("4".equals(ticketstatus)) {
				// 该车票挂失
				throw new BusinessException("18","车票已挂失");
			}
			// SU|班次|票种|座位号|闸机设备号|通过人数|备用0|END
			Schedule sch = (Schedule) checkticketDao.get(Schedule.class,
					ticket.getScheduleid());
			msg.setSchcode(sch.getCode());
			msg.setSeatno(String.valueOf(ticket.getSeatno()));
			// 票种：0 全票，1童票，2军残票，3优惠票
			// q-全票,b-半票,x-学生票,z-打折票......
			if (ticket.getTickettype().equals("Q")) {
				msg.setTicketype("0");
			} else if (ticket.getTickettype().equals("B")) {
				msg.setTicketype("1");
			} else {
				msg.setTicketype("3");
			}
			msg.setPeoples(1);
//			sql = new StringBuffer("select t from Entryticket t ");
//			sql.append(" where t.ticketno=:ticketno");
//			query = checkticketDao.getEntityManager().createQuery(sql.toString());
//			query.setParameter("ticketno", ticketno);
//			list=query.getResultList();
//			if(list==null || list.size()==0){
//				Entryticket en=new Entryticket();
//				en.setTicketno(ticketno);
//				en.setCreatetime(new Date());
//				checkticketDao.getEntityManager().merge(en);
//				// SU|班次|票种|座位号|闸机设备号|通过人数|备用0|END
//				return msg;
//			}else{
//				return msg;
//			}
			return msg;
		}else{
			if (scheduleplan.getIslinework()) {
//				throw new BusinessException("19", "不允许在本闸机检票");
				vehiclereport = checkticketDao.getLineVehiclereport(scheduleplan,
						org.getId());
			} else {
				vehiclereport = checkticketDao.getVehiclereport(scheduleplan,
						org.getId());
				if (vehiclereport == null
						|| vehiclereport.getScheduleplanid() != scheduleplan
								.getId()) {
					// // 该班次还未报到，请稍等
					throw new BusinessException("2", "班次未报班");
				}
				if (scheduleplan.getSeatnum() == checkticketDao.getCheckedcount(
						vehiclereport.getId(), scheduleplan.getId())) {
					// 该班次已检满！
					throw new BusinessException("12", "班次人数超载");
				}
			}
			List<Schedulestatus> schedulestatuslist = scheduleplan
					.getSchedulestatuslist();
			List<Scheduleseats> scheduleseatslist = scheduleplan
					.getScheduleseatslist();
			boolean isvalidsch = false;
			for (Schedulestatus schedulestatus : schedulestatuslist) {
				if (schedulestatus.getDepartstationid() == checkstationid) {
					isvalidsch = true;
					if (!schedulestatus.getIsreported()) {
						// 该班次还未报到，请稍等
						throw new BusinessException("2", "班次未报班");
					} else if (!schedulestatus.getIsbegincheck()) {
						// 该班次还未开始检票，请稍等
						throw new BusinessException("4", "班次未开检");
					}
					if (schedulestatus.getIsdeparted()) {
						throw new BusinessException("5", "班次已发");
					}
					// 正常、报停、晚点、被并、脱班、停售
					if (schedulestatus.getStatus().equals("4")) {
						throw new BusinessException("6", "班次已脱班");
					}
					if (schedulestatus.getStatus().equals("1")) {
						throw new BusinessException("11", "班次已停班");
					}
					// 发车前n分钟开始检票
					long beginchecktime = new Long(parameterService.findParamValue(
							ParamterConst.Param_3001, org.getId()));
					long timemargin = timeintevl(
							formatDatetime(schedulestatus.getDepartdate(),
									schedulestatus.getDeparttime()), new Date());
					if (beginchecktime > 0 && timemargin > beginchecktime) {
						throw new BusinessException("4", "班次未开检");
					}
					Ticketsell ts = checkticket(checkstationid, ticket, checkedby,
							vehiclereport);
					for (Scheduleseats seat : scheduleseatslist) {
						if (seat.getSeatno() == ts.getSeatno()) {
							seat.setStatus("7");
							seat.setUpdateby(checkedby);
							seat.setUpdatetime(new Date());
							checkticketDao.getEntityManager().merge(seat);
						}
					}
					// SU|班次|票种|座位号|闸机设备号|通过人数|备用0|END
					Schedule sch = (Schedule) checkticketDao.get(Schedule.class,
							schedulestatus.getScheduleid());
					msg.setSchcode(sch.getCode());
					msg.setSeatno(String.valueOf(ts.getSeatno()));
					// 票种：0 全票，1童票，2军残票，3优惠票
					// q-全票,b-半票,x-学生票,z-打折票......
					if (ts.getTickettype().equals("Q")) {
						msg.setTicketype("0");
					} else if (ts.getTickettype().equals("B")) {
						msg.setTicketype("1");
					} else {
						msg.setTicketype("3");
					}
					msg.setPeoples(1);
//					msg.setErrcode("0");
				}
			}
			play.Logger.info("ticket.getTicketstatus()==========2=======");
			if (!isvalidsch) {
				throw new BusinessException("19", "不允许在本闸机检票");
			}
			play.Logger.info("ticket.getTicketstatus()==========end=======");
			play.Logger.info("方法结束：" + new Date());
			return msg;
		}
		// checkticketDao.getEntityManager().flush();
		// return checkticketDao.getEntityManager().merge(ticket);
	}
	public List completeticketno(Message msg,Billtype bt){
		List tickets = null;
		StringBuffer sql = new StringBuffer();
		String ticketno =  msg.getTicketno();
		String ticketdate = DateUtils.formatDate(new Date());
		if (msg.getTicketno().length() > bt.getTicketnolength()) {
			int pos = (int) (msg.getTicketno().length() - bt
					.getTicketnolength());
			ticketno = ticketno.substring(pos, msg.getTicketno().length());
		} else if (msg.getTicketno().length() < bt.getTicketnolength()) {
			ticketno = StringUtils.strPad(ticketno,
					(int) bt.getTicketnolength(), "0");
		}
		// 获取车票(可能为多张，之前有重复票号)
		sql = new StringBuffer("select t.* from Ticketsell t where t.ticketno = :ticketno");
		sql.append(" and t.departdate >= date'"+ticketdate+"' order by t.departdate desc");
		Query query = checkticketDao.getEntityManager().createNativeQuery(sql.toString(),Ticketsell.class);
		query.setParameter("ticketno", ticketno);
		tickets = query.getResultList();
		return tickets;
	}
	public Ticketsell queryticketnoBycertificateno(Message msg,int flg){
		Ticketsell ticket = null;
		List<Ticketsell> tickets = null;
		String departdate = DateUtils.formatDate(new Date());
		String certificatenosql = "select ts.* from ticketsell ts,customer c where c.id=ts.customerid and c.certificateno=:certificateno and ts.ticketstatus='0' and c.certificatetype='0' and ts.departdate=date'"+departdate+"'";
		Query certificatenoquery = checkticketDao.getEntityManager().createNativeQuery(certificatenosql,Ticketsell.class);
		certificatenoquery.setParameter("certificateno", msg.getCertificateno());
		tickets = certificatenoquery.getResultList();
		if(flg == 1){
			if((null == tickets) || (tickets.size() > 1) || (tickets.size() == 0)){
				throw new BusinessException("1", "证件号为"+msg.getCertificateno() + "：系统内车票不存在或过了补开天数");
			}else if(tickets.size() == 1){
				ticket = (Ticketsell) tickets.get(0);
			}
		}else{
			if((null == tickets) || (tickets.size() == 0)){
				throw new BusinessException("1", "证件号为"+msg.getCertificateno() + "：系统内车票不存在或过了补开天数");
			}else if(tickets.size() >= 1){
				ticket = (Ticketsell) tickets.get(0);
			}
		}
		return ticket;
	}
	
	private Ticketsell checkticket(long checkstationid, Ticketsell ticket,
			long checkedby, Vehiclereport vehiclereport) {
		Station checkstation = new Station();
		checkstation.setId(checkstationid);
		ticket.setCheckstation(checkstation);
		Userinfo userinfo = new Userinfo();
		userinfo.setId(checkedby);
		ticket.setCheckedby(userinfo);
		ticket.setChecktime(new Date());
		ticket.setUpdateby(checkedby);
		ticket.setUpdatetime(new Date());
		ticket.setIschecked(true);
		ticket.setVehiclereport(vehiclereport);
		return checkticketDao.getEntityManager().merge(ticket);
	}

	@SuppressWarnings("unchecked")
	@Override
	public int checkByticketid(long checkstationid, long vehiclereportid,
			String ticketids, Global global, String ip)
			throws ServiceException {
		String[] ticketid = ticketids.split(",");
		int tickets = 0;
		for (String curid : ticketid) {
			if (!curid.equals("")) {
				long tid = new Long(curid);
				Ticketsell ts = (Ticketsell) checkticketDao.get(
						Ticketsell.class, tid);
				//挂失车票
				if(ts.getTicketstatus().equals("4")){
						throw new ServiceException(ts.getTicketno(), "0471");
				}
				if (!ts.getIschecked()) {
					checkticket(checkstationid, vehiclereportid, ts, global,
							true, ip, null, true,"0");
					tickets++;
				}
			}
		}
		return tickets;
	}

	@Override
	public List<Map<String, Object>> qryReportvehicle(long scheduleplanid,
			long reportorgid) {
		return ListUtil.listToMap(new Object[] { "id", "scheduleplanid",
				"vehicleno", "seatnum", "reporttime" },
				checkticketDao.getVehiclereport(scheduleplanid, reportorgid),
				new Object[] { Long.class, Long.class, String.class,
						Short.class, Timestamp.class });
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean isMixTicket(Global global, long checkstationid,
			String ticketno) throws ServiceException {
		Organization org = checkticketDao.getOrganization(checkstationid);
		// 重打/补开/注销 结算单天数
		String opendays = parameterService.findParamValue(ParamterConst.Param_3041, org.getId());	//补开 3019改3041
		int days = new Integer(opendays);
		Date departdate = new Date();
		;
		if (days > 0) {
			departdate = DateUtils.add(new Date(), -days);
		} else {
			departdate = new Date();
		}
		
		//(1)若输入的是主票儿童票要一起检；(2)输入儿童票成人票也要一起检
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!ticketno", ticketno));
		propertyFilters.add(new PropertyFilter("GED_t!departdate", departdate));
		Ticketsell ticket = (Ticketsell) checkticketDao.uniqueResult(Ticketsell.class, propertyFilters);
		if(ticket == null){
			Billtype bt = billtypeService.findByCode("Ticket");
			String cuticketno = ticketno;
			if (ticketno.length() > bt.getTicketnolength()) {
				int pos = (int) (ticketno.length() - bt.getTicketnolength());
				cuticketno = ticketno.substring(pos, ticketno.length());
			} else if (ticketno.length() < bt.getTicketnolength()) {
				cuticketno = StringUtils.strPad(ticketno,
						(int) bt.getTicketnolength(), "0");
			}
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!ticketno", cuticketno));
			propertyFilters.add(new PropertyFilter("GED_t!departdate", departdate));
			ticket = (Ticketsell) checkticketDao.uniqueResult(Ticketsell.class, propertyFilters);
			if((ticket.getSellway().equals("7")||ticket.getSellway().equals("10"))&&ticket.getTicketstatus().equals("1")){
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!oldticketno", ticket.getTicketno()));
				TicketMixChange tmc = (TicketMixChange) checkticketDao.uniqueResult(TicketMixChange.class, propertyFilters);
				if(tmc!=null){
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQS_t!ticketno", cuticketno+"01"));
					propertyFilters.add(new PropertyFilter("GED_t!departdate", departdate));
					ticket = (Ticketsell) checkticketDao.uniqueResult(Ticketsell.class, propertyFilters);
				}
			}
			if(ticket == null){
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!eticketno", ticketno));
				propertyFilters.add(new PropertyFilter("GED_t!departdate", departdate));
			    ticket = (Ticketsell) checkticketDao.uniqueResult(Ticketsell.class, propertyFilters);
			}
			
			if(ticket==null) {
				throw new BusinessException("未查到该票号：" + ticketno);
			}
			ticketno = ticket.getTicketno();
		}
		TicketDao ticketDao = new TicketDao();
		Ticketsell childTicket = null;//儿童票售票记录
		if("E".equals(ticket.getTickettype())){
			childTicket = ticket;//给儿童票售票记录赋值
			Ticketsell qticket = ticketDao.findQticketBychild(ticket.getId());//查询到全票记录
			if(qticket == null){
				play.Logger.error("未找到此儿童票对应的主票记录，儿童票票号为：" + childTicket.getTicketno());
				throw new BusinessException("未找到此儿童票对应的主票记录，儿童票票号为：" + childTicket.getTicketno());
			}else{
				ticket = qticket;//将主票赋值给将要执行检票的对象
				play.Logger.info("检票，主票号=" + ticket.getTicketno() + "，儿童票票号=" + childTicket.getTicketno());
			}
		}else{
			//主票，查询出对应的儿童票(可能不存在儿童票)
			childTicket = ticketDao.findChildByQticket(ticket.getId());
		}
		
		// 获取车票并锁住
		// 如果取不到车票，提示“该车票不存在，或过了补开天数”
//		Ticketsell ticket = ticketService.getTicket(ticketno, departdate);
		ticket = ticketService.getTicket(ticketno, departdate);
		List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
		filters.clear();
		filters.add(new PropertyFilter("EQL_t!ticketsellid", ticket.getId()));
		filters.add(new PropertyFilter("EQB_t!isactive", true));
		List<Ticketmixcheck> tslist = checkticketDao.query(
				Ticketmixcheck.class, filters);
		if (tslist != null && tslist.size() > 0) {
			return true;
		} else {
			return false;
		}
	}
	/**
	 * 检票界面双击班次获取 到站和票数信息
	 * @param scheduleplanid
	 * @param ischecked
	 * @return
	 */
	@Override
	public List<Map<String, Object>> sumTickets(Long scheduleplanid ){		
		return ListUtil
		.listToMap(new Object[] {"startstationname", "reachstationname", "ticketnum" },
				checkticketDao.sumTickets(scheduleplanid),
				new Object[] { String.class,  String.class,long.class  });
		
	
	}

	@Override
	public long qryUnCheckTickets(long scheduleplanid,Date departdate) {
		return checkticketDao.qryUnCheckTickets(scheduleplanid,departdate);
	}
	
	//是否是远程检票
	public boolean isRemoteTicketCheck(Global global, String ticketno){
		String opendays = parameterService.findParamValue(ParamterConst.Param_3041, global.getOrganization().getId());	//补开 3019改3041
		int day = new Integer(opendays);
		List<Object> remoteCheckList = checkticketDao.queryRemoteCheck(day, ticketno);
		if(remoteCheckList == null || remoteCheckList.size() < 1){
			return false;
		}else{
			return true;
		}
	};
	
	public long cancleRemoteTicketCheck(long checkstationid, Global global, String ticketno) throws Exception{
		// 重打/补开/注销 结算单天数
		String opendays = parameterService.findParamValue(ParamterConst.Param_3041, global.getOrganization().getId());	//补开 3019改3041
		int days = new Integer(opendays);
		Date departdate;
		if (days > 0) {
			departdate = DateUtils.add(new Date(), -days);
		} else {
			departdate = new Date();
		}
		RemoteTicketsell ticket = ticketDao.getRemoteTicketSell(ticketno,departdate);
		
		if(ticket == null){
			throw new Exception("远程检票不存在!");
		}
		if (ticket.isIsdepartinvoices()) {
			throw new ServiceException("0125");
		}
		Organization organization = (Organization) checkticketDao.get(Organization.class, ticket.getDepartorgid());
		;
		Map<String, String> requestMap = new HashMap<String, String>();
		requestMap.put("ticketno", ticketno);
		requestMap.put("departorgcode", organization.getCode());
		requestMap.put("departdate", CommonUtil.dateToSimpleString(ticket.getDepartdate()));
		
		Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
		MethodResult methodResult = new MethodResult();
		if (centreOrg == null) {
			methodResult.setResult(insideInvokFalse);
			methodResult.setResultMsg("无法连接中心服务器:找不到" + organization.getName()+ "的上级机构");
		}
		
		String resultstr = RpcUtil.remoteCall(centreOrg.getServersaddress(), RemoteApi.CANCEL_REMOTE_CHECK, requestMap);		
		methodResult = JsonUtil.parseObject(resultstr, MethodResult.class);
		if(methodResult.getResult() != MethodResult.SUCCESS){
			throw new Exception("取消远程检票失败");
		}
		
		Long scheduleplanid = ticket.getScheduleplanid();
		Scheduleplan sp = (Scheduleplan)ticketDao.get(Scheduleplan.class, scheduleplanid);
		Long updateby = global.getUserinfo().getId();
		Date updateDate = new Date();
		if (!sp.getIslinework()) {
			List<Scheduleseats> sslist = sp.getScheduleseatslist();
			boolean isfind = false;
			for (Scheduleseats ss : sslist) {
				if (ss.getSeatno() == ticket.getSeatno()) {
						ss.setStatus("0");
						ss.setSeattype("0");
						ss.setTickettype(null);
						ss.setUpdateby(updateby);
						ss.setUpdatetime(updateDate);
						ticketDao.merge(ss);
						isfind = true;
						break;
				}
			}
			if (!isfind) {
				for (Scheduleseats ss : sslist) {
					if (ss.getStatus().equals("0")) {
						ss.setStatus("0");
						ss.setSeattype("0");
						ss.setTickettype(null);
						ss.setUpdateby(updateby);
						ss.setUpdatetime(updateDate);
						ticketDao.merge(ss);
						isfind = true;
						break;
					}
				}
			}
		}
		ticketDao.delete(ticket);
		return scheduleplanid;
	}

	@Override
	public String[] setScheduleStatus(String cardno, Date departdate){
		// TODO Auto-generated method stub
		int result = 0;
		String[] str = new String[4];
		Schedulestatus schedulestatus = new Schedulestatus(); 
		List<Schedulestatus> list = checkticketDao.findScheduleIsChecked(cardno, departdate);
		String vehicleno = checkticketDao.getvehiclenobycardno(cardno);
		if(list==null || list.size() < 1){//该班次还没报到			
			str[0] = "没有报到的班次";
			str[1] = String.valueOf(result);
			return str;
		}else{			
			schedulestatus = (Schedulestatus)list.get(0);
		    if (schedulestatus.getIsbegincheck()){//已经开始检票
		    	str[0] = "已经开始检票";
				str[1] = String.valueOf(result);
				str[2] = schedulestatus.getScheduleplan().getId() + "";
				str[3] = vehicleno;
				return str;
		    }else{
		    	result = checkticketDao.updateScheduleStatus(cardno, departdate);
		    	str[1] = String.valueOf(result);
		    	str[2] = schedulestatus.getScheduleplan().getId() + "";
		    	str[3] = vehicleno;
		    	return str;
		    }
		}
		
	}


	@Override
	public String checkticketno(String ticketno,String certificateno,Global global) {
		String opendays = parameterService.findParamValue(ParamterConst.Param_3041, global.getOrganization().getId());	//补开 3019改3041
		int days = new Integer(opendays);
		Date departdate;
		if (days > 0) {
			departdate = DateUtils.add(new Date(), -days);
		} else {
			departdate = new Date();
		}
		return checkticketDao.checkticketno(ticketno,certificateno,departdate);
	}

	@Override
	public int verifyDepartstation(List<PropertyFilter> propertyFilterList,
			String ticketno, Date departdate) throws ServiceException {
		Ticketsell ticket = (Ticketsell)checkticketDao.getTicketByDepartstationids(propertyFilterList, ticketno, departdate);
		if(ticket==null){
			return 0;
		}else{
			return 1;
		}
	}
	

	@Override
	public List<Map<String, Object>> qryTicketinfoByIDcard(
			List<PropertyFilter> propertyFilterList) {
		// TODO Auto-generated method stub
		
		return ListUtil.listToMap(new Object[] { "id", "ticketno"},
				checkticketDao.qryTicketinfoByIDcard(propertyFilterList),
				new Object[] { long.class, String.class });
		
	}
	public boolean saveseller(long sellerid, long departinvoicesid) throws Exception{
		Departinvoices d = (Departinvoices) checkticketDao.get(Departinvoices.class, departinvoicesid);
		d.setSeller(sellerid);
		checkticketDao.merge(d);
		return true;
	}
	
	/**
	 * 姜蓥瑞_plan_
	 */
	public Schedulestatus changeticketstatus(long scheduleplanid,
			long departstationid, boolean isbegincheck) {
		Schedulestatus schedulestatus = checkticketDao.getSchedulestatus(
				scheduleplanid, departstationid);
		if (isbegincheck) {// 进入检票
			if (schedulestatus != null) {
				schedulestatus.setIsbegincheck(true);
				checkticketDao.merge(schedulestatus);
			}
		} else { // 退出检票
			if (schedulestatus != null) {
				schedulestatus.setIsbegincheck(false);
				checkticketDao.merge(schedulestatus);
			}
		}

		return schedulestatus;
	}

	@Override
	public void savechecklog(Ticketsell ts,String checktype,String operationtype,Global global) {
		try {
			Checkticketlog ck = new Checkticketlog();
			Station s = null;
			Schedule sd = null;
			if(ts.getReachstationid()>0){
				s=(Station) checkticketDao.get(Station.class,ts.getReachstationid());
			}
			if(ts.getReachstationid()>0){
				sd=(Schedule) checkticketDao.get(Schedule.class,ts.getScheduleid());
			}
			ck.setCertificateno(ts.getCustomer().getCertificateno());
			ck.setCertificatetype(ts.getCustomer().getCertificatetype());
			ck.setCheckedby(global.getUserinfo().getName());
			ck.setCheckedbycode(global.getUserinfo().getCode());
			ck.setCheckedip(global.getIpAddress());
			ck.setChecktime(new Date());
			ck.setChecktype(checktype);
			ck.setCustomername(ts.getCustomer().getName());
			ck.setDepartdate(ts.getDepartdate());
			ck.setDeparttime(ts.getDeparttime());
			ck.setOperationtype(operationtype);
			if(s!=null){
				ck.setReachstation(s.getName());
			}
			if(sd!=null){
				ck.setSchedulecode(sd.getCode());
			}
			
			ck.setTicketno(ts.getTicketno());
			checkticketDao.merge(ck);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}

	@Override
	public List<Map<String, Object>> qryReportdriver(
			List<PropertyFilter> buildFromHttpRequest,long orgid) {
		return ListUtil.listToMap(new Object[] { "id","code", "drivername", "drivinglicense"},
				checkticketDao.qryReportdriver(buildFromHttpRequest,orgid),
				new Object[] { long.class, long.class, String.class, String.class });
	}
	
	@Override
	public void schedulestartcheck(ScheduleStartCheck schedulestartcheck,long userinfo,long orgid) throws Exception{
		Date date = new Date();
		schedulestartcheck.setCreatetime(date);
		schedulestartcheck.setUpdatetime(date);
		schedulestartcheck.setCreateby(userinfo);
		schedulestartcheck.setUpdateby(userinfo);
		schedulestartcheck.setOrgid(orgid);
		checkticketDao.merge(schedulestartcheck);
	}

	@Override
	public boolean queryschedulestartcheck(
			ScheduleStartCheck schedulestartcheck,long orgids) {
		return checkticketDao.queryschedulestartcheck(schedulestartcheck,orgids);
	}
	
	/**
	 * 团体票混检
	 * @throws Exception 
	 */
	@Override
	public MethodResult mixCheckTuanTicket(Long checkstationid, long scheduleplanid, long vehiclereportid,
			 Global global, short newseatno, String ticketentrance, boolean b,
			Ticketsell ticketsell) throws Exception {
		MethodResult result = new MethodResult();
		//获取未检票团体票list
		List<Ticketsell> tss = checkticketDao.getTuanTickets(ticketsell.getTicketno(),
				ticketsell.getDepartdate(),false,ticketsell.getScheduleplanid());
		if (tss == null || tss.size() <= 0) {
			result.setResult(0);
			result.setResultMsg("未查询到该团体票!");
		}
		Organization org = checkticketDao.getOrganization(checkstationid);
		Scheduleplan newscheduleplan = (Scheduleplan) checkticketDao.get(LockModeType.PESSIMISTIC_READ,
				Scheduleplan.class, scheduleplanid);
		// 满座是否允许混检
		String P3015 = parameterService.findParamValue(ParamterConst.Param_3015, org.getId());
		// 满座时0 换座混检, 1 加座混检.
		String P3010 = parameterService.findParamValue(ParamterConst.Param_3010, org.getId());
		// 不允许满座混检时
		if (ParamterConst.COMMON_FLAG.FALG_NO.equals(P3015)) {
			if (newscheduleplan.getSeatnum() == newscheduleplan.getSoldeatnum() || (newscheduleplan.getSeatnum()
					- newscheduleplan.getSoldeatnum() - newscheduleplan.getAutocancelreserveseatnum()
					- newscheduleplan.getFixedreserveseatnum()) <= 0) {
				// 该班次已没有空位，不允许混检！
				throw new ServiceException("0356");
			}
		}
		// 如果剩余座位数不够团体票混检
		if (newscheduleplan.getSeatnum() - newscheduleplan.getSoldeatnum() < tss.size()) {
			if (ParamterConst.COMMON_FLAG.FALG_NO.equals(P3015)) {
				throw new BusinessException("剩余座位数不够该团体票混检!");
			} else {
				// 如果允许满座混检,但是座位数不够时,判断3010是否可以加座
				if ("0".equals(P3010)) {
					throw new BusinessException("团体票不允许交换座位混检!");
				}
			}
			// 如果剩余座位数够混检
		} else {

		}
		String msg = "团体票: "+ticketsell.getTicketno()+ "检入到座位号/流水号：";
		for (Ticketsell ts : tss) {
			Ticketsell ticket = mixCheckticket(checkstationid, scheduleplanid, vehiclereportid, ts.getId(), global,
					newseatno, ticketentrance, false);
			if (ticket != null) {
				if (ticket.getIslinework()) {
					msg = msg + ticket.getSeatno() + ",";
				} else {
					msg = msg + ticket.getSeatno() + ",";
				}
			} else {
				msg = "混检失败!";
			}
		}
		msg = msg + "混检成功！";
		result.setResultMsg(msg);
		result.setResult(1);
		return result;
	}
	
	@Override
	public Scheduleplan getScheduleplan(long scheduleplanid) {
		return (Scheduleplan) checkticketDao.get(Scheduleplan.class, scheduleplanid);
	}
	@Override
	public Schedule getSchedule(Ticketsell ticket) {
		return (Schedule) checkticketDao.get(Schedule.class, ticket.getScheduleid());
	}

	/**
	 * @param code exceptioncode 
	 * @return -1 不提示语音信息
	 * 		   -2 该票号不存在
	 * 		   -3 该票号的班次与当前班次不一致
	 * 		   -4 该票已检
	 * 		   -5 未报班
	 *         -6 未到发车时间
	 *         -7 已过发车时间
	 */
	@Override
	public Long switchException(String code) {
		if (CommonUtil.isEmptyString(code)) {
			return -1L;
		} 
		if(code.equals("0440")) {
			return -2L;
		} else if(code.equals("0617") || code.equals("3036")) {
			return -3L;
		} else if(code.equals("0117")) {
			return -4L;
		} else if(code.equals("0118")) {
			return -5L;
		} else if(code.equals("0120") || code.equals("0290") || code.equals("0119") || code.equals("3001")) {
			return -6L;
		} else if(code.equals("0195") || code.equals("0362")) {
			return -7L;
		} else {
			return -1L;
		}
	}
	@Override
	public long qryIssamerep(long vehiclereportid,
			String ticketno,long checkstationid,Date departdate) throws ServiceException {
		 Organization org = checkticketDao.getOrganization(checkstationid);
		 Ticketsell ticket = ticketService.getTicket(ticketno, departdate);
		 Scheduleplan scheduleplan = (Scheduleplan) checkticketDao.get(
					Scheduleplan.class, ticket.getScheduleplanid());
		 Vehiclereport vehiclereport = checkticketDao.getVehiclereport(scheduleplan,
					org.getId());
		 if (vehiclereport.getId() != vehiclereportid){
			 return vehiclereport.getId();
		 }
		return 0;
	}
	/**
	 * 通过票号和车辆ID 校验票是否属于这辆车
	 */
	public boolean checkisschedule(long vehiclereportid, String ticketno, Date departdate) {
		return checkticketDao.checkisschedule(vehiclereportid, ticketno,departdate);
	}

	/**
	 * 创建新的售票记录
	 * @throws Exception 
	 * @throws  
	 */
	@Override
	public Ticketsell createNewTicketSell(long id,Global global) throws  Exception {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!code",ConstDefiniens.HJ_USERINFO));//查询售票员工号
		Userinfo hj_userinfo = (Userinfo) checkticketDao.uniqueResult(Userinfo.class, propertyFilters);
		Ticketsell ts = (Ticketsell) checkticketDao.get(Ticketsell.class, id);
		DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
		Ticketreturn ticketreturn = new Ticketreturn();
		ticketreturn.setBilltype(null);
		ticketreturn.setCharges(new BigDecimal(0));
		ticketreturn.setIsreturninsure(false);
		ticketreturn.setReturninsureid(null);
		ticketreturn.setIsselfschedule(true);
		ticketreturn.setRemarks("混检退");
		ticketreturn.setReturnamount(ts.getPrice());
		ticketreturn.setReturnway("5");//混检退
		ticketreturn.setSellid(ts.getId());
		ticketreturn.setTicketoutletsid(global.getTicketoutlets().getId());
		ticketreturn.setTicketprice(ts.getPrice());
		ticketreturn.setIsreturnticket(true);
		ticketreturn.setReturnfeemode("0");//默认为垫付
		ticketreturn.setReturnvoucherno(ts.getTicketno());
		List<Ticketreturn> ticketreturns = new ArrayList<Ticketreturn>();
		ticketreturns.add(ticketreturn);
		ticketreturnService.returnTickets(ticketreturns, global,true);
		Ticketturnoverdetail ticketturnoverdetail = ticketturnoverdetailService.getCurTicketturnoverdetail(hj_userinfo.getId(),"0");
		ts.setTicketno(ts.getTicketno());
		checkticketDao.merge(ts);
		checkticketDao.getEntityManager().flush();
		checkticketDao.getEntityManager().detach(ts);
		Ticketsell newts  = ts;
		newts.setId(0);
		newts.setTicketno(ts.getTicketno()+"01");
		newts.setSellby(hj_userinfo.getId());
		newts.setSellip(global.getIpAddress());
		newts.setSelltime(new Date());
		newts.setCreateby(global.getUserinfo().getId());
		newts.setCreatetime(new Date());
		newts.setUpdateby(global.getUserinfo().getId());
		newts.setUpdatetime(new Date());
		newts.setSellway("1");
		newts.setTicketstatus("0");
		newts.setOrgid(global.getOrganization().getId());
		newts.setTurnoverdetailid(ticketturnoverdetail.getId());
		newts.setOrderno(UUID.randomUUID().toString());
		newts.setTicketoutletsid(global.getTicketoutlets().getId());
		newts.setTicketoutletsname(global.getTicketoutlets().getName());
		newts.setOrgid(global.getOrganization().getId());
		newts.setSellip(global.getIpAddress());
		String datestr = df.format(newts.getSelltime());
		String cipherStr = newts.getOrgid()+datestr+newts.getSellby();
		String tiksno=AuthcodeEncode.authcodeEncode(cipherStr);
		newts.setTiksno(tiksno);
		ticketturnoverdetail.setSellnum(ticketturnoverdetail.getSellnum()+1);
		ticketturnoverdetail.setSellmoney(ticketturnoverdetail.getSellmoney().add(ts.getPrice()));
		checkticketDao.merge(ticketturnoverdetail);
		newts = (Ticketsell) checkticketDao.merge(newts);
		//获取儿童票
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!qticketid",id));//
		CarryChild childticket = (CarryChild) checkticketDao.uniqueResult(CarryChild.class, propertyFilters);
		if(childticket!=null){
			//修改儿童票对应到新票上
			childticket.setQticketid(newts.getId());
			checkticketDao.merge(childticket);			
		}
		checkticketDao.getEntityManager().flush();
		return  newts;
	}

	@Override
	public String addTicketMixChange(long ticketsellid,Ticketsell ticket) {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!code",ConstDefiniens.HJ_USERINFO));//查询售票员工号
		Userinfo hj_userinfo = (Userinfo) checkticketDao.uniqueResult(Userinfo.class, propertyFilters);
		Ticketsell oldticket = (Ticketsell) checkticketDao.get(Ticketsell.class, ticketsellid);
		TicketMixChange tmc = new TicketMixChange();
		tmc.setTicketno(ticket.getTicketno());
		tmc.setSeatno(ticket.getSeatno()+"");
		tmc.setSellid(ticket.getId());
		tmc.setOldsellid(oldticket.getId());
		tmc.setOldticketno(oldticket.getTicketno());
		tmc.setOldseatno(oldticket.getSeatno()+"");
		tmc.setScheduleplanid(ticket.getScheduleplanid());
		tmc.setCheckby(ticket.getCheckedby().getId());
		tmc.setChecktime(ticket.getChecktime());
		tmc.setCheckip(ticket.getSellip());
		tmc.setRemark("混检退");
		tmc.setCreateby(hj_userinfo.getId());
		tmc.setCreatetime(ticket.getCreatetime());
		checkticketDao.getEntityManager().flush();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!ticketno",tmc.getTicketno()));//查询售票员工号
		propertyFilters.add(new PropertyFilter("EQR_t!newseatno",new Short(tmc.getSeatno())));//查询售票员工号
		propertyFilters.add(new PropertyFilter("EQB_t!isactive",true));//查询售票员工号
		Ticketmixcheck tm=(Ticketmixcheck) checkticketDao.uniqueResult(Ticketmixcheck.class, propertyFilters);
		tm.setTicketno(oldticket.getTicketno());
		checkticketDao.merge(tmc);
		return oldticket.getTicketno();
	}
	//查询车票是否为混检退票
	@Override
	public String isMixChange(String ticketno) {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!ticketno", ticketno));
		TicketMixChange tmc = (TicketMixChange) checkticketDao.uniqueResult(TicketMixChange.class, propertyFilters);
		if(tmc!=null){
			return tmc.getOldticketno();
		}else{
			return "";
		}
	}
	@Override
	public String qryEstationsellticket(String encryptionticketno, Global global) {
	String eticketno = "";
		try {
			eticketno = RSAUtil.decryptByBase64PrivateKey(encryptionticketno,eStationSellTicketPrivateKey);
			if(!"".equals(eticketno)){
				eticketno=	eticketno.substring(0,eticketno.indexOf("#"));
			}
		} catch (Exception e) {
			play.Logger.error("电子票二维码解密失败:"+ e.getMessage()+"  encryptionticketno "+ encryptionticketno);
		}
		return eticketno;
	}

}
