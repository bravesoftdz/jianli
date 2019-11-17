package cn.nova.openapi.sevice.impl;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.alibaba.fastjson.JSONObject;

import play.Logger;
import util.AppConstant;
import util.CommonUtil;
import util.CurrentUtil;
import util.JsonUtil;
import util.RedisUtil;
import util.RedisUtil.RedisDBApp;
import cn.nova.bus.archive.model.Customer;
import cn.nova.bus.bill.model.Billinuse;
import cn.nova.bus.bill.model.Billinventory;
import cn.nova.bus.bill.service.impl.BillinuseServiceImpl;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.netsale.model.TicketInfo;
import cn.nova.bus.netsale.model.TicketReturnInfo;
import cn.nova.bus.sale.model.ScheduleAskCondition;
import cn.nova.bus.sale.model.Ticketsellagent;
import cn.nova.bus.sale.model.Ticketturnoverdetail;
import cn.nova.bus.sale.service.impl.TicketturnoverdetailServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.openapi.NetCentreOa;
import cn.nova.openapi.converter.DepartStationConverter;
import cn.nova.openapi.converter.ReachStationConverter;
import cn.nova.openapi.converter.ScheduleConverter;
import cn.nova.openapi.converter.TicketPrintConverter;
import cn.nova.openapi.model.EncryptRequest;
import cn.nova.openapi.model.EncyprtResponse;
import cn.nova.openapi.model.UnEncyprtRequst;
import cn.nova.openapi.model.UnEncyprtResponse;
import cn.nova.openapi.model.request.SeatOrder;
import cn.nova.openapi.model.request.TicketSellOrder;
import cn.nova.openapi.model.response.BusSchedule;
import cn.nova.openapi.model.response.DepartStation;
import cn.nova.openapi.model.response.EncyprtResponseModel;
import cn.nova.openapi.model.response.ReachStation;
import cn.nova.openapi.model.response.SeatInfo;
import cn.nova.openapi.model.response.SeatInfo.Ticket;
import cn.nova.openapi.model.response.TicketDetail;
import cn.nova.openapi.model.response.TicketSellInfo;
import cn.nova.openapi.sevice.OpenApiAdapter;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.TicketOrder;
import cn.nova.utils.commons.TicketPrintInfo;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;

/**
 * @author Mark
 *
 */
public class OpenApiAdapterImpl implements OpenApiAdapter {
	/* (non-Javadoc)
	 * @see cn.nova.openapi.sevice.OpenApiAdapter#findSchedule(cn.nova.bus.sale.model.ScheduleAskCondition)
	 */
	@Override
	public MethodResult findSchedule(ScheduleAskCondition scheduleAskCondition) throws Exception {
		UnEncyprtRequst requstParam = new UnEncyprtRequst();
		requstParam.put("departcityid", scheduleAskCondition.getDepartStationId().toString());
		requstParam.put("reachstationname", scheduleAskCondition.getReachStationName());
		requstParam.put("disable", "1");
		requstParam.put("departdate", CommonUtil.dateToSimpleString(scheduleAskCondition.getDepartDate()));
		UnEncyprtResponse schedule = NetCentreOa.sentUnEncyprtGet(NetCentreOa.SCHEDULE_QUERY ,requstParam);
		MethodResult methodResult = new MethodResult();
		if(schedule.isOk()){
			methodResult.setResult(MethodResult.SUCCESS);
			List<BusSchedule> datalist = JsonUtil.parseArray(schedule.data, BusSchedule.class);
			List<Map<String, Object>> convertered =  new ScheduleConverter().converter(datalist,scheduleAskCondition.getDepartDate());
			methodResult.setObject(convertered);
		}else{
			methodResult.setResult(MethodResult.FAILURE);
		};
		methodResult.setResultMsg(schedule.resmsg);
		return methodResult;
	}
	
	/* (non-Javadoc)
	 * @see cn.nova.openapi.sevice.OpenApiAdapter#findDepartStation(java.lang.String)
	 */
	public List<Map<String, Object>> findDepartStation(String param){
		UnEncyprtRequst requstParam = new UnEncyprtRequst();
		requstParam.put("word", param);	
		UnEncyprtResponse stations = NetCentreOa.sentUnEncyprtGet(NetCentreOa.DEPART_STATION_QUERY,requstParam);
		
		List<DepartStation> datalist = new ArrayList<DepartStation>();
		if(stations.isNotOk()){
			datalist =  JsonUtil.parseArray(stations.data, DepartStation.class);
		}
		List<Map<String, Object>> converter = new DepartStationConverter().converter(datalist);
		return converter;
	}
	
