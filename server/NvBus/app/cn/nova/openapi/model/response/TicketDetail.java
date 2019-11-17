package cn.nova.openapi.model.response;

import java.util.Date;
import java.util.List;

import util.JsonUtil;

/**
 * 查询订单时，openapi响应的车票数据模型
 * @author Mark
 *
 */
public class TicketDetail extends EncyprtResponseModel{
	public String rescode;
	public String resmsg;
	public String uid;
	public String orderno;
	public String departorgname;
	public String reachstationname;
	public String departorgcode;
	public String reachstationcode;
	public String departdate;
	public String departtime;
	public String schedulecode;
	public String seattype;
	public int ticketcount;
	public double totalprice;
	public String status;
	public Date selledtime;
	public List<Ticket> tickets;

	public class Ticket{
		public String ticketid;
		public int status;
		public int takestatus;
		public String tickettype;
		public double price;
		public String seatno;
		public double refundprice;
		public String returnorgcode;
	}
	
	public double getRrefundprice(String eticketid){
		tickets = JsonUtil.parseArray(tickets, Ticket.class);
		for (Ticket ticket : tickets) {
			if(eticketid.equals(ticket.ticketid)){
				return ticket.refundprice;
			}
		}
		return tickets.get(0).refundprice;
	}
}
