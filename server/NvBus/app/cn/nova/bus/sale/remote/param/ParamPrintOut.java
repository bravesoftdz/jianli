package cn.nova.bus.sale.remote.param;

import cn.nova.utils.commons.MethodResult;

public class ParamPrintOut extends MethodResult{
	/**
	 * 
	 */
	private static final long serialVersionUID = -947389947050769501L;
	private String StationCode;// 车站代码
	private String StationName;// 车站名称
	private String NodeCode;// 站点代码
	private String NodeName;// 站点名称
	private String LineCode;// 线路代码
	private String LineName;// 线路名称
	private String LineType;// 线路类型
	private String SchCode;// 班次代码
	private String SchName;// 班次名称
	private String SchType;// 班次类型
	private String SchDate;// 班次日期
	private String SchTime;// 班次时间
	private String TicketType;// 票型
	private float Fare;// 票价
	private float BAFare;// 燃油附加费
	private float TopFare;// 票价上限
	private int Seat;// 座位
	private String BusType;// 车型
	private String BusPark;// 停车位
	private String Wicket;// 检票口
	private String TicketNo;// 票号
	private String Barcode;// 条码号
	private String CustPin;// 验证码
	private String OpTime;// 售票时间
	private String OperCode;// 售票工号

	public String getStationCode() {
		return StationCode;
	}

	public void setStationCode(String stationCode) {
		StationCode = stationCode;
	}

	public String getStationName() {
		return StationName;
	}

	public void setStationName(String stationName) {
		StationName = stationName;
	}

	public String getNodeCode() {
		return NodeCode;
	}

	public void setNodeCode(String nodeCode) {
		NodeCode = nodeCode;
	}

	public String getNodeName() {
		return NodeName;
	}

	public void setNodeName(String nodeName) {
		NodeName = nodeName;
	}

	public String getLineCode() {
		return LineCode;
	}

	public void setLineCode(String lineCode) {
		LineCode = lineCode;
	}

	public String getLineName() {
		return LineName;
	}

	public void setLineName(String lineName) {
		LineName = lineName;
	}

	public String getLineType() {
		return LineType;
	}

	public void setLineType(String lineType) {
		LineType = lineType;
	}

	public String getSchCode() {
		return SchCode;
	}

	public void setSchCode(String schCode) {
		SchCode = schCode;
	}

	public String getSchName() {
		return SchName;
	}

	public void setSchName(String schName) {
		SchName = schName;
	}

	public String getSchType() {
		return SchType;
	}

	public void setSchType(String schType) {
		SchType = schType;
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

	public String getTicketType() {
		return TicketType;
	}

	public void setTicketType(String ticketType) {
		TicketType = ticketType;
	}

	public float getFare() {
		return Fare;
	}

	public void setFare(float fare) {
		Fare = fare;
	}

	public float getBAFare() {
		return BAFare;
	}

	public void setBAFare(float bAFare) {
		BAFare = bAFare;
	}

	public float getTopFare() {
		return TopFare;
	}

	public void setTopFare(float topFare) {
		TopFare = topFare;
	}

	public int getSeat() {
		return Seat;
	}

	public void setSeat(int seat) {
		Seat = seat;
	}

	public String getBusType() {
		return BusType;
	}

	public void setBusType(String busType) {
		BusType = busType;
	}

	public String getBusPark() {
		return BusPark;
	}

	public void setBusPark(String busPark) {
		BusPark = busPark;
	}

	public String getWicket() {
		return Wicket;
	}

	public void setWicket(String wicket) {
		Wicket = wicket;
	}

	public String getTicketNo() {
		return TicketNo;
	}

	public void setTicketNo(String ticketNo) {
		TicketNo = ticketNo;
	}

	public String getBarcode() {
		return Barcode;
	}

	public void setBarcode(String barcode) {
		Barcode = barcode;
	}

	public String getCustPin() {
		return CustPin;
	}

	public void setCustPin(String custPin) {
		CustPin = custPin;
	}

	public String getOpTime() {
		return OpTime;
	}

	public void setOpTime(String opTime) {
		OpTime = opTime;
	}

	public String getOperCode() {
		return OperCode;
	}

	public void setOperCode(String operCode) {
		OperCode = operCode;
	}
}
