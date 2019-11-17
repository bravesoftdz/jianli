package cn.nova.bus.sale.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.persistence.LockModeType;

import models.TestParams;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import util.CurrentUtil;
import util.DateUtils;
import util.JsonUtil;
import util.RemoteApi;
import util.RpcUtil;
import util.SystemFactory;
import cn.nova.bus.archive.model.Vip;
import cn.nova.bus.archive.model.Vipconsume;
import cn.nova.bus.archive.model.Vipconsumeldetail;
import cn.nova.bus.archive.service.VipService;
import cn.nova.bus.archive.service.impl.VipServiceImpl;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.insure.model.Insurance;
import cn.nova.bus.insure.service.InsurancecancelService;
import cn.nova.bus.insure.service.impl.InsurancecancelServiceImpl;
import cn.nova.bus.netsale.model.TicketInfo;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.sale.dao.TicketDao;
import cn.nova.bus.sale.dao.TicketcancelDao;
import cn.nova.bus.sale.model.CarryChild;
import cn.nova.bus.sale.model.Ticketcancel;
import cn.nova.bus.sale.model.Ticketchange;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.model.Ticketsellagent;
import cn.nova.bus.sale.model.Ticketturnoverdetail;
import cn.nova.bus.sale.service.TicketcancelService;
import cn.nova.bus.sale.service.TicketturnoverdetailService;
import cn.nova.bus.sale.service.VipconsumeService;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.service.OrganizationService;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.OrganizationServiceImpl;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.openapi.sevice.OpenApiAdapter;
import cn.nova.openapi.sevice.impl.OpenApiAdapterImpl;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.RemoteInvokeAuxiliaryProperty;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;


public class TicketcancelServiceImpl implements TicketcancelService {
	final private Logger log=LoggerFactory.getLogger(getClass());
	
	private OrganizationService organizationService = new OrganizationServiceImpl();;
	
	final private int insideInvokFalse = -67101735;

	private TicketcancelDao ticketcancelDao = new TicketcancelDao();
	
	private ParameterService parameterService = new ParameterServiceImpl();
	
	private IDAO dao = new EntityManagerDaoSurport();
	
	private InsurancecancelService insurancecancelService = new InsurancecancelServiceImpl();
	
	private TicketturnoverdetailService ticketturnoverdetailService = new TicketturnoverdetailServiceImpl();
	
	private VipService vipService = new VipServiceImpl();
	
	private BilltypeService billtypeService = new BilltypeServiceImpl();
	
	private VipconsumeService vipconsumeService = new VipconsumeServiceImpl();
	
