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
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.base.model.Ticketoutlets;
import cn.nova.bus.base.service.TicketoutletService;
import cn.nova.bus.base.service.impl.TicketoutletServiceImpl;
import cn.nova.bus.exception.ServiceException;
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
public class TicketoutletAction extends BaseAction{

	private List<Map<String, Object>> ticketoutletmap;
	// private Page<ticketoutlet> page = new Page<ticketoutlet>(5);//每页5条记录
	private Ticketoutlets ticketoutlet;
	private List<Ticketoutlets> ticketoutletlist;
	private long id;
	
	private TicketoutletService ticketoutletService;

	public String save() {
		Global global = CurrentUtil.getGlobal();
		if (ticketoutlet != null) {
			if ( ticketoutlet.getId() != -1) {
				msg = "修改成功！";
				markSuccess();
				ticketoutlet.setUpdateby(global.getUserinfo().getId());
				ticketoutlet.setUpdatetime(new Timestamp(System
						.currentTimeMillis()));
			} else {
				msg = "添加成功！";
				markSuccess();
				ticketoutlet.setCreateby(global.getUserinfo().getId());
//				ticketoutlet.setCode(global.getOrganization().getCode());
				ticketoutlet.setCreatetime(new Timestamp(System
						.currentTimeMillis()));
				ticketoutlet.setUpdateby(global.getUserinfo().getId());
				ticketoutlet.setUpdatetime(new Timestamp(System
						.currentTimeMillis()));
			}
			try {
				ticketoutletService = new TicketoutletServiceImpl();
				ticketoutlet = ticketoutletService.save(ticketoutlet);
				setId(ticketoutlet.getId());
			} catch (ServiceException e) {
				markFail();
				setMsg(e.getMessage());
				play.Logger.error(e.getMessage(), e);
			}
		}
		return "json";
	}

	public String list() {
		try {
			ticketoutletService = new TicketoutletServiceImpl();
			setTicketoutletmap(ticketoutletService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String delete() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (ticketoutlet.getId() > 0) {
				ticketoutletService = new TicketoutletServiceImpl();
				Ticketoutlets ticket = ticketoutletService.findById(ticketoutlet
						.getId());
				ticket.setIsactive(false);
				ticket.setUpdateby(global.getUserinfo().getId());
				ticket.setUpdatetime(new Date());
				ticketoutlet = ticketoutletService.save(ticket);
				if (ticketoutlet.getId() > 0) {
					msg = "删除成功！";
					markSuccess();
				} else {
					msg = "删除失败！";
					markFail();
				}
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg(e.getMessage());
		}
		return "json";
	}

	public List<Map<String, Object>> getTicketoutletmap() {
		return ticketoutletmap;
	}

	public void setTicketoutletmap(List<Map<String, Object>> ticketoutletmap) {
		this.ticketoutletmap = ticketoutletmap;
	}

	public Ticketoutlets getTicketoutlet() {
		return ticketoutlet;
	}

	public void setTicketoutlet(Ticketoutlets ticketoutlet) {
		this.ticketoutlet = ticketoutlet;
	}

	public List<Ticketoutlets> getTicketoutletlist() {
		return ticketoutletlist;
	}

	public void setTicketoutletlist(List<Ticketoutlets> ticketoutletlist) {
		this.ticketoutletlist = ticketoutletlist;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
