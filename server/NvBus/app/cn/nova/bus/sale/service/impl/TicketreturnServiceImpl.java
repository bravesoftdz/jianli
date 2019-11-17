package cn.nova.bus.sale.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.persistence.LockModeType;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.nova.bus.archive.model.Vip;
import cn.nova.bus.archive.model.Vipconsume;
import cn.nova.bus.archive.model.Vipconsumeldetail;
import cn.nova.bus.archive.service.VipService;
import cn.nova.bus.archive.service.impl.VipServiceImpl;
import cn.nova.bus.bill.model.Billdamaged;
import cn.nova.bus.bill.model.Billinuse;
import cn.nova.bus.bill.model.Billinventory;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.BillinuseService;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BillinuseServiceImpl;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.common.ConstDefiniens;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.insure.model.Insurance;
import cn.nova.bus.insure.service.InsurancereturnService;
import cn.nova.bus.insure.service.impl.InsurancereturnServiceImpl;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.netsale.model.TicketReturnInfo;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleseats;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.sale.dao.TicketDao;
import cn.nova.bus.sale.dao.TicketreturnDao;
import cn.nova.bus.sale.model.CarryChild;
import cn.nova.bus.sale.model.Ticketchange;
import cn.nova.bus.sale.model.Ticketreturn;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.model.Ticketsellagent;
import cn.nova.bus.sale.model.Ticketsellother;
import cn.nova.bus.sale.model.Ticketsign;
import cn.nova.bus.sale.model.Ticketturnoverdetail;
import cn.nova.bus.sale.model.Ticketturnoverdetailepay;
import cn.nova.bus.sale.service.TicketpriceReturnService;
import cn.nova.bus.sale.service.TicketreturnService;
import cn.nova.bus.sale.service.TicketturnoverdetailService;
import cn.nova.bus.sale.service.VipconsumeService;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.service.OrganizationService;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.OrganizationServiceImpl;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.openapi.model.response.TicketDetail;
import cn.nova.openapi.sevice.OpenApiAdapter;
import cn.nova.openapi.sevice.impl.OpenApiAdapterImpl;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.RemoteInvokeAuxiliaryProperty;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;
import models.TestParams;
import util.CurrentUtil;
import util.DateUtils;
import util.JsonUtil;
import util.RemoteApi;
import util.RpcUtil;
import util.SystemFactory;
import util.TransactionUtil;


public class TicketreturnServiceImpl implements TicketreturnService {
	final private Logger log=LoggerFactory.getLogger(getClass());

	
	private TicketreturnDao ticketreturnDao = new TicketreturnDao();
	
	private ParameterService parameterService = new ParameterServiceImpl();
	
	private BillinuseService billinuseService = new BillinuseServiceImpl();
	
	private IDAO dao = new EntityManagerDaoSurport();
	
	private InsurancereturnService insurancereturnService = new InsurancereturnServiceImpl();
	
	private TicketturnoverdetailService ticketturnoverdetailService = new TicketturnoverdetailServiceImpl();
	
	private BilltypeService billtypeService = new BilltypeServiceImpl();
	 
	private OrganizationService organizationService = new OrganizationServiceImpl();
	
	
	private VipService vipService = new VipServiceImpl();
	
	
	private VipconsumeService vipconsumeService = new VipconsumeServiceImpl();
	//原路退款
	private TicketpriceReturnService ticketpriceReturnService;
	
	final private int insideInvokFalse = -67101735;

	@Override
	public MethodResult find(List<PropertyFilter> propertyFilters,Long loginorgid) throws Exception {
		MethodResult methodResult = new MethodResult();
		String param1115 = new ParameterServiceImpl().findParamValue("1115", CurrentUtil.getGlobal().getOrganization().getId());
		if((param1115 == null) || ("".equals(param1115))){
			param1115 = "0";
		}
		List<Map<String,Object>> result = ticketreturnDao.find(propertyFilters,loginorgid,param1115);
		play.Logger.info("退票查询结果:" + JsonUtil.toFormatString(result));
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
				methodResult = RpcUtil.remoteMethodCall(RpcUtil.getRemoteIp(centreOrg.getId()), RemoteApi.FIND_TICKET_JXS, requestMap);		
				
				if(methodResult.getResult()==MethodResult.SUCCESS){
					Object[] objects = (Object[]) methodResult.getObject();
					String ticketstatus = (String) objects[0];
					//00：未锁定		01：已锁定		02：已销售		03：已取票	04：已废票	05：已退票	06: 已检票
					if("02".equals(ticketstatus)){
						result.get(0).put("isselected", 1);
					}else{
						result.get(0).put("isselected", null);
					}
					if("06".equals(ticketstatus)){
						result.get(0).put("signcharges", objects[2]);
						result.get(0).put("ischecked", 1);
					}else{
						result.get(0).put("ischecked", null);
					}
					if("02".equals(ticketstatus)){
						result.get(0).put("signcharges", objects[2]);
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
				
				propertyFilters2.clear();
				propertyFilters2.add(new PropertyFilter("EQD_t!departdate", ticket.get("departdate")));
				propertyFilters2.add(new PropertyFilter("EQS_t!tickettype", ticket.get("tickettype").toString()));
				
				List list = new ArrayList();
				for (Ticketsell ts_tuan : ts_tuans) {
					ticket.put("price", ((BigDecimal)ticket.get("price")).add(ts_tuan.getPrice()));
					ticket.put("servicefee", ((BigDecimal)ticket.get("servicefee")).add(ts_tuan.getServicefee()));
					
					
						StringBuilder sqlinsurance = new StringBuilder("select i.premium from Ticketsell t,Insurance i where i.sellid=t.id and t.id = "+ts_tuan.getId())
						.append(" and i.insurancestatus='0'");
						list=dao.find(sqlinsurance.toString(), propertyFilters2);
						if (list!=null && list.size()>0){
							if (ticket.get("premium")==null){
								ticket.put("premium", BigDecimal.ZERO);
							}
							ticket.put("premium", ((BigDecimal)ticket.get("premium")).add((BigDecimal) list.get(0)));
						}
						
					
//					ticket.put("premium", ((BigDecimal)ticket.get("premium")).add(ts_tuan.getprServicefee()));
				}
			}
		}*/
		methodResult.setObject(result);
		methodResult.setResult(MethodResult.SUCCESS);
		return methodResult;
	}
	
	public BigDecimal findReturnFee(long ticketsellid) throws Exception{
		Ticketsell ticketsell = (Ticketsell) dao.get(LockModeType.PESSIMISTIC_READ,Ticketsell.class, ticketsellid);
		Ticketsellagent ticketsellagent = (Ticketsellagent) dao.get(LockModeType.PESSIMISTIC_READ,Ticketsellagent.class, ticketsellid);
		BigDecimal returnFee = null;
		if(ticketsell != null){
			
		}else if(ticketsellagent != null){
			OpenApiAdapterImpl openApiAdapterImpl = new OpenApiAdapterImpl();
			TicketDetail querySell = openApiAdapterImpl.querySell(ticketsellagent.getOrderno());
			if(querySell == null){
				throw new  Exception("没有找到票");
			}
			double rrefundprice = querySell.getRrefundprice(ticketsellagent.getEticketid());
			returnFee = new BigDecimal(rrefundprice);
		}else{
			throw new  Exception("没有找到票");
		}
		
		
		return returnFee;
		
	}
	/**
	 * 预处理退票信息，主要为处理儿童票：
	 * 		1.不允许单独退儿童票，即使前台勾选了，也不可退；
	 * 		2.主票退，则儿童票自动退；
	 * 		3.是否退儿童票保险，与主票保持一致
	 * @param ticketreturns
	 * @param global
	 * @throws Exception
	 */
	private Map<String, Object> preChildReturn(List<Ticketreturn> ticketreturns, Global global) throws Exception {
		//返回结果
		Map<String, Object> result = new HashMap<String, Object>();
		
		Ticketsell temp = null;
		int returnTicketNum = 0;//退票张数
		boolean hasChild = false;//是否存在儿童票
		TicketDao ticketDao = new TicketDao(); 
		//StringBuffer tsidStr =  new StringBuffer();//所有勾选的退票的ticketsell id(主票+儿童票)，str供校验是否存在没有勾选主票的儿童票做判断使用（判断是否勾选主票使用）
		List<Long> idsList = new ArrayList<Long>();//所有勾选的退票的ticketsell id(主票+儿童票)，str供校验是否存在没有勾选主票的儿童票做判断使用（判断是否勾选主票使用）
		List<Long> childIdList = new ArrayList<Long>();//所有勾选的退票中儿童票的ticketsell id，list用来查询所有车票中儿童票对应的主票（判断是否勾选主票使用）
		List<Long> primaryIdList = new ArrayList<Long>();//所有勾选的退票中主票的ticketsell id，primaryIdList用来退所有对应的儿童票使用
		Map<Long, Boolean> insuranceMap = new HashMap<Long, Boolean>();//主票是否退保险，供儿童票退保险使用 
		List<Ticketsell> childTicketList = new ArrayList<Ticketsell>();//需要生成退票记录的儿童票
		
//		ParameterService paramService = new ParameterServiceImpl();
//		String p1512 = paramService.findParamValue(ParamterConst.Param_1512, global.getUserinfo().getOrgid());//参数1512：改签是否使用原票号
		
		//儿童票不做单独退票操作，即使前台勾选了，也不可退
		Iterator<Ticketreturn> iterator = ticketreturns.iterator();
		while(iterator.hasNext()){
			Ticketreturn tr = iterator.next();
			//tsidStr.append(tr.getSellid().toString()).append(",");
			idsList.add(tr.getSellid());
			temp = (Ticketsell) dao.get(Ticketsell.class, tr.getSellid());
			if(temp != null){
				if("E".equals(temp.getTickettype())){
					childIdList.add(tr.getSellid());
					hasChild = true;
					iterator.remove();//移除儿童票
				}else{
					//主票id
					primaryIdList.add(temp.getId());
					insuranceMap.put(temp.getId(), tr.getIsreturninsure());					
				}
			}
		}
		
		//前台勾选车票中若存在儿童票，则需要判断是否勾选了了主票
		if(hasChild){
			List<Object[]> childInfo = ticketDao.findQTicket(childIdList);
			if(childInfo != null && childInfo.size() > 0){
				for (Object[] child : childInfo) {
					//if(!tsidStr.toString().contains(((BigDecimal)child[0]).longValue() + "")){
					if(!idsList.contains(((BigDecimal)child[0]).longValue())){
						//若勾选的票号中不存在某儿童票对应的主票，则不允许退票
						play.Logger.error("未勾选票号为" + ((String) child[1]) + "(儿童票)对应的主票，不允许单独退此儿童票！");
						throw new BusinessException(" 未勾选票号为" + ((String) child[1]) + "(儿童票)对应的主票，不允许单独退此儿童票！");
					}
				}
			}else{
				play.Logger.info("所退车票中不包含儿童票！");
			}
		}
		
		//儿童票是否需退保险
		if(primaryIdList.size() > 0){
			//单独退儿童票
			List<Object[]> childInfo = ticketDao.findChildTicket(primaryIdList);
			if(childInfo != null && childInfo.size() > 0){
				Date updatetime = new Date();
				List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
				for (Object[] info : childInfo) {
					//1074参数开启，免票儿童单独打印车票。联网售票暂时不支持联网售免票儿童并打印儿童票。所以不用考虑Tikcetsellother
					temp = (Ticketsell) dao.get(LockModeType.PESSIMISTIC_READ, Ticketsell.class, ((BigDecimal)info[1]).longValue());//儿童票ticketsell
					temp.setTicketstatus("1");//1 已退
					temp.setUpdatetime(updatetime);
					temp.setUpdateby(global.getUserinfo().getId());
					dao.merge(temp);
//					if((ParamterConst.COMMON_FLAG.FALG_YES.equals(p1512)) 
//							&& ("3".equals(ticketreturns.get(0).getReturnway()))){//改签使用原票号时需要将原票加上后缀
//						
//					}
					
					childTicketList.add(temp);//需要生成退票记录的儿童票
					returnTicketNum ++;//退票张数
					
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQL_t!childticketid", temp.getId()));
					CarryChild carryChild = (CarryChild) dao.uniqueResult(LockModeType.PESSIMISTIC_WRITE, CarryChild.class, propertyFilters);
					carryChild.setRemark(carryChild.getRemark() + ", 退票" + DateUtils.formatDatetime(updatetime));
					dao.merge(carryChild);
					
					Ticketreturn tr = new Ticketreturn();
					Boolean flag = insuranceMap.get(((BigDecimal)info[0]).longValue());//通过主票id获取是否退保险
					if(flag == null){
						tr.setIsreturninsure(false);
					}else{
						tr.setIsreturninsure(flag);
						if(flag){
							propertyFilters.clear();
							propertyFilters.add(new PropertyFilter("EQL_t!sellid", temp.getId()));
							//Insurance insurance = (Insurance)dao.uniqueResult(Insurance.class, propertyFilters);
							//tr.setReturninsureid(insurance.getId());
							List<Insurance> list = dao.find(Insurance.class, propertyFilters);
							if(list != null && list.size() > 0){
								Insurance insurance = list.get(0);
								tr.setReturninsureid(insurance.getId());
							}
						}
					}
					tr.setOpertype(ticketreturns.get(0).getOpertype());
					tr.setReturnway(ticketreturns.get(0).getReturnway());
					tr.setReturnby(ticketreturns.get(0).getReturnby());
					tr.setRemarks("儿童票退保险");
					tr.setIsreturnticket(false);//标识儿童票不走主票退票代码
					tr.setSellid(temp.getId());
					ticketreturns.add(tr);//将儿童票赋值到ticketreturns，供儿童票退保险
				}
			}
		}
		
		result.put("returnTicketNum", returnTicketNum);
		result.put("childTicketList", childTicketList);
		//result.put("childIdList", childIdList);
		return result;
	}
	
	
	@Override
	public boolean returnTickets(List<Ticketreturn> ticketreturns,Global global,
									String vipcardno,String vipgrade,BigDecimal vipmoney,BigDecimal vippoint,boolean canprint,long returnby) 
		throws Exception {
		play.Logger.info("退票操作开始" + JsonUtil.toFormatString(ticketreturns));
		if(returnby != global.getUserinfo().getId()){
			play.Logger.error("退票人和Global中的不一致  Global.getUserinfo().getId() : "+global.getUserinfo().getId() +"  returnby : " + returnby);
		}
		Map<String, Object> map = preChildReturn(ticketreturns, global);//预处理退票信息，主要为处理儿童票
		List<Ticketsell> childTicketList = (List<Ticketsell>) map.get("childTicketList");//需要生成退票记录的儿童票
		//儿童票不做单独退票操作，即使前台勾选了，也不可退
		Iterator<Ticketreturn> iterator = ticketreturns.iterator();
		Ticketreturn trInfo = null;//儿童票对应的主票(公共)信息
		TicketDao ticketdao = new TicketDao(); 
		StringBuffer tsidStr =  new StringBuffer();//所有勾选的退票的ticketsell id(主票+儿童票)，str供校验是否存在没有勾选主票的儿童票做判断使用（判断是否勾选主票使用）
		List<Long> childIdList = new ArrayList<Long>();//所有勾选的退票中儿童票的ticketsell id，list用来查询所有车票中儿童票对应的主票（判断是否勾选主票使用）
		List<Long> primaryIdList = new ArrayList<Long>();//所有勾选的退票中主票的ticketsell id，primaryIdList用来退所有对应的儿童票使用
		Map<Long, Boolean> insuranceMap = new HashMap<Long, Boolean>();//主票是否退保险，供儿童票退保险使用 
//		List<Ticketreturn> childReturnList = new ArrayList<Ticketreturn>();//供儿童票退保险使用
		Ticketsell ts = null;
		boolean hasChild = false;
		BigDecimal totalreturnChargesweb = new BigDecimal(0);//网售原路返还手续费
		BigDecimal totalreturnReturnamountweb = new BigDecimal(0);//网售原路返还退票金额
		while(iterator.hasNext()){
			Ticketreturn tr = iterator.next();
			tsidStr.append(tr.getSellid().toString()).append(",");
			ts = (Ticketsell) dao.get(Ticketsell.class, tr.getSellid());
			if(ts!=null){
				//符合原路退款的车票不允许退票、否则提示：该车票已超过退票日期限制，请使用【原路退款】功能进行退款操作！ add by tianhb 2018年6月14日 BEGIN
				if(null == ticketpriceReturnService){
					ticketpriceReturnService = new TicketpriceReturnServiceImpl();
				}	
				String msg = "该车票已经【原路退款】、不允许退票-票号:" + ts.getTicketno();
				if(ticketpriceReturnService.isCanReturnBack(ts)){
					if(ticketpriceReturnService.isExistTicketpriceReturn(ts.getId())){
						play.Logger.info(msg);
						throw new BusinessException(msg);
					}else{
						msg = "该车票已超过退票日期限制，请使用【原路退款】功能进行退款操作-票号:" + ts.getTicketno();
						play.Logger.info(msg);
						throw new BusinessException(msg);
					}
				}
				//符合原路退款的车票不允许退票、否则提示：该车票已超过退票日期限制，请使用【原路退款】功能进行退款操作！ add by tianhb 2018年6月14日 END
				if("E".equals(ts.getTickettype())){
	//				childReturnList.add(tr);
					childIdList.add(tr.getSellid());
					hasChild = true;
					iterator.remove();//移除儿童票
				}else{
					//主票id
					primaryIdList.add(ts.getId());
					insuranceMap.put(ts.getId(), tr.getIsreturninsure());
				}
			}
		}
		if(hasChild){
			//若存在儿童票，则需要判断是否勾选了了主票
			List<Object[]> childInfo = ticketdao.findQTicket(childIdList);
			if(childInfo != null && childInfo.size() > 0){
				for (Object[] child : childInfo) {
					if(!tsidStr.toString().contains(((BigDecimal)child[0]).longValue() + "")){
						//若勾选的票号中不存在某儿童票对应的主票，则不允许退票
						play.Logger.error("未勾选票号为" + ((String) child[1]) + "(儿童票)对应的主票，不允许单独退此儿童票！");
						throw new BusinessException(" 未勾选票号为" + ((String) child[1]) + "(儿童票)对应的主票，不允许单独退此儿童票！");
					}
				}
			}else{
				play.Logger.info("所退车票中不包含儿童票！");
			}
		}
		
		int printreturnnum=0;
		int returnticketnum=0;
		//对方车站机构id
		String startvoucherno = "0";
		BigDecimal totalreturnhandcharge = new BigDecimal(0);
		BigDecimal totalreturnmoney = new BigDecimal(0);
		
		//异站票需要提交到中心去退票
		List<TicketReturnInfo> tickets = new ArrayList<TicketReturnInfo>();
		//售联网中心的票需要提交到中心去退票
		List<TicketReturnInfo> opentickets = new ArrayList<TicketReturnInfo>();
		//跨区配客的要到中心去执行(仅本站售本站班次，且本站退时)
		List<TicketReturnInfo> tickets_worktype3 = new ArrayList<TicketReturnInfo>(); 
		
		String isMultiprint = parameterService.findParamValue(ParamterConst.Param_1108, global.getOrganization().getId());
		String param1110 = parameterService.findParamValue("1110", global.getOrganization().getId());
		String param1180 = parameterService.findParamValue("1180", global.getOrganization().getId());
		boolean isStationEpay = false; //是否窗口电子支付
		Long sellid = ticketreturns.get(0).getSellid();
		if(sellid>0){
			 ts = (Ticketsell) dao.get(Ticketsell.class, sellid);
			if(ts!=null){
				if("0".equals(ts.getSellway()) || "1".equals(ts.getSellway()) || "2".equals(ts.getSellway()) || "6".equals(ts.getSellway())){//售票途径
					if("1".equals(ts.getPaymethod()) || "4".equals(ts.getPaymethod()) || "5".equals(ts.getPaymethod())
							|| "10".equals(ts.getPaymethod()) || "11".equals(ts.getPaymethod())){//支付方式
						isStationEpay = true;
					}
				}
			}
		}
		//统计退票金额、打印退票凭证的数量
		for (Ticketreturn ticketreturn : ticketreturns) {
			if(ticketreturn.getIsreturnticket()){
				returnticketnum++;
//				totalreturnhandcharge = totalreturnhandcharge.add(ticketreturn.getCharges());
//				totalreturnmoney = totalreturnmoney.add(ticketreturn.getReturnamount());
				if(!"1".equals(ticketreturn.getReturnfeemode()))
				{
				totalreturnhandcharge = totalreturnhandcharge.add(ticketreturn.getCharges());
				totalreturnmoney = totalreturnmoney.add(ticketreturn.getReturnamount());
				}else{//原路返还
					 ts = (Ticketsell) dao.get(Ticketsell.class, ticketreturn.getSellid());
					if("1".equals(ticketreturn.getReturnfeemode())){
						//如果是网售原路返还，操作这两个字段
						if (ts.getSellway().equals("7") || ts.getSellway().equals("10")) {//自助机的操作同网售
							totalreturnChargesweb = totalreturnChargesweb.add(ticketreturn.getChargesweb());
							totalreturnReturnamountweb = totalreturnReturnamountweb.add(ticketreturn.getReturnamountweb());
						}
					}
				}
				if(ticketreturn.getCharges().floatValue()>0 || (ticketreturn.getChargesweb() !=null && ticketreturn.getChargesweb().floatValue()>0)){
					if(isMultiprint.equals(ParamterConst.COMMON_FLAG.FALG_YES)){
						printreturnnum=1;
					}else{
						printreturnnum++;
					}										
					if("0".equals(startvoucherno)){
						startvoucherno=ticketreturn.getReturnvoucherno();
					}
//					if ("1".equals(ticketreturn.getReturnfeemode())){//原路返还
//						totalreturnChargesweb = totalreturnChargesweb.add(ticketreturn.getChargesweb());
//						totalreturnReturnamountweb = totalreturnReturnamountweb.add(ticketreturn.getReturnamountweb());
//					}
				}else{
					//退票手续费为0是否打印退票凭证，0：不打印，1：打印
					if("1".equals(param1110) && (!"3".equals(ticketreturn.getReturnway()))){//并且不是3改签自动退
						if(isMultiprint.equals(ParamterConst.COMMON_FLAG.FALG_YES)){
							printreturnnum=1;
						}else{
							printreturnnum++;
						}										
						if("0".equals(startvoucherno)){
							startvoucherno=ticketreturn.getReturnvoucherno();
						}
					}
				}
			}
		}
		
		if(TestParams.getNewest().returnTicket == 1){
			SystemFactory.markRtException();
		}
		
		long opponentorgid = findRemoteCallList(ticketreturns,global.getOrganization().getId(), tickets, opentickets, tickets_worktype3);
		
		// 如果有售异站票退票，则提交到中心去执行退票
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

			Map<String, String> requestMap = new HashMap<String, String>();
			requestMap.put("remoteInvokeAuxiliaryProperty", JsonUtil.toFormatString(remoteInvokeAuxiliaryProperty));
			requestMap.put("tickets", JsonUtil.toFormatString(tickets));

			Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
			try{
				if(TestParams.getNewest().returnTicket == 2){
					SystemFactory.markRtException();
				}
				
				methodResult = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.RETURN_TICKETS, requestMap);		
				
			}catch(Exception e){
				//在连接异常的情况下，默认能成功.因此需要添加后台添加redo
				TransactionUtil.addReturnRemoteTicketRedo(requestMap, centreOrg.getServersaddress());
			}

