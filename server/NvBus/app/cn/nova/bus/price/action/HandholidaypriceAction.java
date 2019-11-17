package cn.nova.bus.price.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Handholidayprice;
import cn.nova.bus.price.model.Handholidaypriceitem;
import cn.nova.bus.price.model.Holiday;
import cn.nova.bus.price.service.HandHolidaypriceService;
import cn.nova.bus.price.service.impl.HandHolidaypriceServiceImpl;
import cn.nova.bus.security.Global;

public class HandholidaypriceAction extends BaseAction{
	private Long scheduleid;
	private String vehicletypeids;
	private Holiday holiday;
	private Handholidayprice handholidayprice;
	private List<Handholidayprice> handholidayprices;
	private List<Map<String, Object>> vehiclettypelist;
	private List<Map<String, Object>> handholidaypricelist;
	private String tickettype;
	private boolean savesameroute;
	private long handholidaypriceid;
	private List<Map<String, Object>> itemlist;	
	private List<Handholidaypriceitem> hpilist;
	private boolean iscopyothersch;

	private HandHolidaypriceService handHolidaypriceService;

	public String qryholidayVehicletype() {
		try {
			handHolidaypriceService = new HandHolidaypriceServiceImpl();
			setVehiclettypelist(handHolidaypriceService
					.qryScheduleVehicletype(scheduleid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qryedthandholidayprice() {
		try {
			handHolidaypriceService = new HandHolidaypriceServiceImpl();
			setHandholidaypricelist(handHolidaypriceService
					.qryHandHolidayPrice(holiday,scheduleid,vehicletypeids));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String qryhandholidayprice() {
		try {
			handHolidaypriceService = new HandHolidaypriceServiceImpl();
			setHandholidaypricelist(handHolidaypriceService
					.qryHandHolidayPrice(handholidayprice));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String save() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				handHolidaypriceService = new HandHolidaypriceServiceImpl();
				setHandholidaypricelist(handHolidaypriceService.save(handholidayprices,holiday,
						global.getUserinfo().getId(),savesameroute));
				setMsg("保存成功！");
				markSuccess();
			}
		} catch (ServiceException e) {
			setMsg(e.getMessage());
			markFail();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("保存失败！");
			markFail();
		}
		return "json";
	}
	public String delhandholidayprice() {
		try {
			handHolidaypriceService = new HandHolidaypriceServiceImpl();
			if (handHolidaypriceService.delHandHolidayPrice(handholidayprice)){
				setMsg("删除成功！");
				markSuccess();
			}else
			{
				setMsg("删除失败！");
				markFail();
			}
		} catch (Exception e) {
			setMsg("删除失败！");
			markFail();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String qryHandholidaypriceitem() {
		try {
			handHolidaypriceService = new HandHolidaypriceServiceImpl();
			setItemlist(handHolidaypriceService
					.qryHandholidaypriceitem(handholidaypriceid,tickettype));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String saveHandholidaypriceitem() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				handHolidaypriceService = new HandHolidaypriceServiceImpl();
				itemlist=handHolidaypriceService.saveHandholidaypriceitem(hpilist, global
						.getUserinfo().getId(),iscopyothersch);
			}
		} catch (ServiceException e) {
			System.out.println(e.getMessage());
		} catch (Exception e) {
			setMsg("系统异常！");
			markFail();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public Long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(Long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public Handholidayprice getHandholidayprice() {
		return handholidayprice;
	}

	public void setHandholidayprice(Handholidayprice handholidayprice) {
		this.handholidayprice = handholidayprice;
	}

	public List<Map<String, Object>> getVehiclettypelist() {
		return vehiclettypelist;
	}

	public void setVehiclettypelist(List<Map<String, Object>> vehiclettypelist) {
		this.vehiclettypelist = vehiclettypelist;
	}

	public List<Map<String, Object>> getHandholidaypricelist() {
		return handholidaypricelist;
	}

	public void setHandholidaypricelist(
			List<Map<String, Object>> handholidaypricelist) {
		this.handholidaypricelist = handholidaypricelist;
	}
	public String getVehicletypeids() {
		return vehicletypeids;
	}

	public void setVehicletypeids(String vehicletypeids) {
		this.vehicletypeids = vehicletypeids;
	}

	public Holiday getHoliday() {
		return holiday;
	}

	public void setHoliday(Holiday holiday) {
		this.holiday = holiday;
	}
	
	@Transient
	public List<Handholidayprice> getHandholidayprices() {
		return handholidayprices;
	}

	public void setHandholidayprices(List<Handholidayprice> handholidayprices) {
		this.handholidayprices = handholidayprices;
	}
	
	public String getTickettype() {
		return tickettype;
	}

	public void setTickettype(String tickettype) {
		this.tickettype = tickettype;
	}

	public long getHandholidaypriceid() {
		return handholidaypriceid;
	}

	public void setHandholidaypriceid(long handholidaypriceid) {
		this.handholidaypriceid = handholidaypriceid;
	}

	public List<Map<String, Object>> getItemlist() {
		return itemlist;
	}

	public void setItemlist(List<Map<String, Object>> itemlist) {
		this.itemlist = itemlist;
	}
	public boolean isSavesameroute() {
		return savesameroute;
	}

	public void setSavesameroute(boolean savesameroute) {
		this.savesameroute = savesameroute;
	}
	public List<Handholidaypriceitem> getHpilist() {
		return hpilist;
	}

	public void setHpilist(List<Handholidaypriceitem> hpilist) {
		this.hpilist = hpilist;
	}

	public boolean isIscopyothersch() {
		return iscopyothersch;
	}

	public void setIscopyothersch(boolean iscopyothersch) {
		this.iscopyothersch = iscopyothersch;
	}
	
}
