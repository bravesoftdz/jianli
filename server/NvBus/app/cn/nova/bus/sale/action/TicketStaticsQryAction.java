package cn.nova.bus.sale.action;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.sale.service.TicketStaticsQryService;
import cn.nova.bus.sale.service.impl.TicketStaticsQryServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class TicketStaticsQryAction extends BaseAction{

	private List<Map<String,Object>> staticsticketMap;
	private TicketStaticsQryService service;
	
	private int sellticketunit;
	private Date beginselltime;
	private Date endselltime;
	
	public String query(){
		try {
		  service = new TicketStaticsQryServiceImpl();
		  setStaticsticketMap(service.query(sellticketunit,beginselltime,endselltime));
		}catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}


	public int getSellticketunit() {
		return sellticketunit;
	}

	public void setSellticketunit(int sellticketunit) {
		this.sellticketunit = sellticketunit;
	}

	public Date getBeginselltime() {
		return beginselltime;
	}

	public void setBeginselltime(Date beginselltime) {
		this.beginselltime = beginselltime;
	}

	public Date getEndselltime() {
		return endselltime;
	}

	public void setEndselltime(Date endselltime) {
		this.endselltime = endselltime;
	}


	public List<Map<String, Object>> getStaticsticketMap() {
		return staticsticketMap;
	}

	public void setStaticsticketMap(List<Map<String, Object>> staticsticketMap) {
		this.staticsticketMap = staticsticketMap;
	}
	
}
