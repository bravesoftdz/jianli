package cn.nova.bus.pay.param;

import java.io.Serializable;

/**
 * 
 *  full_price	全票价	Integer	全票价	必填	分 20000
	has_children	是否带儿童	Boolean	是否带儿童	可选	false
	rider_cert_number	证件号码	String	证件号码	可选	1111
	rider_cert_type	证件类型	String	证件类型	可选	01
	rider_name	姓名	String	姓名	可选	张三
	seat_number	座位号	String	座位号	可选	46
	service_charge	服务费	Integer	服务费	可选	分 300
	ticket_price	该张票价	Integer	该张票价	必填	分9000
 */

public class TvmPassengerVo implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private Integer full_price;
	private Boolean has_children;
	private String rider_cert_number;
	private String rider_cert_type;
	private String rider_name;
	private String seat_number;
	private Integer service_charge;
	private Integer ticket_price;
	public Integer getFull_price() {
		return full_price;
	}
	public void setFull_price(Integer full_price) {
		this.full_price = full_price;
	}
	public Boolean getHas_children() {
		return has_children;
	}
	public void setHas_children(Boolean has_children) {
		this.has_children = has_children;
	}
	public String getRider_cert_number() {
		return rider_cert_number;
	}
	public void setRider_cert_number(String rider_cert_number) {
		this.rider_cert_number = rider_cert_number;
	}
	public String getRider_cert_type() {
		return rider_cert_type;
	}
	public void setRider_cert_type(String rider_cert_type) {
		this.rider_cert_type = rider_cert_type;
	}
	public String getRider_name() {
		return rider_name;
	}
	public void setRider_name(String rider_name) {
		this.rider_name = rider_name;
	}
	public String getSeat_number() {
		return seat_number;
	}
	public void setSeat_number(String seat_number) {
		this.seat_number = seat_number;
	}
	public Integer getService_charge() {
		return service_charge;
	}
	public void setService_charge(Integer service_charge) {
		this.service_charge = service_charge;
	}
	public Integer getTicket_price() {
		return ticket_price;
	}
	public void setTicket_price(Integer ticket_price) {
		this.ticket_price = ticket_price;
	}
	
}
