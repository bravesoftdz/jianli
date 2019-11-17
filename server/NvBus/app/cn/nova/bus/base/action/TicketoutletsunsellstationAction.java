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
import cn.nova.bus.base.model.Ticketoutletsunsellstation;
import cn.nova.bus.base.service.TicketoutletsunsellstationService;
import cn.nova.bus.base.service.impl.TicketoutletsunsellstationServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b> <b>类名称：售票点不可售站点控制</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-8-11 下午02:38:39 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class TicketoutletsunsellstationAction extends BaseAction{

	private Ticketoutletsunsellstation ticketoutletsunsellstation;
	private Long id;
	private List<Map<String, Object>> ticketstationtmap;
	private List<Schedulediscount> ticketstationlist;
	private String ticketoutletsids;

	private TicketoutletsunsellstationService ticketstationService;

	public String query() {
		try {
			ticketstationService = new TicketoutletsunsellstationServiceImpl();
			setTicketstationtmap(ticketstationService.query(ServletPropertyFilterUtil.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		ticketstationService = new TicketoutletsunsellstationServiceImpl();
		Global global = CurrentUtil.getGlobal();
		if (ticketoutletsunsellstation != null) {
			try {
				if (ticketoutletsunsellstation.getId() > 0) {
					markSuccess();
					msg = "修改成功";

					ticketoutletsunsellstation.setUpdateby(global.getUserinfo().getId());
					ticketoutletsunsellstation.setUpdatetime(new Timestamp(
							System.currentTimeMillis()));
				} else {
					markSuccess();
					msg = "添加成功";

					ticketoutletsunsellstation.setCreateby(global.getUserinfo().getId());
					ticketoutletsunsellstation.setUpdateby(global.getUserinfo().getId());
					ticketoutletsunsellstation.setCreatetime(new Timestamp(
							System.currentTimeMillis()));
					ticketoutletsunsellstation.setUpdatetime(new Timestamp(
							System.currentTimeMillis()));
					boolean isExist = ticketstationService.equals(ticketoutletsunsellstation);
					if (isExist) {
						markFail();
						msg = "相同售票点的同一班线类型所控制的停靠点,有效期不能交叉!";
						return "json";
					}
				}
				ticketstationService.save(ticketoutletsunsellstation,ticketoutletsids);
//				setId(ticketoutletsunsellstation.getId());
			} catch (Exception e) {
				markFail();
				msg = "操作失败！";
				play.Logger.error(e.getMessage(), e);
			}
		}
		return "json";
	}

	public String delete() {
		ticketstationService = new TicketoutletsunsellstationServiceImpl();
		if (ticketoutletsunsellstation != null) {
			if (ticketoutletsunsellstation.getId() > 0) {
				markSuccess();
				msg = "删除成功";
			} else {
				markFail();
				msg = "删除失败";
			}
			if (!ticketstationService.delete(ticketoutletsunsellstation)) {
				markFail();
				msg = "删除失败";
			}
		}
		return "json";
	}

	public Ticketoutletsunsellstation getTicketoutletsunsellstation() {
		return ticketoutletsunsellstation;
	}

	public void setTicketoutletsunsellstation(
			Ticketoutletsunsellstation ticketoutletsunsellstation) {
		this.ticketoutletsunsellstation = ticketoutletsunsellstation;
	}

	public List<Map<String, Object>> getTicketstationtmap() {
		return ticketstationtmap;
	}

	public void setTicketstationtmap(List<Map<String, Object>> ticketstationtmap) {
		this.ticketstationtmap = ticketstationtmap;
	}

	public List<Schedulediscount> getTicketstationlist() {
		return ticketstationlist;
	}

	public void setTicketstationlist(List<Schedulediscount> ticketstationlist) {
		this.ticketstationlist = ticketstationlist;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTicketoutletsids() {
		return ticketoutletsids;
	}

	public void setTicketoutletsids(String ticketoutletsids) {
		this.ticketoutletsids = ticketoutletsids;
	}

}