	/* (non-Javadoc)
	 * @see cn.nova.openapi.sevice.OpenApiAdapter#findDepartStation2Array(java.lang.String)
	 */
	public List<Object>  findDepartStation2Array(String param){
		UnEncyprtRequst requstParam = new UnEncyprtRequst();
		requstParam.put("word", param);	
		List<Object> list = new ArrayList<Object>();
		try{
			UnEncyprtResponse stations = NetCentreOa.sentUnEncyprtGet(NetCentreOa.DEPART_STATION_QUERY,requstParam);
			if(stations.isOk()){
				List<DepartStation> datalist = JsonUtil.parseArray(stations.data, DepartStation.class);
				list = new DepartStationConverter().builder(datalist);
			}
		}catch(Exception e){
			play.Logger.error(e.getMessage(), e);
			Logger.warn("联网中心异常");
		}
		return list;
	}
	
	/* (non-Javadoc)
	 * @see cn.nova.openapi.sevice.OpenApiAdapter#findReachtation(java.lang.String, java.lang.String)
	 */
	public List<Map<String, Object>> findReachtation(String departcityid, String param){
		UnEncyprtRequst requstParam = new UnEncyprtRequst();
		requstParam.put("departcityid", departcityid);	
		requstParam.put("word", param);	
		UnEncyprtResponse stations = NetCentreOa.sentUnEncyprtGet(NetCentreOa.REACH_STATION_QUERY,requstParam);
		List<ReachStation> datalist = new ArrayList<ReachStation>();
		if(stations.isOk()){
			datalist = JsonUtil.parseArray(stations.data, ReachStation.class);
		}
		List<Map<String, Object>> converter = new ReachStationConverter().converter(datalist);
		return converter;
	}
	