			if(methodResult.getResult()!=MethodResult.SUCCESS){
				throw new Exception(methodResult.getResultMsg());
			}
			
		}

		// 如果有售联网中心票退票，则提交到中心去执行退票
		if(opentickets.size()>0){
			if(!CurrentUtil.isOpenApiable()){
				throw new Exception("当前OpenApi售票不可用");
			}
			MethodResult methodResult = new MethodResult();
			OpenApiAdapter openapi = new OpenApiAdapterImpl();
			methodResult = openapi.returnTicket(opentickets);
			
			if(methodResult.getResult()!=MethodResult.SUCCESS){
				throw new Exception(methodResult.getResultMsg());
			}
			
		}
		// 如果有跨区配客班次，则提交到中心去执行退票
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
			try{
				if(TestParams.getNewest().returnTicket == 2){
					SystemFactory.markRtException();
				}
				
				play.Logger.info("配载班次退票调用中心 begin------参数tickets=" + JsonUtil.toFormatString(tickets_worktype3));
				methodResult = RpcUtil.remoteMethodCall(RpcUtil.getRemoteIp(centreOrg.getId()), RemoteApi.SCHEDULE_RETURN_TICKET, requestMap);		
				play.Logger.info("配载班次退票调用中心 end------返回结果result=" + methodResult.getResult());
			
				if(methodResult.getResult()!=MethodResult.SUCCESS){
					throw new Exception(methodResult.getResultMsg());
				}
			}catch(Exception e){
				//在连接异常的情况下，默认能成功.因此需要添加后台添加redo
				TransactionUtil.addReturnScheduleTicketRedo(requestMap, centreOrg.getServersaddress());
			}
		}
		Date now = new Date();

		Vip vip = null;
		Vipconsume vipconsume = null;
		Ticketturnoverdetail ticketturnoverdetail=null;
		Map<Ticketreturn, Ticketsell> realReturnMap = new HashMap<Ticketreturn, Ticketsell>();//实际退票记录
		Billinventory billinventory = null;
		if(returnticketnum>0){
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			 ticketturnoverdetail = ticketturnoverdetailService.getCurTicketturnoverdetail(returnby, startvoucherno);
			//插入或修改应缴款表
			Billtype billtype = null;
			Billinuse billinuse = null;
			if(printreturnnum>0&& canprint && ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_1101, global.getOrganization().getId()))){
				String billtypecode = parameterService.findParamValue(ParamterConst.Param_1102, global.getOrganization().getId());
				if(startvoucherno!=null&&!startvoucherno.equals("0")){
					//判断当前票号是否正确
					billtype = getBilltypeService().findByCode(billtypecode);
					billinuse = billinuseService.jumpBillinuse(returnby,billtypecode,startvoucherno,printreturnnum);
					billinventory = (Billinventory) dao.get(Billinventory.class, billinuse.getBillinventoryid());
					if(billtypecode.equals("Ticket")){
						if("0".equals(ticketturnoverdetail.getTicketstartno())){
							ticketturnoverdetail.setTicketstartno(startvoucherno);
							if(billinventory!=null){
								ticketturnoverdetail.setBatchno(billinventory.getBatchno());
							}
							if(billinuse!=null){
								ticketturnoverdetail.setBillinuseid(billinuse.getId());
							}
						}
						ticketturnoverdetail.setTicketendno(StringUtils.strPad(new Long(new Long(startvoucherno)+printreturnnum-1).toString(),startvoucherno.length(), "0"));
						ticketturnoverdetail.setReturnprintnum(ticketturnoverdetail.getReturnprintnum()+printreturnnum);
					}
				}else{
					//TODO 异常  要打印，但没有传入起始票号
				}
			}
			//start 电子支付明细表
			Ticketturnoverdetailepay ticketturnoverdetailepay = null;
			int epayReturnNum = 0;
			double epayReturnMoney = 0;
			if(ticketreturns.size()>0 ){
				ticketturnoverdetailepay = getTicketturnoverdetailService().getCurTicketturnoverdetailepay(ticketturnoverdetail,returnby,"0");
				ticketturnoverdetailepay.setUpdateby(returnby);
				ticketturnoverdetailepay.setUpdatetime(new Date());
			}
			//end 电子支付明细表
			ticketturnoverdetail.setMoneypayable(ticketturnoverdetail.getMoneypayable().subtract(totalreturnmoney));
			ticketturnoverdetail.setReturnhandcharge(ticketturnoverdetail.getReturnhandcharge().add(totalreturnhandcharge));
			ticketturnoverdetail.setReturnmoney(ticketturnoverdetail.getReturnmoney().add(totalreturnmoney));
			ticketturnoverdetail.setChargesweb(ticketturnoverdetail.getChargesweb().add(totalreturnChargesweb)); 
			ticketturnoverdetail.setReturnamountweb(ticketturnoverdetail.getReturnamountweb().add(totalreturnReturnamountweb)); 
			//			ticketturnoverdetail.setReturnmoney(ticketturnoverdetail.getReturnmoney().add(totalreturnmoney));
			//窗口电子票
			if(isStationEpay){
				if("1".equals(param1180) && !"3".equals(ticketreturns.get(0).getReturnway()) ){//窗口电子票退票原路返还
					ticketturnoverdetail.setNoncashmoneypayable(ticketturnoverdetail.getNoncashmoneypayable().subtract(totalreturnmoney));
					ticketturnoverdetail.setEticketreturnbackcharge(ticketturnoverdetail.getEticketreturnbackcharge().add(totalreturnhandcharge));
					ticketturnoverdetail.setEticketreturnbackmoney(ticketturnoverdetail.getEticketreturnbackmoney().add(totalreturnmoney));
				}else{//窗口电子票退票车站垫付
					ticketturnoverdetail.setEticketreturncharge(ticketturnoverdetail.getEticketreturncharge().add(totalreturnhandcharge));
					ticketturnoverdetail.setEticketreturnmoney(ticketturnoverdetail.getEticketreturnmoney().add(totalreturnmoney));
				}
			}
			if("3".equals(ticketreturns.get(0).getReturnway()))
				ticketturnoverdetail.setChangenum(ticketturnoverdetail.getChangenum()+1);
			
			//退票
			long voucherno = 0;
			if(startvoucherno!=null&&!"0".equals(startvoucherno)){
				voucherno = new Long(startvoucherno);
			}

			boolean canReturnAfterChange = ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_1037, global.getOrganization().getId()));
			//加上团体票的废票记录
			List<Ticketreturn> ticketreturns_tuan = new ArrayList<Ticketreturn>();
			for (Ticketreturn ticketreturn : ticketreturns) {
				if(!ticketreturn.getIsreturnticket()){
					continue;
				}
				// 如果是售异站票或异站售本站票，则先存入一个List中，再一次提交到中心去执行退票
				if(ticketreturn.getIsselfschedule()){
					Ticketsell ticketsell = (Ticketsell) dao.get(LockModeType.PESSIMISTIC_READ,Ticketsell.class, ticketreturn.getSellid());
					if(ticketsell==null){
						throw new ServiceException("0175");
					}
					else if("1".equals(ticketsell.getTicketstatus())){
						returnticketnum--;
						continue;
//						throw new ServiceException("0176");
					}
					else if("2".equals(ticketsell.getTicketstatus())){
						throw new ServiceException("0177");
					}
					else if(ticketsell.getIschecked()){
						throw new ServiceException("0178");
					}
					else{
						ticketreturn.setPaymethod(ticketsell.getPaymethod());
						boolean isEPayReturn = false;
						//过滤掉自助机和网售的，只计算本站的电子支付
						//如果不是原路返还并且不是改签自动退  相当于站务的电子支付
						if(ticketreturn.getReturnmethod()==null){
							play.Logger.info("ticketreturn.getReturnmethod()=0");
							ticketreturn.setReturnmethod(new Long(0));
						}
						if(ticketsell.getReturnfeemode()==null){
							ticketsell.setReturnfeemode("0");
						}
						play.Logger.info("ticketsell.getReturnfeemode()="+ticketsell.getReturnfeemode()+",ticketsell.getTicketno()="+ticketsell.getTicketno());
						play.Logger.info("ticketreturn.getReturnfeemode()="+ticketreturn.getReturnfeemode()+",ticketreturn.getReturnmethod()="+ticketreturn.getReturnmethod());
						if (null != ticketreturn.getReturnfeemode() && !"".equals(ticketreturn.getReturnfeemode())) {
							if ("1".equals(ticketreturn.getReturnfeemode())
									&& (!ticketreturn.getReturnfeemode().equals(ticketsell.getReturnfeemode()))) {
								throw new BusinessException(" 退票和售票的原路返还状态不一致!不允许退票!");
							}
						}
						//处理团体票
						List<Ticketsell> ts_tuans = new ArrayList<Ticketsell>();
						List<Ticketreturn> ticketreturn_tuan = new ArrayList<Ticketreturn>();
						Long insuranceid=0L;
						List list = new ArrayList();
						ts_tuans.add(ticketsell);
						if("T".equals(ticketsell.getTickettype())){
							//查出所有其它团体车票
							List<PropertyFilter> propertyFilters2 = new ArrayList<PropertyFilter>();
							propertyFilters2.add(new PropertyFilter("EQD_t!departdate", ticketsell.getDepartdate()));
							propertyFilters2.add(new PropertyFilter("GTS_t!ticketno", ticketsell.getTicketno()));
							propertyFilters2.add(new PropertyFilter("EQS_t!tickettype", ticketsell.getTickettype()));
							/*20170105，禅道编号：4655，云南丘北汽车客运总站需求：团体票支持退其中部分车票
							StringBuilder sql = new StringBuilder("select t from Ticketsell t where t.ticketno like '")
												.append(ticketsell.getTicketno()).append("%'");
							ts_tuans.addAll(dao.find(sql.toString(), propertyFilters2));
							*/
							propertyFilters2.clear();
							propertyFilters2.add(new PropertyFilter("EQD_t!departdate", ticketsell.getDepartdate()));
							propertyFilters2.add(new PropertyFilter("EQS_t!tickettype", ticketsell.getTickettype()));
							
							ticketturnoverdetail.setReturnnum(ticketturnoverdetail.getReturnnum()+ts_tuans.size()-1);//团体票其它车票张数也要加上
							int tuanreturnnum = 0;
							if(isStationEpay){
								if("1".equals(param1180) && !"3".equals(ticketreturn.getReturnway()) ){//窗口电子票退票原路返还
									ticketturnoverdetail.setEticketreturnbacknum(ticketturnoverdetail.getEticketreturnbacknum()+ts_tuans.size()-1);
								}else{//窗口电子票退票车站垫付
									ticketturnoverdetail.setEticketreturnnum(ticketturnoverdetail.getEticketreturnnum()+ts_tuans.size()-1);
								}
							}
							for (Ticketsell ts_tuan : ts_tuans) {
								Ticketreturn _ticketreturn = new Ticketreturn();
//								_ticketreturn.setBatchno(batchno);
								_ticketreturn.setBilltype(billtype);
								//团体票不考虑是不是原路返还  如果走下面说明是站务的电子支付
								if(tuanreturnnum==0){
							    	_ticketreturn.setChargesweb(ticketreturn.getChargesweb());//窗口电子售票退票手续费
							    	_ticketreturn.setCharges(ticketreturn.getCharges());//现金手续费
								    _ticketreturn.setReturnamount(ts_tuan.getPrice().subtract(_ticketreturn.getCharges()));
								}else{
									_ticketreturn.setCharges(new BigDecimal(0));
									_ticketreturn.setChargesweb(new BigDecimal(0));
									_ticketreturn.setReturnamount(new BigDecimal(0));
								}
								if (ticketreturn.getIsreturninsure()){
								StringBuilder sqlinsurance = new StringBuilder("select i.id from Ticketsell t,Insurance i where i.sellid=t.id and t.id = "+ts_tuan.getId());
								list=dao.find(sqlinsurance.toString(), propertyFilters2);
								if (list!=null && list.size()>0){
									insuranceid = (Long) dao.find(sqlinsurance.toString(), propertyFilters2).get(0);
								}else{
									throw new Exception("未找到该保险票");
								}
								}
								
//								_ticketreturn.setCharges(ticketreturn.getCharges());//还原保存前端传过来的值
								_ticketreturn.setCreateby(ticketreturn.getCreateby());
								_ticketreturn.setCreatetime(ticketreturn.getCreatetime());
								_ticketreturn.setIsreturninsure(ticketreturn.getIsreturninsure());
//								_ticketreturn.setIsreturnticket(ticketreturn.getIsreturnticket());
								_ticketreturn.setIsselfschedule(ticketreturn.getIsselfschedule());
//								_ticketreturn.setOpertype(ticketreturn.getOpertype());
								_ticketreturn.setRemarks(ticketreturn.getRemarks());
//								_ticketreturn.setReturnamount(ts_tuan.getPrice().subtract(_ticketreturn.getCharges()));//还原
								_ticketreturn.setReturnby(ticketreturn.getReturnby());
//								_ticketreturn.setReturninsureid(ticketreturn.getReturninsureid());
								_ticketreturn.setReturninsureid(insuranceid);
								_ticketreturn.setRate(ticketreturn.getRate());//设置费率
								_ticketreturn.setReturnfeemode(ticketreturn.getReturnfeemode());
								_ticketreturn.setReturnip(ticketreturn.getReturnip());
								_ticketreturn.setReturntime(ticketreturn.getReturntime());
//								_ticketreturn.setReturnvoucherno(returnvoucherno);
								_ticketreturn.setReturnway(ticketreturn.getReturnway());
								_ticketreturn.setSellid(ts_tuan.getId());
								_ticketreturn.setTicketoutletsid(ticketreturn.getTicketoutletsid());
								_ticketreturn.setTicketprice(ts_tuan.getPrice());
								_ticketreturn.setPaymethod(ticketsell.getPaymethod());
//								_ticketreturn.setTurnoverdetailid(turnoverdetailid);
								ticketreturns_tuan.add(_ticketreturn);
								ticketreturn_tuan.add(_ticketreturn);
								tuanreturnnum++;
								realReturnMap.put(_ticketreturn, ts_tuan);//实际退票记录
							}
//							ticketreturns=ticketreturns_tuan;
						}else{
							realReturnMap.put(ticketreturn, ticketsell);//实际退票记录
							ticketreturns_tuan.add(ticketreturn);
							ticketreturn_tuan.add(ticketreturn);
						}

						//普通退票过了发车时间且没有签手续费的不允许退票
						if("0".equals(ticketreturn.getReturnway())){
							//判断是否签票
							propertyFilters.clear();
							propertyFilters.add(new PropertyFilter("EQL_t!sellid", ticketreturn.getSellid()));
							Ticketsign ticketsign = (Ticketsign) dao.uniqueResult(Ticketsign.class, propertyFilters);
							if(ticketsign==null){
								//判断发班状态
								propertyFilters.clear();
								propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketsell.getScheduleplanid()));
								propertyFilters.add(new PropertyFilter("EQL_t!departstationid",ticketsell.getDepartstationid()));
								Schedulestatus schedulestatus = (Schedulestatus) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Schedulestatus.class,propertyFilters);
								/*if(schedulestatus.getIsdeparted()){
									throw new ServiceException("0179"); //该车票所在的班次已经发班，不允许普通退票。请先签定手续费率或使用其它退票方式
								}*/
								//判断是否已经改签过
								if(!canReturnAfterChange){
									propertyFilters.clear();
									propertyFilters.add(new PropertyFilter("EQL_t!newticketsellid", ticketreturn.getSellid()));
									Ticketchange ticketchange = (Ticketchange) dao.uniqueResult(Ticketchange.class, propertyFilters);
									if(ticketchange!=null){
										throw new ServiceException("票号："+ticketsell.getTicketno(),"0372",true);
									}
								}

//取消发车时间判断，按设定的手续费率退票
//								//判断发车时间
//								//0265  该车票所在的班次已过发车时间，不允许普通退票。请先签定手续费率或使用其它退票方式
//								Calendar calendar_now = Calendar.getInstance();
//								Calendar calendar_departtime = Calendar.getInstance();
//								calendar_departtime.setTime(schedulestatus.getDepartdate());
//								calendar_departtime.set(calendar_departtime.get(Calendar.YEAR), 
//												calendar_departtime.get(Calendar.MONTH), 
//												calendar_departtime.get(Calendar.DAY_OF_MONTH), 
//												Integer.valueOf(schedulestatus.getDeparttime().substring(0,2)),
//												Integer.valueOf(schedulestatus.getDeparttime().substring(3)),
//												0);
//								if(calendar_now.after(calendar_departtime)){
//									throw new ServiceException("0265"); //该车票所在的班次已过发车时间，不允许普通退票。请先签定手续费率或使用其它退票方式
//								}
							}
						}
						
						for (Ticketsell ts_tuan : ts_tuans) {
							ts_tuan.setTicketstatus("1"); //退票
							ts_tuan.setUpdateby(global.getUserinfo().getId());
							ts_tuan.setUpdatetime(now);
							dao.merge(ts_tuan);							
						}
						//若是现金则相应较少营收
