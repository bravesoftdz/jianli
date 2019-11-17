package cn.nova.bus.base.action;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.base.dao.TicketoutletctrDao;
import cn.nova.bus.base.model.Ticketoutletsctr;
import cn.nova.bus.base.service.TicketoutletctrService;
import cn.nova.bus.base.service.impl.InsuretypedetailServiceImpl;
import cn.nova.bus.base.service.impl.TicketoutletServiceImpl;
import cn.nova.bus.base.service.impl.TicketoutletctrServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;



public class TicketoutletsctrAtion extends BaseAction{
	private TicketoutletctrService ticketoutletctrService;
	private List<Map<String, Object>> ticketoutletsctrmap;
	private Ticketoutletsctr ticketoutletctr;
	
	public String queryTicketoutletsctr() {
		try {
			ticketoutletctrService = new TicketoutletctrServiceImpl();
			setTicketoutletsctrmap(ticketoutletctrService.queryTicketoutletsctr(ServletPropertyFilterUtil.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String saveTicketoutletsctr() {
		Global global = CurrentUtil.getGlobal();
		if (ticketoutletctr != null) {
			Date now=new Date();
			if ( ticketoutletctr.getId() != -1) {
				msg = "修改成功！";
				ticketoutletctr.setUpdateby(global.getUserinfo().getId());
				ticketoutletctr.setUpdatetime(now);
			} else {
				msg = "添加成功！";
				ticketoutletctr.setCreateby(global.getUserinfo().getId());
				ticketoutletctr.setCreatetime(now);
				ticketoutletctr.setUpdateby(global.getUserinfo().getId());
				ticketoutletctr.setUpdatetime(now);
			}
			try {
				ticketoutletctrService = new TicketoutletctrServiceImpl();
				ticketoutletctr = ticketoutletctrService.save(ticketoutletctr);
				markSuccess();
			} catch (ServiceException e) {
				setMsg("保存操作失败，"+e.getExceptionMessage());
				markFail();
				play.Logger.error(e.getMessage(), e);
			}
		}
		return "json";
	}
	
	public String delTicketoutletsctr() {
		try {
			ticketoutletctrService = new TicketoutletctrServiceImpl();
			ticketoutletctr = ticketoutletctrService.delete(ticketoutletctr);
			msg = "删除成功！";
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("删除操作失败，"+e.getMessage());
			markFail();
		}
		return "json";
	}
	
	public List<Map<String, Object>> getTicketoutletsctrmap() {
		return ticketoutletsctrmap;
	}
	public void setTicketoutletsctrmap(List<Map<String, Object>> ticketoutletsctrmap) {
		this.ticketoutletsctrmap = ticketoutletsctrmap;
	}
	public Ticketoutletsctr getTicketoutletctr() {
		return ticketoutletctr;
	}
	public void setTicketoutletctr(Ticketoutletsctr ticketoutletctr) {
		this.ticketoutletctr = ticketoutletctr;
	}
	
}
