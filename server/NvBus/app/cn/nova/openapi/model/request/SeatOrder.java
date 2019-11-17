package cn.nova.openapi.model.request;

import java.util.ArrayList;
import java.util.List;

import cn.nova.openapi.converter.DictConverter;
import util.AppConstant;
import util.JsonUtil;

/**
 * 锁座请求参数的封装对象。
 * @author Mark
 *
 */
public class SeatOrder extends BaseRequsttModel {
	public String version;
	public String uid;
	public String suppliercode;
	public String departorgcode;
	public String schedulecode;
	public String reachstationcode;
	public String departdate;
	public String orderno;
	public String seattype;
	public Integer ticketcount;
	public List<Ticket> tickets;
	
	public SeatOrder(){
		version = AppConstant.getValue("openapi.version");
		uid = AppConstant.getValue("openapi.uid");
		suppliercode = AppConstant.getValue("openapi.suppliercode");
	}
	
	public class Ticket{
//		public int tickettype;
		public String tickettype;
		public Double price;
	}
	
	public void buildTickets(String ticketTypesStr, String tickPricesStr){
		String[] ticketTypes = ticketTypesStr.split(",");
		String[] tickPrices = tickPricesStr.split(",");
		List<Ticket> list = new ArrayList<Ticket>();
		for (int i = 0; i < tickPrices.length; i++) {
			Ticket ticket = new Ticket();
//			ticket.tickettype = DictConverter.parseTicketType(ticketTypes[i]);
			ticket.tickettype = ticketTypes[i];
			ticket.price = Double.valueOf(tickPrices[i]);
			list.add(ticket);
		}
		tickets = list;
		ticketcount = tickPrices.length;
	}
}