//						if(ticketsell.getPaymethod().equals("0")&&"0".equals(ticketreturn.getReturnfeemode())){
						if(("7".equals(ticketsell.getSellway())||("10".equals(ticketsell.getSellway()))) && "1".equals(ticketreturn.getReturnfeemode())){
							//网售原路返还 在下面returnWebMode1方法处理
						}else {
							//退票员的缴款记录
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
						if(isEPayReturn || ticketsell.getPaymethod().equals("0")){//窗口电子支付
							//支付明细统计现金退票金额以及数量
							int eReturnNum = ts_tuans.size()==0?1:ts_tuans.size();
							epayReturnNum = epayReturnNum + eReturnNum;
							epayReturnMoney = epayReturnMoney + ticketreturn.getReturnamount().doubleValue();
						}
						Scheduleplan scheduleplan = (Scheduleplan) dao.get(LockModeType.PESSIMISTIC_READ,Scheduleplan.class, ticketsell.getScheduleplanid());
//						if(!ticketsell.getIslinework()
						if(!scheduleplan.getIslinework()            //以班次计划中的是否流水班为准  
//							&&!"2".equals(scheduleplan.getWorktype())
							&&!"3".equals(scheduleplan.getWorktype())){
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
								scheduleseat.setUpdateby(returnby);
								scheduleseat.setUpdatetime(now);
								dao.merge(scheduleseat);
							}
						}

						//锁定班次并更新剩余票数
						scheduleplan.setSoldeatnum((short) (scheduleplan.getSoldeatnum()-ts_tuans.size()));
						for (Ticketsell ts_tuan : ts_tuans) {
							scheduleplan.setCarrychildnum((short) (scheduleplan.getCarrychildnum()-ts_tuan.getCarrychildnum()));
						}
						scheduleplan.setUpdateby(returnby);
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

						for (Ticketreturn _ticketreturn : ticketreturn_tuan) {
							if(printreturnnum>0&&canprint && ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_1101, global.getOrganization().getId()))
									){//&&(ticketreturn.getCharges().floatValue()>0 || ticketreturn.getChargesweb().floatValue()>0) 只要打单就保存
								if(printreturnnum==1){
									//合并打印
									_ticketreturn.setReturnvoucherno(StringUtils.strPad(new Long(voucherno).toString(),startvoucherno.length(), "0"));
								}else{
									_ticketreturn.setReturnvoucherno(StringUtils.strPad(new Long(voucherno++).toString(),startvoucherno.length(), "0"));
								}	
								_ticketreturn.setBilltype(billtype);
								if(billinventory != null){//参数1110设置：手续费为0且不打印凭证时，则不获取billinventory，即为null
									_ticketreturn.setBatchno(billinventory.getBatchno());
								}
							}
							else{
								_ticketreturn.setReturnvoucherno(null);
								_ticketreturn.setBilltype(null);
							}
						}
						Organization sellorg = (Organization) dao.get(Organization.class, ticketsell.getOrgid());
						if(ticketsell.getTicketoutletsid()==0){
							//异站售本站票
							opponentorgid=ticketsell.getOrgid();
							//如果是售票公司售出的车票  不连到中心去退票，通过同步上传
							if(!"0".equals(sellorg.getType())
								&&!"7".equals(sellorg.getType())
								&&!"8".equals(sellorg.getType())
								&&!sellorg.getIslocal()){
								TicketReturnInfo ticketReturnInfo = new TicketReturnInfo();
								ticketReturnInfo.setBatchno(ticketsell.getBatchno());
								ticketReturnInfo.setTicketno(ticketsell.getTicketno());
								ticketReturnInfo.setIsselfschedule(false);
								ticketReturnInfo.setRemarks(ticketreturn.getRemarks());
								
								ticketReturnInfo.setCharges(ticketreturn.getCharges());
								ticketReturnInfo.setReturnbatchno(ticketreturn.getBatchno());
								ticketReturnInfo.setReturnBilltypecode(ticketreturn.getBilltype()==null?null:ticketreturn.getBilltype().getCode());
								ticketReturnInfo.setReturnvoucherno(ticketreturn.getReturnvoucherno());
								tickets.add(ticketReturnInfo);
							}
						}
						else{
							//0现金、1银联卡、2贵客卡余额、3贵客卡积分
							if("2".equals(ticketsell.getPaymethod())||"3".equals(ticketsell.getPaymethod())){
								ticketturnoverdetail.setNonvouchermoneypayable(ticketturnoverdetail.getNonvouchermoneypayable().subtract(ticketreturn.getReturnamount()));
							}
						}
						//是跨区配客班次且没有加到tickets中，要加到tickets_worktype3中
						if("3".equals(scheduleplan.getWorktype())
							&&("0".equals(sellorg.getType())     
								||"7".equals(sellorg.getType())
								||"8".equals(sellorg.getType())
								||sellorg.getIslocal()
								)
							){
							TicketReturnInfo ticketReturnInfo = new TicketReturnInfo();
							ticketReturnInfo.setBatchno(ticketsell.getBatchno());
							ticketReturnInfo.setTicketno(ticketsell.getTicketno());
							ticketReturnInfo.setIsselfschedule(false);
							ticketReturnInfo.setRemarks(ticketreturn.getRemarks());
							//若是电子票
							if(ticketsell.getSellway().equals("7")){
								propertyFilters.clear();
								propertyFilters.add(new PropertyFilter("EQL_t!ticketsellid", ticketsell.getId()));
								Ticketsellother tsk = (Ticketsellother) dao.uniqueResult(Ticketsellother.class, propertyFilters);
								if(tsk!=null){
									ticketReturnInfo.setEticketid(tsk.getEticketid());
									ticketReturnInfo.setEticketno(tsk.getEticketno());
								}
							}
							ticketReturnInfo.setSchplansynccode(scheduleplan.getSynccode());
							ticketReturnInfo.setCharges(ticketreturn.getCharges());
							ticketReturnInfo.setReturnbatchno(ticketreturn.getBatchno());
							ticketReturnInfo.setReturnBilltypecode(ticketreturn.getBilltype()==null?null:ticketreturn.getBilltype().getCode());
							ticketReturnInfo.setReturnvoucherno(ticketreturn.getReturnvoucherno());
							tickets_worktype3.add(ticketReturnInfo);
							if(!ticketsell.getIslinework()){
								//检查座位状态
								propertyFilters.clear();
								propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketsell.getScheduleplanid()));
								propertyFilters.add(new PropertyFilter("EQR_t!seatno", ticketsell.getSeatno()));
								Scheduleseats scheduleseat = (Scheduleseats) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleseats.class, propertyFilters);
								if(scheduleseat==null){
											//回滚
									throw new ServiceException("票号"+ticketsell.getTicketno(),"0204",true); //班次座位记录不存在	
								}
								else if(!"2".equals(scheduleseat.getStatus())){
									//throw new ServiceException("票号"+ticketsell.getTicketno(),"0263",true); //座位不是售出状态
								}
								scheduleseat.setStatus("0");
								scheduleseat.setTickettype(null);
								scheduleseat.setUpdateby(returnby);
								scheduleseat.setUpdatetime(now);
								dao.merge(scheduleseat);
							}

						}
						//判断是否属于VIP卡余额支付
						if(ticketsell.getPaymethod().equals("2")){
							if(vipcardno!=null){
								vip = vipconsumeService.getConsumeVip(true, ticketsell.getId());
								if(vip == null){
									//异站售本站票时，本站没有产生消费记录，无法查出VIP信息
									vip = vipService.findByCustomerID(ticketsell.getCustomer().getId(),"0");
									//vip = vipService.findByCardNo(vipcardno,"0");
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
									vipconsume.setCreateby(returnby);
									vipconsume.setCreatetime(now);
									vipconsume.setUpdateby(vipconsume.getCreateby());
									vipconsume.setUpdatetime(vipconsume.getCreatetime());
									vipconsume.setType("1"); //余额购票后退票
									vipconsume.setMoneychange(totalreturnmoney);
									vipconsume.setRemainmoney(vip.getMoney().add(vipconsume.getMoneychange()));
									vipconsume.setPointchange(totalreturnmoney.multiply(new BigDecimal(-1)));
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
							vipconsumeldetail.setCreateby(returnby);
							vipconsumeldetail.setCreatetime(now);
							vipconsumeldetail.setIsselfschedule(true);
							vipconsumeldetail.setSellid(ticketsell.getId());
							vipconsumeldetail.setVipconsume(vipconsume);
							vipconsume.getVipconsumeldetails().add(vipconsumeldetail);
						}
					}
				}
				else{
					ticketreturns_tuan.add(ticketreturn);
					//本地退售异站票
					Ticketsellagent ticketsellagent = (Ticketsellagent) dao.get(LockModeType.PESSIMISTIC_READ,Ticketsellagent.class, ticketreturn.getSellid());
					if(ticketsellagent==null){
						throw new ServiceException("0175");
					}
					else if("1".equals(ticketsellagent.getTicketstatus())){
						returnticketnum--;
						continue;
//						throw new ServiceException("0176");
					}
					else if("2".equals(ticketsellagent.getTicketstatus())){
						throw new ServiceException("0177");
					}
					else{
						//0现金、1银联卡、2贵客卡余额、3贵客卡积分
						if("2".equals(ticketsellagent.getPaymethod())||"3".equals(ticketsellagent.getPaymethod())){
							ticketturnoverdetail.setNonvouchermoneypayable(ticketturnoverdetail.getNonvouchermoneypayable().subtract(ticketreturn.getReturnamount()));
						}

						ticketsellagent.setTicketstatus("1"); //退票
						ticketsellagent.setUpdateby(returnby);
						ticketsellagent.setUpdatetime(now);
						dao.merge(ticketsellagent);
						//若是现金则相应较少营收
//						if(ticketsellagent.getPaymethod().equals("0")&&"0".equals(ticketreturn.getReturnfeemode())){
						if(("7".equals(ticketsellagent.getSellway())||("10".equals(ticketsellagent.getSellway()))) && "1".equals(ticketreturn.getReturnfeemode())){
							//网售原路返还 在下面returnWebMode1方法处理
						}else {
							ticketturnoverdetail.setFueladditionfee(ticketturnoverdetail.getFueladditionfee().subtract(ticketsellagent.getFueladditionfee()));
							ticketturnoverdetail.setStationservicefee(ticketturnoverdetail.getStationservicefee());  //.subtract(ticketsellagent.getStationservicefee())
							ticketturnoverdetail.setComputefee(ticketturnoverdetail.getComputefee().subtract(ticketsellagent.getComputefee()));
							ticketturnoverdetail.setCoolairfee(ticketturnoverdetail.getCoolairfee().subtract(ticketsellagent.getCoolairfee()));
							ticketturnoverdetail.setAdditionfee(ticketturnoverdetail.getAdditionfee().subtract(ticketsellagent.getAdditionfee()));
							ticketturnoverdetail.setWaterfee(ticketturnoverdetail.getWaterfee().subtract(ticketsellagent.getWaterfee()));
							ticketturnoverdetail.setInsurefee(ticketturnoverdetail.getInsurefee().subtract(ticketsellagent.getInsurefee()));
							ticketturnoverdetail.setOtherfee(ticketturnoverdetail.getOtherfee().subtract(ticketsellagent.getOtherfee()));
						}
						if(canprint && ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_1101, global.getOrganization().getId()))&&ticketreturn.getCharges().floatValue()>0){
							ticketreturn.setReturnvoucherno(StringUtils.strPad(new Long(voucherno++).toString(),startvoucherno.length(), "0"));
							ticketreturn.setBilltype(billtype);
							ticketreturn.setBatchno(billinventory.getBatchno());
						}
						else{
							ticketreturn.setReturnvoucherno(null);
							ticketreturn.setBilltype(null);
						}
						opponentorgid=ticketsellagent.getOrgid();
						TicketReturnInfo ticketReturnInfo = new TicketReturnInfo();
						ticketReturnInfo.setBatchno(ticketsellagent.getBatchno());
						ticketReturnInfo.setTicketno(ticketsellagent.getTicketno());
						ticketReturnInfo.setIsselfschedule(true);
						ticketReturnInfo.setRemarks(ticketreturn.getRemarks());
						
						ticketReturnInfo.setCharges(ticketreturn.getCharges());
						ticketReturnInfo.setReturnbatchno(ticketreturn.getBatchno());
						if(ticketreturn.getBilltype()==null){
							ticketReturnInfo.setReturnBilltypecode(null);
						}
						else{
							ticketReturnInfo.setReturnBilltypecode(ticketreturn.getBilltype().getCode());
						}
						ticketReturnInfo.setReturnvoucherno(ticketreturn.getReturnvoucherno());
						tickets.add(ticketReturnInfo);
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
									vipconsume.setCreateby(returnby);
									vipconsume.setCreatetime(now);
									vipconsume.setUpdateby(vipconsume.getCreateby());
									vipconsume.setUpdatetime(vipconsume.getCreatetime());
									vipconsume.setType("1"); //余额购票后退票
									vipconsume.setMoneychange(totalreturnmoney);
									vipconsume.setRemainmoney(vip.getMoney().add(vipconsume.getMoneychange()));
									vipconsume.setPointchange(totalreturnmoney.multiply(new BigDecimal(-1)));
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
							vipconsumeldetail.setCreateby(returnby);
							vipconsumeldetail.setCreatetime(now);
							vipconsumeldetail.setIsselfschedule(false);
							vipconsumeldetail.setSellid(ticketsellagent.getId());
							vipconsumeldetail.setVipconsume(vipconsume);
							vipconsume.getVipconsumeldetails().add(vipconsumeldetail);
							
						}
					}
				}
			}
			
			ticketturnoverdetail.setUpdateby(returnby);
			ticketturnoverdetail.setUpdatetime(now);
			ticketturnoverdetail.setReturnnum(ticketturnoverdetail.getReturnnum()+returnticketnum+childTicketList.size());
