package cn.nova.bus.balance.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.service.impl.TicketFundsCheckServiceImpl;

public class TicketFundsCheckAction extends BaseAction{
	private TicketFundsCheckServiceImpl ticketFundsCheckService;
	// 返回结果
	private List<Map<String, Object>> resultmap;

	private String vehicleno;
	private Date balanceStartDate;
	private Date balanceEndDate;

	public String queryTicketFundsCheck(){
		ticketFundsCheckService = new TicketFundsCheckServiceImpl();
		try {
			setResultmap(ticketFundsCheckService.query(vehicleno, balanceStartDate, balanceEndDate));
		} catch(Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		
		return "json";
	}
	
	public Date getBalanceStartDate() {
		return balanceStartDate;
	}

	public void setBalanceStartDate(Date balanceStartDate) {
		this.balanceStartDate = balanceStartDate;
	}

	public Date getBalanceEndDate() {
		return balanceEndDate;
	}

	public void setBalanceEndDate(Date balanceEndDate) {
		this.balanceEndDate = balanceEndDate;
	}

	public String getVehicleno() {
		return vehicleno;
	}

	public void setVehicleno(String vehicleno) {
		this.vehicleno = vehicleno;
	}

	public List<Map<String, Object>> getResultmap() {
		return resultmap;
	}

	public void setResultmap(List<Map<String, Object>> resultmap) {
		this.resultmap = resultmap;
	}
}
