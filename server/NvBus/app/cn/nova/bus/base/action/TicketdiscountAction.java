/**
 * <b>项目名：</b>NvBusWeb<br/>
 * <b>包名：</b>cn.nova.bus.base.action<br/>
 * <b>文件名：</b>Ticketdiscount.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2013-1-9 上午10:05:03<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.base.model.Ticketdiscount;
import cn.nova.bus.base.service.TicketdiscountService;
import cn.nova.bus.base.service.impl.TicketdiscountServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>Ticketdiscount.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2013-1-9 上午10:05:03<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("serial")
public class TicketdiscountAction extends BaseAction{

	private Ticketdiscount ticketdiscount;
	private Long id;
	private List<Map<String, Object>> discountMap;
	private TicketdiscountService ticketdiscountService;

	public String query() {
		try {
			ticketdiscountService = new TicketdiscountServiceImpl();
			setDiscountMap(ticketdiscountService
					.query(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String saveAction() {
		ticketdiscountService = new TicketdiscountServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (ticketdiscount != null) {
				if (ticketdiscount.getId() == 0) {
					setMsg("添加成功!");
					markSuccess();
				} else {
					setMsg("修改成功!");
					markSuccess();
				}
				setId(ticketdiscountService.save(ticketdiscount, global).getId());
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getExceptionMessage());
		} catch (Exception e) {
			markFail();
			setMsg(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String delete() {
		if (ticketdiscount != null) {
			try {
				ticketdiscountService = new TicketdiscountServiceImpl();
				if (ticketdiscountService.delete(ticketdiscount.getId())) {
					setMsg("删除成功!");
					markSuccess();
				} else {
					setMsg("删除失败!");
					markSuccess();
				}
			} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
				setMsg(e.getMessage());
				markFail();
			}
		}
		return "json";
	}

	public Ticketdiscount getTicketdiscount() {
		return ticketdiscount;
	}

	public void setTicketdiscount(Ticketdiscount ticketdiscount) {
		this.ticketdiscount = ticketdiscount;
	}

	public List<Map<String, Object>> getDiscountMap() {
		return discountMap;
	}

	public void setDiscountMap(List<Map<String, Object>> discountMap) {
		this.discountMap = discountMap;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
