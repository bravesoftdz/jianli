package cn.nova.bus.sale.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.sale.model.Ticketdeliver;
import cn.nova.bus.sale.service.TicketdeliverService;
import cn.nova.bus.sale.service.impl.TicketdeliverServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class TicketdeliverAction extends BaseAction{
	private Ticketdeliver ticketdeliver;
	private List<Map<String, Object>> ticketdelivermap;
	private Long id;

	private TicketdeliverService ticketdeliverService;

	/**
	 * 查询送票记录
	 * @return
	 */
	public String query() {
		try {
			ticketdeliverService = new TicketdeliverServiceImpl();
			setTicketdelivermap(ticketdeliverService
					.query(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		ticketdeliverService = new TicketdeliverServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (ticketdeliver != null) {
				if (ticketdeliver.getId() > 0) {
					ticketdeliver.setUpdatetime(new Date());
					ticketdeliver.setUpdateby(global.getUserinfo().getId());
					setMsg("修改成功!");
					markSuccess();
				} else {
					ticketdeliver.setIsturnover(false);
					ticketdeliver.setTurnoverid(null);
					ticketdeliver.setCreatetime(new Date());
					ticketdeliver.setUpdatetime(new Date());
					ticketdeliver.setDeliverdate(new Date());
					ticketdeliver.setCreateby(global.getUserinfo().getId());
					ticketdeliver.setUpdateby(global.getUserinfo().getId());
					ticketdeliver.setOrgid(global.getOrganization().getId());
					setMsg("增加成功!");
					markSuccess();
				}
				ticketdeliver = ticketdeliverService.save(ticketdeliver);
				setId(ticketdeliver.getId());
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("操作异常：" + e.getMessage());
			markSuccess();
		}
		return "json";
	}

	public String delete() {
		ticketdeliverService = new TicketdeliverServiceImpl();
		try {
			if (ticketdeliver != null) {
				if (ticketdeliver.getId() > 0) {
					boolean result = ticketdeliverService.delete(ticketdeliver
							.getId());
					if (result) {
						setMsg("删除成功");
						markSuccess();
					} else {
						setMsg("删除操作失败!");
						markSuccess();
					}
				}
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("删除失败:" + e.getMessage());
			markSuccess();
		}
		return "json";
	}

	public Ticketdeliver getTicketdeliver() {
		return ticketdeliver;
	}

	public void setTicketdeliver(Ticketdeliver ticketdeliver) {
		this.ticketdeliver = ticketdeliver;
	}

	public List<Map<String, Object>> getTicketdelivermap() {
		return ticketdelivermap;
	}

	public void setTicketdelivermap(List<Map<String, Object>> ticketdelivermap) {
		this.ticketdelivermap = ticketdelivermap;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
