package controllers.remotesale;

import java.util.Date;

import controllers.BaseController;
import play.mvc.Controller;
import util.JsonUtil;
import cn.nova.bus.eticketsale.service.ETicketSellService;
import cn.nova.bus.eticketsale.service.impl.ETicketSellServiceImpl;
import cn.nova.centre.ws.model.LockSeatesInfo;
import cn.nova.centre.ws.model.SellseatsOrderInfo;
import cn.nova.centre.ws.model.UpdateEticketsInfo;
import cn.nova.utils.commons.MethodResult;

public class ETicketSellAction extends BaseController {

	public static void lockSeat(String lockSeatesInfo) {
		ETicketSellService eTicketSellService = new ETicketSellServiceImpl();
		MethodResult lockSeat = eTicketSellService.lockSeat(JsonUtil.parseObject(lockSeatesInfo, LockSeatesInfo.class));
		renderResult(lockSeat);
	}

	public static void unlockSeat(String orderno) {
		ETicketSellService eTicketSellService = new ETicketSellServiceImpl();
		MethodResult unlockSeat = eTicketSellService.unlockSeat(orderno);
		renderResult(unlockSeat);
	}

	public static void sellTicket(String sellorgcode, String order) {
		ETicketSellService eTicketSellService = new ETicketSellServiceImpl();
		MethodResult sellTicket = eTicketSellService.sellTicket(sellorgcode, JsonUtil.parseObject(order, SellseatsOrderInfo.class));
		renderResult(sellTicket);
	}

	public static void getOrderInfo(String orderno) {
		ETicketSellService eTicketSellService = new ETicketSellServiceImpl();
		MethodResult getOrderInfo = eTicketSellService.GetOrderInfo(orderno);
		renderResult(getOrderInfo);
	}

	public static void getSeatInfo(Date departdate, String schedulecode, String departstationcode, String reachstationcode) {
		ETicketSellService eTicketSellService = new ETicketSellServiceImpl();
		MethodResult getSeatInfo = eTicketSellService.GetSeatInfo(departdate, schedulecode, departstationcode, reachstationcode);
		renderResult(getSeatInfo);
	}

	public static void updateEticket(String updateEticketsInfo) {
		ETicketSellService eTicketSellService = new ETicketSellServiceImpl();
		MethodResult updateEticket = eTicketSellService.UpdateEticket(JsonUtil.parseObject(updateEticketsInfo, UpdateEticketsInfo.class));
		renderResult(updateEticket);
	}

	public static void takeTicket(String batchno, String ticketno, String eticketid) {
		ETicketSellService eTicketSellService = new ETicketSellServiceImpl();
		MethodResult takeTicket = eTicketSellService.takeTicket(batchno, ticketno, eticketid);
		renderResult(takeTicket);
	}

}
