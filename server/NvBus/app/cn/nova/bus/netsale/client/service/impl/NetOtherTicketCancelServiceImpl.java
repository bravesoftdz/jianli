/**
 * 
 */
package cn.nova.bus.netsale.client.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.LockModeType;

import util.TransactionUtil;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.netsale.client.service.NetOtherTicketCancelService;
import cn.nova.bus.netsale.model.TicketInfo;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.sale.model.Ticketcancel;
import cn.nova.bus.sale.model.Ticketsell;
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
public class NetOtherTicketCancelServiceImpl implements
		NetOtherTicketCancelService {

	private IDAO dao = new EntityManagerDaoSurport();	
	private OrganizationService organizationService = new OrganizationServiceImpl();
	private ExceptioninfoDao exceptioninfoDao = new ExceptioninfoDao();
	
	
	/* (non-Javadoc)
	 * @see cn.nova.bus.netsale.client.service.NetOtherTicketCancelService#cancelTickets(java.util.List, java.lang.String, java.lang.String)
	 */
	@Override
	public MethodResult cancelTickets(List<TicketInfo> tickets,
			String cancelbyname, String ticketoutlets) {
//		checkClientOrgIp(remoteInvokeAuxiliaryProperty);
		MethodResult methodResult = new MethodResult();
		Date now = new Date();
		
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		Organization organization_depart = null;
		Organization organization_seller = null;
		
		methodResult.setResult(MethodResult.SUCCESS);
		
		//废票
		for (TicketInfo ticket : tickets) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!batchno", ticket.getBatchno()));
			propertyFilters.add(new PropertyFilter("EQS_t!ticketno", ticket.getTicketno()));
			Ticketsell ticketsell = (Ticketsell) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Ticketsell.class, propertyFilters);
			if(ticketsell==null){
				methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0187"));
				methodResult.setResult(MethodResult.FAILURE);
				break;
			}
			else if(ticketsell.getIschecked()){
				methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0190"));
				methodResult.setResult(MethodResult.FAILURE);
				break;
			}
			else if("1".equals(ticketsell.getTicketstatus())){
				methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0188"));
				methodResult.setResult(MethodResult.FAILURE);
				break;
			}
			else if("2".equals(ticketsell.getTicketstatus())){
				//因为只有售票站与发车站才能废票，并且凭票废票，所以默认只能一处退票。
				//此处用continue,是因为将竞态判断挪到退票点
				continue;
			}
			else{
				if(organization_depart==null){
					//取机构 
					organization_depart = organizationService.getOrgByStationId(ticketsell.getDepartstationid());
					organization_seller = (Organization) dao.get(Organization.class, ticketsell.getOrgid());
				}

				ticketsell.setTicketstatus("2"); //废票
				ticketsell.setUpdateby(0L);
				ticketsell.setUpdatetime(now);
				dao.merge(ticketsell);
				
				//锁定班次并更新剩余票数
				Scheduleplan scheduleplan = (Scheduleplan) dao.get(LockModeType.PESSIMISTIC_READ,Scheduleplan.class, ticketsell.getScheduleplanid());
				if(!ticketsell.getIslinework()
						&&!"2".equals(scheduleplan.getWorktype())
						&&!"3".equals(scheduleplan.getWorktype())){
					//检查座位状态
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketsell.getScheduleplanid()));
					propertyFilters.add(new PropertyFilter("EQR_t!seatno", ticketsell.getSeatno()));
					Scheduleseats scheduleseat = (Scheduleseats) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleseats.class, propertyFilters);
					if(scheduleseat==null){
						methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0204")+":票号"+ticketsell.getTicketno());
						methodResult.setResult(MethodResult.FAILURE);
						break;
					}
					else if(!"2".equals(scheduleseat.getStatus())){
						methodResult.setResultMsg(exceptioninfoDao.getExceptioninfo("0263")+":票号"+ticketsell.getTicketno());
						methodResult.setResult(MethodResult.FAILURE);
						break;
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
				Ticketcancel ticketcancel = new Ticketcancel();
				ticketcancel.setCancelby(0);
				ticketcancel.setCancelip(organization_seller.getServersaddressIp());
				ticketcancel.setCanceltime(now);
				ticketcancel.setCancelway("0");
				ticketcancel.setCreateby(0);
				ticketcancel.setCreatetime(now);
				ticketcancel.setIsselfschedule(true);
				ticketcancel.setRemarks(ticket.getRemarks());
				ticketcancel.setSellby(0);
				ticketcancel.setSellid(ticketsell.getId());
				ticketcancel.setTicketoutletsid(0);
				ticketcancel.setTicketprice(ticketsell.getPrice());
				ticketcancel.setTurnoverdetailid(null);
				ticketcancel.setUpdateby(0);
				ticketcancel.setUpdatetime(now);
				dao.merge(ticketcancel);
			}
		}
		
		if(methodResult.getResult() == MethodResult.FAILURE){
			TransactionUtil.setRollbackOnly();
		}
		//TODO 废保险
		return methodResult;
	}

}
