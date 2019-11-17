package controllers.remotesale;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import controllers.BaseController;
import models.RemoteTransaction;
import models.TestParams;
import play.Logger;
import play.data.binding.As;
import play.mvc.Catch;
import play.mvc.Controller;
import util.AppConstant;
import util.JsonUtil;
import util.SystemFactory;
import util.TransactionUtil;
import util.TransactionUtil.TransactionType;
import cn.nova.bus.checkticket.remote.service.CheckTicketStationService;
import cn.nova.bus.checkticket.remote.service.impl.CheckTicketStationServiceImpl;
import cn.nova.bus.dispatch.model.SeatreserveIn;
import cn.nova.bus.netsale.client.service.NetOtherTicketCancelService;
import cn.nova.bus.netsale.client.service.NetOtherTicketReturnService;
import cn.nova.bus.netsale.client.service.NetOtherTicketSellService;
import cn.nova.bus.netsale.client.service.impl.NetOtherTicketCancelServiceImpl;
import cn.nova.bus.netsale.client.service.impl.NetOtherTicketReturnServiceImpl;
import cn.nova.bus.netsale.client.service.impl.NetOtherTicketSellServiceImpl;
import cn.nova.bus.netsale.model.TicketInfo;
import cn.nova.bus.netsale.model.TicketReturnInfo;
import cn.nova.bus.sale.model.NetScheduleDetail;
import cn.nova.bus.sale.model.ScheduleDetail;
import cn.nova.bus.sale.service.TicketSellService;
import cn.nova.bus.sale.service.impl.TicketSellServiceImpl;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.ParamCheckTicketIn;
import cn.nova.utils.commons.ParamCheckTicketOut;
import cn.nova.utils.commons.RemoteInvokeAuxiliaryProperty;
import cn.nova.utils.commons.TicketOrder;

public class NetOtherTicketSellAction extends BaseController{
	
	@Catch(Exception.class)
	public static void exceptionInterceptor(Throwable e){
		play.Logger.error(e.getMessage(), e);
		MethodResult result = new MethodResult();
		result.setResult(MethodResult.FAILURE);
		result.setResultMsg("服务器内部异常");
		renderResult(result);
	}
	
	public static void findScheduleStatus(Date departdate,String schedulesynccode){
		NetOtherTicketSellService notss = new NetOtherTicketSellServiceImpl();
		play.Logger.info("ssl1:modifySchedulePlanStatus  beCall in Action.modifySchedulePlanStatus:" + schedulesynccode);
		String findSchedulestatus = notss.findSchedulestatus(departdate, schedulesynccode);
		play.Logger.info("ssl2:modifySchedulePlanStatus  called in Action.modifySchedulePlanStatus:" + schedulesynccode);
		renderText(findSchedulestatus);
	}
	
	
	public static void modifySchedulePlanStatus(Date departdate,String schedulesynccode,String worktype){
		NetOtherTicketSellService notss = new NetOtherTicketSellServiceImpl();
		MethodResult status = notss.modifySchedulePlanStatus(departdate, schedulesynccode, worktype);
		renderResult(status);
	}
	
