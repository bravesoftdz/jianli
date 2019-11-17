package cn.nova.openapi.model.response;

import java.util.List;

/**
 * 锁座时，openapi响应的座位数据模型
 * @author Mark
 *
 */
public class SeatInfo extends EncyprtResponseModel{

	public String orderno;
	public String departorgname;
	public String departorgcode;
	public String reachstationname;
	public String reachstationcode;
	public String departdate;
	public String departtime;
	public String schedulecode;
	public int ticketcount;
	public int insurcecount;
	public String locktime;
	public String unlocktime;
	public String seattype;
	public List<Ticket> tickets;
	
	public static class Ticket{
		public String tickettype;
		public String ticketid;
		public double price;
		public String seatno;
	}
}
