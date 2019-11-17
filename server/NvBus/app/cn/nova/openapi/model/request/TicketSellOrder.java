package cn.nova.openapi.model.request;

import java.util.List;

/**
 * 售票请求参数的封装对象。
 * @author Mark
 *
 */
public class TicketSellOrder extends BaseRequsttModel{
	public String version;
	public String uid;
	public String orderno;
	public String startticketno;
	public String ordername;
	public String ordercardtype;
	public String ordercardnum;
	public String orderphonenum;
	public String orderemail;
	public String equipmentproviders;
	public List<Ticket> tickets;
	
	public static class Ticket{
		public String uid;
		public String tickettype;
		public String ticketid;
		public String seatno;
		public double price;
		public double servicefee;
		public String name;
		public int cardtype;
		public String cardnum;
		public String phonenum;
		public String takecode;
		public double insureemoney; 
		public double insureemmoney;
		public String insuranceno;
		public String insurecompanyname;
		public String iseinsurance;
		public String insureprintno;
		public String temp1;
		public String temp2;
		public String extendsinfo;
	}
}
