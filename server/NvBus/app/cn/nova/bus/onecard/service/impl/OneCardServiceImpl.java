/**
 * 
 */
package cn.nova.bus.onecard.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.persistence.Query;

import util.SessionContext;
import cn.nova.bus.archive.model.Customer;
import cn.nova.bus.archive.model.Vip;
import cn.nova.bus.archive.service.VipService;
import cn.nova.bus.archive.service.impl.VipServiceImpl;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.checkticket.service.CheckticketService;
import cn.nova.bus.checkticket.service.impl.CheckticketServiceImpl;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.onecard.service.OneCardService;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.service.TicketOpCommonService;
import cn.nova.bus.sale.service.TicketService;
import cn.nova.bus.sale.service.impl.TicketOpCommonServiceImpl;
import cn.nova.bus.sale.service.impl.TicketServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.service.OrganizationService;
import cn.nova.bus.system.service.impl.OrganizationServiceImpl;
import cn.nova.ticket.param.LockSeatsIn;
import cn.nova.ticket.param.LockSeatsOut;
import cn.nova.ticket.param.LockseatIn;
import cn.nova.ticket.param.LockseatOut;
import cn.nova.ticket.param.ReturnTicketIn;
import cn.nova.ticket.param.ReturnTicketsIn;
import cn.nova.ticket.param.ReturnTicketsOut;
import cn.nova.ticket.param.SellTicketIn;
import cn.nova.ticket.param.SellTicketOut;
import cn.nova.ticket.param.SellTicketsIn;
import cn.nova.ticket.param.SellTicketsOut;
import cn.nova.ticket.param.TicketRemoteInvokeCommonProperty.TicketInvokeType;
import cn.nova.ticket.param.UnLockSeatsIn;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.encode.RandomTicketNo;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * @author ice
 *
 */
public class OneCardServiceImpl implements OneCardService {

	private TicketOpCommonService ticketOpCommonService = new TicketOpCommonServiceImpl();
	private CheckticketService checkticketService = new CheckticketServiceImpl();
	private VipService vipService = new VipServiceImpl();
	private OrganizationService organizationService = new OrganizationServiceImpl();
	private TicketService ticketService = new TicketServiceImpl();
	private IDAO dao = new EntityManagerDaoSurport();
	@Resource 
//	private SessionContext context;
	
	/**
	 * 查询一卡通刷卡上车要显示的信息
	 * @param scheduleplanid
	 * @param checkstationid
	 * @param vehiclereportid
	 * @return
	 */
	public List<Map<String,Object>> findScheduleinfo(long scheduleplanid,long checkstationid,long vehiclereportid){
		StringBuilder sb = new StringBuilder();
		sb.append("select vr.isdeparted,ss.status,ss.isbegincheck                                                              ")
		.append("       ,ste.name as endstationname,sp.departdate,sc.code as schedulecode,trim(ss.departtime),v.vehicleno      ")
		.append("       ,ss.ticketentrance,sp.islinework                                                                       ")
		.append("       ,case sp.islinework when 0 then sp.seatnum-sp.soldeatnum-sp.autocancelreserveseatnum                   ")
		.append("       								   -sp.unautocancelreserveseatnum-sp.fixedreserveseatnum               ")
		.append("                           else v.seatnum-nvl((select count(*) from ticketsell ts                             ")
		.append("                                                where ts.departdate=sp.departdate and ts.scheduleplanid=sp.id ")
		.append("                                                  and ts.ticketstatus='0'                                     ")
		.append("                                                  and ts.vehiclereportid=vr.id                                ")
		.append("                                               )                                                              ")
		.append("                                              ,0)                                                             ")
		.append("        end as residueseatnum                                                                                 ")
		.append("        ,(select max(tp.fullprice) from ticketprice tp                                                        ")
		.append("           where tp.departdate=sp.departdate                                                                  ")
		.append("             and tp.scheduleid=sc.id                                                                          ")
		.append("             and tp.departstationid=").append(checkstationid)
		.append("             and tp.reachstationid=ro.endstationid) as fullpfice                                              ")
		.append(" from scheduleplan sp,schedulestatus ss,vehiclereport vr,vehicle v,schedule sc,route ro,station ste           ")
		.append(" where sp.id=").append(scheduleplanid)
		.append("   and sp.scheduleid=sc.id                                                                                    ")
		.append("   and sc.routeid=ro.id                                                                                       ")
		.append("   and ss.departdate=sp.departdate                                                                            ")
		.append("   and ss.scheduleplanid=sp.id                                                                                ")
		.append("   and ss.departstationid=").append(checkstationid)
		.append("   and vr.id=").append(vehiclereportid)
		.append("   and vr.departdate=sp.departdate                                                                            ")
		.append("   and vr.scheduleplanid=sp.id                                                                                ")
		.append("   and vr.vehicleid=v.id                                                                                      ")
		.append("   and ro.endstationid=ste.id		                                                                           ")
		;
		Query query = dao.getEntityManager().createNativeQuery(sb.toString());
		return ListUtil.listToMap(new Object[]{"isdeparted","status","isbegincheck","endstationname"
												,"departdate","schedulecode","departtime","vehicleno"
												,"ticketentrance","islinework","residueseatnum","fullpfice"}
								, query.getResultList(), 
								new Object[]{Boolean.class,String.class,Boolean.class,String.class
											,Date.class,String.class,String.class,String.class
											,String.class,Boolean.class,Integer.class,BigDecimal.class}
								);
	}
	