	@Override
	public MethodResult find(List<PropertyFilter> propertyFilters,Long loginorgid) throws Exception {
		MethodResult methodResult = new MethodResult();
		List<Map<String,Object>> result = ticketcancelDao.find(propertyFilters,loginorgid);
		//判断是否是江西省厅省联网票，如果是，则要提交到省厅接口去查询
		if(result!=null&&result.size()==1&&"0".equals(result.get(0).get("isselfschedule").toString())){
			Organization departorg = organizationService.getById(new Long(result.get(0).get("scheduleorgid").toString()));
			Organization localorg = organizationService.getById(loginorgid);
			if("8".equals(departorg.getType())){
			
//				JxsTicketService jxsTicketService = (JxsTicketService) getCentreInterface(methodResult,localorg,JxsTicketService.class);
//				if(jxsTicketService==null){
//					methodResult.setResultMsg("无法连接中心服务器"+methodResult.getResultMsg());
//					return methodResult;
//				}
//				methodResult = jxsTicketService.findTicket(result.get(0).get("ticketno").toString());

				Map<String, String> requestMap = new HashMap<String, String>();
				requestMap.put("ticketno", result.get(0).get("ticketno").toString());

				Organization centreOrg = organizationService.getDirectlyParentOrg(localorg);
				methodResult = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.FIND_TICKET_JXS, requestMap);		
				
				if(methodResult.getResult()==MethodResult.SUCCESS){
					Object[] objects = (Object[]) methodResult.getObject();
					String ticketstatus = (String) objects[0];
					//00：未锁定		01：已锁定		02：已销售		03：已取票	04：已废票	05：已退票	06: 已检票
					if("02".equals(ticketstatus)){
						result.get(0).put("isselected", 1);
					}else{
						result.get(0).put("isselected", 0);
					}
					if("06".equals(ticketstatus)){
						result.get(0).put("ischecked", 1);
					}else{
						result.get(0).put("ischecked", null);
					}
					if("02".equals(ticketstatus)){
						result.get(0).put("ticketstatus", "0");
					}else if("04".equals(ticketstatus)){
							result.get(0).put("ticketstatus", "1");
					}else if("05".equals(ticketstatus)){
						result.get(0).put("ticketstatus", "2");
					}else{
						result.get(0).put("ticketstatus", "0");
					}
				}else{
					return methodResult;
				}
			}
		}
		/*20170105，禅道编号：4655，云南丘北汽车客运总站需求：团体票支持退其中部分车票
		//处理团体票
		Billtype billtype = null;
		Iterator<Map<String, Object>> iterator =  result.iterator();
		while(iterator.hasNext()){
			Map<String, Object> ticket = iterator.next();
			if("T".equals(ticket.get("tickettype").toString())){
				if(billtype==null){
					billtype = billtypeService.findByCode("Ticket");
				}
				if(billtype.getTicketnolength()<ticket.get("ticketno").toString().length()){
					iterator.remove();
				}
			}
		}
		iterator =  result.iterator();
		while(iterator.hasNext()){
			Map<String, Object> ticket = iterator.next();
			if("T".equals(ticket.get("tickettype").toString())){
				//查出所有车票
				List<PropertyFilter> propertyFilters2 = new ArrayList<PropertyFilter>();
				propertyFilters2.add(new PropertyFilter("EQD_t!departdate", ticket.get("departdate")));
				propertyFilters2.add(new PropertyFilter("GTS_t!ticketno", ticket.get("ticketno")));
				propertyFilters2.add(new PropertyFilter("EQS_t!tickettype", ticket.get("tickettype").toString()));
				StringBuilder sql = new StringBuilder("select t from Ticketsell t where t.ticketno like '")
									.append(ticket.get("ticketno").toString()).append("%'");
				List<Ticketsell> ts_tuans = dao.find(sql.toString(), propertyFilters2);
				for (Ticketsell ts_tuan : ts_tuans) {
					ticket.put("price", ((BigDecimal)ticket.get("price")).add(ts_tuan.getPrice()));
					ticket.put("servicefee", ((BigDecimal)ticket.get("servicefee")).add(ts_tuan.getServicefee()));
//					ticket.put("premium", ((BigDecimal)ticket.get("premium")).add(ts_tuan.getprServicefee()));
				}
			}
		}
		*/
		methodResult.setObject(result);
		methodResult.setResult(MethodResult.SUCCESS);
		return methodResult;
	}

	@Override
	public boolean cancelTickets(List<Ticketcancel> ticketcancels,Global global,
			String vipcardno,String vipgrade,BigDecimal vipmoney,BigDecimal vippoint) throws Exception {
		//儿童票不做单独废票操作，即使前台勾选了，也不可废
		Iterator<Ticketcancel> iterator = ticketcancels.iterator();
		TicketDao ticketdao = new TicketDao(); 
		StringBuffer tsidStr =  new StringBuffer();//所有勾选的废票的ticketsell id(主票+儿童票)，str供校验是否存在没有勾选主票的儿童票做判断使用（判断是否勾选主票使用）
		List<Long> childIdList = new ArrayList<Long>();//所有勾选的废票中儿童票的ticketsell id，list用来查询所有车票中儿童票对应的主票（判断是否勾选主票使用）
		List<Long> primaryIdList = new ArrayList<Long>();//所有勾选的废票中主票的ticketsell id，primaryIdList用来废所有对应的儿童票使用
		Map<Long, Boolean> insuranceMap = new HashMap<Long, Boolean>();//主票是否废保险，供儿童票废保险使用 
//		List<Ticketreturn> childReturnList = new ArrayList<Ticketreturn>();//供儿童票废保险使用
		Ticketsell ts = null;
		boolean hasChild = false;
		while(iterator.hasNext()){
			Ticketcancel tc = iterator.next();
			tsidStr.append(tc.getSellid()).append(",");
			ts = (Ticketsell) dao.get(Ticketsell.class, tc.getSellid());
			if(ts!=null){
				if("E".equals(ts.getTickettype())){
	//				childReturnList.add(tr);
					childIdList.add(tc.getSellid());
					hasChild = true;
					iterator.remove();//移除儿童票
				}else{
					//主票id
					primaryIdList.add(ts.getId());
					insuranceMap.put(ts.getId(), tc.getIscancelinsure());
				}
			}
		}
		if(hasChild){
			//若存在儿童票，则需要判断是否勾选了了主票
			List<Object[]> childInfo = ticketdao.findQTicket(childIdList);
			if(childInfo != null && childInfo.size() > 0){
				for (Object[] child : childInfo) {
					if(!tsidStr.toString().contains(((BigDecimal)child[0]).longValue() + "")){
						//若勾选的票号中不存在某儿童票对应的主票，则不允许废票
						play.Logger.error("未勾选票号为" + ((String) child[1]) + "(儿童票)对应的主票，不允许单独废此儿童票！");
						throw new BusinessException(" 未勾选票号为" + ((String) child[1]) + "(儿童票)对应的主票，不允许单独废此儿童票！");
					}
				}
			}else{
				play.Logger.info("所废车票中不包含儿童票！");
			}
		}
		
		
		int cancelticketnum=0;
		Date now = new Date();
		long selluserid = ticketcancels.get(0).getSellby();
		BigDecimal totalcancelmoney = new BigDecimal(0);
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		
		//异站票需要提交到中心去废票
		List<TicketInfo> tickets = new ArrayList<TicketInfo>();
		
		//异站票需要提交到中心去废票
		List<TicketInfo> opentickets = new ArrayList<TicketInfo>();
	   //跨区配客的要到中心去执行(仅本站售本站班次，且本站废时)
		List<TicketInfo> tickets_worktype3 = new ArrayList<TicketInfo>(); //跨区配客的要到中心去执行
		
		for (Ticketcancel ticketcancel : ticketcancels) {
			if(!ticketcancel.getIscancelticket()){
				continue;
			}
			else{
				cancelticketnum++;
				totalcancelmoney = totalcancelmoney.add(ticketcancel.getTicketprice());
			}
			if(selluserid!=ticketcancel.getSellby()){
				throw new ServiceException("0192");  //废票不能同时废不同售票员售出的车票
			}
		}
		
//		if(cancelticketnum < 1){
//			return true;
//		}
		
		if(TestParams.getNewest().cancelTicket == 1){
			SystemFactory.markRtException();
		}
		
		//找到需要远调的票
		long opponentorgid = findRemoteCallList(ticketcancels,global.getOrganization().getId(), tickets, opentickets,tickets_worktype3);
		
		
		// 如果有售异站票废票，则提交到中心去执行废票
		if(tickets.size()>0){
			MethodResult methodResult = new MethodResult();
			RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty = new RemoteInvokeAuxiliaryProperty();
			remoteInvokeAuxiliaryProperty.setClientIp(global.getOrganization().getServersaddressIp());
			remoteInvokeAuxiliaryProperty.setClientOrgcode(global.getOrganization().getCode());
			remoteInvokeAuxiliaryProperty.setOperateOrgcode(global.getOrganization().getCode());
			remoteInvokeAuxiliaryProperty.setOperateOrgIp(global.getOrganization().getServersaddressIp());
			remoteInvokeAuxiliaryProperty.setOperateTicketoutletsName(global.getTicketoutlets().getName());
			remoteInvokeAuxiliaryProperty.setOperateUserName(global.getUserinfo().getName());
			Organization organization_opponent = (Organization) dao.get(Organization.class, opponentorgid);
			remoteInvokeAuxiliaryProperty.setOppositeOrgcode(organization_opponent.getCode());
			
			//只有售票站才能废票，所以对方站一定是发车站
			Map<String, String> requestMap = new HashMap<String, String>();
			requestMap.put("remoteInvokeAuxiliaryProperty", JsonUtil.toFormatString(remoteInvokeAuxiliaryProperty));
			requestMap.put("tickets", JsonUtil.toFormatString(tickets));

			Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
			if(TestParams.getNewest().cancelTicket == 2){
				SystemFactory.markRtException();
			}
			methodResult = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.CANCEL_TICKETS, requestMap);		
			
			if(methodResult.getResult()!=1){
				throw new BusinessException(methodResult.getResultMsg());
			}
		}
		
		// 如果有售联网中心票废票，则提交到中心去执行废票
		if(opentickets.size()>0){
			if(!CurrentUtil.isOpenApiable()){
				throw new Exception("当前OpenApi售票不可用");
			}
			MethodResult methodResult = new MethodResult();
			OpenApiAdapter openapi = new OpenApiAdapterImpl();
			methodResult = openapi.cancelTicket(opentickets);
			
			if(methodResult.getResult()!=MethodResult.SUCCESS){
				throw new Exception(methodResult.getResultMsg());
			}
			
		}
		
		// 如果有跨区配客班次，则提交到中心去执行废票
		if(tickets_worktype3.size()>0){
			MethodResult methodResult = new MethodResult();
			RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty = new RemoteInvokeAuxiliaryProperty();
			remoteInvokeAuxiliaryProperty.setClientIp(global.getOrganization().getServersaddressIp());
			remoteInvokeAuxiliaryProperty.setClientOrgcode(global.getOrganization().getCode());
			remoteInvokeAuxiliaryProperty.setOperateOrgcode(global.getOrganization().getCode());
			remoteInvokeAuxiliaryProperty.setOperateOrgIp(global.getOrganization().getServersaddressIp());
			remoteInvokeAuxiliaryProperty.setOperateTicketoutletsName(global.getTicketoutlets().getName());
			remoteInvokeAuxiliaryProperty.setOperateUserName(global.getUserinfo().getName());
			
			
			Map<String, String> requestMap = new HashMap<String, String>();
			requestMap.put("remoteInvokeAuxiliaryProperty", JsonUtil.toFormatString(remoteInvokeAuxiliaryProperty));
			requestMap.put("tickets", JsonUtil.toFormatString(tickets_worktype3));

			Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
			if(TestParams.getNewest().cancelTicket == 2){
				SystemFactory.markRtException();
			}
			methodResult = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.SCHEDULE_CANCEL_TICKET, requestMap);		
			
			if(methodResult.getResult()!=MethodResult.SUCCESS){
				throw new BusinessException(methodResult.getResultMsg());
			}
		}
		
		Vip vip = null;
		Vipconsume vipconsume = null;
		//插入或修改应缴款表
		Ticketturnoverdetail ticketturnoverdetail = getTicketturnoverdetailService().getCurTicketturnoverdetail(selluserid, null);//原逻辑

		//废票
		//加上团体票的废票记录
		List<Ticketcancel> ticketcancels_tuan = new ArrayList<Ticketcancel>();
		for (Ticketcancel ticketcancel : ticketcancels) {
			if(!ticketcancel.getIscancelticket()){
				continue;
			}
			// 如果是售异站票，则先存入一个List中，再一次提交到中心去执行废票
			if(ticketcancel.getIsselfschedule()){
				Ticketsell ticketsell = (Ticketsell) dao.get(LockModeType.PESSIMISTIC_READ,Ticketsell.class, ticketcancel.getSellid());
				if(ticketsell==null){
					throw new ServiceException("0187");
				}
				else if("1".equals(ticketsell.getTicketstatus())){
					throw new ServiceException("0188");
				}
				else if("2".equals(ticketsell.getTicketstatus())){
					cancelticketnum--;
					continue;
			//		throw new ServiceException("0189");
				}
				else if(ticketsell.getIschecked()){
					throw new ServiceException("0190");
				}
				else{
					//处理团体票
					List<Ticketsell> ts_tuans = new ArrayList<Ticketsell>();
					ts_tuans.add(ticketsell);
					if("T".equals(ticketsell.getTickettype())){
						//查出所有其它团体车票
						List<PropertyFilter> propertyFilters2 = new ArrayList<PropertyFilter>();
						propertyFilters2.add(new PropertyFilter("EQD_t!departdate", ticketsell.getDepartdate()));
						propertyFilters2.add(new PropertyFilter("GTS_t!ticketno", ticketsell.getTicketno()));
						propertyFilters2.add(new PropertyFilter("EQS_t!tickettype", ticketsell.getTickettype()));
						/* ----------20170105，禅道编号：4655，丘北汽车客运站：团体票支持退其中部分车票，退票时不再查出所有团体票-
						StringBuilder sql = new StringBuilder("select t from Ticketsell t where t.ticketno like '")
											.append(ticketsell.getTicketno()).append("%'");
						ts_tuans.addAll(dao.find(sql.toString(), propertyFilters2));
						 */
						ticketturnoverdetail.setCancelnum(ticketturnoverdetail.getCancelnum()+ts_tuans.size()-1);//团体票其它车票张数也要加上
						for (Ticketsell ts_tuan : ts_tuans) {
							Ticketcancel _ticketcancel = new Ticketcancel();
							_ticketcancel.setCancelby(ticketcancel.getCancelby());
//								_ticketcancel.setCancelinsureid(ticketcancel.getCancelinsureid());
							_ticketcancel.setCancelip(ticketcancel.getCancelip());
							_ticketcancel.setCanceltime(ticketcancel.getCanceltime());
							_ticketcancel.setCancelway(ticketcancel.getCancelway());
							_ticketcancel.setCreateby(ticketcancel.getCreateby());
							_ticketcancel.setCreatetime(ticketcancel.getCreatetime());
//								_ticketcancel.setInsurancesellby(ticketcancel.getInsurancesellby());
//								_ticketcancel.setIscancelinsure(ticketcancel.getIscancelinsure());
//								_ticketcancel.setIscancelticket(ticketcancel.getIscancelticket());
							_ticketcancel.setIsselfschedule(ticketcancel.getIsselfschedule());
							_ticketcancel.setOpertype(ticketcancel.getOpertype());
							_ticketcancel.setRemarks(ticketcancel.getRemarks());
							_ticketcancel.setSellby(ticketcancel.getSellby());
							_ticketcancel.setSellid(ts_tuan.getId());
							_ticketcancel.setTicketoutletsid(ticketcancel.getTicketoutletsid());
							_ticketcancel.setTicketprice(ts_tuan.getPrice());
//								_ticketcancel.setTurnoverdetailid(turnoverdetailid);
							_ticketcancel.setUpdateby(ticketcancel.getUpdateby());
							_ticketcancel.setUpdatetime(ticketcancel.getUpdatetime());
							ticketcancels_tuan.add(_ticketcancel);
						}
					}else{
						ticketcancels_tuan.add(ticketcancel);
					}
					ticketturnoverdetail.setCancelmoney(ticketturnoverdetail.getCancelmoney().add(ticketcancel.getTicketprice()));
					//0售票、1补票、2特权补票、3代售票、4改票、5手工票、6留票销售、7网上售票、8订票
					if("6".equals(ticketsell.getSellway())){
						for (Ticketsell ts_tuan : ts_tuans) {
							ticketturnoverdetail.setBookservicefee(ticketturnoverdetail.getBookservicefee().subtract(ts_tuan.getServicefee()));
							ticketturnoverdetail.setMoneypayable(ticketturnoverdetail.getMoneypayable().subtract(ticketcancel.getTicketprice()).subtract(ts_tuan.getServicefee()));
						}
					}
					else if("1".equals(ticketsell.getSellway())||"2".equals(ticketsell.getSellway())){
						
						ticketturnoverdetail.setMoneypayable(ticketturnoverdetail.getMoneypayable().subtract(ticketcancel.getTicketprice()).subtract(ts_tuans.get(0).getServicefee()));
						for (Ticketsell ts_tuan : ts_tuans) {
							ticketturnoverdetail.setServicefee(ticketturnoverdetail.getServicefee().subtract(ts_tuan.getServicefee()));
							
						}
					}else{
						ticketturnoverdetail.setMoneypayable(ticketturnoverdetail.getMoneypayable().subtract(ticketcancel.getTicketprice()));//.subtract(ticketsell.getServicefee())
					}
					//0现金、1银联卡、2贵客卡余额、3贵客卡积分
					if("2".equals(ticketsell.getPaymethod())||"3".equals(ticketsell.getPaymethod())){
						ticketturnoverdetail.setNonvouchermoneypayable(ticketturnoverdetail.getNonvouchermoneypayable().subtract(ticketcancel.getTicketprice()));
					}
	
					for (Ticketsell ts_tuan : ts_tuans) {
						ts_tuan.setTicketstatus("2"); //废票
						ts_tuan.setUpdateby(global.getUserinfo().getId());
						ts_tuan.setUpdatetime(now);
						dao.merge(ts_tuan);
					}
					if(ticketsell.getPaymethod().equals("0")){
						for (Ticketsell ts_tuan : ts_tuans) {
							ticketturnoverdetail.setFueladditionfee(ticketturnoverdetail.getFueladditionfee().subtract(ts_tuan.getFueladditionfee()));
							ticketturnoverdetail.setStationservicefee(ticketturnoverdetail.getStationservicefee().subtract(ts_tuan.getStationservicefee()));
							ticketturnoverdetail.setComputefee(ticketturnoverdetail.getComputefee().subtract(ts_tuan.getComputefee()));
							ticketturnoverdetail.setCoolairfee(ticketturnoverdetail.getCoolairfee().subtract(ts_tuan.getCoolairfee()));
							ticketturnoverdetail.setAdditionfee(ticketturnoverdetail.getAdditionfee().subtract(ts_tuan.getAdditionfee()));
							ticketturnoverdetail.setWaterfee(ticketturnoverdetail.getWaterfee().subtract(ts_tuan.getWaterfee()));
							ticketturnoverdetail.setInsurefee(ticketturnoverdetail.getInsurefee().subtract(ts_tuan.getInsurefee()));
							ticketturnoverdetail.setOtherfee(ticketturnoverdetail.getOtherfee().subtract(ts_tuan.getOtherfee()));
						}
					}
					Scheduleplan scheduleplan = (Scheduleplan) dao.get(LockModeType.PESSIMISTIC_READ,Scheduleplan.class, ticketsell.getScheduleplanid());
					if(!ticketsell.getIslinework()
							&&!"2".equals(scheduleplan.getWorktype())
							){
//							&&!"3".equals(scheduleplan.getWorktype())){	//跨区配载票废票时修改为也更新本地scheduleseats
						//检查座位状态
						for (Ticketsell ts_tuan : ts_tuans) {
							propertyFilters.clear();
							propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ts_tuan.getScheduleplanid()));
							propertyFilters.add(new PropertyFilter("EQR_t!seatno", ts_tuan.getSeatno()));
							Scheduleseats scheduleseat = (Scheduleseats) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleseats.class, propertyFilters);
							if(scheduleseat==null){
								//回滚
								throw new ServiceException("票号"+ts_tuan.getTicketno(),"0204",true); //班次座位记录不存在	
							}
							else if(!"2".equals(scheduleseat.getStatus())){
								throw new ServiceException("票号"+ts_tuan.getTicketno(),"0263",true); //座位不是售出状态
							}
							scheduleseat.setStatus("0");
							scheduleseat.setUpdateby(global.getUserinfo().getId());
							scheduleseat.setUpdatetime(now);
							dao.merge(scheduleseat);
						}
					}

					//锁定班次并更新剩余票数
					scheduleplan.setSoldeatnum((short) (scheduleplan.getSoldeatnum()-ts_tuans.size()));
					for (Ticketsell ts_tuan : ts_tuans) {
						scheduleplan.setCarrychildnum((short) (scheduleplan.getCarrychildnum()-ts_tuan.getCarrychildnum()));
					}
					scheduleplan.setUpdateby(global.getUserinfo().getId());
					scheduleplan.setUpdatetime(now);
					dao.merge(scheduleplan);

					//票价表要更新不区分发车站到达站
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketsell.getScheduleplanid()));
					propertyFilters.add(new PropertyFilter("EQS_t!seattype", ticketsell.getSeattype()));
					List<Ticketprice> ticketprices = dao.find(LockModeType.PESSIMISTIC_READ,Ticketprice.class, propertyFilters);
					for (Ticketprice _ticketprice : ticketprices){
						_ticketprice.setSoldeatnum((short) (_ticketprice.getSoldeatnum()-ts_tuans.size()));
						_ticketprice.setUpdateby(global.getUserinfo().getId());
						_ticketprice.setUpdatetime(now);
						dao.merge(_ticketprice);
					}
					//判断是否属于VIP卡余额支付
					if(ticketsell.getPaymethod().equals("2")){
						if(vipcardno!=null){
							vip = vipconsumeService.getConsumeVip(true, ticketsell.getId());
							if(vip == null){
								//异站售本站票时，本站没有产生消费记录，无法查出VIP信息
								vip = vipService.findByCardNo(vipcardno,"0");
							}
							if(vip == null){
								throw new ServiceException("0411"); //找不到VIP卡信息		
							}else if(!"0".equals(vip.getStatus())){//状态：0正常,1已退,2挂失,3注销,4过期,5已补卡 取数据字典
								throw new ServiceException("0412"); //VIP卡当前状态异常
							}
							//判断要退票的所有车票购票所用VIP卡是否为同一张卡
							if(!vip.getVipcardno().equals(vipcardno)){
								throw new ServiceException("0414");
							}
							if(vipconsume==null){
								vip.setVipgrade(vipgrade);
								vip.setMoney(vipmoney);
								vip.setVipamount(vippoint);
								
								vipconsume = new Vipconsume();
								vipconsume.setCreateby(global.getUserinfo().getId());
								vipconsume.setCreatetime(now);
								vipconsume.setUpdateby(vipconsume.getCreateby());
								vipconsume.setUpdatetime(vipconsume.getCreatetime());
								vipconsume.setType("2"); //余额购票后废票
								vipconsume.setMoneychange(totalcancelmoney);
								vipconsume.setRemainmoney(vip.getMoney().add(vipconsume.getMoneychange()));
								vipconsume.setPointchange(totalcancelmoney.multiply(new BigDecimal(-1)));
								vipconsume.setRemainpoint(vip.getVipamount().add(vipconsume.getPointchange()));
								vipconsume.setVipcardno(vip.getVipcardno());
								vipconsume.setVipconsumeldetails(new ArrayList<Vipconsumeldetail>());
								vipconsume.setVipgrade(vip.getVipgrade());
								vipconsume.setVipid(vip.getId());
								
								vip.setMoney(vipconsume.getRemainmoney());
								vip.setVipamount(vipconsume.getRemainpoint());
								vip = (Vip) dao.merge(vip);
							}
						}else{
							//没有传入卡号，但支付方式为 余额支付或积分支付
							throw new ServiceException("0413"); //VIP卡号不允许为空
						}

						//贵宾卡消费记录明细
						Vipconsumeldetail vipconsumeldetail = new Vipconsumeldetail();
						vipconsumeldetail.setCreateby(global.getUserinfo().getId());
						vipconsumeldetail.setCreatetime(now);
						vipconsumeldetail.setIsselfschedule(true);
						vipconsumeldetail.setSellid(ticketsell.getId());
						vipconsumeldetail.setVipconsume(vipconsume);
						vipconsume.getVipconsumeldetails().add(vipconsumeldetail);
					}
				}
			}
			else{
				ticketcancels_tuan.add(ticketcancel);
				// 售票站票退票修改
				Ticketsellagent ticketsellagent = (Ticketsellagent) dao.get(LockModeType.PESSIMISTIC_READ,Ticketsellagent.class, ticketcancel.getSellid());
				if(ticketsellagent==null){
					throw new ServiceException("0187");
				}
				else if("1".equals(ticketsellagent.getTicketstatus())){
					throw new ServiceException("0188");
				}
				else if("2".equals(ticketsellagent.getTicketstatus())){
					cancelticketnum--;
					continue;
//					throw new ServiceException("0189");
				}
				else{
					ticketturnoverdetail.setMoneypayable(ticketturnoverdetail.getMoneypayable().subtract(ticketcancel.getTicketprice()).subtract(ticketsellagent.getServicefee()));
					ticketturnoverdetail.setCancelmoney(ticketturnoverdetail.getCancelmoney().add(ticketcancel.getTicketprice()));
					if("6".equals(ticketsellagent.getSellway())){
						ticketturnoverdetail.setBookservicefee(ticketturnoverdetail.getBookservicefee().subtract(ticketsellagent.getServicefee()));
					}
					else if("1".equals(ticketsellagent.getSellway())||"2".equals(ticketsellagent.getSellway())){
						ticketturnoverdetail.setServicefee(ticketturnoverdetail.getServicefee().subtract(ticketsellagent.getServicefee()));
					} 
					//0现金、1银联卡、2贵客卡余额、3贵客卡积分
					if("2".equals(ticketsellagent.getPaymethod())||"3".equals(ticketsellagent.getPaymethod())){
						ticketturnoverdetail.setNonvouchermoneypayable(ticketturnoverdetail.getNonvouchermoneypayable().subtract(ticketcancel.getTicketprice()));
					}
					
					ticketsellagent.setTicketstatus("2"); //废票
					ticketsellagent.setUpdateby(global.getUserinfo().getId());
					ticketsellagent.setUpdatetime(now);
					dao.merge(ticketsellagent);
					//若是现金则相应较少营收
					if(ticketsellagent.getPaymethod().equals("0")){
						ticketturnoverdetail.setFueladditionfee(ticketturnoverdetail.getFueladditionfee().subtract(ticketsellagent.getFueladditionfee()));
						ticketturnoverdetail.setStationservicefee(ticketturnoverdetail.getStationservicefee().subtract(ticketsellagent.getStationservicefee()));
						ticketturnoverdetail.setComputefee(ticketturnoverdetail.getComputefee().subtract(ticketsellagent.getComputefee()));
						ticketturnoverdetail.setCoolairfee(ticketturnoverdetail.getCoolairfee().subtract(ticketsellagent.getCoolairfee()));
						ticketturnoverdetail.setAdditionfee(ticketturnoverdetail.getAdditionfee().subtract(ticketsellagent.getAdditionfee()));
						ticketturnoverdetail.setWaterfee(ticketturnoverdetail.getWaterfee().subtract(ticketsellagent.getWaterfee()));
						ticketturnoverdetail.setInsurefee(ticketturnoverdetail.getInsurefee().subtract(ticketsellagent.getInsurefee()));
						ticketturnoverdetail.setOtherfee(ticketturnoverdetail.getOtherfee().subtract(ticketsellagent.getOtherfee()));
					}
					//判断是否属于VIP卡余额支付
					if(ticketsellagent.getPaymethod().equals("2")){
						if(vipcardno!=null){
							vip = vipconsumeService.getConsumeVip(false, ticketsellagent.getId());
//								vip = vipService.findByCardNo(vipcardno);
							if(vip == null){
								throw new ServiceException("0411"); //找不到VIP卡信息		
							}else if(!"0".equals(vip.getStatus())){//状态：0正常,1已退,2挂失,3注销,4过期,5已补卡 取数据字典
								throw new ServiceException("0412"); //VIP卡当前状态异常
							}
							//判断要退票的所有车票购票所用VIP卡是否为同一张卡
							if(!vip.getVipcardno().equals(vipcardno)){
								throw new ServiceException("0414");
							}
							if(vipconsume==null){
								vipconsume = new Vipconsume();
								vipconsume.setCreateby(global.getUserinfo().getId());
								vipconsume.setCreatetime(now);
								vipconsume.setUpdateby(vipconsume.getCreateby());
								vipconsume.setUpdatetime(vipconsume.getCreatetime());
								vipconsume.setType("2"); //余额购票后废票
								vipconsume.setMoneychange(totalcancelmoney);
								vipconsume.setRemainmoney(vip.getMoney().add(vipconsume.getMoneychange()));
								vipconsume.setPointchange(totalcancelmoney.multiply(new BigDecimal(-1)));
								vipconsume.setRemainpoint(vip.getVipamount().add(vipconsume.getPointchange()));
								vipconsume.setVipcardno(vip.getVipcardno());
								vipconsume.setVipconsumeldetails(new ArrayList<Vipconsumeldetail>());
								vipconsume.setVipgrade(vip.getVipgrade());
								vipconsume.setVipid(vip.getId());
							}
						}else{
							//没有传入卡号，但支付方式为 余额支付或积分支付
							throw new ServiceException("0413"); //VIP卡号不允许为空
						}

						//贵宾卡消费记录明细
						Vipconsumeldetail vipconsumeldetail = new Vipconsumeldetail();
						vipconsumeldetail.setCreateby(global.getUserinfo().getId());
						vipconsumeldetail.setCreatetime(now);
						vipconsumeldetail.setIsselfschedule(false);
						vipconsumeldetail.setSellid(ticketsellagent.getId());
						vipconsumeldetail.setVipconsume(vipconsume);
						vipconsume.getVipconsumeldetails().add(vipconsumeldetail);
					}
				}
			}
		}

		ticketturnoverdetail.setUpdateby(global.getUserinfo().getId());
		ticketturnoverdetail.setUpdatetime(now);
		ticketturnoverdetail.setCancelnum(ticketturnoverdetail.getCancelnum()+cancelticketnum);
		
		ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);	
		for (Ticketcancel ticketcancel : ticketcancels_tuan) {
			ticketcancel.setTurnoverdetailid(ticketturnoverdetail.getId());
			ticketcancelDao.merge(ticketcancel);
		}
		if(vipconsume!=null){
			dao.merge(vipconsume);
		}
		
		//单独废儿童票
		if(primaryIdList!=null&&primaryIdList.size()>0){
			List<Object[]> childInfo = ticketdao.findChildTicket(primaryIdList);
			if(childInfo != null && childInfo.size() > 0){
				Date updatetime = new Date();
				List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
				for (Object[] pcId : childInfo) {
					ts = (Ticketsell) dao.get(LockModeType.PESSIMISTIC_WRITE, Ticketsell.class, ((BigDecimal)pcId[1]).longValue());//儿童票ticketsell
					ts.setTicketstatus("2");//2已废
					ts.setUpdatetime(updatetime);
					ts.setUpdateby(global.getUserinfo().getId());
					dao.merge(ts);
					
					ticketturnoverdetail.setCancelnum(ticketturnoverdetail.getCancelnum()+1);
					
					filters.clear();
					filters.add(new PropertyFilter("EQL_t!childticketid", ts.getId()));
					CarryChild carryChild = (CarryChild) dao.uniqueResult(LockModeType.PESSIMISTIC_WRITE, CarryChild.class, filters);
					carryChild.setRemark(carryChild.getRemark() + ", 废票" + DateUtils.formatDatetime(updatetime));
					dao.merge(carryChild);
					Ticketcancel _ticketcancel = new Ticketcancel();
					_ticketcancel.setCancelby(global.getUserinfo().getId());
					_ticketcancel.setCancelip(global.getIpAddress());
					_ticketcancel.setCanceltime(now);
					_ticketcancel.setCancelway(ticketcancels.get(0).getCancelway());
					_ticketcancel.setCreateby(global.getUserinfo().getId());
					_ticketcancel.setCreatetime(now);
					_ticketcancel.setIsselfschedule(true);
					_ticketcancel.setTurnoverdetailid(ticketturnoverdetail.getId());
					_ticketcancel.setOpertype(ticketcancels.get(0).getOpertype());
					_ticketcancel.setRemarks("儿童票废票");
					_ticketcancel.setSellby(ticketcancels.get(0).getSellby());
					_ticketcancel.setSellid(ts.getId());
					_ticketcancel.setTicketoutletsid(ticketcancels.get(0).getTicketoutletsid());
					_ticketcancel.setTicketprice(BigDecimal.ZERO);
					_ticketcancel.setUpdateby(global.getUserinfo().getId());
					_ticketcancel.setUpdatetime(now);
					dao.merge(_ticketcancel);
					
					Ticketcancel tc = new Ticketcancel();
					Boolean flag = insuranceMap.get(((BigDecimal)pcId[1]).longValue());//通过主票id获取是否退保险
					if(flag == null){
						tc.setIscancelinsure(false);
					}else{
						tc.setIscancelinsure(flag);
						if(flag){
							filters.clear();
							filters.add(new PropertyFilter("EQL_t!sellid", ts.getId()));
							Insurance insurance = (Insurance)dao.uniqueResult(Insurance.class, filters);
							tc.setCancelinsureid(insurance.getId());
						}
					}
					tc.setCancelway(ticketcancels.get(0).getCancelway());
					tc.setRemarks("儿童票废保险");
					
					ticketcancels.add(tc);//将儿童票赋值到ticketreturns，供儿童票退保险
				}
				dao.merge(ticketturnoverdetail);
			}	
		}
		//废保险
		insurancecancelService.cancelInsuranceAtcancelTicket(ticketcancels, global);
		if(TestParams.getNewest().cancelTicket == 3){
			SystemFactory.markRtException();
		}
		return true;
	}

	private long findRemoteCallList(List<Ticketcancel> ticketcancels,Long orgId,List<TicketInfo> tickets,List<TicketInfo> openticket,List<TicketInfo> tickets_worktype3)
			throws ServiceException {
		long opponentorgid = 0;
		boolean canCancelAfterChange = ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_1038, orgId));
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		for (Ticketcancel ticketcancel : ticketcancels) {
			if(!ticketcancel.getIscancelticket()){
				continue;
			}
			if(ticketcancel.getIsselfschedule()){
				Ticketsell ticketsell = (Ticketsell) dao.get(LockModeType.PESSIMISTIC_READ,Ticketsell.class, ticketcancel.getSellid());
				if(ticketsell==null){
					throw new ServiceException("0187");
				}
				else if("1".equals(ticketsell.getTicketstatus())){
					throw new ServiceException("0188");
				}
				else if("2".equals(ticketsell.getTicketstatus())){
					throw new ServiceException("0189");
				}
				else if(ticketsell.getIschecked()){
					throw new ServiceException("0190");
				}

				Scheduleplan scheduleplan = (Scheduleplan) dao.get(LockModeType.PESSIMISTIC_READ,Scheduleplan.class, ticketsell.getScheduleplanid());
				//普通废票过了时间不允许废票
				if("0".equals(ticketcancel.getCancelway())){
					String outtimestr = parameterService.findParamValue(ParamterConst.Param_1401, orgId);
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
					if(cdnow.after(cdselltime)){
						throw new ServiceException("0191"); //普通废票过了时间不允许废票
					}
				}
				//判断是否已经改签过
				if(!canCancelAfterChange){
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQL_t!newticketsellid", ticketcancel.getSellid()));
					Ticketchange ticketchange = (Ticketchange) dao.uniqueResult(Ticketchange.class, propertyFilters);
					if(ticketchange!=null){
						throw new ServiceException("票号："+ticketsell.getTicketno(),"0373",true);
					}
				}
				
				if("3".equals(scheduleplan.getWorktype())){
					TicketInfo ticketInfo = new TicketInfo();
					ticketInfo.setBatchno(ticketsell.getBatchno());
					ticketInfo.setTicketno(ticketsell.getTicketno());
					ticketInfo.setRemarks(ticketcancel.getRemarks());
					ticketInfo.setIsselfschedule(true);
					ticketInfo.setSchplansynccode(scheduleplan.getSynccode());
					tickets_worktype3.add(ticketInfo);
				}
				
			}else{
				Ticketsellagent ticketsellagent = (Ticketsellagent) dao.get(LockModeType.PESSIMISTIC_READ,Ticketsellagent.class, ticketcancel.getSellid());
				if(ticketsellagent==null){
					throw new ServiceException("0187");
				}
				else if("1".equals(ticketsellagent.getTicketstatus())){
					throw new ServiceException("0188");
				}
				else if("2".equals(ticketsellagent.getTicketstatus())){
					throw new ServiceException("0189");
				}
				
				//普通废票过了时间不允许废票
				if("0".equals(ticketcancel.getCancelway())){
					String outtimestr = parameterService.findParamValue(ParamterConst.Param_1401, orgId);
					int outtime = 10;
					try {
						outtime = new Integer(outtimestr);
					} catch (Exception e) {
						
					}
					Calendar cdnow = Calendar.getInstance();
					cdnow.setTime(new Date());
					Calendar cdselltime = Calendar.getInstance();
					cdselltime.setTime(ticketsellagent.getSelltime());
					cdselltime.add(Calendar.MINUTE, outtime);
					if(cdnow.after(cdselltime)){
						throw new ServiceException("0191"); //普通废票过了时间不允许废票
					}
				}
				
				TicketInfo ticketInfo = new TicketInfo();
				ticketInfo.setBatchno(ticketsellagent.getBatchno());
				ticketInfo.setTicketno(ticketsellagent.getTicketno());
				ticketInfo.setRemarks(ticketcancel.getRemarks());
				ticketInfo.setIsselfschedule(true);
				if(StringUtils.isEmpty(ticketsellagent.getEticketid())){
					tickets.add(ticketInfo);
				}else{
					ticketInfo.setEticketid(ticketsellagent.getEticketid());
					ticketInfo.setOrderno(ticketsellagent.getOrderno());
					openticket.add(ticketInfo);
				}
				opponentorgid=ticketsellagent.getOrgid();
			}

		}
		return opponentorgid;
	}

