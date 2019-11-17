package cn.nova.bus.pay.param;

import java.io.Serializable;
import java.util.List;

/**
 *  machine_number	终端机编号	String	终端机编号	必填	001
	passengers	乘客	List<TvmPassengerVo>	乘客	必填	
	ticket_count	票总数量	Integer	票总数量	必填	2
	total_price	订单总价格，含服务费	Integer	订单总价格，含服务费	必填	分18000
	tvm_bus_line_info	班次信息	TvmBusLineInfo	班次信息	必填	
	real_name	实名标识	Boolean	实名标识	必填	true实名（必须传身份证），fasle非实名（非实名可以不传身份证信息）
 *
 */

public class TvmCreateOrderRq implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private String machine_number;
//	private Object[] passengers;
	private List<TvmPassengerVo> passengers;
	private Integer ticket_count;
	private Integer total_price;
	private TvmBusLineInfo tvm_bus_line_info;
	private Boolean real_name;
	private String trade_source;
	public String getMachine_number() {
		return machine_number;
	}
	public void setMachine_number(String machine_number) {
		this.machine_number = machine_number;
	}
	public List<TvmPassengerVo> getPassengers() {
		return passengers;
	}
	public void setPassengers(List<TvmPassengerVo> passengers) {
		this.passengers = passengers;
	}
	public Integer getTicket_count() {
		return ticket_count;
	}
	public void setTicket_count(Integer ticket_count) {
		this.ticket_count = ticket_count;
	}
	public Integer getTotal_price() {
		return total_price;
	}
	public void setTotal_price(Integer total_price) {
		this.total_price = total_price;
	}
	public TvmBusLineInfo getTvm_bus_line_info() {
		return tvm_bus_line_info;
	}
	public void setTvm_bus_line_info(TvmBusLineInfo tvm_bus_line_info) {
		this.tvm_bus_line_info = tvm_bus_line_info;
	}
	public Boolean getReal_name() {
		return real_name;
	}
	public void setReal_name(Boolean real_name) {
		this.real_name = real_name;
	}
	public String getTrade_source() {
		return trade_source;
	}
	public void setTrade_source(String trade_source) {
		this.trade_source = trade_source;
	}

	
}
