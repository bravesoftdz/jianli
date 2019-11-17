package cn.nova.bus.sale.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.model.Ticketdeliverdetail;
import cn.nova.bus.sale.service.TicketdeliverdetailService;
import cn.nova.bus.sale.service.impl.TicketdeliverdetailServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class TicketdeliverdetailAction extends BaseAction{
	private Ticketdeliverdetail ticketdeliverdetail;
	private List<Map<String, Object>> detailmap;
	private int count;
	private Long deliverid;

	private TicketdeliverdetailService detailService;

	public String query() {
		try {
			detailService = new TicketdeliverdetailServiceImpl();
			setDetailmap(detailService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		detailService = new TicketdeliverdetailServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (ticketdeliverdetail != null) {
				if (ticketdeliverdetail.getId() > 0) {
					setMsg("修改成功！");
					markSuccess();
				} else {
					ticketdeliverdetail.setCreateby(global.getUserinfo()
							.getId());
					ticketdeliverdetail.setCreatetime(new Date());
					setMsg("增加成功！");
					markSuccess();
				}
				ticketdeliverdetail = detailService.save(ticketdeliverdetail,
						count);
				setDeliverid(ticketdeliverdetail.getDeliverid());
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg(e.getMessage());
			markSuccess();
		}
		return "json";
	}

	public String delete() {
		detailService = new TicketdeliverdetailServiceImpl();
		try {
			if (ticketdeliverdetail != null) {
				if (ticketdeliverdetail.getId() > 0) {
					boolean result = detailService.delete(ticketdeliverdetail
							.getId());
					if (result) {
						setMsg("删除成功");
						markSuccess();
					} else {
						setMsg("删除操作失败");
						markSuccess();
					}
				}
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("删除异常:" + e.getMessage());
			markSuccess();
		}
		return "json";
	}

	public Ticketdeliverdetail getTicketdeliverdetail() {
		return ticketdeliverdetail;
	}

	public void setTicketdeliverdetail(Ticketdeliverdetail ticketdeliverdetail) {
		this.ticketdeliverdetail = ticketdeliverdetail;
	}

	public List<Map<String, Object>> getDetailmap() {
		return detailmap;
	}

	public void setDetailmap(List<Map<String, Object>> detailmap) {
		this.detailmap = detailmap;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public Long getDeliverid() {
		return deliverid;
	}

	public void setDeliverid(Long deliverid) {
		this.deliverid = deliverid;
	}

}
