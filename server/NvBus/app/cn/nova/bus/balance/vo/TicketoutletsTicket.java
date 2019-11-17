package cn.nova.bus.balance.vo;

import java.util.ArrayList;
import java.util.List;

import cn.nova.bus.base.model.Ticketoutlets;
import cn.nova.bus.sale.model.Ticketsell;

public class TicketoutletsTicket {

	private List<Ticketsell> ticketlist;

	private Ticketoutlets ticketoutlet;

	
	public TicketoutletsTicket(){
		ticketlist=new ArrayList<Ticketsell>();		
	}
	
	public List<Ticketsell> getTicketlist() {
		return ticketlist;
	}

	public void setTicketlist(List<Ticketsell> ticketlist) {
		this.ticketlist = ticketlist;
	}

	public Ticketoutlets getTicketoutlet() {
		return ticketoutlet;
	}

	public void setTicketoutlet(Ticketoutlets ticketoutlet) {
		this.ticketoutlet = ticketoutlet;
	}

}