	/* (non-Javadoc)
	 * @see cn.nova.openapi.sevice.OpenApiAdapter#lockSeat(cn.nova.openapi.model.request.SeatOrderParam)
	 */
	public MethodResult lockSeat(SeatOrder param){
			EncyprtResponse resp = NetCentreOa.sendEncyprtPost(NetCentreOa.LOCK_SEAT, new EncryptRequest(param));
			MethodResult methodResult = new MethodResult();
			try {
				String decyprtData = resp.getDecyprtData();
				SeatInfo seatinfo = JsonUtil.parseObject(decyprtData, SeatInfo.class);
				if(seatinfo.isOk()){
					//store ticketInfo
					RedisUtil.set(RedisDBApp.openapi, seatinfo.orderno, decyprtData, 60);
					List<SeatInfo.Ticket> lticket = seatinfo.tickets;
					StringBuffer sb = new StringBuffer();
                    for(int i=0;i<lticket.size();i++){
                    	SeatInfo.Ticket ti = JsonUtil.parseObject(lticket.get(i), SeatInfo.Ticket.class);                    	
                    	sb.append(ti.seatno).append(",");
                    }					
																
					sb.deleteCharAt(sb.length()-1);//去除最后一个逗号
					Timestamp ts = CommonUtil.parseStringToTimestamp(seatinfo.unlocktime);
					Object[] obj = new Object[2];
					obj[0] = sb.toString();
					obj[1] = ts;
					methodResult.setObject(obj);
					
					methodResult.setResult(MethodResult.SUCCESS);
				}else{
					methodResult.setResultMsg(seatinfo.resmsg);
					methodResult.setResult(MethodResult.FAILURE);	
				}
			} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
				methodResult.setResult(MethodResult.FAILURE);
				methodResult.setResultMsg(e.getMessage());
			}
			play.Logger.info(JsonUtil.toFormatString(methodResult));
			return methodResult;
			
		
	}

	/* (non-Javadoc)
	 * @see cn.nova.openapi.sevice.OpenApiAdapter#sellTick(cn.nova.openapi.model.request.TicketOrderParam, cn.nova.utils.commons.TicketOrder, java.lang.String, java.lang.String)
	 */
	@Override
	public MethodResult sellTick(TicketSellOrder param, TicketOrder order, String  ticketentrance,String buspark) {
		String string = RedisUtil.get(RedisDBApp.openapi, param.orderno);
		SeatInfo seatInfo = JsonUtil.parseObject(string, SeatInfo.class);
		List<TicketSellOrder.Ticket> tickets = new ArrayList<TicketSellOrder.Ticket>();
		ParameterService ps = new ParameterServiceImpl();
		Global global = CurrentUtil.getGlobal();
		String servicefeestr = ps.findParamValue("1049", global.getOrganization().getId());
		int servicefee  = StringUtils.isEmpty(servicefeestr) ? AppConstant.DEFAULT_SERVICE_FEE : Integer.valueOf(servicefeestr);
		List<Ticket> ticketList = JsonUtil.parseArray(seatInfo.tickets, SeatInfo.Ticket.class);
		for (SeatInfo.Ticket  sticket: ticketList) {
			TicketSellOrder.Ticket ticket = new TicketSellOrder.Ticket();
			ticket.uid = AppConstant.getValue("openapi.uid");
			ticket.ticketid = sticket.ticketid;
			ticket.seatno = sticket.seatno;
			ticket.tickettype = sticket.tickettype;
			ticket.price = sticket.price;
			ticket.servicefee = servicefee;
			ticket.insureemoney=0;
			ticket.insureemmoney=0;
			ticket.insuranceno="";
			ticket.insurecompanyname="";
			ticket.iseinsurance="";
			ticket.insureprintno="";
			ticket.temp1="";
			ticket.temp2="";
			ticket.extendsinfo="";
			tickets.add(ticket);
		}
		param.tickets = tickets;
		EncyprtResponse resp = NetCentreOa.sendEncyprtPost(NetCentreOa.SELL_TICKET, new EncryptRequest(param));
		MethodResult methodResult = new MethodResult();
		try {
			String decyprtData = resp.getDecyprtData();
			TicketSellInfo ticketInfo = JsonUtil.parseObject(decyprtData, TicketSellInfo.class);
			if(ticketInfo.isOk()){
				List<TicketPrintInfo> prints = new TicketPrintConverter().converter(ticketInfo, ticketentrance,buspark);
				
				order.setOrderno(AppConstant.getValue("openapi.preorderno")+order.getOrderno());
				saveTicketSell(prints, ticketInfo, order);
				
				methodResult.setObject(prints);
				methodResult.setResult(MethodResult.SUCCESS);
			}else{
				methodResult.setResult(MethodResult.FAILURE);	
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			methodResult.setResult(MethodResult.FAILURE);
			methodResult.setResultMsg(e.getMessage());
		}
		return methodResult;
	}
	
	/**
	 * 保存售票信息
	 * @param ticketPrintInfos
	 * @param ticketInfo
	 * @param order
	 * @throws ServiceException
	 */
	private void saveTicketSell(List<TicketPrintInfo> ticketPrintInfos, TicketSellInfo ticketInfo, TicketOrder order) throws ServiceException{
		Global global = CurrentUtil.getGlobal();
		IDAO dao = new EntityManagerDaoSurport();
		Date now = new Date();

		//插入或修改应缴款表
		Ticketturnoverdetail ticketturnoverdetail = new TicketturnoverdetailServiceImpl().getCurTicketturnoverdetail(global.getUserinfo().getId(), order.getStartTicketNO());
		if("0".equals(ticketturnoverdetail.getTicketstartno())){
			ticketturnoverdetail.setTicketstartno(order.getStartTicketNO());
		}
		ticketturnoverdetail.setTicketendno(cn.nova.utils.commons.StringUtils.strPad(new Long(new Long(order.getStartTicketNO())+order.getTickets().size()-1).toString(),order.getStartTicketNO().length(), "0"));
		ticketturnoverdetail.setSellnum(ticketturnoverdetail.getSellnum()+order.getTickets().size());
		ticketturnoverdetail.setUpdateby(global.getUserinfo().getId());
		ticketturnoverdetail.setUpdatetime(now);
		//缴款明细表加字段
		Billinuse billinuse = new BillinuseServiceImpl().jumpBillinuse(global.getUserinfo().getId(),"Ticket",order.getStartTicketNO(),order.getTickets().size());
		Billinventory billinventory = (Billinventory) dao.get(Billinventory.class, billinuse.getBillinventoryid()); 
		order.setBatchno(billinventory.getBatchno());
		ticketturnoverdetail.setBatchno(billinventory.getBatchno());
		ticketturnoverdetail.setBillinuseid(billinuse.getId());
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		
		Map<TicketPrintInfo,Ticketsellagent> ticketsells = new HashMap<TicketPrintInfo, Ticketsellagent>();
		// 从售票返回结果写本地ticketsellagent
		//ticketPrintInfos  //order.getTickets()
		for (TicketPrintInfo detail : ticketPrintInfos) {
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
			ticketsellagent.setOrgname(ticketInfo.departcity);
			ticketsellagent.setVehicletypename(ticketInfo.vehicletype);
			
			ticketsellagent.setSeatno(detail.getSeatno());
			ticketsellagent.setBuspark(detail.getBuspark());
			ticketsellagent.setCarrychildnum(detail.getCarrychildnum());
			ticketsellagent.setCreateby(order.getSeller());
			ticketsellagent.setCreatetime(now);
			ticketsellagent.setServiceprice(detail.getServicefee());
			//TODO 售联网票支持售保险
			if(detail.getCustomerid()==null||detail.getCustomerid()<=0){
				ticketsellagent.setCustomer(null);
			}
			else{
				Customer customer = new Customer();
				customer.setId(detail.getCustomerid());
				ticketsellagent.setCustomer(customer);
			}
			ticketsellagent.setDepartdate(detail.getDepartdate());
			ticketsellagent.setDepartstationname(detail.getDepartstationname());
			ticketsellagent.setDeparttime(detail.getDeparttime());
			ticketsellagent.setDiscountrate(detail.getDiscountrate());
			ticketsellagent.setDistance(detail.getDistance());
			ticketsellagent.setFullprice(detail.getFullprice());
			ticketsellagent.setIslinework(detail.getIslinework());
			ticketsellagent.setPaymethod(detail.getPaymethod());
			ticketsellagent.setPrice(detail.getPrice());
			ticketsellagent.setMoreprice(detail.getMoreprice());
			ticketsellagent.setServicefee(detail.getServicefee());
			ticketsellagent.setReachstationname(detail.getReachstationname());
			ticketsellagent.setSchedulecode(detail.getSchedulecode());
			ticketsellagent.setSellby(order.getSeller());
			ticketsellagent.setSellip(order.getIp());
			ticketsellagent.setSelltime(now);
			ticketsellagent.setSellway(order.getSellway());
			ticketsellagent.setBatchno(billinventory.getBatchno());
			if(detail.getTicketentrance()==null){
				ticketsellagent.setTicketentrance("1");
			}else{
			    ticketsellagent.setTicketentrance(detail.getTicketentrance());
			}
			ticketsellagent.setTicketno(detail.getTicketno());
			ticketsellagent.setTicketoutletsid(order.getTicketoutletsid());
			ticketsellagent.setTicketstatus("0"); //正常
			ticketsellagent.setTickettype(detail.getTickettype());
			ticketsellagent.setUpdateby(order.getSeller());
			ticketsellagent.setUpdatetime(now);
			ticketsellagent.setSeattype(detail.getSeattype());
			ticketsellagent.setToplimitprice(detail.getToplimitprice());
			ticketsellagent.setEticketid(detail.getEticketid());

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
		}
		ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);
		for (TicketPrintInfo detail : ticketsells.keySet()) {
			Ticketsellagent _ticketsellagent = ticketsells.get(detail);
			_ticketsellagent.setTurnoverdetailid(ticketturnoverdetail.getId());
			_ticketsellagent = (Ticketsellagent) dao.merge(_ticketsellagent);
			dao.getEntityManager().flush();
			detail.setId(_ticketsellagent.getId());
		}
	}
	
	/* (non-Javadoc)
	 * @see cn.nova.openapi.sevice.OpenApiAdapter#unLockSeat(cn.nova.openapi.model.EncryptParam)
	 */
	public MethodResult unLockSeat(EncryptRequest param){
		EncyprtResponse resp = NetCentreOa.sendEncyprtPost(NetCentreOa.UNLOCK_SEAT, param);
		MethodResult methodResult = new MethodResult();	
		try {
			String decyprtData = resp.getDecyprtData();
			EncyprtResponseModel model = JsonUtil.parseObject(decyprtData, EncyprtResponseModel.class);
			if(model.isOk()){
				methodResult.setResult(MethodResult.SUCCESS);
			}else{
				methodResult.setResult(MethodResult.FAILURE);	
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			methodResult.setResult(MethodResult.FAILURE);
			methodResult.setResultMsg(e.getMessage());
		}
		return methodResult;
	}
	
	/* (non-Javadoc)
	 * @see cn.nova.openapi.sevice.OpenApiAdapter#querySell(java.lang.String)
	 */
	public TicketDetail querySell(String orderno){
		EncryptRequest param = new EncryptRequest();
		param.put("version", AppConstant.getValue("openapi.version"));
		param.put("orderno", orderno);
		param.put("uid", param.getUid());
		EncyprtResponse resp = NetCentreOa.sendEncyprtPost(NetCentreOa.ORDER_QUERY, param);
		try {
			String decyprtData = resp.getDecyprtData();
			TicketDetail detail = JsonUtil.parseObject(decyprtData, TicketDetail.class);
			if(detail.isOk()){
				return detail;
			}else{
				throw new Exception();
			}
		} catch (Exception e) {
			return null;
		}	
	}

	/* (non-Javadoc)
	 * @see cn.nova.openapi.sevice.OpenApiAdapter#cancelTicket(java.util.List)
	 */
	@Override
	public MethodResult cancelTicket(List<TicketInfo> opentickets) {
		MethodResult methodResult = new MethodResult();	
		for (TicketInfo ticketInfo : opentickets) {
			EncryptRequest param = new EncryptRequest();
			param.put("orderno", ticketInfo.getOrderno());
			param.put("version", AppConstant.getValue("openapi.version"));
			param.put("uid", param.getUid());
			param.put("ticketid", ticketInfo.getEticketid());
			EncyprtResponse resp = NetCentreOa.sendEncyprtPost(NetCentreOa.CANCEL_TICKET, param);
			
			try {
				String decyprtData = resp.getDecyprtData();
				EncyprtResponseModel respModel = JsonUtil.parseObject(decyprtData, EncyprtResponseModel.class);
				if(respModel.isOk()){
					methodResult.setResult(MethodResult.SUCCESS);
				}else{
					methodResult.setResult(MethodResult.FAILURE);
					methodResult.setResultMsg(respModel.resmsg);
					return methodResult;
				}
			} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
				methodResult.setResult(MethodResult.FAILURE);
				methodResult.setResultMsg(e.getMessage());
				return methodResult;
			}
		}
		return methodResult;
	}

	/* (non-Javadoc)
	 * @see cn.nova.openapi.sevice.OpenApiAdapter#returnTicket(java.util.List)
	 */
	@Override
	public MethodResult returnTicket(List<TicketReturnInfo> opentickets) {
		MethodResult methodResult = new MethodResult();	
		for (TicketReturnInfo ticketreturn : opentickets) {
			EncryptRequest param = new EncryptRequest();
			param.put("orderno", ticketreturn.getOrderno());
			param.put("version", AppConstant.getValue("openapi.version"));
			param.put("uid", param.getUid());
			param.put("ticketid", ticketreturn.getEticketid());
			param.put("refundfee", ticketreturn.getCharges());
			EncyprtResponse resp = NetCentreOa.sendEncyprtPost(NetCentreOa.RETURN_TICKET, param);
			
			try {
				String decyprtData = resp.getDecyprtData();
				EncyprtResponseModel respModel = JsonUtil.parseObject(decyprtData, EncyprtResponseModel.class);
				if(respModel.isOk()){
					methodResult.setResult(MethodResult.SUCCESS);
				}else{
					methodResult.setResult(MethodResult.FAILURE);
					methodResult.setResultMsg(respModel.resmsg);
					return methodResult;
				}
			} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
				methodResult.setResult(MethodResult.FAILURE);
				methodResult.setResultMsg(e.getMessage());
				return methodResult;
			}
		}
		return methodResult;
	}
	
	/* (non-Javadoc)
	 * @see cn.nova.openapi.sevice.OpenApiAdapter#changeTicket(cn.nova.openapi.model.EncryptParam)
	 */
	@Override
	public MethodResult changeTicket(EncryptRequest param) {
		MethodResult methodResult = new MethodResult();	
		EncyprtResponse resp = NetCentreOa.sendEncyprtPost(NetCentreOa.CHANGE_TICKET, param);
		
		try {
			String decyprtData = resp.getDecyprtData();
			EncyprtResponseModel respModel = JsonUtil.parseObject(decyprtData, EncyprtResponseModel.class);
			if(respModel.isOk()){
				methodResult.setResult(MethodResult.SUCCESS);
			}else{
				methodResult.setResult(MethodResult.FAILURE);	
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			methodResult.setResult(MethodResult.FAILURE);
			methodResult.setResultMsg(e.getMessage());
		}
		return methodResult;
	}
}