	public static void sellTicket(String transactionid,String remoteInvokeAuxiliaryProperty,String order){
		RemoteTransaction remoteTransaction = new RemoteTransaction();
		remoteTransaction.id = transactionid;
		remoteTransaction.formip = request.host;
		remoteTransaction.type = TransactionType.SELL_TICKET.ordinal();
		remoteTransaction.createDate = new Date();
		Map<String, String> requestMap = new HashMap<String, String>();
		requestMap.put("transactionid", transactionid);
		requestMap.put("remoteInvokeAuxiliaryProperty", remoteInvokeAuxiliaryProperty);
		requestMap.put("order", order);
		remoteTransaction.requestjson = JsonUtil.toSimpleString(requestMap);
		remoteTransaction.save();
		
		TransactionUtil.commit();
		TransactionUtil.begin();
		
		remoteTransaction.status = AppConstant.REMOTE_TRANSACTION_ING;
		remoteTransaction.save();
		
		NetOtherTicketSellService notss = new NetOtherTicketSellServiceImpl();
		TicketOrder to = JsonUtil.parseObject(order, TicketOrder.class);
		play.Logger.info("stl11:sellTIcket beCall in Action.orderno:" + to.getOrderno() );
		MethodResult sellTicket = notss.sellTicket(JsonUtil.parseObject(remoteInvokeAuxiliaryProperty, RemoteInvokeAuxiliaryProperty.class),to );
		play.Logger.info("stl12:sellTIcket called in Action.orderno:" + to.getOrderno() +",and resultis:"+ sellTicket.getResult() );
		
		if(TestParams.getNewest().remoteSellTicket == 1){
			TransactionUtil.setRollbackOnly();
			SystemFactory.markRtException();
		}
		
		remoteTransaction.status = AppConstant.REMOTE_TRANSACTION_SUCCESS;
		remoteTransaction.save();
		
		renderResult(sellTicket);
	}
	
	public static void lockSeat(String remoteInvokeAuxiliaryProperty,Date departdate,String schedulesynccode,String orderno,String seatnos,String selectSeatStatus,String selectSeattype){
		NetOtherTicketSellService notss = new NetOtherTicketSellServiceImpl();
		MethodResult lockSeat = notss.lockSeat(JsonUtil.parseObject(remoteInvokeAuxiliaryProperty, RemoteInvokeAuxiliaryProperty.class), departdate, schedulesynccode,UUID.fromString(orderno),JsonUtil.parseArray(seatnos, Short.class) ,JsonUtil.parseArray(selectSeatStatus, String.class), selectSeattype);
		renderResult(lockSeat);
	}
	
	public static void changeTicketNo(String remoteInvokeAuxiliaryProperty,String oldTicketno, String newTicketNo){
		NetOtherTicketSellService notss = new NetOtherTicketSellServiceImpl();
		MethodResult changeTicketNo = notss.changeTicketNo(JsonUtil.parseObject(remoteInvokeAuxiliaryProperty, RemoteInvokeAuxiliaryProperty.class), oldTicketno, newTicketNo);
		renderResult(changeTicketNo);
	}
	
	public static void findScheduleSeats(Date departdate,String schedulesynccode){
		NetOtherTicketSellService notss = new NetOtherTicketSellServiceImpl();
		MethodResult findScheduleseats = notss.findScheduleseats(departdate, schedulesynccode);
		renderResult(findScheduleseats);
	}
	
	
	public static void findScheduleDetail(String scheduleDetail){
		NetScheduleDetail ns =JsonUtil.parseObject(scheduleDetail, NetScheduleDetail.class);
		MethodResult findSchedulDetail = new MethodResult();
		TicketSellService ticketSellService = new TicketSellServiceImpl();
		ScheduleDetail sd = new ScheduleDetail();
		sd.setDepartDate(ns.getDepartDate());
		sd.setDeparttime(ns.getDeparttime());
		sd.setScheduleid(ticketSellService.findScheduleByCode(ns).getId());
		if(ns.getFlag()==1){
			findSchedulDetail.setObject(ticketSellService.findScheduleDetail(sd));
			findSchedulDetail.setResult(1);
		}else if(ns.getFlag()==2){
			findSchedulDetail.setObject(ticketSellService.findScheduleDetail2(sd));
			findSchedulDetail.setResult(1);
		}else{
			findSchedulDetail.setResult(0);
			findSchedulDetail.setResultMsg("进行班次已售详情查询传入参数flag异常");
			System.out.println("进行班次已售详情查询传入参数flag异常");
		}
		renderResult(findSchedulDetail);
	}

	
	public static void findTicketPrices(Date departdate,String schedulesynccode,String departstationcode,String reachstationcode,String seattype){
		NetOtherTicketSellService notss = new NetOtherTicketSellServiceImpl();
		MethodResult findTicketPrices = notss.findTicketPrices(departdate, schedulesynccode, departstationcode, reachstationcode, seattype);
		renderResult(findTicketPrices);
	}
	
