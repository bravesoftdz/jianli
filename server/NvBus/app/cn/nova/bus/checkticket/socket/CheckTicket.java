package cn.nova.bus.checkticket.socket;

import java.io.PrintWriter;
import java.util.Date;
import cn.nova.bus.checkticket.service.CheckTicketAutoGateService;
import cn.nova.bus.checkticket.service.impl.CheckTicketAutoGateServiceImpl;
import play.db.jpa.JPA;
import util.TransactionUtil;
import cn.nova.bus.exception.BusinessException;

public class CheckTicket {
	private PrintWriter streamWriter;

	private CheckTicketAutoGateService checkticketService = null;

	private Message msg;

	public CheckTicket(PrintWriter streamWriter, Message msg) {
		this.msg = msg;
		this.streamWriter = streamWriter;
	}


	public void checkticket() {
		String runResult = "";
		if ("0".equals(msg.getErrcode())) {
			try {
				TransactionUtil.begin();
				checkticketService = new CheckTicketAutoGateServiceImpl();
				msg=checkticketService.checkByticketno(msg);
				TransactionUtil.commit();
			} catch (BusinessException ex) {
				play.Logger.error(ex.getMessage(), ex);
				JPA.em().getTransaction().rollback();
				msg.setErrcode(ex.getCode());
				msg.setErrmsg(ex.getMessage());
			} catch (Exception ex) {
				play.Logger.error(ex.getMessage(), ex);
				JPA.em().getTransaction().rollback();				msg.setErrcode("17");
				msg.setErrmsg("数据库错误");
			}
		} else {
			msg.setErrcode("7");
			msg.setErrmsg("传入格式错误");
		}
		
		runResult = msg.getSendmsg();
		play.Logger.info("执行后返回信息:" +new Date()+ runResult);
		MsgHelper.sendMsg(streamWriter, runResult);
	}

}
