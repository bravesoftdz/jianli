package cn.nova.bus.price.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Ticketpriceformulaitem;
import cn.nova.bus.price.service.TicketpriceformulaitemService;
import cn.nova.bus.price.service.impl.TicketpriceformulaitemServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;
public class TicketpriceformulaitemAction extends BaseAction{

	private Ticketpriceformulaitem ticketpriceformulaitem;
	private List<Map<String, Object>> ticketpriceformulaitemlist;
	private Long formulaitemid;
	public Long getFormulaitemid() {
		return formulaitemid;
	}
	public void setFormulaitemid(Long formulaitemid) {
		this.formulaitemid = formulaitemid;
	}

	private TicketpriceformulaitemService ticketpriceformulaitemService;

	public String query() {
		try {
			ticketpriceformulaitemService = new TicketpriceformulaitemServiceImpl();
			setTicketpriceformulaitemlist(ticketpriceformulaitemService.query(ServletPropertyFilterUtil.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String saveTicketpriceformulaitem() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (ticketpriceformulaitem != null) {
					if (ticketpriceformulaitem.getId() != 0) {
						ticketpriceformulaitem.setUpdateby(global.getUserinfo().getId());
						setMsg("修改成功！");
						markSuccess();
					} else {
						ticketpriceformulaitem.setCreateby(global.getUserinfo().getId());						
						ticketpriceformulaitem.setUpdateby(global.getUserinfo().getId());
						setMsg("添加成功！");
						markSuccess();
					}
					//ticketpriceformulaitem.setOrgid(global.getOrganization().getId());
					ticketpriceformulaitemService = new TicketpriceformulaitemServiceImpl();
					ticketpriceformulaitem=ticketpriceformulaitemService.save(ticketpriceformulaitem);
					formulaitemid=ticketpriceformulaitem.getId();
				}
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

	public String delTicketpriceformulaitem() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				ticketpriceformulaitemService = new TicketpriceformulaitemServiceImpl();
				if (ticketpriceformulaitemService.delete(ticketpriceformulaitem.getId(),
						global.getUserinfo().getId())) {
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
	
	@Transient
	public Ticketpriceformulaitem getTicketpriceformulaitem() {
		return ticketpriceformulaitem;
	}

	public void setTicketpriceformulaitem(
			Ticketpriceformulaitem ticketpriceformulaitem) {
		this.ticketpriceformulaitem = ticketpriceformulaitem;
	}

	public List<Map<String, Object>> getTicketpriceformulaitemlist() {
		return ticketpriceformulaitemlist;
	}

	public void setTicketpriceformulaitemlist(
			List<Map<String, Object>> ticketpriceformulaitemlist) {
		this.ticketpriceformulaitemlist = ticketpriceformulaitemlist;
	}

}
