package cn.nova.bus.archive.action;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.base.service.impl.TicketPrintStrServiceImpl;
import cn.nova.bus.ticketprint.param.TicketPrintParam;

public class TicketprintStrAction extends BaseAction{
	
	private TicketPrintStrServiceImpl ticketprintStrService;
	
	private String ticketno;
	
	//return
	private String printstr;
	
	
	public String getPrintStr() {
		
		ticketprintStrService = new TicketPrintStrServiceImpl();
		 	
		printstr = ticketprintStrService.getPrintStrByTicketno(ticketno);
		
		return "json";
	}

	
	public String getPrintstr() {
		return printstr;
	}

	public void setPrintstr(String printstr) {
		this.printstr = printstr;
	}

	public String getTicketno() {
		return ticketno;
	}

	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
	}

	
}