	/**
	 * 自动生成电子票号
	 * @return
	 */
	private String generateEticketno(){
		//自动生成电子票号
		return RandomTicketNo.random();
	}
	
	/* (non-Javadoc)
	 * @see cn.nova.bus.onecard.service.OneCardService#sellandcheck()
	 */
	@Override
	public MethodResult sellandcheck(Global global,String vipcardno,long vehiclereportid,long scheduleplanid,long checkstationid,String ticketentrance,boolean carrychild
			,String vipgrade,BigDecimal vipmoney,BigDecimal vippoint) throws Exception {
		MethodResult methodResult = new MethodResult();
		Vip vip = vipService.findByCardNo(vipcardno,"0");
		if(vip==null){
//			getContext().setRollbackOnly();
			methodResult.setResult(MethodResult.FAILURE);
			methodResult.setResultMsg("卡号"+vipcardno+"在系统中没有记录，不能刷卡上车");
			return methodResult;
		}
		Customer customer = (Customer) dao.get(Customer.class, vip.getCustomerid());
		Organization checkOrganization =  organizationService.getOrgByStationId(checkstationid);
		Scheduleplan scheduleplan = (Scheduleplan) dao.get(Scheduleplan.class, scheduleplanid);
		Schedule schedule = (Schedule) dao.get(Schedule.class, scheduleplan.getScheduleid());
		//只支持到终点站
		Station reachStation = (Station) dao.get(Station.class, schedule.getRoute().getEndstationid());
		
		//准备锁位参数
		LockSeatsIn paramLockSeatsIn = new LockSeatsIn();
		paramLockSeatsIn.setDepartDate(scheduleplan.getDepartdate());
		paramLockSeatsIn.setDepartStationCode(checkOrganization.getStation().getCode());
		paramLockSeatsIn.setLocktime(0);
		paramLockSeatsIn.setOrderno(java.util.UUID.randomUUID().toString());
		paramLockSeatsIn.setReachStationCode(reachStation.getCode());
		paramLockSeatsIn.setScheduleCode(schedule.getCode());
		paramLockSeatsIn.setScheduleSyncCode(schedule.getSynccode());
		List<String> selectSeatStatus = new ArrayList<String>();
		selectSeatStatus.add("0");
		paramLockSeatsIn.setSelectSeatStatus(selectSeatStatus);
		paramLockSeatsIn.setSellway("12");//一卡通售票
		paramLockSeatsIn.setDeparttime(null);
		
		List<LockseatIn> paramLockseatIns = new ArrayList<LockseatIn>();
		LockseatIn paramLockseatIn = new LockseatIn();
		paramLockseatIn.setPrice(null);
		paramLockseatIn.setSeatno(null);
		paramLockseatIn.setSeattypecode("0");
		paramLockseatIn.setTickettypecode("Q");
		paramLockseatIns.add(paramLockseatIn);
		paramLockSeatsIn.setLockseats(paramLockseatIns);
		
		paramLockSeatsIn.setTicketInvokeType(TicketInvokeType.ONECARD);//一卡通售票

		paramLockSeatsIn.setClientIp(checkOrganization.getServersaddressIp());
		paramLockSeatsIn.setClientOrgcode(checkOrganization.getCode());
		paramLockSeatsIn.setOperateIp(global.getIpAddress());
		paramLockSeatsIn.setOperateOrgcode(checkOrganization.getCode());
		paramLockSeatsIn.setOperateTicketoutletsCode(global.getTicketoutlets().getCode());
		paramLockSeatsIn.setOperateTicketoutletsId(global.getTicketoutlets().getId());
		paramLockSeatsIn.setOperateTicketoutletsName(global.getTicketoutlets().getName());
		paramLockSeatsIn.setOperateUserCode(global.getUserinfo().getCode());
		paramLockSeatsIn.setOperateUserId(global.getUserinfo().getId());
		paramLockSeatsIn.setOperateUserName(global.getUserinfo().getName());
		paramLockSeatsIn.setOppositeOrgcode(checkOrganization.getCode());
		
		LockSeatsOut paramLockSeatsOut = ticketOpCommonService.lockSeat(paramLockSeatsIn);
		if(paramLockSeatsOut.getResult()!=MethodResult.SUCCESS){
			return paramLockSeatsOut;
		}
		
		SellTicketsIn paramSellTicketsIn = new SellTicketsIn();
		paramSellTicketsIn.setBatchno("2222");//做为一卡通电子票号专用的特殊批次号
		paramSellTicketsIn.setOrderno(paramLockSeatsIn.getOrderno());
		paramSellTicketsIn.setPaymethod("2"); //VIP余额购票
		paramSellTicketsIn.setSellway(paramLockSeatsIn.getSellway());
		paramSellTicketsIn.setStartTicketNO(null); 
		paramSellTicketsIn.setBillCustomManage(true);
		paramSellTicketsIn.setVipcardno(vipcardno);
		paramSellTicketsIn.setVipgrade(vipgrade);
		paramSellTicketsIn.setVipmoney(vipmoney);
		paramSellTicketsIn.setVippoint(vippoint);
		
		List<SellTicketIn> paramSellTicketIns = new ArrayList<SellTicketIn>();
		for (LockseatOut paramLockseatOut : paramLockSeatsOut.getLockedseats()) {
			SellTicketIn paramSellTicketIn = new SellTicketIn();
			paramSellTicketIn.setCertificateno(customer.getCertificateno());
			paramSellTicketIn.setCertificatetype(customer.getCertificatetype());
			paramSellTicketIn.setDeparttime(paramLockSeatsOut.getDeparttime());
			paramSellTicketIn.setSeattypeCode(paramLockseatOut.getSeattypecode());
			paramSellTicketIn.setDepartDate(paramLockSeatsIn.getDepartDate());
			
			paramSellTicketIn.setDepartStationCode(checkOrganization.getStation().getCode());
			paramSellTicketIn.setReachStationCode(reachStation.getCode());
			paramSellTicketIn.setSchedulecode(schedule.getCode());
			paramSellTicketIn.setSchedulesynccode(schedule.getSynccode());
			paramSellTicketIn.setSeatno(paramLockseatOut.getSeatno());
			paramSellTicketIn.setSeatnostr(null);
			paramSellTicketIn.setServicefee(new BigDecimal(0));
			if(carrychild){
				paramSellTicketIn.setCarrychildnum((byte) 1);
			}else{
				paramSellTicketIn.setCarrychildnum((byte) 0);
			}
			paramSellTicketIn.setEticketauthcode(null);
			paramSellTicketIn.setEticketid(null);//电子票ID
			String eticketno = generateEticketno();
			paramSellTicketIn.setEticketno(eticketno);//电子票号
			paramSellTicketIn.setPrice(paramLockseatOut.getPrice());
			paramSellTicketIn.setServicefee(new BigDecimal(0));//服务费 默认为0
			
			//票类型字符串：Q-全票 B-半票 E-优惠票（全票带一个免票小孩） 如需买3张全票2张半票1张优惠票时，该域应为QQQBBE
			paramSellTicketIn.setTickettypeCode(paramLockseatOut.getTickettypecode());
			paramSellTicketIns.add(paramSellTicketIn);
		}
		paramSellTicketsIn.setSellseats(paramSellTicketIns);
		
		paramSellTicketsIn.setTicketInvokeType(paramLockSeatsIn.getTicketInvokeType());
		paramSellTicketsIn.setOperateOrgcode(paramLockSeatsIn.getOperateOrgcode());
		paramSellTicketsIn.setOperateIp(paramLockSeatsIn.getOperateIp());
		paramSellTicketsIn.setOperateUserCode(paramLockSeatsIn.getOperateUserCode());
		paramSellTicketsIn.setOperateUserName(paramLockSeatsIn.getOperateUserName());
		paramSellTicketsIn.setOperateUserId(paramLockSeatsIn.getOperateUserId());
		paramSellTicketsIn.setOperateTicketoutletsCode(paramLockSeatsIn.getOperateTicketoutletsCode());
		paramSellTicketsIn.setOperateTicketoutletsName(paramLockSeatsIn.getOperateTicketoutletsName());
		paramSellTicketsIn.setOperateTicketoutletsId(paramLockSeatsIn.getOperateTicketoutletsId());
		paramSellTicketsIn.setOppositeOrgcode(paramLockSeatsIn.getOppositeOrgcode());
		paramSellTicketsIn.setClientOrgcode(paramLockSeatsIn.getClientOrgcode());
		paramSellTicketsIn.setClientIp(paramLockSeatsIn.getClientIp());

		SellTicketsOut paramSellTicketsOut = ticketOpCommonService.sellticket(paramSellTicketsIn);
		if(paramSellTicketsOut.getResult()!=MethodResult.SUCCESS){
			UnLockSeatsIn paramUnLockSeatsIn = new UnLockSeatsIn();
			paramUnLockSeatsIn.setOrderno(paramLockSeatsIn.getOrderno());
			paramUnLockSeatsIn.setDepartDate(null);
			paramUnLockSeatsIn.setScheduleCode(null);
			paramUnLockSeatsIn.setScheduleSyncCode(null);
			paramUnLockSeatsIn.setSeatnos(null);
			
			paramUnLockSeatsIn.setTicketInvokeType(paramLockSeatsIn.getTicketInvokeType());
			paramUnLockSeatsIn.setOperateOrgcode(paramLockSeatsIn.getOperateOrgcode());
			paramUnLockSeatsIn.setOperateIp(paramLockSeatsIn.getOperateIp());
			paramUnLockSeatsIn.setOperateUserCode(paramLockSeatsIn.getOperateUserCode());
			paramUnLockSeatsIn.setOperateUserName(paramLockSeatsIn.getOperateUserName());
			paramUnLockSeatsIn.setOperateUserId(paramLockSeatsIn.getOperateUserId());
			paramUnLockSeatsIn.setOperateTicketoutletsCode(paramLockSeatsIn.getOperateTicketoutletsCode());
			paramUnLockSeatsIn.setOperateTicketoutletsName(paramLockSeatsIn.getOperateTicketoutletsName());
			paramUnLockSeatsIn.setOperateTicketoutletsId(paramLockSeatsIn.getOperateTicketoutletsId());
			paramUnLockSeatsIn.setOppositeOrgcode(paramLockSeatsIn.getOppositeOrgcode());
			paramUnLockSeatsIn.setClientOrgcode(paramLockSeatsIn.getClientOrgcode());
			paramUnLockSeatsIn.setClientIp(paramLockSeatsIn.getClientIp());

			try {
				ticketOpCommonService.unlockSeat(paramUnLockSeatsIn);
			} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
			}
			return paramSellTicketsOut;
		}
		
