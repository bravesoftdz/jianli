package cn.nova.bus.sale.remote.param;

import java.io.Serializable;

public class ParamQueryPrintTicket implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 2088139433309197583L;

	public String getTicketID() {
		return TicketID;
	}

	public void setTicketID(String ticketID) {
		TicketID = ticketID;
	}

	public String getOrderNo() {
		return OrderNo;
	}

	public void setOrderNo(String orderNo) {
		OrderNo = orderNo;
	}

	public String getStationName() {
		return StationName;
	}

	public void setStationName(String stationName) {
		StationName = stationName;
	}

	public String getNodeName() {
		return NodeName;
	}

	public void setNodeName(String nodeName) {
		NodeName = nodeName;
	}

	public String getSchCode() {
		return SchCode;
	}

	public void setSchCode(String schCode) {
		SchCode = schCode;
	}

	public String getSchDate() {
		return SchDate;
	}

	public void setSchDate(String schDate) {
		SchDate = schDate;
	}

	public String getSchTime() {
		return SchTime;
	}

	public void setSchTime(String schTime) {
		SchTime = schTime;
	}

	public float getFare() {
		return Fare;
	}

	public void setFare(float fare) {
		Fare = fare;
	}

	public int getSeat() {
		return Seat;
	}

	public void setSeat(int seat) {
		Seat = seat;
	}

	public int getPrintFlag() {
		return PrintFlag;
	}

	public void setPrintFlag(int printFlag) {
		PrintFlag = printFlag;
	}

	private String TicketID;// 车票ID
	private String OrderNo;// 订单号
	private String StationName;// 车站名称
	private String NodeName;// 站点名称
	private String SchCode;// 班次代码
	private String SchDate;// 班次日期
	private String SchTime;// 班次时间
	private float Fare;// 票价
	private int Seat;// 座位
	private int PrintFlag;// 打印标记

}
