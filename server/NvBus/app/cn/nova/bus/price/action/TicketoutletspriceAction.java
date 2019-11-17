package cn.nova.bus.price.action;

import cn.nova.bus.action.BaseAction;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Ticketoutletsprice;
import cn.nova.bus.price.service.TicketoutletspriceService;
import cn.nova.bus.price.service.impl.TicketoutletspriceServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：售票点票价差额管理</b><br/>
 * <b>类名称：</b>TicketoutletspriceAction.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b>2013-11-01 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class TicketoutletspriceAction extends BaseAction {

	private TicketoutletspriceService ticketoutletspriceService;

	public HttpServletRequest httpServletRequest;

	private Long scheduleid;

	private Long ticketoutletsid;

	private Ticketoutletsprice ticketoutletsprice;

	private boolean iscopyvehicletype;

	private List<Map<String, Object>> scheduleslist;
	private List<Map<String, Object>> ticketoutletlist;

	private List<Map<String, Object>> ticketoutletpricelist;

	private List<Ticketoutletsprice> ticketoutletsprices;
	private String getDateTime;// 添加时设置日期
	private String saveorupdateflag;// 编辑界面查询时用，添加和修改查询不同
	private String station_price;
	private long routeid;
	private Date startdate;
	private Date enddate;
	private String ticketoutletsidstr;
	
	
	
	
	/**
	 * 删除
	 * @return
	 */
	public String delTicketoutletsRoutePrice() {
		try {
			ticketoutletspriceService = new TicketoutletspriceServiceImpl();
			ticketoutletspriceService.delTicketoutletsRoutePrice(routeid, startdate, enddate, ticketoutletsid);
			markSuccess();
			setMsg("删除成功!");
		} catch (Exception e) {
			markFail();
			setMsg("删除失败!" + e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	
	/**
	 * 保存
	 * @return
	 */
	public String saveTicketoutletsRoutePrice(){
		try {
			ticketoutletspriceService = new TicketoutletspriceServiceImpl();
			if(ticketoutletspriceService.saveTicketoutletsRoutePrice(routeid,startdate,enddate,station_price,ticketoutletsid,ticketoutletsidstr)){
				markSuccess();
				setMsg("保存成功!");
			}else{
				markFail();
				setMsg("保存失败!日期不可交叉!");
			}
		} catch (Exception e) {
			markFail();
			setMsg("保存失败!"+e.getMessage());
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 查询线路停靠点信息
	 * 
	 * @return
	 */
	public String queryRouteStopinfo() {
		try {
			ticketoutletspriceService = new TicketoutletspriceServiceImpl();
			setScheduleslist(
					ticketoutletspriceService.queryRouteStopinfo(ServletPropertyFilterUtil.buildFromHttpRequest(),startdate,enddate,ticketoutletsid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 查询线路的票价差额信息
	 * 
	 * @return
	 */
	public String queryTicketoutletsRoutePriceinfo() {
		try {
			ticketoutletspriceService = new TicketoutletspriceServiceImpl();
			setScheduleslist(ticketoutletspriceService
					.queryTicketoutletsRoutePriceinfo(ServletPropertyFilterUtil.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 线路售票点票价差额 查询线路信息
	 * 
	 * @return
	 */
	public String queryRouteinfo() {
		try {
			ticketoutletspriceService = new TicketoutletspriceServiceImpl();
			setScheduleslist(
					ticketoutletspriceService.queryRouteinfo(ServletPropertyFilterUtil.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String query() {
		try {
			ticketoutletspriceService = new TicketoutletspriceServiceImpl();
			setScheduleslist(ticketoutletspriceService.query(ServletPropertyFilterUtil.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String queryticketoutletsprice() {
		try {
			ticketoutletspriceService = new TicketoutletspriceServiceImpl();
			setTicketoutletlist(ticketoutletspriceService.qryTicketoutletsprice(scheduleid, ticketoutletsid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	// 编辑界面的票价查询
	public String queryEditticketoutletsprice() {
		try {
			ticketoutletspriceService = new TicketoutletspriceServiceImpl();
			setTicketoutletpricelist(
					ticketoutletspriceService.qryEdtTicketoutletPrice(ticketoutletsprice, saveorupdateflag));
			setMsg("查询成功！");
			markSuccess();
		} catch (ServiceException se) {
			setMsg(se.getMessage());
		} catch (Exception e) {
			setMsg("系统异常！");
			markError();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				ticketoutletspriceService = new TicketoutletspriceServiceImpl();
				setTicketoutletpricelist(ticketoutletspriceService.save(ticketoutletsprices, iscopyvehicletype,
						global.getUserinfo().getId(), ticketoutletsprice, getDateTime));
			}
			markSuccess();
		} catch (ServiceException e) {
			setMsg(e.getMessage());
			markFail();
		} catch (Exception e) {
			setMsg("系统异常！");
			markFail();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String delTicketoutletsprice() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				ticketoutletspriceService = new TicketoutletspriceServiceImpl();
				if (ticketoutletspriceService.delTicketoutletsprice(ServletPropertyFilterUtil.buildFromHttpRequest())) {
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

	public List<Map<String, Object>> getScheduleslist() {
		return scheduleslist;
	}

	public void setScheduleslist(List<Map<String, Object>> scheduleslist) {
		this.scheduleslist = scheduleslist;
	}

	public Long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(Long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public Long getTicketoutletsid() {
		return ticketoutletsid;
	}

	public void setTicketoutletsid(Long ticketoutletsid) {
		this.ticketoutletsid = ticketoutletsid;
	}

	public List<Map<String, Object>> getTicketoutletlist() {
		return ticketoutletlist;
	}

	public void setTicketoutletlist(List<Map<String, Object>> ticketoutletlist) {
		this.ticketoutletlist = ticketoutletlist;
	}

	public Ticketoutletsprice getTicketoutletsprice() {
		return ticketoutletsprice;
	}

	public void setTicketoutletsprice(Ticketoutletsprice ticketoutletsprice) {
		this.ticketoutletsprice = ticketoutletsprice;
	}

	public boolean isIscopyvehicletype() {
		return iscopyvehicletype;
	}

	public void setIscopyvehicletype(boolean iscopyvehicletype) {
		this.iscopyvehicletype = iscopyvehicletype;
	}

	public List<Map<String, Object>> getTicketoutletpricelist() {
		return ticketoutletpricelist;
	}

	public void setTicketoutletpricelist(List<Map<String, Object>> ticketoutletpricelist) {
		this.ticketoutletpricelist = ticketoutletpricelist;
	}

	public List<Ticketoutletsprice> getTicketoutletsprices() {
		return ticketoutletsprices;
	}

	public void setTicketoutletsprices(List<Ticketoutletsprice> ticketoutletsprices) {
		this.ticketoutletsprices = ticketoutletsprices;
	}

	public String getGetDateTime() {
		return getDateTime;
	}

	public void setGetDateTime(String getDateTime) {
		this.getDateTime = getDateTime;
	}

	public String getSaveorupdateflag() {
		return saveorupdateflag;
	}

	public void setSaveorupdateflag(String saveorupdateflag) {
		this.saveorupdateflag = saveorupdateflag;
	}

	public String getStation_price() {
		return station_price;
	}

	public void setStation_price(String station_price) {
		this.station_price = station_price;
	}

	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public long getRouteid() {
		return routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}


	public String getTicketoutletsidstr() {
		return ticketoutletsidstr;
	}


	public void setTicketoutletsidstr(String ticketoutletsidstr) {
		this.ticketoutletsidstr = ticketoutletsidstr;
	}


}