	public static void unLockSeat(String remoteInvokeAuxiliaryProperty,String orderno){
		NetOtherTicketSellService notss = new NetOtherTicketSellServiceImpl();
		MethodResult unlockSeat = notss.unlockSeat(JsonUtil.parseObject(remoteInvokeAuxiliaryProperty, RemoteInvokeAuxiliaryProperty.class), UUID.fromString(orderno));
		renderResult(unlockSeat);
	}

	public static void returnTickets(String tickets, String cancelbyname, String ticketoutlets) {
		NetOtherTicketReturnService notrs = new NetOtherTicketReturnServiceImpl();
		MethodResult returnTickets = notrs.returnTickets(JsonUtil.parseArray(tickets, TicketReturnInfo.class), cancelbyname, ticketoutlets);
		
		if(TestParams.getNewest().remoteReturnTicket == 1){
			TransactionUtil.setRollbackOnly();
			SystemFactory.markRtException();
		}
		
		renderResult(returnTickets);
	}
	
	//联网改签
	public static void changetickets_O2L(String tickets, String ticketchange, String cancelbyname, String ticketoutlets) {
		NetOtherTicketReturnService notrs = new NetOtherTicketReturnServiceImpl();
		MethodResult returnTickets = notrs.changetickets_O2L(JsonUtil.parseArray(tickets, TicketReturnInfo.class), cancelbyname, ticketoutlets);
		
		if(TestParams.getNewest().remoteReturnTicket == 1){
			TransactionUtil.setRollbackOnly();
			SystemFactory.markRtException();
		}
		
		renderResult(returnTickets);
	}

	public static void cancelTickets(String tickets, String cancelbyname, String ticketoutlets) {
		NetOtherTicketCancelService notcs = new NetOtherTicketCancelServiceImpl();
		MethodResult cancelTickets = notcs.cancelTickets(JsonUtil.parseArray(tickets, TicketInfo.class), cancelbyname, ticketoutlets);
		
		
		if(TestParams.getNewest().remoteCancelTicket == 1){
			TransactionUtil.setRollbackOnly();
			SystemFactory.markRtException();
		}
		
		
		renderResult(cancelTickets);
	}

	public static void checkTicketsell(String inparam) {
		CheckTicketStationService ctss = new CheckTicketStationServiceImpl();
		ParamCheckTicketOut checkTicketsell = ctss.checkTicketsell(JsonUtil.parseObject(inparam, ParamCheckTicketIn.class));
		renderText(JsonUtil.toFormatString(checkTicketsell));
	}
	
	public static void cancelRemoteTicketCheck(String ticketno, String departorgcode,@As("yyyy-MM-dd") Date departdate) throws Exception {
		CheckTicketStationService ctss = new CheckTicketStationServiceImpl();
		MethodResult cancelRemoteTicketCheck = ctss.cancelRemoteTicketCheck(ticketno,departorgcode,departdate);
		renderText(JsonUtil.toFormatString(cancelRemoteTicketCheck));
	}


	public static void findTicketsell(String inparam) {
		CheckTicketStationService ctss = new CheckTicketStationServiceImpl();
		ParamCheckTicketOut findTicketsell = ctss.findTicketsell(JsonUtil.parseObject(inparam, ParamCheckTicketIn.class));
		renderText(JsonUtil.toFormatString(findTicketsell));
	}
	
