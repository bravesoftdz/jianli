package util;

import java.util.Map;

import models.RedoObject;
import models.UndoTransaction;
import play.Play;
import play.db.jpa.JPA;
import util.RedisUtil.RedisDBApp;
import cn.nova.bus.dispatch.model.Seatreserve;
import cn.nova.bus.security.Global;

public class TransactionUtil {
	public static void commit(){
		if(JPA.em().getTransaction().isActive()){
			try{
				JPA.em().getTransaction().commit();
			}catch(Exception ex){
				play.Logger.error(ex.getMessage(), ex);
			}
		}
	}
	
	public static void begin(){
		if(!JPA.em().getTransaction().isActive()){
			JPA.em().getTransaction().begin();
		}
	}
	
	public static void commitAndBegin(){
		if(JPA.em().getTransaction().isActive()){
			try{
				commit();
			}catch(Exception ex){
				play.Logger.error(ex.getMessage(), ex);
			}
		}
		begin();
	}
	
	public static void setRollbackOnly(){
		if(JPA.em().getTransaction().isActive()){
			JPA.em().getTransaction().setRollbackOnly();
		}
	}
	
	public enum TransactionType {
		SELL_TICKET,
		SELL_SCHEDULE_TICKET,
		RESERVE_SEAT,
		MIX_TICKET_CHECK
	}
	
	public static void addUndoJob(String transactionId, String requestIp){
		String json = new UndoTransaction(transactionId, requestIp).toJson();
		RedisUtil.rPush(RedisDBApp.undo,AppConstant.getValue("app.maccode"), json);
	}
	
	public static void addCancelSeatRedo(Map<String, String> requestMap, String requestIp){
		String json = new RedoObject(requestMap, requestIp).toJson();
		RedisUtil.rPush(RedisDBApp.cancelSeat,AppConstant.getValue("app.maccode"), json);
	}
	
	public static void addReturnScheduleTicketRedo(Map<String, String> requestMap, String requestIp){
		String json = new RedoObject(requestMap, requestIp, false).toJson();
		RedisUtil.rPush(RedisDBApp.returnTicket,AppConstant.getValue("app.maccode"), json);
	}
	
	public static void addReturnRemoteTicketRedo(Map<String, String> requestMap, String requestIp){
		String json = new RedoObject(requestMap, requestIp, true).toJson();
		RedisUtil.rPush(RedisDBApp.returnTicket,AppConstant.getValue("app.maccode"), json);
	}
	
	public static void addCancelScheduleCheckRedo(Map<String, String> requestMap, String requestIp) {
		String json = new RedoObject(requestMap, requestIp, false).toJson();
		RedisUtil.rPush(RedisDBApp.cancelCheck,AppConstant.getValue("app.maccode"), json);
	}
}
