package cn.nova.bus.insure.model;

import java.math.BigDecimal;
import java.util.List;


/**
 * 售保险票订单，用做售保险票方法的参数
 * @author ice
 *
 */
public class InsuranceOrder {
	private long seller;
	private long orgid;
	private String startTicketNO;
	private BigDecimal totalmoney;
	private String ip;
	private long ticketoutletsid;
	private String sellway;
	private List<InsurancePrintInfo> insurances;
	private String orderno;
	public long getSeller() {
		return seller;
	}
	public void setSeller(long seller) {
		this.seller = seller;
	}
	public String getStartTicketNO() {
		return startTicketNO;
	}
	public void setStartTicketNO(String startTicketNO) {
		this.startTicketNO = startTicketNO;
	}
	public BigDecimal getTotalmoney() {
		return totalmoney;
	}
	public void setTotalmoney(BigDecimal totalmoney) {
		this.totalmoney = totalmoney;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public long getTicketoutletsid() {
		return ticketoutletsid;
	}
	public void setTicketoutletsid(long ticketoutletsid) {
		this.ticketoutletsid = ticketoutletsid;
	}
	public String getSellway() {
		return sellway;
	}
	public void setSellway(String sellway) {
		this.sellway = sellway;
	}
	public List<InsurancePrintInfo> getInsurances() {
		return insurances;
	}
	public void setInsurances(List<InsurancePrintInfo> insurances) {
		this.insurances = insurances;
	}
	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}
	public long getOrgid() {
		return orgid;
	}
	public String getOrderno() {
		return orderno;
	}
	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}
	
}
