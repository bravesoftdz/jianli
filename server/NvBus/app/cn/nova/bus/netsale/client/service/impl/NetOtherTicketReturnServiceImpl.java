/**
 * 
 */
package cn.nova.bus.netsale.client.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.LockModeType;

import util.TransactionUtil;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.netsale.client.service.NetOtherTicketReturnService;
import cn.nova.bus.netsale.model.TicketReturnInfo;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.sale.model.Ticketreturn;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.model.Ticketsellagent;
import cn.nova.bus.system.dao.ExceptioninfoDao;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.service.OrganizationService;
import cn.nova.bus.system.service.impl.OrganizationServiceImpl;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;

/**
 * @author Administrator
 *
 */
public class NetOtherTicketReturnServiceImpl implements NetOtherTicketReturnService {

	private IDAO dao = new EntityManagerDaoSurport();;
	
	private OrganizationService organizationService = new OrganizationServiceImpl();
	
	private ExceptioninfoDao exceptioninfoDao = new ExceptioninfoDao();
	
//	@EJB
//	private TicketturnoverdetailService ticketturnoverdetailService;
	
	private MethodResult returnTicketsell(MethodResult methodResult,TicketReturnInfo ticket) {
		Date now = new Date();
		
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!batchno", ticket.getBatchno()));
		propertyFilters.add(new PropertyFilter("EQS_t!ticketno", ticket.getTicketno()));
		Ticketsell ticketsell = (Ticketsell) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Ticketsell.class, propertyFilters);
		if(ticketsell==null){
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0187"));
			return methodResult;
		}
		else if("1".equals(ticketsell.getTicketstatus())){
//			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0188"));
			methodResult.setResult(9);
			return methodResult;
		}
		else if("2".equals(ticketsell.getTicketstatus())){
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0189"));
			return methodResult;
		}
		else if(ticketsell.getIschecked()){
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0190"));
			return methodResult;
		}
		else{
			Organization organization_return = organizationService.getById(ticketsell.getOrgid());

			ticketsell.setTicketstatus("1"); //退票
			ticketsell.setUpdateby(0L);
			ticketsell.setUpdatetime(now);
			dao.merge(ticketsell);
			
			//锁定班次并更新剩余票数
			Scheduleplan scheduleplan = (Scheduleplan) dao.get(LockModeType.PESSIMISTIC_READ,Scheduleplan.class, ticketsell.getScheduleplanid());
//			if(!ticketsell.getIslinework()
			if(!scheduleplan.getIslinework()
					&&!"2".equals(scheduleplan.getWorktype())
					&&!"3".equals(scheduleplan.getWorktype())){
				//检查座位状态
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketsell.getScheduleplanid()));
				propertyFilters.add(new PropertyFilter("EQR_t!seatno", ticketsell.getSeatno()));
				Scheduleseats scheduleseat = (Scheduleseats) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleseats.class, propertyFilters);
				if(scheduleseat==null){
					methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0204")+":票号"+ticketsell.getTicketno());
					return methodResult;
				}
				else if(!"2".equals(scheduleseat.getStatus())){
					methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0263")+":票号"+ticketsell.getTicketno());
					return methodResult;
				}
				scheduleseat.setStatus("0");
				scheduleseat.setUpdateby(0L);
				scheduleseat.setUpdatetime(now);
				dao.merge(scheduleseat);
			}

			scheduleplan.setSoldeatnum((short) (scheduleplan.getSoldeatnum()-1));
			scheduleplan.setCarrychildnum((short) (scheduleplan.getCarrychildnum()-ticketsell.getCarrychildnum()));
			scheduleplan.setUpdateby(0L);
			scheduleplan.setUpdatetime(now);
			dao.merge(scheduleplan);
			//票价表要更新不区分发车站到达站
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketsell.getScheduleplanid()));
			propertyFilters.add(new PropertyFilter("EQS_t!seattype", ticketsell.getSeattype()));
			List<Ticketprice> ticketprices = dao.find(LockModeType.PESSIMISTIC_READ,Ticketprice.class, propertyFilters);
			for (Ticketprice _ticketprice : ticketprices){
				_ticketprice.setSoldeatnum((short) (_ticketprice.getSoldeatnum()-1));
				_ticketprice.setUpdateby(0L);
				_ticketprice.setUpdatetime(now);
				dao.merge(_ticketprice);
			}
			Ticketreturn ticketreturn = new Ticketreturn();
			if(!"".equals(ticket.getReturnvoucherno())&&ticket.getReturnvoucherno()!=null&&!"".equals(ticket.getReturnBilltypecode())&&ticket.getReturnBilltypecode()!=null){
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!code", ticket.getReturnBilltypecode()));
				Billtype billtype = (Billtype) dao.uniqueResult(Billtype.class,propertyFilters);
				ticketreturn.setBilltype(billtype);
			}
			else{
				ticketreturn.setBilltype(null);
			}
			ticketreturn.setBatchno(ticket.getReturnbatchno());
			ticketreturn.setCharges(ticket.getCharges());
			ticketreturn.setReturnip(organization_return.getServersaddressIp());
			ticketreturn.setCreateby(0L);
			ticketreturn.setCreatetime(now);
			ticketreturn.setIsselfschedule(true);
			ticketreturn.setReturnamount(ticketsell.getPrice().subtract(ticket.getCharges()));
			ticketreturn.setReturnvoucherno(ticket.getReturnvoucherno());
			ticketreturn.setReturnby(0L);
			ticketreturn.setReturntime(now);
			ticketreturn.setReturnway("0");
			ticketreturn.setRemarks(ticket.getRemarks());
			ticketreturn.setSellid(ticketsell.getId());
			ticketreturn.setTicketoutletsid(0L);
			ticketreturn.setTicketprice(ticketsell.getPrice());
			ticketreturn.setTurnoverdetailid(null);
			ticketreturn.setUpdateby(0L);
			ticketreturn.setUpdatetime(now);
			dao.merge(ticketreturn);
		}
		methodResult.setResult(1);
		return methodResult;
	}
	
	private MethodResult returnTicketsellagent(MethodResult methodResult,TicketReturnInfo ticket) {
		Date now = new Date();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!batchno", ticket.getBatchno()));
		propertyFilters.add(new PropertyFilter("EQS_t!ticketno", ticket.getTicketno()));
		Ticketsellagent ticketsellagent = (Ticketsellagent) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Ticketsellagent.class, propertyFilters);
		if(ticketsellagent==null){
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0175"));
			return methodResult;
		}
		else if("1".equals(ticketsellagent.getTicketstatus())){
//			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0176"));
			methodResult.setResult(9);
			return methodResult;
		}
		else if("2".equals(ticketsellagent.getTicketstatus())){
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0177"));
			return methodResult;
		}
		else{
			Organization organization_return = organizationService.getById(ticketsellagent.getOrgid());
			ticketsellagent.setTicketstatus("1"); //退票
			ticketsellagent.setUpdateby(0L);
			ticketsellagent.setUpdatetime(now);
			dao.merge(ticketsellagent);

			Ticketreturn ticketreturn = new Ticketreturn();
			if(!"".equals(ticket.getReturnvoucherno())&&ticket.getReturnvoucherno()!=null&&!"".equals(ticket.getReturnBilltypecode())&&ticket.getReturnBilltypecode()!=null){
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!code", ticket.getReturnBilltypecode()));
				Billtype billtype = (Billtype) dao.uniqueResult(Billtype.class,propertyFilters);
				ticketreturn.setBilltype(billtype);
			}
			else{
				ticketreturn.setBilltype(null);
			}
			ticketreturn.setBatchno(ticket.getReturnbatchno());
			ticketreturn.setCharges(ticket.getCharges());
			ticketreturn.setReturnip(organization_return.getServersaddressIp());
			ticketreturn.setCreateby(0L);
			ticketreturn.setCreatetime(now);
			ticketreturn.setIsselfschedule(true);
			ticketreturn.setReturnamount(ticketsellagent.getPrice().subtract(ticket.getCharges()));
			ticketreturn.setReturnvoucherno(ticket.getReturnvoucherno());
			ticketreturn.setReturnby(0L);
			ticketreturn.setReturntime(now);
			ticketreturn.setReturnway("0");
			ticketreturn.setRemarks(ticket.getRemarks());
			ticketreturn.setSellid(ticketsellagent.getId());
			ticketreturn.setTicketoutletsid(0L);
			ticketreturn.setTicketprice(ticketsellagent.getPrice());
			ticketreturn.setTurnoverdetailid(null);
			ticketreturn.setUpdateby(0L);
			ticketreturn.setUpdatetime(now);
			dao.merge(ticketreturn);
			//0现金、1银联卡、2贵客卡余额、3贵客卡积分
//			if("2".equals(ticketsellagent.getPaymethod())||"3".equals(ticketsellagent.getPaymethod())){
//				ticketturnoverdetail.setNonvouchermoneypayable(ticketturnoverdetail.getNonvouchermoneypayable().subtract(ticketreturn.getReturnamount()));
//			}
		}
		methodResult.setResult(1);
		return methodResult;
	}
	
	/* (non-Javadoc)
	 * @see cn.nova.bus.netsale.client.service.NetOtherTicketCancelService#cancelTickets(java.util.List, java.lang.String, java.lang.String)
	 */
	@Override
	public MethodResult returnTickets(List<TicketReturnInfo> tickets,
			String cancelbyname, String ticketoutlets) {
//		checkClientOrgIp(remoteInvokeAuxiliaryProperty);
		MethodResult methodResult = new MethodResult();
		
		
		methodResult.setResult(MethodResult.SUCCESS);
		//退票
		for (TicketReturnInfo ticket : tickets) {
			methodResult.setResult(0);
			if(ticket.getIsselfschedule()){
				methodResult = returnTicketsell(methodResult, ticket);
			}
			else{
				methodResult = returnTicketsellagent(methodResult, ticket);
			}
			
			if(methodResult.getResult() == 9){
				//过滤已经有记录的票
				methodResult.setResult(1);
				continue;
			}else if(methodResult.getResult()== 0){
				break;
			}
		}
		if(methodResult.getResult() == MethodResult.FAILURE){
			TransactionUtil.setRollbackOnly();
		}
		//TODO 退保险
		return methodResult;
	}
	
	/**
	 * 联网改签
	 */
	public MethodResult changetickets_O2L(List<TicketReturnInfo> tickets, String cancelbyname,String ticketoutlets) {
		MethodResult methodResult = new MethodResult();
		
		methodResult.setResult(MethodResult.SUCCESS);
		//退票
		for (TicketReturnInfo ticket : tickets) {
			methodResult.setResult(0);
			if(ticket.getIsselfschedule()){
				methodResult = returnTicketsell_O2L(methodResult, ticket);//对于本站来说是本售异
			}
			else{
				methodResult = returnTicketsellagent_O2L(methodResult, ticket);//对于本站来说是异售本
			}
			
			if(methodResult.getResult() == 9){
				//过滤已经有记录的票
				methodResult.setResult(1);
				continue;
			}else if(methodResult.getResult()== 0){
				break;
			}
		}
		if(methodResult.getResult() == MethodResult.FAILURE){
			TransactionUtil.setRollbackOnly();
		}
		//TODO 退保险
		return methodResult;
	}
	//联网改签，对于改签站来说是对本售异s车票进行改签，对于本站来说是异售本车票被发车站改签。
	private MethodResult returnTicketsell_O2L(MethodResult methodResult,TicketReturnInfo ticket) {
		Date now = new Date();
		
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!batchno", ticket.getBatchno()));
		propertyFilters.add(new PropertyFilter("EQS_t!ticketno", ticket.getTicketno()));
		Ticketsell ticketsell = (Ticketsell) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Ticketsell.class, propertyFilters);
		if(ticketsell==null){
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0187"));
			return methodResult;
		}
		else if("1".equals(ticketsell.getTicketstatus())){
//			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0188"));
			methodResult.setResult(9);
			return methodResult;
		}
		else if("2".equals(ticketsell.getTicketstatus())){
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0189"));
			return methodResult;
		}
		else if(ticketsell.getIschecked()){
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0190"));
			return methodResult;
		}
		else{
			Organization organization_return = organizationService.getById(ticketsell.getOrgid());

			ticketsell.setTicketstatus("1"); //退票
			ticketsell.setUpdateby(0L);
			ticketsell.setUpdatetime(now);
			dao.merge(ticketsell);
			
			//锁定班次并更新剩余票数
			Scheduleplan scheduleplan = (Scheduleplan) dao.get(LockModeType.PESSIMISTIC_READ,Scheduleplan.class, ticketsell.getScheduleplanid());
//			if(!ticketsell.getIslinework()
			if(!scheduleplan.getIslinework()
					&&!"2".equals(scheduleplan.getWorktype())
					&&!"3".equals(scheduleplan.getWorktype())){
				//检查座位状态
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketsell.getScheduleplanid()));
				propertyFilters.add(new PropertyFilter("EQR_t!seatno", ticketsell.getSeatno()));
				Scheduleseats scheduleseat = (Scheduleseats) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleseats.class, propertyFilters);
				if(scheduleseat==null){
					methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0204")+":票号"+ticketsell.getTicketno());
					return methodResult;
				}
				else if(!"2".equals(scheduleseat.getStatus())){
					methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0263")+":票号"+ticketsell.getTicketno());
					return methodResult;
				}
				scheduleseat.setStatus("0");
				scheduleseat.setUpdateby(0L);
				scheduleseat.setUpdatetime(now);
				dao.merge(scheduleseat);
			}

			scheduleplan.setSoldeatnum((short) (scheduleplan.getSoldeatnum()-1));
			scheduleplan.setCarrychildnum((short) (scheduleplan.getCarrychildnum()-ticketsell.getCarrychildnum()));
			scheduleplan.setUpdateby(0L);
			scheduleplan.setUpdatetime(now);
			dao.merge(scheduleplan);
			//票价表要更新不区分发车站到达站
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketsell.getScheduleplanid()));
			propertyFilters.add(new PropertyFilter("EQS_t!seattype", ticketsell.getSeattype()));
			List<Ticketprice> ticketprices = dao.find(LockModeType.PESSIMISTIC_READ,Ticketprice.class, propertyFilters);
			for (Ticketprice _ticketprice : ticketprices){
				_ticketprice.setSoldeatnum((short) (_ticketprice.getSoldeatnum()-1));
				_ticketprice.setUpdateby(0L);
				_ticketprice.setUpdatetime(now);
				dao.merge(_ticketprice);
			}
			Ticketreturn ticketreturn = new Ticketreturn();
			if(!"".equals(ticket.getReturnvoucherno())&&ticket.getReturnvoucherno()!=null&&!"".equals(ticket.getReturnBilltypecode())&&ticket.getReturnBilltypecode()!=null){
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!code", ticket.getReturnBilltypecode()));
				Billtype billtype = (Billtype) dao.uniqueResult(Billtype.class,propertyFilters);
				ticketreturn.setBilltype(billtype);
			}
			else{
				ticketreturn.setBilltype(null);
			}
			ticketreturn.setBatchno(ticket.getReturnbatchno());
			ticketreturn.setCharges(ticket.getCharges());
			ticketreturn.setReturnip(organization_return.getServersaddressIp());
			ticketreturn.setCreateby(0L);
			ticketreturn.setCreatetime(now);
			ticketreturn.setIsselfschedule(true);
			ticketreturn.setReturnamount(ticketsell.getPrice().subtract(ticket.getCharges()));
			ticketreturn.setReturnvoucherno(ticket.getReturnvoucherno());
			ticketreturn.setReturnby(0L);
			ticketreturn.setReturntime(now);
			ticketreturn.setReturnway("3");//改签自动退
			ticketreturn.setRemarks(ticket.getRemarks());
			ticketreturn.setSellid(ticketsell.getId());
			ticketreturn.setTicketoutletsid(0L);
			ticketreturn.setTicketprice(ticketsell.getPrice());
			ticketreturn.setTurnoverdetailid(null);
			ticketreturn.setUpdateby(0L);
			ticketreturn.setUpdatetime(now);
			dao.merge(ticketreturn);
		}
		methodResult.setResult(1);
		return methodResult;
	}
	//联网改签，对于改签站来说是对异售本车票进行改签，对于本站来说是本售异车票被发车站改签。
	private MethodResult returnTicketsellagent_O2L(MethodResult methodResult,TicketReturnInfo ticket) {
		Date now = new Date();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!batchno", ticket.getBatchno()));
		propertyFilters.add(new PropertyFilter("EQS_t!ticketno", ticket.getTicketno()));
		Ticketsellagent ticketsellagent = (Ticketsellagent) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Ticketsellagent.class, propertyFilters);
		if(ticketsellagent==null){
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0175"));
			return methodResult;
		}
		else if("1".equals(ticketsellagent.getTicketstatus())){
//			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0176"));
			methodResult.setResult(9);
			return methodResult;
		}
		else if("2".equals(ticketsellagent.getTicketstatus())){
			methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0177"));
			return methodResult;
		}
		else{
			Organization organization_return = organizationService.getById(ticketsellagent.getOrgid());
			ticketsellagent.setTicketstatus("1"); //退票
			ticketsellagent.setUpdateby(0L);
			ticketsellagent.setUpdatetime(now);
			dao.merge(ticketsellagent);

			Ticketreturn ticketreturn = new Ticketreturn();
			if(!"".equals(ticket.getReturnvoucherno())&&ticket.getReturnvoucherno()!=null&&!"".equals(ticket.getReturnBilltypecode())&&ticket.getReturnBilltypecode()!=null){
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!code", ticket.getReturnBilltypecode()));
				Billtype billtype = (Billtype) dao.uniqueResult(Billtype.class,propertyFilters);
				ticketreturn.setBilltype(billtype);
			}
			else{
				ticketreturn.setBilltype(null);
			}
			ticketreturn.setBatchno(ticket.getReturnbatchno());
			ticketreturn.setCharges(ticket.getCharges());
			ticketreturn.setReturnip(organization_return.getServersaddressIp());
			ticketreturn.setCreateby(0L);
			ticketreturn.setCreatetime(now);
			ticketreturn.setIsselfschedule(true);
			ticketreturn.setReturnamount(ticketsellagent.getPrice().subtract(ticket.getCharges()));
			ticketreturn.setReturnvoucherno(ticket.getReturnvoucherno());
			ticketreturn.setReturnby(0L);
			ticketreturn.setReturntime(now);
			ticketreturn.setReturnway("3");//改签自动退票
			ticketreturn.setRemarks(ticket.getRemarks());
			ticketreturn.setSellid(ticketsellagent.getId());
			ticketreturn.setTicketoutletsid(0L);
			ticketreturn.setTicketprice(ticketsellagent.getPrice());
			ticketreturn.setTurnoverdetailid(null);
			ticketreturn.setUpdateby(0L);
			ticketreturn.setUpdatetime(now);
			dao.merge(ticketreturn);
			//0现金、1银联卡、2贵客卡余额、3贵客卡积分
//			if("2".equals(ticketsellagent.getPaymethod())||"3".equals(ticketsellagent.getPaymethod())){
//				ticketturnoverdetail.setNonvouchermoneypayable(ticketturnoverdetail.getNonvouchermoneypayable().subtract(ticketreturn.getReturnamount()));
//			}
		}
		methodResult.setResult(1);
		return methodResult;
	}

}
