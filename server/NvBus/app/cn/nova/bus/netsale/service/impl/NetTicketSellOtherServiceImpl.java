package cn.nova.bus.netsale.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;
import java.util.UUID;
import cn.nova.bus.base.model.District;
import javax.persistence.LockModeType;
import javax.persistence.Query;

import models.TestParams;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;

import util.CommonUtil;
import util.CurrentUtil;
import util.JsonUtil;
import util.RemoteApi;
import util.RpcUtil;
import util.SystemFactory;
import util.TransactionUtil;
import cn.nova.bus.archive.model.Customer;
import cn.nova.bus.archive.model.Vip;
import cn.nova.bus.archive.model.Vipconsume;
import cn.nova.bus.archive.model.Vipconsumeldetail;
import cn.nova.bus.archive.service.VipService;
import cn.nova.bus.archive.service.impl.VipServiceImpl;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Ticketoutlets;
import cn.nova.bus.base.model.Vehicletype;
import cn.nova.bus.bill.model.Billdamaged;
import cn.nova.bus.bill.model.Billinuse;
import cn.nova.bus.bill.model.Billinventory;
import cn.nova.bus.bill.service.BillinuseService;
import cn.nova.bus.bill.service.impl.BillinuseServiceImpl;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.model.Seatreserve;
import cn.nova.bus.dispatch.model.SeatreserveIn;
import cn.nova.bus.dispatch.model.Seatreserveagent;
import cn.nova.bus.dispatch.model.Seatreserveno;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.netsale.service.NetTicketSellOtherService;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.sale.model.NetScheduleAskCondition;
import cn.nova.bus.sale.model.NetScheduleDetail;
import cn.nova.bus.sale.model.Returntripticket;
import cn.nova.bus.sale.model.ScheduleAskCondition;
import cn.nova.bus.sale.model.ScheduleDetail;
import cn.nova.bus.sale.model.Ticketreprint;
import cn.nova.bus.sale.model.Ticketsellagent;
import cn.nova.bus.sale.model.Ticketsellother;
import cn.nova.bus.sale.model.Ticketturnoverdetail;
import cn.nova.bus.sale.service.TicketturnoverdetailService;
import cn.nova.bus.sale.service.impl.TicketturnoverdetailServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.dao.DigitaldictionarydetailDao;
import cn.nova.bus.system.model.Digitaldictionarydetail;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.service.OrganizationService;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.OrganizationServiceImpl;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.openapi.model.EncryptRequest;
import cn.nova.openapi.sevice.OpenApiAdapter;
import cn.nova.openapi.sevice.impl.OpenApiAdapterImpl;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.RemoteInvokeAuxiliaryProperty;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.commons.TicketOrder;
import cn.nova.utils.commons.TicketPrintInfo;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;

@SuppressWarnings({"rawtypes","unchecked"})
//@TransactionManagement(TransactionManagementType.BEAN)
public class NetTicketSellOtherServiceImpl implements NetTicketSellOtherService {
	
	final private Logger log=LoggerFactory.getLogger(getClass());
	final private int insideInvokFalse = -67101735;

	private IDAO dao = new EntityManagerDaoSurport();
	private ParameterService parameterService = new ParameterServiceImpl();
	private BillinuseService billinuseService = new BillinuseServiceImpl();
	private TicketturnoverdetailService ticketturnoverdetailService = new TicketturnoverdetailServiceImpl();
	private OrganizationService organizationService = new OrganizationServiceImpl();
	private VipService vipService = new VipServiceImpl();
	private DigitaldictionarydetailDao dictionaryDao = new DigitaldictionarydetailDao();
	
//	@Resource 
//	private UserTransaction userTransaction;	
	
//	//根据departStationid取orgId
//	private Organization getOrgByStationId(long departstationid){
//		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
//		propertyFilters.add(new PropertyFilter("EQL_t!station.id", departstationid));
//		propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
//		Organization org = (Organization)dao.uniqueResult(Organization.class, propertyFilters);
//		return org;
//	}
//
//	//根据departStationcode取orgId
//	private Organization getOrgByStationCode(String departstationcode){
//		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
//		propertyFilters.add(new PropertyFilter("EQS_t!station.code", departstationcode));
//		propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
//		Organization org = (Organization)dao.uniqueResult(Organization.class, propertyFilters);
//		return org;
//	}
//
//	//根据departStationcode取orgId
//	private Organization getOrgByCode(String departorgcode){
//		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
//		propertyFilters.add(new PropertyFilter("EQS_t!code", departorgcode));
//		propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
//		Organization org = (Organization)dao.uniqueResult(Organization.class, propertyFilters);
//		return org;
//	}

//	private NetTicketSellService getCentreInterface(MethodResult methodResult,Organization localorg){
//		Organization centreOrg = organizationService.getDirectlyParentOrg(localorg);
//		if(centreOrg==null){
//			methodResult.setResult(insideInvokFalse);
//			methodResult.setResultMsg("无法连接中心服务器:找不到"+localorg.getName()+"的上级机构");
//			log.warn(methodResult.getResultMsg());
//			return null;
//		}
//		try {
//			return (NetTicketSellService) EJBFactory.getRemoteEJB(NetTicketSellService.class, centreOrg.getId());
//		} catch (NamingException e) {
//			methodResult.setResult(insideInvokFalse);
//			methodResult.setResultMsg("无法连接中心服务器:"+e.getMessage());
//			log.warn(methodResult.getResultMsg());
//			return null;
//		}
//	}
	
