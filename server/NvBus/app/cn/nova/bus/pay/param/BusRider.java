package cn.nova.bus.pay.param;

import java.math.BigDecimal;

public class BusRider {

	private static final long serialVersionUID = -8326667493922283590L;
	/**
	 *  fullprice	全票价	Integer	全票价	必填	分 20000
		haschildren	是否带儿童	Boolean	是否带儿童	可选	false
		ridercertnumber	证件号码	String	证件号码	可选	1111
		ridercerttype	证件类型	String	证件类型	可选	01
		ridername	姓名	String	姓名	可选	张三
		seatnumber	座位号	String	座位号	可选	46
		servicecharge	服务费	Integer	服务费	可选	分 300
		ticketprice	该张票价	Integer	该张票价	必填	分9000

	 */
	private BigDecimal fullprice;
	private Boolean haschildren;
	private String ridercertnumber;
	private String ridercerttype;
	private String ridername;
	private String seatnumber;
	private BigDecimal servicecharge;
	private BigDecimal ticketprice;
	
	public Boolean getHaschildren() {
		return haschildren;
	}
	public void setHaschildren(Boolean haschildren) {
		this.haschildren = haschildren;
	}
	public String getRidercertnumber() {
		return ridercertnumber;
	}
	public void setRidercertnumber(String ridercertnumber) {
		this.ridercertnumber = ridercertnumber;
	}
	public String getRidercerttype() {
		return ridercerttype;
	}
	public void setRidercerttype(String ridercerttype) {
		this.ridercerttype = ridercerttype;
	}
	public String getRidername() {
		return ridername;
	}
	public void setRidername(String ridername) {
		this.ridername = ridername;
	}
	public String getSeatnumber() {
		return seatnumber;
	}
	public void setSeatnumber(String seatnumber) {
		this.seatnumber = seatnumber;
	}
	public BigDecimal getFullprice() {
		return fullprice;
	}
	public void setFullprice(BigDecimal fullprice) {
		this.fullprice = fullprice;
	}
	public BigDecimal getServicecharge() {
		return servicecharge;
	}
	public void setServicecharge(BigDecimal servicecharge) {
		this.servicecharge = servicecharge;
	}
	public BigDecimal getTicketprice() {
		return ticketprice;
	}
	public void setTicketprice(BigDecimal ticketprice) {
		this.ticketprice = ticketprice;
	}
		
}