//			ticketturnoverdetail.setReturnnum(ticketturnoverdetail.getReturnnum()+returnticketnum + childIdList.size());//退票加上退儿童票张数
			if(isStationEpay){
				if("1".equals(param1180) && !"3".equals(ticketreturns.get(0).getReturnway()) ){//窗口电子票退票原路返还
					ticketturnoverdetail.setEticketreturnbacknum(ticketturnoverdetail.getEticketreturnbacknum()+returnticketnum+childTicketList.size());
				}else{//窗口电子票退票车站垫付
					ticketturnoverdetail.setEticketreturnnum(ticketturnoverdetail.getEticketreturnnum()+returnticketnum+childTicketList.size());
				}
			}
			ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);	
			for (Ticketreturn ticketreturn : ticketreturns_tuan) {
				ticketreturn.setCreateby(global.getUserinfo().getId());
				ticketreturn.setCreatetime(now);
				ticketreturn.setUpdateby(global.getUserinfo().getId());
				ticketreturn.setUpdatetime(now);
				ticketreturn.setReturnby(global.getUserinfo().getId());
				ticketreturn.setReturntime(now);
				ticketreturn.setReturnip(global.getIpAddress());
				if(!(ticketreturn.getIsselfschedule()&&ticketreturn.getTicketoutletsid()==0)){
					//非异站售本站票（本站售本站、本站售异站）
					ticketreturn.setTurnoverdetailid(ticketturnoverdetail.getId());
				}
				if(isStationEpay){//窗口电子票
					if("1".equals(param1180) && !"3".equals(ticketreturns.get(0).getReturnway()) ){//窗口电子票退票原路返还
						ticketreturn.setReturnfeemode("1");//原路返还
					}else{
						ticketreturn.setReturnfeemode("0");//车站垫付
					}
					ticketreturn.setReturnmethod(0L);
				}
				if(!"3".equals(ticketreturns.get(0).getReturnway())&&ticketreturn.getCharges().compareTo(new BigDecimal(0))==0 &&
				   ticketreturn.getChargesweb().compareTo(new BigDecimal(0))==0){
					ticketreturn.setReturnway("1");//责任退票
					ticketreturn.setRemarks("责任退票");
				}
				ticketreturnDao.merge(ticketreturn);
			}
			
			if(vipconsume!=null){
				dao.merge(vipconsume);
			}
			trInfo = ticketreturns_tuan.get(0);
			
			//returnWebMode1方法中查询处理Ticketreturn tr记录，需flush一下，否则Ticketreturn查出结果为null
			ticketreturnDao.getEntityManager().flush();
			//处理退网售原路返还车票：退票张数、金额、手续费记到网售用户头上
			if(realReturnMap.size() > 0){
				returnWebMode1(ticketturnoverdetail, realReturnMap);
			}
			
			//支付明细
			if(ticketturnoverdetailepay!=null){
				ticketturnoverdetailepay.setPrice(ticketturnoverdetailepay.getPrice()-epayReturnMoney);
				ticketturnoverdetailepay.setTicketnum(ticketturnoverdetailepay.getTicketnum()-epayReturnNum);
				if(ticketturnoverdetailepay.getTicketturnoverdetailid()==null){
					ticketturnoverdetailepay.setTicketturnoverdetailid(ticketturnoverdetail.getId());
				}
				if(epayReturnMoney>0 || epayReturnNum>0){
					dao.merge(ticketturnoverdetailepay);
				}
			}

		}
		if(null != trInfo){
			saveChildTicketReturn(childTicketList, trInfo);	
		}
		
		
		//退保险
		insurancereturnService.returnInsuranceAtreturnTicket(ticketreturns, global);
		if(TestParams.getNewest().returnTicket == 3){
			SystemFactory.markRtException();
		}
		dao.getEntityManager().flush();
		return true;
	}
	/**
	 * 保存儿童票退票信息
	 * @param childTicketList：儿童票
	 * @param trInfo：主票信息
	 */
	private void saveChildTicketReturn(List<Ticketsell> childTicketList, Ticketreturn trInfo) throws Exception {
		for (Ticketsell childTicket : childTicketList) {
			Ticketreturn ticketreturn = new Ticketreturn();
			ticketreturn.setIsselfschedule(true);
			ticketreturn.setSellid(childTicket.getId());
			ticketreturn.setTicketprice(childTicket.getPrice());
			ticketreturn.setCharges(BigDecimal.ZERO);
			ticketreturn.setReturnamount(BigDecimal.ZERO);
			ticketreturn.setTurnoverdetailid(trInfo.getTurnoverdetailid());
			ticketreturn.setBilltype(null);
			ticketreturn.setReturnvoucherno("--");
			ticketreturn.setReturnby(trInfo.getReturnby());
			ticketreturn.setReturntime(trInfo.getReturntime());
			ticketreturn.setReturnip(trInfo.getReturnip());
			ticketreturn.setTicketoutletsid(trInfo.getTicketoutletsid());
			ticketreturn.setReturnway(trInfo.getReturnway());
			ticketreturn.setRemarks("儿童票随主票自动退票");
			ticketreturn.setCreatetime(trInfo.getCreatetime());
			ticketreturn.setCreateby(trInfo.getCreateby());
			ticketreturn.setUpdateby(trInfo.getUpdateby());
			ticketreturn.setUpdatetime(trInfo.getUpdatetime());
			ticketreturn.setBatchno("");
			ticketreturn.setReturnamountweb(BigDecimal.ZERO);
			ticketreturn.setChargesweb(BigDecimal.ZERO);
			ticketreturn.setReturnmethod(trInfo.getReturnmethod());
			ticketreturn.setRate(BigDecimal.valueOf(0.00));
			ticketreturn.setReturnfeemode(trInfo.getReturnfeemode());
			dao.merge(ticketreturn);
		}
	}
	/**
	 * 处理退网售原路返还车票：退票张数、金额、手续费记到网售用户头上
	 * @param ticketturnoverdetail：车站窗口退票员缴款明细
	 * @param realReturnMap：退票记录
	 * @throws BusinessException
	 */
	private void returnWebMode1(Ticketturnoverdetail ticketTurnoverDetail,Map<Ticketreturn, Ticketsell> realReturnMap) throws BusinessException{
		long sellOrgId = 0;//网售机构
		int returnNumWeb = 0; //退网售原路返还车票张数
		long sellbyWeb = 0L;
		List<Long> returnTicketIdList = new ArrayList<Long>();//退网售原路返还车票id
		BigDecimal returnTotalPriceWeb = BigDecimal.ZERO; //退网售原路返还车票总票款
		BigDecimal returnChargeweb = BigDecimal.ZERO; //退网售原路返还车票手续费
		BigDecimal returnAmountWeb = BigDecimal.ZERO; //退网售原路返还车票退票款
		BigDecimal stationservicefeeWeb = BigDecimal.ZERO; //站务费
		BigDecimal fueladditionfeeWeb = BigDecimal.ZERO;
		
		BigDecimal computefeeWeb = BigDecimal.ZERO;
		BigDecimal coolairfeeWeb = BigDecimal.ZERO;
		BigDecimal additionfeeWeb = BigDecimal.ZERO;
		BigDecimal waterfeeWeb = BigDecimal.ZERO;
		BigDecimal insurefeeWeb = BigDecimal.ZERO;
		BigDecimal otherfeeWeb = BigDecimal.ZERO;
		//获取各字段金额
		for (Entry<Ticketreturn, Ticketsell> entry : realReturnMap.entrySet()) {
			if(("7".equals(entry.getValue().getSellway())||("10".equals(entry.getValue().getSellway()))) && "1".equals(entry.getValue().getReturnfeemode())){
				if(sellOrgId != 0 && sellOrgId != entry.getValue().getOrgid()){
					throw new BusinessException("不可同时退多个网售机构售出的原路返还车票！");
				}else{
					sellOrgId = entry.getValue().getOrgid();
				}
				returnNumWeb ++;//网售原路返还数
				sellbyWeb = entry.getValue().getSellby();//售票人
				returnTicketIdList.add(entry.getValue().getId());//车票id
				returnTotalPriceWeb = returnTotalPriceWeb.add(entry.getValue().getPrice());//总票款
				returnChargeweb = returnChargeweb.add(entry.getKey().getChargesweb());//手续费
				returnAmountWeb = returnAmountWeb.add(entry.getValue().getPrice().subtract(entry.getKey().getChargesweb()));// 退票款
				stationservicefeeWeb = stationservicefeeWeb.add(entry.getValue().getStationservicefee()); //站务费
				fueladditionfeeWeb = fueladditionfeeWeb.add(entry.getValue().getFueladditionfee());
				computefeeWeb = computefeeWeb.add(entry.getValue().getComputefee());
				coolairfeeWeb = coolairfeeWeb.add(entry.getValue().getCoolairfee());
				additionfeeWeb = additionfeeWeb.add(entry.getValue().getAdditionfee());
				waterfeeWeb = waterfeeWeb.add(entry.getValue().getWaterfee());
				insurefeeWeb = insurefeeWeb.add(entry.getValue().getInsurefee());
				otherfeeWeb = otherfeeWeb.add(entry.getValue().getOtherfee());
			}
		}
		
		//处理网售原路返还车票
		if (returnTicketIdList.size() > 0) {
			//窗口售票员营收缴款记录
			play.Logger.info("窗口退网售原路返还，退票员营收缴款记录before初始值：" + JsonUtil.toSimpleString(ticketTurnoverDetail));
			ticketTurnoverDetail.setReturnnum(ticketTurnoverDetail.getReturnnum() - returnNumWeb);//退票数
			ticketTurnoverDetail.setChargesweb(ticketTurnoverDetail.getChargesweb().subtract(returnChargeweb));//原路返还手续费
			ticketTurnoverDetail.setReturnamountweb(ticketTurnoverDetail.getReturnamountweb().subtract(returnAmountWeb));//原路返还退票款
			//由于前面退票逻辑进行了修改，故修改此处，具体为：上面对网售、自助机原路返还的车票未在退票员缴款明细中增加这把项费用。
			//ticketTurnoverDetail.setStationservicefee(ticketTurnoverDetail.getStationservicefee().add(stationservicefeeWeb));
			//ticketTurnoverDetail.setFueladditionfee(ticketTurnoverDetail.getFueladditionfee().add(fueladditionfeeWeb));
			//ticketTurnoverDetail.setComputefee(ticketTurnoverDetail.getComputefee().add(computefeeWeb));
			//ticketTurnoverDetail.setCoolairfee(ticketTurnoverDetail.getCoolairfee().add(coolairfeeWeb));
			//ticketTurnoverDetail.setAdditionfee(ticketTurnoverDetail.getAdditionfee().add(additionfeeWeb));
			//ticketTurnoverDetail.setWaterfee(ticketTurnoverDetail.getWaterfee().add(waterfeeWeb));
			//ticketTurnoverDetail.setInsurefee(ticketTurnoverDetail.getInsurefee().add(insurefeeWeb));
			//ticketTurnoverDetail.setOtherfee(ticketTurnoverDetail.getOtherfee().add(otherfeeWeb));
			dao.merge(ticketTurnoverDetail);
			play.Logger.info("窗口退网售原路返还，退票员营收缴款记录after结果：" + JsonUtil.toSimpleString(ticketTurnoverDetail));
			
			//网售机构营收缴款记录
			Ticketturnoverdetail turnoverDetailWeb = ticketturnoverdetailService
					.getCurTicketturnoverdetail(sellbyWeb, null);
			play.Logger.info("窗口退网售原路返还，网售sellby营收缴款记录before初始值：" + JsonUtil.toSimpleString(turnoverDetailWeb));
			turnoverDetailWeb.setMoneypayable(turnoverDetailWeb.getMoneypayable().subtract(returnAmountWeb));//总应缴款
			turnoverDetailWeb.setReturnnum(turnoverDetailWeb.getReturnnum() + returnNumWeb);//总退票数
			turnoverDetailWeb.setReturnmoney(turnoverDetailWeb.getReturnmoney().add(returnAmountWeb));//总退票款
			turnoverDetailWeb.setReturnhandcharge(turnoverDetailWeb.getReturnhandcharge().add(returnChargeweb));//总退票手续费
			//turnoverDetailWeb.setNoncashmoneypayable(turnoverDetailWeb.getNoncashmoneypayable().subtract(returnAmountWeb));//电子支付应缴款总和
			//turnoverDetailWeb.setEticketreturnbacknum(turnoverDetailWeb.getEticketreturnbacknum() + returnNumWeb);//电子票原路返还退票数
			//turnoverDetailWeb.setEticketreturnbackmoney(turnoverDetailWeb.getEticketreturnbackmoney().add(returnAmountWeb));//电子票原路返还退票手续费
			//turnoverDetailWeb.setEticketreturnbackcharge(turnoverDetailWeb.getEticketreturncharge().add(returnChargeweb));//电子票原路返还退票金额
			//网售原路返还张数未记，缴款明细表暂不存在该字段
			turnoverDetailWeb.setChargesweb(turnoverDetailWeb.getChargesweb().add(returnChargeweb));//网售原路返还手续费
			turnoverDetailWeb.setReturnamountweb(turnoverDetailWeb.getReturnamountweb().add(returnAmountWeb));//网售原路返还退票金额
			//turnoverDetailWeb.setReturnnumweb(turnoverDetailWeb.getReturnnumweb() + returnNumWeb);//网售原路返还退票张数
			//八大费
			turnoverDetailWeb.setStationservicefee(turnoverDetailWeb.getStationservicefee().subtract(stationservicefeeWeb));
			turnoverDetailWeb.setFueladditionfee(turnoverDetailWeb.getFueladditionfee().subtract(fueladditionfeeWeb));
			turnoverDetailWeb.setComputefee(turnoverDetailWeb.getComputefee().subtract(computefeeWeb));
			turnoverDetailWeb.setCoolairfee(turnoverDetailWeb.getCoolairfee().subtract(coolairfeeWeb));
			turnoverDetailWeb.setAdditionfee(turnoverDetailWeb.getAdditionfee().subtract(additionfeeWeb));
			turnoverDetailWeb.setWaterfee(turnoverDetailWeb.getWaterfee().subtract(waterfeeWeb));
			turnoverDetailWeb.setInsurefee(turnoverDetailWeb.getInsurefee().subtract(insurefeeWeb));
			turnoverDetailWeb.setOtherfee(turnoverDetailWeb.getOtherfee().subtract(otherfeeWeb));
			turnoverDetailWeb = (Ticketturnoverdetail) dao.merge(turnoverDetailWeb);
			play.Logger.info("窗口退网售原路返还，网售sellby营收缴款记录after初始值：" + JsonUtil.toSimpleString(turnoverDetailWeb));
			
			//修改退票记录
			List<PropertyFilter> filter = new ArrayList<PropertyFilter>();
			for(Long tkId : returnTicketIdList){
				filter.clear();
				filter.add(new PropertyFilter("EQL_t!sellid", tkId));
				Ticketreturn tr = (Ticketreturn) dao.uniqueResult(Ticketreturn.class, filter);
				tr.setReturnby(sellbyWeb);
				tr.setTurnoverdetailid(turnoverDetailWeb.getId());
				dao.merge(tr);
				play.Logger.info("窗口退网售原路返还车票：" + JsonUtil.toSimpleString(tr));
			}
		}
	}
	
	
	/**
	 * 异售本改签为本地票时，将原售票站的车票状态改为改签，并记录改签信息
	 */
	@Override
	public boolean changeOtherSellLocalTickets(
			List<Ticketreturn> ticketreturns, Ticketchange ticketchange, Global global, String vipcardno,
			String vipgrade, BigDecimal vipmoney, BigDecimal vippoint,
			boolean canprint) throws Exception {
		int printreturnnum=0;
		int returnticketnum=0;
		//对方车站机构id
		String startvoucherno = "0";
		BigDecimal totalreturnhandcharge = new BigDecimal(0);
		BigDecimal totalreturnmoney = new BigDecimal(0);
		
		//异站票需要提交到中心去退票
		List<TicketReturnInfo> tickets = new ArrayList<TicketReturnInfo>();
		//售联网中心的票需要提交到中心去退票
		List<TicketReturnInfo> opentickets = new ArrayList<TicketReturnInfo>();
		//跨区配客的要到中心去执行(仅本站售本站班次，且本站退时)
		List<TicketReturnInfo> tickets_worktype3 = new ArrayList<TicketReturnInfo>(); 
		
		String isMultiprint = parameterService.findParamValue(ParamterConst.Param_1108, global.getOrganization().getId());
		
		//统计退票金额、打印退票凭证的数量
		for (Ticketreturn ticketreturn : ticketreturns) {
			if(ticketreturn.getIsreturnticket()){
				returnticketnum++;
				totalreturnhandcharge = totalreturnhandcharge.add(ticketreturn.getCharges());
				totalreturnmoney = totalreturnmoney.add(ticketreturn.getReturnamount());
				if(ticketreturn.getCharges().floatValue()>0){
					if(isMultiprint.equals(ParamterConst.COMMON_FLAG.FALG_YES)){
						printreturnnum=1;
					}else{
						printreturnnum++;
					}										
					if("0".equals(startvoucherno)){
						startvoucherno=ticketreturn.getReturnvoucherno();
					}
				}
			}
		}
		
		if(TestParams.getNewest().returnTicket == 1){
			SystemFactory.markRtException();
		}
		
		//opentickets, tickets_worktype3, tickets:为原票信息
		long opponentorgid = findRemoteCallList(ticketreturns,global.getOrganization().getId(), tickets, opentickets, tickets_worktype3);
		
		// 如果有售异站票退票，则提交到中心去执行退票
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

			Map<String, String> requestMap = new HashMap<String, String>();
			requestMap.put("remoteInvokeAuxiliaryProperty", JsonUtil.toFormatString(remoteInvokeAuxiliaryProperty));
			requestMap.put("tickets", JsonUtil.toFormatString(tickets));
			requestMap.put("ticketchange", JsonUtil.toFormatString(ticketchange));

			Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
			try{
				if(TestParams.getNewest().returnTicket == 2){
					SystemFactory.markRtException();
				}
				
				//异售本改签为本地票时，将原售票站的车票状态改为改签，并记录改签信息
				methodResult = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.CHANGE_TICKETS_O2L, requestMap);		
				
			}catch(Exception e){
				//在连接异常的情况下，默认能成功.因此需要添加后台添加redo
				TransactionUtil.addReturnRemoteTicketRedo(requestMap, centreOrg.getServersaddress());
			}

			if(methodResult.getResult()!=MethodResult.SUCCESS){
				throw new Exception(methodResult.getResultMsg());
			}
			
		}

		// 如果有售联网中心票退票，则提交到中心去执行退票
		if(opentickets.size()>0){
			if(!CurrentUtil.isOpenApiable()){
				throw new Exception("当前OpenApi售票不可用");
			}
			MethodResult methodResult = new MethodResult();
			OpenApiAdapter openapi = new OpenApiAdapterImpl();
			methodResult = openapi.returnTicket(opentickets);
			
			if(methodResult.getResult()!=MethodResult.SUCCESS){
				throw new Exception(methodResult.getResultMsg());
			}
			
		}
		// 如果有跨区配客班次，则提交到中心去执行退票
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
			try{
				if(TestParams.getNewest().returnTicket == 2){
					SystemFactory.markRtException();
				}
				
//				methodResult = RpcUtil.remoteMethodCall(RpcUtil.getRemoteIp(centreOrg.getId()), RemoteApi.SCHEDULE_RETURN_TICKET, requestMap);		
				methodResult = RpcUtil.remoteMethodCall(RpcUtil.getRemoteIp(centreOrg.getId()), RemoteApi.SCHEDULE_CHANGE_TICKET, requestMap);		
			
				if(methodResult.getResult()!=MethodResult.SUCCESS){
					throw new Exception(methodResult.getResultMsg());
				}
			}catch(Exception e){
				//在连接异常的情况下，默认能成功.因此需要添加后台添加redo
				TransactionUtil.addReturnScheduleTicketRedo(requestMap, centreOrg.getServersaddress());
			}
		}
		Date now = new Date();

		Vip vip = null;
		Vipconsume vipconsume = null;
		
		Billinventory billinventory = null;
		if(returnticketnum>0){
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			
			//插入或修改应缴款表
			Ticketturnoverdetail ticketturnoverdetail = ticketturnoverdetailService.getCurTicketturnoverdetail(global.getUserinfo().getId(), startvoucherno);
			Billtype billtype = null;
			Billinuse billinuse = null;
			if(printreturnnum>0&& canprint && ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_1101, global.getOrganization().getId()))){
				String billtypecode = parameterService.findParamValue(ParamterConst.Param_1102, global.getOrganization().getId());
				if(startvoucherno!=null&&!startvoucherno.equals("0")){
					//判断当前票号是否正确
					billtype = getBilltypeService().findByCode(billtypecode);
					billinuse = billinuseService.jumpBillinuse(global.getUserinfo().getId(),billtypecode,startvoucherno,printreturnnum);
					billinventory = (Billinventory) dao.get(Billinventory.class, billinuse.getBillinventoryid());
					if(billtypecode.equals("Ticket")){
						if("0".equals(ticketturnoverdetail.getTicketstartno())){
							ticketturnoverdetail.setTicketstartno(startvoucherno);
							if(billinventory!=null){
								ticketturnoverdetail.setBatchno(billinventory.getBatchno());
							}
							if(billinuse!=null){
								ticketturnoverdetail.setBillinuseid(billinuse.getId());
							}
						}
						ticketturnoverdetail.setTicketendno(StringUtils.strPad(new Long(new Long(startvoucherno)+printreturnnum-1).toString(),startvoucherno.length(), "0"));
						ticketturnoverdetail.setReturnprintnum(ticketturnoverdetail.getReturnprintnum()+printreturnnum);
					}
				}else{
					//TODO 异常  要打印，但没有传入起始票号
				}
			}
			ticketturnoverdetail.setMoneypayable(ticketturnoverdetail.getMoneypayable().subtract(totalreturnmoney));
			ticketturnoverdetail.setReturnhandcharge(ticketturnoverdetail.getReturnhandcharge().add(totalreturnhandcharge));
			ticketturnoverdetail.setReturnmoney(ticketturnoverdetail.getReturnmoney().add(totalreturnmoney));
