package cn.nova.bus.price.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Ticketpriceformula;
import cn.nova.bus.price.service.TicketpriceformulaService;
import cn.nova.bus.price.service.impl.TicketpriceformulaServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class TicketpriceformulaAction extends BaseAction{
	private Ticketpriceformula ticketpriceformula;
	private List<Map<String, Object>> ticketpriceformulalist;
	private List<Map<String, Object>> ticketpriceformulaitemlist;
	private List<Map<String, Object>> msglist;

	private String orgids;

	public String getOrgids() {
		return orgids;
	}

	public void setOrgids(String orgids) {
		this.orgids = orgids;
	}

	private TicketpriceformulaService ticketpriceformulaService;

	public String query() {
		try {
			ticketpriceformulaService = new TicketpriceformulaServiceImpl();
			setTicketpriceformulalist(ticketpriceformulaService
					.query(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String queryitem() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				ticketpriceformulaService = new TicketpriceformulaServiceImpl();
				setTicketpriceformulaitemlist(ticketpriceformulaService
						.queryitem(orgids));
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 保存
	public String saveformula() {
		Global global = CurrentUtil.getGlobal();
		try {
			ticketpriceformulaService = new TicketpriceformulaServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if (ticketpriceformula != null) {
					if (ticketpriceformula.getId() != 0) {
						ticketpriceformula.setUpdateby(global.getUserinfo().getId());
						ticketpriceformula.setUpdatetime(new Date());
						setMsg("修改成功！");
						markSuccess();
					} else {
						ticketpriceformula.setCreateby(global.getUserinfo().getId());
						ticketpriceformula.setCreatetime(new Date());
						ticketpriceformula.setUpdateby(global.getUserinfo().getId());
						ticketpriceformula.setUpdatetime(new Date());
						setMsg("添加成功！");
						markSuccess();
					}
				}
				ticketpriceformula.setIsactive(true);
				//ticketpriceformula.setOrgid(global.getOrganization().getId());
				ticketpriceformulaService
						.saveTicketpriceformula(ticketpriceformula);
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}

	// 删除
	public String delformula() {
		Global global = CurrentUtil.getGlobal();
		try {
			ticketpriceformulaService = new TicketpriceformulaServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				ticketpriceformula.setUpdateby(global.getUserinfo().getId());
				if (ticketpriceformulaService
						.delTicketpriceformula(ticketpriceformula)) {
					setMsg("删除成功！");
					markSuccess();
				}
			}
		} catch (ServiceException ex) {
			msg = ex.getMessage();
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}

	// 生成标准票价
	public String generateTicketprice() {
		Global global = CurrentUtil.getGlobal();
		try {
			ticketpriceformulaService = new TicketpriceformulaServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				ticketpriceformula.setUpdateby(global.getUserinfo().getId());
				setMsglist(ticketpriceformulaService.generateTicketprice(
						ticketpriceformula.getOrgid(), new Date(),
						global.getUserinfo().getId()));
				markSuccess();
			}
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}

	public Ticketpriceformula getTicketpriceformula() {
		return ticketpriceformula;
	}

	public void setTicketpriceformula(Ticketpriceformula ticketpriceformula) {
		this.ticketpriceformula = ticketpriceformula;
	}

	public List<Map<String, Object>> getTicketpriceformulalist() {
		return ticketpriceformulalist;
	}

	public void setTicketpriceformulalist(
			List<Map<String, Object>> ticketpriceformulalist) {
		this.ticketpriceformulalist = ticketpriceformulalist;
	}

	public List<Map<String, Object>> getTicketpriceformulaitemlist() {
		return ticketpriceformulaitemlist;
	}

	public void setTicketpriceformulaitemlist(
			List<Map<String, Object>> ticketpriceformulaitemlist) {
		this.ticketpriceformulaitemlist = ticketpriceformulaitemlist;
	}

	public List<Map<String, Object>> getMsglist() {
		return msglist;
	}

	public void setMsglist(List<Map<String, Object>> msglist) {
		this.msglist = msglist;
	}
}
