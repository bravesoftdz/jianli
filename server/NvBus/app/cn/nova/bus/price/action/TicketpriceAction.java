package cn.nova.bus.price.action;

import cn.nova.bus.action.BaseAction;

import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Routeprice;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Scheduleplanlog;
import cn.nova.bus.price.model.Ticketoutletstypeprice;
import cn.nova.bus.price.model.Ticketpriceitem;
import cn.nova.bus.price.service.GenScheduleplanService;
import cn.nova.bus.price.service.HandpriceService;
import cn.nova.bus.price.service.RoutepriceService;
import cn.nova.bus.price.service.impl.GenScheduleplanServiceImpl;
import cn.nova.bus.price.service.impl.HandpriceServiceImpl;
import cn.nova.bus.price.service.impl.RoutepriceServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class TicketpriceAction extends BaseAction{
	private long ticketpriceid;
	private String tickettype;
	private Scheduleplanlog scheduleplanlog;
	private Scheduleplan scheduleplan;
	private List<Map<String, Object>> scheduleplanloglist;
	private List<Map<String, Object>> scheduleplanlist;
	private List<Map<String, Object>> ticketpricelist;
	private List<Map<String, Object>> ticketpriceitemlist;
	private List<Ticketpriceitem> tpitemlist;
	private List<Map<String, Object>> scheduleseatlist;
	private List<Map<String, Object>> helpmap;
	private long routeid;

	private boolean iscopyothersch;

	private List<Map<String, Object>> itemlist;

	private GenScheduleplanService genScheduleplanService;
	private RoutepriceService routeprice;
	private Ticketoutletstypeprice ttp;
	private String ticketoutletsids;
	private String scheduleids;
	private String id;
	
	
	public String qryTicketoutletstypepriceForDel() {
		try {
			routeprice = new RoutepriceServiceImpl();
			helpmap = routeprice.qryTicketoutletstypeprice(ServletPropertyFilterUtil.buildFromHttpRequest());
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	
	public String deleteTicketoutletstypeprice() {
		try {
			routeprice = new RoutepriceServiceImpl();
			if(routeprice.deleteTicketoutletstypeprice(id)) {
				setMsg("删除成功!");
				markSuccess();
			}else {
				markFail();
				setMsg("删除失败!");
			}
		} catch (Exception e) {
			markFail();
			setMsg(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String saveTicketoutletstypeprice() {
		try {
			routeprice = new RoutepriceServiceImpl();
			MethodResult mr = routeprice.saveTicketoutletstypeprice(ttp,ticketoutletsids,scheduleids);
			if(mr.getResult()==1) {
				setMsg("保存成功!");
				markSuccess();
			}else {
				markFail();
				setMsg(mr.getResultMsg());
			}
		} catch (Exception e) {
			markFail();
			setMsg(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	
	public String qryTicketoutletstypeprice() {
		try {
			routeprice = new RoutepriceServiceImpl();
			setScheduleseatlist(routeprice.qryTicketoutletstypeprice(ServletPropertyFilterUtil.buildFromHttpRequest()));
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String genScheduleplan() {
		try {
			genScheduleplanService = new GenScheduleplanServiceImpl();
			setScheduleplanloglist(genScheduleplanService
					.generateScheduleplan(scheduleplanlog));
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qryScheduleplan() {
		try {
			genScheduleplanService = new GenScheduleplanServiceImpl();
			setScheduleplanlist(genScheduleplanService
					.qryScheduleplan(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qryTicketprice() {
		try {
			genScheduleplanService = new GenScheduleplanServiceImpl();
			setTicketpricelist(genScheduleplanService
					.qryTicketprice(scheduleplan));
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qryTicketpriceItem() {
		try {
			genScheduleplanService = new GenScheduleplanServiceImpl();
			itemlist=genScheduleplanService.qryTicketpriceitem(
					ticketpriceid, tickettype);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qryScheduleseat() {
		try {
			genScheduleplanService = new GenScheduleplanServiceImpl();
			setScheduleseatlist(genScheduleplanService
					.qryScheduleseats(scheduleplan));
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qrySameRouteSchedules() {
		try {
			genScheduleplanService = new GenScheduleplanServiceImpl();
			helpmap = genScheduleplanService.qrySchedules(routeid);
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/*
	 * 保存执行票价分项
	 */
	private Date fromdate;
	private Date enddate;

	public String saveTicketpriceitem() {
		Global global = CurrentUtil.getGlobal();
		try {
			markSuccess();
			if (global != null && global.getUserinfo().getId() > 0) {
				HandpriceService handpriceService = new HandpriceServiceImpl();
				itemlist = handpriceService.saveTicketpriceItem(tpitemlist,
						global.getUserinfo().getId(), iscopyothersch,fromdate,enddate);
			}
		} catch (ServiceException e) {
			setMsg(e.getMessage());
			markFailure();
		} catch (Exception e) {
			setMsg("系统异常！");
			markFail();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public Scheduleplanlog getScheduleplanlog() {
		return scheduleplanlog;
	}

	public void setScheduleplanlog(Scheduleplanlog scheduleplanlog) {
		this.scheduleplanlog = scheduleplanlog;
	}

	public List<Map<String, Object>> getScheduleplanloglist() {
		return scheduleplanloglist;
	}

	public void setScheduleplanloglist(
			List<Map<String, Object>> scheduleplanloglist) {
		this.scheduleplanloglist = scheduleplanloglist;
	}

	public Scheduleplan getScheduleplan() {
		return scheduleplan;
	}

	public void setScheduleplan(Scheduleplan scheduleplan) {
		this.scheduleplan = scheduleplan;
	}

	public List<Map<String, Object>> getScheduleplanlist() {
		return scheduleplanlist;
	}

	public void setScheduleplanlist(List<Map<String, Object>> scheduleplanlist) {
		this.scheduleplanlist = scheduleplanlist;
	}

	public List<Map<String, Object>> getTicketpricelist() {
		return ticketpricelist;
	}

	public void setTicketpricelist(List<Map<String, Object>> ticketpricelist) {
		this.ticketpricelist = ticketpricelist;
	}

	public long getTicketpriceid() {
		return ticketpriceid;
	}

	public void setTicketpriceid(long ticketpriceid) {
		this.ticketpriceid = ticketpriceid;
	}

	public String getTickettype() {
		return tickettype;
	}

	public void setTickettype(String tickettype) {
		this.tickettype = tickettype;
	}

	public List<Map<String, Object>> getTicketpriceitemlist() {
		return ticketpriceitemlist;
	}

	public void setTicketpriceitemlist(
			List<Map<String, Object>> ticketpriceitemlist) {
		this.ticketpriceitemlist = ticketpriceitemlist;
	}

	public List<Map<String, Object>> getScheduleseatlist() {
		return scheduleseatlist;
	}

	public void setScheduleseatlist(List<Map<String, Object>> scheduleseatlist) {
		this.scheduleseatlist = scheduleseatlist;
	}

	public List<Map<String, Object>> getHelpmap() {
		return helpmap;
	}

	public void setHelpmap(List<Map<String, Object>> helpmap) {
		this.helpmap = helpmap;
	}

	public long getRouteid() {
		return routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}

	public boolean isIscopyothersch() {
		return iscopyothersch;
	}

	public void setIscopyothersch(boolean iscopyothersch) {
		this.iscopyothersch = iscopyothersch;
	}

	public List<Map<String, Object>> getItemlist() {
		return itemlist;
	}

	public void setItemlist(List<Map<String, Object>> itemlist) {
		this.itemlist = itemlist;
	}
	public List<Ticketpriceitem> getTpitemlist() {
		return tpitemlist;
	}

	public void setTpitemlist(List<Ticketpriceitem> tpitemlist) {
		this.tpitemlist = tpitemlist;
	}

	public Date getFromdate() {
		return fromdate;
	}

	public void setFromdate(Date fromdate) {
		this.fromdate = fromdate;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public Ticketoutletstypeprice getTtp() {
		return ttp;
	}

	public void setTtp(Ticketoutletstypeprice ttp) {
		this.ttp = ttp;
	}


	public String getTicketoutletsids() {
		return ticketoutletsids;
	}


	public void setTicketoutletsids(String ticketoutletsids) {
		this.ticketoutletsids = ticketoutletsids;
	}


	public String getScheduleids() {
		return scheduleids;
	}


	public void setScheduleids(String scheduleids) {
		this.scheduleids = scheduleids;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	
	
}