//			ticketturnoverdetail.setReturnmoney(ticketturnoverdetail.getReturnmoney().add(totalreturnmoney));
			if("3".equals(ticketreturns.get(0).getReturnway()))
				ticketturnoverdetail.setChangenum(ticketturnoverdetail.getChangenum()+1);
			
			//退票
			long voucherno = 0;
			if(startvoucherno!=null&&!"0".equals(startvoucherno)){
				voucherno = new Long(startvoucherno);
			}

			boolean canReturnAfterChange = ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_1037, global.getOrganization().getId()));
			//加上团体票的废票记录
			List<Ticketreturn> ticketreturns_tuan = new ArrayList<Ticketreturn>();
			for (Ticketreturn ticketreturn : ticketreturns) {
				if(!ticketreturn.getIsreturnticket()){
					continue;
				}
				// 如果是售异站票或异站售本站票，则先存入一个List中，再一次提交到中心去执行退票
				if(ticketreturn.getIsselfschedule()){
					Ticketsell ticketsell = (Ticketsell) dao.get(LockModeType.PESSIMISTIC_READ,Ticketsell.class, ticketreturn.getSellid());
					if(ticketsell==null){
						throw new ServiceException("0175");
					}
					else if("1".equals(ticketsell.getTicketstatus())){
						returnticketnum--;
						continue;
//						throw new ServiceException("0176");
					}
					else if("2".equals(ticketsell.getTicketstatus())){
						throw new ServiceException("0177");
					}
					else if(ticketsell.getIschecked()){
						throw new ServiceException("0178");
					}
					else{
						boolean isEPayReturn = false;
						if(ticketreturn.getReturnmethod()==null){
							play.Logger.info("ticketreturn.getReturnmethod()=0");
							ticketreturn.setReturnmethod(new Long(0));
						}
						play.Logger.info("ticketsell.getReturnfeemode()="+ticketsell.getReturnfeemode()+",ticketsell.getTicketno()="+ticketsell.getTicketno());
						play.Logger.info("ticketreturn.getReturnfeemode()="+ticketreturn.getReturnfeemode()+",ticketreturn.getReturnmethod()="+ticketreturn.getReturnmethod());
						if (null != ticketreturn.getReturnfeemode() && !"".equals(ticketreturn.getReturnfeemode())) {
							if ("1".equals(ticketreturn.getReturnfeemode())
									&& (!ticketreturn.getReturnfeemode().equals(ticketsell.getReturnfeemode()))) {
								throw new BusinessException(" 退票和售票的原路返还状态不一致!不允许退票!");
							}
						}
						//处理团体票
						List<Ticketsell> ts_tuans = new ArrayList<Ticketsell>();
						List<Ticketreturn> ticketreturn_tuan = new ArrayList<Ticketreturn>();
						Long insuranceid=0L;
						List list = new ArrayList();
						ts_tuans.add(ticketsell);
						if("T".equals(ticketsell.getTickettype())){
							//查出所有其它团体车票
							List<PropertyFilter> propertyFilters2 = new ArrayList<PropertyFilter>();
							propertyFilters2.add(new PropertyFilter("EQD_t!departdate", ticketsell.getDepartdate()));
							propertyFilters2.add(new PropertyFilter("GTS_t!ticketno", ticketsell.getTicketno()));
							propertyFilters2.add(new PropertyFilter("EQS_t!tickettype", ticketsell.getTickettype()));
							StringBuilder sql = new StringBuilder("select t from Ticketsell t where t.ticketno like '")
												.append(ticketsell.getTicketno()).append("%'");
							ts_tuans.addAll(dao.find(sql.toString(), propertyFilters2));
							
							propertyFilters2.clear();
							propertyFilters2.add(new PropertyFilter("EQD_t!departdate", ticketsell.getDepartdate()));
							propertyFilters2.add(new PropertyFilter("EQS_t!tickettype", ticketsell.getTickettype()));
							
							ticketturnoverdetail.setReturnnum(ticketturnoverdetail.getReturnnum()+ts_tuans.size()-1);//团体票其它车票张数也要加上
							int tuanreturnnum = 0;
							for (Ticketsell ts_tuan : ts_tuans) {
								Ticketreturn _ticketreturn = new Ticketreturn();
//								_ticketreturn.setBatchno(batchno);
								_ticketreturn.setBilltype(billtype);
								if (ticketreturn.getIsreturninsure()){
								StringBuilder sqlinsurance = new StringBuilder("select i.id from Ticketsell t,Insurance i where i.sellid=t.id and t.id = "+ts_tuan.getId());
								list=dao.find(sqlinsurance.toString(), propertyFilters2);
								if (list!=null && list.size()>0){
									insuranceid = (Long) dao.find(sqlinsurance.toString(), propertyFilters2).get(0);
								}else{
									throw new Exception("未找到该保险票");
								}
								}
								
//								_ticketreturn.setCharges(ticketreturn.getCharges().divide(new BigDecimal(ts_tuans.size()),2,BigDecimal.ROUND_HALF_UP));
								_ticketreturn.setCreateby(ticketreturn.getCreateby());
								_ticketreturn.setCreatetime(ticketreturn.getCreatetime());
								_ticketreturn.setIsreturninsure(ticketreturn.getIsreturninsure());
//								_ticketreturn.setIsreturnticket(ticketreturn.getIsreturnticket());
								_ticketreturn.setIsselfschedule(ticketreturn.getIsselfschedule());
//								_ticketreturn.setOpertype(ticketreturn.getOpertype());
								_ticketreturn.setRemarks(ticketreturn.getRemarks());
								//_ticketreturn.setReturnamount(ts_tuan.getPrice().subtract(_ticketreturn.getCharges()));
								_ticketreturn.setReturnby(ticketreturn.getReturnby());
//								_ticketreturn.setReturninsureid(ticketreturn.getReturninsureid());
								_ticketreturn.setReturninsureid(insuranceid);
								
								_ticketreturn.setReturnip(ticketreturn.getReturnip());
								_ticketreturn.setReturntime(ticketreturn.getReturntime());
//								_ticketreturn.setReturnvoucherno(returnvoucherno);
								_ticketreturn.setReturnway(ticketreturn.getReturnway());
								_ticketreturn.setSellid(ts_tuan.getId());
								_ticketreturn.setTicketoutletsid(ticketreturn.getTicketoutletsid());
								_ticketreturn.setTicketprice(ts_tuan.getPrice());
//								_ticketreturn.setTurnoverdetailid(turnoverdetailid);
								ticketreturns_tuan.add(_ticketreturn);
								ticketreturn_tuan.add(_ticketreturn);
								tuanreturnnum++;
							}
							ticketreturns=ticketreturns_tuan;
						}else{
							ticketreturns_tuan.add(ticketreturn);
							ticketreturn_tuan.add(ticketreturn);
						}

						//普通退票过了发车时间且没有签手续费的不允许退票
						if("0".equals(ticketreturn.getReturnway())){
							//判断是否签票
							propertyFilters.clear();
							propertyFilters.add(new PropertyFilter("EQL_t!sellid", ticketreturn.getSellid()));
							Ticketsign ticketsign = (Ticketsign) dao.uniqueResult(Ticketsign.class, propertyFilters);
							if(ticketsign==null){
								//判断发班状态
								propertyFilters.clear();
								propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketsell.getScheduleplanid()));
								propertyFilters.add(new PropertyFilter("EQL_t!departstationid",ticketsell.getDepartstationid()));
								Schedulestatus schedulestatus = (Schedulestatus) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Schedulestatus.class,propertyFilters);
								/*if(schedulestatus.getIsdeparted()){
									throw new ServiceException("0179"); //该车票所在的班次已经发班，不允许普通退票。请先签定手续费率或使用其它退票方式
								}*/
								//判断是否已经改签过
								if(!canReturnAfterChange){
									propertyFilters.clear();
									propertyFilters.add(new PropertyFilter("EQL_t!newticketsellid", ticketreturn.getSellid()));
									ticketchange = (Ticketchange) dao.uniqueResult(Ticketchange.class, propertyFilters);
//									Ticketchange ticketchange = (Ticketchange) dao.uniqueResult(Ticketchange.class, propertyFilters);
									if(ticketchange!=null){
										throw new ServiceException("票号："+ticketsell.getTicketno(),"0372",true);
									}
								}

//取消发车时间判断，按设定的手续费率退票
//								//判断发车时间
//								//0265  该车票所在的班次已过发车时间，不允许普通退票。请先签定手续费率或使用其它退票方式
//								Calendar calendar_now = Calendar.getInstance();
//								Calendar calendar_departtime = Calendar.getInstance();
//								calendar_departtime.setTime(schedulestatus.getDepartdate());
//								calendar_departtime.set(calendar_departtime.get(Calendar.YEAR), 
//												calendar_departtime.get(Calendar.MONTH), 
//												calendar_departtime.get(Calendar.DAY_OF_MONTH), 
//												Integer.valueOf(schedulestatus.getDeparttime().substring(0,2)),
//												Integer.valueOf(schedulestatus.getDeparttime().substring(3)),
//												0);
//								if(calendar_now.after(calendar_departtime)){
//									throw new ServiceException("0265"); //该车票所在的班次已过发车时间，不允许普通退票。请先签定手续费率或使用其它退票方式
//								}
							}
						}
						
						for (Ticketsell ts_tuan : ts_tuans) {
							ts_tuan.setTicketstatus("1"); //退票
							ts_tuan.setUpdateby(global.getUserinfo().getId());
							ts_tuan.setUpdatetime(now);
							dao.merge(ts_tuan);							
						}
						//若是现金则相应较少营收
						if(ticketsell.getPaymethod().equals("0")&&"0".equals(ticketreturn.getReturnfeemode())){
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
//						if(!ticketsell.getIslinework()
						if(!scheduleplan.getIslinework()            //以班次计划中的是否流水班为准  
							&&!"2".equals(scheduleplan.getWorktype())
							&&!"3".equals(scheduleplan.getWorktype())){
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

						for (Ticketreturn _ticketreturn : ticketreturn_tuan) {
							if(canprint && ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_1101, global.getOrganization().getId()))
									&&(ticketreturn.getCharges().floatValue()>0 || (ticketreturn.getChargesweb() !=null && ticketreturn.getChargesweb().floatValue()>0))){
								_ticketreturn.setReturnvoucherno(StringUtils.strPad(new Long(voucherno++).toString(),startvoucherno.length(), "0"));
								_ticketreturn.setBilltype(billtype);
								_ticketreturn.setBatchno(billinventory.getBatchno());
							}
							else{
								_ticketreturn.setReturnvoucherno(null);
								_ticketreturn.setBilltype(null);
							}
						}
						Organization sellorg = (Organization) dao.get(Organization.class, ticketsell.getOrgid());
						if(ticketsell.getTicketoutletsid()==0){
							//异站售本站票
							opponentorgid=ticketsell.getOrgid();
							//如果是售票公司售出的车票  不连到中心去退票，通过同步上传
							if(!"0".equals(sellorg.getType())
								&&!"7".equals(sellorg.getType())
								&&!"8".equals(sellorg.getType())
								&&!sellorg.getIslocal()){
								TicketReturnInfo ticketReturnInfo = new TicketReturnInfo();
								ticketReturnInfo.setBatchno(ticketsell.getBatchno());
								ticketReturnInfo.setTicketno(ticketsell.getTicketno());
								ticketReturnInfo.setIsselfschedule(false);
								ticketReturnInfo.setRemarks(ticketreturn.getRemarks());
								
								ticketReturnInfo.setCharges(ticketreturn.getCharges());
								ticketReturnInfo.setReturnbatchno(ticketreturn.getBatchno());
								ticketReturnInfo.setReturnBilltypecode(ticketreturn.getBilltype()==null?null:ticketreturn.getBilltype().getCode());
								ticketReturnInfo.setReturnvoucherno(ticketreturn.getReturnvoucherno());
								tickets.add(ticketReturnInfo);
							}
						}
						else{
							//0现金、1银联卡、2贵客卡余额、3贵客卡积分
							if("2".equals(ticketsell.getPaymethod())||"3".equals(ticketsell.getPaymethod())){
								ticketturnoverdetail.setNonvouchermoneypayable(ticketturnoverdetail.getNonvouchermoneypayable().subtract(ticketreturn.getReturnamount()));
							}
						}
						//是跨区配客班次且没有加到tickets中，要加到tickets_worktype3中
						if("3".equals(scheduleplan.getWorktype())
							&&("0".equals(sellorg.getType())     
								||"7".equals(sellorg.getType())
								||"8".equals(sellorg.getType())
								||sellorg.getIslocal()
								)
							){
							TicketReturnInfo ticketReturnInfo = new TicketReturnInfo();
							ticketReturnInfo.setBatchno(ticketsell.getBatchno());
							ticketReturnInfo.setTicketno(ticketsell.getTicketno());
							ticketReturnInfo.setIsselfschedule(false);
							ticketReturnInfo.setRemarks(ticketreturn.getRemarks());
							//若是电子票
							if(ticketsell.getSellway().equals("7")){
								propertyFilters.clear();
								propertyFilters.add(new PropertyFilter("EQL_t!ticketsellid", ticketsell.getId()));
								Ticketsellother tsk = (Ticketsellother) dao.uniqueResult(Ticketsellother.class, propertyFilters);
								if(tsk!=null){
									ticketReturnInfo.setEticketid(tsk.getEticketid());
									ticketReturnInfo.setEticketno(tsk.getEticketno());									
								}
							}
							ticketReturnInfo.setSchplansynccode(scheduleplan.getSynccode());
							ticketReturnInfo.setCharges(ticketreturn.getCharges());
							ticketReturnInfo.setReturnbatchno(ticketreturn.getBatchno());
							ticketReturnInfo.setReturnBilltypecode(ticketreturn.getBilltype()==null?null:ticketreturn.getBilltype().getCode());
							ticketReturnInfo.setReturnvoucherno(ticketreturn.getReturnvoucherno());
							tickets_worktype3.add(ticketReturnInfo);
							if(!ticketsell.getIslinework()){
								//检查座位状态
								propertyFilters.clear();
								propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketsell.getScheduleplanid()));
								propertyFilters.add(new PropertyFilter("EQR_t!seatno", ticketsell.getSeatno()));
								Scheduleseats scheduleseat = (Scheduleseats) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Scheduleseats.class, propertyFilters);
								if(scheduleseat==null){
											//回滚
									throw new ServiceException("票号"+ticketsell.getTicketno(),"0204",true); //班次座位记录不存在	
								}
								else if(!"2".equals(scheduleseat.getStatus())){
									//throw new ServiceException("票号"+ticketsell.getTicketno(),"0263",true); //座位不是售出状态
								}
								scheduleseat.setStatus("0");
								scheduleseat.setTickettype(null);
								scheduleseat.setUpdateby(global.getUserinfo().getId());
								scheduleseat.setUpdatetime(now);
								dao.merge(scheduleseat);
							}

						}
						//判断是否属于VIP卡余额支付
						if(ticketsell.getPaymethod().equals("2")){
							if(vipcardno!=null){
								vip = vipconsumeService.getConsumeVip(true, ticketsell.getId());
								if(vip == null){
									//异站售本站票时，本站没有产生消费记录，无法查出VIP信息
									vip = vipService.findByCustomerID(ticketsell.getCustomer().getId(),"0");
									//vip = vipService.findByCardNo(vipcardno,"0");
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
									vipconsume.setType("1"); //余额购票后退票
									vipconsume.setMoneychange(totalreturnmoney);
									vipconsume.setRemainmoney(vip.getMoney().add(vipconsume.getMoneychange()));
									vipconsume.setPointchange(totalreturnmoney.multiply(new BigDecimal(-1)));
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
					ticketreturns_tuan.add(ticketreturn);
					//本地退售异站票
					Ticketsellagent ticketsellagent = (Ticketsellagent) dao.get(LockModeType.PESSIMISTIC_READ,Ticketsellagent.class, ticketreturn.getSellid());
					if(ticketsellagent==null){
						throw new ServiceException("0175");
					}
					else if("1".equals(ticketsellagent.getTicketstatus())){
						returnticketnum--;
						continue;
//						throw new ServiceException("0176");
					}
					else if("2".equals(ticketsellagent.getTicketstatus())){
						throw new ServiceException("0177");
					}
					else{
						//0现金、1银联卡、2贵客卡余额、3贵客卡积分
						if("2".equals(ticketsellagent.getPaymethod())||"3".equals(ticketsellagent.getPaymethod())){
							ticketturnoverdetail.setNonvouchermoneypayable(ticketturnoverdetail.getNonvouchermoneypayable().subtract(ticketreturn.getReturnamount()));
						}

						ticketsellagent.setTicketstatus("1"); //退票
						ticketsellagent.setUpdateby(global.getUserinfo().getId());
						ticketsellagent.setUpdatetime(now);
						dao.merge(ticketsellagent);
						//若是现金则相应较少营收
						if(ticketsellagent.getPaymethod().equals("0")&&"0".equals(ticketreturn.getReturnfeemode())){
							ticketturnoverdetail.setFueladditionfee(ticketturnoverdetail.getFueladditionfee().subtract(ticketsellagent.getFueladditionfee()));
							ticketturnoverdetail.setStationservicefee(ticketturnoverdetail.getStationservicefee());  //.subtract(ticketsellagent.getStationservicefee())
							ticketturnoverdetail.setComputefee(ticketturnoverdetail.getComputefee().subtract(ticketsellagent.getComputefee()));
							ticketturnoverdetail.setCoolairfee(ticketturnoverdetail.getCoolairfee().subtract(ticketsellagent.getCoolairfee()));
							ticketturnoverdetail.setAdditionfee(ticketturnoverdetail.getAdditionfee().subtract(ticketsellagent.getAdditionfee()));
							ticketturnoverdetail.setWaterfee(ticketturnoverdetail.getWaterfee().subtract(ticketsellagent.getWaterfee()));
							ticketturnoverdetail.setInsurefee(ticketturnoverdetail.getInsurefee().subtract(ticketsellagent.getInsurefee()));
							ticketturnoverdetail.setOtherfee(ticketturnoverdetail.getOtherfee().subtract(ticketsellagent.getOtherfee()));
						}
						if(canprint && ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_1101, global.getOrganization().getId()))&&ticketreturn.getCharges().floatValue()>0){
							ticketreturn.setReturnvoucherno(StringUtils.strPad(new Long(voucherno++).toString(),startvoucherno.length(), "0"));
							ticketreturn.setBilltype(billtype);
							ticketreturn.setBatchno(billinventory.getBatchno());
						}
						else{
							ticketreturn.setReturnvoucherno(null);
							ticketreturn.setBilltype(null);
						}
						opponentorgid=ticketsellagent.getOrgid();
						TicketReturnInfo ticketReturnInfo = new TicketReturnInfo();
						ticketReturnInfo.setBatchno(ticketsellagent.getBatchno());
						ticketReturnInfo.setTicketno(ticketsellagent.getTicketno());
						ticketReturnInfo.setIsselfschedule(true);
						ticketReturnInfo.setRemarks(ticketreturn.getRemarks());
						
						ticketReturnInfo.setCharges(ticketreturn.getCharges());
						ticketReturnInfo.setReturnbatchno(ticketreturn.getBatchno());
						if(ticketreturn.getBilltype()==null){
							ticketReturnInfo.setReturnBilltypecode(null);
						}
						else{
							ticketReturnInfo.setReturnBilltypecode(ticketreturn.getBilltype().getCode());
						}
						ticketReturnInfo.setReturnvoucherno(ticketreturn.getReturnvoucherno());
						tickets.add(ticketReturnInfo);
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
									vipconsume.setType("1"); //余额购票后退票
									vipconsume.setMoneychange(totalreturnmoney);
									vipconsume.setRemainmoney(vip.getMoney().add(vipconsume.getMoneychange()));
									vipconsume.setPointchange(totalreturnmoney.multiply(new BigDecimal(-1)));
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
			ticketturnoverdetail.setReturnnum(ticketturnoverdetail.getReturnnum()+returnticketnum);
			ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);	
			for (Ticketreturn ticketreturn : ticketreturns_tuan) {
//				if(!ticketreturn.getIsreturnticket()){
//					continue;
//				}
				ticketreturn.setCreateby(global.getUserinfo().getId());
				ticketreturn.setCreatetime(now);
				ticketreturn.setUpdateby(global.getUserinfo().getId());
				ticketreturn.setUpdatetime(now);
				ticketreturn.setReturnby(global.getUserinfo().getId());
				ticketreturn.setReturntime(now);
				ticketreturn.setReturnip(global.getIpAddress());
				if(!(ticketreturn.getIsselfschedule()&&ticketreturn.getTicketoutletsid()==0)){
					//非异站售本站票（本站售本站、本站售异站）
					ticketreturn.setTurnoverdetailid(ticketturnoverdetail.getId());
				}
				ticketreturnDao.merge(ticketreturn);
			}
			if(vipconsume!=null){
				dao.merge(vipconsume);
			}
			

		}
		//退保险
