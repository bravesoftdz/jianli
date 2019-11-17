package cn.nova.bus.price.action;

import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.action.BaseAction;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.ScheduleDiscountPrice;
import cn.nova.bus.price.service.ScheduleDiscountPriceService;
import cn.nova.bus.price.service.impl.HandHolidaypriceServiceImpl;
import cn.nova.bus.price.service.impl.ScheduleDiscountPriceServiceImpl;
import cn.nova.bus.security.Global;

public class ScheduleDiscountPriceAction extends BaseAction {
	private String msg;// 返回结果提示
	private Long flag;// 返回结果标识
	private Long scheduleid;
	private Long routeid;
	private Long id;
	private ScheduleDiscountPrice schedulediscountprice;
	private List<ScheduleDiscountPrice> schedulediscountprices;
	private ScheduleDiscountPriceService scheduleDiscountPriceService;
	private List<Map<String, Object>> schedulediscountpricelist;
	private List<Map<String, Object>> stationlist;
	private boolean savesameroute;
	private Date enddate;
	private Date startdate;
	private int salenum;
	
	
	public int getSalenum() {
		return salenum;
	}

	public void setSalenum(int salenum) {
		this.salenum = salenum;
	}

	public List<Map<String, Object>> getStationlist() {
		return stationlist;
	}

	public void setStationlist(List<Map<String, Object>> stationlist) {
		this.stationlist = stationlist;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public boolean isSavesameroute() {
		return savesameroute;
	}

	public void setSavesameroute(boolean savesameroute) {
		this.savesameroute = savesameroute;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Long getFlag() {
		return flag;
	}

	public void setFlag(Long flag) {
		this.flag = flag;
	}

	public Long getRouteid() {
		return routeid;
	}

	public void setRouteid(Long routeid) {
		this.routeid = routeid;
	}

	public Long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(Long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public ScheduleDiscountPrice getSchedulediscountprice() {
		return schedulediscountprice;
	}

	public void setSchedulediscountprice(ScheduleDiscountPrice schedulediscountprice) {
		this.schedulediscountprice = schedulediscountprice;
	}

	public List<ScheduleDiscountPrice> getSchedulediscountprices() {
		return schedulediscountprices;
	}

	public void setSchedulediscountprices(
			List<ScheduleDiscountPrice> schedulediscountprices) {
		this.schedulediscountprices = schedulediscountprices;
	}

	public ScheduleDiscountPriceService getScheduleDiscountPriceService() {
		return scheduleDiscountPriceService;
	}

	public void setScheduleDiscountPriceService(
			ScheduleDiscountPriceService scheduleDiscountPriceService) {
		this.scheduleDiscountPriceService = scheduleDiscountPriceService;
	}

	public List<Map<String, Object>> getSchedulediscountpricelist() {
		return schedulediscountpricelist;
	}

	public void setSchedulediscountpricelist(
			List<Map<String, Object>> schedulediscountpricelist) {
		this.schedulediscountpricelist = schedulediscountpricelist;
	}

	public String qrySchDiscountPrice() {
		try {
			scheduleDiscountPriceService = new ScheduleDiscountPriceServiceImpl();
			schedulediscountpricelist = scheduleDiscountPriceService
					.qryScheduleDiscountPrice(scheduleid);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String qryScheduleDiscountPrice() {
		try {
			scheduleDiscountPriceService = new ScheduleDiscountPriceServiceImpl();
			schedulediscountpricelist = scheduleDiscountPriceService
					.qryScheduleDiscountPrice(routeid,scheduleid);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String qryStation() {
		try {
			scheduleDiscountPriceService = new ScheduleDiscountPriceServiceImpl();
			stationlist = scheduleDiscountPriceService
					.qryStation(scheduleid);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String save() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				scheduleDiscountPriceService = new ScheduleDiscountPriceServiceImpl();
				schedulediscountpricelist=scheduleDiscountPriceService.save(schedulediscountprices,
						global.getUserinfo().getId(),scheduleid,startdate,enddate,salenum,savesameroute);
				setMsg("保存成功！");
				markSuccess();
			}
		} catch (ServiceException e) {
			setMsg(e.getMessage());
//			setFlag(new Long(-1));
			markFail();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("保存失败！");
//			setFlag(new Long(-1));
			markFail();
		}
		return "json";
	}
	
	public String delSchDisCountPrice(){
		try {
			scheduleDiscountPriceService = new ScheduleDiscountPriceServiceImpl();
			scheduleDiscountPriceService
					.delScheduleDiscountPrice(scheduleid);
			setMsg("删除成功！");
//			setFlag(new Long(1));
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("删除失败！");
			markFail();
//			setFlag(new Long(-1));
		}
		return "json";
	}
	
	public String addScheduleDiscountPrice(){
		Global global = CurrentUtil.getGlobal();
		scheduleDiscountPriceService = new ScheduleDiscountPriceServiceImpl();
		try {
			setId(scheduleDiscountPriceService.addScheduleDiscountPrice(schedulediscountprice, global));
			markSuccess();
		} catch (ServiceException e) {
			markFail();
			setMsg(e.getMessage());
		}
		return "json";
	}
	
	

}
