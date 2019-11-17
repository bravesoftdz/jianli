package cn.nova.bus.sale.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.model.Ticketsign;
import cn.nova.bus.sale.service.TicketsignService;
import cn.nova.bus.sale.service.impl.TicketsignServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.jpa.ListUtil;

public class TicketsignAction extends BaseAction{
	private List<Map<String,Object>> ticketsignquery;
	private List<Ticketsign> ticketsigns;
	
	public String findEmpty(){
		setTicketsignquery(ListUtil.listToMap(new Object[]{Ticketsign.class}, null));
		markSuccess();
		setMsg("");
		return "json";
	}

	public String sign(){
		try {
			Global global = CurrentUtil.getGlobal();
			Date now = new Date();
			for (Ticketsign ticketsign : getTicketsigns()) {
				ticketsign.setSignby(global.getUserinfo().getId());
				ticketsign.setSigntime(now);
			}
			TicketsignService ticketsignService = new TicketsignServiceImpl();
			ticketsignService.sign(getTicketsigns());
			markSuccess();
			setMsg("");
		} catch (ServiceException e) {
			markFailure();
			setMsg("签定手续费率失败:"+e.getMessage());
		} catch (Exception e) {
			markFailure();
			setMsg("签定手续费率失败:"+e.getMessage());
		}
		return "json";
	}
	
	public void setTicketsignquery(List<Map<String,Object>> ticketsignquery) {
		this.ticketsignquery = ticketsignquery;
	}

	public List<Map<String,Object>> getTicketsignquery() {
		return ticketsignquery;
	}

	public void setTicketsigns(List<Ticketsign> ticketsigns) {
		this.ticketsigns = ticketsigns;
	}

	public List<Ticketsign> getTicketsigns() {
		return ticketsigns;
	}

}
