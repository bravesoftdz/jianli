package cn.nova.openapi.model.response;

import java.util.Date;
import java.util.List;

import cn.nova.openapi.model.response.TicketDetail.Ticket;

/**
 * 买票后，openapi响应的车票数据模型，用于前台打印。
 * @author Mark
 *
 */
public class TicketSellInfo extends EncyprtResponseModel{
	public String orderno;
	public int ticketcount;
	public String selledtime;
	public String departorgcode;
	public String departorgname;
	public String departcity;
	public String reachstationname;
	public String reachstationcode;
	public String departdate;
	public String departtime;
	public String schedulecode;
	public String vehicletype;
	public String seattype;
	public String vehicleno;
	public String distance;
	public String ticketentrance;
	public String waitingroom;
	public String buspark;
	public String scheduletype;
	public boolean isovertime;
	public boolean islineschedule;
	public String starttime;
	public String endtime;
	public List<Ticket> tickets;

	public class Ticket{
		public String ticketid;
		public String ticketno;
		public int seatno;
		public double servicefee;
		public String tickettype;
		public double price;
		public String takecode;
		public double stationservicefee;
		public double fuelprice;
		public double premium;
		public String insureprintno;
		public String insuretype;
		public double insureemoney;
		public double insureemmoney;
		public String insuranceno;
		public String insurecompanyname;
		public String temp1;
		public String temp2;
		public String extendsinfo;
	}
}