	public static void undoTransaciton(String transacionid){
		RemoteTransaction remoteTransaction = RemoteTransaction.findById(transacionid);
		if(remoteTransaction == null){
			MethodResult mr = new MethodResult();
			mr.setResult(MethodResult.SUCCESS);
			mr.setResultMsg("找不到事务不存在！");
			renderResult(mr);
		}
		
		if(remoteTransaction.status == AppConstant.REMOTE_TRANSACTION_UNDO_SUCCESS){
			MethodResult mr = new MethodResult();
			mr.setResult(MethodResult.SUCCESS);
			mr.setResultMsg("事务UNDO已经处理！");
			renderResult(mr);
		}else if(remoteTransaction.status == AppConstant.REMOTE_TRANSACTION_ING){
			MethodResult mr = new MethodResult();
			mr.setResult(MethodResult.FAILURE);
			mr.setResultMsg("事务还在处理中！");
			renderResult(mr);
		}else if(remoteTransaction.status == AppConstant.REMOTE_TRANSACTION_UNDOING){
			MethodResult mr = new MethodResult();
			mr.setResult(MethodResult.FAILURE);
			mr.setResultMsg("事务UNDO在处理中！");
			renderResult(mr);
		}else if(remoteTransaction.status == AppConstant.REMOTE_TRANSACTION_SUCCESS){
			remoteTransaction.status = AppConstant.REMOTE_TRANSACTION_ING;
			remoteTransaction.save();
			
			HashMap<String,String> map = JsonUtil.parseObject(remoteTransaction.requestjson, HashMap.class);
			MethodResult methodResult = new MethodResult();
			if(remoteTransaction.type == TransactionType.SELL_TICKET.ordinal()){
				String transactionId = map.get("transactionId");
				String remoteInvokeAuxiliaryProperty = map.get("remoteInvokeAuxiliaryProperty");
				String order = map.get("order");
				methodResult = new NetOtherTicketSellServiceImpl().sellTicketUndo(transactionId,JsonUtil.parseObject(remoteInvokeAuxiliaryProperty, RemoteInvokeAuxiliaryProperty.class),  JsonUtil.parseObject(order, TicketOrder.class));
			}
			remoteTransaction.status = AppConstant.REMOTE_TRANSACTION_UNDO_SUCCESS;
			remoteTransaction.save();
			renderResult(methodResult);
		}
	}
	
	/**
	 * 联网订票
	 */
	public static void reserveSeat(String transactionid, String remoteInvokeAuxiliaryProperty, String sin){
		RemoteTransaction remoteTransaction = new RemoteTransaction();
		remoteTransaction.id = transactionid;
		remoteTransaction.formip = request.host;
		remoteTransaction.type = TransactionType.RESERVE_SEAT.ordinal();
		remoteTransaction.createDate = new Date();
		Map<String, String> requestMap = new HashMap<String, String>();
		requestMap.put("transactionid", transactionid);
		requestMap.put("remoteInvokeAuxiliaryProperty", remoteInvokeAuxiliaryProperty);
		requestMap.put("seatreserveIn", sin);
		requestMap.put("transactionid", transactionid);
		remoteTransaction.requestjson = JsonUtil.toSimpleString(requestMap);
		remoteTransaction.save();
		
		TransactionUtil.commit();
		TransactionUtil.begin();
		
		remoteTransaction.status = AppConstant.REMOTE_TRANSACTION_ING;
		remoteTransaction.save();
		
		NetOtherTicketSellService notss = new NetOtherTicketSellServiceImpl();
		SeatreserveIn seatreserveIn = JsonUtil.parseObject(sin, SeatreserveIn.class);
		
		play.Logger.info("联网订票(他站预定本站)开始，参数为:" + sin );
		MethodResult reserveSeat = notss.reserveSeat(JsonUtil.parseObject(remoteInvokeAuxiliaryProperty, RemoteInvokeAuxiliaryProperty.class), seatreserveIn);
		play.Logger.info("联网订票(他站预定本站)结束，结果为:" + sin );
		
		if(TestParams.getNewest().remoteSellTicket == 1){
			TransactionUtil.setRollbackOnly();
			SystemFactory.markRtException();
		}
		
		remoteTransaction.status = AppConstant.REMOTE_TRANSACTION_SUCCESS;
		remoteTransaction.save();
		
		renderResult(reserveSeat);
	}
}