//	private Object getCentreInterface(MethodResult methodResult,Organization localorg,Class classes){
//		Organization centreOrg = getOrganizationService().getDirectlyParentOrg(localorg);
//		if(centreOrg==null){
//			methodResult.setResult(insideInvokFalse);
//			methodResult.setResultMsg("无法连接中心服务器:找不到"+localorg.getName()+"的上级机构");
//			log.warn(methodResult.getResultMsg());
//			return null;
//		}
//		try {
//			return EJBFactory.getRemoteEJB(classes, centreOrg.getId());
//		} catch (NamingException e) {
//			methodResult.setResult(insideInvokFalse);
//			methodResult.setResultMsg("无法连接中心服务器:"+e.getMessage());
//			log.warn(methodResult.getResultMsg());
//			return null;
//		}
//	}
	
//	private NetTicketcancelService getCentreInterface(MethodResult methodResult,Organization localorg){
//		Organization centreOrg = getOrganizationService().getDirectlyParentOrg(localorg);
//		if(centreOrg==null){
//			methodResult.setResult(insideInvokFalse);
//			methodResult.setResultMsg("无法连接中心服务器:找不到"+localorg.getName()+"的上级机构");
//			log.warn(methodResult.getResultMsg());
//			return null;
//		}
//		try {
//			return (NetTicketcancelService) EJBFactory.getRemoteEJB(NetTicketcancelService.class, centreOrg.getId());
//		} catch (NamingException e) {
//			methodResult.setResult(insideInvokFalse);
//			methodResult.setResultMsg("无法连接中心服务器:"+e.getMessage());
//			log.warn(methodResult.getResultMsg());
//			return null;
//		}
//	}
//	
	
	public void setInsurancecancelService(InsurancecancelService insurancecancelService) {
		this.insurancecancelService = insurancecancelService;
	}

	public InsurancecancelService getInsurancecancelService() {
		return insurancecancelService;
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

	public VipService getVipService() {
		return vipService;
	}

	public void setVipService(VipService vipService) {
		this.vipService = vipService;
	}

	public VipconsumeService getVipconsumeService() {
		return vipconsumeService;
	}

	public void setVipconsumeService(VipconsumeService vipconsumeService) {
		this.vipconsumeService = vipconsumeService;
	}

	public BilltypeService getBilltypeService() {
		return billtypeService;
	}

	public void setBilltypeService(BilltypeService billtypeService) {
		this.billtypeService = billtypeService;
	}
	
	public List<Map<String, Object>> findspecialticket(
			List<PropertyFilter> propertyFilters) {
		return ListUtil.listToMap(
				new Object[] { "specialticketid","specialid"},
				ticketcancelDao.findspecialticket(propertyFilters),
				new Object[] { Integer.class, Integer.class});
	}
}