//		insurancereturnService.returnInsuranceAtreturnTicket(ticketreturns, global);
		if(TestParams.getNewest().returnTicket == 3){
			SystemFactory.markRtException();
		}
		
		play.Logger.info("退票操作完成" + JsonUtil.toFormatString(ticketreturns));
		return true;
	}
	
//	private NetTicketReturnService getCentreInterface(MethodResult methodResult,Organization localorg){
//		Organization centreOrg = getOrganizationService().getDirectlyParentOrg(localorg);
//		if(centreOrg==null){
//			methodResult.setResult(insideInvokFalse);
//			methodResult.setResultMsg("无法连接中心服务器:找不到"+localorg.getName()+"的上级机构");
//			log.warn(methodResult.getResultMsg());
//			return null;
//		}
//		try {
//			return (NetTicketReturnService) EJBFactory.getRemoteEJB(NetTicketReturnService.class, centreOrg.getId());
//		} catch (NamingException e) {
//			methodResult.setResult(insideInvokFalse);
//			methodResult.setResultMsg("无法连接中心服务器:"+e.getMessage());
//			log.warn(methodResult.getResultMsg());
//			return null;
//		}
//	}
//	
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
//	
	@Override
	public Ticketreturn rePrintTicketreturnAndChangeTicketNo(boolean isselfschedule,
			long ticketsellid, String curTicketNo,Global global) throws ServiceException {
		Date now = new Date();
		//检查参数1101
		String para1101 = parameterService.findParamValue(ParamterConst.Param_1101, global.getOrganization().getId());
		if(!ParamterConst.COMMON_FLAG.FALG_YES.equals(para1101)){
			//系统设置为不打印退票凭证，不允许使用换票号重打退票凭证功能
			throw new ServiceException("0347");
		}
		//只有退票人才允许重打
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!sellid", ticketsellid));
		propertyFilters.add(new PropertyFilter("EQB_t!isselfschedule", isselfschedule));
		Ticketreturn ticketreturn = (Ticketreturn) dao.uniqueResult(Ticketreturn.class, propertyFilters);
		//判断原退票有没有打印退票凭证
		if(ticketreturn.getCharges().compareTo(new BigDecimal(0))<=0||ticketreturn.getReturnvoucherno()==null||ticketreturn.getReturnvoucherno().trim().equals("")){
			//原退票没有打印退票凭证,不允许重打
			throw new ServiceException("0348");
		}
		//判断退票人
		if(ticketreturn.getReturnby()!=global.getUserinfo().getId()){
			//换票号重打退票凭证不允许重打他人退的车票
			throw new ServiceException("0349");
		}
		String billtypecode = parameterService.findParamValue(ParamterConst.Param_1102, global.getOrganization().getId());
		Billinuse billinuse = null;
		Billinventory billinventory = null; 
		
		//插入或修改应缴款表
		Ticketturnoverdetail ticketturnoverdetail = getTicketturnoverdetailService().getCurTicketturnoverdetail(global.getUserinfo().getId(), curTicketNo);
		if(curTicketNo!=null&&!curTicketNo.equals("0")){
			//判断当前票号是否正确
//			billtype = getBilltypeService().findByCode(billtypecode);
			billinuse = billinuseService.jumpBillinuse(global.getUserinfo().getId(),billtypecode,curTicketNo,1);
			billinventory = (Billinventory) dao.get(Billinventory.class, billinuse.getBillinventoryid());
			if(billtypecode.equals("Ticket")){
				if("0".equals(ticketturnoverdetail.getTicketstartno())){
					ticketturnoverdetail.setTicketstartno(curTicketNo);
					if(billinventory!=null){
						ticketturnoverdetail.setBatchno(billinventory.getBatchno());
					}
					if(billinuse!=null){
						ticketturnoverdetail.setBillinuseid(billinuse.getId());
					}
				}
				ticketturnoverdetail.setTicketendno(curTicketNo);
			}
		}else{
			//TODO throw exception 传入票号为空
		}

		ticketturnoverdetail.setUpdateby(global.getUserinfo().getId());
		ticketturnoverdetail.setUpdatetime(now);
		ticketturnoverdetail.setBilldamagednum(ticketturnoverdetail.getBilldamagednum()+1);
		ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);
		//原票号生成坏票登记记录
		Billdamaged billdamaged = new Billdamaged();
		billdamaged.setAmount(1);
		billdamaged.setBillinuseid(billinuse.getId());
		billdamaged.setBilltypeid(billinuse.getBilltypeid());
		billdamaged.setCreateby(global.getUserinfo().getId());
		billdamaged.setCreatetime(new Date());
		billdamaged.setDamageddscribe("换票号重打退票凭证作废原票号！");
		billdamaged.setEndno(new Long(ticketreturn.getReturnvoucherno()));
		billdamaged.setRecordby(global.getUserinfo().getId());
		billdamaged.setRecordip(global.getIpAddress());
		billdamaged.setRecordtime(billdamaged.getCreatetime());
		billdamaged.setStartno(new Long(ticketreturn.getReturnvoucherno()));
		billdamaged.setTicketoutletsid(global.getTicketoutlets().getId());
		billdamaged.setUpdateby(global.getUserinfo().getId());
		billdamaged.setUpdatetime(billdamaged.getCreatetime());
		billdamaged.setTurnoverdetailid(ticketturnoverdetail.getId());
		dao.merge(billdamaged);
		//修改票号
		ticketreturn.setReturnvoucherno(curTicketNo);
		ticketreturn.setBatchno(billinventory.getBatchno());
		dao.merge(ticketreturn);
		
		//返回打印信息
		return ticketreturn;
	}
	
	@Override
	public BigDecimal findticketfee(boolean isselfschedule,long ticketsellid) throws ServiceException {
		BigDecimal ticketfee = new BigDecimal(0);
		if(isselfschedule){
			Ticketsell ts =  (Ticketsell) dao.get(Ticketsell.class, ticketsellid);
			List<Ticketsell> ts_tuans = new ArrayList<Ticketsell>();
			ts_tuans.add(ts);
			if("T".equals(ts.getTickettype())){
				//查出所有其它团体车票
				List<PropertyFilter> propertyFilters2 = new ArrayList<PropertyFilter>();
				propertyFilters2.add(new PropertyFilter("EQD_t!departdate", ts.getDepartdate()));
				propertyFilters2.add(new PropertyFilter("GTS_t!ticketno", ts.getTicketno()));
				propertyFilters2.add(new PropertyFilter("EQS_t!tickettype", ts.getTickettype()));
				StringBuilder sql = new StringBuilder("select t from Ticketsell t where t.ticketno like '")
									.append(ts.getTicketno()).append("%'");
				ts_tuans.addAll(dao.find(sql.toString(), propertyFilters2));
			}
			for (Ticketsell ts_tuan : ts_tuans) {
				ticketfee = ticketfee.add(ts_tuan.getAdditionfee())
						.add(ts_tuan.getComputefee())
						.add(ts_tuan.getCoolairfee())
						.add(ts_tuan.getInsurefee())
						.add(ts_tuan.getWaterfee())
						.add(ts_tuan.getStationservicefee())
						.add(ts_tuan.getOtherfee())
						.add(ts_tuan.getFueladditionfee());
			}
		}else{
			Ticketsellagent ts = (Ticketsellagent) dao.get(Ticketsellagent.class, ticketsellid);
			ticketfee = ticketfee.add(ts.getAdditionfee())
					 .add(ts.getComputefee())
					 .add(ts.getCoolairfee())
					 .add(ts.getInsurefee())
					 .add(ts.getWaterfee())
					 .add(ts.getStationservicefee())
					 .add(ts.getOtherfee())
					 .add(ts.getFueladditionfee());
		}
		return ticketfee;
	}
	
	private long findRemoteCallList(List<Ticketreturn> ticketreturns,long orgId,List<TicketReturnInfo> tickets,List<TicketReturnInfo> opentickets, List<TicketReturnInfo> tickets_worktype3) throws ServiceException{
		//对方车站机构id
		long opponentorgid=0;
		boolean canReturnAfterChange = ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_1037, orgId));
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		for (Ticketreturn ticketreturn : ticketreturns) {
			if(!ticketreturn.getIsreturnticket()){
				continue;
			}
			// 如果是售异站票或异站售本站票，则先存入一个List中，再一次提交到中心去执行退票
			if(ticketreturn.getIsselfschedule()){
				Ticketsell ticketsell = (Ticketsell) dao.get(LockModeType.PESSIMISTIC_READ,Ticketsell.class, ticketreturn.getSellid());
				if(ticketsell==null){
					throw new ServiceException("0175");
				}
				else if("1".equals(ticketsell.getTicketstatus())){
					throw new ServiceException("0176");
				}
				else if("2".equals(ticketsell.getTicketstatus())){
					throw new ServiceException("0177");
				}
				else if(ticketsell.getIschecked()){
					throw new ServiceException("0178");
				}
				else{
					//普通退票过了发车时间且没有签手续费的不允许退票
					if("0".equals(ticketreturn.getReturnway())){
						//判断是否签票
						propertyFilters.clear();
						propertyFilters.add(new PropertyFilter("EQL_t!sellid", ticketreturn.getSellid()));
						Ticketsign ticketsign = (Ticketsign) dao.uniqueResult(Ticketsign.class, propertyFilters);
						if(ticketsign==null){
							//判断发班状态
							propertyFilters.clear();
							propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketsell.getScheduleplanid()));
							propertyFilters.add(new PropertyFilter("EQL_t!departstationid",ticketsell.getDepartstationid()));
							Schedulestatus schedulestatus = (Schedulestatus) dao.uniqueResult(LockModeType.PESSIMISTIC_READ,Schedulestatus.class,propertyFilters);
							/*if(schedulestatus.getIsdeparted()){
								throw new ServiceException("0179"); //该车票所在的班次已经发班，不允许普通退票。请先签定手续费率或使用其它退票方式
							}*/
							//判断是否已经改签过
							if(!canReturnAfterChange){
								propertyFilters.clear();
								propertyFilters.add(new PropertyFilter("EQL_t!newticketsellid", ticketreturn.getSellid()));
								Ticketchange ticketchange = (Ticketchange) dao.uniqueResult(Ticketchange.class, propertyFilters);
								if(ticketchange!=null){
									throw new ServiceException("票号："+ticketsell.getTicketno(),"0372",true);
								}
							}
						}
					}

					Scheduleplan scheduleplan = (Scheduleplan) dao.get(LockModeType.PESSIMISTIC_READ,Scheduleplan.class, ticketsell.getScheduleplanid());
					Organization sellorg = (Organization) dao.get(Organization.class, ticketsell.getOrgid());
					if(ticketsell.getTicketoutletsid()==0){
						//异站售本站票
						opponentorgid=ticketsell.getOrgid();
						//如果是售票公司售出的车票  不连到中心去退票，通过同步上传
						if(!"0".equals(sellorg.getType())
							&&!"7".equals(sellorg.getType())
							&&!"8".equals(sellorg.getType())
							&&!sellorg.getIslocal()){
							TicketReturnInfo ticketReturnInfo = new TicketReturnInfo();
							ticketReturnInfo.setBatchno(ticketsell.getBatchno());
							ticketReturnInfo.setTicketno(ticketsell.getTicketno());
							ticketReturnInfo.setIsselfschedule(false);
							ticketReturnInfo.setRemarks(ticketreturn.getRemarks());
							
							ticketReturnInfo.setCharges(ticketreturn.getCharges());
							ticketReturnInfo.setReturnbatchno(ticketreturn.getBatchno());
							ticketReturnInfo.setReturnBilltypecode(ticketreturn.getBilltype()==null?null:ticketreturn.getBilltype().getCode());
							ticketReturnInfo.setReturnvoucherno(ticketreturn.getReturnvoucherno());
							tickets.add(ticketReturnInfo);
						}
					}
					//是跨区配客班次且没有加到tickets中，要加到tickets_worktype3中
					if("3".equals(scheduleplan.getWorktype())
						&&("0".equals(sellorg.getType())     
							||"7".equals(sellorg.getType())
							||"8".equals(sellorg.getType())
							||sellorg.getIslocal()
							)
						){
						TicketReturnInfo ticketReturnInfo = new TicketReturnInfo();
						ticketReturnInfo.setBatchno(ticketsell.getBatchno());
						ticketReturnInfo.setTicketno(ticketsell.getTicketno());
						ticketReturnInfo.setIsselfschedule(false);
						ticketReturnInfo.setRemarks(ticketreturn.getRemarks());
						//若是电子票
						if(ticketsell.getSellway().equals("7")){
							propertyFilters.clear();
							propertyFilters.add(new PropertyFilter("EQL_t!ticketsellid", ticketsell.getId()));
							Ticketsellother tsk = (Ticketsellother) dao.uniqueResult(Ticketsellother.class, propertyFilters);
							if(tsk!=null){
								ticketReturnInfo.setEticketid(tsk.getEticketid());
								ticketReturnInfo.setEticketno(tsk.getEticketno());								
							}
						}
						ticketReturnInfo.setSchplansynccode(scheduleplan.getSynccode());
						ticketReturnInfo.setCharges(ticketreturn.getCharges());
						ticketReturnInfo.setReturnbatchno(ticketreturn.getBatchno());
						ticketReturnInfo.setReturnBilltypecode(ticketreturn.getBilltype()==null?null:ticketreturn.getBilltype().getCode());
						ticketReturnInfo.setReturnvoucherno(ticketreturn.getReturnvoucherno());
						tickets_worktype3.add(ticketReturnInfo);
					}
				}
			}else{
				//本地退售异站票
				Ticketsellagent ticketsellagent = (Ticketsellagent) dao.get(LockModeType.PESSIMISTIC_READ,Ticketsellagent.class, ticketreturn.getSellid());
				if(ticketsellagent==null){
					throw new ServiceException("0175");
				}
				else if("1".equals(ticketsellagent.getTicketstatus())){
					throw new ServiceException("0176");
				}
				else if("2".equals(ticketsellagent.getTicketstatus())){
					throw new ServiceException("0177");
				}
				else{
					opponentorgid=ticketsellagent.getOrgid();
					TicketReturnInfo ticketReturnInfo = new TicketReturnInfo();
					ticketReturnInfo.setBatchno(ticketsellagent.getBatchno());
					ticketReturnInfo.setTicketno(ticketsellagent.getTicketno());
					ticketReturnInfo.setIsselfschedule(true);
					ticketReturnInfo.setRemarks(ticketreturn.getRemarks());
					
					ticketReturnInfo.setCharges(ticketreturn.getCharges());
					ticketReturnInfo.setReturnbatchno(ticketreturn.getBatchno());
					if(ticketreturn.getBilltype()==null){
						ticketReturnInfo.setReturnBilltypecode(null);
					}
					else{
						ticketReturnInfo.setReturnBilltypecode(ticketreturn.getBilltype().getCode());
					}
					ticketReturnInfo.setReturnvoucherno(ticketreturn.getReturnvoucherno());
					if(org.apache.commons.lang.StringUtils.isEmpty(ticketsellagent.getEticketid())){
						tickets.add(ticketReturnInfo);
					}else{
						ticketReturnInfo.setEticketid(ticketsellagent.getEticketid());
						ticketReturnInfo.setOrderno(ticketsellagent.getOrderno());
						opentickets.add(ticketReturnInfo);
					}
				}
			}
		}
		return opponentorgid;
	}
	
	/**
	 * 重打退票凭证
	 * @param ticketsellid：车票id
	 * @param newReturnvoucherno：新凭证号
	 */
	public List<Map<String, Object>> reprintReturnvoucher(Global global, Long ticketsellid, String newReturnvoucherno) throws Exception {
		String param_1101 = parameterService.findParamValue(ParamterConst.Param_1101, global.getOrganization().getId());//退票是否打印凭证
		if("0".equals(param_1101)){
			play.Logger.error("系统设置了退票不打印凭证，详见1101参数！");
			throw new BusinessException("系统设置了退票不打印凭证，详见1101参数！");
		}
		
		Ticketsell ticketsell = ticketreturnDao.getEntityManager().find(Ticketsell.class, ticketsellid);
		List<Object> printinfo = null;
		if (ticketsell != null) {
			if (!"1".equals(ticketsell.getTicketstatus())) {// 1:已退
				throw new BusinessException("该车票不是退票状态，不可进行补打退票凭证的操作！");
			}

			List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
			filters.clear();
			filters.add(new PropertyFilter("EQL_t!sellid", ticketsell.getId()));
			List<Ticketreturn> list = ticketreturnDao.find(Ticketreturn.class,
					filters);
			if (list != null && list.size() > 0) {
				Ticketreturn ticketreturn = list.get(0);
				ticketreturn = genBilldamaged(ticketreturn, global, newReturnvoucherno);//生成坏票记录
				printinfo = ticketreturnDao.qryTicketreurnInfo(ticketreturn.getId(), "ticketsell");// 查询打印信息
			} 
			
		}else {
			Ticketsellagent ticketsellagent = ticketreturnDao.getEntityManager().find(Ticketsellagent.class,
					ticketsellid);
			if (!"1".equals(ticketsellagent.getTicketstatus())) {// 1:已退
				throw new BusinessException("该车票不是退票状态，不可进行补打退票凭证的操作！");
			}
			List<PropertyFilter> filters = new ArrayList<PropertyFilter>();
			filters.clear();
			filters.add(new PropertyFilter("EQL_t!sellid", ticketsellagent.getId()));
			List<Ticketreturn> list = ticketreturnDao.find(Ticketreturn.class,
					filters);
			if (list != null && list.size() > 0) {
				Ticketreturn ticketreturn = list.get(0);
				ticketreturn = genBilldamaged(ticketreturn, global, newReturnvoucherno);//生成坏票记录
				printinfo = ticketreturnDao.qryTicketreurnInfo(ticketreturn.getId(), "ticketsellagent");// 查询打印信息
			} 
		}

		return ListUtil.listToMap(new Object[] { "tickettotalprice",
				"ticketreturntotal", "charges", "ticketprice", "returnamount",
				"returnvoucherno", "returntime", "ticketoutletsname",
				"sellbycode", "sellbyname", "ticketno", "schedulecode",
				"customername", "departstationname", "reachstationname",
				"departdate", "departtime", "seatno", "insuranceno", "premium",
				"returnnum" },
				printinfo,
				new Object[] {BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class, 
				String.class, Date.class, String.class,
				String.class, String.class, String.class,
				String.class, String.class, String.class, String.class,
				Date.class, String.class, String.class, String.class, BigDecimal.class,
				BigDecimal.class});
	}
	
	private Ticketreturn genBilldamaged(Ticketreturn ticketreturn, Global global, String newReturnvoucherno) throws ServiceException{
		//判断原退票有没有打印退票凭证
		if(ticketreturn.getCharges().compareTo(new BigDecimal(0))<=0||ticketreturn.getReturnvoucherno()==null||ticketreturn.getReturnvoucherno().trim().equals("")){
			//原退票没有打印退票凭证,不允许重打
			throw new ServiceException("0348");
		}
		
		// 判断当前票号是否正确
		String billtypecode = parameterService.findParamValue(
				ParamterConst.Param_1102, global.getOrganization().getId());//退票凭证票据编码
		Billtype billtype = getBilltypeService().findByCode(billtypecode);
		Billinuse billinuse = ticketreturnDao.getBillinuse(
				billtype.getId(), global.getUserinfo().getOrgid(),
				global.getUserinfo().getId(), Long.parseLong(ticketreturn.getReturnvoucherno()));
		Date date = new Date();
		
		
		
		//记录操作日志
		Operationlog operationlog = new Operationlog();
		operationlog.setUserid(global.getUserinfo().getId());
		operationlog.setIp(global.getIpAddress());
		operationlog.setSessionid(global.getSessionID());
		operationlog.setModule("退票-重打");
		operationlog.setOperation("重打退票凭证");
		operationlog.setContent("重打退票凭证，ticketreturn id=" + ticketreturn.getId() 
				+ ", 原退票凭证单号=" + ticketreturn.getReturnvoucherno() + ", 新退票凭证单号=" + newReturnvoucherno);
		operationlog.setOperatetime(date);
		dao.merge(operationlog);
		
		//生成坏票记录
		Billdamaged billdamaged = new Billdamaged();
		billdamaged.setBilltypeid(billtype.getId());
		billdamaged.setStartno(Long.parseLong(ticketreturn.getReturnvoucherno()));
		billdamaged.setEndno(Long.parseLong(ticketreturn.getReturnvoucherno()));
		billdamaged.setAmount(1L);
		billdamaged.setDamageddscribe("重打退票凭证！");
		billdamaged.setRecordby(global.getUserinfo().getId());
		billdamaged.setRecordtime(date);
		billdamaged.setRecordip(global.getIpAddress());
		billdamaged.setTicketoutletsid(global.getTicketoutlets().getId());
		billdamaged.setTurnoverdetailid(ticketreturn.getTurnoverdetailid());
		billdamaged.setCreatetime(date);
		billdamaged.setCreateby(global.getUserinfo().getId());
		billdamaged.setUpdatetime(date);
		billdamaged.setUpdateby(global.getUserinfo().getId());
		billdamaged.setBillinuseid(billinuse.getId());
		dao.merge(billdamaged);
		
		//跳号
		billinuse = billinuseService.jumpBillinuse(global.getUserinfo().getId(), 
				billtypecode, newReturnvoucherno, 1);// 跳1个号
		
		if(newReturnvoucherno != null && !newReturnvoucherno.equals("0")){
			Billinventory billinventory = (Billinventory) dao.get(Billinventory.class, billinuse.getBillinventoryid());
			if(billtypecode.equals("Ticket")){
				Ticketturnoverdetail ticketturnoverdetail = getTicketturnoverdetailService()
						.getCurTicketturnoverdetail(global.getUserinfo().getId(), 
						Long.valueOf((Long.parseLong(newReturnvoucherno))).toString());//取上一个单号对应的缴款记录
				if("0".equals(ticketturnoverdetail.getTicketstartno())){
					ticketturnoverdetail.setTicketstartno(newReturnvoucherno);
					if(billinventory!=null){
						ticketturnoverdetail.setBatchno(billinventory.getBatchno());
					}
					if(billinuse!=null){
						ticketturnoverdetail.setBillinuseid(billinuse.getId());
					}
				}
				ticketturnoverdetail.setTicketendno(newReturnvoucherno);
				ticketturnoverdetail.setBilldamagednum(ticketturnoverdetail.getBilldamagednum()+1);
				dao.merge(ticketturnoverdetail);
			}
		}else{
			throw new BusinessException("参数传入有误：未传入新退票凭证号！");
		}
		
		ticketreturn.setReturnvoucherno(newReturnvoucherno);
		ticketreturn.setUpdateby(global.getUserinfo().getId());
		ticketreturn.setUpdatetime(date);
		return (Ticketreturn) dao.merge(ticketreturn);
	}

	
	public void setInsurancereturnService(InsurancereturnService insurancereturnService) {
		this.insurancereturnService = insurancereturnService;
	}

	public InsurancereturnService getInsurancereturnService() {
		return insurancereturnService;
	}

	public TicketturnoverdetailService getTicketturnoverdetailService() {
		return ticketturnoverdetailService;
	}

	public void setTicketturnoverdetailService(
			TicketturnoverdetailService ticketturnoverdetailService) {
		this.ticketturnoverdetailService = ticketturnoverdetailService;
	}

	public BilltypeService getBilltypeService() {
		return billtypeService;
	}

	public void setBilltypeService(BilltypeService billtypeService) {
		this.billtypeService = billtypeService;
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

	@Override
	public boolean returnTickets(List<Ticketreturn> ticketreturns, Global global, boolean canprint) throws Exception {
		play.Logger.info("混检退票操作开始" + JsonUtil.toFormatString(ticketreturns));
		Iterator<Ticketreturn> iterator = ticketreturns.iterator();
		StringBuffer tsidStr =  new StringBuffer();//所有勾选的退票的ticketsell id(主票+儿童票)，str供校验是否存在没有勾选主票的儿童票做判断使用（判断是否勾选主票使用）
		List<Long> primaryIdList = new ArrayList<Long>();//所有勾选的退票中主票的ticketsell id，primaryIdList用来退所有对应的儿童票使用
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		Ticketsell ts = null;
		int printreturnnum=0;
		int returnticketnum=0;
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!code",ConstDefiniens.HJ_USERINFO));//查询售票员工号
		Userinfo hj_userinfo = (Userinfo) dao.uniqueResult(Userinfo.class, propertyFilters);//工号HJ-9999    用户 ：网售自助机混检
		while(iterator.hasNext()){
			Ticketreturn tr = iterator.next();
			tsidStr.append(tr.getSellid().toString()).append(",");
			ts = (Ticketsell) dao.get(Ticketsell.class, tr.getSellid());
			if(ts!=null){
				//主票id
				primaryIdList.add(ts.getId());
				returnticketnum = 1;
				printreturnnum = 1;
			}
		}
		//对方车站机构id
		String startvoucherno = "0";
		BigDecimal totalreturnmoney = new BigDecimal(0);		
		//异站票需要提交到中心去退票
		List<TicketReturnInfo> tickets = new ArrayList<TicketReturnInfo>();
		//售联网中心的票需要提交到中心去退票
		List<TicketReturnInfo> opentickets = new ArrayList<TicketReturnInfo>();
		//跨区配客的要到中心去执行(仅本站售本站班次，且本站退时)
		List<TicketReturnInfo> tickets_worktype3 = new ArrayList<TicketReturnInfo>(); 
		if(TestParams.getNewest().returnTicket == 1){
			SystemFactory.markRtException();
		}
		long opponentorgid = findRemoteCallList(ticketreturns,global.getOrganization().getId(), tickets, opentickets, tickets_worktype3);
		
		// 如果有售异站票退票，则提交到中心去执行退票
		if(tickets.size()>0){
			MethodResult methodResult = new MethodResult();
			RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty = new RemoteInvokeAuxiliaryProperty();
			remoteInvokeAuxiliaryProperty.setClientIp(global.getOrganization().getServersaddressIp());
			remoteInvokeAuxiliaryProperty.setClientOrgcode(global.getOrganization().getCode());
			remoteInvokeAuxiliaryProperty.setOperateOrgcode(global.getOrganization().getCode());
			remoteInvokeAuxiliaryProperty.setOperateOrgIp(global.getOrganization().getServersaddressIp());
			remoteInvokeAuxiliaryProperty.setOperateTicketoutletsName(global.getTicketoutlets().getName());
			remoteInvokeAuxiliaryProperty.setOperateUserName(hj_userinfo.getName());
			Organization organization_opponent = (Organization) dao.get(Organization.class, opponentorgid);
			remoteInvokeAuxiliaryProperty.setOppositeOrgcode(organization_opponent.getCode());
			Map<String, String> requestMap = new HashMap<String, String>();
			requestMap.put("remoteInvokeAuxiliaryProperty", JsonUtil.toFormatString(remoteInvokeAuxiliaryProperty));
			requestMap.put("tickets", JsonUtil.toFormatString(tickets));
			Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
			try{
				if(TestParams.getNewest().returnTicket == 2){
					SystemFactory.markRtException();
				}
				methodResult = RpcUtil.remoteMethodCall(centreOrg.getServersaddress(), RemoteApi.RETURN_TICKETS, requestMap);		
			}catch(Exception e){
				//在连接异常的情况下，默认能成功.因此需要添加后台添加redo
				TransactionUtil.addReturnRemoteTicketRedo(requestMap, centreOrg.getServersaddress());
			}
			if(methodResult.getResult()!=MethodResult.SUCCESS){
				throw new Exception(methodResult.getResultMsg());
			}
		}
		// 如果有售联网中心票退票，则提交到中心去执行退票
		if(opentickets.size()>0){
			if(!CurrentUtil.isOpenApiable()){
				throw new Exception("当前OpenApi售票不可用");
			}
			MethodResult methodResult = new MethodResult();
			OpenApiAdapter openapi = new OpenApiAdapterImpl();
			methodResult = openapi.returnTicket(opentickets);
			if(methodResult.getResult()!=MethodResult.SUCCESS){
				throw new Exception(methodResult.getResultMsg());
			}
		}
		// 如果有跨区配客班次，则提交到中心去执行退票
		if(tickets_worktype3.size()>0){
			MethodResult methodResult = new MethodResult();
			RemoteInvokeAuxiliaryProperty remoteInvokeAuxiliaryProperty = new RemoteInvokeAuxiliaryProperty();
			remoteInvokeAuxiliaryProperty.setClientIp(global.getOrganization().getServersaddressIp());
			remoteInvokeAuxiliaryProperty.setClientOrgcode(global.getOrganization().getCode());
			remoteInvokeAuxiliaryProperty.setOperateOrgcode(global.getOrganization().getCode());
			remoteInvokeAuxiliaryProperty.setOperateOrgIp(global.getOrganization().getServersaddressIp());
			remoteInvokeAuxiliaryProperty.setOperateTicketoutletsName(global.getTicketoutlets().getName());
			remoteInvokeAuxiliaryProperty.setOperateUserName(hj_userinfo.getName());
			Map<String, String> requestMap = new HashMap<String, String>();
			requestMap.put("remoteInvokeAuxiliaryProperty", JsonUtil.toFormatString(remoteInvokeAuxiliaryProperty));
			requestMap.put("tickets", JsonUtil.toFormatString(tickets_worktype3));

			Organization centreOrg = organizationService.getDirectlyParentOrg(global.getOrganization());
			try{
				if(TestParams.getNewest().returnTicket == 2){
					SystemFactory.markRtException();
				}
				play.Logger.info("配载班次退票调用中心 begin------参数tickets=" + JsonUtil.toFormatString(tickets_worktype3));
				methodResult = RpcUtil.remoteMethodCall(RpcUtil.getRemoteIp(centreOrg.getId()), RemoteApi.SCHEDULE_RETURN_TICKET, requestMap);		
				play.Logger.info("配载班次退票调用中心 end------返回结果result=" + methodResult.getResult());
			
				if(methodResult.getResult()!=MethodResult.SUCCESS){
					throw new Exception(methodResult.getResultMsg());
				}
			}catch(Exception e){
				//在连接异常的情况下，默认能成功.因此需要添加后台添加redo
				TransactionUtil.addReturnScheduleTicketRedo(requestMap, centreOrg.getServersaddress());
			}
		}
		Date now = new Date();
		Ticketturnoverdetail ticketturnoverdetail = ticketturnoverdetailService.getCurTicketturnoverdetail(hj_userinfo.getId(),"0");
		if(returnticketnum>0){
			//插入或修改应缴款表
				if(startvoucherno!=null&&!startvoucherno.equals("0")){
					//判断当前票号是否正确
						if("0".equals(ticketturnoverdetail.getTicketstartno())){
							ticketturnoverdetail.setTicketstartno("0");
							ticketturnoverdetail.setBatchno("0");
							ticketturnoverdetail.setBillinuseid(0);
						}
						ticketturnoverdetail.setTicketendno("0");
						ticketturnoverdetail.setReturnprintnum(ticketturnoverdetail.getReturnprintnum()+printreturnnum);
				}else{
					//TODO 异常  要打印，但没有传入起始票号
				}
			ticketturnoverdetail.setMoneypayable(ticketturnoverdetail.getMoneypayable().subtract(totalreturnmoney));
			ticketturnoverdetail.setReturnhandcharge(new BigDecimal(0));
			ticketturnoverdetail.setReturnmoney(ticketturnoverdetail.getReturnmoney().add(totalreturnmoney));
			for (Ticketreturn ticketreturn : ticketreturns) {
				if(!ticketreturn.getIsreturnticket()){
					continue;
				}
				// 如果是售异站票或异站售本站票，则先存入一个List中，再一次提交到中心去执行退票
				if(ticketreturn.getIsselfschedule()){
					Ticketsell ticketsell = (Ticketsell) dao.get(LockModeType.PESSIMISTIC_READ,Ticketsell.class, ticketreturn.getSellid());
					if(ticketsell==null){
						throw new ServiceException("0175");
					}
					else if("1".equals(ticketsell.getTicketstatus())){
						returnticketnum--;
						continue;
					}
					else if("2".equals(ticketsell.getTicketstatus())){
						throw new ServiceException("0177");
					}
					else if(ticketsell.getIschecked()){
						throw new ServiceException("0178");
					}else{
						//过滤掉自助机和网售的，只计算本站的电子支付
						//如果不是原路返还并且不是改签自动退  相当于站务的电子支付
						if(ticketreturn.getReturnmethod()==null){
							play.Logger.info("ticketreturn.getReturnmethod()=0");
							ticketreturn.setReturnmethod(new Long(0));
						}
						if(ticketsell.getReturnfeemode()==null){
							ticketsell.setReturnfeemode("0");
						}
						List<Ticketreturn> ticketreturn_tuan = new ArrayList<Ticketreturn>();
						ticketreturn_tuan.add(ticketreturn);						
						ticketsell.setTicketstatus("1"); //退票
						ticketsell.setUpdateby(hj_userinfo.getId());
						ticketsell.setUpdatetime(now);
						dao.merge(ticketsell);							
						Scheduleplan scheduleplan = (Scheduleplan) dao.get(LockModeType.PESSIMISTIC_READ,Scheduleplan.class, ticketsell.getScheduleplanid());
						//票价表要更新不区分发车站到达站
						propertyFilters.clear();
						propertyFilters.add(new PropertyFilter("EQL_t!scheduleplan.id", ticketsell.getScheduleplanid()));
						propertyFilters.add(new PropertyFilter("EQS_t!seattype", ticketsell.getSeattype()));
						Organization sellorg = (Organization) dao.get(Organization.class, ticketsell.getOrgid());
						if(ticketsell.getTicketoutletsid()==0){
							//异站售本站票
							opponentorgid=ticketsell.getOrgid();
							//如果是售票公司售出的车票  不连到中心去退票，通过同步上传
							if(!"0".equals(sellorg.getType())
								&&!"7".equals(sellorg.getType())
								&&!"8".equals(sellorg.getType())
								&&!sellorg.getIslocal()){
								TicketReturnInfo ticketReturnInfo = new TicketReturnInfo();
								ticketReturnInfo.setBatchno(ticketsell.getBatchno());
								ticketReturnInfo.setTicketno(ticketsell.getTicketno());
								ticketReturnInfo.setIsselfschedule(false);
								ticketReturnInfo.setRemarks(ticketreturn.getRemarks());
								ticketReturnInfo.setCharges(ticketreturn.getCharges());
								ticketReturnInfo.setReturnbatchno(ticketreturn.getBatchno());
								ticketReturnInfo.setReturnBilltypecode(ticketreturn.getBilltype()==null?null:ticketreturn.getBilltype().getCode());
								ticketReturnInfo.setReturnvoucherno(ticketreturn.getReturnvoucherno());
								tickets.add(ticketReturnInfo);
							}
						}
						//是跨区配客班次且没有加到tickets中，要加到tickets_worktype3中
						if("3".equals(scheduleplan.getWorktype())
							&&("0".equals(sellorg.getType())     
								||"7".equals(sellorg.getType())
								||"8".equals(sellorg.getType())
								||sellorg.getIslocal()
								)
							){
							TicketReturnInfo ticketReturnInfo = new TicketReturnInfo();
							ticketReturnInfo.setBatchno(ticketsell.getBatchno());
							ticketReturnInfo.setTicketno(ticketsell.getTicketno());
							ticketReturnInfo.setIsselfschedule(false);
							ticketReturnInfo.setRemarks(ticketreturn.getRemarks());
							//若是电子票
							if(ticketsell.getSellway().equals("7")){
								propertyFilters.clear();
								propertyFilters.add(new PropertyFilter("EQL_t!ticketsellid", ticketsell.getId()));
								Ticketsellother tsk = (Ticketsellother) dao.uniqueResult(Ticketsellother.class, propertyFilters);
								if(tsk!=null){
									ticketReturnInfo.setEticketid(tsk.getEticketid());
									ticketReturnInfo.setEticketno(tsk.getEticketno());
								}
							}
							ticketReturnInfo.setSchplansynccode(scheduleplan.getSynccode());
							ticketReturnInfo.setCharges(ticketreturn.getCharges());
							ticketReturnInfo.setReturnbatchno(ticketreturn.getBatchno());
							ticketReturnInfo.setReturnBilltypecode(ticketreturn.getBilltype()==null?null:ticketreturn.getBilltype().getCode());
							ticketReturnInfo.setReturnvoucherno(ticketreturn.getReturnvoucherno());
							tickets_worktype3.add(ticketReturnInfo);
						}
					}
				}
				else{
					//本地退售异站票
					Ticketsellagent ticketsellagent = (Ticketsellagent) dao.get(LockModeType.PESSIMISTIC_READ,Ticketsellagent.class, ticketreturn.getSellid());
					if(ticketsellagent==null){
						throw new ServiceException("0175");
					}
					else if("1".equals(ticketsellagent.getTicketstatus())){
						returnticketnum--;
						continue;
					}
					else if("2".equals(ticketsellagent.getTicketstatus())){
						throw new ServiceException("0177");
					}
					else{
						ticketsellagent.setTicketstatus("1"); //退票
						ticketsellagent.setUpdateby(hj_userinfo.getId());
						ticketsellagent.setUpdatetime(now);
						dao.merge(ticketsellagent);
						opponentorgid=ticketsellagent.getOrgid();
						TicketReturnInfo ticketReturnInfo = new TicketReturnInfo();
						ticketReturnInfo.setBatchno(ticketsellagent.getBatchno());
						ticketReturnInfo.setTicketno(ticketsellagent.getTicketno());
						ticketReturnInfo.setIsselfschedule(true);
						ticketReturnInfo.setRemarks(ticketreturn.getRemarks());
						ticketReturnInfo.setCharges(ticketreturn.getCharges());
						ticketReturnInfo.setReturnbatchno(ticketreturn.getBatchno());
						if(ticketreturn.getBilltype()==null){
							ticketReturnInfo.setReturnBilltypecode(null);
						}
						else{
							ticketReturnInfo.setReturnBilltypecode(ticketreturn.getBilltype().getCode());
						}
						ticketReturnInfo.setReturnvoucherno(ticketreturn.getReturnvoucherno());
						tickets.add(ticketReturnInfo);
					}
				}
				ticketturnoverdetail.setUpdateby(hj_userinfo.getId());
				ticketturnoverdetail.setUpdatetime(now);
				ticketturnoverdetail.setReturnnum(ticketturnoverdetail.getReturnnum()+returnticketnum);//退票加上退儿童票张数
				ticketturnoverdetail.setReturnmoney(ticketturnoverdetail.getReturnmoney().add(ticketreturn.getReturnamount()));
				ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);	
				ticketreturn.setCreateby(hj_userinfo.getId());
				ticketreturn.setCreatetime(now);
				ticketreturn.setUpdateby(hj_userinfo.getId());
				ticketreturn.setUpdatetime(now);
				ticketreturn.setReturnby(hj_userinfo.getId());
				ticketreturn.setReturntime(now);
				ticketreturn.setReturnip(global.getIpAddress());
				if(null == ticketreturn.getCharges()) {
					ticketreturn.setCharges(BigDecimal.ZERO);
				}
				if(null == ticketreturn.getReturnamount()) {
					ticketreturn.setReturnamount(BigDecimal.ZERO);
				}
				if(!(ticketreturn.getIsselfschedule()&&ticketreturn.getTicketoutletsid()==0)){
					//非异站售本站票（本站售本站、本站售异站）
					ticketreturn.setTurnoverdetailid(ticketturnoverdetail.getId());
				}
				ticketreturn.setReturnmethod(new Long(0));//车站退票
				ticketreturnDao.merge(ticketreturn);
			}
		}
		if(TestParams.getNewest().returnTicket == 3){
			SystemFactory.markRtException();
		}
		dao.getEntityManager().flush();
		return true;
		
	}

}