		//调用检票
		List<Ticketsell> ticketsells = new ArrayList<Ticketsell>();
		for (SellTicketOut sellTicketOut : paramSellTicketsOut.getSelledtickets()) {
			try {
				Ticketsell ticketsell = checkticketService.checkByticketno(checkOrganization.getStation().getId()
																			,vehiclereportid
																			,sellTicketOut.getTicketno()
																			,global
																			,false
																			,global.getIpAddress()
																			,ticketentrance);
				ticketsells.add(ticketsell);
			} catch (ServiceException e) {
//				getContext().setRollbackOnly();
				methodResult.setResult(MethodResult.FAILURE);
				methodResult.setResultMsg(e.getExceptionMessage());
				return methodResult;
			}
		}
		methodResult.setResult(MethodResult.SUCCESS);
		methodResult.setObject(ticketsells);
		StringBuilder msg = null;
		if(!scheduleplan.getIslinework()){
			msg = new StringBuilder("");
			for (Ticketsell ticketsell : ticketsells) {
				if(msg.toString().equals("")){
					msg.append(ticketsell.getSeatno());
				}else{
					msg.append("、").append(ticketsell.getSeatno());
				}
			}
			msg.insert(0, "座位号为：");
		}else{
			msg = new StringBuilder("流水班无座位");
		}
		msg.insert(0, "刷卡上车成功。");
		methodResult.setResultMsg(msg.toString());
		return methodResult;
	}

	/**
	 * 查询一卡通卡号当天的购票信息
	 * @param vipcardno
	 * @return
	 */
	public List<Map<String,Object>> findTicketinfo(String vipcardno){
		StringBuilder sb = new StringBuilder();
		sb.append("select case when ts.ticketstatus='0' and ts.ischecked=1 and ts.isdepartinvoices=0 then 1 ")
		.append("         else null end as isselected")
		.append("       ,ts.ticketno,ts.departdate,trim(ts.departtime),ts.seatno,ts.islinework,ts.carrychildnum")
		.append("       ,ts.price,sc.code as schedulecode,str.name as reachstationname,ts.ticketstatus")
		.append("       ,ddt.value as ticketstatusname,ts.isdepartinvoices,ts.ischecked,ts.selltime ")
		.append(" from ticketsell ts,vipconsumeldetail vcd,vipconsume vc,vip v,schedule sc,station str,digitaldictionary dd,digitaldictionarydetail ddt")
		.append(" where ts.sellway='12' and ts.paymethod='2' and ts.scheduleid=sc.id and ts.reachstationid=str.id	")
		.append("  and vcd.isselfschedule=1 and vcd.sellid=ts.id  and vcd.vipconsumeid=vc.id                        ")
		.append("  and vc.type='0' and vc.vipid=v.id  ")
		.append("  and dd.tablename='ticketsell' and dd.columnname='ticketstatus' ")
		.append("  and dd.id=ddt.digitaldictionaryid and ddt.code=ts.ticketstatus")
		.append("  and v.vipcardno=").append(vipcardno)
		.append("  and ts.departdate=:departdate")
		;
		Query query = dao.getEntityManager().createNativeQuery(sb.toString());
		query.setParameter("departdate", DateUtils.trunc(new Date()));
		return ListUtil.listToMap(new Object[]{"isselected","ticketno","departdate","departtime","seatno","islinework","carrychildnum"
												,"price","schedulecode","reachstationname","ticketstatus"
												,"ticketstatusname","isdepartinvoices","ischecked","selltime"}
								, query.getResultList(), 
								new Object[]{Boolean.class,String.class,Date.class,String.class,Integer.class,Boolean.class,Integer.class
											,BigDecimal.class,String.class,String.class,String.class
											,String.class,Boolean.class,Boolean.class,Timestamp.class}
								);
	}
	

	/**
	 * 退检并退票 , 只能退当天发车的车票，不收取手续费
	 * @param global
	 * @param checkstationid 检票站点
	 * @param ticketnos 要退票的票号列表
	 * @return
	 * @throws Exception 
	 */
	public MethodResult returncheckandsell(Global global,long checkstationid,List<String> ticketnos,String vipcardno
			,String vipgrade,BigDecimal vipmoney,BigDecimal vippoint) throws Exception{
		MethodResult methResult = new MethodResult();
		for (String ticketno : ticketnos) {
			//退检
			try {
				checkticketService.cancelCheckticket(checkstationid, ticketno, global,0);
			} catch (ServiceException e) {
//				getContext().setRollbackOnly();
				methResult.setResultMsg(e.getExceptionMessage());
				return methResult;
			}
		}

		//退票
		ReturnTicketsIn paramreturnticketsin = new ReturnTicketsIn();
		paramreturnticketsin.setBillCustomManage(true);
		paramreturnticketsin.setReturnPrintStartNo(null);
		paramreturnticketsin.setReturnbatchno("2222");//做为一卡通专用的特殊批次号
		paramreturnticketsin.setRemarks(null);
		paramreturnticketsin.setReturnway("2"); //特权退票
		paramreturnticketsin.setVipcardno(vipcardno);
		paramreturnticketsin.setVipgrade(vipgrade);
		paramreturnticketsin.setVipmoney(vipmoney);
		paramreturnticketsin.setVippoint(vippoint);
		
		paramreturnticketsin.setReturnTickets(new ArrayList<ReturnTicketIn>());
		for (String ticketno : ticketnos) {
			Ticketsell ticketsell;
			try {
				ticketsell = ticketService.getTicket(ticketno, DateUtils.trunc(new Date()));
			} catch (ServiceException e) {
				methResult.setResultMsg("票号"+ticketno+"不存在，或不是今天发车！");
//				getContext().setRollbackOnly();
				return methResult;
			}
			if(ticketsell==null){
				methResult.setResultMsg("票号"+ticketno+"不存在，或不是今天发车！");
//				getContext().setRollbackOnly();
				return methResult;
			}
			ReturnTicketIn returnTicketIn = new ReturnTicketIn();
			returnTicketIn.setOrderno(ticketsell.getOrderno());
			returnTicketIn.setTicketno(ticketno);
			returnTicketIn.setCharge(new BigDecimal(0));
			returnTicketIn.setPrice(ticketsell.getPrice());
			paramreturnticketsin.getReturnTickets().add(returnTicketIn);
		}
		
		Organization checkOrganization =  organizationService.getOrgByStationId(checkstationid);
		
		paramreturnticketsin.setTicketInvokeType(TicketInvokeType.ONECARD);
		paramreturnticketsin.setOperateOrgcode(checkOrganization.getCode());
		paramreturnticketsin.setOperateIp(global.getIpAddress());
		paramreturnticketsin.setOperateUserCode(global.getUserinfo().getCode());
		paramreturnticketsin.setOperateUserName(global.getUserinfo().getName());
		paramreturnticketsin.setOperateUserId(global.getUserinfo().getId());
		paramreturnticketsin.setOperateTicketoutletsCode(global.getTicketoutlets().getCode());
		paramreturnticketsin.setOperateTicketoutletsName(global.getTicketoutlets().getName());
		paramreturnticketsin.setOperateTicketoutletsId(global.getTicketoutlets().getId());
		paramreturnticketsin.setOppositeOrgcode(checkOrganization.getCode());
		paramreturnticketsin.setClientOrgcode(global.getOrganization().getCode());
		paramreturnticketsin.setClientIp(global.getIpAddress());
		
		ReturnTicketsOut returnTicketsOut = ticketOpCommonService.returnticket(paramreturnticketsin);
		if(returnTicketsOut.getResult()!=MethodResult.SUCCESS){
//			getContext().setRollbackOnly();
			return returnTicketsOut;
		}
		
		methResult.setResult(MethodResult.SUCCESS);
		return methResult;
	}
	
	public CheckticketService getCheckticketService() {
		return checkticketService;
	}

	public void setCheckticketService(CheckticketService checkticketService) {
		this.checkticketService = checkticketService;
	}

	public TicketOpCommonService getTicketOpCommonService() {
		return ticketOpCommonService;
	}

	public void setTicketOpCommonService(TicketOpCommonService ticketOpCommonService) {
		this.ticketOpCommonService = ticketOpCommonService;
	}
//
//	public SessionContext getContext() {
//		return context;
//	}
//
//	public void setContext(SessionContext context) {
//		this.context = context;
//	}

	public VipService getVipService() {
		return vipService;
	}

	public void setVipService(VipService vipService) {
		this.vipService = vipService;
	}

	public IDAO getDao() {
		return dao;
	}

	public void setDao(IDAO dao) {
		this.dao = dao;
	}

	public OrganizationService getOrganizationService() {
		return organizationService;
	}

	public void setOrganizationService(OrganizationService organizationService) {
		this.organizationService = organizationService;
	}

	public TicketService getTicketService() {
		return ticketService;
	}

	public void setTicketService(TicketService ticketService) {
		this.ticketService = ticketService;
	}

}
