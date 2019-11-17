/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b><br/>
 * <b>文件名：</b>.java<br/>
 * <b>版本信息：</b>南凌客运信息管理系统 v4.0<br/>
 * <b>日期：</b> 2011-8-11 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 * 
 */
package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.base.model.Schedulediscount;
import cn.nova.bus.base.model.Ticketoutletssellschedule;
import cn.nova.bus.base.service.TicketoutletssellscheduleService;
import cn.nova.bus.base.service.impl.TicketoutletssellscheduleServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b> <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-8-11 下午02:38:39 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class TicketoutletssellscheduleAction extends BaseAction{

	private Ticketoutletssellschedule ticketoutletssellschedule;
	private Long id;
	private List<Map<String, Object>> ticketmap;
	private List<Schedulediscount> ticketlist;

	private TicketoutletssellscheduleService ticketService;

	public String query() {
		try {
			ticketService = new TicketoutletssellscheduleServiceImpl();
			setTicketmap(ticketService.query(ServletPropertyFilterUtil.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		ticketService = new TicketoutletssellscheduleServiceImpl();
		Global global = CurrentUtil.getGlobal();
		if (ticketoutletssellschedule != null) {
			try {
				if (ticketoutletssellschedule.getId() > 0) {
					markSuccess();
					msg = "修改成功";
					ticketoutletssellschedule.setUpdateby(global.getUserinfo().getId());
					ticketoutletssellschedule.setUpdatetime(new Timestamp(
							System.currentTimeMillis()));
				} else {
					markSuccess();
					msg = "添加成功";
					ticketoutletssellschedule.setCreateby(global.getUserinfo().getId());
					ticketoutletssellschedule.setUpdateby(global.getUserinfo().getId());
					ticketoutletssellschedule.setCreatetime(new Timestamp(
							System.currentTimeMillis()));
					ticketoutletssellschedule.setUpdatetime(new Timestamp(
							System.currentTimeMillis()));
					boolean isExist = ticketService.equals(
							ticketoutletssellschedule.getTicketoutletsid(),
							ticketoutletssellschedule.getType(),
							ticketoutletssellschedule.getTypeid());
					if (isExist) {
						markFail();
						msg = "该售票点对应的班线信息已经添加！";
						return "json";
					}
				}
				ticketoutletssellschedule = ticketService.save(ticketoutletssellschedule);
				setId(ticketoutletssellschedule.getId());
			} catch (Exception e) {
				markFail();
				msg = "操作失败！";
				play.Logger.error(e.getMessage(), e);
			}
		}
		return "json";
	}

	public String delete() {
		ticketService = new TicketoutletssellscheduleServiceImpl();
		if (ticketoutletssellschedule != null) {
			if (ticketoutletssellschedule.getId() > 0) {
				markSuccess();
				msg = "删除成功";
			} else {
				markFail();
				msg = "删除失败";
			}
			if (!ticketService.delete(ticketoutletssellschedule)) {
				markFail();
				msg = "删除失败";
			}
		}
		return "json";
	}

	public Ticketoutletssellschedule getTicketoutletssellschedule() {
		return ticketoutletssellschedule;
	}

	public void setTicketoutletssellschedule(
			Ticketoutletssellschedule ticketoutletssellschedule) {
		this.ticketoutletssellschedule = ticketoutletssellschedule;
	}

	public List<Map<String, Object>> getTicketmap() {
		return ticketmap;
	}

	public void setTicketmap(List<Map<String, Object>> ticketmap) {
		this.ticketmap = ticketmap;
	}

	public List<Schedulediscount> getTicketlist() {
		return ticketlist;
	}

	public void setTicketlist(List<Schedulediscount> ticketlist) {
		this.ticketlist = ticketlist;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
