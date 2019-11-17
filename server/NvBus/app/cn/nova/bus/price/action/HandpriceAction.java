package cn.nova.bus.price.action;

import cn.nova.bus.action.BaseAction;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Handprice;
import cn.nova.bus.price.model.Handpriceitem;
import cn.nova.bus.price.service.HandpriceService;
import cn.nova.bus.price.service.impl.HandpriceServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.jpa.ListUtil;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class HandpriceAction extends BaseAction{
	private Long vehiclebrandmodelid;
	private String seattype;
	private String seatnos;

	private Handprice handprice;
	private List<Map<String, Object>> schedulelist;
	private List<Map<String, Object>> handpricelist;
	private List<Handprice> handprices;
	private long routeid;
	private List<Map<String, Object>> vehiclettypelist;
	private List<Map<String, Object>> schedulestoplist;
	private boolean iscopyvehicletype;

	private List<Handpriceitem> hpilist;
	private Long scheduleid;

	private boolean iscopyothersch;
    private String adjusttype;
    private String departstationids;
	private boolean isdepart;
	private String vehicletypeids;
	private String stationids;
	private String scheduleids;
	private String tickettype;
	private long handpriceid;
	private long reachstationid;
	
	private List<Map<String, Object>> itemlist;

	private HandpriceService handpriceService;

	// 查询循环车型
	public String qryScheduleVehicletype() {
	Global global = CurrentUtil.getGlobal();
		try {
			handpriceService = new HandpriceServiceImpl();
			setVehiclettypelist(handpriceService
					.qryScheduleVehicletype(scheduleid,global));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 查询运行车型
	public String qryhandpricevehicletype() {
		try {
			handpriceService = new HandpriceServiceImpl();
			vehiclettypelist = handpriceService
					.qrySchedulevehicletype(scheduleid);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 查询班次停靠点
	public String qryScheduleDepartStop() {
		try {
			handpriceService = new HandpriceServiceImpl();
			setSchedulestoplist(handpriceService.qryScheduleStop(scheduleid,
					true));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 查询硬调票价停靠点
	public String qryHandpricestation() {
		try {
			handpriceService = new HandpriceServiceImpl();
			handpriceService = new HandpriceServiceImpl();
			schedulestoplist = handpriceService.qrySchedulestation(scheduleid);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 查询同线路的所有班次
	public String qrySchedules() {
		try {
			handpriceService = new HandpriceServiceImpl();
			schedulelist = handpriceService.qrySchedules(routeid, scheduleid);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qryScheduleStop() {
		try {
			handpriceService = new HandpriceServiceImpl();
			setSchedulestoplist(handpriceService.qryScheduleStop(scheduleid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 编辑界面的票价查询
	public String queryedithandprice() {
		try {
			handpriceService = new HandpriceServiceImpl();
			setHandpricelist(handpriceService.qryHandPrice(handprice));
			setMsg("查询成功！");
			markSuccess();
		} catch (ServiceException se) {
			setMsg(se.getMessage());
			markFail();
			handpricelist = ListUtil.listToMap(new Object[] { "id",
					"scheduleid", "departstationid", "reachstationid",
					"vehicletypeid", "vehiclebrandmodelid", "brandname",
					"seattype", "fullprice", "halfprice", "studentprice",
					"toplimitprice", "lowerlimitprice", "createby",
					"vehicletype", "departstation", "reachstation","moreprice", "distance" }, null,
					new Object[] { Long.class, Long.class, Long.class,
							Long.class, Long.class, Long.class, String.class,
							String.class, BigDecimal.class, BigDecimal.class,
							BigDecimal.class, BigDecimal.class,
							BigDecimal.class, Long.class, String.class,
							String.class, String.class,BigDecimal.class,
							Integer.class });
		} catch (Exception e) {
			setMsg("系统异常！");
			markError();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	//班次加班 查询 硬调票价 信息
	public String queryhandprice() {
		try {
			handpriceService = new HandpriceServiceImpl();
			setHandpricelist(handpriceService.qryHandPrice(scheduleid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qryScheduleSeatno() {
		handpriceService = new HandpriceServiceImpl();
		seatnos = handpriceService.qryScheduleSeats(vehiclebrandmodelid,
				seattype);
		return "json";
	}

	public String save() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				handpriceService = new HandpriceServiceImpl();
				setHandpricelist(handpriceService.save(handprices,
						iscopyvehicletype, global.getUserinfo().getId(), handprice));
			}
			markSuccess();
		} catch (ServiceException e) {
			setMsg(e.getMessage());
			markFail();
//			System.out.println(e.getMessage());
		} catch (Exception e) {
			setMsg("系统异常！");
			markFail();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String delhandprice() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				handpriceService = new HandpriceServiceImpl();
				if (handpriceService.delHandPrice(ServletPropertyFilterUtil
						.buildFromHttpRequest())) {
					setMsg("删除成功！");
					markSuccess();
				} else {
					setMsg("删除失败！");
					markFail();
				}
			}
		} catch (Exception e) {
			setMsg("删除失败！");
			markFail();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 复制票价
	public String copyhandprice() {
		setMsg("复制成功！");
		markSuccess();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				handpriceService = new HandpriceServiceImpl();
				handpriceService.copyHandprice(scheduleid, vehicletypeids,
						stationids, scheduleids, global.getUserinfo().getId());
			}
		} catch (ServiceException e) {
			setMsg(e.getMessage());
			markFail();
		} catch (Exception e) {
			markFail();
			setMsg(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String qryHandpriceItem() {
		try {
			handpriceService = new HandpriceServiceImpl();
			setItemlist(handpriceService.qryHandpriceitem(handpriceid,
					tickettype));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String saveHandpriceitem() {
		Global global = CurrentUtil.getGlobal();
		try {
			markSuccess();
			if (global != null && global.getUserinfo().getId() > 0) {
				handpriceService = new HandpriceServiceImpl();
				itemlist = handpriceService.saveHandpriceitem(hpilist, global
						.getUserinfo().getId(), iscopyothersch);
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

	// 复制票价
	public String copyHandpricetoStatioin() {
		setMsg("复制成功！");
		markSuccess();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				handpriceService = new HandpriceServiceImpl();
				handpriceService.copyHandpricetoStatioin(scheduleid, global
						.getUserinfo().getId());
			}
		} catch (ServiceException e) {
			setMsg(e.getMessage());
			markFail();
		} catch (Exception e) {
			markFail();
			setMsg(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 综合调度-站点票价
	public String saveStationPrice() {
		setMsg("保存成功！");
		markSuccess();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				handpriceService = new HandpriceServiceImpl();
				handpriceService.saveStationPrice(adjusttype, departstationids,
						scheduleids, handprice);
			}
		} catch (ServiceException e) {
			setMsg(e.getMessage());
			markFail();
		} catch (Exception e) {
			markFail();
			setMsg(e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	//综合调度-站点票价 查询相同站点班次票价信息
	public String qrySameStations() {
		try {
			handpriceService = new HandpriceServiceImpl();
			schedulelist=handpriceService.qrySameStations(departstationids,
					reachstationid);
		} catch (ServiceException e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public Handprice getHandprice() {
		return handprice;
	}

	public void setHandprice(Handprice handprice) {
		this.handprice = handprice;
	}

	public List<Map<String, Object>> getHandpricelist() {
		return handpricelist;
	}

	public void setHandpricelist(List<Map<String, Object>> handpricelist) {
		this.handpricelist = handpricelist;
	}

	public List<Map<String, Object>> getVehiclettypelist() {
		return vehiclettypelist;
	}

	public void setVehiclettypelist(List<Map<String, Object>> vehiclettypelist) {
		this.vehiclettypelist = vehiclettypelist;
	}

	public List<Map<String, Object>> getSchedulestoplist() {
		return schedulestoplist;
	}

	public void setSchedulestoplist(List<Map<String, Object>> schedulestoplist) {
		this.schedulestoplist = schedulestoplist;
	}

	public Long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(Long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public boolean getIsdepart() {
		return isdepart;
	}

	public void setIsdepart(boolean isdepart) {
		this.isdepart = isdepart;
	}

	public String getSeatnos() {
		return seatnos;
	}

	public void setSeatnos(String seatnos) {
		this.seatnos = seatnos;
	}

	public Long getVehiclebrandmodelid() {
		return vehiclebrandmodelid;
	}

	public void setVehiclebrandmodelid(Long vehiclebrandmodelid) {
		this.vehiclebrandmodelid = vehiclebrandmodelid;
	}

	public String getSeattype() {
		return seattype;
	}

	public void setSeattype(String seattype) {
		this.seattype = seattype;
	}

	public List<Handprice> getHandprices() {
		return handprices;
	}

	public void setHandprices(List<Handprice> handprices) {
		this.handprices = handprices;
	}

	public List<Map<String, Object>> getSchedulelist() {
		return schedulelist;
	}

	public void setSchedulelist(List<Map<String, Object>> schedulelist) {
		this.schedulelist = schedulelist;
	}

	public long getRouteid() {
		return routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}

	public String getVehicletypeids() {
		return vehicletypeids;
	}

	public void setVehicletypeids(String vehicletypeids) {
		this.vehicletypeids = vehicletypeids;
	}

	public String getStationids() {
		return stationids;
	}

	public void setStationids(String stationids) {
		this.stationids = stationids;
	}

	public String getScheduleids() {
		return scheduleids;
	}

	public void setScheduleids(String scheduleids) {
		this.scheduleids = scheduleids;
	}

	public long getHandpriceid() {
		return handpriceid;
	}

	public void setHandpriceid(long handpriceid) {
		this.handpriceid = handpriceid;
	}

	public List<Map<String, Object>> getItemlist() {
		return itemlist;
	}

	public void setItemlist(List<Map<String, Object>> itemlist) {
		this.itemlist = itemlist;
	}

	public String getTickettype() {
		return tickettype;
	}

	public void setTickettype(String tickettype) {
		this.tickettype = tickettype;
	}

	public boolean isIscopyvehicletype() {
		return iscopyvehicletype;
	}

	public void setIscopyvehicletype(boolean iscopyvehicletype) {
		this.iscopyvehicletype = iscopyvehicletype;
	}

	public List<Handpriceitem> getHpilist() {
		return hpilist;
	}

	public void setHpilist(List<Handpriceitem> hpilist) {
		this.hpilist = hpilist;
	}

	public boolean isIscopyothersch() {
		return iscopyothersch;
	}

	public void setIscopyothersch(boolean iscopyothersch) {
		this.iscopyothersch = iscopyothersch;
	}
	public String getAdjusttype() {
		return adjusttype;
	}

	public void setAdjusttype(String adjusttype) {
		this.adjusttype = adjusttype;
	}

	public String getDepartstationids() {
		return departstationids;
	}

	public void setDepartstationids(String departstationids) {
		this.departstationids = departstationids;
	}
	public long getReachstationid() {
		return reachstationid;
	}

	public void setReachstationid(long reachstationid) {
		this.reachstationid = reachstationid;
	}

}