	@Override
	public MethodResult findNetSchedule(ScheduleAskCondition scheduleAskCondition,Global global) throws Exception {
		MethodResult methodResult = new MethodResult();
//		NetTicketSellService netTicketSellService = getCentreInterface(methodResult,global.getOrganization());
//		if(netTicketSellService==null){
//			return methodResult;
//		}
		RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty = new RemoteInvokeAuxiliaryProperty();
		remoteInvokeAuxiliaryProperty.setClientIp(global.getOrganization().getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setClientOrgcode(global.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgcode(global.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgIp(global.getOrganization().getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setOperateTicketoutletsName(global.getTicketoutlets().getName());
		remoteInvokeAuxiliaryProperty.setOperateUserName(global.getUserinfo().getName());
		
		NetScheduleAskCondition netScheduleAskCondition = new NetScheduleAskCondition();
		netScheduleAskCondition.setDepartDate(scheduleAskCondition.getDepartDate());
		Station station = (Station) dao.get(Station.class, scheduleAskCondition.getReachStationId());
		netScheduleAskCondition.setReachStationcode(station.getCode());
		netScheduleAskCondition.setOrgcode(global.getOrganization().getCode());
		netScheduleAskCondition.setSellway(scheduleAskCondition.getSellway());
		netScheduleAskCondition.setDistrictcode(scheduleAskCondition.getDistrictcode());
		if(scheduleAskCondition.getDepartStationId()!=null&&scheduleAskCondition.getDepartStationId()>0){
			Organization organization_depart = organizationService.getOrgByStationId(scheduleAskCondition.getDepartStationId());
			remoteInvokeAuxiliaryProperty.setOppositeOrgcode(organization_depart.getCode());
			station = (Station) dao.get(Station.class, scheduleAskCondition.getDepartStationId());
			netScheduleAskCondition.setDepartStationcode(station.getCode());
		}
		else{
			remoteInvokeAuxiliaryProperty.setOppositeOrgcode(null);
		}
//		List<Map<String, Object>> result = netTicketSellService.findSchedule(remoteInvokeAuxiliaryProperty, netScheduleAskCondition);
//		methodResult = netTicketSellService.findSchedule(remoteInvokeAuxiliaryProperty, netScheduleAskCondition);
		
		Map<String, String> requestMap = new HashMap<String, String>();
		requestMap.put("remoteInvokeAuxiliaryProperty", JsonUtil.toFormatString(remoteInvokeAuxiliaryProperty));
		requestMap.put("scheduleAskCondition", JsonUtil.toFormatString(netScheduleAskCondition));

		Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
		methodResult = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.FIND_SCHEDULE, requestMap);
		List<Map<String, Object>> result = JSON.parseObject(methodResult.getObject().toString(),new TypeReference<List<Map<String,Object>>>(){});
//		List<Map<String, Object>> result = (List<Map<String, Object>>) methodResult.getObject();
		//根据参数1029过滤已过时间的班次
		if(scheduleAskCondition.getSellway()!=null&&!scheduleAskCondition.getSellway().trim().equals("")&&result!=null){
			Ticketoutlets ticketoutlets = (Ticketoutlets) dao.get(Ticketoutlets.class, scheduleAskCondition.getTicketoutletsid()); 
			int netStopSaleTime  = new Integer(getParameterService().findParamValue("1029", ticketoutlets.getOrgid()));//售联网票截止时间（分钟）
			Calendar calendar_now = Calendar.getInstance();
			for (Iterator iterator = result.iterator(); iterator.hasNext();) {
				Map<String, Object> row = (Map<String, Object>)iterator.next();
				try {
					if(row.get("DATA-FLAG") != null){
						continue;
					}
					Date departDate = CommonUtil.parseStringToTimestamp((String)row.get("departdate"));
					Calendar calendar_stoptime = Calendar.getInstance();
					calendar_stoptime.setTime(departDate);
					String departTime = (String) row.get("departtime");
					calendar_stoptime.set(calendar_stoptime.get(Calendar.YEAR), 
							calendar_stoptime.get(Calendar.MONTH), 
							calendar_stoptime.get(Calendar.DAY_OF_MONTH), 
							new Integer(departTime.substring(0,2)), 
							new Integer(departTime.substring(3,5)), 0);
					calendar_stoptime.add(Calendar.MINUTE, -1*netStopSaleTime);
					if(calendar_now.after(calendar_stoptime)){
						iterator.remove();
						continue;
					}
				} catch (Exception e) {
					continue;
				}
			}
		}
		methodResult.setResult(1);
		methodResult.setObject(result);
		return methodResult;
	}

	@Override
	public MethodResult sellTicket(String transactionid, TicketOrder order,Global global) throws Exception{
		MethodResult methodResult = new MethodResult();
//		NetTicketSellService netTicketSellService = getCentreInterface(methodResult,global.getOrganization());
//		if(netTicketSellService==null){
//			return methodResult;
//		}
		
		String param1074 = parameterService.findParamValue(ParamterConst.Param_1074, global.getOrganization().getId());//参数1074: 免票儿童是否单独打印车票，0不打印，1打印
		if(ParamterConst.COMMON_FLAG.FALG_YES.equals(param1074)){
			for (TicketPrintInfo tpi : order.getTickets()) {
				if("E".equals(tpi.getTickettype())){
					play.Logger.error("1074参数开启，免票儿童单独打印车票。联网售票暂时不支持联网售免票儿童并打印儿童票。");
					throw new BusinessException("暂不支持联网售免票儿童并打印儿童票（1074参数开启）");
				}
			}
		}
		
		
		Date now = new Date();

		Vip vip = null;
		Vipconsume vipconsume = null;
		if(order.getVipcardno()!=null&&"2".equals(order.getTickets().get(0).getPaymethod())){
			vip = vipService.findByCardNo(order.getVipcardno(),"0");
			if(vip == null){
				throw new ServiceException("0411"); //找不到VIP卡信息		
			}else if(!"0".equals(vip.getStatus())){//状态：0正常,1已退,2挂失,3注销,4过期,5已补卡 取数据字典
				throw new ServiceException("0412"); //VIP卡当前状态异常
			}
			vip.setVipgrade(order.getVipgrade());
			vip.setMoney(order.getVipmoney());
			vip.setVipamount(order.getVippoint());

			vipconsume = new Vipconsume();
			vipconsume.setCreateby(order.getSeller());
			vipconsume.setCreatetime(now);
			vipconsume.setUpdateby(vipconsume.getCreateby());
			vipconsume.setUpdatetime(vipconsume.getCreatetime());
//			if("2".equals(order.getTickets().get(0).getPaymethod())){
				vipconsume.setType("0"); //余额购票
				vipconsume.setMoneychange(order.getTotalmoney().multiply(new BigDecimal(-1)));
				vipconsume.setRemainmoney(vip.getMoney().add(vipconsume.getMoneychange()));
//			}else{
//				vipconsume.setType("3"); //只积分
//			}
			vipconsume.setPointchange(order.getTotalmoney());
			vipconsume.setRemainpoint(vip.getVipamount().add(vipconsume.getPointchange()));
			vipconsume.setVipcardno(vip.getVipcardno());
			vipconsume.setVipconsumeldetails(new ArrayList<Vipconsumeldetail>());
			vipconsume.setVipgrade(vip.getVipgrade());
			vipconsume.setVipid(vip.getId());
			
			vip.setMoney(vipconsume.getRemainmoney());
			vip.setVipamount(vipconsume.getRemainpoint());
			vip = (Vip) dao.merge(vip);
		}else if(order.getVipcardno()==null&&"2".equals(order.getTickets().get(0).getPaymethod())){
			//没有传入卡号，但支付方式为 余额支付或积分支付
			throw new ServiceException("0413"); //VIP卡号不允许为空
		}

		if(TestParams.getNewest().sellTicket == 1){
			SystemFactory.markRtException();
		}
		
		//计算消耗票证数
		int printticketcount = order.getTickets().size();		
		
		//如果是团体票只打印一张车票
		if("T".equals(order.getTickets().get(0).getTickettype())){
			printticketcount=1;
		}		
		
		int isSetServicefee = order.getTickets().get(0).getServicefee().compareTo(new BigDecimal(0));
		if(isSetServicefee==1){//设置改签或补票手续费
			//改签消耗票证数
		   if(order.getSellway().equals("4")){
			   if (ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_1066, global.getOrganization().getId()))){
				   printticketcount++;
			   }
		   }	
		}
		
//		Billinuse billinuse = billinuseService.jumpBillinuse(global.getUserinfo().getId(),"Ticket",order.getStartTicketNO(),printticketcount);
		Billinuse billinuse = null;
		if(isSetServicefee==1 && order.getSellway().equals("4")){ //改签时跳号
			if("T".equals(order.getTickets().get(0).getTickettype())){
				//如果改签后车票为团体票
				billinuse = billinuseService.jumpBillinuse(global.getUserinfo().getId(),"Ticket",order.getStartTicketNO(),printticketcount);
			}else{
				int changeprintticketcount=printticketcount+(order.getTickets().size()-1);
				billinuse = billinuseService.jumpBillinuse(global.getUserinfo().getId(),"Ticket",order.getStartTicketNO(),changeprintticketcount);
			}
		}else{
		    billinuse = billinuseService.jumpBillinuse(global.getUserinfo().getId(),"Ticket",order.getStartTicketNO(),printticketcount);
		}
		
		RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty = new RemoteInvokeAuxiliaryProperty();
		remoteInvokeAuxiliaryProperty.setClientIp(global.getOrganization().getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setClientOrgcode(global.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgcode(global.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgIp(global.getOrganization().getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setOperateTicketoutletsName(global.getTicketoutlets().getName());
		remoteInvokeAuxiliaryProperty.setOperateUserName(global.getUserinfo().getName());
		Organization organization_depart = organizationService.getOrgByStationCode(order.getDepartstationcode());
		remoteInvokeAuxiliaryProperty.setOppositeOrgcode(organization_depart.getCode());
		//售联网票不支持订单购票,发车站相同
		for (TicketPrintInfo ticketPrintInfo : order.getTickets()) {
			ticketPrintInfo.setDepartorgcode(remoteInvokeAuxiliaryProperty.getOppositeOrgcode());
//			ticketPrintInfo.setDepartstationcode(order.getDepartstationcode());
			if(ticketPrintInfo.getCustomerid()!= null && ticketPrintInfo.getCustomerid()>0){
				Customer customer = (Customer) dao.get(Customer.class, ticketPrintInfo.getCustomerid());
				if (null !=customer){
					ticketPrintInfo.setCustomername(customer.getName());
					ticketPrintInfo.setCustomersex(customer.getSex());
				}
			}
		}
		Billinventory billinventory = (Billinventory) dao.get(Billinventory.class, billinuse.getBillinventoryid()); 
		order.setBatchno(billinventory.getBatchno());
		
//		methodResult = netTicketSellService.sellTicket(remoteInvokeAuxiliaryProperty, order);
		
		Map<String, String> requestMap = new HashMap<String, String>();
		requestMap.put("remoteInvokeAuxiliaryProperty", JsonUtil.toFormatString(remoteInvokeAuxiliaryProperty));
		requestMap.put("order", JsonUtil.toFormatString(order));
		requestMap.put("transactionid", transactionid);

		Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
		
		CurrentUtil.setFlash("remoteurl", centreOrg.getServersaddress());
		
		if(TestParams.getNewest().sellTicket == 2){
			SystemFactory.markRtException();
		}
		methodResult = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.SELL_TICKET, requestMap);
		
		//@TODO
		if(methodResult.getResult()!=MethodResult.SUCCESS){
			TransactionUtil.setRollbackOnly();
			return methodResult;
		}
		
//		List<TicketPrintInfo> ticketPrintInfos = (List<TicketPrintInfo>) methodResult.getObject();
		List<TicketPrintInfo> ticketPrintInfos = JsonUtil.parseArray( methodResult.getObject(), TicketPrintInfo.class);
		//插入或修改应缴款表
		Ticketturnoverdetail ticketturnoverdetail = getTicketturnoverdetailService().getCurTicketturnoverdetail(global.getUserinfo().getId(), order.getStartTicketNO());
		if("0".equals(ticketturnoverdetail.getTicketstartno())){
			ticketturnoverdetail.setTicketstartno(order.getStartTicketNO());
		}
//		ticketturnoverdetail.setTicketendno(StringUtils.strPad(new Long(new Long(order.getStartTicketNO())+printticketcount-1).toString(),order.getStartTicketNO().length(), "0"));
		if(isSetServicefee==1 && order.getSellway().equals("4")){ //改签时售票员营收缴款明细表中的截止票号 			
			if("T".equals(order.getTickets().get(0).getTickettype())){
				//团体票改签时，截止票号 = 开始票号 数(改签后票号)+ 消耗票证数 - 1
				ticketturnoverdetail.setTicketendno(StringUtils.strPad(Long.valueOf(Long.parseLong(order.getStartTicketNO()) + printticketcount - 1).toString(),order.getStartTicketNO().length(), "0"));
			}else{
				ticketturnoverdetail.setTicketendno(StringUtils.strPad(Long.valueOf(Long.parseLong(order.getStartTicketNO()) + order.getTickets().size() - 1).toString(),order.getStartTicketNO().length(), "0"));
			}
		}else{
			ticketturnoverdetail.setTicketendno(StringUtils.strPad(Long.valueOf(Long.parseLong(order.getStartTicketNO()) + printticketcount - 1).toString(),order.getStartTicketNO().length(), "0"));
		}
		
		ticketturnoverdetail.setSellnum(ticketturnoverdetail.getSellnum()+order.getTickets().size());
		ticketturnoverdetail.setUpdateby(global.getUserinfo().getId());
		ticketturnoverdetail.setUpdatetime(now);
		//缴款明细表加字段
		ticketturnoverdetail.setBatchno(billinventory.getBatchno());
		ticketturnoverdetail.setBillinuseid(billinuse.getId());
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		Long ticketno = new Long(order.getStartTicketNO());
		Map<TicketPrintInfo,Ticketsellagent> ticketsells = new HashMap<TicketPrintInfo, Ticketsellagent>();
		ticketno = ticketno -1;
		// 从售票返回结果写本地ticketsellagent
		//ticketPrintInfos  //order.getTickets()
		for (TicketPrintInfo detail : ticketPrintInfos) {
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code", detail.getDepartstationcode()));
			Station station_depart = (Station) dao.uniqueResult(Station.class, propertyFilters);
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code", detail.getReachstationcode()));
			Station station_reach = (Station) dao.uniqueResult(Station.class, propertyFilters);
			//0售票、1补票、2特权补票、3代售票、4改票、5手工票、6留票销售、7网上售票、8订票
			ticketturnoverdetail.setServicefee(ticketturnoverdetail.getServicefee().add(detail.getServicefee()));
			ticketturnoverdetail.setMoneypayable(ticketturnoverdetail.getMoneypayable().add(detail.getPrice()).add(detail.getServicefee()));
			ticketturnoverdetail.setSellmoney(ticketturnoverdetail.getSellmoney().add(detail.getPrice()));
			
			//0现金、1银联卡、2贵客卡余额、3贵客卡积分
			if("1".equals(detail.getPaymethod())){
				ticketturnoverdetail.setNoncashmoney(ticketturnoverdetail.getNoncashmoney().add(detail.getPrice()));
				ticketturnoverdetail.setNoncashnum(ticketturnoverdetail.getNoncashnum()+1);
			}
			if("2".equals(detail.getPaymethod())||"3".equals(detail.getPaymethod())){
				ticketturnoverdetail.setNonvouchermoneypayable(ticketturnoverdetail.getNonvouchermoneypayable().add(detail.getPrice()));
			}
			
			Ticketsellagent ticketsellagent = new Ticketsellagent();
			ticketsellagent.setSeatno(detail.getSeatno());
			ticketsellagent.setBuspark(detail.getBuspark());
			ticketsellagent.setCarrychildnum(detail.getCarrychildnum());
			ticketsellagent.setCreateby(order.getSeller());
			ticketsellagent.setCreatetime(now);
			ticketsellagent.setServiceprice(detail.getServicefee());
			//TODO 售联网票支持售保险
			if(detail.getCustomerid()==null||detail.getCustomerid()<=0){
				if(vip!=null){
					Customer customer = new Customer();
					customer.setId(vip.getCustomerid());
					ticketsellagent.setCustomer(customer);
					
					Customer cus = (Customer) dao.get(Customer.class, vip.getCustomerid());
					//售票表增加冗余字段 customername、certificateno、certificatetypename
					if(cus!=null){
						ticketsellagent.setCustomername(cus.getName());//旅客姓名
						ticketsellagent.setCertificateno(cus.getCertificateno());//证件号码
						Digitaldictionarydetail certificatetype = dictionaryDao.qryDigitaldictionarydetail("customer", "certificatetype", cus.getCertificatetype());
						if(certificatetype != null){
							ticketsellagent.setCertificatetypename(certificatetype.getValue());//证件类型名称
						}
					}
				}else{
					if(!"".equals(detail.getCertificateno())&&!"".equals(detail.getCertificatetype())
							&&detail.getCertificateno() !=null&&detail.getCertificatetype()!=null){
						propertyFilters.clear();
						propertyFilters.add(new PropertyFilter("EQS_t!certificateno", detail.getCertificateno()));
						propertyFilters.add(new PropertyFilter("EQS_t!certificatetype", detail.getCertificatetype()));
					
						Customer customer = null;	
						List<Customer> listcu=dao.find(Customer.class, propertyFilters);
						if(listcu != null &&listcu.size()>0){
							customer =listcu.get(0);
						}
						if(customer!=null){
							ticketsellagent.setCustomer(customer);
							//售票表增加冗余字段 customername、certificateno、certificatetypename
							ticketsellagent.setCustomername(customer.getName());//旅客姓名
							ticketsellagent.setCertificateno(customer.getCertificateno());//证件号码
							Digitaldictionarydetail certificatetype = dictionaryDao.qryDigitaldictionarydetail("customer", "certificatetype", customer.getCertificatetype());
							
							if(certificatetype != null){
								ticketsellagent.setCertificatetypename(certificatetype.getValue());//证件类型名称
							}
						}
					}else
						ticketsellagent.setCustomer(null);
				}
			}
			else{
				Customer customer = null;	
				if(!"".equals(detail.getCertificateno())&&!"".equals(detail.getCertificatetype())
						&&detail.getCertificateno() !=null&&detail.getCertificatetype()!=null){
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQS_t!certificateno", detail.getCertificateno()));
					propertyFilters.add(new PropertyFilter("EQS_t!certificatetype", detail.getCertificatetype()));
					List<Customer> listcu=dao.find(Customer.class, propertyFilters);
					if(listcu != null &&listcu.size()>0){
						customer =listcu.get(0);
					}
					if(customer!=null){
						ticketsellagent.setCustomer(customer);
						//售票表增加冗余字段 customername、certificateno、certificatetypename
						ticketsellagent.setCustomername(customer.getName());//旅客姓名
						ticketsellagent.setCertificateno(customer.getCertificateno());//证件号码
						Digitaldictionarydetail certificatetype = dictionaryDao.qryDigitaldictionarydetail("customer", "certificatetype", customer.getCertificatetype());
						if(certificatetype != null){
							ticketsellagent.setCertificatetypename(certificatetype.getValue());//证件类型名称
						}
					}
				}else{
					ticketsellagent.setCustomer(customer);
				}
			}
			ticketsellagent.setDepartdate(detail.getDepartdate());
			ticketsellagent.setDepartstationid(station_depart.getId());
			ticketsellagent.setDeparttime(detail.getDeparttime());
			ticketsellagent.setDiscountrate(detail.getDiscountrate());
			ticketsellagent.setDistance(detail.getDistance());
			ticketsellagent.setFullprice(detail.getFullprice());
			ticketsellagent.setIslinework(detail.getIslinework());
			ticketsellagent.setOrgid(organization_depart.getId());
			ticketsellagent.setPaymethod(detail.getPaymethod());
			ticketsellagent.setPrice(detail.getPrice());
			ticketsellagent.setMoreprice(detail.getMoreprice());
			ticketsellagent.setServicefee(new BigDecimal(0));
			ticketsellagent.setReachstationid(station_reach.getId());
			ticketsellagent.setSchedulecode(detail.getSchedulecode());
			ticketsellagent.setSellby(order.getSeller());
			ticketsellagent.setSellip(order.getIp());
			ticketsellagent.setSelltime(now);
			ticketsellagent.setSellway(order.getSellway());
			ticketsellagent.setBatchno(billinventory.getBatchno());
			ticketsellagent.setTicketentrance(detail.getTicketentrance());
			
			ticketno=ticketno+1;
			
			//如果是团体票只打印一张车票
			if("T".equals(detail.getTickettype())||"H".equals(detail.getTickettype())){
				//团体票第一张售票记录的票号为真实票号、其它车票生成虚拟票号
				if(ticketno.longValue()==Long.parseLong(order.getStartTicketNO())){
					ticketsellagent.setTicketno(order.getStartTicketNO());
				}else{
					ticketsellagent.setTicketno(order.getStartTicketNO()+new Long(ticketno-Long.parseLong(order.getStartTicketNO())));
				}
			}else{
				ticketsellagent.setTicketno(StringUtils.strPad(ticketno.toString(),order.getStartTicketNO().length(), "0"));
			}
			
//			ticketsellagent.setTicketno(detail.getTicketno());
								
			ticketsellagent.setTicketoutletsid(order.getTicketoutletsid());
			ticketsellagent.setTicketstatus("0"); //正常
			ticketsellagent.setTickettype(detail.getTickettype());
			ticketsellagent.setUpdateby(order.getSeller());
			ticketsellagent.setUpdatetime(now);
			ticketsellagent.setSeattype(detail.getSeattype());
			ticketsellagent.setToplimitprice(detail.getToplimitprice());

			ticketsellagent.setFueladditionfee(detail.getFueladditionfee());
			ticketsellagent.setStationservicefee(detail.getStationservicefee());
			ticketsellagent.setComputefee(detail.getComputefee());
			ticketsellagent.setCoolairfee(detail.getCoolairfee());
			ticketsellagent.setAdditionfee(detail.getAdditionfee());
			ticketsellagent.setWaterfee(detail.getWaterfee());
			ticketsellagent.setInsurefee(detail.getInsurefee());
			ticketsellagent.setOtherfee(detail.getOtherfee());
			ticketsellagent.setOrderno(order.getOrderno());
			
			ticketturnoverdetail.setFueladditionfee(ticketturnoverdetail.getFueladditionfee().add(ticketsellagent.getFueladditionfee()));
			ticketturnoverdetail.setStationservicefee(ticketturnoverdetail.getStationservicefee().add(ticketsellagent.getStationservicefee()));
			ticketturnoverdetail.setComputefee(ticketturnoverdetail.getComputefee().add(ticketsellagent.getComputefee()));
			ticketturnoverdetail.setCoolairfee(ticketturnoverdetail.getCoolairfee().add(ticketsellagent.getCoolairfee()));
			ticketturnoverdetail.setAdditionfee(ticketturnoverdetail.getAdditionfee().add(ticketsellagent.getAdditionfee()));
			ticketturnoverdetail.setWaterfee(ticketturnoverdetail.getWaterfee().add(ticketsellagent.getWaterfee()));
			ticketturnoverdetail.setInsurefee(ticketturnoverdetail.getInsurefee().add(ticketsellagent.getInsurefee()));
			ticketturnoverdetail.setOtherfee(ticketturnoverdetail.getOtherfee().add(ticketsellagent.getOtherfee()));	
			
			ticketsells.put(detail,ticketsellagent);
//			---------------------------------------    联网订票没有将本站Seatreserveagent状态修改
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQD_t!departdate", detail.getDepartdate()));
			propertyFilters.add(new PropertyFilter("EQS_t!schedulecode", detail.getSchedulecode()));
			propertyFilters.add(new PropertyFilter("EQR_t!seatno", detail.getSeatno()));
			propertyFilters.add(new PropertyFilter("EQL_t!orgid",ticketsellagent.getOrgid() ));
			List<Seatreserveagent> seatreserves = dao.find(LockModeType.PESSIMISTIC_READ,Seatreserveagent.class, propertyFilters);
			for (Seatreserveagent seatreserve : seatreserves) {
				if(seatreserve.getSellstate().equals("R")){
					seatreserve.setSellstate("S");
					seatreserve.setUpdateby(global.getUserinfo().getId());
					seatreserve.setUpdatetime(now);
					dao.merge(seatreserve);	
					break;
				}
			}
//			-------------------------------------------
		}
		ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);
		for (TicketPrintInfo detail : ticketsells.keySet()) {
			Ticketsellagent _ticketsellagent = ticketsells.get(detail);
			_ticketsellagent.setTurnoverdetailid(ticketturnoverdetail.getId());
			_ticketsellagent = (Ticketsellagent) dao.merge(_ticketsellagent);
			dao.getEntityManager().flush();
			detail.setId(_ticketsellagent.getId());
			if(vipconsume!=null){
				//贵宾卡消费记录明细
				Vipconsumeldetail vipconsumeldetail = new Vipconsumeldetail();
				vipconsumeldetail.setCreateby(order.getSeller());
				vipconsumeldetail.setCreatetime(now);
				vipconsumeldetail.setIsselfschedule(false);
				vipconsumeldetail.setSellid(_ticketsellagent.getId());
				vipconsumeldetail.setVipconsume(vipconsume);
				vipconsume.getVipconsumeldetails().add(vipconsumeldetail);
			}
		}
		if(vipconsume!=null){
			dao.merge(vipconsume);
		}
		
		if(TestParams.getNewest().sellTicket == 3){
			SystemFactory.markRtException();
		}
		
		methodResult.setResult(1);
		methodResult.setObject(ticketPrintInfos); //order.getTickets()
		return methodResult;
	}

	@SuppressWarnings("unchecked")
	@Override
	public MethodResult lockSeat(UUID orderno,Date departdate, String schedulesynccode,String departstationcode, List<Short> seatnos,List<String> selectSeatStatus,String selectSeattype,Global global) throws Exception{
		MethodResult methodResult = new MethodResult();
//		NetTicketSellService netTicketSellService = getCentreInterface(methodResult,global.getOrganization());
//		if(netTicketSellService==null){
//			return methodResult;
//		}
		RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty = new RemoteInvokeAuxiliaryProperty();
		remoteInvokeAuxiliaryProperty.setClientIp(global.getOrganization().getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setClientOrgcode(global.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgcode(global.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgIp(global.getOrganization().getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setOperateTicketoutletsName(global.getTicketoutlets().getName());
		remoteInvokeAuxiliaryProperty.setOperateUserName(global.getUserinfo().getName());
		Organization organization_depart = organizationService.getOrgByStationCode(departstationcode);
		remoteInvokeAuxiliaryProperty.setOppositeOrgcode(organization_depart.getCode());
		
//		methodResult = netTicketSellService.lockSeat(remoteInvokeAuxiliaryProperty, departdate, schedulesynccode, orderno, seatnos, selectSeatStatus, selectSeattype);
		Map<String, String> requestMap = new HashMap<String, String>();
		requestMap.put("remoteInvokeAuxiliaryProperty", JsonUtil.toFormatString(remoteInvokeAuxiliaryProperty));
		requestMap.put("departdate", CommonUtil.dateToFullString(departdate));
		requestMap.put("schedulesynccode", schedulesynccode);
		requestMap.put("orderno", orderno.toString());
		requestMap.put("seatnos", JsonUtil.toFormatString(seatnos));
		requestMap.put("selectSeatStatus", JsonUtil.toFormatString(selectSeatStatus));
		requestMap.put("selectSeattype", selectSeattype);

		Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
		methodResult = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.LOCK_SEAT, requestMap);		
		
		if(methodResult.getResult()!=MethodResult.SUCCESS){
			TransactionUtil.setRollbackOnly();
		}
		else{
//			Object[] returnresult= (Object[]) methodResult.getObject();
//			List<Short> _seatnos = (List<Short>) returnresult[1];
			Object[] returnresult= JsonUtil.toObjctArray( methodResult.getObject());
			List<Short> _seatnos = JsonUtil.parseArray(returnresult[1], Short.class);
			
			ListIterator<Short> itSeatnos = seatnos.listIterator();
			int i=0;
			while(itSeatnos.hasNext()){
				itSeatnos.next();
				itSeatnos.set(_seatnos.get(i));
				i++;
			}
			methodResult.setObject(CommonUtil.stringToDate(returnresult[0].toString()));
		}
		return methodResult;
	}

	@SuppressWarnings("unchecked")
	@Override
	public MethodResult findTicketPrices(Date departdate, String schedulesynccode,String departstationcode,String reachstationcode,String seattype,Global global,String departtime) throws Exception {
		MethodResult methodResult = new MethodResult();
//		NetTicketSellService netTicketSellService = getCentreInterface(methodResult,global.getOrganization());
//		if(netTicketSellService==null){
//			return methodResult;
//		}
		RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty = new RemoteInvokeAuxiliaryProperty();
		remoteInvokeAuxiliaryProperty.setClientIp(global.getOrganization().getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setClientOrgcode(global.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgcode(global.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgIp(global.getOrganization().getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setOperateTicketoutletsName(global.getTicketoutlets().getName());
		remoteInvokeAuxiliaryProperty.setOperateUserName(global.getUserinfo().getName());
		Organization organization_depart = organizationService.getOrgByStationCode(departstationcode);
		remoteInvokeAuxiliaryProperty.setOppositeOrgcode(organization_depart.getCode());

//		methodResult = netTicketSellService.findTicketPrices(remoteInvokeAuxiliaryProperty, departdate, schedulesynccode,departstationcode,reachstationcode,seattype,departtime);

		Map<String, String> requestMap = new HashMap<String, String>();
		requestMap.put("remoteInvokeAuxiliaryProperty", JsonUtil.toFormatString(remoteInvokeAuxiliaryProperty));
		requestMap.put("departdate", CommonUtil.dateToFullString(departdate));
		requestMap.put("schedulesynccode", schedulesynccode);
		requestMap.put("departstationcode", departstationcode);
		requestMap.put("reachstationcode", reachstationcode);
		requestMap.put("seattype", seattype);
		requestMap.put("departtime", departtime);

		Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
		methodResult = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.FIND_TICKET_PRICES, requestMap);		
		
		if(methodResult.getResult()==1){
//			Object[] remoteresult = (Object[]) methodResult.getObject();
//			cn.nova.bus.netsale.model.Ticketprice ticketprice_centre = (cn.nova.bus.netsale.model.Ticketprice) remoteresult[0];
			Object[] remoteresult = JsonUtil.toObjctArray(methodResult.getObject());
			
			cn.nova.bus.netsale.model.Ticketprice ticketprice_centre = JsonUtil.parseObject(remoteresult[0], cn.nova.bus.netsale.model.Ticketprice.class);
			
			Ticketprice ticketprice = new Ticketprice();
			ticketprice.setAutocancelreserveseatnum(ticketprice_centre.getAutocancelreserveseatnum());
			ticketprice.setFixedreserveseatnum(ticketprice_centre.getFixedreserveseatnum());
			ticketprice.setFueladditionfee(ticketprice_centre.getFueladditionfee());
			ticketprice.setFullprice(ticketprice_centre.getFullprice());
			ticketprice.setHalfprice(ticketprice_centre.getHalfprice());
			ticketprice.setIssellable(ticketprice_centre.getIssellable());
			ticketprice.setLowerlimitprice(ticketprice_centre.getLowerlimitprice());
			ticketprice.setRuntime(ticketprice_centre.getRuntime());
			ticketprice.setSeatnos(ticketprice_centre.getSeatnos());
			ticketprice.setSeatnum(ticketprice_centre.getSeatnum());
			ticketprice.setSoldeatnum(ticketprice_centre.getSoldeatnum());
			ticketprice.setStationservicefee(ticketprice_centre.getStationservicefee());
			ticketprice.setStudentprice(ticketprice_centre.getStudentprice());
			ticketprice.setToplimitprice(ticketprice_centre.getToplimitprice());
			ticketprice.setUnautocancelreserveseatnum(ticketprice_centre.getUnautocancelreserveseatnum());
			ticketprice.setDiscountprice(ticketprice_centre.getDiscountprice());
			ticketprice.setRoundprice(ticketprice_centre.getRoundprice());
			ticketprice.setConnectprice(ticketprice_centre.getConnectprice());
			if(remoteresult.length>2){
				methodResult.setObject(new Object[]{ticketprice,remoteresult[1],remoteresult[2],remoteresult[3]});
			}else{
				methodResult.setObject(new Object[]{ticketprice,remoteresult[1]});
			}
		}
		else{
			methodResult.setObject(null);
		}
		return methodResult;
	}
	
	@Override
	public MethodResult findScheduleseats(Date departdate, String schedulesynccode,String departstationcode,Global global) throws Exception {
		MethodResult methodResult = new MethodResult();
		
//		NetTicketSellService netTicketSellService = getCentreInterface(methodResult,global.getOrganization());
//		if(netTicketSellService==null){
//			return methodResult;
//		}
		RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty = new RemoteInvokeAuxiliaryProperty();
		remoteInvokeAuxiliaryProperty.setClientIp(global.getOrganization().getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setClientOrgcode(global.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgcode(global.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgIp(global.getOrganization().getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setOperateTicketoutletsName(global.getTicketoutlets().getName());
		remoteInvokeAuxiliaryProperty.setOperateUserName(global.getUserinfo().getName());
		Organization organization_depart = organizationService.getOrgByStationCode(departstationcode);
		remoteInvokeAuxiliaryProperty.setOppositeOrgcode(organization_depart.getCode());
			
//		methodResult = netTicketSellService.findScheduleseats(remoteInvokeAuxiliaryProperty, departdate, schedulesynccode);
		
		Map<String, String> requestMap = new HashMap<String, String>();
		requestMap.put("remoteInvokeAuxiliaryProperty", JsonUtil.toFormatString(remoteInvokeAuxiliaryProperty));
		requestMap.put("departdate", CommonUtil.dateToFullString(departdate));
		requestMap.put("schedulesynccode", schedulesynccode);

		Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
		methodResult = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.FIND_SCHEDULE_SEATS, requestMap);	
		return methodResult;
	}
	
	@Override
	public MethodResult unlockSeat(UUID orderno,String departstationcode,Global global) throws Exception {
		MethodResult methodResult = new MethodResult();
//		NetTicketSellService netTicketSellService = getCentreInterface(methodResult,global.getOrganization());
//		if(netTicketSellService==null){
//			return methodResult;
//		}
		RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty = new RemoteInvokeAuxiliaryProperty();
		remoteInvokeAuxiliaryProperty.setClientIp(global.getOrganization().getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setClientOrgcode(global.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgcode(global.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgIp(global.getOrganization().getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setOperateTicketoutletsName(global.getTicketoutlets().getName());
		remoteInvokeAuxiliaryProperty.setOperateUserName(global.getUserinfo().getName());
		Organization organization = organizationService.getOrgByStationCode(departstationcode);
		remoteInvokeAuxiliaryProperty.setOppositeOrgcode(organization.getCode());
		
//		methodResult = netTicketSellService.unlockSeat(remoteInvokeAuxiliaryProperty, orderno);
		Map<String, String> requestMap = new HashMap<String, String>();
		requestMap.put("remoteInvokeAuxiliaryProperty", JsonUtil.toFormatString(remoteInvokeAuxiliaryProperty));
		requestMap.put("orderno", orderno.toString());

		Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
		String resultstr = RpcUtil.remoteCall(RpcUtil.getRemoteIp(centreOrg.getId()), RemoteApi.UNLOCK_SEAT, requestMap);		
		methodResult = JsonUtil.parseObject(resultstr, MethodResult.class);		
		
		if(methodResult.getResult()!=MethodResult.SUCCESS){
			TransactionUtil.setRollbackOnly();
		}
		return methodResult;
	}
	
	/**
	 * 查询班次停靠点 
	 * @param propertyFilterList
	 * @return
	 * @throws Exception 
	 */
	public MethodResult findSchedulestops(Date departdate, String schedulesynccode,String departstationcode,Global global) throws Exception{
		MethodResult methodResult = new MethodResult();
//		NetTicketSellService netTicketSellService = getCentreInterface(methodResult,global.getOrganization());
//		if(netTicketSellService==null){
//			return methodResult;
//		}
		RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty = new RemoteInvokeAuxiliaryProperty();
		remoteInvokeAuxiliaryProperty.setClientIp(global.getOrganization().getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setClientOrgcode(global.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgcode(global.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgIp(global.getOrganization().getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setOperateTicketoutletsName(global.getTicketoutlets().getName());
		remoteInvokeAuxiliaryProperty.setOperateUserName(global.getUserinfo().getName());
		Organization organization = organizationService.getOrgByStationCode(departstationcode);
		remoteInvokeAuxiliaryProperty.setOppositeOrgcode(organization.getCode());
		
//		methodResult = netTicketSellService.findSchedulestops(remoteInvokeAuxiliaryProperty, departdate, schedulesynccode, departstationcode);
		Map<String, String> requestMap = new HashMap<String, String>();
		requestMap.put("remoteInvokeAuxiliaryProperty", JsonUtil.toFormatString(remoteInvokeAuxiliaryProperty));
		requestMap.put("departdate", CommonUtil.dateToFullString(departdate));
		requestMap.put("schedulesynccode", schedulesynccode);
		requestMap.put("departstationcode", departstationcode);

		Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
		methodResult = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.FIND_SCHEDULE_STOPS, requestMap);	
		return methodResult;
	}
	
	public List<TicketPrintInfo> getTicketPrintInfo(List<PropertyFilter> propertyFilters){
		List<Ticketsellagent> ticketsells = dao.find(Ticketsellagent.class,propertyFilters);
		List<TicketPrintInfo> result = new ArrayList<TicketPrintInfo>();
		Station station;
		for (Ticketsellagent ticketsell : ticketsells) {
			TicketPrintInfo ticketPrintInfo = new TicketPrintInfo();
			ticketPrintInfo.setBuspark(ticketsell.getBuspark());
			ticketPrintInfo.setCarrychildnum(ticketsell.getCarrychildnum());
			ticketPrintInfo.setDepartdate(ticketsell.getDepartdate());
			ticketPrintInfo.setDepartstationid(ticketsell.getDepartstationid());
			station = (Station) dao.get(Station.class, ticketsell.getDepartstationid());
			ticketPrintInfo.setDepartstationname(station == null ? ticketsell.getDepartstationname():station.getName());
			ticketPrintInfo.setDeparttime(ticketsell.getDeparttime());
			ticketPrintInfo.setDiscountrate(ticketsell.getDiscountrate());
			ticketPrintInfo.setDistance(ticketsell.getDistance());
			station = (Station) dao.get(Station.class, ticketsell.getReachstationid());
			ticketPrintInfo.setEndstationname(station == null ? ticketsell.getReachstationname():station.getName());
			ticketPrintInfo.setFueladditionfee(ticketsell.getFueladditionfee());
			ticketPrintInfo.setFullprice(ticketsell.getFullprice());
			ticketPrintInfo.setId(ticketsell.getId());
			ticketPrintInfo.setIslinework(ticketsell.getIslinework());
			ticketPrintInfo.setIsovertime(false);
			ticketPrintInfo.setOrgid(ticketsell.getOrgid());
			ticketPrintInfo.setPaymethod(ticketsell.getPaymethod());
			ticketPrintInfo.setPlanbrandmodel(ticketsell.getVehiclebrandmodelname());
			ticketPrintInfo.setPlanvehicleno(ticketsell.getVehicleno());
			if(ticketsell.getVehicletypeid()>0){
				Vehicletype vehicletype = (Vehicletype) dao.get(Vehicletype.class, ticketsell.getVehicletypeid());
				if(vehicletype!=null){
					ticketPrintInfo.setPlanvehiclegrade(vehicletype.getGrade());
					ticketPrintInfo.setPlanvehicletype(vehicletype.getType());
					ticketPrintInfo.setPlanvehicletypecustomname(vehicletype.getCustomname());
				}
			}
			ticketPrintInfo.setPrice(ticketsell.getPrice());
			ticketPrintInfo.setReachstationid(ticketsell.getReachstationid());
			station = (Station) dao.get(Station.class, ticketsell.getReachstationid());
			if(station != null){
				ticketPrintInfo.setIsroundtrip(station.getIsroundtrip());
				ticketPrintInfo.setReachstationname(station.getName());
				ticketPrintInfo.setReachstationsecondname(station.getSecondname());
			}else{
				ticketPrintInfo.setIsroundtrip(false);
				ticketPrintInfo.setReachstationname(ticketsell.getReachstationname());
				ticketPrintInfo.setReachstationsecondname("");
			}
			ticketPrintInfo.setRoutename("");
			ticketPrintInfo.setSchedulecode(ticketsell.getSchedulecode());
			ticketPrintInfo.setScheduleid(0);
			ticketPrintInfo.setScheduleplanid(0);
			ticketPrintInfo.setScheduleremarks("");
			ticketPrintInfo.setSeatno(ticketsell.getSeatno());
			ticketPrintInfo.setSeatnostr(new Short(ticketsell.getSeatno()).toString());
			ticketPrintInfo.setSeattype(ticketsell.getSeattype());
			ticketPrintInfo.setServicefee(ticketsell.getServicefee());
			station = (Station) dao.get(Station.class, ticketsell.getDepartstationid());
			if(station != null){
				ticketPrintInfo.setStartstationname(station.getName());
				ticketPrintInfo.setDepartstationcode(station.getCode());
				District district =  (District) dao.get(District.class, station.getDistrictid());
				if(district != null){
					ticketPrintInfo.setDepartstationdis(district.getName());
				}
			}else{
				ticketPrintInfo.setStartstationname(ticketsell.getDepartstationname());
				ticketPrintInfo.setStartstationname("");
			}
			ticketPrintInfo.setStationservicefee(ticketsell.getStationservicefee());
			ticketPrintInfo.setTicketentrance(ticketsell.getTicketentrance());
			ticketPrintInfo.setTicketno(ticketsell.getTicketno());
			ticketPrintInfo.setTickettype(ticketsell.getTickettype());
			ticketPrintInfo.setToplimitprice(ticketsell.getToplimitprice());
			ticketPrintInfo.setWorkways("");
			ticketPrintInfo.setReturntripvaliddays((short) 0);
			if(ticketsell.getCustomer()!=null){			   
				   ticketPrintInfo.setCustomerid(ticketsell.getCustomer().getId());
				   ticketPrintInfo.setCertificatetype(ticketsell.getCustomer().getCertificatetype());
				   ticketPrintInfo.setCertificateno(ticketsell.getCustomer().getCertificateno());
				   ticketPrintInfo.setCustomername(ticketsell.getCustomer().getName());
			}
			result.add(ticketPrintInfo);
		}
		return result;
	}
	
	public void setParameterService(ParameterService parameterService) {
		this.parameterService = parameterService;
	}
	
	public ParameterService getParameterService() {
		return parameterService;
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

	@Override
	public MethodResult lockSeat_Jxs(
			Date departdate, String departtime, String routecode,
			String schedulecode, String departstationcode,
			String reachstationcode, UUID orderno, List<Short> seatnos,
			List<String> tickettypelist, List<BigDecimal> prices,
			String selectSeattype,Global global,int takekidnum) throws Exception {
		MethodResult methodResult = new MethodResult();
//		NetTicketSellService netTicketSellService = getCentreInterface(methodResult,global.getOrganization());
//		if(netTicketSellService==null){
//			return methodResult;
//		}
		RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty = new RemoteInvokeAuxiliaryProperty();
		remoteInvokeAuxiliaryProperty.setClientIp(global.getOrganization().getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setClientOrgcode(global.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgcode(global.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgIp(global.getOrganization().getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setOperateTicketoutletsName(global.getTicketoutlets().getName());
		remoteInvokeAuxiliaryProperty.setOperateUserName(global.getUserinfo().getName());
		Organization organization_depart = organizationService.getOrgByStationCode(departstationcode);
		remoteInvokeAuxiliaryProperty.setOppositeOrgcode(organization_depart.getCode());
		
//		
//		methodResult = netTicketSellService.lockSeat_Jxs(remoteInvokeAuxiliaryProperty, departdate, departtime, routecode,schedulecode, 
//														departstationcode,reachstationcode, orderno, seatnos,tickettypelist, prices,selectSeattype,takekidnum);

		Map<String, String> requestMap = new HashMap<String, String>();
		requestMap.put("remoteInvokeAuxiliaryProperty", JsonUtil.toFormatString(remoteInvokeAuxiliaryProperty));
		requestMap.put("departdate", CommonUtil.dateToFullString(departdate));
		requestMap.put("routecode", routecode);
		requestMap.put("schedulecode", schedulecode);
		requestMap.put("departstationcode", departstationcode);
		requestMap.put("reachstationcode", reachstationcode);
		requestMap.put("orderno", orderno.toString());
		requestMap.put("seatnos", JsonUtil.toFormatString(seatnos));
		requestMap.put("tickettypelist", JsonUtil.toFormatString(tickettypelist));
		requestMap.put("prices", JsonUtil.toFormatString(prices));
		requestMap.put("selectSeattype", selectSeattype);
		requestMap.put("takekidnum", takekidnum + "");

		Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
		methodResult = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.LOCK_SEAT_JXS, requestMap);
		
		if(methodResult.getResult()!=MethodResult.SUCCESS){
			TransactionUtil.setRollbackOnly();
		}
		else{
			Object[] returnresult= (Object[]) methodResult.getObject();
			List<Short> _seatnos = (List<Short>) returnresult[1];
			ListIterator<Short> itSeatnos = seatnos.listIterator();
			int i=0;
			while(itSeatnos.hasNext()){
				itSeatnos.next();
				itSeatnos.set(_seatnos.get(i));
				i++;
			}
			
			methodResult.setObject(new Object[]{returnresult[0],returnresult[2]});
		}
		return methodResult;
	}

	@Override
	public TicketPrintInfo getTicketPrintInfoAndChangeTicketNo(
			long ticketsellid, String curTicketNo, Global global)
			throws Exception {
		Date now = new Date();
		//只有售票人或者换票人才允许重打
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!id", ticketsellid));
		Ticketsellagent ticketsellagent = (Ticketsellagent) dao.uniqueResult(Ticketsellagent.class, propertyFilters);
		String ticketstatus = ticketsellagent.getTicketstatus();
		// 正常、退票、废票
		if ("1".equals(ticketstatus)) {
			// 该车票已退
			throw new ServiceException(ticketsellagent.getTicketno(),"0121");
		} else if ("2".equals(ticketstatus)) {
			// 该车票已废
			throw new ServiceException(ticketsellagent.getTicketno(), "0122");
		} else if ("4".equals(ticketstatus)) {
			// 该车票挂失
			throw new ServiceException(ticketsellagent.getTicketno(), "0471");
		}
		//判断售票人
		if(ticketsellagent.getSellby()!=global.getUserinfo().getId()){
			if(!ticketsellagent.getSellway().equals("7")){
			//换票号重打车票不允许重打他人售出的车票
			throw new ServiceException("0344");
			}
		}
	    if(ticketsellagent.getSellway().equals("7")){
			//判断是否是电子票
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!ticketsellid", ticketsellid));
			Ticketsellother ticketsellother = (Ticketsellother) dao.uniqueResult(Ticketsellother.class, propertyFilters);
			if(ticketsellother==null){
				//换票号重打车票不允许重打他人售出的车票
				throw new ServiceException("0344");
			}
			/*else if(!ticketsellother.getIstaked()){
				//该电子票还没有取票，不允许重打车票
				throw new ServiceException("0346");
			}
			else if (ticketsellother.getPrintby()!=global.getUserinfo().getId()){
				//电子票换票号重打车票不允许重打他人取出的电子票
				throw new ServiceException("0350");
			}*/
			MethodResult methodResult = new MethodResult();
//			NetTicketSellService netTicketSellService = getCentreInterface(methodResult,global.getOrganization());
//			if(netTicketSellService==null){
//				throw new Exception(methodResult.getResultMsg());
//			}
			RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty = new RemoteInvokeAuxiliaryProperty();
			remoteInvokeAuxiliaryProperty.setClientIp(global.getOrganization().getServersaddressIp());
			remoteInvokeAuxiliaryProperty.setClientOrgcode(global.getOrganization().getCode());
			remoteInvokeAuxiliaryProperty.setOperateOrgcode(global.getOrganization().getCode());
			remoteInvokeAuxiliaryProperty.setOperateOrgIp(global.getOrganization().getServersaddressIp());
			remoteInvokeAuxiliaryProperty.setOperateTicketoutletsName(global.getTicketoutlets().getName());
			remoteInvokeAuxiliaryProperty.setOperateUserName(global.getUserinfo().getName());
			Organization organization = organizationService.getById(ticketsellagent.getOrgid());
			remoteInvokeAuxiliaryProperty.setOppositeOrgcode(organization.getCode());
			
//			methodResult = netTicketSellService.changeTicketNo(remoteInvokeAuxiliaryProperty, ticketsellagent.getTicketno(), curTicketNo);
			Map<String, String> requestMap = new HashMap<String, String>();
			requestMap.put("remoteInvokeAuxiliaryProperty", JsonUtil.toFormatString(remoteInvokeAuxiliaryProperty));
			requestMap.put("oldTicketno", JsonUtil.toFormatString(ticketsellagent.getTicketno()));
			requestMap.put("newTicketNo", curTicketNo);
			
			Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
			String resultstr = RpcUtil.remoteCall(RpcUtil.getRemoteIp(centreOrg.getId()), RemoteApi.FIND_SCHEDULE_STOPS, requestMap);		
			methodResult = JsonUtil.parseObject(resultstr, MethodResult.class);	
			
			if(methodResult.getResult()!=MethodResult.SUCCESS){
				TransactionUtil.setRollbackOnly();
				throw new Exception(methodResult.getResultMsg());
			}
		}else if(org.apache.commons.lang.StringUtils.isNotEmpty(ticketsellagent.getEticketid())){
			//根据是否有电子票号判断是否前往openapi中心退票
			if(!CurrentUtil.isOpenApiable()){
				throw new Exception("当前OpenApi售票不可用");
			}
			
			OpenApiAdapter openapi = new OpenApiAdapterImpl();
			EncryptRequest param = new EncryptRequest();
			param.put("uid", param.getUid());
			param.put("orderno", ticketsellagent.getOrderno());
			param.put("ticketid", ticketsellagent.getEticketid());
			param.put("ticketno", ticketsellagent.getTicketno());
			param.put("newticketno", curTicketNo);
			param.put("takeway", "0");
			MethodResult methodResult = openapi.changeTicket(param);
			if(methodResult.getResult()!=MethodResult.SUCCESS){
				TransactionUtil.setRollbackOnly();
				throw new Exception(methodResult.getResultMsg());
			}
		}
		//校验当前票号
		Billinuse billinuse = billinuseService.jumpBillinuse(global.getUserinfo().getId(),"Ticket",curTicketNo,1);
		Billinventory billinventory = (Billinventory) dao.get(Billinventory.class, billinuse.getBillinventoryid()); 
		
		//插入或修改应缴款表
		Ticketturnoverdetail ticketturnoverdetail = getTicketturnoverdetailService().getCurTicketturnoverdetail(global.getUserinfo().getId(), curTicketNo);
		if("0".equals(ticketturnoverdetail.getTicketstartno())){
			ticketturnoverdetail.setTicketstartno(curTicketNo);
		}
		
		Station reachstation = (Station) dao.get(Station.class, ticketsellagent.getReachstationid());
		Billdamaged billdamaged_returntripticket = null;
		if(reachstation != null && reachstation.getIsroundtrip()){
			ticketturnoverdetail.setTicketendno(StringUtils.strPad(new Long(curTicketNo+1).toString(),curTicketNo.length(), "0"));

			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQB_t!isselfschedule", true));
			propertyFilters.add(new PropertyFilter("EQL_t!sellid", ticketsellagent.getId()));
			Returntripticket returntripticket = (Returntripticket) dao.uniqueResult(Returntripticket.class,propertyFilters);
			Ticketreprint tp=new Ticketreprint();
			tp.setChangeby(global.getUserinfo().getId());
			tp.setChangetime(now);
			tp.setCreateby(global.getUserinfo().getId());
			tp.setCreatetime(now);
			tp.setIsselfschedule(false);
			tp.setDepartdate(ticketsellagent.getDepartdate());
			tp.setDepartstationid(ticketsellagent.getDepartstationid());
			tp.setDeparttime(ticketsellagent.getDeparttime());
			tp.setNewbatchno(billinventory.getBatchno());
			tp.setNewticketno(ticketturnoverdetail.getTicketendno());
			tp.setOldticketno(returntripticket.getTicketno());
			tp.setOldbatchno(returntripticket.getBatchno());
			tp.setPrice(ticketsellagent.getPrice());
			tp.setReachstationid(ticketsellagent.getReachstationid());
			tp.setSchedulecode(ticketsellagent.getSchedulecode());
			tp.setSeatno(ticketsellagent.getSeatno());
			tp.setSellby(ticketsellagent.getSellby());
			tp.setSellid(ticketsellagent.getId());
			tp.setSellorgid(global.getOrganization().getId());
			tp.setSelltime(ticketsellagent.getSelltime());
			tp.setUpdateby(global.getUserinfo().getId());
			tp.setUpdatetime(now);
			dao.merge(tp);
			//原票号生成坏票登记记录
			billdamaged_returntripticket = new Billdamaged();
			billdamaged_returntripticket.setAmount(1);
			billdamaged_returntripticket.setBillinuseid(billinuse.getId());
			billdamaged_returntripticket.setBilltypeid(billinuse.getBilltypeid());
			billdamaged_returntripticket.setCreateby(global.getUserinfo().getId());
			billdamaged_returntripticket.setCreatetime(now);
			billdamaged_returntripticket.setDamageddscribe("换票号重打车票做废原返程票号！");
			billdamaged_returntripticket.setEndno(new Long(returntripticket.getTicketno()));
			billdamaged_returntripticket.setRecordby(global.getUserinfo().getId());
			billdamaged_returntripticket.setRecordip(global.getIpAddress());
			billdamaged_returntripticket.setRecordtime(billdamaged_returntripticket.getCreatetime());
			billdamaged_returntripticket.setStartno(new Long(returntripticket.getTicketno()));
			billdamaged_returntripticket.setTicketoutletsid(global.getTicketoutlets().getId());
			billdamaged_returntripticket.setUpdateby(global.getUserinfo().getId());
			billdamaged_returntripticket.setUpdatetime(now);
			billdamaged_returntripticket.setTurnoverdetailid(ticketturnoverdetail.getId());
		}
		else{
			ticketturnoverdetail.setTicketendno(curTicketNo);
		}

		ticketturnoverdetail.setUpdateby(global.getUserinfo().getId());
		ticketturnoverdetail.setUpdatetime(now);
		ticketturnoverdetail.setBilldamagednum(ticketturnoverdetail.getBilldamagednum()+1);
		ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);
		if(billdamaged_returntripticket!=null){
			dao.merge(billdamaged_returntripticket);
		}
		Ticketreprint tp=new Ticketreprint();
		tp.setChangeby(global.getUserinfo().getId());
		tp.setChangetime(now);
		tp.setIsselfschedule(false);
		tp.setCreateby(global.getUserinfo().getId());
		tp.setCreatetime(now);
		tp.setDepartdate(ticketsellagent.getDepartdate());
		tp.setDepartstationid(ticketsellagent.getDepartstationid());
		tp.setDeparttime(ticketsellagent.getDeparttime());
		tp.setNewbatchno(billinventory.getBatchno());
		tp.setNewticketno(curTicketNo);
		tp.setOldticketno(ticketsellagent.getTicketno());
		tp.setOldbatchno(ticketsellagent.getBatchno());
		tp.setPrice(ticketsellagent.getPrice());
		tp.setReachstationid(ticketsellagent.getReachstationid());
		tp.setSchedulecode(ticketsellagent.getSchedulecode());
		tp.setSeatno(ticketsellagent.getSeatno());
		tp.setSellby(ticketsellagent.getSellby());
		tp.setSellid(ticketsellagent.getId());
		tp.setSellorgid(global.getOrganization().getId());
		tp.setSelltime(ticketsellagent.getSelltime());
		tp.setUpdateby(global.getUserinfo().getId());
		tp.setUpdatetime(now);
		dao.merge(tp);
		//原售票号生成坏票登记记录
		Billdamaged billdamaged = new Billdamaged();
		billdamaged.setAmount(1);
		billdamaged.setBillinuseid(billinuse.getId());
		billdamaged.setBilltypeid(billinuse.getBilltypeid());
		billdamaged.setCreateby(global.getUserinfo().getId());
		billdamaged.setCreatetime(now);
		billdamaged.setDamageddscribe("换票号重打车票做废原票号！");
		billdamaged.setEndno(new Long(ticketsellagent.getTicketno()));
		billdamaged.setRecordby(global.getUserinfo().getId());
		billdamaged.setRecordip(global.getIpAddress());
		billdamaged.setRecordtime(billdamaged.getCreatetime());
		billdamaged.setStartno(new Long(ticketsellagent.getTicketno()));
		billdamaged.setTicketoutletsid(global.getTicketoutlets().getId());
		billdamaged.setUpdateby(global.getUserinfo().getId());
		billdamaged.setUpdatetime(now);
		billdamaged.setTurnoverdetailid(ticketturnoverdetail.getId());
		dao.merge(billdamaged);
		//修改票号
		ticketsellagent.setTicketno(curTicketNo);
		ticketsellagent.setBatchno(billinventory.getBatchno());
		ticketsellagent.setUpdateby(global.getUserinfo().getId());
		ticketsellagent.setUpdatetime(now);
		dao.merge(ticketsellagent);
		
		//返回打印信息
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!id", ticketsellid));
		return getTicketPrintInfo(propertyFilters).get(0);
	}
	
	@Override
	public MethodResult findNetScheduleDetail(ScheduleDetail scheduleDetail,
			Global global) throws Exception {
		MethodResult methodResult = new MethodResult();
		RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty = new RemoteInvokeAuxiliaryProperty();
		remoteInvokeAuxiliaryProperty.setClientIp(global.getOrganization().getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setClientOrgcode(global.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgcode(global.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgIp(global.getOrganization().getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setOperateTicketoutletsName(global.getTicketoutlets().getName());
		remoteInvokeAuxiliaryProperty.setOperateUserName(global.getUserinfo().getName());
		
		NetScheduleDetail netScheduleDetail = new NetScheduleDetail();
		
		//设置查询条件
		netScheduleDetail.setFlag(scheduleDetail.getFlag());
		netScheduleDetail.setIslinework(scheduleDetail.isIslinework());
		netScheduleDetail.setDeparttime(scheduleDetail.getDeparttime());
		netScheduleDetail.setSchedulesynccode(scheduleDetail.getSchedulesynccode());
//		netScheduleDetail.setScheduleplanid(scheduleDetail.getScheduleplanid());
		netScheduleDetail.setDepartDate(scheduleDetail.getDepartDate());
		Station station = (Station) dao.get(Station.class, scheduleDetail.getReachStationId());
		netScheduleDetail.setReachStationcode(station.getCode());
		netScheduleDetail.setOrgcode(global.getOrganization().getCode());
		netScheduleDetail.setDistrictcode(scheduleDetail.getDistrictcode());
		netScheduleDetail.setWorktype(scheduleDetail.getWorktype());
		if(scheduleDetail.getDepartStationId()!=null&&scheduleDetail.getDepartStationId()>0){
			Organization organization_depart = organizationService.getOrgByStationId(scheduleDetail.getDepartStationId());
			remoteInvokeAuxiliaryProperty.setOppositeOrgcode(organization_depart.getCode());
			station = (Station) dao.get(Station.class, scheduleDetail.getDepartStationId());
			netScheduleDetail.setDepartStationcode(station.getCode());
		}
		else{
			remoteInvokeAuxiliaryProperty.setOppositeOrgcode(null);
		}
		
		Map<String, String> requestMap = new HashMap<String, String>();
		requestMap.put("remoteInvokeAuxiliaryProperty", JsonUtil.toFormatString(remoteInvokeAuxiliaryProperty));
		requestMap.put("scheduleDetail", JsonUtil.toFormatString(netScheduleDetail));
		play.Logger.info("RemoteApi.FIND_SCHEDULEDETAIL"+RemoteApi.FIND_SCHEDULEDETAIL);
		Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
		methodResult = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.FIND_SCHEDULEDETAIL, requestMap);
		play.Logger.info("RemoteApi.FIND_SCHEDULEDETAIL END");
//		methodResult.setObject(result);
		methodResult.setResult(1);
		return methodResult;
	}

	@Override
	public MethodResult findStowageScheduleDetail(
			ScheduleDetail scheduleDetail, Global global) throws Exception {
		MethodResult methodResult = new MethodResult();
		RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty = new RemoteInvokeAuxiliaryProperty();
		remoteInvokeAuxiliaryProperty.setClientIp(global.getOrganization().getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setClientOrgcode(global.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgcode(global.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgIp(global.getOrganization().getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setOperateTicketoutletsName(global.getTicketoutlets().getName());
		remoteInvokeAuxiliaryProperty.setOperateUserName(global.getUserinfo().getName());
		
		NetScheduleDetail netScheduleDetail = new NetScheduleDetail();
		
		//设置查询条件
		netScheduleDetail.setFlag(scheduleDetail.getFlag());
		netScheduleDetail.setIslinework(scheduleDetail.isIslinework());
		netScheduleDetail.setDeparttime(scheduleDetail.getDeparttime());
		netScheduleDetail.setSchedulesynccode(scheduleDetail.getSchedulesynccode());
		netScheduleDetail.setDepartDate(scheduleDetail.getDepartDate());
		Station station = (Station) dao.get(Station.class, scheduleDetail.getReachStationId());
		netScheduleDetail.setReachStationcode(station.getCode());
		netScheduleDetail.setOrgcode(global.getOrganization().getCode());
		netScheduleDetail.setDistrictcode(scheduleDetail.getDistrictcode());
		netScheduleDetail.setWorktype(scheduleDetail.getWorktype());
		if(scheduleDetail.getDepartStationId()!=null&&scheduleDetail.getDepartStationId()>0){
			Organization organization_depart = organizationService.getOrgByStationId(scheduleDetail.getDepartStationId());
			remoteInvokeAuxiliaryProperty.setOppositeOrgcode(organization_depart.getCode());
			station = (Station) dao.get(Station.class, scheduleDetail.getDepartStationId());
			netScheduleDetail.setDepartStationcode(station.getCode());
		}
		else{
			remoteInvokeAuxiliaryProperty.setOppositeOrgcode(null);
		}
		
		Map<String, String> requestMap = new HashMap<String, String>();
		requestMap.put("remoteInvokeAuxiliaryProperty", JsonUtil.toFormatString(remoteInvokeAuxiliaryProperty));
		requestMap.put("scheduleDetail", JsonUtil.toFormatString(netScheduleDetail));
		play.Logger.info("RemoteApi.FIND_STOWAGESCHEDULEDETAIL"+RemoteApi.FIND_STOWAGESCHEDULEDETAIL);
		Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
		methodResult = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.FIND_STOWAGESCHEDULEDETAIL, requestMap);
			//获取配置班次中心售票情况更新到车站
		if(methodResult.getResult()==0){
			System.out.println("该班次错误记录：=="+methodResult.getResultMsg());
		}
		List<Map<String, Object>> result =null;
		if(scheduleDetail.getFlag()==1){
			Object[] remoteresult = JsonUtil.toObjctArray(methodResult.getObject());
			result = JSON.parseObject(remoteresult[0].toString(),new TypeReference<List<Map<String,Object>>>(){});
		}else{
			result = JSON.parseObject(methodResult.getObject().toString(),new TypeReference<List<Map<String,Object>>>(){});
		}

		play.Logger.info("RemoteApi.FIND_STOWAGESCHEDULEDETAIL END");
		methodResult.setObject(result);
		methodResult.setResult(1);
		return methodResult;
	}
	//更新本地的售票数和留位数
	@Override
	public void updateTicketpriceAndScheduleplan(short soldnum,short autoseatnum,short unautoseatnum,long scheduleplanid){
		Scheduleplan sp =(Scheduleplan)dao.get(Scheduleplan.class, scheduleplanid);
		if(sp==null){
			return;
		}
		sp.setAutocancelreserveseatnum(autoseatnum);
		sp.setUnautocancelreserveseatnum(unautoseatnum);
		sp.setSoldeatnum(soldnum);
		dao.merge(sp);
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", scheduleplanid));
		List<Ticketprice> ticketprices = dao.find(LockModeType.PESSIMISTIC_READ,Ticketprice.class, propertyFilters);
		if(ticketprices.size()>0){
			for (Ticketprice _ticketprice : ticketprices){
				_ticketprice.setSoldeatnum(soldnum);
				_ticketprice.setAutocancelreserveseatnum(autoseatnum);
				_ticketprice.setUnautocancelreserveseatnum(unautoseatnum);
				dao.merge(_ticketprice);
			}
		}
	}

	@Override
	public MethodResult findStowageNetSchedule(
			List<Map<String, Object>> scheduleplanlist, Global global)
			throws Exception {
		MethodResult methodResult = new MethodResult();
		Map<String, String> requestMap = new HashMap<String, String>();
		requestMap.put("scheduleplanlist", JsonUtil.toFormatString(scheduleplanlist));
		play.Logger.info("RemoteApi.FIND_STOWAGESCHEDULEDETAIL"+RemoteApi.FIND_STOWAGESCHEDULEDETAIL);
		Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
		methodResult = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.FIND_STOWAGENETSCHEDULE, requestMap);
		//获取配置班次中心售票情况更新到车站
		if(methodResult.getResult()==1){
			List<Map<String, Object>> result =null;
			result = JSON.parseObject(methodResult.getObject().toString(),new TypeReference<List<Map<String,Object>>>(){});
			methodResult.setObject(result);
			methodResult.setResult(1);
		}
		return methodResult;
	}

	@Override
	public List<Map<String, Object>> findNetSoldnum(
			List<Map<String, Object>> scheduleplanlist, Global global)
			throws Exception {
		MethodResult methodResult = new MethodResult();
		RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty = new RemoteInvokeAuxiliaryProperty();
		remoteInvokeAuxiliaryProperty.setClientIp(global.getOrganization().getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setClientOrgcode(global.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgcode(global.getOrganization().getCode());
		remoteInvokeAuxiliaryProperty.setOperateOrgIp(global.getOrganization().getServersaddressIp());
		remoteInvokeAuxiliaryProperty.setOperateTicketoutletsName(global.getTicketoutlets().getName());
		remoteInvokeAuxiliaryProperty.setOperateUserName(global.getUserinfo().getName());
		
		Map<String, String> requestMap = new HashMap<String, String>();
		requestMap.put("scheduleplanlist", JsonUtil.toFormatString(scheduleplanlist));
		requestMap.put("remoteInvokeAuxiliaryProperty", JsonUtil.toFormatString(remoteInvokeAuxiliaryProperty));
		
		Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
		methodResult = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.FIND_NETSOLDNUM, requestMap);
		List<Map<String, Object>> result = JSON.parseObject(methodResult.getObject().toString(),new TypeReference<List<Map<String,Object>>>(){});
		return result;
	}
	
	/**
	 * 联网订票
	 * @param seatreserves
	 * @param global
	 * @return
	 */
	public MethodResult reserveSeat(String transactionid, List<Seatreserve> seatreserves, Global global) {
		MethodResult methodResult = new MethodResult();
		try {
			int carrychildnum = 0;
			String seatnos = "";
			List<Seatreserveno> srlist=new ArrayList<Seatreserveno>();
			for (Seatreserve sr : seatreserves) {
				Seatreserveno seat = new Seatreserveno();
				carrychildnum = sr.getCarrychildnum() + carrychildnum;
				seatnos = seatnos + sr.getSeatno() + ",";
				seat.setPrice(sr.getFullprice());
				seat.setSeatno(sr.getSeatno());
				seat.setSeattypeCode("0");
				seat.setTickettype(sr.getTickettype());
				srlist.add(seat);
			}

			Seatreserve seatreserve = seatreserves.get(0);	
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code", seatreserve.getDepartstationcode()));
			Station dpstation = (Station) dao.uniqueResult(Station.class, propertyFilters);//发车站
			
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!station.id", dpstation.getId()));
			Organization dpOrg = (Organization) dao.uniqueResult(Organization.class, propertyFilters);//发车机构
			
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!code", seatreserve.getReachstationcode()));
			Station rpstation = (Station) dao.uniqueResult(Station.class, propertyFilters);//到达站
			
			//联网留位参数
			SeatreserveIn sin = new SeatreserveIn();
			sin.setAutocanceltime(seatreserve.getAutocanceltime());
			sin.setCarrychildnum((byte) carrychildnum);
			sin.setSeatnostr(seatnos);
			Customer customer=null;
			if (seatreserve.getCustomer() != null) {
				sin.setCustomerid(seatreserve.getCustomer().getId());
			}
			if(seatreserve.getCustomerid()>0){
				customer = (Customer) dao.get(Customer.class,
						seatreserve.getCustomerid());
				sin.setSex(customer.getSex());
				sin.setCertificateno(customer.getCertificateno());
				sin.setCertificatetype(customer.getCertificatetype());
				sin.setName(customer.getName());
				sin.setCustomersynccode(customer.getSynccode());
				
			}
			sin.setDepartStationCode(dpstation.getCode());
			sin.setDepartDate(seatreserve.getDepartdate());
			sin.setDepartstationid(seatreserve.getDepartstationid());
			sin.setDeparttime(seatreserve.getDeparttime());
			sin.setFullprice(seatreserve.getFullprice());
			sin.setIsautocancel(seatreserve.isIsautocancel());
			Organization organization = (Organization) dao.get(
					Organization.class, seatreserve.getReserveorgid());
//					Organization.class, seatreserve.getOrgid());
			sin.setOrgcode(organization.getCode());//留位机构
			sin.setSeatlist(srlist);
			sin.setReachstationid(seatreserve.getReachstationid());
			sin.setReachStationCode(rpstation.getCode());
			sin.setReserveIp(seatreserve.getReserveip());
			sin.setReserveOrgCode(global.getOrganization().getCode());
			sin.setReservetime(seatreserve.getReservetime());
			sin.setSchedulecode(seatreserve.getSchedulecode());
			sin.setSchedulesynccode(seatreserve.getSchedulesynccode());
			//sin.setSchplanSynccode(seatreserve.getSchplanSynccode());
			sin.setSeatnostr(seatnos);
			sin.setServiceprice(seatreserve.getServiceprice());
			sin.setTicketoutletsCode(global.getTicketoutlets().getCode());
			sin.setTicketoutletsname(global.getTicketoutlets().getName());

			RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty = new RemoteInvokeAuxiliaryProperty();
			remoteInvokeAuxiliaryProperty.setClientIp(global.getOrganization()
					.getServersaddressIp());
			remoteInvokeAuxiliaryProperty.setClientOrgcode(global
					.getOrganization().getCode());
			remoteInvokeAuxiliaryProperty.setOperateOrgcode(global
					.getOrganization().getCode());
			remoteInvokeAuxiliaryProperty.setOperateOrgIp(global
					.getOrganization().getServersaddressIp());
			remoteInvokeAuxiliaryProperty.setOperateTicketoutletsName(global
					.getTicketoutlets().getName());
			remoteInvokeAuxiliaryProperty.setOperateUserName(global
					.getUserinfo().getName());
			
			//调用远程
			Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
			if(centreOrg == null){
				methodResult.setResult(MethodResult.FAILURE);
				methodResult.setResultMsg("无法连接中心服务器:找不到" +  global.getOrganization() + "的上级机构");
				play.Logger.info(methodResult.getResultMsg());
				return methodResult;
			}
			try {
				Map<String, String> requestMap = new HashMap<String, String>();
				requestMap.put("sin", JsonUtil.toFormatString(sin));
				requestMap.put("remoteInvokeAuxiliaryProperty", JsonUtil.toFormatString(remoteInvokeAuxiliaryProperty));
				requestMap.put("transactionid", transactionid);
				play.Logger.info("联网订票，请求中心参数：" + JsonUtil.toFormatString(sin));
				methodResult = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.NET_SEAT_RESERVE, requestMap);
				
				if(methodResult.getResult() != MethodResult.SUCCESS){
					TransactionUtil.setRollbackOnly();
					return methodResult;
				}
			} catch (Exception e) {
				methodResult.setResult(MethodResult.FAILURE);
				methodResult.setResultMsg(e.getMessage());
				play.Logger.error("联网订票调用中心出错" + e.getMessage());
				return methodResult;
			}

			if (methodResult.SUCCESS == 1) {
				Date now = new Date();
				long userid = global.getUserinfo().getId();
				//远程成功，本地保存Seatreserveagent信息
				int index = 0;//给座位类型赋值用
				for (Seatreserve seat : seatreserves) {
					Seatreserveagent seg = new Seatreserveagent();
//					Seatreserve seg = new Seatreserve();
					seg.setDepartdate(sin.getDepartDate());
					if (carrychildnum > 0) {
						seg.setCarrychildnum((byte) 1);
						carrychildnum = carrychildnum - 1;
					} else {
						seg.setCarrychildnum((byte) 0);
					}
					seg.setAutocanceltime(seg.getAutocanceltime());
					seg.setCreateby(userid);
					seg.setCreatetime(now);
					seg.setCustomer(seat.getCustomer());
					seg.setDeparttime(seatreserve.getDeparttime());
					seg.setDepartstation(dpstation);
					seg.setOrgid(dpOrg.getId());
					seg.setFullprice(seatreserve.getFullprice());
					seg.setIsautocancel(seatreserve.isIsautocancel());
					seg.setReachstation(rpstation);
					seg.setReserveby(global.getUserinfo().getId());
					seg.setReserveip(seatreserve.getReserveip());
					seg.setReservetime(now);
					seg.setReserveway("1");// 订票
					seg.setRemarks(seatreserve.getRemarks());
					seg.setDepartstationid(dpstation.getId());
					seg.setReachstationid(rpstation.getId());
					// seg.setScheduleid(scheduleplan.getScheduleid());
					seg.setScheduleplanid((long) 0);
					seg.setSeatno(seat.getSeatno());
					seg.setSellstate("R");
					seg.setServiceprice(seatreserve.getServiceprice());
					seg.setTicketoutletsid(global.getTicketoutlets().getId());
					seg.setTickettype(seatreserve.getTickettype());
					seg.setUpdateby((long) 0);
					seg.setUpdatetime(now);
					seg.setReserveorgid(global.getOrganization().getId());
					seg.setCustomer(customer);
					seg.setSchedulecode(sin.getSchedulecode());
					seg.setSchedulesynccode(sin.getSchedulesynccode());
					seg.setRoutename(sin.getRoutename());
					seg.setSeattype(sin.getSeatlist().get(index).getSeattypeCode());
					index ++;
					dao.merge(seg);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			methodResult.setResult(0);
		}
		methodResult.setResultMsg("订票成功，请通知乘客在规定时间内提前取票！");
		return methodResult;
	}
	
}

